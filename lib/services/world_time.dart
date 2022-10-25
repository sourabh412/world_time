import 'package:intl/intl.dart';
import 'package:http/http.dart';
import 'dart:convert';

class WorldTime {

  String location, flag, url_loc;
  late String time;
  bool isDaytime = true;

  WorldTime(this.url_loc, this.location, this.flag);

  Future<void> getTime() async {

    try{

      var url = Uri.https("worldtimeapi.org","/api/timezone/$url_loc");
      Response response = await get(url);
      Map data = jsonDecode(response.body);
      // print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      // print(datetime);
      // print(offset);

      //create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset.substring(1,3)),minutes: int.parse(offset.substring(4,6))));
      isDaytime = (now.hour > 6 && now.hour < 20) ? true : false ;
      time = DateFormat.jm().format(now);

    } catch(e){

      time = "some error occurred";
    }

  }

}
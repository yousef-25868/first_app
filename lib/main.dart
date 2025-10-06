import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(SebhaApp());
}

class SebhaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سبحة إلكترونية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Arial',
      ),
      home: SebhaScreen(),
    );
  }
}

class SebhaScreen extends StatefulWidget {
  @override
  _SebhaScreenState createState() => _SebhaScreenState();
}

class _SebhaScreenState extends State<SebhaScreen> {
  int subhanAllahCount = 0;
  int alhamdulillahCount = 0;
  int allahuAkbarCount = 0;
  bool showResetMessage = false;

  void incrementCounter(String type) {
    setState(() {
      switch (type) {
        case 'سبحان الله':
          if (subhanAllahCount < 33) subhanAllahCount++;
          break;
        case 'الحمد لله':
          if (alhamdulillahCount < 33) alhamdulillahCount++;
          break;
        case 'الله أكبر':
          if (allahuAkbarCount < 33) allahuAkbarCount++;
          break;
      }
    });
  }

  void resetCounters() {
    setState(() {
      subhanAllahCount = 0;
      alhamdulillahCount = 0;
      allahuAkbarCount = 0;
      showResetMessage = true;
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        showResetMessage = false;
      });
    });
  }

  Widget buildTasbeehCard(String title, int count) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 10),
            Text(
              '$count / 33',
              style: TextStyle(fontSize: 22, color: Colors.black87),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => incrementCounter(title),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.teal,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سبحة إلكترونية', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          ListView(
            padding: EdgeInsets.symmetric(vertical: 20),
            children: [
              buildTasbeehCard('سبحان الله', subhanAllahCount),
              buildTasbeehCard('الحمد لله', alhamdulillahCount),
              buildTasbeehCard('الله أكبر', allahuAkbarCount),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  onPressed: resetCounters,
                  icon: Icon(Icons.refresh),
                  label: Text('تصفير العدادات', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
          if (showResetMessage)
            Positioned(
              bottom: 40,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'تم تصفير العدادات',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

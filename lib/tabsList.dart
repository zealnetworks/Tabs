import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';

class TabsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuerySnapshot>(
      builder: (context, tabsData, child) {
        if (tabsData != null)
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            padding: EdgeInsets.all(8.0),
            itemCount: tabsData.documents.length,
            itemBuilder: (context, index) {
              return TabCard(
                tab: tabsData.documents[index],
              );
            },
          );
        else
          return Text("No open tabs");
      },
    );
  }
}

class TabCard extends StatelessWidget {
  final DocumentSnapshot tab;
  TabCard({@required this.tab});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              this.tab["name"],
              style: Theme.of(context).textTheme.subhead,
            ),
            Text(
              FlutterMoneyFormatter(amount: this.tab["amount"])
                  .output
                  .symbolOnLeft,
              style: Theme.of(context)
                  .textTheme
                  .headline
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            if (this.tab["description"] != null)
              Chip(
                backgroundColor: Color(int.parse(this.tab["descriptionColor"])),
                label: Text(
                  this.tab["description"],
                ),
              ),
            // ButtonTheme.bar(
            //   child: ButtonBar(
            //     children: <Widget>[
            //       FlatButton(
            //         child: Text('PAID'),
            //         onPressed: () async {
            //           try {
            //             await Firestore.instance
            //                 .collection("tabs")
            //                 .document(this.tab.documentID)
            //                 .delete();
            //           } catch (e) {}
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

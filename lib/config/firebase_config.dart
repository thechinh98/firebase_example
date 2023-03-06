import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

const firebaseRemoteConfigAdKey = "showAdBanner";
const firebaseRemoteConfigTextKey = "Text";

void firebaseConfig() {
  firebaseCrashlyticConfig();
  firebaseRemoteConfig();
}

void firebaseCrashlyticConfig() {
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

void firebaseRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 3),
    minimumFetchInterval: const Duration(hours: 1),
  ));
  await remoteConfig.fetchAndActivate();
  print(remoteConfig.getBool(firebaseRemoteConfigAdKey));
  print(remoteConfig.getString(firebaseRemoteConfigTextKey));
}

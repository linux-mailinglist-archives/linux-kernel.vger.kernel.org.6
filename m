Return-Path: <linux-kernel+bounces-438614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77249EA387
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F43616543C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB5B70816;
	Tue, 10 Dec 2024 00:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XyCiVBjv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF532B9BC;
	Tue, 10 Dec 2024 00:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789839; cv=none; b=nb2nIT6UsznTHBX6vjD5J5/q2AujXXuoDkN84dNi1dKGEVYix7xThy14tmYogLFCEC8X3itCxXZyKjhDjZWVie+d+wEkXB1smsy/JPXGXJ4K66fhXSJEhKp23EyLeN59SvlwIeVa2w4lF2ELBa1dXSR6QoNBSaJf6fwCPF8R6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789839; c=relaxed/simple;
	bh=r34yAgF017ih7tX/p3FGTkzlRWDgi+IjA6+NdmVcPUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifGFB/++JjDkeQ0ePQmLhxGVHfjHNUI7i0rsWl/obmoBU6d96Zx9Ld5PVGn5RXrpuQJWQKJ3n4mjcNSanWkSsYlMO10LIgA1/fo/ULG9qamvQJP6gQk1WvN1/yRiAyD9T8N3As9fZawWuTQUkfLus9oQNN7HP9+U6asB+DrCwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XyCiVBjv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733789830; x=1734394630; i=w_armin@gmx.de;
	bh=WdbwHUb6mfi2wigqcDZ1jvoMmwZIaUUy0vonFZSHUtU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XyCiVBjvJQqH5XUBQbA5NWlYFyi+YTGO4PirhGYT5V3hh14pimcbEWkcBN5SWi/d
	 RxKq01qELfTdBPFr6iBk3Ig11FWO8q4bbXEAEeEoIb+1jjMK1VJvahKaC5X7CTdu/
	 ubITH7tlElHpSlk83BcbkgUSJfY5GGsn9sr3moDm+brgEXd4Vc+ct/r2xn1UBRzxQ
	 xbqO3CsUeJ7wI5Asp2EEHrdAqzYDwANXU9WWTKLEuqxGEX7IXiUoYzh3I9kwC8xES
	 XHcXKzpAJue7dKyOzX/1BIKEpSLfF4tModAFvX27M3CQar2AmEuOC5ltwCs18g/Gg
	 8nZoTQQs1gSn7Dhwdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.14.230.110]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MEm6F-1tQcqE3bVz-005j78; Tue, 10 Dec 2024 01:17:10 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuurtb@gmail.com
Subject: [PATCH v4 4/5] platform/x86: acer-wmi: Implement proper hwmon support
Date: Tue, 10 Dec 2024 01:16:56 +0100
Message-Id: <20241210001657.3362-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210001657.3362-1-W_Armin@gmx.de>
References: <20241210001657.3362-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MuCak7G+WIcPOqA/yi+NaU98YghsrzkDud2jg2B+j/25C9PK63x
 WpnLdojNZoLyLMiCIIxOOuYv+K5ctyvADDLOasteYzyaRmDA5/Rq3AFXmflpDoV0ay9gY1s
 pfDD2Yvx651JtfM6gjs//a6HeLwfT0YPHXPSSpY2KLCNq8x85oHMNZ7pQCuxBPhlb//0pgl
 aD2rK+09SLWv0STxCVthg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8O4kST7heOk=;T/kr6LDhRUC5CR6Z5X4qyDclFrF
 zC8bifg8vV0x7HemKtXF4DWSOUbA1N3l5PgA4cKJlQeAvpvThmErdQ/D+JIaTn9BZ8aEfxv2B
 9i4KNErnSUj/RssK9SykSDkeK2JLvMSWAtoYs6bhzogb5RoCVp0q+9a3N1nt8oszbxIacammA
 heuMxbwfiPoeAxkAAPW2BJ2X25c10E1DlR+WaSmnNnfDCjPtma/31cXr3B0pisHYay/CWW4vA
 rs9ky2BVOsIJHS/6bn0W3ItQCdkx7OivmBviludu8KitlRhvjVt+h9SjhV8d3n1uJDXAbyh0d
 1juPOMFgyyTt5xbzdpLeWE0fWYuKW2V8CfFpKTbzSzxqES7oFdKpZgFob72OMd7OKKKXjImN6
 wpzjvaOJ3SCFJ2a/w6Pb0kYQ1lycR+zMc2dyaDK4VyZw933oCIXkqgVC7cEbfRRhNSwlOKs5h
 vECo7b7P8fIoiYC+FxRnzinVbjgHfqnAnNgEGUhvmoiD6bddnc3WRhkVtoBqNyWJZcfrP1Tsa
 jrtvREIsBgJRrqeJTWX13u8MeZM3o4khLhQAqacbIOhs9uoJyGUqBMEOc5mmwlnoWhEdm6pIW
 xTDFPzNNmn5ELeJraudMIP/HenVSQElLagu4JFM2Mt/tx7wl6h3EbNIabBmdF1DRT6aND1usV
 jq4oM3q9NsWykWyc7e4fUEUeGkPjHhW5YQzJmCTQey/SxjTtG2bZC9WV6njdg5ZpHfTqhV1o/
 iRE9xBnXK11pFEat4jgH5oTSfz9G/7681MhJeMKY4XFvuZvkO5tPWGjdw2oBM3yu3/a+zpXB/
 Js8r+Qa3xwxJv4urBTecCH8YJ2xDYWMkCNMX7HtTOi7+Oi0YAGxS2xwnNawpzLxDJlU263map
 nF4kJ4Kc5znHKb0uwIoMj3joYI9K6RnAGbltZGfcgnM3XVQ03NyVgGYCDy6+0xWc7W/XHvMIx
 hKdCyl20EgnYiEzsOX3Er5XK5L6EtI3F0yYYycSs517qTeIe5ZWZIwTVNfCOHMrenZxc+AeVR
 TTbXaeC+KojQD5Ei5GDEFadiWVhIuA93VYdjvnb//ZR+XV79hCWgKJREgrTB2uAKS+4cuUnTd
 fdb3Bwv86On2cuZJv51oIMfpiN5+jf

After looking at the ACPI AML code, it seems that the command 0x0000
used with ACER_WMID_GET_GAMING_SYS_INFO_METHODID returns a bitmap of
all supported sensor indices available through the 0x0001 command.

Those sensor indices seem to include both temperature and fan speed
sensors, with only the fan speed sensors being currently supported.

Use the output of this new command to implement reliable sensor
detection. This fixes detection of fans which do not spin during
probe, as fans are currently being ignored if their speed is 0.

Also add support for the new temperature sensor ids.

Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 113 ++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index ac4500f33b8c..aad8eb0ddae5 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -30,6 +30,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <acpi/video.h>
 #include <linux/hwmon.h>
+#include <linux/units.h>
 #include <linux/bitfield.h>

 MODULE_AUTHOR("Carlos Corbacho");
@@ -71,7 +72,9 @@ MODULE_LICENSE("GPL");
 #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54

 #define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)
-#define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
+#define ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK GENMASK_ULL(15, 8)
+#define ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK GENMASK_ULL(23, 8)
+#define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK_ULL(39, 24)

 /*
  * Acer ACPI method GUIDs
@@ -99,9 +102,17 @@ enum acer_wmi_event_ids {
 };

 enum acer_wmi_predator_v4_sys_info_command {
-	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS =3D 0x02,
-	ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED =3D 0x0201,
-	ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED =3D 0x0601,
+	ACER_WMID_CMD_GET_PREDATOR_V4_SUPPORTED_SENSORS =3D 0x0000,
+	ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING	=3D 0x0001,
+	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS	=3D 0x0002,
+};
+
+enum acer_wmi_predator_v4_sensor_id {
+	ACER_WMID_SENSOR_CPU_TEMPERATURE	=3D 0x01,
+	ACER_WMID_SENSOR_CPU_FAN_SPEED		=3D 0x02,
+	ACER_WMID_SENSOR_EXTERNAL_TEMPERATURE_2 =3D 0x03,
+	ACER_WMID_SENSOR_GPU_FAN_SPEED		=3D 0x06,
+	ACER_WMID_SENSOR_GPU_TEMPERATURE	=3D 0x0A,
 };

 static const struct key_entry acer_wmi_keymap[] __initconst =3D {
@@ -272,6 +283,7 @@ static u16 commun_func_bitmap;
 static u8 commun_fn_key_number;
 static bool cycle_gaming_thermal_profile =3D true;
 static bool predator_v4;
+static u64 supported_sensors;

 module_param(mailled, int, 0444);
 module_param(brightness, int, 0444);
@@ -1779,27 +1791,6 @@ static int acer_gsensor_event(void)
 	return 0;
 }

-static int acer_get_fan_speed(int fan)
-{
-	u64 fanspeed;
-	u32 command;
-	int ret;
-
-	if (!quirks->predator_v4)
-		return -EOPNOTSUPP;
-
-	if (fan =3D=3D 0)
-		command =3D ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED;
-	else
-		command =3D ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED;
-
-	ret =3D WMID_gaming_get_sys_info(command, &fanspeed);
-	if (ret < 0)
-		return ret;
-
-	return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
-}
-
 /*
  *  Predator series turbo button
  */
@@ -2688,43 +2679,86 @@ static void __init create_debugfs(void)
 			   &interface->debug.wmid_devices);
 }

+static const enum acer_wmi_predator_v4_sensor_id acer_wmi_temp_channel_to=
_sensor_id[] =3D {
+	[0] =3D ACER_WMID_SENSOR_CPU_TEMPERATURE,
+	[1] =3D ACER_WMID_SENSOR_GPU_TEMPERATURE,
+	[2] =3D ACER_WMID_SENSOR_EXTERNAL_TEMPERATURE_2,
+};
+
+static const enum acer_wmi_predator_v4_sensor_id acer_wmi_fan_channel_to_=
sensor_id[] =3D {
+	[0] =3D ACER_WMID_SENSOR_CPU_FAN_SPEED,
+	[1] =3D ACER_WMID_SENSOR_GPU_FAN_SPEED,
+};
+
 static umode_t acer_wmi_hwmon_is_visible(const void *data,
 					 enum hwmon_sensor_types type, u32 attr,
 					 int channel)
 {
+	enum acer_wmi_predator_v4_sensor_id sensor_id;
+	const u64 *supported_sensors =3D data;
+
 	switch (type) {
+	case hwmon_temp:
+		sensor_id =3D acer_wmi_temp_channel_to_sensor_id[channel];
+		break;
 	case hwmon_fan:
-		if (acer_get_fan_speed(channel) >=3D 0)
-			return 0444;
+		sensor_id =3D acer_wmi_fan_channel_to_sensor_id[channel];
 		break;
 	default:
 		return 0;
 	}

+	if (*supported_sensors & BIT(sensor_id - 1))
+		return 0444;
+
 	return 0;
 }

 static int acer_wmi_hwmon_read(struct device *dev, enum hwmon_sensor_type=
s type,
 			       u32 attr, int channel, long *val)
 {
+	u64 command =3D ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
+	u64 result;
 	int ret;

 	switch (type) {
+	case hwmon_temp:
+		command |=3D FIELD_PREP(ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK,
+				      acer_wmi_temp_channel_to_sensor_id[channel]);
+
+		ret =3D WMID_gaming_get_sys_info(command, &result);
+		if (ret < 0)
+			return ret;
+
+		result =3D FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
+		*val =3D result * MILLIDEGREE_PER_DEGREE;
+		return 0;
 	case hwmon_fan:
-		ret =3D acer_get_fan_speed(channel);
+		command |=3D FIELD_PREP(ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK,
+				      acer_wmi_fan_channel_to_sensor_id[channel]);
+
+		ret =3D WMID_gaming_get_sys_info(command, &result);
 		if (ret < 0)
 			return ret;
-		*val =3D ret;
-		break;
+
+		*val =3D FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
+		return 0;
 	default:
 		return -EOPNOTSUPP;
 	}
-
-	return 0;
 }

 static const struct hwmon_channel_info *const acer_wmi_hwmon_info[] =3D {
-	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT, HWMON_F_INPUT), NULL
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT,
+			   HWMON_T_INPUT
+			   ),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT,
+			   HWMON_F_INPUT
+			   ),
+	NULL
 };

 static const struct hwmon_ops acer_wmi_hwmon_ops =3D {
@@ -2741,9 +2775,20 @@ static int acer_wmi_hwmon_init(void)
 {
 	struct device *dev =3D &acer_platform_device->dev;
 	struct device *hwmon;
+	u64 result;
+	int ret;
+
+	ret =3D WMID_gaming_get_sys_info(ACER_WMID_CMD_GET_PREDATOR_V4_SUPPORTED=
_SENSORS, &result);
+	if (ret < 0)
+		return ret;
+
+	/* Return early if no sensors are available */
+	supported_sensors =3D FIELD_GET(ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_M=
ASK, result);
+	if (!supported_sensors)
+		return 0;

 	hwmon =3D devm_hwmon_device_register_with_info(dev, "acer",
-						     &acer_platform_driver,
+						     &supported_sensors,
 						     &acer_wmi_hwmon_chip_info,
 						     NULL);

=2D-
2.39.5



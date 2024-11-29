Return-Path: <linux-kernel+bounces-425916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D299DEC83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C84BB230CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABEF1AA1E3;
	Fri, 29 Nov 2024 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="LcZDsUtz"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E31A256B;
	Fri, 29 Nov 2024 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908862; cv=none; b=V45pq8Hpk8BFhMSbCBnA+HVNVzmsR7xWLZDZbG3W1wjwTwwzeAX8k2qSG4/G3nOH9bc+Oq4rHLK3LcE/VzXuGdYuuoxYuDxH8iDb3QP0d3OGHnOb3Ql8cvJZ23QN3pOyzPvsMlhFbmWuboybiYPsMTdCeGbMnFj2p5tH7d5vjAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908862; c=relaxed/simple;
	bh=GQjVcCIr/0IA5545qmgRVzt+JIneduevB9BxTt+Nq1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SV94k0v9X6MH2Qjqd1a0p2qoQxC3/zOq/aMyWP+uOLfejQ+NFuAq9ptsu1QDW0D2X5k9KyGE9mh0sEAIbTR5eW9vrrs5Emt9JhTTlMQ7JYjgELRTdGspYOrUOe+Es5VqtKRd71HEHR2Q6rrcyvDpT9zyOpQlZ6OHp+HflO9jpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=LcZDsUtz; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732908853; x=1733513653; i=w_armin@gmx.de;
	bh=vAOIOi0xlHXftrBt/pbZu0/b/mF+loyRuZxpSlsLR1Y=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LcZDsUtzqpbcHRrW+DPJ6PTnzac1eti6FQenVkMLFgC2b9p/VzGC6XN9iTKQZ4CK
	 MhLPcfkxRId8jbJtNSOPLKz08gc7QdB2MTd5wvJq7LcHxs2/huE+Ui0FdDQIHpvjg
	 4tq+BQAzhD93ibiVvhhLOLQsouDd8MLEUR8cXShDKuJNnhfI5bMKRXvYRcLS4vOx6
	 wzczN9i0uFHFxD9MSaDqijb0WHZ8TL6Ja4cYdaeY2dxmIrwoK4SAtN/FNCQtQNEad
	 E7IrRoFgpkn71tFz0v9KNWuezmJvMXtwIXev4dGYzrmAWozPrzLDq6+vtzW4sPNPa
	 nPg+7DWjSxNv+ABJeg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MDhlV-1tQl7b30wp-000sCa; Fri, 29 Nov 2024 20:34:13 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] platform/x86: acer-wmi: Implement proper hwmon support
Date: Fri, 29 Nov 2024 20:33:58 +0100
Message-Id: <20241129193359.8392-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241129193359.8392-1-W_Armin@gmx.de>
References: <20241129193359.8392-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H+Ez4nj6lraIK9MBdQ4M7/It/xWTnled57pSmieOftLLVi5lvWM
 Cdw+IpqM0uvVXWZf5njGM2GFZVFQbcrKf/BtfnmJsulBN8QaK5LyaUEgCW/6CX4H1O/yToP
 NQiwu2JfLclKtHFyJXotYPC0KTdwj7hr2fCNb64CZ11cmExOTRiVzeou/EaylAFo/JlJeeF
 Bj8g8xNe+Wx44OmnZH2tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MZ8SNlbuP2M=;1LBbKM+egVLysEKF6+20GcIt7IG
 OTSpk0R4v0u6ABsWKRl2vRG+RS/4hgJNeecQ0YPMxQmFdO3mMtXFbc20tzeb6gQ/f7eK5ItTw
 gM7lFDVjYOVyhaeTP4p5aO2nLdQcy7n2PPTzMs9NtMwryrs0uH1+YABDNnMov5/7HPCBHVwXG
 QC8A3Stpo4mLDjXvnqgJnSTOja1mPtOKYDW4iqZ+TjXkzEQzH02T3CFAyXb4r0kNnket6YK+E
 GaIhSEJJSs339++eKKQdFNfpoh4cTKzp+38muGFav4/FB96FmiJtjkkiZTWfDspO5NsJCng5G
 LYCbc34a+PNk8ciLpgVTd0yDkOTY4fREyNRqSfou7UYAkA4RkT1BG+eCRcKstlDC0X6i5sV50
 7CtgPPuzHvRBdyPUYJPDucGGpOvUvHalc0osybQfkFySkKeQ1CC7Dlyk8VLBeGiP9BqA/UYyu
 ltCs17m1TLMZN1TmakxSwdgvB2IRfuafA9Jc8NDOMWIziKw+uBJjc9wy4yX/GY4r7Jm0XK5e4
 jtWkkTEqTEbFORu62D1XvXAzsbUvqvAVecg2ZxTJPc92HP6Hl7CXJ11JqTUVmJ9dorutyXMaO
 SUodC8KLaDID6rcsBnSHLpfLg1B26ejQq+kLrT9mDYX6XL0Wmh+icKrnj7z01y8+df9rIPfuf
 01KmlYUfK4Vlwx3l2jT4B1xomQ/NDM96ICFfk/yNjl1LayNUJPkw9crSjoGB0bJ0PfMJJ5pcj
 ITASLjh0BFU+aX9GHC9pnvLn8EHMoqsbuL7ogdKUdDGQ20hMacL+Zsck0Rfogx4tqF0bCRHpU
 ttbw0QadNk7Y38nnvfDWWDtCVCWzwNt2Y6NZ7aYlOsLD8i7wjzMyQL7j6jtXKBVvz2gvjeGkq
 H5jllzPHPp1gm/2p7bQ0rLFjPGwD/JKsZLk2EPLDKAu7DFeon9bakXnjZwZRezSLGmKY3mTBU
 bxsXPEAVWnMJ5c7Ok3ntvJhYvEWdvk+Co28067sGxyxWN4wi/hZt3RdcUJcSHMagdSWUn34iW
 OR6HBfyrKar3Us8vOb5OyCBjg59R4d9JZLr+LGwLd1Y6eYKRTdggExU1W21T5nSVbMpb1qUCf
 NWnNpXokm9CGx9TlcH+15lXp+rNW1O

After looking at the ACPI AML code, it seems that the command 0x0000
used with ACER_WMID_GET_GAMING_SYS_INFO_METHODID returns a bitmap of
all supported sensor indices available through the 0x0001 command.

Those sensor indices seem to include both temperature and fan speed
sensors, with only the fan speed sensors being currently supported.

Use the output of this new command to implement reliable sensor
detection. This fixes detection of fans which do not spin during
probe, as fans are currently being ignored if their speed is 0.

Also add support for the new temperature sensor ids.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 114 ++++++++++++++++++++++----------
 1 file changed, 80 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index ac4500f33b8c..2c1ea6155bd3 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -30,6 +30,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <acpi/video.h>
 #include <linux/hwmon.h>
+#include <linux/units.h>
 #include <linux/bitfield.h>

 MODULE_AUTHOR("Carlos Corbacho");
@@ -71,7 +72,10 @@ MODULE_LICENSE("GPL");
 #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54

 #define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)
-#define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
+#define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK_ULL(7, 0)
+#define ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK GENMASK_ULL(15, 8)
+#define ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK GENMASK_ULL(23, 8)
+#define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK_ULL(39, 24)

 /*
  * Acer ACPI method GUIDs
@@ -99,9 +103,17 @@ enum acer_wmi_event_ids {
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
@@ -272,6 +284,7 @@ static u16 commun_func_bitmap;
 static u8 commun_fn_key_number;
 static bool cycle_gaming_thermal_profile =3D true;
 static bool predator_v4;
+static u64 supported_sensors;

 module_param(mailled, int, 0444);
 module_param(brightness, int, 0444);
@@ -1779,27 +1792,6 @@ static int acer_gsensor_event(void)
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
@@ -2688,43 +2680,86 @@ static void __init create_debugfs(void)
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
@@ -2741,9 +2776,20 @@ static int acer_wmi_hwmon_init(void)
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



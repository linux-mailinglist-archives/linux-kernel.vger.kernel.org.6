Return-Path: <linux-kernel+bounces-424824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE3F9DB9ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC57028138D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23D91BD9CB;
	Thu, 28 Nov 2024 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MLEC0lt7"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC292233A;
	Thu, 28 Nov 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805493; cv=none; b=jwNBbIPCHi1JWRMmst95HutnvFkPp49oSFLQ8MAWafgDhBmPfe4F+IUwcd8Pl4UrthjM2xSkjCMaaoHsfhcoXD7iijoceq+YB82pLwZ3tFb0tEDMTPGumjB/QHK+kZxNlzqRBOdYQHIYOvlrLzKHOSWKGshlXVnlhQddXVVOjiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805493; c=relaxed/simple;
	bh=jA/RYuJuXv2Kcbxr/tarWpJfHkpKlsndR+/8Rf8rxAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eKzJG/lOVFO6TadpQRvAeaBj1s73twx1heoo4dt/2ok4Hcaz4vTqTQuIiUfHCgexJMakssOBdJVtt0FkcB2ENtQDuvt9NVcnNmlmd0Z8GPMPhsb1BlHJCIVWbQZbmqjaIs2qh6JzYGPzKLJJrCRa7rhjwG9AWVtMHU2HQFc9NPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MLEC0lt7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732805482; x=1733410282; i=w_armin@gmx.de;
	bh=w9XMGh+DU+TKMHDIPn2YAPDqHS7ou5ajkWr6SnoQXWQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MLEC0lt78mPqH9Ed6phnbZ9Iq24envJpPGUZWNH/TgLGNj67nFGwwQDOO709UD2a
	 60vkNPQcJvFc3y1oyVj4PsOJSEMU1TvN+8hHoe9U5tVZJZGZ2PXurhF0tv1NzHJB8
	 lKdJHOrCsVgmiXMBzHQnnmLHwk8K8yUF+rdQNgRT4fu8pD5f766s3A3FhL99vAKFO
	 v4yl1cxcPt3iicduk2RtZK6ilT0PydmaTxyGRvNnP0nszDPJOHlQWJ9WnEpO6Y/zP
	 Av10K24iT5mKczXZ8bpNiaDAdhuay+EVE8WqpJ1/E4JvY7M30ggDfRgMTjoiI5d/x
	 AGFJZhXKys3Pvac/6A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.dip.tu-dresden.de ([141.76.179.133]) by
 mail.gmx.net (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1McYCb-1tovDT1KkX-00ieTw; Thu, 28 Nov 2024 15:51:22 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] platform/x86: acer-wmi: Implement proper hwmon support
Date: Thu, 28 Nov 2024 15:51:03 +0100
Message-Id: <20241128145104.13538-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241128145104.13538-1-W_Armin@gmx.de>
References: <20241128145104.13538-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LofgK/zvLEhUQ9+gMCmd49ZNnWI81B4x+9RUlKeQ8b5wsrXl2Fj
 mN8EM3hCEsN09EyQoACSjWTRxYf4FhRNMcVJl+ib6448fk8/AXG7X6aNP0EISvBtqIpugOl
 tIyUd+LFykH0GZ4GF9gtMH+Vjo0M1KyAkxMIzbKacwCCx9DROCw7cQzxqj9ltXoaGhughvH
 m7JQU6i1ypGdSt4VlaNkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YlDLqZ4l6GE=;LqEsfvBFMj6MdIdwV0LZB0s7mas
 LS0/SlHTIJp8OG5sEWrC3uvfCwH8q1Z4hTiRoXPGt66uJzNc+1WfJm96jFT+PPyVoDpJn7VRG
 5r8tZaV/6AjiFUOgYtwRQwv3GmlRX7S0pJsafshLsIWB5NEr6VdSM+ITov4Wk/FiApnBEd1E3
 6TXfGMX+J4a8ITlJZFzDl+QFYBa3AFH8nMpZw4gkY0nY6sdxTBw6LF4rTmyBNbcn+jjyiJ7h7
 /ql3JDXBbRkK31cI7u4Qh8bZ7zeuO0XK53xegwAUUQSzMAxk0Led1bKgPxtNOOUZptau66wWw
 xW4ogLXuteEMpyTR2jy35Xa5XXH01yXYoCN16z8Xnj8QJKnuEVpwLIpeEuhcbC8/H0O5VKzZp
 SAkRn5o1WBPu9S4ESYP38wRSiGOoxr/Xr5yWv1ePw5axUsb0n+xA6NibH0BI+si53WZLoAYSP
 ETZlI1JAH1eA7FjUE2sVWQD5FpUcUDZ2b+QOab/vMustTZ7VuGaXp4k34cFe8d7BMzlZAyBIy
 R/HREHJjYhSYc3RbKdbehnTKBXjHH3BZh+0TgyKjwz0AkaHTEhxT87dluXm7XrIvrWpweUwJE
 g/0X1Z9gxuoF3dOEvLCTqM1tmtYczKnr3x3Q+yP6MzsJI4kUiFQ69saIixLtbjCtv9SZQZmRO
 zHXCfh+sANHx0tEhNolJvGM626Yfm1AxRDoAZd/Lh/BL573ZbDzmUwndJae5gpWdLKTDN/86g
 z2O/NiwF4ZSW+T4H5fELqPeWZP2TLb8kpkrqdTV/6TpcyedLK5Jyp4S2WEB78w67ubR/Ycm2M
 aZJth8vxyehaA7VTgOJeHaBnI6s++6JDuHRRt5ddeOUmKYnc6C7wUSjv+/+b1UpJs6CUCkt0N
 XYrZsMVlyOpjtCX1PmD2dhmlGTqaBUXoOwtUomooPROo6kEaIHcccP2UXp8OdjGiRGNP4648V
 I4+P+1zH0eEQtqM8DXw1musst2ZiBkOk7uqsznu/x3ckScB+UcIm6PMmTRI4hg62wzlKbXQ9G
 5VfuaY3UPH4KWTVD5Ejb6RBfnkj8rvdc8dB3gEv0nZegkFlkLThXAUE+s9ahJtMdbk9OABAB4
 vXDwkaEj773j01WlXwRoX8KN1gp+ND

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
 drivers/platform/x86/acer-wmi.c | 113 ++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index fcea017f0796..e2615ab3fd25 100644
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

 #define ACER_PREDATOR_V4_RETURN_STATUS_BIT_MASK GENMASK(8, 0)
-#define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
+#define ACER_PREDATOR_V4_SENSOR_INDEX_BIT_MASK GENMASK(16, 8)
+#define ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK GENMASK(24, 8)
+#define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)

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
-	ret =3D WMID_gaming_get_sys_info(command, &fan_speed);
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



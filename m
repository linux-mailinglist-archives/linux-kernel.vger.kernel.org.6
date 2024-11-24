Return-Path: <linux-kernel+bounces-420180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AC59D767A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 18:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33043283471
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC913C8E2;
	Sun, 24 Nov 2024 17:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="i1Ws1c8g"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8F12B17C;
	Sun, 24 Nov 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732468491; cv=none; b=AmDPk8+OuJ/csGR3ckCA7ZNuoZS/V8EW+CUrXQ++lTTLEOucjC+pTo8QIi+PzjQmEBsGkloKEJNBYsAPULo9tQ7fhq4KwUA3ckvBuQs0SUNW4Tl9+tA9sdFUbqHo2dtlmzDsxtBoMZN0I1din/HjsbNqCjb04WMPHqv7BhCYlB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732468491; c=relaxed/simple;
	bh=TT8O367oCxl+F9JDDZIY5YxynYWK+Rsj6R4XZJXRhqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8i41ZekH1CZ/Vxc3JEFkbD3/cI7umpDgTLwCQex7Rr5koLltuhmI+iFJ6ZVDXUqz6TPAnYNh4xM4AwHB7nt4wKuOKz8gJQToEgz4O+dsNm4OJHjKHwQ3jfbzpC0ifgzSWADarBjV7UxWJ1PU6rfxaI/V8bGEuJmfMOJN4b1cGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=i1Ws1c8g; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732468481; x=1733073281; i=w_armin@gmx.de;
	bh=fZmHkIMIUdIfMfagPjZfZST1MIYYT0drmmDKyN+Uvz8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i1Ws1c8gSKMD3EUuOyJ69c6//V6sKgxRLQrec3W6B3m5c5cQ9KlQYog+ye9rFeUg
	 lcgWSNgWZLmkIy2FJhGzDrtvJzfTJZus9rDFBrN0GAlHUBP43cmySqOWyEUjHZAbU
	 XJ9MAIKe9La8Uu57tS+orPTzE1yd2SA+uCAk+VUUiN9NSWqb0yfzagBUrOH3pktgt
	 +rrH4hhuZQbsou28mJfophIe1tf1pEVDWlpX8m72pL9egWiHIDNlHeq3IpD7FRkwM
	 Gpplc+AYldXS6SQkON3tqnzp06m/oBWJmMBBw1BxdmDOUrJoeDHB2hqw8nfsBCBJy
	 3X0QnrJBR+dvmLFQBg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mr9Fs-1u2M8V1nGQ-00aVrz; Sun, 24 Nov 2024 18:14:41 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/5] platform/x86: acer-wmi: Add support for temperature sensors
Date: Sun, 24 Nov 2024 18:14:24 +0100
Message-Id: <20241124171426.29203-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241124171426.29203-1-W_Armin@gmx.de>
References: <20241124171426.29203-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/uxuGI9SYPfiDM+uFre+uNU/7AhCYnzlumWZ/QzakRZFqQrBgvt
 chCIdDTM5P2253AIImhvVmYVEtcpFesZVv4s+0X/pO+4ezVGRCThvi33U1+2TxFhJxN2ZCN
 /b8BU56kq7hZ+2jXOXhp6m1XMwFMesKfr3kAXK+6nCb2z2jHNPWyTJOECrqs1eB1tEWvcRV
 SnQ6M+eVyVD/SbzSLwzyg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+8o/+kLHqTI=;T1KZhB+W6XlLw2M7t01rN3e7Xe9
 B7pXmmyf9t0w4sipOHQ7foAFkFGnmyzrmhuNERo4I0KSMOhHB5Jw8ZpvpMYvoZzKuaX6LukvX
 KXeahsMjM6CpFt0dl+ee3sLgSksggWaHzHJemaGzRUoH5sgKf34mfM9i84BD82OhNee7QNiCP
 LvR/kq1LViDa+eqzkZdo1jBq2qvfmMegCZfrwxQIeDjusjiagU9VkyEvi9IAkf6WWpfsIMM3k
 J2/2VBBLjYs0ARaJTyv2b+qDbfSgroOfY5bYAPcj+hyvV3tp6FHed74JIr3HOPaZjRBeDuvbi
 KHkHPYyar6pZWioeyyzJbLTSAI3HeG2kTXV3S7oEgZGxdrolPA7LE9FjD76OfkFf+wUnpqE9K
 voMTiL9pZf5geAraHkIxr1R0M1120YtvaidtUo1/gaAPjkifCnMjlMvfx1aV/sQNpYF1fldZO
 ADsjh44EsXGWckEB4JEhUqV2U6Gng6ZfZZnUOKEoj1ygvq4ESYPSxISZ5djD1Pj7vLvq13pK+
 Mjhdjcx+wbl9y4Sc7g8dsMHHqRlLN2fId4swP8kqKsgjuylTGADpSW50MymNM8fLpWcmCryI+
 Tsk4Lw3txeGCu3TJHxQNHjhPJdkv4wO1JTWb0jz3heE+ldiOECDGfQHlZ7iWG+TrNF3oUSAjC
 HXSenz3K5vpUp+6rTVGRxI7gECJ272JECA2yaVhBmflWm95tUKjw3o5U3oyeMZmFHvu3GamJS
 klWtpyeES8aEFxc5OX6MkTieyhOfierbywrYoTQUobhtV2cMJt6ZoEZHhXVnwj922bn7VFDki
 xalFouRvizVv7+HKmdYgzBy4/5iRSPemuiahrGe1y9osboVgq7d+cBZl1pMdLuDhHvN6QSH5u
 /mwDbTvUbszwiTyPHAKLRyNSDpCrfB0BNwDyuW9xzy9MT6p1hV2m9zrxU

After looking at the ACPI AML code, it seems that the command 0x0000
used with ACER_WMID_GET_GAMING_SYS_INFO_METHODID returns a bitmap of
all supported sensors available through the 0x0001 command.

Add support for this command and the additional temperature sensors.
This also fixed detection of fan sensors should the fan not spin
during device initialization.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 129 ++++++++++++++++++++++++--------
 1 file changed, 96 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index dd57787466b9..7b549920eba7 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -30,6 +30,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <acpi/video.h>
 #include <linux/hwmon.h>
+#include <linux/units.h>
 #include <linux/bitfield.h>

 MODULE_AUTHOR("Carlos Corbacho");
@@ -70,7 +71,8 @@ MODULE_LICENSE("GPL");

 #define ACER_PREDATOR_V4_THERMAL_PROFILE_EC_OFFSET 0x54

-#define ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK GENMASK(20, 8)
+#define ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK GENMASK(24, 8)
+#define ACER_PREDATOR_V4_SUPPORTED_SENSORS_BIT_MASK GENMASK(40, 24)

 /*
  * Acer ACPI method GUIDs
@@ -98,9 +100,17 @@ enum acer_wmi_event_ids {
 };

 enum acer_wmi_predator_v4_sys_info_command {
-	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS =3D 0x02,
-	ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED =3D 0x0201,
-	ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED =3D 0x0601,
+	ACER_WMID_CMD_GET_PREDATOR_V4_SUPPORTED_SENSORS =3D 0x0000,
+	ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING =3D 0x0001,
+	ACER_WMID_CMD_GET_PREDATOR_V4_BAT_STATUS =3D 0x0002,
+};
+
+enum acer_wmi_predator_v4_sensor_id {
+	ACER_WMID_SENSOR_CPU_TEMPERATURE =3D 0x01,
+	ACER_WMID_SENSOR_CPU_FAN_SPEED =3D 0x02,
+	ACER_WMID_SENSOR_EXTERNAL_TEMPERATURE_2 =3D 0x03,
+	ACER_WMID_SENSOR_GPU_FAN_SPEED =3D 0x06,
+	ACER_WMID_SENSOR_GPU_TEMPERATURE =3D 0x0A,
 };

 static const struct key_entry acer_wmi_keymap[] __initconst =3D {
@@ -271,6 +281,7 @@ static u16 commun_func_bitmap;
 static u8 commun_fn_key_number;
 static bool cycle_gaming_thermal_profile =3D true;
 static bool predator_v4;
+static u64 supported_sensors;

 module_param(mailled, int, 0444);
 module_param(brightness, int, 0444);
@@ -1513,6 +1524,24 @@ static acpi_status WMID_gaming_get_u64(u64 *value, =
u32 cap)
 	return status;
 }

+static int WMID_gaming_get_sys_info(u32 command, u64 *out)
+{
+	acpi_status status;
+	u64 result;
+
+	status =3D WMI_gaming_execute_u64(ACER_WMID_GET_GAMING_SYS_INFO_METHODID=
, command, &result);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	/* The lower 8 bits must be zero for the operation to have succeeded */
+	if (result & 0xff)
+		return -EIO;
+
+	*out =3D result;
+
+	return 0;
+}
+
 static void WMID_gaming_set_fan_mode(u8 fan_mode)
 {
 	/* fan_mode =3D 1 is used for auto, fan_mode =3D 2 used for turbo*/
@@ -1760,26 +1789,6 @@ static int acer_gsensor_event(void)
 	return 0;
 }

-static int acer_get_fan_speed(int fan)
-{
-	if (quirks->predator_v4) {
-		acpi_status status;
-		u64 fanspeed;
-
-		status =3D WMI_gaming_execute_u64(
-			ACER_WMID_GET_GAMING_SYS_INFO_METHODID,
-			fan =3D=3D 0 ? ACER_WMID_CMD_GET_PREDATOR_V4_CPU_FAN_SPEED :
-				   ACER_WMID_CMD_GET_PREDATOR_V4_GPU_FAN_SPEED,
-			&fanspeed);
-
-		if (ACPI_FAILURE(status))
-			return -EIO;
-
-		return FIELD_GET(ACER_PREDATOR_V4_FAN_SPEED_READ_BIT_MASK, fanspeed);
-	}
-	return -EOPNOTSUPP;
-}
-
 /*
  *  Predator series turbo button
  */
@@ -2671,43 +2680,86 @@ static void __init create_debugfs(void)
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
+	enum acer_wmi_predator_v4_sensor_id sensor_id;
+	u64 command, result;
 	int ret;

 	switch (type) {
+	case hwmon_temp:
+		sensor_id =3D acer_wmi_temp_channel_to_sensor_id[channel];
+		command =3D ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING | (sensor_id <=
< 8);
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
+		sensor_id =3D acer_wmi_fan_channel_to_sensor_id[channel];
+		command =3D ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING | (sensor_id <=
< 8);
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
@@ -2724,9 +2776,20 @@ static int acer_wmi_hwmon_init(void)
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



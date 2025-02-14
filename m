Return-Path: <linux-kernel+bounces-515721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC848A36824
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 23:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134FE171292
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879D81FC7C1;
	Fri, 14 Feb 2025 22:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jV9vxTmW"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3591DAC95;
	Fri, 14 Feb 2025 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739571218; cv=none; b=AXNsU4jS2HiqNHklgpqYeVo/MaZBUxLxaZdWn+E2KkA0VjX7FaV64bb80gKUs5zflfm4fm11lI7i5uOE64tn7Tr21O8iNqcO9JQ7HtURCgPAqWKtTukdc0LYdlrZ9GLyq1xMcaWLiIYWMGFtrwTziWmGFAiQydZsYwK77ViowVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739571218; c=relaxed/simple;
	bh=WV4joV9iIg7zYXBQxWjjLedPiBapTAJv1mf0/5ZpyBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sd6krVzfv3PTaoQmsZe28ph7XAxW68M4GbXQuS7b73koNvjahiTwOvf5LXiFcfu9LWngok55P9T7EsFIrzn1k8rRDwbu2yM+cjWTB/DvJEbnbBD3UTTPNZ81LFIL4N+JjKBv2Yx761gpY9nCbybzmJWC3EGtLlAElr6fHHpbizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jV9vxTmW; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739571214; x=1740176014; i=w_armin@gmx.de;
	bh=BVcQ46ClAAgi3BH3jIONiYBhKas//7x1AXXEuG2Z4m8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jV9vxTmWHwc+meZAnVYtVkEDvxEGYLjXw5tJrtQFKiWGOAgs7zZGGW0YzKGfOSWE
	 ESJytMhoUzzlsBlG25ycY+Ce9im8JHHbh9rQLJvGry2w2SP5Az9i7zBh8EbhG6hvg
	 ztgxfyT0+krGPeYva12PNchCaX0umI2bIJfvBoVnYhb98OeGn5hPcAxkQu4DKY36j
	 +vklYG2xeg7bwTZpr8znhOkBZ2Y9pbehJ1G4NZm8N7IUt5T42bOfbx7qwkUU5DH6a
	 ZfbynJ4va6uV9UlX2Bau+K7+AOVdFXK9BDxnkzG8KoJuecDCrLnyaGOw3yEotas8m
	 I454nVxJdA1EpVZa8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MvbFs-1tPcB13svu-00yiVE; Fri, 14 Feb 2025 23:13:34 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] platform/x86: acer-wmi: Add fan control support
Date: Fri, 14 Feb 2025 23:13:21 +0100
Message-Id: <20250214221322.47298-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250214221322.47298-1-W_Armin@gmx.de>
References: <20250214221322.47298-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wnmS9XvtAerOZ8OLFOkdrmh3UySH97I7bI3GQ2TN0wJ3ZKq6ZGY
 4+a1mW/21q+Cyp4K61RDbM3hU3E8HyuhbLpIdXc6CdHUhfOBsVJcGesAzZ4psC2S95q2bUZ
 BwD2HUU7Sz/V6vOuJaK5G3XfeKR/AzvI98VIEC320yz1ebQt1IdV8xQ5R/Ky8EbombGybmL
 fufbdFDUE1qsMT6d/LM3w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uLrtbSGEK5Q=;8GSs9ksD8NoUmE6KWD44cSrbDyd
 AcCtYAe6DqoB6rxpm+HGOTWt6YsT9EaS6/yyaFKiewI+94jaZ1gghBFVNpzi1FBHRjyJH1fmZ
 Wlz0lnXIjcfqD8Xf2IqxcrS1QO5ApwgoSM1t6FJuyOwH2TcUrzq93lAumtfxEYBuy+aOo3RcZ
 LwOJlm3vVu5lXKcTbm+ZjPz7OkrTAtNW8r405IcijVqUudu6uqtElDWzJ8l4YlPuPnycFvv6d
 dQyivreoBLm9k/djFHHkvwydDMiACK0VVQkHwJPQr5X6wmKdY+8Pz+KV0KCq9YjbH7TkdJ3C7
 KfXTblKmeU+g10bZuyMJhGmuYOPKao5lCm2/vTTJTGCF5zrTni1YikeDLiNwxv2V+YKxGPEvJ
 N1yktX170Mg71HNLPA+FN61gy7gvTBKZKN/C9hk08SXJ1qqB6NuvJhT9Q+iEvlpB5UI/W9jQ9
 AQNO3DwxBm5YL0tuYvDe2JXzZxGc/HcKnyDEQxmEbUBV4L9erb+x5oiLiRhZbcQjLHFoQhfQR
 /IjHdpCItxZqusaJjtVi7EapSj2Vz6ZdnxJP3BGft2QqFpGDHUpw+rIBAcN49eGvJyeIAxX1o
 v0ZCRG+GAJWgz2gliWjPIYuYInGqV2vSh0RqODVnG06KB+eFWwD+qSaATp/C13IP+60HgGzZW
 FyhjoNX24aDQjImNWKhT5cBM8ECPtP1hJMeInZxP+UlxfkYxxy8oyLm5GmQwRo/hLNXYklcXG
 P9ZubvK2Efo6NKeq0pwlYQRznDczEAu9MvJWdjiS8QRm22MA+bDLVQJYfiDwW+jqjFbX0jKBf
 B4JqDR6HnPN2f0oH+JkXRftufy8MeQInjrBA7xZklYTteTURl4EUCIqCooLXiKuT0iVn4IyNm
 UGPPGZwTLHMXkKwrvFAgurHHUNmSU6V8+iW2OJ8iDsi21H5/kbEYFrDKsJP4corjQmNLg78p2
 Yn1Zhk3h7+mvmXvUucIBeTCb9urAo7n4LfZs0qzJgcrLucSmSXBWzTGRpYNx/gBrwdvFmFt6A
 Ci/h7e5QBkDD3vID3h4a5p9gNrchXXQLWKdLjJIDpCc8HaQ+mX6ncOT+MLRsY4jpjv0OAmys/
 kzqXWSwbAg9qRVdsvVKPEhJnzcqBqVlSP52rWhDBvTAv7gu5grL9s8pypBcjsGGCbp47W3icb
 f/QvLWzPv0VbSb0sihUz4JBY2czP0cdx3ZlFJHdk7SVmoxzMLnJJH8KoNAmeOa5CChnM7IQA6
 acS3aglDJAOpsS/9wzcXT3WtaRndMteBmsWV/9p6d2bXwzye+guJd6cGEjU3PVPJoU9H8zLpM
 /M9fvz9FK6XLSwI1Qf4h4p2W+Mty6mZRfGeVuoETqRmkjWKo5XLA5fArHNBnjcZxXoyYGQK8W
 2zkULDnPYD2A2VIL+W7y01qa6fE+ybrCypWvpubIMZvMp5KNv2UgY273lQ

Add support for controlling the fan speed using the
SetGamingFanSpeed() and GetGamingFanSpeed() WMI methods.

This feature is only enabled if the machine has ACER_CAP_PWM enabled
and depend on ACER_CAP_HWMON for detecting the number of available
fans.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 222 +++++++++++++++++++++++++++++++-
 1 file changed, 220 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index f20a882e3650..e24f5a323f95 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -12,10 +12,12 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/dmi.h>
+#include <linux/fixp-arith.h>
 #include <linux/backlight.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
@@ -30,6 +32,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <acpi/video.h>
 #include <linux/hwmon.h>
+#include <linux/unaligned.h>
 #include <linux/units.h>
 #include <linux/unaligned.h>
 #include <linux/bitfield.h>
@@ -69,11 +72,16 @@ MODULE_LICENSE("GPL");
 #define ACER_WMID_GET_GAMING_LED_METHODID 4
 #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
 #define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
+#define ACER_WMID_GET_GAMING_FAN_BEHAVIOR_METHODID 15
+#define ACER_WMID_SET_GAMING_FAN_SPEED_METHODID 16
+#define ACER_WMID_GET_GAMING_FAN_SPEED_METHODID 17
 #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
 #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23

+#define ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
 #define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
+#define ACER_GAMING_FAN_BEHAVIOR_GET_MODE_MASK GENMASK_ULL(23, 8)

 #define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
 #define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
@@ -81,6 +89,10 @@ MODULE_LICENSE("GPL");
 #define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
 #define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)

+#define ACER_GAMING_FAN_SPEED_STATUS_MASK GENMASK_ULL(7, 0)
+#define ACER_GAMING_FAN_SPEED_ID_MASK GENMASK_ULL(7, 0)
+#define ACER_GAMING_FAN_SPEED_VALUE_MASK GENMASK_ULL(15, 8)
+
 #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
@@ -130,6 +142,11 @@ enum acer_wmi_predator_v4_sensor_id {
 	ACER_WMID_SENSOR_GPU_TEMPERATURE	=3D 0x0A,
 };

+enum acer_wmi_gaming_fan_id {
+	ACER_WMID_CPU_FAN	=3D 0x01,
+	ACER_WMID_GPU_FAN	=3D 0x04,
+};
+
 enum acer_wmi_gaming_fan_mode {
 	ACER_WMID_FAN_MODE_AUTO		=3D 0x01,
 	ACER_WMID_FAN_MODE_TURBO	=3D 0x02,
@@ -292,6 +309,7 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_TURBO_FAN		BIT(9)
 #define ACER_CAP_PLATFORM_PROFILE	BIT(10)
 #define ACER_CAP_HWMON			BIT(11)
+#define ACER_CAP_PWM			BIT(12)

 /*
  * Interface type flags
@@ -386,6 +404,7 @@ struct quirk_entry {
 	u8 cpu_fans;
 	u8 gpu_fans;
 	u8 predator_v4;
+	u8 pwm;
 };

 static struct quirk_entry *quirks;
@@ -405,6 +424,9 @@ static void __init set_quirks(void)
 	if (quirks->predator_v4)
 		interface->capability |=3D ACER_CAP_PLATFORM_PROFILE |
 					 ACER_CAP_HWMON;
+
+	if (quirks->pwm)
+		interface->capability |=3D ACER_CAP_PWM;
 }

 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -1650,6 +1672,27 @@ static int WMID_gaming_set_fan_behavior(u16 fan_bit=
map, u8 mode_bitmap)
 	return 0;
 }

+static int WMID_gaming_get_fan_behavior(u16 fan_bitmap, u8 *mode_bitmap)
+{
+	acpi_status status;
+	u32 input =3D 0;
+	u64 result;
+
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
+	status =3D WMI_gaming_execute_u32_u64(ACER_WMID_GET_GAMING_FAN_BEHAVIOR_=
METHODID, input,
+					    &result);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	/* The return status must be zero for the operation to have succeeded */
+	if (FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK, result))
+		return -EIO;
+
+	*mode_bitmap =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GET_MODE_MASK, resul=
t);
+
+	return 0;
+}
+
 static void WMID_gaming_set_fan_mode(u8 fan_mode)
 {
 	u16 mode_bitmap =3D 0;
@@ -1668,6 +1711,55 @@ static void WMID_gaming_set_fan_mode(u8 fan_mode)
 	WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
 }

+static int WMID_gaming_set_gaming_fan_speed(u8 fan, u8 speed)
+{
+	acpi_status status;
+	u64 input =3D 0;
+	u64 result;
+
+	if (speed > 100)
+		return -EINVAL;
+
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_ID_MASK, fan);
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_VALUE_MASK, speed);
+
+	status =3D WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_SPEED_METHODI=
D, input, &result);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	switch (FIELD_GET(ACER_GAMING_FAN_SPEED_STATUS_MASK, result)) {
+	case 0x00:
+		return 0;
+	case 0x01:
+		return -ENODEV;
+	case 0x02:
+		return -EINVAL;
+	default:
+		return -ENXIO;
+	}
+}
+
+static int WMID_gaming_get_gaming_fan_speed(u8 fan, u8 *speed)
+{
+	acpi_status status;
+	u32 input =3D 0;
+	u64 result;
+
+	input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_ID_MASK, fan);
+
+	status =3D WMI_gaming_execute_u32_u64(ACER_WMID_GET_GAMING_FAN_SPEED_MET=
HODID, input,
+					    &result);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if (FIELD_GET(ACER_GAMING_FAN_SPEED_STATUS_MASK, result))
+		return -ENODEV;
+
+	*speed =3D FIELD_GET(ACER_GAMING_FAN_SPEED_VALUE_MASK, result);
+
+	return 0;
+}
+
 static int WMID_gaming_set_misc_setting(enum acer_wmi_gaming_misc_setting=
 setting, u8 value)
 {
 	acpi_status status;
@@ -2839,6 +2931,16 @@ static const enum acer_wmi_predator_v4_sensor_id ac=
er_wmi_fan_channel_to_sensor_
 	[1] =3D ACER_WMID_SENSOR_GPU_FAN_SPEED,
 };

+static const enum acer_wmi_gaming_fan_id acer_wmi_fan_channel_to_fan_id[]=
 =3D {
+	[0] =3D ACER_WMID_CPU_FAN,
+	[1] =3D ACER_WMID_GPU_FAN,
+};
+
+static const u16 acer_wmi_fan_channel_to_fan_bitmap[] =3D {
+	[0] =3D ACER_GAMING_FAN_BEHAVIOR_CPU,
+	[1] =3D ACER_GAMING_FAN_BEHAVIOR_GPU,
+};
+
 static umode_t acer_wmi_hwmon_is_visible(const void *data,
 					 enum hwmon_sensor_types type, u32 attr,
 					 int channel)
@@ -2850,6 +2952,11 @@ static umode_t acer_wmi_hwmon_is_visible(const void=
 *data,
 	case hwmon_temp:
 		sensor_id =3D acer_wmi_temp_channel_to_sensor_id[channel];
 		break;
+	case hwmon_pwm:
+		if (!has_cap(ACER_CAP_PWM))
+			return 0;
+
+		fallthrough;
 	case hwmon_fan:
 		sensor_id =3D acer_wmi_fan_channel_to_sensor_id[channel];
 		break;
@@ -2857,8 +2964,12 @@ static umode_t acer_wmi_hwmon_is_visible(const void=
 *data,
 		return 0;
 	}

-	if (*supported_sensors & BIT(sensor_id - 1))
+	if (*supported_sensors & BIT(sensor_id - 1)) {
+		if (type =3D=3D hwmon_pwm)
+			return 0644;
+
 		return 0444;
+	}

 	return 0;
 }
@@ -2867,8 +2978,10 @@ static int acer_wmi_hwmon_read(struct device *dev, =
enum hwmon_sensor_types type,
 			       u32 attr, int channel, long *val)
 {
 	u64 command =3D ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
+	u8 fan, speed, mode_bitmap;
+	u16 fan_bitmap;
+	int mode, ret;
 	u64 result;
-	int ret;

 	switch (type) {
 	case hwmon_temp:
@@ -2892,6 +3005,106 @@ static int acer_wmi_hwmon_read(struct device *dev,=
 enum hwmon_sensor_types type,

 		*val =3D FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
 		return 0;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			fan =3D acer_wmi_fan_channel_to_fan_id[channel];
+			ret =3D WMID_gaming_get_gaming_fan_speed(fan, &speed);
+			if (ret < 0)
+				return ret;
+
+			*val =3D fixp_linear_interpolate(0, 0, 100, U8_MAX, speed);
+			return 0;
+		case hwmon_pwm_enable:
+			fan_bitmap =3D acer_wmi_fan_channel_to_fan_bitmap[channel];
+			ret =3D WMID_gaming_get_fan_behavior(fan_bitmap, &mode_bitmap);
+			if (ret < 0)
+				return ret;
+
+			switch (channel) {
+			case 0:
+				mode =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
+						 mode_bitmap);
+				break;
+			case 1:
+				mode =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
+						 mode_bitmap);
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			switch (mode) {
+			case ACER_WMID_FAN_MODE_AUTO:
+				*val =3D 2;
+				return 0;
+			case ACER_WMID_FAN_MODE_TURBO:
+				*val =3D 0;
+				return 0;
+			case ACER_WMID_FAN_MODE_CUSTOM:
+				*val =3D 1;
+				return 0;
+			default:
+				return -ENXIO;
+			}
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int acer_wmi_hwmon_write(struct device *dev, enum hwmon_sensor_typ=
es type,
+				u32 attr, int channel, long val)
+{
+	u8 fan, speed, mode_bitmap;
+	u16 fan_bitmap;
+	int mode;
+
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			fan =3D acer_wmi_fan_channel_to_fan_id[channel];
+			speed =3D fixp_linear_interpolate(0, 0, U8_MAX, 100,
+							clamp_val(val, 0, U8_MAX));
+
+			return WMID_gaming_set_gaming_fan_speed(fan, speed);
+		case hwmon_pwm_mode:
+			fan_bitmap =3D acer_wmi_fan_channel_to_fan_bitmap[channel];
+
+			switch (val) {
+			case 0:
+				mode =3D ACER_WMID_FAN_MODE_TURBO;
+				break;
+			case 1:
+				mode =3D ACER_WMID_FAN_MODE_CUSTOM;
+				break;
+			case 2:
+				mode =3D ACER_WMID_FAN_MODE_AUTO;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			switch (channel) {
+			case 0:
+				mode_bitmap =3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
+							 mode);
+				break;
+			case 1:
+				mode_bitmap =3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
+							 mode);
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			return WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
+		default:
+			return -EOPNOTSUPP;
+		}
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -2907,11 +3120,16 @@ static const struct hwmon_channel_info *const acer=
_wmi_hwmon_info[] =3D {
 			   HWMON_F_INPUT,
 			   HWMON_F_INPUT
 			   ),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
+			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE
+			   ),
 	NULL
 };

 static const struct hwmon_ops acer_wmi_hwmon_ops =3D {
 	.read =3D acer_wmi_hwmon_read,
+	.write =3D acer_wmi_hwmon_write,
 	.is_visible =3D acer_wmi_hwmon_is_visible,
 };

=2D-
2.39.5



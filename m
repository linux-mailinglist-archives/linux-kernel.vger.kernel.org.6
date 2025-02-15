Return-Path: <linux-kernel+bounces-516348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B46A36FF7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE92188F919
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B8B18A6BD;
	Sat, 15 Feb 2025 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="X6el3skq"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0120E1EA7EF;
	Sat, 15 Feb 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739641565; cv=none; b=g5wr0UHyQ7a9MtsIS2yBRSKkLCNSI9kzAmKWetm8Hv6j72MtECQK/QnMLywbEcr6Oag1jHzHzNcI9t/jrWmzt0/r8H9tqi2ltsKEBa74Hz67vaSugVPnnlSCSyE8tutwIrA6g8BE1aRw/1JKiKPeFWOrORgiynkMc9oSR9SZ9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739641565; c=relaxed/simple;
	bh=5GPnXmvBwinxqnLBRuSA6lXDokyiCQ94bv/HSY/D9ns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aoSaieSB27mC6U02E7stxWYmPV9wrZ/AZdhC20uZOFTXY1JOQrgnll6t/mVx9fUWZ0jkOxbBtxC93ft8K7Fg2syEhMiBmBM4BlwzJFHd2gzVMOnOuQ+lXcNfHz6gnS1ND/VrdvYk/q2NITbP4BWwDrZX3MhXCnCPlN3xQjr1lx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=X6el3skq; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739641555; x=1740246355; i=w_armin@gmx.de;
	bh=l6SQS9pEwNkX15KazjrKSTgn4dXapdRQGuzJZjItFr0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X6el3skq3oERka48+a6NJq6v01ett+da9tv5PRYW3VhZi/ow35qSqNmkmacYwv17
	 YfKrVyaHmwGSBPbyNo9sBRJq6rSx/M1b6OJ8Ro0/JaCLsoOFnpXhQmaSL15gzn39j
	 mZ8nZRBKAxpW9etJkD5YOD06k8SYXPU5I0TlpA9vz4bIlQ8St5m3TRkT6xi/v/Asi
	 MQR8SjWFOnulGgF3MvsgbjssZvhBu/vP+siZXC9tnBtheztoLzDW1eQKJDu7/ZC0k
	 5j9cTCErWuBkHshyk6attemuAh8dSJaqNvD0tSUgmg8kxXL2gm3WM+xqUf8nzzVNF
	 6n6UBF4DqH6aeA3Ikw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mel81-1tBOzv3CIH-00iyrB; Sat, 15 Feb 2025 18:45:54 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	basak.sb2006@gmail.com,
	rayanmargham4@gmail.com
Cc: kuurtb@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/3] platform/x86: acer-wmi: Add fan control support
Date: Sat, 15 Feb 2025 18:45:43 +0100
Message-Id: <20250215174544.8790-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250215174544.8790-1-W_Armin@gmx.de>
References: <20250215174544.8790-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HUC9L2P1gvHrek+xSNk/jvEYHJ2TskhSppkZ6TzYOt/4xkxdYkw
 MVUqUzNpRuwEYShho3zl8WacSj51BHr6xGiJSHXxJwj/mc/6k4uOnS9i1eHdhfHvWly5pzB
 GbuTO/Qsq5mm7znAip96F+xVgL+S1nYng/0QXBXm4w3gOSnvt8+nNXvU+c4vM0xN2CMr11O
 NwTpqG41gVMKTRiAPfmlQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RmMGrmcpP4Y=;MDbVxYksi+Fi8d2NM8H5ZAPoJJ4
 Gu2RtaeNfgS6KQtozkK+akVddKQgbly8cDHHe/ziXcmbybJWHyfc2IWeYjxJ4Iu9PgTfpgHRE
 qFrC7Z0GxsPwNCOQZdSfbpDVOEIZa6fLSsn4Pt25qNJbduQcugsjgC6Ph8ndC20xMuepQn5zu
 LGgwmqfmaOhkO7DNHUA2bmFFWCATJ2xQAnELbXTAr3uJ2sAov0DihwV8R6EgOip3J2Ds9ito0
 L12N3T551fUBROom7lAMQFsFkA7YeXicIG0McYDUn35goi0ZyKu1r2bZIxLDhPzvwNK/mtCjE
 K3YML/QdNy+a+LQtvCvohF7HbNhDdV4nFZ9qUwyMgj5VTegXhDXmZwr6/heWJCwMWUkTe97aw
 +v12R7qc9uMqniOq1/Bc/M2kMmSgTYVGS3j3/SGlNj+ZQvRL3YjSkKRnCGGdJNMnp3Xv8a7iG
 Q7HDZ6JGwAsZnNtnugDHBS1hswIct7GUn4cx0Fcf1LRPvD9EuADmxcRNQMIhqXDEA1WZ5RUvw
 nvCPI1ezaBTcbXcEupWbeqdaSxQ9VrBvT5lINiRdRF5NQVhsxgzpox2/Z7DzhqYPMQ+UIaGb2
 FC4N3dqqJOe1rEDU8l4COVfycgcTHvmpJAkiM0ChES0pe+2p+22Opkh4mAvr2ZjhjgM3UgnyP
 uj+oo4ilKvFTTtqNHQlJXa7ynhWdZ0TNUpiW77e3uJ66bk2ayW/fy4Xba63JWNs+lLQWf+aN6
 eZf5WqH2VbbAWMe539ZsUTTWUQZ7Dkc1ER1AxSFhS5z6dSwdPz9UfZuEJymSk6SKYvyn63Q+O
 3vLTjakZaGvMBrOs4rhqFg3VdZtEU6uTYDjlsV+zenRCYsvo/myCEJ/rgU/3/QhUlUwlC105z
 KBJjq+QQRXu/I9jwalmgOxW+iQj5PrlmQNYJgYSCZHzhnYhOWVPdkYWDhfX6TcXnK4nzKjCn0
 oHg1KnEZnfbfLihyaeGlBqfA6oVvksg+V+wt61gOh/kX5aaR8EAv7GzOiS9He6AsfgIrLAmls
 Ia0mYx/aEmGgIbn9MsX6u0k5DAxl0s38DNqb8O+pN1f6xQ/RQ2939ivbbp9iga8/+ihbpWgL6
 DmBJyYpbfpseqVCpJtKlAZOpX1hYo45oHja5Sfuv+bFrXG7BpqrMYub7yI8V0OjVOT2jlwNUw
 zkdAU0Bj9mZrKL0OwJ5Cr2miotPZqhaQU8HDPg1RcYVtFHAIFnrUanYxx0OtqG0J7aoMUMOuG
 ybakzyt6AUudBgP+4zI4yUAnkX7zj3qheKBZ5+/cNxW33reeoTKn6jozU+PDSPILJRotM8BM3
 QNXdTI56+ajK2j1AzKkRjwKJCRiJ2+aZkzaFH8/6x+gKue7QA3R+A7UlpQI4GemvSxz/tJ8ht
 MU3mpQGcwe4x86yc/i23KpG53zjTFK+y8COBM8rCRZjz7PJD/r1NPLPjV1

Add support for controlling the fan speed using the
SetGamingFanSpeed() and GetGamingFanSpeed() WMI methods.

This feature is only enabled if the machine has ACER_CAP_PWM enabled
and depend on ACER_CAP_HWMON for detecting the number of available
fans.

Reviewed-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 221 +++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index f20a882e3650..e5aef09d9d96 100644
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
@@ -69,11 +71,16 @@ MODULE_LICENSE("GPL");
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
@@ -81,6 +88,10 @@ MODULE_LICENSE("GPL");
 #define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
 #define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)

+#define ACER_GAMING_FAN_SPEED_STATUS_MASK GENMASK_ULL(7, 0)
+#define ACER_GAMING_FAN_SPEED_ID_MASK GENMASK_ULL(7, 0)
+#define ACER_GAMING_FAN_SPEED_VALUE_MASK GENMASK_ULL(15, 8)
+
 #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
 #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
@@ -130,6 +141,11 @@ enum acer_wmi_predator_v4_sensor_id {
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
@@ -292,6 +308,7 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_TURBO_FAN		BIT(9)
 #define ACER_CAP_PLATFORM_PROFILE	BIT(10)
 #define ACER_CAP_HWMON			BIT(11)
+#define ACER_CAP_PWM			BIT(12)

 /*
  * Interface type flags
@@ -386,6 +403,7 @@ struct quirk_entry {
 	u8 cpu_fans;
 	u8 gpu_fans;
 	u8 predator_v4;
+	u8 pwm;
 };

 static struct quirk_entry *quirks;
@@ -405,6 +423,9 @@ static void __init set_quirks(void)
 	if (quirks->predator_v4)
 		interface->capability |=3D ACER_CAP_PLATFORM_PROFILE |
 					 ACER_CAP_HWMON;
+
+	if (quirks->pwm)
+		interface->capability |=3D ACER_CAP_PWM;
 }

 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -1650,6 +1671,27 @@ static int WMID_gaming_set_fan_behavior(u16 fan_bit=
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
@@ -1668,6 +1710,55 @@ static void WMID_gaming_set_fan_mode(u8 fan_mode)
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
@@ -2839,6 +2930,16 @@ static const enum acer_wmi_predator_v4_sensor_id ac=
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
@@ -2850,6 +2951,11 @@ static umode_t acer_wmi_hwmon_is_visible(const void=
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
@@ -2857,8 +2963,12 @@ static umode_t acer_wmi_hwmon_is_visible(const void=
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
@@ -2867,8 +2977,10 @@ static int acer_wmi_hwmon_read(struct device *dev, =
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
@@ -2892,6 +3004,106 @@ static int acer_wmi_hwmon_read(struct device *dev,=
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
+		case hwmon_pwm_enable:
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
@@ -2907,11 +3119,16 @@ static const struct hwmon_channel_info *const acer=
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



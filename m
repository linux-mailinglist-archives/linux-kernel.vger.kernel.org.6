Return-Path: <linux-kernel+bounces-548071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6185A53F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4B316F306
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFE97E0FF;
	Thu,  6 Mar 2025 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeV5p/gW"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DB46F31E;
	Thu,  6 Mar 2025 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222700; cv=none; b=qA6nTWY+xk6oQ49xhUXMf29MAcsCLMnlW3bpWDihjPSUEHFwgmZhoLQUUhpIZ0lTojpgC6y0/aJcXRyTMCSED3Gih0V00IU/IQyNHDjpW7FLOwPf04ej736OvTutbmebHx1KUq+R4ui4lVfITHD/fDlesofxXol8YxAR7Wk8Vxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222700; c=relaxed/simple;
	bh=8CGjNcSxJObvcYxkua+oAPqDnLTQSgB1KD0yu/DuXmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SK0CGYYP25JYOfqw5tckXFBnngM+GL4dr3IkSyxq4o6SXbOMdPSZlQQduJSd7qj3SB7zBUjXLHXZwuNWe+gMbCVfnPA8Gb2Y8ye+Lq69P8Y/N5yMb2fi1c0+0C1SoQSj8OFk7q83vcTCjaIf+bHPibZGm0Zu+k9Z1e2LLp/TUwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeV5p/gW; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86715793b1fso31465241.0;
        Wed, 05 Mar 2025 16:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222698; x=1741827498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TP4DuREGD4142MYOEnJT0mlfxYRnERTRzB9IczVkCeY=;
        b=eeV5p/gWa6DqtwD3EVGPyiY3v3RhNlJoDDttYGp0Cs4pdDCrpH0zKdAnDUbaDnjxzd
         XV/giUGXTjSgSu+ryIZTXJ3J//2+O+Uz23LxiFeIvMG/glaTtTLcdauQZW0affavN2YT
         f4JwB2QEae8KCOxOSmTJO1xx0DAOsjV5DcJ/9CORbRSgSrO7vyW174M+K4AkXlYnFypA
         Gyan60JwJZ/Xg46/WHFQUVqMI6EehUeFDdzN2GKJXStegrI9rZjsQ1/l8FrPvoOjlLTn
         kx7ksPI3ozgQYPGNGLXx9hafyJxwXhB3ixbHY3iRSKjw4ztn8jKAAV/n6NJybs0lTopa
         tX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222698; x=1741827498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TP4DuREGD4142MYOEnJT0mlfxYRnERTRzB9IczVkCeY=;
        b=ET96Oo1X0RykgdbwojXdYcniFOKGfXNV/Yddn4+wvHDJRa5R9yvz5CKkvhk519HeCy
         CX1um8lYlFXMizaGftH+fFwt7zGuvysWPE5YK6OArj7I1EQdgsDXp/Uhcpoiunrui/Gg
         spO9vKUIlW/Tr8ETBHS3X8RUyewej0sHxsn8a3mcS2ZkKguKAkqxywV4GFpyr1IKy9jS
         cwN7ZQlmW09MxiXy/+edMzIqnWhbfAUg2MC9m0WY8BDEftRFGYAxScTzgqZaO2udWfnu
         7iPojDxKN/6xZbgOyVG0neXn61CvZMSwGV1JNDrUKnEqGzQwP9c3LkJsxnzZVyQn5Vgh
         oZMA==
X-Forwarded-Encrypted: i=1; AJvYcCUThmdVAAsoYwFeJRY7FcHGfmd0L9TkpX0sStZe11QUVNGigoKTcf26ijRdvpOHPZPToRzJqkmt3How1A==@vger.kernel.org, AJvYcCXaSeac/oS/wHHP8eWrmOJLCXCd8uu0O+fzioEoKI7Pd0cGLuNwVVoyRpzoEQ15UZiWO+LnFyVlMWIoNAYb@vger.kernel.org, AJvYcCXhbeHPV16SLNmBae+UF5k1cG7zUeGav/DYDhN4CgKW/IvgSkyhBlHI2ROkn3ldALC9w7bhgk3U9zLy6Li8VodRp2rZpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5bkCpO6b3m1qwpgFgRiAf2xFAkB1/E2q7cUb9Az2cler3+MV7
	ydOEXDRQpdvcCFxiUH31dCzClVaYIBjpQdbYYjdJWzZyv4M7K4s9dsdZwC7UECo=
X-Gm-Gg: ASbGncs0E9U8pRJ3+qMZjuPNqN+Jlikw5UtnmgYhKM26NpnJN/+X/yixiQbZ3XKI5SJ
	VtIoQDP1tZRV4P3k/iUg/0nhFusescXmkLbla33J+HpqdLF7Hf7lGHoDtXEo+s1uIuHYCvRG7FY
	kTqctuk8dDwgaOV5ZzqawoZVmftV9tiETARiCuzaOlfGAsqOtPuPQ7z1Igv01hfz1JKTOe4e8LQ
	Zd0XZHov8HAADKTounhi0UXkwh/sSjh2GsB87NC//Jkpu0MoOto9oOPJ/lXN7WvWzqBccHIpAAW
	iL+TRu9shheZqkTjj+spyk7rHTNGPTVVC1pVt64pL1uLHQ==
X-Google-Smtp-Source: AGHT+IHMpvP5xzQiR/B8F8nIFw5XFSmZyCfR94swhOUPG9U1WUb4tEFVfYai/V99VH1Kjp0AjlVMXg==
X-Received: by 2002:a05:6102:3c9f:b0:4c1:a2fb:c207 with SMTP id ada2fe7eead31-4c2e293d0aemr3692451137.25.1741222697749;
        Wed, 05 Mar 2025 16:58:17 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bc0065sm25925241.4.2025.03.05.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:58:16 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 05 Mar 2025 19:56:58 -0500
Subject: [PATCH v3 07/10] platform/x86: alienware-wmi-wmax: Add HWMON
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-hwm-v3-7-395e7a1407e2@gmail.com>
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
In-Reply-To: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
X-Mailer: b4 0.14.2

All models with the "AWCC" WMAX device support monitoring fan speed and
temperature sensors. Expose this feature through the HWMON interface.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/Kconfig              |   1 +
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 431 +++++++++++++++++++++++++
 2 files changed, 432 insertions(+)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index f8a0dffcaab7c3b423472c5b9093011334a698c8..85a57c01aaada5d899cd8252e77ed6043da5cbdf 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -43,6 +43,7 @@ config ALIENWARE_WMI_WMAX
 	bool "Alienware WMAX WMI device driver"
 	default y
 	depends on ALIENWARE_WMI
+	depends on HWMON
 	select ACPI_PLATFORM_PROFILE
 	help
 	 Alienware WMI driver with AlienFX LED, HDMI, amplifier, deep sleep and
diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 71fc17e8d103146b8edf53a552ae5ba64414e873..20cf3371ee3c0e1ea038b3ca517e831f3b30dc29 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -9,10 +9,13 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/bitfield.h>
+#include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/dmi.h>
+#include <linux/hwmon.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_profile.h>
+#include <linux/units.h>
 #include <linux/wmi.h>
 #include "alienware-wmi.h"
 
@@ -25,6 +28,7 @@
 #define WMAX_METHOD_BRIGHTNESS			0x3
 #define WMAX_METHOD_ZONE_CONTROL		0x4
 
+#define AWCC_METHOD_GET_FAN_SENSORS		0x13
 #define AWCC_METHOD_THERMAL_INFORMATION		0x14
 #define AWCC_METHOD_THERMAL_CONTROL		0x15
 #define AWCC_METHOD_GAME_SHIFT_STATUS		0x25
@@ -39,6 +43,10 @@
 /* Arbitrary limit based on supported models */
 #define AWCC_MAX_RES_COUNT			16
 
+static bool force_hwmon;
+module_param_unsafe(force_hwmon, bool, 0);
+MODULE_PARM_DESC(force_hwmon, "Force probing for HWMON support without checking if the WMI backend is available");
+
 static bool force_platform_profile;
 module_param_unsafe(force_platform_profile, bool, 0);
 MODULE_PARM_DESC(force_platform_profile, "Forces auto-detecting thermal profiles without checking if WMI thermal backend is available");
@@ -48,16 +56,19 @@ module_param_unsafe(force_gmode, bool, 0);
 MODULE_PARM_DESC(force_gmode, "Forces G-Mode when performance profile is selected");
 
 struct awcc_quirks {
+	bool hwmon;
 	bool pprof;
 	bool gmode;
 };
 
 static struct awcc_quirks g_series_quirks = {
+	.hwmon = true,
 	.pprof = true,
 	.gmode = true,
 };
 
 static struct awcc_quirks generic_quirks = {
+	.hwmon = true,
 	.pprof = true,
 	.gmode = false,
 };
@@ -155,9 +166,18 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
 	},
 };
 
+enum AWCC_GET_FAN_SENSORS_OPERATIONS {
+	AWCC_OP_GET_TOTAL_FAN_TEMPS		= 0x01,
+	AWCC_OP_GET_FAN_TEMP_ID			= 0x02,
+};
+
 enum AWCC_THERMAL_INFORMATION_OPERATIONS {
 	AWCC_OP_GET_SYSTEM_DESCRIPTION		= 0x02,
 	AWCC_OP_GET_RESOURCE_ID			= 0x03,
+	AWCC_OP_GET_TEMPERATURE			= 0x04,
+	AWCC_OP_GET_FAN_RPM			= 0x05,
+	AWCC_OP_GET_FAN_MIN_RPM			= 0x08,
+	AWCC_OP_GET_FAN_MAX_RPM			= 0x09,
 	AWCC_OP_GET_CURRENT_PROFILE		= 0x0B,
 };
 
@@ -180,6 +200,12 @@ enum AWCC_SPECIAL_THERMAL_CODES {
 	AWCC_SPECIAL_PROFILE_GMODE		= 0xAB,
 };
 
+enum AWCC_TEMP_SENSOR_TYPES {
+	AWCC_TEMP_SENSOR_CPU			= 0x01,
+	AWCC_TEMP_SENSOR_GPU			= 0x06,
+	AWCC_TEMP_SENSOR_LAST
+};
+
 enum awcc_thermal_profile {
 	AWCC_PROFILE_USTT_BALANCED,
 	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
@@ -216,6 +242,15 @@ struct wmax_u32_args {
 	u8 arg3;
 };
 
+struct awcc_fan_data {
+	unsigned long *related_temps;
+	unsigned long *auto_channels_temp;
+	u32 total_temps;
+	u32 min_rpm;
+	u32 max_rpm;
+	u8 id;
+};
+
 struct awcc_priv {
 	struct wmi_device *wdev;
 	union {
@@ -231,6 +266,11 @@ struct awcc_priv {
 
 	struct device *ppdev;
 	u8 supported_profiles[PLATFORM_PROFILE_LAST];
+
+	struct device *hwdev;
+	struct awcc_fan_data **fan_data;
+	unsigned int temp_sensors_size;
+	unsigned long *temp_sensors;
 };
 
 static const enum platform_profile_option awcc_mode_to_platform_profile[AWCC_PROFILE_LAST] = {
@@ -495,6 +535,19 @@ static int __awcc_wmi_command(struct wmi_device *wdev, u32 method_id,
 	return 0;
 }
 
+static inline int awcc_get_fan_sensors(struct wmi_device *wdev, u8 operation,
+				       u8 fan_id, u8 index, u32 *out)
+{
+	struct wmax_u32_args args = {
+		.operation = operation,
+		.arg1 = fan_id,
+		.arg2 = index,
+		.arg3 = 0,
+	};
+
+	return __awcc_wmi_command(wdev, AWCC_METHOD_GET_FAN_SENSORS, &args, out);
+}
+
 static inline int awcc_thermal_information(struct wmi_device *wdev, u8 operation,
 					   u8 arg, u32 *out)
 {
@@ -552,6 +605,32 @@ static inline int awcc_op_get_resource_id(struct wmi_device *wdev, u8 index, u32
 	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
 }
 
+static inline int awcc_op_get_fan_rpm(struct wmi_device *wdev, u8 fan_id, u32 *out)
+{
+	struct wmax_u32_args args = {
+		.operation = AWCC_OP_GET_FAN_RPM,
+		.arg1 = fan_id,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+
+
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
+}
+
+static inline int awcc_op_get_temperature(struct wmi_device *wdev, u8 temp_id, u32 *out)
+{
+	struct wmax_u32_args args = {
+		.operation = AWCC_OP_GET_TEMPERATURE,
+		.arg1 = temp_id,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
+
+
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
+}
+
 static inline int awcc_op_get_current_profile(struct wmi_device *wdev, u32 *out)
 {
 	struct wmax_u32_args args = {
@@ -599,6 +678,345 @@ static int awcc_profile_id_to_pprof(u32 id, enum platform_profile_option *profil
 	return 0;
 }
 
+/*
+ * HWMON
+ *  - Provides temperature and fan speed monitoring as well as manual fan
+ *    control
+ */
+static umode_t awcc_hwmon_is_visible(const void *drvdata, enum hwmon_sensor_types type,
+				     u32 attr, int channel)
+{
+	const struct awcc_priv *priv = drvdata;
+	unsigned int temp_count;
+
+	switch (type) {
+	case hwmon_temp:
+		temp_count = bitmap_weight(priv->temp_sensors, priv->temp_sensors_size);
+
+		return channel < temp_count ? 0444 : 0;
+	case hwmon_fan:
+		return channel < priv->fan_count ? 0444 : 0;
+	case hwmon_pwm:
+		if (channel >= priv->fan_count)
+			return 0;
+
+		switch (attr) {
+		case hwmon_pwm_enable:
+			return 0644;
+		case hwmon_pwm_auto_channels_temp:
+			return 0444;
+		default:
+			return 0;
+		}
+	default:
+		return 0;
+	}
+}
+
+static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	struct awcc_fan_data *fan;
+	u32 state;
+	int ret;
+	u8 temp;
+
+	switch (type) {
+	case hwmon_temp:
+		temp = find_nth_bit(priv->temp_sensors, priv->temp_sensors_size, channel);
+
+		switch (attr) {
+		case hwmon_temp_input:
+			ret = awcc_op_get_temperature(priv->wdev, temp, &state);
+			if (ret)
+				return ret;
+
+			*val = state * MILLIDEGREE_PER_DEGREE;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+		break;
+	case hwmon_fan:
+		fan = priv->fan_data[channel];
+
+		switch (attr) {
+		case hwmon_fan_input:
+			ret = awcc_op_get_fan_rpm(priv->wdev, fan->id, &state);
+			if (ret)
+				return ret;
+
+			*val = state;
+			break;
+		case hwmon_fan_min:
+			*val = fan->min_rpm;
+			break;
+		case hwmon_fan_max:
+			*val = fan->max_rpm;
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+		break;
+	case hwmon_pwm:
+		fan = priv->fan_data[channel];
+
+		switch (attr) {
+		case hwmon_pwm_auto_channels_temp:
+			bitmap_copy(val, fan->auto_channels_temp, BITS_PER_LONG);
+			break;
+		default:
+			return -EOPNOTSUPP;
+		}
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int awcc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types type,
+				  u32 attr, int channel, const char **str)
+{
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	struct awcc_fan_data *fan;
+	u8 temp;
+
+	switch (type) {
+	case hwmon_temp:
+		temp = find_nth_bit(priv->temp_sensors, priv->temp_sensors_size, channel);
+
+		switch (temp) {
+		case AWCC_TEMP_SENSOR_CPU:
+			*str = "CPU";
+			break;
+		case AWCC_TEMP_SENSOR_GPU:
+			*str = "GPU";
+			break;
+		default:
+			*str = "Unknown";
+			break;
+		}
+
+		break;
+	case hwmon_fan:
+		fan = priv->fan_data[channel];
+
+		switch (fan->total_temps) {
+		case 0:
+			*str = "Independent Fan";
+			break;
+		case 1:
+			temp = find_first_bit(fan->related_temps, priv->temp_sensors_size);
+
+			switch (temp) {
+			case AWCC_TEMP_SENSOR_CPU:
+				*str = "Processor Fan";
+				break;
+			case AWCC_TEMP_SENSOR_GPU:
+				*str = "Video Fan";
+				break;
+			default:
+				*str = "Unknown Fan";
+				break;
+			}
+
+			break;
+		default:
+			*str = "Shared Fan";
+			break;
+		}
+
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops awcc_hwmon_ops = {
+	.is_visible = awcc_hwmon_is_visible,
+	.read = awcc_hwmon_read,
+	.read_string = awcc_hwmon_read_string,
+};
+
+static const struct hwmon_channel_info * const awcc_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_LABEL | HWMON_T_INPUT,
+			   HWMON_T_LABEL | HWMON_T_INPUT,
+			   HWMON_T_LABEL | HWMON_T_INPUT,
+			   HWMON_T_LABEL | HWMON_T_INPUT,
+			   HWMON_T_LABEL | HWMON_T_INPUT,
+			   HWMON_T_LABEL | HWMON_T_INPUT
+			   ),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
+			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
+			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
+			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
+			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX,
+			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
+			   ),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP
+			   ),
+	NULL
+};
+
+static const struct hwmon_chip_info awcc_hwmon_chip_info = {
+	.ops = &awcc_hwmon_ops,
+	.info = awcc_hwmon_info,
+};
+
+static int awcc_hwmon_temps_init(struct wmi_device *wdev)
+{
+	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
+	unsigned long temp_sensors[BITS_TO_LONGS(U8_MAX)];
+	unsigned int i, max_sensor_id = 0;
+	int ret;
+	u32 id;
+
+	for (i = 0; i < priv->temp_count; i++) {
+		/*
+		 * Temperature sensors IDs are listed after the fan IDs at
+		 * offset `fan_count`
+		 */
+		ret = awcc_op_get_resource_id(wdev, i + priv->fan_count, &id);
+		if (ret)
+			return ret;
+
+		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
+		if (id > max_sensor_id)
+			max_sensor_id = id;
+
+		__set_bit(id, temp_sensors);
+	}
+
+	/*
+	 * We prefer to allocate the bitmap dynamically because usually temp IDs
+	 * are small (< 0x30) and only one UL is needed to store it, but there
+	 * may be unknown devices that break this rule
+	 */
+	priv->temp_sensors_size = max_sensor_id + 1;
+	priv->temp_sensors = devm_bitmap_zalloc(&wdev->dev, priv->temp_sensors_size,
+						GFP_KERNEL);
+	if (!priv->temp_sensors)
+		return -ENOMEM;
+
+	bitmap_copy(priv->temp_sensors, temp_sensors, priv->temp_sensors_size);
+
+	return 0;
+}
+
+static int awcc_hwmon_fans_init(struct wmi_device *wdev)
+{
+	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
+	u32 id, min_rpm, max_rpm, temp_count, temp_id;
+	unsigned long gather[BITS_TO_LONGS(U8_MAX)];
+	struct awcc_fan_data *fan_data;
+	unsigned int i, j;
+	int ret;
+
+	for (i = 0; i < priv->fan_count; i++) {
+		fan_data = devm_kzalloc(&wdev->dev, sizeof(*fan_data), GFP_KERNEL);
+		if (!fan_data)
+			return -ENOMEM;
+
+		fan_data->related_temps = devm_bitmap_zalloc(&wdev->dev,
+							     priv->temp_sensors_size,
+							     GFP_KERNEL);
+		if (!priv->temp_sensors)
+			return -ENOMEM;
+
+		fan_data->auto_channels_temp = devm_bitmap_zalloc(&wdev->dev,
+								  priv->temp_count,
+								  GFP_KERNEL);
+		if (!priv->temp_sensors)
+			return -ENOMEM;
+
+		/*
+		 * Fan IDs are listed first at offset 0
+		 */
+		ret = awcc_op_get_resource_id(wdev, i, &id);
+		if (ret)
+			return ret;
+		id = FIELD_GET(AWCC_RESOURCE_ID_MASK, id);
+
+		ret = awcc_thermal_information(wdev, AWCC_OP_GET_FAN_MIN_RPM, id,
+					       &min_rpm);
+		if (ret)
+			return ret;
+
+		ret = awcc_thermal_information(wdev, AWCC_OP_GET_FAN_MAX_RPM, id,
+					       &max_rpm);
+		if (ret)
+			return ret;
+
+		ret = awcc_get_fan_sensors(wdev, AWCC_OP_GET_TOTAL_FAN_TEMPS, id,
+					   0, &temp_count);
+		if (ret)
+			return ret;
+
+		for (j = 0; j < temp_count; j++) {
+			ret = awcc_get_fan_sensors(wdev, AWCC_OP_GET_FAN_TEMP_ID,
+						   id, j, &temp_id);
+			if (ret)
+				break;
+
+			temp_id = FIELD_GET(AWCC_RESOURCE_ID_MASK, temp_id);
+			if (temp_id < priv->temp_sensors_size)
+				__set_bit(temp_id, fan_data->related_temps);
+		}
+
+		fan_data->id = id;
+		fan_data->min_rpm = min_rpm;
+		fan_data->max_rpm = max_rpm;
+		fan_data->total_temps = bitmap_weight(fan_data->related_temps,
+						      priv->temp_sensors_size);
+		bitmap_gather(gather, fan_data->related_temps, priv->temp_sensors,
+			      priv->temp_sensors_size);
+		bitmap_copy(fan_data->auto_channels_temp, gather, priv->temp_count);
+		priv->fan_data[i] = fan_data;
+	}
+
+	return 0;
+}
+
+static int awcc_hwmon_init(struct wmi_device *wdev)
+{
+	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
+	int ret;
+
+	priv->fan_data = devm_kcalloc(&wdev->dev, priv->fan_count,
+				      sizeof(*priv->fan_data), GFP_KERNEL);
+	if (!priv->fan_data)
+		return -ENOMEM;
+
+	ret = awcc_hwmon_temps_init(wdev);
+	if (ret)
+		return ret;
+
+	ret = awcc_hwmon_fans_init(wdev);
+	if (ret)
+		return ret;
+
+	priv->hwdev = devm_hwmon_device_register_with_info(&wdev->dev, "alienware_wmi", priv,
+							   &awcc_hwmon_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(priv->hwdev);
+}
+
 /*
  * Thermal Profile control
  *  - Provides thermal profile control through the Platform Profile API
@@ -753,6 +1171,12 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
 	priv->wdev = wdev;
 	dev_set_drvdata(&wdev->dev, priv);
 
+	if (awcc->hwmon) {
+		ret = awcc_hwmon_init(wdev);
+		if (ret)
+			return ret;
+	}
+
 	if (awcc->pprof) {
 		ret = awcc_platform_profile_init(wdev);
 		if (ret)
@@ -833,6 +1257,13 @@ int __init alienware_wmax_wmi_init(void)
 	if (id)
 		awcc = id->driver_data;
 
+	if (force_hwmon) {
+		if (!awcc)
+			awcc = &empty_quirks;
+
+		awcc->hwmon = true;
+	}
+
 	if (force_platform_profile) {
 		if (!awcc)
 			awcc = &empty_quirks;

-- 
2.48.1



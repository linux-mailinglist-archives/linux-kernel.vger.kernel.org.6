Return-Path: <linux-kernel+bounces-559701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A65F2A5F858
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F4B319C4BAA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCA1267B6F;
	Thu, 13 Mar 2025 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EViHaYxy"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F912268FFD;
	Thu, 13 Mar 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876231; cv=none; b=FVgOfGRDkejBUicwoKL4jToLzbfO4vlulQrxvxOgW8M3HVNxgTA+EeGfNOEF+an/a7b4q2pnNylvHagzMhxQ4bRsOwDYbL6y39jfToSeH1VsqrTwedDKHOIRcpWltAlFAnV+BeLi8T1G2Zmb8oPV07KqFumkNSw7uNjD3YPmHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876231; c=relaxed/simple;
	bh=xJNuBJ8Lq+cf0vQCIGGN/Evrgk1LJ5JESRbRX7CZAU0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sM5C5qcOVCEl8mjIXffAdT3utdk2dPL1OTawI7nehsx2R9T84WkKVAPns3tLo0J0y7DP+RA+24CqL3t73Wh7iyLyzdAk8B7E57Q9S87bvwuPIr2KcbqWAZ91Wkq9BqpMCHNlNlDvGkL/wZ+7SQ+QXJW6oPsddsCSFA9FAi0yHg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EViHaYxy; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6f74b78df93so10723287b3.0;
        Thu, 13 Mar 2025 07:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876228; x=1742481028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovIBwyrFCxunHqofwj+leY0pxsU/rdE7vlF0h9oNJ9g=;
        b=EViHaYxykOf3SpfNoN/51ITgQHempFYK7tV01TtW43TLi4gAs50JxXbnz2QQVmXCQy
         QWZzX0RFkdKFjSogiRfbaemcv050QtaruRyo9JmroiFKYbOe+dbv2OqKk6yU/PU6SpUd
         RfqYMUgFsv/sZS7VRmjDGa4eYJDNx50A9JnDSAVuaiO71uTrpv4jJtGcXaOKxkCQn12B
         6oHt5MvL1Nq//YRVIEDI3c05jiSor78iBqt0fnowD3Po76Pa9pSJx5THSCLM4OhojY/a
         IeWIXUlxRj9g/uxxqux0VVnfEKJmkxZa3L7aPE1N3pNlVxDDupQoaKuhe7bmNR8Hx5Q9
         xtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876228; x=1742481028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovIBwyrFCxunHqofwj+leY0pxsU/rdE7vlF0h9oNJ9g=;
        b=S1NFSaJn1QHvEjC7r+BQFlGFCjomrEdqe5f+Gyhi+qG/m81uGs+VuYZclHx7e+2Gu3
         mlA/6Zlk6anXzLZkk6XBsMK4H3lDWSZvhdBNj5cV3LSqwH/ChmtzwhtqX/7gE+Zq+uuQ
         P5Bi7yEkwsaFCfsIRAmO2tldhpOR5C85ER11zYWs1+zc+05rzCcvjF1HC/5IO9VnH27f
         C3NQ0E+ERVB4K+0pTjIg/JxJIu1PRux+pMf+Q4eKJjmSWBn70lrliC4+SOQDCdNXb+aN
         W+HZiufTvf73KSXS+yQJYA1cIo2ljGMvkhInp0O3C6jeYe7g4D2D95JtniGl8oJ5PCu3
         n0DA==
X-Forwarded-Encrypted: i=1; AJvYcCUHlLb1QiL27HMRcgIsLHLz+Z/SskZAJtNtnxysuF4y98ypaSqLYXNAbfvkYFSleYZ8aZXpK+DhCUnm8g==@vger.kernel.org, AJvYcCUj/1VnqoXsKc35E3BhAqocwkVRrT0DCcADm7PV0YXb4OBuQWukBDXR67o6OGC/HC/Mq5CBmX6+JxSCeghAmg86PSvF6g==@vger.kernel.org, AJvYcCWGVNbuy6ndo23zBWqZwtEQ2ooLMA/doiFPFyP/x50leXxcA5tu4XoJixGouM2YtF8urhxO57JCOZyOFh7F@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3sAVigEE0LFWHURHHWOWGhqvOfyjS/Rlyv/tKCAi8OlQhhIKT
	GIQFcllwPHlYFgUWBj/Z1u+6nJJTraUBQUGCh9gResWVGQ2wxqiNuIAcTzEk
X-Gm-Gg: ASbGncsvaqikKx8GRBRZjY68CFs5vkXwpWJ4xAoM8thGQOLHTgOfsO3a864an+TzN71
	rA46f9Oy2TNQZKzCU3Op00D2V4NukHDuSLFbtj0c6/4vp3Y/5DXaF18uM6zZvFA87Hp4FH+1ZyF
	+ZvYUTn8PId856vsesSg1cLgjWxpaB75ieCOB8mAF7XIHiwI5hUY5QoAqdMxsrVfAi0zJ5+m53N
	ZEOKPk/VMBi6TtdrAtOKU4SUDItwC+CECxuSXOFxeC8SOd3P1o2JsUcrcF8PNvoT6O0bUbN2aJf
	swBnnfQBsnuBo/kKCjSf19IBAC1qRhImHZs/ltiQGQjPmQ==
X-Google-Smtp-Source: AGHT+IFHcibNeL97nDuwMxCGYqtgpUyeE9vE4YjaeOwxFsm7FS3wDbWO/gktO9Xm/Ua/w9JJTld2TQ==
X-Received: by 2002:a05:6902:cc7:b0:e60:8d10:8698 with SMTP id 3f1490d57ef6-e635c1906f6mr33296569276.27.1741876227532;
        Thu, 13 Mar 2025 07:30:27 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e56718d0sm338938276.50.2025.03.13.07.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:26 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 13 Mar 2025 09:30:02 -0500
Subject: [PATCH v6 07/12] platform/x86: alienware-wmi-wmax: Add HWMON
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hwm-v6-7-17b57f787d77@gmail.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
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
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/Kconfig              |   1 +
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 396 +++++++++++++++++++++++++
 2 files changed, 397 insertions(+)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index f8a0dffcaab7c3b423472c5b9093011334a698c8..f7107b0c55f27c9be70f50b36dd2e7bab42a6960 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -22,6 +22,7 @@ config ALIENWARE_WMI
 	depends on DMI
 	depends on LEDS_CLASS
 	depends on NEW_LEDS
+	depends on HWMON
 	help
 	 This is a driver for controlling Alienware WMI driven features.
 
diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 3b37e4456482bc284b8e867c1c5b6255fc6c8ef2..0c30ffb6091a15d81f4dc959dfd28417249d3dda 100644
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
@@ -38,6 +42,12 @@
 
 /* Arbitrary limit based on supported models */
 #define AWCC_MAX_RES_COUNT			16
+#define AWCC_ID_BITMAP_SIZE			(U8_MAX + 1)
+#define AWCC_ID_BITMAP_LONGS			BITS_TO_LONGS(AWCC_ID_BITMAP_SIZE)
+
+static bool force_hwmon;
+module_param_unsafe(force_hwmon, bool, 0);
+MODULE_PARM_DESC(force_hwmon, "Force probing for HWMON support without checking if the WMI backend is available");
 
 static bool force_platform_profile;
 module_param_unsafe(force_platform_profile, bool, 0);
@@ -48,16 +58,19 @@ module_param_unsafe(force_gmode, bool, 0);
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
@@ -155,9 +168,18 @@ static const struct dmi_system_id awcc_dmi_table[] __initconst = {
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
 
@@ -180,6 +202,11 @@ enum AWCC_SPECIAL_THERMAL_CODES {
 	AWCC_SPECIAL_PROFILE_GMODE		= 0xAB,
 };
 
+enum AWCC_TEMP_SENSOR_TYPES {
+	AWCC_TEMP_SENSOR_CPU			= 0x01,
+	AWCC_TEMP_SENSOR_GPU			= 0x06,
+};
+
 enum awcc_thermal_profile {
 	AWCC_PROFILE_USTT_BALANCED,
 	AWCC_PROFILE_USTT_BALANCED_PERFORMANCE,
@@ -216,6 +243,14 @@ struct wmax_u32_args {
 	u8 arg3;
 };
 
+struct awcc_fan_data {
+	unsigned long auto_channels_temp;
+	const char *label;
+	u32 min_rpm;
+	u32 max_rpm;
+	u8 id;
+};
+
 struct awcc_priv {
 	struct wmi_device *wdev;
 	union {
@@ -231,6 +266,10 @@ struct awcc_priv {
 
 	struct device *ppdev;
 	u8 supported_profiles[PLATFORM_PROFILE_LAST];
+
+	struct device *hwdev;
+	struct awcc_fan_data **fan_data;
+	unsigned long temp_sensors[AWCC_ID_BITMAP_LONGS];
 };
 
 static const enum platform_profile_option awcc_mode_to_platform_profile[AWCC_PROFILE_LAST] = {
@@ -495,6 +534,19 @@ static int __awcc_wmi_command(struct wmi_device *wdev, u32 method_id,
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
@@ -552,6 +604,30 @@ static inline int awcc_op_get_resource_id(struct wmi_device *wdev, u8 index, u32
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
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
+}
+
 static inline int awcc_op_get_current_profile(struct wmi_device *wdev, u32 *out)
 {
 	struct wmax_u32_args args = {
@@ -577,6 +653,313 @@ static inline int awcc_op_activate_profile(struct wmi_device *wdev, u8 profile)
 	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &out);
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
+		temp_count = bitmap_weight(priv->temp_sensors, AWCC_ID_BITMAP_SIZE);
+
+		return channel < temp_count ? 0444 : 0;
+	case hwmon_fan:
+		return channel < priv->fan_count ? 0444 : 0;
+	case hwmon_pwm:
+		return channel < priv->fan_count ? 0444 : 0;
+	default:
+		return 0;
+	}
+}
+
+static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			   u32 attr, int channel, long *val)
+{
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	const struct awcc_fan_data *fan;
+	u32 state;
+	int ret;
+	u8 temp;
+
+	switch (type) {
+	case hwmon_temp:
+		temp = find_nth_bit(priv->temp_sensors, AWCC_ID_BITMAP_SIZE, channel);
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
+			*val = fan->auto_channels_temp;
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
+	u8 temp;
+
+	switch (type) {
+	case hwmon_temp:
+		temp = find_nth_bit(priv->temp_sensors, AWCC_ID_BITMAP_SIZE, channel);
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
+		*str = priv->fan_data[channel]->label;
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
+	unsigned int i;
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
+		__set_bit(FIELD_GET(AWCC_RESOURCE_ID_MASK, id), priv->temp_sensors);
+	}
+
+	return 0;
+}
+
+static char *awcc_get_fan_label(struct device *dev, u32 temp_count, u8 temp_id)
+{
+	char *label;
+
+	switch (temp_count) {
+	case 0:
+		label = "Independent Fan";
+		break;
+	case 1:
+		switch (temp_id) {
+		case AWCC_TEMP_SENSOR_CPU:
+			label = "Processor Fan";
+			break;
+		case AWCC_TEMP_SENSOR_GPU:
+			label = "Video Fan";
+			break;
+		default:
+			label = "Unknown Fan";
+			break;
+		}
+
+		break;
+	default:
+		label = "Shared Fan";
+		break;
+	}
+
+	return label;
+}
+
+static int awcc_hwmon_fans_init(struct wmi_device *wdev)
+{
+	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
+	u32 id, min_rpm, max_rpm, temp_count, temp_id;
+	unsigned long fan_temps[AWCC_ID_BITMAP_LONGS];
+	unsigned long gather[AWCC_ID_BITMAP_LONGS];
+	struct awcc_fan_data *fan_data;
+	unsigned int i, j;
+	char *label;
+	int ret;
+
+	for (i = 0; i < priv->fan_count; i++) {
+		fan_data = devm_kzalloc(&wdev->dev, sizeof(*fan_data), GFP_KERNEL);
+		if (!fan_data)
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
+			__set_bit(temp_id, fan_temps);
+		}
+
+		label = awcc_get_fan_label(&wdev->dev, temp_count, temp_id);
+		if (!label)
+			return -ENOMEM;
+
+		fan_data->id = id;
+		fan_data->min_rpm = min_rpm;
+		fan_data->max_rpm = max_rpm;
+		fan_data->label = label;
+		bitmap_gather(gather, fan_temps, priv->temp_sensors, AWCC_ID_BITMAP_SIZE);
+		bitmap_copy(&fan_data->auto_channels_temp, gather, BITS_PER_LONG);
+		priv->fan_data[i] = fan_data;
+
+		bitmap_zero(fan_temps, AWCC_ID_BITMAP_SIZE);
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
@@ -744,6 +1127,12 @@ static int alienware_awcc_setup(struct wmi_device *wdev)
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
@@ -824,6 +1213,13 @@ int __init alienware_wmax_wmi_init(void)
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



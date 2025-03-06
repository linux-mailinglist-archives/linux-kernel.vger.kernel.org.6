Return-Path: <linux-kernel+bounces-548072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332E0A53F80
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F8E1891C2A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57AA16088F;
	Thu,  6 Mar 2025 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp0pU9z/"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABA6155744;
	Thu,  6 Mar 2025 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222703; cv=none; b=a2IoQrJZE6sMJbspwmXO5mWlrXW8pFLLRO5J1mH7/y0vkbGY5Ax0GRtgV+A/usfazuTHO7w0CfA5IDU4zyVoA6Gu5v//2iD4hYiGD0gEfGjbeO1j9CAuBBxjuJAG9jeKcQFK4OZO2TuWvJO49qLnFZsqDhVypuZACpYxEEY9bII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222703; c=relaxed/simple;
	bh=s5x4lOTGnw5Q8PcWF713UcfigAEI1V9LQ9nULH9mSyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hm7//RQJYqLLGqxYwVhPKL0yzWSpcvmMUN3daRr6c7Q7gQYv4byIXP7PUpirQ0Fr43FIwV+ow0hDTpFiYHuUZHqj3OuULxMAmo8NTdvDVZAjxAVtimuZTTh6Iwdm88anYIE+5a+UqkFCByCgRmRcBd1tBKY68s6PRbfBxBeRrMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp0pU9z/; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86b3bd4d0faso27488241.3;
        Wed, 05 Mar 2025 16:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741222700; x=1741827500; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8D9ztAwLAQxr3py/ju2NfZMZuFaZlpOJBPfxMkVBJQY=;
        b=Rp0pU9z/VUpm8Ug/tGS4mirGugbGipsDzvBWNaYUwDeMCPd920CVa+HBliJnEE52ig
         TqwPHCplRijnwmMAKF1REL6VMn7HHpHpI/Y6eksn2qOq1qahQxxXylpl6KkaY+/6mOru
         La3Hw7K7tuUIccQJKWSHGo3MJgfwOEr/pejWAu2N9XRB8BiX3mK/ygW6VeMYD9X4tzV0
         vIDnQUK3KUTHKmxnPrZ31mi9N8Jhc6AgFX/dV0ASnH+nsSj5yGZ9VGJ7Y9PFESiv1iLU
         tEbGLpbijEIIWn9apxiGu8j5aa5ncvGYaZH3yA8Eprhsyhg7yYXaQXXJkj+wORSi9+78
         G4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741222700; x=1741827500;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8D9ztAwLAQxr3py/ju2NfZMZuFaZlpOJBPfxMkVBJQY=;
        b=BBbsC9faxYaJk1qai+5LvkTFy7piXye+p7dCWTZx1nJFZ6vFgpjFsDmQWm1l7gTsdz
         NEALQE2oYx2mb9eDh2Qg8fTPhMEyQuOvkesDgaq9UpMN2fL9tA1B6tqxIt+NRJG7R0YO
         U4cYuDKyfq1JNU2mVtxDkaGCJ23Vb3SgzngEWbhiZ0Urbq2MUmf0ghaI9stsSiRepbKM
         sXee6umrvQmdGP8frDYBqt1Hv8/MpdcOuWzMO+REsWkjNQjmY0G7t4JFwWITC2rkpvwl
         iPybIACpuPkZGCm7rmipK1VjnfTWY98xu1wbDlTGri3nUGap3gVy869VwxoGnbU4fsiQ
         XM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoCaIm56umtp+aaaX/bm+YNwaMF4Kcx25UAWxWnbyigEV3o/xP9WzRvv8p3w0B96qPNJpnt1emi8uAhFja@vger.kernel.org, AJvYcCXgbUnAgFCIxCossWC0SbPrSUXyw5xle1/gDydogqWty+s8IoOwA77p5Y00pO1GV8X3qDhC/Pl0gPeWY1qGwLY30ww15g==@vger.kernel.org, AJvYcCXqeEV/nR5Mk89fvtCGEbAFjr/GW5u3N2YgAD2AVlhRPbFxiDOqzML7VT/ZChXes4fe4YtFpZcIhkBlog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1GK+0Ou9+Wr0tTAyDw0sI9hg+rqU53eLRHyMekqy6sdMRaYv
	c8rB0wep15TSfIkGrOzZtgISHxnO+YFj8salra/X9xdV9lIiww+I
X-Gm-Gg: ASbGncvE3oOISzPpojYzX49z0sx2nqOS/8lW7r0Nnmmg73zm0e6Q2NJh1Go5rTNK4s6
	1wOUg/eP2y6wbYnurnt1VlP72Q/rP5hglQ9i4IDYOeroMcR03xxHqt+e3+9+8qZYF1qts3A1q5E
	qQvk6TpalrjfPl7rldsGu48vmONPIUT2ZvOuIVrv5M5GG8RmAPsZwhtAfM0RYx9eM38FeBDPtKq
	4f1rpHXNzwe2T8zwDUd2hxG5HYWz/NrZeg5WaLFZWsEglIoydSxUtZkx9MkuR5gJYHf0lDZXijI
	QXiuomCK+ZGx9EXPE2jkHAwwuBxtwBpFzeRF9ioVW09KFw==
X-Google-Smtp-Source: AGHT+IHPMKJbIvbaBv2eaZtZLIjqgplQijv6/Jo8dNH7iTEbbrnL/fQ2vOAluuH2DiD0ddlBMnrVXw==
X-Received: by 2002:a05:6102:440e:b0:4c1:a66f:a468 with SMTP id ada2fe7eead31-4c2e299f78amr3548363137.22.1741222700519;
        Wed, 05 Mar 2025 16:58:20 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33bc0065sm25925241.4.2025.03.05.16.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 16:58:19 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 05 Mar 2025 19:56:59 -0500
Subject: [PATCH v3 08/10] platform/x86: alienware-wmi-wmax: Add support for
 manual fan control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-hwm-v3-8-395e7a1407e2@gmail.com>
References: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
In-Reply-To: <20250305-hwm-v3-0-395e7a1407e2@gmail.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Kurt Borja <kuurtb@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
X-Mailer: b4 0.14.2

All models with the "AWCC" WMAX device support a way of manually
controlling fans.

The PWM duty cycle of a fan can't be controlled directly. Instead the
AWCC interface let's us tune a PWM `boost` value, which has the
following empirically discovered, aproximate behavior over the PWM
value:

	pwm = pwm_base + (pwm_boost / 255) * (pwm_max - pwm_base)

Where the pwm_base is the locked PWM value controlled by the FW and
pwm_boost is a value between 0 and 255.

Expose this pwm_boost knob as a custom HWMON attribute.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 223 ++++++++++++++++++++++++-
 1 file changed, 220 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 20cf3371ee3c0e1ea038b3ca517e831f3b30dc29..de4e8f177aadc9552b05cc732e41ee458b761143 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -13,8 +13,11 @@
 #include <linux/bits.h>
 #include <linux/dmi.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/minmax.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_profile.h>
+#include <linux/pm.h>
 #include <linux/units.h>
 #include <linux/wmi.h>
 #include "alienware-wmi.h"
@@ -179,10 +182,12 @@ enum AWCC_THERMAL_INFORMATION_OPERATIONS {
 	AWCC_OP_GET_FAN_MIN_RPM			= 0x08,
 	AWCC_OP_GET_FAN_MAX_RPM			= 0x09,
 	AWCC_OP_GET_CURRENT_PROFILE		= 0x0B,
+	AWCC_OP_GET_FAN_BOOST			= 0x0C,
 };
 
 enum AWCC_THERMAL_CONTROL_OPERATIONS {
 	AWCC_OP_ACTIVATE_PROFILE		= 0x01,
+	AWCC_OP_SET_FAN_BOOST			= 0x02,
 };
 
 enum AWCC_GAME_SHIFT_STATUS_OPERATIONS {
@@ -248,6 +253,7 @@ struct awcc_fan_data {
 	u32 total_temps;
 	u32 min_rpm;
 	u32 max_rpm;
+	u8 suspend_cache;
 	u8 id;
 };
 
@@ -627,6 +633,17 @@ static inline int awcc_op_get_temperature(struct wmi_device *wdev, u8 temp_id, u
 		.arg3 = 0,
 	};
 
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
+}
+
+static inline int awcc_op_get_fan_boost(struct wmi_device *wdev, u8 fan_id, u32 *out)
+{
+	struct wmax_u32_args args = {
+		.operation = AWCC_OP_GET_FAN_BOOST,
+		.arg1 = fan_id,
+		.arg2 = 0,
+		.arg3 = 0,
+	};
 
 	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
 }
@@ -656,6 +673,19 @@ static inline int awcc_op_activate_profile(struct wmi_device *wdev, u8 profile)
 	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &out);
 }
 
+static int awcc_op_set_fan_boost(struct wmi_device *wdev, u8 fan_id, u8 boost)
+{
+	struct wmax_u32_args args = {
+		.operation = AWCC_OP_SET_FAN_BOOST,
+		.arg1 = fan_id,
+		.arg2 = boost,
+		.arg3 = 0,
+	};
+	u32 out;
+
+	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &out);
+}
+
 static int awcc_profile_id_to_pprof(u32 id, enum platform_profile_option *profile)
 {
 	switch (id) {
@@ -717,6 +747,7 @@ static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			   u32 attr, int channel, long *val)
 {
 	struct awcc_priv *priv = dev_get_drvdata(dev);
+	enum platform_profile_option profile;
 	struct awcc_fan_data *fan;
 	u32 state;
 	int ret;
@@ -765,6 +796,28 @@ static int awcc_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 		fan = priv->fan_data[channel];
 
 		switch (attr) {
+		case hwmon_pwm_enable:
+			ret = awcc_op_get_current_profile(priv->wdev, &state);
+			if (ret)
+				return ret;
+
+			ret = awcc_profile_id_to_pprof(state, &profile);
+			if (ret)
+				return ret;
+
+			switch (profile) {
+			case PLATFORM_PROFILE_PERFORMANCE:
+				*val = 0;
+				break;
+			case PLATFORM_PROFILE_CUSTOM:
+				*val = 1;
+				break;
+			default:
+				*val = 2;
+				break;
+			}
+
+			break;
 		case hwmon_pwm_auto_channels_temp:
 			bitmap_copy(val, fan->auto_channels_temp, BITS_PER_LONG);
 			break;
@@ -840,10 +893,48 @@ static int awcc_hwmon_read_string(struct device *dev, enum hwmon_sensor_types ty
 	return 0;
 }
 
+
+static int awcc_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long val)
+{
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_enable:
+			/*
+			 * We don't want to duplicate platform profile logic, so
+			 * we only allow enabling manual fan control
+			 */
+			if (val != 1)
+				return -EINVAL;
+
+			ret = awcc_op_activate_profile(priv->wdev, AWCC_SPECIAL_PROFILE_CUSTOM);
+			if (ret)
+				return ret;
+
+			if (priv->ppdev)
+				platform_profile_notify(priv->ppdev);
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
 static const struct hwmon_ops awcc_hwmon_ops = {
 	.is_visible = awcc_hwmon_is_visible,
 	.read = awcc_hwmon_read,
 	.read_string = awcc_hwmon_read_string,
+	.write = awcc_hwmon_write,
 };
 
 static const struct hwmon_channel_info * const awcc_hwmon_info[] = {
@@ -864,7 +955,7 @@ static const struct hwmon_channel_info * const awcc_hwmon_info[] = {
 			   HWMON_F_LABEL | HWMON_F_INPUT | HWMON_F_MIN | HWMON_F_MAX
 			   ),
 	HWMON_CHANNEL_INFO(pwm,
-			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP | HWMON_PWM_ENABLE,
 			   HWMON_PWM_AUTO_CHANNELS_TEMP,
 			   HWMON_PWM_AUTO_CHANNELS_TEMP,
 			   HWMON_PWM_AUTO_CHANNELS_TEMP,
@@ -879,6 +970,75 @@ static const struct hwmon_chip_info awcc_hwmon_chip_info = {
 	.info = awcc_hwmon_info,
 };
 
+static ssize_t pwm_boost_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	int ret, index = to_sensor_dev_attr(attr)->index;
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	struct awcc_fan_data *fan = priv->fan_data[index];
+	u32 boost;
+
+	ret = awcc_op_get_fan_boost(priv->wdev, fan->id, &boost);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", boost);
+}
+
+static ssize_t pwm_boost_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int ret, index = to_sensor_dev_attr(attr)->index;
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	struct awcc_fan_data *fan = priv->fan_data[index];
+	unsigned long val;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = awcc_op_set_fan_boost(priv->wdev, fan->id, clamp_val(val, 0, 255));
+
+	return ret ? ret : count;
+}
+
+static SENSOR_DEVICE_ATTR_RW(pwm1_boost, pwm_boost, 0);
+static SENSOR_DEVICE_ATTR_RW(pwm2_boost, pwm_boost, 1);
+static SENSOR_DEVICE_ATTR_RW(pwm3_boost, pwm_boost, 2);
+static SENSOR_DEVICE_ATTR_RW(pwm4_boost, pwm_boost, 3);
+
+static umode_t pwm_boost_attr_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct awcc_priv *priv = dev_get_drvdata(kobj_to_dev(kobj));
+
+	return n < priv->fan_count ? attr->mode : 0;
+}
+
+static bool pwm_boost_group_visible(struct kobject *kobj)
+{
+	return true;
+}
+
+DEFINE_SYSFS_GROUP_VISIBLE(pwm_boost);
+
+static struct attribute *fan_boost_attrs[] = {
+	&sensor_dev_attr_pwm1_boost.dev_attr.attr,
+	&sensor_dev_attr_pwm2_boost.dev_attr.attr,
+	&sensor_dev_attr_pwm3_boost.dev_attr.attr,
+	&sensor_dev_attr_pwm4_boost.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group pwm_boost_group = {
+	.attrs = fan_boost_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(pwm_boost),
+};
+
+static const struct attribute_group *awcc_hwmon_groups[] = {
+	&pwm_boost_group,
+	NULL
+};
+
 static int awcc_hwmon_temps_init(struct wmi_device *wdev)
 {
 	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
@@ -1011,12 +1171,50 @@ static int awcc_hwmon_init(struct wmi_device *wdev)
 	if (ret)
 		return ret;
 
-	priv->hwdev = devm_hwmon_device_register_with_info(&wdev->dev, "alienware_wmi", priv,
-							   &awcc_hwmon_chip_info, NULL);
+	priv->hwdev = devm_hwmon_device_register_with_info(&wdev->dev, "alienware_wmi",
+							   priv, &awcc_hwmon_chip_info,
+							   awcc_hwmon_groups);
 
 	return PTR_ERR_OR_ZERO(priv->hwdev);
 }
 
+static void awcc_hwmon_suspend(struct device *dev)
+{
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	struct awcc_fan_data *fan;
+	unsigned int i;
+	u32 boost;
+	int ret;
+
+	for (i = 0; i < priv->fan_count; i++) {
+		fan = priv->fan_data[i];
+
+		ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_FAN_BOOST,
+					       fan->id, &boost);
+		if (ret)
+			fan->suspend_cache = 0;
+		else
+			fan->suspend_cache = clamp_val(boost, 0, 255);
+
+		awcc_op_set_fan_boost(priv->wdev, fan->id, 0);
+	}
+}
+
+static void awcc_hwmon_resume(struct device *dev)
+{
+
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	struct awcc_fan_data *fan;
+	unsigned int i;
+
+	for (i = 0; i < priv->fan_count; i++) {
+		fan = priv->fan_data[i];
+
+		if (fan->suspend_cache)
+			awcc_op_set_fan_boost(priv->wdev, fan->id, fan->suspend_cache);
+	}
+}
+
 /*
  * Thermal Profile control
  *  - Provides thermal profile control through the Platform Profile API
@@ -1233,6 +1431,24 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 	return ret;
 }
 
+static int wmax_wmi_suspend(struct device *dev)
+{
+	if (awcc->hwmon)
+		awcc_hwmon_suspend(dev);
+
+	return 0;
+}
+
+static int wmax_wmi_resume(struct device *dev)
+{
+	if (awcc->hwmon)
+		awcc_hwmon_resume(dev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(wmax_wmi_pm_ops, wmax_wmi_suspend, wmax_wmi_resume);
+
 static const struct wmi_device_id alienware_wmax_device_id_table[] = {
 	{ WMAX_CONTROL_GUID, NULL },
 	{ },
@@ -1243,6 +1459,7 @@ static struct wmi_driver alienware_wmax_wmi_driver = {
 	.driver = {
 		.name = "alienware-wmi-wmax",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = pm_sleep_ptr(&wmax_wmi_pm_ops),
 	},
 	.id_table = alienware_wmax_device_id_table,
 	.probe = wmax_wmi_probe,

-- 
2.48.1



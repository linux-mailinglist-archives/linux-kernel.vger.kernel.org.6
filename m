Return-Path: <linux-kernel+bounces-552789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 290FEA57E1D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 21:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D2816B142
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 20:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6F021516E;
	Sat,  8 Mar 2025 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3HcXCLu"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB07215066;
	Sat,  8 Mar 2025 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741465444; cv=none; b=Ug+N01iAW9Fq3rcHaal8xO+0FDgg7W9VMhCHH8PRV+suGAKnOAA4qGeHM+aWfZRn1W/zR8mwPzl7hET/a6PvOEF6JzJKuqpFrHUrTEcoZU1M+55bqn2AZhxMbzikfY5Dv7O3E+I+zQAqk5P8mc7SXrSBARDGwzn9ZFrQlymF9vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741465444; c=relaxed/simple;
	bh=1WvtCI7T/zSeG16awHQltZPDSPU9utR7aCz/0rI6NFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlkjFAtUVObqmpixjgDI7g3n4SyJ+eYZ57RErsHlSbCMC/vaS0AgZo2yCz1QD1V3/ICAIALHENuTFqGdPc71YfrJBNePxZ66X84wxuL3gINJ/3p1Og1soqibnQXJVN0AT8seFaVdjHk/YJFCRMHVTrWXzSFGkNypFoeYFjcpe+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3HcXCLu; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so1162534241.1;
        Sat, 08 Mar 2025 12:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741465441; x=1742070241; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnJlPpID8OgV+6ieoW+XQuA9obmHPOcyUX8+U0ErvAw=;
        b=l3HcXCLunkpibpI01g5PdYFbXJfOXi7kE3Az2WkNoFfSfjWiDhnO/PVzOuT2sEERgQ
         5de+DFXG5hsHmcXN6d2i+SgshT4IL40xLd184NwjDJex2xy/PQrQqQvegaT1qKLg4Wcz
         VYOGOjrALUUV3x+Wo5Fo/huvj3ajSpPOd9SAVNTZidvzkCB5IHY1Y6hbvmLLF+eUiSW5
         SMOONwYjW5yokTmN3BT63zI/wHPVflRrXXAScV8v1/O7sorCr8xPYH2p49e0BzWfiaed
         hR+Vd51acO60R8VpNYDRm7oEyOUh77IXtZgtyvK3mj1K+N0ndo0woPOghvdbOlEsaz4H
         zhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741465441; x=1742070241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnJlPpID8OgV+6ieoW+XQuA9obmHPOcyUX8+U0ErvAw=;
        b=rNtGAAULcVbJ53D7pkReXYlEwnrNIkEo4SLes9+nxPIdyrBlO34KLJv9uA0LYB0oES
         LPGFXCREeVFo/NYmpB++M3TrzGrX5ugTYUCFR8xKIGdYl6LIR6Yri2GCGOHqU9zi7FZb
         D94s/njV5jz9zBuT7jClnMOa4DoRXaEw/3NgGcNOEemXyEO+dUV4QzX5OFGZOiQd5JLu
         NiLABUrupE57ncPyPD39mfRJuCjgM9k22fVABV3mIMonmTGFQ5TOiic6aIyOnAvSWOro
         GZEbtWFtMUBYq/gSJ4ulkvLovWo00JZVwRm8wR4cWmOUUmf7RWdwKkmFmSkds9LTvFyN
         jCLg==
X-Forwarded-Encrypted: i=1; AJvYcCUwJ+xdTwWkZnPtdpeoxkYRX4JtiuVZj6QN8bv/SluObCC2hrAN+kz+W62rrkAze9HKG0aY680izOkT20wv577Bvb2IzQ==@vger.kernel.org, AJvYcCW75hhoFrJ+/PwzVczfC/iB8WjrGar2SGQ4xn48RqwlZLrjUxLqq7eNpjxKA2peVcKgDcZwXs/mILqgXbz0@vger.kernel.org, AJvYcCXv7beJGD+NSuTBgJrG/p6XQNgt8bWXpPcqYwp+871eEMTCa3WYU/+iBqdTF3M+1d+RYdBsdlG1FlGiUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5LIgfekFdwkGIKX8U41mZW9vN/EowTYxwtPQ9jcSGwQYoxwoJ
	vDYBuYDIudSbskU0L4OHyudi+DrO3wOSMzI6QPGaCmh3+4rAouV5
X-Gm-Gg: ASbGncv+zS/pMH1U4KXgGZ3qo4+WTqaEaDiKrjfeFqx1oy58R5RDJRCXwSwsGFYl9d2
	f3vU8hOyV8/UgS/XcEiDlEvHDqksKVFomb6sx9M/dsnFAVJb1rfM8fjIjI3jK+xRrfKSAhil70O
	sK2Zrnu+FkzGt7LenV2jTHYanJcPjesE+vkG/XFZOg0EdBYj5HKix7QaX5ci2egu1YuvxsrcNRa
	9IWn6+XvksEwG7CnffIZgjkEBcpZVExq7g/9y03aMnMqiyK00h4qiZUwva1N/iUcBEyYtdn10EB
	9Nq3lU4hGVq3lY/eI3PYhasvuZjVO4IpblABhdNTOA+kjw==
X-Google-Smtp-Source: AGHT+IGNO21Owm/0YLb7Atl/atogHWj/IWrr1Qy6qbQK/gdQJ7tkJ6cIpVSdIKPU1ai3xeK5RFaccQ==
X-Received: by 2002:a05:6102:3fa7:b0:4bb:9b46:3f8a with SMTP id ada2fe7eead31-4c30a5016d4mr6314470137.2.1741465441289;
        Sat, 08 Mar 2025 12:24:01 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c2fb452a47sm1281061137.8.2025.03.08.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 12:24:00 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 15:23:20 -0500
Subject: [PATCH v4 08/12] platform/x86: alienware-wmi-wmax: Add support for
 manual fan control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-hwm-v4-8-afa1342828f5@gmail.com>
References: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
In-Reply-To: <20250308-hwm-v4-0-afa1342828f5@gmail.com>
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
AWCC interface let's us tune a fan `boost` value, which has the
following empirically discovered, aproximate behavior over the PWM
value:

	pwm = pwm_base + (fan_boost / 255) * (pwm_max - pwm_base)

Where the pwm_base is the locked PWM value controlled by the FW and
fan_boost is a value between 0 and 255.

Expose this fan_boost knob as a custom HWMON attribute.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 174 ++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index f1f20db206d47f644e8cd58a6d169c850606e75b..68ff520f016d2d567cddcefe41f01bf284b4d979 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -13,8 +13,12 @@
 #include <linux/bits.h>
 #include <linux/dmi.h>
 #include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/kstrtox.h>
+#include <linux/minmax.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_profile.h>
+#include <linux/pm.h>
 #include <linux/units.h>
 #include <linux/wmi.h>
 #include "alienware-wmi.h"
@@ -181,10 +185,12 @@ enum AWCC_THERMAL_INFORMATION_OPERATIONS {
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
@@ -248,6 +254,7 @@ struct awcc_fan_data {
 	const char *label;
 	u32 min_rpm;
 	u32 max_rpm;
+	u8 suspend_cache;
 	u8 id;
 };
 
@@ -628,6 +635,18 @@ static inline int awcc_op_get_temperature(struct wmi_device *wdev, u8 temp_id, u
 	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
 }
 
+static inline int awcc_op_get_fan_boost(struct wmi_device *wdev, u8 fan_id, u32 *out)
+{
+	struct wmax_u32_args args = {
+		.operation = AWCC_OP_GET_FAN_BOOST,
+		.arg1 = fan_id,
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
@@ -653,6 +672,19 @@ static inline int awcc_op_activate_profile(struct wmi_device *wdev, u8 profile)
 	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_CONTROL, &args, &out);
 }
 
+static inline int awcc_op_set_fan_boost(struct wmi_device *wdev, u8 fan_id, u8 boost)
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
 /*
  * HWMON
  *  - Provides temperature and fan speed monitoring as well as manual fan
@@ -817,6 +849,81 @@ static const struct hwmon_chip_info awcc_hwmon_chip_info = {
 	.info = awcc_hwmon_info,
 };
 
+static ssize_t fan_boost_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct awcc_fan_data *fan = priv->fan_data[index];
+	u32 boost;
+	int ret;
+
+	ret = awcc_op_get_fan_boost(priv->wdev, fan->id, &boost);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n", boost);
+}
+
+static ssize_t fan_boost_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	int index = to_sensor_dev_attr(attr)->index;
+	struct awcc_fan_data *fan = priv->fan_data[index];
+	unsigned long val;
+	int ret;
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
+static SENSOR_DEVICE_ATTR_RW(fan1_boost, fan_boost, 0);
+static SENSOR_DEVICE_ATTR_RW(fan2_boost, fan_boost, 1);
+static SENSOR_DEVICE_ATTR_RW(fan3_boost, fan_boost, 2);
+static SENSOR_DEVICE_ATTR_RW(fan4_boost, fan_boost, 3);
+static SENSOR_DEVICE_ATTR_RW(fan5_boost, fan_boost, 4);
+static SENSOR_DEVICE_ATTR_RW(fan6_boost, fan_boost, 5);
+
+static umode_t fan_boost_attr_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct awcc_priv *priv = dev_get_drvdata(kobj_to_dev(kobj));
+
+	return n < priv->fan_count ? attr->mode : 0;
+}
+
+static bool fan_boost_group_visible(struct kobject *kobj)
+{
+	return true;
+}
+
+DEFINE_SYSFS_GROUP_VISIBLE(fan_boost);
+
+static struct attribute *fan_boost_attrs[] = {
+	&sensor_dev_attr_fan1_boost.dev_attr.attr,
+	&sensor_dev_attr_fan2_boost.dev_attr.attr,
+	&sensor_dev_attr_fan3_boost.dev_attr.attr,
+	&sensor_dev_attr_fan4_boost.dev_attr.attr,
+	&sensor_dev_attr_fan5_boost.dev_attr.attr,
+	&sensor_dev_attr_fan6_boost.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group fan_boost_group = {
+	.attrs = fan_boost_attrs,
+	.is_visible = SYSFS_GROUP_VISIBLE(fan_boost),
+};
+
+static const struct attribute_group *awcc_hwmon_groups[] = {
+	&fan_boost_group,
+	NULL
+};
+
 static int awcc_hwmon_temps_init(struct wmi_device *wdev)
 {
 	struct awcc_priv *priv = dev_get_drvdata(&wdev->dev);
@@ -954,12 +1061,56 @@ static int awcc_hwmon_init(struct wmi_device *wdev)
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
+			dev_err(dev, "Failed to store Fan %u boost while suspending\n", i);
+
+		fan->suspend_cache = ret ? 0 : clamp_val(boost, 0, 255);
+
+		awcc_op_set_fan_boost(priv->wdev, fan->id, 0);
+		if (ret)
+			dev_err(dev, "Failed to set Fan %u boost to 0 while suspending\n", i);
+	}
+}
+
+static void awcc_hwmon_resume(struct device *dev)
+{
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	struct awcc_fan_data *fan;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < priv->fan_count; i++) {
+		fan = priv->fan_data[i];
+
+		if (!fan->suspend_cache)
+			continue;
+
+		ret = awcc_op_set_fan_boost(priv->wdev, fan->id, fan->suspend_cache);
+		if (ret)
+			dev_err(dev, "Failed to restore Fan %u boost while resuming\n", i);
+	}
+}
+
 /*
  * Thermal Profile control
  *  - Provides thermal profile control through the Platform Profile API
@@ -1189,6 +1340,24 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
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
@@ -1199,6 +1368,7 @@ static struct wmi_driver alienware_wmax_wmi_driver = {
 	.driver = {
 		.name = "alienware-wmi-wmax",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = pm_sleep_ptr(&wmax_wmi_pm_ops),
 	},
 	.id_table = alienware_wmax_device_id_table,
 	.probe = wmax_wmi_probe,

-- 
2.48.1



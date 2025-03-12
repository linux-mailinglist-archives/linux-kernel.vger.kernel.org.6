Return-Path: <linux-kernel+bounces-557229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111EBA5D560
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 06:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A80F3B1F45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09ED1EA7C1;
	Wed, 12 Mar 2025 05:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWvcxrs4"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F211E5B7A;
	Wed, 12 Mar 2025 05:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741756340; cv=none; b=WhFM3rQdQMCNPhdleVzSdyf+fVsFWzXLpBbPKB1NlA2IjJlvUbyZa6icPLq2F0SUXhIXRHJKzEDQ/yEb8oSowjMiNwrLNJtxQEWteJgpnuMcvTrLHWajCrlWIbNnCx831WgeX8TXbTaIdkj8iJqNnj0lh3cx49xkwWsFa4uX+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741756340; c=relaxed/simple;
	bh=oaPXgZuxQdnVVxiKRB7aZ23bK6tGn8BzFWpnsqYDtew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLG8H3Ww5BC2yYRoN+20z2Zh++23jOounRPdGWzTeqQkwUqFIHvowzafB681tIxH45iaD/Ya8oJNVU0XB2qB/R1c7xwT6/0t8uC/Ms9ep2eLFywsGle7nsvew3o+8feTmP66EEE2IIdotiUIdUrJ8lJHuMxT5BCgpKkR4KbSbrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWvcxrs4; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f7031ea11cso64946427b3.2;
        Tue, 11 Mar 2025 22:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741756336; x=1742361136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJXdYgpnaSANjr6mjP2NezwhNSkQ+3v2rcj0Q2SIosY=;
        b=FWvcxrs4rMeAwG3PV55b4MlxR1o0EoCCg4vfYR2gaiPTgZX1xveEYZBK8lvnJPmM47
         W2xq1qbc5m76zj2/HrxFyNNaqfGm0+6rkkuHUVvKNg5gFNG/Qtfr6N0n4u6nPpKIXuxD
         Kt+LO+o7tY65jFnQArWa9z/xLUSEVFVlPD7qmdeyg059c583fuV+xwcpF31DofyzGOCs
         +3pyyfibvVTkT8+VX1eKcA/YqQvO8FvBm/2f81H5ixAOk/MLj6iwrnTRsSTcvOBBsNF5
         S/qr0ZCjx0kn+D36UvGJcJ/jjc2FQgaA7HLmcOx8jFMP7N6KsEvXK/19bsH0B78dkTyn
         8tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741756336; x=1742361136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RJXdYgpnaSANjr6mjP2NezwhNSkQ+3v2rcj0Q2SIosY=;
        b=qfM5/BKH0Ms6t6gGVK+Q84hBsOSPgEv3oWMWezlqjV0xeGaoN6hHCZC4d/ElzboCMZ
         fKzlZQWPRwDTIvMJEYKWWtF8O7GtNOoRD4hDMLPYdfYFlLNQ5ULzBL0nNju+gwdNJh3a
         9nSi0X77h1uVORwh/Uy2PVqohhkqCoBj4g3horcHVXihTCRruadX8m8d5WhyTh0x1s22
         yJ4xoKMdENtut5Xp/60BHWxS4B7NRduZjUpKHpfy4ijZL46Vh9RjBkt5N0Vb2AOgW6Gi
         LKz6WRZOpUaNc1+DkwrHTJ8ATcsPXJFCGcrt59UQXQ2d94v3dbY2X4u4kh7kNLvPQx+g
         KfDw==
X-Forwarded-Encrypted: i=1; AJvYcCUoxg+mrJeaP+1am6/gKeAM/u+bVR/e3Tx2MigtTEOxDbjOkYUPzhWExkbCy+vjekICtDlZ0qSj88s2CKwK@vger.kernel.org, AJvYcCVtxbok/7nVphwHQAeFLU2fYAl3IpLrttBwcQ9E9zjRHUqZBTyQWZZC75gnJJYJtS99NKwV/5a7PuiNdA==@vger.kernel.org, AJvYcCWKFMQCcsWgTER8c5gsam+zrSXQVqDap6zbalJjCkQTrb3l//V4hjUaAinSxOlrEWcj4lp6i6yEeI7x6S831uRKBWS/5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOqP9Kh4AhsfIljhLNiLvMuzo1Yp9yzFG7kDtYgnZt5kSbRQDZ
	/8ib5MMm/nkTucUomMKM19ufQTQIZg0WHIgApjLOhcB3r3yaXa7OF/uJts+s
X-Gm-Gg: ASbGncvQJGt4/jATa5Fxnv2AwiixpsT8z9uwhco3+4a+2AsC9xwCkHJ7hmFnZ0iKFE2
	RyDXrI2MFh2Q95fGnBjTyPXFl8+UZCFgvp5bBOA82TI6ezNK/ryYcDuspUciWN/COFyFLglZfog
	Uonaj+adY0oT/vSo/nxT4Icwdd1G+bh+kDwWWm5YIkQo+kQTVK/qgqCBDJXr4aXXHCXIiZByVI6
	zuTlDDVyDx7COSjyMA7UZkz0XJDtfUSjGofdb0YJHJGJxAMwAXPkWu6+9Q5u1JfshySig9Vkm7Z
	xkdiq+OQMfppThN/UTLu6tQrCVs8rSDV2rJRgABB3bG+yQ==
X-Google-Smtp-Source: AGHT+IFxxLr6102fRp8Rlj+gTdwAAvhzpikKt4ybQE3TM6C+D+k3sIKVuQPucmu4mSpUoMY0wQU7SQ==
X-Received: by 2002:a05:690c:6f84:b0:6fb:9786:5871 with SMTP id 00721157ae682-6febf292ca7mr271938667b3.7.1741756336630;
        Tue, 11 Mar 2025 22:12:16 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6feb2c46defsm29811287b3.105.2025.03.11.22.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 22:12:15 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 12 Mar 2025 00:11:21 -0500
Subject: [PATCH v5 08/12] platform/x86: alienware-wmi-wmax: Add support for
 manual fan control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-hwm-v5-8-deb15ff8f3c6@gmail.com>
References: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
In-Reply-To: <20250312-hwm-v5-0-deb15ff8f3c6@gmail.com>
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
Reviewed-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 174 ++++++++++++++++++++++++-
 1 file changed, 172 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 0c30ffb6091a15d81f4dc959dfd28417249d3dda..bc15f78054f3c87148b8729d6ae471cdbb36a940 100644
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



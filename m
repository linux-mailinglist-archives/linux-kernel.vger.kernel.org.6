Return-Path: <linux-kernel+bounces-559702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47292A5F85B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436483A8039
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B7A269B1C;
	Thu, 13 Mar 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoNB4Q9L"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F28269827;
	Thu, 13 Mar 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876232; cv=none; b=CWhy62rOnXWY3JmYzAHasVJoIPU2Wap0EPyT7pVZkgrOqh3LgWPqhwdkJs32oIThEGa1+xXGtJGyHxHC4qSnr0LWytvCCeD9zdQdMsKlhDRLqmGY27QpSoR/dkLbkB/zlpG3wP/Tr7PKJdU8FmKa82F2dT7j6aRDRQv5dVk2xXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876232; c=relaxed/simple;
	bh=ivAY+5mUtEoo0Yn/CdswmOdOT+MH1hiQsZQtqNwGuvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWP2NRfayfQ7nJVBrtp7KmV7tsBrWzDi7fYj98U2/K1wcWnH2J3woCvqChsJCGdHiSutBI67oD1AeqnvSXaMoSPjoAodaG/Iqqwxy7yGHrghWoZ9w7oosuRJ2p06yJBz8+Cq2mJ5Mqpi+4qaUw+2UsSr9Zw8aj7+pR4pIEgKV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoNB4Q9L; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e60f212fee7so734430276.1;
        Thu, 13 Mar 2025 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876229; x=1742481029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RWLQ6OJvPjGY+MuzQcOxHw/mUwbQwWGIpX/Qme8AKs=;
        b=UoNB4Q9LNKhhRQ+w8ekwsRrlAShGAkZypL3IY6lH3RNFYB1AnfJs+OGXwSzTdFDqIA
         6ypbNKu5TU8SGEvG58yEhPPXf7OwYn9IfMHvYrsztqDNeoL1nmipKfV1ytf0ccHTQf/L
         XihEpGhjjVggmVjwaFB+vak5Alyb2Ukcvdx3sHYh/1u7IdwR1ha/20AHqNizn0c4ZRHP
         TEwWvdb7+a5tD5WFmR7NYvrIo2yQqTjHINitcHyKKAiaH6L3XbuFBKvMR0l8nHqoEdm0
         2+sfWjVEp5rp9UU5IwvcHa+pj/UR81tUshLKN8RO3mImx0Bh23i2AMurgiD4sr1J47tr
         jRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876229; x=1742481029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RWLQ6OJvPjGY+MuzQcOxHw/mUwbQwWGIpX/Qme8AKs=;
        b=E9/qog286fz9KwRS2HRwexbBum8qZ+FYt0YlxmiTItHSIOPT9a0SOc7+PYi20kDScK
         3OFtHlntiLsdQoTt/guGPC9FkYTBRLDa78ijIw0rehmqx88braINY4ln880oNJcMT/QG
         vQ+IwDWLAvVCIHsNfLzG0sC0xomsIWUg73K6++vS4Ra/0NNtygahpy4emQqdTnnlFRQ6
         FVx/1CUwWxlaonUc0ULz3ltQxWSodrDx2D3wAeUkJZRNePQtX6n70ffw34kCG1rgl3wM
         vCZE/sJwn4TjGNSa9qcrXqGB0+C4jfzE0DVeKKcEpeCK7mGrnjeKZ3K49BBOfwgnvWyE
         Bicg==
X-Forwarded-Encrypted: i=1; AJvYcCUZQU10W5IyyqVoK/K0Eji7VLPAHUWC/s4D2gfOhsu9Npbrp8asiGamPiZVjvY/78+pdS4UlAcExmOUx4b0Xnc0u+ueHw==@vger.kernel.org, AJvYcCVBKrunoE0Qf4pOfvz5XYjxyfu7FvUqmVpuSgJausn8txOfrogrPM31gbT3n5g36JgNQ+kE2keRUlVacdYY@vger.kernel.org, AJvYcCXqXQZ32ZCNS32hzAUUPHHD/v7066ze01As3qJgDEVBfuh5TDw6lvXRoYuwjtdNDt+QQT3oRncdjQYk1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCmH8pugSeSgxGUW2Kc5NLc93JbOGdy0kwebj7XXmbvDKhEcul
	QsqGsGtfCEB0r12YsKidV35Gx7btRhQBVUjxx+reV6a2ea+5mao80qw5bKqS
X-Gm-Gg: ASbGncvP5l7VRUabPTZLQs1N61ZaXvxtVsntk/cFZuxI9kCUactSVGPojicROVl5NOl
	Q1qIuz4A2+7ql7zLz4R8vqv9oHRkr69XOneY7H1ZYzWava8ZVYXvOw1J6ZDH2UxHOi4FXbXBZWO
	3s8IsO8n3eJBTaO3XeEgBrpKR0f6nF8H9XMOJN7X7wPTzebx+ccQzWEkwhV5QjERtf1oLrP3gfy
	8exVD9xsNgO/u78g0tv2JjA+3kc9/2a7AAMuQ8TSlqaP0knDBJ4TsVlBJ2B7TsXEacWEuF11qSe
	sTrhVFueuXrD2ArrB+9uqkXCf4BF0qMeD6tIybIpn+v8FQ==
X-Google-Smtp-Source: AGHT+IF1hEpC9u58s6TqP+szXZJpBOVH2hyllVVoIbdjkvOgzDQU25h0wLZdBmudFd+usFibYoaKCA==
X-Received: by 2002:a05:6902:260e:b0:e63:d299:8705 with SMTP id 3f1490d57ef6-e63d29987b2mr5988645276.31.1741876229443;
        Thu, 13 Mar 2025 07:30:29 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e56718d0sm338938276.50.2025.03.13.07.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 07:30:29 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 13 Mar 2025 09:30:03 -0500
Subject: [PATCH v6 08/12] platform/x86: alienware-wmi-wmax: Add support for
 manual fan control
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hwm-v6-8-17b57f787d77@gmail.com>
References: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
In-Reply-To: <20250313-hwm-v6-0-17b57f787d77@gmail.com>
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
index 0c30ffb6091a15d81f4dc959dfd28417249d3dda..823b579260555085ef6ac793b806738a756bb9da 100644
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
+static DEFINE_SIMPLE_DEV_PM_OPS(wmax_wmi_pm_ops, wmax_wmi_suspend, wmax_wmi_resume);
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



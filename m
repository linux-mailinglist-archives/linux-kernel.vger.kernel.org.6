Return-Path: <linux-kernel+bounces-532628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11608A4501C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5205B7AD758
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C730220697;
	Tue, 25 Feb 2025 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFtaZ+Nh"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF221D3DA;
	Tue, 25 Feb 2025 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522327; cv=none; b=BSA+iH3NYu88IW6u1qD2NnfHbGciVz1hTjuWoSNw9wyTjy6M1BiLW0Lk8oLXmVlfrMkdDmhWay4WCTCQx9RLqZao7/IFqGAnNa4XbExJaOWFwcbSBlkgBCnSpI20P79VbdLOrl/Sc9tEf9o2aPKkSYaqbJXcLaXewSHJZIOn/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522327; c=relaxed/simple;
	bh=/eo10kjHGQTKqwD8wnoYQqTqRNZdnJnuq227qjiEHMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj07VyHQ6Kdllg33FtbuTx2wsegaHFdIblMg+h/i3JDY8QJFSMq3YlNjes18WYb3/VUmUqhXBIX1RhAua4MrJuYdMCSZTHTGmhmcPcZf364K5g3gLqh6MnIpdibJ4gvHvPCqyhW/4SO0dAoLb3Jr3UhI1VTf4BlZiGG8qZ5brgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFtaZ+Nh; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e53ef7462b6so5151561276.3;
        Tue, 25 Feb 2025 14:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740522324; x=1741127124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uaWzicfmHXc/LpyRPRs0tJ1l/TrMjPTRdPjC+njdQEM=;
        b=cFtaZ+Nh2E3wdzxyL1+DET6ujirsp8yczpJeTmjv2NIQrwg/zzKXjdlX61/Mh8AM0H
         NZfVbBv0tj+bma+0YkVtblXPkASOOfkvCjCZOTphg/PBqCVwO5t0kkPWo9c00LFSi1Ni
         VYHWkk2qIQpuv/6U72HGcJ/N0MKP9yK4+/JShqO8IHRG7DR5Veugp8vHRn5bKxxGMGRq
         ntQ6i1ZYmShgwE7kC6zPPggf/MJsYyrnH6AYLoc/ODdUSaVf3jnQXBanR0gzeAVQbe+N
         g9Ji8ibQPdtRSLiWf3Be+zHLu4Xb4jLOp2C6xmRn3KCUps2LxmGJhFw/iICV6lSL5JSm
         LYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522324; x=1741127124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uaWzicfmHXc/LpyRPRs0tJ1l/TrMjPTRdPjC+njdQEM=;
        b=sIjgRfemztaQRgqsCUvQgELz4VAHWh+Dj2+zDL/wHURwOzSZQxMQYuqP/IQwIkOTC6
         C0tbtN0EDq4FJ+xyTVUAc21moev2jB+6IRcKzW2HaJr2qdbwABFRsmnR03/lb71gXvOQ
         SO+pF7ryp+AX0CijG0h7Ba12194iWwTyh2WhWlGDrTxAaTmkJWHgKmiDQW1iDtPt5aGS
         ftmDC7yw9RUwYK91Cs1uXzOvHAzwCHtJ9YdXAEV/qEiaYhEPSSmoPZbu994C1uVhlyBL
         kyL8uFVEpCwoe0FTDvyKqH1iQ2FNcbhyqf/WqeYEY7Y5s4Px9ujDo2iGpmV197ukwVCm
         mARw==
X-Forwarded-Encrypted: i=1; AJvYcCXI6dMpYGpnHEjvsIr39WAzQ6GHU8h31+wJ6R0IHp8rzFTF/0Wi1wIT/A/GyqxoKe1CkZiBX5/1H3Rrvr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2epCHt0OXqBVqlM/8s2b/V67oi8R1ClfCxwxE4/pC311r8qsq
	CVy2apFZ22AQCLexODQo+8Wbg+BolJszqkPGuOO1jJSL1o1O0Vn8M1l8Pl2Q
X-Gm-Gg: ASbGncuH8+KRNfF5g8GxuU/P5h5cHWhbApl0QSHlmMZg44tQFZARnERZ9gUl+u6Mid/
	7Ksy5yGemcZOX46tU4oVEeY3bY5KlY0H6ZXeF9ay5eQ/aqf/R+N0xrwXk2s3nLiiE6e+9lkt7jI
	yhD6Lmk5om5BptWGtZKBcrdUkRH7wBSVeqlp1iWQiZtUO+CIDT3cLFgVuRpWfID4GM9pVrB1W/I
	Bc3RY9/qZ/vnP+mbGlKeWCfDwr+AUkh7SpFSxwuCEknJXyBuz13D2RTuxKak3ncgs4Ll+eoh+/n
	EapIBynIXKBEYOlcWMVBMQigZYR96MoxtA==
X-Google-Smtp-Source: AGHT+IHUM+MfHWwncsThi8IY1zrwxMYmNJollW58jq9gfBWsfaqegtxfrqAhMr5RNxiDCwWUfzFeSg==
X-Received: by 2002:a05:6902:108f:b0:e5b:458a:dec2 with SMTP id 3f1490d57ef6-e607a4f9bc1mr4062939276.21.1740522324508;
        Tue, 25 Feb 2025 14:25:24 -0800 (PST)
Received: from localhost.localdomain ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e607b3ead63sm595466276.19.2025.02.25.14.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:25:24 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Armin Wolf" <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org,
	"Hans de Goede" <hdegoede@redhat.com>,
	Dell.Client.Kernel@dell.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 08/10] platform/x86: alienware-wmi-wmax: Add support for manual fan control
Date: Tue, 25 Feb 2025 17:24:58 -0500
Message-ID: <20250225222500.23535-9-kuurtb@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225222500.23535-1-kuurtb@gmail.com>
References: <20250225222500.23535-1-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 .../platform/x86/dell/alienware-wmi-wmax.c    | 152 +++++++++++++++++-
 1 file changed, 144 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 818023a5b205..64818efc3a1a 100644
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
@@ -178,10 +181,12 @@ enum AWCC_THERMAL_INFORMATION_OPERATIONS {
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
@@ -247,6 +252,7 @@ struct awcc_fan_data {
 	u32 total_temps;
 	u32 min_rpm;
 	u32 max_rpm;
+	u8 suspend_cache;
 	u8 id;
 };
 
@@ -560,12 +566,13 @@ static inline int awcc_thermal_information(struct wmi_device *wdev, u8 operation
 	return __awcc_wmi_command(wdev, AWCC_METHOD_THERMAL_INFORMATION, &args, out);
 }
 
-static inline int awcc_thermal_control(struct wmi_device *wdev, u8 profile)
+static inline int awcc_thermal_control(struct wmi_device *wdev, u8 operation,
+				       u8 arg1, u8 arg2)
 {
 	struct wmax_u32_args args = {
-		.operation = AWCC_OP_ACTIVATE_PROFILE,
-		.arg1 = profile,
-		.arg2 = 0,
+		.operation = operation,
+		.arg1 = arg1,
+		.arg2 = arg2,
 		.arg3 = 0,
 	};
 	u32 out;
@@ -815,6 +822,77 @@ static const struct hwmon_chip_info awcc_hwmon_chip_info = {
 	.info = awcc_hwmon_info,
 };
 
+static ssize_t pwm_boost_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	int ret, index = to_sensor_dev_attr(attr)->index;
+	struct awcc_priv *priv = dev_get_drvdata(dev);
+	struct awcc_fan_data *data = priv->fan_data[index];
+	u32 boost;
+
+	ret = awcc_thermal_information(priv->wdev, AWCC_OP_GET_FAN_BOOST, data->id,
+				       &boost);
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
+	struct awcc_fan_data *data = priv->fan_data[index];
+	unsigned long val;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	ret = awcc_thermal_control(priv->wdev, AWCC_OP_SET_FAN_BOOST, data->id,
+				   clamp_val(val, 0, 255));
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
@@ -948,12 +1026,51 @@ static int awcc_hwmon_init(struct wmi_device *wdev)
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
+		awcc_thermal_control(priv->wdev, AWCC_OP_SET_FAN_BOOST, fan->id, 0);
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
+			awcc_thermal_control(priv->wdev, AWCC_OP_SET_FAN_BOOST,
+					     fan->id, fan->suspend_cache);
+	}
+}
+
 /*
  * Thermal Profile control
  *  - Provides thermal profile control through the Platform Profile API
@@ -1018,8 +1135,8 @@ static int awcc_platform_profile_set(struct device *dev,
 		}
 	}
 
-	return awcc_thermal_control(priv->wdev,
-				    priv->supported_profiles[profile]);
+	return awcc_thermal_control(priv->wdev, AWCC_OP_ACTIVATE_PROFILE,
+				    priv->supported_profiles[profile], 0);
 }
 
 static int awcc_platform_profile_probe(void *drvdata, unsigned long *choices)
@@ -1187,6 +1304,24 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
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
@@ -1197,6 +1332,7 @@ static struct wmi_driver alienware_wmax_wmi_driver = {
 	.driver = {
 		.name = "alienware-wmi-wmax",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = pm_sleep_ptr(&wmax_wmi_pm_ops),
 	},
 	.id_table = alienware_wmax_device_id_table,
 	.probe = wmax_wmi_probe,
-- 
2.48.1



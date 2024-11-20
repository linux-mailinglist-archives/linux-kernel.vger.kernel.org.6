Return-Path: <linux-kernel+bounces-416109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E11929D4059
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17C82822CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D05E1552E7;
	Wed, 20 Nov 2024 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5LdfClx"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890D153801;
	Wed, 20 Nov 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121026; cv=none; b=iv56I/d+Yye1a7H1uLBoA+KmGuacE5t+KRqhCM7tGcphfsCelui1Urv+JekqSEFJYMB5hLe0wU0lbt9Lw6uDyA0Pz9NvzyyNcai6sMN2rRl8+eI3mKr9yOXEMsUwtlvGfOYxkeTA3FJUui8ZDG3TtYJzJd2c5y0EBNkcj+mDf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121026; c=relaxed/simple;
	bh=qoRKPifNpwbHxIrkRiZGC9o4/ZMOh/cdw8ZUMqvXrmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKtWXfRLAXXpWhhM9bM+F80r+yY+XIaWdkJPziK7XHE7VXC+1qCZGgG2II7J4hqcxSA0Oqoqp1OTzSSShXYeI1/XZLHF2iAwui4VKjmkkfyO5PASfV2Q8DsuqNbOZvdFTgs4FqzHakFhXukP3Wp/vR2TgpTGXvRzB0Cg3e+FK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5LdfClx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ed9c16f687so6589a12.0;
        Wed, 20 Nov 2024 08:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732121024; x=1732725824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rY4MrtcqVyuIerAVdHZZzP/4uqpO8ITrRAcC2cys/es=;
        b=l5LdfClxQeGOBJDm6kAzxeWgTcM3R5hZSI3biQloZq/c8O1EfpjwaLfX3UDAR1ErsB
         V9m1GGFC0HAbdCB8bzJhAZwwk7SJpEfp8nzND1zVzsyKSEKNG8pwglk5Fauyd5rD2xHs
         I4PZa7LZDOSyu20eSNvuK4Nz6bHrOhzADXGDZNBJuMsl3WN3/ALoBnoAMnxDLP4a1Kc+
         RArtIO+Ql7zZLEIibS6kxkBwTFYFr/ApW0h2g/6KrTgBubEOGd0drselARBBM/yuXC8z
         JRohW8W+dpURoV5fHM7RXN1PaWBwhmZ3yIkZqHGiceCRLJnVSi+ltFP9WOKgd89fgZYF
         eRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732121024; x=1732725824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rY4MrtcqVyuIerAVdHZZzP/4uqpO8ITrRAcC2cys/es=;
        b=QJ3FSqT9HYEagC3RpUDEPHNqegsPGUfE80dR3J5A3Ms+jwaVuA+nX7w4gK6HratSzk
         KOz7EYxT/Sn5XZbe11UxGx/+GVKKIasUVhHKHqf24qu01HpQazztaKL+07U53RaKYZRX
         A+V8PU1nbE5pA3HSJfgxKIWVpjOAKPKCBcmysxFygBj4QoopF4zjMfg+lIjDw3BYEQO2
         RtCSJX8UsbCttNAWv/kfcU2G/cnFWXqwctZRGhY81S63OuQtnC2L+IkIhkAFqWjcHuts
         zZwcFPUNdKZkuNPtU86EolWA78m0xm2QHrz0+bxOHBs9e1nGsiqdNR+GkwBgtIaISQGa
         MdBw==
X-Forwarded-Encrypted: i=1; AJvYcCW3YokGdMnjXqFL6flf717Em/QJkAWmOgb5cYbC/KeZCnnubPzIAklILExYJ2qC/vgw8C/s/N2+RvFbJE8=@vger.kernel.org, AJvYcCWxhv+BTZDXSOw85cabGZwasgh4cBMrRppQA/G9UGYfEGFdCsMPQs0AUnIoZZfTrC+3XK/LKbCUhm9Ohdt+lj8f11mg9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXseU9JShEUGdGQO2r/fGZaCI81F5gD5nwM+m13rdMHq3Zb2tF
	DaokGlw89QezTVaUPbSbsQ/od8iEyZMAqOgI+Vi0FivYrrd2a2/c
X-Google-Smtp-Source: AGHT+IH4f9DJqyCERcRoaTWN3u2lPuc/Tl4KK60jt8i94AdWpvBw1cuYr1gKIuUxeh5zLQWIMqgb0w==
X-Received: by 2002:a05:6a20:734d:b0:1dc:154a:81fb with SMTP id adf61e73a8af0-1ddb06251camr4852097637.44.1732121022739;
        Wed, 20 Nov 2024 08:43:42 -0800 (PST)
Received: from localhost.localdomain ([181.84.94.92])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fb72420decsm6192116a12.9.2024.11.20.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:43:42 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH v2 2/4] alienware-wmi: Improves sysfs groups creation
Date: Wed, 20 Nov 2024 13:43:15 -0300
Message-ID: <20241120164314.7177-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120163834.6446-3-kuurtb@gmail.com>
References: <20241120163834.6446-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices with hdmi_mux, amplifier or deepslp quirks create a sysfs group
for each available feature. To accomplish this, helper create/remove
functions were called on module init, but they had the following
problems:

 - Create helpers called remove helpers on failure, which in turn tried
   to remove the sysfs group that failed to be created
 - If group creation failed mid way, previous successfully created groups
   were not cleaned up
 - Module exit only removed hdmi_mux group

To improve this, drop all helpers and let the platform driver manage these
sysfs groups, while controlling visibility with their respective quirks.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v2:
 - Drop the helpers approach in favor of letting the driver manage the
   wmax sysfs groups
---

Again I think not cleaning up created sysfs group is not actually a bug
so this is only an improvement.

---
 drivers/platform/x86/dell/alienware-wmi.c | 112 +++++++---------------
 1 file changed, 36 insertions(+), 76 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 6760c7627f62..ecab14d90b27 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -410,17 +410,12 @@ struct wmax_u32_args {
 	u8 arg3;
 };
 
+
 static struct platform_device *platform_device;
 static struct platform_zone *zone_data;
 static struct platform_profile_handler pp_handler;
 static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 
-static struct platform_driver platform_driver = {
-	.driver = {
-		.name = "alienware-wmi",
-	}
-};
-
 static struct attribute_group zone_attribute_group = {
 	.name = "rgb_zones",
 };
@@ -781,6 +776,12 @@ static ssize_t toggle_hdmi_source(struct device *dev,
 	return count;
 }
 
+static bool hdmi_group_visible(struct kobject *kobj)
+{
+	return quirks->hdmi_mux;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(hdmi);
+
 static DEVICE_ATTR(cable, S_IRUGO, show_hdmi_cable, NULL);
 static DEVICE_ATTR(source, S_IRUGO | S_IWUSR, show_hdmi_source,
 		   toggle_hdmi_source);
@@ -793,25 +794,10 @@ static struct attribute *hdmi_attrs[] = {
 
 static const struct attribute_group hdmi_attribute_group = {
 	.name = "hdmi",
+	.is_visible = SYSFS_GROUP_VISIBLE(hdmi),
 	.attrs = hdmi_attrs,
 };
 
-static void remove_hdmi(struct platform_device *dev)
-{
-	if (quirks->hdmi_mux > 0)
-		sysfs_remove_group(&dev->dev.kobj, &hdmi_attribute_group);
-}
-
-static int create_hdmi(struct platform_device *dev)
-{
-	int ret;
-
-	ret = sysfs_create_group(&dev->dev.kobj, &hdmi_attribute_group);
-	if (ret)
-		remove_hdmi(dev);
-	return ret;
-}
-
 /*
  * Alienware GFX amplifier support
  * - Currently supports reading cable status
@@ -838,6 +824,12 @@ static ssize_t show_amplifier_status(struct device *dev,
 	return sysfs_emit(buf, "unconnected connected [unknown]\n");
 }
 
+static bool amplifier_group_visible(struct kobject *kobj)
+{
+	return quirks->amplifier;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(amplifier);
+
 static DEVICE_ATTR(status, S_IRUGO, show_amplifier_status, NULL);
 
 static struct attribute *amplifier_attrs[] = {
@@ -847,25 +839,10 @@ static struct attribute *amplifier_attrs[] = {
 
 static const struct attribute_group amplifier_attribute_group = {
 	.name = "amplifier",
+	.is_visible = SYSFS_GROUP_VISIBLE(amplifier),
 	.attrs = amplifier_attrs,
 };
 
-static void remove_amplifier(struct platform_device *dev)
-{
-	if (quirks->amplifier > 0)
-		sysfs_remove_group(&dev->dev.kobj, &amplifier_attribute_group);
-}
-
-static int create_amplifier(struct platform_device *dev)
-{
-	int ret;
-
-	ret = sysfs_create_group(&dev->dev.kobj, &amplifier_attribute_group);
-	if (ret)
-		remove_amplifier(dev);
-	return ret;
-}
-
 /*
  * Deep Sleep Control support
  * - Modifies BIOS setting for deep sleep control allowing extra wakeup events
@@ -916,6 +893,12 @@ static ssize_t toggle_deepsleep(struct device *dev,
 	return count;
 }
 
+static bool deepsleep_group_visible(struct kobject *kobj)
+{
+	return quirks->deepslp;
+}
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(deepsleep);
+
 static DEVICE_ATTR(deepsleep, S_IRUGO | S_IWUSR, show_deepsleep_status, toggle_deepsleep);
 
 static struct attribute *deepsleep_attrs[] = {
@@ -925,25 +908,10 @@ static struct attribute *deepsleep_attrs[] = {
 
 static const struct attribute_group deepsleep_attribute_group = {
 	.name = "deepsleep",
+	.is_visible = SYSFS_GROUP_VISIBLE(deepsleep),
 	.attrs = deepsleep_attrs,
 };
 
-static void remove_deepsleep(struct platform_device *dev)
-{
-	if (quirks->deepslp > 0)
-		sysfs_remove_group(&dev->dev.kobj, &deepsleep_attribute_group);
-}
-
-static int create_deepsleep(struct platform_device *dev)
-{
-	int ret;
-
-	ret = sysfs_create_group(&dev->dev.kobj, &deepsleep_attribute_group);
-	if (ret)
-		remove_deepsleep(dev);
-	return ret;
-}
-
 /*
  * Thermal Profile control
  *  - Provides thermal profile control through the Platform Profile API
@@ -1151,6 +1119,20 @@ static void remove_thermal_profile(void)
 		platform_profile_remove();
 }
 
+const struct attribute_group *wmax_groups[] = {
+	&hdmi_attribute_group,
+	&amplifier_attribute_group,
+	&deepsleep_attribute_group,
+	NULL
+};
+
+static struct platform_driver platform_driver = {
+	.driver = {
+		.name = "alienware-wmi",
+		.dev_groups = wmax_groups,
+	}
+};
+
 static int __init alienware_wmi_init(void)
 {
 	int ret;
@@ -1190,24 +1172,6 @@ static int __init alienware_wmi_init(void)
 	if (ret)
 		goto fail_platform_device2;
 
-	if (quirks->hdmi_mux > 0) {
-		ret = create_hdmi(platform_device);
-		if (ret)
-			goto fail_prep_hdmi;
-	}
-
-	if (quirks->amplifier > 0) {
-		ret = create_amplifier(platform_device);
-		if (ret)
-			goto fail_prep_amplifier;
-	}
-
-	if (quirks->deepslp > 0) {
-		ret = create_deepsleep(platform_device);
-		if (ret)
-			goto fail_prep_deepsleep;
-	}
-
 	if (quirks->thermal) {
 		ret = create_thermal_profile();
 		if (ret)
@@ -1223,9 +1187,6 @@ static int __init alienware_wmi_init(void)
 fail_prep_zones:
 	remove_thermal_profile();
 fail_prep_thermal_profile:
-fail_prep_deepsleep:
-fail_prep_amplifier:
-fail_prep_hdmi:
 	platform_device_del(platform_device);
 fail_platform_device2:
 	platform_device_put(platform_device);
@@ -1240,7 +1201,6 @@ module_init(alienware_wmi_init);
 static void __exit alienware_wmi_exit(void)
 {
 	if (platform_device) {
-		remove_hdmi(platform_device);
 		remove_thermal_profile();
 		platform_device_unregister(platform_device);
 		platform_driver_unregister(&platform_driver);
-- 
2.47.0



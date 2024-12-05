Return-Path: <linux-kernel+bounces-432445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E079E4B51
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D55C18814EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63577FBF6;
	Thu,  5 Dec 2024 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyHbQy4F"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073611185;
	Thu,  5 Dec 2024 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359269; cv=none; b=CwHYCquFCHgKv/yTjG9yzqVx/8UYJ9CisIztiLtbuPHjCfAHomsxRj3AfGWZ19GOJ2/PZCY//eakUyq8nFNRTDzF87c8HSvcC9/Fd2XNpfC0HVEZ4IVNg+DrhHZW6AYlICDoERi1oU/dF2Iwldg3tYXNwKf4yVnruLOuuXb/tOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359269; c=relaxed/simple;
	bh=UccVoGu94NgUgMYRUgrC/+FtNNEsujhaYb2fbha/f5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWeVZ0R6ZnQqOnn2P704grmeb0CHPjk/9tR+2UPESfldvkW/49iO3hL5pinrMCLLeOoraEmNgWj/b1Y2SxtyXm2huyT0MrZmOCElqUp4t4Y8kiax+7DE+UbiHTpQ3V2j2Xpgn1UvcftIYT2tJgsFEJQUrNcKB8toQGKrmFFfbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyHbQy4F; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7fc41dab8e3so323859a12.3;
        Wed, 04 Dec 2024 16:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359267; x=1733964067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65OcLr4FPhGXkdHEMtCl+2bLn6t3Nrnc5J+Fw6WgdjQ=;
        b=hyHbQy4FeMQ3npNJe+jtCct3+3xoHZCNS8rUysF87oa4hsSNcdLbDRb1ohIGHP5VL/
         cKcmPO6fff6b8kpQV/kqpobRJfpnTE/AzdBM3mzmyb5J6dLfERF+6GnQBs/qAl/CEISC
         6I4bPEnkBIf5MoAf87VNRe9uzxdG/goCaAxZcAG7eshzpaS+oo+HMv8d43rHJVzGCYz2
         Y0hSmdeoyBGj1g+NIwSiRwHeebBA2GyJI4ImvtaaS5arUqQgIEYee8EkLjYU4/JlxOFK
         gGleACzJcYy9sYgxYMOMVLFJ8ykn7QsaRAFdgWWnBN10aog82s8aVzfvulu2y1ocDmni
         c7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359267; x=1733964067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65OcLr4FPhGXkdHEMtCl+2bLn6t3Nrnc5J+Fw6WgdjQ=;
        b=trQF1fk5G129XzQsT4j38F5vYyb57eYJm1V9/wAHKfMaUgkgz7xEcL2BMmF5JL3Zyt
         jyiH99YEtysHQyMG7NdIn9bIjbNgS0woN8x4PQ3G+8wgEPf0JHiBDJ1qYI2E4DnouYn8
         vFlkoQdhMqRG7v+EpmmSms4aDMnvkusYTx/kZi6PUr/fwfSxUYDGTIJddVVEZntaxu9g
         FzL72vUuYyagJbiB7uAsxfYd+HKSzwYwChTwNyxivr8jEHugigCsBJipKi7OUSrZFTWf
         4JS4bpeP8VmaNajo2EtJcEKub85Ly3wyjj0Em0Podo9tn3PTfC1kktP4txowzRLJ6teB
         jMHg==
X-Forwarded-Encrypted: i=1; AJvYcCVgFnFSsbUp+6L/OECSaw0j0RWiyVgUSFvXuKRkoPrxffLJgh58eTh8sKRQZjw+CW/k0F1i9Q4I/d+8Wi1Fzh6/xs0B1g==@vger.kernel.org, AJvYcCWAmTq4UT6OxwE8jvXtNT0hNgHeEp4IrVjTTft4+PYlKx3l3UrFqqCXFjoVXjhwYe0GcpAI6P753Jf5j40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD8/FiI2ahnR9LkDVrfgF18dn4JJbjQ0YRjMFNbg1eLtciWmjN
	2diziRTJImRTKI70ARamm4YypkZotlnOkTJ+8T6jVGGTSsJFQCxblQPXeDBi
X-Gm-Gg: ASbGncs6gcUPInC+img/okWTFEaXH6jVM2lV705379A7n+K8hxOdWsF96CBOg6Vqv2v
	yxCpjVv6oKgq7ONiztfdcU+shurvXXBPTcRMgJVrIyMehXe+mUYLFSixqJiwftUInqhZrTjk/26
	iPycpLoHdQlmhjR3dAysTaGeDz0FsSvAbtH8cZSWQUuTiVK/X51Hyr0k/CMad82okIFB6aqKE6f
	NNeOmPHEgxYPpo/CAxDWP75zUhJJZwu+QzEnQdRXO+y1YVos/18OJ7e51qLacjAG7qGFytG5nU9
	5J2Mw4F4dLZDzzKSKTw=
X-Google-Smtp-Source: AGHT+IHzx1P9kzseo/UwCY38/Rcz2V5O2hA1TN0uUl8YRb5ST4Us535wNDltWa/UcX/gg1SJ6lbtOg==
X-Received: by 2002:a05:6a20:6a04:b0:1e0:dc7b:4ee9 with SMTP id adf61e73a8af0-1e1653a2a4cmr10496896637.8.1733359267078;
        Wed, 04 Dec 2024 16:41:07 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a2cc5482sm94414b3a.171.2024.12.04.16.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:41:06 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 07/21] alienware-wmi: Migrate to state container pattern
Date: Wed,  4 Dec 2024 21:40:53 -0300
Message-ID: <20241205004052.2185242-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241205002733.2183537-3-kuurtb@gmail.com>
References: <20241205002733.2183537-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate all led control functions to use the platform_device state
container.

Additionally move the led_classdev registration to the platform driver
probe and make it device managed.

Drop alienware_zone_init() and alienware_zone_exit() because it's no
longer needed.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 123 +++++++++-------------
 1 file changed, 47 insertions(+), 76 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index ea848937b579..e5e4a7b4e9ca 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -376,11 +376,6 @@ struct color_platform {
 	u8 red;
 } __packed;
 
-struct platform_zone {
-	u8 location;
-	struct color_platform colors;
-};
-
 struct wmax_brightness_args {
 	u32 led_mask;
 	u32 percentage;
@@ -418,13 +413,10 @@ struct alienfx_priv {
 };
 
 static struct platform_device *platform_device;
-static struct platform_zone *zone_data;
 static struct platform_profile_handler pp_handler;
 static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 
 static u8 interface;
-static u8 lighting_control_state;
-static u8 global_brightness;
 
 /*
  * Helpers used for zone control
@@ -456,7 +448,7 @@ static int parse_rgb(const char *buf, struct color_platform *colors)
 /*
  * Individual RGB zone control
  */
-static int alienware_update_led(struct platform_zone *zone)
+static int alienware_update_led(struct alienfx_priv *priv, u8 location)
 {
 	int method_id;
 	acpi_status status;
@@ -465,25 +457,25 @@ static int alienware_update_led(struct platform_zone *zone)
 	struct legacy_led_args legacy_args;
 	struct wmax_led_args wmax_basic_args;
 	if (interface == WMAX) {
-		wmax_basic_args.led_mask = 1 << zone->location;
-		wmax_basic_args.colors = zone->colors;
-		wmax_basic_args.state = lighting_control_state;
+		wmax_basic_args.led_mask = 1 << location;
+		wmax_basic_args.colors = priv->colors[location];
+		wmax_basic_args.state = priv->lighting_control_state;
 		guid = WMAX_CONTROL_GUID;
 		method_id = WMAX_METHOD_ZONE_CONTROL;
 
 		input.length = sizeof(wmax_basic_args);
 		input.pointer = &wmax_basic_args;
 	} else {
-		legacy_args.colors = zone->colors;
-		legacy_args.brightness = global_brightness;
+		legacy_args.colors = priv->colors[location];
+		legacy_args.brightness = priv->global_brightness;
 		legacy_args.state = 0;
-		if (lighting_control_state == LEGACY_BOOTING ||
-		    lighting_control_state == LEGACY_SUSPEND) {
+		if (priv->lighting_control_state == LEGACY_BOOTING ||
+		    priv->lighting_control_state == LEGACY_SUSPEND) {
 			guid = LEGACY_POWER_CONTROL_GUID;
-			legacy_args.state = lighting_control_state;
+			legacy_args.state = priv->lighting_control_state;
 		} else
 			guid = LEGACY_CONTROL_GUID;
-		method_id = zone->location + 1;
+		method_id = location + 1;
 
 		input.length = sizeof(legacy_args);
 		input.pointer = &legacy_args;
@@ -499,24 +491,33 @@ static int alienware_update_led(struct platform_zone *zone)
 static ssize_t zone_show(struct device *dev, struct device_attribute *attr,
 			 char *buf, u8 location)
 {
-	struct platform_zone *target_zone;
-	target_zone = &zone_data[location];
+	struct alienfx_priv *priv;
+	struct color_platform *colors;
+
+	priv = dev_get_drvdata(dev);
+	colors = &priv->colors[location];
+
 	return sprintf(buf, "red: %d, green: %d, blue: %d\n",
-		       target_zone->colors.red,
-		       target_zone->colors.green, target_zone->colors.blue);
+		       colors->red, colors->green, colors->blue);
 
 }
 
 static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count, u8 location)
 {
-	struct platform_zone *target_zone;
+	struct alienfx_priv *priv;
+	struct color_platform *colors;
 	int ret;
-	target_zone = &zone_data[location];
-	ret = parse_rgb(buf, &target_zone->colors);
+
+	priv = dev_get_drvdata(dev);
+
+	colors = &priv->colors[location];
+	ret = parse_rgb(buf, colors);
 	if (ret)
 		return ret;
-	ret = alienware_update_led(target_zone);
+
+	ret = alienware_update_led(priv, location);
+
 	return ret ? ret : count;
 }
 
@@ -553,9 +554,13 @@ static ssize_t lighting_control_state_show(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	if (lighting_control_state == LEGACY_BOOTING)
+	struct alienfx_priv *priv;
+
+	priv = dev_get_drvdata(dev);
+
+	if (priv->lighting_control_state == LEGACY_BOOTING)
 		return sysfs_emit(buf, "[booting] running suspend\n");
-	else if (lighting_control_state == LEGACY_SUSPEND)
+	else if (priv->lighting_control_state == LEGACY_SUSPEND)
 		return sysfs_emit(buf, "booting running [suspend]\n");
 	return sysfs_emit(buf, "booting [running] suspend\n");
 }
@@ -564,8 +569,11 @@ static ssize_t lighting_control_state_store(struct device *dev,
 					    struct device_attribute *attr,
 					    const char *buf, size_t count)
 {
+	struct alienfx_priv *priv;
 	u8 val;
 
+	priv = dev_get_drvdata(dev);
+
 	if (strcmp(buf, "booting\n") == 0)
 		val = LEGACY_BOOTING;
 	else if (strcmp(buf, "suspend\n") == 0)
@@ -575,9 +583,9 @@ static ssize_t lighting_control_state_store(struct device *dev,
 	else
 		val = WMAX_RUNNING;
 
-	lighting_control_state = val;
+	priv->lighting_control_state = val;
 	pr_debug("alienware-wmi: updated control state to %d\n",
-		 lighting_control_state);
+		 priv->lighting_control_state);
 
 	return count;
 }
@@ -634,55 +642,26 @@ static int wmax_brightness(int brightness)
 static void global_led_set(struct led_classdev *led_cdev,
 			   enum led_brightness brightness)
 {
+	struct alienfx_priv *priv;
 	int ret;
-	global_brightness = brightness;
+
+	priv = container_of(led_cdev, struct alienfx_priv, global_led);
+	priv->global_brightness = brightness;
 	if (interface == WMAX)
 		ret = wmax_brightness(brightness);
 	else
-		ret = alienware_update_led(&zone_data[0]);
+		ret = alienware_update_led(priv, 0);
 	if (ret)
 		pr_err("LED brightness update failed\n");
 }
 
 static enum led_brightness global_led_get(struct led_classdev *led_cdev)
 {
-	return global_brightness;
-}
-
-static struct led_classdev global_led = {
-	.brightness_set = global_led_set,
-	.brightness_get = global_led_get,
-	.name = "alienware::global_brightness",
-};
-
-static int alienware_zone_init(struct platform_device *dev)
-{
-	u8 zone;
-
-	if (interface == WMAX) {
-		lighting_control_state = WMAX_RUNNING;
-	} else if (interface == LEGACY) {
-		lighting_control_state = LEGACY_RUNNING;
-	}
-	global_led.max_brightness = 0x0F;
-	global_brightness = global_led.max_brightness;
-
-	zone_data =
-	    kcalloc(quirks->num_zones, sizeof(struct platform_zone),
-		    GFP_KERNEL);
-	if (!zone_data)
-		return -ENOMEM;
-
-	for (zone = 0; zone < 4; zone++)
-		zone_data[zone].location = zone;
+	struct alienfx_priv *priv;
 
-	return led_classdev_register(&dev->dev, &global_led);
-}
+	priv = container_of(led_cdev, struct alienfx_priv, global_led);
 
-static void alienware_zone_exit(struct platform_device *dev)
-{
-	led_classdev_unregister(&global_led);
-	kfree(zone_data);
+	return priv->global_brightness;
 }
 
 static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
@@ -1152,7 +1131,7 @@ static int alienfx_probe(struct platform_device *pdev)
 
 	priv->global_brightness = priv->global_led.max_brightness;
 
-	return 0;
+	return devm_led_classdev_register(&pdev->dev, &priv->global_led);
 }
 
 static const struct attribute_group *alienfx_groups[] = {
@@ -1216,15 +1195,8 @@ static int __init alienware_wmi_init(void)
 			goto fail_prep_thermal_profile;
 	}
 
-	ret = alienware_zone_init(platform_device);
-	if (ret)
-		goto fail_prep_zones;
-
 	return 0;
 
-fail_prep_zones:
-	alienware_zone_exit(platform_device);
-	remove_thermal_profile();
 fail_prep_thermal_profile:
 	platform_device_del(platform_device);
 fail_platform_device2:
@@ -1239,7 +1211,6 @@ module_init(alienware_wmi_init);
 
 static void __exit alienware_wmi_exit(void)
 {
-	alienware_zone_exit(platform_device);
 	remove_thermal_profile();
 	platform_device_unregister(platform_device);
 	platform_driver_unregister(&platform_driver);
-- 
2.47.1



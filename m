Return-Path: <linux-kernel+bounces-432443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC659E4B4C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA6B167414
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BD7F513;
	Thu,  5 Dec 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgCWQsFg"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3A17BB6;
	Thu,  5 Dec 2024 00:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359228; cv=none; b=sWEfe2bRPFTXzWqEhjnWUjEsceikLPaZKGQDhBhYpVU2kMvniAh57hApUOaexYgbWeQxaYZ6P77uowQnA6VL7NFn72A/+uCtToYXIP2enqPaHl2GjlWrujg8yuqOqvcPPKRwm0IVbomzTqLLb+9ltx9VEl5OmXMXmTgMcueC8I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359228; c=relaxed/simple;
	bh=P5/kIGbX/bFrFqpM9iYhUcYT2ADJ5IEqutf5VESuf+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQ03NN24spNHAgbhw1hyLdwbi7VESSUwtYv22n2+pHNphysP/krJ11osR0QJKkGc/gOIIHb5mNjnnUFhVmPvtUSgF6LV5AJzkeY8jNck/9UJDnlOUbU/F6iDwzRrPEmqxr6kombyhvR7tNroHysSMtgWjTrrjQlx28GOmVfel6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgCWQsFg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd10cd5b1aso291161a12.2;
        Wed, 04 Dec 2024 16:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359226; x=1733964026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tK+ClSQ6UY0i3I0k7CEH05rGNOTkJditxK5OuDd1s0I=;
        b=FgCWQsFg+VFgbvayK90gvKdxmuOZu6yGC53RQcuKtiXh+vfrnoJ51brxQRXM1+Wij4
         YsQvJBTPZRrQPND+/c/Zu5CXjPUsVzQbDJtN9279u60rz2LU8x8D7D4/TvLbBWTHQk8A
         dRYAG6/wDSL63Y+QHaBfsL8dooNGjA90fhGdorxZ85fJRlyqYdR3PrhqrZpi/Sy0WNa9
         39cnfy596JG/M8zEorcH6/F68d9zKRlEQqbwhujz4ooKnojWbOX8ViNmqgGoNfxDUUUe
         i3ybvYXLIqvLOgbQ6/oz+ZUQpZLbqHnuYXFQfuDlslpLZIcxHm5o9oEkkxOKlYynWpef
         VEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359226; x=1733964026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK+ClSQ6UY0i3I0k7CEH05rGNOTkJditxK5OuDd1s0I=;
        b=Q9yuweVDI9yytdCHvCqbU2kaAeYGX3F8sxTdl3D+QV9QIf9brWmCGVxZ7peaaJGqDU
         Pc0ieJk7OuHzxQaV/GZbnQYOAhGi1bAwK59WrujO+H10VATZZo8px5BkaG7oztBlLqNa
         WZJx/DRVmROeH4rk6jWSg3jmnRV3g/5XvBd8aUGli9XhOyo/u3C+u6VFJYXxKchWQDe1
         xyfqkyiiqoiwKKskmrU0FssCrmaZAuIh03zju30KwVrBldMhKSayYAgpCBxQf2uLsZf2
         yYUve97VWjfc1sppZx4EDXcINYdK5IC6NkoIcn73uWlktgEN/7V/mUWpqfOhYIwwBHjk
         oVBg==
X-Forwarded-Encrypted: i=1; AJvYcCW6nZ9QkDNmSLekaFBWXSOdwhM+WUoIDk6M7l/wwzy3VxSO5h9vmY5Z0BFEn6A2z2kb3vj8xY6SvTEO1qA=@vger.kernel.org, AJvYcCXgrPPy9VNIM1hEYfoUimVTBUc80fMx9JdvuI40c8piILFvQ2WmZDw56n+wjU3gGGCLD4TYf/LrLJmk4eCaNpt0jRe3Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHNHInbpgZsjd62hNd+m0vHG1wThirvNk761/hJ538rwdY1m5F
	4mTFL6ZFCKm8y6Z/wYRH/HY5epvKtfkqf2hDPmOUT6bik8wpr2/B
X-Gm-Gg: ASbGncsM1/7uCIfXpU7AIXkndiYUpb/A8pp/Trvnca6shUXUIftiP0ofjUsPUwUTQY8
	3s1LPzu0fu3eZniH5mat9BXDWeY3R3NAdSU+RPFAShq6YDd2XMTGYWsSnliiDpZENFesLAmPpC8
	JLqFWB2ht+Gzpr2Txk8+JYO31bV75iVCOf3xfjDIaY/kvjnS80NEvialBymWn9BsgF1DhoIBC5a
	y/am88jTC7UFDuz3uS9ln0DsWqb2Lu/qewrlkBvKR+IItwyWS0HhX/+VSgeZFP4rVlkzOIdwKKr
	tchruc6UCg6au6zemFA=
X-Google-Smtp-Source: AGHT+IFNPbUuAutZgb6Iuc9X6KMHApQCqeBS/cbE9Pubfhlc8t8WZp25zilDnMqjm1Fz0yAqeOPxtg==
X-Received: by 2002:a05:6a20:734f:b0:1e0:d3c6:b453 with SMTP id adf61e73a8af0-1e16bdf9bafmr10838383637.10.1733359225807;
        Wed, 04 Dec 2024 16:40:25 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1568f286sm120319a12.11.2024.12.04.16.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:40:25 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 05/21] alienware-wmi: Refactor rgb-zones sysfs group creation
Date: Wed,  4 Dec 2024 21:40:06 -0300
Message-ID: <20241205004005.2184945-2-kuurtb@gmail.com>
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

Define zone_attrs statically with the use of helper macros and
initialize the zone_attribute_group with driver's .dev_groups.

This makes match_zone() no longer needed, so drop it.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 137 ++++++++++------------
 1 file changed, 60 insertions(+), 77 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 78bbb4ef4526..fa7bbbb07b86 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -378,7 +378,6 @@ struct color_platform {
 
 struct platform_zone {
 	u8 location;
-	struct device_attribute *attr;
 	struct color_platform colors;
 };
 
@@ -411,16 +410,10 @@ struct wmax_u32_args {
 };
 
 static struct platform_device *platform_device;
-static struct device_attribute *zone_dev_attrs;
-static struct attribute **zone_attrs;
 static struct platform_zone *zone_data;
 static struct platform_profile_handler pp_handler;
 static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 
-static struct attribute_group zone_attribute_group = {
-	.name = "rgb_zones",
-};
-
 static u8 interface;
 static u8 lighting_control_state;
 static u8 global_brightness;
@@ -452,20 +445,6 @@ static int parse_rgb(const char *buf, struct color_platform *colors)
 	return 0;
 }
 
-static struct platform_zone *match_zone(struct device_attribute *attr)
-{
-	u8 zone;
-
-	for (zone = 0; zone < quirks->num_zones; zone++) {
-		if ((struct device_attribute *)zone_data[zone].attr == attr) {
-			pr_debug("alienware-wmi: matched zone location: %d\n",
-				 zone_data[zone].location);
-			return &zone_data[zone];
-		}
-	}
-	return NULL;
-}
-
 /*
  * Individual RGB zone control
  */
@@ -510,12 +489,10 @@ static int alienware_update_led(struct platform_zone *zone)
 }
 
 static ssize_t zone_show(struct device *dev, struct device_attribute *attr,
-			 char *buf)
+			 char *buf, u8 location)
 {
 	struct platform_zone *target_zone;
-	target_zone = match_zone(attr);
-	if (target_zone == NULL)
-		return sprintf(buf, "red: -1, green: -1, blue: -1\n");
+	target_zone = &zone_data[location];
 	return sprintf(buf, "red: %d, green: %d, blue: %d\n",
 		       target_zone->colors.red,
 		       target_zone->colors.green, target_zone->colors.blue);
@@ -523,15 +500,11 @@ static ssize_t zone_show(struct device *dev, struct device_attribute *attr,
 }
 
 static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
-			const char *buf, size_t count)
+			const char *buf, size_t count, u8 location)
 {
 	struct platform_zone *target_zone;
 	int ret;
-	target_zone = match_zone(attr);
-	if (target_zone == NULL) {
-		pr_err("alienware-wmi: invalid target zone\n");
-		return 1;
-	}
+	target_zone = &zone_data[location];
 	ret = parse_rgb(buf, &target_zone->colors);
 	if (ret)
 		return ret;
@@ -539,6 +512,32 @@ static ssize_t zone_set(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : count;
 }
 
+#define ALIENWARE_ZONE_SHOW_FUNC(_num)					\
+	static ssize_t zone0##_num##_show(struct device *dev,		\
+					struct device_attribute *attr,	\
+					char *buf)			\
+	{								\
+		return zone_show(dev, attr, buf, _num);			\
+	}
+
+#define ALIENWARE_ZONE_STORE_FUNC(_num)					\
+	static ssize_t zone0##_num##_store(struct device *dev,		\
+					struct device_attribute *attr,	\
+					const char *buf, size_t count)	\
+	{								\
+		return zone_set(dev, attr, buf, count, _num);		\
+	}
+
+#define ALIENWARE_ZONE_ATTR(_num)					\
+	ALIENWARE_ZONE_SHOW_FUNC(_num)					\
+	ALIENWARE_ZONE_STORE_FUNC(_num)					\
+	static DEVICE_ATTR_RW(zone0##_num)
+
+ALIENWARE_ZONE_ATTR(0);
+ALIENWARE_ZONE_ATTR(1);
+ALIENWARE_ZONE_ATTR(2);
+ALIENWARE_ZONE_ATTR(3);
+
 /*
  * Lighting control state device attribute (Global)
  */
@@ -577,6 +576,33 @@ static ssize_t lighting_control_state_store(struct device *dev,
 
 static DEVICE_ATTR_RW(lighting_control_state);
 
+static umode_t zone_attr_visible(struct kobject *kobj,
+				 struct attribute *attr, int n)
+{
+	return n < quirks->num_zones + 1 ? 0644 : 0;
+}
+
+static bool zone_group_visible(struct kobject *kobj)
+{
+	return quirks->num_zones > 0;
+}
+DEFINE_SYSFS_GROUP_VISIBLE(zone);
+
+static struct attribute *zone_attrs[] = {
+	&dev_attr_lighting_control_state.attr,
+	&dev_attr_zone00.attr,
+	&dev_attr_zone01.attr,
+	&dev_attr_zone02.attr,
+	&dev_attr_zone03.attr,
+	NULL
+};
+
+static struct attribute_group zone_attribute_group = {
+	.name = "rgb_zones",
+	.is_visible = SYSFS_GROUP_VISIBLE(zone),
+	.attrs = zone_attrs,
+};
+
 /*
  * LED Brightness (Global)
  */
@@ -624,7 +650,6 @@ static struct led_classdev global_led = {
 static int alienware_zone_init(struct platform_device *dev)
 {
 	u8 zone;
-	char *name;
 
 	if (interface == WMAX) {
 		lighting_control_state = WMAX_RUNNING;
@@ -634,65 +659,22 @@ static int alienware_zone_init(struct platform_device *dev)
 	global_led.max_brightness = 0x0F;
 	global_brightness = global_led.max_brightness;
 
-	/*
-	 *      - zone_dev_attrs num_zones + 1 is for individual zones and then
-	 *        null terminated
-	 *      - zone_attrs num_zones + 2 is for all attrs in zone_dev_attrs +
-	 *        the lighting control + null terminated
-	 *      - zone_data num_zones is for the distinct zones
-	 */
-	zone_dev_attrs =
-	    kcalloc(quirks->num_zones + 1, sizeof(struct device_attribute),
-		    GFP_KERNEL);
-	if (!zone_dev_attrs)
-		return -ENOMEM;
-
-	zone_attrs =
-	    kcalloc(quirks->num_zones + 2, sizeof(struct attribute *),
-		    GFP_KERNEL);
-	if (!zone_attrs)
-		return -ENOMEM;
-
 	zone_data =
 	    kcalloc(quirks->num_zones, sizeof(struct platform_zone),
 		    GFP_KERNEL);
 	if (!zone_data)
 		return -ENOMEM;
 
-	for (zone = 0; zone < quirks->num_zones; zone++) {
-		name = kasprintf(GFP_KERNEL, "zone%02hhX", zone);
-		if (name == NULL)
-			return 1;
-		sysfs_attr_init(&zone_dev_attrs[zone].attr);
-		zone_dev_attrs[zone].attr.name = name;
-		zone_dev_attrs[zone].attr.mode = 0644;
-		zone_dev_attrs[zone].show = zone_show;
-		zone_dev_attrs[zone].store = zone_set;
+	for (zone = 0; zone < 4; zone++)
 		zone_data[zone].location = zone;
-		zone_attrs[zone] = &zone_dev_attrs[zone].attr;
-		zone_data[zone].attr = &zone_dev_attrs[zone];
-	}
-	zone_attrs[quirks->num_zones] = &dev_attr_lighting_control_state.attr;
-	zone_attribute_group.attrs = zone_attrs;
-
-	led_classdev_register(&dev->dev, &global_led);
 
-	return sysfs_create_group(&dev->dev.kobj, &zone_attribute_group);
+	return led_classdev_register(&dev->dev, &global_led);
 }
 
 static void alienware_zone_exit(struct platform_device *dev)
 {
-	u8 zone;
-
-	sysfs_remove_group(&dev->dev.kobj, &zone_attribute_group);
 	led_classdev_unregister(&global_led);
-	if (zone_dev_attrs) {
-		for (zone = 0; zone < quirks->num_zones; zone++)
-			kfree(zone_dev_attrs[zone].attr.name);
-	}
-	kfree(zone_dev_attrs);
 	kfree(zone_data);
-	kfree(zone_attrs);
 }
 
 static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
@@ -1140,6 +1122,7 @@ static void remove_thermal_profile(void)
  * Platform Driver
  */
 static const struct attribute_group *alienfx_groups[] = {
+	&zone_attribute_group,
 	&hdmi_attribute_group,
 	&amplifier_attribute_group,
 	&deepsleep_attribute_group,
-- 
2.47.1



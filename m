Return-Path: <linux-kernel+bounces-413830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6219D1F48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277DA1F21D14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C7114C5AA;
	Tue, 19 Nov 2024 04:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ozp6iN4r"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC04149C57;
	Tue, 19 Nov 2024 04:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990914; cv=none; b=hQrfkbMNE2kbNOdCacYas9Mz8lpwz3XffJJ/q7wgGf08WXvFIAm1AuATSnCbTjUh3qAJqQMMVIJrGw/Zq4svqR3lkIjOp9sIqiHZ6DB+tPIqTe/XFshtNqpiHvsJ35bwkMwy6obIVJvupsSu1/Z13usS3tJPd43e1oPqjXrsBdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990914; c=relaxed/simple;
	bh=jjMFNJ7TfVSIiHLU1uUB9MdGrQDFNHvXGBxvrKjkOTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRTaU3li5dMWg+fwhJWtJ/0Td3ym6fYXTu9aEaPKHTkyHnqrothXZAeoteD4ULOpH8wiWJyJRnqvl4V6GjjBXpt/Y5qtLRmqTm4F1ET3RjZDD+kfE83a5nV+BaGh05usNqgzWjIM82/ovOMNvqUJDEYttRjwmHl/nhwk7atp8mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ozp6iN4r; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5ffbc6acbso1563938b6e.3;
        Mon, 18 Nov 2024 20:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731990911; x=1732595711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qutRYX47PZq2TLtsUHnQwEmMSJ5C/hYw2sul0EI6m04=;
        b=Ozp6iN4rfmb1Vc8WbWzs67uZxrlaICw/BcbOuhcVClpujV2DhPo+WHXkAshXUPpYjC
         nt3jCfDNtdUmVaCC31oxVXVVkfi9tWr+RHUnJmAANf6tz3B861meB+sF2afkU/EMMPIY
         75Q0mvcxkOGyi8sjtwM0KMP11jQjj8jem9cw5cB2OOz1WB9Qkn70QW9ccVM1/9F8O1Lb
         OgkJXYPqkNaxWnpgIQFMZSsp/tQUu6LwhZ9rSzvIdSgpfTHFQmE8Lva/riYnEseUlwyc
         J5zGuOPuRnj/7Mun20wOTLXnamFb6Pc7CbL0aXjwkMJ6EGSQ+gd1AH5ivjfY/5OPV9sZ
         x6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731990911; x=1732595711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qutRYX47PZq2TLtsUHnQwEmMSJ5C/hYw2sul0EI6m04=;
        b=Dn7Y+DXy/B+zrRirQ7KydvXXG2e0RdSHjSYosMNZGDh8VmtfiPwaY2oM9eVWtUK3bP
         G51fnaFrNI43dXD0Irw4BUpaVVA+/h99OUBacGvUsSdOwYn11g99qGaRbkyzOCoIbPhr
         f6Z0lbGk1fmmEBcm0eYAI/zjclOQWMFp3VWyHsWW1qUdJAO8v+whzndlWD/WwC8PcUBH
         huhNWfIvzKeoGh846ol7UGeALXyRyUUYlTbLIfIhO37hzuwgmNfmU30GdYARnpo8qJWp
         jgxeZ+xoxmcUQ1nuEzpkw0nJ9IQJK44kEtr2g+IGN97aoar59fNm7R8uC//iK8ZYhHva
         6UdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYzbkb2NcAsjA9jtr16ATE3YTIIlGzhnua5WbrOujBJKruGyOxa770LyDO6oAaIJBn4L6zQ7KWCns8njo=@vger.kernel.org, AJvYcCXMV7B+OOE3Bzmpv1Ba7zOfgt6hztw2YpaYX7pI7Xs3xl9xuzfc4DrgIVXX4lfVdX4bPhN/jEL6NH6MxqAjQxwtgckbDw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VQ1KRyVmssCUjQip1whjuz0OSA23fkSslE8/smo2k283MmDu
	jE9CYIr/1h4mGjSC10B7ouZNP+2vK5pFIePOQ+RU3/5v8mWT95UU
X-Google-Smtp-Source: AGHT+IH8PX/8w9Hkk5kEwM/fjpVkD0RLQ/t5jnTZsGQtIcgZum72ZmOZWLsoa9E/lEyXMkEPsZFk5w==
X-Received: by 2002:a05:6808:4481:b0:3e3:cd42:58b0 with SMTP id 5614622812f47-3e7bc877597mr12378149b6e.43.1731990911595;
        Mon, 18 Nov 2024 20:35:11 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0d37sm7306207b3a.104.2024.11.18.20.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 20:35:11 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH 3/5] alienware-wmi: Migrate to device managed allocations
Date: Tue, 19 Nov 2024 01:35:06 -0300
Message-ID: <20241119043506.25611-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All allocation's lifetimes are tied to the platform device lifetime thus
make them device managed.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 40 ++++++++---------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 289b842c07aa..980ffc545093 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -411,8 +411,6 @@ struct wmax_u32_args {
 };
 
 static struct platform_device *platform_device;
-static struct device_attribute *zone_dev_attrs;
-static struct attribute **zone_attrs;
 static struct platform_zone *zone_data;
 static struct platform_profile_handler pp_handler;
 static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
@@ -624,10 +622,12 @@ static ssize_t store_control_state(struct device *dev,
 static DEVICE_ATTR(lighting_control_state, 0644, show_control_state,
 		   store_control_state);
 
-static int alienware_zone_init(struct platform_device *dev)
+static int alienware_zone_init(struct platform_device *pdev)
 {
 	u8 zone;
 	char *name;
+	struct device_attribute *zone_dev_attrs;
+	struct attribute **zone_attrs;
 
 	if (interface == WMAX) {
 		lighting_control_state = WMAX_RUNNING;
@@ -644,28 +644,25 @@ static int alienware_zone_init(struct platform_device *dev)
 	 *        the lighting control + null terminated
 	 *      - zone_data num_zones is for the distinct zones
 	 */
-	zone_dev_attrs =
-	    kcalloc(quirks->num_zones + 1, sizeof(struct device_attribute),
-		    GFP_KERNEL);
+	zone_dev_attrs = devm_kcalloc(&pdev->dev, quirks->num_zones + 1,
+				      sizeof(struct device_attribute), GFP_KERNEL);
 	if (!zone_dev_attrs)
 		return -ENOMEM;
 
-	zone_attrs =
-	    kcalloc(quirks->num_zones + 2, sizeof(struct attribute *),
-		    GFP_KERNEL);
+	zone_attrs = devm_kcalloc(&pdev->dev, quirks->num_zones + 2,
+				  sizeof(struct attribute *), GFP_KERNEL);
 	if (!zone_attrs)
 		return -ENOMEM;
 
-	zone_data =
-	    kcalloc(quirks->num_zones, sizeof(struct platform_zone),
-		    GFP_KERNEL);
+	zone_data = devm_kcalloc(&pdev->dev, quirks->num_zones,
+				 sizeof(struct platform_zone), GFP_KERNEL);
 	if (!zone_data)
 		return -ENOMEM;
 
 	for (zone = 0; zone < quirks->num_zones; zone++) {
-		name = kasprintf(GFP_KERNEL, "zone%02hhX", zone);
-		if (name == NULL)
-			return 1;
+		name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "zone%02hhX", zone);
+		if (!name)
+			return -ENOMEM;
 		sysfs_attr_init(&zone_dev_attrs[zone].attr);
 		zone_dev_attrs[zone].attr.name = name;
 		zone_dev_attrs[zone].attr.mode = 0644;
@@ -678,24 +675,15 @@ static int alienware_zone_init(struct platform_device *dev)
 	zone_attrs[quirks->num_zones] = &dev_attr_lighting_control_state.attr;
 	zone_attribute_group.attrs = zone_attrs;
 
-	led_classdev_register(&dev->dev, &global_led);
+	led_classdev_register(&pdev->dev, &global_led);
 
-	return sysfs_create_group(&dev->dev.kobj, &zone_attribute_group);
+	return sysfs_create_group(&pdev->dev.kobj, &zone_attribute_group);
 }
 
 static void alienware_zone_exit(struct platform_device *dev)
 {
-	u8 zone;
-
 	sysfs_remove_group(&dev->dev.kobj, &zone_attribute_group);
 	led_classdev_unregister(&global_led);
-	if (zone_dev_attrs) {
-		for (zone = 0; zone < quirks->num_zones; zone++)
-			kfree(zone_dev_attrs[zone].attr.name);
-	}
-	kfree(zone_dev_attrs);
-	kfree(zone_data);
-	kfree(zone_attrs);
 }
 
 static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
-- 
2.47.0



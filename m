Return-Path: <linux-kernel+bounces-413832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DF79D1F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 05:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6471F209B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 04:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2139149DF7;
	Tue, 19 Nov 2024 04:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATxncjnS"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC60C14883C;
	Tue, 19 Nov 2024 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990942; cv=none; b=ZijbME6+K64pbetHj+efAtszlY/RaviGYpoGn1vN//49CzJMLGeHcasJmGRhKkn0cOzp94fWInYJh4pebh9gjl2hOC5mpoWqTM7BvXdDMUS22csc7Xc3Io7S5ZajeX0cA5TOJT314/M5kUB9tOvUD0BA7CnGmn0FvSysj/Gcc7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990942; c=relaxed/simple;
	bh=JvVjEtUcK8mPj6HAzqx4Td1tV1c6mTucb2cJy/j6Ij0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uZoIxa7aHqYEJR7dKwbAXO123PwPF5wB0Dj+I67rm6EjM2H0snLUWZthaEKj2bDbEZSe2YoRosJU57jh6Q87tRzQ93O84aDuoYSvTAex4CrxacTGhGATt6tcUCOKQWRqdavK4YJtGFQR91TaChfQZV0CBmW6AcnKFzXlmlcWE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATxncjnS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso358321a12.3;
        Mon, 18 Nov 2024 20:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731990940; x=1732595740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mt2kk2PoDSy2cjvOCOwysjW9T27/nUvH/Sb5nJrvwg=;
        b=ATxncjnSly5kX01UrEscrOUjYGqIhaKc17eFheLZsnZqGXZd+VHrCwLfnnL6i9tGy2
         y5Zt4xicd8h3qHSz1qbyTda1h2ICT7/T3vk7Vag3qk50v58cv9AToTJyh3JHywfZqH6c
         B2apl/EPwUdXQtP/HrsW9bJOLTjZlw5m9zFe2l/3Od2CJLjHtEQ8xSaQvR+191Wg39j3
         a+WYhZRsLf2ffD5pHv+0lXVyUh7Ye6YwENgEeFDSRTqNDPFQvLicbuxveVto9aPLJLUG
         SZn1Czmo7iPh0Qj6hywR21bQcsCfu7gL2tBsNAdmRzkU33qG04EUJkHboTSWn8UA5F7x
         x+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731990940; x=1732595740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Mt2kk2PoDSy2cjvOCOwysjW9T27/nUvH/Sb5nJrvwg=;
        b=CKgmCLrDcyp8nsLOo3JR0uZoi041YjN7z4IK1PDBlF5raVGR3C6oHKC2hWYb3cAGgn
         86O1NMyKmD0ZYMCn805jvt4UBmBqScVfyswCvGRg5iBPP0GiuUnEY8bN/xWRFev9HDgG
         kbEwgt2t6jlINOW+X7WpxK/swZMPBo746yahVNfG4nIS2MFJd79OuZe5eHNSBu8scaRw
         YiHV+5XKUBbUDCaxISJSa0zsIxzsvw+RTg+bDt4mLMrZHL3WkQcG/oHC9zhB21wrtMye
         qdGrHiNoqfXaNBZCkqIWyPBctq3EjiVxwJbL0ovhePZ9dkAWHm3l6Gzx8bDa9HQBos4d
         UZPg==
X-Forwarded-Encrypted: i=1; AJvYcCWan7gHd+OdQK4RFEpunlGfdFX2zD4/PhcU8E2ZHF8HTdKxsg9mxMA5PdeEzXxOLUgTI8W5pGoa1y2Gd/JFx0JVQJ+mCw==@vger.kernel.org, AJvYcCXLtQiyFU5fQU0h2oayrHqJUjf2MN9yPKNyBCYOkfH3uugO8pWB8SQXax39WANsrG/BXUdYubXbB5b22nU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnOgbFZT90dgkrXpiG9tKRGwPZd8cj5C4tRZvj71eZDwgMURJ
	n1IK6gTkMCK8U2tFHcCtYGA8QfToS1Gy8gFoSPr0D/zBeOfshUVF
X-Google-Smtp-Source: AGHT+IFIbC5XYKPiw7Q5hAiWvRuRq5h8g+cAOP1pn9KewVr847vttcmRTfnskisPgoXj6hMDjXkpWA==
X-Received: by 2002:a05:6a20:158e:b0:1db:f07e:8ab5 with SMTP id adf61e73a8af0-1dc90bcd528mr22349418637.36.1731990940075;
        Mon, 18 Nov 2024 20:35:40 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771394ffsm7050045b3a.90.2024.11.18.20.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 20:35:39 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH 5/5] alienware-wmi: Improves sysfs groups creation
Date: Tue, 19 Nov 2024 01:35:34 -0300
Message-ID: <20241119043534.25683-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
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

To improve this, drop all helpers in favor of two helpers that make use
of sysfs_create_groups/sysfs_remove_groups to cleanly create/remove
groups at module init/exit.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---

I have a question. Do the created sysfs groups get removed when their
kobj reference count goes to 0? I ask because I want to know if this is
a bug fix.

---
 drivers/platform/x86/dell/alienware-wmi.c | 105 ++++++++--------------
 1 file changed, 36 insertions(+), 69 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 44f1f7b57d0a..e9ed2089cba0 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -410,8 +410,10 @@ struct wmax_u32_args {
 	u8 arg3;
 };
 
+
 static struct platform_device *platform_device;
 static struct platform_zone *zone_data;
+const struct attribute_group *wmax_groups[4];
 static struct platform_profile_handler pp_handler;
 static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 
@@ -810,22 +812,6 @@ static const struct attribute_group hdmi_attribute_group = {
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
@@ -864,22 +850,6 @@ static const struct attribute_group amplifier_attribute_group = {
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
@@ -942,22 +912,6 @@ static const struct attribute_group deepsleep_attribute_group = {
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
@@ -1165,6 +1119,34 @@ static void remove_thermal_profile(void)
 		platform_profile_remove();
 }
 
+static int __init create_wmax_groups(struct platform_device *pdev)
+{
+	int no_groups = 0;
+
+	if (quirks->hdmi_mux) {
+		wmax_groups[no_groups] = &hdmi_attribute_group;
+		no_groups++;
+	}
+
+	if (quirks->amplifier) {
+		wmax_groups[no_groups] = &amplifier_attribute_group;
+		no_groups++;
+	}
+
+	if (quirks->deepslp) {
+		wmax_groups[no_groups] = &deepsleep_attribute_group;
+		no_groups++;
+	}
+
+	return no_groups > 0 ? device_add_groups(&pdev->dev, wmax_groups) : 0;
+}
+
+static void __exit remove_wmax_groups(struct platform_device *pdev)
+{
+	if (!wmax_groups[0])
+		device_remove_groups(&pdev->dev, wmax_groups);
+}
+
 static int __init alienware_wmi_init(void)
 {
 	int ret;
@@ -1203,23 +1185,9 @@ static int __init alienware_wmi_init(void)
 		goto fail_platform_device1;
 	}
 
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
+	ret = create_wmax_groups(platform_device);
+	if (ret)
+		goto fail_prep_groups;
 
 	if (quirks->thermal) {
 		ret = create_thermal_profile();
@@ -1236,9 +1204,8 @@ static int __init alienware_wmi_init(void)
 fail_prep_zones:
 	remove_thermal_profile();
 fail_prep_thermal_profile:
-fail_prep_deepsleep:
-fail_prep_amplifier:
-fail_prep_hdmi:
+	remove_wmax_groups(platform_device);
+fail_prep_groups:
 	platform_device_unregister(platform_device);
 fail_platform_device1:
 	platform_driver_unregister(&platform_driver);
@@ -1251,7 +1218,7 @@ module_init(alienware_wmi_init);
 static void __exit alienware_wmi_exit(void)
 {
 	alienware_zone_exit(platform_device);
-	remove_hdmi(platform_device);
+	remove_wmax_groups(platform_device);
 	remove_thermal_profile();
 	platform_device_unregister(platform_device);
 	platform_driver_unregister(&platform_driver);
-- 
2.47.0



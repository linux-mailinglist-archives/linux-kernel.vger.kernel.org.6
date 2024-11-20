Return-Path: <linux-kernel+bounces-416106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BA39D4055
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FA6282BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A51B1547EF;
	Wed, 20 Nov 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA31gkMN"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2213B58A;
	Wed, 20 Nov 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120986; cv=none; b=Fj2y4kY6kDzfzOs4V5TFAREecG+K2t8jiNTwHohLd8zS+Uxm49tiIE12Of5eHgEylgvi/AXfCqQEOhn/2cVPBD9RnLQ86Kq2Aa3Nu45bku3Y86K+assI/nNEi4inwnmVOzlCJpOzuJc+iH7Y6XMbwIzPTpnDk9AaZO7War1oqNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120986; c=relaxed/simple;
	bh=OoymVpwFMkwuz2aiVMAKjmPOQvN4cofwBGIBPbYhn18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0j0hYq5+Y7umNCYVz/2QqeGlVjbLQzum1aphT4NMYubjfTk9SqCi6+jq202gNyd/QkFSInEgBtFGs9lyWLzM0djyKNuIlRwzBi+vvJgYO6aSWerz1rWEeE5LMF91Ol43hRReGbprPgxRy18uDVmf+ChOAt0gYKjaLIirfhvj+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA31gkMN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so5035038a12.1;
        Wed, 20 Nov 2024 08:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732120984; x=1732725784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DskX8Tuw2FCowoWZpTw1NNNCPSabdrvI4T93JXuLkvY=;
        b=QA31gkMN0xnjxYWQboZENlhnUcozK78SNDnnGa9CmnDs5ooV04PaAZnAUHd2+0dWQ9
         FE7/32VvykgtxsfzokfoOiMSb4qBI7m6FVsSjaXL4DtRCzsRfpldaqcQKcDXolHh0unD
         y3s3W/MfB/m2JzdskDcdRhGKKF0SKGsLVJKDcQFSfSD6vAFNrpY1ITt28SvQm1mUFN15
         KS/DmgbGIRsoyZtnqo/K6z0aXWRuIMtidrHl2r9XqIkFBejh/yN2RYeQHC5VN2+2f8u0
         dgi5IZX12XBgHHo5xM5XMvFiLFiIUars8vB9Bkzp/chUv3ZruOXmb5W4OdLZ4cMEIAAW
         0+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732120984; x=1732725784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DskX8Tuw2FCowoWZpTw1NNNCPSabdrvI4T93JXuLkvY=;
        b=u4sjur80xmuEc8YBlipOfl+DP2c9MsFK2kX9WPSVT7BbDSEYvy/Pw/KucxcUziqmxR
         aqQHLB8LLlu9LfD8hWRqm1bv0c9CbMrL3Kpp2Ck5rg8/z7cz7HGoA9w4xx3W4VbzVDbl
         taB9MbpzoCXaRyDRcDHzxCW2D83oksFjj1gDnYrnHuw3ys71zC6prcP80U1ciPjhAHd1
         Ttz1PdNYpHBjFC8pkWMrXben0TPtnQifDW30jarhVFCg6FaTx6mdakaAjfhOjJ5V0VBi
         hWi0l0wC9APKe/iMX4uUu/ZoF8rb4ypKmvWrtE/JckPdH83iFFtiI4kyjVBzLxF6+NEK
         Xh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnoVOyip8qySAHh53DfacNxcfr8enizXxupIgiPMpFuOaNAk6AOvgovw2quJpOC6LcWknCpP/OWWzKi2E=@vger.kernel.org, AJvYcCVbmWSQVZtVhQGjnq82KMnxloaFaSdjI15wSfy2dHCZAomm0yLBIlRfgoUX47lY/iJ2f+oGfCoQwASlN05ax8ublDWhXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8s0mJQmRKr1ypg21fLLwtS2aIvHq41rVijeSlWmKXFzGBwC+o
	1BiiArxbKd5Xiwdzj5ymurp2JOays5er0O93f9OFpsSOc6jjYDVP
X-Google-Smtp-Source: AGHT+IGTe1jHqCkRptoyAj6gkJtMDGTCstoPSv+zgzfzndR6HAdJEeZ7cO9ZgTyIDIJR9r2YL1OILQ==
X-Received: by 2002:a05:6a21:621:b0:1d8:a67b:9224 with SMTP id adf61e73a8af0-1ddaff54ba5mr2946733637.34.1732120984212;
        Wed, 20 Nov 2024 08:43:04 -0800 (PST)
Received: from localhost.localdomain ([181.84.94.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724beeb82a4sm1856233b3a.12.2024.11.20.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 08:43:03 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [PATCH v2 1/4] alienware-wmi: Migrate to device managed resources
Date: Wed, 20 Nov 2024 13:41:30 -0300
Message-ID: <20241120164129.6893-2-kuurtb@gmail.com>
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

These resources are tied to the platform device lifetime thus make them
make them device managed. Also propagate devm_led_classdev_register() in
case of failure.

This indirectly improves module exit error handling, as potentially not
registered led class or sysfs groups are unregistered.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
v2:
 - led_classdev_register() is now device managed
 - sysfs_create_group() is now device managed
 - Removed alienware_zone_exit() because it's empty now
---

It seems even if the led class is not registered, led_classdev_unregister
fails safely. Same for the sysfs group. If I'm wrong and this is
actually a fix please point it out.

---
 drivers/platform/x86/dell/alienware-wmi.c | 51 ++++++++---------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 77465ed9b449..6760c7627f62 100644
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
@@ -624,10 +622,13 @@ static ssize_t store_control_state(struct device *dev,
 static DEVICE_ATTR(lighting_control_state, 0644, show_control_state,
 		   store_control_state);
 
-static int alienware_zone_init(struct platform_device *dev)
+static int alienware_zone_init(struct platform_device *pdev)
 {
 	u8 zone;
 	char *name;
+	struct device_attribute *zone_dev_attrs;
+	struct attribute **zone_attrs;
+	int ret;
 
 	if (interface == WMAX) {
 		lighting_control_state = WMAX_RUNNING;
@@ -644,28 +645,25 @@ static int alienware_zone_init(struct platform_device *dev)
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
@@ -678,24 +676,11 @@ static int alienware_zone_init(struct platform_device *dev)
 	zone_attrs[quirks->num_zones] = &dev_attr_lighting_control_state.attr;
 	zone_attribute_group.attrs = zone_attrs;
 
-	led_classdev_register(&dev->dev, &global_led);
-
-	return sysfs_create_group(&dev->dev.kobj, &zone_attribute_group);
-}
-
-static void alienware_zone_exit(struct platform_device *dev)
-{
-	u8 zone;
+	ret = devm_led_classdev_register(&pdev->dev, &global_led);
+	if (ret < 0)
+		return ret;
 
-	sysfs_remove_group(&dev->dev.kobj, &zone_attribute_group);
-	led_classdev_unregister(&global_led);
-	if (zone_dev_attrs) {
-		for (zone = 0; zone < quirks->num_zones; zone++)
-			kfree(zone_dev_attrs[zone].attr.name);
-	}
-	kfree(zone_dev_attrs);
-	kfree(zone_data);
-	kfree(zone_attrs);
+	return devm_device_add_group(&pdev->dev, &zone_attribute_group);
 }
 
 static acpi_status alienware_wmax_command(void *in_args, size_t in_size,
@@ -1236,7 +1221,6 @@ static int __init alienware_wmi_init(void)
 	return 0;
 
 fail_prep_zones:
-	alienware_zone_exit(platform_device);
 	remove_thermal_profile();
 fail_prep_thermal_profile:
 fail_prep_deepsleep:
@@ -1256,7 +1240,6 @@ module_init(alienware_wmi_init);
 static void __exit alienware_wmi_exit(void)
 {
 	if (platform_device) {
-		alienware_zone_exit(platform_device);
 		remove_hdmi(platform_device);
 		remove_thermal_profile();
 		platform_device_unregister(platform_device);
-- 
2.47.0



Return-Path: <linux-kernel+bounces-432447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438869E4B55
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C195B282670
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3CC10940;
	Thu,  5 Dec 2024 00:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUOfSg7A"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8C0DF78;
	Thu,  5 Dec 2024 00:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733359336; cv=none; b=oLrz7rTpKJjs3hRAfQyEQxmCnmgUsCuSvge7j1IyszjR0NIo8FuVgohr4PY6RtpXRF3NpeSD0ch7VUo2HYFbg05VtJ1raCc8jMrN2EZZ7z2/ggQuBM5kAdOEnAW6hKnXlPEuRpl7/AL2RJDaeFjYMz5khJ/baxTdd0ADYf8Y8tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733359336; c=relaxed/simple;
	bh=TYS/+QG/QZOmVmbxFBEJ2sprBGACQgJvbcP+KIaKsyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2ofo+fCpc8ft4dSR+xUMTrP9FVQ/beg//K89wpahOAri1iCdr+pCLvmPxFGaUY8Tt5SIl5DSRsvprBN8CBnrNgL+WsRWFqxcnOwGopYpDTeNMpJ+c8c6pfjv6d7QWcNrN2n+x17P8Qr8rXE4LSGDZYTTf5Wc01bU5MLY7VVHmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUOfSg7A; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21583cf5748so3483395ad.1;
        Wed, 04 Dec 2024 16:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733359334; x=1733964134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AW2NdhokyNp5GT2wMPEkU5inhjkJ9tIPNy2oyF/lZlw=;
        b=BUOfSg7AWcEoUq/4Y1tcOOnZR7mFeNbud38AKorgShbXU5tiQYW4NYdAo36DFbvSyP
         kU0oVLQ9BUVI3iF2pAR3OhejmC60c8IMHCsJXb/DaTG/IaxIkLLTttRgeKut7N43fDXT
         pmrXC+z+Gjx20O2soSh2FrPslI2ygPYwTaHzMp8231Xxj3DaTnpdca3dkDCW2YKlzomF
         4Ljr4x8GdavHKD/evp80xUDGOgjPsLGapjZ8G8aKLkeGVeZgPiqaVA5n2aCDaAkUhpXb
         I1619hBkxIniFwm60KjGNi5KK1hLzeu2rtnUew8mgio2+LPR+nKpopxITPeApu5gdOGT
         /KQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733359334; x=1733964134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AW2NdhokyNp5GT2wMPEkU5inhjkJ9tIPNy2oyF/lZlw=;
        b=nm7UFC7gLTtmtljpFnuuXtaAJcHUT6V8AZ89bnbQVDr7/y8HAu7Z1e3BqkS9O48z64
         vHffmWHoVpvdE6PjXD1KpZi+usoepi+U5Zz6J9Pe4ycwjJsgJamxvNAgYQA0Egy1dM9G
         DOqckUXxlp28YHfsiunrLRDyT8RD5Bowwx3HwcQ62OuLtX4UT+CrrKzNIvGPyKp4vaxL
         XD30aY1UwlDCgJfWcZ0Y1gt9ZaXvIde5fwIDg8/vNjPEvdaULdjqNhi4qAq8pcjCRP9a
         W/uzSoJkxGZRNTsLJXTWs6Tq0bo7CFW/FJenKiEfN05ixVUHUHvOH+me19H4gjLK9J9O
         Dk/A==
X-Forwarded-Encrypted: i=1; AJvYcCUAeujn3DigH8zf+Cp9S+6jtfOMbQwXGwJ5jtbO/s+haukiVU+4K0PtjxJxlhPWo7o3YNElrAHmRO5iWuGsGBRrGeftAQ==@vger.kernel.org, AJvYcCVl+bBdxAeS7WDAr2ENiRCY+vCV5GO3jXWTQgpJsnmsZq6CmImtzptsRoMVZt3vITtZ2x6A+Jt0HeHpO1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxEHIhukOPqeaYiEJbwKsUny0g4ieyttOjaEdPD8U0L4mfP83
	/0Szg0Vw5YXrvexw8tCRLwy/eAZnPTGSBrUB0MTg1h9TUPXDbW4N
X-Gm-Gg: ASbGncsY8SSR+vGOsVDmmydoFrpAdjaIk2AGQ5BMH26+afoXrUCKtDZdcbkiafXjmR6
	llpx/+htbCL9AyJKHhH7GDtL941gjQ3OOTedp6AgO2RJtgt9+zDblIISZEcSTm1t1wMR3rg8lOt
	JNyaA+AMWTyRFmOKly1g323uCeE+CYgHvBGlZJanIYqigBHl0GQSgKAoBZOwjcRolu+HXN+a4Rd
	4LifSXAxBhqcl82XkKwwREqr8Qx4aBrqwqmfBsImhrp5lIYERe+GQnxj6y4q7B90WtNS1oSsGKj
	p4mO4ajjiHC1Z7Kjejk=
X-Google-Smtp-Source: AGHT+IENrmQj5DGYVSm3Q09qGmnTTrno1aaNZTTYBKZd9OTNDs9cK+tqcXUkhkUUySX2J4NvRb6zbg==
X-Received: by 2002:a17:902:ea0a:b0:215:7ce8:1360 with SMTP id d9443c01a7336-215bd1287b4mr113659325ad.33.1733359334057;
        Wed, 04 Dec 2024 16:42:14 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3ea7fsm1412625ad.49.2024.12.04.16.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 16:42:13 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	platform-driver-x86@vger.kernel.org,
	w_armin@gmx.de
Subject: [RFC PATCH 09/21] alienware-wmi: Initialize WMI drivers
Date: Wed,  4 Dec 2024 21:41:51 -0300
Message-ID: <20241205004150.2185529-2-kuurtb@gmail.com>
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

Usually, laptop models only support one of the two WMI devices, however,
to avoid the risk of registering two platform devices with the same
name, the WMAX device driver is always preferred.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 48 ++++-------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 38e9cb80ae69..34fb59a14bc0 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -415,11 +415,11 @@ struct alienfx_platdata {
 	struct wmi_device *wdev;
 };
 
-static struct platform_device *platform_device;
 static struct platform_profile_handler pp_handler;
 static enum wmax_thermal_mode supported_thermal_profiles[PLATFORM_PROFILE_LAST];
 
 static u8 interface;
+static struct wmi_driver *preferred_wmi_driver;
 
 /*
  * Helpers used for zone control
@@ -1263,15 +1263,12 @@ static struct wmi_driver alienware_wmax_wmi_driver = {
 
 static int __init alienware_wmi_init(void)
 {
-	int ret;
-
-	if (wmi_has_guid(LEGACY_CONTROL_GUID))
-		interface = LEGACY;
-	else if (wmi_has_guid(WMAX_CONTROL_GUID))
+	if (wmi_has_guid(WMAX_CONTROL_GUID)) {
 		interface = WMAX;
-	else {
-		pr_warn("alienware-wmi: No known WMI GUID found\n");
-		return -ENODEV;
+		preferred_wmi_driver = &alienware_wmax_wmi_driver;
+	} else {
+		interface = LEGACY;
+		preferred_wmi_driver = &alienware_legacy_wmi_driver;
 	}
 
 	dmi_check_system(alienware_quirks);
@@ -1288,43 +1285,14 @@ static int __init alienware_wmi_init(void)
 			pr_warn("force_gmode requires platform profile support\n");
 	}
 
-	ret = platform_driver_register(&platform_driver);
-	if (ret)
-		goto fail_platform_driver;
-	platform_device = platform_device_alloc("alienware-wmi", PLATFORM_DEVID_NONE);
-	if (!platform_device) {
-		ret = -ENOMEM;
-		goto fail_platform_device1;
-	}
-	ret = platform_device_add(platform_device);
-	if (ret)
-		goto fail_platform_device2;
-
-	if (quirks->thermal) {
-		ret = create_thermal_profile();
-		if (ret)
-			goto fail_prep_thermal_profile;
-	}
-
-	return 0;
-
-fail_prep_thermal_profile:
-	platform_device_del(platform_device);
-fail_platform_device2:
-	platform_device_put(platform_device);
-fail_platform_device1:
-	platform_driver_unregister(&platform_driver);
-fail_platform_driver:
-	return ret;
+	return wmi_driver_register(preferred_wmi_driver);
 }
 
 module_init(alienware_wmi_init);
 
 static void __exit alienware_wmi_exit(void)
 {
-	remove_thermal_profile();
-	platform_device_unregister(platform_device);
-	platform_driver_unregister(&platform_driver);
+	wmi_driver_unregister(preferred_wmi_driver);
 }
 
 module_exit(alienware_wmi_exit);
-- 
2.47.1



Return-Path: <linux-kernel+bounces-435900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EE59E7E68
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEFE188787F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0870807;
	Sat,  7 Dec 2024 05:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4/FKX+b"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC024594A;
	Sat,  7 Dec 2024 05:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733549955; cv=none; b=uMkbH6jo1xU+mx82d3R35ydeFDZUId4kC5lQX6XsuTaOqZ0YfyxqLj/udYPv0w23dnokz3Z7a4Myual8Tej9L/DVxMDCJHX3Cst0f2430/aJ7ybtUA9lqz28sxBIM+2wptV99aiwPDYLRbupyydwm0gavHvG+kAoO1K+eMJYCE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733549955; c=relaxed/simple;
	bh=YWWkAPLgsC9HvBC/5hchGcJwyExXfdwOh0yeoajTagI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZxGJIMUKPxvFqCYH/z4WIhEvQzSZZfIHKXEbvFipKBdiBqfp7Eo8dTt4ILImSpg1pGPzXOMrPrTIx3JhV0atcl89rIT6if/alLOzaEgDKDFb2z1asXCQinFxSMsfpluhk9iMUTqlskFJpn88LhFPmpE0cwj+XxPnI6WSyJ1ciPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4/FKX+b; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7256dc42176so3020221b3a.3;
        Fri, 06 Dec 2024 21:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733549953; x=1734154753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb0QGhP4oxqcwOF1zvyWqvtr758gkOk3hVsSW2fV0lg=;
        b=U4/FKX+bwLgq7Mtj6XHdiE6O9nAMuMD61Ox1Y8qkB7RsTQSfOSyQKNLekpV+wL5ye6
         +9JRBnXHs0IxyyFpuJdMBpj7qMd7WUNP/n1dLpXEPpfYApiQOs9eAOOYtkJqWx3SlKro
         LqGZX+G83QNbVhJHkVw686l/3fSx3TeFmfOj4WNujcN3zEFZ9E7qDDupjg1YBojYcK3Z
         AXKWd5Wr2HwZq5zc/b9M/65zqoe0rByg7uh7L6nfRESnYhW8t60EIDln3dX4grsZgyNr
         mwCLpMy+LHY2L7KcWoqMAEAlosMQO2MoyKziPr39uKvhxCU9C5FTrPeOczUNw/S4o03Q
         QweA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733549953; x=1734154753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kb0QGhP4oxqcwOF1zvyWqvtr758gkOk3hVsSW2fV0lg=;
        b=e7MGfbXPeF+mt7LVcNiZnZD0SLD3GXycqt1SnP9TeIoc66+3QgzA9l/S2UGxavWxJF
         c8dAjslap+7+r8eS4XWCaje+/80xkq7oZ+VVc71dGVD06Bf7fPcDJR62mQ2B9QDAlRCq
         pVor/e0uCxWbx6jnlWj5n7aqoHyY3REwp/mdiMHVkArzn+SXUnWYp6/kWvHFnz/nKrei
         tFvclMX5QvsIx0ME+t/7sFoYXEMW+DwXUEbz12/psxbAt0m5/Dlnts7nQRiydAvS9mI5
         zyGyDk4UFH2c/iaywk8T2lKnlu7DlRg6mY0vlbxFvv7uOMYTShFjOr+Mkh+L8oa/PelC
         P/IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXhn5ySGb6WtMFjJ6fk0WvXCG8Uiz5MUXHtuVC+D6G8y2fMYTflnEwVo24w0jSxkiNxpvdVcDsxk0iFjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNTDD+YabzxToKus1Dst/tcDQ7lVE5gs2BbBi2551pmq9c6jj
	FFFas+OhJzpv4uL8ohaAvVp3FDj0EcpOxoUgI1CmSrgMfkpUjvd12FfQyg==
X-Gm-Gg: ASbGncsvy1xSBd2tNd/IWCEJUgtQnj+TNpJA0K/AKWMGBbDt01aqNyzoNtyNOlGLDOj
	gf7B6Y2gB1Vcp1hSOl7hHdrjXuIoRvCPP9V72gHw4bQ/R9j2gn4o6xWfBvRwSlNWnwHZy5QJMot
	pUm9JF5tLBqPs3upVIwqTq9chgBgujZxiG/dYxVQee0KS4RgVShwWaBH+L4KiRhdgcEGS0jxIMq
	Ib4lnNBSmHF71WKKrHaBa8UXUPfMVizclohFVI8tzIgWNV2VBt/yvKJo/V8e5DrGWSxxsjFjuCo
	PFQQYGGTKxPGz4Oi+O0=
X-Google-Smtp-Source: AGHT+IHU8UD9g3l/0tAj1CDKXl9g5F9vriFRMXYYRcE6+tsugcKTLARXo0ZBNOVjRxHMYEhXVGgTRA==
X-Received: by 2002:a05:6a00:2e1f:b0:725:2b93:3583 with SMTP id d2e1a72fcca58-725b8185650mr7142136b3a.21.1733549953119;
        Fri, 06 Dec 2024 21:39:13 -0800 (PST)
Received: from localhost.localdomain (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29c6ffdsm3806929b3a.14.2024.12.06.21.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 21:39:12 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: platform-driver-x86@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: Dell.Client.Kernel@dell.com,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	Kurt Borja <kuurtb@gmail.com>,
	Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH] alienware-wmi: Fix X Series and G Series quirks
Date: Sat,  7 Dec 2024 02:38:00 -0300
Message-ID: <20241207053759.99608-2-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devices that are known to support the WMI thermal interface do not
support the legacy LED control interface. Make `.num_zones = 0` and
avoid calling alienware_zone_init() if that's the case.

Verified by reading the ACPI tables of all supported devices.

Fixes: 9f6c43041552 ("alienware-wmi: added platform profile support")
Fixes: 1c1eb70e7d23 ("alienware-wmi: extends the list of supported models")

Suggested-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Suggested here:

[1] https://lore.kernel.org/platform-driver-x86/38399b6a-e31c-4b99-a10e-01dc20649c24@gmx.de/
---
 drivers/platform/x86/dell/alienware-wmi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 77465ed9b449..e69bf9a7b6c8 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -190,7 +190,7 @@ static struct quirk_entry quirk_asm201 = {
 };
 
 static struct quirk_entry quirk_g_series = {
-	.num_zones = 2,
+	.num_zones = 0,
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
@@ -199,7 +199,7 @@ static struct quirk_entry quirk_g_series = {
 };
 
 static struct quirk_entry quirk_x_series = {
-	.num_zones = 2,
+	.num_zones = 0,
 	.hdmi_mux = 0,
 	.amplifier = 0,
 	.deepslp = 0,
@@ -687,6 +687,9 @@ static void alienware_zone_exit(struct platform_device *dev)
 {
 	u8 zone;
 
+	if (!quirks->num_zones)
+		return;
+
 	sysfs_remove_group(&dev->dev.kobj, &zone_attribute_group);
 	led_classdev_unregister(&global_led);
 	if (zone_dev_attrs) {
@@ -1229,9 +1232,11 @@ static int __init alienware_wmi_init(void)
 			goto fail_prep_thermal_profile;
 	}
 
-	ret = alienware_zone_init(platform_device);
-	if (ret)
-		goto fail_prep_zones;
+	if (quirks->num_zones > 0) {
+		ret = alienware_zone_init(platform_device);
+		if (ret)
+			goto fail_prep_zones;
+	}
 
 	return 0;
 
-- 
2.47.1



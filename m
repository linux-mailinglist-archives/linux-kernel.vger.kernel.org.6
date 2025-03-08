Return-Path: <linux-kernel+bounces-552837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52360A57F41
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 23:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0FD3A79AF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 22:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D60B212B37;
	Sat,  8 Mar 2025 22:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zorr73sx"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C020D507;
	Sat,  8 Mar 2025 22:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471544; cv=none; b=RSx2k5CFTuKWAWgVjh52zs7k30gQPu6nDTCXocS4lWrjzNF7h3ru1xr/GhkNIdVBXbarHO70g+XZCtp/JBgNqb4JFkVvg3fb1qR8Mf6pg+MkBYxMySsaxLtvPndTPxdxQsnF2Zi0KezlfNjQS9hVw8eiCPvbWSle0h1cu4Dm8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471544; c=relaxed/simple;
	bh=nN77IwIGI648I3GigeBGrymFDuOUGS4FcvoASpty838=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iqu8gtJQksEMD0qMLySwddcAWcy+wewhmHduyP0Hbewc/wZgjwmC2Jz+yT0jLu7+hNPUd20GIwGtZsINV936AuZKCOI91/E1KA1GfKespAbDehJxAkgf3R/ZWrsCVlMhyK4j4MDmPruuJbUHAQN3S/FfxF1RrIyenCL5fhYfZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zorr73sx; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e60aef2711fso2146229276.2;
        Sat, 08 Mar 2025 14:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741471540; x=1742076340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+D/KgGcQ5CLqX0YETaEbqClPh8IeweKq2T0/hk3vpY=;
        b=Zorr73sx10rcMkujBpYAD6nxcJnMZjMSBgLgO3BmObw7yUs+QVGpijCbkAXKkg6mr3
         aCNt5X+gBMCltC0cK5vJIEaqde2Vl9zCNeXYs3rJwZX9nYb3quvtVByWLCZyF/pSdpjr
         5u1/OS66pQfNnCEFGWafv5GL8h5Qg9E5ybQX7i5jircarrIubtOoNOWQ5tULSm3MAD6c
         uoxxrJDwiTtE1jaMTnVQOkfSbZahabe6XDSRH58r/f6UluTuA8qIdYSMMxuOVCnwaGqk
         6NNtQLhiJKOtorrYLxXAAKl9hgwVZ8t98+tK5CxMOWOg/okEJ2LW3Vp5AjmVc1Cc9ZgH
         AXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741471540; x=1742076340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+D/KgGcQ5CLqX0YETaEbqClPh8IeweKq2T0/hk3vpY=;
        b=ER9SQ9vZpchasSzX0PXa4CwHfOVnV6PxAZHiduK07woLa7NXRlEW1ByKyyrqPL0p+c
         LKlshQMCycYWI06mdkWLSrBZ8e5tfyyEMFC8oe7JG+fmjli/cPF5bZv2UdABH33+f4TD
         A0qKjfZETVtEmDYsn+n7EHIeIG5RNaDNjYQevG9hY/HC2m/oy2bdxLhvJ6cufS4zvesd
         SV0aiVbvyzQiYZg7uPsZEpqQ2AIjyyS60LhBq3P4aTiiH8DAKJMXBgIoA1S9t6rQh8ol
         ucRdAIDgRiWiWe51qzzUZSt2gIoqd09tZLwN49NXwft6DLRw3XuxhRxDTyiSK0CXRyG1
         Djpg==
X-Forwarded-Encrypted: i=1; AJvYcCXu8E2L1KwggpkEtkhWowCGDQVHVH4W6Bn65cQieIu0dMTJzysCWAEelchwjBhB1WqUeOi/uuTQLMdFsv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNr8ULU4u0/SBvlWO/ss9oQrICodFrp3T2aXpnMtJf2y8HrLwN
	zGuwQCxEIXWn1yUJ5c+uwv/1cXUxMyLiSHlnBC+edyRzUK9LpkeD
X-Gm-Gg: ASbGncvwKjfVBj903U/hHkVuJH6Gay3DGa727T6PR0MrgqLF/zIIk297w54znhoH712
	yEter8rOudRHLAlGHmbVFxPAO6jdr3ixkJlPEJvBLTVGpO4wu5xpIpi64jJrbK1oPZnIL+xuMZ/
	p79dMrjQtzJ1QFPUyzZdW/ZwOu7Tgmvkuju+nyV158JJWVI9gTVoGyxHgS13wGMllB4fS9TB8dy
	6Uv1R1JHhY9PvtIa9eW7a/Fi4yrDXmogj1fk/+lxpY0poBoTnXftkj8zux5KWdLIIw72ujIRvRG
	xewf/EW4rsTRynrlJU4JY6Lfnrcj5LdhIZe+2gaHuxRsKw==
X-Google-Smtp-Source: AGHT+IFVkxXSEszfNFyFTlcAc0j70OOH8Rf06Fmp9HH9nzpLq/9xQu/1NWywZ0uRHD2tLqK6o69udg==
X-Received: by 2002:a05:6902:3307:b0:e5a:e604:78df with SMTP id 3f1490d57ef6-e635c163099mr9462858276.17.1741471540347;
        Sat, 08 Mar 2025 14:05:40 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:9e61:1a62:1a8c:3e62])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e634b8e8ef6sm1524824276.36.2025.03.08.14.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 14:05:40 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 08 Mar 2025 17:05:28 -0500
Subject: [PATCH RFC 1/2] platform/x86: wmi: Add
 wmidev_get_acpi_device_uid()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250308-awcc-uid-v1-1-6360892d8b95@gmail.com>
References: <20250308-awcc-uid-v1-0-6360892d8b95@gmail.com>
In-Reply-To: <20250308-awcc-uid-v1-0-6360892d8b95@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dell.Client.Kernel@dell.com, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2

Add a non-deprecated version of wmi_get_acpi_device_uid().

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/wmi.c | 12 +++++++++---
 include/linux/wmi.h        |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index e46453750d5f1475eb87342b1c5fd04fe20df335..e5ccea1fba4ffcd1ec96dd03cb3fae1dfc6737ef 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -636,7 +636,6 @@ EXPORT_SYMBOL_GPL(wmi_has_guid);
  */
 char *wmi_get_acpi_device_uid(const char *guid_string)
 {
-	struct wmi_block *wblock;
 	struct wmi_device *wdev;
 	char *uid;
 
@@ -644,8 +643,7 @@ char *wmi_get_acpi_device_uid(const char *guid_string)
 	if (IS_ERR(wdev))
 		return NULL;
 
-	wblock = container_of(wdev, struct wmi_block, dev);
-	uid = acpi_device_uid(wblock->acpi_device);
+	uid = wmidev_get_acpi_device_uid(wdev);
 
 	wmi_device_put(wdev);
 
@@ -653,6 +651,14 @@ char *wmi_get_acpi_device_uid(const char *guid_string)
 }
 EXPORT_SYMBOL_GPL(wmi_get_acpi_device_uid);
 
+char *wmidev_get_acpi_device_uid(struct wmi_device *wdev)
+{
+	struct wmi_block *wblock = container_of(wdev, struct wmi_block, dev);
+
+	return acpi_device_uid(wblock->acpi_device);
+}
+EXPORT_SYMBOL_GPL(wmidev_get_acpi_device_uid);
+
 /*
  * sysfs interface
  */
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index 10751c8e5e6a0ad3ac9ae317b6f8ecfb14c9a983..625c52ee125219aaa23cf946333af33ad118aafa 100644
--- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -46,6 +46,8 @@ extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
 
 acpi_status wmidev_block_set(struct wmi_device *wdev, u8 instance, const struct acpi_buffer *in);
 
+char *wmidev_get_acpi_device_uid(struct wmi_device *wdev);
+
 u8 wmidev_instance_count(struct wmi_device *wdev);
 
 /**

-- 
2.48.1



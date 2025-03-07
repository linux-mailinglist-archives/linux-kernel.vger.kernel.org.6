Return-Path: <linux-kernel+bounces-550161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632AA55C07
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72851189EA9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674FF610B;
	Fri,  7 Mar 2025 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ImY7Pnmu"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFFB67A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741307455; cv=none; b=KNGWgvcR8njKFjDzSkz47szXNSZZ1ciyZl8jU/chts9tRFUbT7ChSmINvFZy/lPrZrSKcN9skSCEgsV6+/diNzCLzC8/+w6zhFtX4DnxAQf1s7Sq/Ayfoc5Og0fwB3MMkMHZGjo28qvtUrqyCybKP/KlRZk9gGgh8qSnLCPjExs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741307455; c=relaxed/simple;
	bh=7MhYfXHkOQ8ZGIdLgjMd9C0x4UCj8Oh6u+dyk4mmFgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QyEs14gpAn3vibfCS3WKP3xfayyIGabTynnoV7Fiot+W1VAaxXJPIZfjlXSphZOJHTSXu9MC4VlpTzBh5aifbVuR73glpC/uQyKqDIsrKTe6r2QX1ezk8Tes1elrH1iAZ07HX1IaU18pWZlu5reXI5wufJmVvkhxtR28supT7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ImY7Pnmu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so8267185e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 16:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1741307452; x=1741912252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa6mPo22G4sJ0z9oS69CQS4FeNayLpuAbfup6CaM7pE=;
        b=ImY7Pnmu3dOI7zvuwy6Euib94fjJKnziE/9m2rbsK+MFMmsMK175pU4MS2Ep+l0g7l
         agoVHbvZJCbmzog5GkWUKnGx5kYjosxbhp4EiT/luUFSFzU06vA+8TNHlwLzYyBcolUy
         h1eeFdyyj+LPnRRjhDQyM652yIwk8fF306DUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741307452; x=1741912252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pa6mPo22G4sJ0z9oS69CQS4FeNayLpuAbfup6CaM7pE=;
        b=sUzYJY4hnGurV2y1DcOhtRdgZObuKN2CKXCiXj9APHQqIv5sDnWoP62Ryax5CJr0RY
         y7KneE8Mv66S+/DyoBKWvxsSLuyymxPAn2ydwcDf/JGs+bJ5qn8GecbNZT49eeh1yDn5
         X/3S+QHemZDduGYIdHniwu/Qxzgvk5LDdkkfA+gkH66x75PHU4gF6BEKdxnDDO9kBAGT
         Z0eAZStUGBE9IKGj2S8NdUDRAlD+ehzL422hhwQNjT4GHksLILmg7xY3qRzBYvrCKL33
         bXgF4RO4wqsWiGQ3wgYhiVW3AY0Apn/oI8Ni/1Ed2ZoDrEd1aH7uBcqXm/Nybcen+s02
         iTWA==
X-Gm-Message-State: AOJu0YygiHRggl17S4/9OMmlwi71ivFa+NJrc3lv5UNfcvHyEu31ok9/
	dBwZdYFkr6KUB8Ee8d8UhEOn2RqcUfw91y6xB5xuEBkW1PfvybhS5Ot/1qzWaOK4iJXhnIyAL5G
	I
X-Gm-Gg: ASbGncsL2jMnf0yzby3TCaKEYLdl3Mhfky+0OD9yeXBw/JHYPuCXwcxQtET8HhQMVot
	ZBK867TpiU/32dH8N6B++dUqdAX7QdGF7wdaln5tFPzJ/cEmevMDYX21eV0KSkkDsq54c9HhdAx
	ulgjYHCPQ2uFyp0KTHNMYZf6bwuk0bQsE6Ye1F//KFPqxZjJZZSiKmE4XPL3Vb+o7YUXOcfSyhR
	Um+Kz5Q67qn6ICpmamGirs+c+N6+i4zAM+qx1WVIbe6lhdpXO1dlnIhuxXw7JKKRmfSiv/d+mQT
	qmEj4gDMaDHlGh+3iFgcSaR7XvNSsHxxVt+5OlXu9dqUVLRAn2GH3GGKeM39JxERHIDF7p9kRLg
	4U/ErAROaoq1tO6tXi2f+471+
X-Google-Smtp-Source: AGHT+IGVZJThV1qmi+NzjmxwvK467nmPprXOwsU/4RMo3ydzzEtJK/8fcYrXtodVk9VX4LGgAYMPQg==
X-Received: by 2002:a05:600c:1616:b0:43b:c965:5f1d with SMTP id 5b1f17b1804b1-43bdb3e17f0mr43241655e9.15.1741307451717;
        Thu, 06 Mar 2025 16:30:51 -0800 (PST)
Received: from andrewcoop.eng.citrite.net (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c28f5sm34378305e9.9.2025.03.06.16.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 16:30:51 -0800 (PST)
From: Andrew Cooper <andrew.cooper3@citrix.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Richard Gong <richard.gong@amd.com>,
	Juergen Gross <jgross@suse.com>
Subject: x86/amd_nb: Use rdmsr_safe() in amd_get_mmconfig_range()
Date: Fri,  7 Mar 2025 00:28:46 +0000
Message-Id: <20250307002846.3026685-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Xen doesn't offer MSR_FAM10H_MMIO_CONF_BASE to all guests.  This results
in the following warning:

  unchecked MSR access error: RDMSR from 0xc0010058 at rIP: 0xffffffff8101d19f (xen_do_read_msr+0x7f/0xa0)
  Call Trace:
   xen_read_msr+0x1e/0x30
   amd_get_mmconfig_range+0x2b/0x80
   quirk_amd_mmconfig_area+0x28/0x100
   pnp_fixup_device+0x39/0x50
   __pnp_add_device+0xf/0x150
   pnp_add_device+0x3d/0x100
   pnpacpi_add_device_handler+0x1f9/0x280
   acpi_ns_get_device_callback+0x104/0x1c0
   acpi_ns_walk_namespace+0x1d0/0x260
   acpi_get_devices+0x8a/0xb0
   pnpacpi_init+0x50/0x80
   do_one_initcall+0x46/0x2e0
   kernel_init_freeable+0x1da/0x2f0
   kernel_init+0x16/0x1b0
   ret_from_fork+0x30/0x50
   ret_from_fork_asm+0x1b/0x30

based on quirks for a "PNP0c01" device.  Treating MMCFG as disabled is the
right course of action, so no change is needed there.

This was most likely exposed by fixing the Xen MSR accessors to not be
silently-safe.

Fixes: 3fac3734c43a ("xen/pv: support selecting safe/unsafe msr accesses")
Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>
CC: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>
CC: Richard Gong <richard.gong@amd.com>
CC: Juergen Gross <jgross@suse.com>
CC: linux-kernel@vger.kernel.org

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 11fac09e3a8c..90e58b4e8237 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -143,7 +143,6 @@ bool __init early_is_amd_nb(u32 device)
 
 struct resource *amd_get_mmconfig_range(struct resource *res)
 {
-	u32 address;
 	u64 base, msr;
 	unsigned int segn_busn_bits;
 
@@ -151,13 +150,11 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 	    boot_cpu_data.x86_vendor != X86_VENDOR_HYGON)
 		return NULL;
 
-	/* assume all cpus from fam10h have mmconfig */
-	if (boot_cpu_data.x86 < 0x10)
+	/* Assume CPUs from fam10h have mmconfig, although not all VMs do */
+	if (boot_cpu_data.x86 < 0x10 ||
+	    rdmsrl_safe(MSR_FAM10H_MMIO_CONF_BASE, &msr))
 		return NULL;
 
-	address = MSR_FAM10H_MMIO_CONF_BASE;
-	rdmsrl(address, msr);
-
 	/* mmconfig is not enabled */
 	if (!(msr & FAM10H_MMIO_CONF_ENABLE))
 		return NULL;


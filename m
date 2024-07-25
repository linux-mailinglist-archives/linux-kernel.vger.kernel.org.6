Return-Path: <linux-kernel+bounces-261865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAC393BD20
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71416283EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5876E172791;
	Thu, 25 Jul 2024 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="gQ4hkxUL"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55B16F85A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892720; cv=none; b=kk3jhhbcJCKJzoKyju63doCd7NeeOL1yEFs7zuh2v+EHuDf2kAJI2K2QtNBXXOZzOuhb6IofVIi5gapBv979ReTUL3fQE0JGsKwwjvjmDXJuJl35i7aR5eq6a0ODB3nyoevNqTcLNVcdBvPYK5cONcA4nHdpclnKSOnNGtKJlDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892720; c=relaxed/simple;
	bh=o8NUO49pyls0LZ2Byzt8r39bjxdRCntAoRgx4xOCnJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIpBo/QuB73Rg9OFXDgdXDHau5SE1cDtOj3O+rcL9YVhYNYdS6GzpSfbQAgAAbd9ldKQt+M5GesR44T+MC0HK/ZBB1xl3n8t/c1wjlutxRpRNpVUhH4pSn0fzPX0p3YQbTQfI4x164yF2wpGoFB9z9s0nfO5AURMZBkr0z+OLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=gQ4hkxUL; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c791729c36so381091eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1721892718; x=1722497518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRJmNl7Bb9/OZ0AorI+0NK/6Qn825Rg5jazvccIBXIg=;
        b=gQ4hkxUL8iH8fvzCCOX3gkis3y5egyQ2IexB2KgKVFslG2QtQoe7fmgu+GryT/ULWE
         vUE6evuEZC18+8W3ajGoQV9KHEtn54v7gn6lAvT/6QD3Ps73DrtqbqzyCVGABxNbV5+z
         RYZyS42VLsHpuOjT0B0ycZcSG3sN1aayaCI7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721892718; x=1722497518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRJmNl7Bb9/OZ0AorI+0NK/6Qn825Rg5jazvccIBXIg=;
        b=oMbQDOsP6WQCgZ7u9uF0gcQR95Sj5Dh/wAlfGBH+H3tUcXZqwI7S0LiPZ6QtsiCSRy
         +dpW6tt0KMNYAffL0g2rluBQq0Nydx3nx7gfAf3S3XseKv/Cijld/5f+3wPDUXZy+mpy
         QOiG49zddksirbYIrJ4fJIlHOhZgvOAz17Zys3rLIA+aqWS9K5uPic4P1vaoJ8xD4LYS
         EvII6xnekoYcTCQSR5gA04pf2VaE01+d4Nmg2bl9mD+zutMr8z5njnF+FdGD1byrYy7Y
         Q/sXjY/NAgebowx16Sxi6AJ5sU1vv6IM08yBrqwP91mADqJH6RHWcdGE3Yi8YIWKxAyv
         M5qw==
X-Forwarded-Encrypted: i=1; AJvYcCVTG2cSOcydAwUShNikBka4pT4mLc8DeU4E/00/mMOQByJ2LcKpRZ1dZX4dJdv9ciPJCLldCmdBOtPciN+SMeW4R80flKVA9t8o68I7
X-Gm-Message-State: AOJu0YxI6QaZZwyxsvdYeRIlJ/1SuQ6+Zagi+rHqgQjtgTRZIy6G4NVm
	tXKjWFTscCXsDcM8Jip7MUzDJ6iLYR4WIbPh9asMIZnwqeOMCuMqF9uwdyg4klU=
X-Google-Smtp-Source: AGHT+IFCNLG+ST0ZSsb5RJ0EWHwiIT/DnYl4e0Leyodh0YVdE/18MhaBFG2YoCxWCCHPvCxSvB4InQ==
X-Received: by 2002:a05:6358:2829:b0:1ac:ed54:224d with SMTP id e5c5f4694b2df-1acf8878d6fmr282666955d.11.1721892717619;
        Thu, 25 Jul 2024 00:31:57 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44fe8416381sm3660701cf.93.2024.07.25.00.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:31:57 -0700 (PDT)
From: Roger Pau Monne <roger.pau@citrix.com>
To: xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Roger Pau Monne <roger.pau@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/xen: move xen_reserve_extra_memory()
Date: Thu, 25 Jul 2024 09:31:14 +0200
Message-ID: <20240725073116.14626-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725073116.14626-1-roger.pau@citrix.com>
References: <20240725073116.14626-1-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In preparation for making the function static.

No functional change.

Fixes: 38620fc4e893 ('x86/xen: attempt to inflate the memory balloon on PVH')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Since this is a pre-requisite for a bugfix, I've tagged it with "Fixes:", not
sure if that's appropriate or there's some better tag to use.
---
 arch/x86/xen/enlighten_pvh.c | 96 ++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 27a2a02ef8fb..91c6db4ec054 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -27,54 +27,6 @@
 bool __ro_after_init xen_pvh;
 EXPORT_SYMBOL_GPL(xen_pvh);
 
-void __init xen_pvh_init(struct boot_params *boot_params)
-{
-	u32 msr;
-	u64 pfn;
-
-	xen_pvh = 1;
-	xen_domain_type = XEN_HVM_DOMAIN;
-	xen_start_flags = pvh_start_info.flags;
-
-	msr = cpuid_ebx(xen_cpuid_base() + 2);
-	pfn = __pa(hypercall_page);
-	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
-
-	if (xen_initial_domain())
-		x86_init.oem.arch_setup = xen_add_preferred_consoles;
-	x86_init.oem.banner = xen_banner;
-
-	xen_efi_init(boot_params);
-
-	if (xen_initial_domain()) {
-		struct xen_platform_op op = {
-			.cmd = XENPF_get_dom0_console,
-		};
-		int ret = HYPERVISOR_platform_op(&op);
-
-		if (ret > 0)
-			xen_init_vga(&op.u.dom0_console,
-				     min(ret * sizeof(char),
-					 sizeof(op.u.dom0_console)),
-				     &boot_params->screen_info);
-	}
-}
-
-void __init mem_map_via_hcall(struct boot_params *boot_params_p)
-{
-	struct xen_memory_map memmap;
-	int rc;
-
-	memmap.nr_entries = ARRAY_SIZE(boot_params_p->e820_table);
-	set_xen_guest_handle(memmap.buffer, boot_params_p->e820_table);
-	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
-	if (rc) {
-		xen_raw_printk("XENMEM_memory_map failed (%d)\n", rc);
-		BUG();
-	}
-	boot_params_p->e820_entries = memmap.nr_entries;
-}
-
 /*
  * Reserve e820 UNUSABLE regions to inflate the memory balloon.
  *
@@ -141,3 +93,51 @@ void __init xen_reserve_extra_memory(struct boot_params *bootp)
 		xen_add_extra_mem(PFN_UP(e->addr), pages);
 	}
 }
+
+void __init xen_pvh_init(struct boot_params *boot_params)
+{
+	u32 msr;
+	u64 pfn;
+
+	xen_pvh = 1;
+	xen_domain_type = XEN_HVM_DOMAIN;
+	xen_start_flags = pvh_start_info.flags;
+
+	msr = cpuid_ebx(xen_cpuid_base() + 2);
+	pfn = __pa(hypercall_page);
+	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
+
+	if (xen_initial_domain())
+		x86_init.oem.arch_setup = xen_add_preferred_consoles;
+	x86_init.oem.banner = xen_banner;
+
+	xen_efi_init(boot_params);
+
+	if (xen_initial_domain()) {
+		struct xen_platform_op op = {
+			.cmd = XENPF_get_dom0_console,
+		};
+		int ret = HYPERVISOR_platform_op(&op);
+
+		if (ret > 0)
+			xen_init_vga(&op.u.dom0_console,
+				     min(ret * sizeof(char),
+					 sizeof(op.u.dom0_console)),
+				     &boot_params->screen_info);
+	}
+}
+
+void __init mem_map_via_hcall(struct boot_params *boot_params_p)
+{
+	struct xen_memory_map memmap;
+	int rc;
+
+	memmap.nr_entries = ARRAY_SIZE(boot_params_p->e820_table);
+	set_xen_guest_handle(memmap.buffer, boot_params_p->e820_table);
+	rc = HYPERVISOR_memory_op(XENMEM_memory_map, &memmap);
+	if (rc) {
+		xen_raw_printk("XENMEM_memory_map failed (%d)\n", rc);
+		BUG();
+	}
+	boot_params_p->e820_entries = memmap.nr_entries;
+}
-- 
2.45.2



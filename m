Return-Path: <linux-kernel+bounces-261867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F33F93BD24
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200AF1F225EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F9C172BDF;
	Thu, 25 Jul 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="EpxaULCZ"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5817279E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892723; cv=none; b=LkXOkcZYJl5GbdcYKMUXKo+/WAsiWMfDZXZm/DFLuHVM1fFsz3Ak5OLZdnnskYYmnMrq4XFFvPeNL9K0nE4P52pr9XpHSnstgb9Yxkp4DjPsGE/2/BYJ+IWwFaLsOwJwYaShRIMJbGX9V223jijM/NBbkDoKGBnQ/TAPL/mW94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892723; c=relaxed/simple;
	bh=fyrhbCXnlByRYnhG528ptI2X/mfEToljyaGXElZ8V0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4HW6kNtxIWka9tx0KAlLZ+yzJycpcMmsSVjs6p50dT8KDPyzQw3m4naddMS2ruPnXlYi8uK+4Sxy9/U439pBznhzg9igAneRfjTqW+rDg4hb5BEogXr/GnxF3fFrCa1e1oqIlMK4KLFrW/FQlMEZ0JPhM6uxjQrhMC3kDMuPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=EpxaULCZ; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b7a0ef0e75so3700036d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1721892720; x=1722497520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GVlNStJvrT8ORCcRB8+CmsmV0FyqBN6Hy+p1P9rZbw=;
        b=EpxaULCZ7JOiGQLmE1TnbjDGmWohdaOPbAlwX5Hn274vCo2ZbPaMPahJ7P804uKHR/
         n4u7ETXPohG0PBU5QNad2IduOmc62RMIukCbhKhOh0RldmWyC9GvZJjxzAf2J32ITy8I
         /4kLE47kwNJ6Z9YXXQGJg5dN/rAowHXBIGiZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721892720; x=1722497520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GVlNStJvrT8ORCcRB8+CmsmV0FyqBN6Hy+p1P9rZbw=;
        b=r6kl4yjOLuVL1Kyt1nUUXA4Oi/L3J3iT1bYFvBzLNYADJKiRspF4QlateArACO/3FF
         fdV19JDykrgmS0nuLjRhQonFNsJgOfmtrV3wS0HX6f+NdvChkpDwuobGIXMBVBPebwBv
         dIY1hgjEJlv0sGeJWb3nzRfkedM0dS9cjKsyQ3jxa5tC+j/Krk6W//fPeBG61DolUdES
         4Qidow/Z6NQDxGP2M9ukNK8FcVkDmQWP+t0zXk3N3Jjs9rDOAwlLanXjXKDA6OfPqpFp
         6BwUNEYde6OoA12WGVzn32yLDxr2RCxAkiB+DoPtYLP1hF28eeqAL7UP/peieSSpqpWC
         F5jg==
X-Forwarded-Encrypted: i=1; AJvYcCXjmQUCJrOrsiR0RNTt1hPaJFbqdv7nBonwxbwxeLGKnspxihmSHv5udTmUxY2naEfZcJQdCQBe8nhqMLcmlOuQOBX5HSBgtlwCVe0s
X-Gm-Message-State: AOJu0Yx7Ot16d4io/soFkPOE+pJRMNmUWBgY9+uJpw4fXcz9iwyfY92/
	LSfT5L5/aqH5jgRVA1xpCcgxIrWEt3zmHo5tIQZpfe7w6Ip+dbOSktvtDcesDF8=
X-Google-Smtp-Source: AGHT+IHfDJbquxK4yoeiAtgbU0j7N/IGyrHV9CdR7h6snx/JBoTzCuXUsX3oxBVqaoEeHvgUuwnjCQ==
X-Received: by 2002:a05:6214:202f:b0:6b0:6dba:c947 with SMTP id 6a1803df08f44-6bb40700306mr13763466d6.18.1721892720336;
        Thu, 25 Jul 2024 00:32:00 -0700 (PDT)
Received: from localhost ([213.195.124.163])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f9143e1sm4321446d6.61.2024.07.25.00.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:31:59 -0700 (PDT)
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
Subject: [PATCH 2/2] x86/xen: fix memblock_reserve() usage on PVH
Date: Thu, 25 Jul 2024 09:31:15 +0200
Message-ID: <20240725073116.14626-3-roger.pau@citrix.com>
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

The current usage of memblock_reserve() in init_pvh_bootparams() is done before
the .bss is zeroed, and that used to be fine when
memblock_reserved_init_regions implicitly ended up in the .meminit.data
section.  However after commit 73db3abdca58c memblock_reserved_init_regions
ends up in the .bss section, thus breaking it's usage before the .bss is
cleared.

Move and rename the call to xen_reserve_extra_memory() so it's done in the
x86_init.oem.arch_setup hook, which gets executed after the .bss has been
zeroed, but before calling e820__memory_setup().

Fixes: 38620fc4e893 ('x86/xen: attempt to inflate the memory balloon on PVH')
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
While the commit that introduced the user-noticeable regression is
73db3abdca58c, I think 38620fc4e893 should have been more careful to not
initialize the memblock ranges ahead of the .bss zeroing.
---
 arch/x86/include/asm/xen/hypervisor.h |  5 -----
 arch/x86/platform/pvh/enlighten.c     |  3 ---
 arch/x86/xen/enlighten_pvh.c          | 15 ++++++++++++---
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
index 64fbd2dbc5b7..a9088250770f 100644
--- a/arch/x86/include/asm/xen/hypervisor.h
+++ b/arch/x86/include/asm/xen/hypervisor.h
@@ -62,11 +62,6 @@ void xen_arch_unregister_cpu(int num);
 #ifdef CONFIG_PVH
 void __init xen_pvh_init(struct boot_params *boot_params);
 void __init mem_map_via_hcall(struct boot_params *boot_params_p);
-#ifdef CONFIG_XEN_PVH
-void __init xen_reserve_extra_memory(struct boot_params *bootp);
-#else
-static inline void xen_reserve_extra_memory(struct boot_params *bootp) { }
-#endif
 #endif
 
 /* Lazy mode for batching updates / context switch */
diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 8c2d4b8de25d..944e0290f2c0 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -75,9 +75,6 @@ static void __init init_pvh_bootparams(bool xen_guest)
 	} else
 		xen_raw_printk("Warning: Can fit ISA range into e820\n");
 
-	if (xen_guest)
-		xen_reserve_extra_memory(&pvh_bootparams);
-
 	pvh_bootparams.hdr.cmd_line_ptr =
 		pvh_start_info.cmdline_paddr;
 
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 91c6db4ec054..728a4366ca85 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -9,6 +9,7 @@
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
+#include <asm/setup.h>
 
 #include <xen/xen.h>
 #include <asm/xen/interface.h>
@@ -41,8 +42,9 @@ EXPORT_SYMBOL_GPL(xen_pvh);
  * hypervisor should notify us which memory ranges are suitable for creating
  * foreign mappings, but that's not yet implemented.
  */
-void __init xen_reserve_extra_memory(struct boot_params *bootp)
+static void __init pvh_reserve_extra_memory(void)
 {
+	struct boot_params *bootp = &boot_params;
 	unsigned int i, ram_pages = 0, extra_pages;
 
 	for (i = 0; i < bootp->e820_entries; i++) {
@@ -94,6 +96,14 @@ void __init xen_reserve_extra_memory(struct boot_params *bootp)
 	}
 }
 
+static void __init pvh_arch_setup(void)
+{
+	pvh_reserve_extra_memory();
+
+	if (xen_initial_domain())
+		xen_add_preferred_consoles();
+}
+
 void __init xen_pvh_init(struct boot_params *boot_params)
 {
 	u32 msr;
@@ -107,8 +117,7 @@ void __init xen_pvh_init(struct boot_params *boot_params)
 	pfn = __pa(hypercall_page);
 	wrmsr_safe(msr, (u32)pfn, (u32)(pfn >> 32));
 
-	if (xen_initial_domain())
-		x86_init.oem.arch_setup = xen_add_preferred_consoles;
+	x86_init.oem.arch_setup = pvh_arch_setup;
 	x86_init.oem.banner = xen_banner;
 
 	xen_efi_init(boot_params);
-- 
2.45.2



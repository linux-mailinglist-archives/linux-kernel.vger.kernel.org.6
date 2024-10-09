Return-Path: <linux-kernel+bounces-357430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75917997122
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990851C20441
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3D01E32AD;
	Wed,  9 Oct 2024 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q8mV3SKL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DB1E909A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490155; cv=none; b=RFFswpAdx+sg6W5Wg5fgECpTpZwWLKCJKFpISzpYVA7aTmeYKUscQeQQcvFDHaPTA3LFimfWkVlU5K9VROJO2GZs1lyEYr51tJGMsN0goTpQMpufeB1Ug7g1U4Da7AFDWwDDeW83EH2wAbT+dyRK1tqkpY7nFEyfw47MPRBt8ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490155; c=relaxed/simple;
	bh=fwh5LXxdisltEp+RjBo75HomKfALPkDu+Kt+4I1wDxo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qeqA8y+0S89XSMYICkwx21eZaflMa7PRmrGBlhNSQMfvsjsC4WDHXT2n+dgMzPw+imsTFfFe6uvS9DYEqrmq71kUe1ARE6jECJqqwgMpeuuEV93VwQKEMkaaq3zf90DYBGyZJ9AHC+dbGhVku6W+Qg7qG4zpyO+DrtE8nt2i7Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q8mV3SKL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e26046ed465so10046461276.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 09:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728490153; x=1729094953; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qfTuALibAeUjzZyHnaTNb0n9bb4hHeONDW14sDZ6lQE=;
        b=Q8mV3SKLOa7OAr/a60BanxS+wLxXdBCbZU7NDBXrIHyCcevM633xUppNvPqGgKRJ1N
         ADt/zGyT3CvYaMMfN2pHZAZekLMd+PrUOzr2u/ozrpYSS793d1Hyy+CwKJ+GnW2R3q3f
         z+KjPhzsUxJBc16M/t5E9WvHMDrKrWZBFdlGqoESAgoE5wQFEG+Eziyqa9rrTmugpulx
         OmfEDDMSo9BK0MBfTQKlU8oxR20SdGXgmN1IfK8fxqN2bmSQE6vCDWreHOnyPp2xPiKm
         De7Q+/GacVDrER7foYehJxbJz3JvDKreszeq0TjPnxKOnUmEqkQCgGsNczTWEJELMkvP
         /++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728490153; x=1729094953;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qfTuALibAeUjzZyHnaTNb0n9bb4hHeONDW14sDZ6lQE=;
        b=Fbvld5fQU9tF3WdmAoeX4G3gMQIJy4iA+GziKoAHngyOUTEcd2SmhyNh0/GYr2QG6q
         flPeJZf4UhKnoL5UUNhhQU+bib/xLJZzsJDQftUA2iK9Ov9+NOR56QrMlamEiJSvF87S
         5T/wnxw9M1X8okM66PJXHF/FpPETf0dmlUFOqGmPGEsw5vyg1ltImLR1mGybU0jpjVo6
         +Q/WBYlGjQuVB6JDrCdY2DgHDJGQmBPX+vdaA4z76wLg28A6rFZogrzMJdminwfBv8Pq
         b5MSy1o9aYphs2bsJ7RJ3U9LSbBGixyZyE1/U9AOLelIN9b8L8bk5LOkaQV5CEcTRCTJ
         l3ew==
X-Gm-Message-State: AOJu0YwCWy02N+gnKhwIoqP1jV0bvyDSitxbV84TtOweY8MFHuZI+Im+
	xFbvdUB12DEA6dczdgFsqHREjK8TBjbUC47NTWPblguUwdljcM6JEIDf5iRmYfRTus3/GvkVMVM
	kkEGifr7ViNEnei5Jo3JDhTZtOr306rP6Q8GMWCGW5x7DcsBFR3GXMmpwhIY6B5zJxbAUpnkGFc
	n3i3X6PxNMNwiSL52Nspp133UfLLWkDQ==
X-Google-Smtp-Source: AGHT+IGSwzDDwa9vfi8McEdFMoR0PLLZMRY7iqvUgt19TSvNHlS6capqTKRHK6X82aIm2RwCa+IhAMD6
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:df09:0:b0:e28:fc1c:eb4d with SMTP id
 3f1490d57ef6-e28fe32b721mr58962276.1.1728490153207; Wed, 09 Oct 2024 09:09:13
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:04:43 +0200
In-Reply-To: <20241009160438.3884381-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009160438.3884381-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4449; i=ardb@kernel.org;
 h=from:subject; bh=AQt8zs3Emx4CUUaeR6x58jNDJibSKr6ifPlMsbVG+cQ=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1t5ZwCb7dpkU8nOf9OFdq2+mPT7Qerpm6yWpi6sTF9c
 YQ2O+P9jlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRHfMZ/vA9beh7s984n3lF
 nbt8C5vrhH0L+bUzNWZc2rptzvfbi9Yz/C/2LdZQ9yvoyEoxXnp71/ubzTvKvmpbXurczZbm/Dj kCAcA
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009160438.3884381-11-ardb+git@google.com>
Subject: [PATCH v3 4/5] x86/xen: Avoid relocatable quantities in Xen ELF notes
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jason Andryuk <jason.andryuk@amd.com>, 
	Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Xen puts virtual and physical addresses into ELF notes that are treated
by the linker as relocatable by default. Doing so is not only pointless,
given that the ELF notes are only intended for consumption by Xen before
the kernel boots. It is also a KASLR leak, given that the kernel's ELF
notes are exposed via the world readable /sys/kernel/notes.

So emit these constants in a way that prevents the linker from marking
them as relocatable. This involves place-relative relocations (which
subtract their own virtual address from the symbol value) and linker
provided absolute symbols that add the address of the place to the
desired value.

Tested-by: Jason Andryuk <jason.andryuk@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 19 +++++++++++++++++++
 arch/x86/platform/pvh/head.S  |  6 +++---
 arch/x86/tools/relocs.c       |  1 +
 arch/x86/xen/xen-head.S       |  6 ++++--
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6726be89b7a6..495f88c9d9f8 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -527,3 +527,22 @@ INIT_PER_CPU(irq_stack_backing_store);
 #endif
 
 #endif /* CONFIG_X86_64 */
+
+/*
+ * The symbols below are referenced using relative relocations in the
+ * respective ELF notes. This produces build time constants that the
+ * linker will never mark as relocatable. (Using just ABSOLUTE() is not
+ * sufficient for that).
+ */
+#ifdef CONFIG_XEN
+#ifdef CONFIG_XEN_PV
+xen_elfnote_entry_value =
+	ABSOLUTE(xen_elfnote_entry) + ABSOLUTE(startup_xen);
+#endif
+xen_elfnote_hypercall_page_value =
+	ABSOLUTE(xen_elfnote_hypercall_page) + ABSOLUTE(hypercall_page);
+#endif
+#ifdef CONFIG_PVH
+xen_elfnote_phys32_entry_value =
+	ABSOLUTE(xen_elfnote_phys32_entry) + ABSOLUTE(pvh_start_xen - LOAD_OFFSET);
+#endif
diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 7ca51a4da217..e6f39d77f0b4 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -52,7 +52,7 @@
 #define PVH_CS_SEL		(PVH_GDT_ENTRY_CS * 8)
 #define PVH_DS_SEL		(PVH_GDT_ENTRY_DS * 8)
 
-SYM_CODE_START_LOCAL(pvh_start_xen)
+SYM_CODE_START(pvh_start_xen)
 	UNWIND_HINT_END_OF_STACK
 	cld
 
@@ -300,5 +300,5 @@ SYM_DATA_END(pvh_level2_kernel_pgt)
 		     .long KERNEL_IMAGE_SIZE - 1)
 #endif
 
-	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,
-	             _ASM_PTR (pvh_start_xen - __START_KERNEL_map))
+	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY, .global xen_elfnote_phys32_entry;
+		xen_elfnote_phys32_entry: _ASM_PTR xen_elfnote_phys32_entry_value - .)
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index c101bed61940..3ede19ca8432 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -56,6 +56,7 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 	[S_ABS] =
 	"^(xen_irq_disable_direct_reloc$|"
 	"xen_save_fl_direct_reloc$|"
+	"xen_elfnote_.+_offset$|"
 	"VDSO|"
 	"__kcfi_typeid_|"
 	"__crc_)",
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 758bcd47b72d..7f6c69dbb816 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -94,7 +94,8 @@ SYM_CODE_END(xen_cpu_bringup_again)
 	ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR __START_KERNEL_map)
 	/* Map the p2m table to a 512GB-aligned user address. */
 	ELFNOTE(Xen, XEN_ELFNOTE_INIT_P2M,       .quad (PUD_SIZE * PTRS_PER_PUD))
-	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
+	ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          .globl xen_elfnote_entry;
+		xen_elfnote_entry: _ASM_PTR xen_elfnote_entry_value - .)
 	ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,       .ascii "!writable_page_tables")
 	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz "yes")
 	ELFNOTE(Xen, XEN_ELFNOTE_L1_MFN_VALID,
@@ -115,7 +116,8 @@ SYM_CODE_END(xen_cpu_bringup_again)
 #else
 # define FEATURES_DOM0 0
 #endif
-	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, _ASM_PTR hypercall_page)
+	ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, .globl xen_elfnote_hypercall_page;
+		xen_elfnote_hypercall_page: _ASM_PTR xen_elfnote_hypercall_page_value - .)
 	ELFNOTE(Xen, XEN_ELFNOTE_SUPPORTED_FEATURES,
 		.long FEATURES_PV | FEATURES_PVH | FEATURES_DOM0)
 	ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz "generic")
-- 
2.47.0.rc0.187.ge670bccf7e-goog



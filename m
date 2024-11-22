Return-Path: <linux-kernel+bounces-418825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C19D65EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1214B23346
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C73E1DF252;
	Fri, 22 Nov 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hKxKpX98"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE476189BBA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315666; cv=none; b=qNVbNw2QLwlYzqtzWoUA2oFcEE2Eug4EuL+ZtStZ01zktw/uJEo7+BatD5jCdbH3m3/+swo8Jy+yysi5BGGpWrGPrZvnxaK5NGvJ8kNhgkQhu6/xjlup6j7Axy2qOkpD4gvouZHl75Qws+0KFtvbmTjZrbnzf9+wQjERSC9C6mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315666; c=relaxed/simple;
	bh=ES94CY4oxmMLlOXPxmho4+dVHtK1sGih6Ia5cWMiqAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arXWvjI+r30Sr3EtjEfI6cKbOEomnqJlNwiSrBymi7Y005K73ZBUgIlBuPFJFvFsdvV6sjE44TJymtWCnQ0SglkgIbEno0g9KuOOQFdmT4KetgiUCvJpSHpdPmwMhOgxUqaQI4tSS2oMwgY2W8aepq9Ko96Vv7svsSvdpxqTLOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hKxKpX98; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ubsMDj/bpOoQF9AOzyotTy2PSXk8cSR2Tvgh3iOVNio=; b=hKxKpX98/aMh88PkgdxNmX/Mgx
	a3PgEWqnnZCUJ2cg9LsTiZKxQ+3S0A+0NMeDH5D5JYpvJpeOBcwRYMUm+oiTk4b0KUQngIKgCsEgn
	IygEDtirKxYvjwqL49sJLUm5Bj7k8mHfOR7UF1kqryHBjl9HbMHjrj0fiasy1uXGROFTmf87mvkHf
	moicpez9/yJhvYiHO/fdMNAsmbTfbXSUjAV6xyhqPtxSWA2fQcJfzXVsE/bsCM7y7av21cH/qTVic
	7M9aOe67xm8yYh7hjHvy5Uca5teizdmuLjR+jfWsH+rLzxGbSknn3ZNrdw9l7tHSwhxSXqgZvyu+w
	pkqHT1zg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000008PHQ-2EVH;
	Fri, 22 Nov 2024 22:47:21 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiI-0RYH;
	Fri, 22 Nov 2024 22:47:19 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org
Subject: [RFC PATCH v2 06/16] x86/kexec: Move relocate_kernel to kernel .data section
Date: Fri, 22 Nov 2024 22:38:15 +0000
Message-ID: <20241122224715.171751-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122224715.171751-1-dwmw2@infradead.org>
References: <20241122224715.171751-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Now that the copy is executed instead of the original, the relocate_kernel
page can live in the kernel's .text section. This will allow subsequent
commits to actually add real data to it and clean up the code somewhat as
well as making the control page ROX.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/sections.h      |  1 +
 arch/x86/kernel/machine_kexec_64.c   |  4 +++-
 arch/x86/kernel/relocate_kernel_64.S |  6 +-----
 arch/x86/kernel/vmlinux.lds.S        | 11 ++++++++++-
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 3fa87e5e11ab..30e8ee7006f9 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -5,6 +5,7 @@
 #include <asm-generic/sections.h>
 #include <asm/extable.h>
 
+extern char __relocate_kernel_start[], __relocate_kernel_end[];
 extern char __brk_base[], __brk_limit[];
 extern char __end_rodata_aligned[];
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 3aeb225a0b36..048868d868ce 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -333,6 +333,8 @@ void machine_kexec(struct kimage *image)
 					     unsigned long start_address,
 					     unsigned int preserve_context,
 					     unsigned int host_mem_enc_active);
+	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
+	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	unsigned long page_list[PAGES_NR];
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
@@ -370,7 +372,7 @@ void machine_kexec(struct kimage *image)
 	}
 
 	control_page = page_address(image->control_code_page) + PAGE_SIZE;
-	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 70539b1b9545..085dddf79476 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -41,10 +41,8 @@
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
 #define CP_VA_CONTROL_PAGE	DATA(0x38)
 
-	.text
-	.align PAGE_SIZE
+	.section .text.relocate_kernel,"ax";
 	.code64
-SYM_CODE_START_NOALIGN(relocate_range)
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
@@ -340,5 +338,3 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	int3
 SYM_CODE_END(swap_pages)
 
-	.skip KEXEC_CONTROL_CODE_MAX_SIZE - (. - relocate_kernel), 0xcc
-SYM_CODE_END(relocate_range);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index b8c5741d2fb4..925a821134b5 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -95,7 +95,15 @@ const_pcpu_hot = pcpu_hot;
 #define BSS_DECRYPTED
 
 #endif
-
+#if defined(CONFIG_X86_64) && defined(CONFIG_KEXEC_CORE)
+#define KEXEC_RELOCATE_KERNEL					\
+	. = ALIGN(0x100);					\
+	__relocate_kernel_start = .;				\
+	*(.text.relocate_kernel);				\
+	__relocate_kernel_end = .;
+#else
+#define KEXEC_RELOCATE_KERNEL
+#endif
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
@@ -181,6 +189,7 @@ SECTIONS
 
 		DATA_DATA
 		CONSTRUCTORS
+		KEXEC_RELOCATE_KERNEL
 
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
-- 
2.47.0



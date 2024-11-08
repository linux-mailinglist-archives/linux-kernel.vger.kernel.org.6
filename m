Return-Path: <linux-kernel+bounces-401101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D53789C15F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C6531C225B7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389931C4610;
	Fri,  8 Nov 2024 05:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cy7a5i86"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F59CA6F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731043382; cv=none; b=MKcdErsOLgMrV3Ao2FOiVCOpbKO2eKRMD5Lq3OZTIXdqNtCtGyQbh6LAIgxZS8AswmQ2uBARr6OhCLOqKrHLLCE+8ZoTbuOxuwxScrkEoS6iQtOWEKEfD97Zx3hVIVJsg30eX+FYn5ms7BjFoN8mxIHDJjuT4qDcmJm4Nu0hmjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731043382; c=relaxed/simple;
	bh=HUA26w7CbKb56VVOyYfM00VgjKL15D1qbl6Vzr6iFZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLNi20qCoF5pgvOQ6Y73M7JYaHyKN094qmvrP5gFhcFHteaCDnwVzkZYDTW6JtXmIcxjAXoTgZ2/GW/pZSLgrwUwcUNtGrRTw+nk2JE9G5j5JaB2lEamaj+kqPNe1HdIkGeegD6Nht407nBGqdOCLRA3buFkToN6V+JP+4Fu7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cy7a5i86; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9N3Kt0ix/6HfXG5gXJdl2peagLFdoYwmXEP62M2qcaM=; b=Cy7a5i86F2keYsbL3ZJoLhkt53
	pgN96LF2hzI9D53Ft8sXSTtRBDPRMdGpptj/AkLgCmzLkN+3+CyVJyAVVB7n7Yrx+ZAZJUMGEtwDl
	RKMAwkruWNGpfDwq08TmXxRGY7gyY4LBjLUK3iPPP896wZm+E1VSzs5QkKU46Ex5u67lNAx6TM1cD
	66r7Jj7EDkLDl2Ue/OcNgZ7kKNh+lNdn6JBxvBvgExUoJRLMuAzV4uWXjSundbDhkdhIHQvUOr/Vw
	SJVwKffTE99IsNTeuJQaa57Sp9fqPTdFX+hslReh6fUhDuuguhp2hFVMOCn2PTrI1o5JfKganj9Dh
	H9F9zl/Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9HSN-000000088sH-1iRV;
	Fri, 08 Nov 2024 05:22:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t9HSM-0000000GfPi-0YhJ;
	Fri, 08 Nov 2024 05:22:50 +0000
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
	Simon Horman <horms@kernel.org>
Subject: [RFC PATCH 1/2] x86/kexec: Use linker script for relocate_kernel page layout
Date: Fri,  8 Nov 2024 05:22:40 +0000
Message-ID: <20241108052241.3972433-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <1983c62c02b863f6d70198730dbb55a1ef7ceb9f.camel@infradead.org>
References: <1983c62c02b863f6d70198730dbb55a1ef7ceb9f.camel@infradead.org>
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

---
 arch/x86/include/asm/sections.h      |  1 +
 arch/x86/kernel/machine_kexec_64.c   |  6 ++++--
 arch/x86/kernel/relocate_kernel_64.S |  6 +-----
 arch/x86/kernel/vmlinux.lds.S        | 12 +++++++++++-
 4 files changed, 17 insertions(+), 8 deletions(-)

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
index 9c9ac606893e..f873bef6eefd 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -156,7 +156,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	pmd_t *pmd;
 	pte_t *pte;
 
-	vaddr = (unsigned long)relocate_kernel;
+	vaddr = (unsigned long)__relocate_kernel_start;
 	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
 	pgd += pgd_index(vaddr);
 	if (!pgd_present(*pgd)) {
@@ -321,6 +321,8 @@ void machine_kexec_cleanup(struct kimage *image)
  */
 void machine_kexec(struct kimage *image)
 {
+	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
+	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	unsigned long page_list[PAGES_NR];
 	unsigned int host_mem_enc_active;
 	int save_ftrace_enabled;
@@ -358,7 +360,7 @@ void machine_kexec(struct kimage *image)
 	}
 
 	control_page = page_address(image->control_code_page) + PAGE_SIZE;
-	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
 	page_list[PA_CONTROL_PAGE] = virt_to_phys(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)control_page;
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 2848d086ceb0..1efcbd340528 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -40,10 +40,8 @@
 #define CP_PA_SWAP_PAGE		DATA(0x28)
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
 
-	.text
-	.align PAGE_SIZE
+	.section .text.relocate_kernel,"ax";
 	.code64
-SYM_CODE_START_NOALIGN(relocate_range)
 SYM_CODE_START_NOALIGN(relocate_kernel)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR
@@ -332,5 +330,3 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	int3
 SYM_CODE_END(swap_pages)
 
-	.skip KEXEC_CONTROL_CODE_MAX_SIZE - (. - relocate_kernel), 0xcc
-SYM_CODE_END(relocate_range);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index b8c5741d2fb4..ad451371e179 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -95,7 +95,16 @@ const_pcpu_hot = pcpu_hot;
 #define BSS_DECRYPTED
 
 #endif
-
+#if defined(CONFIG_X86_64) && defined(CONFIG_KEXEC_CORE)
+#define KEXEC_RELOCATE_KERNEL_TEXT				\
+	. = ALIGN(PAGE_SIZE);					\
+	__relocate_kernel_start = .;				\
+	*(.text.relocate_kernel);				\
+	*(.rodata.relocate_kernel);				\
+	__relocate_kernel_end = .;
+#else
+#define KEXEC_RELOCATE_KERNEL_TEXT
+#endif
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
@@ -124,6 +133,7 @@ SECTIONS
 		/* bootstrapping code */
 		HEAD_TEXT
 		TEXT_TEXT
+		KEXEC_RELOCATE_KERNEL_TEXT
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
-- 
2.44.0



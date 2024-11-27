Return-Path: <linux-kernel+bounces-423855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455D9DAD89
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B917B23310
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EE5204F95;
	Wed, 27 Nov 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wn/uYhEd"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805D203703
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734251; cv=none; b=A8osQiq1PGIo2h17MZHKVzwtn4r8zblt2whTHUmxQIuYswu4xD+KiiVi8KhH5nP1S30ZvWJiLDr1zxJzDvcwt/h/eoEwjsaFVSeKLBQL1hyu2U/CMa8vJvCxhYBtayi8pEHMOrJeiuYkkfYLO+Hq7AXz9doAook9TVfRW9YV5nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734251; c=relaxed/simple;
	bh=RgZAS7eRpj8HVUhSNf7gSSClH/Y1bldeh41m+XiqIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ebKARn3f02kaG6+V+XkDzqjkF+LLa6W2IahjtjlNXbcdUrD+kcuNyuk4OXq18AYnhvDyXb0bmQ2Sofx8/UsGjUfcEfKsYwxLfmpIc9kA0j35ispTxAE+Y+0dsAFB5XmJgJGmu6kM5XZGvd25ZKeT2ghtVc95SPuSs6V1Niz8wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wn/uYhEd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=50BPCyL9LIGHSpurJ68Tq+6jNVpqvvXZVWUSqaOyZlA=; b=Wn/uYhEdkk9I16azIWbeCOgE5Q
	WZ3ZbpRZetorvKyyCqcvnjFF2EPMVvOhuu0xJgvg0HMIRmTTRXV8ggqPk+2OpeCBF87jtsP35H5pN
	D4yn9QOCcrTSN/N+5J101xcWN8tE0EfHeht/IleOrA0nhUTyeFRBM2TV7Vp+aRF3Fk/lgSX67d+up
	pxJVgiCW9v3kgLFx4s5kfQk2EHv3gQhz3fV2HuydUAm6Vzu1UmyHUwNm/pdLh44SChf4YSQc7JfmX
	/9CCXbD0VGuWp81iMUjGzDQmeJYfxugOZz6C7GbUhc97cW6z+BrdRmLw5yPI8EsF0yS3RoPwkWsDE
	WSQA8HJg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKD-00000001cW9-0xjs;
	Wed, 27 Nov 2024 19:03:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKE-00000000Bih-143V;
	Wed, 27 Nov 2024 19:03:46 +0000
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
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [RFC PATCH v4 09/20] x86/kexec: Move relocate_kernel to kernel .data section
Date: Wed, 27 Nov 2024 19:00:23 +0000
Message-ID: <20241127190343.44916-10-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
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
 arch/x86/kernel/callthunks.c         |  6 ++++++
 arch/x86/kernel/machine_kexec_64.c   |  4 +++-
 arch/x86/kernel/relocate_kernel_64.S |  7 +------
 arch/x86/kernel/vmlinux.lds.S        | 15 ++++++++++++++-
 5 files changed, 25 insertions(+), 8 deletions(-)

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
 
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 465647456753..51c3e0049152 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -139,9 +139,15 @@ static bool skip_addr(void *dest)
 		return true;
 #endif
 #ifdef CONFIG_KEXEC_CORE
+# ifdef CONFIG_X86_64
+	if (dest >= (void *)__relocate_kernel_start &&
+	    dest < (void *)__relocate_kernel_end)
+		return true;
+# else
 	if (dest >= (void *)relocate_kernel &&
 	    dest < (void*)relocate_kernel + KEXEC_CONTROL_CODE_MAX_SIZE)
 		return true;
+# endif
 #endif
 #ifdef CONFIG_XEN
 	if (dest >= (void *)hypercall_page &&
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9567347f7a9b..23dffdc070dd 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -307,6 +307,8 @@ static void load_segments(void)
 int machine_kexec_prepare(struct kimage *image)
 {
 	void *control_page = page_address(image->control_code_page);
+	unsigned long reloc_start = (unsigned long)__relocate_kernel_start;
+	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	int result;
 
 	/* Setup the identity mapped 64bit page table */
@@ -314,7 +316,7 @@ int machine_kexec_prepare(struct kimage *image)
 	if (result)
 		return result;
 
-	__memcpy(control_page, relocate_kernel, KEXEC_CONTROL_CODE_MAX_SIZE);
+	__memcpy(control_page, __relocate_kernel_start, reloc_end - reloc_start);
 
 	set_memory_x((unsigned long)control_page, 1);
 
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b48bd82843fd..01138f862c59 100644
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
@@ -341,6 +339,3 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	ret
 	int3
 SYM_CODE_END(swap_pages)
-
-	.skip KEXEC_CONTROL_CODE_MAX_SIZE - (. - relocate_kernel), 0xcc
-SYM_CODE_END(relocate_range);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index b8c5741d2fb4..1ff23a4bbf03 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -28,6 +28,7 @@
 #include <asm/orc_lookup.h>
 #include <asm/cache.h>
 #include <asm/boot.h>
+#include <asm/kexec.h>
 
 #undef i386     /* in case the preprocessor is a 32bit one */
 
@@ -95,7 +96,18 @@ const_pcpu_hot = pcpu_hot;
 #define BSS_DECRYPTED
 
 #endif
-
+#if defined(CONFIG_X86_64) && defined(CONFIG_KEXEC_CORE)
+#define KEXEC_RELOCATE_KERNEL					\
+	. = ALIGN(0x100);					\
+	__relocate_kernel_start = .;				\
+	*(.text.relocate_kernel);				\
+	__relocate_kernel_end = .;
+
+ASSERT(__relocate_kernel_end - __relocate_kernel_start <= KEXEC_CONTROL_CODE_MAX_SIZE,
+	"relocate_kernel code too large!")
+#else
+#define KEXEC_RELOCATE_KERNEL
+#endif
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
@@ -181,6 +193,7 @@ SECTIONS
 
 		DATA_DATA
 		CONSTRUCTORS
+		KEXEC_RELOCATE_KERNEL
 
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
-- 
2.47.0



Return-Path: <linux-kernel+bounces-401102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F1E9C15F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E541F2450F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59621C9EAB;
	Fri,  8 Nov 2024 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jQ/62DFL"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AF11CABF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731043422; cv=none; b=qILbQq2ud8VsWywxlWavgdfX4jS+pj4p807/Dx6yBL/hNmGNI4zEzBj3kEBx6KXCW9d9O28lGP2SETpmh2vsvqIoPibJndc8daSZHXjE3WA7i7JFWXA+WeKaI/I1t5YOVElr5B21zZu3CQOUAEG9PXlBIJ3E1gRC7wr4F8kczjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731043422; c=relaxed/simple;
	bh=Uj+KGt1xQKCrDZxFfc2dLjQLYCU6Sy69KgzxrIC614w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuaIJcpwwSdatRMW11wkdu10qjQQlRCM4KEV7Qy1mMBNE4vEBsKegCsFaaCCgIn9MaazA0TxfYvaYR3j7FRoOPqEnDmJ1NkF0AuE09iVVN2SgcNthq+AH97sg/LKnmHWxqtdugbg6pIGiSL9PsKB3XYgZensAmLoX6UewAFkrvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jQ/62DFL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/QTHmetNkJAJhU8HeG8NItFW3aSHqtCsmEYlxk8Askc=; b=jQ/62DFLBxnFf0z5aT/OdglUrb
	1oHOWAd8gS1B4TLE50STyEwrNsr5ag0TUBOQcPbdvFZlMtIT+yQKg7Ue7JvMyk/qc2h7yaJ2vSvUy
	fV98Wso/2qDaq5KqMcC23HmaP6P+7+L6RugmCpcgudgQM1KFiwWV/69mubI8rhqb/W8LW2/FmTqjg
	A5kQNfaichPbfAM8Q2XNAXX26pG3z4/oQf4QV37Irt+6QB2D/nv/wU8rrcZWnLG4sQb1J5gOfy2I5
	FBHwHMUx0J1lZrMQBMXpDEw11D7fIMBZQZJMVlK7jAC6DMCfIRYxvTUehGENYKjJGsXRVdtIllgId
	AOw/isRA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t9HSP-0000000CFpJ-0xcq;
	Fri, 08 Nov 2024 05:23:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t9HSM-0000000GfPl-0lRG;
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
Subject: [RFC PATCH 2/2] x86/kexec: Add data section to relocate_kernel
Date: Fri,  8 Nov 2024 05:22:41 +0000
Message-ID: <20241108052241.3972433-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108052241.3972433-1-dwmw2@infradead.org>
References: <1983c62c02b863f6d70198730dbb55a1ef7ceb9f.camel@infradead.org>
 <20241108052241.3972433-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Now that it's handled sanely by a linker script we can have actual data,
and just use %rip-relative addressing to access it.

If we could call the *copy* instead of the original relocate_kernel in
the kernel text, then we could use %rip-relative addressing everywhere.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 58 ++++++++++++++++------------
 arch/x86/kernel/vmlinux.lds.S        |  2 +-
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1efcbd340528..577aa1672349 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -27,18 +27,28 @@
  * ~ control_page + PAGE_SIZE are used as data storage and stack for
  * jumping back
  */
-#define DATA(offset)		(KEXEC_CONTROL_CODE_MAX_SIZE+(offset))
 
+	.section .data.relocate_kernel,"a";
 /* Minimal CPU state */
-#define RSP			DATA(0x0)
-#define CR0			DATA(0x8)
-#define CR3			DATA(0x10)
-#define CR4			DATA(0x18)
-
+SYM_DATA_LOCAL(saved_rsp, .quad 0)
+SYM_DATA_LOCAL(saved_cr0, .quad 0)
+SYM_DATA_LOCAL(saved_cr3, .quad 0)
+SYM_DATA_LOCAL(saved_cr4, .quad 0)
 /* other data */
-#define CP_PA_TABLE_PAGE	DATA(0x20)
-#define CP_PA_SWAP_PAGE		DATA(0x28)
-#define CP_PA_BACKUP_PAGES_MAP	DATA(0x30)
+SYM_DATA_LOCAL(pa_table_page, .quad 0)
+SYM_DATA_LOCAL(pa_swap_page, .quad 0)
+SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
+
+/*
+ * There are two physical copies of relocate_kernel(), one in the original
+ * Kernel text and the other copied to the control page. There is a virtual
+ * mapping of each, in the original kernel. It is the *original* which is
+ * called from machine_kexec(), largely becaose the copy isn't mapped as an
+ * executable page. Thus, this code cannot just use %rip-relative addressing
+ * until after the %cr3 change and the jump to identity_mapped(). Until
+ * then, some pointer arithmetic is required.
+ */
+#define DATA(x) (x - relocate_kernel)
 
 	.section .text.relocate_kernel,"ax";
 	.code64
@@ -63,13 +73,13 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushf
 
 	movq	PTR(VA_CONTROL_PAGE)(%rsi), %r11
-	movq	%rsp, RSP(%r11)
+	movq	%rsp, DATA(saved_rsp)(%r11)
 	movq	%cr0, %rax
-	movq	%rax, CR0(%r11)
+	movq	%rax, DATA(saved_cr0)(%r11)
 	movq	%cr3, %rax
-	movq	%rax, CR3(%r11)
+	movq	%rax, DATA(saved_cr3)(%r11)
 	movq	%cr4, %rax
-	movq	%rax, CR4(%r11)
+	movq	%rax, DATA(saved_cr4)(%r11)
 
 	/* Save CR4. Required to enable the right paging mode later. */
 	movq	%rax, %r13
@@ -94,9 +104,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	PTR(PA_SWAP_PAGE)(%rsi), %r10
 
 	/* save some information for jumping back */
-	movq	%r9, CP_PA_TABLE_PAGE(%r11)
-	movq	%r10, CP_PA_SWAP_PAGE(%r11)
-	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
+	movq	%r9, DATA(pa_table_page)(%r11)
+	movq	%r10, DATA(pa_swap_page)(%r11)
+	movq	%rdi, DATA(pa_backup_pages_map)(%r11)
 
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
@@ -128,7 +138,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* set return address to 0 if not preserving context */
 	pushq	$0
 	/* store the start address on the stack */
-	pushq   %rdx
+	pushq   start_address(%rip)
 
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
@@ -227,9 +237,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* get the re-entry point of the peer system */
 	movq	0(%rsp), %rbp
 	leaq	relocate_kernel(%rip), %r8
-	movq	CP_PA_SWAP_PAGE(%r8), %r10
-	movq	CP_PA_BACKUP_PAGES_MAP(%r8), %rdi
-	movq	CP_PA_TABLE_PAGE(%r8), %rax
+	movq	pa_swap_page(%rip), %r10
+	movq	pa_backup_pages_map(%rip), %rdi
+	movq	pa_table_page(%rip), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
 	call	swap_pages
@@ -243,11 +253,11 @@ SYM_CODE_END(identity_mapped)
 SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	UNWIND_HINT_END_OF_STACK
 	ANNOTATE_NOENDBR // RET target, above
-	movq	RSP(%r8), %rsp
-	movq	CR4(%r8), %rax
+	movq	saved_rsp(%rip), %rsp
+	movq	saved_cr4(%rip), %rax
 	movq	%rax, %cr4
-	movq	CR3(%r8), %rax
-	movq	CR0(%r8), %r8
+	movq	saved_cr3(%rip), %rax
+	movq	saved_cr0(%r8), %r8
 	movq	%rax, %cr3
 	movq	%r8, %cr0
 	movq	%rbp, %rax
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ad451371e179..65f879b31a82 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -100,7 +100,7 @@ const_pcpu_hot = pcpu_hot;
 	. = ALIGN(PAGE_SIZE);					\
 	__relocate_kernel_start = .;				\
 	*(.text.relocate_kernel);				\
-	*(.rodata.relocate_kernel);				\
+	*(.data.relocate_kernel);				\
 	__relocate_kernel_end = .;
 #else
 #define KEXEC_RELOCATE_KERNEL_TEXT
-- 
2.44.0



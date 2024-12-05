Return-Path: <linux-kernel+bounces-433560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1958F9E59D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1842F16A0F9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFB5227B98;
	Thu,  5 Dec 2024 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i1bLMQK3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDCB22146F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412846; cv=none; b=sOjpJokfaYz0/FpCXdS/sQ3j1vpq75+oQGxaqo9/HtE1ICKd9YZidUfGNvYNCEzwYLtUYCKitG/9PFLCpjXF94hVG2SHpwYtMaRUHrVgl6C1ujXKOKGJvpFkxUYGsbkZVYeNtm3hOXJODKDtcQuDDSsDaCR8GwjVgDdXrQyR2Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412846; c=relaxed/simple;
	bh=623G9e0jeZ2RMFMd1YHMdaz5Es5e+KKYpgx8j02dSxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMiU4fK6lwxCDqI7KIA9E978ZIEI8/Pa11Sjxl6TARBKpfwGlWkFXpMNHMUCtp2AS4CKu5JHrOmmuUQrqyd72hDuPWlu7Th1jqb3z6Ej4qYcSY/ZemB2E4tdxC+biLSn8vbqTG5370M1wglp7sly/KSUIm8di9A/Mqxc3Lnjnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i1bLMQK3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=J05THXe+YRacmOzA8KfGrmyEonAyJGQ1gSBRrJydwjs=; b=i1bLMQK3g9+n+w/NJ8IuW4SrxT
	dW53XlW8k73Hs1prakYznZ+xzRINMQTe5you6+DqbCQqKr3PIkni566IkE9xTroPLrpCjnzQc77I4
	E15g6ANLbyTAF8/ihToY/mowlaZAUwFji64bAohjTKORtWZv7fU95ECUXjnaUEJSHlTkzGOHqTK01
	KxxxqNFVG2Dk1s2VLFIWbwBuM227oWUAakde4oJfr++BJGut9+jK2SO7pWef6Rh7lfIm0XjWwWcu3
	Ry5aGBwcOELnvRbmt3Ery0hsnh+yeNcdCam23zsp+11iKGr7NaMMQi21d74ZTAmsrv+Won2/iBDrv
	tUrr8WSw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrM-0000000DDp8-3Ieq;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyMF-3JqE;
	Thu, 05 Dec 2024 15:33:45 +0000
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
Subject: [PATCH v5 15/20] x86/kexec: Debugging support: load a GDT
Date: Thu,  5 Dec 2024 15:05:21 +0000
Message-ID: <20241205153343.3275139-16-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
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

There are some failure modes which lead to triple-faults in the
relocate_kernel function, which is fairly much undebuggable for normal
mortals.

Adding a GDT in the relocate_kernel environment is step 1 towards being
able to catch faults and do something more useful.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b24198eb1fe9..6c6bfdccfe6a 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -39,6 +39,18 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
+#ifdef CONFIG_KEXEC_DEBUG
+	.balign 16
+SYM_DATA_START_LOCAL(kexec_debug_gdt)
+	.word   kexec_debug_gdt_end - kexec_debug_gdt - 1
+	.long   0
+	.word   0
+	.quad   0x00cf9a000000ffff      /* __KERNEL32_CS */
+	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
+	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
+SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
+#endif /* CONFIG_KEXEC_DEBUG */
+
 	.section .text.relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
@@ -112,6 +124,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* store the start address on the stack */
 	pushq   %rdx
 
+#ifdef CONFIG_KEXEC_DEBUG
+	/* Create a GDTR (16 bits limit, 64 bits addr) on stack */
+	leaq	kexec_debug_gdt(%rip), %rax
+	pushq	%rax
+	pushw	(%rax)
+
+	/* Load the GDT, put the stack back */
+	lgdt	(%rsp)
+	addq	$10, %rsp
+
+	/* Test that we can load segments */
+	movq	%ds, %rax
+	movq	%rax, %ds
+#endif /* CONFIG_KEXEC_DEBUG */
+
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
 	 * below.
-- 
2.47.0



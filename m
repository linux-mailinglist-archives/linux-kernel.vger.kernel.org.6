Return-Path: <linux-kernel+bounces-557919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1B6A5DF52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CDC3BC0D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3BA2528F0;
	Wed, 12 Mar 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lpf4zUwQ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160C24EABF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790595; cv=none; b=mKgHG9t8ZDisk0/vfvODb75QRU6IB5PojDIO7/dk8Lt87KFpxA3Yvm2n6fYMiqefWOWlgGQe9YYlKVJaqVWTWo+DhPb0187myYg0Y64xYmxqK4okB++Ao643DVv3ijn3JnEEMg//2P28WEquiAKTyb8GPyG/6TgDMXAhsK4JVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790595; c=relaxed/simple;
	bh=JmF3kgVolE9NdnDOZ/gXDFGedL4Egk4E2CIPt9HV9J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHq6F9MOmiw9aFOm9/5qrpp+IUEZwt1eBTyzi3IaghoPx96scMFBR/yb5wNdWD0v5xVIw2pIgnh0ECSvGyXFUAfPh9sVdgr/OmEIunKA+d1OeP/lZAc3miAeFDXPGNCppfbWmIRv2QQ1LmAC1x4d4lkc7dzlaojjzgiGErFzs+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lpf4zUwQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ybsUY7o8yqbkApk0dzSa8UzXZgQrXii7fmhg0Fzl2SU=; b=Lpf4zUwQXV7/cVzR0agKC2C9cL
	1Aij1V44AFbT3Eh+UqJSrf28DqUd42eB0vvUbmcZJ7ZvBraR10bkf1ANYoL8bedlgbnv/iCrhA/4C
	ISSo9W2ge9dsnoBjn/wbBOFQ+fHxhutRxplYf/P324OSo3oRHTCr5BcbPsNOnfJ4LgSEZ5UO4C/tn
	xP4GdZ0aZx8mqpdsiD7IyqndEOaeVpdUt8Rr22g62dDbPIiV9TCpLRc+z15g2eK6T+WQsoRkSM/IM
	SPsyOv3dRw8WWA+3xaL9peTlJF2tpIed7wZLzlYx3gQn3MFsbqyfY8P9z0kmXtklkgg/4/49zF7Rh
	LQZXf7uQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-0000000CxJF-2VLv;
	Wed, 12 Mar 2025 14:42:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uU3-1de1;
	Wed, 12 Mar 2025 14:42:59 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v7 1/8] x86/kexec: Debugging support: load a GDT
Date: Wed, 12 Mar 2025 14:34:13 +0000
Message-ID: <20250312144257.2348250-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
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
 arch/x86/kernel/relocate_kernel_64.S | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b44d8863e57f..ac058971a382 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -40,6 +40,16 @@ SYM_DATA(kexec_pa_table_page, .quad 0)
 SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
+	.balign 16
+SYM_DATA_START_LOCAL(kexec_debug_gdt)
+	.word   kexec_debug_gdt_end - kexec_debug_gdt - 1
+	.long   0
+	.word   0
+	.quad   0x00cf9a000000ffff      /* __KERNEL32_CS */
+	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
+	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
+SYM_DATA_END_LABEL(kexec_debug_gdt, SYM_L_LOCAL, kexec_debug_gdt_end)
+
 	.section .text..relocate_kernel,"ax";
 	.code64
 SYM_CODE_START_NOALIGN(relocate_kernel)
@@ -116,6 +126,19 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* store the start address on the stack */
 	pushq   %rdx
 
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
+
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
 	 * below.
-- 
2.48.1



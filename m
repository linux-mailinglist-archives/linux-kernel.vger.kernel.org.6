Return-Path: <linux-kernel+bounces-433546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2539E59C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5BA284238
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51DB21D59B;
	Thu,  5 Dec 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QrYwSmit"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A0218E99
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412842; cv=none; b=LP9VlXZxCfCKHXV2M0pZoSW5Ugr6nKwv8dqDjdIMKUj8LXzKXQ54JZCsmp+D1Cv1QDlVI8U0kRMzmyyjvYhrS1vSwpRpKMq6GfE3/QXoWH4rR+Zd9Ev1i8zCi3yqf/0GIp7uCNWh2irwp9qGdo+2lB8QDVamZx2aKDmPy4IjzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412842; c=relaxed/simple;
	bh=YEYgduFbx3hxPviKlbaHo3vgA2xGogrBHXSzn5W5fyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4/4gGuPyzTCYN2KYOvefoB5zsBI34e1ypt9d/zSICbTIu3m0T1ynyk4Y4dlq4EMiX3CKZmxHzpVnQUxhSU+eVaCk7s817UxIfbhVli2QvZBYJCHWxuj3TKUPea/+3yjZsVNoMISQm1tWzG+t/5Iwh0uEg8jVy92bJYS4i2eNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QrYwSmit; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=G8KdxSUjA1BoxOPlX8D0AVdJHTOMU4u9sPbtmHj+Y10=; b=QrYwSmitQBPynjW3mqK11tWkLw
	R4pUElq/LusIYt55LPLYTD7sNaKYGmaDMlOsd8ApXwDpuhYnUAqIV7MPt+qX7i3LCnxjqDwItejP4
	PO2us32aVKe4ZTz9X9ORP+yvHvVRGWKqWy00aMdV6mkLtpUdW/dg74yvd3zTqq/Lsd4M8aQMCSzh4
	+M52AHzzWdLV2gE5tkHK5TDh1lne+1Ynyf2OXux09UfQaZLhwHzHIiURE1ltXWfV0eMz0xfZSBb7M
	+MQeinPLVp54cxVurw94OPJ6k+df6rcVEDPQn4Z3zFLRdo08wg1+Ckj8ztuja8wSkdsC0949Xm4mD
	N/OGJbVA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-00000002wEs-35Cb;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyLB-16nR;
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
Subject: [PATCH v5 02/20] x86/kexec: Clean up and document register use in relocate_kernel_64.S
Date: Thu,  5 Dec 2024 15:05:08 +0000
Message-ID: <20241205153343.3275139-3-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Add more comments explaining what each register contains, and save the
preserve_context flag to a non-clobbered register sooner, to keep things
simpler.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1236f25fc8d1..92478e2e254f 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -100,6 +100,9 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	%r10, CP_PA_SWAP_PAGE(%r11)
 	movq	%rdi, CP_PA_BACKUP_PAGES_MAP(%r11)
 
+	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
+	movq	%rcx, %r11
+
 	/* Switch to the identity mapped page tables */
 	movq	%r9, %cr3
 
@@ -116,6 +119,14 @@ SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	UNWIND_HINT_END_OF_STACK
+	/*
+	 * %rdi	indirection page
+	 * %rdx start address
+	 * %r11 preserve_context
+	 * %r12 host_mem_enc_active
+	 * %r13 original CR4 when relocate_kernel() was invoked
+	 */
+
 	/* set return address to 0 if not preserving context */
 	pushq	$0
 	/* store the start address on the stack */
@@ -170,8 +181,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	wbinvd
 .Lsme_off:
 
-	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
-	movq	%rcx, %r11
 	call	swap_pages
 
 	/*
@@ -183,13 +192,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	%cr3, %rax
 	movq	%rax, %cr3
 
+	testq	%r11, %r11	/* preserve_context */
+	jnz .Lrelocate
+
 	/*
 	 * set all of the registers to known values
 	 * leave %rsp alone
 	 */
 
-	testq	%r11, %r11
-	jnz .Lrelocate
 	xorl	%eax, %eax
 	xorl	%ebx, %ebx
 	xorl    %ecx, %ecx
-- 
2.47.0



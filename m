Return-Path: <linux-kernel+bounces-393705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FC79BA435
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730091C20D76
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A631494B3;
	Sun,  3 Nov 2024 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C7uD+miH"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732816849F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730612454; cv=none; b=dli43MTVtLZCjg00UFRFO4xmrVCv9UYAp7rKt8f8Nl15xu83UFJrGPGnFLjHyPJynMtq9eStM4fe+uYoaDd15Nu9LbLU4RaLPUuaXsOevduFhSzzO/b43DWpozzGQVuRNcyIybeUDz1j2E7NVlGKCqAZj6BLPKbKzI0Q7VbydEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730612454; c=relaxed/simple;
	bh=lxdlDTIKoz0IVHJ/XpoozLbAx51ZVaHrnOahKZMN/9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5o1MTJHL16+3xgKa5UWzRNTgbbj9ID61RAJepS/u3CLD6mVRsftObXpIc6TxQECcUZMKvXr0qn4hGwoIdmZ/11mM7UrpHjjs/v7ELhAX+88C8xPgE1FTFQyie/1bzgnMt3i6/krYscqiqV2vWnAIMJAeKU8OTsdC1kevSjJJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C7uD+miH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZdZ+nlAayZckzp2Spz6rpIxa9MO+4/e+5j0I1vjYVzw=; b=C7uD+miHpdzhuY8kUB3Jx01O1r
	yAObd9yToflETXCD8JZVihND7D94qZx3ypGkLw4xgVPaICWvF5pfN3Wlf7ASg+NPiQDmO6N0QDplJ
	+WYz2QC1k+JQLhsKeCx1L78DSaHCbcBfvE9LjFDESocunEi68Lm3u6dPit8ZRsm6q+8K3tvefWxQC
	RzCTbUSDTB9TErCocvuHGJ3Oo7vc43UbVExPx++YTG25Lc/7nICWtIRIoRlgugRRszoBSSEJ7f9bJ
	e8/3pSQNIX2ULMdzcc8F0sydMW/q/c/j3HS51E8hp1pAtzOrbK+yd1SV7hpvQW9DTPRk+/pUcmXVA
	qHmfjxCA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLb-0000000B4NU-46Mw;
	Sun, 03 Nov 2024 05:40:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLa-0000000FvL9-3Dh7;
	Sun, 03 Nov 2024 05:40:22 +0000
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
Subject: [RFC PATCH 1/7] x86/kexec: Clean up and document register use in relocate_kernel_64.S
Date: Sun,  3 Nov 2024 05:35:26 +0000
Message-ID: <20241103054019.3795299-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241103054019.3795299-1-dwmw2@infradead.org>
References: <20241103054019.3795299-1-dwmw2@infradead.org>
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
---
 arch/x86/kernel/relocate_kernel_64.S | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index e9e88c342f75..c065806884f8 100644
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
 
@@ -116,6 +119,13 @@ SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	UNWIND_HINT_END_OF_STACK
+	/*
+	 * %rdi	indirection page
+	 * %rdx start address
+	 * %r11 preserve_context
+	 * %r12 host_mem_enc_active
+	 */
+
 	/* set return address to 0 if not preserving context */
 	pushq	$0
 	/* store the start address on the stack */
@@ -170,8 +180,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	wbinvd
 .Lsme_off:
 
-	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
-	movq	%rcx, %r11
 	call	swap_pages
 
 	/*
@@ -183,13 +191,14 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
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
2.44.0



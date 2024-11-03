Return-Path: <linux-kernel+bounces-393703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB20E9BA433
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C82B225BC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291CD1632CC;
	Sun,  3 Nov 2024 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jTF85dx2"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B951158DB9
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 05:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730612448; cv=none; b=owxqu7hekP/HLeijMqMHLTw6XokOq2qxvZyqhl8P2awf5wsNfDilx9vfhPcOfVCG2Z/vWeOSArIrbfBxLqo1qYLIB8F2/XrW6zDGsYSvuYe0q5ruWWSEW8nMGqfYjv/nfoLYWSrxC92YDzWwlOUGiAP+qH92hi9ATU8+RbVUY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730612448; c=relaxed/simple;
	bh=/6DPqRlMBgCD87uZJerS6ebaGmyjgm2J2S4yV0UY32c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6WuBLIVImpgwrKLWwMqif1FNrjlo6ZmB01DsYJHGm6m5RUmdt2Lpz7FBbyrjLaFnrTLpMZjKIzkBVSiXPI5s6JN5GBu9odaJhUHzoh69A5u7N1dbet11v0Sb5Tx9WLoazd2eW9lgMkYh48a2F7sQ2piv5Hk+JpmnRO3NHYgJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jTF85dx2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TT41j7+YieIW7CJdU2V5YhKog/Kk/4ZOf15yuetAirQ=; b=jTF85dx2l1wpjKRQC9BuGBkjal
	bLBF9euKln0Owji+Yq8mzi3YccZAqy+4NNdJAvSbd3HKY37bdtDKahxWDauL+cb8Z55P0x3XOnGpH
	VEolZJmCeAxOruk7f5MELUtPNJI9Dj5s7U85MNWOxr08HoY3NuzSTcsipaBwVHdW5CrjmhDtpfPrg
	akfNXWGI0GLKHo8fir3B0zNdVPIZr/7xzVqMocHRTmlFnHlzSTYyGbRobvUcFOCGnxu+vsLLnlbwn
	+WW9jnQ3StiPLIi//mCsg2pqxTCPPa7E9fCczeJoKMfDelmqSHXaPDPjqgPChjXjQFpCmxf9kV0ZD
	lL22GM0g==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLb-0000000B4NW-475z;
	Sun, 03 Nov 2024 05:40:34 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLa-0000000FvLP-44tq;
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
Subject: [RFC PATCH 5/7] x86/kexec: Debugging support: Load an IDT and basic exception entry points
Date: Sun,  3 Nov 2024 05:35:30 +0000
Message-ID: <20241103054019.3795299-6-dwmw2@infradead.org>
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 110 +++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 2af4ce593645..2a2a6e693e18 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -117,6 +117,11 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	int3
 SYM_CODE_END(relocate_kernel)
 
+#ifdef DEBUG
+	UNWIND_HINT_UNDEFINED
+	.balign 0x100	/* relocate_kernel will be overwritten with an IDT */
+#endif
+
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	UNWIND_HINT_END_OF_STACK
 	/*
@@ -144,6 +149,52 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* Test that we can load segments */
 	movq	%ds, %rax
 	movq	%rax, %ds
+
+	/* Load address of reloc_kernel, at start of this page, into %r8 */
+	lea	relocate_kernel(%rip), %r8
+
+	/*
+	 * Build an IDT descriptor in %rax/%rbx. The address is in the low 16
+	 * and high 16 bits of %rax, and low 32 of %rbx. The niddle 32 bits
+	 * of %rax hold the selector/ist/flags which are hard-coded below.
+         */
+	movq	%r8, %rax         // 1234567890abcdef
+
+	andq	$-0xFFFF, %rax    // 1234567890ab....
+	shlq	$16, %rax         // 567890ab........
+
+	movq	$0x8F000010, %rcx // Present, DPL0, Interrupt Gate, __KERNEL_CS.
+	orq	%rcx, %rax        // 567890ab8F000010
+	shlq	$16, %rax         // 90ab8F000010....
+
+	movq	%r8, %rcx
+	andq	$0xffff, %rcx     // ............cdef
+	orq	%rcx, %rax        // 90ab87000010cdef
+
+	movq	%r8, %rbx
+	shrq	$32, %rbx
+
+	/*
+	 * The descriptor was built using the address of relocate_kernel. Add
+	 * the required offset to point to the actual entry points.
+	 */
+	addq	$(exc_vectors - relocate_kernel), %rax
+
+	/* Loop 16 times to handle exception 0-15 */
+	movq	$16, %rcx
+1:
+	movq	%rax, (%r8)
+	movq	%rbx, 8(%r8)
+	addq	$16, %r8
+	addq	$6, %rax
+	loop	1b
+
+	/* Now put an IDTR on the stack (temporarily) to load it */
+	subq	$0x100, %r8
+	pushq	%r8
+	pushw	$0xff
+	lidt	(%rsp)
+	addq	$10, %rsp
 #endif /* DEBUG */
 
 	/*
@@ -347,6 +398,65 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 SYM_CODE_END(swap_pages)
 
 #ifdef DEBUG
+SYM_CODE_START_LOCAL_NOALIGN(exc_vectors)
+	/* Each of these is 6 bytes. */
+.macro vec_err exc
+	UNWIND_HINT_ENTRY
+	. = exc_vectors + (\exc * 6)
+	nop
+	nop
+	pushq	$\exc
+	jmp	exc_handler
+.endm
+
+.macro vec_noerr exc
+	UNWIND_HINT_ENTRY
+	. = exc_vectors + (\exc * 6)
+	pushq	$0
+	pushq	$\exc
+	jmp	exc_handler
+.endm
+
+	vec_noerr 0 // #DE
+	vec_noerr 1 // #DB
+	vec_noerr 2 // #NMI
+	vec_noerr 3 // #BP
+	vec_noerr 4 // #OF
+	vec_noerr 5 // #BR
+	vec_noerr 6 // #UD
+	vec_noerr 7 // #NM
+	vec_err 8   // #DF
+	vec_noerr 9
+	vec_err 10 // #TS
+	vec_err 11 // #NP
+	vec_err 12 // #SS
+	vec_err 13 // #GP
+	vec_err 14 // #PF
+	vec_noerr 15
+SYM_CODE_END(exc_vectors)
+
+SYM_CODE_START_LOCAL_NOALIGN(exc_handler)
+	pushq	%rax
+	pushq	%rdx
+	movw	$0x3f8, %dx
+	movb	$'A', %al
+	outb	%al, %dx
+	popq	%rdx
+	popq	%rax
+
+	/* Only return from int3 */
+	cmpq	$3, (%rsp)
+	jne	.Ldie
+
+	addq	$16, %rsp
+	iretq
+
+.Ldie:
+	hlt
+	jmp	.Ldie
+
+SYM_CODE_END(exc_handler)
+
 .Lreloc_kernel_gdt:
 	.word   1f - .Lreloc_kernel_gdt - 1
 	.long   0
-- 
2.44.0



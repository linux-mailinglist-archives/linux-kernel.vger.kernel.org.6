Return-Path: <linux-kernel+bounces-418833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5E89D65F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC57916175B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E31E04B1;
	Fri, 22 Nov 2024 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OUrawLPe"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A91A2C04
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315674; cv=none; b=Xm1pWqgNiMjrxovy9IigSoYd/iJiPP3mxarG2RH97RJN1VX6w1uNk0TiJn4quSshRetoUNb8pTs+x4i/CMqHR4qjO2u5yxq+PniTqFuNakEkl0jHIjspZTMGxQvKwmoWx/q8PrhGkiu5IqGeCKgKuDoBjwvywYZLRU5d4koRiOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315674; c=relaxed/simple;
	bh=Bhs04KRfRQvGIUrz4dzn3/izuilfGY5/AIEzWkc0b4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qL8yMuG369JDynDrCgz72tArfY4BDXEpiiYiO+C43wphQnjEDpLDmDWuylnbSHXrLeWNQw1Kz1JojdJ2G8bN7LHtAGK/3K3p0YGIq0WHOTOn2Broy6YWB7QMgm4ENxr+rZlkO0Cf2x6kjtr831o7D/8552AGXpmZ/OWOFqsNh3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OUrawLPe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PEUnuyo3lv8xn/euDjI9tjOuOh4F6Q7bzHZN/CcSabk=; b=OUrawLPeNmRQKiVkHFQSboDgmt
	/DeTlAS1+leaw+52uRjWR6ujt9jDCzmuKKltyNXb4CQXaVJrX7GBcZyJoghGlPEsT2hTtFB/HdeQe
	yyUdd+E46ifHaJ2lZa9wCoA1UzDruhF+z0zvakY/i+NUJYkhw1AY35dyK3vX7qbWvhBZs3d3NB+5h
	pBMeW1r7IIBJDuAxJETD4uWt5BJhQI8VivET1q0P2jZQ7dCSMy9HwhKg5HPkeQ7ZEr68lvWuMHdEA
	7PxGobCyvV2fHYqbbmbY2lgjMqlGgHObpbcUXuETQDQikofC10Fxyr0pLCkMs+cOx0icjVP1Psf8D
	Wh39c2sg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQv-00000000maM-3Cpk;
	Fri, 22 Nov 2024 22:47:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iig-1wFO;
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
Subject: [RFC PATCH v2 14/16] x86/kexec: Debugging support: Load an IDT and basic exception entry points
Date: Fri, 22 Nov 2024 22:38:23 +0000
Message-ID: <20241122224715.171751-15-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 114 +++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 5c174829f794..4ace2577afc6 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -40,6 +40,9 @@ SYM_DATA(kexec_pa_swap_page, .quad 0)
 SYM_DATA_LOCAL(pa_backup_pages_map, .quad 0)
 
 #ifdef DEBUG
+	/* Size of each exception handler referenced by the IDT */
+#define EXC_HANDLER_SIZE	6 /* pushi, pushi, 2-byte jmp */
+
 SYM_DATA_START_LOCAL(reloc_kernel_gdt)
 	.balign 16
 	.word   reloc_kernel_gdt_end - reloc_kernel_gdt - 1
@@ -108,6 +111,11 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
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
@@ -137,6 +145,52 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* Test that we can load segments */
 	movq	%ds, %rax
 	movq	%rax, %ds
+
+	/* Load address of reloc_kernel, at start of this page, into %rsi */
+	lea	relocate_kernel(%rip), %rsi
+
+	/*
+	 * Build an IDT descriptor in %rax/%rbx. The address is in the low 16
+	 * and high 16 bits of %rax, and low 32 of %rbx. The niddle 32 bits
+	 * of %rax hold the selector/ist/flags which are hard-coded below.
+         */
+	movq	%rsi, %rax         // 1234567890abcdef
+
+	andq	$-0xFFFF, %rax    // 1234567890ab....
+	shlq	$16, %rax         // 567890ab........
+
+	movq	$0x8F000010, %rcx // Present, DPL0, Interrupt Gate, __KERNEL_CS.
+	orq	%rcx, %rax        // 567890ab8F000010
+	shlq	$16, %rax         // 90ab8F000010....
+
+	movq	%rsi, %rcx
+	andq	$0xffff, %rcx     // ............cdef
+	orq	%rcx, %rax        // 90ab87000010cdef
+
+	movq	%rsi, %rbx
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
+	movq	%rax, (%rsi)
+	movq	%rbx, 8(%rsi)
+	addq	$16, %rsi
+	addq	$EXC_HANDLER_SIZE, %rax
+	loop	1b
+
+	/* Now put an IDTR on the stack (temporarily) to load it */
+	subq	$0x100, %rsi
+	pushq	%rsi
+	pushw	$0xff
+	lidt	(%rsp)
+	addq	$10, %rsp
 #endif /* DEBUG */
 
 	/*
@@ -345,3 +399,63 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	int3
 SYM_CODE_END(swap_pages)
 
+#ifdef DEBUG
+SYM_CODE_START_LOCAL_NOALIGN(exc_vectors)
+	/* Each of these is 6 bytes. */
+.macro vec_err exc
+	UNWIND_HINT_ENTRY
+	. = exc_vectors + (\exc * EXC_HANDLER_SIZE)
+	nop
+	nop
+	pushq	$\exc
+	jmp	exc_handler
+.endm
+
+.macro vec_noerr exc
+	UNWIND_HINT_ENTRY
+	. = exc_vectors + (\exc * EXC_HANDLER_SIZE)
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
+#endif /* DEBUG */
-- 
2.47.0



Return-Path: <linux-kernel+bounces-448307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9FE9F3E57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498DF188F6CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF51DE891;
	Mon, 16 Dec 2024 23:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HZk53P+Q"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAB91D9592
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392263; cv=none; b=Geowl0flhpq08bPYh+h4Efy3fUAovZjLY4wovshqeDC5ZZ9NZ64FiXUCE4SsL8b+5yUEuhHcMTDO6PGI2BZiQIqUOoa8IWek8+aqulG50iFRRHYpx3/K65KL8F2+kJQKRNJfqrjMBqSW8gTEtmMegEznHpF1cJq6HXieE/CMB1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392263; c=relaxed/simple;
	bh=aaxElBxQe7VbZoqviico/VjmU+O3c6qs4deC5d6uovc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QnBcgueod4LdvzSD3eq9N69YADIhpUJsZFHRA4+38thwwZ+ChAMANQA2r1NhLQokHIKA0xYehcPvYxQZn8L23JYYYfm1QrmQDHY/Xsm225fL0lhyterireCA5UifGJQhqVf8Ogkj72WrZp4Fg2uTDmKAQiCFJMwwwMWiwRv2kno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HZk53P+Q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=3ORzIP291/TaZUjjutyd5sQ2ZIP1eUhgRH/ydhloMEg=; b=HZk53P+QNu/mMYp9+pOCm1RQGW
	0oTqkJukX/mf5SQigAHRX4z3odyjtFe+o7CnSBQUZsYHhuQsseTwukoJKAVW0FmKskEc0IPfA99yP
	0+LVkk5hTdxxiK9TrUrtWR3ITPW3DEHSCHrkydpSN8T0Aq8+i/hs2fZN/bnSOTWR8vgDj8f92Yuuh
	28SUD2RjFX537iXog2goRxBZ9MGlzB16AfxacU5J1txpykakwRSk8VtGBe76t+VXzccKo8sWbpdm+
	8YWQ4b4om5dIXdNqT33btYU5oQyudc9FcbE+/phWOWGa4uV7x/G1qh3Dxv/od73MLQlNVZpODG2KO
	F4OQdngA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeB-00000004xiO-2A3d;
	Mon, 16 Dec 2024 23:37:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeWF-0frC;
	Mon, 16 Dec 2024 23:37:06 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	David Kaplan <david.kaplan@amd.com>,
	Tao Liu <ltao@redhat.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Rong Xu <xur@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	bsz@amazon.de,
	nathan@kernel.org
Subject: [PATCH 4/9] x86/kexec: Fix stack and handling of re-entry point for ::preserve_context
Date: Mon, 16 Dec 2024 23:24:11 +0000
Message-ID: <20241216233704.3208607-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241216233704.3208607-1-dwmw2@infradead.org>
References: <20241216233704.3208607-1-dwmw2@infradead.org>
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

A ::preserve_context kimage can be invoked more than once, and the entry
point can be different every time. When the callee returns to the kernel,
it leaves the address of its entry point for next time on the stack.

That being the case, one might reasonably assume that the caller would
allocate space for it on the stack fram before actually performing the
'call' into the callee.

Apparently not, though. Ever since the kjump code was first added in
2009, it has set up a *new* stack at the top of the swap_page scratch
page, then just performed the 'call' without allocating any space for
the re-entry address to be returned. It then reads the re-entry point
for next time from 0(%rsp) which is actually the first qword of the page
*after* the swap page, which might not exist at all! And if the callee
has written to that, then it will have corrupted memory it doesn't own.

Correct this by pushing the entry point of the callee onto the stack
before calling it. The callee may then adjust it, or not, as it sees fit,
and subsequent invocations should work correctly either way.

Remove a stray push of zero to the *relocate_kernel* stack, which may
have been intended for this purpose, but which was actually just noise.

Also, loading the stack for the callee relied on the address of the swap
page being in %r10 without ever documenting that fact. Recent code
changes made that no longer true, so load it directly from the local
kexec_pa_swap_page variable instead.

Fixes: b3adabae8a96 ("x86/kexec: Drop page_list argument from relocate_kernel()")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 0d6fce1e0a32..b680f24896b8 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -113,8 +113,6 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * %r13 original CR4 when relocate_kernel() was invoked
 	 */
 
-	/* set return address to 0 if not preserving context */
-	pushq	$0
 	/* store the start address on the stack */
 	pushq   %rdx
 
@@ -208,12 +206,19 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 .Lrelocate:
 	popq	%rdx
+
+	/* Use the swap page for the callee's stack */
+	movq	kexec_pa_swap_page(%rip), %r10
 	leaq	PAGE_SIZE(%r10), %rsp
+
+	/* push the existing entry point onto the callee's stack */
+	pushq	%rdx
+
 	ANNOTATE_RETPOLINE_SAFE
 	call	*%rdx
 
 	/* get the re-entry point of the peer system */
-	movq	0(%rsp), %rbp
+	popq	%rbp
 	leaq	relocate_kernel(%rip), %r8
 	movq	kexec_pa_swap_page(%rip), %r10
 	movq	pa_backup_pages_map(%rip), %rdi
@@ -247,6 +252,7 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	lgdt    saved_context_gdt_desc(%rax)
 #endif
 
+	/* relocate_kernel() returns the re-entry point for next time */
 	movq	%rbp, %rax
 
 	popf
-- 
2.47.0



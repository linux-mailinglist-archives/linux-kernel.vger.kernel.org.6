Return-Path: <linux-kernel+bounces-448309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F4C9F3E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8499A189047F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C931D9592;
	Mon, 16 Dec 2024 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C4BhlY9t"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BFB1DED49
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392266; cv=none; b=VsaPc5Dg33qGtFX12bMQNBdBCiKsuAr1HgPs49/442HntKFf4AB7dAvD16VWrDxjVVqrkutUcVrlifHiWtqjFQ7WTCUz0u0r34wKQiUH+phXoJfIcksQf72c2jM0sM1qLkJ4CQFSm1Ra9lThO3tjCBHl3yNeOeFWeaHsC+nysQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392266; c=relaxed/simple;
	bh=ZnFGZgBd4aLQO4C/x8vIGcFWrrbQsg7gzuJ2gVC5XKg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qK4Cv9DDyE05oT/3qZRQXEULCu58UCQZ11rhmC4nJ2pecsjZsPZg3tKbErS6xauj99F2QaKCwPm+bhOS2rj1SS+e+jgv/TOrTjNlF+9uh6PiAjVs76HSnzkNu8c9EXzIY/ALQtF0GRny5EitD+jAb9XZHxjXRr8SCiJ3Og61qGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C4BhlY9t; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=qnDZGmQXXRBfaYMiHf8RcgZ8w0/B4+1DdFBULwwOb1o=; b=C4BhlY9tosLdIgFYuh5FbO/pL/
	7pNlWsSUXRZ1uO0qtK2mm/dZ0iRLw8BpfekA09Za0yudhv6GpxK5wD9LykP53btHBu8t84yPPLeJc
	hR4RYsxmPxIjQ+gIfBazGmf3BYNpEgmJuQVvPgQiBny2vTiCeytTB1OrzDrwiwjGLf9pLrFOKu+SA
	X3AS/tMDFA29VUlMJdqqTllWAqPSXjP6LTmuQ4oUP6EGhKLRleXwIBhpqe+eXYSsny4nZ/OhwQ95n
	R1pH7h1yp/HOhIEXY6kRe9vqzQKXt/+qGQlM1G3hWAZ3paIT2bnB3dX4UJrUOA8hfayYQ+LdkrPwn
	hPpVuuVw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeB-00000004xiQ-2AqD;
	Mon, 16 Dec 2024 23:37:09 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeWV-1XPO;
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
Subject: [PATCH 8/9] x86/kexec: Cope with relocate_kernel() not being at the start of the page
Date: Mon, 16 Dec 2024 23:24:15 +0000
Message-ID: <20241216233704.3208607-9-dwmw2@infradead.org>
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

A few places in the kexec control code page make the assumption that the
first instruction of relocate_kernel is at the very start of the page.

To allow for Clang CFI information to be added to relocate_kernel(), as
well as the general principle of removing unwarranted assumptions, fix
them to use the external __relocate_kernel_start symbol that the linker
adds. This means using a separate addq and subq for calculating offsets,
as the assembler can no longer calculate the delta directly for itself
and relocations aren't that versatile.

Turn the jump from relocate_kernel() to identity_mapped() into a real
indirect 'jmp *%rsi' too, while touching it. There was no real reason
for it to be a push+ret in the first place, and adding Clang CFI info
will also give objtool enough visibility to start complaining 'return
with modified stack frame' about it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1996cea909ff..d74798d78263 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -95,11 +95,10 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	lea	PAGE_SIZE(%rsi), %rsp
 
 	/* jump to identity mapped page */
-	addq	$(identity_mapped - relocate_kernel), %rsi
-	pushq	%rsi
-	ANNOTATE_UNRET_SAFE
-	ret
-	int3
+	addq	$identity_mapped, %rsi
+	subq	$__relocate_kernel_start, %rsi
+	ANNOTATE_RETPOLINE_SAFE
+	jmp	*%rsi
 SYM_CODE_END(relocate_kernel)
 
 SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
@@ -219,16 +218,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 
 	/* get the re-entry point of the peer system */
 	popq	%rbp
-	leaq	relocate_kernel(%rip), %r8
 	movq	kexec_pa_swap_page(%rip), %r10
 	movq	pa_backup_pages_map(%rip), %rdi
 	movq	kexec_pa_table_page(%rip), %rax
 	movq	%rax, %cr3
+
+	/* Find start (and end) of this physical mapping of control page */
+	leaq	(%rip), %r8
+	ANNOTATE_NOENDBR
+	andq	$PAGE_MASK, %r8
 	lea	PAGE_SIZE(%r8), %rsp
 	movq	$1, %r11	/* Ensure preserve_context flag is set */
 	call	swap_pages
 	movq	kexec_va_control_page(%rip), %rax
-	addq	$(virtual_mapped - relocate_kernel), %rax
+	addq	$virtual_mapped, %rax
+	subq	$__relocate_kernel_start, %rax
 	pushq	%rax
 	ANNOTATE_UNRET_SAFE
 	ret
-- 
2.47.0



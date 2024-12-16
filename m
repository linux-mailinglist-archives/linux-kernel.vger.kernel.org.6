Return-Path: <linux-kernel+bounces-448304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348AF9F3E51
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A92188D2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA61DD54C;
	Mon, 16 Dec 2024 23:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gY/TwmhM"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521681DACAF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734392260; cv=none; b=gxPMqb7TU4eRm83AKdxz1OryDurt9Li3PKFZXWzKQVAWbFAAIj3GEYLk9V0/Jqqa1zoNbjWjx2TWOfUSsvuovzaLKkK0nbWKT5Ox+CSngFRxBD0Vz5YQ8/fwY8JC+sLZLMbQ3FL4s9qhPR+8qOcBVUxWnrFFQC/37qhvj5dmWZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734392260; c=relaxed/simple;
	bh=J15PTcLBO+YxoVKNHZq8FmvDQXS8n+Mg0vCpOx+RUxs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTYWC2G87XmgKUrUjiqhebaggkti3elkZGKEKbTtj4REg1xeUNpJqpuAhcKfpFvXWZEtLb3yDock2AODhD1I8tspK4ndNZEP+vDV9O3hRmKuGOxzMW83eEEueBz+aH2sngPZ0IRQ4nd7ktybifrNeoouQYfAWGy6SKpp0+VS2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gY/TwmhM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description;
	bh=zzCHIqIiQJDgySmzgmnKF8ZlcgBrOOsvhFm4kYphShs=; b=gY/TwmhMVrUX4ruTov+kQpAeXq
	vUof0P+v8tmNgZzieQgAPFNfKsdCHZ/fwo462vl2AG6mOxorwVgsneYQhjXjghSswbLIN6yyq2tG4
	MLM5EBtf9WXI43ph0N7ap72TpygIWsaBhtBU+fFNKjt/VY3Rpmjp1TLnWE0uLjvSh15dTjVNS0Zqq
	xsxKda+QdQW9Z/ITvj5zEnY921zH0MMyZEtqdA6/StFGUzAoRPMx0NaN6IQY4fANl3FpmUJQlxLGP
	TX9n2KDYVOHgvF5DsVSzF60WeTB/u/TkkLqwmClvBnb+T2Wv3wqAtEWxJKwwFM/tQCqlMGEFmxN56
	4l17Grwg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-000000034nX-25us;
	Mon, 16 Dec 2024 23:37:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNKeA-0000000DeW9-0Qg3;
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
Subject: [PATCH 3/9] x86/kexec: Use correct swap page in swap_pages function
Date: Mon, 16 Dec 2024 23:24:10 +0000
Message-ID: <20241216233704.3208607-4-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The swap_pages function expects the swap page to be in %r10, but there
was no documentation to that effect. Once upon a time the setup code
used to load its value from a kernel virtual address and save it to an
address which is accessible in the identity-mapped page tables, and
*happened* to use %r10 to do so, with no comment that it was left there
on *purpose* instead of just being a scratch register. Once that was no
longer necessary, %r10 just holds whatever the kernel happened to leave
in it.

Now that the original value passed by the kernel is accessible via
%rip-relative addressing, load directly from there instead of using %r10
for it. But document the other parameters that the swap_pages function
*does* expect in registers.

Fixes: b3adabae8a96 ("x86/kexec: Drop page_list argument from relocate_kernel()")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 1a52e4339c1d..0d6fce1e0a32 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -264,6 +264,10 @@ SYM_CODE_END(virtual_mapped)
 	/* Do the copies */
 SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	UNWIND_HINT_END_OF_STACK
+	/*
+	 * %rdi indirection page
+	 * %r11 preserve_context
+	 */
 	movq	%rdi, %rcx	/* Put the indirection_page in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
@@ -302,7 +306,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	jz	.Lnoswap
 
 	/* copy source page to swap page */
-	movq	%r10, %rdi
+	movq	kexec_pa_swap_page(%rip), %rdi
 	movl	$512, %ecx
 	rep ; movsq
 
@@ -314,7 +318,7 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 
 	/* copy swap page to destination page */
 	movq	%rdx, %rdi
-	movq	%r10, %rsi
+	movq	kexec_pa_swap_page(%rip), %rsi
 .Lnoswap:
 	movl	$512, %ecx
 	rep ; movsq
-- 
2.47.0



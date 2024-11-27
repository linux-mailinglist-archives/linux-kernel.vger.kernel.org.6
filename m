Return-Path: <linux-kernel+bounces-423851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF6F9DAD87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 229EEB2294F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42D5204F62;
	Wed, 27 Nov 2024 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CKL0Pnq6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A852036FE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732734251; cv=none; b=UduJlPHzE670tpNvvDxy0afJD5oj+cfzttUQacmLGac4EzBjHebhQ5HG3rskiJBXZKiVSmhsV+i5AqgXnjhscFY3ksydwZ9tt95sArZzX3zPAkFgLaHaL3KDzgfRX5mEhPaOV/7m2mxpTmUesodc9cfP6dbBZuXDhr5fC2Hd9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732734251; c=relaxed/simple;
	bh=0IXqucUxMBmTpYcXB8raPtO79+38AarfDo7A5uJ9hsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqWNNNyRJjDHHamZS1672dvhK4O1m3ye+eE4QjSnFYbjINaj9N3RinxkZ+bf1y5PyEE4wttx7SseMyjJ2nN4QxMKhCQnelfdng+QeoAt5vmnl7dLb+KTQwEn9d3OZToqQwGp4Ya4CHm0ndOHxRqN6ZjxkMGkNtIq+q1JVZWByaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CKL0Pnq6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=fLZisNRVnIE7XYTDFZ5u5GD/dt85ViU8LD82f5fJODE=; b=CKL0Pnq6GJ1us0i0716sVxK93k
	GFKtUYNrh1URKFI+lnoi/NEdvJaeZFY/0VysNqn0jaMbJ9O6ALODaWllLzervIVGFpUKBaLcgg0mC
	qAlhQWKbO6liMmKDoRWKyWiBJJtctPwlkHU/+/8yoSmDfmgbQpc5+6hzoymzlEfNFYyrJ6psWfxLW
	w6dvX9l034i+XaEdwJSQwr6SrnHQByTws4kWc9nTOzxrveL7PgQ071+9vuAQNwNTWttYJIWl6cXDm
	LgmrDP0ygEEohMlmhR9i/JY73YqG5GSRx1L9gutbSrYdahF94zvBbtvLab627pNVVFUKceM6DK5Xv
	ApvNSYiw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKC-00000001cW3-3qom;
	Wed, 27 Nov 2024 19:03:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGNKD-00000000BiI-3sev;
	Wed, 27 Nov 2024 19:03:45 +0000
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
Subject: [RFC PATCH v4 03/20] x86/kexec: Use named labels in swap_pages in relocate_kernel_64.S
Date: Wed, 27 Nov 2024 19:00:17 +0000
Message-ID: <20241127190343.44916-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127190343.44916-1-dwmw2@infradead.org>
References: <20241127190343.44916-1-dwmw2@infradead.org>
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

Make the code a little more readable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 30 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 92478e2e254f..fea650f92606 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -279,31 +279,31 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rdi, %rcx	/* Put the indirection_page in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
-	jmp	1f
+	jmp	.Lstart		/* Should start with an indirection record */
 
-0:	/* top, read another word for the indirection page */
+.Lloop:	/* top, read another word for the indirection page */
 
 	movq	(%rbx), %rcx
 	addq	$8,	%rbx
-1:
+.Lstart:
 	testb	$0x1,	%cl   /* is it a destination page? */
-	jz	2f
+	jz	.Lnotdest
 	movq	%rcx,	%rdi
 	andq	$0xfffffffffffff000, %rdi
-	jmp	0b
-2:
+	jmp	.Lloop
+.Lnotdest:
 	testb	$0x2,	%cl   /* is it an indirection page? */
-	jz	2f
+	jz	.Lnotind
 	movq	%rcx,   %rbx
 	andq	$0xfffffffffffff000, %rbx
-	jmp	0b
-2:
+	jmp	.Lloop
+.Lnotind:
 	testb	$0x4,	%cl   /* is it the done indicator? */
-	jz	2f
-	jmp	3f
-2:
+	jz	.Lnotdone
+	jmp	.Ldone
+.Lnotdone:
 	testb	$0x8,	%cl   /* is it the source indicator? */
-	jz	0b	      /* Ignore it otherwise */
+	jz	.Lloop	      /* Ignore it otherwise */
 	movq	%rcx,   %rsi  /* For ever source page do a copy */
 	andq	$0xfffffffffffff000, %rsi
 
@@ -328,8 +328,8 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	rep ; movsq
 
 	lea	PAGE_SIZE(%rax), %rsi
-	jmp	0b
-3:
+	jmp	.Lloop
+.Ldone:
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-- 
2.47.0



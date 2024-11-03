Return-Path: <linux-kernel+bounces-393704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB77E9BA434
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69888281E63
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C16165F17;
	Sun,  3 Nov 2024 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AtBu14Me"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CEF1632C6
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730612450; cv=none; b=MkgDIyoDkMyDxvUzqh1caftf1AyX1LVIvvv5KQVUpF9St5Wi+8CMTXxcXANAABf5zhogasys6Em5wpSZYEbJGx+ncoNNc8WfqHfqYukXiMZ/92KW+izgvVA5o95OneEYFigIh20LMnBLsdYZlS7LC2q9bTWtDBpGBh8D+Nz4ahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730612450; c=relaxed/simple;
	bh=K1KWT/E7FsmLJnCOu1yHk/7CDe49pdoiyXXYyMdh1tE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rfSmjWv2BHl7ohbPI6IyH6th0UkkbGn9o8ilfhS806Fq7kuHpUSvJdjs/SQk0x8bAAOLAzAzV94O7+PPS4w94Cggut9y8NH8AWLR9WAJMS7cSLlZRnqH6RKNJe5PsmTLrx/MbZ58+JGHRKc6oFyA/knQSiSyF7/coXqdAEVZQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AtBu14Me; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KE2zAg0FNUcZu2wRX0Sf0y9yX7Pxf0UAIJCxTS4zamA=; b=AtBu14MeLBRdSkyzOtDpgPhJNB
	3hRjG+jBwG+OKjW8af0r6qd4L4MDNIOc9HpqqPZ6yqOwYyY/c+4tNlHrdAdxCEpQtByhqUtTRbUFS
	3ADKuLdlOc9fIaltzvdx22MV5t9wu9BRlTxF8Sziq63nS8xaLvhz9f2ZIdSdtxeBOCqj9ePDB/tfc
	oUwmFYQQ8Jir37/ai4G1WvXIXH4q2VoRyTU0JAkUu/vlotzyEBNfCoRI0QLDmibi9fbrVVa86tqjJ
	RbcloQZ6NiU8XMnJcYS6Sd1br20KFH4wTmITi5uORr80C90Fr39NU7StdRRpNpGREsP7fqQdfORZ9
	+LFYmD2A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLb-0000000B4NV-45eL;
	Sun, 03 Nov 2024 05:40:29 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLa-0000000FvLD-3WY6;
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
Subject: [RFC PATCH 2/7] x86/kexec: Use named labels in swap_pages in relocate_kernel_64.S
Date: Sun,  3 Nov 2024 05:35:27 +0000
Message-ID: <20241103054019.3795299-3-dwmw2@infradead.org>
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

Make the code a little more readable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 30 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index c065806884f8..e607c0b7d70b 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -271,31 +271,31 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
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
 
@@ -320,8 +320,8 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
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
2.44.0



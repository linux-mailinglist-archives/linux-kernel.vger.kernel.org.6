Return-Path: <linux-kernel+bounces-418820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB619D65E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CE6161667
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792FF170A37;
	Fri, 22 Nov 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O2h2pjVi"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE428187332
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315665; cv=none; b=ELLN/p2nOWzoJ4p7H8IDNfpfivG+Cd4wVRfqYy+oC+r4qbVJmM7LguC9Apy1MgeUzkuLu8n6nUNtzCbVdb4yMWH5amkF3UWzy2zzywHTIx2SL8I1Yaqxxdhlb0JdzVX73ajv8/WdGfwO+PpVl8kjRop/AJOyL3HzoXectd0IyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315665; c=relaxed/simple;
	bh=Tut/DVSgyPMceFwEIPGjIQ9A3QJx8b1IbX24tJaHN8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tczk0TJulShFFzi0K4kILSrYTTkJDnjghO7K9XqLqGs1rAvFZKaPi2caLcnLIkqSERkkZvqROIl6T5ndV2M9qhdvK593Li4FzAxtX62E0yCbl4rUXp3eTm9C3zHEKHnPrcjVqcTiHVu80nhao3dCTf9zZKDlb8WmE2h+TMNeh/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O2h2pjVi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1mMILGYOmOJ50kB2grC2kFU1xTOvUAHt2PqPYBJoz2c=; b=O2h2pjViyLSTCP7Ozn1mTqmoBC
	FMVFz+vDuC6SvC9JfPMfjrx8q0FEncgN2xLnnxqnydc6EE0khAuF167GLgAcy9KzaDBloSWusYkFn
	E6sEUzXgobVwZNC2eCr+BpJUMTQK+43XixU/QcI5Mpa5CccGadMlwS7SAdLcbwIP5zNmvHA32UeBZ
	kxR89qod79D233IRJZuqnvwnJHokol62+CpJUuU5trQ/XSaq89H4LxHByeDsnTDpYoH6BH1og22mY
	XYb/QyRHjRKsuWfL5pfDMp1XVKU+vT/kYhpMoano5j1ruJd2nCWP8gVikszKRwr0ZiFIlBusps2Dh
	aLpp4uJA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000008PHR-2Caq;
	Fri, 22 Nov 2024 22:47:20 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQo-00000000ii6-3ky3;
	Fri, 22 Nov 2024 22:47:18 +0000
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
Subject: [RFC PATCH v2 02/16] x86/kexec: Use named labels in swap_pages in relocate_kernel_64.S
Date: Fri, 22 Nov 2024 22:38:11 +0000
Message-ID: <20241122224715.171751-3-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Make the code a little more readable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/kernel/relocate_kernel_64.S | 30 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 7ee32bcb6e01..ca01e3e2f097 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -272,31 +272,31 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
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
 
@@ -321,8 +321,8 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
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



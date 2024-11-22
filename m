Return-Path: <linux-kernel+bounces-418821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7C29D65E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34AF22838BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970D31C303A;
	Fri, 22 Nov 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j5eGqunu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB62176FD2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315666; cv=none; b=iqnaTDmonwhl1nRxtozQqUYryIuI2urAij3RTSMWPLfmVw0LTrk6VvIlqOxVOoLopwzCBD/+kdJzFzish/T6FNKvpWTV9olgHvmelKrlzkaHMwEnxxvwEr7R9AvRcDfiwnaF5o7Z1LgkA8UHcTFdbI3boTr3rYKGnSUqgMigwLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315666; c=relaxed/simple;
	bh=etXLrsfhpMzfNgr85hW8kZ0GD35Jbyx0gK4v/B6e5YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2q5u5AoK0UyrN6x763o8d/Ah1ytFy/olVUdhS/+zqa/5jakjrjFc+Ulc7NTJsOtSXXRvwpMW0RTbiaP1MrEH3QwQmIm+12KcsPjzCMqF2t3Dg336fNxQUpnpyams/S60p5tAISKPKHbPy8dvHSbMo+fn844E/9Nk9WC8G76y+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j5eGqunu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YMX4hA6TET2DRs4mytpddGAuD8BkAw4cael/oyJ3CzM=; b=j5eGqunufmPhasYy2LK3CUUVYV
	FMuL2WPvLJfDxgVpWHdc6ZNz9HzCGNJ6GJ7aIvw7CZYCEF6EMCdja/ezLz4UbLm5d/bGjiH9QPWym
	ie+6CZewJaSFrjYaDhevFCk6HQqdjZ40crIiHTKq5x4AYfW/kWIqONSXADQ3yM7eJfe0qexsDRYnS
	DXML8O7v6WHh7lwwylGeWvWpjcpFLil0W8/i1fvWCnJbjK2/JLk00Ob+3cNwq44+KLoZ7PYoylsk+
	GY9n4kJG71+jK2U+4P+UFEqPxo3dnJZalAzXi/eSb0BgnExDBkc9lK3nub4xKvJqqu4+lKNO+AD1A
	wCzb0c6A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000008PHT-2E7k;
	Fri, 22 Nov 2024 22:47:21 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQo-00000000ii9-3zyd;
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
Subject: [RFC PATCH v2 03/16] x86/kexec: Restore GDT on return from preserve_context kexec
Date: Fri, 22 Nov 2024 22:38:12 +0000
Message-ID: <20241122224715.171751-4-dwmw2@infradead.org>
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

The restore_processor_state() function explicitly states that "the asm code
that gets us here will have restored a usable GDT". That wasn't true in the
case of returning from a preserve_context kexec. Make it so.

Without this, the kernel was depending on the called function to reload an
appropriate GDT.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index ca01e3e2f097..ed2ae50535dd 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -252,6 +252,11 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	movq	CR0(%r8), %r8
 	movq	%rax, %cr3
 	movq	%r8, %cr0
+
+	/* Saved in save_processor_state. */
+	movq    $saved_context, %rax
+	lgdt    saved_context_gdt_desc(%rax)
+
 	movq	%rbp, %rax
 
 	popf
-- 
2.47.0



Return-Path: <linux-kernel+bounces-393699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD049BA42F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B9FB20E04
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B7149C6A;
	Sun,  3 Nov 2024 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jO9C1c79"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2D70833
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730612443; cv=none; b=WZ72JSWg/cEd0pzcGz8aEzkDplNEeCFxbfaMbpTnEvloTj7+2lbIDa1IBHRZm1YYHWm5cxbym0wOwZQDEf1J4TtjNtaOTRjGSWj4ghFgXQYOD0QWL4wVEQAakv1r3neXr6l0t3JNl/Y6OZCRJHT3Wz4AttGBhaQ9scU0PZVIt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730612443; c=relaxed/simple;
	bh=TU9+UXf7+RHIl2GCb3qmVvh9GSTfxpS2NpMu5EjjhVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rd5YhnSnM/erPjxYCLCitVCNXhuCgGz7kxuJXe6eKPyAlLluoCI6cPmjEo/Wp7MalR5C9eOKJRJ44Gxc7CCgeYQXzZKItYB6K29ETyLG4gqINUsJoP7ssOfsiSq+7S6qRYNVYydB+8ebDI+I/KQz65LDPMzDxWLZIrufssgiRVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jO9C1c79; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=b9tRHLeN7pxr2xLddlnhC83jvrEl3kzVd1otLRBzbTE=; b=jO9C1c79487FhflAUbwCJXVvep
	IS2n0bhmHSa0v4UNoWe/2n9mZpNuTvAoBh+a6iE+2qJIoJ5RCVK1Yb3Y/F28Of9qEVlH2Nkme22eD
	MmdptXVsZXviyiN7cPhxIwAiatf1M4w7DH1STwE4AFwZkl4VVybStgt0rfPaoUgDJ5V74WFtlJuJ1
	tUCLZ5Q2obhJgUyNNiqNF0FvgbxzVzHTTUWlsd3ryjyaDToXWuMBJk7x3p60VkG/11V3L4TXdMO+V
	TbpFwFHmNMQaDRgrB4xHChR6ZWdx3UGuxnpTIdzsp30qH/fFv/8KMiXdFbnvEBamgKGI45dUK9SSr
	Pxld+mCQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7TLa-0000000HSiN-2SWN;
	Sun, 03 Nov 2024 05:40:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1t7TLa-0000000FvLL-3x2L;
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
Subject: [RFC PATCH 4/7] x86/kexec: Debugging support: load a GDT
Date: Sun,  3 Nov 2024 05:35:29 +0000
Message-ID: <20241103054019.3795299-5-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

There are some failure modes which lead to triple-faults in the
relocate_kernel function, which is fairly much undebuggable for normal
mortals.

Adding a GDT in the relocate_kernel environment is step 1 towards being
able to catch faults and do something more useful.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 9b6ed08e00ea..2af4ce593645 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -131,6 +131,21 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* store the start address on the stack */
 	pushq   %rdx
 
+#ifdef DEBUG
+	/* Create a GDTR (16 bits limit, 64 bits addr) on stack */
+	leaq	.Lreloc_kernel_gdt(%rip), %r8
+	pushq	%r8
+	pushw	(%r8)
+
+	/* Load the GDT, put the stack back */
+	lgdt	(%rsp)
+	addq	$10, %rsp
+
+	/* Test that we can load segments */
+	movq	%ds, %rax
+	movq	%rax, %ds
+#endif /* DEBUG */
+
 	/*
 	 * Clear X86_CR4_CET (if it was set) such that we can clear CR0_WP
 	 * below.
@@ -331,5 +346,16 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	int3
 SYM_CODE_END(swap_pages)
 
+#ifdef DEBUG
+.Lreloc_kernel_gdt:
+	.word   1f - .Lreloc_kernel_gdt - 1
+	.long   0
+	.word   0
+	.quad   0x00cf9a000000ffff      /* __KERNEL32_CS */
+	.quad   0x00af9a000000ffff      /* __KERNEL_CS */
+	.quad   0x00cf92000000ffff      /* __KERNEL_DS */
+1:
+#endif /* DEBUG */
+
 	.skip KEXEC_CONTROL_CODE_MAX_SIZE - (. - relocate_kernel), 0xcc
 SYM_CODE_END(relocate_range);
-- 
2.44.0



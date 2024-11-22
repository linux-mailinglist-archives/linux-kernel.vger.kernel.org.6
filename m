Return-Path: <linux-kernel+bounces-418824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DF29D65EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51CEB28460A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352931DE4E4;
	Fri, 22 Nov 2024 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qcrkkUW+"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3D5184549
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315666; cv=none; b=Y72Odh8oT7dLPM1icOM+F5fEYhvYqt7O/k0JhTf9GkC9jwOfRPz8xolo165lggD8jt4dfuVgyTPluDqixg+x0i8uyt8n0B0JIbL5zLsqLGZyI0I2F3zc0KdGwJRHfS67GafXxgxqq/oqWBfwIedAy53fqNw6H1XTzpRuK4YduCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315666; c=relaxed/simple;
	bh=y3/a5/Ks2TnZdRoPI7F6nLHbCWNFoxgQiFOw1wppEkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+vOYy7Klk1VWfMAaNbpGTrifIc7Wcg2q2OlNqDkPjBPRBFJKVMWcEBpHir7+JUNDtv07RDayYgOXgeK3jb1JjwthOrsQBlHSOmPj9m2ncdoU7pCcoLyGTEhr+cWCgUIA7nGgTq/ALOpMgObqGWV1lqi2Zwx45OsJwxwSXhfB1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qcrkkUW+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=i2Ix5g+A/s6rVJXMB+lf9O3jUtCCFkDMNyc2WtM36JM=; b=qcrkkUW+O+/LLv5VlEXxqoKLUq
	vqS/kjBYrGoaV3SjGC0ZScvV8oYy/boURhybxSSDQXD+Tp8FemmCIWF5XEzKcx6W4bFHN+UydTbml
	iWfPdQTa9cIDlbkR5SJ7MPCttKEufeYq6l/VjTS4OVEw7QlriyfOg68wB5UwlfKLcks39Xs5gnvOz
	IN20cSOlitZHRRd7x7Naq+yFXBgwefuXdIiTmarYgXcKtHGABNxW5ODj84J7V9AUiP01TFVMsLakU
	7t9WNZ8qnvUdRwXJBaldpbwt87xi/+Jq3TP3bqPmMHEo98AEYsKZ33PJmdbG5p07douIckQr5hM7k
	BhkuZG0w==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQt-00000008PI5-15Yv;
	Fri, 22 Nov 2024 22:47:24 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiU-18nA;
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
Subject: [RFC PATCH v2 10/16] x86/kexec: Eliminate writes through kernel mapping of relocate_kernel page
Date: Fri, 22 Nov 2024 22:38:19 +0000
Message-ID: <20241122224715.171751-11-dwmw2@infradead.org>
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

All writes to the relocate_kernel control page are now done *after* the
%cr3 switch via simple %rip-relative addressing, which means the DATA()
macro with its pointer arithmetic can also now be removed.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 29 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index b9ad3ef0b982..5c6456467f08 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -61,21 +61,24 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq %r15
 	pushf
 
-	movq	%rsp, saved_rsp(%rip)
-	movq	%cr0, %rax
-	movq	%rax, saved_cr0(%rip)
-	movq	%cr3, %rax
-	movq	%rax, saved_cr3(%rip)
-	movq	%cr4, %rax
-	movq	%rax, saved_cr4(%rip)
-
-	/* Save CR4. Required to enable the right paging mode later. */
-	movq	%rax, %r13
-
 	/* zero out flags, and disable interrupts */
 	pushq $0
 	popfq
 
+	/* Switch to the identity mapped page tables */
+	movq	%cr3, %rax
+	movq	kexec_pa_table_page(%rip), %r9
+	movq	%r9, %cr3
+
+	/* Save %rsp and CRs. */
+	movq    %rsp, saved_rsp(%rip)
+	movq	%rax, saved_cr3(%rip)
+	movq	%cr0, %rax
+	movq	%rax, saved_cr0(%rip)
+	/* Leave CR4 in %r13 to enable the right paging mode later. */
+	movq	%cr4, %r13
+	movq	%r13, saved_cr4(%rip)
+
 	/* Save SME active flag */
 	movq	%r8, %r12
 
@@ -85,10 +88,6 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 
-	/* Switch to the identity mapped page tables */
-	movq	kexec_pa_table_page(%rip), %r9
-	movq	%r9, %cr3
-
 	/* Physical address of control page */
 	movq    %rsi, %r8
 
-- 
2.47.0



Return-Path: <linux-kernel+bounces-420798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B35369D831D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 735832891F2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC301AB6D8;
	Mon, 25 Nov 2024 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hz9yRkL/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373A192D68
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529317; cv=none; b=eAxRGJP8PH6kKmI/1f8PPUuaiuaFidcrlyxDKb4sy1euf/hrOldwCmWjWyQu/j1Fo0mv2Gbv+S4KHzp0ALkv4XjdYl/ANjUGD4I2hl1sDDSnLXlH88myBwivpcc321u/FhR1gS1f0yXVq9eQ3fi2w6ZtVUgINBxtVZ56lm+Mvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529317; c=relaxed/simple;
	bh=+pmdgCkhVTXULc+zNZF3mqNKSLVfJPhAcX/3S8Yjupo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doEymf78VG1bq9IdGP2TVsBa1bSG7zwOFiI3hptATq4JoMQMJ8lwB4iJWtw/iqknazSOWRT+1Oeg6fZRbJQcziToz6k/ix3/pJDJSzPHPgpEZot+p+0TIThvRIzS9+EDOQy3a4kyANpNWqmwJGGFHWwjbbi69yNpZXl7Nc1olP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hz9yRkL/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1uC9ZsG8+iSDsihXzKgc5JDj2Gbt5KFaLk2mOsYAE18=; b=Hz9yRkL/51WZ+iQPTOfsXpI1M0
	Io44/tFfv3HvNPTC30HtKctZcDnS9WF4bLtNX8jcHEPUnmYBRNaxz8Gd+ojnLpkUreLev8Vcufx5p
	nu84JTKFS8WrDq3dwgy2Ih4S6NeAGMJ6v4PbKgVsk8B39QwY0gEaW6bm3OodUKL43MGDZVGB9bGqX
	ZLx/uOI7aUY6U4yETF2fpw4h0Im15AGwaUD4RRMhIWtBxrEG/x4qD+fwG55uzwGw90ryXrDDh/gd2
	zC7u/3um2egCEN/XYpCXFyDX6x+OBn6lOBvCBLeAwhHS4UUd4Uj6kIo/FEVvT5gothf5I5QteHh5/
	qcXvO2+A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-0000000Bir9-441i;
	Mon, 25 Nov 2024 10:08:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFW0z-000000000lQ-3Amp;
	Mon, 25 Nov 2024 10:08:21 +0000
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
Subject: [RFC PATCH v3 12/20] x86/kexec: Eliminate writes through kernel mapping of relocate_kernel page
Date: Mon, 25 Nov 2024 09:54:42 +0000
Message-ID: <20241125100815.2512-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125100815.2512-1-dwmw2@infradead.org>
References: <20241125100815.2512-1-dwmw2@infradead.org>
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
index 16f123527406..288dfc08c63d 100644
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



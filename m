Return-Path: <linux-kernel+bounces-433549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B70D59E59CB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D41188665D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA08222582;
	Thu,  5 Dec 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I2oNb2UJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076E421C179
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 15:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412842; cv=none; b=jwwbsRV9tvDpKk6nLVk4XY6lTzmXHkjouWoOEj6PA+ek/TTMzf/pZpNGSfnfcKe4FTOXhOjMN1Th7eBwUx9/qhKtuAOQq1zSF8vSM3P8yTP/URjJdS+ki8RAdbeY/COgDBoPce/ClMG7slq0mSHTIVxPM2W/C0EyX8Hb7dl8EIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412842; c=relaxed/simple;
	bh=MjVsLckdiCBNZq9iVaa/SPkl4U5dQcUJNFlUyW9YUYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXVIW4o1Y6yb+PWMFLoj4X7zTAqfRc+d+D3xX4YzfdxvKodQjtbdLWgUKTJGZpN5QKRDnqngkKNWLn5KXK9kr7JJvYD1iQICknuRooK14KX/hp9aNq/+IdcfotaBVkWZ7tgNt/yeIIJtR2/3VWW9z926rnpc6sePfPdBenJRdQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I2oNb2UJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=B+cdGMrXlLMQ5gF/V+Me3rwZRfmBgngjB82bVhN99Q4=; b=I2oNb2UJjFauAMuN+/xgw3Gegw
	HanPAJkk+IMhIBHHZjJ0hfJuHDRBcXEm1VCpBvit/OIkD4TAv87hGrtioxVbodAYdV4GNKnMAECYC
	Giec+23STvlk9V/6RLRtEn7hqYQQzFnjW3F26t2qO7l9K3gUotLyd8shRifquSFfsOftZEXA3cvOo
	lg0pKnePImyrFl65zHgJFgd4xnBWSp9LfIjSE8lfTDJKYupOrp55GrFnCmKDGisMUL1MzQR8XyXN2
	HVTv4Xpw4drndPc8FkGFzD6Zpev9RESg9xOCltKLbIecM+Jkro1f6xB+YJ77sVlFCxtynaqBXZRRc
	/40qu9QA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrO-00000002wEx-0lzi;
	Thu, 05 Dec 2024 15:33:46 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tJDrN-0000000DyLz-2p7H;
	Thu, 05 Dec 2024 15:33:45 +0000
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
Subject: [PATCH v5 12/20] x86/kexec: Clean up register usage in relocate_kernel()
Date: Thu,  5 Dec 2024 15:05:18 +0000
Message-ID: <20241205153343.3275139-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205153343.3275139-1-dwmw2@infradead.org>
References: <20241205153343.3275139-1-dwmw2@infradead.org>
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

The memory encryption flag is passed in %r8 because that's where the
calling convention puts it. Instead of moving it to %r12 and then using
%r8 for other things, just leave it in %r8 and use other registers
instead.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/relocate_kernel_64.S | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 288dfc08c63d..b24198eb1fe9 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -79,24 +79,18 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	movq	%cr4, %r13
 	movq	%r13, saved_cr4(%rip)
 
-	/* Save SME active flag */
-	movq	%r8, %r12
-
 	/* save indirection list for jumping back */
 	movq	%rdi, pa_backup_pages_map(%rip)
 
 	/* Save the preserve_context to %r11 as swap_pages clobbers %rcx. */
 	movq	%rcx, %r11
 
-	/* Physical address of control page */
-	movq    %rsi, %r8
-
 	/* setup a new stack at the end of the physical control page */
-	lea	PAGE_SIZE(%r8), %rsp
+	lea	PAGE_SIZE(%rsi), %rsp
 
 	/* jump to identity mapped page */
-	addq	$(identity_mapped - relocate_kernel), %r8
-	pushq	%r8
+	addq	$(identity_mapped - relocate_kernel), %rsi
+	pushq	%rsi
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
@@ -107,8 +101,9 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/*
 	 * %rdi	indirection page
 	 * %rdx start address
+	 * %r8 host_mem_enc_active
+	 * %r9 page table page
 	 * %r11 preserve_context
-	 * %r12 host_mem_enc_active
 	 * %r13 original CR4 when relocate_kernel() was invoked
 	 */
 
@@ -161,7 +156,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	 * entries that will conflict with the now unencrypted memory
 	 * used by kexec. Flush the caches before copying the kernel.
 	 */
-	testq	%r12, %r12
+	testq	%r8, %r8
 	jz .Lsme_off
 	wbinvd
 .Lsme_off:
-- 
2.47.0



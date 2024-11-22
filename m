Return-Path: <linux-kernel+bounces-418832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A87699D65F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70814161C79
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF6D1E04A2;
	Fri, 22 Nov 2024 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UCav4PgT"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2771DFE0C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315674; cv=none; b=U3zDDXIb70i9qDj20V7BWSmbepECJGEjnIbaV1kaLO+Jr0Bt4lit0wJFwbLY8VM4QSE2tKIBunlC7A8wzhOq89oLpWeXhMKxTLnZ/jgovUhJtN5tuVL5fzU3ceSBL8myReRrxFVdon9dNw2RReSS/cdGepSusQ+tIYoaDOpPLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315674; c=relaxed/simple;
	bh=HL3ux3eNef6SY3eR0/deQX8VN0VjBmggbUcVLonrZgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUNFeMAUYmB7S41UMuAS0vo2ZXlBMQ+8xg1FtLp15l0/tJTkYmjiEEAhmed38VXb6bDywgEuVwFRNcAzEZKpdZmBwaprFWJuxSNhwttJv+U3XkGLhfyi2pvyG+uOxDcRiMhHDwRYc5tt1XuMaVPrl4lw63NoPN+dtcKxF+6icw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UCav4PgT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=j4VdY6af5RlPVPqmFUSdejWtC3j5qgVFRN++43ZJ7hw=; b=UCav4PgTGKePskAf9vMzi2epjA
	ROEgahlU9adV5GwqBDCw6RkMxLuvEL3NmwTdYDa6JYPraR6L7Vz/HDfQlFqya5WgP8X8Z0u+Sfg3R
	g1Nrw+YOE0NZrUeVwb6+ScNURx23Tg9T7PHCMSSVE+Zu25kzg08smKJAydcFDnoFEEc6t6fVtfydS
	uWcQjA+diU9kAdazzVvn5a6oqatNbJRPj1qJRx5PcVAMxypTiz64HOjtN7ohq/rAkT8emD3PpE4po
	TsCD2P6jE6+fVBIG+qkkvzqCJa9xzb5VfnjBH4i3vTPBMbepEimM1js5CaaP6t/3W04W2wv30rt2Z
	5Lj4kMkA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQv-00000000maK-3CSF;
	Fri, 22 Nov 2024 22:47:32 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEcQp-00000000iiX-1KwP;
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
Subject: [RFC PATCH v2 11/16] x86/kexec: Clean up register usage in relocate_kernel()
Date: Fri, 22 Nov 2024 22:38:20 +0000
Message-ID: <20241122224715.171751-12-dwmw2@infradead.org>
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
index 5c6456467f08..51dc55ac4395 100644
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



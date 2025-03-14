Return-Path: <linux-kernel+bounces-561886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75389A61827
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 18:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04B73AB886
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7403C2046A9;
	Fri, 14 Mar 2025 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gUQO3Uty"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46ADC2046A5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973768; cv=none; b=lH629s9fpgsrR3qWywVwY0Z151WvBk467puncRy1NYbGLVLCcZ3k4MZ46kGbStDl7NioFRrRQHaYKQUkpf2FreQdpBF6rEMidrqZXQbkHOVc1hAOTxpUUx9gM7V0Rl11/4PZTDqxlltJ8T7lRq0b/pWyF/t01ml+tWIQKlv/fnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973768; c=relaxed/simple;
	bh=eu1vahZq0TwHF+eFm6KndnNqayo/tNR4UGGuRmNnaZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2PjWliHllI9QJSk1w5LLRrf0Ao/PPSlE44G3E41fW7VuMp+1q035GndRnuuBBMDaXRE0za4Dqz4udsH2sS3V1Mz4ex+hvSWjhh+lv/pP4u7fXuS10H9jc5kp7m2qUESlk8yxDEMOYJxf+A2LU91LYAh/KBpsiZpYBd3YAsWPYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gUQO3Uty; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YA4cz3IqKYs8g/T34NdCWeOqKjRd9LcnyNkGC/9OpFU=; b=gUQO3UtyUMXfkoHY35Due7617c
	GQLNYIyJZ6cu5vT2UBXPDrWAmV0dG5RR+gk9dgwnutpLoljUUiHv1KXha68ASFKh0eQNsXvQPAkfH
	BV1pE5gV3kckJ9Zk1oa3GEJ+izc7bY1jHUqAgvXynaas1/9dxJfzLEaXDZmxG6n1s+tJZ3jiuEijP
	b8XpJxWBW4H0RvHS53dLW0+99NsJEiOpxTP69TJTY5pu24vCAipSQc6EjaxKhaVDe9kXF6NKwdnAT
	YfAJTMjs3RrHcwM8Er7/iWGVjdvRl9e5uXtsW8WVB/mYlzFTzEQPITJLsN0j4hmn/DiQozPaJDNrx
	YqcHAo9Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8ta-00000003tcs-2mto;
	Fri, 14 Mar 2025 17:32:35 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tt8tZ-0000000CsW8-0KEO;
	Fri, 14 Mar 2025 17:32:29 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kexec@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dave Young <dyoung@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	jpoimboe@kernel.org,
	bsz@amazon.de
Subject: [PATCH v8 5/7] x86/kexec: Invalidate GDT/IDT from relocate_kernel() instead of earlier
Date: Fri, 14 Mar 2025 17:27:37 +0000
Message-ID: <20250314173226.3062535-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314173226.3062535-1-dwmw2@infradead.org>
References: <20250314173226.3062535-1-dwmw2@infradead.org>
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

Commit 2114796ca041 ("x86/kexec: Mark machine_kexec() with __nocfi") marked
the machine_kexec() function with __nocfi because I failed to make objtool
happy when actually *providing* CFI information for the relocate_kernel()
function that it calls, and __nocfi was the easy workaround.

When that eventually gets fixed, the check on calling the relocate_kernel()
function pointer may trap. Obviously that should never happen unless the
function prototype gets messed up, but that's exactly what the CFI check is
for.

So it would be kind of helpful if the IDT was still in place and the trap
could be *handled*. It can remain valid until the moment that %cr3 gets
replaced, so shift the invalidation down into relocate_kernel() itself.

This is a useful cleanup regardless of making CFI work, so do it now.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   | 10 ++--------
 arch/x86/kernel/relocate_kernel_64.S |  9 +++++++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a2e00a814708..7abc7aa0261b 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -434,16 +434,10 @@ void __nocfi machine_kexec(struct kimage *image)
 	 * with from a table in memory.  At no other time is the
 	 * descriptor table in memory accessed.
 	 *
-	 * I take advantage of this here by force loading the
-	 * segments, before I zap the gdt with an invalid value.
+	 * Take advantage of this here by force loading the segments,
+	 * before the GDT is zapped with an invalid value.
 	 */
 	load_segments();
-	/*
-	 * The gdt & idt are now invalid.
-	 * If you want to load them you must set up your own idt & gdt.
-	 */
-	native_idt_invalidate();
-	native_gdt_invalidate();
 
 	/* now call it */
 	image->start = relocate_kernel_ptr((unsigned long)image->head,
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index cf736bbaec98..4f8b7d318025 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -79,8 +79,13 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	pushq %r15
 	pushf
 
-	/* zero out flags, and disable interrupts */
-	pushq $0
+	/* Invalidate GDT/IDT, zero out flags */
+	pushq	$0
+	pushq	$0
+
+	lidt	(%rsp)
+	lgdt	(%rsp)
+	addq	$8, %rsp
 	popfq
 
 	/* Switch to the identity mapped page tables */
-- 
2.48.1



Return-Path: <linux-kernel+bounces-557915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EF9A5DF4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801AD7AABCF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8B82500BE;
	Wed, 12 Mar 2025 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RbnOGxjY"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9494424DFE5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741790595; cv=none; b=fwUTgAC/HkgJgP+SLzbARz3cbAGxZD3WPz8vEfxcMz/ktMcQvfP0vSFqfG4Pr5W46zp7AtjpCljAeGnGDZbxjgkvAr51m3RO80rB3kpM/y9zpGRHURy1BxZzSo0PmKvICOoXO0SlZrnk5fACcBD4YeV+9zbZZ/Q7HRLfAXTQCwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741790595; c=relaxed/simple;
	bh=ul03oAcQXMefCTiGUi+eaIlIHO70h4py0AsG2feQ6QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZe7M0cwaIegtl/iqcFtwAvSkFaP7GCDIoTNoq/QD0GPsmYfRusH4osJMqjSWsKzYEvBf0Ge01RJL/224Xmuy2KYvlTDiOwK9Bbfut9xFhUBdo1BpjD7Yr9JmljBif1iqoVPdzIN1gOmtd/y95fmGaZx8nkunH+486XOkyHwfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RbnOGxjY; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=smwmDBLOWfUhJklrdermZZW/GJNGuEkisxlZADiwt80=; b=RbnOGxjYBz98oRqawqOY0eW/OF
	msz2Cc3lSLeyxwEwziWg51tcedhkawDdCSaIMwfmH9tDT3P4rjPwc6cQicRTetKsTKl+XQGKbltb4
	9xT1PMk/1KvwGc+fteEKwTTJV62/ucIaUbaD47TARCJfEDEy/Ijn3Sw5A4mZ+4en8P0KKb4vYV+mh
	Z1Ty6ksFmWmAUKMDy6uUnJqWZgGgy0ADNURLWpt5m+2hfb9HfCx4XLdw69SXy3sb/LCdM1wm6KoLi
	sKAKrSAUpanBRVteyV7SUZNWFcq7CZmqqO/+kuO8yMpgrmpkd7s7Y56qgS8bPoBYZ1lHas4xHa6u5
	+/GiIu+Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIS-00000002QEs-2cNj;
	Wed, 12 Mar 2025 14:43:00 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNIR-00000009uUc-2cfY;
	Wed, 12 Mar 2025 14:42:59 +0000
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
Subject: [PATCH v7 6/8] x86/kexec: Invalidate GDT/IDT from relocate_kernel() instead of earlier
Date: Wed, 12 Mar 2025 14:34:18 +0000
Message-ID: <20250312144257.2348250-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312144257.2348250-1-dwmw2@infradead.org>
References: <20250312144257.2348250-1-dwmw2@infradead.org>
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
index d58b4686645c..17d41e6e1a4b 100644
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



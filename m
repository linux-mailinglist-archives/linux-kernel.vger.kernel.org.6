Return-Path: <linux-kernel+bounces-577105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F88A7186A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD0E188D401
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C031F1818;
	Wed, 26 Mar 2025 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SIsdGIzD"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B7019F101
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999062; cv=none; b=B5S/E7qA53PDiRYfJ17sqFWPCB3d0Lpg3HHirLnp71MJGk+N2OMesznkiwNHhc919Wnb9b6vYJu+5KBNUI8WYptcmSeLaJLUhFUXWjBYsGEiGC3Pl9s644QiN3u32KwXyw0IQ/bXIaMbKC7J2s9kiBqWT0AUTXVhbeq+yI8MEnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999062; c=relaxed/simple;
	bh=hYrF90r2xFg7uxj0zdYW40vdg4phzS/EDjbLv+SWj4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zpa5qcWmopVbRpWbsVpRdiY6MkyD2yDcciy6xW4ShuQNrvxnXH+a5nLYx6r7KyIjl9NKbrywvBeYsNlC3CyAyiJImXcES/LFMWbFPs1Fj8Fca9aI3s8Y4YEBvulbAJDXfPwy5Qd4JlO3JDHE6OJKW/5Hz3vtgCU64RRyMQbK3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SIsdGIzD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RvmErclzm3ESdlbbeOIui5chM8AM69F81Cko6lvZeHg=; b=SIsdGIzD8wPLQpJkj76S3CBd1A
	066SsI15Z4cS/uwmEq58Ds9/2sxDMEV27Gux5EGiIsEkl4RWKztQdsL7NzDRqPURhs3VEpbh5C0hL
	L3XmrEQVfjRjQSnTHH4hjm9T1UdZTYSdAQCN70QAUP2Sq089P6w9wUcSDuY4kEhQkqgKo7mBvHq9P
	jqU+4u1x7YYHdOIAAw5jVu5fspeXSsVmxqFgTE+cDUM4Uw5XapXfsofSCb0CDqDaJD4O5/8ZnjiAH
	Ll6TVcJ9QuCHa/eYbMqedMBleDB/wBZKJKU9Bpfvr9oJcUwqW6WoQcCHT11/aWQUq0xfJK6CFnPgm
	f8k/JTug==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txRfq-000000005rg-3Q75;
	Wed, 26 Mar 2025 14:24:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1txRfq-00000001A9Q-2IUt;
	Wed, 26 Mar 2025 14:24:06 +0000
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
Subject: [PATCH v9 3/4] x86/kexec: Invalidate GDT/IDT from relocate_kernel() instead of earlier
Date: Wed, 26 Mar 2025 14:16:03 +0000
Message-ID: <20250326142404.256980-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326142404.256980-1-dwmw2@infradead.org>
References: <20250326142404.256980-1-dwmw2@infradead.org>
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

Reduce the window during which exceptions are unhandled, by leaving the
GDT/IDT in place all the way into the relocate_kernel() function, until
the moment that %cr3 gets replaced.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kernel/machine_kexec_64.c   | 10 ++--------
 arch/x86/kernel/relocate_kernel_64.S |  9 +++++++--
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ecb0da54abd1..949c9e4bfad2 100644
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
index 8808cfca6322..3062cb3efc44 100644
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



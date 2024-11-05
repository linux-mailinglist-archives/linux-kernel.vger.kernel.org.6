Return-Path: <linux-kernel+bounces-396362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ABF9BCC22
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C34283553
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F4F1D63CE;
	Tue,  5 Nov 2024 11:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IJ56XDuF"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A851D63C9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807279; cv=none; b=enZi0PhDN8NLAVpkmjPys3NSPRlH0ZeLeeywPZX58ELTSu4jk3QO1wZUd4QnoecxXsnXXCZfKkYMkIJTNhXCXEVwOo0euhBty7mQjD1Kf6pl+MloAqETov23Puz3V3ztuiDBNOaqOKa8eRAEG1GQlp6AtO9C/rhjK1RqH4h2HPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807279; c=relaxed/simple;
	bh=VidXdPtbh2bTuFCIDSaznp2IkB1WCS04s8nddvipaSw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Rh2MstQEeyldsmkQKpkyZBZ4h36j88Y7pElEaSQdngjhZJBSEAa8zWq2Vhq9xHFzT0qwecGVo7AvjWDghSIPmnpEvVRe1l4ZAC80QMGZ7wAFGHrFZeJ81xqMIWWjkbm1VeD1kalMaTCAZy2ccYLXlsXTiOpU+A+rFty1OPzJoUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IJ56XDuF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=tblBls7liJOC0BRcZvZJjuzCBGu7d6vWrUIadWdBE1c=; b=IJ56XDuFRfH+ykxqIdH2YX2Tom
	hoRlBb8ZStMPnX9S/U/zwCgHnDwKDk8xIH/TW8PQ6aJj+1pqpCUh3hN0BK0gERW/sgAZldvYZd7Ab
	WdaQa8fYfsV2Xp2E9sxZ32xrqt+jEIv/7OjzDc+MUdaeXTsADilDwn5bd8AdB1p95oxfWz3RFZPAn
	i12WSBhrSze5ocem5YmatiMMZ4+g3GXv+V+Bvt4JRGtROC4qbax8K9UlBcIe3Ked1BA6JB1Ua2SGE
	Zjkp8YlcD18rw46fxBPRALXVV3ytYCJzxrSr/r0PGvIkiBt/xrjhUA+8y+HADmZyVLtlwshmqbxlL
	KM5hwYIg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8I2E-00000002iAI-152h;
	Tue, 05 Nov 2024 11:47:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id E3A9530083E; Tue,  5 Nov 2024 12:47:45 +0100 (CET)
Message-Id: <20241105114522.068976491@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 05 Nov 2024 12:39:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 alexei.starovoitov@gmail.com,
 ebiggers@kernel.org,
 samitolvanen@google.com,
 kees@kernel.org
Subject: [PATCH 3/8] x86/boot: Mark start_secondary() with __noendbr
References: <20241105113901.348320374@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

The handoff between the boot stubs and start_secondary() are before IBT is
enabled and is definitely not subject to kCFI. As such, suppress all that for
this function.

Notably when the ENDBR poison would become fatal (ud1 instead of nop) this will
trigger a tripple fault because we haven't set up the IDT to handle #UD yet.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/smpboot.c |    3 ++-
 include/linux/objtool.h   |   13 ++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -228,7 +228,7 @@ static void ap_calibrate_delay(void)
 /*
  * Activate a secondary processor.
  */
-static void notrace start_secondary(void *unused)
+static void notrace __noendbr start_secondary(void *unused)
 {
 	/*
 	 * Don't put *anything* except direct CPU state initialization
@@ -313,6 +313,7 @@ static void notrace start_secondary(void
 	wmb();
 	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
 }
+NOENDBR_SYMBOL(start_secondary);
 
 /*
  * The bootstrap kernel entry code has set these up. Save them for
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -45,12 +45,18 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #endif
 
-#define ANNOTATE_NOENDBR					\
-	"986: \n\t"						\
+#define __ANNOTATE_NOENDBR(label)				\
 	".pushsection .discard.noendbr\n\t"			\
-	".long 986b\n\t"					\
+	".long " #label "\n\t"					\
 	".popsection\n\t"
 
+#define NOENDBR_SYMBOL(func)					\
+	asm(__ANNOTATE_NOENDBR(func))
+
+#define ANNOTATE_NOENDBR					\
+	"986: \n\t"						\
+	__ANNOTATE_NOENDBR(986b)
+
 #define ASM_REACHABLE							\
 	"998:\n\t"							\
 	".pushsection .discard.reachable\n\t"				\
@@ -157,6 +163,7 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define ANNOTATE_NOENDBR
 #define ASM_REACHABLE
+#define NOENDBR_SYMBOL(func)
 #else
 #define ANNOTATE_INTRA_FUNCTION_CALL
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0




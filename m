Return-Path: <linux-kernel+bounces-342135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901A6988AED
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515FA284E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA111C460B;
	Fri, 27 Sep 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IHoubrKT"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC41C3F3A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466663; cv=none; b=hvYcm14ux1wqRBabSyAzO98stmraq4pZO3+O0CA4ZVQf4EJKwNtoYYQZBQX7Tzw7oa1xaDRcF/LqEpxF+jfAEOSqSas9Klb6Fh+kGd0V0K4Btl8WscZquhnDpkKbElbVw14zpoCMMIlq+ontyamDb0egGR79s/NXGLYJ7nAEMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466663; c=relaxed/simple;
	bh=VidXdPtbh2bTuFCIDSaznp2IkB1WCS04s8nddvipaSw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nB+W3oKbEsq3N0pEpcBqxaK7uBM8pGuVKu1xemXC60yE65oZufP0e+nWR35IGkjF/yzreirsclfPgKo1+ZawJofa1aD8Y8RN68sJa8RwKZtyoIvehF0CA8bmO7CPX/q2/Z3S8sJJVuS7nnMFjPVHjPVwv1RQQUkB1eomjgSspsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IHoubrKT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=tblBls7liJOC0BRcZvZJjuzCBGu7d6vWrUIadWdBE1c=; b=IHoubrKTrxc7PXlAeVGX/qvMoW
	1sytf1UEZNtCUTwh1ae2KGF+/uYsDmss/uNLQq3v+KUApw3NSt6JA157HO6rZRs42EgYi2y04cO2+
	PlwCct2kf4y+iPRSstN4GHWbAhqP9Tc/bKCxuMi9t/yKMwJE/0fjGYXO77B9Z4rHBGnXJH35JQ088
	SLgMGxfWrrSJJl0WPH7dS57EXGloHn+wo8jh4j4a4TNYqYe+rg1AYFEVYiC4c4CmQ+VIpiSyxfUYN
	dzFi383uiJHT85ApaT6U5Trlm01THdhRLvsQJ75d60FjIH+edcfa4OrdZmv4xqr+r95b+SgDGSYfe
	U6DZcjdg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzF-00000002Onl-430Y;
	Fri, 27 Sep 2024 19:50:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id AEE10300C1F; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194924.504708296@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:48:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 alyssa.milburn@intel.com,
 scott.d.constable@intel.com,
 joao@overdrivepizza.com,
 andrew.cooper3@citrix.com,
 jpoimboe@kernel.org,
 jose.marchesi@oracle.com,
 hjl.tools@gmail.com,
 ndesaulniers@google.com,
 samitolvanen@google.com,
 nathan@kernel.org,
 ojeda@kernel.org,
 kees@kernel.org,
 alexei.starovoitov@gmail.com
Subject: [PATCH 02/14] x86/boot: Mark start_secondary() with __noendbr
References: <20240927194856.096003183@infradead.org>
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




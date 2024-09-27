Return-Path: <linux-kernel+bounces-342136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B28988AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017A1284D38
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747221C460F;
	Fri, 27 Sep 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S1Qoh504"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B58C1C3F3D
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466663; cv=none; b=G/opAZu2ueRKrN9NfY0pTguaHXqkmX8fxUiSRXihBN8CB6qqfYmA5HQaNu54WysJaOFaxK27iRu/Okt44DYcbgkGt0PqeQYg1hsTg90sq818Cr8CMm6j2nh1ZY0b9Qih1pSPVH1+gSNC5PNUYCQfO6xCGBMmxX09td0Dt6kQL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466663; c=relaxed/simple;
	bh=C1E04fEG9kmHcFxhirOzJyn20hcQMNssZ7QzcqdfwTM=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MVzMf8R2hAJyVstOxSfVHG8DviwRE0XlCQSPUXDFqQDffCoHLueO7hHRBWimrzI2xQ9dGy8P3boQTzvAsgwbll20zCYc2uvZ2faYZagngii/7q+vYtdjmn0+cFfkvY8zG+fMCOqeN3q8WF1XO9s7QNYc3dS+uEADImc6E9nmmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S1Qoh504; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=mrg3n5kuv76jLLAOEDkCz2d0wdxL1/leoBvVupWWebI=; b=S1Qoh504qprUUGxIj6ZrXSo8r6
	qO2fgjNDxjQN7IMGHeCbXneLBG5HIS82Ok4V0YMT90VDQjtxCySxnokKbS2D6zF+4P8pFLh3/glEE
	VxTFXjzRcuVLWaV7df1lDPKtqbVr0GPwAJhfP5EpuLy7oFGWVLG2wNhuqiIpidC4cT6HvjH+LATbS
	gsaBNJvDMP+s5DcsqiPaRR9vVgOnsnWKTv1Q6sey0ongG7JO3xq9sx8/vyyGDKQyi1ZJLJqtHOMyr
	52vqLqX4P6VPKT6lyQpAdRlCw+Lw61EXk5IJFXDEZ6r+J5KFCk5m7Ru9NDDSlm/7b4akdopHqJAh5
	cwtCjTAg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1suGzG-00000002Onp-2xjE;
	Fri, 27 Sep 2024 19:50:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id C6A3B308CAD; Fri, 27 Sep 2024 21:50:44 +0200 (CEST)
Message-Id: <20240927194925.177636534@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 27 Sep 2024 21:49:04 +0200
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
Subject: [PATCH 08/14] x86/ibt: Clean up poison_endbr()
References: <20240927194856.096003183@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Basically, get rid of the .warn argument and explicitly don't call the
function when we know there isn't an endbr. This makes the calling
code clearer.

Nota: perhaps don't add functions to .cfi_sites when the function
doesn't have endbr -- OTOH why would the compiler emit the prefix if
it has already determined there are no indirect callers and has
omitted the ENDBR instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -864,14 +864,12 @@ __noendbr bool is_endbr(u32 *val)
 
 static void poison_cfi(void *addr);
 
-static void __init_or_module poison_endbr(void *addr, bool warn)
+static void __init_or_module poison_endbr(void *addr)
 {
 	u32 poison = gen_endbr_poison();
 
-	if (!is_endbr(addr)) {
-		WARN_ON_ONCE(warn);
+	if (WARN_ON_ONCE(!is_endbr(addr)))
 		return;
-	}
 
 	DPRINTK(ENDBR, "ENDBR at: %pS (%px)", addr, addr);
 
@@ -896,7 +894,7 @@ void __init_or_module noinline apply_sea
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 
-		poison_endbr(addr, true);
+		poison_endbr(addr);
 		if (IS_ENABLED(CONFIG_FINEIBT))
 			poison_cfi(addr - 16);
 	}
@@ -1203,6 +1201,14 @@ static int cfi_rewrite_preamble(s32 *sta
 		void *addr = (void *)s + *s;
 		u32 hash;
 
+		/*
+		 * When the function doesn't start with ENDBR the compiler will
+		 * have determined there are no indirect calls to it and we
+		 * don't need no CFI either.
+		 */
+		if (!is_endbr(addr + 16))
+			continue;
+
 		hash = decode_preamble_hash(addr);
 		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
 			 addr, addr, 5, addr))
@@ -1223,7 +1229,10 @@ static void cfi_rewrite_endbr(s32 *start
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
 
-		poison_endbr(addr+16, false);
+		if (!is_endbr(addr + 16))
+			continue;
+
+		poison_endbr(addr + 16);
 	}
 }
 
@@ -1356,9 +1365,23 @@ static inline void poison_hash(void *add
 
 static void poison_cfi(void *addr)
 {
+	/*
+	 * Compilers manage to be inconsistent with ENDBR vs __cfi prefixes,
+	 * some (static) functions for which they can determine the address
+	 * is never taken do not get a __cfi prefix, but *DO* get an ENDBR.
+	 *
+	 * As such, these functions will get sealed, but we need to be careful
+	 * to not unconditionally scribble the previous function.
+	 */
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
 		/*
+		 * FineIBT prefix should start with an ENDBR.
+		 */
+		if (!is_endbr(addr))
+			break;
+
+		/*
 		 * __cfi_\func:
 		 *	osp nopl (%rax)
 		 *	subl	$0, %r10d
@@ -1366,12 +1389,17 @@ static void poison_cfi(void *addr)
 		 *	ud2
 		 * 1:	nop
 		 */
-		poison_endbr(addr, false);
+		poison_endbr(addr);
 		poison_hash(addr + fineibt_preamble_hash);
 		break;
 
 	case CFI_KCFI:
 		/*
+		 * kCFI prefix should start with a valid hash.
+		 */
+		if (!decode_preamble_hash(addr))
+			break;
+		/*
 		 * __cfi_\func:
 		 *	movl	$0, %eax
 		 *	.skip	11, 0x90




Return-Path: <linux-kernel+bounces-396364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9C59BCC24
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A366D1F22EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410A1D63E6;
	Tue,  5 Nov 2024 11:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k3Soq74z"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569C01D47DC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730807281; cv=none; b=u4FJpIrYX+bmCYTeIpdOJ0if8tKBh2x3/J4xXb96Pkl/s9Of6FOHhxk78WANnoDcuoCI2vWoJuNjjdRGyvG0NorXnXIlJuSLgB8WCXirMKH8OdNWQqSCIotW3NpqokYEDg/DMw2xVS6iwo3AtQJrxxJmnHq30xUUW6VyNEUfF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730807281; c=relaxed/simple;
	bh=jjIRVIVe7fUoo7NxieUatEeH1Fo61fxkHv2nmodJgEg=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IcwlPcjS5kNmxXZ32vZkpquTMEKVK4HUH6G38Kn4cF3NHKhm1N/IDuj0lUaG/bBoG927nvFJ30VO7beFXIcjZkNHwcJ9TrAQdZ957EiiUOxxPZt69uH7LdaJXaNAR60fhlSQMXJqHLns+yEpTFOs9Eek/JAjRSOafuar1y1MkwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k3Soq74z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=bc3E9QU7kUXplI6TGDYjrbxIqySGBgV7FhD6rJ3O/hg=; b=k3Soq74z47oiAjvh5+QX95JNHz
	fHOWssFDQEOKOOrrVaNKMFf6HfPyszJV6ylq0uUOzI4428sxbUKMpBoVg0+ogoUnuuAxgSYXZQ5Ik
	V/6RisfI7HrqBlgTvvYmZqI7dIdB26eOl1VpRqStv+dW5VIAtIRNx5m3dY9x7QscdnNdcGv1kSegb
	FMuxjJUE2zEDAq9KINq+0ptN3Jjznso0RloWRrelGDTcHoJf+/jWbQ7kswcmncH4ZBm5gVoXvgj4u
	UTzR0ZcMBI9a9W/82/3NxiJ5wmU869nv48UTENLKgRyyRUgYNFgjjnLURml5Qfnpu1VD2KBig67s4
	bTi9mIJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8I2E-00000002iAJ-1pFB;
	Tue, 05 Nov 2024 11:47:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 00A79300DF3; Tue,  5 Nov 2024 12:47:45 +0100 (CET)
Message-Id: <20241105114522.514586258@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 05 Nov 2024 12:39:08 +0100
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
Subject: [PATCH 7/8] x86/ibt: Clean up poison_endbr()
References: <20241105113901.348320374@infradead.org>
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

Note: perhaps don't add functions to .cfi_sites when the function
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




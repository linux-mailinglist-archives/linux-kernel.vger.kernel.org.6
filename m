Return-Path: <linux-kernel+bounces-424489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAEA9DB4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6BAFB22D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615F199E89;
	Thu, 28 Nov 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N4t7I81n"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69DB157E6B;
	Thu, 28 Nov 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732787049; cv=none; b=thjUkA+0oh3cXVekWHel01ZUSfC8tDKlCtQ44qqHtyLQ7AHlHAIMjdxXkcKqGvxgLCsAF+9umLcaqbc+IZK5xRdatmNc2zvuy24ChgtA9WoMiwUi1Q9UG8sc/5BYBHmWwGSNHrkblzVNLix3s+UHMxic5oACOtYhEztfzcL6ACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732787049; c=relaxed/simple;
	bh=N977qjYQyNiH1GU3lPNLCmz25IiPxBBU0fylee/nVqo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pbpmSAaVFkwdR2SQgP0492bJ7jfvBqbZg6fzB2/WTtNRsvkzwq0DMsJBMZHlO6FZJJp1BaYIaVp330a3MRrISQBuXJr9gmVH0fRoWZEqq5KsH8qpP7YAkIRdRfYMsRuh/RoxxeILsmzweirw7ZkIbAe8+VzxtOLGKymBi79c2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N4t7I81n; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=4LWTl2H6aL5DsJXRdlt+1kHQPXgTtK8uQyNB3mqvwQ0=; b=N4t7I81nqVpXZjTQb1b/H2gwkv
	puunr98yWFsnkP/y4Ugtd9d2OTo+OIm3jmjwvq1nmZV3M9fBnj1XilmsXRArkYY+pdx8K7MgbGqDa
	cVOct1+4N1RF2139IAvwJb6MTUzbUD0FSgKpYTrZviVFSqgKW7rWkWxKS1JCK8kLZwFlPyzJNlOs/
	39n/7HW+ImdE8z/J8kZz+d/Y9AyI09EvKpPY0deHc1pUWGpjuVsYmVbwYedUHSxlYusSeM1C3Z7jQ
	7VjPnj9K1S1b22V4hYW3jXh6BxTepqmFadx/r0p2x1UWKYpQ/0CI+sMP54wH3HLSC5Aw0ZrAlxeMy
	wXj+U2xg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tGb48-00000001a87-1hDT;
	Thu, 28 Nov 2024 09:44:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 23DE030119C; Thu, 28 Nov 2024 10:44:03 +0100 (CET)
Message-ID: <20241128094311.924381359@infradead.org>
User-Agent: quilt/0.66
Date: Thu, 28 Nov 2024 10:39:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: jpoimboe@kernel.org
Cc: chenhuacai@kernel.org,
 kernel@xen0n.name,
 x86@kernel.org,
 peterz@infradead.org,
 loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/16] unreachable: Unify
References: <20241128093851.469225872@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Since barrier_before_unreachable() is empty for !GCC it is trivial to
unify the two definitions. Less is more.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/compiler-gcc.h |   12 ------------
 include/linux/compiler.h     |   10 +++++++---
 2 files changed, 7 insertions(+), 15 deletions(-)

--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -52,18 +52,6 @@
  */
 #define barrier_before_unreachable() asm volatile("")
 
-/*
- * Mark a position in code as unreachable.  This can be used to
- * suppress control flow warnings after asm blocks that transfer
- * control elsewhere.
- */
-#define unreachable() \
-	do {					\
-		annotate_unreachable();		\
-		barrier_before_unreachable();	\
-		__builtin_unreachable();	\
-	} while (0)
-
 #if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP)
 #define __HAVE_BUILTIN_BSWAP32__
 #define __HAVE_BUILTIN_BSWAP64__
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -141,12 +141,16 @@ void ftrace_likely_update(struct ftrace_
 #define __annotate_jump_table
 #endif /* CONFIG_OBJTOOL */
 
-#ifndef unreachable
-# define unreachable() do {		\
+/*
+ * Mark a position in code as unreachable.  This can be used to
+ * suppress control flow warnings after asm blocks that transfer
+ * control elsewhere.
+ */
+#define unreachable() do {		\
 	annotate_unreachable();		\
+	barrier_before_unreachable();	\
 	__builtin_unreachable();	\
 } while (0)
-#endif
 
 /*
  * KENTRY - kernel entry point




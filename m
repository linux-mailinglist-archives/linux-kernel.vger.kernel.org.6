Return-Path: <linux-kernel+bounces-414615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAC69D2B22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AF4B2CBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4DC1D0F76;
	Tue, 19 Nov 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tP8gFJZk"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7871D0B9B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033927; cv=none; b=BezcbHbfbv78l2cIq4MxNWTDTtt7qzpQbWWIuxjIsYyJsoGlEf4n+vcKu5KjBHQUi66yIk5zk8bAG0UuixNzibFCkp9getpge9pwZxK29qr91tC0f14hgHhdsEirRHZLcn5oMnE+SuhVfxqdCxoeEDsyJ2kzMMpzvnAUdbQrqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033927; c=relaxed/simple;
	bh=3hTq3ao6mMjvQIMqDw14trvOszSouAAEXNR4qG7UVT4=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nUFUiK+Tt/DaEkwhp9DCK9O7HAjhBUdcXRX1+04wcfhTIDZNcnml8il67RlRkPZvpQNlCiOW80zNUxU7d4BMRWuVwXLzYkbo7yx6xBXOOzPDd2TE0tYIatjPCgoMsNcYEaIDE98QG82EESSsZjGlocOJ6SSKSqEtlLjGdbb3R3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tP8gFJZk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=t4Vmjpv2X0PmjEDEF4K179IGaPm3OC/AOeYNwIwQvfQ=; b=tP8gFJZkXCnvGpbvlSASjgS6wA
	6Ym2vzmkaQk9RD2jPdgMYCzSBF5CRwu4wh+d+4fImXrdsevZsTGxQXXoG22SPR/fSSwzkc234od/c
	6K0gE2DyT0Cpy6q5+gJXXmmG2oHg/lavxD/hl9HDGHipfZOOi93mlaCRCSzICT2t8yvt28Uf6yinu
	3N/TvmsEJnFzMdwae9ZaxxhsX5gN7m5YJ8yXuSx2mdLi3HYoZlMi7PeiRzJ+n+nYQs9J9Uc8i/hfP
	C4V/R/07FYpAI5bIqKWpAUT3vzjaPe/W6u9yrZrSHlDW0GWM2c+Sa8xlf4nlmt2GZzQctlQZKaV97
	dXKaoXUg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDR90-00000004IUG-24Zk;
	Tue, 19 Nov 2024 16:32:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DD8B7300AA5; Tue, 19 Nov 2024 17:32:02 +0100 (CET)
Message-Id: <20241119163035.433533770@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 19 Nov 2024 17:25:29 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "To:riel"@surriel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/7] x86/events, x86/insn-eval: Remove incorrect active_mm references
References: <20241119162527.952745944@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Andy Lutomirski <luto@kernel.org>

When decoding an instruction or handling a perf event that references an
LDT segment, if we don't have a valid user context, trying to access the
LDT by any means other than SLDT is racy.  Certainly, using
current->active_mm is wrong, as active_mm can point to a real user mm when
CR3 and LDTR no longer reference that mm.

Clean up the code.  If nmi_uaccess_okay() says we don't have a valid
context, just fail.  Otherwise use current->mm.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/d456e7da9dbd271aacd14812d4b9b74e7d7edd52.1641659630.git.luto@kernel.org
---
 arch/x86/events/core.c   |    9 ++++++++-
 arch/x86/lib/insn-eval.c |   13 ++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2798,8 +2798,15 @@ static unsigned long get_segment_base(un
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 		struct ldt_struct *ldt;
 
+		/*
+		 * If we're not in a valid context with a real (not just lazy)
+		 * user mm, then don't even try.
+		 */
+		if (!nmi_uaccess_okay())
+			return 0;
+
 		/* IRQs are off, so this synchronizes with smp_store_release */
-		ldt = READ_ONCE(current->active_mm->context.ldt);
+		ldt = smp_load_acquire(&current->mm->context.ldt);
 		if (!ldt || idx >= ldt->nr_entries)
 			return 0;
 
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -631,14 +631,21 @@ static bool get_desc(struct desc_struct
 		/* Bits [15:3] contain the index of the desired entry. */
 		sel >>= 3;
 
-		mutex_lock(&current->active_mm->context.lock);
-		ldt = current->active_mm->context.ldt;
+		/*
+		 * If we're not in a valid context with a real (not just lazy)
+		 * user mm, then don't even try.
+		 */
+		if (!nmi_uaccess_okay())
+			return false;
+
+		mutex_lock(&current->mm->context.lock);
+		ldt = current->mm->context.ldt;
 		if (ldt && sel < ldt->nr_entries) {
 			*out = ldt->entries[sel];
 			success = true;
 		}
 
-		mutex_unlock(&current->active_mm->context.lock);
+		mutex_unlock(&current->mm->context.lock);
 
 		return success;
 	}




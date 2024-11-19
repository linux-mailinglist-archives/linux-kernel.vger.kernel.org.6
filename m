Return-Path: <linux-kernel+bounces-414616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C45179D2B17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0D7B2D9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4554F1D12E6;
	Tue, 19 Nov 2024 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qxQ0arek"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D11D0786
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 16:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732033927; cv=none; b=ijvgMt/tDvhhRt06ojvH38AB2vYR+OY1zWODDcQ13McIWOHFBKRK+qWg0bI2iR+2vNILQbXFVD+ZysZwFGD5tz6tMj6NkmD9x3TnHhUpWLpxkh8MG9DtYyDjdAWk85xKBkpUokmztGqLT77U5I5rCxCadmUyvBDxiyL72EBHmco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732033927; c=relaxed/simple;
	bh=Kll3naxKaRgx1hIF5ErmABSbuADQDLzscKsVmxNt9F0=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hRD+z4eep4fIB/GK8GNl53HPHEEe6/yrp1UWrlbcJ61GgppD2KW4IEcb6YZm7T/3MeDesF2b51hQWS5usXjhuI742RCin7s9CjB+dSsu1kr3vhnYepTJndN5tAPRpkzXwNHgJJIr8DNsDR3bVn7T/5+lU9+OGakfyoKVzpkS4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qxQ0arek; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=vE/LC6yVFmhHKFcfrpK9WBndKxy/9zWNjg0UWLOfH/0=; b=qxQ0arekj2w0UoqvJqOcbcBI+W
	HdJPpSIND0nTvTLxOre5dY2Zdp7RdR/gc1x3bkeQFD8wSnOSO5BKs+s7UsDDTSvjzm2k7oO564j0D
	0HcPXTFS++1RsqiQtb1u1Ks6Gm+xZpYvd9a42afVHWqAqyYwGfFnCTlscfRNB82CFUT6P6juPryzO
	asqOYSoiKQ/71lDXUHYQBHw5ssfgzmfip3ocQU4J28XhZAeyX8Jy97GQeggHS8z8Vpc17gi3MHRm3
	94pgKjsT+vgvgjQVQ5cp8+fjvvAXKBy5leIpoUdp/Faemh/MEKjkza6w6oIajAMok/C1zbW6Qfbac
	KrNhbc0w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDR90-00000004IUF-2IZi;
	Tue, 19 Nov 2024 16:32:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D903B300848; Tue, 19 Nov 2024 17:32:02 +0100 (CET)
Message-Id: <20241119163035.322525475@infradead.org>
User-Agent: quilt/0.65
Date: Tue, 19 Nov 2024 17:25:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org, "To:riel"@surriel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org
Subject: [PATCH 1/7] x86/mm: Add mm argument to unuse_temporary_mm()
References: <20241119162527.952745944@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In commit 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")
unuse_temporary_mm() grew the assumption that it gets used on
poking_nn exclusively. While this is currently true, lets not hard
code this assumption.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1828,14 +1828,14 @@ static inline temp_mm_state_t use_tempor
 __ro_after_init struct mm_struct *poking_mm;
 __ro_after_init unsigned long poking_addr;
 
-static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
+static inline void unuse_temporary_mm(struct mm_struct *mm, temp_mm_state_t prev_state)
 {
 	lockdep_assert_irqs_disabled();
 
 	switch_mm_irqs_off(NULL, prev_state.mm, current);
 
 	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
-	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(poking_mm));
+	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(mm));
 
 	/*
 	 * Restore the breakpoints if they were disabled before the temporary mm
@@ -1942,7 +1942,7 @@ static void *__text_poke(text_poke_f fun
 	 * instruction that already allows the core to see the updated version.
 	 * Xen-PV is assumed to serialize execution in a similar manner.
 	 */
-	unuse_temporary_mm(prev);
+	unuse_temporary_mm(poking_mm, prev);
 
 	/*
 	 * Flushing the TLB might involve IPIs, which would require enabled




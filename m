Return-Path: <linux-kernel+bounces-394992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69039BB6E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 14:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2B31F23221
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FEA1BD4E4;
	Mon,  4 Nov 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G1L1HVOF"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB213C9A3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730728615; cv=none; b=VS6QfroabIIuPiPpDkYmLgXN6ljo1wcpv+NGRMcOfX4KnZIXbseD8TdM89v7r/s1zoTuh2M/CAHYwNG8rPMncSz29PgHFFNI+wn5A6MkN/EavxaCwd3j2zPYzVByJvf4E1K706IXsjz/hghZHGGVM2HuxLclZWuIMT+5SGuPxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730728615; c=relaxed/simple;
	bh=jkluaH4XEYEQte8xGB2hv1h2ykK+4gRIqt1RXfpWLbg=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Lf25wwaMr8UvRRTWLWJQhIHn9EjMMHTpUXxXTbKAYSw43AZx8Oh6L6FOWjU4uIwGc/EUa7hKi05rWwj7/GOeQTeDvH6SIwPupxPSuLjIYbrsHhTDgUuWBC6hNnUuDnr/4MBowXiEzIalBqdoj+q4zHEwGzkM7iLCdkDUWubs5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G1L1HVOF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=ae6cNYVBi7drCixIq97d0s/5QVUjP8FLagtyIO73Xkc=; b=G1L1HVOFKT/GpMy/rtL3mKmy+u
	9geJhBRiC1vaKw0Zbk9Mw4rGxmmwstzIXIsSU5jpzyrILLFhRFqu2BIOQosZysE9aEAlBNcP6sH84
	Hape5dnY4zEry4qHH5BBfc+/21q8/Rhl96qte4xjwd8ceAA+r1fbiTTnu90tvoO/adeU4iBr/LXK5
	iMXumTgV4uCS5qHn75dRHYK7VUmqsIR6FbJJA+145mMRtb1uV+dNxztir/CTSbi6qR0PqolOfjUJf
	p01YamlczYc8m1lIXJIYjyZCyPrtAiFOXfILsrJPjIdbxwXYaDaup7urrCDuzeA0suOwWz6k5+P/j
	LPvS45Iw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7xZX-0000000BL7x-1P1O;
	Mon, 04 Nov 2024 13:56:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 5227430073F; Mon,  4 Nov 2024 14:56:46 +0100 (CET)
Message-Id: <20241104135517.536628371@infradead.org>
User-Agent: quilt/0.65
Date: Mon, 04 Nov 2024 14:39:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 willy@infradead.org,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 01/19] lockdep: Fix might_fault()
References: <20241104133909.669111662@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Turns out that commit 9ec23531fd48 ("sched/preempt, mm/fault: Trigger
might_sleep() in might_fault() with disabled pagefaults") accidentally
(and unnessecarily) put the lockdep part of __might_fault() under
CONFIG_DEBUG_ATOMIC_SLEEP.

Cc: David Hildenbrand <david@redhat.com>
Fixes: 9ec23531fd48 ("sched/preempt, mm/fault: Trigger might_sleep() in might_fault() with disabled pagefaults")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/memory.c |    2 --
 1 file changed, 2 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6695,10 +6695,8 @@ void __might_fault(const char *file, int
 	if (pagefault_disabled())
 		return;
 	__might_sleep(file, line);
-#if defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 	if (current->mm)
 		might_lock_read(&current->mm->mmap_lock);
-#endif
 }
 EXPORT_SYMBOL(__might_fault);
 #endif




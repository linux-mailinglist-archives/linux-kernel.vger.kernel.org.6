Return-Path: <linux-kernel+bounces-390241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048289B7751
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9CD28669F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A291957E1;
	Thu, 31 Oct 2024 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E1w/a6LW"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7C5194C96
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366433; cv=none; b=flfD4WkvIEKwRV0h6PuY2/UoqziXj7GVJdVA2UfkA/p7+JMVcS0qYws5WvkB0NgNDjR1PEQCVAs+xZlclUHTmcD2PN19LbgTUcpjz3yPdmHRyKu8O+UplMAawa1KxfS05z9ZiCr58AwpHUsULgig8cYJ3C+Xq1Mosz+RlpCwo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366433; c=relaxed/simple;
	bh=PCNhOZ7FjPcuLH06KFlsCRmNhIA+2CJAVbgl+hQwgKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soLIGyMLQ/FzSDeeSXeQwzt/7YZIl/x7sRboIOcOxqkH5YwK+Z+FTTen2o8a431UeEj2H8JFLrOL3in9b+4bwwHh+qcYWra/cIMgfYahe+6c9/6t7FMnqpseFD1D4HTF6xYGll6mEW/wDWBPO0MUAeNNAO5hLtEGVJWJ7ooS3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E1w/a6LW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1q52zKliJkMThvPumU3SPfBPY2krJYFtdl0Hl6uLP8c=; b=E1w/a6LWlcQSKW0TIr267belFF
	SHzLhrZMs+5bifyGCPvhFZ3lLOGPyjzuiGghPgrOSxPqlkamceocJ5BJEQ6mwrd+NxR3Z1nx7reuW
	sLBlMOA5aTGcNCI57BweswkLj9wCMg7o1TKNjezmOpHQK3Xrnq6fTiyqgA7CA0V/5Z+aIH+MAmgfN
	en0EkrOF5q4zbsj45O5LLXLnvkvxFT+9lDrRoJ+kqs3nQR9ScoJgsCIwXMRzsTKVefCfEq6OzDtmG
	GSYxawQaiRWYMUhIhmPpQMoTr2nibaXmKfpZ3aoVIKAv18Fa7AoB9l/HuH8e3sbk2/u4BmvjrjFm5
	uNlzrJZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6RLu-0000000EWbk-2fUW;
	Thu, 31 Oct 2024 09:20:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D573D300599; Thu, 31 Oct 2024 10:20:26 +0100 (CET)
Date: Thu, 31 Oct 2024 10:20:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] kcsan, seqlock: Support seqcount_latch_t
Message-ID: <20241031092026.GU33184@noisy.programming.kicks-ass.net>
References: <20241029083658.1096492-1-elver@google.com>
 <20241029114937.GT14555@noisy.programming.kicks-ass.net>
 <CANpmjNPyXGRTWHhycVuEXdDfe7MoN19MeztdQaSOJkzqhCD69Q@mail.gmail.com>
 <20241029134641.GR9767@noisy.programming.kicks-ass.net>
 <ZyFKUU1LpFfLrVXb@elver.google.com>
 <20241030204815.GQ14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030204815.GQ14555@noisy.programming.kicks-ass.net>

On Wed, Oct 30, 2024 at 09:48:15PM +0100, Peter Zijlstra wrote:
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index 68d6c1190ac7..4958b40ba6c9 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -102,7 +102,9 @@ unsigned long long notrace sched_clock(void)
>  {
>  	unsigned long long ns;
>  	preempt_disable_notrace();
> +	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
>  	ns = sched_clock_noinstr();
> +	kcsan_atomic_next(0);
>  	preempt_enable_notrace();
>  	return ns;
>  }

You might want to consider also folding something like this in.
That should give this instrumented version instrumentation :-)


diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 68d6c1190ac7..db26f343233f 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -80,7 +80,7 @@ notrace int sched_clock_read_retry(unsigned int seq)
 	return raw_read_seqcount_latch_retry(&cd.seq, seq);
 }
 
-unsigned long long noinstr sched_clock_noinstr(void)
+static __always_inline unsigned long long __sched_clock(void)
 {
 	struct clock_read_data *rd;
 	unsigned int seq;
@@ -98,11 +98,16 @@ unsigned long long noinstr sched_clock_noinstr(void)
 	return res;
 }
 
+unsigned long long noinstr sched_clock_noinstr(void)
+{
+	return __sched_clock();
+}
+
 unsigned long long notrace sched_clock(void)
 {
 	unsigned long long ns;
 	preempt_disable_notrace();
-	ns = sched_clock_noinstr();
+	ns = __sched_clock();
 	preempt_enable_notrace();
 	return ns;
 }


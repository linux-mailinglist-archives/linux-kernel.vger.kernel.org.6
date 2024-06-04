Return-Path: <linux-kernel+bounces-201273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F068FBC58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 21:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D3E284957
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E833A14AD38;
	Tue,  4 Jun 2024 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g4dyiM5h"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59314A629
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717528357; cv=none; b=CJ6JkxIDLsv6WcH22YMRR5i1knxP8KyeqqWfx7g0U5aWRXblwoJ8KIsT3bpePMZDG6MAwTUK0jpEGj8LFxuV6WtY+6KfBwmC3mnpwCEgujghm9ffjabdu8xCEko9nVtkZ0JY2ME5dF2/B46TT1BgjZmdjp+olSIZq5rezgvF75Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717528357; c=relaxed/simple;
	bh=uth3pBz50kuBxtutu24UCRZ5v8bN+byDA5nfgsuMcls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh/JPsatiVsqB/MBa4DchCCL9qI1Nfy2edCBxLfb+PQL/LIxiH+Og58NALUIUDD7yQog7VXD5noX2b9IDJvpx9W+OeEWatmYOizn3EEEg/FYZkSuSTjWWR7/rZUCZh68pa9CmqwowV+/XohJajlN1jcsDSFvhKTpZnbKRmFKkaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g4dyiM5h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DIpk3jRNpFdid58ZOeWexYwMoUALCO2h2dO4SitkQuY=; b=g4dyiM5h7sbERLaUgik2FP6h+d
	evFYtJlV6rkhnawHiNZsnrBdo8E6zDkDc1gTQ4JQN/FAIWonQ1Ltj9xq7JErbe8TtJxM7WTUGIadw
	+NzbYBHbZsatv4f+4fQPkjDVcCtUEB8WUtDzXFbo/+4IThMWBnJHp81Dv3dvfydlAg4+kjz2Txpe1
	3XyI5c7yju3x7O0CGFaY/dAaFe43MUVVg4sqv5bjqh6auSksml61+jRTwkAc64V6jdaUnyvizThNN
	rFHYYM49Ks4tlq/DR2O4iuloPEMLRZbCb52uHVe90UB2LXbYt/aESqSt3PBzxNIYZEf8UekPYI1nz
	zwG4VOSA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZa1-0000000F2sH-1ggI;
	Tue, 04 Jun 2024 19:12:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C0B9230068B; Tue,  4 Jun 2024 21:12:20 +0200 (CEST)
Date: Tue, 4 Jun 2024 21:12:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	nd <nd@arm.com>, John Stultz <jstultz@google.com>,
	Hongyan.Xia2@arm.com
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240604191220.GP40213@noisy.programming.kicks-ass.net>
References: <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <20240529225036.GN40213@noisy.programming.kicks-ass.net>
 <7eac0774-0f9d-487c-97b6-ab0e85f0ae3a@arm.com>
 <20240604101107.GO26599@noisy.programming.kicks-ass.net>
 <24e09046-74ee-4ebb-ac1a-bdc84568e825@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24e09046-74ee-4ebb-ac1a-bdc84568e825@arm.com>

On Tue, Jun 04, 2024 at 03:23:41PM +0100, Luis Machado wrote:
> On 6/4/24 11:11, Peter Zijlstra wrote:

> > Note how dequeue_task() does uclamp_rq_dec() unconditionally, which is
> > then not balanced in the case below.
> > 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3664,6 +3664,7 @@ static int ttwu_runnable(struct task_str
> >  			/* mustn't run a delayed task */
> >  			SCHED_WARN_ON(task_on_cpu(rq, p));
> >  			enqueue_task(rq, p, ENQUEUE_DELAYED);
> > +			uclamp_rq_inc(rq, p);
> >  		}
> >  		if (!task_on_cpu(rq, p)) {
> >  			/*
> 
> As Hongyan pointed out in a separate message, the above makes things
> worse, as we end up with even more leftover tasks in the uclamp
> buckets.
> 
> I'm trying a fix in kernel/sched/core.c:enqueue_task that only
> calls uclamp_rq_inc if the task is not sched_delayed, so:
> 
> -       uclamp_rq_inc(rq, p);
> +       if (!p->se.sched_delayed)
> +         uclamp_rq_inc(rq, p);
> 
> I'm not entirely sure it is correct, but it seems to fix things,
> but I'm still running some tests.
> 
> With the current code, given uclamp_rq_inc and uclamp_rq_dec get
> called in enqueue_task and dequeue_task, the additional enqueue_task
> call from ttwu_runnable for a delayed_dequeue task may do an additional
> unconditional call to uclamp_rq_inc, no?

Yes, I got enqueue_task() and class->enqueue_task() confused this
morning.

But with the above, you skip inc for sched_delayed, but dequeue_task()
will have done the dec, so isn't it then still unbalanced?

Oh well, I'll go stare at this in tomorrow.

In any case, is there a uclamp self-test somewhere?


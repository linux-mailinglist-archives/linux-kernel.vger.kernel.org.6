Return-Path: <linux-kernel+bounces-194760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0038D418E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B388F1C21291
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBB91CB325;
	Wed, 29 May 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iwsr9LFy"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B7617557C
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717023061; cv=none; b=n8DfWUQ1gWhQQeWlYiVU2QGY3W89u+dqggtXGMWYIpxt0jR7I1hrN7YdhB3CscaXxWo9TowK7X0uYjsHruJrhDFKc58Gmr2fxkQ/UCxyNWRraDMGB6cE8CICj80/OXWP69qsZ9oNn2hZjoR1OXupW0Ixc5atiMiQFFvxQoKE4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717023061; c=relaxed/simple;
	bh=jpIc1L1W1lMeTLnGiYz4VV3MEutmsnnV7edBqPUynzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnFXNdnH0g9oXl4uP605eRrOavf2pLnE0HBfao/f9xCd3APjDmDbuo9AVpXXU7W6Q3Xw+lTF9ahHA7mW02Dc1d0Or4xmxD80ZSdcnMJVrznmeB3p3q+x3h4d00fIHmzwUySw5y2C4qmJsAOytTupi5hIlwTZ9fpnSl1APQqN6BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iwsr9LFy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d0iLIvOrS77A3lgec52g76gBqftLiiGZ8VaMokv0GlQ=; b=iwsr9LFytoU+i++0x4XXMcGukS
	eZdDGukrJ277UcPu2rCP+4RW5QyHf6zkop3rk33hDdPB7LgZE2eHJ1Kdbz5ktMesWY/CiM6gWnVpq
	+U8DFsNNa/EYDLSYPsZQ79TEP3XELhBivEUuwSPx6mmlGMgqdhdbt4Vll0UlrXMVQpAIvBPbo77Rl
	jdQ3o+H/Z92DtRXOjsERCUnHfpEhMVLXwJT8rLsiSUkWiGOioTniqJa4q4PbvcC1v1DiRhpLkk2MW
	BYa4cUpvalYBUtsJPBrYYQor9SS3mjZ8dmn2ky4RDy7khfnwi1HlPDhOLdIhnfLwvI0Eyvk047N9Q
	Hgb4AD2Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCS7x-0000000AEiT-1AaM;
	Wed, 29 May 2024 22:50:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6D27D30073F; Thu, 30 May 2024 00:50:36 +0200 (CEST)
Date: Thu, 30 May 2024 00:50:36 +0200
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
Message-ID: <20240529225036.GN40213@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>

On Thu, May 02, 2024 at 11:26:14AM +0100, Luis Machado wrote:

> Going through the code, my understanding is that the util_est functions seem to be getting
> called correctly, and in the right order. That is, we first util_est_enqueue, then util_est_dequeue
> and finally util_est_update. So the stats *should* be correct.
> 
> On dequeuing (dequeue_task_fair), we immediately call util_est_dequeue, even for the case of
> a DEQUEUE_DELAYED task, since we're no longer going to run the dequeue_delayed task for now, even
> though it is still in the rq.
> 
> We delay the util_est_update of dequeue_delayed tasks until a later time in dequeue_entities.
> 
> Eventually the dequeue_delayed task will have its lag zeroed when it becomes eligible again,
> (requeue_delayed_entity) while still being in the rq. It will then get dequeued/enqueued (requeued),
> and marked as a non-dequeue-delayed task.
> 
> Next time we attempt to enqueue such a task (enqueue_task_fair), it will skip the ENQUEUE_DELAYED
> block and call util_est_enqueue.
> 
> Still, something seems to be signalling that util/load is high, and causing migration to the big cores.
> 
> Maybe we're not decaying the util/load properly at some point, and inflated numbers start to happen.
> 
> I'll continue investigating.

So I re-read all this util_est stuff again this evening and I am
confused :-) Please bear with me.

So the old code does:

	dequeue_task_fair()
	  util_est_dequeue();
	  // actual dequeue -- updates pelt
	  util_est_update();


While the new code does:

	dequeue_task_fair()
	  util_est_dequeue();
	  if (!dequeue())
	    return;
	  util_est_update();

	delayed_dequeue:
	  util_est_update();


Specifically, we only call util_est_update() if/when we do the actual
dequeue -- potentially at a later point in time. Because, as I argued in
the comments, ttwu()'s ENQUEUE_DELAYED will not actually enqueue the
task (since it is still enqueued) and therefore the update would be
spurious.

However!!, if we do dequeue, then we'll end up updating the EWMA with a
potentially different task_util(p).

And this is where the confusion comes... this extra time on the runqueue
would not be running and thus decreate util_avg, as such task_util_est()
should be lower than before and tasks should tend towards smaller cores,
rather than larger cores as you seem to be seeing.

[ there is the 'dequeued + UTIL_EST_MARGIN < task_runnable()' escape
  clause, which we might be hitting... dunno ]

In any case, if you haven't tried it already, could I ask you to test
the below (once you're back in the office)?

Also, this doesn't really explain why things go sideways once you enable
DELAY_DEQUEUE and then don't re-align if you disable it again. I mean,
it should eventually age out the dodgy EWMA contributions and start
working as expected.

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7008,7 +7008,6 @@ static int dequeue_entities(struct rq *r
 			SCHED_WARN_ON(p->on_rq != 1);
 
 			/* Fix-up what dequeue_task_fair() skipped */
-			util_est_update(&rq->cfs, p, task_sleep);
 			hrtick_update(rq);
 
 			/* Fix-up what block_task() skipped. */
@@ -7028,13 +7027,11 @@ static bool dequeue_task_fair(struct rq
 {
 	util_est_dequeue(&rq->cfs, p);
 
-	if (dequeue_entities(rq, &p->se, flags) < 0)
+	if (dequeue_entities(rq, &p->se, flags) < 0) {
+		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
 		return false;
+	}
 
-	/*
-	 * It doesn't make sense to update util_est for the delayed dequeue
-	 * case where ttwu will make it appear the sleep never happened.
-	 */
 	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
 	hrtick_update(rq);
 	return true;


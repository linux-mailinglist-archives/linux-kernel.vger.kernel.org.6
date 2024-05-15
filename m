Return-Path: <linux-kernel+bounces-179819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A48A8C65E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9DA6B21449
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0D6F073;
	Wed, 15 May 2024 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VzQmBzBq"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B992CCD0
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715773726; cv=none; b=DD68aQx3RGKK8YkxnbXbZExF8Oqe5cO/b06JLZeN49S6EpUK9Gy+1XBTIOwoLRYLxYWhETteGsVu3RE754iYa1WyeNVM7kihR6iwSXaXvaCQXfNEpQUiNpjkb4OeOmGGC2bjEdTZwU3Sj6L2W2iDIAzb2AHOMItJRNaTmHJv1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715773726; c=relaxed/simple;
	bh=nRdoqcnIgajr9m4SQFCPnF8s6F1in0LeJsdZrDbz8Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4cDPALAw6+VeK6pYVQd3DJOF1oqSP9GCNPYK1dU6WNbYLSI/8H8oFMaY2R/VE03hml6lbqk4CaxACw4U0uujKrQkKOMZ/E7Fqv328t3xS+jmz6LbXKq2geE2jGeEdVRdVUkhvTef7Sa1zaKt6saFOHFmvYLvnZzJDNkQXsCl0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VzQmBzBq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FFsrr8x9TFZA3GNSLmifIzCZ7TQAIkuSwKQBBQMGbKY=; b=VzQmBzBqyQDehI94nbb/4CxlJV
	RN2zwY6Up8luzn4Sh1x0kibz5XUMs9ztoSE6S2smGY4tbiYX7pscIEg4gG9xLmYVs7yvr1T6SeGU1
	L2m6dIRuSnGcC/ERiyY/2Rk1Hm0fRcdkCWY8ZdVJnwZp6NAYMGUUBNL89n7D2a9bTSNVHVxbL1vE0
	AmCXMgAIbT7YkwG5lRtjDQMu+5G+UugbjwOPAvGjLUxEI+QXAophEpPhA/OiHYysfXuU4hQBLx1BM
	CId9ULtzIfr/awT+D/YWgootBuw02fSxz6hprqJNW2g4BnAC4xKyOCtxFm1Gb4VgTUW/2/14kh+RC
	q7cgTE+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7D7X-0000000ALfd-3sHZ;
	Wed, 15 May 2024 11:48:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ED9C83005E3; Wed, 15 May 2024 13:48:28 +0200 (CEST)
Date: Wed, 15 May 2024 13:48:28 +0200
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
Message-ID: <20240515114828.GO12673@noisy.programming.kicks-ass.net>
References: <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <219b8b49-3767-4010-aa68-9e1cf66c2ccb@arm.com>
 <20240515093649.GF40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515093649.GF40213@noisy.programming.kicks-ass.net>

On Wed, May 15, 2024 at 11:36:49AM +0200, Peter Zijlstra wrote:
> On Fri, May 10, 2024 at 03:49:46PM +0100, Luis Machado wrote:
> > Just a quick update on this. While investigating this behavior, I
> > spotted very high loadavg values on an idle system. For instance:
> > 
> > load average: 4733.84, 4721.24, 4680.33
> > 
> > I wonder if someone else also spotted this.
> 
> Hadn't spotted it, but now that you mention it, I can definitely see it.
> 
> Let me go prod with something sharp. Thanks!

What's the point of making notes if you then don't read them... *sigh*.

Does this help?

---
 kernel/sched/core.c  | 23 ++++++++++++-----------
 kernel/sched/fair.c  |  4 ++--
 kernel/sched/sched.h |  8 ++++++++
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ffd7e047393..43f061bcfe54 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2154,14 +2154,18 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	bool sleep = flags & DEQUEUE_SLEEP;
+	SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
 
-	if (dequeue_task(rq, p, flags)) {
-		WRITE_ONCE(p->on_rq, sleep ? 0 : TASK_ON_RQ_MIGRATING);
-		ASSERT_EXCLUSIVE_WRITER(p->on_rq);
-	} else {
-		SCHED_WARN_ON(!sleep); /* only sleep can fail */
-	}
+	dequeue_task(rq, p, flags);
+
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+}
+
+static void block_task(struct rq *rq, struct task_struct *p, int flags)
+{
+	if (dequeue_task(rq, p, DEQUEUE_SLEEP | flags))
+		__block_task(rq, p);
 }
 
 static inline int __normal_prio(int policy, int rt_prio, int nice)
@@ -6693,9 +6697,6 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 				!(prev_state & TASK_NOLOAD) &&
 				!(prev_state & TASK_FROZEN);
 
-			if (prev->sched_contributes_to_load)
-				rq->nr_uninterruptible++;
-
 			/*
 			 * __schedule()			ttwu()
 			 *   prev_state = prev->state;    if (p->on_rq && ...)
@@ -6707,7 +6708,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 			 *
 			 * After this, schedule() must not care about p->state any more.
 			 */
-			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
+			block_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
 
 			if (prev->in_iowait) {
 				atomic_inc(&rq->nr_iowait);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 536eabcb1a71..596a5fabe490 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7032,8 +7032,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			util_est_update(&rq->cfs, p, task_sleep);
 			hrtick_update(rq);
 
-			/* Fix-up what deactivate_task() skipped. */
-			WRITE_ONCE(p->on_rq, 0);
+			/* Fix-up what block_task() skipped. */
+			__block_task(rq, p);
 		}
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 12841d8195c5..48e5f49d9bc2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2560,6 +2560,14 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 	sched_update_tick_dependency(rq);
 }
 
+static inline void __block_task(struct rq *rq, struct task_struct *p)
+{
+	WRITE_ONCE(p->on_rq, 0);
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+	if (p->sched_contributes_to_load)
+		rq->nr_uninterruptible++;
+}
+
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 


Return-Path: <linux-kernel+bounces-212998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFBD906996
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAB12829DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A6F1411D6;
	Thu, 13 Jun 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jrlpXsfl"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AF4134409
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273095; cv=none; b=YYGEit8W1sgcjEpFbl9ATdgpxOvZllM8jVzCLRFdl8hpgJW0i61eb/Nbz7TZ+Ae3njxd9bgwAQVkecezix44ihhW8HhpFj9Qf7dpZKA6z8fkDDcK6avb9HM+e8zSEXjeaLPX+HM9UAs8LN7L+s/C9b2NumaCHGBusdZwdIBHMVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273095; c=relaxed/simple;
	bh=Yk+Eoj2OJdicg3/WFr9dYTwKDEgeckcAHzU4r9Y9kD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1+hfqnht6F3OivdoIBzOgqinfcXqh5VInvNclCvHuoeTq/5c99mrDzxA9EnDNjJyyjrLT+xXB005W/s+OMfJgULWuCuBR7ZAXsxMhPeY6vZjEB0jtQ9FbcQkWBFm0a1uw23XPXK7u7iWc2GlGjBqodlMz3Zt2SNAa0TDne2soA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jrlpXsfl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TI8E+UMBGV1H2wYOS4JfYeTaxH+FVDl4mdl2JFj34mQ=; b=jrlpXsfloXeWDanIKs2ak2VHEx
	HXS/KdU8e6GwqCcitfpdK2JwkpkPEhak2AOa6/shVQhh+DdclfeZjuDMmalW8BL2Jk7jaEhTsC22z
	PTlXkeL5bUkp0QlFfUJPQGsjbRsPQgJhY5VlEfh71+3qXJnk9+0AviBvwb31Vh5ZiiAYM7GkP0THq
	HhUSxImtbDJSKiMlBArOIkreY63JwCX6SZfYYR1p+N89R0+vYOvhHihhFuUDXohwbEEeNaMRmiK1w
	PjB8N9PqK+UTfFjubTd46YNu/kruZx1OnyHqZY4XIbDpmhdecSEqvoqUnKsdbF1TMZFQrG7Bq6i00
	KiV0Ex1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHhJy-0000000Fdds-1FvK;
	Thu, 13 Jun 2024 10:04:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E3F0F300B40; Thu, 13 Jun 2024 12:04:41 +0200 (CEST)
Date: Thu, 13 Jun 2024 12:04:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Qais Yousef <qyousef@layalina.io>,
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling
 update_rq_clock
Message-ID: <20240613100441.GC17707@noisy.programming.kicks-ass.net>
References: <20240613015837.4132703-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613015837.4132703-1-jstultz@google.com>

On Wed, Jun 12, 2024 at 06:58:26PM -0700, John Stultz wrote:
> I recently got a bug report that
> clock_gettime(CLOCK_THREAD_CPUTIME_ID,...) had regressed between
> 5.10 and 6.1. Its not a huge regression in absolute time
> (~30-40ns), but is >10% change.
> 
> I narrowed the cause down to the addition of
> psi_account_irqtime() in update_rq_clock_task(), in commit
> 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
> pressure")
> 
> So that explains the behavior change, 

It doesn't really... that patch just feeds the irq_time we *already*
subtracted prior to it, to PSI, such that PSI can also enjoy the 'view'.

The only explanation I have is that interrupts that end up in the
scheduler (wakeups, tick, etc..) now get to do that PSI cgroup iteration
and that cost adds up to the IRQ time itself, and as such the task time
slows down accordingly.

Are you using silly deep cgroup hierarchies?

> but it also seems odd that
> we're doing psi irq accounting from a syscall that is just
> trying to read the thread's cputime.

In order to avoid doing all the accounting in the IRQ entry/exit paths,
those paths only do the bare minimum of tracking how much IRQ time there
is.

update_rq_clock_task() then looks at the increase of IRQ time and
subtracts this from the task time -- after all, all time spend in the
IRQ wasn't spend on the task itself.

It did that prior to the PSI patch, and it does so after. The only
change is it now feeds this delta into the PSI thing.

> NOTE: I'm not 100% sure this is correct yet. There may be some
> edge cases I've overlooked, so I'd greatly appreciate any
> review or feedback.

Urgh, you're sprinkling the details of what is clock_task over multiple
places.

Does something like so work?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d4bb7b..d4b87539d72a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
-	psi_account_irqtime(rq->curr, irq_delta);
 	delayacct_irq(rq->curr, irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
@@ -5459,6 +5458,8 @@ void sched_tick(void)
 
 	sched_clock_tick();
 
+	psi_account_irqtime(curr, &rq->psi_irq_time);
+
 	rq_lock(rq, &rf);
 
 	update_rq_clock(rq);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 146baa91d104..57fdb0b9efbd 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -991,12 +991,13 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-void psi_account_irqtime(struct task_struct *task, u32 delta)
+void psi_account_irqtime(struct task_struct *task, u64 *prev)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now;
+	u64 now, irq;
+	s64 delta;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
@@ -1005,6 +1006,11 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 		return;
 
 	now = cpu_clock(cpu);
+	irq = irq_time_read(cpu);
+	delta = (s64)(irq - *prev);
+	if (delta < 0)
+		return;
+	*prev = irq;
 
 	group = task_psi_group(task);
 	do {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 62fd8bc6fd08..a63eb546bc4a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1133,6 +1133,7 @@ struct rq {
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
 	u64			prev_irq_time;
+	u64			psi_irq_time;
 #endif
 #ifdef CONFIG_PARAVIRT
 	u64			prev_steal_time;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index d1445410840a..1111f060264f 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -110,7 +110,7 @@ __schedstats_from_se(struct sched_entity *se)
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
-void psi_account_irqtime(struct task_struct *task, u32 delta);
+void psi_account_irqtime(struct task_struct *task, u64 *prev);
 
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
@@ -192,7 +192,7 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
-static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
+static inline void psi_account_irqtime(struct task_struct *task, u64 *prev) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO


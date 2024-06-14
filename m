Return-Path: <linux-kernel+bounces-214695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD0B9088BD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2015E1C21EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56687194A7F;
	Fri, 14 Jun 2024 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oSALYD5c"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC545192B87
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358535; cv=none; b=jNixVTjvhWbZST6IV+HTtC3HTghAjUpaq16PVpM0GjYOlvNYhOXILdAh+Tw6KYUmcQvLwRM3S1abDpiDLDNeZHNlPBcWkwrHzuYRQlbmdAVXOdtiiAjyaj0IVJNAXZ/zHKSxRrKuiy4cJRDrE+zNAgOX4z8aQJfbLXU8cwFRYMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358535; c=relaxed/simple;
	bh=E3eAqK6STJ6JNhODp6IrnGwzwof/k4TTREMsI1Xif3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHkDtQT4HAKxZNbomNpB9d3gRaa0v19nYv92OjISIe9jgSN1WkArXChTBEQpLsDtkESz4AMTsOJFRi1ECUt3MR5iGlrD1TMq87hhe4lv4Gg/+apsQdNJUTlqumGlTjdDsI1Qm+OoKIAq1Rllcd+GbFGyiEzNiXfaXF4fMKjyH+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oSALYD5c; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9Nwc/RDSTflthFWFhP7cT9cJV+65rW5riaGRjZ9W4p8=; b=oSALYD5cHe0gkqcqCWBuFopWFe
	6k5MW+8/yBjpq+F5e6bgGhXYperMtdp97gVQVAV0qMpLHDDf8FbetjKmGHVsfYEpSbHXp95MDePDf
	9MEu3zoNOO0LJUVG/7+bd21BkFjSMhdCyIuGZjOaWo4ruP3OokkHaoKHUCGqDxyjdoFkI5biQOY7/
	to/yTT9Epz3z1B9jPeVbLS7xHvcqlD7YBS9IhRin8an0k+sAI8hXKKThsAKT/UAAhOA3EyJG5HtRQ
	H+zpd422DNE6eRefpr/ibitb4VcIjOfwa7i1qeYtRYn2L2f7pjBUzdIM61VqTWmnW6/wWcOfLWaFZ
	POVK+6/g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI3Xu-00000004FL9-0HCj;
	Fri, 14 Jun 2024 09:48:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7DFE4300886; Fri, 14 Jun 2024 11:48:33 +0200 (CEST)
Date: Fri, 14 Jun 2024 11:48:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qais Yousef <qyousef@layalina.io>
Cc: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling
 update_rq_clock
Message-ID: <20240614094833.GM8774@noisy.programming.kicks-ass.net>
References: <20240613015837.4132703-1-jstultz@google.com>
 <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613115142.kxrmlf3btmwjcprg@airbuntu>

On Thu, Jun 13, 2024 at 12:51:42PM +0100, Qais Yousef wrote:
> On 06/13/24 12:04, Peter Zijlstra wrote:
> 
> > ---
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0935f9d4bb7b..d4b87539d72a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
> >  
> >  	rq->prev_irq_time += irq_delta;
> >  	delta -= irq_delta;
> > -	psi_account_irqtime(rq->curr, irq_delta);
> >  	delayacct_irq(rq->curr, irq_delta);
> >  #endif
> >  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> > @@ -5459,6 +5458,8 @@ void sched_tick(void)
> >  
> >  	sched_clock_tick();
> >  
> > +	psi_account_irqtime(curr, &rq->psi_irq_time);
> > +
> 
> If wakeup preemption causes a context switch, wouldn't we lose this
> information then? I *think* active migration might cause this information to be
> lost too.

I'm not sure what would be lost ?! the accounting is per cpu, not per
task afaict. That said,...

> pick_next_task() might be a better place to do the accounting?

Additionally, when there has been an effective cgroup switch. Only on
switch doesn't work for long running tasks, then the PSI information
will be artitrarily long out of date.

Which then gets me something like the (completely untested) below..

Hmm?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0935f9d4bb7b..36aed99d6a6c 100644
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
 
+	psi_account_irqtime(curr, NULL, &rq->psi_irq_time);
+
 	rq_lock(rq, &rf);
 
 	update_rq_clock(rq);
@@ -6521,6 +6524,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		++*switch_count;
 
 		migrate_disable_switch(rq, prev);
+		psi_account_irqtime(prev, next, &rq->psi_irq_time);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
 
 		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 146baa91d104..65bba162408f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -991,22 +991,31 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
-void psi_account_irqtime(struct task_struct *task, u32 delta)
+void psi_account_irqtime(struct task_struct *curr, struct task_struct *prev, u64 *time)
 {
-	int cpu = task_cpu(task);
+	int cpu = task_cpu(curr);
 	struct psi_group *group;
 	struct psi_group_cpu *groupc;
-	u64 now;
+	u64 now, irq;
+	s64 delta;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (!task->pid)
+	if (!curr->pid)
+		return;
+
+	group = task_psi_group(curr);
+	if( prev && task_psi_group(prev) == group)
 		return;
 
 	now = cpu_clock(cpu);
+	irq = irq_time_read(cpu);
+	delta = (s64)(irq - *time);
+	if (delta < 0)
+		return;
+	*time = irq;
 
-	group = task_psi_group(task);
 	do {
 		if (!group->enabled)
 			continue;
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
index d1445410840a..1e290054c5db 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -110,7 +110,7 @@ __schedstats_from_se(struct sched_entity *se)
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
-void psi_account_irqtime(struct task_struct *task, u32 delta);
+void psi_account_irqtime(struct task_struct *curr, struct task_struct *prev, u64 *time);
 
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
@@ -192,7 +192,7 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
-static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
+static inline void psi_account_irqtime(struct task_struct *curr, struct task_struct *prev, u64 *time) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO





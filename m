Return-Path: <linux-kernel+bounces-358027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C252E997962
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC0F1C222D0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3B51E8839;
	Wed,  9 Oct 2024 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TAGCGQHB"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9861E7C1C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 23:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728518055; cv=none; b=KOojzcfYkmL3fJjAC/wu6NDRLkzEDt7HGk8yFHArD1msqoGqompmlREgKsybqgCepUwgsPXM4hOJB6Qptrs+eMUP+cSwVhkPAEy0TuU1/4yZNaodQmtx1uySxke2QTmTaPOxk9BBzm4NxrTQqR6O2BK8EPjNJPLQxrDKq1jhzok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728518055; c=relaxed/simple;
	bh=QRSsRAk39RD4Hx6q8ORWTINKvkFDnJuCQHVMUILYCDs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a9x/1/vsHmL5DPEb038Pmkc66tEb3Pq8n2RK7gGj9ZbGY7vfSVl+0LAzRuTE0XroJTxEEsxtF51rWOrKlGeAHkjhIWa9xpqLpI+5Sy6qug2qxXN5NnICa9C9JjL66ULfp1o7o0S9N4LRDQqeR0uY+qa/E34hql/Jps5YiCOs2GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TAGCGQHB; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29088a6942so677148276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728518052; x=1729122852; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZi/UDAsdITqz7yNcwBkza8TcCDv6Ww6ovBhqqKb/wI=;
        b=TAGCGQHBXeuOPE1Yn0V5pLmU1LSZHuXuWMQWCejUp3vFhOK5sFMA/3FfFT1MzeaNqb
         pOd/SAJJaQjGtUxFTcNx33/KWDQU491gRiIJKvY+pUEa7SsXsbgj772ay499KjFPqEOp
         3P6Dcc7EMn73Ohfg+5IMjzajlPUO09H+NSf1nOSfGFey0ejOhOibi3ou9kz2oVefNJ8k
         aj9H5iK7QGaQTkJ770iQGF9cbNi5rIPIYkaYjpL953BbbikvTHYFR0agNc557bHWI5aL
         kI01f2HGcBtrN/OFDLj7fsrLjOrdlu7UlCe2HOy37UTgDkmAVWhX+RJbhltSQgDu05ym
         8U1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728518052; x=1729122852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZi/UDAsdITqz7yNcwBkza8TcCDv6Ww6ovBhqqKb/wI=;
        b=teicgaW/ZhRHfdxWWz8ae7CSTPAQaTCQ6zz+N36xADEAIovnWpsD0m+WombijzPAkb
         Igwy4VTACrFnoC2tPPB8Rmka+MERD1ZbLxetxghuT2N0w+SunePNY1MSWrppAOciQa4b
         gYqQOdh1ZZHP1GecpIqtR2si74sUbr9nhlPMhfeinrKLZ8y01JQ5s+5y8zEA7jRsY0+P
         NaWjAGC011PZSmfFrrRVpMum23QfQ7gIGz+xrKxLkgTy22aNmUCoUoG0LDcYffoj6v5U
         EsY8kIcCzfXjR1lDxDpUm53Pn3vHaLY2VaEyJdpAuhH87m8N9GkZjXeMwg4N5n1DyVKu
         iv+A==
X-Gm-Message-State: AOJu0YzGLCqul4KzVCnmqMOIEHZUYMDiwbyM2/rAR9rg55Xwy5QVop3t
	APhMEVaUEdt5TH/j+efTsu9bNMQLny+Sx9C54zcw1EWZRDSu1ZXmHk477Boa0Jy8PPy/VfbvIOR
	8T4XD/6N/Xw5u0GratrgPPqzLJQ6sYqXwLjbhyJh5H8rbSOFgYz9M8j9EyyfmgKrJyfl0WH4/fr
	8xIaFJpzfjKC5FuinjBweNUi1ozIcIcOtA5evRfmsWh4g5
X-Google-Smtp-Source: AGHT+IGSsl//MZsKn0wTHN/bG/ypC9Bh9U2Zsvvyg4VbuDHiO60pF9crGcjPZQRNxrZgH/uM0PA5voWdqr5u
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a25:f409:0:b0:e16:4d66:982e with SMTP id
 3f1490d57ef6-e28fe386cdcmr25107276.5.1728518051506; Wed, 09 Oct 2024 16:54:11
 -0700 (PDT)
Date: Wed,  9 Oct 2024 16:53:40 -0700
In-Reply-To: <20241009235352.1614323-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009235352.1614323-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009235352.1614323-8-jstultz@google.com>
Subject: [RESEND x3][PATCH v12 7/7] sched: Split scheduler and execution contexts
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Metin Kaya <Metin.Kaya@arm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Metin Kaya <metin.kaya@arm.com>, "Connor O'Brien" <connoro@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

Let's define the "scheduling context" as all the scheduler state
in task_struct for the task chosen to run, which we'll call the
donor task, and the "execution context" as all state required to
actually run the task.

Currently both are intertwined in task_struct. We want to
logically split these such that we can use the scheduling
context of the donor task selected to be scheduled, but use
the execution context of a different task to actually be run.

To this purpose, introduce rq->donor field to point to the
task_struct chosen from the runqueue by the scheduler, and will
be used for scheduler state, and preserve rq->curr to indicate
the execution context of the task that will actually be run.

This patch introduces the donor field as a union with curr, so it
doesn't cause the contexts to be split yet, but adds the logic to
handle everything separately.

Cc: Joel Fernandes <joelaf@google.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-team@android.com
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20181009092434.26221-5-juri.lelli@redhat.com
[add additional comments and update more sched_class code to use
 rq::proxy]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Rebased and resolved minor collisions, reworked to use
 accessors, tweaked update_curr_common to use rq_proxy fixing rt
 scheduling issues]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Reworked to use accessors
* Fixed update_curr_common to use proxy instead of curr
v3:
* Tweaked wrapper names
* Swapped proxy for selected for clarity
v4:
* Minor variable name tweaks for readability
* Use a macro instead of a inline function and drop
  other helper functions as suggested by Peter.
* Remove verbose comments/questions to avoid review
  distractions, as suggested by Dietmar
v5:
* Add CONFIG_PROXY_EXEC option to this patch so the
  new logic can be tested with this change
* Minor fix to grab rq_selected when holding the rq lock
v7:
* Minor spelling fix and unused argument fixes suggested by
  Metin Kaya
* Switch to curr_selected for consistency, and minor rewording
  of commit message for clarity
* Rename variables selected instead of curr when we're using
  rq_selected()
* Reduce macros in CONFIG_SCHED_PROXY_EXEC ifdef sections,
  as suggested by Metin Kaya
v8:
* Use rq->curr, not rq_selected with task_tick, as suggested by
  Valentin
* Minor rework to reorder this with CONFIG_SCHED_PROXY_EXEC patch
v10:
* Use rq_selected in push_rt_task & get_push_task
v11:
* Rework to use selected instead of curr in a few cases we were
  previously assigning curr = rq_selected() to minimize lines of
  change. Suggested by Metin.
v12:
* Big rename to use rq->donor instead of rq_selected(), as suggested
  by Peter.
---
 kernel/sched/core.c     | 45 +++++++++++++++++++++++---------------
 kernel/sched/deadline.c | 39 +++++++++++++++++----------------
 kernel/sched/fair.c     | 28 ++++++++++++------------
 kernel/sched/pelt.c     |  2 +-
 kernel/sched/rt.c       | 48 ++++++++++++++++++++---------------------
 kernel/sched/sched.h    | 28 +++++++++++++++++++++---
 kernel/sched/syscalls.c |  4 ++--
 7 files changed, 114 insertions(+), 80 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f949bb9e2a8..74f01fbff726 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -827,7 +827,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
+	rq->donor->sched_class->task_tick(rq, rq->curr, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -2130,16 +2130,18 @@ void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->sched_class == rq->curr->sched_class)
-		rq->curr->sched_class->wakeup_preempt(rq, p, flags);
-	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
+	struct task_struct *donor = rq->donor;
+
+	if (p->sched_class == donor->sched_class)
+		donor->sched_class->wakeup_preempt(rq, p, flags);
+	else if (sched_class_above(p->sched_class, donor->sched_class))
 		resched_curr(rq);
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
+	if (task_on_rq_queued(donor) && test_tsk_need_resched(rq->curr))
 		rq_clock_skip_update(rq);
 }
 
@@ -2675,7 +2677,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_donor(rq, p);
 
 	if (queued) {
 		/*
@@ -5500,7 +5502,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * project cycles that may never be accounted to this
 	 * thread, breaking clock_gettime().
 	 */
-	if (task_current(rq, p) && task_on_rq_queued(p)) {
+	if (task_current_donor(rq, p) && task_on_rq_queued(p)) {
 		prefetch_curr_exec_start(p);
 		update_rq_clock(rq);
 		p->sched_class->update_curr(rq);
@@ -5568,7 +5570,8 @@ void sched_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr;
+	/* accounting goes to the donor task */
+	struct task_struct *donor;
 	struct rq_flags rf;
 	unsigned long hw_pressure;
 	u64 resched_latency;
@@ -5579,19 +5582,19 @@ void sched_tick(void)
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
+	donor = rq->donor;
 
-	curr = rq->curr;
-	psi_account_irqtime(rq, curr, NULL);
+	psi_account_irqtime(rq, donor, NULL);
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
-	curr->sched_class->task_tick(rq, curr, 0);
+	donor->sched_class->task_tick(rq, donor, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
-	task_tick_mm_cid(rq, curr);
+	task_tick_mm_cid(rq, donor);
 	scx_tick(rq);
 
 	rq_unlock(rq, &rf);
@@ -5601,8 +5604,8 @@ void sched_tick(void)
 
 	perf_event_task_tick();
 
-	if (curr->flags & PF_WQ_WORKER)
-		wq_worker_tick(curr);
+	if (donor->flags & PF_WQ_WORKER)
+		wq_worker_tick(donor);
 
 #ifdef CONFIG_SMP
 	if (!scx_switched_all()) {
@@ -5669,6 +5672,12 @@ static void sched_tick_remote(struct work_struct *work)
 		struct task_struct *curr = rq->curr;
 
 		if (cpu_online(cpu)) {
+			/*
+			 * Since this is a remote tick for full dynticks mode,
+			 * we are always sure that there is no proxy (only a
+			 * single task is running).
+			 */
+			SCHED_WARN_ON(rq->curr != rq->donor);
 			update_rq_clock(rq);
 
 			if (!is_idle_task(curr)) {
@@ -6633,6 +6642,7 @@ static void __sched notrace __schedule(int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+	rq_set_donor(rq, next);
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
@@ -7134,7 +7144,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
 	prev_class = p->sched_class;
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_donor(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flag);
 	if (running)
@@ -7702,6 +7712,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	rcu_read_unlock();
 
 	rq->idle = idle;
+	rq_set_donor(rq, idle);
 	rcu_assign_pointer(rq->curr, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
@@ -7791,7 +7802,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_donor(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -8941,7 +8952,7 @@ void sched_move_task(struct task_struct *tsk)
 
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_current_donor(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 56260a80a268..90ddab256072 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1339,7 +1339,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 #endif
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
-	if (dl_task(rq->curr))
+	if (dl_task(rq->donor))
 		wakeup_preempt_dl(rq, p, 0);
 	else
 		resched_curr(rq);
@@ -1736,11 +1736,11 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
  */
 static void update_curr_dl(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
-	struct sched_dl_entity *dl_se = &curr->dl;
+	struct task_struct *donor = rq->donor;
+	struct sched_dl_entity *dl_se = &donor->dl;
 	s64 delta_exec;
 
-	if (!dl_task(curr) || !on_dl_rq(dl_se))
+	if (!dl_task(donor) || !on_dl_rq(dl_se))
 		return;
 
 	/*
@@ -2213,7 +2213,7 @@ static int find_later_rq(struct task_struct *task);
 static int
 select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *donor;
 	bool select_rq;
 	struct rq *rq;
 
@@ -2224,6 +2224,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	donor = READ_ONCE(rq->donor);
 
 	/*
 	 * If we are dealing with a -deadline task, we must
@@ -2234,9 +2235,9 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	 * other hand, if it has a shorter deadline, we
 	 * try to make it stay here, it might be important.
 	 */
-	select_rq = unlikely(dl_task(curr)) &&
+	select_rq = unlikely(dl_task(donor)) &&
 		    (curr->nr_cpus_allowed < 2 ||
-		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
+		     !dl_entity_preempt(&p->dl, &donor->dl)) &&
 		    p->nr_cpus_allowed > 1;
 
 	/*
@@ -2299,7 +2300,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	 * let's hope p can move out.
 	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpudl_find(&rq->rd->cpudl, rq->curr, NULL))
+	    !cpudl_find(&rq->rd->cpudl, rq->donor, NULL))
 		return;
 
 	/*
@@ -2338,7 +2339,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
-	if (dl_entity_preempt(&p->dl, &rq->curr->dl)) {
+	if (dl_entity_preempt(&p->dl, &rq->donor->dl)) {
 		resched_curr(rq);
 		return;
 	}
@@ -2348,7 +2349,7 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 	 * In the unlikely case current and p have the same deadline
 	 * let us try to decide what's the best thing to do...
 	 */
-	if ((p->dl.deadline == rq->curr->dl.deadline) &&
+	if ((p->dl.deadline == rq->donor->dl.deadline) &&
 	    !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
@@ -2380,7 +2381,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (!first)
 		return;
 
-	if (rq->curr->sched_class != &dl_sched_class)
+	if (rq->donor->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
@@ -2699,8 +2700,8 @@ static int push_dl_task(struct rq *rq)
 	 * can move away, it makes sense to just reschedule
 	 * without going further in pushing next_task.
 	 */
-	if (dl_task(rq->curr) &&
-	    dl_time_before(next_task->dl.deadline, rq->curr->dl.deadline) &&
+	if (dl_task(rq->donor) &&
+	    dl_time_before(next_task->dl.deadline, rq->donor->dl.deadline) &&
 	    rq->curr->nr_cpus_allowed > 1) {
 		resched_curr(rq);
 		return 0;
@@ -2823,7 +2824,7 @@ static void pull_dl_task(struct rq *this_rq)
 			 * deadline than the current task of its runqueue.
 			 */
 			if (dl_time_before(p->dl.deadline,
-					   src_rq->curr->dl.deadline))
+					   src_rq->donor->dl.deadline))
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2862,9 +2863,9 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 	if (!task_on_cpu(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
 	    p->nr_cpus_allowed > 1 &&
-	    dl_task(rq->curr) &&
+	    dl_task(rq->donor) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &rq->curr->dl))) {
+	     !dl_entity_preempt(&p->dl, &rq->donor->dl))) {
 		push_dl_tasks(rq);
 	}
 }
@@ -3039,12 +3040,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (rq->curr != p) {
+	if (rq->donor != p) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
 			deadline_queue_push_tasks(rq);
 #endif
-		if (dl_task(rq->curr))
+		if (dl_task(rq->donor))
 			wakeup_preempt_dl(rq, p, 0);
 		else
 			resched_curr(rq);
@@ -3073,7 +3074,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	if (!rq->dl.overloaded)
 		deadline_queue_pull_task(rq);
 
-	if (task_current(rq, p)) {
+	if (task_current_donor(rq, p)) {
 		/*
 		 * If we now have a earlier deadline task than p,
 		 * then reschedule, provided p is still on this
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5a621210c9c1..078ef61dd1a0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1200,12 +1200,12 @@ static inline bool do_preempt_short(struct cfs_rq *cfs_rq,
  */
 s64 update_curr_common(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor = rq->donor;
 	s64 delta_exec;
 
-	delta_exec = update_curr_se(rq, &curr->se);
+	delta_exec = update_curr_se(rq, &donor->se);
 	if (likely(delta_exec > 0))
-		update_curr_task(curr, delta_exec);
+		update_curr_task(donor, delta_exec);
 
 	return delta_exec;
 }
@@ -1258,7 +1258,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq->curr->se));
+	update_curr(cfs_rq_of(&rq->donor->se));
 }
 
 static inline void
@@ -6812,7 +6812,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
-			if (task_current(rq, p))
+			if (task_current_donor(rq, p))
 				resched_curr(rq);
 			return;
 		}
@@ -6827,12 +6827,12 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
  */
 static void hrtick_update(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor = rq->donor;
 
-	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
+	if (!hrtick_enabled_fair(rq) || donor->sched_class != &fair_sched_class)
 		return;
 
-	hrtick_start_fair(rq, curr);
+	hrtick_start_fair(rq, donor);
 }
 #else /* !CONFIG_SCHED_HRTICK */
 static inline void
@@ -8747,9 +8747,9 @@ static void set_next_buddy(struct sched_entity *se)
  */
 static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
 {
-	struct task_struct *curr = rq->curr;
-	struct sched_entity *se = &curr->se, *pse = &p->se;
-	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
+	struct task_struct *donor = rq->donor;
+	struct sched_entity *se = &donor->se, *pse = &p->se;
+	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
 
 	if (unlikely(se == pse))
@@ -8778,7 +8778,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(rq->curr))
 		return;
 
 	if (!sched_feat(WAKEUP_PREEMPTION))
@@ -13077,7 +13077,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 * our priority decreased, or if we are not currently running on
 	 * this runqueue and our priority is higher than the current's
 	 */
-	if (task_current(rq, p)) {
+	if (task_current_donor(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
@@ -13200,7 +13200,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * kick off the schedule if running, otherwise just see
 		 * if we can still preempt the current task.
 		 */
-		if (task_current(rq, p))
+		if (task_current_donor(rq, p))
 			resched_curr(rq);
 		else
 			wakeup_preempt(rq, p, 0);
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a9c65d97b3ca..fc07382361a8 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -476,7 +476,7 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 bool update_other_load_avgs(struct rq *rq)
 {
 	u64 now = rq_clock_pelt(rq);
-	const struct sched_class *curr_class = rq->curr->sched_class;
+	const struct sched_class *curr_class = rq->donor->sched_class;
 	unsigned long hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 
 	lockdep_assert_rq_held(rq);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index c5c22fc51824..bd66a46b06ac 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -528,7 +528,7 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 
 static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 {
-	struct task_struct *curr = rq_of_rt_rq(rt_rq)->curr;
+	struct task_struct *donor = rq_of_rt_rq(rt_rq)->donor;
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct sched_rt_entity *rt_se;
 
@@ -542,7 +542,7 @@ static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 		else if (!on_rt_rq(rt_se))
 			enqueue_rt_entity(rt_se, 0);
 
-		if (rt_rq->highest_prio.curr < curr->prio)
+		if (rt_rq->highest_prio.curr < donor->prio)
 			resched_curr(rq);
 	}
 }
@@ -988,10 +988,10 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
  */
 static void update_curr_rt(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *donor = rq->donor;
 	s64 delta_exec;
 
-	if (curr->sched_class != &rt_sched_class)
+	if (donor->sched_class != &rt_sched_class)
 		return;
 
 	delta_exec = update_curr_common(rq);
@@ -999,7 +999,7 @@ static void update_curr_rt(struct rq *rq)
 		return;
 
 #ifdef CONFIG_RT_GROUP_SCHED
-	struct sched_rt_entity *rt_se = &curr->rt;
+	struct sched_rt_entity *rt_se = &donor->rt;
 
 	if (!rt_bandwidth_enabled())
 		return;
@@ -1535,7 +1535,7 @@ static int find_lowest_rq(struct task_struct *task);
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *donor;
 	struct rq *rq;
 	bool test;
 
@@ -1547,6 +1547,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	donor = READ_ONCE(rq->donor);
 
 	/*
 	 * If the current task on @p's runqueue is an RT task, then
@@ -1575,8 +1576,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	 * systems like big.LITTLE.
 	 */
 	test = curr &&
-	       unlikely(rt_task(curr)) &&
-	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
+	       unlikely(rt_task(donor)) &&
+	       (curr->nr_cpus_allowed < 2 || donor->prio <= p->prio);
 
 	if (test || !rt_task_fits_capacity(p, cpu)) {
 		int target = find_lowest_rq(p);
@@ -1606,12 +1607,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 static void check_preempt_equal_prio(struct rq *rq, struct task_struct *p)
 {
-	/*
-	 * Current can't be migrated, useless to reschedule,
-	 * let's hope p can move out.
-	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpupri_find(&rq->rd->cpupri, rq->curr, NULL))
+	    !cpupri_find(&rq->rd->cpupri, rq->donor, NULL))
 		return;
 
 	/*
@@ -1654,7 +1651,9 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
  */
 static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq->curr->prio) {
+	struct task_struct *donor = rq->donor;
+
+	if (p->prio < donor->prio) {
 		resched_curr(rq);
 		return;
 	}
@@ -1672,7 +1671,7 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
+	if (p->prio == donor->prio && !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -1697,7 +1696,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	 * utilization. We only care of the case where we start to schedule a
 	 * rt task
 	 */
-	if (rq->curr->sched_class != &rt_sched_class)
+	if (rq->donor->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
@@ -1959,6 +1958,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
 
 	BUG_ON(rq->cpu != task_cpu(p));
 	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current_donor(rq, p));
 	BUG_ON(p->nr_cpus_allowed <= 1);
 
 	BUG_ON(!task_on_rq_queued(p));
@@ -1991,7 +1991,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (unlikely(next_task->prio < rq->donor->prio)) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2012,7 +2012,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * Note that the stoppers are masqueraded as SCHED_FIFO
 		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
 		 */
-		if (rq->curr->sched_class != &rt_sched_class)
+		if (rq->donor->sched_class != &rt_sched_class)
 			return 0;
 
 		cpu = find_lowest_rq(rq->curr);
@@ -2344,7 +2344,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio)
+			if (p->prio < src_rq->donor->prio)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2386,9 +2386,9 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 	bool need_to_push = !task_on_cpu(rq, p) &&
 			    !test_tsk_need_resched(rq->curr) &&
 			    p->nr_cpus_allowed > 1 &&
-			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
+			    (dl_task(rq->donor) || rt_task(rq->donor)) &&
 			    (rq->curr->nr_cpus_allowed < 2 ||
-			     rq->curr->prio <= p->prio);
+			     rq->donor->prio <= p->prio);
 
 	if (need_to_push)
 		push_rt_tasks(rq);
@@ -2472,7 +2472,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
+		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2487,7 +2487,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (task_current(rq, p)) {
+	if (task_current_donor(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
@@ -2513,7 +2513,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq->curr->prio)
+		if (p->prio < rq->donor->prio)
 			resched_curr(rq);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cb74a577c89d..12651bb9410b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1147,7 +1147,10 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
-	struct task_struct __rcu	*curr;
+	union {
+		struct task_struct __rcu *donor; /* Scheduler context */
+		struct task_struct __rcu *curr;  /* Execution context */
+	};
 	struct sched_dl_entity	*dl_server;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
@@ -1344,6 +1347,11 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
+{
+	/* Do nothing */
+}
+
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
@@ -2260,11 +2268,25 @@ static inline u64 global_rt_runtime(void)
 	return (u64)sysctl_sched_rt_runtime * NSEC_PER_USEC;
 }
 
+/*
+ * Is p the current execution context?
+ */
 static inline int task_current(struct rq *rq, struct task_struct *p)
 {
 	return rq->curr == p;
 }
 
+/*
+ * Is p the current scheduling context?
+ *
+ * Note that it might be the current execution context at the same time if
+ * rq->curr == rq->donor == p.
+ */
+static inline int task_current_donor(struct rq *rq, struct task_struct *p)
+{
+	return rq->donor == p;
+}
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2448,7 +2470,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq->donor != prev);
 	prev->sched_class->put_prev_task(rq, prev, NULL);
 }
 
@@ -2612,7 +2634,7 @@ static inline cpumask_t *alloc_user_cpus_ptr(int node)
 
 static inline struct task_struct *get_push_task(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 
 	lockdep_assert_rq_held(rq);
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index aa70beee9895..db6f3fcb8111 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -91,7 +91,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_donor(rq, p);
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	if (running)
@@ -707,7 +707,7 @@ int __sched_setscheduler(struct task_struct *p,
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_donor(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flags);
 	if (running)
-- 
2.47.0.rc0.187.ge670bccf7e-goog



Return-Path: <linux-kernel+bounces-307809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF611965328
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 00:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D463281151
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6891BAEFF;
	Thu, 29 Aug 2024 22:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVxTjMNk"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929DA1BAEF0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971954; cv=none; b=el/uI3DDrlZy9S4KrdQZJAZy8D5fHixKRlyxsI8OU1dYM7cuoXGng+/Yx8iuJXN60Umb2ALNwGRLBTjn3tGwQcKiLWz8dI12MPbALMjMZL84NrvPaT4bs0d9obqoJ5HrcGbNQ++a8bAM/8eJUmCvR+Qbpl8vyAvMLfBDLX4KR9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971954; c=relaxed/simple;
	bh=Lj9MoKDrlaFVtjFG5TDfwdNRAw8w+RlbxwDAG1tDl+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uxvMd/oj8d+upGFm96uUNGzOiv+n+lf0c9Yk3+cztPqhqVH6Q41uyKhpI6YYO4qFuIpM/GuH8yZNl5+X0EDmgByEcv33yv3sfdQeCUabutj8XYK7gDio4+eIqvyWNth4+n1xTsHUyVehzVt44GqHmp/fiVByHUSYxCGMtXYjWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EVxTjMNk; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2039ce56280so12915175ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724971952; x=1725576752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYm82jaa8JuzNNgWsciwm8uY+j6r3O8VIIoxhBVM8ZU=;
        b=EVxTjMNkqx4V0Qw6236jmRSpMvRmdowOfiNJn2pFHB4yBPFvEMca3uifonPiT/wVGC
         VwVHLDgMMtMOXnmaJhnfoC4e5LmxsKLC7PhOuicxEdhKmDiWrk1clHCOoNDDkAMkce+R
         gR1urpN9fwxiYGLcqTUuA3XlDSRRqWpx//f0LP8fyJv1fQ9OHpCeDANtuda2pslyHQvP
         v+5ApzzQSbTfdzWHXn40s+exdep+pHDfPHDxzeXVQyzfaYbypMFYbBNugqZHqlcYD+oo
         lOUGuBWsnORiAlbH2IT3FJe6snALCC5zSYiO9vmeR4NwJisyTLYvX2gmff8AW9Iu9+Gc
         iZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724971952; x=1725576752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYm82jaa8JuzNNgWsciwm8uY+j6r3O8VIIoxhBVM8ZU=;
        b=f7sumjWwO60wfI78GeqOOEonepFV/6bUrUz/YbBWSq+q2Yg+4oVgpKvUqo1OAVE75w
         r7rgTBu/ZZmzlOo07txGlLpkG5wOEUJ/OpSrPVajKoITMxGY2GOe2k1HGwJmwlUJFxgK
         1i6H3xtbsYrtIvYtudcYyvKAwdDar8h5hkae8ORBCShyUv4SUg2NUjxUTE831lDLTU6w
         W+Z8mn9z8JM9b1Fbq5xAy/GG/g3gUX8AjPkHMjpS16EiBnfloDS40uyZV2E6uF52W9EH
         FJnJmZt9gdfdwk/UVjb+neGDkgfPZgBq2gNrSloTzHas43/2/67PjYC26ZL4opAKmGIu
         GIXA==
X-Gm-Message-State: AOJu0YwQChgZSqNGrDx38GNriQ1QooLNkfNXUuWnLZa9cWmabbnwglAD
	ZI46nEMC6/nXleiES/IoHBtIQxOZ1+E/VEeaMDUgpWexZ3rv3pcKjxzror12n/wbBsmMoxLm1qf
	TFnBZlfNfo+HNT8MI/cCzV9M53aI8mkE4uRP7QPWliK3o43keEmaXVCSUfk2gESuAAhLpZCC7CJ
	QcDbfKXHpmOX3rpV3M8RVuhNiu/k/pVuuUIFFH+WsaBOyf
X-Google-Smtp-Source: AGHT+IEv1SzcVNWaE45zOHwpngS41s6YWN0ErcB47tgp6+XKfWvKitas5UEfB7otpzu0QMxURsWc+LxBBxvX
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:e748:b0:201:daee:6fb2 with SMTP id
 d9443c01a7336-20527d56f4bmr107125ad.8.1724971951594; Thu, 29 Aug 2024
 15:52:31 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:52:07 -0700
In-Reply-To: <20240829225212.6042-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829225212.6042-1-jstultz@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240829225212.6042-8-jstultz@google.com>
Subject: [RESEND][PATCH v12 7/7] sched: Split scheduler and execution contexts
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
 kernel/sched/fair.c     | 32 +++++++++++++--------------
 kernel/sched/rt.c       | 48 ++++++++++++++++++++---------------------
 kernel/sched/sched.h    | 28 +++++++++++++++++++++---
 kernel/sched/syscalls.c |  4 ++--
 6 files changed, 115 insertions(+), 81 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2cc84f1549b7b..80a70b9bd27c2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -794,7 +794,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
+	rq->donor->sched_class->task_tick(rq, rq->curr, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -2053,16 +2053,18 @@ void check_class_changed(struct rq *rq, struct task_struct *p,
 
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
 
@@ -2586,7 +2588,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_donor(rq, p);
 
 	if (queued) {
 		/*
@@ -5373,7 +5375,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * project cycles that may never be accounted to this
 	 * thread, breaking clock_gettime().
 	 */
-	if (task_current(rq, p) && task_on_rq_queued(p)) {
+	if (task_current_donor(rq, p) && task_on_rq_queued(p)) {
 		prefetch_curr_exec_start(p);
 		update_rq_clock(rq);
 		p->sched_class->update_curr(rq);
@@ -5441,7 +5443,8 @@ void sched_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr;
+	/* accounting goes to the donor task */
+	struct task_struct *donor;
 	struct rq_flags rf;
 	unsigned long hw_pressure;
 	u64 resched_latency;
@@ -5452,19 +5455,19 @@ void sched_tick(void)
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
 
 	rq_unlock(rq, &rf);
 
@@ -5473,8 +5476,8 @@ void sched_tick(void)
 
 	perf_event_task_tick();
 
-	if (curr->flags & PF_WQ_WORKER)
-		wq_worker_tick(curr);
+	if (donor->flags & PF_WQ_WORKER)
+		wq_worker_tick(donor);
 
 #ifdef CONFIG_SMP
 	rq->idle_balance = idle_cpu(cpu);
@@ -5539,6 +5542,12 @@ static void sched_tick_remote(struct work_struct *work)
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
@@ -6488,6 +6497,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+	rq_set_donor(rq, next);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -6984,7 +6994,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
 	prev_class = p->sched_class;
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_donor(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flag);
 	if (running)
@@ -7552,6 +7562,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	rcu_read_unlock();
 
 	rq->idle = idle;
+	rq_set_donor(rq, idle);
 	rcu_assign_pointer(rq->curr, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
@@ -7641,7 +7652,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_donor(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -8772,7 +8783,7 @@ void sched_move_task(struct task_struct *tsk)
 
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_current_donor(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d3050f6c2958d..c284585f23cba 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1217,7 +1217,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 #endif
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
-	if (dl_task(rq->curr))
+	if (dl_task(rq->donor))
 		wakeup_preempt_dl(rq, p, 0);
 	else
 		resched_curr(rq);
@@ -1441,11 +1441,11 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
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
@@ -1903,7 +1903,7 @@ static int find_later_rq(struct task_struct *task);
 static int
 select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *donor;
 	bool select_rq;
 	struct rq *rq;
 
@@ -1914,6 +1914,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	donor = READ_ONCE(rq->donor);
 
 	/*
 	 * If we are dealing with a -deadline task, we must
@@ -1924,9 +1925,9 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
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
@@ -1989,7 +1990,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	 * let's hope p can move out.
 	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpudl_find(&rq->rd->cpudl, rq->curr, NULL))
+	    !cpudl_find(&rq->rd->cpudl, rq->donor, NULL))
 		return;
 
 	/*
@@ -2028,7 +2029,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
-	if (dl_entity_preempt(&p->dl, &rq->curr->dl)) {
+	if (dl_entity_preempt(&p->dl, &rq->donor->dl)) {
 		resched_curr(rq);
 		return;
 	}
@@ -2038,7 +2039,7 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 	 * In the unlikely case current and p have the same deadline
 	 * let us try to decide what's the best thing to do...
 	 */
-	if ((p->dl.deadline == rq->curr->dl.deadline) &&
+	if ((p->dl.deadline == rq->donor->dl.deadline) &&
 	    !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
@@ -2070,7 +2071,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (!first)
 		return;
 
-	if (rq->curr->sched_class != &dl_sched_class)
+	if (rq->donor->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
@@ -2395,8 +2396,8 @@ static int push_dl_task(struct rq *rq)
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
@@ -2519,7 +2520,7 @@ static void pull_dl_task(struct rq *this_rq)
 			 * deadline than the current task of its runqueue.
 			 */
 			if (dl_time_before(p->dl.deadline,
-					   src_rq->curr->dl.deadline))
+					   src_rq->donor->dl.deadline))
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2558,9 +2559,9 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
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
@@ -2735,12 +2736,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
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
@@ -2769,7 +2770,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	if (!rq->dl.overloaded)
 		deadline_queue_pull_task(rq);
 
-	if (task_current(rq, p)) {
+	if (task_current_donor(rq, p)) {
 		/*
 		 * If we now have a earlier deadline task than p,
 		 * then reschedule, provided p is still on this
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06de..9b8734f861e03 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1140,12 +1140,12 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
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
@@ -1177,7 +1177,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq->curr->se));
+	update_curr(cfs_rq_of(&rq->donor->se));
 }
 
 static inline void
@@ -6645,7 +6645,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
-			if (task_current(rq, p))
+			if (task_current_donor(rq, p))
 				resched_curr(rq);
 			return;
 		}
@@ -6660,12 +6660,12 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
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
@@ -8347,9 +8347,9 @@ static void set_next_buddy(struct sched_entity *se)
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
@@ -8378,11 +8378,11 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(rq->curr))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
-	if (unlikely(task_has_idle_policy(curr)) &&
+	if (unlikely(task_has_idle_policy(donor)) &&
 	    likely(!task_has_idle_policy(p)))
 		goto preempt;
 
@@ -9356,7 +9356,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
 	 * DL and IRQ signals have been updated before updating CFS.
 	 */
-	curr_class = rq->curr->sched_class;
+	curr_class = rq->donor->sched_class;
 
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 
@@ -12738,7 +12738,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 * our priority decreased, or if we are not currently running on
 	 * this runqueue and our priority is higher than the current's
 	 */
-	if (task_current(rq, p)) {
+	if (task_current_donor(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
@@ -12843,7 +12843,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * kick off the schedule if running, otherwise just see
 		 * if we can still preempt the current task.
 		 */
-		if (task_current(rq, p))
+		if (task_current_donor(rq, p))
 			resched_curr(rq);
 		else
 			wakeup_preempt(rq, p, 0);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 9f07f09641f7a..f8b3cb92d6776 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -529,7 +529,7 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 
 static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 {
-	struct task_struct *curr = rq_of_rt_rq(rt_rq)->curr;
+	struct task_struct *donor = rq_of_rt_rq(rt_rq)->donor;
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct sched_rt_entity *rt_se;
 
@@ -543,7 +543,7 @@ static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 		else if (!on_rt_rq(rt_se))
 			enqueue_rt_entity(rt_se, 0);
 
-		if (rt_rq->highest_prio.curr < curr->prio)
+		if (rt_rq->highest_prio.curr < donor->prio)
 			resched_curr(rq);
 	}
 }
@@ -999,11 +999,11 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
  */
 static void update_curr_rt(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
-	struct sched_rt_entity *rt_se = &curr->rt;
+	struct task_struct *donor = rq->donor;
+	struct sched_rt_entity *rt_se = &donor->rt;
 	s64 delta_exec;
 
-	if (curr->sched_class != &rt_sched_class)
+	if (donor->sched_class != &rt_sched_class)
 		return;
 
 	delta_exec = update_curr_common(rq);
@@ -1542,7 +1542,7 @@ static int find_lowest_rq(struct task_struct *task);
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *donor;
 	struct rq *rq;
 	bool test;
 
@@ -1554,6 +1554,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	donor = READ_ONCE(rq->donor);
 
 	/*
 	 * If the current task on @p's runqueue is an RT task, then
@@ -1582,8 +1583,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	 * systems like big.LITTLE.
 	 */
 	test = curr &&
-	       unlikely(rt_task(curr)) &&
-	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
+	       unlikely(rt_task(donor)) &&
+	       (curr->nr_cpus_allowed < 2 || donor->prio <= p->prio);
 
 	if (test || !rt_task_fits_capacity(p, cpu)) {
 		int target = find_lowest_rq(p);
@@ -1613,12 +1614,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
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
@@ -1661,7 +1658,9 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
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
@@ -1679,7 +1678,7 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
+	if (p->prio == donor->prio && !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -1704,7 +1703,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	 * utilization. We only care of the case where we start to schedule a
 	 * rt task
 	 */
-	if (rq->curr->sched_class != &rt_sched_class)
+	if (rq->donor->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
@@ -1976,6 +1975,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
 
 	BUG_ON(rq->cpu != task_cpu(p));
 	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current_donor(rq, p));
 	BUG_ON(p->nr_cpus_allowed <= 1);
 
 	BUG_ON(!task_on_rq_queued(p));
@@ -2008,7 +2008,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (unlikely(next_task->prio < rq->donor->prio)) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2029,7 +2029,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * Note that the stoppers are masqueraded as SCHED_FIFO
 		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
 		 */
-		if (rq->curr->sched_class != &rt_sched_class)
+		if (rq->donor->sched_class != &rt_sched_class)
 			return 0;
 
 		cpu = find_lowest_rq(rq->curr);
@@ -2361,7 +2361,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio)
+			if (p->prio < src_rq->donor->prio)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2403,9 +2403,9 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
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
@@ -2489,7 +2489,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
+		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2504,7 +2504,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (task_current(rq, p)) {
+	if (task_current_donor(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
@@ -2530,7 +2530,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq->curr->prio)
+		if (p->prio < rq->donor->prio)
 			resched_curr(rq);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10ef612c078f9..06bca59c2bce5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1058,7 +1058,10 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
-	struct task_struct __rcu	*curr;
+	union {
+		struct task_struct __rcu *donor; /* Scheduler context */
+		struct task_struct __rcu *curr;  /* Execution context */
+	};
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -1254,6 +1257,11 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
+{
+	/* Do nothing */
+}
+
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
@@ -2170,11 +2178,25 @@ static inline u64 global_rt_runtime(void)
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
@@ -2344,7 +2366,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq->donor != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
@@ -2436,7 +2458,7 @@ static inline cpumask_t *alloc_user_cpus_ptr(int node)
 
 static inline struct task_struct *get_push_task(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq->donor;
 
 	lockdep_assert_rq_held(rq);
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index ae1b42775ef95..f0b25e810cbae 100644
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
@@ -784,7 +784,7 @@ int __sched_setscheduler(struct task_struct *p,
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_donor(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flags);
 	if (running)
-- 
2.46.0.469.g59c65b2a67-goog



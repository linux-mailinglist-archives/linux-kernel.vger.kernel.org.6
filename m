Return-Path: <linux-kernel+bounces-246639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1B92C497
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF5A1F2323E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62081182A6C;
	Tue,  9 Jul 2024 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6RvXDIX"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF19189F37
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557164; cv=none; b=OT3GPEGgGKjEZyuStnoPtr6qFNgwoR4u+ObddckF9b/T+Jchj8GqPtKQ2Ox0DikxSDLKJUEbQTPKwlhHuakkOGELa0zlfDVU0nOo+Z8Q38WozgAnU8OJXPLAs7QQ9s1TUuSkleUoOARQBe+VjAgRDb6tHwEbag1xOKGpGxi0384=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557164; c=relaxed/simple;
	bh=8oj2dPJkunaEhP3TXkBMXGahZJyB/Lzz3GQs5N7CM0A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JUHBbSzutA/9pcVw94NjfVYJRWW4x0Eh/igmWW+JhrOs5CwnqlNWJlg6xKpwnlMUGzyb84XtKiaQ9B/4u01WGH2b586rsYdrUxj8qaKfjhrxpD3yMkCPviyLohF/W3PQg6X82plpqeVCo68dZ91eTvmheDCVwVFfrhCqXFnrJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6RvXDIX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c1a9e8d3b0so5117027a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720557161; x=1721161961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9e4tXmsEC4Nw+Pj8+hrXXnuPc9FiOIZDGJo5IDuGx9g=;
        b=K6RvXDIXx59I/RuMaY43edwJawoUHU88TZdmrWEfGmYmG/26cBVTXYqJkDcNBUJhyc
         ZMsDb9DvWyaYPNLW/2hkGPemA0+pbClfDhI2u28L1UAoX8JDD2gRnrzYj2F3sKVFxQAb
         ZyO7k2KEz3avWSksNUkSzrxsL8aWUGcgYA5MJwZj/IrmB/qeRASntg1o7lTIAOc6QQzF
         JE2CxruGwcvGL7alUpYLrSjkIcndVo2cStUH7ol25rhVo/3mAblk7M4XlacecVQ2ORcC
         9ts9h/HsbQgPBs+ePMN89bRErA174Bxe+ldOywe5/pJw06mBnFRW+2uOfPyibkdX1+TB
         bSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557161; x=1721161961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9e4tXmsEC4Nw+Pj8+hrXXnuPc9FiOIZDGJo5IDuGx9g=;
        b=epck3RfAQdv8SdFSsu5W4fKvs3YT+1OA79nIC3zaOwF0Xg1C+EED1Gx50BXc9ahOtO
         AXo1257aKbwdPWsWUbnHjW+uNCAXrSX2wCmUBMig1QDYvw5EXJ4WPlrLvtBDjLfDl9Jz
         fL5UA1OUBzVhyZ7ttk81bsPN27Qmt8aH8ivr6NvKEHTKdduHgtQGWUKmk6peWcDtqyEj
         VMdTYZjSgJYTc6psrdCXG6kPON9kkGYHcYs/eXJrmITqm66GfPo/tJwR6xTVIkZuiN8C
         wEYBEHH8dxn1fH5pNFz7jgy3DV9LG3ZNFObebamAcchrEun6o4gzsyjqGo/94zNzOcuJ
         YKJw==
X-Gm-Message-State: AOJu0YxMsSthsK25wcKd0auyZJwc0VOh2nCxY5Ffkr//khj24/4eVrv7
	VHN7QEFWLPfJySdvyP11DzXGFtXDVOGw7Qbe+Bg5qMnnMMDDn4DwJiQmpX6SRle0qSla3z5PnUM
	Z1rUFBhHHKUrnY7eJ9BkltdfyYPTh70A/JDoo6WmKLB1qzB+LwjJR+ZEh06vW7UaEF8/vflhCVP
	3Ag38wAziv5i3EEap3YOCtRbnafblpQYWDl5VxFYPuj9kg
X-Google-Smtp-Source: AGHT+IHHYaY+AsRwjbooo/r+hbZcznnhi7/ERdwg/3poVO0ge/tGlFZlxV2mrkusIBNXMalXMTMntVDLoSD0
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:d2cc:b0:1f9:aafc:1ebb with SMTP id
 d9443c01a7336-1fbb6e9abc3mr2637455ad.13.1720557161034; Tue, 09 Jul 2024
 13:32:41 -0700 (PDT)
Date: Tue,  9 Jul 2024 13:31:50 -0700
In-Reply-To: <20240709203213.799070-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240709203213.799070-8-jstultz@google.com>
Subject: [PATCH v11 7/7] sched: Split scheduler and execution contexts
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat <youssefesmat@google.com>, 
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Metin Kaya <Metin.Kaya@arm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>, Metin Kaya <metin.kaya@arm.com>
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

Let's define the scheduling context as all the scheduler state
in task_struct for the task selected to run, and the execution
context as all state required to actually run the task.

Currently both are intertwined in task_struct. We want to
logically split these such that we can use the scheduling
context of the task selected to be scheduled, but use the
execution context of a different task to actually be run.

To this purpose, introduce rq_selected() macro to point to the
task_struct selected from the runqueue by the scheduler, and
will be used for scheduler state, and preserve rq->curr to
indicate the execution context of the task that will actually be
run.

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
Cc: Youssef Esmat <youssefesmat@google.com>
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
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
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
---
 kernel/sched/core.c     | 46 ++++++++++++++++++++++++---------------
 kernel/sched/deadline.c | 39 +++++++++++++++++----------------
 kernel/sched/fair.c     | 32 +++++++++++++--------------
 kernel/sched/rt.c       | 48 ++++++++++++++++++++---------------------
 kernel/sched/sched.h    | 27 ++++++++++++++++++++---
 5 files changed, 113 insertions(+), 79 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 029e7ecf5ea9..17036bae4a27 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -794,7 +794,7 @@ static enum hrtimer_restart hrtick(struct hrtimer *timer)
 
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
-	rq->curr->sched_class->task_tick(rq, rq->curr, 1);
+	rq_selected(rq)->sched_class->task_tick(rq, rq->curr, 1);
 	rq_unlock(rq, &rf);
 
 	return HRTIMER_NORESTART;
@@ -2236,16 +2236,18 @@ static inline void check_class_changed(struct rq *rq, struct task_struct *p,
 
 void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->sched_class == rq->curr->sched_class)
-		rq->curr->sched_class->wakeup_preempt(rq, p, flags);
-	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
+	struct task_struct *selected = rq_selected(rq);
+
+	if (p->sched_class == selected->sched_class)
+		selected->sched_class->wakeup_preempt(rq, p, flags);
+	else if (sched_class_above(p->sched_class, selected->sched_class))
 		resched_curr(rq);
 
 	/*
 	 * A queue event has occurred, and we're going to schedule.  In
 	 * this case, we can save a useless back to back clock update.
 	 */
-	if (task_on_rq_queued(rq->curr) && test_tsk_need_resched(rq->curr))
+	if (task_on_rq_queued(selected) && test_tsk_need_resched(rq->curr))
 		rq_clock_skip_update(rq);
 }
 
@@ -2772,7 +2774,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 		lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 
 	if (queued) {
 		/*
@@ -5593,7 +5595,7 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	 * project cycles that may never be accounted to this
 	 * thread, breaking clock_gettime().
 	 */
-	if (task_current(rq, p) && task_on_rq_queued(p)) {
+	if (task_current_selected(rq, p) && task_on_rq_queued(p)) {
 		prefetch_curr_exec_start(p);
 		update_rq_clock(rq);
 		p->sched_class->update_curr(rq);
@@ -5661,7 +5663,8 @@ void sched_tick(void)
 {
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
-	struct task_struct *curr = rq->curr;
+	/* accounting goes to the selected task */
+	struct task_struct *selected;
 	struct rq_flags rf;
 	unsigned long hw_pressure;
 	u64 resched_latency;
@@ -5672,16 +5675,17 @@ void sched_tick(void)
 	sched_clock_tick();
 
 	rq_lock(rq, &rf);
+	selected = rq_selected(rq);
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
-	curr->sched_class->task_tick(rq, curr, 0);
+	selected->sched_class->task_tick(rq, selected, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
-	task_tick_mm_cid(rq, curr);
+	task_tick_mm_cid(rq, selected);
 
 	rq_unlock(rq, &rf);
 
@@ -5690,8 +5694,8 @@ void sched_tick(void)
 
 	perf_event_task_tick();
 
-	if (curr->flags & PF_WQ_WORKER)
-		wq_worker_tick(curr);
+	if (selected->flags & PF_WQ_WORKER)
+		wq_worker_tick(selected);
 
 #ifdef CONFIG_SMP
 	rq->idle_balance = idle_cpu(cpu);
@@ -5756,6 +5760,12 @@ static void sched_tick_remote(struct work_struct *work)
 		struct task_struct *curr = rq->curr;
 
 		if (cpu_online(cpu)) {
+			/*
+			 * Since this is a remote tick for full dynticks mode,
+			 * we are always sure that there is no proxy (only a
+			 * single task is running).
+			 */
+			SCHED_WARN_ON(rq->curr != rq_selected(rq));
 			update_rq_clock(rq);
 
 			if (!is_idle_task(curr)) {
@@ -6705,6 +6715,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	}
 
 	next = pick_next_task(rq, prev, &rf);
+	rq_set_selected(rq, next);
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
@@ -7215,7 +7226,7 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 
 	prev_class = p->sched_class;
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flag);
 	if (running)
@@ -7305,7 +7316,7 @@ void set_user_nice(struct task_struct *p, long nice)
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
 	if (running)
@@ -7884,7 +7895,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	}
 
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 	if (queued)
 		dequeue_task(rq, p, queue_flags);
 	if (running)
@@ -9311,6 +9322,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	rcu_read_unlock();
 
 	rq->idle = idle;
+	rq_set_selected(rq, idle);
 	rcu_assign_pointer(rq->curr, idle);
 	idle->on_rq = TASK_ON_RQ_QUEUED;
 #ifdef CONFIG_SMP
@@ -9400,7 +9412,7 @@ void sched_setnuma(struct task_struct *p, int nid)
 
 	rq = task_rq_lock(p, &rf);
 	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
+	running = task_current_selected(rq, p);
 
 	if (queued)
 		dequeue_task(rq, p, DEQUEUE_SAVE);
@@ -10505,7 +10517,7 @@ void sched_move_task(struct task_struct *tsk)
 
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
+	running = task_current_selected(rq, tsk);
 	queued = task_on_rq_queued(tsk);
 
 	if (queued)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ef135776e068..dbfa14ff16ed 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1217,7 +1217,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 #endif
 
 	enqueue_task_dl(rq, p, ENQUEUE_REPLENISH);
-	if (dl_task(rq->curr))
+	if (dl_task(rq_selected(rq)))
 		wakeup_preempt_dl(rq, p, 0);
 	else
 		resched_curr(rq);
@@ -1441,11 +1441,11 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
  */
 static void update_curr_dl(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
-	struct sched_dl_entity *dl_se = &curr->dl;
+	struct task_struct *selected = rq_selected(rq);
+	struct sched_dl_entity *dl_se = &selected->dl;
 	s64 delta_exec;
 
-	if (!dl_task(curr) || !on_dl_rq(dl_se))
+	if (!dl_task(selected) || !on_dl_rq(dl_se))
 		return;
 
 	/*
@@ -1898,7 +1898,7 @@ static int find_later_rq(struct task_struct *task);
 static int
 select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *selected;
 	bool select_rq;
 	struct rq *rq;
 
@@ -1909,6 +1909,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	selected = READ_ONCE(rq_selected(rq));
 
 	/*
 	 * If we are dealing with a -deadline task, we must
@@ -1919,9 +1920,9 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	 * other hand, if it has a shorter deadline, we
 	 * try to make it stay here, it might be important.
 	 */
-	select_rq = unlikely(dl_task(curr)) &&
+	select_rq = unlikely(dl_task(selected)) &&
 		    (curr->nr_cpus_allowed < 2 ||
-		     !dl_entity_preempt(&p->dl, &curr->dl)) &&
+		     !dl_entity_preempt(&p->dl, &selected->dl)) &&
 		    p->nr_cpus_allowed > 1;
 
 	/*
@@ -1984,7 +1985,7 @@ static void check_preempt_equal_dl(struct rq *rq, struct task_struct *p)
 	 * let's hope p can move out.
 	 */
 	if (rq->curr->nr_cpus_allowed == 1 ||
-	    !cpudl_find(&rq->rd->cpudl, rq->curr, NULL))
+	    !cpudl_find(&rq->rd->cpudl, rq_selected(rq), NULL))
 		return;
 
 	/*
@@ -2023,7 +2024,7 @@ static int balance_dl(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 				  int flags)
 {
-	if (dl_entity_preempt(&p->dl, &rq->curr->dl)) {
+	if (dl_entity_preempt(&p->dl, &rq_selected(rq)->dl)) {
 		resched_curr(rq);
 		return;
 	}
@@ -2033,7 +2034,7 @@ static void wakeup_preempt_dl(struct rq *rq, struct task_struct *p,
 	 * In the unlikely case current and p have the same deadline
 	 * let us try to decide what's the best thing to do...
 	 */
-	if ((p->dl.deadline == rq->curr->dl.deadline) &&
+	if ((p->dl.deadline == rq_selected(rq)->dl.deadline) &&
 	    !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_dl(rq, p);
 #endif /* CONFIG_SMP */
@@ -2065,7 +2066,7 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (!first)
 		return;
 
-	if (rq->curr->sched_class != &dl_sched_class)
+	if (rq_selected(rq)->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	deadline_queue_push_tasks(rq);
@@ -2390,8 +2391,8 @@ static int push_dl_task(struct rq *rq)
 	 * can move away, it makes sense to just reschedule
 	 * without going further in pushing next_task.
 	 */
-	if (dl_task(rq->curr) &&
-	    dl_time_before(next_task->dl.deadline, rq->curr->dl.deadline) &&
+	if (dl_task(rq_selected(rq)) &&
+	    dl_time_before(next_task->dl.deadline, rq_selected(rq)->dl.deadline) &&
 	    rq->curr->nr_cpus_allowed > 1) {
 		resched_curr(rq);
 		return 0;
@@ -2514,7 +2515,7 @@ static void pull_dl_task(struct rq *this_rq)
 			 * deadline than the current task of its runqueue.
 			 */
 			if (dl_time_before(p->dl.deadline,
-					   src_rq->curr->dl.deadline))
+					   rq_selected(src_rq)->dl.deadline))
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2553,9 +2554,9 @@ static void task_woken_dl(struct rq *rq, struct task_struct *p)
 	if (!task_on_cpu(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
 	    p->nr_cpus_allowed > 1 &&
-	    dl_task(rq->curr) &&
+	    dl_task(rq_selected(rq)) &&
 	    (rq->curr->nr_cpus_allowed < 2 ||
-	     !dl_entity_preempt(&p->dl, &rq->curr->dl))) {
+	     !dl_entity_preempt(&p->dl, &rq_selected(rq)->dl))) {
 		push_dl_tasks(rq);
 	}
 }
@@ -2730,12 +2731,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 		return;
 	}
 
-	if (rq->curr != p) {
+	if (rq_selected(rq) != p) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->dl.overloaded)
 			deadline_queue_push_tasks(rq);
 #endif
-		if (dl_task(rq->curr))
+		if (dl_task(rq_selected(rq)))
 			wakeup_preempt_dl(rq, p, 0);
 		else
 			resched_curr(rq);
@@ -2764,7 +2765,7 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 	if (!rq->dl.overloaded)
 		deadline_queue_pull_task(rq);
 
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 		/*
 		 * If we now have a earlier deadline task than p,
 		 * then reschedule, provided p is still on this
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..4d0d3b423220 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1140,12 +1140,12 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
  */
 s64 update_curr_common(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *selected = rq_selected(rq);
 	s64 delta_exec;
 
-	delta_exec = update_curr_se(rq, &curr->se);
+	delta_exec = update_curr_se(rq, &selected->se);
 	if (likely(delta_exec > 0))
-		update_curr_task(curr, delta_exec);
+		update_curr_task(selected, delta_exec);
 
 	return delta_exec;
 }
@@ -1177,7 +1177,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq->curr->se));
+	update_curr(cfs_rq_of(&rq_selected(rq)->se));
 }
 
 static inline void
@@ -6646,7 +6646,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
-			if (task_current(rq, p))
+			if (task_current_selected(rq, p))
 				resched_curr(rq);
 			return;
 		}
@@ -6661,12 +6661,12 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
  */
 static void hrtick_update(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
+	struct task_struct *selected = rq_selected(rq);
 
-	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
+	if (!hrtick_enabled_fair(rq) || selected->sched_class != &fair_sched_class)
 		return;
 
-	hrtick_start_fair(rq, curr);
+	hrtick_start_fair(rq, selected);
 }
 #else /* !CONFIG_SCHED_HRTICK */
 static inline void
@@ -8348,9 +8348,9 @@ static void set_next_buddy(struct sched_entity *se)
  */
 static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
 {
-	struct task_struct *curr = rq->curr;
-	struct sched_entity *se = &curr->se, *pse = &p->se;
-	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
+	struct task_struct *selected = rq_selected(rq);
+	struct sched_entity *se = &selected->se, *pse = &p->se;
+	struct cfs_rq *cfs_rq = task_cfs_rq(selected);
 	int cse_is_idle, pse_is_idle;
 
 	if (unlikely(se == pse))
@@ -8379,11 +8379,11 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * prevents us from potentially nominating it as a false LAST_BUDDY
 	 * below.
 	 */
-	if (test_tsk_need_resched(curr))
+	if (test_tsk_need_resched(rq->curr))
 		return;
 
 	/* Idle tasks are by definition preempted by non-idle tasks. */
-	if (unlikely(task_has_idle_policy(curr)) &&
+	if (unlikely(task_has_idle_policy(selected)) &&
 	    likely(!task_has_idle_policy(p)))
 		goto preempt;
 
@@ -9361,7 +9361,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 	 * update_load_avg() can call cpufreq_update_util(). Make sure that RT,
 	 * DL and IRQ signals have been updated before updating CFS.
 	 */
-	curr_class = rq->curr->sched_class;
+	curr_class = rq_selected(rq)->sched_class;
 
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
 
@@ -12738,7 +12738,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 * our priority decreased, or if we are not currently running on
 	 * this runqueue and our priority is higher than the current's
 	 */
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
@@ -12843,7 +12843,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * kick off the schedule if running, otherwise just see
 		 * if we can still preempt the current task.
 		 */
-		if (task_current(rq, p))
+		if (task_current_selected(rq, p))
 			resched_curr(rq);
 		else
 			wakeup_preempt(rq, p, 0);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 56363e18949a..da4cbd744fe6 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -529,7 +529,7 @@ static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 
 static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 {
-	struct task_struct *curr = rq_of_rt_rq(rt_rq)->curr;
+	struct task_struct *selected = rq_selected(rq_of_rt_rq(rt_rq));
 	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct sched_rt_entity *rt_se;
 
@@ -543,7 +543,7 @@ static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
 		else if (!on_rt_rq(rt_se))
 			enqueue_rt_entity(rt_se, 0);
 
-		if (rt_rq->highest_prio.curr < curr->prio)
+		if (rt_rq->highest_prio.curr < selected->prio)
 			resched_curr(rq);
 	}
 }
@@ -999,11 +999,11 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
  */
 static void update_curr_rt(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
-	struct sched_rt_entity *rt_se = &curr->rt;
+	struct task_struct *selected = rq_selected(rq);
+	struct sched_rt_entity *rt_se = &selected->rt;
 	s64 delta_exec;
 
-	if (curr->sched_class != &rt_sched_class)
+	if (selected->sched_class != &rt_sched_class)
 		return;
 
 	delta_exec = update_curr_common(rq);
@@ -1542,7 +1542,7 @@ static int find_lowest_rq(struct task_struct *task);
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
-	struct task_struct *curr;
+	struct task_struct *curr, *selected;
 	struct rq *rq;
 	bool test;
 
@@ -1554,6 +1554,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 
 	rcu_read_lock();
 	curr = READ_ONCE(rq->curr); /* unlocked access */
+	selected = READ_ONCE(rq_selected(rq));
 
 	/*
 	 * If the current task on @p's runqueue is an RT task, then
@@ -1582,8 +1583,8 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	 * systems like big.LITTLE.
 	 */
 	test = curr &&
-	       unlikely(rt_task(curr)) &&
-	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
+	       unlikely(rt_task(selected)) &&
+	       (curr->nr_cpus_allowed < 2 || selected->prio <= p->prio);
 
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
+	    !cpupri_find(&rq->rd->cpupri, rq_selected(rq), NULL))
 		return;
 
 	/*
@@ -1661,7 +1658,9 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
  */
 static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (p->prio < rq->curr->prio) {
+	struct task_struct *selected = rq_selected(rq);
+
+	if (p->prio < selected->prio) {
 		resched_curr(rq);
 		return;
 	}
@@ -1679,7 +1678,7 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 	 * to move current somewhere else, making room for our non-migratable
 	 * task.
 	 */
-	if (p->prio == rq->curr->prio && !test_tsk_need_resched(rq->curr))
+	if (p->prio == selected->prio && !test_tsk_need_resched(rq->curr))
 		check_preempt_equal_prio(rq, p);
 #endif
 }
@@ -1704,7 +1703,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	 * utilization. We only care of the case where we start to schedule a
 	 * rt task
 	 */
-	if (rq->curr->sched_class != &rt_sched_class)
+	if (rq_selected(rq)->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
 	rt_queue_push_tasks(rq);
@@ -1976,6 +1975,7 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
 
 	BUG_ON(rq->cpu != task_cpu(p));
 	BUG_ON(task_current(rq, p));
+	BUG_ON(task_current_selected(rq, p));
 	BUG_ON(p->nr_cpus_allowed <= 1);
 
 	BUG_ON(!task_on_rq_queued(p));
@@ -2008,7 +2008,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 	 * higher priority than current. If that's the case
 	 * just reschedule current.
 	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
+	if (unlikely(next_task->prio < rq_selected(rq)->prio)) {
 		resched_curr(rq);
 		return 0;
 	}
@@ -2029,7 +2029,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		 * Note that the stoppers are masqueraded as SCHED_FIFO
 		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
 		 */
-		if (rq->curr->sched_class != &rt_sched_class)
+		if (rq_selected(rq)->sched_class != &rt_sched_class)
 			return 0;
 
 		cpu = find_lowest_rq(rq->curr);
@@ -2361,7 +2361,7 @@ static void pull_rt_task(struct rq *this_rq)
 			 * p if it is lower in priority than the
 			 * current task on the run queue
 			 */
-			if (p->prio < src_rq->curr->prio)
+			if (p->prio < rq_selected(src_rq)->prio)
 				goto skip;
 
 			if (is_migration_disabled(p)) {
@@ -2403,9 +2403,9 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 	bool need_to_push = !task_on_cpu(rq, p) &&
 			    !test_tsk_need_resched(rq->curr) &&
 			    p->nr_cpus_allowed > 1 &&
-			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
+			    (dl_task(rq_selected(rq)) || rt_task(rq_selected(rq))) &&
 			    (rq->curr->nr_cpus_allowed < 2 ||
-			     rq->curr->prio <= p->prio);
+			     rq_selected(rq)->prio <= p->prio);
 
 	if (need_to_push)
 		push_rt_tasks(rq);
@@ -2489,7 +2489,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
 #endif /* CONFIG_SMP */
-		if (p->prio < rq->curr->prio && cpu_online(cpu_of(rq)))
+		if (p->prio < rq_selected(rq)->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
 }
@@ -2504,7 +2504,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (task_current(rq, p)) {
+	if (task_current_selected(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
@@ -2530,7 +2530,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 		 * greater than the current running task
 		 * then reschedule.
 		 */
-		if (p->prio < rq->curr->prio)
+		if (p->prio < rq_selected(rq)->prio)
 			resched_curr(rq);
 	}
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 493de4cc320a..7ee8c7fa0ae8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1051,7 +1051,7 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
-	struct task_struct __rcu	*curr;
+	struct task_struct __rcu	*curr;       /* Execution context */
 	struct task_struct	*idle;
 	struct task_struct	*stop;
 	unsigned long		next_balance;
@@ -1246,6 +1246,13 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+/* For now, rq_selected == rq->curr */
+#define rq_selected(rq)		((rq)->curr)
+static inline void rq_set_selected(struct rq *rq, struct task_struct *t)
+{
+	/* Do nothing */
+}
+
 struct sched_group;
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
@@ -2151,11 +2158,25 @@ static inline u64 global_rt_runtime(void)
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
+ * rq->curr == rq_selected() == p.
+ */
+static inline int task_current_selected(struct rq *rq, struct task_struct *p)
+{
+	return rq_selected(rq) == p;
+}
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2325,7 +2346,7 @@ struct sched_class {
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq_selected(rq) != prev);
 	prev->sched_class->put_prev_task(rq, prev);
 }
 
@@ -2406,7 +2427,7 @@ extern void set_cpus_allowed_common(struct task_struct *p, struct affinity_conte
 
 static inline struct task_struct *get_push_task(struct rq *rq)
 {
-	struct task_struct *p = rq->curr;
+	struct task_struct *p = rq_selected(rq);
 
 	lockdep_assert_rq_held(rq);
 
-- 
2.45.2.993.g49e7a77208-goog



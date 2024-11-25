Return-Path: <linux-kernel+bounces-421581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAC09D8D19
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFFE7B26385
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A521C07F6;
	Mon, 25 Nov 2024 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+FpwR5E"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC61CD210
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564341; cv=none; b=Efi2STIZjqk6KS6YzPNFB0HT9yK8IZtvEC3kqRqwf2age4YmEnt1jJnEifTdoU7iTAWLfrEVI4CcskDmQOKIycqmP+zGFltYv4NPQ6nWKetzHUJEUqDtMnkQqE+ZR+KsUfU5VIfRJWlJs75NxQMFHo++o1KiaEF78POHQUhttkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564341; c=relaxed/simple;
	bh=J0V+SYDTlsKBx4a0oSxVfq4AwcX1ZjFOzABscMrTpFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=md9vI6SKqfZawWtMrF+AMSbiwpXhSjs04Sj+JkaXhW97jxOXEhwiVu/VbXfQLstZciA5PXYqiV9F4Oh1z7sqi6jn6dS5iUHm6cJ5Q4Lm8ph5PfqKjsyZgH4ENaivxDAIThRl4jC472UaXYm6yGRVQIGxWS3fD0rcQtIDPLvYzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+FpwR5E; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7fc2dc5861eso1265379a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732564339; x=1733169139; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XOtAH6cdJdFL4IxlyXePH2qxBmoamy+ophSAltPJL/Y=;
        b=Z+FpwR5ES4w5XtzTxSkSDCMfYhQ/91zL1bVm799uQ0aUYrJFkSsUXz2pd1aPkG4Bjm
         yGM1H7YQsohl1LXOSP3U+13pxE4Nk/DOag14aRPNV6w7fI99AJ8UWAUid4yQyPvVflUu
         Htt92+2kfLS0DTPQ4vwWQ9eQnyJMGbfb3K/LKnydDrxa+343vzFaa3+cgCOpHpUW9nj7
         Rle3wH3OOfAcb6r24QMrwHs7xRppfsSR7mCMlxGWZSzs71O2FU4ohYzIloNuHyhDu1OY
         gGFJ91AQ87Zj89xQXXUYlrhcCeUyDTDxp67NHYC2TYNEwL3Yq30K1IriTmFmlmYRWGpY
         G12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564339; x=1733169139;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOtAH6cdJdFL4IxlyXePH2qxBmoamy+ophSAltPJL/Y=;
        b=QkGTpYmmrW5vz2LQoa6CWuPhaVDIZWAlUm2xP5aGQehia1IpKCoEzfXw4RXGBrqd+Y
         OGYoIPz3QN5tPPN/qbeSkFlwUPNeYDoeHv5YlJBJuuudDl+9CDuRpbqa0wYgZUHvKTx7
         KKawWcEdVcA4ce/wCVhI0XbCq9KIltATpbxsSIS6g8Ly2LpDrN9wjYQI9Q6dtHcxtD7K
         ziTB+r/0vZKpkMXZjRnuo3XK4EHaqhXYR+R6D2RUsCnCaCABhfwW0B/wmaGgvNRlhXze
         pU22UIHKE0DhckIl37LtbWeex/kf50IjBsA2EbguAuen9nRfvPibis//OoIk98bElap8
         KKVQ==
X-Gm-Message-State: AOJu0YygQv8YrTRF3q9oE0G2/X/8JSi/kziWopFWWM5NJ/BA2asgSFMp
	V25tqWIUMZyolTRtU6uzlXXlPVj4zbs4ltQzF8YAnmF60sYQ0zUCVsQGKZZlUAVYloHVCEAKwzu
	jwLmkkIWiCdneBB/OyYsJ3kgoMS/+DLPhGfOaAizuQpF22tTXCQ0Y4HIBXGbKM/f/aKRH8Jzu8V
	pQxV7mfDbSnzKVOQK7std3EinAEtjoUtyas5mAUsZKVYVe
X-Google-Smtp-Source: AGHT+IH6+pgLBwSnl6sWAv3xpjSy90jPbSII/bpFkF6vlEVfFOs6RTZCVP2LrSmVpuKdyXbOBieIMm/YV5i+
X-Received: from pgbcx11.prod.google.com ([2002:a05:6a02:220b:b0:7fc:2823:d6c4])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748e:b0:1db:e3f6:55f
 with SMTP id adf61e73a8af0-1e09e420b79mr22740426637.18.1732564338393; Mon, 25
 Nov 2024 11:52:18 -0800 (PST)
Date: Mon, 25 Nov 2024 11:52:01 -0800
In-Reply-To: <20241125195204.2374458-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125195204.2374458-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125195204.2374458-8-jstultz@google.com>
Subject: [RFC][PATCH v14 7/7] sched: Start blocked_on chain processing in find_proxy_task()
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	Valentin Schneider <valentin.schneider@arm.com>, "Connor O'Brien" <connoro@google.com>, 
	John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

Start to flesh out the real find_proxy_task() implementation,
but avoid the migration cases for now, in those cases just
deactivate the donor task and pick again.

To ensure the donor task or other blocked tasks in the chain
aren't migrated away while we're running the proxy, also tweak
the CFS logic to avoid migrating donor or mutex blocked tasks.

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
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-team@android.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: This change was split out from the larger proxy patch]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split this out from larger proxy patch
v7:
* Minor refactoring of core find_proxy_task() function
* Minor spelling and corrections suggested by Metin Kaya
* Dropped an added BUG_ON that was frequently tripped
v8:
* Fix issue if proxy_deactivate fails, we don't leave task
  BO_BLOCKED
* Switch to WARN_ON from BUG_ON checks
v9:
* Improve comments suggested by Metin
* Minor cleanups
v11:
* Previously we checked next==rq->idle && prev==rq->idle, but I
  think we only really care if next==rq->idle from find_proxy_task,
  as we will still want to resched regardless of what prev was.
v12:
* Commit message rework for selected -> donor rewording
v13:
* Address new delayed dequeue condition (deactivate donor for now)
* Next to donor renaming in find_proxy_task
* Improved comments for find_proxy_task
* Rework for proxy_deactivate cleanup
v14:
* Fix build error from __mutex_owner() with CONFIG_PREEMPT_RT
---
 kernel/locking/mutex.h |   3 +-
 kernel/sched/core.c    | 164 ++++++++++++++++++++++++++++++++++-------
 kernel/sched/fair.c    |  10 ++-
 3 files changed, 148 insertions(+), 29 deletions(-)

diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index cbff35b9b7ae3..2e8080a9bee37 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -6,7 +6,7 @@
  *
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  */
-
+#ifndef CONFIG_PREEMPT_RT
 /*
  * This is the control structure for tasks blocked on mutex, which resides
  * on the blocked task's kernel stack:
@@ -70,3 +70,4 @@ extern void debug_mutex_init(struct mutex *lock, const char *name,
 # define debug_mutex_unlock(lock)			do { } while (0)
 # define debug_mutex_init(lock, name, key)		do { } while (0)
 #endif /* !CONFIG_DEBUG_MUTEXES */
+#endif /* CONFIG_PREEMPT_RT */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a18523355fb18..dec9fabb7e105 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -96,6 +96,7 @@
 #include "../workqueue_internal.h"
 #include "../../io_uring/io-wq.h"
 #include "../smpboot.h"
+#include "../locking/mutex.h"
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpu);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ipi_send_cpumask);
@@ -2941,8 +2942,15 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
 	bool stop_pending, complete = false;
 
-	/* Can the task run on the task's current CPU? If so, we're done */
-	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
+	/*
+	 * Can the task run on the task's current CPU? If so, we're done
+	 *
+	 * We are also done if the task is the current donor, boosting a lock-
+	 * holding proxy, (and potentially has been migrated outside its
+	 * current or previous affinity mask)
+	 */
+	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask) ||
+	    (task_current_donor(rq, p) && !task_current(rq, p))) {
 		struct task_struct *push_task = NULL;
 
 		if ((flags & SCA_MIGRATE_ENABLE) &&
@@ -6688,41 +6696,139 @@ static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
 }
 
 /*
- * Initial simple proxy that just returns the task if it's waking
- * or deactivates the blocked task so we can pick something that
- * isn't blocked.
+ * Find runnable lock owner to proxy for mutex blocked donor
+ *
+ * Follow the blocked-on relation:
+ *   task->blocked_on -> mutex->owner -> task...
+ *
+ * Lock order:
+ *
+ *   p->pi_lock
+ *     rq->lock
+ *       mutex->wait_lock
+ *         p->blocked_lock
+ *
+ * Returns the task that is going to be used as execution context (the one
+ * that is actually going to be run on cpu_of(rq)).
  */
 static struct task_struct *
 find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 {
-	struct task_struct *p = donor;
+	struct task_struct *owner = NULL;
+	struct task_struct *ret = NULL;
+	int this_cpu = cpu_of(rq);
+	struct task_struct *p;
 	struct mutex *mutex;
 
-	mutex = p->blocked_on;
-	/* Something changed in the chain, so pick again */
-	if (!mutex)
-		return NULL;
-	/*
-	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
-	 * and ensure @owner sticks around.
-	 */
-	raw_spin_lock(&mutex->wait_lock);
-	raw_spin_lock(&p->blocked_lock);
+	/* Follow blocked_on chain. */
+	for (p = donor; task_is_blocked(p); p = owner) {
+		mutex = p->blocked_on;
+		/* Something changed in the chain, so pick again */
+		if (!mutex)
+			return NULL;
+		/*
+		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
+		 * and ensure @owner sticks around.
+		 */
+		raw_spin_lock(&mutex->wait_lock);
+		raw_spin_lock(&p->blocked_lock);
+
+		/* Check again that p is blocked with blocked_lock held */
+		if (mutex != get_task_blocked_on(p)) {
+			/*
+			 * Something changed in the blocked_on chain and
+			 * we don't know if only at this level. So, let's
+			 * just bail out completely and let __schedule
+			 * figure things out (pick_again loop).
+			 */
+			goto out;
+		}
+
+		owner = __mutex_owner(mutex);
+		if (!owner) {
+			p->blocked_on_state = BO_RUNNABLE;
+			ret = p;
+			goto out;
+		}
+
+		if (task_cpu(owner) != this_cpu) {
+			/* XXX Don't handle migrations yet */
+			if (!proxy_deactivate(rq, donor))
+				goto deactivate_failed;
+			goto out;
+		}
+
+		if (task_on_rq_migrating(owner)) {
+			/*
+			 * One of the chain of mutex owners is currently migrating to this
+			 * CPU, but has not yet been enqueued because we are holding the
+			 * rq lock. As a simple solution, just schedule rq->idle to give
+			 * the migration a chance to complete. Much like the migrate_task
+			 * case we should end up back in find_proxy_task(), this time
+			 * hopefully with all relevant tasks already enqueued.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return proxy_resched_idle(rq);
+		}
+
+		if (!owner->on_rq) {
+			/* XXX Don't handle blocked owners yet */
+			if (!proxy_deactivate(rq, donor))
+				goto deactivate_failed;
+			goto out;
+		}
+
+		if (owner->se.sched_delayed) {
+			/* XXX Don't handle delayed dequeue yet */
+			if (!proxy_deactivate(rq, donor))
+				goto deactivate_failed;
+			goto out;
+		}
+
+		if (owner == p) {
+			/*
+			 * It's possible we interleave with mutex_unlock like:
+			 *
+			 *				lock(&rq->lock);
+			 *				  find_proxy_task()
+			 * mutex_unlock()
+			 *   lock(&wait_lock);
+			 *   donor(owner) = current->blocked_donor;
+			 *   unlock(&wait_lock);
+			 *
+			 *   wake_up_q();
+			 *     ...
+			 *       ttwu_runnable()
+			 *         __task_rq_lock()
+			 *				  lock(&wait_lock);
+			 *				  owner == p
+			 *
+			 * Which leaves us to finish the ttwu_runnable() and make it go.
+			 *
+			 * So schedule rq->idle so that ttwu_runnable can get the rq lock
+			 * and mark owner as running.
+			 */
+			raw_spin_unlock(&p->blocked_lock);
+			raw_spin_unlock(&mutex->wait_lock);
+			return proxy_resched_idle(rq);
+		}
 
-	/* Check again that p is blocked with blocked_lock held */
-	if (!task_is_blocked(p) || mutex != get_task_blocked_on(p)) {
 		/*
-		 * Something changed in the blocked_on chain and
-		 * we don't know if only at this level. So, let's
-		 * just bail out completely and let __schedule
-		 * figure things out (pick_again loop).
+		 * OK, now we're absolutely sure @owner is on this
+		 * rq, therefore holding @rq->lock is sufficient to
+		 * guarantee its existence, as per ttwu_remote().
 		 */
-		goto out;
+		raw_spin_unlock(&p->blocked_lock);
+		raw_spin_unlock(&mutex->wait_lock);
 	}
-	if (!proxy_deactivate(rq, donor))
-		/* XXX: This hack won't work when we get to migrations */
-		donor->blocked_on_state = BO_RUNNABLE;
 
+	WARN_ON_ONCE(owner && !owner->on_rq);
+	return owner;
+
+deactivate_failed:
+	/* XXX: This hack won't work when we get to migrations */
+	donor->blocked_on_state = BO_RUNNABLE;
 out:
 	raw_spin_unlock(&p->blocked_lock);
 	raw_spin_unlock(&mutex->wait_lock);
@@ -6807,6 +6913,7 @@ static void __sched notrace __schedule(int sched_mode)
 	struct rq_flags rf;
 	struct rq *rq;
 	int cpu;
+	bool preserve_need_resched = false;
 
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
@@ -6877,9 +6984,12 @@ static void __sched notrace __schedule(int sched_mode)
 			zap_balance_callbacks(rq);
 			goto pick_again;
 		}
+		if (next == rq->idle)
+			preserve_need_resched = true;
 	}
 picked:
-	clear_tsk_need_resched(prev);
+	if (!preserve_need_resched)
+		clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
 #ifdef CONFIG_SCHED_DEBUG
 	rq->last_seen_need_resched_ns = 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ebde314e151f1..cc126cfcdac06 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9379,6 +9379,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
 	 * 3) running (obviously), or
 	 * 4) are cache-hot on their current CPU.
+	 * 5) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
 	 */
 	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
 		return 0;
@@ -9387,6 +9388,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	if (kthread_is_per_cpu(p))
 		return 0;
 
+	if (task_is_blocked(p))
+		return 0;
+
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
 		int cpu;
 
@@ -9423,7 +9427,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-	if (task_on_cpu(env->src_rq, p)) {
+	if (task_on_cpu(env->src_rq, p) ||
+	    task_current_donor(env->src_rq, p)) {
 		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
@@ -9462,6 +9467,9 @@ static void detach_task(struct task_struct *p, struct lb_env *env)
 {
 	lockdep_assert_rq_held(env->src_rq);
 
+	WARN_ON(task_current(env->src_rq, p));
+	WARN_ON(task_current_donor(env->src_rq, p));
+
 	deactivate_task(env->src_rq, p, DEQUEUE_NOCLOCK);
 	set_task_cpu(p, env->dst_cpu);
 }
-- 
2.47.0.371.ga323438b13-goog



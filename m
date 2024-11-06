Return-Path: <linux-kernel+bounces-397554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFB39BDD58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD5961C20937
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE63618FC8C;
	Wed,  6 Nov 2024 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OdfgTzNv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4837A190054
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861828; cv=none; b=qd4KQ+lbYx6HDUwNNeU58PzpDlIReb+761AW2E2VAP6MTQR+AWvLGKASwySLsttZ5z0mVNRBpj0lds/6pa4+PfBE+3Q7eicpAEKDcSxUuZDs0wBg469pRNeUYvGgU9Am+0MCTp1sEDuqIqiLsvVme8+60G0981JFWv1LZtTDV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861828; c=relaxed/simple;
	bh=rGQtlEpcbH5FcjFwNcQYCFCUyRz3/P8mR0Q7FHjFhZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ek/pJoi0XwTWaDjvB911FkJBVZHAmbP09bM8zRK27f8qYFZ+9SmrS9pxwk7491+7wpLcblG2IZhbHb5X73F6Th5M13v566CY85nx1Cuznvl0fX/BlJLGocLMBQPLo6q87L9HANYgm7jHRuCidNXKB0veEOQj+Bfc50LgZUh0OIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OdfgTzNv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8d6fb2ffso57541667b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730861825; x=1731466625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy8ujYSiTl3GPld1FOnShhk2/fC3GPk4dpw7u9r67Hw=;
        b=OdfgTzNvtitQjxTFEkAVpV86d543FYXrx1bwWDjW0uDpVqSP0YK81KK/SvPYES0Yfn
         25Kw/JBldYyW2JjjkiNEvfgXBTqPfMuqEwAWhfeAo/AtFlE421I9JLBSvoJ5KZ/Ye2Km
         yjwOVKvfS1mUnjY5KqZQizs7yKK3qS+WTNLaHpA9smMeyy4GggrvDsj/4hghsiaoM9Gd
         DPoEun6SpxKT2W4DLPObnRyzMtQSLbNfL6E/4YEp2FQ1Xhsvox3/xqOix6uaW6Y8LiOi
         Hfp2lK932kVZboMegpDjOTw+3YgkXhiYvSuCcViWKwKnN8EVsrIZWyRQZI/YLfGmjgX2
         v1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861825; x=1731466625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy8ujYSiTl3GPld1FOnShhk2/fC3GPk4dpw7u9r67Hw=;
        b=b/MFtys7Qby/V04h+w0GQIJViZUGFGf7JWOn9UvAF0saypNaQ7lt5qtTHHYrziL8uY
         xGnRsMp3irxFFQcbffxWuSnvWRrhC4Uto4aQFJvf5Uq8taaESqRiRSekndxDIAkuA8DK
         agajXnaBa0iJGnOPV0oXqgzNn5G95rs+kRGjYFNFibpNd3UV5ZPMFeWfKWTzMT9FX1US
         E8KmwBizyoS/CA8Pw10CSQAifasP9JeQkGRZ1EbIdp++V0MvkaqeiJ5SzUk2HVcpgxVn
         8jMJfkgWLiaPZJqRSZhqg0Kaw1l0eUYrLJyAxMEpvvqoG4D08ucvVZ2ngUYL2OcUVX+u
         CiYA==
X-Gm-Message-State: AOJu0YylBONT7FDLpwi6qRykkRTAdxsITdReUPkT2xSKJRBsNB42AEFl
	BDagInxEIAVV320EPfrRUB97N4tIKHbLwbKZekc22KocJX8L912o1fjauRf+YlcEaUBz7hkOl7c
	MHLCHB+aIK64OufMa1d5zrejos7wRqqF17u06lNBZiG+IWejnh6b9hqjjm/szgbrDH/L9rX8sCy
	+S4UzwczST/YSn/yEkkxAUet7Tbq5D4MTPxtW8t6ZW3vV8
X-Google-Smtp-Source: AGHT+IHvHSAbDQygaFhNCAVzyvsYcPMRaSN8WnKN79uFGaPTu4FMD3xyJWMtxa3W1WII9y47gFXE4LdzTunU
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:650a:b0:6ea:384f:bd85 with SMTP
 id 00721157ae682-6ea384fd4bemr6325827b3.6.1730861825109; Tue, 05 Nov 2024
 18:57:05 -0800 (PST)
Date: Tue,  5 Nov 2024 18:56:42 -0800
In-Reply-To: <20241106025656.2326794-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106025656.2326794-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106025656.2326794-3-jstultz@google.com>
Subject: [RFC][PATCH v13 2/7] locking/mutex: Rework task_struct::blocked_on
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
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

Track the blocked-on relation for mutexes, to allow following this
relation at schedule time.

   task
     | blocked-on
     v
   mutex
     | owner
     v
   task

Also add a blocked_on_state value so we can distinguish when a
task is blocked_on a mutex, but is either blocked, waking up, or
runnable (such that it can try to acquire the lock its blocked
on).

This avoids some of the subtle & racy games where the blocked_on
state gets cleared, only to have it re-added by the
mutex_lock_slowpath call when it tries to acquire the lock on
wakeup

Also add blocked_lock to the task_struct so we can safely
serialize the blocked-on state.

Finally add wrappers that are useful to provide correctness
checks. Folded in from a patch by:
  Valentin Schneider <valentin.schneider@arm.com>

This all will be used for tracking blocked-task/mutex chains
with the prox-execution patch in a similar fashion to how
priority inheritance is done with rt_mutexes.

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
[minor changes while rebasing]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Fix blocked_on tracking in __mutex_lock_common in error paths]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Fixed blocked_on tracking in error paths that was causing crashes
v4:
* Ensure we clear blocked_on when waking ww_mutexes to die or wound.
  This is critical so we don't get circular blocked_on relationships
  that can't be resolved.
v5:
* Fix potential bug where the skip_wait path might clear blocked_on
  when that path never set it
* Slight tweaks to where we set blocked_on to make it consistent,
  along with extra WARN_ON correctness checking
* Minor comment changes
v7:
* Minor commit message change suggested by Metin Kaya
* Fix WARN_ON conditionals in unlock path (as blocked_on might already
  be cleared), found while looking at issue Metin Kaya raised.
* Minor tweaks to be consistent in what we do under the
  blocked_on lock, also tweaked variable name to avoid confusion
  with label, and comment typos, as suggested by Metin Kaya
* Minor tweak for CONFIG_SCHED_PROXY_EXEC name change
* Moved unused block of code to later in the series, as suggested
  by Metin Kaya
* Switch to a tri-state to be able to distinguish from waking and
  runnable so we can later safely do return migration from ttwu
* Folded together with related blocked_on changes
v8:
* Fix issue leaving task BO_BLOCKED when calling into optimistic
  spinning path.
* Include helper to better handle BO_BLOCKED->BO_WAKING transitions
v9:
* Typo fixup pointed out by Metin
* Cleanup BO_WAKING->BO_RUNNABLE transitions for the !proxy case
* Many cleanups and simplifications suggested by Metin
v11:
* Whitespace fixup pointed out by Metin
v13:
* Refactor set_blocked_on helpers clean things up a bit
---
 include/linux/sched.h        | 66 ++++++++++++++++++++++++++++++++----
 init/init_task.c             |  1 +
 kernel/fork.c                |  4 +--
 kernel/locking/mutex-debug.c |  9 ++---
 kernel/locking/mutex.c       | 40 ++++++++++++++++++----
 kernel/locking/ww_mutex.h    | 24 +++++++++++--
 kernel/sched/core.c          |  1 +
 7 files changed, 125 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2a47228a4808..abe23791de30 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/sched/prio.h>
 #include <linux/sched/types.h>
 #include <linux/signal_types.h>
+#include <linux/spinlock.h>
 #include <linux/syscall_user_dispatch_types.h>
 #include <linux/mm_types_task.h>
 #include <linux/netdevice_xmit.h>
@@ -775,6 +776,12 @@ struct kmap_ctrl {
 #endif
 };
 
+enum blocked_on_state {
+	BO_RUNNABLE,
+	BO_BLOCKED,
+	BO_WAKING,
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1195,10 +1202,9 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
-	/* Mutex deadlock detection: */
-	struct mutex_waiter		*blocked_on;
-#endif
+	enum blocked_on_state		blocked_on_state;
+	struct mutex			*blocked_on;	/* lock we're blocked on */
+	raw_spinlock_t			blocked_lock;
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	int				non_block_count;
@@ -2116,6 +2122,56 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
+static inline void __set_blocked_on_runnable(struct task_struct *p)
+{
+	lockdep_assert_held(&p->blocked_lock);
+
+	if (p->blocked_on_state == BO_WAKING)
+		p->blocked_on_state = BO_RUNNABLE;
+}
+
+static inline void set_blocked_on_runnable(struct task_struct *p)
+{
+	unsigned long flags;
+
+	if (!sched_proxy_exec())
+		return;
+
+	raw_spin_lock_irqsave(&p->blocked_lock, flags);
+	__set_blocked_on_runnable(p);
+	raw_spin_unlock_irqrestore(&p->blocked_lock, flags);
+}
+
+static inline void set_blocked_on_waking(struct task_struct *p)
+{
+	lockdep_assert_held(&p->blocked_lock);
+
+	if (p->blocked_on_state == BO_BLOCKED)
+		p->blocked_on_state = BO_WAKING;
+}
+
+static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	lockdep_assert_held(&p->blocked_lock);
+
+	/*
+	 * Check we are clearing values to NULL or setting NULL
+	 * to values to ensure we don't overwrite existing mutex
+	 * values or clear already cleared values
+	 */
+	WARN_ON((!m && !p->blocked_on) || (m && p->blocked_on));
+
+	p->blocked_on = m;
+	p->blocked_on_state = m ? BO_BLOCKED : BO_RUNNABLE;
+}
+
+static inline struct mutex *get_task_blocked_on(struct task_struct *p)
+{
+	lockdep_assert_held(&p->blocked_lock);
+
+	return p->blocked_on;
+}
+
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
@@ -2155,8 +2211,6 @@ extern bool sched_task_on_rq(struct task_struct *p);
 extern unsigned long get_wchan(struct task_struct *p);
 extern struct task_struct *cpu_curr_snapshot(int cpu);
 
-#include <linux/spinlock.h>
-
 /*
  * In order to reduce various lock holder preemption latencies provide an
  * interface to see if a vCPU is currently running or not.
diff --git a/init/init_task.c b/init/init_task.c
index 136a8231355a..c2da9cce36bd 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -139,6 +139,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.journal_info	= NULL,
 	INIT_CPU_TIMERS(init_task)
 	.pi_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.pi_lock),
+	.blocked_lock	= __RAW_SPIN_LOCK_UNLOCKED(init_task.blocked_lock),
 	.timer_slack_ns = 50000, /* 50 usec default slack */
 	.thread_pid	= &init_struct_pid,
 	.thread_node	= LIST_HEAD_INIT(init_signals.thread_head),
diff --git a/kernel/fork.c b/kernel/fork.c
index 7d950e93f080..99ebc8269140 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2229,6 +2229,7 @@ __latent_entropy struct task_struct *copy_process(
 	ftrace_graph_init_task(p);
 
 	rt_mutex_init_task(p);
+	raw_spin_lock_init(&p->blocked_lock);
 
 	lockdep_assert_irqs_enabled();
 #ifdef CONFIG_PROVE_LOCKING
@@ -2326,9 +2327,8 @@ __latent_entropy struct task_struct *copy_process(
 	lockdep_init_task(p);
 #endif
 
-#ifdef CONFIG_DEBUG_MUTEXES
+	p->blocked_on_state = BO_RUNNABLE;
 	p->blocked_on = NULL; /* not blocked yet */
-#endif
 #ifdef CONFIG_BCACHE
 	p->sequential_io	= 0;
 	p->sequential_io_avg	= 0;
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 6e6f6071cfa2..1d8cff71f65e 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -53,17 +53,18 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 {
 	lockdep_assert_held(&lock->wait_lock);
 
-	/* Mark the current thread as blocked on the lock: */
-	task->blocked_on = waiter;
+	/* Current thread can't be already blocked (since it's executing!) */
+	DEBUG_LOCKS_WARN_ON(get_task_blocked_on(task));
 }
 
 void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
+	struct mutex *blocked_on = get_task_blocked_on(task);
+
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
-	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
-	task->blocked_on = NULL;
+	DEBUG_LOCKS_WARN_ON(blocked_on && blocked_on != lock);
 
 	INIT_LIST_HEAD(&waiter->list);
 	waiter->task = NULL;
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 3302e52f0c96..8f5d3fe6c102 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -597,6 +597,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	raw_spin_lock(&current->blocked_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -627,6 +628,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
+	set_task_blocked_on(current, lock);
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -639,7 +641,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		 * the handoff.
 		 */
 		if (__mutex_trylock(lock))
-			goto acquired;
+			break; /* acquired */;
 
 		/*
 		 * Check for signals and kill conditions while holding
@@ -657,6 +659,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 				goto err;
 		}
 
+		raw_spin_unlock(&current->blocked_lock);
 		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 		/* Make sure we do wakeups before calling schedule */
 		wake_up_q(&wake_q);
@@ -666,6 +669,13 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 		first = __mutex_waiter_is_first(lock, &waiter);
 
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+		raw_spin_lock(&current->blocked_lock);
+
+		/*
+		 * Re-set blocked_on_state as unlock path set it to WAKING/RUNNABLE
+		 */
+		current->blocked_on_state = BO_BLOCKED;
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -676,16 +686,26 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			break;
 
 		if (first) {
+			bool opt_acquired;
+
+			/*
+			 * mutex_optimistic_spin() can schedule, so  we need to
+			 * release these locks before calling it.
+			 */
+			current->blocked_on_state = BO_RUNNABLE;
+			raw_spin_unlock(&current->blocked_lock);
+			raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
-			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
+			opt_acquired = mutex_optimistic_spin(lock, ww_ctx, &waiter);
+			raw_spin_lock_irqsave(&lock->wait_lock, flags);
+			raw_spin_lock(&current->blocked_lock);
+			current->blocked_on_state = BO_BLOCKED;
+			if (opt_acquired)
 				break;
 			trace_contention_begin(lock, LCB_F_MUTEX);
 		}
-
-		raw_spin_lock_irqsave(&lock->wait_lock, flags);
 	}
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-acquired:
+	set_task_blocked_on(current, NULL);
 	__set_current_state(TASK_RUNNING);
 
 	if (ww_ctx) {
@@ -710,16 +730,20 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;
 
 err:
+	set_task_blocked_on(current, NULL);
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
+	WARN_ON(get_task_blocked_on(current));
 	trace_contention_end(lock, ret);
+	raw_spin_unlock(&current->blocked_lock);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
@@ -928,8 +952,12 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 
 		next = waiter->task;
 
+		raw_spin_lock(&next->blocked_lock);
 		debug_mutex_wake_waiter(lock, waiter);
+		WARN_ON(get_task_blocked_on(next) != lock);
+		set_blocked_on_waking(next);
 		wake_q_add(&wake_q, next);
+		raw_spin_unlock(&next->blocked_lock);
 	}
 
 	if (owner & MUTEX_FLAG_HANDOFF)
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 37f025a096c9..d1bec62c6ef0 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -281,10 +281,21 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		return false;
 
 	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
+		/* nested as we should hold current->blocked_lock already */
+		raw_spin_lock_nested(&waiter->task->blocked_lock, SINGLE_DEPTH_NESTING);
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
+		/*
+		 * When waking up the task to die, be sure to set the
+		 * blocked_on_state to WAKING. Otherwise we can see
+		 * circular blocked_on relationships that can't
+		 * resolve.
+		 */
+		WARN_ON(get_task_blocked_on(waiter->task) != lock);
+		set_blocked_on_waking(waiter->task);
 		wake_q_add(wake_q, waiter->task);
+		raw_spin_unlock(&waiter->task->blocked_lock);
 	}
 
 	return true;
@@ -331,9 +342,18 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * it's wounded in __ww_mutex_check_kill() or has a
 		 * wakeup pending to re-read the wounded state.
 		 */
-		if (owner != current)
+		if (owner != current) {
+			/* nested as we should hold current->blocked_lock already */
+			raw_spin_lock_nested(&owner->blocked_lock, SINGLE_DEPTH_NESTING);
+			/*
+			 * When waking up the task to wound, be sure to set the
+			 * blocked_on_state flag. Otherwise we can see circular
+			 * blocked_on relationships that can't resolve.
+			 */
+			set_blocked_on_waking(owner);
 			wake_q_add(wake_q, owner);
-
+			raw_spin_unlock(&owner->blocked_lock);
+		}
 		return true;
 	}
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 731ebd8614a9..f040feed9df3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4309,6 +4309,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		ttwu_queue(p, cpu, wake_flags);
 	}
 out:
+	set_blocked_on_runnable(p);
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
 
-- 
2.47.0.199.ga7371fff76-goog



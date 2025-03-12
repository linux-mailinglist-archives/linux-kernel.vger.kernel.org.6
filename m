Return-Path: <linux-kernel+bounces-558524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A22A5E70C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29AD617AFDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB421E2823;
	Wed, 12 Mar 2025 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AI1bS0Cf"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B6C1EFFA2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817532; cv=none; b=HUgI3NwKfzG48GVnqr/4oG0YLzhsNHvmRRV9Uy+RYyzGue80LrynqLyD0lrJRGVNque+yleGuN+1ejuCc3bzIoogwnNPo1Ae5gKV17Gg4dvTtxxYFtUpKu5+pG9Ma2qKPxdv9m2MVeaQxjW7+9hjVlZnOI34QK1tkrbtt/0hIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817532; c=relaxed/simple;
	bh=wQ4q9BLz+/Ygh0iE1my+UV+H0RQphJCoS7PHCglxKOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eeD0UTWOuQjXBWAUlU6y0Clat1AzB2eq43DDKScbLdHU0/+1vCpTo6RAoxr2ATLY777xIznThHs7yFGz2y/Qp9xxPtLYff08sbAIwJXKeuHbrraSZYuMIneAC5Xxd9OcLK1sl7cc1E438NZSfsdQ8YgYF04N6+NqU4sz9g6csR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AI1bS0Cf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2242f3fd213so4953605ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741817529; x=1742422329; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nkT2tLj01VhqJCQPdRpaz0OoBLYfRLMGUJqn28kAih0=;
        b=AI1bS0CfVhUNqIXQOsdGVldi6rTsyC/k7Z0xOKfqqKSTu05gm89AiNYkcuIRyTJOQY
         jH2V35MoPSDamWhDJOqz54qoACBJ7KZLg65yTYR+eC2NN+lOFnHIOQgo9PPGWodSgYmp
         mt8qLdtR6ngEualhNOzdDBRBLVuI3emV/T9a7wU7GRSbRfptpsJ2MMQ2Zq16erxZJVu0
         X4MFyfrtMKxTGvWewk6uSTGGhUabMFsAhpwbvbUUGVNcghJ+h0sBO5k/HZpY2NoBPUhh
         z1LBUZ5rkD69uH/jfLn3r/F4DbIx2j6GGSEhj94tY1vEL6x1LmwuvqySbVcN0IXLPk0b
         mpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817529; x=1742422329;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkT2tLj01VhqJCQPdRpaz0OoBLYfRLMGUJqn28kAih0=;
        b=vujntzeH2B/7Qntjh5uQfroddS4oz4DW4XkcEB59beytqz1R7mfjKBh9YbGgCc/6vK
         p8RnQi0CKYXzH14Jw8V+HeSVPdxe30/pYxHn57W8o2cAKIQO+VAgf8RcUyuWAgDmlE6g
         JqWox8ZSQwPHEGfxSzi8wfix8p1hSdBJNplinehCRKpq+sfPx+82Tu5fCIdlk1D3cp2X
         /bCKuwms8NYXfH+jitE8b7uA6gf3zUY1JokJsNawfpi0wc6O6cKGeqH2BNGOUcdDG2re
         z6vpnJAwrMYCIKB0K3CEILIfrZzDqiHGOma65LwFYsaVLTXMSOJPUxJRSQxjzrP2bAma
         rTKw==
X-Gm-Message-State: AOJu0YzhcU58WpfG2KWevE+eTUJPX3tBFtHRN+PT8H0hPQeKXKpOykaV
	KDpPpigKZG7vTllMXFZ1yoPtTEnZv0RBnTotpKX2BTghWraCIjfCiAdMccm3Ol7djrKQCvhlJoM
	Ir+pd+xCpO0ALh4qh7pU4QGLsdoPs0rjkQ/txNeVsgITK5XbJpLxfXLW166gb8b1WD/fHGjZiWQ
	OHxz+24xjWpY6ZP7RXKaSRuGLJNz4UcdqP7HzmyWG6hgGn
X-Google-Smtp-Source: AGHT+IFRwX9wtAAWoDGVE22lmgc1vBQwRmfmbC3N7VTkxvBj02OdDXnkum50eVo1YcbuSjZ4qMldNVtv4lkh
X-Received: from pllx8.prod.google.com ([2002:a17:902:7c08:b0:220:ea57:34e3])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2405:b0:224:93e:b5d7
 with SMTP id d9443c01a7336-22428c0579bmr361718175ad.34.1741817528883; Wed, 12
 Mar 2025 15:12:08 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:11:33 -0700
In-Reply-To: <20250312221147.1865364-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312221147.1865364-4-jstultz@google.com>
Subject: [RFC PATCH v15 3/7] locking/mutex: Add p->blocked_on wrappers for
 correctness checks
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com, 
	"Connor O'Brien" <connoro@google.com>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Valentin Schneider <valentin.schneider@arm.com>

This lets us assert mutex::wait_lock is held whenever we access
p->blocked_on, as well as warn us for unexpected state changes.

Cc: Joel Fernandes <joelagnelf@nvidia.com>
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
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kernel-team@android.com
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
[fix conflicts, call in more places]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: tweaked commit subject, reworked a good bit]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Added get_task_blocked_on() accessor
v4:
* Address READ_ONCE usage that was dropped in v2
* Reordered to be a later add on to the main patch series as
  Peter was unhappy with similar wrappers in other patches.
v5:
* Added some extra correctness checking in wrappers
v7:
* Tweaks to reorder this change in the patch series
* Minor cleanup to set_task_blocked_on() suggested by Metin Kaya
v15:
* Split out into its own patch again.
* Further improve assumption checks in helpers.
---
 include/linux/sched.h        | 44 ++++++++++++++++++++++++++++++++++--
 kernel/locking/mutex-debug.c |  4 ++--
 kernel/locking/mutex.c       | 20 +++++-----------
 kernel/locking/ww_mutex.h    |  6 ++---
 4 files changed, 52 insertions(+), 22 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 03775c44b7073..62870077379a6 100644
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
@@ -2154,6 +2155,47 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
+static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	WARN_ON_ONCE(!m);
+	/* The task should only be setting itself as blocked */
+	WARN_ON_ONCE(p != current);
+	/* Currently we serialize blocked_on under the mutex::wait_lock */
+	lockdep_assert_held_once(&m->wait_lock);
+	/*
+	 * Check ensure we don't overwrite exisiting mutex value
+	 * with a different mutex. Note, setting it to the same
+	 * lock repeatedly is ok.
+	 */
+	WARN_ON_ONCE(p->blocked_on && p->blocked_on != m);
+	p->blocked_on = m;
+}
+
+static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	guard(raw_spinlock_irqsave)(&m->wait_lock);
+	__set_task_blocked_on(p, m);
+}
+
+static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	WARN_ON_ONCE(!m);
+	/* Currently we serialize blocked_on under the mutex::wait_lock */
+	lockdep_assert_held_once(&m->wait_lock);
+	/*
+	 * There may be cases where we re-clear already cleared
+	 * blocked_on relationships, but make sure we are not
+	 * clearing the relationship with a different lock.
+	 */
+	WARN_ON_ONCE(m && p->blocked_on && p->blocked_on != m);
+	p->blocked_on = NULL;
+}
+
+static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
+{
+	return READ_ONCE(p->blocked_on);
+}
+
 static __always_inline bool need_resched(void)
 {
 	return unlikely(tif_need_resched());
@@ -2193,8 +2235,6 @@ extern bool sched_task_on_rq(struct task_struct *p);
 extern unsigned long get_wchan(struct task_struct *p);
 extern struct task_struct *cpu_curr_snapshot(int cpu);
 
-#include <linux/spinlock.h>
-
 /*
  * In order to reduce various lock holder preemption latencies provide an
  * interface to see if a vCPU is currently running or not.
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 758b7a6792b0c..949103fd8e9b5 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -54,13 +54,13 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	lockdep_assert_held(&lock->wait_lock);
 
 	/* Current thread can't be already blocked (since it's executing!) */
-	DEBUG_LOCKS_WARN_ON(task->blocked_on);
+	DEBUG_LOCKS_WARN_ON(__get_task_blocked_on(task));
 }
 
 void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
-	struct mutex *blocked_on = READ_ONCE(task->blocked_on);
+	struct mutex *blocked_on = __get_task_blocked_on(task);
 
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
 	DEBUG_LOCKS_WARN_ON(waiter->task != task);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 37d1966970617..351500cf50ece 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -627,8 +627,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 			goto err_early_kill;
 	}
 
-	WARN_ON(current->blocked_on);
-	current->blocked_on = lock;
+	__set_task_blocked_on(current, lock);
 	set_current_state(state);
 	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
@@ -670,7 +669,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		 * that has cleared our blocked_on state, re-set
 		 * it to the lock we are trying to aquire.
 		 */
-		current->blocked_on = lock;
+		set_task_blocked_on(current, lock);
 		set_current_state(state);
 		/*
 		 * Here we order against unlock; we must either see it change
@@ -691,7 +690,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	}
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
 acquired:
-	current->blocked_on = NULL;
+	__clear_task_blocked_on(current, lock);
 	__set_current_state(TASK_RUNNING);
 
 	if (ww_ctx) {
@@ -721,11 +720,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	return 0;
 
 err:
-	current->blocked_on = NULL;
+	__clear_task_blocked_on(current, lock);
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-	WARN_ON(current->blocked_on);
+	WARN_ON(__get_task_blocked_on(current));
 	trace_contention_end(lock, ret);
 	raw_spin_unlock_irqrestore_wake(&lock->wait_lock, flags, &wake_q);
 	debug_mutex_free_waiter(&waiter);
@@ -935,14 +934,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 		next = waiter->task;
 
 		debug_mutex_wake_waiter(lock, waiter);
-		/*
-		 * Unlock wakeups can be happening in parallel
-		 * (when optimistic spinners steal and release
-		 * the lock), so blocked_on may already be
-		 * cleared here.
-		 */
-		WARN_ON(next->blocked_on && next->blocked_on != lock);
-		next->blocked_on = NULL;
+		__clear_task_blocked_on(next, lock);
 		wake_q_add(&wake_q, next);
 	}
 
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 00db40946328e..086fd5487ca77 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -289,9 +289,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		 * blocked_on pointer. Otherwise we can see circular
 		 * blocked_on relationships that can't resolve.
 		 */
-		WARN_ON(waiter->task->blocked_on &&
-			waiter->task->blocked_on != lock);
-		waiter->task->blocked_on = NULL;
+		__clear_task_blocked_on(waiter->task, lock);
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -345,7 +343,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 * blocked_on pointer. Otherwise we can see circular
 			 * blocked_on relationships that can't resolve.
 			 */
-			owner->blocked_on = NULL;
+			__clear_task_blocked_on(owner, lock);
 			wake_q_add(wake_q, owner);
 		}
 		return true;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog



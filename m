Return-Path: <linux-kernel+bounces-246633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B4C92C491
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985A81C20CEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01201B86EA;
	Tue,  9 Jul 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yEED3fkF"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2471509A5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 20:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557150; cv=none; b=C58THBz1OO87Ac7KMWq0f3h5OB/ifFYEj77L2cGnz5SIuq50nfZyElwzDgyY01Eyx06TP3Sp3IUXIyk4wsvEgSLJDR9pS+Sntjjtp8ayUKTDuKh9DnMlxPfeQAnC3+Q/W+LPJYmMGW4RBJNRdDBYMIiGXVT2j65OZY1i3bI3w/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557150; c=relaxed/simple;
	bh=q8Ix9JjcyY9SL/viaL1qjWfW1Dg1Z1BI9AMBEYWy8rk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YP4ET1Lw8aJspYhO9wqXmDGm6NAIYGcjlgISpKmAigjREkNx+N5sgvFqhBkPE4EDvaXxJF9jXmB+Cv4dCth6gsQe6hdKOoN/Sc+uz0YEo4zuv04QkDTOhBlyGcLg8ddpXdSlxgLaHqI0ihOgBkQaYTdlngJr50qUo3om0ebF1Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yEED3fkF; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70af6961edfso3823302b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 13:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720557148; x=1721161948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VifKCQ8gzzjROGV0IDOcCIlHaH0M28p7NLw7oCj8lNA=;
        b=yEED3fkF6hOuUgBYLhWqZsaLr413+J4mVxGn/7alegwPvAFdqDlPE4sbutIMvU6iDG
         xRrzLfN6zDwqADwQP6LxiWi191KkdsGKS++KgfEadS+hHCxIB9ERZ7LeHix5FukRN6FH
         rUBtAoczNyoegwK4dC1wBwUXtOq/QYdRJN7aV4HPo3+FFnog6Iwn8sHD64UDtCxmvVKw
         JwT1weZXy2+cqTHIFzcZFesk+5uQpiM4DUKkWbAWsXiYpGwuNv9gkYOhEAdkzHhfGzSE
         ev/94ZI6buvGcZXRjVAUxE3IS7IaU1e5aBY35EEX4zZvKrP2dLrw1NUrPAuDS2V7ylvj
         8tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720557148; x=1721161948;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VifKCQ8gzzjROGV0IDOcCIlHaH0M28p7NLw7oCj8lNA=;
        b=HINUETgqzbTpfFlTfvMSQ04Mu1gCKOOx7YXrPwUauXUnkSrF8ZefIVvsC+9Pb3/G0z
         muRgDG/36SJNZURm4TE6UPG3FOTmd3DIl1qrgWylHXBcSurI7kvk6NcJY2WB561dZ1cv
         DxFI0LoUE1JYz4yaFhhuF/kXkk/fjqO16yf+Bv4Z2umkup4lQpAHfrqDNMfucM8nssh3
         vV744ksqYg7tnZml/eDzHQQRnryakc7Ev9gUDwtLZ+2H8bN5DEfIPJk3LF17gr9cuPMX
         +BoNImRxfIFeFKk3NEK9rP7nM9qduzBTFQF5L3ttoFt8fiXtUmj6gnKUaXy/I1VclW6F
         3IuA==
X-Gm-Message-State: AOJu0YxjWPWDkHch51MtuJpJ7evTUDrBB7w2IF2pahPYP8XwDgrIg+xe
	HDNaxAEDzOALd47v+msAOwwXZJM6fLLSc5fBk5a1tg+aB47jSd0CGwsWgflsbHNNUvi3C7At8Qk
	RJ6s7QK7dGhA7uj3ML+h7QpZugbsno+5/4VGchxzBR6CweNo33/K95X8Z8EldXNw0a//nX8c/0W
	kFX3im4sGWj8aI/Ujw8iaM5IcqQbScOpXblp7ZHRnc3CpF
X-Google-Smtp-Source: AGHT+IEIzKQflnwFEK3K64qo1nTbbiDqUlbliJiC7D862cuEovbFwy0nKfpYSApan4u2dzu8ITu+B77e1RnY
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:aa7:9a5c:0:b0:706:2a35:66e2 with SMTP id
 d2e1a72fcca58-70b4369b573mr53994b3a.5.1720557145751; Tue, 09 Jul 2024
 13:32:25 -0700 (PDT)
Date: Tue,  9 Jul 2024 13:31:44 -0700
In-Reply-To: <20240709203213.799070-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709203213.799070-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240709203213.799070-2-jstultz@google.com>
Subject: [PATCH v11 1/7] locking/mutex: Remove wakeups from under mutex::wait_lock
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
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com, 
	John Stultz <jstultz@google.com>, Metin Kaya <metin.kaya@arm.com>, 
	Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

In preparation to nest mutex::wait_lock under rq::lock we need to remove
wakeups from under it.

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
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel-team@android.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[Heavily changed after 55f036ca7e74 ("locking: WW mutex cleanup") and
08295b3b5bee ("locking: Implement an algorithm choice for Wound-Wait
mutexes")]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[jstultz: rebased to mainline, added extra wake_up_q & init
 to avoid hangs, similar to Connor's rework of this patch]
Signed-off-by: John Stultz <jstultz@google.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
---
v5:
* Reverted back to an earlier version of this patch to undo
  the change that kept the wake_q in the ctx structure, as
  that broke the rule that the wake_q must always be on the
  stack, as its not safe for concurrency.
v6:
* Made tweaks suggested by Waiman Long
v7:
* Fixups to pass wake_qs down for PREEMPT_RT logic
v10:
* Switched preempt_enable to be lower close to the unlock as
  suggested by Valentin
* Added additional preempt_disable coverage around the wake_q
  calls as again noted by Valentin
---
 kernel/locking/mutex.c       | 17 +++++++++++++----
 kernel/locking/rtmutex.c     | 30 +++++++++++++++++++++---------
 kernel/locking/rwbase_rt.c   |  8 +++++++-
 kernel/locking/rwsem.c       |  4 ++--
 kernel/locking/spinlock_rt.c |  3 ++-
 kernel/locking/ww_mutex.h    | 29 ++++++++++++++++++-----------
 6 files changed, 63 insertions(+), 28 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cbae8c0b89ab..4269da1f3ef5 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -575,6 +575,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		    struct lockdep_map *nest_lock, unsigned long ip,
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
+	DEFINE_WAKE_Q(wake_q);
 	struct mutex_waiter waiter;
 	struct ww_mutex *ww;
 	int ret;
@@ -625,7 +626,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	 */
 	if (__mutex_trylock(lock)) {
 		if (ww_ctx)
-			__ww_mutex_check_waiters(lock, ww_ctx);
+			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
 
 		goto skip_wait;
 	}
@@ -645,7 +646,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		 * Add in stamp order, waking up waiters that must kill
 		 * themselves.
 		 */
-		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
+		ret = __ww_mutex_add_waiter(&waiter, lock, ww_ctx, &wake_q);
 		if (ret)
 			goto err_early_kill;
 	}
@@ -681,6 +682,11 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		}
 
 		raw_spin_unlock(&lock->wait_lock);
+		/* Make sure we do wakeups before calling schedule */
+		if (!wake_q_empty(&wake_q)) {
+			wake_up_q(&wake_q);
+			wake_q_init(&wake_q);
+		}
 		schedule_preempt_disabled();
 
 		first = __mutex_waiter_is_first(lock, &waiter);
@@ -714,7 +720,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		 */
 		if (!ww_ctx->is_wait_die &&
 		    !__mutex_waiter_is_first(lock, &waiter))
-			__ww_mutex_check_waiters(lock, ww_ctx);
+			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
 	}
 
 	__mutex_remove_waiter(lock, &waiter);
@@ -730,6 +736,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
 	raw_spin_unlock(&lock->wait_lock);
+	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;
 
@@ -741,6 +748,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
+	wake_up_q(&wake_q);
 	preempt_enable();
 	return ret;
 }
@@ -951,9 +959,10 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
 
+	preempt_disable();
 	raw_spin_unlock(&lock->wait_lock);
-
 	wake_up_q(&wake_q);
+	preempt_enable();
 }
 
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 88d08eeb8bc0..7a85d9bfa972 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -34,13 +34,15 @@
 
 static inline int __ww_mutex_add_waiter(struct rt_mutex_waiter *waiter,
 					struct rt_mutex *lock,
-					struct ww_acquire_ctx *ww_ctx)
+					struct ww_acquire_ctx *ww_ctx,
+					struct wake_q_head *wake_q)
 {
 	return 0;
 }
 
 static inline void __ww_mutex_check_waiters(struct rt_mutex *lock,
-					    struct ww_acquire_ctx *ww_ctx)
+					    struct ww_acquire_ctx *ww_ctx,
+					    struct wake_q_head *wake_q)
 {
 }
 
@@ -1207,6 +1209,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	struct rt_mutex_waiter *top_waiter = waiter;
 	struct rt_mutex_base *next_lock;
 	int chain_walk = 0, res;
+	DEFINE_WAKE_Q(wake_q);
 
 	lockdep_assert_held(&lock->wait_lock);
 
@@ -1245,7 +1248,10 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 
 		/* Check whether the waiter should back out immediately */
 		rtm = container_of(lock, struct rt_mutex, rtmutex);
-		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
+		preempt_disable();
+		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, &wake_q);
+		wake_up_q(&wake_q);
+		preempt_enable();
 		if (res) {
 			raw_spin_lock(&task->pi_lock);
 			rt_mutex_dequeue(lock, waiter);
@@ -1678,7 +1684,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 				       struct ww_acquire_ctx *ww_ctx,
 				       unsigned int state,
 				       enum rtmutex_chainwalk chwalk,
-				       struct rt_mutex_waiter *waiter)
+				       struct rt_mutex_waiter *waiter,
+				       struct wake_q_head *wake_q)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
 	struct ww_mutex *ww = ww_container_of(rtm);
@@ -1689,7 +1696,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock, current, NULL)) {
 		if (build_ww_mutex() && ww_ctx) {
-			__ww_mutex_check_waiters(rtm, ww_ctx);
+			__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
 			ww_mutex_lock_acquired(ww, ww_ctx);
 		}
 		return 0;
@@ -1707,7 +1714,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 		/* acquired the lock */
 		if (build_ww_mutex() && ww_ctx) {
 			if (!ww_ctx->is_wait_die)
-				__ww_mutex_check_waiters(rtm, ww_ctx);
+				__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
 			ww_mutex_lock_acquired(ww, ww_ctx);
 		}
 	} else {
@@ -1729,7 +1736,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 					     struct ww_acquire_ctx *ww_ctx,
-					     unsigned int state)
+					     unsigned int state,
+					     struct wake_q_head *wake_q)
 {
 	struct rt_mutex_waiter waiter;
 	int ret;
@@ -1738,7 +1746,7 @@ static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 	waiter.ww_ctx = ww_ctx;
 
 	ret = __rt_mutex_slowlock(lock, ww_ctx, state, RT_MUTEX_MIN_CHAINWALK,
-				  &waiter);
+				  &waiter, wake_q);
 
 	debug_rt_mutex_free_waiter(&waiter);
 	return ret;
@@ -1754,6 +1762,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 				     struct ww_acquire_ctx *ww_ctx,
 				     unsigned int state)
 {
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 	int ret;
 
@@ -1775,8 +1784,11 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 	 * irqsave/restore variants.
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state);
+	ret = __rt_mutex_slowlock_locked(lock, ww_ctx, state, &wake_q);
+	preempt_disable();
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	wake_up_q(&wake_q);
+	preempt_enable();
 	rt_mutex_post_schedule();
 
 	return ret;
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 34a59569db6b..9f4322c07486 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -69,6 +69,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 				      unsigned int state)
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
+	DEFINE_WAKE_Q(wake_q);
 	int ret;
 
 	rwbase_pre_schedule();
@@ -110,7 +111,7 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	 * For rwlocks this returns 0 unconditionally, so the below
 	 * !ret conditionals are optimized out.
 	 */
-	ret = rwbase_rtmutex_slowlock_locked(rtm, state);
+	ret = rwbase_rtmutex_slowlock_locked(rtm, state, &wake_q);
 
 	/*
 	 * On success the rtmutex is held, so there can't be a writer
@@ -121,7 +122,12 @@ static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
 	 */
 	if (!ret)
 		atomic_inc(&rwb->readers);
+
+	preempt_disable();
 	raw_spin_unlock_irq(&rtm->wait_lock);
+	wake_up_q(&wake_q);
+	preempt_enable();
+
 	if (!ret)
 		rwbase_rtmutex_unlock(rtm);
 
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c6d17aee4209..79ab7b8df5c1 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1415,8 +1415,8 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 #define rwbase_rtmutex_lock_state(rtm, state)		\
 	__rt_mutex_lock(rtm, state)
 
-#define rwbase_rtmutex_slowlock_locked(rtm, state)	\
-	__rt_mutex_slowlock_locked(rtm, NULL, state)
+#define rwbase_rtmutex_slowlock_locked(rtm, state, wq)	\
+	__rt_mutex_slowlock_locked(rtm, NULL, state, wq)
 
 #define rwbase_rtmutex_unlock(rtm)			\
 	__rt_mutex_unlock(rtm)
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 38e292454fcc..fb1810a14c9d 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -162,7 +162,8 @@ rwbase_rtmutex_lock_state(struct rt_mutex_base *rtm, unsigned int state)
 }
 
 static __always_inline int
-rwbase_rtmutex_slowlock_locked(struct rt_mutex_base *rtm, unsigned int state)
+rwbase_rtmutex_slowlock_locked(struct rt_mutex_base *rtm, unsigned int state,
+			       struct wake_q_head *wake_q)
 {
 	rtlock_slowlock_locked(rtm);
 	return 0;
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index 3ad2cc4823e5..7189c6631d90 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -275,7 +275,7 @@ __ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
  */
 static bool
 __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
-	       struct ww_acquire_ctx *ww_ctx)
+	       struct ww_acquire_ctx *ww_ctx, struct wake_q_head *wake_q)
 {
 	if (!ww_ctx->is_wait_die)
 		return false;
@@ -284,7 +284,7 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 #ifndef WW_RT
 		debug_mutex_wake_waiter(lock, waiter);
 #endif
-		wake_up_process(waiter->task);
+		wake_q_add(wake_q, waiter->task);
 	}
 
 	return true;
@@ -299,7 +299,8 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
  */
 static bool __ww_mutex_wound(struct MUTEX *lock,
 			     struct ww_acquire_ctx *ww_ctx,
-			     struct ww_acquire_ctx *hold_ctx)
+			     struct ww_acquire_ctx *hold_ctx,
+			     struct wake_q_head *wake_q)
 {
 	struct task_struct *owner = __ww_mutex_owner(lock);
 
@@ -331,7 +332,7 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 		 * wakeup pending to re-read the wounded state.
 		 */
 		if (owner != current)
-			wake_up_process(owner);
+			wake_q_add(wake_q, owner);
 
 		return true;
 	}
@@ -352,7 +353,8 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
  * The current task must not be on the wait list.
  */
 static void
-__ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
+__ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx,
+			 struct wake_q_head *wake_q)
 {
 	struct MUTEX_WAITER *cur;
 
@@ -364,8 +366,8 @@ __ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
 		if (!cur->ww_ctx)
 			continue;
 
-		if (__ww_mutex_die(lock, cur, ww_ctx) ||
-		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
+		if (__ww_mutex_die(lock, cur, ww_ctx, wake_q) ||
+		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx, wake_q))
 			break;
 	}
 }
@@ -377,6 +379,8 @@ __ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
 static __always_inline void
 ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
+	DEFINE_WAKE_Q(wake_q);
+
 	ww_mutex_lock_acquired(lock, ctx);
 
 	/*
@@ -405,8 +409,10 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * die or wound us.
 	 */
 	lock_wait_lock(&lock->base);
-	__ww_mutex_check_waiters(&lock->base, ctx);
+	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
 	unlock_wait_lock(&lock->base);
+
+	wake_up_q(&wake_q);
 }
 
 static __always_inline int
@@ -488,7 +494,8 @@ __ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 static inline int
 __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		      struct MUTEX *lock,
-		      struct ww_acquire_ctx *ww_ctx)
+		      struct ww_acquire_ctx *ww_ctx,
+		      struct wake_q_head *wake_q)
 {
 	struct MUTEX_WAITER *cur, *pos = NULL;
 	bool is_wait_die;
@@ -532,7 +539,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		pos = cur;
 
 		/* Wait-Die: ensure younger waiters die. */
-		__ww_mutex_die(lock, cur, ww_ctx);
+		__ww_mutex_die(lock, cur, ww_ctx, wake_q);
 	}
 
 	__ww_waiter_add(lock, waiter, pos);
@@ -550,7 +557,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		 * such that either we or the fastpath will wound @ww->ctx.
 		 */
 		smp_mb();
-		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx, wake_q);
 	}
 
 	return 0;
-- 
2.45.2.993.g49e7a77208-goog



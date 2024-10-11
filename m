Return-Path: <linux-kernel+bounces-361961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E8B99AF5E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 633EE1F2222A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802881E490B;
	Fri, 11 Oct 2024 23:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="encYlpDW"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C11D1745
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728689141; cv=none; b=LcPAUY3mLvv3T6XOl/TXNH2ZKbU8iB++ecm3ZhL5eF6K3sp3XLZxNXHp5IUSz75MfYdefRftJ/XphyNKnzBmWIhlSQfp4ANEQ3/+i8dO8dJLw19gpSKxV9Zs3bUIKA+PBesguxG5giaTqokp07AdqZJbX7FZDLA345pgP3EZhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728689141; c=relaxed/simple;
	bh=SaolSQrmZugwURUO1/2nE4/Fsqo4U96OCl6zGppw31U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tlPeoBA+mShHr20f2yXWo3sqr1xY5T1ejE4XqKjS78ErdBgm0nXPM5D6it09KmEWjKbaelUQPy7t4ccqhziK16dImibK41R5uu9GZu8u8yjKpiwbnRWBiBLVt7waBMcTseDjnv5Agn/nt/jtU7Py/sxjo3qMacDmqbyio0xGwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=encYlpDW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c8a799e8dso21579025ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728689138; x=1729293938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mci0IDSL2fMyiVnOT4z+dvqIjXvgYiI9foZu788538k=;
        b=encYlpDWsFpJx3qoDCgfM4ElsecQTV2yBcV5vuEon8DYiMhUE+dpeudJzRGTCP4ioV
         4KXQUBOF2LxWgmHVQcGq7H3/hFitUrZ/qP+7s+WVa8LCKQQnGwQaeJiut5wwUqTpY9+F
         q/k+MMJVzKAYTEK68dLS+ewAzNPLaPceX59SMouE8NxbWed4Wq7REM2jUo1p61VmZYVz
         k9imqTCeYq/7uUA0+jmfLuwUBD2D1h+qRHP0mzOnbIr7XuK4465hHveszDFJumecyzR8
         GZqBTH4zn4SdzoEhUO3kJPpc6Z3CynvXFOLafBdAlWn/F1eoYSsXBuehHYmIsQ0dNDKI
         X6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728689138; x=1729293938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mci0IDSL2fMyiVnOT4z+dvqIjXvgYiI9foZu788538k=;
        b=R1hdjFlUjXoC5kzAcoRzz6VYAy+QT0bwHLLEqt7A5jRvb7MMKFdvBvBLND/jVYD3Xh
         WuYYs/wUV9E4Av2LTZWf4ZXQWxY5y3FWL5CvzC15PbqB48wCiSn8UWDC/No91bolaKHe
         zLX4dW37ZR9zplb1+vJXkUR4Y71TDY3e5PMMLn5NTITu2wb+GovVLYUIFB4+KjCtHFUN
         A44CQq3KvUwsxdcC2b9z5Qhcu6dTeDsCujtnxS4T5+jw/xjUvIIqTe3WAY78s7L2DRjL
         aW3Eki/uqdvzV81KPAZzKHbNDZx47nmMA6rsr3Q1kJqFY36yqfOq9sbDcWsuzWSG1BQN
         UfZA==
X-Gm-Message-State: AOJu0YwU5oaaPHg7QazfKVZ8fidRvYJ1fRdxbiy39ZwMunNGdQj+ABaw
	BtMJZpkoB/Y6RbrNv771J6nS07EGMC9KYFUzkR/UUoJQwcsonaRjfoS/4/xGztTXSfl9l5Dios+
	zGsrcdA75k3Go8TqqWF8wrw9LYutgk5gGEXXDZxtFqtJi4igXiP0LQvthD+KMTp00IkAzihgCqr
	lzXIdXLzsJbxk3HuR/lJhnQP95HH0PbrUI6ci9SuSMoS9/
X-Google-Smtp-Source: AGHT+IH0KIrWlkiv+680eJs6Q4IWuUI/NVOaQvwxRUnhc7DYyJs24F3E7Fr9tQVppJeHpZjKPdDgghCF4oDy
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:e845:b0:1fa:2ae7:cc6a with SMTP id
 d9443c01a7336-20ca14625c1mr126855ad.4.1728689137282; Fri, 11 Oct 2024
 16:25:37 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:25:13 -0700
In-Reply-To: <20241011232525.2513424-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011232525.2513424-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011232525.2513424-2-jstultz@google.com>
Subject: [PATCH v13 1/7] locking/mutex: Remove wakeups from under mutex::wait_lock
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
	Metin Kaya <metin.kaya@arm.com>, Davidlohr Bueso <dave@stgolabs.net>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Peter Zijlstra <peterz@infradead.org>

In preparation to nest mutex::wait_lock under rq::lock we need
to remove wakeups from under it.

Do this by utilizing wake_qs to defer the wakeup until after the
lock is dropped.

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
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Metin Kaya <metin.kaya@arm.com>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Metin Kaya <metin.kaya@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[Heavily changed after 55f036ca7e74 ("locking: WW mutex cleanup") and
08295b3b5bee ("locking: Implement an algorithm choice for Wound-Wait
mutexes")]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
[jstultz: rebased to mainline, added extra wake_up_q & init
 to avoid hangs, similar to Connor's rework of this patch]
Signed-off-by: John Stultz <jstultz@google.com>
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
v12:
* Fixes and simplifications from K Prateek Nayak and Peter Zijlstra
* Commit message tweak
---
 kernel/futex/pi.c               |  6 +++-
 kernel/locking/mutex.c          | 16 ++++++++---
 kernel/locking/rtmutex.c        | 49 +++++++++++++++++++++++----------
 kernel/locking/rtmutex_api.c    | 11 ++++++--
 kernel/locking/rtmutex_common.h |  3 +-
 kernel/locking/rwbase_rt.c      |  8 +++++-
 kernel/locking/rwsem.c          |  4 +--
 kernel/locking/spinlock_rt.c    |  3 +-
 kernel/locking/ww_mutex.h       | 30 ++++++++++++--------
 9 files changed, 92 insertions(+), 38 deletions(-)

diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 5722467f2737..d62cca5ed8f4 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -922,6 +922,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	struct rt_mutex_waiter rt_waiter;
 	struct futex_hash_bucket *hb;
 	struct futex_q q = futex_q_init;
+	DEFINE_WAKE_Q(wake_q);
 	int res, ret;
 
 	if (!IS_ENABLED(CONFIG_FUTEX_PI))
@@ -1018,8 +1019,11 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int flags, ktime_t *time, int tryl
 	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
 	 * it sees the futex_q::pi_state.
 	 */
-	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
+	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current, &wake_q);
+	preempt_disable();
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
+	wake_up_q(&wake_q);
+	preempt_enable();
 
 	if (ret) {
 		if (ret == 1)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cbae8c0b89ab..6c94da061ec2 100644
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
@@ -681,6 +682,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		}
 
 		raw_spin_unlock(&lock->wait_lock);
+		/* Make sure we do wakeups before calling schedule */
+		wake_up_q(&wake_q);
+		wake_q_init(&wake_q);
+
 		schedule_preempt_disabled();
 
 		first = __mutex_waiter_is_first(lock, &waiter);
@@ -714,7 +719,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		 */
 		if (!ww_ctx->is_wait_die &&
 		    !__mutex_waiter_is_first(lock, &waiter))
-			__ww_mutex_check_waiters(lock, ww_ctx);
+			__ww_mutex_check_waiters(lock, ww_ctx, &wake_q);
 	}
 
 	__mutex_remove_waiter(lock, &waiter);
@@ -730,6 +735,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
 	raw_spin_unlock(&lock->wait_lock);
+	wake_up_q(&wake_q);
 	preempt_enable();
 	return 0;
 
@@ -741,6 +747,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
+	wake_up_q(&wake_q);
 	preempt_enable();
 	return ret;
 }
@@ -951,9 +958,10 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
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
index ebebd0eec7f6..8ada6567a141 100644
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
 
@@ -1201,7 +1203,8 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 					   struct rt_mutex_waiter *waiter,
 					   struct task_struct *task,
 					   struct ww_acquire_ctx *ww_ctx,
-					   enum rtmutex_chainwalk chwalk)
+					   enum rtmutex_chainwalk chwalk,
+					   struct wake_q_head *wake_q)
 {
 	struct task_struct *owner = rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter = waiter;
@@ -1245,7 +1248,10 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 
 		/* Check whether the waiter should back out immediately */
 		rtm = container_of(lock, struct rt_mutex, rtmutex);
-		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
+		preempt_disable();
+		res = __ww_mutex_add_waiter(waiter, rtm, ww_ctx, wake_q);
+		wake_up_q(wake_q);
+		preempt_enable();
 		if (res) {
 			raw_spin_lock(&task->pi_lock);
 			rt_mutex_dequeue(lock, waiter);
@@ -1679,7 +1685,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 				       struct ww_acquire_ctx *ww_ctx,
 				       unsigned int state,
 				       enum rtmutex_chainwalk chwalk,
-				       struct rt_mutex_waiter *waiter)
+				       struct rt_mutex_waiter *waiter,
+				       struct wake_q_head *wake_q)
 {
 	struct rt_mutex *rtm = container_of(lock, struct rt_mutex, rtmutex);
 	struct ww_mutex *ww = ww_container_of(rtm);
@@ -1690,7 +1697,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock, current, NULL)) {
 		if (build_ww_mutex() && ww_ctx) {
-			__ww_mutex_check_waiters(rtm, ww_ctx);
+			__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
 			ww_mutex_lock_acquired(ww, ww_ctx);
 		}
 		return 0;
@@ -1700,7 +1707,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 	trace_contention_begin(lock, LCB_F_RT);
 
-	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk);
+	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk, wake_q);
 	if (likely(!ret))
 		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
 
@@ -1708,7 +1715,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 		/* acquired the lock */
 		if (build_ww_mutex() && ww_ctx) {
 			if (!ww_ctx->is_wait_die)
-				__ww_mutex_check_waiters(rtm, ww_ctx);
+				__ww_mutex_check_waiters(rtm, ww_ctx, wake_q);
 			ww_mutex_lock_acquired(ww, ww_ctx);
 		}
 	} else {
@@ -1730,7 +1737,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
 
 static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 					     struct ww_acquire_ctx *ww_ctx,
-					     unsigned int state)
+					     unsigned int state,
+					     struct wake_q_head *wake_q)
 {
 	struct rt_mutex_waiter waiter;
 	int ret;
@@ -1739,7 +1747,7 @@ static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
 	waiter.ww_ctx = ww_ctx;
 
 	ret = __rt_mutex_slowlock(lock, ww_ctx, state, RT_MUTEX_MIN_CHAINWALK,
-				  &waiter);
+				  &waiter, wake_q);
 
 	debug_rt_mutex_free_waiter(&waiter);
 	return ret;
@@ -1755,6 +1763,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
 				     struct ww_acquire_ctx *ww_ctx,
 				     unsigned int state)
 {
+	DEFINE_WAKE_Q(wake_q);
 	unsigned long flags;
 	int ret;
 
@@ -1776,8 +1785,11 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
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
@@ -1804,7 +1816,8 @@ static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
  * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
  * @lock:	The underlying RT mutex
  */
-static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
+static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock,
+					   struct wake_q_head *wake_q)
 {
 	struct rt_mutex_waiter waiter;
 	struct task_struct *owner;
@@ -1821,7 +1834,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 
 	trace_contention_begin(lock, LCB_F_RT);
 
-	task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAINWALK);
+	task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAINWALK, wake_q);
 
 	for (;;) {
 		/* Try to acquire the lock again */
@@ -1832,7 +1845,11 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 			owner = rt_mutex_owner(lock);
 		else
 			owner = NULL;
+		preempt_disable();
 		raw_spin_unlock_irq(&lock->wait_lock);
+		wake_up_q(wake_q);
+		wake_q_init(wake_q);
+		preempt_enable();
 
 		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
 			schedule_rtlock();
@@ -1857,10 +1874,14 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
 {
 	unsigned long flags;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	rtlock_slowlock_locked(lock);
+	rtlock_slowlock_locked(lock, &wake_q);
+	preempt_disable();
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+	wake_up_q(&wake_q);
+	preempt_enable();
 }
 
 #endif /* RT_MUTEX_BUILD_SPINLOCKS */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index a6974d044593..747f2da16037 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -291,7 +291,8 @@ void __sched rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
  */
 int __sched __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 					struct rt_mutex_waiter *waiter,
-					struct task_struct *task)
+					struct task_struct *task,
+					struct wake_q_head *wake_q)
 {
 	int ret;
 
@@ -302,7 +303,7 @@ int __sched __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 
 	/* We enforce deadlock detection for futexes */
 	ret = task_blocks_on_rt_mutex(lock, waiter, task, NULL,
-				      RT_MUTEX_FULL_CHAINWALK);
+				      RT_MUTEX_FULL_CHAINWALK, wake_q);
 
 	if (ret && !rt_mutex_owner(lock)) {
 		/*
@@ -341,12 +342,16 @@ int __sched rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				      struct task_struct *task)
 {
 	int ret;
+	DEFINE_WAKE_Q(wake_q);
 
 	raw_spin_lock_irq(&lock->wait_lock);
-	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
+	ret = __rt_mutex_start_proxy_lock(lock, waiter, task, &wake_q);
 	if (unlikely(ret))
 		remove_waiter(lock, waiter);
+	preempt_disable();
 	raw_spin_unlock_irq(&lock->wait_lock);
+	wake_up_q(&wake_q);
+	preempt_enable();
 
 	return ret;
 }
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index 1162e07cdaea..c38a2d2d4a7e 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -83,7 +83,8 @@ extern void rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
 extern void rt_mutex_proxy_unlock(struct rt_mutex_base *lock);
 extern int __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				     struct rt_mutex_waiter *waiter,
-				     struct task_struct *task);
+				     struct task_struct *task,
+				     struct wake_q_head *);
 extern int rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
 				     struct rt_mutex_waiter *waiter,
 				     struct task_struct *task);
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
index 2bbb6eca5144..2ddb827e3bea 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1413,8 +1413,8 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
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
index 76d204b7d29c..a54bd16d0f17 100644
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
@@ -405,8 +409,11 @@ ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 	 * die or wound us.
 	 */
 	lock_wait_lock(&lock->base);
-	__ww_mutex_check_waiters(&lock->base, ctx);
+	__ww_mutex_check_waiters(&lock->base, ctx, &wake_q);
+	preempt_disable();
 	unlock_wait_lock(&lock->base);
+	wake_up_q(&wake_q);
+	preempt_enable();
 }
 
 static __always_inline int
@@ -488,7 +495,8 @@ __ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 static inline int
 __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		      struct MUTEX *lock,
-		      struct ww_acquire_ctx *ww_ctx)
+		      struct ww_acquire_ctx *ww_ctx,
+		      struct wake_q_head *wake_q)
 {
 	struct MUTEX_WAITER *cur, *pos = NULL;
 	bool is_wait_die;
@@ -532,7 +540,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		pos = cur;
 
 		/* Wait-Die: ensure younger waiters die. */
-		__ww_mutex_die(lock, cur, ww_ctx);
+		__ww_mutex_die(lock, cur, ww_ctx, wake_q);
 	}
 
 	__ww_waiter_add(lock, waiter, pos);
@@ -550,7 +558,7 @@ __ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
 		 * such that either we or the fastpath will wound @ww->ctx.
 		 */
 		smp_mb();
-		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx, wake_q);
 	}
 
 	return 0;
-- 
2.47.0.rc1.288.g06298d1525-goog



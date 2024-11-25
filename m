Return-Path: <linux-kernel+bounces-421579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A029D8D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A52C16AF8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274801CD21C;
	Mon, 25 Nov 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCRUCbts"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B881CB528
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564338; cv=none; b=PRbsvz6gWbk3SIT1l3Zjmb96za9qiDwCUsDpIA5ttN8ILLeMX1ojxdPCVdZGFS5LsL9zuPRxOdDCMbv2KU9RynwFZ41me/g1ve+2cWtHlxXLl+aax8qn5nkq3bLOhB+HRMj/mEXm9Hohch1gg4eY4StiU2oGlXE9GivO6Ncv2MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564338; c=relaxed/simple;
	bh=NNU4b6vYWC+pp13z/kreFmWIrgI60yMuB6wPhJjCZxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k8sqP+KZ7myfJ8toyTDBIP5rCBN93oZAkNqoAp9qS52Dfem+FidzPu7iruSURB2tgWNwonMqrwM+J0zwLWvI7UaER8GF5dzWbhQB/FMO4OVw0VbC/aa3c6mXbvPtQNPm5kALAnbahFcENAEnOjzlwSt+4dG4n7SZOfzdsyoomfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCRUCbts; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ea21082c99so5045792a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732564335; x=1733169135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLnULeoJXWgPfRnVPCmnhWhkq15uv2wq1pCAMSH3YsQ=;
        b=QCRUCbtsYpM6xR+MvOFChiCWn65LrAKInX9INXpISVWVD5PX+wMll4oBM/PXNU4gEF
         LlvRyNiBhpFuxrMiOlgARVSQmI7rO84oLi9zdW65U521dI62ddlYpe7Cm6kDHg84PI+6
         H5ij9yqLNdDy+Mq3mNNNx6GNd7OwIm+w2uZbAPnLJkCh7mTaXKZzdXkq4VPlDwHNuC17
         0yrN+s6xiNnZSaIxMdGOzkk+cUFYSEWNv1Z9P/MXoWBe1qlln6kpGA4rfrXLWLTVvALG
         wbbPzeHC7cceEU7Zrw6v4PCrdFF5jxnddYT7Zkwu0tUPkqA0gdfeXm28ycvI5/ax6JL+
         TWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564335; x=1733169135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLnULeoJXWgPfRnVPCmnhWhkq15uv2wq1pCAMSH3YsQ=;
        b=W3hkBUqbx32HCaXvWMnvIzX7l/wozj/ttz/cLWZhsmfczyuCvxIl8sei/qHvwOZW65
         NmEhMWpMt0Wuedgn/JVXry6g48CLERmo8sPojxHqcOaQ/EUGzV0ObEO0pL0Z0kBoH/gi
         v9M3EPG7JAe37JlSgZgG9gZGurpqK/Fbs81ngnvTalLbNanOrkOdUsH3kZyvnu3TlVMv
         yeoQlgehTjfc+ssqaOuWdoCXo1325uyeGk9LGCTYY7IebexszfEIzUZgLIImZpGO7ozb
         hznuesaw8kT6Zknu2+2jj9Fx1B7ASXIcp3JEUseIAHXGnhlvL3LwOv6eJf21ai/uNTVA
         sy0w==
X-Gm-Message-State: AOJu0YzJcs0kDv2EWYsRP+PmC63EKoQwMdamA+YYl6C6NGePLLYjRQsx
	rbBaPkTaAX3EnBGxdFJ4ne5ONch0nbXKOw+CKAs2OJaD5unvdpGSuvAotc90UtDuuBFr0RQW0cu
	gI9OIH5g5IpItFJ90+IIiC3CYOXlJ8satYrVW9sDHj8GQu4ehfjfGswhdMTV2p/WKjw1J0ii32D
	d2Dz//G2VItYnELTt8kiO6pv9f+yz9KqZd1XswkImeDQQF
X-Google-Smtp-Source: AGHT+IHEUw2v7KxtCDazuF9zCs2de10S81Xzx2nmKTJ6b9b3qL6s7Gie6aTltVTaUIS65if6ckdOtxuh6p+l
X-Received: from plfz3.prod.google.com ([2002:a17:902:d543:b0:212:4e78:e2b6])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2283:b0:211:f674:9d60
 with SMTP id d9443c01a7336-2129f69e7a1mr181413475ad.50.1732564335366; Mon, 25
 Nov 2024 11:52:15 -0800 (PST)
Date: Mon, 25 Nov 2024 11:51:59 -0800
In-Reply-To: <20241125195204.2374458-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125195204.2374458-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125195204.2374458-6-jstultz@google.com>
Subject: [RFC][PATCH v14 5/7] sched: Add an initial sketch of the
 find_proxy_task() function
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add a find_proxy_task() function which doesn't do much.

When we select a blocked task to run, we will just deactivate it
and pick again. The exception being if it has become unblocked
after find_proxy_task() was called.

Greatly simplified from patch by:
  Peter Zijlstra (Intel) <peterz@infradead.org>
  Juri Lelli <juri.lelli@redhat.com>
  Valentin Schneider <valentin.schneider@arm.com>
  Connor O'Brien <connoro@google.com>

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
[jstultz: Split out from larger proxy patch and simplified
 for review and testing.]
Signed-off-by: John Stultz <jstultz@google.com>
---
v5:
* Split out from larger proxy patch
v7:
* Fixed unused function arguments, spelling nits, and tweaks for
  clarity, pointed out by Metin Kaya
* Fix build warning Reported-by: kernel test robot <lkp@intel.com>
  Closes: https://lore.kernel.org/oe-kbuild-all/202311081028.yDLmCWgr-lkp@intel.com/
v8:
* Fixed case where we might return a blocked task from find_proxy_task()
* Continued tweaks to handle avoiding returning blocked tasks
v9:
* Add zap_balance_callbacks helper to unwind balance_callbacks
  when we will re-call pick_next_task() again.
* Add extra comment suggested by Metin
* Typo fixes from Metin
* Moved adding proxy_resched_idle earlier in the series, as suggested
  by Metin
* Fix to call proxy_resched_idle() *prior* to deactivating next, to avoid
  crashes caused by stale references to next
* s/PROXY/SCHED_PROXY_EXEC/ as suggested by Metin
* Number of tweaks and cleanups suggested by Metin
* Simplify proxy_deactivate as suggested by Metin
v11:
* Tweaks for earlier simplification in try_to_deactivate_task
v13:
* Rename rename "next" to "donor" in find_proxy_task() for clarity
* Similarly use "donor" instead of next in proxy_deactivate
* Refactor/simplify proxy_resched_idle
* Moved up a needed fix from later in the series
---
 kernel/sched/core.c  | 129 ++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/rt.c    |  15 ++++-
 kernel/sched/sched.h |  10 +++-
 3 files changed, 148 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f8714050b6d0d..b492506d33415 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5052,6 +5052,34 @@ static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 	}
 }
 
+/*
+ * Only called from __schedule context
+ *
+ * There are some cases where we are going to re-do the action
+ * that added the balance callbacks. We may not be in a state
+ * where we can run them, so just zap them so they can be
+ * properly re-added on the next time around. This is similar
+ * handling to running the callbacks, except we just don't call
+ * them.
+ */
+static void zap_balance_callbacks(struct rq *rq)
+{
+	struct balance_callback *next, *head;
+	bool found = false;
+
+	lockdep_assert_rq_held(rq);
+
+	head = rq->balance_callback;
+	while (head) {
+		if (head == &balance_push_callback)
+			found = true;
+		next = head->next;
+		head->next = NULL;
+		head = next;
+	}
+	rq->balance_callback = found ? &balance_push_callback : NULL;
+}
+
 static void balance_push(struct rq *rq);
 
 /*
@@ -6592,7 +6620,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Otherwise marks the task's __state as RUNNING
  */
 static bool try_to_block_task(struct rq *rq, struct task_struct *p,
-			      unsigned long task_state)
+			      unsigned long task_state, bool deactivate_cond)
 {
 	int flags = DEQUEUE_NOCLOCK;
 
@@ -6601,6 +6629,9 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 		return false;
 	}
 
+	if (!deactivate_cond)
+		return false;
+
 	p->sched_contributes_to_load =
 		(task_state & TASK_UNINTERRUPTIBLE) &&
 		!(task_state & TASK_NOLOAD) &&
@@ -6624,6 +6655,88 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 	return true;
 }
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+
+static inline struct task_struct *
+proxy_resched_idle(struct rq *rq)
+{
+	put_prev_task(rq, rq->donor);
+	rq_set_donor(rq, rq->idle);
+	set_next_task(rq, rq->idle);
+	set_tsk_need_resched(rq->idle);
+	return rq->idle;
+}
+
+static bool proxy_deactivate(struct rq *rq, struct task_struct *donor)
+{
+	unsigned long state = READ_ONCE(donor->__state);
+
+	/* Don't deactivate if the state has been changed to TASK_RUNNING */
+	if (state == TASK_RUNNING)
+		return false;
+	/*
+	 * Because we got donor from pick_next_task, it is *crucial*
+	 * that we call proxy_resched_idle before we deactivate it.
+	 * As once we deactivate donor, donor->on_rq is set to zero,
+	 * which allows ttwu to immediately try to wake the task on
+	 * another rq. So we cannot use *any* references to donor
+	 * after that point. So things like cfs_rq->curr or rq->donor
+	 * need to be changed from next *before* we deactivate.
+	 */
+	proxy_resched_idle(rq);
+	return try_to_block_task(rq, donor, state, true);
+}
+
+/*
+ * Initial simple proxy that just returns the task if it's waking
+ * or deactivates the blocked task so we can pick something that
+ * isn't blocked.
+ */
+static struct task_struct *
+find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
+{
+	struct task_struct *p = donor;
+	struct mutex *mutex;
+
+	mutex = p->blocked_on;
+	/* Something changed in the chain, so pick again */
+	if (!mutex)
+		return NULL;
+	/*
+	 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
+	 * and ensure @owner sticks around.
+	 */
+	raw_spin_lock(&mutex->wait_lock);
+	raw_spin_lock(&p->blocked_lock);
+
+	/* Check again that p is blocked with blocked_lock held */
+	if (!task_is_blocked(p) || mutex != get_task_blocked_on(p)) {
+		/*
+		 * Something changed in the blocked_on chain and
+		 * we don't know if only at this level. So, let's
+		 * just bail out completely and let __schedule
+		 * figure things out (pick_again loop).
+		 */
+		goto out;
+	}
+	if (!proxy_deactivate(rq, donor))
+		/* XXX: This hack won't work when we get to migrations */
+		donor->blocked_on_state = BO_RUNNABLE;
+
+out:
+	raw_spin_unlock(&p->blocked_lock);
+	raw_spin_unlock(&mutex->wait_lock);
+	return NULL;
+}
+#else /* SCHED_PROXY_EXEC */
+static struct task_struct *
+find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
+{
+	WARN_ONCE(1, "This should never be called in the !SCHED_PROXY_EXEC case\n");
+	return donor;
+}
+#endif /* SCHED_PROXY_EXEC */
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -6732,12 +6845,22 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		block = try_to_block_task(rq, prev, prev_state);
+		block = try_to_block_task(rq, prev, prev_state,
+					  !task_is_blocked(prev));
 		switch_count = &prev->nvcsw;
 	}
 
-	next = pick_next_task(rq, prev, &rf);
+pick_again:
+	next = pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
+	if (unlikely(task_is_blocked(next))) {
+		next = find_proxy_task(rq, next, &rf);
+		if (!next) {
+			/* zap the balance_callbacks before picking again */
+			zap_balance_callbacks(rq);
+			goto pick_again;
+		}
+	}
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index bd66a46b06aca..fa4d9bf76ad49 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1479,8 +1479,19 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 
 	enqueue_rt_entity(rt_se, flags);
 
-	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
-		enqueue_pushable_task(rq, p);
+	/*
+	 * Current can't be pushed away. Selected is tied to current,
+	 * so don't push it either.
+	 */
+	if (task_current(rq, p) || task_current_donor(rq, p))
+		return;
+	/*
+	 * Pinned tasks can't be pushed.
+	 */
+	if (p->nr_cpus_allowed == 1)
+		return;
+
+	enqueue_pushable_task(rq, p);
 }
 
 static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 24eae02ddc7f6..f560d1d1a7a0c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2272,6 +2272,14 @@ static inline int task_current_donor(struct rq *rq, struct task_struct *p)
 	return rq->donor == p;
 }
 
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return false;
+
+	return !!p->blocked_on && p->blocked_on_state != BO_RUNNABLE;
+}
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2481,7 +2489,7 @@ static inline void put_prev_set_next_task(struct rq *rq,
 					  struct task_struct *prev,
 					  struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq->donor != prev);
 
 	__put_prev_set_next_dl_server(rq, prev, next);
 
-- 
2.47.0.371.ga323438b13-goog



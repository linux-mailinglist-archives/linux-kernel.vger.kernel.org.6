Return-Path: <linux-kernel+bounces-558526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EC1A5E70E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9323BC9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD11F150A;
	Wed, 12 Mar 2025 22:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C7vQShDs"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F31F0E56
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817535; cv=none; b=V1RQIJtdEqk85Fk8tuMfyeGwxP2Mjdd/gf9pGrruWoJKtECuu94WOWe/uy3puK+FOGKql3a+yvqZDa7SwbTl1JJ7MkLBhrJoML90yA97xZ3Eik144ahtOlBpZy0Xvn9wz+EF0/Ck4qgI2hg28VzKz7f9nrT6utt2Su5CNg47yJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817535; c=relaxed/simple;
	bh=/mbP4YZxfCyEn2ISQ0juJw1J8fHDfeUVnNlWsNL7flc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QkIsCGl8BmjE7cfn4DGlyhkNWAPYW2RxDl8XCwW1yXYj1DHfqGWEVllyPyuERP5iEZf3KGW8yoyE0qkGjFaVm+1U0fQRcKTTgk2e7Ra3DPVxTzTb7NxXSQ/x2Jhs5fLe+Z+wZ/xap43LArWeyA/amwY2fZp9wE+AK4cvbmAyKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C7vQShDs; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2235a1f8aadso4019245ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741817532; x=1742422332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrsfwqXXgkFJ2winP2ZmaOd8BgTSD1NeOP1iqnaIQP4=;
        b=C7vQShDsVyk/F08Nx9E+uGS3n9FHZ3tVEAGzeRIKK8nUO9M05yLSLv3DkWnu8PO9i+
         KJXOnHI1ayD+RDg/L0IZvxS6a/xrAMAH77iGf6+ZpGXJ1DE02PhfSyX1xsUkT+Rnzp9r
         kei6fjCpkrgW6EgL2ioUliFAEIu8Y7w8fcefzXvl2AqeCBaGx/taUwiolwZ+xu1jB8n8
         XQOyLNGifBUa1x3XWK5qLsnddgH8sC2zanbK47haroXN7LjEWlGP08x9od6fs7Z+h05o
         EEAuoFkOxGODmG1M83rKnbOXVN7U5ZmCwAbAOamseBeEskY9RLl/FIEjZWZjwlEumJI7
         hoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817532; x=1742422332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrsfwqXXgkFJ2winP2ZmaOd8BgTSD1NeOP1iqnaIQP4=;
        b=d2r88+eB+ziLlbKgAfPyKrKK0mHDYpbUtQ45G3pyE6SC3tKDovRzZ8Zt4Gk4lM6+1q
         HuqWrtLoykHxw++3bTn8VJ7qYipncYCXBDm0Xi6erbHrcuyE87QrjqOZiJJLSUXsBYmN
         s+T35fLXmAAQgLEtehAe2DYKoh4DrkWiLraWMfVVX8Ag63iB6DHPiSKvbLm6fhCrATcy
         pEW8sI98nKBPuu6LXV6NDjPBFsplQmV6Cj2g1glavzcN0rW/5q1G86yqm96PvIkXeEyl
         MO94f/K/wkay5jPRZMkkznuw5bNZpl0wy+jTckYVE6eFxH44/3SNAWOD600fZXnwux57
         JoMg==
X-Gm-Message-State: AOJu0YygOgGwP+thWLwrhhOrD9YlOMnYL9CU7ylA0fjbJWtGwv4dJH5u
	B/JiV2ZkyjD2wUlOqNdWpJCXFSLqHpvufcLmrVLuuIGkl/HuwmUl+4gUSFF+LDp1R6Pb0lDygfR
	iMzEOcPnIA7B0GHXGe1/pbpUCg5ha5oUIGsZRdv4rRNKUj6UqPE9P5AIBmPHETMta0eyeq0AQUA
	Yu5Ru76fyu1I4aiYmS/eHvggMTnkvinRy0KsKEuum/LQaJ
X-Google-Smtp-Source: AGHT+IFEPYyaeCVs3PtoZnYnn43MPFjmvJuf32UoV9oQUH9UWlRga5DN+nb/mOKj7mdFwCWxJOpJPtioVyu7
X-Received: from plbkf11.prod.google.com ([2002:a17:903:5cb:b0:223:faee:f527])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e88a:b0:21f:6fb9:9299
 with SMTP id d9443c01a7336-22428aaad15mr360725245ad.27.1741817532211; Wed, 12
 Mar 2025 15:12:12 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:11:35 -0700
In-Reply-To: <20250312221147.1865364-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312221147.1865364-6-jstultz@google.com>
Subject: [RFC PATCH v15 5/7] sched: Add an initial sketch of the
 find_proxy_task() function
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
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
v15:
* Tweaked some comments to better explain the initial sketch of
  find_proxy_task(), suggested by Qais
* Build fixes for !CONFIG_SMP
* Slight rework for blocked_on_state being added later in the
  series.
* Move the zap_balance_callbacks to later in the patch series
---
 kernel/sched/core.c  | 103 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/rt.c    |  15 ++++++-
 kernel/sched/sched.h |  10 ++++-
 3 files changed, 122 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3968c3967ec38..b4f7b14f62a24 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6600,7 +6600,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  * Otherwise marks the task's __state as RUNNING
  */
 static bool try_to_block_task(struct rq *rq, struct task_struct *p,
-			      unsigned long task_state)
+			      unsigned long task_state, bool deactivate_cond)
 {
 	int flags = DEQUEUE_NOCLOCK;
 
@@ -6609,6 +6609,9 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
 		return false;
 	}
 
+	if (!deactivate_cond)
+		return false;
+
 	p->sched_contributes_to_load =
 		(task_state & TASK_UNINTERRUPTIBLE) &&
 		!(task_state & TASK_NOLOAD) &&
@@ -6632,6 +6635,93 @@ static bool try_to_block_task(struct rq *rq, struct task_struct *p,
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
+ * Initial simple sketch that just deactivates the blocked task
+ * chosen by pick_next_task() so we can then pick something that
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
+
+	/* Check again that p is blocked with blocked_lock held */
+	if (!task_is_blocked(p) || mutex != __get_task_blocked_on(p)) {
+		/*
+		 * Something changed in the blocked_on chain and
+		 * we don't know if only at this level. So, let's
+		 * just bail out completely and let __schedule
+		 * figure things out (pick_again loop).
+		 */
+		goto out;
+	}
+
+	if (!proxy_deactivate(rq, donor)) {
+		/*
+		 * XXX: For now, if deactivation failed, set donor
+		 * as not blocked, as we aren't doing proxy-migrations
+		 * yet (more logic will be needed then).
+		 */
+		__clear_task_blocked_on(donor, mutex);
+		raw_spin_unlock(&mutex->wait_lock);
+		return NULL;
+	}
+out:
+	raw_spin_unlock(&mutex->wait_lock);
+	return NULL; /* do pick_next_task again */
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
@@ -6739,12 +6829,19 @@ static void __sched notrace __schedule(int sched_mode)
 			goto picked;
 		}
 	} else if (!preempt && prev_state) {
-		try_to_block_task(rq, prev, prev_state);
+		try_to_block_task(rq, prev, prev_state,
+				  !task_is_blocked(prev));
 		switch_count = &prev->nvcsw;
 	}
 
-	next = pick_next_task(rq, prev, &rf);
+pick_again:
+	next = pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
+	if (unlikely(task_is_blocked(next))) {
+		next = find_proxy_task(rq, next, &rf);
+		if (!next)
+			goto pick_again;
+	}
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b12..2d418e0efecc5 100644
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
index 05d2122533619..3e49d77ce2cdd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2311,6 +2311,14 @@ static inline int task_current_donor(struct rq *rq, struct task_struct *p)
 	return rq->donor == p;
 }
 
+static inline bool task_is_blocked(struct task_struct *p)
+{
+	if (!sched_proxy_exec())
+		return false;
+
+	return !!p->blocked_on;
+}
+
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
@@ -2520,7 +2528,7 @@ static inline void put_prev_set_next_task(struct rq *rq,
 					  struct task_struct *prev,
 					  struct task_struct *next)
 {
-	WARN_ON_ONCE(rq->curr != prev);
+	WARN_ON_ONCE(rq->donor != prev);
 
 	__put_prev_set_next_dl_server(rq, prev, next);
 
-- 
2.49.0.rc0.332.g42c0ae87b1-goog



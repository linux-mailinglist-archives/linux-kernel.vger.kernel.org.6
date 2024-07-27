Return-Path: <linux-kernel+bounces-264098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7086693DEFB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F2C2844D5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE177E572;
	Sat, 27 Jul 2024 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i8IKfGYw"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8554D9FE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078147; cv=none; b=JzVCD7zMQY+ZzebaIizsC7uzKWrEDpkQYxY74J+WSUn3vB5ZCwcssQJwoIVPrrmEOI98m8j79SeCnBu8HBopYPxLjxN4sXDYxPQgAVz5fHIZDP3BtyzsgwlmcJw/tVc8wfe7svItIqZKpeMH/loMCqgEMlBM8upK6GtkldglSh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078147; c=relaxed/simple;
	bh=VfSeFVQpVR3Ie2WXE/8+GLfqEkjbiZzJJ3ebPVldrF0=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=PDE0ZhQ1V+/6sBkPmOmXJp2v20wVPm7B/syj69e9XuUCvLktcP3u3CGKB4ILQryszjl9UEOcsGf1WmjSsO30D/CWsu3T+OAsqCRUj22cylYRAgrvPzB1tM6pmiZYqjHkjU8Fq04Cw7qVbEFmjzp4aCbcMzKDDSmSncWhzexGFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i8IKfGYw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=HSpNrrhOKnI+fCUAM80vQF3pcg432VOftpJHATgs/yI=; b=i8IKfGYw1RyTWCVQQKUxc1C4+R
	3XOM/OM3GPCwFnGa+VNUdfA7vcwSOD1XdBjZVepkjZ74XM8ZyZT4EwUg+Vlom/jZJGIxXlfcG4dIg
	G2O00wI+3JfjemjhoyH/nhjpqj+2pteAYyBcpYJolDX1Kd6qwDUhWqMoRFtDNV7dEwrk5x4oP30dq
	qOBy2tfaz8gQewS+FjVduuDlf2O/tu42GIm8gfK6QrvBzzhmTVv6gtQnvocQ5J+YUEtV5hFAdx+pg
	TobDgIrPhBV0ddeyXQiAwRRvxBzQyAL6i/2ktYnNlsNuV1NPPpkkqoFOaUz8fQR/FShfR4qYOKovJ
	Lii+9Dxw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBg-00000004QMo-41bV;
	Sat, 27 Jul 2024 11:02:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DB9603061F2; Sat, 27 Jul 2024 13:02:06 +0200 (CEST)
Message-Id: <20240727105030.226163742@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 youssefesmat@chromium.org,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [PATCH 17/24] sched/fair: Implement delayed dequeue
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
noting that lag is fundamentally a temporal measure. It should not be
carried around indefinitely.

OTOH it should also not be instantly discarded, doing so will allow a
task to game the system by purposefully (micro) sleeping at the end of
its time quantum.

Since lag is intimately tied to the virtual time base, a wall-time
based decay is also insufficient, notably competition is required for
any of this to make sense.

Instead, delay the dequeue and keep the 'tasks' on the runqueue,
competing until they are eligible.

Strictly speaking, we only care about keeping them until the 0-lag
point, but that is a difficult proposition, instead carry them around
until they get picked again, and dequeue them at that point.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/deadline.c |    1 
 kernel/sched/fair.c     |   82 ++++++++++++++++++++++++++++++++++++++++++------
 kernel/sched/features.h |    9 +++++
 3 files changed, 81 insertions(+), 11 deletions(-)

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2428,7 +2428,6 @@ static struct task_struct *__pick_next_t
 		else
 			p = dl_se->server_pick_next(dl_se);
 		if (!p) {
-			WARN_ON_ONCE(1);
 			dl_se->dl_yielded = 1;
 			update_curr_dl_se(rq, dl_se, 0);
 			goto again;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5379,20 +5379,44 @@ static void clear_buddies(struct cfs_rq
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
-static void
+static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	int action = UPDATE_TG;
+	if (flags & DEQUEUE_DELAYED) {
+		/*
+		 * DEQUEUE_DELAYED is typically called from pick_next_entity()
+		 * at which point we've already done update_curr() and do not
+		 * want to do so again.
+		 */
+		SCHED_WARN_ON(!se->sched_delayed);
+		se->sched_delayed = 0;
+	} else {
+		bool sleep = flags & DEQUEUE_SLEEP;
+
+		/*
+		 * DELAY_DEQUEUE relies on spurious wakeups, special task
+		 * states must not suffer spurious wakeups, excempt them.
+		 */
+		if (flags & DEQUEUE_SPECIAL)
+			sleep = false;
+
+		SCHED_WARN_ON(sleep && se->sched_delayed);
+		update_curr(cfs_rq);
 
+		if (sched_feat(DELAY_DEQUEUE) && sleep &&
+		    !entity_eligible(cfs_rq, se)) {
+			if (cfs_rq->next == se)
+				cfs_rq->next = NULL;
+			se->sched_delayed = 1;
+			return false;
+		}
+	}
+
+	int action = UPDATE_TG;
 	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
 		action |= DO_DETACH;
 
 	/*
-	 * Update run-time statistics of the 'current'.
-	 */
-	update_curr(cfs_rq);
-
-	/*
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
@@ -5430,6 +5454,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 
 	if (cfs_rq->nr_running == 0)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
+
+	return true;
 }
 
 static void
@@ -5828,11 +5854,21 @@ static bool throttle_cfs_rq(struct cfs_r
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
+		int flags;
+
 		/* throttled entity or throttle-on-deactivate */
 		if (!se->on_rq)
 			goto done;
 
-		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
+		/*
+		 * Abuse SPECIAL to avoid delayed dequeue in this instance.
+		 * This avoids teaching dequeue_entities() about throttled
+		 * entities and keeps things relatively simple.
+		 */
+		flags = DEQUEUE_SLEEP | DEQUEUE_SPECIAL;
+		if (se->sched_delayed)
+			flags |= DEQUEUE_DELAYED;
+		dequeue_entity(qcfs_rq, se, flags);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_task_delta = cfs_rq->h_nr_running;
@@ -6918,6 +6954,7 @@ static int dequeue_entities(struct rq *r
 	bool was_sched_idle = sched_idle_rq(rq);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
+	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
 	int h_nr_running = 0;
@@ -6931,7 +6968,13 @@ static int dequeue_entities(struct rq *r
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		dequeue_entity(cfs_rq, se, flags);
+
+		if (!dequeue_entity(cfs_rq, se, flags)) {
+			if (p && &p->se == se)
+				return -1;
+
+			break;
+		}
 
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
@@ -6956,6 +6999,7 @@ static int dequeue_entities(struct rq *r
 			break;
 		}
 		flags |= DEQUEUE_SLEEP;
+		flags &= ~(DEQUEUE_DELAYED | DEQUEUE_SPECIAL);
 	}
 
 	for_each_sched_entity(se) {
@@ -6985,6 +7029,17 @@ static int dequeue_entities(struct rq *r
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
+	if (p && task_delayed) {
+		SCHED_WARN_ON(!task_sleep);
+		SCHED_WARN_ON(p->on_rq != 1);
+
+		/* Fix-up what dequeue_task_fair() skipped */
+		hrtick_update(rq);
+
+		/* Fix-up what block_task() skipped. */
+		__block_task(rq, p);
+	}
+
 	return 1;
 }
 /*
@@ -6996,8 +7051,10 @@ static bool dequeue_task_fair(struct rq
 {
 	util_est_dequeue(&rq->cfs, p);
 
-	if (dequeue_entities(rq, &p->se, flags) < 0)
+	if (dequeue_entities(rq, &p->se, flags) < 0) {
+		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
 		return false;
+	}
 
 	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
 	hrtick_update(rq);
@@ -12973,6 +13030,11 @@ static void set_next_task_fair(struct rq
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		account_cfs_rq_runtime(cfs_rq, 0);
 	}
+
+	if (!first)
+		return;
+
+	SCHED_WARN_ON(se->sched_delayed);
 }
 
 void init_cfs_rq(struct cfs_rq *cfs_rq)
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -29,6 +29,15 @@ SCHED_FEAT(NEXT_BUDDY, false)
 SCHED_FEAT(CACHE_HOT_BUDDY, true)
 
 /*
+ * Delay dequeueing tasks until they get selected or woken.
+ *
+ * By delaying the dequeue for non-eligible tasks, they remain in the
+ * competition and can burn off their negative lag. When they get selected
+ * they'll have positive lag by definition.
+ */
+SCHED_FEAT(DELAY_DEQUEUE, true)
+
+/*
  * Allow wakeup-time preemption of the current task:
  */
 SCHED_FEAT(WAKEUP_PREEMPTION, true)




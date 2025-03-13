Return-Path: <linux-kernel+bounces-558899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B30A5ECDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E4C179774
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846C51FCD0C;
	Thu, 13 Mar 2025 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MGCg9nMT"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BAB1FCFF6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850485; cv=none; b=m5fkGg6GLi/vZTeeIcBJLZ5s8sThiu2S2zvxvTEOuyfdOeT107EMDz/aMV44zSCMr0gBr0o3kFsrkYYsr+mQRIR9e0kklF7/BPiOn8UvWsigWfqBH31jD5iyPyt2NmXCfrp9o8ER2EIZp0bhjoaUARYdksgwZGfuPhvZrT48QBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850485; c=relaxed/simple;
	bh=FPYrVMdzMgoRn0ykyVlfROJr6GOBCIwlvqj8+tF+pR0=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=logENHshvxZbBVWb2dud8D7+MIIqiD+pYGopGQp5uzROzNiu5njhJIK2VtGE/WwE3Gx5vZoFsd4t0jZ7eD531Q2vtI36v6p3PJZj1hItd0AQSLrXVdvOJhIPmRyPNx1WGoSMKzHoKKIPdHPFWkCTZ31ilLxvj4/JIVjNU+63iTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MGCg9nMT; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso1293567a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741850482; x=1742455282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9X3j/Al+E0qt3CF0NzuCOMM22tcAbBsDeUSDt8lyYIc=;
        b=MGCg9nMTOUvY/LeQmcs7y7uHuZpQdbHtPO4j0ssibi1/kdVaVtGMNf99mlVb+j236T
         cRIVnKisdZLQzQFZr2m2zXGwiNZSN/GqxjCOydTbRTtPX8MaZXnwmzEiOOW3gpioYKy/
         yLVX5Ia2ciT4GZ1+e6+TON5Z39Sh7ozCe6OCArmYed+4NYBx7kb8Un225+J2pMIW/84d
         Y6PGhZOasvKbxdENmh/9Cu8PgScZp68wAUo97Lsv+zZIbJ4xToVU+Q2sZ0/ch1N/Oo/7
         9XkrgOPgbyhuXC2aZFGQQHXriR8NlH4MjGxqufj1BOfKjy8C+p4/xc23+24lpHgFpk0I
         ZO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850482; x=1742455282;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X3j/Al+E0qt3CF0NzuCOMM22tcAbBsDeUSDt8lyYIc=;
        b=GDMx5gsmnEzVkreqmkG8CmRPvXT/+6SAE0Dc/z4wC0tSgpYzRpvacyMW9lO0QknxbS
         p93LEOsKmM9IBg/Gr4XVMVRTyZ1EbQadCZ4NKEZvpRU1uod3H48wg+RPd1tJFT/43BQ/
         BlaLYK2PTGOmTtlhzNTYtERRU+OqUIPVcu+Wa3mJRa6hGko9ibaM94nSjumyjd5eD4cw
         brE44+8p6YJ9FbQizvt7ruXDkSonANqoCRVjhzqEsf01JEisE8l52ROVRmgMFdXfFKAv
         OS2SK8YgYF37lxegSutnrI+jVEZe1BENn18OTq/T9spPHbj00afkFu52BBfj83FaeGxR
         Axhw==
X-Gm-Message-State: AOJu0Ywa7BpAApGVG9HDOVnpGtbzCcHP1vISNZasiWuGPtMUsrDBHLU5
	tz6P72N7g+ssRZWFYdxDtny5KN/B1EY8AAM8R5UvPmBGl5ZOFEfwGME9IWDtQG2kojq4twAcwPW
	wUpSqDdXWj/mkQ2XnkHmkwR3NqmTr+rYByBe1
X-Gm-Gg: ASbGncvjFhM/DeK7Aje6ASOZaJluZyjNvZ5OU7wAj3YEm5FG3yUIwnKy/U8EE34gll1
	9OknpSz+6SqOiWhwbcyFs/1Sb++X8L5cppU/MngFvVX7nSKwQRSBeJnwQSrbcm3RffymTZKBB2I
	3NttOdNZe8kI+6AawI2lgv7D26bys=
X-Google-Smtp-Source: AGHT+IGgnZtSATN2Xo2VvJvcktGSwzPWv0X85+vVzQIddh/0WYEeN2pnG6/EtCQih1PN3DJ8ZncETihAEApQQDvIAeI=
X-Received: by 2002:a05:6402:d08:b0:5e6:60da:dc45 with SMTP id
 4fb4d7f45d1cf-5e75f987950mr12486383a12.31.1741850481603; Thu, 13 Mar 2025
 00:21:21 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Mar 2025 07:21:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
From: Aaron Lu <ziqianlu@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313072030.1032893-1-ziqianlu@bytedance.com>
Date: Thu, 13 Mar 2025 07:21:21 +0000
X-Gm-Features: AQ5f1JooU-arp1lqIqQdw18F33sXyJhPom3vRV1LsqGgNxWZpG0iLVAjL4pOIm0
Message-ID: <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
Subject: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based throttle
To: Valentin Schneider <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mel Gorman <mgorman@suse.de>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chuyi Zhou <zhouchuyi@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

From: Valentin Schneider <vschneid@redhat.com>

Once a cfs_rq gets throttled, for all tasks belonging to this cfs_rq,
add a task work to them so that when those tasks return to user, the
actual throttle/dequeue can happen.

Note that since the throttle/dequeue always happens on a task basis when
it returns to user, it's no longer necessary for check_cfs_rq_runtime()
to return a value and pick_task_fair() acts differently according to that
return value, so check_cfs_rq_runtime() is changed to not return a
value.

[aaronlu: extracted from Valentin's original patches.
 Fixed a problem that curr is not in timeline tree and has to be dealed
 with explicitely;
 Make check_cfs_rq_runtime() void.]
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c  | 201 ++++++++++++++++++++++++-------------------
 kernel/sched/sched.h |   1 +
 2 files changed, 112 insertions(+), 90 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 60eb5329bf526..ab403ff7d53c8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5607,7 +5607,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	return se;
 }

-static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
+static void check_cfs_rq_runtime(struct cfs_rq *cfs_rq);

 static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 {
@@ -5832,8 +5832,49 @@ static inline int throttled_lb_pair(struct
task_group *tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }

+static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags);
 static void throttle_cfs_rq_work(struct callback_head *work)
 {
+	struct task_struct *p = container_of(work, struct task_struct,
sched_throttle_work);
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+	struct rq *rq;
+	struct rq_flags rf;
+
+	WARN_ON_ONCE(p != current);
+	p->sched_throttle_work.next = &p->sched_throttle_work;
+
+	/*
+	 * If task is exiting, then there won't be a return to userspace, so we
+	 * don't have to bother with any of this.
+	 */
+	if ((p->flags & PF_EXITING))
+		return;
+
+	rq = task_rq_lock(p, &rf);
+
+	se = &p->se;
+	cfs_rq = cfs_rq_of(se);
+
+	/* Raced, forget */
+	if (p->sched_class != &fair_sched_class)
+		goto out_unlock;
+
+	/*
+	 * If not in limbo, then either replenish has happened or this task got
+	 * migrated out of the throttled cfs_rq, move along
+	 */
+	if (!cfs_rq->throttle_count)
+		goto out_unlock;
+
+	update_rq_clock(rq);
+	WARN_ON_ONCE(!list_empty(&p->throttle_node));
+	list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
+	dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
+	resched_curr(rq);
+
+out_unlock:
+	task_rq_unlock(rq, p, &rf);
 }

 void init_cfs_throttle_work(struct task_struct *p)
@@ -5873,32 +5914,81 @@ static int tg_unthrottle_up(struct task_group
*tg, void *data)
 	return 0;
 }

+static inline bool task_has_throttle_work(struct task_struct *p)
+{
+	return p->sched_throttle_work.next != &p->sched_throttle_work;
+}
+
+static inline void task_throttle_setup_work(struct task_struct *p)
+{
+	/*
+	 * Kthreads and exiting tasks don't return to userspace, so adding the
+	 * work is pointless
+	 */
+	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
+		return;
+
+	if (task_has_throttle_work(p))
+		return;
+
+	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
+}
+
 static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct task_struct *p;
+	struct rb_node *node;
+
+	cfs_rq->throttle_count++;
+	if (cfs_rq->throttle_count > 1)
+		return 0;

 	/* group is entering throttled state, stop time */
-	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
-		list_del_leaf_cfs_rq(cfs_rq);
+	cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
+	list_del_leaf_cfs_rq(cfs_rq);

-		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
-		if (cfs_rq->nr_queued)
-			cfs_rq->throttled_clock_self = rq_clock(rq);
+	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
+	if (cfs_rq->nr_queued)
+		cfs_rq->throttled_clock_self = rq_clock(rq);
+
+	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
+	/*
+	 * rq_lock is held, current is (obviously) executing this in kernelspace.
+	 *
+	 * All other tasks enqueued on this rq have their saved PC at the
+	 * context switch, so they will go through the kernel before returning
+	 * to userspace. Thus, there are no tasks-in-userspace to handle, just
+	 * install the task_work on all of them.
+	 */
+	node = rb_first(&cfs_rq->tasks_timeline.rb_root);
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		if (!entity_is_task(se))
+			goto next;
+
+		p = task_of(se);
+		task_throttle_setup_work(p);
+next:
+		node = rb_next(node);
+	}
+
+	/* curr is not in the timeline tree */
+	if (cfs_rq->curr && entity_is_task(cfs_rq->curr)) {
+		p = task_of(cfs_rq->curr);
+		task_throttle_setup_work(p);
 	}
-	cfs_rq->throttle_count++;

 	return 0;
 }

-static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
+static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
-	long rq_h_nr_queued = rq->cfs.h_nr_queued;
+	int dequeue = 1;

 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5919,74 +6009,13 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	raw_spin_unlock(&cfs_b->lock);

 	if (!dequeue)
-		return false;  /* Throttle no longer required. */
-
-	se = cfs_rq->tg->se[cpu_of(rq_of(cfs_rq))];
+		return;  /* Throttle no longer required. */

 	/* freeze hierarchy runnable averages while throttled */
 	rcu_read_lock();
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();

-	queued_delta = cfs_rq->h_nr_queued;
-	runnable_delta = cfs_rq->h_nr_runnable;
-	idle_delta = cfs_rq->h_nr_idle;
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-		int flags;
-
-		/* throttled entity or throttle-on-deactivate */
-		if (!se->on_rq)
-			goto done;
-
-		/*
-		 * Abuse SPECIAL to avoid delayed dequeue in this instance.
-		 * This avoids teaching dequeue_entities() about throttled
-		 * entities and keeps things relatively simple.
-		 */
-		flags = DEQUEUE_SLEEP | DEQUEUE_SPECIAL;
-		if (se->sched_delayed)
-			flags |= DEQUEUE_DELAYED;
-		dequeue_entity(qcfs_rq, se, flags);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta = cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued -= queued_delta;
-		qcfs_rq->h_nr_runnable -= runnable_delta;
-		qcfs_rq->h_nr_idle -= idle_delta;
-
-		if (qcfs_rq->load.weight) {
-			/* Avoid re-evaluating load for this entity: */
-			se = parent_entity(se);
-			break;
-		}
-	}
-
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-		/* throttled entity or throttle-on-deactivate */
-		if (!se->on_rq)
-			goto done;
-
-		update_load_avg(qcfs_rq, se, 0);
-		se_update_runnable(se);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta = cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued -= queued_delta;
-		qcfs_rq->h_nr_runnable -= runnable_delta;
-		qcfs_rq->h_nr_idle -= idle_delta;
-	}
-
-	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, queued_delta);
-
-	/* Stop the fair server if throttling resulted in no runnable tasks */
-	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
-		dl_server_stop(&rq->fair_server);
-done:
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
@@ -5995,7 +6024,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	SCHED_WARN_ON(cfs_rq->throttled_clock);
 	if (cfs_rq->nr_queued)
 		cfs_rq->throttled_clock = rq_clock(rq);
-	return true;
+	return;
 }

 void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
@@ -6471,22 +6500,22 @@ static void sync_throttle(struct task_group
*tg, int cpu)
 }

 /* conditionally throttle active cfs_rq's from put_prev_entity() */
-static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq)
+static void check_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	if (!cfs_bandwidth_used())
-		return false;
+		return;

 	if (likely(!cfs_rq->runtime_enabled || cfs_rq->runtime_remaining > 0))
-		return false;
+		return;

 	/*
 	 * it's possible for a throttled entity to be forced into a running
 	 * state (e.g. set_curr_task), in this case we're finished.
 	 */
 	if (cfs_rq_throttled(cfs_rq))
-		return true;
+		return;

-	return throttle_cfs_rq(cfs_rq);
+	throttle_cfs_rq(cfs_rq);
 }

 static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
@@ -6582,6 +6611,7 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
 	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
+	INIT_LIST_HEAD(&cfs_rq->throttled_limbo_list);
 }

 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
@@ -7117,10 +7147,6 @@ static int dequeue_entities(struct rq *rq,
struct sched_entity *se, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;

-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			return 0;
-
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			slice = cfs_rq_min_slice(cfs_rq);
@@ -7157,10 +7183,6 @@ static int dequeue_entities(struct rq *rq,
struct sched_entity *se, int flags)

 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = h_nr_queued;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			return 0;
 	}

 	sub_nr_running(rq, h_nr_queued);
@@ -8869,8 +8891,7 @@ static struct task_struct *pick_task_fair(struct rq *rq)
 		if (cfs_rq->curr && cfs_rq->curr->on_rq)
 			update_curr(cfs_rq);

-		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
-			goto again;
+		check_cfs_rq_runtime(cfs_rq);

 		se = pick_next_entity(rq, cfs_rq);
 		if (!se)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8bfa3d708081..5c2af5a70163c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -742,6 +742,7 @@ struct cfs_rq {
 	int			throttle_count;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
+	struct list_head	throttled_limbo_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
-- 
2.39.5


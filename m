Return-Path: <linux-kernel+bounces-558901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F36ABA5ECDC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33F6D17992D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE401FDE24;
	Thu, 13 Mar 2025 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e182KGKy"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7891FC7C6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850497; cv=none; b=CmYc68vjWYr1IFY4wh1Gq36LS9Zfkx69ALnTnz6RuRMUEFnP94nZY9+GUvSjpwRTNwGAO42hOc337NpabI2x2JNwGtXBcnJISqEqSqi0h8RTVAKiCWguH7QTMAmCRF5DMRedWVxo3znGQN1/+ei2y7xwnssUprfy8ZZ7UFTFpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850497; c=relaxed/simple;
	bh=lOJiSz7w3clLPaLxlSufcLuCf7SVEUA7lnAKEmzNWT4=;
	h=Mime-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7couGqI8vM0wR8GtL+YDrMPbEhQn579ySmAtfDVZUbgCdhFcJpYel8ovJxq6/3oDdiD3f+dIHScXM/MjxfdILxBLftnsClkEHjl639mN9B4FZq55hSYn+3g3AsMwia/CVL4yiO0BUz5/56IvfZ/eVeAyvM21rBeDoAUgenpCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e182KGKy; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so1207852a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741850493; x=1742455293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8IUTonFnbGR28bH8I5KVSgIiO0PN+YCRA2kMGCMcFvo=;
        b=e182KGKysAZLSRSRBRgNsksc0zQlCPVtcYaC3R3Jxj0T6J5CZcNNQj510b+7oc1AKS
         bgi1iqWPdaXOQ8oKP965mgDOx6nybR7EM35u7fex1ErPebfT/lyV8th0HS/9h38o4bwn
         7u8Wq0XL4yLRrGOEgy4ERUZ0TM12XroHRHZaYr3GeCVbLBxNtqGCq0cThzRFtQIn0J6A
         1OEMBff+nIrLwjMinDudQTI14KK83ZCtROBnRE1wHaTa+wcGyA0N/5co4Thh/8sA0H5h
         huqu62tqhPFS0POSPkoYu1vdliA+IVmn/jOHWeFmobhGSGEMqRm9CACc/Vh/jvCG/YlH
         g3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850493; x=1742455293;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8IUTonFnbGR28bH8I5KVSgIiO0PN+YCRA2kMGCMcFvo=;
        b=SOFZd8Y/CdbiSladPE7bvgZX1O/RtbB7SBMcmgjT5qgatnEY+Fp3kCoZ6CR+3w/XPA
         6FG7pFG2iBHYpf+UM2FLf76naVA3fxr135Tp5stNCSnqFprMM5MQS/RDQt1x5xG1e0YY
         RdG8llYlBPZInzNI+7wLsYV3K877YyI51V/knJ3SstTJT06cnTWvHmQ5J7JLpoQTHOfd
         AWDmsIA18omXEBd7Yk+wmK/3z54ppmMcEj53aJ1Mu3ivf3ghB9cQp2Ravlr+rAEiqal3
         UTUoxSuGziWcE9Dj0XN6KMYDtwCVVjg92toqux/+kNkMGR1J6982PS90jWBGmqXyB9ib
         H4lQ==
X-Gm-Message-State: AOJu0Yx3ah7MoWh6lB27k9vmRY/IuM419LlckUmJSKXlQoffl/ZBF0fQ
	VGwnZCtpWyQCulnRmdIGCmEu/iwWfQy1gCSl9wucIO2E7301LCj4Iir+BEykM2Qin+LiaSnTDF8
	blRjmtvbX78PZiHWL6NwzL0VbrzGxoHyXX2CB
X-Gm-Gg: ASbGncv1EgksUiWzsb9gpsOHxcfMpKfgXwBFpbYh8Com9IdL1X68yQju9EOFG58lV5s
	B9ln8C+DX7hbrUB/iO7pg/zUx6xD/BcoKQ/aF2KColJ1wa+QFB54laLBSfHrXLJwhuku5lgwREl
	5FvGbwkfflleT2dqMkBsxrWyyorZM=
X-Google-Smtp-Source: AGHT+IGeC7ByiYR5LqV6b9JQUsphbI5YmoLxADfUOig/IAbugjBqDiy9iqK8Q2k+FurOApQZ5znqPsMmSMUksniypIM=
X-Received: by 2002:a05:6402:d08:b0:5e6:60da:dc45 with SMTP id
 4fb4d7f45d1cf-5e75f987950mr12486783a12.31.1741850493161; Thu, 13 Mar 2025
 00:21:33 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 13 Mar 2025 00:21:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20250313072030.1032893-1-ziqianlu@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
X-Original-From: Aaron Lu <ziqianlu@bytedance.com>
From: Aaron Lu <ziqianlu@bytedance.com>
Date: Thu, 13 Mar 2025 00:21:32 -0700
X-Gm-Features: AQ5f1Jp_ea6Yb1KOLsBDUR1_sNy1JA_TVnPxXRepu8DMiQqpWVs4TTLWsW7wDNw
Message-ID: <CANCG0GcAic5QThYG-r9CaXPgZtXJuB0RuCW5Y0SyBn7VyOQi=g@mail.gmail.com>
Subject: [RFC PATCH 3/7] sched/fair: Handle unthrottle path for task based throttle
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

On unthrottle, enqueue throttled tasks back so they can continue to run.

Note that for this task based throttling, the only throttle place is
when it returns to user space so as long as a task is enqueued, no
matter its cfs_rq is throttled or not, it will be allowed to run till it
reaches that throttle place.

leaf_cfs_rq list is handled differently now: as long as a task is
enqueued to a throttled or not cfs_rq, this cfs_rq will be added to that
list and when cfs_rq is throttled and all its tasks are dequeued, it
will be removed from that list. I think this is easy to reason so chose
to do so.

[aaronlu: extracted from Valentin's original patches. I also changed the
 implementation to using enqueue_task_fair() for queuing back tasks to
 unthrottled cfs_rq]
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 132 +++++++++++++++-----------------------------
 1 file changed, 45 insertions(+), 87 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ab403ff7d53c8..4a95fe3785e43 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5366,18 +5366,17 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct
sched_entity *se, int flags)

 	if (cfs_rq->nr_queued == 1) {
 		check_enqueue_throttle(cfs_rq);
-		if (!throttled_hierarchy(cfs_rq)) {
-			list_add_leaf_cfs_rq(cfs_rq);
-		} else {
+		list_add_leaf_cfs_rq(cfs_rq);
 #ifdef CONFIG_CFS_BANDWIDTH
+		if (throttled_hierarchy(cfs_rq)) {
 			struct rq *rq = rq_of(cfs_rq);

 			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
 				cfs_rq->throttled_clock = rq_clock(rq);
 			if (!cfs_rq->throttled_clock_self)
 				cfs_rq->throttled_clock_self = rq_clock(rq);
-#endif
 		}
+#endif
 	}
 }

@@ -5525,8 +5524,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct
sched_entity *se, int flags)
 	if (flags & DEQUEUE_DELAYED)
 		finish_delayed_dequeue_entity(se);

-	if (cfs_rq->nr_queued == 0)
+	if (cfs_rq->nr_queued == 0) {
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
+		if (throttled_hierarchy(cfs_rq))
+			list_del_leaf_cfs_rq(cfs_rq);
+	}

 	return true;
 }
@@ -5832,6 +5834,11 @@ static inline int throttled_lb_pair(struct
task_group *tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }

+static inline bool task_is_throttled(struct task_struct *p)
+{
+	return !list_empty(&p->throttle_node);
+}
+
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags);
 static void throttle_cfs_rq_work(struct callback_head *work)
 {
@@ -5885,32 +5892,45 @@ void init_cfs_throttle_work(struct task_struct *p)
 	INIT_LIST_HEAD(&p->throttle_node);
 }

+static void enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags);
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
 	struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
+	struct task_struct *p, *tmp;

 	cfs_rq->throttle_count--;
-	if (!cfs_rq->throttle_count) {
-		cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
-					     cfs_rq->throttled_clock_pelt;
+	if (cfs_rq->throttle_count)
+		return 0;

-		/* Add cfs_rq with load or one or more already running entities to
the list */
-		if (!cfs_rq_is_decayed(cfs_rq))
-			list_add_leaf_cfs_rq(cfs_rq);
+	cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
+		cfs_rq->throttled_clock_pelt;

-		if (cfs_rq->throttled_clock_self) {
-			u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
+	if (cfs_rq->throttled_clock_self) {
+		u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;

-			cfs_rq->throttled_clock_self = 0;
+		cfs_rq->throttled_clock_self = 0;

-			if (SCHED_WARN_ON((s64)delta < 0))
-				delta = 0;
+		if (SCHED_WARN_ON((s64)delta < 0))
+			delta = 0;

-			cfs_rq->throttled_clock_self_time += delta;
-		}
+		cfs_rq->throttled_clock_self_time += delta;
 	}

+	/* Re-enqueue the tasks that have been throttled at this level. */
+	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list,
throttle_node) {
+		list_del_init(&p->throttle_node);
+		/*
+		 * FIXME: p may not be allowed to run on this rq anymore
+		 * due to affinity change while p is throttled.
+		 */
+		enqueue_task_fair(rq_of(cfs_rq), p, ENQUEUE_WAKEUP);
+	}
+
+	/* Add cfs_rq with load or one or more already running entities to the list */
+	if (!cfs_rq_is_decayed(cfs_rq))
+		list_add_leaf_cfs_rq(cfs_rq);
+
 	return 0;
 }

@@ -5947,12 +5967,16 @@ static int tg_throttle_down(struct task_group
*tg, void *data)

 	/* group is entering throttled state, stop time */
 	cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
-	list_del_leaf_cfs_rq(cfs_rq);

 	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
 	if (cfs_rq->nr_queued)
 		cfs_rq->throttled_clock_self = rq_clock(rq);

+	if (!cfs_rq->nr_queued) {
+		list_del_leaf_cfs_rq(cfs_rq);
+		return 0;
+	}
+
 	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
 	/*
 	 * rq_lock is held, current is (obviously) executing this in kernelspace.
@@ -6031,11 +6055,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	struct sched_entity *se;
-	long queued_delta, runnable_delta, idle_delta;
-	long rq_h_nr_queued = rq->cfs.h_nr_queued;
-
-	se = cfs_rq->tg->se[cpu_of(rq)];
+	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];

 	cfs_rq->throttled = 0;

@@ -6063,62 +6083,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			if (list_add_leaf_cfs_rq(cfs_rq_of(se)))
 				break;
 		}
-		goto unthrottle_throttle;
 	}

-	queued_delta = cfs_rq->h_nr_queued;
-	runnable_delta = cfs_rq->h_nr_runnable;
-	idle_delta = cfs_rq->h_nr_idle;
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-
-		/* Handle any unfinished DELAY_DEQUEUE business first. */
-		if (se->sched_delayed) {
-			int flags = DEQUEUE_SLEEP | DEQUEUE_DELAYED;
-
-			dequeue_entity(qcfs_rq, se, flags);
-		} else if (se->on_rq)
-			break;
-		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta = cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued += queued_delta;
-		qcfs_rq->h_nr_runnable += runnable_delta;
-		qcfs_rq->h_nr_idle += idle_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
-	}
-
-	for_each_sched_entity(se) {
-		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
-
-		update_load_avg(qcfs_rq, se, UPDATE_TG);
-		se_update_runnable(se);
-
-		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_delta = cfs_rq->h_nr_queued;
-
-		qcfs_rq->h_nr_queued += queued_delta;
-		qcfs_rq->h_nr_runnable += runnable_delta;
-		qcfs_rq->h_nr_idle += idle_delta;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(qcfs_rq))
-			goto unthrottle_throttle;
-	}
-
-	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
-		dl_server_start(&rq->fair_server);
-
-	/* At this point se is NULL and we are at root level*/
-	add_nr_running(rq, queued_delta);
-
-unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);

 	/* Determine whether we need to wake up potentially idle CPU: */
@@ -6989,6 +6955,7 @@ enqueue_task_fair(struct rq *rq, struct
task_struct *p, int flags)
 		util_est_enqueue(&rq->cfs, p);

 	if (flags & ENQUEUE_DELAYED) {
+		SCHED_WARN_ON(task_is_throttled(p));
 		requeue_delayed_entity(se);
 		return;
 	}
@@ -7031,10 +6998,6 @@ enqueue_task_fair(struct rq *rq, struct
task_struct *p, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;

-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
-
 		flags = ENQUEUE_WAKEUP;
 	}

@@ -7056,10 +7019,6 @@ enqueue_task_fair(struct rq *rq, struct
task_struct *p, int flags)

 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle = 1;
-
-		/* end evaluation on encountering a throttled cfs_rq */
-		if (cfs_rq_throttled(cfs_rq))
-			goto enqueue_throttle;
 	}

 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
@@ -7089,7 +7048,6 @@ enqueue_task_fair(struct rq *rq, struct
task_struct *p, int flags)
 	if (!task_new)
 		check_update_overutilized_status(rq);

-enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);

 	hrtick_update(rq);
-- 
2.39.5


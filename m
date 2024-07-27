Return-Path: <linux-kernel+bounces-264092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F67C93DEF5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C80283DA1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0C26F303;
	Sat, 27 Jul 2024 11:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bb+U52wi"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30A4AEE9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722078146; cv=none; b=uXGpEfjOTJVHBc+fhzDCwFv+XSKyGMP4Olb21GCcXNpJRktP8J4PIjqDDcUMbaUclkV5Iraz09hzlnRIb/EHgPnBE1cB2qsyX36yOOLmxfEd27GDkV+W4rH+xiMvrg+sotM2SsuzjQ5PCSoogY9qk/NlmG9gQERXCtiu+tZtvmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722078146; c=relaxed/simple;
	bh=GatGV5EiNrcfC9FtYW3ixHu+CIAH0wQyqLtdISPb76U=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LuS2NGGD0PyCR8jw98w19qahjZwh8vQOt3n/rylkj/Sgpzj55SF+Az4cOXJ3Hyg+9QcxqWSXfsrOaC7auDCG4oJ/mvm1nIVuPN6wbzFJLW9cwBb/cbjXHOafA1OShuN9nnltgkkC80VAjY4SKn7t5J1/XK40csOj5jnMZp8J+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bb+U52wi; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=zyZc3oXnO0kyE8lQTKVm1rBPZIzLBcn8udEj4bjNwec=; b=Bb+U52wi0jOtjccVx1Gv1TYwDY
	Ie2DdsMsNZ9BT8s1pwB2gHkOQ9LIMN9PmB0mh3PjFKFrn+JOib2Nh2GRl8rWmpfaUIibrb6YySNh0
	tINNh5/QTGl8w04xLCIYGtYL0sBrfLnkObKOkrxzv11abWWbPJezZUcq73JMN8HIKVxYSdS32X030
	F5ikwuSOw1yls73It62fmPIXfo+fXS3nDb638QFpZmbjq4u9JdwhfZT79xDm/yC9xp+arRYWiYdNa
	Xa6cy36Usd5YZ/B7xSETA8ogrJRcS4V8GwLBYTzS7qHH889a6Q1iSVBRTY5GbV6QCKTYzjc36DNVT
	jp9TgfYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXfBh-00000004QN3-42Nd;
	Sat, 27 Jul 2024 11:02:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 046AE308147; Sat, 27 Jul 2024 13:02:07 +0200 (CEST)
Message-Id: <20240727105030.948188417@infradead.org>
User-Agent: quilt/0.65
Date: Sat, 27 Jul 2024 12:27:55 +0200
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
Subject: [PATCH 23/24] sched/eevdf: Propagate min_slice up the cgroup hierarchy
References: <20240727102732.960974693@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In the absence of an explicit cgroup slice configureation, make mixed
slice length work with cgroups by propagating the min_slice up the
hierarchy.

This ensures the cgroup entity gets timely service to service its
entities that have this timing constraint set on them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    1 
 kernel/sched/fair.c   |   57 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -542,6 +542,7 @@ struct sched_entity {
 	struct rb_node			run_node;
 	u64				deadline;
 	u64				min_vruntime;
+	u64				min_slice;
 
 	struct list_head		group_node;
 	unsigned char			on_rq;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -782,6 +782,21 @@ static void update_min_vruntime(struct c
 	cfs_rq->min_vruntime = __update_min_vruntime(cfs_rq, vruntime);
 }
 
+static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
+{
+	struct sched_entity *root = __pick_root_entity(cfs_rq);
+	struct sched_entity *curr = cfs_rq->curr;
+	u64 min_slice = ~0ULL;
+
+	if (curr && curr->on_rq)
+		min_slice = curr->slice;
+
+	if (root)
+		min_slice = min(min_slice, root->min_slice);
+
+	return min_slice;
+}
+
 static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
 {
 	return entity_before(__node_2_se(a), __node_2_se(b));
@@ -798,19 +813,34 @@ static inline void __min_vruntime_update
 	}
 }
 
+static inline void __min_slice_update(struct sched_entity *se, struct rb_node *node)
+{
+	if (node) {
+		struct sched_entity *rse = __node_2_se(node);
+		if (rse->min_slice < se->min_slice)
+			se->min_slice = rse->min_slice;
+	}
+}
+
 /*
  * se->min_vruntime = min(se->vruntime, {left,right}->min_vruntime)
  */
 static inline bool min_vruntime_update(struct sched_entity *se, bool exit)
 {
 	u64 old_min_vruntime = se->min_vruntime;
+	u64 old_min_slice = se->min_slice;
 	struct rb_node *node = &se->run_node;
 
 	se->min_vruntime = se->vruntime;
 	__min_vruntime_update(se, node->rb_right);
 	__min_vruntime_update(se, node->rb_left);
 
-	return se->min_vruntime == old_min_vruntime;
+	se->min_slice = se->slice;
+	__min_slice_update(se, node->rb_right);
+	__min_slice_update(se, node->rb_left);
+
+	return se->min_vruntime == old_min_vruntime &&
+	       se->min_slice == old_min_slice;
 }
 
 RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sched_entity,
@@ -823,6 +853,7 @@ static void __enqueue_entity(struct cfs_
 {
 	avg_vruntime_add(cfs_rq, se);
 	se->min_vruntime = se->vruntime;
+	se->min_slice = se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				__entity_less, &min_vruntime_cb);
 }
@@ -6917,6 +6948,7 @@ enqueue_task_fair(struct rq *rq, struct
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
+	u64 slice = 0;
 
 	if (flags & ENQUEUE_DELAYED) {
 		requeue_delayed_entity(se);
@@ -6946,7 +6978,18 @@ enqueue_task_fair(struct rq *rq, struct
 			break;
 		}
 		cfs_rq = cfs_rq_of(se);
+
+		/*
+		 * Basically set the slice of group entries to the min_slice of
+		 * their respective cfs_rq. This ensures the group can service
+		 * its entities in the desired time-frame.
+		 */
+		if (slice) {
+			se->slice = slice;
+			se->custom_slice = 1;
+		}
 		enqueue_entity(cfs_rq, se, flags);
+		slice = cfs_rq_min_slice(cfs_rq);
 
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
@@ -6968,6 +7011,9 @@ enqueue_task_fair(struct rq *rq, struct
 		se_update_runnable(se);
 		update_cfs_group(se);
 
+		se->slice = slice;
+		slice = cfs_rq_min_slice(cfs_rq);
+
 		cfs_rq->h_nr_running++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 
@@ -7033,11 +7079,15 @@ static int dequeue_entities(struct rq *r
 	int idle_h_nr_running = 0;
 	int h_nr_running = 0;
 	struct cfs_rq *cfs_rq;
+	u64 slice = 0;
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
 		h_nr_running = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
+	} else {
+		cfs_rq = group_cfs_rq(se);
+		slice = cfs_rq_min_slice(cfs_rq);
 	}
 
 	for_each_sched_entity(se) {
@@ -7062,6 +7112,8 @@ static int dequeue_entities(struct rq *r
 
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
+			slice = cfs_rq_min_slice(cfs_rq);
+
 			/* Avoid re-evaluating load for this entity: */
 			se = parent_entity(se);
 			/*
@@ -7083,6 +7135,9 @@ static int dequeue_entities(struct rq *r
 		se_update_runnable(se);
 		update_cfs_group(se);
 
+		se->slice = slice;
+		slice = cfs_rq_min_slice(cfs_rq);
+
 		cfs_rq->h_nr_running -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 




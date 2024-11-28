Return-Path: <linux-kernel+bounces-424464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5169F9DB4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 10:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11DE528245B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B465D176ADE;
	Thu, 28 Nov 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/34xi1n"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A340156641
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732786081; cv=none; b=JissIiWVMSiMpTyO2+N/WIM5RUefKb7lN92H+qhzuQmVeMCtu4gropU2hwl/BTZ1gftzALYz26JHVf6mvBWwfZA8R02opl4I3GVHkhCMX73i4gPjMAensRQgOqkGQiVgM5JIwUDr6TeEV5rDVQGT1S344AhFkTzqNWhNYX9zv5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732786081; c=relaxed/simple;
	bh=47/XhuXPiMuE3PlFlrzpWKyxXSSVVJimF/5e4ZBwoyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAxe2pqNHtQpkPQ4daSwkBooxi+tsUx2quVrxLaUW4uuSgHQVdB34VYPJJQO5w/ltGJycMtbzBz2aT5NyJUms++a8ooMf8Mtaqpnh8Q7TbzmxEiuw9T4t/kqnVF3onUGA4Nms4TnJJlcGl20CwpdL54ePfEwYz7QEODm3lGYaFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R/34xi1n; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a95095efso10066395e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732786078; x=1733390878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd6iAgfGMbvPVpB2MIxIP2xrJbn95ItnIFtFFWxsmMA=;
        b=R/34xi1nUBEN7XkcpyiPO4+vxDukCcdJHZ0bNkdy+mmQoyhyYHbZZ7jLHEYvd0iH7I
         8EmZUpnw4JPWMDXbFG9HJfAU/BV5pPwGx3P8W4XdVNSmHd8jJ6rW77rjyYkSKkxS+bAI
         dYWj9HkFe9jww217OgseD7h/DhQt+j++bJM5qkpNECH491sMW6W2FRhK59S6lis4oHMN
         9V9P4pvCFX7DhEFDRbcqig7XTr0llDqNWgvv5N8oLVkJKxKmSG5z8z5WjJjmtkYp0m1K
         KvOz9m2bsSxB/oDvEIR2AcycI25AFUrng4TersaylmgZZeDFw8Lst+pJ1Rc43m8Rfbh2
         Y7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732786078; x=1733390878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dd6iAgfGMbvPVpB2MIxIP2xrJbn95ItnIFtFFWxsmMA=;
        b=W0b4C6duDx/xcOFKIcmDPenRqViKpgVPhXZnVX1PWZTj0u8eeWJlO+IVaPDsTHjqxQ
         APdIcxmGTzlUXDkwc1D/frgFAJtZnqiEqgrA/tS6BD5wWk/7G2QP0udMOKc94x3R7EdM
         U44ICCC2WeTp/QejLTw1xWbWyjwPh1fYWHWwCTGKJgLBuO7UE1cl1Z3jTTHqVrlANXI9
         3vvy2bFddOQNdJ2VYvpbgA2KMAScEcsTV1jQ5MNqS3dQs5ybZGWqQ/X5bxmbwS3KyXiO
         +UBpMmsn4NTMu+uaUphqR7Swp1lbZahHH1vPmLOrzWmOOIZH2h4yvGgwzNsB6I5uTh3c
         CtrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFGUagxyGTsynm8AcaMvhqA96AZZ1qW1TaZrJ99OUPIzGri+dDjmhQ88PiA7WRtFql6i3JwHoK3PoxwzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLWT4NqjZDwJ6rgbIoblUhldE6rqNlY1Nz176zI6eKkmPyKRM
	cbFsl7inTob8+7X05+Q4xIzsuTdyCm+62FHqtCBb+T8/kUlwuqlploSJaHPjXck=
X-Gm-Gg: ASbGncvtkLlvD+xbzgE2LTkFja11pcROFteqnH6CMMQjYFD4DSkrEt1YqaeWR3JUvlz
	P4h68pARuQRg215ZpXJvgoKwfbA1kdrJr5T/Dn5dfUiQrePBtFx+JOFU4oaISVb2UW5XkwIPG40
	K4MqwvVU6ERtHdVgtU2nSmx9DC68L75il9l7uXyAqs3NnutOBmJi4cZWJnBBtiC483KtJ4GFiOn
	yzUvA6dYvP5B/32vcQmc9zhrm/R4Od+EZlT1Fphfyxse1fQ4cfAgvXagOg=
X-Google-Smtp-Source: AGHT+IF4P1LqWGlTXUG5JBsNWPxcshOaGTcZYT2yAT/bwAD2jR0/ZL1U4BNgNczRKPfLMUAr/6/L7Q==
X-Received: by 2002:a05:600c:1c01:b0:434:9d55:620 with SMTP id 5b1f17b1804b1-434afbd337amr20050475e9.11.1732786077712;
        Thu, 28 Nov 2024 01:27:57 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c0d5:15dc:1ec9:3f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4d42sm47078885e9.37.2024.11.28.01.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 01:27:57 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
	pauld@redhat.com,
	efault@gmx.de,
	luis.machado@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/9] sched/fair: Add new cfs_rq.h_nr_enqueued
Date: Thu, 28 Nov 2024 10:27:43 +0100
Message-ID: <20241128092750.2541735-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128092750.2541735-1-vincent.guittot@linaro.org>
References: <20241128092750.2541735-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With delayed dequeued feature, a sleeping sched_entity remains enqueued
in the rq until its lag has elapsed. As a result, it stays also visible
in the statistics that are used to balance the system and in particular
the field h_nr_running when the sched_entity is associated to a task.

Create a new h_nr_enqueued that tracks all enqueued tasks and restore the
behavior of h_nr_running i.e. tracking the number of fair tasks that want
to run.

h_nr_running is used in several places to make decision on load balance:
- PELT runnable_avg
- deciding if a group is overloaded or has spare capacity
- numa stats
- reduced capacity management
- load balance
- nohz kick

It should be noticed that the rq->nr_running still counts the delayed
dequeued tasks as delayed dequeue is a fair feature that is meaningless
at core level.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/debug.c |  5 +--
 kernel/sched/fair.c  | 81 +++++++++++++++++++++++++++-----------------
 kernel/sched/pelt.c  |  2 +-
 kernel/sched/sched.h |  8 ++---
 5 files changed, 57 insertions(+), 41 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a519..425739bbdc63 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6018,7 +6018,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * opportunity to pull in more work from other CPUs.
 	 */
 	if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
-		   rq->nr_running == rq->cfs.h_nr_running)) {
+		   rq->nr_running == rq->cfs.h_nr_enqueued)) {
 
 		p = pick_next_task_fair(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a1be00a988bf..6b8cd869a2f4 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -379,7 +379,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		if (rq->cfs.h_nr_running) {
+		if (rq->cfs.h_nr_enqueued) {
 			update_rq_clock(rq);
 			dl_server_stop(&rq->fair_server);
 		}
@@ -392,7 +392,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_running)
+		if (rq->cfs.h_nr_enqueued)
 			dl_server_start(&rq->fair_server);
 	}
 
@@ -845,6 +845,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_enqueued", cfs_rq->h_nr_enqueued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dc43a8daea35..6b7afb69d8ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5471,18 +5471,21 @@ static void set_delayed(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		cfs_rq->h_nr_running--;
 		cfs_rq->h_nr_delayed++;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
 	}
 }
 
-static void clear_delayed(struct sched_entity *se)
+static void clear_delayed(struct sched_entity *se, bool running)
 {
 	se->sched_delayed = 0;
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		if (running)
+			cfs_rq->h_nr_running++;
 		cfs_rq->h_nr_delayed--;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5491,7 +5494,7 @@ static void clear_delayed(struct sched_entity *se)
 
 static inline void finish_delayed_dequeue_entity(struct sched_entity *se)
 {
-	clear_delayed(se);
+	clear_delayed(se, false);
 	if (sched_feat(DELAY_ZERO) && se->vlag > 0)
 		se->vlag = 0;
 }
@@ -5935,8 +5938,8 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, delayed_delta, dequeue = 1;
-	long rq_h_nr_running = rq->cfs.h_nr_running;
+	long running_delta, enqueued_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long rq_h_nr_enqueued = rq->cfs.h_nr_enqueued;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5966,7 +5969,8 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();
 
-	task_delta = cfs_rq->h_nr_running;
+	running_delta = cfs_rq->h_nr_running;
+	enqueued_delta = cfs_rq->h_nr_enqueued;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -5988,9 +5992,10 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		dequeue_entity(qcfs_rq, se, flags);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_enqueued;
 
-		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->h_nr_running -= running_delta;
+		qcfs_rq->h_nr_enqueued -= enqueued_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 
@@ -6011,18 +6016,19 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_enqueued;
 
-		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->h_nr_running -= running_delta;
+		qcfs_rq->h_nr_enqueued -= enqueued_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, task_delta);
+	sub_nr_running(rq, enqueued_delta);
 
 	/* Stop the fair server if throttling resulted in no runnable tasks */
-	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+	if (rq_h_nr_enqueued && !rq->cfs.h_nr_enqueued)
 		dl_server_stop(&rq->fair_server);
 done:
 	/*
@@ -6041,8 +6047,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, delayed_delta;
-	long rq_h_nr_running = rq->cfs.h_nr_running;
+	long running_delta, enqueued_delta, idle_task_delta, delayed_delta;
+	long rq_h_nr_enqueued = rq->cfs.h_nr_enqueued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -6075,7 +6081,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		goto unthrottle_throttle;
 	}
 
-	task_delta = cfs_rq->h_nr_running;
+	running_delta = cfs_rq->h_nr_running;
+	enqueued_delta = cfs_rq->h_nr_enqueued;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -6091,9 +6098,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_enqueued;
 
-		qcfs_rq->h_nr_running += task_delta;
+		qcfs_rq->h_nr_running += running_delta;
+		qcfs_rq->h_nr_enqueued += enqueued_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6109,9 +6117,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_enqueued;
 
-		qcfs_rq->h_nr_running += task_delta;
+		qcfs_rq->h_nr_running += running_delta;
+		qcfs_rq->h_nr_enqueued += enqueued_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6121,11 +6130,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 
 	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_running && rq->cfs.h_nr_running)
+	if (!rq_h_nr_enqueued && rq->cfs.h_nr_enqueued)
 		dl_server_start(&rq->fair_server);
 
 	/* At this point se is NULL and we are at root level*/
-	add_nr_running(rq, task_delta);
+	add_nr_running(rq, enqueued_delta);
 
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
@@ -6840,7 +6849,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
-	if (rq->cfs.h_nr_running > 1) {
+	if (rq->cfs.h_nr_enqueued > 1) {
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
 		u64 slice = se->slice;
 		s64 delta = slice - ran;
@@ -6967,7 +6976,7 @@ requeue_delayed_entity(struct sched_entity *se)
 	}
 
 	update_load_avg(cfs_rq, se, 0);
-	clear_delayed(se);
+	clear_delayed(se, true);
 }
 
 /*
@@ -6983,7 +6992,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int h_nr_delayed = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
-	int rq_h_nr_running = rq->cfs.h_nr_running;
+	int rq_h_nr_enqueued = rq->cfs.h_nr_enqueued;
 	u64 slice = 0;
 
 	/*
@@ -7031,7 +7040,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_entity(cfs_rq, se, flags);
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running++;
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_running++;
+		cfs_rq->h_nr_enqueued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
 
@@ -7055,7 +7066,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running++;
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_running++;
+		cfs_rq->h_nr_enqueued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
 
@@ -7067,7 +7080,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 	}
 
-	if (!rq_h_nr_running && rq->cfs.h_nr_running) {
+	if (!rq_h_nr_enqueued && rq->cfs.h_nr_enqueued) {
 		/* Account for idle runtime */
 		if (!rq->nr_running)
 			dl_server_update_idle_time(rq, rq->curr);
@@ -7114,7 +7127,7 @@ static void set_next_buddy(struct sched_entity *se);
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 {
 	bool was_sched_idle = sched_idle_rq(rq);
-	int rq_h_nr_running = rq->cfs.h_nr_running;
+	int rq_h_nr_enqueued = rq->cfs.h_nr_enqueued;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
@@ -7145,7 +7158,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 
-		cfs_rq->h_nr_running -= h_nr_running;
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_running -= h_nr_running;
+		cfs_rq->h_nr_enqueued -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
@@ -7184,7 +7199,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running -= h_nr_running;
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_running -= h_nr_running;
+		cfs_rq->h_nr_enqueued -= h_nr_running;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
@@ -7198,7 +7215,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 
 	sub_nr_running(rq, h_nr_running);
 
-	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+	if (rq_h_nr_enqueued && !rq->cfs.h_nr_enqueued)
 		dl_server_stop(&rq->fair_server);
 
 	/* balance early to pull high priority tasks */
@@ -12862,7 +12879,7 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 		pulled_task = 1;
 
 	/* Is there a task of a high priority class? */
-	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
+	if (this_rq->nr_running != this_rq->cfs.h_nr_enqueued)
 		pulled_task = -1;
 
 out:
@@ -13549,7 +13566,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 				parent_cfs_rq->idle_nr_running--;
 		}
 
-		idle_task_delta = grp_cfs_rq->h_nr_running -
+		idle_task_delta = grp_cfs_rq->h_nr_enqueued -
 				  grp_cfs_rq->idle_h_nr_running;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
 			idle_task_delta *= -1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index fee75cc2c47b..fc07382361a8 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -321,7 +321,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				cfs_rq->h_nr_running - cfs_rq->h_nr_delayed,
+				cfs_rq->h_nr_running,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1e494af2cd23..b5fe4a622822 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -647,6 +647,7 @@ struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_enqueued;
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 	unsigned int		h_nr_delayed;
@@ -899,11 +900,8 @@ struct dl_rq {
 
 static inline void se_update_runnable(struct sched_entity *se)
 {
-	if (!entity_is_task(se)) {
-		struct cfs_rq *cfs_rq = se->my_q;
-
-		se->runnable_weight = cfs_rq->h_nr_running - cfs_rq->h_nr_delayed;
-	}
+	if (!entity_is_task(se))
+		se->runnable_weight = se->my_q->h_nr_running;
 }
 
 static inline long se_runnable(struct sched_entity *se)
-- 
2.43.0



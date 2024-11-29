Return-Path: <linux-kernel+bounces-425766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B469DEACE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A8E1640B3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EEC19753F;
	Fri, 29 Nov 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfWKi243"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D691A0BFA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897097; cv=none; b=Sgw0LTiCHb7VYwZckdTJptHXAYDBVMyigSk6T4gLuohfj+VrVPAgFrULWfHBZ56TkOU68CghMCGdzGrxT8OOInvLBLcoEHFHTv7siAJkJvkRvDG2/k2balAAfWyibUopIB/HhpLJewl1ZLjA0TxJXp3a9OI8IQ3aOGbOoy2EEpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897097; c=relaxed/simple;
	bh=sJ6TUvAYpMRQPUW4ZyvAwhOJBT7BtjbYSA4d2wZ5F/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecq0kZQpEJpqRyopVHuX9JdOQScGeM9Zu7ktv15ICb284Il1T7jjoy37pmLo9cssA05TiyZ5HWbzN1n4kmdR1y4JiF0nTgrYhZvf8bB1MCQZEl35AEfunXvvP43PJYXYSVxmaP92rSzOwXkUg91leW4Z7dJ/RMp8zLmyQrOlXYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dfWKi243; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ffd711274dso26321721fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897094; x=1733501894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=echnW2zNUNXbTTkfjUQkfrRCQzojIi8MNZBS6ar+qJ4=;
        b=dfWKi243gZ3ATGe8EfcNmnDrKjXGr7jGIQEYnmH7oI0fP/cP03CxhnvpMfxsPAZ5zd
         ayQ/km5/1TntXNMeDT5X8ZRer9x1sHU66hPphMGazgUhmjnACI/Foy8+iu+MxeISSy0h
         BqWRM1LR/VQUE6WZQ7qifch0I5KfobTzREFgGuPgUG9CKbxE7Zq4V5Leqv0J+mE8A2gk
         rQ3Ihv2AzFt8d84zdIUuPEy3zqzWdyleEN5gQWh10FfHhxDKFUFQwJDDtb6+f0E0x4hQ
         st7A7+kQZYVK/FDe1ZJudzG+SfN6mkoizXYtZGz2a++zT2x+VhwjG78MYyZ1yc5eR7vq
         1jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897094; x=1733501894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=echnW2zNUNXbTTkfjUQkfrRCQzojIi8MNZBS6ar+qJ4=;
        b=D7drM2p8U4iAVUPWU1De0gYYyQfOKvcERkHZHnr1mKKee4MCMldc1yO8mFqbUYobwV
         Gu6KLV6JJCV+aBqBNj01GTI+kKt+g8r8VohR0MixktB1o55PXEeeXjdYdlAwemBa97/Z
         J80d/RNP4m3VR9JJnkqKYAbrYtpoECSF3enenDdTJWgDI7AcDZuqcr8VGsiVlkMoJcFa
         vh2fKIXUj0LWNZEVMvHI5w2VdZsIq2loNQ1tjGuTEtsjH8gzmuuKlApnx/IrktPUf5yN
         DtOkjY/cbCFTz62FxtfqGUNaErJz3eEhHV7uOlHbIh2TK+ZvF8P1nECppWziwb61jhQw
         QGsw==
X-Forwarded-Encrypted: i=1; AJvYcCVoUIPNe7oOEY44l+ZJlIiZKMidBSvN/SEV8CqFC9NyTgqrTXrT0wkV3D8aSWN26cpr8U5L51NJZwXAvC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Bi/HQlZEXk8IQWqEDMazrI/6QYs2Lz9oKyqJzONXmSBfnH0C
	/hkV8KtXCI3Q5qGEWIUCl2FN/HZgcFa05vx8O6sxB0GP4lQgzA0kLVluqA4RF31dwjIPo6/fsjl
	puCQ=
X-Gm-Gg: ASbGnctqRfAKoKvue8R7XXt8DDG0QnCsx7HIgzJhmT+hyskyMlHIv9Pb4muyrXMYkRK
	CLTFVFHoJv084vIzzY3mw58iHZDBYh3882ejv5TOK/3Qp22Z8je35Xxaq5/hULzWISKG4KPRYVG
	vzHHIB4xTZhtLF2FIc+fWkD0uLNFBMyNMa55ckLD5NaQ2THY31HZGFOyiuR51h3WeTk8BKocqrN
	zDI684nX4kM4AHhACeJB+PwWu4wTuNRHSA/XiTlS0tx8HAdkSlOGJq+yYw=
X-Google-Smtp-Source: AGHT+IG/qNmu5Nr+yqIUE98ewq5NzL3uSAlKQj6wU5q7bDJWdjfF2pnFmNd/YKeoTcJbaleTjP68WQ==
X-Received: by 2002:a05:600c:3589:b0:434:a4d3:31f0 with SMTP id 5b1f17b1804b1-434afb9533fmr76777135e9.3.1732897083315;
        Fri, 29 Nov 2024 08:18:03 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:02 -0800 (PST)
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
Subject: [PATCH 02/10 v2] sched/fair: Rename h_nr_running into h_nr_queued
Date: Fri, 29 Nov 2024 17:17:48 +0100
Message-ID: <20241129161756.3081386-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241129161756.3081386-1-vincent.guittot@linaro.org>
References: <20241129161756.3081386-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With delayed dequeued feature, a sleeping sched_entity remains queued
in the rq until its lag has elapsed but can't run.
Rename h_nr_running into h_nr_queued to reflect this new behavior.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c  |  2 +-
 kernel/sched/debug.c |  6 +--
 kernel/sched/fair.c  | 88 ++++++++++++++++++++++----------------------
 kernel/sched/pelt.c  |  4 +-
 kernel/sched/sched.h |  4 +-
 5 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5c47d70f4204..ba5e314eb99b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6015,7 +6015,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * opportunity to pull in more work from other CPUs.
 	 */
 	if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
-		   rq->nr_running == rq->cfs.h_nr_running)) {
+		   rq->nr_running == rq->cfs.h_nr_queued)) {
 
 		p = pick_next_task_fair(rq, prev, rf);
 		if (unlikely(p == RETRY_TASK))
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index a1be00a988bf..08d6c2b7caa3 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -379,7 +379,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			return  -EINVAL;
 		}
 
-		if (rq->cfs.h_nr_running) {
+		if (rq->cfs.h_nr_queued) {
 			update_rq_clock(rq);
 			dl_server_stop(&rq->fair_server);
 		}
@@ -392,7 +392,7 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
 					cpu_of(rq));
 
-		if (rq->cfs.h_nr_running)
+		if (rq->cfs.h_nr_queued)
 			dl_server_start(&rq->fair_server);
 	}
 
@@ -844,7 +844,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
-	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
 			cfs_rq->idle_nr_running);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f4ed2ed070e4..c3cc9f784afe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2128,7 +2128,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->load += cpu_load(rq);
 		ns->runnable += cpu_runnable(rq);
 		ns->util += cpu_util_cfs(cpu);
-		ns->nr_running += rq->cfs.h_nr_running;
+		ns->nr_running += rq->cfs.h_nr_queued;
 		ns->compute_capacity += capacity_of(cpu);
 
 		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
@@ -5396,7 +5396,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_running of its group cfs_rq.
+	 *     h_nr_queued of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -5534,7 +5534,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_running of its group cfs_rq.
+	 *     h_nr_queued of its group cfs_rq.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
@@ -5934,8 +5934,8 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, delayed_delta, dequeue = 1;
-	long rq_h_nr_running = rq->cfs.h_nr_running;
+	long queued_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5965,7 +5965,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	walk_tg_tree_from(cfs_rq->tg, tg_throttle_down, tg_nop, (void *)rq);
 	rcu_read_unlock();
 
-	task_delta = cfs_rq->h_nr_running;
+	queued_delta = cfs_rq->h_nr_queued;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -5987,9 +5987,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		dequeue_entity(qcfs_rq, se, flags);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 
@@ -6010,18 +6010,18 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->h_nr_queued -= queued_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
 
 	/* At this point se is NULL and we are at root level*/
-	sub_nr_running(rq, task_delta);
+	sub_nr_running(rq, queued_delta);
 
 	/* Stop the fair server if throttling resulted in no runnable tasks */
-	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
 		dl_server_stop(&rq->fair_server);
 done:
 	/*
@@ -6040,8 +6040,8 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long task_delta, idle_task_delta, delayed_delta;
-	long rq_h_nr_running = rq->cfs.h_nr_running;
+	long queued_delta, idle_task_delta, delayed_delta;
+	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -6074,7 +6074,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		goto unthrottle_throttle;
 	}
 
-	task_delta = cfs_rq->h_nr_running;
+	queued_delta = cfs_rq->h_nr_queued;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -6090,9 +6090,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running += task_delta;
+		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6108,9 +6108,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		se_update_runnable(se);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
-			idle_task_delta = cfs_rq->h_nr_running;
+			idle_task_delta = cfs_rq->h_nr_queued;
 
-		qcfs_rq->h_nr_running += task_delta;
+		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6120,11 +6120,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 
 	/* Start the fair server if un-throttling resulted in new runnable tasks */
-	if (!rq_h_nr_running && rq->cfs.h_nr_running)
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
 		dl_server_start(&rq->fair_server);
 
 	/* At this point se is NULL and we are at root level*/
-	add_nr_running(rq, task_delta);
+	add_nr_running(rq, queued_delta);
 
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
@@ -6839,7 +6839,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
-	if (rq->cfs.h_nr_running > 1) {
+	if (rq->cfs.h_nr_queued > 1) {
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
 		u64 slice = se->slice;
 		s64 delta = slice - ran;
@@ -6982,7 +6982,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int idle_h_nr_running = task_has_idle_policy(p);
 	int h_nr_delayed = 0;
 	int task_new = !(flags & ENQUEUE_WAKEUP);
-	int rq_h_nr_running = rq->cfs.h_nr_running;
+	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	u64 slice = 0;
 
 	/*
@@ -7030,7 +7030,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_entity(cfs_rq, se, flags);
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running++;
+		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
 
@@ -7054,7 +7054,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running++;
+		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
 
@@ -7066,7 +7066,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 			goto enqueue_throttle;
 	}
 
-	if (!rq_h_nr_running && rq->cfs.h_nr_running) {
+	if (!rq_h_nr_queued && rq->cfs.h_nr_queued) {
 		/* Account for idle runtime */
 		if (!rq->nr_running)
 			dl_server_update_idle_time(rq, rq->curr);
@@ -7113,19 +7113,19 @@ static void set_next_buddy(struct sched_entity *se);
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 {
 	bool was_sched_idle = sched_idle_rq(rq);
-	int rq_h_nr_running = rq->cfs.h_nr_running;
+	int rq_h_nr_queued = rq->cfs.h_nr_queued;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	struct task_struct *p = NULL;
 	int idle_h_nr_running = 0;
-	int h_nr_running = 0;
+	int h_nr_queued = 0;
 	int h_nr_delayed = 0;
 	struct cfs_rq *cfs_rq;
 	u64 slice = 0;
 
 	if (entity_is_task(se)) {
 		p = task_of(se);
-		h_nr_running = 1;
+		h_nr_queued = 1;
 		idle_h_nr_running = task_has_idle_policy(p);
 		if (!task_sleep && !task_delayed)
 			h_nr_delayed = !!se->sched_delayed;
@@ -7144,12 +7144,12 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 
-		cfs_rq->h_nr_running -= h_nr_running;
+		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_running;
+			idle_h_nr_running = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
@@ -7183,21 +7183,21 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
-		cfs_rq->h_nr_running -= h_nr_running;
+		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			idle_h_nr_running = h_nr_running;
+			idle_h_nr_running = h_nr_queued;
 
 		/* end evaluation on encountering a throttled cfs_rq */
 		if (cfs_rq_throttled(cfs_rq))
 			return 0;
 	}
 
-	sub_nr_running(rq, h_nr_running);
+	sub_nr_running(rq, h_nr_queued);
 
-	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+	if (rq_h_nr_queued && !rq->cfs.h_nr_queued)
 		dl_server_stop(&rq->fair_server);
 
 	/* balance early to pull high priority tasks */
@@ -10319,7 +10319,7 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	 * When there is more than 1 task, the group_overloaded case already
 	 * takes care of cpu with reduced capacity
 	 */
-	if (rq->cfs.h_nr_running != 1)
+	if (rq->cfs.h_nr_queued != 1)
 		return false;
 
 	return check_cpu_capacity(rq, sd);
@@ -10354,7 +10354,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->group_load += load;
 		sgs->group_util += cpu_util_cfs(i);
 		sgs->group_runnable += cpu_runnable(rq);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_queued;
 
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
@@ -10669,7 +10669,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		sgs->group_util += cpu_util_without(i, p);
 		sgs->group_runnable += cpu_runnable_without(rq, p);
 		local = task_running_on_cpu(i, p);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_running - local;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_queued - local;
 
 		nr_running = rq->nr_running - local;
 		sgs->sum_nr_running += nr_running;
@@ -11451,7 +11451,7 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
-		nr_running = rq->cfs.h_nr_running;
+		nr_running = rq->cfs.h_nr_queued;
 		if (!nr_running)
 			continue;
 
@@ -11610,7 +11610,7 @@ static int need_active_balance(struct lb_env *env)
 	 * available on dst_cpu.
 	 */
 	if (env->idle &&
-	    (env->src_rq->cfs.h_nr_running == 1)) {
+	    (env->src_rq->cfs.h_nr_queued == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
 			return 1;
@@ -12353,7 +12353,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * If there's a runnable CFS task and the current CPU has reduced
 		 * capacity, kick the ILB to see if there's a better CPU to run on:
 		 */
-		if (rq->cfs.h_nr_running >= 1 && check_cpu_capacity(rq, sd)) {
+		if (rq->cfs.h_nr_queued >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
@@ -12851,11 +12851,11 @@ static int sched_balance_newidle(struct rq *this_rq, struct rq_flags *rf)
 	 * have been enqueued in the meantime. Since we're not going idle,
 	 * pretend we pulled a task.
 	 */
-	if (this_rq->cfs.h_nr_running && !pulled_task)
+	if (this_rq->cfs.h_nr_queued && !pulled_task)
 		pulled_task = 1;
 
 	/* Is there a task of a high priority class? */
-	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
+	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
 		pulled_task = -1;
 
 out:
@@ -13542,7 +13542,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 				parent_cfs_rq->idle_nr_running--;
 		}
 
-		idle_task_delta = grp_cfs_rq->h_nr_running -
+		idle_task_delta = grp_cfs_rq->h_nr_queued -
 				  grp_cfs_rq->idle_h_nr_running;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
 			idle_task_delta *= -1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index fee75cc2c47b..2bad0b508dfc 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -275,7 +275,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *
  *   group: [ see update_cfs_group() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = grq->h_nr_running
+ *     se_runnable() = grq->h_nr_queued
  *
  *   runnable_sum = se_runnable() * runnable = grq->runnable_sum
  *   runnable_avg = runnable_sum
@@ -321,7 +321,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				cfs_rq->h_nr_running - cfs_rq->h_nr_delayed,
+				cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 77a05ca0cce7..4677e5412c40 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -646,7 +646,7 @@ struct balance_callback {
 struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
-	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_queued;      /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 	unsigned int		h_nr_delayed;
@@ -901,7 +901,7 @@ static inline void se_update_runnable(struct sched_entity *se)
 	if (!entity_is_task(se)) {
 		struct cfs_rq *cfs_rq = se->my_q;
 
-		se->runnable_weight = cfs_rq->h_nr_running - cfs_rq->h_nr_delayed;
+		se->runnable_weight = cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed;
 	}
 }
 
-- 
2.43.0



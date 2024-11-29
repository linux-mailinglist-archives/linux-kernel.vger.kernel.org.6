Return-Path: <linux-kernel+bounces-425759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBFF9DEAC4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0176B163B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AB419D093;
	Fri, 29 Nov 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P8irERl9"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F547158851
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732897088; cv=none; b=gNNp13z47XEBplgzBq/oTSyF3sbXPLbSjmD9IrA3Emx8iEJk+pQBhHVLpiMh4kxgrwNpOaaWDY0ixzrRr7ocxkB8BMd5LuaLY1NhjHn/stdVMyZLX0vWZcB1/Lc3XwqxR5+PVzkTJMU+xm/snsfYdPNukOWcm1tov5jRYXNygTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732897088; c=relaxed/simple;
	bh=OFCxYR6KvY0frdZoDh9vcMnm72QvWhsQJmXJXppqBo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTHSFXFmsHB/XKpU8fekU8cSOIKAepXGdfsiCwRm0pN/SMqVvKbD23uDWQemd6mPSopc8TM6bMesBu71vfki2JWzyTXvedQnAMUMZl15jKZUKVhbdbN7c9GXyWGKYCgbnFXaUnpHVGIa7hVD1d7Pin6x+XTS5f2IXNwuMVSiV2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P8irERl9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-432d86a3085so17990965e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732897085; x=1733501885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqluTYt4sTu+/yGY3V+MIFvKYHw0c4swhzOIbIipU4s=;
        b=P8irERl9tPf7smQmFQ7js9suvyV9q46KXQx+1OTNRJACL4RK0+21AVxREfeFJEjcuL
         u8V9on0I7nceM+yVVmKIRXp0rfWk08o3Vm1P6GcaQ4KuChAm5DJnIgRmQAHJR5XBJc4Q
         b7IvFWlyuucwHyFbSEGQCVpopAXcXeXAXUi/70dPZOHUTieqIyuiVQtdhbFp1OH54DHQ
         DKfT8Uh//ReceD3NzPlHgP8tjfWrXjLCmD5PPaL/1N549xULMDeo9JIjnRmVZtYahIVM
         6plEG86WYsUqZi8gZatdKGQoahWm3KmroXiFppckbkginy1xfg4Mks5EBhPK9iPPu/NV
         On4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732897085; x=1733501885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqluTYt4sTu+/yGY3V+MIFvKYHw0c4swhzOIbIipU4s=;
        b=P07SzmVh0gnhs2VenS7wzgcJIIV/5IiqbyE0nNTEdYnUpi+RYXHyBtWyxNFhE7OdeC
         PRXO7DkrBemU4kndQGoMoiTwRztJH8B8KTdzoUBETxT6nPicsIGuK6xFvhtzy40Fww7W
         hlErmnAjd3+UROoiBeCTdSNraj7bo/JpimXeqJfQ41Tg0h3dsYoPpxitJZ1Za1LECupX
         feUqP4TJrIHaTEnhTdD6PM/dRl67XNJsqtRNS9xmsooIBA3dXf6HF/TreYkTXZAORDbk
         NCiwVk+yiG4rkBv3bTEPsUB+XK4xV0+6b+9lK/5qGCiwkIJ+f3B2J9YKG1EsXKRt21Jf
         UZCA==
X-Forwarded-Encrypted: i=1; AJvYcCW90wrpsGfGTX2wXAmpSzXiWB5anRBuCJ9nwTwR8QqWhj1UQD+jxzqOJKdLfL/YebMrD2XX48Ywzq6XCto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDNSpxyLokkY833WTLeuEu/21fbvCeMJw/CK6T+NUqlY6oI+yS
	zsMRxSamil4hcLgSwNkWWvMKfHfwHbtFQN7aLErJtotIl6MaYqeHP59fwSju5ac=
X-Gm-Gg: ASbGncvqdIobecbLjxhu9IZXQVluRu3ejVqzo8zJ0LqqLEjbad1j8/8l8oeRPoQIETU
	IKqZ2RQq+/CVfzoM73+ZMpqTOE8wCH8p9aoBIwoHJXcyI1MEr+Xof4DftSWICuLPjQbduO7Eff/
	Mv6OY2sGuq3QeScM9pA8RzuG/6VM0aLh4Wnrw3d2o5PWx5Y6x1u9BwGeab3zqnlbljZHrLBkf8w
	oCuFzvX7XBEvj082ZTFtPJx6OMQqMPrQtH+49xyIopKuxjEkWWtLxGyQ2o=
X-Google-Smtp-Source: AGHT+IEpPAZboWRTS9KwHNuuPBIbRI/hQ2pnd2OWGXIeR/B2iY4/6pU2FtFCd8KDYPg58R6UmPGPuw==
X-Received: by 2002:a05:600c:4747:b0:431:586e:7e7 with SMTP id 5b1f17b1804b1-434a9dbc646mr98515985e9.1.1732897084443;
        Fri, 29 Nov 2024 08:18:04 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:c54b:5636:4db3:1028])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbf95fsm56771665e9.15.2024.11.29.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:18:03 -0800 (PST)
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
Subject: [PATCH 03/10 v2] sched/fair: Add new cfs_rq.h_nr_runnable
Date: Fri, 29 Nov 2024 17:17:49 +0100
Message-ID: <20241129161756.3081386-4-vincent.guittot@linaro.org>
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

With delayed dequeued feature, a sleeping sched_entity remains queued in
the rq until its lag has elapsed. As a result, it stays also visible
in the statistics that are used to balance the system and in particular
the field cfs.h_nr_queued when the sched_entity is associated to a task.

Create a new h_nr_runnable that tracks all queued and runnable tasks and
use it when balancing the load on the system.

h_nr_runnable will be used in several places to make decision on load
balance:
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
 kernel/sched/debug.c |  1 +
 kernel/sched/fair.c  | 45 ++++++++++++++++++++++++++++++--------------
 kernel/sched/pelt.c  |  4 ++--
 kernel/sched/sched.h | 10 ++++------
 4 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 08d6c2b7caa3..fd711cc4d44c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -844,6 +844,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c3cc9f784afe..d5736bde3682 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2128,7 +2128,7 @@ static void update_numa_stats(struct task_numa_env *env,
 		ns->load += cpu_load(rq);
 		ns->runnable += cpu_runnable(rq);
 		ns->util += cpu_util_cfs(cpu);
-		ns->nr_running += rq->cfs.h_nr_queued;
+		ns->nr_running += rq->cfs.h_nr_runnable;
 		ns->compute_capacity += capacity_of(cpu);
 
 		if (find_idle && idle_core < 0 && !rq->nr_running && idle_cpu(cpu)) {
@@ -5396,7 +5396,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_queued of its group cfs_rq.
+	 *     h_nr_runnable of its group cfs_rq.
 	 *   - For group_entity, update its weight to reflect the new share of
 	 *     its group cfs_rq
 	 *   - Add its new weight to cfs_rq->load.weight
@@ -5471,18 +5471,21 @@ static void set_delayed(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		cfs_rq->h_nr_runnable--;
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
+			cfs_rq->h_nr_runnable++;
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
@@ -5534,7 +5537,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * When dequeuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
 	 *   - For group_entity, update its runnable_weight to reflect the new
-	 *     h_nr_queued of its group cfs_rq.
+	 *     h_nr_runnable of its group cfs_rq.
 	 *   - Subtract its previous weight from cfs_rq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs_rq.
@@ -5934,7 +5937,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long queued_delta, runnable_delta, idle_task_delta, delayed_delta, dequeue = 1;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5966,6 +5969,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	rcu_read_unlock();
 
 	queued_delta = cfs_rq->h_nr_queued;
+	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -5990,6 +5994,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued -= queued_delta;
+		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 
@@ -6013,6 +6018,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued -= queued_delta;
+		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
@@ -6040,7 +6046,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, idle_task_delta, delayed_delta;
+	long queued_delta, runnable_delta, idle_task_delta, delayed_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6075,6 +6081,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 
 	queued_delta = cfs_rq->h_nr_queued;
+	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -6093,6 +6100,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued += queued_delta;
+		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6111,6 +6119,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued += queued_delta;
+		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6966,7 +6975,7 @@ requeue_delayed_entity(struct sched_entity *se)
 	}
 
 	update_load_avg(cfs_rq, se, 0);
-	clear_delayed(se);
+	clear_delayed(se, true);
 }
 
 /*
@@ -7030,6 +7039,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_entity(cfs_rq, se, flags);
 		slice = cfs_rq_min_slice(cfs_rq);
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable++;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
@@ -7054,6 +7065,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable++;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
@@ -7144,6 +7157,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable -= h_nr_queued;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
@@ -7183,6 +7198,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable -= h_nr_queued;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
@@ -10319,7 +10336,7 @@ sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
 	 * When there is more than 1 task, the group_overloaded case already
 	 * takes care of cpu with reduced capacity
 	 */
-	if (rq->cfs.h_nr_queued != 1)
+	if (rq->cfs.h_nr_runnable != 1)
 		return false;
 
 	return check_cpu_capacity(rq, sd);
@@ -10354,7 +10371,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		sgs->group_load += load;
 		sgs->group_util += cpu_util_cfs(i);
 		sgs->group_runnable += cpu_runnable(rq);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_queued;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_runnable;
 
 		nr_running = rq->nr_running;
 		sgs->sum_nr_running += nr_running;
@@ -10669,7 +10686,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 		sgs->group_util += cpu_util_without(i, p);
 		sgs->group_runnable += cpu_runnable_without(rq, p);
 		local = task_running_on_cpu(i, p);
-		sgs->sum_h_nr_running += rq->cfs.h_nr_queued - local;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_runnable - local;
 
 		nr_running = rq->nr_running - local;
 		sgs->sum_nr_running += nr_running;
@@ -11451,7 +11468,7 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
-		nr_running = rq->cfs.h_nr_queued;
+		nr_running = rq->cfs.h_nr_runnable;
 		if (!nr_running)
 			continue;
 
@@ -11610,7 +11627,7 @@ static int need_active_balance(struct lb_env *env)
 	 * available on dst_cpu.
 	 */
 	if (env->idle &&
-	    (env->src_rq->cfs.h_nr_queued == 1)) {
+	    (env->src_rq->cfs.h_nr_runnable == 1)) {
 		if ((check_cpu_capacity(env->src_rq, sd)) &&
 		    (capacity_of(env->src_cpu)*sd->imbalance_pct < capacity_of(env->dst_cpu)*100))
 			return 1;
@@ -12353,7 +12370,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * If there's a runnable CFS task and the current CPU has reduced
 		 * capacity, kick the ILB to see if there's a better CPU to run on:
 		 */
-		if (rq->cfs.h_nr_queued >= 1 && check_cpu_capacity(rq, sd)) {
+		if (rq->cfs.h_nr_runnable >= 1 && check_cpu_capacity(rq, sd)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 2bad0b508dfc..7a8534a2deff 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -275,7 +275,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
  *
  *   group: [ see update_cfs_group() ]
  *     se_weight()   = tg->weight * grq->load_avg / tg->load_avg
- *     se_runnable() = grq->h_nr_queued
+ *     se_runnable() = grq->h_nr_runnable
  *
  *   runnable_sum = se_runnable() * runnable = grq->runnable_sum
  *   runnable_avg = runnable_sum
@@ -321,7 +321,7 @@ int __update_load_avg_cfs_rq(u64 now, struct cfs_rq *cfs_rq)
 {
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
-				cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed,
+				cfs_rq->h_nr_runnable,
 				cfs_rq->curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4677e5412c40..e0b05ab43abd 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -646,7 +646,8 @@ struct balance_callback {
 struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
-	unsigned int		h_nr_queued;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_runnable;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_queued;
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 	unsigned int		h_nr_delayed;
@@ -898,11 +899,8 @@ struct dl_rq {
 
 static inline void se_update_runnable(struct sched_entity *se)
 {
-	if (!entity_is_task(se)) {
-		struct cfs_rq *cfs_rq = se->my_q;
-
-		se->runnable_weight = cfs_rq->h_nr_queued - cfs_rq->h_nr_delayed;
-	}
+	if (!entity_is_task(se))
+		se->runnable_weight = se->my_q->h_nr_runnable;
 }
 
 static inline long se_runnable(struct sched_entity *se)
-- 
2.43.0



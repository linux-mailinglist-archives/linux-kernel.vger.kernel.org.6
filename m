Return-Path: <linux-kernel+bounces-540623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C84BA4B2FC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A423516F5E3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590041E9B34;
	Sun,  2 Mar 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fdw7Cuj/"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAC61E9B2E
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932017; cv=none; b=sV0n94iWz+oiYvoBth/7fPBOXO7W9EIFUTH4ml4CXIljHkfdlnsDkX6SmKsoCqTOm7P9D3elPoSPNWsvjoEO4mHSsttjDAF8M2KAXQ5Oqdt3mN1/zv0esRL63FmEE9x1ee2LKqYbGoF0IedVoJhL9+ZIdPVUYrZvsOvUR9L9bMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932017; c=relaxed/simple;
	bh=y5FCWfFLmsduRKElpG7HovceQUJ3S158eZxC8JqxkvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agier1RcLEkylhe39dcGx4ughnCtZxSiZQa/XOopOdN6LN0BMd59aV5LWbauiUVR6uivr3r/W9JqL4cQ0hBTXivB+gqptEVLVaXIqXBSTsRtvtlHgT7QwMTV6rV4MxjVhc5TTGanq6jFzGGPc2/nXJ50XlkRkb+wsGmNSN+g+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fdw7Cuj/; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so22610735e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 08:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740932014; x=1741536814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QJDWaAxbTaZ06HQKgT3VZ8iGIVgt7TTKEF4KOjm0kA=;
        b=Fdw7Cuj/mGwbZZZksaM/LA1bho5s3cWOX42APvVLqh/5iV8sCYVNjpvUIi52YmVUm9
         7jeEpoXsVrvwPKWp4lv2SdS9Vp6t70sfJ22mMJzeaKm4iLdsRYgkY78w14x27p/xkzQQ
         6eM8Wn/+rbMg7ODDymU52DdqiY6oi5dnuaDnH0uLmXJLtg+PNeBPRilF+0JbYml8lZGR
         5XpzuRE24t376U65dN4yrfWJJiK/JEKbC/SuS7pgDkm6VJf6a5W2yaMe//gcmAFIp2sL
         +roA06rc/yobuiZvYDVp+ZnctpmVxZDGjRSQRsxV1Znw2liZWN3wqGGr7DCKAlGNMk/R
         lq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932014; x=1741536814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9QJDWaAxbTaZ06HQKgT3VZ8iGIVgt7TTKEF4KOjm0kA=;
        b=H5xn+vSSzRpe0hUWnXW4MoAt1HdPenURMMcgVZR15YKW5vDUWaGkJk+ivgIcJDrSx9
         UaZhehzDC9T0iAvrRhZb99pOdYbKaRaGGvBFcx2gKoaopWxfr3VixGs+rcOAeQsh7WAa
         /ledhqlMwbCCZYijsLJRRSHIm69565loDNVJh4ACKFK+hZ7a28Ry0ypgaKcvtXyFbZAT
         BzNXZ7NwMc8Hx5XNaJy2UUmWhfufivQuZOguFVIefWtMg0+PIHI1Lwz/N5qP9WHUdQLf
         rHs/wpXpalifLPOWEQVEvMaxJqY6blcqBzeamps0dSjxoSeTPT3Dq+MpM/6HD5V2YE/q
         8h7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoDqafPaxE7Fxfn5dNJ8pBQSSVKktN8q8jiXHxqMPCM4tUHRkIsmwdYHAFOSyI0z2c6GLkTxJEONxcIq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZrQHtR3CSZ7OTirnLLNtNrld2q5e1SYgP4Eg/kZV2dHqJgMQ/
	PZljnu/XoEhPrAo/JOa8u/6+MoDOZvqWQS14w3FjDWoHKdQ5OOnySuP1TvsC1v8=
X-Gm-Gg: ASbGnctwvaiExbt2YeTY3GiAVE9TdJMQZ5TLWh2varcQds7YuPEJ0LMk8spp0KjQzvp
	18M2Ub2i9PlUOl3d6JwPuk5QJ/Ds0EGizIilNIH6cFhIRuZAEmJ+q5+shewPGf+JkwrEBUg8Kp4
	Q1ho+pJRm6sDT17TOdJxn1ng3KwOr0+umoG6IUcSdIcQm6n/zyZ4bB7BYQnurmJjumP8OG2CTtv
	qPfD1AdSQDgk6VjQIjzyenUu5AJYkbccPURdr+em62rPyY0ULS6MHDOKB4vJmXQZNFi6E3lyvBd
	m1hD+IrYly/dBvDh+DOgCVhMgA/pLI11DRq83X2Cx+kWPIuCRKs7
X-Google-Smtp-Source: AGHT+IGDrUGbBBJeI3Z6m3NvQMruF2Of1ytD5KxJBxh0WsbVRQJsMVb/0KPnaTPD35QtvSHpwu6SCw==
X-Received: by 2002:a05:600c:3b9b:b0:43b:c270:49ae with SMTP id 5b1f17b1804b1-43bc2704ae8mr2497795e9.0.1740932013509;
        Sun, 02 Mar 2025 08:13:33 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bb767a977sm25530245e9.18.2025.03.02.08.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:13:32 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com,
	pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	christian.loehle@arm.com,
	luis.machado@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 5/7 v4] sched/fair: Add push task mechanism for EAS
Date: Sun,  2 Mar 2025 17:13:19 +0100
Message-ID: <20250302161321.1476139-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302161321.1476139-1-vincent.guittot@linaro.org>
References: <20250302161321.1476139-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EAS is based on wakeup events to efficiently place tasks on the system, but
there are cases where a task doesn't have wakeup events anymore or at a far
too low pace. For such situation, we can take advantage of the task being
put back in the enqueued list to check if it should be pushed on another
CPU. When the task is alone on the CPU, it's never put back in the enqueued
list; In this special case, we use the tick to run the check.

Wake up events remain the main way to migrate tasks but we now detect
situation where a task is stuck on a CPU by checking that its utilization
is larger than the max available compute capacity (max cpu capacity or
uclamp max setting)

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 220 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |   2 +
 2 files changed, 222 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a9b97bbc085f..c3e383b86808 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7051,6 +7051,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	hrtick_update(rq);
 }
 
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
 static void set_next_buddy(struct sched_entity *se);
 
 /*
@@ -7081,6 +7082,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		h_nr_idle = task_has_idle_policy(p);
 		if (task_sleep || task_delayed || !se->sched_delayed)
 			h_nr_runnable = 1;
+
+		fair_remove_pushable_task(rq, p);
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -8589,6 +8592,197 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	return target;
 }
 
+static inline bool task_stuck_on_cpu(struct task_struct *p, int cpu)
+{
+	unsigned long max_capa, util;
+
+	max_capa = min(get_actual_cpu_capacity(cpu),
+		       uclamp_eff_value(p, UCLAMP_MAX));
+	util = max(task_util_est(p), task_runnable(p));
+
+	/*
+	 * Return true only if the task might not sleep/wakeup because of a low
+	 * compute capacity. Tasks, which wake up regularly, will be handled by
+	 * feec().
+	 */
+	return (util > max_capa);
+}
+
+static inline bool sched_energy_push_task(struct task_struct *p, struct rq *rq)
+{
+	if (p->nr_cpus_allowed == 1)
+		return false;
+
+	if (is_rd_overutilized(rq->rd))
+		return false;
+
+	if (task_stuck_on_cpu(p, cpu_of(rq)))
+		return true;
+
+	return false;
+}
+
+static int active_load_balance_cpu_stop(void *data);
+
+static inline void check_pushable_task(struct task_struct *p, struct rq *rq)
+{
+	int new_cpu, cpu = cpu_of(rq);
+
+	if (!sched_energy_enabled())
+		return;
+
+	if (WARN_ON(!p))
+		return;
+
+	if (WARN_ON(!task_current(rq, p)))
+		return;
+
+	if (is_migration_disabled(p))
+		return;
+
+	/* If there are several task, wait for being put back */
+	if (rq->nr_running > 1)
+		return;
+
+	if (!sched_energy_push_task(p, rq))
+		return;
+
+	new_cpu = find_energy_efficient_cpu(p, cpu);
+
+	if (new_cpu == cpu)
+		return;
+
+	/*
+	 * ->active_balance synchronizes accesses to
+	 * ->active_balance_work.  Once set, it's cleared
+	 * only after active load balance is finished.
+	 */
+	if (!rq->active_balance) {
+		rq->active_balance = 1;
+		rq->push_cpu = new_cpu;
+	} else
+		return;
+
+	raw_spin_rq_unlock(rq);
+	stop_one_cpu_nowait(cpu,
+		active_load_balance_cpu_stop, rq,
+		&rq->active_balance_work);
+	raw_spin_rq_lock(rq);
+}
+
+static inline int has_pushable_tasks(struct rq *rq)
+{
+	return !plist_head_empty(&rq->cfs.pushable_tasks);
+}
+
+static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
+{
+	struct task_struct *p;
+
+	if (!has_pushable_tasks(rq))
+		return NULL;
+
+	p = plist_first_entry(&rq->cfs.pushable_tasks,
+			      struct task_struct, pushable_tasks);
+
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+
+	/*
+	 * Remove task from the pushable list as we try only once after that
+	 * the task has been put back in enqueued list.
+	 */
+	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+
+	return p;
+}
+
+/*
+ * See if the non running fair tasks on this rq can be sent on other CPUs
+ * that fits better with their profile.
+ */
+static bool push_fair_task(struct rq *rq)
+{
+	struct task_struct *next_task;
+	int prev_cpu, new_cpu;
+	struct rq *new_rq;
+
+	next_task = pick_next_pushable_fair_task(rq);
+	if (!next_task)
+		return false;
+
+	if (is_migration_disabled(next_task))
+		return true;
+
+	/* We might release rq lock */
+	get_task_struct(next_task);
+
+	prev_cpu = rq->cpu;
+
+	new_cpu = find_energy_efficient_cpu(next_task, prev_cpu);
+
+	if (new_cpu == prev_cpu)
+		goto out;
+
+	new_rq = cpu_rq(new_cpu);
+
+	if (double_lock_balance(rq, new_rq)) {
+		/* The task has already migrated in between */
+		if (task_cpu(next_task) != rq->cpu) {
+			double_unlock_balance(rq, new_rq);
+			goto out;
+		}
+
+		deactivate_task(rq, next_task, 0);
+		set_task_cpu(next_task, new_cpu);
+		activate_task(new_rq, next_task, 0);
+
+		resched_curr(new_rq);
+
+		double_unlock_balance(rq, new_rq);
+	}
+
+out:
+	put_task_struct(next_task);
+
+	return true;
+}
+
+static void push_fair_tasks(struct rq *rq)
+{
+	/* push_fair_task() will return true if it moved a fair task */
+	while (push_fair_task(rq))
+		;
+}
+
+static DEFINE_PER_CPU(struct balance_callback, fair_push_head);
+
+static inline void fair_queue_pushable_tasks(struct rq *rq)
+{
+	if (!sched_energy_enabled() || !has_pushable_tasks(rq))
+		return;
+
+	queue_balance_callback(rq, &per_cpu(fair_push_head, rq->cpu), push_fair_tasks);
+}
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
+{
+	if (sched_energy_enabled())
+		plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+}
+
+static void fair_add_pushable_task(struct rq *rq, struct task_struct *p)
+{
+	if (sched_energy_enabled() && task_on_rq_queued(p) && !p->se.sched_delayed) {
+		if (sched_energy_push_task(p, rq)) {
+			plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+			plist_node_init(&p->pushable_tasks, p->prio);
+			plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+		}
+	}
+}
+
 /*
  * select_task_rq_fair: Select target runqueue for the waking task in domains
  * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
@@ -8758,6 +8952,10 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return sched_balance_newidle(rq, rf) != 0;
 }
 #else
+static inline void check_pushable_task(struct task_struct *p, struct rq *rq) {}
+static inline void fair_queue_pushable_tasks(struct rq *rq) {}
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p) {}
+static inline void fair_add_pushable_task(struct rq *rq, struct task_struct *p) {}
 static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 #endif /* CONFIG_SMP */
 
@@ -8947,6 +9145,12 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
 		put_prev_entity(cfs_rq, pse);
 		set_next_entity(cfs_rq, se);
 
+		/*
+		 * The previous task might be eligible for being pushed on
+		 * another cpu if it is still active.
+		 */
+		fair_add_pushable_task(rq, prev);
+
 		__set_next_task_fair(rq, p, true);
 	}
 
@@ -9019,6 +9223,13 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
 		cfs_rq = cfs_rq_of(se);
 		put_prev_entity(cfs_rq, se);
 	}
+
+	/*
+	 * The previous task might be eligible for being pushed on another cpu
+	 * if it is still active.
+	 */
+	fair_add_pushable_task(rq, prev);
+
 }
 
 /*
@@ -13151,6 +13362,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
+	check_pushable_task(curr, rq);
 	update_misfit_status(curr, rq);
 	check_update_overutilized_status(task_rq(curr));
 
@@ -13303,6 +13515,8 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
 {
 	struct sched_entity *se = &p->se;
 
+	fair_remove_pushable_task(rq, p);
+
 #ifdef CONFIG_SMP
 	if (task_on_rq_queued(p)) {
 		/*
@@ -13320,6 +13534,11 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
 	if (hrtick_enabled_fair(rq))
 		hrtick_start_fair(rq, p);
 
+	/*
+	 * Try to push prev task before checking misfit for next task as
+	 * the migration of prev can make next fitting the CPU
+	 */
+	fair_queue_pushable_tasks(rq);
 	update_misfit_status(p, rq);
 	sched_fair_update_stop_tick(rq, p);
 }
@@ -13350,6 +13569,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
 	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
 #ifdef CONFIG_SMP
+	plist_head_init(&cfs_rq->pushable_tasks);
 	raw_spin_lock_init(&cfs_rq->removed.lock);
 #endif
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ab16d3d0e51c..2db198dccf21 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -722,6 +722,8 @@ struct cfs_rq {
 	struct list_head	leaf_cfs_rq_list;
 	struct task_group	*tg;	/* group that "owns" this runqueue */
 
+	struct plist_head	pushable_tasks;
+
 	/* Locally cached copy of our task_group's idle value */
 	int			idle;
 
-- 
2.43.0



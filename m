Return-Path: <linux-kernel+bounces-308841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5930966282
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 168581C23AF1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325B91B86F0;
	Fri, 30 Aug 2024 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udcgTNVw"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B217B1B78EA
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023003; cv=none; b=jyij0I4kjHp8S/OOCVND9Blu7IxXj5bEQx+aKHExsQfBeVO+pFlX5fvD84899u2bkBWOkeGxfoAhI9OcxinUIjZEyZS2DRsgAEunPEO31iI6a7ASMGDls400XyKRXyT7XuTG9owdPWCgtodVSHi/MrEevYZuziiUTUwx7DHd0cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023003; c=relaxed/simple;
	bh=8pKBSrpwiuzaUXhTOgUmrL8vOGNInghVvRONHy4UxEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iU9adH/Rf+ZuH7cgxmwyw4fi8XbxG59hyh+jwE33gf1DlvSGPKsBdxzD8kUbQvdBMl2HC/hNcvHd1K7m7O7ncg8zv59DZrkOHVHwHmjhQszRLCYSbhk6LZqpkdFqLrZYT2h0UFwBsKgwY0t4ARySUw0lb6MdeMEzpG8KfR/qJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=udcgTNVw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42bbe809b06so3382775e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725023000; x=1725627800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6AZbyU444PflN+GWii/bOJJEcyRPxrIzNhhYkaQbt4I=;
        b=udcgTNVwxKOwn3ElWHK/Svxv4BChnkL3gfHMImddpI9Qtjcx5qo2GUrVcJRyRXg3Uh
         CA7eVcEfukXuIpObtVQ3NbWF7zGJy7XeD3OpYDY2PzEoENc+yhIPOQFIor0ddfONignW
         BL7Fp3cb59KX7BhKdiF5pENxfSGzBelgA9RiBLBtEWLDmyfqy0Pqy/15OTRQpixb/QP8
         VSKyw5q/rUwbhwxraxZ4bvE+23Jow/APJfz28zxACfmEVIts3AarEMKmp95VxV5MWMZJ
         bQhP0y1dxjqm3lNy5LQ3jYl8yB7tOlC98yvWTmhDsB05tKDLAG2AcyxFF+wo1lE9ll4m
         vusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725023000; x=1725627800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AZbyU444PflN+GWii/bOJJEcyRPxrIzNhhYkaQbt4I=;
        b=mnxWQZT2ADx4OIQt15hOy+U/AyHipXYXLt6GRlWAF2QIdfY5hP0rvG9BmlSNrRpXRS
         kehDEOaHkZfoCg4e9TqWHlSevHL5RISAipNbIKLFBczQMSlqWrwUHSoiRDUFBTbL21Qq
         6HxdfH/IuGngHKqic2POWpyTDECCCQmBFri4x9sZVT2MZDdzVwKueWfh/dNcb727okER
         05qV56hR12etEyRKc4pF6BbtVq25yR3KMS/0yKZjJsWYDHCbulPs8E/pYMfee+eG1ISk
         L32yBHA3/oRT2wEcbhFot9NBYi3QK/ff1xAA9mXPXGypzvxxdOSpvkneBqEZwKV2WFku
         TD3g==
X-Forwarded-Encrypted: i=1; AJvYcCWBXHGizJo8A85iGVZ3/xKbOAJH6N7SNZ+AAfEk+Rpq6IRVSckl3z88BOFJ0FL2eKmX12YrM70lWxo0KY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmOjWkR1j8xhVYqkqk1aMEzs/6UZzPgzOmOSB6G4AptJ0Tln7
	7cAUxe2pt1MaW/8FvpG+FjhDlVjVfO3Ip/RoDonnaCTN9U7MjMboYwGMbnIJTWQ=
X-Google-Smtp-Source: AGHT+IHUKl2vSXfnFoB5bubvWIJnlyFWhcc9ZKlUqMsH5dXPHD53Y5F2O2hN5vOC25T1imv+CmylsA==
X-Received: by 2002:a05:600c:4505:b0:426:60b8:d8ba with SMTP id 5b1f17b1804b1-42bb27a9ca8mr51463945e9.28.1725022999723;
        Fri, 30 Aug 2024 06:03:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3cfc:139d:f91:133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efaf35asm3954076f8f.90.2024.08.30.06.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:03:19 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC PATCH 5/5] sched/fair: Add push task callback for EAS
Date: Fri, 30 Aug 2024 15:03:09 +0200
Message-Id: <20240830130309.2141697-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830130309.2141697-1-vincent.guittot@linaro.org>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EAS is based on wakeup events to efficiently place tasks on the system, but
there are cases where a task will not have wakeup events anymore or at a
far too low pace. For such situation, we can take advantage of the task
being put back in the enqueued list to check if it should be migrated on
another CPU. When the task is the only one running on the CPU, the tick
will check it the task is stuck on this CPU and should migrate on another
one.

Wake up events remain the main way to migrate tasks but we now detect
situation where a task is stuck on a CPU by checking that its utilization
is larger than the max available compute capacity (max cpu capacity or
uclamp max setting)

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c  | 211 +++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |   2 +
 2 files changed, 213 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e46af2416159..41fb18ac118b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5455,6 +5455,7 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 }
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
+static void dequeue_pushable_task(struct cfs_rq *cfs_rq, struct sched_entity *se, bool queue);
 
 static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -5463,6 +5464,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	update_curr(cfs_rq);
 
+	dequeue_pushable_task(cfs_rq, se, false);
+
 	if (flags & DEQUEUE_DELAYED) {
 		SCHED_WARN_ON(!se->sched_delayed);
 	} else {
@@ -5585,6 +5588,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
+
+	dequeue_pushable_task(cfs_rq, se, true);
 }
 
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
@@ -5620,6 +5625,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 }
 
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
+static void enqueue_pushable_task(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 {
@@ -5639,9 +5645,16 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 		__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
+
+		/*
+		 * The previous task might be eligible for pushing it on
+		 * another cpu if it is still active.
+		 */
+		enqueue_pushable_task(cfs_rq, prev);
 	}
 	SCHED_WARN_ON(cfs_rq->curr != prev);
 	cfs_rq->curr = NULL;
+
 }
 
 static void
@@ -8393,6 +8406,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			target_stat.runnable = cpu_runnable(cpu_rq(cpu));
 			target_stat.capa = capacity_of(cpu);
 			target_stat.nr_running = cpu_rq(cpu)->cfs.h_nr_running;
+			if ((p->on_rq) && (cpu == prev_cpu))
+				target_stat.nr_running--;
 
 			/* If the target needs a lower OPP, then look up for
 			 * the corresponding OPP and its associated cost.
@@ -8473,6 +8488,197 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	return target;
 }
 
+static inline bool task_misfit_cpu(struct task_struct *p, int cpu)
+{
+	unsigned long max_capa = get_actual_cpu_capacity(cpu);
+	unsigned long util = task_util_est(p);
+
+	max_capa = min(max_capa, uclamp_eff_value(p, UCLAMP_MAX));
+	util = max(util, task_runnable(p));
+
+	/*
+	 * Return true only if the task might not sleep/wakeup because of a low
+	 * compute capacity. Tasks, which wake up regularly, will be handled by
+	 * feec().
+	 */
+	return (util > max_capa);
+}
+
+static int active_load_balance_cpu_stop(void *data);
+
+static inline void check_misfit_cpu(struct task_struct *p, struct rq *rq)
+{
+	int new_cpu, cpu = cpu_of(rq);
+
+	if (!sched_energy_enabled())
+		return;
+
+	if (WARN_ON(!p))
+		return;
+
+	if (WARN_ON(p != rq->curr))
+		return;
+
+	if (is_migration_disabled(p))
+		return;
+
+	if ((rq->nr_running > 1) || (p->nr_cpus_allowed == 1))
+		return;
+
+	if (!task_misfit_cpu(p, cpu))
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
+
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+
+	/*
+	 * Remove task from the pushable list as we try only once after
+	 * task has been put back in enqueued list.
+	 */
+	plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+
+	return p;
+}
+
+/*
+ * See if the non running fair tasks on this rq
+ * can be sent to some other CPU that fits better with
+ * their profile.
+ */
+static int push_fair_task(struct rq *rq)
+{
+	struct task_struct *next_task;
+	struct rq *new_rq;
+	int prev_cpu, new_cpu;
+	int ret = 0;
+
+	next_task = pick_next_pushable_fair_task(rq);
+	if (!next_task)
+		return 0;
+
+	if (is_migration_disabled(next_task))
+		return 0;
+
+	if (WARN_ON(next_task == rq->curr))
+		return 0;
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
+
+		deactivate_task(rq, next_task, 0);
+		set_task_cpu(next_task, new_cpu);
+		activate_task(new_rq, next_task, 0);
+		ret = 1;
+
+		resched_curr(new_rq);
+
+		double_unlock_balance(rq, new_rq);
+	}
+
+out:
+	put_task_struct(next_task);
+
+	return ret;
+}
+
+static void push_fair_tasks(struct rq *rq)
+{
+	/* push_dl_task() will return true if it moved a -deadline task */
+	while (push_fair_task(rq))
+		;
+}
+
+static DEFINE_PER_CPU(struct balance_callback, fair_push_head);
+
+static inline void fair_queue_push_tasks(struct rq *rq)
+{
+	if (!sched_energy_enabled() || !has_pushable_tasks(rq))
+		return;
+
+	queue_balance_callback(rq, &per_cpu(fair_push_head, rq->cpu), push_fair_tasks);
+}
+static void dequeue_pushable_task(struct cfs_rq *cfs_rq, struct sched_entity *se, bool queue)
+{
+	struct task_struct *p;
+	struct rq *rq;
+
+	if (sched_energy_enabled() && entity_is_task(se)) {
+		rq = rq_of(cfs_rq);
+		p = container_of(se, struct task_struct, se);
+
+		plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
+
+		if (queue)
+			fair_queue_push_tasks(rq);
+	}
+}
+
+static void enqueue_pushable_task(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (sched_energy_enabled() && entity_is_task(se)) {
+		struct task_struct *p = container_of(se, struct task_struct, se);
+		struct rq *rq = rq_of(cfs_rq);
+
+		if ((p->nr_cpus_allowed > 1) && task_misfit_cpu(p, rq->cpu)) {
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
@@ -8642,6 +8848,8 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return sched_balance_newidle(rq, rf) != 0;
 }
 #else
+static inline void dequeue_pushable_task(struct cfs_rq *cfs_rq, struct sched_entity *se, bool queue) {}
+static inline void enqueue_pushable_task(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 #endif /* CONFIG_SMP */
 
@@ -13013,6 +13221,8 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 	check_update_overutilized_status(task_rq(curr));
 
 	task_tick_core(rq, curr);
+
+	check_misfit_cpu(curr, rq);
 }
 
 /*
@@ -13204,6 +13414,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
+	plist_head_init(&cfs_rq->pushable_tasks);
 	cfs_rq->min_vruntime = (u64)(-(1LL << 20));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2f5d658c0631..f3327695d4a3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -672,6 +672,8 @@ struct cfs_rq {
 	struct list_head	leaf_cfs_rq_list;
 	struct task_group	*tg;	/* group that "owns" this runqueue */
 
+	struct plist_head	pushable_tasks;
+
 	/* Locally cached copy of our task_group's idle value */
 	int			idle;
 
-- 
2.34.1



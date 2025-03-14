Return-Path: <linux-kernel+bounces-561800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0AEA61665
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0197463574
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850642036FC;
	Fri, 14 Mar 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YY5PRdk0"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644432045AC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970188; cv=none; b=krzkfkOrA4dLdw+JFThuqTdyK0IEO0/l0ZwLDBdz6vhtuoqHSBTaekPzWbwsK3MrVWLOEUcIUJWp5cpTa5FwEh7EncH4eufHDHjiYbBNGfWZGCltIIW+7TaU+MQQxS5Vj6z7rcP7kr37ri2o0Oph/7QfVVMJ5khfSDR660SRs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970188; c=relaxed/simple;
	bh=zfPl9MyRhHUFx5JuHyEuOGpXeAcBqo+G+6qZNjgbWeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ej7BDtvCmyPMmXALEvtxIea+gIfqT2abyDr0oynXk7TG6EpJJh5il0FSSb9YoM3MsnB0tx8OSYOWb8Jwtbeb0WBefvN8sbJgIB1yBjbRQhuCBls7TYbaelxyoe6qujNC8COrQKOck+lcgpLd6J2/61gPOqWf0eU2UVU1zUWHV1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YY5PRdk0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39129fc51f8so2038338f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741970184; x=1742574984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptn5ue5nomW76WbcZrd99QQFqHz88NDJ1b07bPRv0fA=;
        b=YY5PRdk0/a/oWUgglSvx8Yq2Pre+R0bPEFzDv5GSztbvcDU/5fOANo2wCDD/N+3546
         LzVvRum2tjYipgWjfZJZtwOzH1q0iI8t1cw5wzqrpJ8Zt5r+AlNllykFGHzzTNK30zXU
         m/le3gGjV4G8GZYu4g/qs2jcpz+sac10iXihmE80sYul8jhYsOiOMO73M/nz2dB038xS
         P/RReeZVKTxBilEJk2z7/9FwxYdUtpGDAOm9GBRQYSOffAujye2u78r210rCjTyWHGi9
         eCOHHMvPLImbLBzrcdgcByqzvZcGPGr9qZGon5sHCt0/yS/QiG3I3EOrrPdpd4GYEaq3
         Cacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970184; x=1742574984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptn5ue5nomW76WbcZrd99QQFqHz88NDJ1b07bPRv0fA=;
        b=mE7FhZ/LBpKZT20Tei0ap0rVFEp2eSYVkM7/Hw2w/qk/79hAmx4zoNSL2XN8yM8+91
         Xezm7aTENGtIhMyvbYgJs2yFn6AxEbhwykwxqD2jBoWlf6H8aN1T7/hC2bbIsLYje3Fw
         Gf7pqAV+2bM2o3rVkxU0zXk9HQJawkvRnxAiJmhU3p435tmBf0gkeMMYi+1Z8I89Izqt
         x0/1d27YpKRpV+hoqK+gNQk/D3rce2JXn6Q6VkOsG9wviYNGO/V+WTyA7Js7P3ME/y7L
         XYEfeSXUp71+uYsHxaF07X7P0qu9U+17gor6MtXE3o8vCLCxWbsskEJliGRaBDNGdLpb
         hDRw==
X-Forwarded-Encrypted: i=1; AJvYcCWNRdLpxnPneWZrkXK6P+SFoajl5uI8M6JjIVgYPT2e7cHIp4VilIMb/BfQwUP5oR+rWnNgOpB7asnWdWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqVkEDMWMMqrTZloVJX94sz+d3f+lqeqsvrNoq1f7+42AVjunz
	09tNfb4fHT+LCHGepXRcvui2jWJ4ey1vj1i6FofR1+V0eT56zm8lSNH7o7BCY4w=
X-Gm-Gg: ASbGncudyit8cjVZqQ+mYadOxJE2pGdD8ALtEOdRp+DXgIRrQZtbq3jgkFdoPlkdkYY
	VioUxRwXSq5jDwtT6uzxBnNUyl2SOKzSOfqjCtiX5pzn705JyseqbkmGoqP2lX2C2PVGo9UpI0y
	XI0qKZpZUnoapPPajLDH/9giWyROplcd9PdEy48v12Qq5heMboB/mGHJZVEsInj+4A+e2jb85wQ
	z9fl3zDVT4SpHvdn4FRI7fcPq7YNn11WxdxUlEUyNLxKf+uCWiajPsqjWrgf3WJFoCFjd++JOIl
	0KJiKJazYN5p0wfZZkhPNXQKh5E18ftim1gA/bgdJjjvlFW/f3Vn
X-Google-Smtp-Source: AGHT+IEMJJw1TuZxTASB021QRnNdTISAQj7oeq45fYkNbkF8F4bcckk9ewi8RoxByDAptytLNc0sQw==
X-Received: by 2002:a5d:47cc:0:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-3971ee43fc3mr4704671f8f.42.1741970184408;
        Fri, 14 Mar 2025 09:36:24 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:329b:9a6:20f4:3754])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm6072925f8f.78.2025.03.14.09.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:36:23 -0700 (PDT)
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
Subject: [PATCH 5/7 v6] sched/fair: Add push task mechanism for EAS
Date: Fri, 14 Mar 2025 17:36:12 +0100
Message-ID: <20250314163614.1356125-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314163614.1356125-1-vincent.guittot@linaro.org>
References: <20250314163614.1356125-1-vincent.guittot@linaro.org>
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
index fa23e48c1965..9a95d2eb168e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7053,6 +7053,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	hrtick_update(rq);
 }
 
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
 static void set_next_buddy(struct sched_entity *se);
 
 /*
@@ -7083,6 +7084,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		h_nr_idle = task_has_idle_policy(p);
 		if (task_sleep || task_delayed || !se->sched_delayed)
 			h_nr_runnable = 1;
+
+		fair_remove_pushable_task(rq, p);
 	} else {
 		cfs_rq = group_cfs_rq(se);
 		slice = cfs_rq_min_slice(cfs_rq);
@@ -8591,6 +8594,197 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -8760,6 +8954,10 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	return sched_balance_newidle(rq, rf) != 0;
 }
 #else
+static inline void check_pushable_task(struct task_struct *p, struct rq *rq) {}
+static inline void fair_queue_pushable_tasks(struct rq *rq) {}
+static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p) {}
+static inline void fair_add_pushable_task(struct rq *rq, struct task_struct *p) {}
 static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 #endif /* CONFIG_SMP */
 
@@ -8949,6 +9147,12 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
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
 
@@ -9021,6 +9225,13 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
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
index 023b844159c9..51dd9bc55a0d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -689,6 +689,8 @@ struct cfs_rq {
 		unsigned long	runnable_avg;
 	} removed;
 
+	struct plist_head	pushable_tasks;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	u64			last_update_tg_load_avg;
 	unsigned long		tg_load_avg_contrib;
-- 
2.43.0



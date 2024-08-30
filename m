Return-Path: <linux-kernel+bounces-308839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25455966281
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D6F1F2215E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851E1B86C4;
	Fri, 30 Aug 2024 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkDRb6jk"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C541AF4EB
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023002; cv=none; b=QRmSmmSBkC26TBGMsHCtPofwhX3g2Q0qSjsf3Fm8hm1VbZHXDWTb8HbZc5GT1CL8pNPuZq99GJqvRjmpQnarPL2gPkgvQejYQzDppwTRkT8Fk1GlKvrGISGA4ARaaBHyPkgMqj3agTFAP0f9PoksTGEWgrLeH+2m9z6jGrOxwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023002; c=relaxed/simple;
	bh=9HmsRl1ZKBTRl2+MDp0/GUQxxay3vv93aRdinbjdA+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPxmiYP4pf3A7HK/BMUnXQmExGD6wbtUN+Cndc6EXKXyhfl2HaGsAgCoBaZ1hQeQf3eacZbTGsGqCZPKY000ZjS/N3VaIeLL6HIxCOYWXIAyezENLV3ZT3yOuzpQK/uRMc5AppSBewGQCbeeIqr8+vIastht8QwsnG5ylFz2eO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GkDRb6jk; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bb885f97eso7886035e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725022998; x=1725627798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wp1EI73bJNLlvb/fdhUIeKhwRhBXZtilTY/v4ngKN+U=;
        b=GkDRb6jkOkQR2acMr0NCfF+JtiU/da+EeLmzTFG95P5rYHXkpRtUOCbmDP9cK37KK6
         hg0sxYOnRFqIITbZlzwVlTWLJZ0SL65GB2HicLu8WtD4FateRgkaprvN3eF+dBSWQQHK
         oh1W+7Zj8aZPcxttDYjpLvUMZwE3fqpM6JejvMYdqbd0tdCJhUFWPTSLieUHZWD+6Pc9
         UxY8LxYQBV1rOGDiafv4OBawxJuwJ9awc58rSZROz3DjoMs6yLRsVYy4Y+l4OzuUEKmz
         Sp5cJ+S7MP9Mqp7CQL6g1qK9Qkv4UZOSheSWpc1RTcXDq0yF2aZXnDUmdiDpSs+0i9gJ
         oebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022998; x=1725627798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wp1EI73bJNLlvb/fdhUIeKhwRhBXZtilTY/v4ngKN+U=;
        b=LgpcyDFDtZ7hdshZwASpmadnREHYvTgZfobCQDRlNXV+vrhrdUlzq+gbYVCj77D5dt
         fkpGgOLqArGUjult8U8aPSMZ1NjDrgJDtozKUf6ab21ZibXpCfAWiuytoE9vGgxe3qb9
         PUZTFB5rZQmju3opZ0xglLTuy0XdZPqM+ctS5ROz0Lb0Hx+k6tpbRKnXYpSQOXdaRUrY
         t42cmARJiTCYAA1GNbNbeyHu2H4/Vdb/9Baphrfn+sy0uGEpaYUMWgtRZjPNEGdgFyrv
         cnDBNUUXLuLXXzWihqMoJaaarfmeXzRBmzjGddfr3rLcnl5gU5MADKL1ExNN1AXeWUDi
         BcQA==
X-Forwarded-Encrypted: i=1; AJvYcCWcGRZa56iBQGwHrsOBkrix/CQ+KNtJFFOetD78Ak9M2ysJGY3NzvBiq3aOxvb2vkh3ycsRVVnMb04cN2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbNtLg90/erEJ+LiGGoCb3oXDqHt3JGVSVAXdhjDWYXIwBTFwL
	z20LMJ3UUFJdEvJ+yUvOMXZzhBHG2vAteLvxTXOFo06LNCAd3JHJqEOjYHmgoXg=
X-Google-Smtp-Source: AGHT+IFX8zpmHavq8reISVu7Tm0irwOFXrJsHyMOkhF+Dbv+Ryx403SQBh+h9344ToameGHYo1oymg==
X-Received: by 2002:a05:600c:1ca8:b0:426:5b17:8458 with SMTP id 5b1f17b1804b1-42bbb693013mr14983135e9.12.1725022997737;
        Fri, 30 Aug 2024 06:03:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3cfc:139d:f91:133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efaf35asm3954076f8f.90.2024.08.30.06.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:03:17 -0700 (PDT)
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
Subject: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of spare capacity
Date: Fri, 30 Aug 2024 15:03:07 +0200
Message-Id: <20240830130309.2141697-4-vincent.guittot@linaro.org>
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

feec() looks for the CPU with highest spare capacity in a PD assuming that
it will be the best CPU from a energy efficiency PoV because it will
require the smallest increase of OPP. Although this is true generally
speaking, this policy also filters some others CPUs which will be as
efficients because of using the same OPP.
In fact, we really care about the cost of the new OPP that will be
selected to handle the waking task. In many cases, several CPUs will end
up selecting the same OPP and as a result using the same energy cost. In
these cases, we can use other metrics to select the best CPU for the same
energy cost.

Rework feec() to look 1st for the lowest cost in a PD and then the most
performant CPU between CPUs.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
 1 file changed, 244 insertions(+), 222 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e67d6029b269..2273eecf6086 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8081,29 +8081,37 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
 }
 
 /*
- * energy_env - Utilization landscape for energy estimation.
- * @task_busy_time: Utilization contribution by the task for which we test the
- *                  placement. Given by eenv_task_busy_time().
- * @pd_busy_time:   Utilization of the whole perf domain without the task
- *                  contribution. Given by eenv_pd_busy_time().
- * @cpu_cap:        Maximum CPU capacity for the perf domain.
- * @pd_cap:         Entire perf domain capacity. (pd->nr_cpus * cpu_cap).
- */
-struct energy_env {
-	unsigned long task_busy_time;
-	unsigned long pd_busy_time;
-	unsigned long cpu_cap;
-	unsigned long pd_cap;
+ * energy_cpu_stat - Utilization landscape for energy estimation.
+ * @idx :        Index of the OPP in the performance domain
+ * @cost :       Cost of the OPP
+ * @max_perf :   Compute capacity of OPP
+ * @min_perf :   Compute capacity of the previous OPP
+ * @capa :       Capacity of the CPU
+ * @runnable :   runnbale_avg of the CPU
+ * @nr_running : number of cfs running task
+ * @fits :       Fits level of the CPU
+ * @cpu :        current best CPU
+ */
+struct energy_cpu_stat {
+	unsigned long idx;
+	unsigned long cost;
+	unsigned long max_perf;
+	unsigned long min_perf;
+	unsigned long capa;
+	unsigned long util;
+	unsigned long runnable;
+	unsigned int nr_running;
+	int fits;
+	int cpu;
 };
 
 /*
- * Compute the task busy time for compute_energy(). This time cannot be
- * injected directly into effective_cpu_util() because of the IRQ scaling.
+ * Compute the task busy time for computing its energy impact. This time cannot
+ * be injected directly into effective_cpu_util() because of the IRQ scaling.
  * The latter only makes sense with the most recent CPUs where the task has
  * run.
  */
-static inline void eenv_task_busy_time(struct energy_env *eenv,
-				       struct task_struct *p, int prev_cpu)
+static inline unsigned long task_busy_time(struct task_struct *p, int prev_cpu)
 {
 	unsigned long busy_time, max_cap = arch_scale_cpu_capacity(prev_cpu);
 	unsigned long irq = cpu_util_irq(cpu_rq(prev_cpu));
@@ -8113,124 +8121,152 @@ static inline void eenv_task_busy_time(struct energy_env *eenv,
 	else
 		busy_time = scale_irq_capacity(task_util_est(p), irq, max_cap);
 
-	eenv->task_busy_time = busy_time;
+	return busy_time;
 }
 
-/*
- * Compute the perf_domain (PD) busy time for compute_energy(). Based on the
- * utilization for each @pd_cpus, it however doesn't take into account
- * clamping since the ratio (utilization / cpu_capacity) is already enough to
- * scale the EM reported power consumption at the (eventually clamped)
- * cpu_capacity.
- *
- * The contribution of the task @p for which we want to estimate the
- * energy cost is removed (by cpu_util()) and must be calculated
- * separately (see eenv_task_busy_time). This ensures:
- *
- *   - A stable PD utilization, no matter which CPU of that PD we want to place
- *     the task on.
- *
- *   - A fair comparison between CPUs as the task contribution (task_util())
- *     will always be the same no matter which CPU utilization we rely on
- *     (util_avg or util_est).
- *
- * Set @eenv busy time for the PD that spans @pd_cpus. This busy time can't
- * exceed @eenv->pd_cap.
- */
-static inline void eenv_pd_busy_time(struct energy_env *eenv,
-				     struct cpumask *pd_cpus,
-				     struct task_struct *p)
+/* Estimate the utilization of the CPU that is then used to select the OPP */
+static unsigned long find_cpu_max_util(int cpu, struct task_struct *p, int dst_cpu)
 {
-	unsigned long busy_time = 0;
-	int cpu;
+	unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
+	unsigned long eff_util, min, max;
+
+	/*
+	 * Performance domain frequency: utilization clamping
+	 * must be considered since it affects the selection
+	 * of the performance domain frequency.
+	 */
+	eff_util = effective_cpu_util(cpu, util, &min, &max);
 
-	for_each_cpu(cpu, pd_cpus) {
-		unsigned long util = cpu_util(cpu, p, -1, 0);
+	/* Task's uclamp can modify min and max value */
+	if (uclamp_is_used() && cpu == dst_cpu) {
+		min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
 
-		busy_time += effective_cpu_util(cpu, util, NULL, NULL);
+		/*
+		 * If there is no active max uclamp constraint,
+		 * directly use task's one, otherwise keep max.
+		 */
+		if (uclamp_rq_is_idle(cpu_rq(cpu)))
+			max = uclamp_eff_value(p, UCLAMP_MAX);
+		else
+			max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
 	}
 
-	eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
+	eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
+	return eff_util;
 }
 
-/*
- * Compute the maximum utilization for compute_energy() when the task @p
- * is placed on the cpu @dst_cpu.
- *
- * Returns the maximum utilization among @eenv->cpus. This utilization can't
- * exceed @eenv->cpu_cap.
- */
-static inline unsigned long
-eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
-		 struct task_struct *p, int dst_cpu)
+/* Estimate the utilization of the CPU without the task */
+static unsigned long find_cpu_actual_util(int cpu, struct task_struct *p)
 {
-	unsigned long max_util = 0;
-	int cpu;
+	unsigned long util = cpu_util(cpu, p, -1, 0);
+	unsigned long eff_util;
 
-	for_each_cpu(cpu, pd_cpus) {
-		struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
-		unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
-		unsigned long eff_util, min, max;
+	eff_util = effective_cpu_util(cpu, util, NULL, NULL);
 
-		/*
-		 * Performance domain frequency: utilization clamping
-		 * must be considered since it affects the selection
-		 * of the performance domain frequency.
-		 * NOTE: in case RT tasks are running, by default the min
-		 * utilization can be max OPP.
-		 */
-		eff_util = effective_cpu_util(cpu, util, &min, &max);
+	return eff_util;
+}
 
-		/* Task's uclamp can modify min and max value */
-		if (tsk && uclamp_is_used()) {
-			min = max(min, uclamp_eff_value(p, UCLAMP_MIN));
+/* Find the cost of a performance domain for the estimated utilization */
+static inline void find_pd_cost(struct em_perf_domain *pd,
+				unsigned long max_util,
+				struct energy_cpu_stat *stat)
+{
+	struct em_perf_table *em_table;
+	struct em_perf_state *ps;
+	int i;
 
-			/*
-			 * If there is no active max uclamp constraint,
-			 * directly use task's one, otherwise keep max.
-			 */
-			if (uclamp_rq_is_idle(cpu_rq(cpu)))
-				max = uclamp_eff_value(p, UCLAMP_MAX);
-			else
-				max = max(max, uclamp_eff_value(p, UCLAMP_MAX));
-		}
+	/*
+	 * Find the lowest performance state of the Energy Model above the
+	 * requested performance.
+	 */
+	em_table = rcu_dereference(pd->em_table);
+	i = em_pd_get_efficient_state(em_table->state, pd->nr_perf_states,
+				      max_util, pd->flags);
+	ps = &em_table->state[i];
 
-		eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
-		max_util = max(max_util, eff_util);
+	/* Save the cost and performance range of the OPP */
+	stat->max_perf = ps->performance;
+	stat->cost = ps->cost;
+	i = em_pd_get_previous_state(em_table->state, pd->nr_perf_states,
+				      i, pd->flags);
+	if (i < 0)
+		stat->min_perf = 0;
+	else {
+		ps = &em_table->state[i];
+		stat->min_perf = ps->performance;
 	}
-
-	return min(max_util, eenv->cpu_cap);
 }
 
-/*
- * compute_energy(): Use the Energy Model to estimate the energy that @pd would
- * consume for a given utilization landscape @eenv. When @dst_cpu < 0, the task
- * contribution is ignored.
- */
-static inline unsigned long
-compute_energy(struct energy_env *eenv, struct perf_domain *pd,
-	       struct cpumask *pd_cpus, struct task_struct *p, int dst_cpu)
+/*Check if the CPU can handle the waking task */
+static int check_cpu_with_task(struct task_struct *p, int cpu)
 {
-	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
-	unsigned long busy_time = eenv->pd_busy_time;
-	unsigned long energy;
+	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
+	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
+	unsigned long util_min = p_util_min;
+	unsigned long util_max = p_util_max;
+	unsigned long util = cpu_util(cpu, p, cpu, 0);
+	struct rq *rq = cpu_rq(cpu);
 
-	if (dst_cpu >= 0)
-		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
+	/*
+	 * Skip CPUs that cannot satisfy the capacity request.
+	 * IOW, placing the task there would make the CPU
+	 * overutilized. Take uclamp into account to see how
+	 * much capacity we can get out of the CPU; this is
+	 * aligned with sched_cpu_util().
+	 */
+	if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
+		unsigned long rq_util_min, rq_util_max;
+		/*
+		 * Open code uclamp_rq_util_with() except for
+		 * the clamp() part. I.e.: apply max aggregation
+		 * only. util_fits_cpu() logic requires to
+		 * operate on non clamped util but must use the
+		 * max-aggregated uclamp_{min, max}.
+		 */
+		rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
+		rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
+		util_min = max(rq_util_min, p_util_min);
+		util_max = max(rq_util_max, p_util_max);
+	}
+	return util_fits_cpu(util, util_min, util_max, cpu);
+}
 
-	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+/* For a same cost, select the CPU that will povide best performance for the task */
+static bool select_best_cpu(struct energy_cpu_stat *target,
+			    struct energy_cpu_stat *min,
+			    int prev, struct sched_domain *sd)
+{
+	/*  Select the one with the least number of running tasks */
+	if (target->nr_running < min->nr_running)
+		return true;
+	if (target->nr_running > min->nr_running)
+		return false;
 
-	trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
+	/* Favor previous CPU otherwise */
+	if (target->cpu == prev)
+		return true;
+	if (min->cpu == prev)
+		return false;
 
-	return energy;
+	/*
+	 * Choose CPU with lowest contention. One might want to consider load instead of
+	 * runnable but we are supposed to not be overutilized so there is enough compute
+	 * capacity for everybody.
+	 */
+	if ((target->runnable * min->capa * sd->imbalance_pct) >=
+			(min->runnable * target->capa * 100))
+		return false;
+
+	return true;
 }
 
 /*
  * find_energy_efficient_cpu(): Find most energy-efficient target CPU for the
- * waking task. find_energy_efficient_cpu() looks for the CPU with maximum
- * spare capacity in each performance domain and uses it as a potential
- * candidate to execute the task. Then, it uses the Energy Model to figure
- * out which of the CPU candidates is the most energy-efficient.
+ * waking task. find_energy_efficient_cpu() looks for the CPU with the lowest
+ * power cost (usually with maximum spare capacity but not always) in each
+ * performance domain and uses it as a potential candidate to execute the task.
+ * Then, it uses the Energy Model to figure out which of the CPU candidates is
+ * the most energy-efficient.
  *
  * The rationale for this heuristic is as follows. In a performance domain,
  * all the most energy efficient CPU candidates (according to the Energy
@@ -8267,17 +8303,14 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
-	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
-	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
-	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
+	unsigned long task_util;
+	unsigned long best_nrg = ULONG_MAX;
+	int best_fits = -1;
+	int best_cpu = -1;
 	struct root_domain *rd = this_rq()->rd;
-	int cpu, best_energy_cpu, target = -1;
-	int prev_fits = -1, best_fits = -1;
-	unsigned long best_actual_cap = 0;
-	unsigned long prev_actual_cap = 0;
+	int cpu, target = -1;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
-	struct energy_env eenv;
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
@@ -8296,20 +8329,21 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	target = prev_cpu;
 
-	sync_entity_load_avg(&p->se);
-	if (!task_util_est(p) && p_util_min == 0)
-		goto unlock;
 
-	eenv_task_busy_time(&eenv, p, prev_cpu);
+	sync_entity_load_avg(&p->se);
+	task_util = task_busy_time(p, prev_cpu);
 
 	for (; pd; pd = pd->next) {
-		unsigned long util_min = p_util_min, util_max = p_util_max;
-		unsigned long cpu_cap, cpu_actual_cap, util;
-		long prev_spare_cap = -1, max_spare_cap = -1;
-		unsigned long rq_util_min, rq_util_max;
-		unsigned long cur_delta, base_energy;
-		int max_spare_cap_cpu = -1;
-		int fits, max_fits = -1;
+		unsigned long cpu_actual_cap, max_cost = 0;
+		unsigned long pd_actual_util = 0, delta_nrg = 0;
+		struct energy_cpu_stat target_stat;
+		struct energy_cpu_stat min_stat = {
+			.cost = ULONG_MAX,
+			.max_perf = ULONG_MAX,
+			.min_perf = ULONG_MAX,
+			.fits = -2,
+			.cpu = -1,
+		};
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -8320,13 +8354,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		cpu = cpumask_first(cpus);
 		cpu_actual_cap = get_actual_cpu_capacity(cpu);
 
-		eenv.cpu_cap = cpu_actual_cap;
-		eenv.pd_cap = 0;
-
+		/* In a PD, the CPU with the lowest cost will be the most efficient */
 		for_each_cpu(cpu, cpus) {
-			struct rq *rq = cpu_rq(cpu);
-
-			eenv.pd_cap += cpu_actual_cap;
+			unsigned long target_perf;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 				continue;
@@ -8334,120 +8364,112 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 				continue;
 
-			util = cpu_util(cpu, p, cpu, 0);
-			cpu_cap = capacity_of(cpu);
+			target_stat.fits = check_cpu_with_task(p, cpu);
+
+			if (!target_stat.fits)
+				continue;
+
+			/* 1st select the CPU that fits best */
+			if (target_stat.fits < min_stat.fits)
+				continue;
+
+			/* Then select the CPU with lowest cost */
+
+			/* Get the performance of the CPU w/ waking task. */
+			target_perf = find_cpu_max_util(cpu, p, cpu);
+			target_perf = min(target_perf, cpu_actual_cap);
+
+			/* Needing a higher OPP means a higher cost */
+			if (target_perf > min_stat.max_perf)
+				continue;
 
 			/*
-			 * Skip CPUs that cannot satisfy the capacity request.
-			 * IOW, placing the task there would make the CPU
-			 * overutilized. Take uclamp into account to see how
-			 * much capacity we can get out of the CPU; this is
-			 * aligned with sched_cpu_util().
+			 * At this point, target's cost can be either equal or
+			 * lower than the current minimum cost.
 			 */
-			if (uclamp_is_used() && !uclamp_rq_is_idle(rq)) {
-				/*
-				 * Open code uclamp_rq_util_with() except for
-				 * the clamp() part. I.e.: apply max aggregation
-				 * only. util_fits_cpu() logic requires to
-				 * operate on non clamped util but must use the
-				 * max-aggregated uclamp_{min, max}.
-				 */
-				rq_util_min = uclamp_rq_get(rq, UCLAMP_MIN);
-				rq_util_max = uclamp_rq_get(rq, UCLAMP_MAX);
 
-				util_min = max(rq_util_min, p_util_min);
-				util_max = max(rq_util_max, p_util_max);
-			}
+			/* Gather more statistics */
+			target_stat.cpu = cpu;
+			target_stat.runnable = cpu_runnable(cpu_rq(cpu));
+			target_stat.capa = capacity_of(cpu);
+			target_stat.nr_running = cpu_rq(cpu)->cfs.h_nr_running;
 
-			fits = util_fits_cpu(util, util_min, util_max, cpu);
-			if (!fits)
+			/* If the target needs a lower OPP, then look up for
+			 * the corresponding OPP and its associated cost.
+			 * Otherwise at same cost level, select the CPU which
+			 * provides best performance.
+			 */
+			if (target_perf < min_stat.min_perf)
+				find_pd_cost(pd->em_pd, target_perf, &target_stat);
+			else if (!select_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
 				continue;
 
-			lsub_positive(&cpu_cap, util);
-
-			if (cpu == prev_cpu) {
-				/* Always use prev_cpu as a candidate. */
-				prev_spare_cap = cpu_cap;
-				prev_fits = fits;
-			} else if ((fits > max_fits) ||
-				   ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
-				/*
-				 * Find the CPU with the maximum spare capacity
-				 * among the remaining CPUs in the performance
-				 * domain.
-				 */
-				max_spare_cap = cpu_cap;
-				max_spare_cap_cpu = cpu;
-				max_fits = fits;
-			}
+			/* Save the new most efficient CPU of the PD */
+			min_stat = target_stat;
 		}
 
-		if (max_spare_cap_cpu < 0 && prev_spare_cap < 0)
+		if (min_stat.cpu == -1)
 			continue;
 
-		eenv_pd_busy_time(&eenv, cpus, p);
-		/* Compute the 'base' energy of the pd, without @p */
-		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
+		if (min_stat.fits < best_fits)
+			continue;
 
-		/* Evaluate the energy impact of using prev_cpu. */
-		if (prev_spare_cap > -1) {
-			prev_delta = compute_energy(&eenv, pd, cpus, p,
-						    prev_cpu);
-			/* CPU utilization has changed */
-			if (prev_delta < base_energy)
-				goto unlock;
-			prev_delta -= base_energy;
-			prev_actual_cap = cpu_actual_cap;
-			best_delta = min(best_delta, prev_delta);
-		}
+		/* Idle system costs nothing */
+		target_stat.max_perf = 0;
+		target_stat.cost = 0;
 
-		/* Evaluate the energy impact of using max_spare_cap_cpu. */
-		if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
-			/* Current best energy cpu fits better */
-			if (max_fits < best_fits)
-				continue;
+		/* Estimate utilization and cost without p */
+		for_each_cpu(cpu, cpus) {
+			unsigned long target_util;
 
-			/*
-			 * Both don't fit performance hint (i.e. uclamp_min)
-			 * but best energy cpu has better capacity.
-			 */
-			if ((max_fits < 0) &&
-			    (cpu_actual_cap <= best_actual_cap))
-				continue;
+			/* Accumulate actual utilization w/o task p */
+			pd_actual_util += find_cpu_actual_util(cpu, p);
 
-			cur_delta = compute_energy(&eenv, pd, cpus, p,
-						   max_spare_cap_cpu);
-			/* CPU utilization has changed */
-			if (cur_delta < base_energy)
-				goto unlock;
-			cur_delta -= base_energy;
+			/* Get the max utilization of the CPU w/o task p */
+			target_util = find_cpu_max_util(cpu, p, -1);
+			target_util = min(target_util, cpu_actual_cap);
 
-			/*
-			 * Both fit for the task but best energy cpu has lower
-			 * energy impact.
-			 */
-			if ((max_fits > 0) && (best_fits > 0) &&
-			    (cur_delta >= best_delta))
+			/* Current OPP is enough */
+			if (target_util <= target_stat.max_perf)
 				continue;
 
-			best_delta = cur_delta;
-			best_energy_cpu = max_spare_cap_cpu;
-			best_fits = max_fits;
-			best_actual_cap = cpu_actual_cap;
+			/* Compute and save the cost of the OPP */
+			find_pd_cost(pd->em_pd, target_util, &target_stat);
+			max_cost = target_stat.cost;
 		}
-	}
-	rcu_read_unlock();
 
-	if ((best_fits > prev_fits) ||
-	    ((best_fits > 0) && (best_delta < prev_delta)) ||
-	    ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
-		target = best_energy_cpu;
+		/* Add the NRG cost of p */
+		delta_nrg = task_util * min_stat.cost;
 
-	return target;
+		/* Compute the NRG cost of others running at higher OPP because of p */
+		if (min_stat.cost > max_cost)
+			delta_nrg += pd_actual_util * (min_stat.cost - max_cost);
+
+		/* nrg with p */
+		trace_sched_compute_energy_tp(p, min_stat.cpu, delta_nrg,
+				min_stat.max_perf, pd_actual_util + task_util);
+
+		/*
+		 * The probability that delta NRGs are equals is almost null. PDs being sorted
+		 * by max capacity, keep the one with highest max capacity if this
+		 * happens.
+		 * TODO: add a margin in nrg cost and take into account other stats
+		 */
+		if ((min_stat.fits == best_fits) &&
+		    (delta_nrg >= best_nrg))
+			continue;
+
+		best_fits = min_stat.fits;
+		best_nrg = delta_nrg;
+		best_cpu = min_stat.cpu;
+	}
 
 unlock:
 	rcu_read_unlock();
 
+	if (best_cpu >= 0)
+		target = best_cpu;
+
 	return target;
 }
 
-- 
2.34.1



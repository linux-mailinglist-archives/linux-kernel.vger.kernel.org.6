Return-Path: <linux-kernel+bounces-538596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132DA49AB8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5078F173F06
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AA726BDBB;
	Fri, 28 Feb 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lY5ul3Ir"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3E26E152
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750012; cv=none; b=fFGptvW4GZNTpGfBhuRqFAZGaAYl3zfcfveg2sLwoBRjGu52QAGXVdXNjVRfpD6fqZ6d23o3LJYOr1AkWJQQKNpjhdUIYWmqL6FdDoYOLDPUWNWf4GXLQOR2B/1h7mtxGzT2ZRnTd8ZzQKcpCslGspVvmDEaSFCJze3O6y5isxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750012; c=relaxed/simple;
	bh=PsixIBRYtomDMf+aa69pSUIIBXLsyccZplM+BMuxbl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aryPhaxYAM/nL27WG0hDJx0AJ0YVUe43byvrJZVkXByLNJdKHhurzZrxlWduJj3Trf0WcC9acKDMIUcj+ClIkBGWSLtntF7LJW3vH63i5vvb6PT6Zpp4Z9ag0/44xyQ7M2VPtRljzMwMmqwwwJ2xQE3Q63CzeNnRWzpyd879pIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lY5ul3Ir; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-390effd3e85so664357f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740750008; x=1741354808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0wS9NNaT48S3voEP7Ca12jv6d8Skrd9dbmu26/lMYU=;
        b=lY5ul3Ir0t+FkMWT7LniuU+AMsT0gJZPh2PHDunmUji0M1NhciAweLWbYv10p77Mjp
         q0alX3re4tPOif8p9g2KTbYTxDxHZX0MgxRZGFgVrGpRcPbzlWaTBj03LW0+QNApqqw3
         xbIY0z8gmsvvvMZ5eFW1Ydb94lUWeMp1KgCvE3R5nI6kQxevjjU084i0gEftNXMS5/J7
         vBrE1105Cfg5hDJLkOmrC0x4pxv1xDyDrg7G9FEqIAYa4xePTWBdVjWNm3ZsjDQlYD8W
         YH5XN0eRevpBnuL2GVwbsnLnh0hFDmxwQrUkxLsd5GkgO9PEG6lOFLt2GKh3jweZSHhV
         5lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750008; x=1741354808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0wS9NNaT48S3voEP7Ca12jv6d8Skrd9dbmu26/lMYU=;
        b=Rb9ZXW4x+Bip2vq4WNA6LoCrRkao3n+wUD6qy/ZjoHudF6YXKLq9+glu6PjqKqa4qP
         q30V/tRU+s0cO+WvtAq5fxor5COKrhq1wtgPhYZmZoTEu02/7GxLdoCgj2XwftYm5f1c
         p4Fih1AyVWxN6OBwvwmKEj/3U8YD7o17TX8YzljDY/16/jDJJ5ZP/FN6dMXpy4yW82TL
         Zu8aG6q5EFfS2RjQPYBHwWSkqTzzYEp+6Pepyi2/yjVEpMM3HP4lv9HFXqRQOdUg2zKC
         Gk+pEtZsXWPVpWNzRNjCTND1QBOHfIUWWYEeO2rBqReSeLoElOQTy5JzJNuStwcIraWx
         nEcg==
X-Forwarded-Encrypted: i=1; AJvYcCX4UBbE0spKWiRTTuTxBcbjPwsuxoitzEBcK23KWvY5ny5fphXSt611hdRILIgxIZrTtscu4f235nmvFSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOGavhFaX3uyX7EmkQUt4dU0Ig6g3ftDrEJyYuoTI6E6nKNgi
	rDpZ7tNZY877E9/ehBYm53dhILAM3D/EkkiIX2ES6zB8Q0iBoxz7S89gWDNohOc=
X-Gm-Gg: ASbGncvJBMbou29EQLXdBvfDRHKQ3h3ZFiwYFnyTTOODgA+faeEDkWaIzAFD2PhAzwM
	T8/uyIOOwEVJSEvq3dnQ4guXdZATdW42pssYFDeSumOk/4aKevfrYzwUyGcT7nyJVYqb+NBxW/F
	02b7B9t1jl3WBi0vn0qb0/YuxVEysFihJiXkiKYu0DdRsNMzTN0akYzBS5Gi2H3Ro4Kf/zCf0Hf
	9Oe5Oz4Fjhg4N2OxE5XNbu9WT0atFf8Sak7ua7Yzi3X/UuBsm8Db4f4w5mP5IJmDKpfePms07qV
	BG1uJbNBkdhf+j0EVN/YcefYvJHeHp1w1Q==
X-Google-Smtp-Source: AGHT+IF7x4AnOeOpnmNGS+9mlTSN6LoUEvvf222LCvsjzyHDrJCQ9CMXxz2855nY0UxQ7rCP3pW1Ig==
X-Received: by 2002:a5d:64a6:0:b0:390:eb32:3fd2 with SMTP id ffacd0b85a97d-390ec7748c9mr3106012f8f.0.1740750007745;
        Fri, 28 Feb 2025 05:40:07 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d4b:473f:a962:e9e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717171sm55984405e9.18.2025.02.28.05.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:40:06 -0800 (PST)
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
Subject: [PATCH 3/7 v3] sched/fair: Rework feec() to use cost instead of spare capacity
Date: Fri, 28 Feb 2025 14:39:56 +0100
Message-ID: <20250228134000.1226665-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228134000.1226665-1-vincent.guittot@linaro.org>
References: <20250228134000.1226665-1-vincent.guittot@linaro.org>
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
performant CPU between CPUs. The cost of the OPP remains the only
comparison criteria between Performance Domains.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
 1 file changed, 246 insertions(+), 220 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d3d1a2ba6b1a..a9b97bbc085f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8193,29 +8193,37 @@ unsigned long sched_cpu_util(int cpu)
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
+ * @runnable :   runnable_avg of the CPU
+ * @nr_running : Number of cfs running task
+ * @fits :       Fits level of the CPU
+ * @cpu :        Current best CPU
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
@@ -8225,124 +8233,153 @@ static inline void eenv_task_busy_time(struct energy_env *eenv,
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
+	i = em_pd_get_efficient_state(em_table->state, pd, max_util);
+	ps = &em_table->state[i];
 
-		eff_util = sugov_effective_cpu_perf(cpu, eff_util, min, max);
-		max_util = max(max_util, eff_util);
+	/* Save the cost and performance range of the OPP */
+	stat->max_perf = ps->performance;
+	stat->cost = ps->cost;
+	i = em_pd_get_previous_state(em_table->state, pd, i);
+	if (i < 0)
+		stat->min_perf = 0;
+	else {
+		ps = &em_table->state[i];
+		stat->min_perf = ps->performance;
 	}
+}
+
+/*Check if the CPU can handle the waking task */
+static int check_cpu_with_task(struct task_struct *p, int cpu)
+{
+	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
+	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
+	unsigned long util_min = p_util_min;
+	unsigned long util_max = p_util_max;
+	unsigned long util = cpu_util(cpu, p, cpu, 0);
+	struct rq *rq = cpu_rq(cpu);
 
-	return min(max_util, eenv->cpu_cap);
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
 }
 
 /*
- * compute_energy(): Use the Energy Model to estimate the energy that @pd would
- * consume for a given utilization landscape @eenv. When @dst_cpu < 0, the task
- * contribution is ignored.
+ * For the same cost, select the CPU that will povide best performance for the
+ * task.
  */
-static inline unsigned long
-compute_energy(struct energy_env *eenv, struct perf_domain *pd,
-	       struct cpumask *pd_cpus, struct task_struct *p, int dst_cpu)
+static bool update_best_cpu(struct energy_cpu_stat *target,
+			    struct energy_cpu_stat *min,
+			    int prev, struct sched_domain *sd)
 {
-	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
-	unsigned long busy_time = eenv->pd_busy_time;
-	unsigned long energy;
-
-	if (dst_cpu >= 0)
-		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
+	/*  Select the one with the least number of running tasks */
+	if (target->nr_running < min->nr_running)
+		return true;
+	if (target->nr_running > min->nr_running)
+		return false;
 
-	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
+	/* Favor previous CPU otherwise */
+	if (target->cpu == prev)
+		return true;
+	if (min->cpu == prev)
+		return false;
 
-	trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
+	/*
+	 * Choose CPU with lowest contention. One might want to consider load
+	 * instead of runnable but we are supposed to not be overutilized so
+	 * there is enough compute capacity for everybody.
+	 */
+	if ((target->runnable * min->capa * sd->imbalance_pct) >=
+			(min->runnable * target->capa * 100))
+		return false;
 
-	return energy;
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
@@ -8379,17 +8416,14 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
 static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
-	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
-	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
-	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
 	struct root_domain *rd = this_rq()->rd;
-	int cpu, best_energy_cpu, target = -1;
-	int prev_fits = -1, best_fits = -1;
-	unsigned long best_actual_cap = 0;
-	unsigned long prev_actual_cap = 0;
+	unsigned long best_nrg = ULONG_MAX;
+	unsigned long task_util;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
-	struct energy_env eenv;
+	int cpu, target = -1;
+	int best_fits = -1;
+	int best_cpu = -1;
 
 	rcu_read_lock();
 	pd = rcu_dereference(rd->pd);
@@ -8409,19 +8443,19 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	target = prev_cpu;
 
 	sync_entity_load_avg(&p->se);
-	if (!task_util_est(p) && p_util_min == 0)
-		goto unlock;
-
-	eenv_task_busy_time(&eenv, p, prev_cpu);
+	task_util = task_busy_time(p, prev_cpu);
 
 	for (; pd; pd = pd->next) {
-		unsigned long util_min = p_util_min, util_max = p_util_max;
-		unsigned long cpu_cap, cpu_actual_cap, util;
-		long prev_spare_cap = -1, max_spare_cap = -1;
-		unsigned long rq_util_min, rq_util_max;
-		unsigned long cur_delta, base_energy;
-		int max_spare_cap_cpu = -1;
-		int fits, max_fits = -1;
+		unsigned long pd_actual_util = 0, delta_nrg = 0;
+		unsigned long cpu_actual_cap, max_cost = 0;
+		struct energy_cpu_stat target_stat;
+		struct energy_cpu_stat min_stat = {
+			.cost = ULONG_MAX,
+			.max_perf = ULONG_MAX,
+			.min_perf = ULONG_MAX,
+			.fits = -2,
+			.cpu = -1,
+		};
 
 		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
 
@@ -8432,13 +8466,9 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
@@ -8446,120 +8476,116 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
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
+			/* Get the performance of the CPU w/ the waking task */
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
+			target_stat.nr_running = cpu_rq(cpu)->cfs.h_nr_runnable;
 
-			fits = util_fits_cpu(util, util_min, util_max, cpu);
-			if (!fits)
+			/* If the target needs a lower OPP, then look up for
+			 * the corresponding OPP and its associated cost.
+			 * Otherwise at same cost level, select the CPU which
+			 * provides best performance.
+			 */
+			if (target_perf < min_stat.min_perf)
+				find_pd_cost(pd->em_pd, target_perf, &target_stat);
+			else if (!update_best_cpu(&target_stat, &min_stat, prev_cpu, sd))
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
+		/* Add the energy cost of p */
+		delta_nrg = task_util * min_stat.cost;
 
-	return target;
+		/*
+		 * Compute the energy cost of others running at higher OPP
+		 * because of p.
+		 */
+		if (min_stat.cost > max_cost)
+			delta_nrg += pd_actual_util * (min_stat.cost - max_cost);
+
+		/* Delta energy with p */
+		trace_sched_compute_energy_tp(p, min_stat.cpu, delta_nrg,
+				min_stat.max_perf, pd_actual_util + task_util);
+
+		/*
+		 * The probability that delta energies are equals is almost
+		 * null. PDs being sorted by max capacity, keep the one with
+		 * highest max capacity if this happens.
+		 * TODO: add a margin in energy cost and take into account
+		 * other stats.
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
2.43.0



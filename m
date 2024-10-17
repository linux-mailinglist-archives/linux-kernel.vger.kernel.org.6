Return-Path: <linux-kernel+bounces-370642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B45E9A2FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 23:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B93B22E42
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 21:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CC21D618E;
	Thu, 17 Oct 2024 21:47:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7DC1D618A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201619; cv=none; b=HJkz84W080RHC2f2m7okDtXqK6kqykWHFXzZ33IaerQG/weWPSjD+zWWoNnD5l5Cae7MWZSQuv5Pmz2R4IfNuLgAbg+tDsNpCIr5ln3mCfDJsRS1fQFdkeNi72e9nGYdlZSruZizLZhZzbAqfuIMBmzFCGVy8xOxu+uwYov6tTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201619; c=relaxed/simple;
	bh=eByi7Quusp9pfvFkVZxx6f4c/DwUlPqAFhPMG3Tjuuw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hwSGquoPMI6mjOuNe95z+GUSB2DQ9u+URHEfRwT/i4iTeV5vSMC7MSXrMKoCVOyaoXreF1zv5+5dmYge5CERcyHKxPYpdjeGMUvwNfsztvqPM7wRkVFrYEp97ZNl1CBSR8O6DNhvAHCSk0eKpyMT3xkcNtHXLqjnN2qKeiHPnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E02CAFEC;
	Thu, 17 Oct 2024 14:47:22 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 505313F71E;
	Thu, 17 Oct 2024 14:46:51 -0700 (PDT)
Message-ID: <32c0aed9-bae1-4273-938d-36acb420eb56@arm.com>
Date: Thu, 17 Oct 2024 22:46:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: mpe@ellerman.id.au, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] sched: Make ASYM_PACKING compile-time arch config
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Only x86 and Power7 set SD_ASYM_PACKING at boot-time depending on the
system. All other platforms don't make use of asym-packing anyway,
so introduce auxiliary ARCH_HAS_SCHED_ASYM_PACKING and guard all the
related logic behind that so it isn't compiled when not needed.

On arm64 this reduces
size kernel/sched/fair.o
   text	   data	    bss	    dec	    hex	filename
  74120	   4097	     88	  78305	  131e1	kernel/sched/fair.o
to
size kernel/sched/fair.o
   text	   data	    bss	    dec	    hex	filename
  72896	   4065	     88	  77049	  12cf9	kernel/sched/fair.o

Most of that is on the load-balance hot-path, in particular
need_active_balance() reduces from 141 to 84 instructions.

hackbench -pTl 20000 on a rk3399 goes from
58.4664 to 57.6056 (-1.5%), mean over 20 iterations.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 arch/Kconfig         |  3 ++
 arch/powerpc/Kconfig |  1 +
 arch/x86/Kconfig     |  1 +
 kernel/sched/fair.c  | 86 ++++++++++++++++++++++++++++++--------------
 kernel/sched/sched.h |  8 ++++-
 5 files changed, 71 insertions(+), 28 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8af374ea1adc..9f6ec10723a3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1684,4 +1684,7 @@ config CC_HAS_SANE_FUNCTION_ALIGNMENT
 config ARCH_NEED_CMPXCHG_1_EMU
 	bool
 
+config ARCH_HAS_SCHED_ASYM_PACKING
+	bool
+
 endmenu
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8094a01974cc..5de478f9087e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -148,6 +148,7 @@ config PPC
 	select ARCH_HAS_PTE_DEVMAP		if PPC_BOOK3S_64
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
+	select ARCH_HAS_SCHED_ASYM_PACKING
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx) && !HIBERNATION
 	select ARCH_HAS_STRICT_KERNEL_RWX	if PPC_85xx && !HIBERNATION && !RANDOMIZE_BASE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd82cbd..6d7db89d141c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -99,6 +99,7 @@ config X86
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
 	select ARCH_HAS_COPY_MC			if X86_64
+	select ARCH_HAS_SCHED_ASYM_PACKING
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 225b31aaee55..5a2108b16340 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -86,13 +86,6 @@ static int __init setup_sched_thermal_decay_shift(char *str)
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
 
 #ifdef CONFIG_SMP
-/*
- * For asym packing, by default the lower numbered CPU has higher priority.
- */
-int __weak arch_asym_cpu_priority(int cpu)
-{
-	return -cpu;
-}
 
 /*
  * The margin used when comparing utilization with CPU capacity.
@@ -9186,12 +9179,14 @@ enum group_type {
 	 * a task on SMT with busy sibling to another CPU on idle core.
 	 */
 	group_smt_balance,
+#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
 	/*
 	 * SD_ASYM_PACKING only: One local CPU with higher capacity is available,
 	 * and the task should be migrated to it instead of running on the
 	 * current CPU.
 	 */
 	group_asym_packing,
+#endif
 	/*
 	 * The tasks' affinity constraints previously prevented the scheduler
 	 * from balancing the load across the system.
@@ -9876,7 +9871,9 @@ struct sg_lb_stats {
 	unsigned int idle_cpus;                 /* Nr of idle CPUs         in the group */
 	unsigned int group_weight;
 	enum group_type group_type;
+#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
+#endif
 	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
 	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
@@ -10136,8 +10133,10 @@ group_type group_classify(unsigned int imbalance_pct,
 	if (sg_imbalanced(group))
 		return group_imbalanced;
 
+#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
 	if (sgs->group_asym_packing)
 		return group_asym_packing;
+#endif
 
 	if (sgs->group_smt_balance)
 		return group_smt_balance;
@@ -10151,6 +10150,15 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
+#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
+/*
+ * For asym packing, by default the lower numbered CPU has higher priority.
+ */
+int __weak arch_asym_cpu_priority(int cpu)
+{
+	return -cpu;
+}
+
 /**
  * sched_use_asym_prio - Check whether asym_packing priority must be used
  * @sd:		The scheduling domain of the load balancing
@@ -10209,6 +10217,40 @@ sched_group_asym(struct lb_env *env, struct sg_lb_stats *sgs, struct sched_group
 	return sched_asym(env->sd, env->dst_cpu, group->asym_prefer_cpu);
 }
 
+static inline bool asym_active_balance(struct lb_env *env)
+{
+	/*
+	 * ASYM_PACKING needs to force migrate tasks from busy but lower
+	 * priority CPUs in order to pack all tasks in the highest priority
+	 * CPUs. When done between cores, do it only if the whole core if the
+	 * whole core is idle.
+	 *
+	 * If @env::src_cpu is an SMT core with busy siblings, let
+	 * the lower priority @env::dst_cpu help it. Do not follow
+	 * CPU priority.
+	 */
+	return env->idle && sched_use_asym_prio(env->sd, env->dst_cpu) &&
+	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
+		!sched_use_asym_prio(env->sd, env->src_cpu));
+}
+
+static inline bool check_asym_packing(struct sg_lb_stats *group)
+{
+	return group->group_type == group_asym_packing;
+}
+
+#else
+
+static inline bool sched_asym(struct sched_domain *sd, int dst_cpu, int src_cpu)
+{
+	return false;
+}
+
+static inline bool asym_active_balance(struct lb_env *env) { return false; }
+static inline bool check_asym_packing(struct sg_lb_stats *group) { return false; }
+
+#endif /* CONFIG_ARCH_HAS_SCHED_ASYM_PACKING */
+
 /* One group has more than one SMT CPU while the other group does not */
 static inline bool smt_vs_nonsmt_groups(struct sched_group *sg1,
 				    struct sched_group *sg2)
@@ -10360,10 +10402,12 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	sgs->group_weight = group->group_weight;
 
+#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->idle && sgs->sum_h_nr_running &&
 	    sched_group_asym(env, sgs, group))
 		sgs->group_asym_packing = 1;
+#endif
 
 	/* Check for loaded SMT group to be balanced to dst CPU */
 	if (!local_group && smt_balance(env, sgs, group))
@@ -10436,9 +10480,11 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		 */
 		return false;
 
+#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
 	case group_asym_packing:
 		/* Prefer to move from lowest priority CPU's work */
 		return sched_asym_prefer(sds->busiest->asym_prefer_cpu, sg->asym_prefer_cpu);
+#endif
 
 	case group_misfit_task:
 		/*
@@ -10691,7 +10737,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
 		break;
 
 	case group_imbalanced:
+#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
 	case group_asym_packing:
+#endif
 	case group_smt_balance:
 		/* Those types are not used in the slow wakeup path */
 		return false;
@@ -10823,7 +10871,9 @@ sched_balance_find_dst_group(struct sched_domain *sd, struct task_struct *p, int
 		break;
 
 	case group_imbalanced:
+#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
 	case group_asym_packing:
+#endif
 	case group_smt_balance:
 		/* Those type are not used in the slow wakeup path */
 		return NULL;
@@ -11058,7 +11108,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 		return;
 	}
 
-	if (busiest->group_type == group_asym_packing) {
+	if (check_asym_packing(busiest)) {
 		/*
 		 * In case of asym capacity, we will try to migrate all load to
 		 * the preferred CPU.
@@ -11265,7 +11315,7 @@ static struct sched_group *sched_balance_find_src_group(struct lb_env *env)
 		goto out_balanced;
 
 	/* ASYM feature bypasses nice load balance check */
-	if (busiest->group_type == group_asym_packing)
+	if (check_asym_packing(busiest))
 		goto force_balance;
 
 	/*
@@ -11520,24 +11570,6 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
  */
 #define MAX_PINNED_INTERVAL	512
 
-static inline bool
-asym_active_balance(struct lb_env *env)
-{
-	/*
-	 * ASYM_PACKING needs to force migrate tasks from busy but lower
-	 * priority CPUs in order to pack all tasks in the highest priority
-	 * CPUs. When done between cores, do it only if the whole core if the
-	 * whole core is idle.
-	 *
-	 * If @env::src_cpu is an SMT core with busy siblings, let
-	 * the lower priority @env::dst_cpu help it. Do not follow
-	 * CPU priority.
-	 */
-	return env->idle && sched_use_asym_prio(env->sd, env->dst_cpu) &&
-	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
-		!sched_use_asym_prio(env->sd, env->src_cpu));
-}
-
 static inline bool
 imbalanced_active_balance(struct lb_env *env)
 {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b1c3588a8f00..51d49700f643 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -937,11 +937,17 @@ static inline long se_weight(struct sched_entity *se)
 	return scale_load_down(se->load.weight);
 }
 
-
+#ifdef CONFIG_ARCH_HAS_SCHED_ASYM_PACKING
 static inline bool sched_asym_prefer(int a, int b)
 {
 	return arch_asym_cpu_priority(a) > arch_asym_cpu_priority(b);
 }
+#else
+static inline bool sched_asym_prefer(int a, int b)
+{
+	return false;
+}
+#endif
 
 struct perf_domain {
 	struct em_perf_domain *em_pd;
-- 
2.34.1


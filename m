Return-Path: <linux-kernel+bounces-563931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBD5A64A8D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA1816BB2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8302B2356DC;
	Mon, 17 Mar 2025 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL0hBW+/"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818B22B8D9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208191; cv=none; b=Vm6RC/LPlSWbQ32bc+3tSDMMNrtGJg1KLRUdFRogVsYrms7PAIYala/fLfnc2lIA+LObapqO6IT8NNWhB2KsGWmfnseGli1OYpJa6boRrgv7IszNvga5xvAc3KXookrBVSBdLkkrrWRgBLBV4bENg+CeRZ1MTq4Pe6AOEnvkeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208191; c=relaxed/simple;
	bh=HzqkGXLbyXnfxqFy+KHi8BS1Yw4Drjo9HtN+UPrBNDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDG8dGFPpQTxSzOrrd+49Q8+QpJ7PIbihtO88PRX7WT3ZUkpgV3uZmEJhyVpS3CzYwBWx0buLSrl+zMSvnjhe4zEtGgqFaKuRE2uZnSzaJXmTzWWSlE/s+vLMnidSGnhslRe69WkloZYc8XfYmoqOvJza2ajgxbF57UPrWuRhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL0hBW+/; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so20424985e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742208187; x=1742812987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXiwNlhHHkVHmQlhy+M9VYV3FYmoT2BZc91EFsZurIs=;
        b=FL0hBW+/WsWKMPDbyem4DH+SbDNayaspx5PS0f/bda53DU4XBy9LQaaMPbY+fppbLD
         G97ydJwnbg2Ie65jHHIesPvV2hU+nW14/x5dxn6xJ3zzK6pck4DhagReJUHJajvKLJUo
         6WEYoHaGwldXlQKzFjznsE0DvaK7nfMbsXXR4fPuCHduDgHhUX67KfyVMaqu+4Qxb7ZA
         VD4CTMAlmVPMx0wUT+OMdT3dYwbcXOmOeTP4BOPzMhqgwjnyI5Oz7aGKKrV3pTBRlm7g
         rlfD8oWjs8KAv3/J1GAd+b/f6lm8wbDKod0CW9NTqKp7EivQ7Pm0fDJb5L8gWbJQOHlB
         zcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208187; x=1742812987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kXiwNlhHHkVHmQlhy+M9VYV3FYmoT2BZc91EFsZurIs=;
        b=YWyJqnyGPy+KfjbbMeIrlCx6Qq3nYBB3OEMXQcpunN+nor3Zb3gxDpNd/5vUm+0O3q
         QvqZZ0R73E+YnFKde6WrvLhW9z16eSOl86xM1iB6WKyCp+a3miRat2HOxjbsosvGI/xt
         M+XHMV4b7EY+HQUX+L3PBGowL2bqaVZP+XKCXeoNN6JDM3XqzyzzADRB6CZR2j/JpkfD
         376EkkGgGROEQLht3RLr32ei+lTpSdlIIk4fPh7xPjkDIvx2UnoawkghZt4qmiDt0r1j
         PGeSFtpnqQF3l3wE40lSFu78+f4waPT8JSHNjXm6D0ew8AGanPQ/kFiUX2k6SKxd9v+A
         4t5w==
X-Gm-Message-State: AOJu0Yx5r7aIVUECAf8rbCA285cvpYgFsPuwgTe0ltIySFIo7NJvb/r4
	+d2cbgmVQjg6j/qJi+41xyYYRuQXipixJt/YVWQBPCn0V0xYgRc1yxaUTiGE
X-Gm-Gg: ASbGnctTrtnY80MAjOjkbi7GnAUNMLhiWTyBCkGBL2aXq3Lt2jAxvc82jHtMC/xV9kt
	mdMZKYgZoOpAR+9T5wcgri0/Ul9V0xNEPCfRF3MufvG67hvqw2QoGkJjgxCTjmldr1cYm5lS7XY
	trs3sZDpCdr9GEzge7YvEFGuMr2vy5tZopDOa8+uDhc1O2WtEInAzJZ2KCgy+ghwdXVa9lSkXyJ
	ZCu0lOBKT1LADgj3j4Pwsep1iVpA4S8LhgvhHN/S9dHodm2oiqYA7PpCPEHddGZKThy7aZwxEDc
	akE6L/21yIIAgh5y0vekAFeFd5ak8pyb2RfrE4yy+J8Ld2qSdeNGdFmzD54r6ej6FA==
X-Google-Smtp-Source: AGHT+IGwHRrB2+IpciPVRMY+M4P+gjN7zqqLq5SU2B+vcIjFHvl/kEmnQHQAX1//Zloba9FSLhuGdg==
X-Received: by 2002:a5d:5886:0:b0:391:4684:dbdb with SMTP id ffacd0b85a97d-3971d61752amr10770007f8f.17.1742208186824;
        Mon, 17 Mar 2025 03:43:06 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb3189absm14807262f8f.71.2025.03.17.03.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:43:06 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/5] sched/debug: Make CONFIG_SCHED_DEBUG functionality unconditional
Date: Mon, 17 Mar 2025 11:42:54 +0100
Message-ID: <20250317104257.3496611-4-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250317104257.3496611-1-mingo@kernel.org>
References: <20250317104257.3496611-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All the big Linux distros enable CONFIG_SCHED_DEBUG, because
the various features it provides help not just with kernel
development, but with system administration and user-space
software development as well.

Reflect this reality and enable this functionality
unconditionally.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 fs/proc/base.c                 |  7 -------
 include/linux/energy_model.h   |  2 --
 include/linux/sched/debug.h    |  2 --
 include/linux/sched/topology.h |  4 ----
 include/trace/events/sched.h   |  2 --
 kernel/sched/build_utility.c   |  4 +---
 kernel/sched/core.c            | 18 +++---------------
 kernel/sched/deadline.c        |  2 --
 kernel/sched/fair.c            |  4 ----
 kernel/sched/rt.c              |  5 +----
 kernel/sched/sched.h           | 54 ++++--------------------------------------------------
 kernel/sched/topology.c        | 13 -------------
 12 files changed, 9 insertions(+), 108 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index cd89e956c322..61526420d0ee 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1489,7 +1489,6 @@ static const struct file_operations proc_fail_nth_operations = {
 #endif
 
 
-#ifdef CONFIG_SCHED_DEBUG
 /*
  * Print out various scheduling related per-task fields:
  */
@@ -1539,8 +1538,6 @@ static const struct file_operations proc_pid_sched_operations = {
 	.release	= single_release,
 };
 
-#endif
-
 #ifdef CONFIG_SCHED_AUTOGROUP
 /*
  * Print out autogroup related information:
@@ -3331,9 +3328,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 	ONE("status",     S_IRUGO, proc_pid_status),
 	ONE("personality", S_IRUSR, proc_pid_personality),
 	ONE("limits",	  S_IRUGO, proc_pid_limits),
-#ifdef CONFIG_SCHED_DEBUG
 	REG("sched",      S_IRUGO|S_IWUSR, proc_pid_sched_operations),
-#endif
 #ifdef CONFIG_SCHED_AUTOGROUP
 	REG("autogroup",  S_IRUGO|S_IWUSR, proc_pid_sched_autogroup_operations),
 #endif
@@ -3682,9 +3677,7 @@ static const struct pid_entry tid_base_stuff[] = {
 	ONE("status",    S_IRUGO, proc_pid_status),
 	ONE("personality", S_IRUSR, proc_pid_personality),
 	ONE("limits",	 S_IRUGO, proc_pid_limits),
-#ifdef CONFIG_SCHED_DEBUG
 	REG("sched",     S_IRUGO|S_IWUSR, proc_pid_sched_operations),
-#endif
 	NOD("comm",      S_IFREG|S_IRUGO|S_IWUSR,
 			 &proc_tid_comm_inode_operations,
 			 &proc_pid_set_comm_operations, {}),
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 78318d49276d..65efc0f5ea2e 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -240,9 +240,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	struct em_perf_state *ps;
 	int i;
 
-#ifdef CONFIG_SCHED_DEBUG
 	WARN_ONCE(!rcu_read_lock_held(), "EM: rcu read lock needed\n");
-#endif
 
 	if (!sum_util)
 		return 0;
diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
index b5035afa2396..35ed4577a6cc 100644
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -35,12 +35,10 @@ extern void show_stack(struct task_struct *task, unsigned long *sp,
 
 extern void sched_show_task(struct task_struct *p);
 
-#ifdef CONFIG_SCHED_DEBUG
 struct seq_file;
 extern void proc_sched_show_task(struct task_struct *p,
 				 struct pid_namespace *ns, struct seq_file *m);
 extern void proc_sched_set_task(struct task_struct *p);
-#endif
 
 /* Attach to any functions which should be ignored in wchan output. */
 #define __sched		__section(".sched.text")
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7f3dbafe1817..7894653bc70b 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -25,16 +25,12 @@ enum {
 };
 #undef SD_FLAG
 
-#ifdef CONFIG_SCHED_DEBUG
-
 struct sd_flag_debug {
 	unsigned int meta_flags;
 	char *name;
 };
 extern const struct sd_flag_debug sd_flag_debug[];
 
-#endif
-
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
 {
diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 9ea4c404bd4e..bfd97cce40a1 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -193,9 +193,7 @@ static inline long __trace_sched_switch_state(bool preempt,
 {
 	unsigned int state;
 
-#ifdef CONFIG_SCHED_DEBUG
 	BUG_ON(p != current);
-#endif /* CONFIG_SCHED_DEBUG */
 
 	/*
 	 * Preemption ignores task state, therefore preempted tasks are always
diff --git a/kernel/sched/build_utility.c b/kernel/sched/build_utility.c
index 80a3df49ab47..bf9d8db94b70 100644
--- a/kernel/sched/build_utility.c
+++ b/kernel/sched/build_utility.c
@@ -68,9 +68,7 @@
 # include "cpufreq_schedutil.c"
 #endif
 
-#ifdef CONFIG_SCHED_DEBUG
-# include "debug.c"
-#endif
+#include "debug.c"
 
 #ifdef CONFIG_SCHEDSTATS
 # include "stats.c"
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d6833a85e561..598b7f241dda 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -118,7 +118,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
-#ifdef CONFIG_SCHED_DEBUG
 /*
  * Debugging: various feature bits
  *
@@ -142,7 +141,6 @@ __read_mostly unsigned int sysctl_sched_features =
  */
 __read_mostly int sysctl_resched_latency_warn_ms = 100;
 __read_mostly int sysctl_resched_latency_warn_once = 1;
-#endif /* CONFIG_SCHED_DEBUG */
 
 /*
  * Number of tasks to iterate in a single balance run.
@@ -799,11 +797,10 @@ void update_rq_clock(struct rq *rq)
 	if (rq->clock_update_flags & RQCF_ACT_SKIP)
 		return;
 
-#ifdef CONFIG_SCHED_DEBUG
 	if (sched_feat(WARN_DOUBLE_CLOCK))
 		WARN_ON_ONCE(rq->clock_update_flags & RQCF_UPDATED);
 	rq->clock_update_flags |= RQCF_UPDATED;
-#endif
+
 	clock = sched_clock_cpu(cpu_of(rq));
 	scx_rq_clock_update(rq, clock);
 
@@ -3291,7 +3288,6 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
-#ifdef CONFIG_SCHED_DEBUG
 	unsigned int state = READ_ONCE(p->__state);
 
 	/*
@@ -3329,7 +3325,6 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	WARN_ON_ONCE(!cpu_online(new_cpu));
 
 	WARN_ON_ONCE(is_migration_disabled(p));
-#endif
 
 	trace_sched_migrate_task(p, new_cpu);
 
@@ -5577,7 +5572,6 @@ unsigned long long task_sched_runtime(struct task_struct *p)
 	return ns;
 }
 
-#ifdef CONFIG_SCHED_DEBUG
 static u64 cpu_resched_latency(struct rq *rq)
 {
 	int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
@@ -5622,9 +5616,6 @@ static int __init setup_resched_latency_warn_ms(char *str)
 	return 1;
 }
 __setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
-#else
-static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
-#endif /* CONFIG_SCHED_DEBUG */
 
 /*
  * This function gets called by the timer code, with HZ frequency.
@@ -6718,9 +6709,7 @@ static void __sched notrace __schedule(int sched_mode)
 picked:
 	clear_tsk_need_resched(prev);
 	clear_preempt_need_resched();
-#ifdef CONFIG_SCHED_DEBUG
 	rq->last_seen_need_resched_ns = 0;
-#endif
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
@@ -7094,7 +7083,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
 			  void *key)
 {
-	WARN_ON_ONCE(IS_ENABLED(CONFIG_SCHED_DEBUG) && wake_flags & ~(WF_SYNC|WF_CURRENT_CPU));
+	WARN_ON_ONCE(wake_flags & ~(WF_SYNC|WF_CURRENT_CPU));
 	return try_to_wake_up(curr->private, mode, wake_flags);
 }
 EXPORT_SYMBOL(default_wake_function);
@@ -7764,10 +7753,9 @@ void show_state_filter(unsigned int state_filter)
 			sched_show_task(p);
 	}
 
-#ifdef CONFIG_SCHED_DEBUG
 	if (!state_filter)
 		sysrq_sched_debug_show();
-#endif
+
 	rcu_read_unlock();
 	/*
 	 * Only show locks if all tasks are dumped:
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b18c80272f86..d352b57f31cf 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3567,9 +3567,7 @@ void dl_bw_free(int cpu, u64 dl_bw)
 }
 #endif
 
-#ifdef CONFIG_SCHED_DEBUG
 void print_dl_stats(struct seq_file *m, int cpu)
 {
 	print_dl_rq(m, cpu, &cpu_rq(cpu)->dl);
 }
-#endif /* CONFIG_SCHED_DEBUG */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 35ee8d9d78d5..a0c4cd26ee07 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -983,7 +983,6 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	return best;
 }
 
-#ifdef CONFIG_SCHED_DEBUG
 struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *last = rb_last(&cfs_rq->tasks_timeline.rb_root);
@@ -1010,7 +1009,6 @@ int sched_update_scaling(void)
 	return 0;
 }
 #endif
-#endif
 
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
@@ -13668,7 +13666,6 @@ DEFINE_SCHED_CLASS(fair) = {
 #endif
 };
 
-#ifdef CONFIG_SCHED_DEBUG
 void print_cfs_stats(struct seq_file *m, int cpu)
 {
 	struct cfs_rq *cfs_rq, *pos;
@@ -13702,7 +13699,6 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 	rcu_read_unlock();
 }
 #endif /* CONFIG_NUMA_BALANCING */
-#endif /* CONFIG_SCHED_DEBUG */
 
 __init void init_sched_fair_class(void)
 {
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 926281ac3ac0..8f7c3bfb49ef 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -169,9 +169,8 @@ static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
 
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_SCHED_DEBUG
 	WARN_ON_ONCE(!rt_entity_is_task(rt_se));
-#endif
+
 	return container_of(rt_se, struct task_struct, rt);
 }
 
@@ -2967,7 +2966,6 @@ static int sched_rr_handler(const struct ctl_table *table, int write, void *buff
 }
 #endif /* CONFIG_SYSCTL */
 
-#ifdef CONFIG_SCHED_DEBUG
 void print_rt_stats(struct seq_file *m, int cpu)
 {
 	rt_rq_iter_t iter;
@@ -2978,4 +2976,3 @@ void print_rt_stats(struct seq_file *m, int cpu)
 		print_rt_rq(m, cpu, rt_rq);
 	rcu_read_unlock();
 }
-#endif /* CONFIG_SCHED_DEBUG */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 187a22800577..ac68db706b7c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1174,10 +1174,8 @@ struct rq {
 
 	atomic_t		nr_iowait;
 
-#ifdef CONFIG_SCHED_DEBUG
 	u64 last_seen_need_resched_ns;
 	int ticks_without_resched;
-#endif
 
 #ifdef CONFIG_MEMBARRIER
 	int membarrier_state;
@@ -1706,14 +1704,12 @@ static inline void rq_clock_stop_loop_update(struct rq *rq)
 struct rq_flags {
 	unsigned long flags;
 	struct pin_cookie cookie;
-#ifdef CONFIG_SCHED_DEBUG
 	/*
 	 * A copy of (rq::clock_update_flags & RQCF_UPDATED) for the
 	 * current pin context is stashed here in case it needs to be
 	 * restored in rq_repin_lock().
 	 */
 	unsigned int clock_update_flags;
-#endif
 };
 
 extern struct balance_callback balance_push_callback;
@@ -1764,21 +1760,18 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 {
 	rf->cookie = lockdep_pin_lock(__rq_lockp(rq));
 
-#ifdef CONFIG_SCHED_DEBUG
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
-# ifdef CONFIG_SMP
+#ifdef CONFIG_SMP
 	WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);
-# endif
 #endif
 }
 
 static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 {
-#ifdef CONFIG_SCHED_DEBUG
 	if (rq->clock_update_flags > RQCF_ACT_SKIP)
 		rf->clock_update_flags = RQCF_UPDATED;
-#endif
+
 	scx_rq_clock_invalidate(rq);
 	lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
 }
@@ -1787,12 +1780,10 @@ static inline void rq_repin_lock(struct rq *rq, struct rq_flags *rf)
 {
 	lockdep_repin_lock(__rq_lockp(rq), rf->cookie);
 
-#ifdef CONFIG_SCHED_DEBUG
 	/*
 	 * Restore the value we stashed in @rf for this pin context.
 	 */
 	rq->clock_update_flags |= rf->clock_update_flags;
-#endif
 }
 
 extern
@@ -2066,9 +2057,7 @@ struct sched_group_capacity {
 	unsigned long		next_update;
 	int			imbalance;		/* XXX unrelated to capacity but shared group state */
 
-#ifdef CONFIG_SCHED_DEBUG
 	int			id;
-#endif
 
 	unsigned long		cpumask[];		/* Balance mask */
 };
@@ -2108,13 +2097,8 @@ static inline struct cpumask *group_balance_mask(struct sched_group *sg)
 
 extern int group_balance_cpu(struct sched_group *sg);
 
-#ifdef CONFIG_SCHED_DEBUG
 extern void update_sched_domain_debugfs(void);
 extern void dirty_sched_domain_sysctl(int cpu);
-#else
-static inline void update_sched_domain_debugfs(void) { }
-static inline void dirty_sched_domain_sysctl(int cpu) { }
-#endif
 
 extern int sched_update_scaling(void);
 
@@ -2207,8 +2191,6 @@ enum {
 
 #undef SCHED_FEAT
 
-#ifdef CONFIG_SCHED_DEBUG
-
 /*
  * To support run-time toggling of sched features, all the translation units
  * (but core.c) reference the sysctl_sched_features defined in core.c.
@@ -2235,24 +2217,6 @@ extern struct static_key sched_feat_keys[__SCHED_FEAT_NR];
 
 #endif /* !CONFIG_JUMP_LABEL */
 
-#else /* !SCHED_DEBUG: */
-
-/*
- * Each translation unit has its own copy of sysctl_sched_features to allow
- * constants propagation at compile time and compiler optimization based on
- * features default.
- */
-#define SCHED_FEAT(name, enabled)	\
-	(1UL << __SCHED_FEAT_##name) * enabled |
-static __read_mostly __maybe_unused unsigned int sysctl_sched_features =
-#include "features.h"
-	0;
-#undef SCHED_FEAT
-
-#define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
-
-#endif /* !SCHED_DEBUG */
-
 extern struct static_key_false sched_numa_balancing;
 extern struct static_key_false sched_schedstats;
 
@@ -2837,7 +2801,6 @@ extern __read_mostly unsigned int sysctl_sched_migration_cost;
 
 extern unsigned int sysctl_sched_base_slice;
 
-#ifdef CONFIG_SCHED_DEBUG
 extern int sysctl_resched_latency_warn_ms;
 extern int sysctl_resched_latency_warn_once;
 
@@ -2848,7 +2811,6 @@ extern unsigned int sysctl_numa_balancing_scan_period_min;
 extern unsigned int sysctl_numa_balancing_scan_period_max;
 extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
-#endif
 
 #ifdef CONFIG_SCHED_HRTICK
 
@@ -2921,7 +2883,6 @@ unsigned long arch_scale_freq_capacity(int cpu)
 }
 #endif
 
-#ifdef CONFIG_SCHED_DEBUG
 /*
  * In double_lock_balance()/double_rq_lock(), we use raw_spin_rq_lock() to
  * acquire rq lock instead of rq_lock(). So at the end of these two functions
@@ -2936,9 +2897,6 @@ static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
 	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 #endif
 }
-#else
-static inline void double_rq_clock_clear_update(struct rq *rq1, struct rq *rq2) { }
-#endif
 
 #define DEFINE_LOCK_GUARD_2(name, type, _lock, _unlock, ...)				\
 __DEFINE_UNLOCK_GUARD(name, type, _unlock, type *lock2; __VA_ARGS__)			\
@@ -3151,7 +3109,6 @@ extern struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq);
 extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
 extern struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq);
 
-#ifdef	CONFIG_SCHED_DEBUG
 extern bool sched_debug_verbose;
 
 extern void print_cfs_stats(struct seq_file *m, int cpu);
@@ -3162,15 +3119,12 @@ extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
 extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
 
 extern void resched_latency_warn(int cpu, u64 latency);
-# ifdef CONFIG_NUMA_BALANCING
+#ifdef CONFIG_NUMA_BALANCING
 extern void show_numa_stats(struct task_struct *p, struct seq_file *m);
 extern void
 print_numa_stats(struct seq_file *m, int node, unsigned long tsf,
 		 unsigned long tpf, unsigned long gsf, unsigned long gpf);
-# endif /* CONFIG_NUMA_BALANCING */
-#else /* !CONFIG_SCHED_DEBUG: */
-static inline void resched_latency_warn(int cpu, u64 latency) { }
-#endif /* !CONFIG_SCHED_DEBUG */
+#endif /* CONFIG_NUMA_BALANCING */
 
 extern void init_cfs_rq(struct cfs_rq *cfs_rq);
 extern void init_rt_rq(struct rt_rq *rt_rq);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c49aea8c1025..cb0769820b0b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -11,8 +11,6 @@ DEFINE_MUTEX(sched_domains_mutex);
 static cpumask_var_t sched_domains_tmpmask;
 static cpumask_var_t sched_domains_tmpmask2;
 
-#ifdef CONFIG_SCHED_DEBUG
-
 static int __init sched_debug_setup(char *str)
 {
 	sched_debug_verbose = true;
@@ -151,15 +149,6 @@ static void sched_domain_debug(struct sched_domain *sd, int cpu)
 			break;
 	}
 }
-#else /* !CONFIG_SCHED_DEBUG */
-
-# define sched_debug_verbose 0
-# define sched_domain_debug(sd, cpu) do { } while (0)
-static inline bool sched_debug(void)
-{
-	return false;
-}
-#endif /* CONFIG_SCHED_DEBUG */
 
 /* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
 #define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_NEEDS_GROUPS)) |
@@ -2275,9 +2264,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 			if (!sgc)
 				return -ENOMEM;
 
-#ifdef CONFIG_SCHED_DEBUG
 			sgc->id = j;
-#endif
 
 			*per_cpu_ptr(sdd->sgc, j) = sgc;
 		}
-- 
2.45.2



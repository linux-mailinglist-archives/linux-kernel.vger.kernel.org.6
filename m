Return-Path: <linux-kernel+bounces-563929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19529A64AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4A53A85A2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638A423372E;
	Mon, 17 Mar 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVhy19j/"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA00221D90
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208189; cv=none; b=nRU0I03MbrAIcCppsjUF/6dM7qkuumNArgdWPkUAG6p1xoANxaBDHtl9BxamEv8GF3HVfOV40qaVRkHmmZBPtLmQdoOUZFvu6N1fzFZDIxxdC8OdtwL4VfEerzVl6Ep7dWJj7ZoHIWf/aojQvs5sVPzhi9WTpr1499q/zZhbFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208189; c=relaxed/simple;
	bh=x0F9Wc6PmA7Mj6G2FHO4Iyk/rm/aXwBNFFkeSmZJIt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uz8kyKmZwbPi5KfCkCbHqvlVoVOF7TwQeyhV7dAWtb9yeYvfppV5AmboR/pdaB7h48oM55glDmYuRmZfIRrG5i/6tqzj+tqW4dyKL6Y6FB2E6LibK4QDQKfC5u+rllM3ZkT0tDGjj9H2sSu6f2lenZwFobc2mkY8f/xkrCqwdCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVhy19j/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390cf7458f5so3692865f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742208185; x=1742812985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvIByDkGm9SD8qNzdW0YO+9Wrq4g6pxBmwrq0RDmigY=;
        b=DVhy19j/R1ihRlbhLleMY6CCV+EfPZ7xPc4BdeVD3ME2tlL+57j9FloRdBxjHiENEq
         ZBWxgAJ64TOm1TsfacgfuC2oP9TUg7RmmhlUp8pK0MCeIEQ5vszralu5SDZykqrGEQeU
         /UZvCl3V8N1iSCyvGReY1bde28moMYc2eYu2Vl1WIbqrMf2fRC2Wkrc/Xh7rECt2wqPV
         VRoCYewsnxo41DeYEVbeO4T73fJn8b3kKZYeW1qIUxKysgB+Ix5aO3htUbSlFKw6zHvw
         omNJa1ax1j4wLNFx3z86iP3Cv4f5OrDuFH+X+KgdD1yHg15hj4BpXjRamn+A/8LdkbRv
         q94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208185; x=1742812985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tvIByDkGm9SD8qNzdW0YO+9Wrq4g6pxBmwrq0RDmigY=;
        b=IZlIS9DZr6lq1EQ+dp51B4daQfgr0vUW9zJ+fBxUvwNQSHVJrmrv+Td02jaDgumfOS
         n4sUDSZhqr0XE/NceH2siQUpGBgivU2MNqHHReF1YLIFrtKMwE+KSbFJMr+amiz//Sd9
         fENOt3XX+ZFLqABW1Ep5owftoSjmySJFyTQP6jE0eSvy/fSzpWwa5SY3cufaDTujDaGC
         BeuJSI2Xn0r1sZbCC+MuMgXT0bWm2x8fHHUqXx19RbwyX1irlIoOAGoTCgNX90zSdD5C
         GLgurlL3HDGDB9aRDO8tjLSJ1THQK19IetmQb6q7V184W9YKGp55PguHuuD+vId2p4K8
         KJQg==
X-Gm-Message-State: AOJu0YwvCC02nP64m0WWTl4T6Mf0NeL0WPCcYkL8UYdAl73J9Hf51Sb6
	KSvJSmmbANlBowtrjA3oJMwlUQfKXPi6j42NkXv5NmC4E+5KssUQCyPatLFj
X-Gm-Gg: ASbGncucfHp3jUoqw3XgivJ1qsk8qn/fjN7rInZ0XC2C/z4GwSw1z6vdAXxYsyU77u/
	4C+Ti1kTamUx5r0VKRhfqIQ+hfD+pGzGLmwE2YZugfIoBgGl6c8n3It/rRIbeADt/A/BGkZ50iW
	HgJILZ5Hzo4vfQmtqQNdZ5qolkuzoeYerhqv6eI2Eh4JwZw0w8+1HP8TJRjzGj+EDhXD+SCeaKk
	rKzVGNr/7zSAYGNRTjkqgTLQPvThWEEcwKYIgpqq8nheVcX7P60IYbtSsUhM1Tpi+TcuZpnzFiR
	hjkcBEx/+RtoP1ZwHBnkFg2EFKiYkegWC/ZKPjd0zW/9xmNYHkhQZdvKOO2fEAUAVb+0nbFIESu
	N
X-Google-Smtp-Source: AGHT+IEvWF+8TYzeQlb+MW9+WYcgYJ1Bio2BDwzY4XszZtwtPDmt4VKN6QimcFqfhj51xgDjOYC3ug==
X-Received: by 2002:adf:ca93:0:b0:391:888:f534 with SMTP id ffacd0b85a97d-3971e780ea7mr8372748f8f.20.1742208184707;
        Mon, 17 Mar 2025 03:43:04 -0700 (PDT)
Received: from starship.. (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb3189absm14807262f8f.71.2025.03.17.03.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:43:04 -0700 (PDT)
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
Subject: [PATCH 1/5] sched/debug: Change SCHED_WARN_ON() to WARN_ON_ONCE()
Date: Mon, 17 Mar 2025 11:42:52 +0100
Message-ID: <20250317104257.3496611-2-mingo@kernel.org>
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

The scheduler has this special SCHED_WARN() facility that
depends on CONFIG_SCHED_DEBUG.

Since CONFIG_SCHED_DEBUG is getting removed, convert
SCHED_WARN() to WARN_ON_ONCE().

Note that the warning output isn't 100% equivalent:

   #define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)

Because SCHED_WARN_ON() would output the 'x' condition
as well, while WARN_ONCE() will only show a backtrace.

Hopefully these are rare enough to not really matter.

If it does, we should probably introduce a new WARN_ON()
variant that outputs the condition in stringified form,
or improve WARN_ON() itself.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c       | 24 ++++++++++++------------
 kernel/sched/core_sched.c |  2 +-
 kernel/sched/deadline.c   | 12 ++++++------
 kernel/sched/ext.c        |  2 +-
 kernel/sched/fair.c       | 58 +++++++++++++++++++++++++++++-----------------------------
 kernel/sched/rt.c         |  2 +-
 kernel/sched/sched.h      | 16 +++++-----------
 kernel/sched/stats.h      |  2 +-
 8 files changed, 56 insertions(+), 62 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 03d7b63dc3e5..2da197b2968b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -801,7 +801,7 @@ void update_rq_clock(struct rq *rq)
 
 #ifdef CONFIG_SCHED_DEBUG
 	if (sched_feat(WARN_DOUBLE_CLOCK))
-		SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED);
+		WARN_ON_ONCE(rq->clock_update_flags & RQCF_UPDATED);
 	rq->clock_update_flags |= RQCF_UPDATED;
 #endif
 	clock = sched_clock_cpu(cpu_of(rq));
@@ -1719,7 +1719,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 
 	bucket = &uc_rq->bucket[uc_se->bucket_id];
 
-	SCHED_WARN_ON(!bucket->tasks);
+	WARN_ON_ONCE(!bucket->tasks);
 	if (likely(bucket->tasks))
 		bucket->tasks--;
 
@@ -1739,7 +1739,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	 * Defensive programming: this should never happen. If it happens,
 	 * e.g. due to future modification, warn and fix up the expected value.
 	 */
-	SCHED_WARN_ON(bucket->value > rq_clamp);
+	WARN_ON_ONCE(bucket->value > rq_clamp);
 	if (bucket->value >= rq_clamp) {
 		bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
 		uclamp_rq_set(rq, clamp_id, bkt_clamp);
@@ -2121,7 +2121,7 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
+	WARN_ON_ONCE(flags & DEQUEUE_SLEEP);
 
 	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
@@ -2726,7 +2726,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 	 * XXX do further audits, this smells like something putrid.
 	 */
 	if (ctx->flags & SCA_MIGRATE_DISABLE)
-		SCHED_WARN_ON(!p->on_cpu);
+		WARN_ON_ONCE(!p->on_cpu);
 	else
 		lockdep_assert_held(&p->pi_lock);
 
@@ -4195,7 +4195,7 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
-		SCHED_WARN_ON(p->se.sched_delayed);
+		WARN_ON_ONCE(p->se.sched_delayed);
 		if (!ttwu_state_match(p, state, &success))
 			goto out;
 
@@ -4489,7 +4489,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	INIT_LIST_HEAD(&p->se.group_node);
 
 	/* A delayed task cannot be in clone(). */
-	SCHED_WARN_ON(p->se.sched_delayed);
+	WARN_ON_ONCE(p->se.sched_delayed);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
@@ -5745,7 +5745,7 @@ static void sched_tick_remote(struct work_struct *work)
 			 * we are always sure that there is no proxy (only a
 			 * single task is running).
 			 */
-			SCHED_WARN_ON(rq->curr != rq->donor);
+			WARN_ON_ONCE(rq->curr != rq->donor);
 			update_rq_clock(rq);
 
 			if (!is_idle_task(curr)) {
@@ -5965,7 +5965,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
 		preempt_count_set(PREEMPT_DISABLED);
 	}
 	rcu_sleep_check();
-	SCHED_WARN_ON(ct_state() == CT_STATE_USER);
+	WARN_ON_ONCE(ct_state() == CT_STATE_USER);
 
 	profile_hit(SCHED_PROFILING, __builtin_return_address(0));
 
@@ -6811,7 +6811,7 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	 * deadlock if the callback attempts to acquire a lock which is
 	 * already acquired.
 	 */
-	SCHED_WARN_ON(current->__state & TASK_RTLOCK_WAIT);
+	WARN_ON_ONCE(current->__state & TASK_RTLOCK_WAIT);
 
 	/*
 	 * If we are going to sleep and we have plugged IO queued,
@@ -9202,7 +9202,7 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 	unsigned int clamps;
 
 	lockdep_assert_held(&uclamp_mutex);
-	SCHED_WARN_ON(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	css_for_each_descendant_pre(css, top_css) {
 		uc_parent = css_tg(css)->parent
@@ -10537,7 +10537,7 @@ static void task_mm_cid_work(struct callback_head *work)
 	struct mm_struct *mm;
 	int weight, cpu;
 
-	SCHED_WARN_ON(t != container_of(work, struct task_struct, cid_work));
+	WARN_ON_ONCE(t != container_of(work, struct task_struct, cid_work));
 
 	work->next = work;	/* Prevent double-add */
 	if (t->flags & PF_EXITING)
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 1ef98a93eb1d..c4606ca89210 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -65,7 +65,7 @@ static unsigned long sched_core_update_cookie(struct task_struct *p,
 	 * a cookie until after we've removed it, we must have core scheduling
 	 * enabled here.
 	 */
-	SCHED_WARN_ON((p->core_cookie || cookie) && !sched_core_enabled(rq));
+	WARN_ON_ONCE((p->core_cookie || cookie) && !sched_core_enabled(rq));
 
 	if (sched_core_enqueued(p))
 		sched_core_dequeue(rq, p, DEQUEUE_SAVE);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ff4df16b5186..b18c80272f86 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -249,8 +249,8 @@ void __add_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw += dl_bw;
-	SCHED_WARN_ON(dl_rq->running_bw < old); /* overflow */
-	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
+	WARN_ON_ONCE(dl_rq->running_bw < old); /* overflow */
+	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
 	cpufreq_update_util(rq_of_dl_rq(dl_rq), 0);
 }
@@ -262,7 +262,7 @@ void __sub_running_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->running_bw -= dl_bw;
-	SCHED_WARN_ON(dl_rq->running_bw > old); /* underflow */
+	WARN_ON_ONCE(dl_rq->running_bw > old); /* underflow */
 	if (dl_rq->running_bw > old)
 		dl_rq->running_bw = 0;
 	/* kick cpufreq (see the comment in kernel/sched/sched.h). */
@@ -276,7 +276,7 @@ void __add_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw += dl_bw;
-	SCHED_WARN_ON(dl_rq->this_bw < old); /* overflow */
+	WARN_ON_ONCE(dl_rq->this_bw < old); /* overflow */
 }
 
 static inline
@@ -286,10 +286,10 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
 
 	lockdep_assert_rq_held(rq_of_dl_rq(dl_rq));
 	dl_rq->this_bw -= dl_bw;
-	SCHED_WARN_ON(dl_rq->this_bw > old); /* underflow */
+	WARN_ON_ONCE(dl_rq->this_bw > old); /* underflow */
 	if (dl_rq->this_bw > old)
 		dl_rq->this_bw = 0;
-	SCHED_WARN_ON(dl_rq->running_bw > dl_rq->this_bw);
+	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
 }
 
 static inline
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0f1da199cfc7..953a5b9ec0cd 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2341,7 +2341,7 @@ static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq,
 {
 	int cpu = cpu_of(rq);
 
-	SCHED_WARN_ON(task_cpu(p) == cpu);
+	WARN_ON_ONCE(task_cpu(p) == cpu);
 
 	/*
 	 * If @p has migration disabled, @p->cpus_ptr is updated to contain only
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9dafb374d76d..89609ebd4904 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -399,7 +399,7 @@ static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
 
 static inline void assert_list_leaf_cfs_rq(struct rq *rq)
 {
-	SCHED_WARN_ON(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
+	WARN_ON_ONCE(rq->tmp_alone_branch != &rq->leaf_cfs_rq_list);
 }
 
 /* Iterate through all leaf cfs_rq's on a runqueue */
@@ -696,7 +696,7 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	s64 vlag, limit;
 
-	SCHED_WARN_ON(!se->on_rq);
+	WARN_ON_ONCE(!se->on_rq);
 
 	vlag = avg_vruntime(cfs_rq) - se->vruntime;
 	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
@@ -3317,7 +3317,7 @@ static void task_numa_work(struct callback_head *work)
 	bool vma_pids_skipped;
 	bool vma_pids_forced = false;
 
-	SCHED_WARN_ON(p != container_of(work, struct task_struct, numa_work));
+	WARN_ON_ONCE(p != container_of(work, struct task_struct, numa_work));
 
 	work->next = work;
 	/*
@@ -4036,7 +4036,7 @@ static inline bool load_avg_is_decayed(struct sched_avg *sa)
 	 * Make sure that rounding and/or propagation of PELT values never
 	 * break this.
 	 */
-	SCHED_WARN_ON(sa->load_avg ||
+	WARN_ON_ONCE(sa->load_avg ||
 		      sa->util_avg ||
 		      sa->runnable_avg);
 
@@ -5460,7 +5460,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	clear_buddies(cfs_rq, se);
 
 	if (flags & DEQUEUE_DELAYED) {
-		SCHED_WARN_ON(!se->sched_delayed);
+		WARN_ON_ONCE(!se->sched_delayed);
 	} else {
 		bool delay = sleep;
 		/*
@@ -5470,7 +5470,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		if (flags & DEQUEUE_SPECIAL)
 			delay = false;
 
-		SCHED_WARN_ON(delay && se->sched_delayed);
+		WARN_ON_ONCE(delay && se->sched_delayed);
 
 		if (sched_feat(DELAY_DEQUEUE) && delay &&
 		    !entity_eligible(cfs_rq, se)) {
@@ -5551,7 +5551,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 
 	update_stats_curr_start(cfs_rq, se);
-	SCHED_WARN_ON(cfs_rq->curr);
+	WARN_ON_ONCE(cfs_rq->curr);
 	cfs_rq->curr = se;
 
 	/*
@@ -5592,7 +5592,7 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	if (sched_feat(PICK_BUDDY) &&
 	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
 		/* ->next will never be delayed */
-		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
+		WARN_ON_ONCE(cfs_rq->next->sched_delayed);
 		return cfs_rq->next;
 	}
 
@@ -5628,7 +5628,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
-	SCHED_WARN_ON(cfs_rq->curr != prev);
+	WARN_ON_ONCE(cfs_rq->curr != prev);
 	cfs_rq->curr = NULL;
 }
 
@@ -5851,7 +5851,7 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 
 			cfs_rq->throttled_clock_self = 0;
 
-			if (SCHED_WARN_ON((s64)delta < 0))
+			if (WARN_ON_ONCE((s64)delta < 0))
 				delta = 0;
 
 			cfs_rq->throttled_clock_self_time += delta;
@@ -5871,7 +5871,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 		cfs_rq->throttled_clock_pelt = rq_clock_pelt(rq);
 		list_del_leaf_cfs_rq(cfs_rq);
 
-		SCHED_WARN_ON(cfs_rq->throttled_clock_self);
+		WARN_ON_ONCE(cfs_rq->throttled_clock_self);
 		if (cfs_rq->nr_queued)
 			cfs_rq->throttled_clock_self = rq_clock(rq);
 	}
@@ -5980,7 +5980,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 * throttled-list.  rq->lock protects completion.
 	 */
 	cfs_rq->throttled = 1;
-	SCHED_WARN_ON(cfs_rq->throttled_clock);
+	WARN_ON_ONCE(cfs_rq->throttled_clock);
 	if (cfs_rq->nr_queued)
 		cfs_rq->throttled_clock = rq_clock(rq);
 	return true;
@@ -6136,7 +6136,7 @@ static inline void __unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 	}
 
 	/* Already enqueued */
-	if (SCHED_WARN_ON(!list_empty(&cfs_rq->throttled_csd_list)))
+	if (WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_csd_list)))
 		return;
 
 	first = list_empty(&rq->cfsb_csd_list);
@@ -6155,7 +6155,7 @@ static void unthrottle_cfs_rq_async(struct cfs_rq *cfs_rq)
 {
 	lockdep_assert_rq_held(rq_of(cfs_rq));
 
-	if (SCHED_WARN_ON(!cfs_rq_throttled(cfs_rq) ||
+	if (WARN_ON_ONCE(!cfs_rq_throttled(cfs_rq) ||
 	    cfs_rq->runtime_remaining <= 0))
 		return;
 
@@ -6191,7 +6191,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 			goto next;
 
 		/* By the above checks, this should never be true */
-		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
+		WARN_ON_ONCE(cfs_rq->runtime_remaining > 0);
 
 		raw_spin_lock(&cfs_b->lock);
 		runtime = -cfs_rq->runtime_remaining + 1;
@@ -6212,7 +6212,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 				 * We currently only expect to be unthrottling
 				 * a single cfs_rq locally.
 				 */
-				SCHED_WARN_ON(!list_empty(&local_unthrottle));
+				WARN_ON_ONCE(!list_empty(&local_unthrottle));
 				list_add_tail(&cfs_rq->throttled_csd_list,
 					      &local_unthrottle);
 			}
@@ -6237,7 +6237,7 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 
 		rq_unlock_irqrestore(rq, &rf);
 	}
-	SCHED_WARN_ON(!list_empty(&local_unthrottle));
+	WARN_ON_ONCE(!list_empty(&local_unthrottle));
 
 	rcu_read_unlock();
 
@@ -6789,7 +6789,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
 
-	SCHED_WARN_ON(task_rq(p) != rq);
+	WARN_ON_ONCE(task_rq(p) != rq);
 
 	if (rq->cfs.h_nr_queued > 1) {
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
@@ -6900,8 +6900,8 @@ requeue_delayed_entity(struct sched_entity *se)
 	 * Because a delayed entity is one that is still on
 	 * the runqueue competing until elegibility.
 	 */
-	SCHED_WARN_ON(!se->sched_delayed);
-	SCHED_WARN_ON(!se->on_rq);
+	WARN_ON_ONCE(!se->sched_delayed);
+	WARN_ON_ONCE(!se->on_rq);
 
 	if (sched_feat(DELAY_ZERO)) {
 		update_entity_lag(cfs_rq, se);
@@ -7161,8 +7161,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		rq->next_balance = jiffies;
 
 	if (p && task_delayed) {
-		SCHED_WARN_ON(!task_sleep);
-		SCHED_WARN_ON(p->on_rq != 1);
+		WARN_ON_ONCE(!task_sleep);
+		WARN_ON_ONCE(p->on_rq != 1);
 
 		/* Fix-up what dequeue_task_fair() skipped */
 		hrtick_update(rq);
@@ -8740,7 +8740,7 @@ static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
 static void set_next_buddy(struct sched_entity *se)
 {
 	for_each_sched_entity(se) {
-		if (SCHED_WARN_ON(!se->on_rq))
+		if (WARN_ON_ONCE(!se->on_rq))
 			return;
 		if (se_is_idle(se))
 			return;
@@ -12484,7 +12484,7 @@ static void set_cpu_sd_state_busy(int cpu)
 
 void nohz_balance_exit_idle(struct rq *rq)
 {
-	SCHED_WARN_ON(rq != this_rq());
+	WARN_ON_ONCE(rq != this_rq());
 
 	if (likely(!rq->nohz_tick_stopped))
 		return;
@@ -12520,7 +12520,7 @@ void nohz_balance_enter_idle(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	SCHED_WARN_ON(cpu != smp_processor_id());
+	WARN_ON_ONCE(cpu != smp_processor_id());
 
 	/* If this CPU is going down, then nothing needs to be done: */
 	if (!cpu_active(cpu))
@@ -12603,7 +12603,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 	int balance_cpu;
 	struct rq *rq;
 
-	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
+	WARN_ON_ONCE((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
 
 	/*
 	 * We assume there will be no idle load after this update and clear
@@ -13043,7 +13043,7 @@ bool cfs_prio_less(const struct task_struct *a, const struct task_struct *b,
 	struct cfs_rq *cfs_rqb;
 	s64 delta;
 
-	SCHED_WARN_ON(task_rq(b)->core != rq->core);
+	WARN_ON_ONCE(task_rq(b)->core != rq->core);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/*
@@ -13246,7 +13246,7 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
 
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
-	SCHED_WARN_ON(p->se.sched_delayed);
+	WARN_ON_ONCE(p->se.sched_delayed);
 
 	attach_task_cfs_rq(p);
 
@@ -13281,7 +13281,7 @@ static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool firs
 	if (!first)
 		return;
 
-	SCHED_WARN_ON(se->sched_delayed);
+	WARN_ON_ONCE(se->sched_delayed);
 
 	if (hrtick_enabled_fair(rq))
 		hrtick_start_fair(rq, p);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..926281ac3ac0 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1713,7 +1713,7 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 	BUG_ON(idx >= MAX_RT_PRIO);
 
 	queue = array->queue + idx;
-	if (SCHED_WARN_ON(list_empty(queue)))
+	if (WARN_ON_ONCE(list_empty(queue)))
 		return NULL;
 	next = list_entry(queue->next, struct sched_rt_entity, run_list);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0212a0c5534a..189f7b033dab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -91,12 +91,6 @@ struct cpuidle_state;
 #include "cpupri.h"
 #include "cpudeadline.h"
 
-#ifdef CONFIG_SCHED_DEBUG
-# define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)
-#else
-# define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
-#endif
-
 /* task_struct::on_rq states: */
 #define TASK_ON_RQ_QUEUED	1
 #define TASK_ON_RQ_MIGRATING	2
@@ -1571,7 +1565,7 @@ static inline void update_idle_core(struct rq *rq) { }
 
 static inline struct task_struct *task_of(struct sched_entity *se)
 {
-	SCHED_WARN_ON(!entity_is_task(se));
+	WARN_ON_ONCE(!entity_is_task(se));
 	return container_of(se, struct task_struct, se);
 }
 
@@ -1652,7 +1646,7 @@ static inline void assert_clock_updated(struct rq *rq)
 	 * The only reason for not seeing a clock update since the
 	 * last rq_pin_lock() is if we're currently skipping updates.
 	 */
-	SCHED_WARN_ON(rq->clock_update_flags < RQCF_ACT_SKIP);
+	WARN_ON_ONCE(rq->clock_update_flags < RQCF_ACT_SKIP);
 }
 
 static inline u64 rq_clock(struct rq *rq)
@@ -1699,7 +1693,7 @@ static inline void rq_clock_cancel_skipupdate(struct rq *rq)
 static inline void rq_clock_start_loop_update(struct rq *rq)
 {
 	lockdep_assert_rq_held(rq);
-	SCHED_WARN_ON(rq->clock_update_flags & RQCF_ACT_SKIP);
+	WARN_ON_ONCE(rq->clock_update_flags & RQCF_ACT_SKIP);
 	rq->clock_update_flags |= RQCF_ACT_SKIP;
 }
 
@@ -1774,7 +1768,7 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
 # ifdef CONFIG_SMP
-	SCHED_WARN_ON(rq->balance_callback && rq->balance_callback != &balance_push_callback);
+	WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);
 # endif
 #endif
 }
@@ -2685,7 +2679,7 @@ static inline void idle_set_state(struct rq *rq,
 
 static inline struct cpuidle_state *idle_get_state(struct rq *rq)
 {
-	SCHED_WARN_ON(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held());
 
 	return rq->idle_state;
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 19cdbe96f93d..452826df6ae1 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -144,7 +144,7 @@ static inline void psi_enqueue(struct task_struct *p, int flags)
 
 	if (p->se.sched_delayed) {
 		/* CPU migration of "sleeping" task */
-		SCHED_WARN_ON(!(flags & ENQUEUE_MIGRATED));
+		WARN_ON_ONCE(!(flags & ENQUEUE_MIGRATED));
 		if (p->in_memstall)
 			set |= TSK_MEMSTALL;
 		if (p->in_iowait)
-- 
2.45.2



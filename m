Return-Path: <linux-kernel+bounces-190531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35D08CFF95
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8AD281F65
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CD815E5BB;
	Mon, 27 May 2024 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esc8Z3TF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997115E5A7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811647; cv=none; b=Ok7ULydshoEZ7A3pbGIpDEqo2tRzW3GpKX2KpTPjsrDG72g/RywiliPg8NtGfzKW5ouOtEuwZwGAkxzpy4TNZoiGN+7RuQkUDEjwqZpDdJuFnJjTtrME4t++04aFPD0wRpnAjquACrnAcc0p9a4dNLAPxdS0C102arz3JO4JEKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811647; c=relaxed/simple;
	bh=bhGVa6euB5QFhz9UojwRvbtIeiZhpw1lAIXXI1eWUe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdVZfolYN0eeELHX9E/FjrMlT6E82ikK5kTvlp5N2QfPC/jwUSjFzp/Cj8Y8vsbFPWJH0kjzolYrq7c3tOsDyoveK+kXMdnz164fAUJIZIiAJkKVCLfU868h6PfHcYbuhFB2lvHPwVH1CkkTX3rqartfKh/r/HqX0grMlySjiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esc8Z3TF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01295C4AF07;
	Mon, 27 May 2024 12:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716811646;
	bh=bhGVa6euB5QFhz9UojwRvbtIeiZhpw1lAIXXI1eWUe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=esc8Z3TFPTxs1e6lLvlYTE5rCKVIRi2dbnzcjPfGsm+Tj+s90EuJSmt3SqpdztVMM
	 mxsByA/O656yvH0fIsT11TiBdtW4aXGQ1eCzHPbGn5FOkDZjIno+/P5JoQbPhAcjRl
	 z0X8TK20dBa2mpMd+l1VSqkgwSMBatm6PgqB6P68tlyukD72yh3M13mhaNqhGzA57Z
	 3VCyyJmftZ2sfSG3JxF1F4Lmv8y6mT0Zhhossb6bUrHqAyepQR3wlq/KyIV+aU6Ub4
	 YWe8PkXcjunU+i5dXb8kVrSpXNRT2KVamLhyL/3hAxH9B43l7QRjU2+rFyoYJ1vGsx
	 wq4WMN+r9exZQ==
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	bristot@kernel.org,
	Phil Auld <pauld@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Youssef Esmat <youssefesmat@google.com>
Subject: [PATCH V7 4/9] sched/fair: Add trivial fair server
Date: Mon, 27 May 2024 14:06:50 +0200
Message-ID: <b6b0bcefaf25391bcf5b6ecdb9f1218de402d42e.1716811044.git.bristot@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716811043.git.bristot@kernel.org>
References: <cover.1716811043.git.bristot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

Use deadline servers to service fair tasks.

This patch adds a fair_server deadline entity which acts as a container
for fair entities and can be used to fix starvation when higher priority
(wrt fair) tasks are monopolizing CPU(s).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/core.c     |  1 +
 kernel/sched/deadline.c | 23 +++++++++++++++++++++++
 kernel/sched/fair.c     | 34 ++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |  4 ++++
 4 files changed, 62 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6d01863f93ca..53f0470a1d0a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10057,6 +10057,7 @@ void __init sched_init(void)
 #endif /* CONFIG_SMP */
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
+		fair_server_init(rq);
 
 #ifdef CONFIG_SCHED_CORE
 		rq->core = rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c75d1307d86d..b69d6c3e1587 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1381,6 +1381,13 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 			resched_curr(rq);
 	}
 
+	/*
+	 * The fair server (sole dl_server) does not account for real-time
+	 * workload because it is running fair work.
+	 */
+	if (dl_se == &rq->fair_server)
+		return;
+
 	/*
 	 * Because -- for now -- we share the rt bandwidth, we need to
 	 * account our runtime there too, otherwise actual rt tasks
@@ -1414,15 +1421,31 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
 
 void dl_server_start(struct sched_dl_entity *dl_se)
 {
+	struct rq *rq = dl_se->rq;
+
 	if (!dl_server(dl_se)) {
+		/* Disabled */
+		dl_se->dl_runtime = 0;
+		dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
+		dl_se->dl_period = 1000 * NSEC_PER_MSEC;
+
 		dl_se->dl_server = 1;
 		setup_new_dl_entity(dl_se);
 	}
+
+	if (!dl_se->dl_runtime)
+		return;
+
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
+	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
+		resched_curr(dl_se->rq);
 }
 
 void dl_server_stop(struct sched_dl_entity *dl_se)
 {
+	if (!dl_se->dl_runtime)
+		return;
+
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8a5b1ae0aa55..2d5d3e6c1e72 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5766,6 +5766,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, idle_task_delta, dequeue = 1;
+	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5838,6 +5839,9 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	sub_nr_running(rq, task_delta);
 
 done:
+	/* Stop the fair server if throttling resulted in no runnable tasks */
+	if (rq_h_nr_running && !rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
@@ -5855,6 +5859,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, idle_task_delta;
+	long rq_h_nr_running = rq->cfs.h_nr_running;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -5930,6 +5935,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 unthrottle_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
+	/* Start the fair server if un-throttling resulted in new runnable tasks */
+	if (!rq_h_nr_running && rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/* Determine whether we need to wake up potentially idle CPU: */
 	if (rq->curr == rq->idle && rq->cfs.nr_running)
 		resched_curr(rq);
@@ -6760,6 +6769,9 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	util_est_enqueue(&rq->cfs, p);
 
+	if (!throttled_hierarchy(task_cfs_rq(p)) && !rq->cfs.h_nr_running)
+		dl_server_start(&rq->fair_server);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -6904,6 +6916,9 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		rq->next_balance = jiffies;
 
 dequeue_throttle:
+	if (!throttled_hierarchy(task_cfs_rq(p)) && !rq->cfs.h_nr_running)
+		dl_server_stop(&rq->fair_server);
+
 	util_est_update(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
@@ -8607,6 +8622,25 @@ static struct task_struct *__pick_next_task_fair(struct rq *rq)
 	return pick_next_task_fair(rq, NULL, NULL);
 }
 
+static bool fair_server_has_tasks(struct sched_dl_entity *dl_se)
+{
+	return !!dl_se->rq->cfs.nr_running;
+}
+
+static struct task_struct *fair_server_pick(struct sched_dl_entity *dl_se)
+{
+	return pick_next_task_fair(dl_se->rq, NULL, NULL);
+}
+
+void fair_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se = &rq->fair_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, fair_server_has_tasks, fair_server_pick);
+}
+
 /*
  * Account for a descheduled task:
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a831af102070..39c9669b23a7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -356,6 +356,8 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 		    dl_server_has_tasks_f has_tasks,
 		    dl_server_pick_f pick);
 
+extern void fair_server_init(struct rq *rq);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 struct cfs_rq;
@@ -1037,6 +1039,8 @@ struct rq {
 	struct rt_rq		rt;
 	struct dl_rq		dl;
 
+	struct sched_dl_entity	fair_server;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
 	struct list_head	leaf_cfs_rq_list;
-- 
2.45.1



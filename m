Return-Path: <linux-kernel+bounces-190533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F368CFF97
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0251F21260
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A879C15EFA5;
	Mon, 27 May 2024 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhPhr/Uy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A315ECFA
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716811657; cv=none; b=RJfuyQDLdYncWjE2pMzL8AfOul2MS1sbMs1BF8E2FZXKcJvoPvX59MwXjAumBJkvwGV3y5gTWxGI0faqMberFOjjglZ/6d9tF21DCvgJZvKDKMLWM15pZ/Yd/ZnmKwts2pt8sEPAaxxThbICAFjGVnNqQkio+eaL7Xtsf2TG/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716811657; c=relaxed/simple;
	bh=5lup1FZO/XefFIZhrWgD25s1f4FfOt8VZtpHNBZ1gUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kz7E0RaSY2fuJE4+NK2dlycndIMjRuC/5mBZ34yiBexkxvdiFGuN3SyqC1CU7qx/FAxk298Ql5zGRuD0J1m6x8MKf77aNUeXkhnWeGt4GH0xqdypUOVS7rX5pxNqE3838ERNExSm7uFenyN4SRrN5l0hgTSmOS4dvTbNc2AeDEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhPhr/Uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFD7C2BBFC;
	Mon, 27 May 2024 12:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716811657;
	bh=5lup1FZO/XefFIZhrWgD25s1f4FfOt8VZtpHNBZ1gUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XhPhr/UyLxbKAs2IMOjk0VguggdStLske5yroaSsJC+j0FI7vCE5mPMed9chLcnsc
	 IWAKfpCrynUsrFZ5efHHA11nyP4WeOp1dX6ru4ZHWwZi4GcGJR9yhXs3T2MRgRKmh8
	 RRBRhjDqBAF8CaBmKbgXw94BrfbZp0JvLUcYHu+ZtGvzDxQruLS9Xv/WWZSclviW0F
	 ProR84+7gs33nQK+OuLEmIa3WD9y2CtqCRI/F4jEMFsd6cTDJarhekrxRrE0yh48k3
	 H507S4H+tutcesP6rz98WdH579J3/tvND+yWHm0rGUDj39m3e9fEOlVtfZ5gTg6qCY
	 4VBQQrg9Ttq2A==
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
Subject: [PATCH V7 6/9] sched/fair: Fair server interface
Date: Mon, 27 May 2024 14:06:52 +0200
Message-ID: <a9ef9fc69bcedb44bddc9bc34f2b313296052819.1716811044.git.bristot@kernel.org>
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

Add an interface for fair server setup on debugfs.

Each CPU has two files under /debug/sched/fair_server/cpu{ID}:

 - runtime: set runtime in ns
 - period:  set period in ns

This then leaves /proc/sys/kernel/sched_rt_{period,runtime}_us to set
bounds on admission control.

The interface also add the server to the dl bandwidth accounting.

Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/deadline.c | 103 +++++++++++++++++++++-----
 kernel/sched/debug.c    | 159 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |   3 +
 kernel/sched/topology.c |   8 ++
 4 files changed, 256 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index eddfe18d9762..f8afe0a69c1e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -320,19 +320,12 @@ void sub_running_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 		__sub_running_bw(dl_se->dl_bw, dl_rq);
 }
 
-static void dl_change_utilization(struct task_struct *p, u64 new_bw)
+static void dl_rq_change_utilization(struct rq *rq, struct sched_dl_entity *dl_se, u64 new_bw)
 {
-	struct rq *rq;
-
-	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
-
-	if (task_on_rq_queued(p))
-		return;
+	if (dl_se->dl_non_contending) {
+		sub_running_bw(dl_se, &rq->dl);
+		dl_se->dl_non_contending = 0;
 
-	rq = task_rq(p);
-	if (p->dl.dl_non_contending) {
-		sub_running_bw(&p->dl, &rq->dl);
-		p->dl.dl_non_contending = 0;
 		/*
 		 * If the timer handler is currently running and the
 		 * timer cannot be canceled, inactive_task_timer()
@@ -340,13 +333,25 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
-			put_task_struct(p);
+		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
+			if (!dl_server(dl_se))
+				put_task_struct(dl_task_of(dl_se));
+		}
 	}
-	__sub_rq_bw(p->dl.dl_bw, &rq->dl);
+	__sub_rq_bw(dl_se->dl_bw, &rq->dl);
 	__add_rq_bw(new_bw, &rq->dl);
 }
 
+static void dl_change_utilization(struct task_struct *p, u64 new_bw)
+{
+	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
+
+	if (task_on_rq_queued(p))
+		return;
+
+	dl_rq_change_utilization(task_rq(p), &p->dl, new_bw);
+}
+
 static void __dl_clear_params(struct sched_dl_entity *dl_se);
 
 /*
@@ -1621,11 +1626,17 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
 
+	/*
+	 * XXX: the apply do not work fine at the init phase for the
+	 * fair server because things are not yet set. We need to improve
+	 * this before getting generic.
+	 */
 	if (!dl_server(dl_se)) {
 		/* Disabled */
-		dl_se->dl_runtime = 0;
-		dl_se->dl_deadline = 1000 * NSEC_PER_MSEC;
-		dl_se->dl_period = 1000 * NSEC_PER_MSEC;
+		u64 runtime = 0;
+		u64 period = 1000 * NSEC_PER_MSEC;
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
 
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
@@ -1660,6 +1671,64 @@ void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 	dl_se->server_pick = pick;
 }
 
+void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq)
+{
+	u64 new_bw = dl_se->dl_bw;
+	int cpu = cpu_of(rq);
+	struct dl_bw *dl_b;
+
+	dl_b = dl_bw_of(cpu_of(rq));
+	guard(raw_spinlock)(&dl_b->lock);
+
+	if (!dl_bw_cpus(cpu))
+		return;
+
+	__dl_add(dl_b, new_bw, dl_bw_cpus(cpu));
+}
+
+int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 period, bool init)
+{
+	u64 old_bw = init ? 0 : to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+	u64 new_bw = to_ratio(period, runtime);
+	struct rq *rq = dl_se->rq;
+	int cpu = cpu_of(rq);
+	struct dl_bw *dl_b;
+	unsigned long cap;
+	int retval = 0;
+	int cpus;
+
+	dl_b = dl_bw_of(cpu);
+	guard(raw_spinlock)(&dl_b->lock);
+
+	cpus = dl_bw_cpus(cpu);
+	cap = dl_bw_capacity(cpu);
+
+	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
+		return -EBUSY;
+
+	if (init) {
+		__add_rq_bw(new_bw, &rq->dl);
+		__dl_add(dl_b, new_bw, cpus);
+	} else {
+		__dl_sub(dl_b, dl_se->dl_bw, cpus);
+		__dl_add(dl_b, new_bw, cpus);
+
+		dl_rq_change_utilization(rq, dl_se, new_bw);
+	}
+
+	dl_se->dl_runtime = runtime;
+	dl_se->dl_deadline = period;
+	dl_se->dl_period = period;
+
+	dl_se->runtime = 0;
+	dl_se->deadline = 0;
+
+	dl_se->dl_bw = to_ratio(dl_se->dl_period, dl_se->dl_runtime);
+	dl_se->dl_density = to_ratio(dl_se->dl_deadline, dl_se->dl_runtime);
+
+	return retval;
+}
+
 /*
  * Update the current task's runtime statistics (provided it is still
  * a -deadline task and has not been removed from the dl_rq).
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c1eb9a1afd13..b14ffb100867 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -333,8 +333,165 @@ static const struct file_operations sched_debug_fops = {
 	.release	= seq_release,
 };
 
+enum dl_param {
+	DL_RUNTIME = 0,
+	DL_PERIOD,
+};
+
+static unsigned long fair_server_period_max = (1 << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+
+static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
+				       size_t cnt, loff_t *ppos, enum dl_param param)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+	u64 runtime, period;
+	size_t err;
+	int retval;
+	u64 value;
+
+	err = kstrtoull_from_user(ubuf, cnt, 10, &value);
+	if (err)
+		return err;
+
+	scoped_guard (rq_lock_irqsave, rq) {
+		runtime  = rq->fair_server.dl_runtime;
+		period = rq->fair_server.dl_period;
+
+		switch (param) {
+		case DL_RUNTIME:
+			if (runtime == value)
+				break;
+			runtime = value;
+			break;
+		case DL_PERIOD:
+			if (value == period)
+				break;
+			period = value;
+			break;
+		}
+
+		if (runtime > period ||
+		    period > fair_server_period_max ||
+		    period < fair_server_period_min) {
+			return  -EINVAL;
+		}
+
+		if (rq->cfs.h_nr_running) {
+			update_rq_clock(rq);
+			dl_server_stop(&rq->fair_server);
+		}
+
+		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		if (retval)
+			cnt = retval;
+
+		if (!runtime)
+			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
+					cpu_of(rq));
+
+		if (rq->cfs.h_nr_running)
+			dl_server_start(&rq->fair_server);
+	}
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+	u64 value;
+
+	switch (param) {
+	case DL_RUNTIME:
+		value = rq->fair_server.dl_runtime;
+		break;
+	case DL_PERIOD:
+		value = rq->fair_server.dl_period;
+		break;
+	}
+
+	seq_printf(m, "%llu\n", value);
+	return 0;
+
+}
+
+static ssize_t
+sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+}
+
+static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
+{
+	return sched_fair_server_show(m, v, DL_RUNTIME);
+}
+
+static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_fair_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations fair_server_runtime_fops = {
+	.open		= sched_fair_server_runtime_open,
+	.write		= sched_fair_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static ssize_t
+sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+}
+
+static int sched_fair_server_period_show(struct seq_file *m, void *v)
+{
+	return sched_fair_server_show(m, v, DL_PERIOD);
+}
+
+static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_fair_server_period_show, inode->i_private);
+}
+
+static const struct file_operations fair_server_period_fops = {
+	.open		= sched_fair_server_period_open,
+	.write		= sched_fair_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static struct dentry *debugfs_sched;
 
+static void debugfs_fair_server_init(void)
+{
+	struct dentry *d_fair;
+	unsigned long cpu;
+
+	d_fair = debugfs_create_dir("fair_server", debugfs_sched);
+	if (!d_fair)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_fair);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &fair_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &fair_server_period_fops);
+	}
+}
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -374,6 +531,8 @@ static __init int sched_init_debug(void)
 
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
+	debugfs_fair_server_init();
+
 	return 0;
 }
 late_initcall(sched_init_debug);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76751b945474..ed7be7b085af 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -359,6 +359,9 @@ extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
 extern void dl_server_update_idle_time(struct rq *rq,
 		    struct task_struct *p);
 extern void fair_server_init(struct rq *rq);
+extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq);
+extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
+		    u64 runtime, u64 period, bool init);
 
 #ifdef CONFIG_CGROUP_SCHED
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a6994a1fcc90..a172ed4d95af 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -516,6 +516,14 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (cpumask_test_cpu(rq->cpu, cpu_active_mask))
 		set_rq_online(rq);
 
+	/*
+	 * Because the rq is not a task, dl_add_task_root_domain() did not
+	 * move the fair server bw to the rd if it already started.
+	 * Add it now.
+	 */
+	if (rq->fair_server.dl_server)
+		__dl_server_attach_root(&rq->fair_server, rq);
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
-- 
2.45.1



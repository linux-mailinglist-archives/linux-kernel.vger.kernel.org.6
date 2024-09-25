Return-Path: <linux-kernel+bounces-337818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63C4984F54
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147651C22D84
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFADB17BBE;
	Wed, 25 Sep 2024 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRC562H/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3865C10A18
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222790; cv=none; b=N9dFd4R2N8Iiq836Opj/0Qu3Ap45KZvRWJDm1+MEPI03/K70USEOXwqtFDjVi5XaWEGHAe6Y56CrWQMpEN8EXQRsf+hfZ9xgcHmpx4JdmJHKa0fbOq6Hqa351wLzHfsnEs2OvfiecNGg1ZZWX1nzcY6K3kfTn2aWCnlnut1Dg4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222790; c=relaxed/simple;
	bh=FcejQOO54iM2SmpT8VmHQOjBORJ1SGaATVzWJMPBM5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbpR7fwMbd14YIgJdwFDPBV5aPZaNnWcvXFN71Stx84OaK+RXwBHtcHVHpoPB8aJTAbWIPkPmg97RK7eFmRA9bmYGsXlQYDjI7i7i2Lyjo9ojXaRa2MPs/3tOq/erw4SKYyeL9ic0uJdS/aPpLfdv+BlImQw8v3+UiYtnJxXR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRC562H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A73C4CED1;
	Wed, 25 Sep 2024 00:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727222790;
	bh=FcejQOO54iM2SmpT8VmHQOjBORJ1SGaATVzWJMPBM5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cRC562H/ApBmm+p8g2xxVQYVBtaj3DWFnLocnQisYcj+dpbiYojESxu2Xr47KLlE4
	 mASvK2mCMHAN4RyvxUB7geObp3atTDQBNYEzAjSgU8sRyG1tX2N+vT9IKxrCZFw524
	 nPBYxOJKO6zcdHXiRs2XvL2aLXi6Fu1PuSLsf876Red9+al7bNRmF9Eh8avpvpKb3r
	 s6paDfh5MB9w3GaCbDadVqBsCt8TzvkfyUR4d9+Y4pEYN5ZvaRV5ZJwKj+Bb9gP3f+
	 0XDt1zX3g9inOMEwDPXzV0vAZ5dgBHf65dvPcumazyxHSesd9uOZN+K6KbpGlEDBp7
	 icYnumwYBeHaw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] sched_ext: Split the global DSQ per NUMA node
Date: Tue, 24 Sep 2024 14:06:06 -1000
Message-ID: <20240925000622.1972325-5-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925000622.1972325-1-tj@kernel.org>
References: <20240925000622.1972325-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the bypass mode, the global DSQ is used to schedule all tasks in simple
FIFO order. All tasks are queued into the global DSQ and all CPUs try to
execute tasks from it. This creates a lot of cross-node cacheline accesses
and scheduling across the node boundaries, and can lead to live-lock
conditions where the system takes tens of minutes to disable the BPF
scheduler while executing in the bypass mode.

Split the global DSQ per NUMA node. Each node has its own global DSQ. When a
task is dispatched to SCX_DSQ_GLOBAL, it's put into the global DSQ local to
the task's CPU and all CPUs in a node only consume its node-local global
DSQ.

This resolves a livelock condition which could be reliably triggered on an
2x EPYC 7642 system by running `stress-ng --race-sched 1024` together with
`stress-ng --workload 80 --workload-threads 10` while repeatedly enabling
and disabling a SCX scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 73 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index acb4db7827a4..949a3c43000a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -925,8 +925,15 @@ static unsigned long __percpu *scx_kick_cpus_pnt_seqs;
  */
 static DEFINE_PER_CPU(struct task_struct *, direct_dispatch_task);
 
-/* dispatch queues */
-static struct scx_dispatch_q __cacheline_aligned_in_smp scx_dsq_global;
+/*
+ * Dispatch queues.
+ *
+ * The global DSQ (%SCX_DSQ_GLOBAL) is split per-node for scalability. This is
+ * to avoid live-locking in bypass mode where all tasks are dispatched to
+ * %SCX_DSQ_GLOBAL and all CPUs consume from it. If per-node split isn't
+ * sufficient, it can be further split.
+ */
+static struct scx_dispatch_q **global_dsqs;
 
 static const struct rhashtable_params dsq_hash_params = {
 	.key_len		= 8,
@@ -1029,6 +1036,11 @@ static bool u32_before(u32 a, u32 b)
 	return (s32)(a - b) < 0;
 }
 
+static struct scx_dispatch_q *find_global_dsq(struct task_struct *p)
+{
+	return global_dsqs[cpu_to_node(task_cpu(p))];
+}
+
 static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
 {
 	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
@@ -1642,7 +1654,7 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 			scx_ops_error("attempting to dispatch to a destroyed dsq");
 			/* fall back to the global dsq */
 			raw_spin_unlock(&dsq->lock);
-			dsq = &scx_dsq_global;
+			dsq = find_global_dsq(p);
 			raw_spin_lock(&dsq->lock);
 		}
 	}
@@ -1820,20 +1832,20 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct rq *rq, u64 dsq_id,
 		s32 cpu = dsq_id & SCX_DSQ_LOCAL_CPU_MASK;
 
 		if (!ops_cpu_valid(cpu, "in SCX_DSQ_LOCAL_ON dispatch verdict"))
-			return &scx_dsq_global;
+			return find_global_dsq(p);
 
 		return &cpu_rq(cpu)->scx.local_dsq;
 	}
 
 	if (dsq_id == SCX_DSQ_GLOBAL)
-		dsq = &scx_dsq_global;
+		dsq = find_global_dsq(p);
 	else
 		dsq = find_user_dsq(dsq_id);
 
 	if (unlikely(!dsq)) {
 		scx_ops_error("non-existent DSQ 0x%llx for %s[%d]",
 			      dsq_id, p->comm, p->pid);
-		return &scx_dsq_global;
+		return find_global_dsq(p);
 	}
 
 	return dsq;
@@ -2005,7 +2017,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 global:
 	touch_core_sched(rq, p);	/* see the comment in local: */
 	p->scx.slice = SCX_SLICE_DFL;
-	dispatch_enqueue(&scx_dsq_global, p, enq_flags);
+	dispatch_enqueue(find_global_dsq(p), p, enq_flags);
 }
 
 static bool task_runnable(const struct task_struct *p)
@@ -2391,6 +2403,13 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 	return false;
 }
 
+static bool consume_global_dsq(struct rq *rq)
+{
+	int node = cpu_to_node(cpu_of(rq));
+
+	return consume_dispatch_q(rq, global_dsqs[node]);
+}
+
 /**
  * dispatch_to_local_dsq - Dispatch a task to a local dsq
  * @rq: current rq which is locked
@@ -2424,7 +2443,8 @@ static void dispatch_to_local_dsq(struct rq *rq, struct scx_dispatch_q *dst_dsq,
 
 #ifdef CONFIG_SMP
 	if (unlikely(!task_can_run_on_remote_rq(p, dst_rq, true))) {
-		dispatch_enqueue(&scx_dsq_global, p, enq_flags | SCX_ENQ_CLEAR_OPSS);
+		dispatch_enqueue(find_global_dsq(p), p,
+				 enq_flags | SCX_ENQ_CLEAR_OPSS);
 		return;
 	}
 
@@ -2624,7 +2644,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (rq->scx.local_dsq.nr)
 		goto has_tasks;
 
-	if (consume_dispatch_q(rq, &scx_dsq_global))
+	if (consume_global_dsq(rq))
 		goto has_tasks;
 
 	if (!SCX_HAS_OP(dispatch) || scx_rq_bypassing(rq) || !scx_rq_online(rq))
@@ -2649,7 +2669,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 
 		if (rq->scx.local_dsq.nr)
 			goto has_tasks;
-		if (consume_dispatch_q(rq, &scx_dsq_global))
+		if (consume_global_dsq(rq))
 			goto has_tasks;
 
 		/*
@@ -4924,7 +4944,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	struct scx_task_iter sti;
 	struct task_struct *p;
 	unsigned long timeout;
-	int i, cpu, ret;
+	int i, cpu, node, ret;
 
 	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
 			   cpu_possible_mask)) {
@@ -4943,6 +4963,34 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		}
 	}
 
+	if (!global_dsqs) {
+		struct scx_dispatch_q **dsqs;
+
+		dsqs = kcalloc(nr_node_ids, sizeof(dsqs[0]), GFP_KERNEL);
+		if (!dsqs) {
+			ret = -ENOMEM;
+			goto err_unlock;
+		}
+
+		for_each_node_state(node, N_POSSIBLE) {
+			struct scx_dispatch_q *dsq;
+
+			dsq = kzalloc_node(sizeof(*dsq), GFP_KERNEL, node);
+			if (!dsq) {
+				for_each_node_state(node, N_POSSIBLE)
+					kfree(dsqs[node]);
+				kfree(dsqs);
+				ret = -ENOMEM;
+				goto err_unlock;
+			}
+
+			init_dsq(dsq, SCX_DSQ_GLOBAL);
+			dsqs[node] = dsq;
+		}
+
+		global_dsqs = dsqs;
+	}
+
 	if (scx_ops_enable_state() != SCX_OPS_DISABLED) {
 		ret = -EBUSY;
 		goto err_unlock;
@@ -5777,7 +5825,6 @@ void __init init_sched_ext_class(void)
 		   SCX_TG_ONLINE);
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
-	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
 #ifdef CONFIG_SMP
 	BUG_ON(!alloc_cpumask_var(&idle_masks.cpu, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&idle_masks.smt, GFP_KERNEL));
@@ -6053,7 +6100,7 @@ static bool scx_dispatch_from_dsq(struct bpf_iter_scx_dsq_kern *kit,
 	if (dst_dsq->id == SCX_DSQ_LOCAL) {
 		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
 		if (!task_can_run_on_remote_rq(p, dst_rq, true)) {
-			dst_dsq = &scx_dsq_global;
+			dst_dsq = find_global_dsq(p);
 			dst_rq = src_rq;
 		}
 	} else {
-- 
2.46.0



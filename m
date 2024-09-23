Return-Path: <linux-kernel+bounces-336245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DBD97F105
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD10FB220B8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839021A3BBC;
	Mon, 23 Sep 2024 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G797nmR3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E031A3BA6
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118042; cv=none; b=NKh9Zj/AKGNufNnRb0TmwUlZUQOx/fl44i+twegQHyIbMK47iBRPJe0y3jH17FDqKDID/JletP44DYAOPb/RKUEQrvHsunlaAmrJ8gY+NfyqdnQu+DIAUu/8MLO8+64nHqHCO4e/wIaAEZ9GWA27pnBA2PCAHJw3iTIdi07TO50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118042; c=relaxed/simple;
	bh=JRYG9e8+5qhscE3BCpopPU6Tv/NZeKUR9N1H0N9whos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhPRkuIKOiNp8Nj1btcVtFuifcobZNsbqxmxH/LVd7Gs8Eg/nh0jI0tiUnNzSUZAS3+tSBjV3KLkhM5B8gpUvuYAMsYdefD2Z6h2dJQ6ovQVK5cL/814HgXxww2y3lbMwQwtB+VhOnik3Mx9s0LD1W+aqNwkzVIFb4sRSbA45Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G797nmR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43182C4CEC4;
	Mon, 23 Sep 2024 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118041;
	bh=JRYG9e8+5qhscE3BCpopPU6Tv/NZeKUR9N1H0N9whos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G797nmR32XdNjntMyqWmnC6RBiqW6mcu2LIxfkFwg57Fu2dKuuNv/CPg3Rvaai/of
	 H2C4yQ2PbLyaErlhvqy6GWYmgI0mdFkAIvMsaArifK6ZSFfea3VAJY15fVHaQZLfXw
	 0ia2ze2SgKb2KcKMxdNTgwgGMolrKJpbIHaaS4baJdhVAJLTsQw5QdlBA/gQ5Sa3Q8
	 0SlY9/cosKvyLc9UhLgb8iwYD2V7kbkvO2Jt+2p79C60DBHbZPzt5Dyy+lvUQB2wv/
	 Q7tIXluaPhuayG2MS3y24xP/Tl+ICXTnnwfF7ZvfPzDt2uqStFO5lDppkgIIfGphXS
	 JaAjbNaqcGmEQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	aboorvad@linux.ibm.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 8/8] sched_ext: Decouple locks in scx_ops_enable()
Date: Mon, 23 Sep 2024 08:59:35 -1000
Message-ID: <20240923190020.1446325-9-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923190020.1446325-1-tj@kernel.org>
References: <20240923190020.1446325-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The enable path uses three big locks - scx_fork_rwsem, scx_cgroup_rwsem and
cpus_read_lock. Currently, the locks are grabbed together which is prone to
locking order problems.

For example, currently, there is a possible deadlock involving
scx_fork_rwsem and cpus_read_lock. cpus_read_lock has to nest inside
scx_fork_rwsem due to locking order existing in other subsystems. However,
there exists a dependency in the other direction during hotplug if hotplug
needs to fork a new task, which happens in some cases. This leads to the
following deadlock:

       scx_ops_enable()                               hotplug

                                          percpu_down_write(&cpu_hotplug_lock)
   percpu_down_write(&scx_fork_rwsem)
   block on cpu_hotplug_lock
                                          kthread_create() waits for kthreadd
					  kthreadd blocks on scx_fork_rwsem

Note that this doesn't trigger lockdep because the hotplug side dependency
bounces through kthreadd.

With the preceding scx_cgroup_enabled change, this can be solved by
decoupling cpus_read_lock, which is needed for static_key manipulations,
from the other two locks.

- Move the first block of static_key manipulations outside of scx_fork_rwsem
  and scx_cgroup_rwsem. This is now safe with the preceding
  scx_cgroup_enabled change.

- Drop scx_cgroup_rwsem and scx_fork_rwsem between the two task iteration
  blocks so that __scx_ops_enabled static_key enabling is outside the two
  rwsems.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-and-tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: http://lkml.kernel.org/r/8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com
---
 kernel/sched/ext.c | 67 +++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 18f95072866f..5fe0dfd97340 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5004,7 +5004,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, init);
 		if (ret) {
 			ret = ops_sanitize_err("init", ret);
-			goto err_disable_unlock_cpus;
+			cpus_read_unlock();
+			goto err_disable;
 		}
 	}
 
@@ -5047,54 +5048,30 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	scx_ops_bypass(true);
 
-	/*
-	 * Lock out forks, cgroup on/offlining and moves before opening the
-	 * floodgate so that they don't wander into the operations prematurely.
-	 *
-	 * We don't need to keep the CPUs stable but static_branch_*() requires
-	 * cpus_read_lock() and scx_cgroup_rwsem must nest inside
-	 * cpu_hotplug_lock because of the following dependency chain:
-	 *
-	 *   cpu_hotplug_lock --> cgroup_threadgroup_rwsem --> scx_cgroup_rwsem
-	 *
-	 * So, we need to do cpus_read_lock() before scx_cgroup_lock() and use
-	 * static_branch_*_cpuslocked().
-	 *
-	 * Note that cpu_hotplug_lock must nest inside scx_fork_rwsem due to the
-	 * following dependency chain:
-	 *
-	 *   scx_fork_rwsem --> pernet_ops_rwsem --> cpu_hotplug_lock
-	 */
-	percpu_down_write(&scx_fork_rwsem);
-	cpus_read_lock();
-	scx_cgroup_lock();
-
 	for (i = SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
 		if (((void (**)(void))ops)[i])
-			static_branch_enable_cpuslocked(&scx_has_op[i]);
+			static_branch_enable(&scx_has_op[i]);
 
 	if (ops->flags & SCX_OPS_ENQ_LAST)
-		static_branch_enable_cpuslocked(&scx_ops_enq_last);
+		static_branch_enable(&scx_ops_enq_last);
 
 	if (ops->flags & SCX_OPS_ENQ_EXITING)
-		static_branch_enable_cpuslocked(&scx_ops_enq_exiting);
+		static_branch_enable(&scx_ops_enq_exiting);
 	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
-		static_branch_enable_cpuslocked(&scx_ops_cpu_preempt);
+		static_branch_enable(&scx_ops_cpu_preempt);
 
 	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
 		reset_idle_masks();
-		static_branch_enable_cpuslocked(&scx_builtin_idle_enabled);
+		static_branch_enable(&scx_builtin_idle_enabled);
 	} else {
-		static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
+		static_branch_disable(&scx_builtin_idle_enabled);
 	}
 
 	/*
-	 * All cgroups should be initialized before letting in tasks. cgroup
-	 * on/offlining and task migrations are already locked out.
+	 * Lock out forks, cgroup on/offlining and moves before opening the
+	 * floodgate so that they don't wander into the operations prematurely.
 	 */
-	ret = scx_cgroup_init();
-	if (ret)
-		goto err_disable_unlock_all;
+	percpu_down_write(&scx_fork_rwsem);
 
 	WARN_ON_ONCE(scx_ops_init_task_enabled);
 	scx_ops_init_task_enabled = true;
@@ -5105,7 +5082,18 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * leaving as sched_ext_free() can handle both prepped and enabled
 	 * tasks. Prep all tasks first and then enable them with preemption
 	 * disabled.
+	 *
+	 * All cgroups should be initialized before scx_ops_init_task() so that
+	 * the BPF scheduler can reliably track each task's cgroup membership
+	 * from scx_ops_init_task(). Lock out cgroup on/offlining and task
+	 * migrations while tasks are being initialized so that
+	 * scx_cgroup_can_attach() never sees uninitialized tasks.
 	 */
+	scx_cgroup_lock();
+	ret = scx_cgroup_init();
+	if (ret)
+		goto err_disable_unlock_all;
+
 	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
@@ -5138,19 +5126,22 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	}
 	scx_task_iter_exit(&sti);
 	spin_unlock_irq(&scx_tasks_lock);
+	scx_cgroup_unlock();
+	percpu_up_write(&scx_fork_rwsem);
 
 	/*
 	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
 	 * all eligible tasks.
 	 */
 	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
-	static_branch_enable_cpuslocked(&__scx_ops_enabled);
+	static_branch_enable(&__scx_ops_enabled);
 
 	/*
 	 * We're fully committed and can't fail. The task READY -> ENABLED
 	 * transitions here are synchronized against sched_ext_free() through
 	 * scx_tasks_lock.
 	 */
+	percpu_down_write(&scx_fork_rwsem);
 	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
@@ -5168,10 +5159,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	}
 	scx_task_iter_exit(&sti);
 	spin_unlock_irq(&scx_tasks_lock);
-
-	scx_cgroup_unlock();
-	cpus_read_unlock();
 	percpu_up_write(&scx_fork_rwsem);
+
 	scx_ops_bypass(false);
 
 	/*
@@ -5214,8 +5203,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 	scx_ops_bypass(false);
-err_disable_unlock_cpus:
-	cpus_read_unlock();
 err_disable:
 	mutex_unlock(&scx_ops_enable_mutex);
 	/* must be fully disabled before returning */
-- 
2.46.0



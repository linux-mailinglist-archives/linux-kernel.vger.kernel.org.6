Return-Path: <linux-kernel+bounces-336244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F9A97F0FE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3186F2820B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AF41A3A95;
	Mon, 23 Sep 2024 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmaMg4EN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36871A38FB
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118040; cv=none; b=uW9Z51nKQRx8N+RuCc7NRguCvtZhS0E0u0i2yWOPX2cc00zDIoxW74xQ7Bv5H7guoBy6Eod45sE2q5rZuHtC4NRKPA2SfLs4nr23gtrlU3O+o7Dbx9/vIVrqb3M/acCVU6CSgzpJHFhS3MgFhO07g332iRrVfFW9Ki828gR7BPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118040; c=relaxed/simple;
	bh=5/vqN+InVauDjO/iJY++gdXLlEdSCH55EKUI6Uptgcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyeiV61QclKCsUPMUQk2SxlzDrUkfVCUNVVSzGoCTFwNaZbQVbJT6doS+Cacuj9kvnuDiMbEp6TGOboyy5redWnnRiU//KTmeP7OznPGvNI1wsHBggkL7oS5/2Zin1V4rncHSOwpYwlMWsepBmA7m9O8Ky9IBWjxYrTLfgyT5zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmaMg4EN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36269C4CEC5;
	Mon, 23 Sep 2024 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118040;
	bh=5/vqN+InVauDjO/iJY++gdXLlEdSCH55EKUI6Uptgcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JmaMg4ENKPN0edbz3p9NB7S5qwO48ZqDFe4POwFidvIk/HdEYtpbVb5ggGxdpru4u
	 PnZmUUEnsU14v1G/QQ5fmM4ZimdAwKbxyFd6J3ml9M68oogICUGf1114Q6tNigrpWw
	 FT483j2333l/cxm4wPsxyoZCxJuNI2jLP9uzoqW4WquT09GD+GbO8pMtNLLM8Mmmch
	 yovi0slz4LdkJnlHYf+N0LoLVvS4CUnQv+HrMmIC6CHPQ4fTvpXJ/SrFm9qYDvpo49
	 oKFOuTWz3h/rzZEQbCdTGSLl8aZcTMbhzXiLW7klHbIWKn8bz9HHZ+SmWAvWMHBfp2
	 Y5Bn/QPqixjcA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	aboorvad@linux.ibm.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/8] sched_ext: Decouple locks in scx_ops_disable_workfn()
Date: Mon, 23 Sep 2024 08:59:34 -1000
Message-ID: <20240923190020.1446325-8-tj@kernel.org>
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

The disable path uses three big locks - scx_fork_rwsem, scx_cgroup_rwsem and
cpus_read_lock. Currently, the locks are grabbed together which is prone to
locking order problems. With the preceding scx_cgroup_enabled change, we can
decouple them:

- As cgroup disabling no longer requires modifying a static_key which
  requires cpus_read_lock(), no need to grab cpus_read_lock() before
  grabbing scx_cgroup_rwsem.

- cgroup can now be independently disabled before tasks are moved back to
  the fair class.

Relocate scx_cgroup_exit() invocation before scx_fork_rwsem is grabbed, drop
now unnecessary cpus_read_lock() and move static_key operations out of
scx_fork_rwsem. This decouples all three locks in the disable path.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-and-tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: http://lkml.kernel.org/r/8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com
---
 kernel/sched/ext.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 06dc1011312d..18f95072866f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4439,21 +4439,23 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	WRITE_ONCE(scx_switching_all, false);
 
 	/*
-	 * Avoid racing against fork and cgroup changes. See scx_ops_enable()
-	 * for explanation on the locking order.
+	 * Shut down cgroup support before tasks so that the cgroup attach path
+	 * doesn't race against scx_ops_exit_task().
 	 */
-	percpu_down_write(&scx_fork_rwsem);
-	cpus_read_lock();
 	scx_cgroup_lock();
+	scx_cgroup_exit();
+	scx_cgroup_unlock();
 
-	scx_ops_init_task_enabled = false;
-
-	spin_lock_irq(&scx_tasks_lock);
-	scx_task_iter_init(&sti);
 	/*
 	 * The BPF scheduler is going away. All tasks including %TASK_DEAD ones
 	 * must be switched out and exited synchronously.
 	 */
+	percpu_down_write(&scx_fork_rwsem);
+
+	scx_ops_init_task_enabled = false;
+
+	spin_lock_irq(&scx_tasks_lock);
+	scx_task_iter_init(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
 		struct sched_enq_and_set_ctx ctx;
@@ -4471,23 +4473,18 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	}
 	scx_task_iter_exit(&sti);
 	spin_unlock_irq(&scx_tasks_lock);
+	percpu_up_write(&scx_fork_rwsem);
 
 	/* no task is on scx, turn off all the switches and flush in-progress calls */
-	static_branch_disable_cpuslocked(&__scx_ops_enabled);
+	static_branch_disable(&__scx_ops_enabled);
 	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
-		static_branch_disable_cpuslocked(&scx_has_op[i]);
-	static_branch_disable_cpuslocked(&scx_ops_enq_last);
-	static_branch_disable_cpuslocked(&scx_ops_enq_exiting);
-	static_branch_disable_cpuslocked(&scx_ops_cpu_preempt);
-	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
+		static_branch_disable(&scx_has_op[i]);
+	static_branch_disable(&scx_ops_enq_last);
+	static_branch_disable(&scx_ops_enq_exiting);
+	static_branch_disable(&scx_ops_cpu_preempt);
+	static_branch_disable(&scx_builtin_idle_enabled);
 	synchronize_rcu();
 
-	scx_cgroup_exit();
-
-	scx_cgroup_unlock();
-	cpus_read_unlock();
-	percpu_up_write(&scx_fork_rwsem);
-
 	if (ei->kind >= SCX_EXIT_ERROR) {
 		pr_err("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
 		       scx_ops.name, ei->reason);
-- 
2.46.0



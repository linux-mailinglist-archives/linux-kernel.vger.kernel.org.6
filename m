Return-Path: <linux-kernel+bounces-336239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5BD97F0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7731C2190A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A821A2C22;
	Mon, 23 Sep 2024 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkWVNrK3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E51A286E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118036; cv=none; b=vBbKLMqxX8fPf4IyR8jwtni8Xl0Gs544O007/SZp2qhCtC0zUtdhhC7RCov5suvxlpdlrQxdcuf2Ghlydnc7AWBACvsj/QXektdy/CCi0xVPtdC/ALxckONczU6w4OsPaR+QKwdvHaq3qpxl3ruir3WkH2LqyTr6ROzRu0qBAOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118036; c=relaxed/simple;
	bh=QOZu0TndXYoRKoqbvRlULpsc4VkwSX2Xi/rDYZBWrA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MprX8Su/hYy1ACkjqfiZKmVVrBdCDi9fGTcKg2+eRlrPvomT+YjHF+RTQSLrtMqAu1dUSpZzN7AKi7KQs/sxGfVLLDQx+EvXtjtZKZ5wTp89eY8RrQsGRs2EdCbfiUjVhmwpbax3DZuN0ApC+x7CkMK6WItnvlByNWXzC/AXmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkWVNrK3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E3CC4CEC4;
	Mon, 23 Sep 2024 19:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118036;
	bh=QOZu0TndXYoRKoqbvRlULpsc4VkwSX2Xi/rDYZBWrA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkWVNrK3nAHbwpVl39FzNq+qTpN+usMAiK7TWWrRfWUBbn2s5Gd5wxgPwGhchCedZ
	 8B1A9ybUbwK7+iqJdYVKis2kw1bzcLLjOeIm9RTdoRHc8SRThVnNp5gZQOmVf3ziQ/
	 IaTVDjXJ6h0QJUYWRfbQqlqP0z40d0EymI8FKpVXP5WLWQYsMEDp/SHY1Q5XQJI/lf
	 7up450BL2ltuugD2M891uvbxvJcg4gnwoBfU+jM+3KNZETWEZzim47KYSIsgP2Yseb
	 B+KVE0PJYTbEDARoWYmPDqfvC3rJFc2ZbtDvveEa5HD0vosfL0yzQUNSwx43lRvz2n
	 Hq6+gJHEh9tMA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	aboorvad@linux.ibm.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/8] sched_ext: Initialize in bypass mode
Date: Mon, 23 Sep 2024 08:59:30 -1000
Message-ID: <20240923190020.1446325-4-tj@kernel.org>
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

scx_ops_enable() used preempt_disable() around the task iteration loop to
switch tasks into SCX to guarantee forward progress of the task which is
running scx_ops_enable(). However, in the gap between setting
__scx_ops_enabled and preeempt_disable(), an external entity can put tasks
including the enabling one into SCX prematurely, which can lead to
malfunctions including stalls.

The bypass mode can wrap the entire enabling operation and guarantee forward
progress no matter what the BPF scheduler does. Use the bypass mode instead
to guarantee forward progress while enabling.

While at it, release and regrab scx_tasks_lock between the two task
iteration locks in scx_ops_enable() for clarity as there is no reason to
keep holding the lock between them.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2422b2abee6e..1b4b6439cd1a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5030,6 +5030,14 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
 			   scx_watchdog_timeout / 2);
 
+	/*
+	 * Once __scx_ops_enabled is set, %current can be switched to SCX
+	 * anytime. This can lead to stalls as some BPF schedulers (e.g.
+	 * userspace scheduling) may not function correctly before all tasks are
+	 * switched. Init in bypass mode to guarantee forward progress.
+	 */
+	scx_ops_bypass(true);
+
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
 	 * floodgate so that they don't wander into the operations prematurely.
@@ -5089,7 +5097,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * disabled.
 	 */
 	spin_lock_irq(&scx_tasks_lock);
-
 	scx_task_iter_init(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		/*
@@ -5118,22 +5125,19 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		spin_lock_irq(&scx_tasks_lock);
 	}
 	scx_task_iter_exit(&sti);
+	spin_unlock_irq(&scx_tasks_lock);
 
 	/*
-	 * All tasks are prepped but are still ops-disabled. Ensure that
-	 * %current can't be scheduled out and switch everyone.
-	 * preempt_disable() is necessary because we can't guarantee that
-	 * %current won't be starved if scheduled out while switching.
+	 * All tasks are prepped but the tasks are not enabled. Switch everyone.
 	 */
-	preempt_disable();
+	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
 
 	/*
 	 * We're fully committed and can't fail. The PREPPED -> ENABLED
 	 * transitions here are synchronized against sched_ext_free() through
 	 * scx_tasks_lock.
 	 */
-	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
-
+	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
@@ -5150,12 +5154,12 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		check_class_changed(task_rq(p), p, old_class, p->prio);
 	}
 	scx_task_iter_exit(&sti);
-
 	spin_unlock_irq(&scx_tasks_lock);
-	preempt_enable();
+
 	scx_cgroup_unlock();
 	cpus_read_unlock();
 	percpu_up_write(&scx_fork_rwsem);
+	scx_ops_bypass(false);
 
 	/*
 	 * Returning an error code here would lose the recorded error
@@ -5196,6 +5200,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 err_disable_unlock_all:
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
+	scx_ops_bypass(false);
 err_disable_unlock_cpus:
 	cpus_read_unlock();
 err_disable:
-- 
2.46.0



Return-Path: <linux-kernel+bounces-336242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147E497F0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC018281DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533861A305F;
	Mon, 23 Sep 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPj/Y2Yx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE31A3044
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118038; cv=none; b=KrGiBgTZL1IUrl9W9mdtxSpHLJeUADrNQu+0ShqGc4rw4O7yNErPnw4sJa0e0sPwvBK8fy2zqP4U4X8Xp6sA67QlP2paVo7cNZPGYItk7JKO6iKwEyrBByBsgfLZQiQpEPRqRxxKHaULFHRAJstr5aS12SOdF5hWmUo0MGFlZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118038; c=relaxed/simple;
	bh=B5V2AHHWaV2NEaqxe+k8pL0KhUjJZqcYHpi3EUocjrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+fLrHImCaGGURdFweD4vQXIe7VYMXDcBfZ9sStTXl3DFmNqwUI0Csf+7pKpDOktaJymG0Flaob1TNiqh8nxhjaW9Bq7QXoOdO01i2c3fgNT9mpQ8vzJ83daE3+5c/B8baAeI96ZQJ0q1LecVuyKB13wtqHSR+KGifdW8saMpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPj/Y2Yx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DFDC4CEC4;
	Mon, 23 Sep 2024 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118038;
	bh=B5V2AHHWaV2NEaqxe+k8pL0KhUjJZqcYHpi3EUocjrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HPj/Y2YxtSESuwvLEJ2xWxH1shB9wV3pr8Etxz678EVJHSQEWAYYnv1vo1q6qCM+p
	 BwzcqZK5sTdGr8JKtzC+bt4JygVlsDKz06wUAYCNJ9kqEKJI/njuvWobmO9BJ5antj
	 wufsktjAo9OM/dcbX48DuGTSW6HM+Q4akHIqzsc3kEi7R8Eq+i9xrKHgC4JfBIBW6u
	 djZtLZ2QRXM5n7hEbxPH+hCgDF/HND5Uj/9RGRksTv66i7NbKgyKiWHcbswUwjTpVV
	 XEJnysbTkFoUIGVu007Jm93EFbAwTwI0JXLBs1TAyuNYGSssa2gSNiiwv57sGgWHFZ
	 4cISOP91iJS9A==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	aboorvad@linux.ibm.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/8] sched_ext: Enable scx_ops_init_task() separately
Date: Mon, 23 Sep 2024 08:59:32 -1000
Message-ID: <20240923190020.1446325-6-tj@kernel.org>
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

scx_ops_init_task() and the follow-up scx_ops_enable_task() in the fork path
were gated by scx_enabled() test and thus __scx_ops_enabled had to be turned
on before the first scx_ops_init_task() loop in scx_ops_enable(). However,
if an external entity causes sched_class switch before the loop is complete,
tasks which are not initialized could be switched to SCX.

The following can be reproduced by running a program which keeps toggling a
process between SCHED_OTHER and SCHED_EXT using sched_setscheduler(2).

  sched_ext: Invalid task state transition 0 -> 3 for fish[1623]
  WARNING: CPU: 1 PID: 1650 at kernel/sched/ext.c:3392 scx_ops_enable_task+0x1a1/0x200
  ...
  Sched_ext: simple (enabling)
  RIP: 0010:scx_ops_enable_task+0x1a1/0x200
  ...
   switching_to_scx+0x13/0xa0
   __sched_setscheduler+0x850/0xa50
   do_sched_setscheduler+0x104/0x1c0
   __x64_sys_sched_setscheduler+0x18/0x30
   do_syscall_64+0x7b/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix it by gating scx_ops_init_task() separately using
scx_ops_init_task_enabled. __scx_ops_enabled is now set after all tasks are
finished with scx_ops_init_task().

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fe86231e021d..feb7c620f9c6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -852,6 +852,7 @@ DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
 static atomic_t scx_ops_bypass_depth = ATOMIC_INIT(0);
+static bool scx_ops_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
 
@@ -3548,7 +3549,7 @@ int scx_fork(struct task_struct *p)
 {
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
-	if (scx_enabled())
+	if (scx_ops_init_task_enabled)
 		return scx_ops_init_task(p, task_group(p), true);
 	else
 		return 0;
@@ -3556,7 +3557,7 @@ int scx_fork(struct task_struct *p)
 
 void scx_post_fork(struct task_struct *p)
 {
-	if (scx_enabled()) {
+	if (scx_ops_init_task_enabled) {
 		scx_set_task_state(p, SCX_TASK_READY);
 
 		/*
@@ -4436,6 +4437,8 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	cpus_read_lock();
 	scx_cgroup_lock();
 
+	scx_ops_init_task_enabled = false;
+
 	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
 	/*
@@ -5087,7 +5090,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret)
 		goto err_disable_unlock_all;
 
-	static_branch_enable_cpuslocked(&__scx_ops_enabled);
+	WARN_ON_ONCE(scx_ops_init_task_enabled);
+	scx_ops_init_task_enabled = true;
 
 	/*
 	 * Enable ops for every task. Fork is excluded by scx_fork_rwsem
@@ -5130,9 +5134,11 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	spin_unlock_irq(&scx_tasks_lock);
 
 	/*
-	 * All tasks are prepped but the tasks are not enabled. Switch everyone.
+	 * All tasks are READY. It's safe to turn on scx_enabled() and switch
+	 * all eligible tasks.
 	 */
 	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
+	static_branch_enable_cpuslocked(&__scx_ops_enabled);
 
 	/*
 	 * We're fully committed and can't fail. The task READY -> ENABLED
-- 
2.46.0



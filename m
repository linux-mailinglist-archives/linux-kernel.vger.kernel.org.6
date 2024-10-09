Return-Path: <linux-kernel+bounces-357916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 465FA9977BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629111C226DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870361A0AFA;
	Wed,  9 Oct 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWn7BHSE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7021E2831
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510260; cv=none; b=Fqv/3O5GnwW8ouE3RzahnMdjHLxEZYBBZGCEtU1ZiUiwNtQhxHNm71uo6YwBglS5XYwjHpPSBYZ6AsV5ynDDvKQg54B5JviDSrGEEjT8wR26z1nZXrIZDbv7/dAops8jVakpoTHmn9I5oXDIzulaf5B5Fxui3Cwg3skHTvjMjyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510260; c=relaxed/simple;
	bh=FdJBX3psqN+UPLZ7G9zrQ3AsyOgOIDLwnpjOF2Z9Zyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDnoumMzA8llydIU8UjCqI4sIao2OUYELjdzFz3klzwKoFJ+tAwTiYNWn2xFBVHM2Xww+5400uGTAArk5lj9SM4FUtX0KQcm9IhzKfSF4Cm8t5cnv4sy2HnyHXywWrPal3eAjomG2dn6LFadgbaC26PQ8KF16x9GegjZ/2hNuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWn7BHSE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5C8C4CEC3;
	Wed,  9 Oct 2024 21:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728510260;
	bh=FdJBX3psqN+UPLZ7G9zrQ3AsyOgOIDLwnpjOF2Z9Zyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWn7BHSEiCiIxvENx8wQ6j2/VP83w4wcTtF+21LQIrxIxJ87omOARnOKh0ltJbGep
	 4toMBMuiFneQjGrzcSpNtCGmIz5QYFRHiiCH2pKgJQbeg97517jfX5aqNY5WxAm8dP
	 1po2neBe/9gEhoB3917aePnt/RO9vIMgdp/j3sf5Dj0A5Sm8PfF2NyKP8mL501GYh6
	 SC6gXBBbZPkGVIdVfd9xJqaLxMHV9+f6uOkLX+W/4gHZyP32BxixBM60tDCDXbW7dh
	 ecjW+YGbgXfQL9siP8Fd+k9E5P5za2VUPlOv02d54g3byIlLUuQmwpcOAar80GFm5Y
	 9u6jYp+lz5SDQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/6] sched_ext: Don't hold scx_tasks_lock for too long
Date: Wed,  9 Oct 2024 11:41:02 -1000
Message-ID: <20241009214411.681233-7-tj@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009214411.681233-1-tj@kernel.org>
References: <20241009214411.681233-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While enabling and disabling a BPF scheduler, every task is iterated a
couple times by walking scx_tasks. Except for one, all iterations keep
holding scx_tasks_lock. On multi-socket systems under heavy rq lock
contention and high number of threads, this can can lead to RCU and other
stalls.

The following is triggered on a 2 x AMD EPYC 7642 system (192 logical CPUs)
running `stress-ng --workload 150 --workload-threads 10` with >400k idle
threads and RCU stall period reduced to 5s:

  rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
  rcu:     91-...!: (10 ticks this GP) idle=0754/1/0x4000000000000000 softirq=18204/18206 fqs=17
  rcu:     186-...!: (17 ticks this GP) idle=ec54/1/0x4000000000000000 softirq=25863/25866 fqs=17
  rcu:     (detected by 80, t=10042 jiffies, g=89305, q=33 ncpus=192)
  Sending NMI from CPU 80 to CPUs 91:
  NMI backtrace for cpu 91
  CPU: 91 UID: 0 PID: 284038 Comm: sched_ext_ops_h Kdump: loaded Not tainted 6.12.0-rc2-work-g6bf5681f7ee2-dirty #471
  Hardware name: Supermicro Super Server/H11DSi, BIOS 2.8 12/14/2023
  Sched_ext: simple (disabling+all)
  RIP: 0010:queued_spin_lock_slowpath+0x17b/0x2f0
  Code: 02 c0 10 03 00 83 79 08 00 75 08 f3 90 83 79 08 00 74 f8 48 8b 11 48 85 d2 74 09 0f 0d 0a eb 0a 31 d2 eb 06 31 d2 eb 02 f3 90 <8b> 07 66 85 c0 75 f7 39 d8 75 0d be 01 00 00 00 89 d8 f0 0f b1 37
  RSP: 0018:ffffc9000fadfcb8 EFLAGS: 00000002
  RAX: 0000000001700001 RBX: 0000000001700000 RCX: ffff88bfcaaf10c0
  RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffff88bfca8f0080
  RBP: 0000000001700000 R08: 0000000000000090 R09: ffffffffffffffff
  R10: ffff88a74761b268 R11: 0000000000000000 R12: ffff88a6b6765460
  R13: ffffc9000fadfd60 R14: ffff88bfca8f0080 R15: ffff88bfcaac0000
  FS:  0000000000000000(0000) GS:ffff88bfcaac0000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f5c55f526a0 CR3: 0000000afd474000 CR4: 0000000000350eb0
  Call Trace:
   <NMI>
   </NMI>
   <TASK>
   do_raw_spin_lock+0x9c/0xb0
   task_rq_lock+0x50/0x190
   scx_task_iter_next_locked+0x157/0x170
   scx_ops_disable_workfn+0x2c2/0xbf0
   kthread_worker_fn+0x108/0x2a0
   kthread+0xeb/0x110
   ret_from_fork+0x36/0x40
   ret_from_fork_asm+0x1a/0x30
   </TASK>
  Sending NMI from CPU 80 to CPUs 186:
  NMI backtrace for cpu 186
  CPU: 186 UID: 0 PID: 51248 Comm: fish Kdump: loaded Not tainted 6.12.0-rc2-work-g6bf5681f7ee2-dirty #471

scx_task_iter can safely drop locks while iterating. Make
scx_task_iter_next() drop scx_tasks_lock every 32 iterations to avoid
stalls.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d53c7a365fec..b44946198ea5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -18,6 +18,12 @@ enum scx_consts {
 	SCX_EXIT_DUMP_DFL_LEN		= 32768,
 
 	SCX_CPUPERF_ONE			= SCHED_CAPACITY_SCALE,
+
+	/*
+	 * Iterating all tasks may take a while. Periodically drop
+	 * scx_tasks_lock to avoid causing e.g. CSD and RCU stalls.
+	 */
+	SCX_OPS_TASK_ITER_BATCH		= 32,
 };
 
 enum scx_exit_kind {
@@ -1273,6 +1279,7 @@ struct scx_task_iter {
 	struct task_struct		*locked;
 	struct rq			*rq;
 	struct rq_flags			rf;
+	u32				cnt;
 };
 
 /**
@@ -1301,6 +1308,7 @@ static void scx_task_iter_start(struct scx_task_iter *iter)
 	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
 	list_add(&iter->cursor.tasks_node, &scx_tasks);
 	iter->locked = NULL;
+	iter->cnt = 0;
 }
 
 static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
@@ -1355,14 +1363,21 @@ static void scx_task_iter_stop(struct scx_task_iter *iter)
  * scx_task_iter_next - Next task
  * @iter: iterator to walk
  *
- * Visit the next task. See scx_task_iter_start() for details.
+ * Visit the next task. See scx_task_iter_start() for details. Locks are dropped
+ * and re-acquired every %SCX_OPS_TASK_ITER_BATCH iterations to avoid causing
+ * stalls by holding scx_tasks_lock for too long.
  */
 static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 {
 	struct list_head *cursor = &iter->cursor.tasks_node;
 	struct sched_ext_entity *pos;
 
-	lockdep_assert_held(&scx_tasks_lock);
+	if (!(++iter->cnt % SCX_OPS_TASK_ITER_BATCH)) {
+		scx_task_iter_unlock(iter);
+		cpu_relax();
+		cond_resched();
+		scx_task_iter_relock(iter);
+	}
 
 	list_for_each_entry(pos, cursor, tasks_node) {
 		if (&pos->tasks_node == &scx_tasks)
-- 
2.46.2



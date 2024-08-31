Return-Path: <linux-kernel+bounces-309772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0197967043
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907C1B212A3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AF616DC01;
	Sat, 31 Aug 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8Wae4RX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAACC1D12E4
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725091355; cv=none; b=Mg88A1akJ6ZongwN90kZIbOk0Oap0J6kLElNDtuFSzFLCflWtcUsr+y12R7QH49nbxOapu58OcphLK0qU+iXbuDsv6FG88g2CXVA9idQ4WvUaNsF6kTOIn7g+rHp626vBUNTIn7+uzY779HCvUSrBpghrBISOVENDJX5hrB9FsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725091355; c=relaxed/simple;
	bh=QbNyzeGgMoRmWVJSLjIl6VsD6IaJo2e1qgMC2YAIiKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OPv0DCdk2AaAjRjaqfe/3Hkx8o2iPTbDwHQfb7NSPz8pbM2xWfCsk5vGZNIz/b0+TGfooKfMSgX2DDVFS6UpvPMAew4CR6Q05Jrdx66aTydlx26oo3WQtvSfWXKXzFFx2TsXYFNRl8ajnffumnCwhU9RtQrxZCbEBei/U5IRusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8Wae4RX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEA9C4CEC0;
	Sat, 31 Aug 2024 08:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725091355;
	bh=QbNyzeGgMoRmWVJSLjIl6VsD6IaJo2e1qgMC2YAIiKM=;
	h=Date:From:To:Cc:Subject:From;
	b=n8Wae4RX39OMTTsCLaoFG9I3n9WVsZoYaCQZJsNxBZGdS2JwpBuIoPms1K8B95+Tz
	 7Efved0uJxI+B5Hm57NvYab43zsyvmssjbd4K8wZfXmGqE9OQLznN8uKcyhzEFL6Vz
	 apoKa8tunSEWxm7Z7JJU+IoNCQu3EhitcAi7bwwVsekztPS0w/1D/AcFFaR7oA+uCU
	 bqiL3F6TptZc6YNiMfj3e7Ixm8Jltlo5Jor20wTYyahgzXuTzpq0igk32cDiUhzm63
	 4/fzdm61I5sLEYMX5Z3jb2DfUI90iwEDuFro49FPyrfAabQ1G0KkGchnum5QrJ5PCB
	 WrDUtR6nPYnjQ==
Date: Fri, 30 Aug 2024 22:02:34 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH sched_ext/for-6.12] sched_ext: TASK_DEAD tasks must be
 switched into SCX on ops_enable
Message-ID: <ZtLOGi4bf4YeRCFr@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

During scx_ops_enable(), SCX needs to invoke the sleepable ops.init_task()
on every task. To do this, it does get_task_struct() on each iterated task,
drop the lock and then call ops.init_task().

However, a TASK_DEAD task may already have lost all its usage count and be
waiting for RCU grace period to be freed. If get_task_struct() is called on
such task, use-after-free can happen. To avoid such situations,
scx_ops_enable() skips initialization of TASK_DEAD tasks, which seems safe
as they are never going to be scheduled again.

Unfortunately, a racing sched_setscheduler(2) can grab the task before the
task is unhashed and then continue to e.g. move the task from RT to SCX
after TASK_DEAD is set and ops_enable skipped the task. As the task hasn't
gone through scx_ops_init_task(), scx_ops_enable_task() called from
switching_to_scx() triggers the following warning:

  sched_ext: Invalid task state transition 0 -> 3 for stress-ng-race-[2872]
  WARNING: CPU: 6 PID: 2367 at kernel/sched/ext.c:3327 scx_ops_enable_task+0x18f/0x1f0
  ...
  RIP: 0010:scx_ops_enable_task+0x18f/0x1f0
  ...
   switching_to_scx+0x13/0xa0
   __sched_setscheduler+0x84e/0xa50
   do_sched_setscheduler+0x104/0x1c0
   __x64_sys_sched_setscheduler+0x18/0x30
   do_syscall_64+0x7b/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

As in the ops_disable path, it just doesn't seem like a good idea to leave
any task in an inconsistent state, even when the task is dead. The root
cause is ops_enable not being able to tell reliably whether a task is truly
dead (no one else is looking at it and it's about to be freed) and was
testing TASK_DEAD instead. Fix it by testing the task's usage count
directly.

- ops_init no longer ignores TASK_DEAD tasks. As now all users iterate all
  tasks, @include_dead is removed from scx_task_iter_next_locked() along
  with dead task filtering.

- tryget_task_struct() is added. Tasks are skipped iff tryget_task_struct()
  fails.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/sched/task.h |    5 +++++
 kernel/sched/ext.c         |   30 +++++++++++++-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -120,6 +120,11 @@ static inline struct task_struct *get_ta
 	return t;
 }
 
+static inline struct task_struct *tryget_task_struct(struct task_struct *t)
+{
+	return refcount_inc_not_zero(&t->usage) ? t : NULL;
+}
+
 extern void __put_task_struct(struct task_struct *t);
 extern void __put_task_struct_rcu_cb(struct rcu_head *rhp);
 
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1243,11 +1243,10 @@ static struct task_struct *scx_task_iter
  * whether they would like to filter out dead tasks. See scx_task_iter_init()
  * for details.
  */
-static struct task_struct *
-scx_task_iter_next_locked(struct scx_task_iter *iter, bool include_dead)
+static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
 {
 	struct task_struct *p;
-retry:
+
 	scx_task_iter_rq_unlock(iter);
 
 	while ((p = scx_task_iter_next(iter))) {
@@ -1285,16 +1284,6 @@ retry:
 	iter->rq = task_rq_lock(p, &iter->rf);
 	iter->locked = p;
 
-	/*
-	 * If we see %TASK_DEAD, @p already disabled preemption, is about to do
-	 * the final __schedule(), won't ever need to be scheduled again and can
-	 * thus be safely ignored. If we don't see %TASK_DEAD, @p can't enter
-	 * the final __schedle() while we're locking its rq and thus will stay
-	 * alive until the rq is unlocked.
-	 */
-	if (!include_dead && READ_ONCE(p->__state) == TASK_DEAD)
-		goto retry;
-
 	return p;
 }
 
@@ -4054,7 +4043,7 @@ static void scx_ops_disable_workfn(struc
 	 * The BPF scheduler is going away. All tasks including %TASK_DEAD ones
 	 * must be switched out and exited synchronously.
 	 */
-	while ((p = scx_task_iter_next_locked(&sti, true))) {
+	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
 		struct sched_enq_and_set_ctx ctx;
 
@@ -4685,8 +4674,15 @@ static int scx_ops_enable(struct sched_e
 	spin_lock_irq(&scx_tasks_lock);
 
 	scx_task_iter_init(&sti);
-	while ((p = scx_task_iter_next_locked(&sti, false))) {
-		get_task_struct(p);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		/*
+		 * @p may already be dead, have lost all its usages counts and
+		 * be waiting for RCU grace period before being freed. @p can't
+		 * be initialized for SCX in such cases and should be ignored.
+		 */
+		if (!tryget_task_struct(p))
+			continue;
+
 		scx_task_iter_rq_unlock(&sti);
 		spin_unlock_irq(&scx_tasks_lock);
 
@@ -4739,7 +4735,7 @@ static int scx_ops_enable(struct sched_e
 	WRITE_ONCE(scx_switching_all, !(ops->flags & SCX_OPS_SWITCH_PARTIAL));
 
 	scx_task_iter_init(&sti);
-	while ((p = scx_task_iter_next_locked(&sti, false))) {
+	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
 		struct sched_enq_and_set_ctx ctx;
 


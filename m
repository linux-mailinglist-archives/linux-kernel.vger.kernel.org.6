Return-Path: <linux-kernel+bounces-309576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D6C966CFA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180951C22ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14F618E371;
	Fri, 30 Aug 2024 23:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCy9qUc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8D15C150
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725061483; cv=none; b=sQySkN4qOqLrhBLQvVLPEBLw65Sg9kauPUWEnokDWHsRwNav2Go3M5iOqTi/0Qcy3JMD7VdVWsLjejsuh32FUbU26qhFbZM/yjPsJoTXzHVbUS1wYa3fN7dJIZcPoCl+YkPlCAAH43LasHUPES1119JPi0fnI48zTTld3bBXzYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725061483; c=relaxed/simple;
	bh=7tquis1hF3WP05sIeYmloT33J1l7BkNdQSL+Utj2T8k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q54ngPsI17De7tDkifytRrRH5ryffKfVRCJW6vPv0Y7d/Pq4xVA4LLFdwF9sU//0ltiPY7v2uFMVlhWbfL9Zg6QtQAoP1Cabi5KeKvOJTtQoMRIi/HEUko63kNYa/y5t5f+9essqVKO5q6h6mk5kwODRt0ldWlGqmoXILoKj1JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCy9qUc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AA8C4CEC2;
	Fri, 30 Aug 2024 23:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725061481;
	bh=7tquis1hF3WP05sIeYmloT33J1l7BkNdQSL+Utj2T8k=;
	h=Date:From:To:Cc:Subject:From;
	b=WCy9qUc4GbxuT0TQIiyqzGZHhcZ5aqCA5vBdVYKxtiHyVCHHlgZEMYTpi3y3q1N9I
	 YSVggnR0rq763L+xZgJ83uUHLqqLmo2kKLx1zgRnb0rF1QtEvV6jaK9XpNm+RwX/7Z
	 D18qqFfhYsvZk40a0/XWhesdCXIiCNayIr0O1mCUo9KDo9Soww0q0F/Ht63JvGmUva
	 NwXaEIbBGxTWggsDcVBtmRZ4MkYNX+xWUkiBwQabG7dmA9AGjO2Phjzkx1d4X4E/dA
	 RdMfwYNGOhKUmn3k7EgZLIHJmQPkcakTeubr5RjzU+Pd3KjH32wpYX2b5bU6YpOXaF
	 mxXnT0dCNSIMA==
Date: Fri, 30 Aug 2024 13:44:40 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Andrea Righi <andrea.righi@linux.dev>
Subject: [PATCH sched_ext/for-6.12] sched_ext: TASK_DEAD tasks must be
 switched out of SCX on ops_disable
Message-ID: <ZtJZaKxg39SkQtMA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

scx_ops_disable_workfn() only switches !TASK_DEAD tasks out of SCX while
calling scx_ops_exit_task() on all tasks including dead ones. This can leave
a dead task on SCX but with SCX_TASK_NONE state, which is inconsistent.

If another task was in the process of changing the TASK_DEAD task's
scheduling class and grabs the rq lock after scx_ops_disable_workfn() is
done with the task, the task ends up calling scx_ops_disable_task() on the
dead task which is in an inconsistent state triggering a warning:

  WARNING: CPU: 6 PID: 3316 at kernel/sched/ext.c:3411 scx_ops_disable_task+0x12c/0x160
  ...
  RIP: 0010:scx_ops_disable_task+0x12c/0x160
  ...
  Call Trace:
   <TASK>
   check_class_changed+0x2c/0x70
   __sched_setscheduler+0x8a0/0xa50
   do_sched_setscheduler+0x104/0x1c0
   __x64_sys_sched_setscheduler+0x18/0x30
   do_syscall_64+0x7b/0x140
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f140d70ea5b

There is no reason to leave dead tasks on SCX when unloading the BPF
scheduler. Fix by making scx_ops_disable_workfn() eject all tasks including
the dead ones from SCX.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |   24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 57f30b1604db..a1340d3c711c 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4051,30 +4051,22 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
 	/*
-	 * Invoke scx_ops_exit_task() on all non-idle tasks, including
-	 * TASK_DEAD tasks. Because dead tasks may have a nonzero refcount,
-	 * we may not have invoked sched_ext_free() on them by the time a
-	 * scheduler is disabled. We must therefore exit the task here, or we'd
-	 * fail to invoke ops.exit_task(), as the scheduler will have been
-	 * unloaded by the time the task is subsequently exited on the
-	 * sched_ext_free() path.
+	 * The BPF scheduler is going away. All tasks including %TASK_DEAD ones
+	 * must be switched out and exited synchronously.
 	 */
 	while ((p = scx_task_iter_next_locked(&sti, true))) {
 		const struct sched_class *old_class = p->sched_class;
 		struct sched_enq_and_set_ctx ctx;
 
-		if (READ_ONCE(p->__state) != TASK_DEAD) {
-			sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE,
-					       &ctx);
+		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
-			p->scx.slice = min_t(u64, p->scx.slice, SCX_SLICE_DFL);
-			__setscheduler_prio(p, p->prio);
-			check_class_changing(task_rq(p), p, old_class);
+		p->scx.slice = min_t(u64, p->scx.slice, SCX_SLICE_DFL);
+		__setscheduler_prio(p, p->prio);
+		check_class_changing(task_rq(p), p, old_class);
 
-			sched_enq_and_set_task(&ctx);
+		sched_enq_and_set_task(&ctx);
 
-			check_class_changed(task_rq(p), p, old_class, p->prio);
-		}
+		check_class_changed(task_rq(p), p, old_class, p->prio);
 		scx_ops_exit_task(p);
 	}
 	scx_task_iter_exit(&sti);


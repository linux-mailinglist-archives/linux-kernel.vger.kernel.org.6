Return-Path: <linux-kernel+bounces-308621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E0965F97
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98114284E79
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F17E18FDA6;
	Fri, 30 Aug 2024 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBt4vlO6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C5115C12D
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015102; cv=none; b=FkCqatXgWsWjvYfW+q+/G70a85vRtKSv8L6ddZSeyyiOyMclCN6DDst9wvWf1RYl6l5d3UKmzB152dUuiTattqRmEA7oJjHB+mV1eybd5ac9+JTEBz1lu1giWu/Aw9y2gI+ZGC2M26BFO4bkVzo+bQ5qWKEm6ItGdnMqe0lXZcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015102; c=relaxed/simple;
	bh=p7iQG4uDG9oEKHbsCV6aqnCDOGRx90ZJ0B9J696B1J8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gCuXs1MtDRLQAERojKOS26xOumWJ69TMwDUKS0Dub7wTLoA4xn6REqkUl/bdjdRW5F8clbPti2XZEYV9iVhlKhx8GbaICacxLGGjjjKddeQGK0k1cF/CWBN1pUlR/XhXvEOE3gUhNxkbaXRG2GOjm8qDyZIufVXX+qUgvZu1flU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBt4vlO6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CBFC4CEC2;
	Fri, 30 Aug 2024 10:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015101;
	bh=p7iQG4uDG9oEKHbsCV6aqnCDOGRx90ZJ0B9J696B1J8=;
	h=Date:From:To:Cc:Subject:From;
	b=GBt4vlO6ph/0dimlHu8xtK4rtxFEfvKFWQ5CfbhhXgUArm2X5Vd11kOWgvbUqNKeO
	 whGfuebIkj9EerhzXI9M1+VQn+At5DpZ/6gvO1RiJ8oKK3Y9L7ydCpoHb/QWqPDI99
	 spx0NaY1rVOcG+OJ8WMCYNbsUdY4vPgKR1R7jfnffcCOHYwZgSiwymBbGIMUe5YHCl
	 CrUainRv39USBsEPCfv3zHGzpYlnFQPmAGX1lk/Qu/iwr71TcqDQ8ZNymUot40wnRH
	 xSdrqE+IW/7O5lduYtJZPlMeJ2NIyI/0cn16AC0TW+i8Ls/sCJnKkMBXIWuVM2lG+l
	 x5I0kg0NADm2w==
Date: Fri, 30 Aug 2024 00:51:40 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	kernel-team@meta.com
Subject: [PATCH 1/2 sched_ext/for-6.12] sched_ext: Use
 task_can_run_on_remote_rq() test in dispatch_to_local_dsq()
Message-ID: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When deciding whether a task can be migrated to a CPU,
dispatch_to_local_dsq() was open-coding p->cpus_allowed and scx_rq_online()
tests instead of using task_can_run_on_remote_rq(). This had two problems.

- It was missing is_migration_disabled() check and thus could try to migrate
  a task which shouldn't leading to assertion and scheduling failures.

- It was testing p->cpus_ptr directly instead of using task_allowed_on_cpu()
  and thus failed to consider ISA compatibility.

Update dispatch_to_local_dsq() to use task_can_run_on_remote_rq():

- Move scx_ops_error() triggering into task_can_run_on_remote_rq().

- When migration isn't allowed, fall back to the global DSQ instead of the
  source DSQ by returning DTL_INVALID. This is both simpler and an overall
  better behavior.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/ext.c |   40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2203,16 +2203,30 @@ static void consume_local_task(struct rq
  * - The BPF scheduler is bypassed while the rq is offline and we can always say
  *   no to the BPF scheduler initiated migrations while offline.
  */
-static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq)
+static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq,
+				      bool trigger_error)
 {
 	int cpu = cpu_of(rq);
 
-	if (!task_allowed_on_cpu(p, cpu))
+	/*
+	 * We don't require the BPF scheduler to avoid dispatching to offline
+	 * CPUs mostly for convenience but also because CPUs can go offline
+	 * between scx_bpf_dispatch() calls and here. Trigger error iff the
+	 * picked CPU is outside the allowed mask.
+	 */
+	if (!task_allowed_on_cpu(p, cpu)) {
+		if (trigger_error)
+			scx_ops_error("SCX_DSQ_LOCAL[_ON] verdict target cpu %d not allowed for %s[%d]",
+				      cpu_of(rq), p->comm, p->pid);
 		return false;
+	}
+
 	if (unlikely(is_migration_disabled(p)))
 		return false;
+
 	if (!scx_rq_online(rq))
 		return false;
+
 	return true;
 }
 
@@ -2240,9 +2254,8 @@ static bool consume_remote_task(struct r
 	return move_task_to_local_dsq(p, 0, task_rq, rq);
 }
 #else	/* CONFIG_SMP */
-static bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq) { return false; }
-static bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq,
-				struct task_struct *p, struct rq *task_rq) { return false; }
+static inline bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq, bool trigger_error) { return false; }
+static inline bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq, struct task_struct *p, struct rq *task_rq) { return false; }
 #endif	/* CONFIG_SMP */
 
 static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
@@ -2267,7 +2280,7 @@ retry:
 			return true;
 		}
 
-		if (task_can_run_on_remote_rq(p, rq)) {
+		if (task_can_run_on_remote_rq(p, rq, false)) {
 			if (likely(consume_remote_task(rq, dsq, p, task_rq)))
 				return true;
 			goto retry;
@@ -2330,7 +2343,7 @@ dispatch_to_local_dsq(struct rq *rq, u64
 	}
 
 #ifdef CONFIG_SMP
-	if (cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr)) {
+	if (likely(task_can_run_on_remote_rq(p, dst_rq, true))) {
 		bool dsp;
 
 		/*
@@ -2355,17 +2368,6 @@ dispatch_to_local_dsq(struct rq *rq, u64
 			raw_spin_rq_lock(src_rq);
 		}
 
-		/*
-		 * We don't require the BPF scheduler to avoid dispatching to
-		 * offline CPUs mostly for convenience but also because CPUs can
-		 * go offline between scx_bpf_dispatch() calls and here. If @p
-		 * is destined to an offline CPU, queue it on its current CPU
-		 * instead, which should always be safe. As this is an allowed
-		 * behavior, don't trigger an ops error.
-		 */
-		if (!scx_rq_online(dst_rq))
-			dst_rq = src_rq;
-
 		if (src_rq == dst_rq) {
 			/*
 			 * As @p is staying on the same rq, there's no need to
@@ -2399,8 +2401,6 @@ dispatch_to_local_dsq(struct rq *rq, u64
 	}
 #endif	/* CONFIG_SMP */
 
-	scx_ops_error("SCX_DSQ_LOCAL[_ON] verdict target cpu %d not allowed for %s[%d]",
-		      cpu_of(dst_rq), p->comm, p->pid);
 	return DTL_INVALID;
 }
 


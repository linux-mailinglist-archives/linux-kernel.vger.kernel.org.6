Return-Path: <linux-kernel+bounces-397187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B722C9BD7CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1381C22B8A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDDA215F4C;
	Tue,  5 Nov 2024 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2B6GeWq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428181802AB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730843293; cv=none; b=SC/5HcZHGiqdtrc5SeahSjZeubUygEm5xzpi1MWPg2YRliYCut+fZry/2QviTLC8mUx2TzXGvuPi0/YpNinJ+slWy1vUCOpAaBl1Ng2ZzNwPIBLCuP2eleQl7gUH4ai5xqTzcKCM+VCUb4p6VZ7s7uGWQgAmnBlOqxlBT4QMxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730843293; c=relaxed/simple;
	bh=vNp358KKfXPLnOBHtwMo5lXXGz7NwzAexBHZziciLv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oAH00DwUdY/8F3qkpWzPcmaI28VxOomb/DG9NmF7KbDYr5dmfLfSlbQvYehSoI93gZNaOQIwP4LSarj6K6D69F49GQz825wAo07iAjwvAcDVdHKopVjlmOEk4qEvhGvwCZABXNSw/zxxDc0uZ2aRBRPdrGcW4eR+9X8ZWSSJW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2B6GeWq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E07C4CECF;
	Tue,  5 Nov 2024 21:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730843292;
	bh=vNp358KKfXPLnOBHtwMo5lXXGz7NwzAexBHZziciLv8=;
	h=Date:From:To:Cc:Subject:From;
	b=V2B6GeWqyDoYxdXHVflQ3TC9X4JJeSh3PloVrMoli1TzQ1/WaUm2F/WSTPKEZonTs
	 lQSuP5mbR+VxEiEeRYY6h7ywoXgJj6uHmV3vYOsIrop2I/yBMzCLfLr4RcIOUuQTQH
	 1w/tCMsmY1A7vBph6gzLdRLyg8yE3++EgLP3AHvgEqCWWOPTadH+ADaWwENgrlw/xe
	 /tQ1z9WyvD2wXktWkpGO920iIo5OggyxFtuLnXH2Xy39AS4BnaJGWXWMP2DlhUsUVI
	 e9Hs9Y3xFb8/D6PEsQdp+no4Gknj4cFmoguGeFwMa6JnR94Ojy78ANw3b36hBH6RQp
	 qgExXgpHfyO3g==
Date: Tue, 5 Nov 2024 11:48:11 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <multics69@gmail.com>
Subject: [PATCH sched_ext/for-6.13 1/2] sched_ext: Avoid live-locking bypass
 mode switching
Message-ID: <ZyqSm4B4NuzuHEbp@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A poorly behaving BPF scheduler can live-lock the system by e.g. incessantly
banging on the same DSQ on a large NUMA system to the point where switching
to the bypass mode can take a long time. Turning on the bypass mode requires
dequeueing and re-enqueueing currently runnable tasks, if the DSQs that they
are on are live-locked, this can take tens of seconds cascading into other
failures. This was observed on 2 x Intel Sapphire Rapids machines with 224
logical CPUs.

Inject artifical delays while the bypass mode is switching to guarantee
timely completion.

While at it, move __scx_ops_bypass_lock into scx_ops_bypass() and rename it
to bypass_lock.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Valentin Andrei <vandrei@meta.com>
Reported-by: Patrick Lu <patlu@meta.com>
---
 kernel/sched/ext.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -867,8 +867,8 @@ static DEFINE_MUTEX(scx_ops_enable_mutex
 DEFINE_STATIC_KEY_FALSE(__scx_ops_enabled);
 DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_ops_enable_state_var = ATOMIC_INIT(SCX_OPS_DISABLED);
+static atomic_t scx_ops_breather_depth = ATOMIC_INIT(0);
 static int scx_ops_bypass_depth;
-static DEFINE_RAW_SPINLOCK(__scx_ops_bypass_lock);
 static bool scx_ops_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
@@ -2474,11 +2474,48 @@ static struct rq *move_task_between_dsqs
 	return dst_rq;
 }
 
+/*
+ * A poorly behaving BPF scheduler can live-lock the system by e.g. incessantly
+ * banging on the same DSQ on a large NUMA system to the point where switching
+ * to the bypass mode can take a long time. Inject artifical delays while the
+ * bypass mode is switching to guarantee timely completion.
+ */
+static void scx_ops_breather(struct rq *rq)
+{
+	u64 until;
+
+	lockdep_assert_rq_held(rq);
+
+	if (likely(!atomic_read(&scx_ops_breather_depth)))
+		return;
+
+	raw_spin_rq_unlock(rq);
+
+	until = ktime_get_ns() + NSEC_PER_MSEC;
+
+	do {
+		int cnt = 1024;
+		while (atomic_read(&scx_ops_breather_depth) && --cnt)
+			cpu_relax();
+	} while (atomic_read(&scx_ops_breather_depth) &&
+		 time_before64(ktime_get_ns(), until));
+
+	raw_spin_rq_lock(rq);
+}
+
 static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 {
 	struct task_struct *p;
 retry:
 	/*
+	 * This retry loop can repeatedly race against scx_ops_bypass()
+	 * dequeueing tasks from @dsq trying to put the system into the bypass
+	 * mode. On some multi-socket machines (e.g. 2x Intel 8480c), this can
+	 * live-lock the machine into soft lockups. Give a breather.
+	 */
+	scx_ops_breather(rq);
+
+	/*
 	 * The caller can't expect to successfully consume a task if the task's
 	 * addition to @dsq isn't guaranteed to be visible somehow. Test
 	 * @dsq->list without locking and skip if it seems empty.
@@ -4550,10 +4587,11 @@ bool task_should_scx(struct task_struct
  */
 static void scx_ops_bypass(bool bypass)
 {
+	static DEFINE_RAW_SPINLOCK(bypass_lock);
 	int cpu;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&__scx_ops_bypass_lock, flags);
+	raw_spin_lock_irqsave(&bypass_lock, flags);
 	if (bypass) {
 		scx_ops_bypass_depth++;
 		WARN_ON_ONCE(scx_ops_bypass_depth <= 0);
@@ -4566,6 +4604,8 @@ static void scx_ops_bypass(bool bypass)
 			goto unlock;
 	}
 
+	atomic_inc(&scx_ops_breather_depth);
+
 	/*
 	 * No task property is changing. We just need to make sure all currently
 	 * queued tasks are re-queued according to the new scx_rq_bypassing()
@@ -4621,8 +4661,10 @@ static void scx_ops_bypass(bool bypass)
 		/* resched to restore ticks and idle state */
 		resched_cpu(cpu);
 	}
+
+	atomic_dec(&scx_ops_breather_depth);
 unlock:
-	raw_spin_unlock_irqrestore(&__scx_ops_bypass_lock, flags);
+	raw_spin_unlock_irqrestore(&bypass_lock, flags);
 }
 
 static void free_exit_info(struct scx_exit_info *ei)
@@ -6275,6 +6317,13 @@ static bool scx_dispatch_from_dsq(struct
 		raw_spin_rq_lock(src_rq);
 	}
 
+	/*
+	 * If the BPF scheduler keeps calling this function repeatedly, it can
+	 * cause similar live-lock conditions as consume_dispatch_q(). Insert a
+	 * breather if necessary.
+	 */
+	scx_ops_breather(src_rq);
+
 	locked_rq = src_rq;
 	raw_spin_lock(&src_dsq->lock);
 



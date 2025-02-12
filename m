Return-Path: <linux-kernel+bounces-512042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519FCA33330
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 00:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDFAC1680A5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8B2045A1;
	Wed, 12 Feb 2025 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDiEUqOY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5159E1FF7D8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739401713; cv=none; b=gIErRs4f89NIxjSnJthRGgo+QBNXptRZ4XpY6TB8joywQ7e/HtssMBXjn7WxifeJG2W+bMKbY7JQzovSICEzM0MNqa/mZNOPR22jmz8UMCMPlSSK5kyfGzQivrAprKMMYKij9kZJyRCy7fzi4LGTbAQkULDZf3ZmzuTKys/xJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739401713; c=relaxed/simple;
	bh=iJd+IzK9WM4HAeb72MMT+N0buvDJD2787sBiT5RUUu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e4FrawhrOtIvy/o0WRP19OnTNUphZa7e/PDjmyI51L4ai4xr9wvEcgOo2V1JAoEpTn3h3eA7xn9P1va6BDnCdP5hAfl44Sa9cwrwCGWcWn8hcIkwhU2cvzZnJkEpq6jxPT9goqJqkyaAwJ5gjTSQx3QW57MCzIjmRTWMyQq/CE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDiEUqOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950FEC4CEDF;
	Wed, 12 Feb 2025 23:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739401712;
	bh=iJd+IzK9WM4HAeb72MMT+N0buvDJD2787sBiT5RUUu4=;
	h=Date:From:To:Cc:Subject:From;
	b=YDiEUqOYt0FnjtyrJemilBeIsBjsCmcbiW9d7VPv2H3SVu9G1CkDjOL2K8jw3PaOO
	 O7MhpPvtHWrFfpEo0b3Nh5Esvsd+4nTF7bgbAoMkQOsFrm1S69tS2noOgCFfF5OY0U
	 SODWx/xLkLMmu3C8pxD6I+rnEhINQSQUoW7GA+LVCW4Q4usPyf3ve91H/O8jCteG6x
	 0Uh1K+/DRy+VDLMfvd75vDvE8eB8GihZHRisWQRX5btMesfY4jFTdHccIV4Ku59M5C
	 XiWax8GgfjTGzaiBB/4OmXSIeTtolzxhWYMIkbpgSFo95iEtJ6x/jJRkJxx7pq+LIp
	 7lTHGPnTudFnw==
Date: Wed, 12 Feb 2025 13:08:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Neel Natu <neelnatu@google.com>, Barret Rhoden <brho@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	sched-ext@meta.com
Subject: [PATCH sched_ext/for-6.15] sched_ext: Implement
 SCX_OPS_ALLOW_QUEUED_WAKEUP
Message-ID: <Z60p755gE1aDiimC@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A task wakeup can be either processed on the waker's CPU or bounced to the
wakee's previous CPU using an IPI (ttwu_queue). Bouncing to the wakee's CPU
avoids the waker's CPU locking and accessing the wakee's rq which can be
expensive across cache and node boundaries.

When ttwu_queue path is taken, select_task_rq() and thus ops.select_cpu()
are skipped. As this confused some BPF schedulers, there wasn't a good way
for a BPF scheduler to tell whether idle CPU selection has been skipped,
ops.enqueue() couldn't insert tasks into foreign local DSQs, and the
performance difference on machines with simple toplogies were minimal,
sched_ext disabled ttwu_queue.

However, this optimization makes noticeable difference on more complex
topologies and a BPF scheduler now has an easy way tell whether
ops.select_cpu() was skipped since 9b671793c7d9 ("sched_ext, scx_qmap: Add
and use SCX_ENQ_CPU_SELECTED") and can insert tasks into foreign local DSQs
since 5b26f7b920f7 ("sched_ext: Allow SCX_DSQ_LOCAL_ON for direct
dispatches").

Implement SCX_OPS_ALLOW_QUEUED_WAKEUP which allows BPF schedulers to choose
to enable ttwu_queue optimization.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Neel Natu <neelnatu@google.com>
Reported-by: Barret Rhoden <brho@google.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |    9 ++-------
 kernel/sched/ext.c  |   30 ++++++++++++++++++++++++------
 kernel/sched/ext.h  |   10 ++++++++++
 3 files changed, 36 insertions(+), 13 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3921,13 +3921,8 @@ bool cpus_share_resources(int this_cpu,
 
 static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
 {
-	/*
-	 * The BPF scheduler may depend on select_task_rq() being invoked during
-	 * wakeups. In addition, @p may end up executing on a different CPU
-	 * regardless of what happens in the wakeup path making the ttwu_queue
-	 * optimization less meaningful. Skip if on SCX.
-	 */
-	if (task_on_scx(p))
+	/* See SCX_OPS_ALLOW_QUEUED_WAKEUP. */
+	if (!scx_allow_ttwu_queue(p))
 		return false;
 
 	/*
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -96,7 +96,7 @@ enum scx_ops_flags {
 	/*
 	 * Keep built-in idle tracking even if ops.update_idle() is implemented.
 	 */
-	SCX_OPS_KEEP_BUILTIN_IDLE = 1LLU << 0,
+	SCX_OPS_KEEP_BUILTIN_IDLE	= 1LLU << 0,
 
 	/*
 	 * By default, if there are no other task to run on the CPU, ext core
@@ -104,7 +104,7 @@ enum scx_ops_flags {
 	 * flag is specified, such tasks are passed to ops.enqueue() with
 	 * %SCX_ENQ_LAST. See the comment above %SCX_ENQ_LAST for more info.
 	 */
-	SCX_OPS_ENQ_LAST	= 1LLU << 1,
+	SCX_OPS_ENQ_LAST		= 1LLU << 1,
 
 	/*
 	 * An exiting task may schedule after PF_EXITING is set. In such cases,
@@ -117,13 +117,13 @@ enum scx_ops_flags {
 	 * depend on pid lookups and wants to handle these tasks directly, the
 	 * following flag can be used.
 	 */
-	SCX_OPS_ENQ_EXITING	= 1LLU << 2,
+	SCX_OPS_ENQ_EXITING		= 1LLU << 2,
 
 	/*
 	 * If set, only tasks with policy set to SCHED_EXT are attached to
 	 * sched_ext. If clear, SCHED_NORMAL tasks are also included.
 	 */
-	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
+	SCX_OPS_SWITCH_PARTIAL		= 1LLU << 3,
 
 	/*
 	 * A migration disabled task can only execute on its current CPU. By
@@ -136,7 +136,21 @@ enum scx_ops_flags {
 	 * current CPU while p->nr_cpus_allowed keeps tracking p->user_cpus_ptr
 	 * and thus may disagree with cpumask_weight(p->cpus_ptr).
 	 */
-	SCX_OPS_ENQ_MIGRATION_DISABLED = 1LLU << 4,
+	SCX_OPS_ENQ_MIGRATION_DISABLED	= 1LLU << 4,
+
+	/*
+	 * Queued wakeup (ttwu_queue) is an optimization during wakeups which
+	 * bypasses ops.select_cpu() and invokes ops.enqueue() on the wakee's
+	 * previous CPU via IPI (inter-processor interrupt) to reduce cacheline
+	 * transfers. As the BPF scheduler may depend on ops.select_cpu() being
+	 * invoked during wakeups, queued wakeup is disabled by default.
+	 *
+	 * If this ops flag is set, queued wakeup optimization is enabled and
+	 * the BPF scheduler must be able to handle ops.enqueue() invoked on the
+	 * wakee's CPU without preceding ops.select_cpu() even for tasks which
+	 * may be executed on multiple CPUs.
+	 */
+	SCX_OPS_ALLOW_QUEUED_WAKEUP	= 1LLU << 5,
 
 	/*
 	 * CPU cgroup support flags
@@ -147,6 +161,7 @@ enum scx_ops_flags {
 				  SCX_OPS_ENQ_LAST |
 				  SCX_OPS_ENQ_EXITING |
 				  SCX_OPS_ENQ_MIGRATION_DISABLED |
+				  SCX_OPS_ALLOW_QUEUED_WAKEUP |
 				  SCX_OPS_SWITCH_PARTIAL |
 				  SCX_OPS_HAS_CGROUP_WEIGHT,
 };
@@ -897,6 +912,7 @@ DEFINE_STATIC_KEY_FALSE(__scx_switched_a
 static struct sched_ext_ops scx_ops;
 static bool scx_warned_zero_slice;
 
+DEFINE_STATIC_KEY_FALSE(scx_ops_allow_queued_wakeup);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_last);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_exiting);
 static DEFINE_STATIC_KEY_FALSE(scx_ops_enq_migration_disabled);
@@ -4717,6 +4733,7 @@ static void scx_ops_disable_workfn(struc
 	static_branch_disable(&__scx_ops_enabled);
 	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
 		static_branch_disable(&scx_has_op[i]);
+	static_branch_disable(&scx_ops_allow_queued_wakeup);
 	static_branch_disable(&scx_ops_enq_last);
 	static_branch_disable(&scx_ops_enq_exiting);
 	static_branch_disable(&scx_ops_enq_migration_disabled);
@@ -5348,9 +5365,10 @@ static int scx_ops_enable(struct sched_e
 		if (((void (**)(void))ops)[i])
 			static_branch_enable(&scx_has_op[i]);
 
+	if (ops->flags & SCX_OPS_ALLOW_QUEUED_WAKEUP)
+		static_branch_enable(&scx_ops_allow_queued_wakeup);
 	if (ops->flags & SCX_OPS_ENQ_LAST)
 		static_branch_enable(&scx_ops_enq_last);
-
 	if (ops->flags & SCX_OPS_ENQ_EXITING)
 		static_branch_enable(&scx_ops_enq_exiting);
 	if (ops->flags & SCX_OPS_ENQ_MIGRATION_DISABLED)
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -8,6 +8,8 @@
  */
 #ifdef CONFIG_SCHED_CLASS_EXT
 
+DECLARE_STATIC_KEY_FALSE(scx_ops_allow_queued_wakeup);
+
 void scx_tick(struct rq *rq);
 void init_scx_entity(struct sched_ext_entity *scx);
 void scx_pre_fork(struct task_struct *p);
@@ -34,6 +36,13 @@ static inline bool task_on_scx(const str
 	return scx_enabled() && p->sched_class == &ext_sched_class;
 }
 
+static inline bool scx_allow_ttwu_queue(const struct task_struct *p)
+{
+	return !scx_enabled() ||
+		static_branch_likely(&scx_ops_allow_queued_wakeup) ||
+		p->sched_class != &ext_sched_class;
+}
+
 #ifdef CONFIG_SCHED_CORE
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi);
@@ -52,6 +61,7 @@ static inline void scx_rq_activate(struc
 static inline void scx_rq_deactivate(struct rq *rq) {}
 static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
 static inline bool task_on_scx(const struct task_struct *p) { return false; }
+static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
 static inline void init_sched_ext_class(void) {}
 
 #endif	/* CONFIG_SCHED_CLASS_EXT */


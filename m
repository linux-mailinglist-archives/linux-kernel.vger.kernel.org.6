Return-Path: <linux-kernel+bounces-403011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 695EE9C2F8C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 21:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04871F217A7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 20:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B836D19E97C;
	Sat,  9 Nov 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLCcoqC8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DDF1E4BE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731185429; cv=none; b=VXidREcQ0fgII8jG8uqgmWFyp5TC5ljEHLeaCyc7nmge3QmYTpzw1zwayVoRptIu8ImK9ThjKU9yyKz80ljQMcLJO5GniR5zgTm+DiYSqd3b/+unHL/E80tIrdVun/1eMID22hswsQKyjVOtFlqdWGAKwi2pzSPI2RdTiHkeQkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731185429; c=relaxed/simple;
	bh=CIwqaifFMigBoZYG0XQaTf+ltDV88b4u9xJR6K8anFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwhuEBaW3EmcJ0qV661H9ljpEtcIH6uh7ELQ50wTLvmz896WD+oSy4O7qCaacN4GeJkhDcDx2T+42tg9j5yHSpmKrZk6loSpF/0SSWIsuWAvCfOaghv2xySlR3e115I9t6a98P0L+xeqH7P5GTXSW6zoQdGpuXAba0rNv3jTgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLCcoqC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C7BC4CECE;
	Sat,  9 Nov 2024 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731185428;
	bh=CIwqaifFMigBoZYG0XQaTf+ltDV88b4u9xJR6K8anFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLCcoqC8oXCEZ699ohPt1y+pdaMX4R7tlc3eff4ZPMOAv8YX6j9x7VOpmi4bMOGkE
	 h8Y3U7tLjE7k7pSXANwtvkKbF0MVygXCeB4+xyj6NPgZXpD+Y0cQwA0c4yJJw8MnQB
	 mI4Zn4oesqWTeoGhf4qIlz9T46JBBqm8/dorGweKUV29Px1Sp9Toh4Q7ILeyTZ419w
	 AVCPW82bc7slz6hJh6H6hFCAFZwMCRS+PpTqowiNYaIyLNE3affyq362yKDvP60Yqx
	 5vmwQebdLhbuNtyEANuPKjuKKy4tv3CYZTFGWyPsvKm+CtcY/IdKVY82OMd3fQMnon
	 1mZtbc6M3FLwQ==
Date: Sat, 9 Nov 2024 10:50:27 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH sched_ext/for-6.12-fixes v2] sched_ext: Handle cases where
 pick_task_scx() is called without preceding balance_scx()
Message-ID: <Zy_LEx7n26JIHbTV@slm.duckdns.org>
References: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztj_h5c2LYsdXYbA@slm.duckdns.org>

sched_ext dispatches tasks from the BPF scheduler from balance_scx() and
thus every pick_task_scx() call must be preceded by balance_scx(). While
this usually holds, due to a bug, there are cases where the fair class's
balance() returns true indicating that it has tasks to run on the CPU and
thus terminating balance() calls but fails to actually find the next task to
run when pick_task() is called. In such cases, pick_task_scx() can be called
without preceding balance_scx().

Detect this condition using SCX_RQ_BAL_PENDING flags. If detected, keep
running the previous task if possible and avoid stalling from entering idle
without balancing.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/Ztj_h5c2LYsdXYbA@slm.duckdns.org
---
Applied to sched_ext/for-6.12-fixes.

 kernel/sched/core.c  | 13 ++++++++-----
 kernel/sched/ext.c   | 44 +++++++++++++++++++++++++++++++-------------
 kernel/sched/sched.h |  5 +++--
 3 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index aeb595514461..a910a5b4c274 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5914,12 +5914,15 @@ static void prev_balance(struct rq *rq, struct task_struct *prev,
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 	/*
-	 * SCX requires a balance() call before every pick_next_task() including
-	 * when waking up from SCHED_IDLE. If @start_class is below SCX, start
-	 * from SCX instead.
+	 * SCX requires a balance() call before every pick_task() including when
+	 * waking up from SCHED_IDLE. If @start_class is below SCX, start from
+	 * SCX instead. Also, set a flag to detect missing balance() call.
 	 */
-	if (scx_enabled() && sched_class_above(&ext_sched_class, start_class))
-		start_class = &ext_sched_class;
+	if (scx_enabled()) {
+		rq->scx.flags |= SCX_RQ_BAL_PENDING;
+		if (sched_class_above(&ext_sched_class, start_class))
+			start_class = &ext_sched_class;
+	}
 #endif
 
 	/*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 3bdb08fc2056..19f9cb3a4190 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2634,7 +2634,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 
 	lockdep_assert_rq_held(rq);
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
-	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
+	rq->scx.flags &= ~(SCX_RQ_BAL_PENDING | SCX_RQ_BAL_KEEP);
 
 	if (static_branch_unlikely(&scx_ops_cpu_preempt) &&
 	    unlikely(rq->scx.cpu_released)) {
@@ -2948,12 +2948,11 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 {
 	struct task_struct *prev = rq->curr;
 	struct task_struct *p;
+	bool prev_on_scx = prev->sched_class == &ext_sched_class;
+	bool keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
+	bool kick_idle = false;
 
 	/*
-	 * If balance_scx() is telling us to keep running @prev, replenish slice
-	 * if necessary and keep running @prev. Otherwise, pop the first one
-	 * from the local DSQ.
-	 *
 	 * WORKAROUND:
 	 *
 	 * %SCX_RQ_BAL_KEEP should be set iff $prev is on SCX as it must just
@@ -2962,22 +2961,41 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 	 * which then ends up calling pick_task_scx() without preceding
 	 * balance_scx().
 	 *
-	 * For now, ignore cases where $prev is not on SCX. This isn't great and
-	 * can theoretically lead to stalls. However, for switch_all cases, this
-	 * happens only while a BPF scheduler is being loaded or unloaded, and,
-	 * for partial cases, fair will likely keep triggering this CPU.
+	 * Keep running @prev if possible and avoid stalling from entering idle
+	 * without balancing.
 	 *
-	 * Once fair is fixed, restore WARN_ON_ONCE().
+	 * Once fair is fixed, remove the workaround and trigger WARN_ON_ONCE()
+	 * if pick_task_scx() is called without preceding balance_scx().
 	 */
-	if ((rq->scx.flags & SCX_RQ_BAL_KEEP) &&
-	    prev->sched_class == &ext_sched_class) {
+	if (unlikely(rq->scx.flags & SCX_RQ_BAL_PENDING)) {
+		if (prev_on_scx) {
+			keep_prev = true;
+		} else {
+			keep_prev = false;
+			kick_idle = true;
+		}
+	} else if (unlikely(keep_prev && !prev_on_scx)) {
+		/* only allowed during transitions */
+		WARN_ON_ONCE(scx_ops_enable_state() == SCX_OPS_ENABLED);
+		keep_prev = false;
+	}
+
+	/*
+	 * If balance_scx() is telling us to keep running @prev, replenish slice
+	 * if necessary and keep running @prev. Otherwise, pop the first one
+	 * from the local DSQ.
+	 */
+	if (keep_prev) {
 		p = prev;
 		if (!p->scx.slice)
 			p->scx.slice = SCX_SLICE_DFL;
 	} else {
 		p = first_local_task(rq);
-		if (!p)
+		if (!p) {
+			if (kick_idle)
+				scx_bpf_kick_cpu(cpu_of(rq), SCX_KICK_IDLE);
 			return NULL;
+		}
 
 		if (unlikely(!p->scx.slice)) {
 			if (!scx_rq_bypassing(rq) && !scx_warned_zero_slice) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6085ef50febf..4d79804631e4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -751,8 +751,9 @@ enum scx_rq_flags {
 	 */
 	SCX_RQ_ONLINE		= 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
-	SCX_RQ_BAL_KEEP		= 1 << 2, /* balance decided to keep current */
-	SCX_RQ_BYPASSING	= 1 << 3,
+	SCX_RQ_BAL_PENDING	= 1 << 2, /* balance hasn't run yet */
+	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
+	SCX_RQ_BYPASSING	= 1 << 4,
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
 	SCX_RQ_IN_BALANCE	= 1 << 17,
-- 
2.47.0



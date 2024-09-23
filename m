Return-Path: <linux-kernel+bounces-336243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B30897F0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A0A281568
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567421A38E7;
	Mon, 23 Sep 2024 19:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWJSfZWI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10BC1A38CB
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118039; cv=none; b=NvGfZEQ02FCqs1e6Gsjkodz+PvBCsojYOvShiL5uXqH3dVyL2hITvvmd+BjbUPUIY0XZ5d2nS7HF5Au+UO1A/VJO9TVqeIRajr6gzUb/Fju/lu0zSH4GBMHjsLeBncLwNXvF2/CsONjQSnTIdmo8VSvjNUFL9jgzesv5KPChIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118039; c=relaxed/simple;
	bh=0KSmF78fXy/3v9nwyerJ+dULKjdYR69Fscy8eO5ZvFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lPISORUWRwrfZXXrAB3KQJYkFRLMqcXIyPhAXAKxrqJjNorSCqdEGQjLqYGNe+p2RRNtAQ7Slty7d8TkGrZgQpYe1PyaB+fQSPq9g+W5mPRRh1mWaTltaf69tqokpyIKiRMMDPayIp8Mu7OUxS6PxWLy9N93Fq4O1oYrM5wBc/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWJSfZWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EB3C4CEC4;
	Mon, 23 Sep 2024 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727118039;
	bh=0KSmF78fXy/3v9nwyerJ+dULKjdYR69Fscy8eO5ZvFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qWJSfZWIEto3Rfne6juvXSk1zfJYM16fSguQ4Q5Z3pINQ29FT7vUZNtyThpsDLCDh
	 xjNAJiqZefhPB4YU2RWJs2Dhd7FFgufEF3nRqt87+qUZG1OmrULyCPhCFT4utlKLbU
	 pXj9R9DMyZr3V+tIkijiFFSfFdW/Ghgq9XfcSuP1u/aVMC6qz+Q9Wu4uIhaSmybHio
	 XsZ/k8BxJdsgpLg9C5YbsMR02TVv2xmDKSAEx7hqPG0TTmSbVx6NgCPq75QgGabiTc
	 C3ds6FI2ajX/yJQHj4Plj4KJN4qEMYB1H/HD8Z9928pUD8RRHNfv5MmhB156DcXEMg
	 Zr9swIfwOLIJw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	aboorvad@linux.ibm.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6/8] sched_ext: Add scx_cgroup_enabled to gate cgroup operations and fix scx_tg_online()
Date: Mon, 23 Sep 2024 08:59:33 -1000
Message-ID: <20240923190020.1446325-7-tj@kernel.org>
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

If the BPF scheduler does not implement ops.cgroup_init(), scx_tg_online()
didn't set SCX_TG_INITED which meant that ops.cgroup_exit(), even if
implemented, won't be called from scx_tg_offline(). This is because
SCX_HAS_OP(cgroupt_init) is used to test both whether SCX cgroup operations
are enabled and ops.cgroup_init() exists.

Fix it by introducing a separate bool scx_cgroup_enabled to gate cgroup
operations and use SCX_HAS_OP(cgroup_init) only to test whether
ops.cgroup_init() exists. Make all cgroup operations consistently use
scx_cgroup_enabled to test whether cgroup operations are enabled.
scx_cgroup_enabled is added instead of using scx_enabled() to ease planned
locking updates.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index feb7c620f9c6..06dc1011312d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3689,6 +3689,7 @@ bool scx_can_stop_tick(struct rq *rq)
 #ifdef CONFIG_EXT_GROUP_SCHED
 
 DEFINE_STATIC_PERCPU_RWSEM(scx_cgroup_rwsem);
+static bool scx_cgroup_enabled;
 static bool cgroup_warned_missing_weight;
 static bool cgroup_warned_missing_idle;
 
@@ -3708,8 +3709,7 @@ static void scx_cgroup_warn_missing_weight(struct task_group *tg)
 
 static void scx_cgroup_warn_missing_idle(struct task_group *tg)
 {
-	if (scx_ops_enable_state() == SCX_OPS_DISABLED ||
-	    cgroup_warned_missing_idle)
+	if (!scx_cgroup_enabled || cgroup_warned_missing_idle)
 		return;
 
 	if (!tg->idle)
@@ -3730,15 +3730,18 @@ int scx_tg_online(struct task_group *tg)
 
 	scx_cgroup_warn_missing_weight(tg);
 
-	if (SCX_HAS_OP(cgroup_init)) {
-		struct scx_cgroup_init_args args = { .weight = tg->scx_weight };
+	if (scx_cgroup_enabled) {
+		if (SCX_HAS_OP(cgroup_init)) {
+			struct scx_cgroup_init_args args =
+				{ .weight = tg->scx_weight };
 
-		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
-				      tg->css.cgroup, &args);
-		if (!ret)
+			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
+					      tg->css.cgroup, &args);
+			if (ret)
+				ret = ops_sanitize_err("cgroup_init", ret);
+		}
+		if (ret == 0)
 			tg->scx_flags |= SCX_TG_ONLINE | SCX_TG_INITED;
-		else
-			ret = ops_sanitize_err("cgroup_init", ret);
 	} else {
 		tg->scx_flags |= SCX_TG_ONLINE;
 	}
@@ -3769,7 +3772,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 	/* released in scx_finish/cancel_attach() */
 	percpu_down_read(&scx_cgroup_rwsem);
 
-	if (!scx_enabled())
+	if (!scx_cgroup_enabled)
 		return 0;
 
 	cgroup_taskset_for_each(p, css, tset) {
@@ -3812,7 +3815,7 @@ int scx_cgroup_can_attach(struct cgroup_taskset *tset)
 
 void scx_move_task(struct task_struct *p)
 {
-	if (!scx_enabled())
+	if (!scx_cgroup_enabled)
 		return;
 
 	/*
@@ -3848,7 +3851,7 @@ void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
 	struct cgroup_subsys_state *css;
 	struct task_struct *p;
 
-	if (!scx_enabled())
+	if (!scx_cgroup_enabled)
 		goto out_unlock;
 
 	cgroup_taskset_for_each(p, css, tset) {
@@ -3865,7 +3868,7 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 {
 	percpu_down_read(&scx_cgroup_rwsem);
 
-	if (tg->scx_weight != weight) {
+	if (scx_cgroup_enabled && tg->scx_weight != weight) {
 		if (SCX_HAS_OP(cgroup_set_weight))
 			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight,
 				    tg_cgrp(tg), weight);
@@ -4037,6 +4040,9 @@ static void scx_cgroup_exit(void)
 
 	percpu_rwsem_assert_held(&scx_cgroup_rwsem);
 
+	WARN_ON_ONCE(!scx_cgroup_enabled);
+	scx_cgroup_enabled = false;
+
 	/*
 	 * scx_tg_on/offline() are excluded through scx_cgroup_rwsem. If we walk
 	 * cgroups and exit all the inited ones, all online cgroups are exited.
@@ -4112,6 +4118,9 @@ static int scx_cgroup_init(void)
 	}
 	rcu_read_unlock();
 
+	WARN_ON_ONCE(scx_cgroup_enabled);
+	scx_cgroup_enabled = true;
+
 	return 0;
 }
 
-- 
2.46.0



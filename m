Return-Path: <linux-kernel+bounces-357911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51479977B5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73010284C27
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0273F1E32AD;
	Wed,  9 Oct 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRFPMRsr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC961E284D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510255; cv=none; b=GCl0Nd6bl5KQrSmszGbYkBlD2F47cZkHbqEdDkzUbffSyb7c7NJ0s6oqsL4DjdCPGUgcjriH5DuG5awUUMt4iqk8sHg1kfQoqqNO+NVLCSI4m9cBXFrFY9iagYNS9GpKUFp2uLn8qKHo1Io6ogx2Z3yR+yTwGX3ZsWjdRjJqUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510255; c=relaxed/simple;
	bh=+CrDYJebRAwpL/FBdD3hs8AEeNU9afUmJQfT5eC5qWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBhc5we3YmzbWfaAXzEnAqgr1SxG4tEZ4jGDO29RvLidRBEMLVLS28kbOh86QPNDxMLF6DhBiAsSpgqLa/6MGmFIF4DwhJuUwBj1jN+yWn6tly6h0+bo4NzRteHI78y3+mOPooCObhgdc+UVUaAC6xSFw/rj2J4BP2qA+8BgWOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRFPMRsr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC257C4CECC;
	Wed,  9 Oct 2024 21:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728510254;
	bh=+CrDYJebRAwpL/FBdD3hs8AEeNU9afUmJQfT5eC5qWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oRFPMRsr6625zMZbn9midn2Dp4fvd5CSltWnk9hbomJaITUuDNAbUqT4VRmvGQG4/
	 TFxNCj20pBohMh98EgztY53Rf/ufstWy5EeOu/8eyAOlZdS7slMInuhE3H77UzEtfv
	 IaLSrbw584IFYVycWnY4U1YioNih4PaYHTS3pvvJcnM2C+Orq62HNt8UVhtxyggiHo
	 C2QEO+TwtbxBAlzg42u5xawuOIZzJ8XhmGRu4HjT1sQU5oECaVRe3wNB97WyuvQAXP
	 t7AAvF9SWYq5dMLvxatPR8TfUbBwDvPrU6iHuD+m2HPBZM7Epq3zOoqepKCYcKz+nv
	 CGRiK7fdmc7jA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] Revert "sched_ext: Use shorter slice while bypassing"
Date: Wed,  9 Oct 2024 11:40:57 -1000
Message-ID: <20241009214411.681233-2-tj@kernel.org>
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

This reverts commit 6f34d8d382d64e7d8e77f5a9ddfd06f4c04937b0.

Slice length is ignored while bypassing and tasks are switched on every tick
and thus the patch does not make any difference. The perceived difference
was from test noise.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 22e18aec4ee1..e08cfba33cb4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9,7 +9,6 @@
 #define SCX_OP_IDX(op)		(offsetof(struct sched_ext_ops, op) / sizeof(void (*)(void)))
 
 enum scx_consts {
-	SCX_SLICE_BYPASS		= SCX_SLICE_DFL / 4,
 	SCX_DSP_DFL_MAX_BATCH		= 32,
 	SCX_DSP_MAX_LOOPS		= 32,
 	SCX_WATCHDOG_MAX_TIMEOUT	= 30 * HZ,
@@ -1949,7 +1948,6 @@ static bool scx_rq_online(struct rq *rq)
 static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			    int sticky_cpu)
 {
-	bool bypassing = scx_rq_bypassing(rq);
 	struct task_struct **ddsp_taskp;
 	unsigned long qseq;
 
@@ -1967,7 +1965,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (!scx_rq_online(rq))
 		goto local;
 
-	if (bypassing)
+	if (scx_rq_bypassing(rq))
 		goto global;
 
 	if (p->scx.ddsp_dsq_id != SCX_DSQ_INVALID)
@@ -2022,7 +2020,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 
 global:
 	touch_core_sched(rq, p);	/* see the comment in local: */
-	p->scx.slice = bypassing ? SCX_SLICE_BYPASS : SCX_SLICE_DFL;
+	p->scx.slice = SCX_SLICE_DFL;
 	dispatch_enqueue(find_global_dsq(p), p, enq_flags);
 }
 
-- 
2.46.2



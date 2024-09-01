Return-Path: <linux-kernel+bounces-310311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 115C296797B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C278F2821F7
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9041865E9;
	Sun,  1 Sep 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6AYChNU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567117CA1F
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209067; cv=none; b=hZyJ+B+rjjmNSuCHpeQpyRyiYxou7Vdd1RoqlMh81BZuNGIIRzBntDlqt0lcuxIJDO/dHI2PlgnPaYR8C80HN5AEbOWrqqTzQYYm5gT03Ya8clWxzGn61RtlZWDsD6usm1SFHIlwn3uKvgjd4P83e1/IC777HDrZPrWEE/oSG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209067; c=relaxed/simple;
	bh=tk5uWIu211G7T0NWDKCU8S4nfSMHmawfzn9J13a/nKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AUqTbL+HDzZoAS+BRcp7ix7eXJLuW5t+e1y4hcyTbZPPF2NKFpnGMfQJSdVMNXDF2soiQDXR8D3OHB6UIFTq5DwdNuEOn1OCKHwGc3QPBrAIkxYrUoxnHc0px8ksw4exKh3qKDfLSlGx6uhU2tNB68N8d38goMmeN4dxp75y+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6AYChNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7031CC4CEC3;
	Sun,  1 Sep 2024 16:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209067;
	bh=tk5uWIu211G7T0NWDKCU8S4nfSMHmawfzn9J13a/nKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h6AYChNUOXqCd+uqVXQnAPLh5emcn6Lg4E+Qzh7hNtH8kK+puGoto5+nH5pZteBiY
	 97CsaQz7u1zn9gyQ4SeoaREUKDuUL+hxpaXuKJntSehKPTWy8GS2DtU3OiZBG8J7iH
	 ojYuE9Owqy0ibvA7Vm80QVJ5DOAHMbVnSD1HsbMXoCqQHLKKZ5zGqn2PrpFzgxycLo
	 p+ha9pf5xd5JBViPFdD+e5y2Q493+9LbfEjfmY2tBGLRc8k0/mRWXmp0LSht/H09gs
	 CLQrnS6iTmdK8zEckKENWKfmnCOXK5yPvlZHR0Ecvgx5f/TnmagY2jQyaWJl1BAxA4
	 e/pqaIBiZFBKA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/12] sched_ext: Move sanity check and dsq_mod_nr() into task_unlink_from_dsq()
Date: Sun,  1 Sep 2024 06:43:44 -1000
Message-ID: <20240901164417.779239-8-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901164417.779239-1-tj@kernel.org>
References: <20240901164417.779239-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All task_unlink_from_dsq() users are doing dsq_mod_nr(dsq, -1). Move it into
task_unlink_from_dsq(). Also move sanity check into it.

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0829b7637c52..4ec0a4f7f3ee 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1639,6 +1639,8 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 static void task_unlink_from_dsq(struct task_struct *p,
 				 struct scx_dispatch_q *dsq)
 {
+	WARN_ON_ONCE(list_empty(&p->scx.dsq_list.node));
+
 	if (p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) {
 		rb_erase(&p->scx.dsq_priq, &dsq->priq);
 		RB_CLEAR_NODE(&p->scx.dsq_priq);
@@ -1646,6 +1648,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 	}
 
 	list_del_init(&p->scx.dsq_list.node);
+	dsq_mod_nr(dsq, -1);
 }
 
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
@@ -1682,9 +1685,7 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	*/
 	if (p->scx.holding_cpu < 0) {
 		/* @p must still be on @dsq, dequeue */
-		WARN_ON_ONCE(list_empty(&p->scx.dsq_list.node));
 		task_unlink_from_dsq(p, dsq);
-		dsq_mod_nr(dsq, -1);
 	} else {
 		/*
 		 * We're racing against dispatch_to_local_dsq() which already
@@ -2146,7 +2147,6 @@ static void consume_local_task(struct task_struct *p,
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 	task_unlink_from_dsq(p, dsq);
 	list_add_tail(&p->scx.dsq_list.node, &rq->scx.local_dsq.list);
-	dsq_mod_nr(dsq, -1);
 	dsq_mod_nr(&rq->scx.local_dsq, 1);
 	p->scx.dsq = &rq->scx.local_dsq;
 	raw_spin_unlock(&dsq->lock);
@@ -2236,7 +2236,6 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 	task_unlink_from_dsq(p, dsq);
-	dsq_mod_nr(dsq, -1);
 	p->scx.holding_cpu = cpu;
 
 	raw_spin_unlock(&dsq->lock);
-- 
2.46.0



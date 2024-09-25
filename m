Return-Path: <linux-kernel+bounces-337817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7393984F53
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E551F244B9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E53BEAE9;
	Wed, 25 Sep 2024 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eODALFoW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3CC125
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222789; cv=none; b=MlPBSM6qsPEY48bFpxjgnOJMhrO6uL6UYrWlXCnQjuDnoaDwyhc/1BdTF+U42qY+1qeZEYudbRxQLcEgPyrdd+yoaqoNK3VMJHENizabsxoKSlGSHyO0iucUPxukrjd6yTBsmKOtLIngrxU3dZvQqWsVcN2oSvf/iMJOH8lhGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222789; c=relaxed/simple;
	bh=IR6TGpWnPeQZLl9L5wmFCrn7bkLPRBabwOuyUi3ewS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CM3TKY4w45NLj9SQ5XMTYwESaQMOicSDXcCmR3ZHO0mld58sPVLJtGPz/sjTval4+V9g8fFSLZo8+0zN12Mii9S6qJHqHKaVlVm9pj0C1ZSaPMWZE77LUwFmP0sgBrWaNbb4UnBEBwAhXU0YRlkPqCNpSDnr7skRKhqvzRhvqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eODALFoW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B7CC4CEC4;
	Wed, 25 Sep 2024 00:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727222789;
	bh=IR6TGpWnPeQZLl9L5wmFCrn7bkLPRBabwOuyUi3ewS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eODALFoWkUwZJSc2w5lhk8+f4vS42gnGd1AQKfmV66DmnmWHpFyx1sYbPowIo9ve7
	 QjK0qhSY13VYkNuGEw8wCa33+07RBPo09CCoEmR2EsbgpJP3xnoZTR3WC8Ow9EfSDn
	 BGJahjMHlb0rE21OD8U7GL8ifJzezRceXRZfraAcMaigjWTVmJt7viP5eYE2fvzDSw
	 7nmaISPCr4T557ZRW9CN1DCAZQAYeFRD9L54mvEEjK/Ih2hVl2p8H4m7xnRzfcmOp2
	 5SzY9RV8jqiB+wBTaRrdHVbOA/EF4wS+uSpknm8C9yqD0m/Wcr74yo/6ckktgsAVgV
	 uCOk3S16H+yOg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] sched_ext: Relocate find_user_dsq()
Date: Tue, 24 Sep 2024 14:06:05 -1000
Message-ID: <20240925000622.1972325-4-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240925000622.1972325-1-tj@kernel.org>
References: <20240925000622.1972325-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for the addition of find_global_dsq(). No functional changes.

Signed-off-by: tejun heo <tj@kernel.org>
---
 kernel/sched/ext.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ed2b914c42d1..acb4db7827a4 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1029,6 +1029,11 @@ static bool u32_before(u32 a, u32 b)
 	return (s32)(a - b) < 0;
 }
 
+static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
+{
+	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -1803,11 +1808,6 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 		raw_spin_unlock(&dsq->lock);
 }
 
-static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
-{
-	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
-}
-
 static struct scx_dispatch_q *find_dsq_for_dispatch(struct rq *rq, u64 dsq_id,
 						    struct task_struct *p)
 {
-- 
2.46.0



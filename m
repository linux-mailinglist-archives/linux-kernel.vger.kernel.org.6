Return-Path: <linux-kernel+bounces-310314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0FE96797F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD951C212A8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BE9187323;
	Sun,  1 Sep 2024 16:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQ9bYivA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128BB186E43
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209071; cv=none; b=YnBbAotukVmjmY1L2spw1qdmvMd2Tdx2qcHTLKF162wOcqaF1IYZFwL4NEubvkoKkqiRBi613ahr758uBbprLcO1P8ADLVtUCJu/aQu9oc66h4oAWhnMgsb9erURszZ/i6Uv34/kcHNTAB+U/GaMnvZcd8Qbg2MkkhQN2UipQto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209071; c=relaxed/simple;
	bh=WHG0IHGvZhEQCcWG9ILcb/L742XpLyDMjE2MKizTtVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjKUNsn+7tDtY7jGFhUaGzAHCdVnMqAsaZgYhbviWUYe3gyyeCvbzWAz9MZNKPq/R2UakbY6lgSIf34JJFTO6uyrn+BourFLiXqvcLZn7EMMYrShAtOSK0MMZGaF7SfMiFY6nK7iVjRC6brsDPiJpZvKjkLyN6c0pRdELqxpcMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQ9bYivA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD307C4CEC9;
	Sun,  1 Sep 2024 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209070;
	bh=WHG0IHGvZhEQCcWG9ILcb/L742XpLyDMjE2MKizTtVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQ9bYivAR8U7BxluUYzyRY3+J3fsChtAtfZmYge0GhdefJyP/Pst+N6FPc9P5jaW5
	 cMBjUGPeIgg4ufvI5jR1IGreDtTQBrb3355kl7tPoMWKaKCcc3Nhvpl6KGPPhaUYqy
	 pDPJWydUhrQfeWaajk5pktII7O1ycTKhaVqUen7cTlF6O+9vZI9FNRpL05rM/ZYDaO
	 vloPSl+0an5ObZJlw2SDtsYb5qXoESFdkIspaTHCE4J3ho2v6vwg2qp1kLLt7LE/sW
	 wzFEnbItfQzYYfxWahkYbG23GGah4Qt+UM7ehPVOSfbhHz7dbOBTgzuMpCUR29s6Wf
	 T5gn2JNWQZH2w==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 10/12] sched_ext: Compact struct bpf_iter_scx_dsq_kern
Date: Sun,  1 Sep 2024 06:43:47 -1000
Message-ID: <20240901164417.779239-11-tj@kernel.org>
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

struct scx_iter_scx_dsq is defined as 6 u64's and scx_dsq_iter_kern was
using 5 of them. We want to add two more u64 fields but it's better if we do
so while staying within scx_iter_scx_dsq to maintain binary compatibility.

The way scx_iter_scx_dsq_kern is laid out is rather inefficient - the node
field takes up three u64's but only one bit of the last u64 is used. Turn
the bool into u32 flags and only use the lower 16 bits freeing up 48 bits -
16 bits for flags, 32 bits for a u32 - for use by struct
bpf_iter_scx_dsq_kern.

This allows moving the dsq_seq and flags fields of bpf_iter_scx_dsq_kern
into the cursor field reducing the struct size by a full u64.

No behavior changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 10 +++++++++-
 kernel/sched/ext.c        | 23 ++++++++++++-----------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 69f68e2121a8..9a75534cfac6 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -120,9 +120,17 @@ enum scx_kf_mask {
 	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_SELECT_CPU | SCX_KF_REST,
 };
 
+enum scx_dsq_lnode_flags {
+	SCX_DSQ_LNODE_ITER_CURSOR = 1 << 0,
+
+	/* high 16 bits can be for iter cursor flags */
+	__SCX_DSQ_LNODE_PRIV_SHIFT = 16,
+};
+
 struct scx_dsq_list_node {
 	struct list_head	node;
-	bool			is_bpf_iter_cursor;
+	u32			flags;
+	u32			priv;		/* can be used by iter cursor */
 };
 
 /*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d50166a2651a..28f421227b5b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1100,7 +1100,7 @@ static struct task_struct *nldsq_next_task(struct scx_dispatch_q *dsq,
 
 		dsq_lnode = container_of(list_node, struct scx_dsq_list_node,
 					 node);
-	} while (dsq_lnode->is_bpf_iter_cursor);
+	} while (dsq_lnode->flags & SCX_DSQ_LNODE_ITER_CURSOR);
 
 	return container_of(dsq_lnode, struct task_struct, scx.dsq_list);
 }
@@ -1118,16 +1118,15 @@ static struct task_struct *nldsq_next_task(struct scx_dispatch_q *dsq,
  */
 enum scx_dsq_iter_flags {
 	/* iterate in the reverse dispatch order */
-	SCX_DSQ_ITER_REV		= 1U << 0,
+	SCX_DSQ_ITER_REV		= 1U << 16,
 
-	__SCX_DSQ_ITER_ALL_FLAGS	= SCX_DSQ_ITER_REV,
+	__SCX_DSQ_ITER_USER_FLAGS	= SCX_DSQ_ITER_REV,
+	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS,
 };
 
 struct bpf_iter_scx_dsq_kern {
 	struct scx_dsq_list_node	cursor;
 	struct scx_dispatch_q		*dsq;
-	u32				dsq_seq;
-	u32				flags;
 } __attribute__((aligned(8)));
 
 struct bpf_iter_scx_dsq {
@@ -1165,6 +1164,9 @@ static void scx_task_iter_init(struct scx_task_iter *iter)
 {
 	lockdep_assert_held(&scx_tasks_lock);
 
+	BUILD_BUG_ON(__SCX_DSQ_ITER_ALL_FLAGS &
+		     ((1U << __SCX_DSQ_LNODE_PRIV_SHIFT) - 1));
+
 	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
 	list_add(&iter->cursor.tasks_node, &scx_tasks);
 	iter->locked = NULL;
@@ -5876,7 +5878,7 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 	BUILD_BUG_ON(__alignof__(struct bpf_iter_scx_dsq_kern) !=
 		     __alignof__(struct bpf_iter_scx_dsq));
 
-	if (flags & ~__SCX_DSQ_ITER_ALL_FLAGS)
+	if (flags & ~__SCX_DSQ_ITER_USER_FLAGS)
 		return -EINVAL;
 
 	kit->dsq = find_non_local_dsq(dsq_id);
@@ -5884,9 +5886,8 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 		return -ENOENT;
 
 	INIT_LIST_HEAD(&kit->cursor.node);
-	kit->cursor.is_bpf_iter_cursor = true;
-	kit->dsq_seq = READ_ONCE(kit->dsq->seq);
-	kit->flags = flags;
+	kit->cursor.flags |= SCX_DSQ_LNODE_ITER_CURSOR | flags;
+	kit->cursor.priv = READ_ONCE(kit->dsq->seq);
 
 	return 0;
 }
@@ -5900,7 +5901,7 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it)
 {
 	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
-	bool rev = kit->flags & SCX_DSQ_ITER_REV;
+	bool rev = kit->cursor.flags & SCX_DSQ_ITER_REV;
 	struct task_struct *p;
 	unsigned long flags;
 
@@ -5921,7 +5922,7 @@ __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *i
 	 */
 	do {
 		p = nldsq_next_task(kit->dsq, p, rev);
-	} while (p && unlikely(u32_before(kit->dsq_seq, p->scx.dsq_seq)));
+	} while (p && unlikely(u32_before(kit->cursor.priv, p->scx.dsq_seq)));
 
 	if (p) {
 		if (rev)
-- 
2.46.0



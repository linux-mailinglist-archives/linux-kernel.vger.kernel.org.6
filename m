Return-Path: <linux-kernel+bounces-310312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B75496797D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCA61C21308
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A169E18660D;
	Sun,  1 Sep 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho0bJGXP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D3E185952
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209069; cv=none; b=QeJxmaNajAxVj1sNnHwNz4vNCqlnYisryzf5Yos/XnGkYrhiOd7IlGvsxOclXnvBJ77l23IJuUwjF4ISEFWh42ehfPkHCaE9+Rod8HKzS/uC8gN1nNEmauMAAup7cPySJ0ia+n5i0aIK7RZFOCd+IZ0ApxyrPDtS19S/is93v2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209069; c=relaxed/simple;
	bh=CW7FWr2zaVuSThu0V18bcAE7WRshti8f+yRRPfF7cHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRHu4tm7TRUpmKndCOM7XM+KAUs19zT4IHwt61zPZW2UAlWOztXzFsUPTd1sXV4kZGtwsZKuVt83KfoBIkYzAAxXmEf6rc4JVm1ppvcflkUIzX/6fTrJogk7zSge0ELJGQBllSreDidpwnN3zSb7SIIRCAN87piyTtM2ZKdTrxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho0bJGXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5ACC4CEC8;
	Sun,  1 Sep 2024 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209068;
	bh=CW7FWr2zaVuSThu0V18bcAE7WRshti8f+yRRPfF7cHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ho0bJGXPZwut865XnIcBkh73ylRHTKoXoUGirb9vmkNlYG7+hNQSjlw0f35wPlV0m
	 LzY36rMDaxPtwhprxRliWJAbW2/5bykBVJzRb4XRLjvunQG7vniIiagWXKKqJ3U0D+
	 4ruYc9PEfNPBZbhBCk1ikGR9XJcNE0NGxKvnxwH+JDWxztHDlwiNAPrFLJe8S9RbEU
	 MQTZv/tnW97zOJjv7oGsfLNKdzC7V1p1QrHNm05L6s/7GD8xs0EgQYwoeFhmZ/oY2B
	 DMvzFGdyJgcDP124Ejg/95YNWIXVzCGdSe7JiJhO7o2Iw9pFHWvyO3TQLmkZYkzWlk
	 dluE0kOZq01og==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/12] sched_ext: Move consume_local_task() upward
Date: Sun,  1 Sep 2024 06:43:45 -1000
Message-ID: <20240901164417.779239-9-tj@kernel.org>
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

So that the local case comes first and two CONFIG_SMP blocks can be merged.

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: David Vernet <void@manifault.com>
---
 kernel/sched/ext.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4ec0a4f7f3ee..e0bc4851b6e2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2101,6 +2101,20 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 		return false;
 }
 
+static void consume_local_task(struct task_struct *p,
+			       struct scx_dispatch_q *dsq, struct rq *rq)
+{
+	lockdep_assert_held(&dsq->lock);	/* released on return */
+
+	/* @dsq is locked and @p is on this rq */
+	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
+	task_unlink_from_dsq(p, dsq);
+	list_add_tail(&p->scx.dsq_list.node, &rq->scx.local_dsq.list);
+	dsq_mod_nr(&rq->scx.local_dsq, 1);
+	p->scx.dsq = &rq->scx.local_dsq;
+	raw_spin_unlock(&dsq->lock);
+}
+
 #ifdef CONFIG_SMP
 /**
  * move_task_to_local_dsq - Move a task from a different rq to a local DSQ
@@ -2136,23 +2150,6 @@ static void move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 	dst_rq->scx.extra_enq_flags = 0;
 }
 
-#endif	/* CONFIG_SMP */
-
-static void consume_local_task(struct task_struct *p,
-			       struct scx_dispatch_q *dsq, struct rq *rq)
-{
-	lockdep_assert_held(&dsq->lock);	/* released on return */
-
-	/* @dsq is locked and @p is on this rq */
-	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
-	task_unlink_from_dsq(p, dsq);
-	list_add_tail(&p->scx.dsq_list.node, &rq->scx.local_dsq.list);
-	dsq_mod_nr(&rq->scx.local_dsq, 1);
-	p->scx.dsq = &rq->scx.local_dsq;
-	raw_spin_unlock(&dsq->lock);
-}
-
-#ifdef CONFIG_SMP
 /*
  * Similar to kernel/sched/core.c::is_cpu_allowed(). However, there are two
  * differences:
-- 
2.46.0



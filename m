Return-Path: <linux-kernel+bounces-308662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2454F966002
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AB6282916
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652011AF4E0;
	Fri, 30 Aug 2024 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHNZUmpc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC51AE861
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015873; cv=none; b=jZr6mV0JJgZC6hCrOE1k5kaT+cFSU7pg6salC4poc2yyKLskSHYbRTDRN6xeDX+1QSeNEInWYvnRSZJnGxlmFpHi2q9x7sUMabLn95418QRP3fKYwo2WmF1UIFZKE1b3e6HQkjpgtFHQRm6yLrk36wvvehzle+nARyMyvKCvRMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015873; c=relaxed/simple;
	bh=QsvgDXM0BmeJBUQ4FgI+K/H4DhXRPCEolnRiFAR23UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCJYvPRS9HWvCZU4jS6A78UDox4NjpOkTMJt82RAHTUFI+Geci60mabGyXbFJ259A/pRgro3PiaL+z2leTobbZcmmPQAhWun9e9WY1v/Fr1MePFUnJBg9IecGk10EzM764Vp6wjIGvFT+ys39Xj/+g1fk1HJYBhwHhwnIAuHlgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHNZUmpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE34C4CEC2;
	Fri, 30 Aug 2024 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015873;
	bh=QsvgDXM0BmeJBUQ4FgI+K/H4DhXRPCEolnRiFAR23UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bHNZUmpc+3vpTjHrUvpSyQMyWHNHeJX4iKCUm19gHf63nPryA+qqVbOFU6NKsRIJb
	 S80WIAirkG0Yy7k8uEm0/mEjTT/tV2KcMDhbHcmIV3pA6/2JCJdgbvZ40ZglsNR1HM
	 /qubdt2WU2DaziATVhYW5TNuitDRJ9+ce3MSeH3FxiK/pOk1YGxTdK4h9+7Ed2IXma
	 zuykVgJj3RZVnbiXE1cd75F5kMlsUoF0izdCLQVFW/hf83olX8kD5WkIX93FTR/aa3
	 9jOSVTfz4Pfhvod6fl7JAkqKDNhqE2F4XhuRh3ad2IeIIfUCY8c/JUhgozyZWKvsp5
	 lr5D+PitqqVMA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 08/11] sched_ext: Move consume_local_task() upward
Date: Fri, 30 Aug 2024 01:03:52 -1000
Message-ID: <20240830110415.116090-9-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830110415.116090-1-tj@kernel.org>
References: <20240830110415.116090-1-tj@kernel.org>
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
---
 kernel/sched/ext.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9befa2bd1eb0..51d141602a11 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2103,6 +2103,20 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
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
@@ -2138,23 +2152,6 @@ static void move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
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



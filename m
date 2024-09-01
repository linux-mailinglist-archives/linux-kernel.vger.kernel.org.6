Return-Path: <linux-kernel+bounces-310310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9090C96797A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C6931F21B04
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6439C185B75;
	Sun,  1 Sep 2024 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtqasJ4Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4A185B61
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209066; cv=none; b=MbxpA7qhB1QH31WJ+FVYBpm6pqvH1UWGl2fNvt2F4lVMajjCAALBnUtrHAaI3RiZu3x8oIGgQcABlgvOvYSCP2TXDgZe+nAVjmU3BmeIqmv6HAN+yRpN/131gi/8R81vg5FpOTFlrYNSWuH8vG2yoLqY193gKhXyMsKayL6cWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209066; c=relaxed/simple;
	bh=qBpA/zAi41pUWCiZChHMNOJxO610LB7mM0BlmCcmX9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6uA1Nq0LcAIhyfjVnSR1gunARc3HR4q0X8NxB+ho9qOqHu01gIlJVZZX7kgwr9PUADre+bFLeEgZkM7SvBrUrxbEEFODRMTXMYGcfROhK/kHRiER0BhI44vkQbAYlVZI+k9aLDMN7zVEbAffzOIarwpMWWVwuCmSkQeeXNm1tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtqasJ4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B6AC4CEC9;
	Sun,  1 Sep 2024 16:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725209066;
	bh=qBpA/zAi41pUWCiZChHMNOJxO610LB7mM0BlmCcmX9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtqasJ4QZNv378/V1VxZxiRGZAuqvydJMr2vqLwUFwYRbzlalQloGXG31v8rguESy
	 blOmRw7JY88kHqA8esVKp18VrucBrscEVnaeKRpRAZEnvSzMu/yAOGbnNcl9iLwiXd
	 ZBMQTPK+J6CQEa85XF+4nAU9rDv10Jh6dLR4K6Fauxc2fNxH294h/NdrmQmNZZyNyU
	 UDuS63nLXSeBxoxXwJpJq8ozjNp3fn4heSuST1LUuhIUzekKN6hk9GiocRiZT1ULfG
	 kFI5szq3AjkTw28X124/ODIlrRd905lxLgvVMU3CUJldgFCIcj1wgBSC8yaJpm5EUE
	 Te+4y17udamrw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/12] sched_ext: Reorder args for consume_local/remote_task()
Date: Sun,  1 Sep 2024 06:43:43 -1000
Message-ID: <20240901164417.779239-7-tj@kernel.org>
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

Reorder args for consistency in the order of:

  current_rq, p, src_[rq|dsq], dst_[rq|dsq].

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 89a393f183dd..0829b7637c52 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2137,8 +2137,8 @@ static void move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 
 #endif	/* CONFIG_SMP */
 
-static void consume_local_task(struct rq *rq, struct scx_dispatch_q *dsq,
-			       struct task_struct *p)
+static void consume_local_task(struct task_struct *p,
+			       struct scx_dispatch_q *dsq, struct rq *rq)
 {
 	lockdep_assert_held(&dsq->lock);	/* released on return */
 
@@ -2247,8 +2247,8 @@ static bool unlink_dsq_and_lock_src_rq(struct task_struct *p,
 		!WARN_ON_ONCE(src_rq != task_rq(p));
 }
 
-static bool consume_remote_task(struct rq *this_rq, struct scx_dispatch_q *dsq,
-				struct task_struct *p, struct rq *src_rq)
+static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
+				struct scx_dispatch_q *dsq, struct rq *src_rq)
 {
 	raw_spin_rq_unlock(this_rq);
 
@@ -2263,7 +2263,7 @@ static bool consume_remote_task(struct rq *this_rq, struct scx_dispatch_q *dsq,
 }
 #else	/* CONFIG_SMP */
 static inline bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq, bool trigger_error) { return false; }
-static inline bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq, struct task_struct *p, struct rq *task_rq) { return false; }
+static inline bool consume_remote_task(struct rq *this_rq, struct task_struct *p, struct scx_dispatch_q *dsq, struct rq *task_rq) { return false; }
 #endif	/* CONFIG_SMP */
 
 static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
@@ -2284,12 +2284,12 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 		struct rq *task_rq = task_rq(p);
 
 		if (rq == task_rq) {
-			consume_local_task(rq, dsq, p);
+			consume_local_task(p, dsq, rq);
 			return true;
 		}
 
 		if (task_can_run_on_remote_rq(p, rq, false)) {
-			if (likely(consume_remote_task(rq, dsq, p, task_rq)))
+			if (likely(consume_remote_task(rq, p, dsq, task_rq)))
 				return true;
 			goto retry;
 		}
-- 
2.46.0



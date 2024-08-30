Return-Path: <linux-kernel+bounces-308660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB06965FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C92AB1C20D95
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A961ACE07;
	Fri, 30 Aug 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW36jOm1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7944A1ACDE3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015871; cv=none; b=PVqfX2utoI2vWcqeLRIssSWu0vt0FH+fVCwvDD9T6JPpI4Duj9ULqMyA4I/bM1Zf28QzMaz4hj5aGOZtV3UD6/Yb8FocGRiuym7h9I3QRcSp6+6NRBxzImLWPHn8PgVBXZwPNsQOHp/ZUdk9f4g1JFzI15wgqkp3jkTptGXZl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015871; c=relaxed/simple;
	bh=Kt0jGoKUTnwjeS4lgC+ZSxyC+Mfkq9FpI5rpJMgEMO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMgHnI8CGv5Nxo8CIPa1H/cI0icZfDuEK6zhI3HdtrgUtXkF9c1PPoSTxC5FMD3guba08d3xEO67ki6JXukLVSR9pWGJf5TKe4Wmd1xnSArND/8rhMY8Y5CI/Kj9ug2Qb63GG632a7QC5RtlM7cOn+TNO9WXvq5H7plTtTIbKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW36jOm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB1EC4CEC4;
	Fri, 30 Aug 2024 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015871;
	bh=Kt0jGoKUTnwjeS4lgC+ZSxyC+Mfkq9FpI5rpJMgEMO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UW36jOm1NUAA4YiUdHrGrg6ux+nL8JFdnlettuYaidMwJAMpqmUotyB5/A89fAoPi
	 hcBr03Ect4pjIXhNw0ooYd/ZwC+HmFREDITN4mresNHcJVj7+GK+0JSRfZBSylgymI
	 7hfByGxZM1kwkOlsX9bWuriH0XHcQx0tz9seXO9KdABncFL7MI2IWg2IAgrDR5FtDu
	 3JbLtEfSe7F8HmxaGJdLdm9PQ+kNhsNNYH7J4vcQRB9a6m47A2z+cUyulgB/EMr1cW
	 xSohNgzb3o0qjajh12ThiNk7bMTbKRJ8904SbOhXEPE43Bq22hPFUh19njC2m2sn/Q
	 bod1xdMaNA/4A==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 06/11] sched_ext: Reorder args for consume_local/remote_task()
Date: Fri, 30 Aug 2024 01:03:50 -1000
Message-ID: <20240830110415.116090-7-tj@kernel.org>
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

Reorder args for consistency in the order of:

  current_rq, p, src_[rq|dsq], dst_[rq|dsq].

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index add267f31396..620cc0586c4b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2139,8 +2139,8 @@ static void move_task_to_local_dsq(struct task_struct *p, u64 enq_flags,
 
 #endif	/* CONFIG_SMP */
 
-static void consume_local_task(struct rq *rq, struct scx_dispatch_q *dsq,
-			       struct task_struct *p)
+static void consume_local_task(struct task_struct *p,
+			       struct scx_dispatch_q *dsq, struct rq *rq)
 {
 	lockdep_assert_held(&dsq->lock);	/* released on return */
 
@@ -2249,8 +2249,8 @@ static bool unlink_dsq_and_lock_task_rq(struct task_struct *p,
 		!WARN_ON_ONCE(task_rq != task_rq(p));
 }
 
-static bool consume_remote_task(struct rq *this_rq, struct scx_dispatch_q *dsq,
-				struct task_struct *p, struct rq *task_rq)
+static bool consume_remote_task(struct rq *this_rq, struct task_struct *p,
+				struct scx_dispatch_q *dsq, struct rq *task_rq)
 {
 	raw_spin_rq_unlock(this_rq);
 
@@ -2265,7 +2265,7 @@ static bool consume_remote_task(struct rq *this_rq, struct scx_dispatch_q *dsq,
 }
 #else	/* CONFIG_SMP */
 static inline bool task_can_run_on_remote_rq(struct task_struct *p, struct rq *rq, bool trigger_error) { return false; }
-static inline bool consume_remote_task(struct rq *rq, struct scx_dispatch_q *dsq, struct task_struct *p, struct rq *task_rq) { return false; }
+static inline bool consume_remote_task(struct rq *this_rq, struct task_struct *p, struct scx_dispatch_q *dsq, struct rq *task_rq) { return false; }
 #endif	/* CONFIG_SMP */
 
 static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
@@ -2286,12 +2286,12 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
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



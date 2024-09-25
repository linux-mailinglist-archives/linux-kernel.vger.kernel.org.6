Return-Path: <linux-kernel+bounces-337820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E69984F57
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 02:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4361F24642
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D60F1862;
	Wed, 25 Sep 2024 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PipVKimp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D62367
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727222933; cv=none; b=m7XMySKgSlHgWfBR7qCwbqY/bkFfywFzDT+qGn04aafgTF1BPArrwwnGz6SwJItDd+o7IJT9+G8WDj+ltdLtDSQMnN+zrihiqfhyta19P39GjOpzT6fot1RQ3LgFMqeZI1rSt+DWtFLmpOz4NI+bOxtBOdTzuR3+5ppzbFIPlLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727222933; c=relaxed/simple;
	bh=YFC6S6N8hE+GkVgobmdUokssatSjr1KE+G4PuGTdy9s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kufKdjnvjO99LazdJe+N9MHUTv3jCcAXH2sHq0xOcJYs+FUrYGrJtuMdU2lU1nZouq5n/SHf9II3WnsJI/iWvbeH+NwtYDZCk50fjLEwp/IxGy4pyG7CxQTosbgT60x6bpyWkLnTwQAqUbeZCJqPqmreOhZgN2XvFj5/0Qw1RZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PipVKimp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E24C4CEC4;
	Wed, 25 Sep 2024 00:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727222933;
	bh=YFC6S6N8hE+GkVgobmdUokssatSjr1KE+G4PuGTdy9s=;
	h=Date:From:To:Cc:Subject:From;
	b=PipVKimpdrmeWEuToYZWZ1nj7hIgWOIzJrjnqtlwqKHPihdZ8BXYgE+7v6LFZUva4
	 hY7BW6+J5hTr2S+W2cNYhYEES5mKzyDvyNg23h76/7DGhtZ9HBx5uf+LDYGd9w7t9a
	 uxJ+kG7HoC70sfm+iSVcZgcRgm5JGWRoHBtxgjT6sXgdNMizzDHCMkjKZ6hiIKZ2/t
	 +W1KtBP4+R9oVC7YU/Y/dgcjgGYvuWIXNYTqGmWBllHMPM2M9LutvUCkjStre6m/bL
	 Bcy1U4YqX7uETjxMd7tOcQL2LeTLXSMccNxEL8zJcmlF2k1p4hjWCXsGZ4z/3wM3A8
	 +j2486LaPhFiw==
Date: Tue, 24 Sep 2024 14:08:52 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, sched-ext@meta.com
Subject: [PATCH sched_ext/for-6.13] sched_ext: Factor out
 move_task_between_dsqs() from scx_dispatch_from_dsq()
Message-ID: <ZvNUlEVgJkJkGaT8@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Pure reorganization. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c |  116 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 75 insertions(+), 41 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2368,6 +2368,73 @@ static inline bool task_can_run_on_remot
 static inline bool consume_remote_task(struct rq *this_rq, struct task_struct *p, struct scx_dispatch_q *dsq, struct rq *task_rq) { return false; }
 #endif	/* CONFIG_SMP */
 
+/**
+ * move_task_between_dsqs() - Move a task from one DSQ to another
+ * @p: target task
+ * @enq_flags: %SCX_ENQ_*
+ * @src_dsq: DSQ @p is currently on, must not be a local DSQ
+ * @dst_dsq: DSQ @p is being moved to, can be any DSQ
+ *
+ * Must be called with @p's task_rq and @src_dsq locked. If @dst_dsq is a local
+ * DSQ and @p is on a different CPU, @p will be migrated and thus its task_rq
+ * will change. As @p's task_rq is locked, this function doesn't need to use the
+ * holding_cpu mechanism.
+ *
+ * On return, @src_dsq is unlocked and only @p's new task_rq, which is the
+ * return value, is locked.
+ */
+static struct rq *move_task_between_dsqs(struct task_struct *p, u64 enq_flags,
+					 struct scx_dispatch_q *src_dsq,
+					 struct scx_dispatch_q *dst_dsq)
+{
+	struct rq *src_rq = task_rq(p), *dst_rq;
+
+	BUG_ON(src_dsq->id == SCX_DSQ_LOCAL);
+	lockdep_assert_held(&src_dsq->lock);
+	lockdep_assert_rq_held(src_rq);
+
+	if (dst_dsq->id == SCX_DSQ_LOCAL) {
+		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
+		if (!task_can_run_on_remote_rq(p, dst_rq, true)) {
+			dst_dsq = find_global_dsq(p);
+			dst_rq = src_rq;
+		}
+	} else {
+		/* no need to migrate if destination is a non-local DSQ */
+		dst_rq = src_rq;
+	}
+
+	/*
+	 * Move @p into $dst_dsq. If $dst_dsq is the local DSQ of a different
+	 * CPU, @p will be migrated.
+	 */
+	if (dst_dsq->id == SCX_DSQ_LOCAL) {
+		/* @p is going from a non-local DSQ to a local DSQ */
+		if (src_rq == dst_rq) {
+			task_unlink_from_dsq(p, src_dsq);
+			move_local_task_to_local_dsq(p, enq_flags,
+						     src_dsq, dst_rq);
+			raw_spin_unlock(&src_dsq->lock);
+		} else {
+			raw_spin_unlock(&src_dsq->lock);
+			move_remote_task_to_local_dsq(p, enq_flags,
+						      src_rq, dst_rq);
+		}
+	} else {
+		/*
+		 * @p is going from a non-local DSQ to a non-local DSQ. As
+		 * $src_dsq is already locked, do an abbreviated dequeue.
+		 */
+		task_unlink_from_dsq(p, src_dsq);
+		p->scx.dsq = NULL;
+		raw_spin_unlock(&src_dsq->lock);
+
+		dispatch_enqueue(dst_dsq, p, enq_flags);
+	}
+
+	return dst_rq;
+}
+
 static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
 {
 	struct task_struct *p;
@@ -6041,7 +6108,7 @@ static bool scx_dispatch_from_dsq(struct
 				  u64 enq_flags)
 {
 	struct scx_dispatch_q *src_dsq = kit->dsq, *dst_dsq;
-	struct rq *this_rq, *src_rq, *dst_rq, *locked_rq;
+	struct rq *this_rq, *src_rq, *locked_rq;
 	bool dispatched = false;
 	bool in_balance;
 	unsigned long flags;
@@ -6087,51 +6154,18 @@ static bool scx_dispatch_from_dsq(struct
 	/* @p is still on $src_dsq and stable, determine the destination */
 	dst_dsq = find_dsq_for_dispatch(this_rq, dsq_id, p);
 
-	if (dst_dsq->id == SCX_DSQ_LOCAL) {
-		dst_rq = container_of(dst_dsq, struct rq, scx.local_dsq);
-		if (!task_can_run_on_remote_rq(p, dst_rq, true)) {
-			dst_dsq = find_global_dsq(p);
-			dst_rq = src_rq;
-		}
-	} else {
-		/* no need to migrate if destination is a non-local DSQ */
-		dst_rq = src_rq;
-	}
-
 	/*
-	 * Move @p into $dst_dsq. If $dst_dsq is the local DSQ of a different
-	 * CPU, @p will be migrated.
+	 * Apply vtime and slice updates before moving so that the new time is
+	 * visible before inserting into $dst_dsq. @p is still on $src_dsq but
+	 * this is safe as we're locking it.
 	 */
-	if (dst_dsq->id == SCX_DSQ_LOCAL) {
-		/* @p is going from a non-local DSQ to a local DSQ */
-		if (src_rq == dst_rq) {
-			task_unlink_from_dsq(p, src_dsq);
-			move_local_task_to_local_dsq(p, enq_flags,
-						     src_dsq, dst_rq);
-			raw_spin_unlock(&src_dsq->lock);
-		} else {
-			raw_spin_unlock(&src_dsq->lock);
-			move_remote_task_to_local_dsq(p, enq_flags,
-						      src_rq, dst_rq);
-			locked_rq = dst_rq;
-		}
-	} else {
-		/*
-		 * @p is going from a non-local DSQ to a non-local DSQ. As
-		 * $src_dsq is already locked, do an abbreviated dequeue.
-		 */
-		task_unlink_from_dsq(p, src_dsq);
-		p->scx.dsq = NULL;
-		raw_spin_unlock(&src_dsq->lock);
-
-		if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
-			p->scx.dsq_vtime = kit->vtime;
-		dispatch_enqueue(dst_dsq, p, enq_flags);
-	}
-
+	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_VTIME)
+		p->scx.dsq_vtime = kit->vtime;
 	if (kit->cursor.flags & __SCX_DSQ_ITER_HAS_SLICE)
 		p->scx.slice = kit->slice;
 
+	/* execute move */
+	locked_rq = move_task_between_dsqs(p, enq_flags, src_dsq, dst_dsq);
 	dispatched = true;
 out:
 	if (in_balance) {


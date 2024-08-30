Return-Path: <linux-kernel+bounces-308661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF13966001
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85D381F211B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7971AD9D8;
	Fri, 30 Aug 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InXdFK+l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922501ACE1C
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725015872; cv=none; b=qKxNL0O8/83QWQZ0NDY3mWZqYfudHHmLtpk4EHdNcpPVUwJjMP5e2LZOS0xEHX/pn2qkWG4Zotn37qrO42KM35otafuystgs2t2WmQuQmE3Bq0tAE82J2H6cMfPISGuqf0AcygQ/EY/+Mexm0KeZhPfMXl65+zHVqoNlhpcX1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725015872; c=relaxed/simple;
	bh=vlImN/zjcHkaVlnc1Gd/cx7iCmRUF86WxTRFiha//TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqNSEQ8F0+Y6jFTyjuKxBnLkYvn6kEQ8uUKOEn4+FgBvocieSr3nKgKeVTGLoFuWI+9wGxXKlGOlN5PhP3MCwpXDn0VsYjrs6yQMvZof9hmVktnuBaexqYlFhXtLBLlvKJaEhuy2y0uS9xH4e+EME3UnsdIe2ORc4avAY+Ojyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InXdFK+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F34C4CEC4;
	Fri, 30 Aug 2024 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725015872;
	bh=vlImN/zjcHkaVlnc1Gd/cx7iCmRUF86WxTRFiha//TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=InXdFK+lJpSnH5N5dMkeaVgapjpArFoGSTv/qpTTzxfMFtXza3SaHjZnPVrUuX5Od
	 bNYrOp3HboYlVB4vULPl5CqRj4utclQNu3uS+LTHoBOlOjvTzydbHjVN5cyqsRgdYp
	 WrnnL3mdqwHosRqf4w40slzRO16YHPiCXzEnxC9gP6iQZ1x5kD1hhjoQkSsyr1R0Mn
	 R5//Kbw0R1DlVznw+0n19Nlsq7e98dZ8pjSLmgMCo7IwpwKKsAMB+wYj1W+IN+0Qvb
	 UeRWeORNi8fj75A4eg8xKbL5Accd/Dev6soM/Lw9LG3zZb59UVOt6yYJ8OseJaZO6U
	 TiLNH+KBDCy2Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 07/11] sched_ext: Move sanity check and dsq_mod_nr() into task_unlink_from_dsq()
Date: Fri, 30 Aug 2024 01:03:51 -1000
Message-ID: <20240830110415.116090-8-tj@kernel.org>
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

All task_unlink_from_dsq() users are doing dsq_mod_nr(dsq, -1). Move it into
task_unlink_from_dsq(). Also move sanity check into it.

No functional changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 620cc0586c4b..9befa2bd1eb0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1641,6 +1641,8 @@ static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
 static void task_unlink_from_dsq(struct task_struct *p,
 				 struct scx_dispatch_q *dsq)
 {
+	WARN_ON_ONCE(list_empty(&p->scx.dsq_list.node));
+
 	if (p->scx.dsq_flags & SCX_TASK_DSQ_ON_PRIQ) {
 		rb_erase(&p->scx.dsq_priq, &dsq->priq);
 		RB_CLEAR_NODE(&p->scx.dsq_priq);
@@ -1648,6 +1650,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 	}
 
 	list_del_init(&p->scx.dsq_list.node);
+	dsq_mod_nr(dsq, -1);
 }
 
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
@@ -1684,9 +1687,7 @@ static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
 	*/
 	if (p->scx.holding_cpu < 0) {
 		/* @p must still be on @dsq, dequeue */
-		WARN_ON_ONCE(list_empty(&p->scx.dsq_list.node));
 		task_unlink_from_dsq(p, dsq);
-		dsq_mod_nr(dsq, -1);
 	} else {
 		/*
 		 * We're racing against dispatch_to_local_dsq() which already
@@ -2148,7 +2149,6 @@ static void consume_local_task(struct task_struct *p,
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 	task_unlink_from_dsq(p, dsq);
 	list_add_tail(&p->scx.dsq_list.node, &rq->scx.local_dsq.list);
-	dsq_mod_nr(dsq, -1);
 	dsq_mod_nr(&rq->scx.local_dsq, 1);
 	p->scx.dsq = &rq->scx.local_dsq;
 	raw_spin_unlock(&dsq->lock);
@@ -2238,7 +2238,6 @@ static bool unlink_dsq_and_lock_task_rq(struct task_struct *p,
 
 	WARN_ON_ONCE(p->scx.holding_cpu >= 0);
 	task_unlink_from_dsq(p, dsq);
-	dsq_mod_nr(dsq, -1);
 	p->scx.holding_cpu = cpu;
 
 	raw_spin_unlock(&dsq->lock);
-- 
2.46.0



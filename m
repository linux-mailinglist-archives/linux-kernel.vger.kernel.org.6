Return-Path: <linux-kernel+bounces-289479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C856995469F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5716D1F2308A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD418FDCB;
	Fri, 16 Aug 2024 10:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gy5j7pjp"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C4C157A41
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803511; cv=none; b=sA1zTPZ6CXV2tYUX+XIAQPi5+FjryANzxzXUf8H2rYs5Pulvick69M7459U852CYPa1SkGCnjxl2KxPLEDoThty90aRw/3lLw9ueTmm6d1BYviIBFgkLQc6vRLIn9t9jSNdY/2z9dnSSBsB6CP1JiUQrGLDQ21lYZB5qP+8WeLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803511; c=relaxed/simple;
	bh=854Tc/VZ1d5O2o/2BCOPI9sWwhMD/3ZPsWf/nkvDZQo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C8UScSnaezVjrNZCamgkpLO2haqvTpBGV0SHO+pm4JqnZIxMg9tjKNI7e3BGASczhoGmF7wieXPhIKtiF+moOQWYsgLII1fPF4En3bCZi7KQGjkjgonHrtSXyo5p6RhU+iDatAM2rDosEN0UdL+aigoHxCiAhGCnekXdGMJf5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gy5j7pjp; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723803500; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=XMCnFkKAqlubyvb/UouIBjEW4PW/jdwjHj5LzFnSFGw=;
	b=gy5j7pjpPtISwzoAG2oPByhoCauyXYHFTSHmRTYg8G+jLO6ft9Z+mRlWzEAnJZP+Eb4bNZauuPvRpBqYZaCktAb01bUpOlMUeBD1NBf0FVtP8Ak9YKaM6zldqzSSjEXHRF+19PU0xS6Gamrojv+prxn4zoG9gxhl9g3wlnHiPbc=
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0WD-4XeO_1723803459)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 18:18:19 +0800
From: Peng Wang <rocking@linux.alibaba.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sched/eevdf: Improve the clarity of the lag-based placement comments
Date: Fri, 16 Aug 2024 18:17:30 +0800
Message-Id: <4c99af2c8d9b35ccdab66163c3ac256e3e95d5c0.1723802710.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the original comments, the derivation starts with preserving v_i to
calculate V' and uses the equation v_i = V - vl_i. However, tasks might
have migrated from other queues, which means that the relationship with
this queue's V does not necessarily hold.

The new derivation is based on keeping vl_i unchanged and derives from the
post-enqueue perspective, thereby avoiding the previous assumption.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 kernel/sched/fair.c | 56 +++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..2bfae2ca2bb6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5196,56 +5196,38 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		lag = se->vlag;
 
 		/*
-		 * If we want to place a task and preserve lag, we have to
+		 * If we want to place a task i and preserve lag, we have to
 		 * consider the effect of the new entity on the weighted
 		 * average and compensate for this, otherwise lag can quickly
 		 * evaporate.
 		 *
-		 * Lag is defined as:
+		 *		Avg-Load    VRuntime    Avg-VRuntime	Vlag
+		 *	before	  W	    v_i		  V		vl_i
+		 *	after	  W+w_i	    v_i'	  V'		vl_i
 		 *
-		 *   lag_i = S - s_i = w_i * (V - v_i)
+		 * We want to preserve lag, so vl_i wil not change:
 		 *
-		 * To avoid the 'w_i' term all over the place, we only track
-		 * the virtual lag:
+		 *   vl_i = V' - v_i'
+		 *   ==> v_i' = V' - vl_i			(1)
 		 *
-		 *   vl_i = V - v_i <=> v_i = V - vl_i
+		 * We take V' to be the weighted average of all v'
 		 *
-		 * And we take V to be the weighted average of all v:
+		 *   V' = (W*V + w_i*v_i') / (W + w_i)
+		 *   ==> (W + w_i)*V' = W*V + w_i*v_i'		(2)
 		 *
-		 *   V = (\Sum w_j*v_j) / W
+		 * by using (1) & (2) we obtain:
 		 *
-		 * Where W is: \Sum w_j
+		 *   (W + w_i)*V' = W*V + w_i*(V' - vl_i)
+		 *   ==>     W*V' = W*V -w_i*vl_i
+		 *   ==>       V' = V - w_i*vl_i/W		(3)
 		 *
-		 * Then, the weighted average after adding an entity with lag
-		 * vl_i is given by:
+		 * by using (1) & (3) we obtain:
 		 *
-		 *   V' = (\Sum w_j*v_j + w_i*v_i) / (W + w_i)
-		 *      = (W*V + w_i*(V - vl_i)) / (W + w_i)
-		 *      = (W*V + w_i*V - w_i*vl_i) / (W + w_i)
-		 *      = (V*(W + w_i) - w_i*l) / (W + w_i)
-		 *      = V - w_i*vl_i / (W + w_i)
+		 *   v_i' = V - w_i*vl_i/W - vl_i
+		 *        = V - (w_i*vl_i/W + vl_i)
+		 *        = V - (w_i*vl_i + W*vl_i)/W
+		 *        = V - vl_i*(w_i + W)/W
 		 *
-		 * And the actual lag after adding an entity with vl_i is:
-		 *
-		 *   vl'_i = V' - v_i
-		 *         = V - w_i*vl_i / (W + w_i) - (V - vl_i)
-		 *         = vl_i - w_i*vl_i / (W + w_i)
-		 *
-		 * Which is strictly less than vl_i. So in order to preserve lag
-		 * we should inflate the lag before placement such that the
-		 * effective lag after placement comes out right.
-		 *
-		 * As such, invert the above relation for vl'_i to get the vl_i
-		 * we need to use such that the lag after placement is the lag
-		 * we computed before dequeue.
-		 *
-		 *   vl'_i = vl_i - w_i*vl_i / (W + w_i)
-		 *         = ((W + w_i)*vl_i - w_i*vl_i) / (W + w_i)
-		 *
-		 *   (W + w_i)*vl'_i = (W + w_i)*vl_i - w_i*vl_i
-		 *                   = W*vl_i
-		 *
-		 *   vl_i = (W + w_i)*vl'_i / W
 		 */
 		load = cfs_rq->avg_load;
 		if (curr && curr->on_rq)
-- 
2.27.0



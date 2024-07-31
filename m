Return-Path: <linux-kernel+bounces-268374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE59423D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88D841C231C3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B72812E5D;
	Wed, 31 Jul 2024 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhXV8rkt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3FE8BE0
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385836; cv=none; b=WAZmXy8vdU+eEnPBlCEmV09kVgFVDt1UIk/U3jSKDSCFI5GZPCKtiyMz3B9IDd3VladelrA2Pfg4wNhlk7tbmBRd8sLXXD/mTf924cWzKogqVgSANx0MJI348Rpq0/gqSSubXjAm/Mnufktei/OHr89o6D7kmmuriSk2u8aHnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385836; c=relaxed/simple;
	bh=ND0M1O/b09cO9CGWjH0eDAueXMZa8J6c/uYozl9G1ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPvxtog8qRbN6rMuz/0bDzHdXkHVdJ/JpTKwSIrY04PgFnFzTGQjA7JPRgKz0IPGbPzT8U+VNegLTSxqfjgD75+V3C8ncEjQN+kGJ+4Y5ZjQZUf/uWC/m6s8QnYbOh5K/yrCURX6AAJiURRxskYcY47R75+GBW0XA35g9XpVbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhXV8rkt; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722385835; x=1753921835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ND0M1O/b09cO9CGWjH0eDAueXMZa8J6c/uYozl9G1ZY=;
  b=MhXV8rktYDHl2rMnVQyNQFG8rVQrTzrJpYlDH5etrMMM4+WMtJJkRr2o
   DFYreXskZET1PhZtSw0iTaz6XCW97Jphdfdzuf9abCEeBYvWjTcAtJnKT
   +g+1t5cWhNEcppFrKINNErpqiqe0O5gNxt3ka9TdVs7pi1q73oWLn/A4j
   Bkga8Y2aRMotBJoR+cwtDyVag24fNHPopUL0ScO2iYKJJ17YjlYbtdg/S
   w/rnEIYRU0XxoXPzLup451sxLsTAr2fpJzzJSwyxdFA9D1AFtmsXwbL4a
   VakUjvaVp3g3bW9BuhKAvi2sYTySMYuwp8D9ySEV53Jv5Te6OkRZFa0Gm
   Q==;
X-CSE-ConnectionGUID: 8QFR4x+HSKSfPVXpkkpONQ==
X-CSE-MsgGUID: UzD79jBGQPOu7qPg/6HyaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="23156099"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="23156099"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:31 -0700
X-CSE-ConnectionGUID: jsP8RgPXRo6BK5inw1iByA==
X-CSE-MsgGUID: SKrLtFNsQsqF3bG5sjq9xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="77781801"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v2 5/5] drm/xe: Drop GuC submit_wq pool
Date: Tue, 30 Jul 2024 17:31:19 -0700
Message-Id: <20240731003119.2422940-6-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731003119.2422940-1-matthew.brost@intel.com>
References: <20240731003119.2422940-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that drm sched uses a single lockdep map for all submit_wq, drop the
GuC submit_wq pool hack.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_submit.c | 60 +-----------------------------
 drivers/gpu/drm/xe/xe_guc_types.h  |  7 ----
 2 files changed, 1 insertion(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_submit.c b/drivers/gpu/drm/xe/xe_guc_submit.c
index 460808507947..882cef3a10dc 100644
--- a/drivers/gpu/drm/xe/xe_guc_submit.c
+++ b/drivers/gpu/drm/xe/xe_guc_submit.c
@@ -224,64 +224,11 @@ static bool exec_queue_killed_or_banned_or_wedged(struct xe_exec_queue *q)
 		 EXEC_QUEUE_STATE_BANNED));
 }
 
-#ifdef CONFIG_PROVE_LOCKING
-static int alloc_submit_wq(struct xe_guc *guc)
-{
-	int i;
-
-	for (i = 0; i < NUM_SUBMIT_WQ; ++i) {
-		guc->submission_state.submit_wq_pool[i] =
-			alloc_ordered_workqueue("submit_wq", 0);
-		if (!guc->submission_state.submit_wq_pool[i])
-			goto err_free;
-	}
-
-	return 0;
-
-err_free:
-	while (i)
-		destroy_workqueue(guc->submission_state.submit_wq_pool[--i]);
-
-	return -ENOMEM;
-}
-
-static void free_submit_wq(struct xe_guc *guc)
-{
-	int i;
-
-	for (i = 0; i < NUM_SUBMIT_WQ; ++i)
-		destroy_workqueue(guc->submission_state.submit_wq_pool[i]);
-}
-
-static struct workqueue_struct *get_submit_wq(struct xe_guc *guc)
-{
-	int idx = guc->submission_state.submit_wq_idx++ % NUM_SUBMIT_WQ;
-
-	return guc->submission_state.submit_wq_pool[idx];
-}
-#else
-static int alloc_submit_wq(struct xe_guc *guc)
-{
-	return 0;
-}
-
-static void free_submit_wq(struct xe_guc *guc)
-{
-
-}
-
-static struct workqueue_struct *get_submit_wq(struct xe_guc *guc)
-{
-	return NULL;
-}
-#endif
-
 static void guc_submit_fini(struct drm_device *drm, void *arg)
 {
 	struct xe_guc *guc = arg;
 
 	xa_destroy(&guc->submission_state.exec_queue_lookup);
-	free_submit_wq(guc);
 }
 
 static void guc_submit_wedged_fini(struct drm_device *drm, void *arg)
@@ -337,10 +284,6 @@ int xe_guc_submit_init(struct xe_guc *guc, unsigned int num_ids)
 	if (err)
 		return err;
 
-	err = alloc_submit_wq(guc);
-	if (err)
-		return err;
-
 	gt->exec_queue_ops = &guc_exec_queue_ops;
 
 	xa_init(&guc->submission_state.exec_queue_lookup);
@@ -1445,8 +1388,7 @@ static int guc_exec_queue_init(struct xe_exec_queue *q)
 	timeout = (q->vm && xe_vm_in_lr_mode(q->vm)) ? MAX_SCHEDULE_TIMEOUT :
 		  msecs_to_jiffies(q->sched_props.job_timeout_ms);
 	err = xe_sched_init(&ge->sched, &drm_sched_ops, &xe_sched_ops,
-			    get_submit_wq(guc),
-			    q->lrc[0]->ring.size / MAX_JOB_SIZE_BYTES, 64,
+			    NULL, q->lrc[0]->ring.size / MAX_JOB_SIZE_BYTES, 64,
 			    timeout, guc_to_gt(guc)->ordered_wq, NULL,
 			    q->name, gt_to_xe(q->gt)->drm.dev);
 	if (err)
diff --git a/drivers/gpu/drm/xe/xe_guc_types.h b/drivers/gpu/drm/xe/xe_guc_types.h
index 546ac6350a31..585f5c274f09 100644
--- a/drivers/gpu/drm/xe/xe_guc_types.h
+++ b/drivers/gpu/drm/xe/xe_guc_types.h
@@ -72,13 +72,6 @@ struct xe_guc {
 		atomic_t stopped;
 		/** @submission_state.lock: protects submission state */
 		struct mutex lock;
-#ifdef CONFIG_PROVE_LOCKING
-#define NUM_SUBMIT_WQ	256
-		/** @submission_state.submit_wq_pool: submission ordered workqueues pool */
-		struct workqueue_struct *submit_wq_pool[NUM_SUBMIT_WQ];
-		/** @submission_state.submit_wq_idx: submission ordered workqueue index */
-		int submit_wq_idx;
-#endif
 		/** @submission_state.enabled: submission is enabled */
 		bool enabled;
 	} submission_state;
-- 
2.34.1



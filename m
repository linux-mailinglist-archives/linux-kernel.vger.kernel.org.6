Return-Path: <linux-kernel+bounces-281608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E3994D8BC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C777283674
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 22:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AEB16D9C3;
	Fri,  9 Aug 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TlyzpZVh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2B16C87C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242470; cv=none; b=Tt+5J5xntelJelsFQ6zq8eLthDEQ+l2wcSMaCqEl/PsbUBmLQ/rgRYLOsaYdgBUWdvjHAmuiaHwL6Or42uwAmmicvM15aUa85+EmzYX2erUIh7etWOiB3M4nW93fksTvGCFss+sdvhHDVH6sda9Uizl30NzZShmrmtYJIURXfPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242470; c=relaxed/simple;
	bh=ND0M1O/b09cO9CGWjH0eDAueXMZa8J6c/uYozl9G1ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtPZOYm0JUabAVO5eGH87/HH/Y5G/xElNBOxuHMffxFsc7PeLsT0Ebx//TI47ih6lXzR9IJUhfVylQzlUKpoi9IHsAoodaOWQfIxxsEBa6Tj2X8tIcV9exLnD8Gby8yDvyPQHtdYNeQSojWBo+PaQ/0wCsdD05SGamvSQXFh5uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TlyzpZVh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723242469; x=1754778469;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ND0M1O/b09cO9CGWjH0eDAueXMZa8J6c/uYozl9G1ZY=;
  b=TlyzpZVhnlM+/soAFMAIAhSJdI0wmNeDdnnOS61oWLHKGtVcE6VclXv/
   vsKcebKI628dm07lqaOULKbsS01HVt2DVsqlhZeNo23FMMNGLsz4xP8+/
   r5PQVLE5EX3p+yLyAnjScbINq1vvDr7XGuiNOFsdxJZTgaArptdjOwaPq
   StUIIqN5ERRHcB0zIOFnTPxMiX2sJYhxskrsHOyKPhqFn6gqwjUJjGjzl
   t3vC/47u9niRbNYiLweGt5RTAtcEMuJ8k4O12nmYpVyqkLCXL10tTm8qJ
   sjm2aoXk4hwopoRVUOhja/5uUxQszFdPXDWGajP7eS0357S2e4SAYZGTU
   g==;
X-CSE-ConnectionGUID: iTrGtzDUS46qMsQmEVq8QQ==
X-CSE-MsgGUID: OyhXeE+7TbCM13DDbS+CWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11159"; a="25229665"
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="25229665"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
X-CSE-ConnectionGUID: yRHSFi7BSbGkYELLDEK/cg==
X-CSE-MsgGUID: EgBTSnGNTRGaGrfbQGCDLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,277,1716274800"; 
   d="scan'208";a="62641786"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 15:27:43 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v3 5/5] drm/xe: Drop GuC submit_wq pool
Date: Fri,  9 Aug 2024 15:28:27 -0700
Message-Id: <20240809222827.3211998-6-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809222827.3211998-1-matthew.brost@intel.com>
References: <20240809222827.3211998-1-matthew.brost@intel.com>
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



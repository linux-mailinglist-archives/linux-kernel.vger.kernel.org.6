Return-Path: <linux-kernel+bounces-268280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04ECB9422A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED2E1C224EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB7A191F7A;
	Tue, 30 Jul 2024 22:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Spv8JYtT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19A191484
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 22:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377821; cv=none; b=uPfMRzEm1cbTBHaq9l8ff+qr4RlG+vvcNYH+67Pv2/yHZeliH/b4zPLxcP9v5SE81tuOWtXI1e9fGMdsTXs2stEe50adDN955EEGlgP6pN0DdYqPsywMlcQP/6eS3/SY0nHd+y3yl2FokE3JNqsXBzzZt1XFLYY+f3bzhujsSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377821; c=relaxed/simple;
	bh=ND0M1O/b09cO9CGWjH0eDAueXMZa8J6c/uYozl9G1ZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nUcezfCd1CwMA8LauStXWjFpqcdcjbNBzEMenVE8zb/HuBVDn9IhjM/BUwV7nsDG1DftY/hv2TgB4qojURY1sFDuHTEPYKVb5DFa1alkQ+f1Tp4A/07frkL1QQOElKYmQLAWYKZEKUMaMC4gfbn+ynnWAhVczRy+FK//lb4pnqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Spv8JYtT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722377819; x=1753913819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ND0M1O/b09cO9CGWjH0eDAueXMZa8J6c/uYozl9G1ZY=;
  b=Spv8JYtTdZ80OBXBdPUgD24xrdw3J6HNm+1sRxBkJEh8FCx41mAqneFw
   Mggfa2jREyOJ5+zN+HeV2hXirZt23XQa77+lxFkYuMSHT8BQp/ri7JvDH
   MkxW2zB/tQOzHCfco/iU2xg3/8B395FACH2tFZaqMCRe26C6BDSKII9ZB
   MdlR6BpkuHtA5BR+YiBcWxug/lte0tJGDFDWxa6YEV72qmtVtYCm5wOqR
   w1m3zaNxxlw0MFucz/FRaHcgpIFyp+RvqaW19SyNZ99JMp6Crz8c2vTnt
   YfrA/5AAKySkVKkcywV8H1qIw1IwVGO/IrAnA+fMhLwK1JyUNXL9lHaMz
   w==;
X-CSE-ConnectionGUID: 5V26OP1uSUaL/74ZtI9fug==
X-CSE-MsgGUID: FcpkaAsdSb+vZbG0x0x17Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="24094135"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24094135"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 15:16:55 -0700
X-CSE-ConnectionGUID: 7WxHhnR9TaueAGKqB2JvwA==
X-CSE-MsgGUID: pNpF4eF7S02MYcejiLF95Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="58613347"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 15:16:56 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [RFC PATCH 3/3] drm/xe: Drop GuC submit_wq pool
Date: Tue, 30 Jul 2024 15:17:42 -0700
Message-Id: <20240730221742.2248527-4-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730221742.2248527-1-matthew.brost@intel.com>
References: <20240730221742.2248527-1-matthew.brost@intel.com>
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



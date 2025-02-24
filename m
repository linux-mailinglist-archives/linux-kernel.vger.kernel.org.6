Return-Path: <linux-kernel+bounces-528956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25088A41E66
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C6A162479
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AE623BD16;
	Mon, 24 Feb 2025 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6dKQYHt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61092192F4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398486; cv=none; b=ab/yX4ggpNem/+i6x6gLs3E6xDrCa2mEUUJkaFuyWoItAjtwDKKh2t9b+IQkmkMcUtlVSqwAyJA0yCc9iKOzoModsmP9JCRx2v+LlvuUlUn6BzBmJhBiA8nSe8c+Mltw1tJEEeB04b9rxGDFfTXMx3Ya3tDoiVrsxvuwDOkc7K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398486; c=relaxed/simple;
	bh=+Uxhx1xGTovyycqe8ouVh7sgRJBt25e6QRniKx2bUmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bg/N4VXxh5BRAKMiNEfeEHptr0TFuESuMo8lliUd9i9JcLuR7FKSYaCebCxFN6IySBWGA2JfPwP2yvpycKEbDjil02FFzvbEoVQ2QkM3xWBPqtqG0NCtmVkTihkk6vjIWbaLVmg4aNNCHOlaZBUUe784ts/WieHz9IC085N49zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6dKQYHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC689C4CEE9;
	Mon, 24 Feb 2025 12:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398485;
	bh=+Uxhx1xGTovyycqe8ouVh7sgRJBt25e6QRniKx2bUmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6dKQYHtxTePq/dRC+AezFipPw6sLMRD6Q+EXeAK3mGa+Dl4spUImaYLkOyvlk5hT
	 /M0gApa3ssZjqKx5aATb+948bnu3Zse85Im7zcn8tzLNle/xwNki2j9QL8vnoX6umf
	 8neRN0HFHAT+0bT/VXzQ+R7JagTetd0QHzESpjn48cI9SWMR/yWm9TloZ2UrKaB2Fl
	 jBeqZfHbs3wIk7YJ1+SkEnkiuzGMDxul3ikhDzW0mT+2TkKCxBCzjrqiUqX5AfAmc8
	 HU7+NAsAL9YQtnZ3zfB+HE04ZJcMoc++BnF6S6teGUvxOomOUQeDDdXi4tebCxRNdE
	 /CG73GO7RSATw==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] drm/sched: Adjust outdated docu for run_job()
Date: Mon, 24 Feb 2025 13:01:03 +0100
Message-ID: <20250224120104.26211-3-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224120104.26211-2-phasta@kernel.org>
References: <20250224120104.26211-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for drm_sched_backend_ops.run_job() mentions a certain
function called drm_sched_job_recovery(). This function does not exist.
What's actually meant is drm_sched_resubmit_jobs(), which is by now also
deprecated.

Remove the mention of the removed function.

Discourage the behavior of drm_sched_backend_ops.run_job() being called
multiple times for the same job.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 include/drm/gpu_scheduler.h | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 6bf458dbce84..5d0394f40aae 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -420,10 +420,33 @@ struct drm_sched_backend_ops {
 					 struct drm_sched_entity *s_entity);
 
 	/**
-         * @run_job: Called to execute the job once all of the dependencies
-         * have been resolved.  This may be called multiple times, if
-	 * timedout_job() has happened and drm_sched_job_recovery()
-	 * decides to try it again.
+	 * @run_job: Called to execute the job once all of the dependencies
+	 * have been resolved.
+	 *
+	 * @sched_job: the job to run
+	 *
+	 * The deprecated drm_sched_resubmit_jobs() (called by
+	 * &drm_sched_backend_ops.timedout_job) can invoke this again with the
+	 * same parameters. Using this is discouraged because it, presumably,
+	 * violates dma_fence rules.
+	 *
+	 * TODO: Document which fence rules above.
+	 *
+	 * This method is called in a workqueue context - either from the
+	 * submit_wq the driver passed through drm_sched_init(), or, if the
+	 * driver passed NULL, a separate, ordered workqueue the scheduler
+	 * allocated.
+	 *
+	 * Note that the scheduler expects to 'inherit' its own reference to
+	 * this fence from the callback. It does not invoke an extra
+	 * dma_fence_get() on it. Consequently, this callback must take a
+	 * reference for the scheduler, and additional ones for the driver's
+	 * respective needs.
+	 *
+	 * Return:
+	 * * On success: dma_fence the driver must signal once the hardware has
+	 * completed the job ("hardware fence").
+	 * * On failure: NULL or an ERR_PTR.
 	 */
 	struct dma_fence *(*run_job)(struct drm_sched_job *sched_job);
 
-- 
2.48.1



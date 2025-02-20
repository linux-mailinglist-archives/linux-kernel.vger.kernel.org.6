Return-Path: <linux-kernel+bounces-523579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D365A3D8A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22823BF583
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178001F2B83;
	Thu, 20 Feb 2025 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="powKHjxj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E2C5223
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050906; cv=none; b=mpOswsOkXpklz0ZJkOa+Jj7qSZxAxA1nAiRZuES78Qhnb1EVjYoXjipZxcvSsx3M6RK8/N91ZevbFK5O0yoogneJPF6vnjpW68cf4WHao+T9HfbO0Q50zU/iK8PT1KYYmkizYHi+qygWc+3XQvh7NgfNd2sso/ArJPNJLWCZf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050906; c=relaxed/simple;
	bh=wHCQOUz8s89T92fB5TvJiqEYx/Hx0bOuLLu49+hLCDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSA0gFHhLHRlRyfa5PF0pO37ivF+5IjOpzUSn7gyg8CnGlMZ6T1lBal0Zzoqh3ImG7rS8gsoGMbHwP2dOtfm4Wc2K0FXNH4W6SF3YbYpHmbY62zqKptP+0WRAM45e4TU8iQr9gtgw01CYb2Y3gSqMUT86Mzro44VnGKjyALTrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=powKHjxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D2AC4CEE6;
	Thu, 20 Feb 2025 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050905;
	bh=wHCQOUz8s89T92fB5TvJiqEYx/Hx0bOuLLu49+hLCDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=powKHjxj93Pu/YE65INKj5tPPrmoZFdq8DTbgOKWMR29xCXpsqsqtqD+U624ZQ5AZ
	 aRh12hEq2tviZ6SoA0LnP1qujBnnmYZCRX1f3v/HLs5pggLo0Oqu0vkAMWLLDo7aWY
	 ml9gZips+OLf/jEmrxl1WEhsLC+ftmJwGfdNRmVUb++fgPwxJSY1t3Je2PEitavlsw
	 3JluyeNbSbN4ty+1vLKAvBQ2C6djiVL1z6bnMZPscE5UuYaaV8LYUSaK3kxqt4mpBR
	 7FpUlqrGLXLQSxAYqX+c3+J34N3R50qbdHandlaMLaKZqZCnZsg9L+yNwAB7YP3q31
	 BqDpxjX9AGRAQ==
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
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v5 1/3] drm/sched: Document run_job() refcount hazard
Date: Thu, 20 Feb 2025 12:28:12 +0100
Message-ID: <20250220112813.87992-3-phasta@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250220112813.87992-2-phasta@kernel.org>
References: <20250220112813.87992-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

drm_sched_backend_ops.run_job() returns a dma_fence for the scheduler.
That fence is signalled by the driver once the hardware completed the
associated job. The scheduler does not increment the reference count on
that fence, but implicitly expects to inherit this fence from run_job().

This is relatively subtle and prone to misunderstandings.

This implies that, to keep a reference for itself, a driver needs to
call dma_fence_get() in addition to dma_fence_init() in that callback.

It's further complicated by the fact that the scheduler even decrements
the refcount in drm_sched_run_job_work() since it created a new
reference in drm_sched_fence_scheduled(). It does, however, still use
its pointer to the fence after calling dma_fence_put() - which is safe
because of the aforementioned new reference, but actually still violates
the refcounting rules.

Move the call to dma_fence_put() to the position behind the last usage
of the fence.

Document the necessity to increment the reference count in
drm_sched_backend_ops.run_job().

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c |  5 ++---
 include/drm/gpu_scheduler.h            | 19 +++++++++++++++----
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 8c36a59afb72..02af3f89099d 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1222,15 +1222,14 @@ static void drm_sched_run_job_work(struct work_struct *w)
 	drm_sched_fence_scheduled(s_fence, fence);
 
 	if (!IS_ERR_OR_NULL(fence)) {
-		/* Drop for original kref_init of the fence */
-		dma_fence_put(fence);
-
 		r = dma_fence_add_callback(fence, &sched_job->cb,
 					   drm_sched_job_done_cb);
 		if (r == -ENOENT)
 			drm_sched_job_done(sched_job, fence->error);
 		else if (r)
 			DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n", r);
+
+		dma_fence_put(fence);
 	} else {
 		drm_sched_job_done(sched_job, IS_ERR(fence) ?
 				   PTR_ERR(fence) : 0);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 6bf458dbce84..916279b5aa00 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -420,10 +420,21 @@ struct drm_sched_backend_ops {
 					 struct drm_sched_entity *s_entity);
 
 	/**
-         * @run_job: Called to execute the job once all of the dependencies
-         * have been resolved.  This may be called multiple times, if
-	 * timedout_job() has happened and drm_sched_job_recovery()
-	 * decides to try it again.
+	 * @run_job: Called to execute the job once all of the dependencies
+	 * have been resolved. This may be called multiple times, if
+	 * timedout_job() has happened and drm_sched_job_recovery() decides to
+	 * try it again.
+	 *
+	 * @sched_job: the job to run
+	 *
+	 * Returns: dma_fence the driver must signal once the hardware has
+	 *	completed the job ("hardware fence").
+	 *
+	 * Note that the scheduler expects to 'inherit' its own reference to
+	 * this fence from the callback. It does not invoke an extra
+	 * dma_fence_get() on it. Consequently, this callback must take a
+	 * reference for the scheduler, and additional ones for the driver's
+	 * respective needs.
 	 */
 	struct dma_fence *(*run_job)(struct drm_sched_job *sched_job);
 
-- 
2.47.1



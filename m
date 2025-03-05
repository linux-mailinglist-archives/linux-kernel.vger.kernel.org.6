Return-Path: <linux-kernel+bounces-546860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08221A4FFAB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E8C1771E0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7125324BBF9;
	Wed,  5 Mar 2025 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSAr/Q0p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B824A070
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179965; cv=none; b=rKXC6zN0vbRBe//4wv6t1dn9VFidGQA2RG4uktGflbZNyMh1EPtwt/oQperL+GaR+pLsTW64uavzrq8lBXNyPlB3aord9j5EuUCPH1E8URrkQ0Zhay89ewT9f4HxpBvO+XWWeaFVGNOLG6kfcvywcmdEp88zVchNoYhVyoBR74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179965; c=relaxed/simple;
	bh=s9ST4+emcIcU6IvxekHRjVJTnRB1rgArxQeZs5dv/lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9fPc97UPMBUHN0u7FR32Rww/nD6Zu6iUs7Www4ETfAIZm3ww2fmHLrUjd14gT5XTSqbQtpgQfT085UyMXvyRMPNIbov8IAY+7ehEe8MRRQiP+GKFlyI3Q6RlnJLCCpKws33HvzPymOcjXSHbk3ivELghD7ZMmxObMMMFgWOK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSAr/Q0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BABBC4CEEA;
	Wed,  5 Mar 2025 13:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741179965;
	bh=s9ST4+emcIcU6IvxekHRjVJTnRB1rgArxQeZs5dv/lA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSAr/Q0pBfAR1NOqM9X7y8gIvBFuKdF4nPTlJcNTbHzobtgmuEOwOi/ppny0+5l9g
	 VDVrQhHvm9iN1eJlJAGBKXuJ/eLHRBXzPCurdzfB1kl3KmsqaiCFahOr4crecf77jd
	 61l9tvUQtuzrWKA1bCa9sFKYdKGal8dT2HnZIeLn/SrqalHOTOzjPhDHjv+36INNWR
	 rJ2omCO271m+vNjC2MNAKGFuf10tECiMqhyoFd5Pns+Z8K5kRuttp40Fw/OfexdNc8
	 /mAXeCzV14QDbWJuh32SXahw9muHUS85lqHURNrh9ppSeS14zwEqfHKMyrwLfxGmWL
	 Bx7gUkfPIG43A==
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
	Sumit Semwal <sumit.semwal@linaro.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/3] drm/sched: Adjust outdated docu for run_job()
Date: Wed,  5 Mar 2025 14:05:50 +0100
Message-ID: <20250305130551.136682-3-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305130551.136682-2-phasta@kernel.org>
References: <20250305130551.136682-2-phasta@kernel.org>
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

Furthermore, the scheduler expects to "inherit" a reference on the fence
from the run_job() callback. This, so far, is also not documented.

Remove the mention of the removed function.

Discourage the behavior of drm_sched_backend_ops.run_job() being called
multiple times for the same job.

Document the necessity of incrementing the refcount in run_job().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 include/drm/gpu_scheduler.h | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 50928a7ae98e..6381baae8024 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -410,10 +410,36 @@ struct drm_sched_backend_ops {
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
+	 * The deprecated drm_sched_resubmit_jobs() (called by &struct
+	 * drm_sched_backend_ops.timedout_job) can invoke this again with the
+	 * same parameters. Using this is discouraged because it violates
+	 * dma_fence rules, notably dma_fence_init() has to be called on
+	 * already initialized fences for a second time. Moreover, this is
+	 * dangerous because attempts to allocate memory might deadlock with
+	 * memory management code waiting for the reset to complete.
+	 *
+	 * TODO: Document what drivers should do / use instead.
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



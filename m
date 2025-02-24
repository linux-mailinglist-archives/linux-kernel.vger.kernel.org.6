Return-Path: <linux-kernel+bounces-528958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B8AA41E76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755FD7AC2F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2AA1863E;
	Mon, 24 Feb 2025 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTOw7fk4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DFC248872
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398491; cv=none; b=IEIZqN06iTW7omAUIIDlXsJWQZpVJSOac1CT0yHhzoaE0lSNuBb1UWaOVoIpJrdxpZTknG1CJRahVLlEgW2/4x70ilyulSBqwvOix2bx43sbhz30DfrMA1Y0KP+v6CXMB+n8B2+taIfFHDlZ7unbKq0ZwQAsSLnRdagpRVwzov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398491; c=relaxed/simple;
	bh=ksjrJsaXHGs+/qojuMnwn+tMZr0i67NGvRTZp6GNHqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHgZcbfT2O5s6ZBnz3hnatOz8mmuHFLyx8ySPwjrT85b2pr1tbl5d/+agnqQ3cbPmZXbw/G5KM16UbDhTUPqmepF3tMcghjkcnvJfxxuHkwKG2haxCIZn/CAmkFreqnfxSChFyA1hUHFkaXQW9DZfud0TicM+5SmM4FlqILNzw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTOw7fk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B71C4CED6;
	Mon, 24 Feb 2025 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398491;
	bh=ksjrJsaXHGs+/qojuMnwn+tMZr0i67NGvRTZp6GNHqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cTOw7fk4hlSaArImsvrN63uePusXG8VaGRYtat9pdX8JDcAES2ymC39qwH49ZkZTR
	 tTg5ZdcmySjzo9Y8MrRUZNS5TiL0K8wT7UIbstkw+6hP8Vb3hUVei/B+x5NEnKvNKm
	 ztHDkI/dDoTL82P2ftbBjVxXyPIMv/tuS4j+ygSIkJKSMeWTctvsg6EzNej1HhXOL+
	 tLiZn0xhJ6ulE2qVrYZnirh/Cy/8EV6vAMTWe7A/m6PNn0dSeEWG6uYXyjsnFp5pzl
	 TdYCkTf+59tsaCpM/2ys1UWH7zmt9/nOlwVmGBThbZS7kRcXiFCuVvIIHeG42mLzkM
	 PYMV+2LFgGn3Q==
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
Subject: [PATCH v6 3/3] drm/sched: Update timedout_job()'s documentation
Date: Mon, 24 Feb 2025 13:01:05 +0100
Message-ID: <20250224120104.26211-5-phasta@kernel.org>
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

drm_sched_backend_ops.timedout_job()'s documentation is outdated. It
mentions the deprecated function drm_sched_resubmit_job(). Furthermore,
it does not point out the important distinction between hardware and
firmware schedulers.

Since firmware schedulers tyipically only use one entity per scheduler,
timeout handling is significantly more simple because the entity the
faulted job came from can just be killed without affecting innocent
processes.

Update the documentation with that distinction and other details.

Reformat the docstring to work to a unified style with the other
handles.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 include/drm/gpu_scheduler.h | 78 ++++++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index c59a903deebe..f31c1032af45 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -393,8 +393,15 @@ static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
 	return s_job && atomic_inc_return(&s_job->karma) > threshold;
 }
 
+/**
+ * enum drm_gpu_sched_stat - the scheduler's status
+ *
+ * @DRM_GPU_SCHED_STAT_NONE: Reserved. Do not use.
+ * @DRM_GPU_SCHED_STAT_NOMINAL: Operation succeeded.
+ * @DRM_GPU_SCHED_STAT_ENODEV: Error: Device is not available anymore.
+ */
 enum drm_gpu_sched_stat {
-	DRM_GPU_SCHED_STAT_NONE, /* Reserve 0 */
+	DRM_GPU_SCHED_STAT_NONE,
 	DRM_GPU_SCHED_STAT_NOMINAL,
 	DRM_GPU_SCHED_STAT_ENODEV,
 };
@@ -455,43 +462,52 @@ struct drm_sched_backend_ops {
 	 * @timedout_job: Called when a job has taken too long to execute,
 	 * to trigger GPU recovery.
 	 *
-	 * This method is called in a workqueue context.
+	 * @sched_job: The job that has timed out
 	 *
-	 * Drivers typically issue a reset to recover from GPU hangs, and this
-	 * procedure usually follows the following workflow:
+	 * Drivers typically issue a reset to recover from GPU hangs.
+	 * This procedure looks very different depending on whether a firmware
+	 * or a hardware scheduler is being used.
 	 *
-	 * 1. Stop the scheduler using drm_sched_stop(). This will park the
-	 *    scheduler thread and cancel the timeout work, guaranteeing that
-	 *    nothing is queued while we reset the hardware queue
-	 * 2. Try to gracefully stop non-faulty jobs (optional)
-	 * 3. Issue a GPU reset (driver-specific)
-	 * 4. Re-submit jobs using drm_sched_resubmit_jobs()
-	 * 5. Restart the scheduler using drm_sched_start(). At that point, new
-	 *    jobs can be queued, and the scheduler thread is unblocked
+	 * For a FIRMWARE SCHEDULER, each ring has one scheduler, and each
+	 * scheduler has one entity. Hence, the steps taken typically look as
+	 * follows:
+	 *
+	 * 1. Stop the scheduler using drm_sched_stop(). This will pause the
+	 *    scheduler workqueues and cancel the timeout work, guaranteeing
+	 *    that nothing is queued while the ring is being removed.
+	 * 2. Remove the ring. The firmware will make sure that the
+	 *    corresponding parts of the hardware are resetted, and that other
+	 *    rings are not impacted.
+	 * 3. Kill the entity and the associated scheduler.
+	 *
+	 *
+	 * For a HARDWARE SCHEDULER, a scheduler instance schedules jobs from
+	 * one or more entities to one ring. This implies that all entities
+	 * associated with the affected scheduler cannot be torn down, because
+	 * this would effectively also affect innocent userspace processes which
+	 * did not submit faulty jobs (for example).
+	 *
+	 * Consequently, the procedure to recover with a hardware scheduler
+	 * should look like this:
+	 *
+	 * 1. Stop all schedulers impacted by the reset using drm_sched_stop().
+	 * 2. Kill the entity the faulty job stems from.
+	 * 3. Issue a GPU reset on all faulty rings (driver-specific).
+	 * 4. Re-submit jobs on all schedulers impacted by re-submitting them to
+	 *    the entities which are still alive.
+	 * 5. Restart all schedulers that were stopped in step #1 using
+	 *    drm_sched_start().
 	 *
 	 * Note that some GPUs have distinct hardware queues but need to reset
 	 * the GPU globally, which requires extra synchronization between the
-	 * timeout handler of the different &drm_gpu_scheduler. One way to
-	 * achieve this synchronization is to create an ordered workqueue
-	 * (using alloc_ordered_workqueue()) at the driver level, and pass this
-	 * queue to drm_sched_init(), to guarantee that timeout handlers are
-	 * executed sequentially. The above workflow needs to be slightly
-	 * adjusted in that case:
+	 * timeout handlers of different schedulers. One way to achieve this
+	 * synchronization is to create an ordered workqueue (using
+	 * alloc_ordered_workqueue()) at the driver level, and pass this queue
+	 * as drm_sched_init()'s @timeout_wq parameter. This will guarantee
+	 * that timeout handlers are executed sequentially.
 	 *
-	 * 1. Stop all schedulers impacted by the reset using drm_sched_stop()
-	 * 2. Try to gracefully stop non-faulty jobs on all queues impacted by
-	 *    the reset (optional)
-	 * 3. Issue a GPU reset on all faulty queues (driver-specific)
-	 * 4. Re-submit jobs on all schedulers impacted by the reset using
-	 *    drm_sched_resubmit_jobs()
-	 * 5. Restart all schedulers that were stopped in step #1 using
-	 *    drm_sched_start()
+	 * Return: The scheduler's status, defined by &drm_gpu_sched_stat
 	 *
-	 * Return DRM_GPU_SCHED_STAT_NOMINAL, when all is normal,
-	 * and the underlying driver has started or completed recovery.
-	 *
-	 * Return DRM_GPU_SCHED_STAT_ENODEV, if the device is no longer
-	 * available, i.e. has been unplugged.
 	 */
 	enum drm_gpu_sched_stat (*timedout_job)(struct drm_sched_job *sched_job);
 
-- 
2.48.1



Return-Path: <linux-kernel+bounces-574270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C3EA6E2EA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F39F171A7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2662673A5;
	Mon, 24 Mar 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e182ef8e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF126137B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842776; cv=none; b=JCjld54T6QsMIjcQmtqDP8QxXjZcaRt6piWIS0OD5hM0f0GIMhrDYHQFuCbym24oSf1z7d+u36jOAzTTa0YejRPE11CwhKD3P4P5BBN24Nw3mNlYP1e76K9XPbwG8mXBjb+eOm1XTJGUVONqI3PgT6Gzdhz+Xc3MvSHS3jXJhX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842776; c=relaxed/simple;
	bh=LNb2F2c8zejJK69+mIOoiRybsoWajBLMqCUkOY1Wo0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoOJxKjYn/WCYHUmO8P9XN8R5frd2FqWtOsw76nXNOY3NcrkutOeO3lL9GT9mUf3H7JI/l9Kru1zw3rt0WQD5HoVfP5pmytb1GDfVPrzQ6uc+//3082gEpAQ882DlhNzy1/00raQzjojYAtYKwMdQ5RrouIUN/xSCwrxnZn7yRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e182ef8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B32CC4CEDD;
	Mon, 24 Mar 2025 18:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742842774;
	bh=LNb2F2c8zejJK69+mIOoiRybsoWajBLMqCUkOY1Wo0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e182ef8ede+irYinDn6XTciN4Ex31PqrioQgd73OedFXW6CnCknDLmOJtTNynMg/e
	 lTR0qjVFMhS0c4RyEJ/pw1KDZmmO7KVLwfUI6pPXyeGixfxYPvj6xpdMRJbV5lofJ0
	 seWPT6drG7wpXKqUQkiipOO6Qh4iTdvEe3HlkboCD9hRv922rGjMcFjg4xfW0L0VMu
	 vKsuVcT7hzGJy1/Z6a5DIwBuGhRcPaQzXF62dCUwjPBueYBhSS7aJMh9oxhuVa6dmT
	 bS8B+J/+aevKaDQpBcMhHYNO93SCgllyqcZsO2Hxn42rWx3fI5Ut+ZZ1Zmm1myFqbS
	 3hcrG/+F4jeyg==
From: Philipp Stanner <phasta@kernel.org>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [RFC PATCH 2/5] drm/sched: Prevent teardown waitque from blocking too long
Date: Mon, 24 Mar 2025 19:57:26 +0100
Message-ID: <20250324185728.45857-4-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324185728.45857-2-phasta@kernel.org>
References: <20250324185728.45857-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The waitqueue that ensures that drm_sched_fini() blocks until the
pending_list has become empty could theoretically cause that function to
block for a very long time. That, ultimately, could block userspace
procesess and prevent them from being killable through SIGKILL.

When a driver calls drm_sched_fini(), it is safe to assume that all
still pending jobs are not needed anymore anyways. Thus, they can be
cancelled and thereby it can be ensured that drm_sched_fini() will
return relatively quickly.

Implement a new helper to stop all work items / submission except for
the drm_sched_backend_ops.run_job().

Implement a driver callback, kill_fence_context(), that instructs the
driver to kill the fence context associated with this scheduler, thereby
causing all pending hardware fences to be signalled.

Call those new routines in drm_sched_fini() and ensure backwards
compatibility if the new callback is not implemented.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 47 +++++++++++++++++---------
 include/drm/gpu_scheduler.h            | 11 ++++++
 2 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c1ab48ef61cf..87acbcb1a821 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1388,31 +1388,46 @@ drm_sched_no_jobs_pending(struct drm_gpu_scheduler *sched)
 	return empty;
 }
 
+/**
+ * drm_sched_cancel_jobs_and_wait - trigger freeing of all pending jobs
+ * @sched: scheduler instance
+ *
+ * Must only be called if &struct drm_sched_backend_ops.kill_fence_context is
+ * implemented.
+ *
+ * Instructs the driver to kill the fence context associated with this scheduler,
+ * thereby signalling all pending fences. This, in turn, will trigger
+ * &struct drm_sched_backend_ops.free_job to be called for all pending jobs.
+ * The function then blocks until all pending jobs have been freed.
+ */
+static inline void
+drm_sched_cancel_jobs_and_wait(struct drm_gpu_scheduler *sched)
+{
+	sched->ops->kill_fence_context(sched);
+	wait_event(sched->pending_list_waitque, drm_sched_no_jobs_pending(sched));
+}
+
 /**
  * drm_sched_fini - Destroy a gpu scheduler
  *
  * @sched: scheduler instance
  *
- * Tears down and cleans up the scheduler.
- *
- * Note that this function blocks until all the fences returned by
- * &struct drm_sched_backend_ops.run_job have been signalled.
+ * Tears down and cleans up the scheduler. Might leak memory if
+ * &struct drm_sched_backend_ops.kill_fence_context is not implemented.
  */
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
 	struct drm_sched_entity *s_entity;
 	int i;
 
-	/*
-	 * Jobs that have neither been scheduled or which have timed out are
-	 * gone by now, but jobs that have been submitted through
-	 * backend_ops.run_job() and have not yet terminated are still pending.
-	 *
-	 * Wait for the pending_list to become empty to avoid leaking those jobs.
-	 */
-	drm_sched_submission_and_timeout_stop(sched);
-	wait_event(sched->pending_list_waitque, drm_sched_no_jobs_pending(sched));
-	drm_sched_free_stop(sched);
+	if (sched->ops->kill_fence_context) {
+		drm_sched_submission_and_timeout_stop(sched);
+		drm_sched_cancel_jobs_and_wait(sched);
+		drm_sched_free_stop(sched);
+	} else {
+		/* We're in "legacy free-mode" and ignore potential mem leaks */
+		drm_sched_wqueue_stop(sched);
+	}
 
 	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
 		struct drm_sched_rq *rq = sched->sched_rq[i];
@@ -1500,7 +1515,7 @@ bool drm_sched_wqueue_ready(struct drm_gpu_scheduler *sched)
 EXPORT_SYMBOL(drm_sched_wqueue_ready);
 
 /**
- * drm_sched_wqueue_stop - stop scheduler submission
+ * drm_sched_wqueue_stop - stop scheduler submission and freeing
  * @sched: scheduler instance
  *
  * Stops the scheduler from pulling new jobs from entities. It also stops
@@ -1516,7 +1531,7 @@ void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched)
 EXPORT_SYMBOL(drm_sched_wqueue_stop);
 
 /**
- * drm_sched_wqueue_start - start scheduler submission
+ * drm_sched_wqueue_start - start scheduler submission and freeing
  * @sched: scheduler instance
  *
  * Restarts the scheduler after drm_sched_wqueue_stop() has stopped it.
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index badcf9ea4501..e13eb7e4c93a 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -509,6 +509,17 @@ struct drm_sched_backend_ops {
          * and it's time to clean it up.
 	 */
 	void (*free_job)(struct drm_sched_job *sched_job);
+
+	/**
+	 * @kill_fence_context: kill the fence context belonging to this scheduler
+	 *
+	 * Needed to cleanly tear the scheduler down in drm_sched_fini(). This
+	 * callback will cause all hardware fences to be signalled by the driver,
+	 * which, ultimately, ensures that all jobs get freed before teardown.
+	 *
+	 * This callback is optional, but it is highly recommended to implement it.
+	 */
+	void (*kill_fence_context)(struct drm_gpu_scheduler *sched);
 };
 
 /**
-- 
2.48.1



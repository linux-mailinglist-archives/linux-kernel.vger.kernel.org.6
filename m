Return-Path: <linux-kernel+bounces-574269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C506A6E2E0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8655170443
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC997266F01;
	Mon, 24 Mar 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR0Mq8QL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2026137B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842771; cv=none; b=FgE5bOStq96n+Lz9pHpOYo32bfgHiio9ZT700+sVkSdteYA36R5pblqx5P0AMg/zofRlbtfjFRFokGcNTZD8jU9gCgo1CFTQGRIAwYABeaPkB5WIqFk8Yuwi3EwfmGYG67WPEU94j9F9O5wQDMN7G02t7hUd9Lp68k6RGZynLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842771; c=relaxed/simple;
	bh=DNWUEy0AwswO/8irYrxLdpr2c6TuEDEyDdVtB7RXVL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGRoHG9TetdIRiVAfI9WkOwbWSrZVNwqEEHuTr/nLihqGH1es/c03/Q+vImWLr4zrndhoZSQU/KmhVa5HeXcKXm1hNTBuXlumnGpBXNlpR5SV8beRaM2TBN/boQ7b39S+YuaHDjjeo9tXJ6/ScLkw+VHpYWB/hnR0fcVSMuPIBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR0Mq8QL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A27C4CEED;
	Mon, 24 Mar 2025 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742842770;
	bh=DNWUEy0AwswO/8irYrxLdpr2c6TuEDEyDdVtB7RXVL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CR0Mq8QLqbfCYz+/LXSBKbKnfDEE36w5PrRJLTDBQ4ppYa3NS52Dn9DqqAk7tTzOg
	 t0CUrvaLV4BiUVuQwASFQlGwB+hHVru8JeR5vu0Srq6w54sQLD7mBQ8G3D+X9QmCyl
	 XL7XTxVLNMQU4W8wApu1qVt1fy6ZryiCwui5iykKYwRVCEKpUgFWQwCrWIoRPQbEh1
	 WF5S+UCxw2UNo5YGsYnSfeuMASvABFMc9FZZ9c1F8scwS3k1v2q4zsnnQukypP6+tm
	 jwsEBqmF6VFjartvvNRK1S3mvnbn/hHa0UhM9ACJvxWwQqyRqDO0AxMCrC+/se+/w9
	 fTjCbqwssdnsg==
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
	Philipp Stanner <pstanner@redhat.com>
Subject: [RFC PATCH 1/5] drm/sched: Fix teardown leaks with waitqueue
Date: Mon, 24 Mar 2025 19:57:25 +0100
Message-ID: <20250324185728.45857-3-phasta@kernel.org>
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

From: Philipp Stanner <pstanner@redhat.com>

The GPU scheduler currently does not ensure that its pending_list is
empty before performing various other teardown tasks in
drm_sched_fini().

If there are still jobs in the pending_list, this is problematic because
after scheduler teardown, no one will call backend_ops.free_job()
anymore. This would, consequently, result in memory leaks.

One way to solve this is to implement a waitqueue that drm_sched_fini()
blocks on until the pending_list has become empty.

Add a waitqueue to struct drm_gpu_scheduler. Wake up waiters once the
pending_list becomes empty. Wait in drm_sched_fini() for that to happen.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 84 ++++++++++++++++++++------
 include/drm/gpu_scheduler.h            |  8 +++
 2 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 53e6aec37b46..c1ab48ef61cf 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -367,7 +367,7 @@ static void drm_sched_run_job_queue(struct drm_gpu_scheduler *sched)
  */
 static void __drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
 {
-	if (!READ_ONCE(sched->pause_submit))
+	if (!READ_ONCE(sched->pause_free))
 		queue_work(sched->submit_wq, &sched->work_free_job);
 }
 
@@ -556,6 +556,7 @@ static void drm_sched_job_timedout(struct work_struct *work)
 		 * is parked at which point it's safe.
 		 */
 		list_del_init(&job->list);
+
 		spin_unlock(&sched->job_list_lock);
 
 		status = job->sched->ops->timedout_job(job);
@@ -572,8 +573,10 @@ static void drm_sched_job_timedout(struct work_struct *work)
 		spin_unlock(&sched->job_list_lock);
 	}
 
-	if (status != DRM_GPU_SCHED_STAT_ENODEV)
-		drm_sched_start_timeout_unlocked(sched);
+	if (status != DRM_GPU_SCHED_STAT_ENODEV) {
+		if (!READ_ONCE(sched->cancel_timeout))
+			drm_sched_start_timeout_unlocked(sched);
+	}
 }
 
 /**
@@ -1109,12 +1112,22 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 		/* remove job from pending_list */
 		list_del_init(&job->list);
 
+		/*
+		 * Inform tasks blocking in drm_sched_fini() that it's now safe to proceed.
+		 */
+		if (list_empty(&sched->pending_list))
+			wake_up(&sched->pending_list_waitque);
+
 		/* cancel this job's TO timer */
 		cancel_delayed_work(&sched->work_tdr);
 		/* make the scheduled timestamp more accurate */
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
 
+		// TODO RFC: above we wake up the waitque which relies on the fact
+		// that timeouts have been deactivated. The below should never
+		// reactivate them since the list was empty above. Still, should
+		// we document that?
 		if (next) {
 			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
 				     &next->s_fence->scheduled.flags))
@@ -1314,6 +1327,7 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	init_waitqueue_head(&sched->job_scheduled);
 	INIT_LIST_HEAD(&sched->pending_list);
 	spin_lock_init(&sched->job_list_lock);
+	init_waitqueue_head(&sched->pending_list_waitque);
 	atomic_set(&sched->credit_count, 0);
 	INIT_DELAYED_WORK(&sched->work_tdr, drm_sched_job_timedout);
 	INIT_WORK(&sched->work_run_job, drm_sched_run_job_work);
@@ -1321,6 +1335,8 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 	atomic_set(&sched->_score, 0);
 	atomic64_set(&sched->job_id_count, 0);
 	sched->pause_submit = false;
+	sched->pause_free = false;
+	sched->cancel_timeout = false;
 
 	sched->ready = true;
 	return 0;
@@ -1338,6 +1354,40 @@ int drm_sched_init(struct drm_gpu_scheduler *sched, const struct drm_sched_init_
 }
 EXPORT_SYMBOL(drm_sched_init);
 
+/**
+ * drm_sched_submission_and_timeout_stop - stop everything except for free_job()
+ * @sched: scheduler instance
+ *
+ * Only needed to cleanly tear down the scheduler in drm_sched_fini().
+ */
+static inline void
+drm_sched_submission_and_timeout_stop(struct drm_gpu_scheduler *sched)
+{
+	WRITE_ONCE(sched->pause_submit, true);
+	WRITE_ONCE(sched->cancel_timeout, true);
+	cancel_work_sync(&sched->work_run_job);
+	cancel_delayed_work_sync(&sched->work_tdr);
+}
+
+static inline void
+drm_sched_free_stop(struct drm_gpu_scheduler *sched)
+{
+	WRITE_ONCE(sched->pause_free, true);
+	cancel_work_sync(&sched->work_free_job);
+}
+
+static inline bool
+drm_sched_no_jobs_pending(struct drm_gpu_scheduler *sched)
+{
+	bool empty;
+
+	spin_lock(&sched->job_list_lock);
+	empty = list_empty(&sched->pending_list);
+	spin_unlock(&sched->job_list_lock);
+
+	return empty;
+}
+
 /**
  * drm_sched_fini - Destroy a gpu scheduler
  *
@@ -1345,26 +1395,24 @@ EXPORT_SYMBOL(drm_sched_init);
  *
  * Tears down and cleans up the scheduler.
  *
- * This stops submission of new jobs to the hardware through
- * drm_sched_backend_ops.run_job(). Consequently, drm_sched_backend_ops.free_job()
- * will not be called for all jobs still in drm_gpu_scheduler.pending_list.
- * There is no solution for this currently. Thus, it is up to the driver to make
- * sure that:
- *
- *  a) drm_sched_fini() is only called after for all submitted jobs
- *     drm_sched_backend_ops.free_job() has been called or that
- *  b) the jobs for which drm_sched_backend_ops.free_job() has not been called
- *     after drm_sched_fini() ran are freed manually.
- *
- * FIXME: Take care of the above problem and prevent this function from leaking
- * the jobs in drm_gpu_scheduler.pending_list under any circumstances.
+ * Note that this function blocks until all the fences returned by
+ * &struct drm_sched_backend_ops.run_job have been signalled.
  */
 void drm_sched_fini(struct drm_gpu_scheduler *sched)
 {
 	struct drm_sched_entity *s_entity;
 	int i;
 
-	drm_sched_wqueue_stop(sched);
+	/*
+	 * Jobs that have neither been scheduled or which have timed out are
+	 * gone by now, but jobs that have been submitted through
+	 * backend_ops.run_job() and have not yet terminated are still pending.
+	 *
+	 * Wait for the pending_list to become empty to avoid leaking those jobs.
+	 */
+	drm_sched_submission_and_timeout_stop(sched);
+	wait_event(sched->pending_list_waitque, drm_sched_no_jobs_pending(sched));
+	drm_sched_free_stop(sched);
 
 	for (i = DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
 		struct drm_sched_rq *rq = sched->sched_rq[i];
@@ -1461,6 +1509,7 @@ EXPORT_SYMBOL(drm_sched_wqueue_ready);
 void drm_sched_wqueue_stop(struct drm_gpu_scheduler *sched)
 {
 	WRITE_ONCE(sched->pause_submit, true);
+	WRITE_ONCE(sched->pause_free, true);
 	cancel_work_sync(&sched->work_run_job);
 	cancel_work_sync(&sched->work_free_job);
 }
@@ -1478,6 +1527,7 @@ EXPORT_SYMBOL(drm_sched_wqueue_stop);
 void drm_sched_wqueue_start(struct drm_gpu_scheduler *sched)
 {
 	WRITE_ONCE(sched->pause_submit, false);
+	WRITE_ONCE(sched->pause_free, false);
 	queue_work(sched->submit_wq, &sched->work_run_job);
 	queue_work(sched->submit_wq, &sched->work_free_job);
 }
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 1a7e377d4cbb..badcf9ea4501 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/xarray.h>
 #include <linux/workqueue.h>
+#include <linux/wait.h>
 
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
 
@@ -533,6 +534,8 @@ struct drm_sched_backend_ops {
  *            timeout interval is over.
  * @pending_list: the list of jobs which are currently in the job queue.
  * @job_list_lock: lock to protect the pending_list.
+ * @pending_list_waitque: a waitqueue for drm_sched_fini() to block on until all
+ *		          pending jobs have been finished.
  * @hang_limit: once the hangs by a job crosses this limit then it is marked
  *              guilty and it will no longer be considered for scheduling.
  * @score: score to help loadbalancer pick a idle sched
@@ -540,6 +543,8 @@ struct drm_sched_backend_ops {
  * @ready: marks if the underlying HW is ready to work
  * @free_guilty: A hit to time out handler to free the guilty job.
  * @pause_submit: pause queuing of @work_run_job on @submit_wq
+ * @pause_free: pause queuing of @work_free_job on @submit_wq
+ * @cancel_timeout: pause queuing of @work_tdr on @submit_wq
  * @own_submit_wq: scheduler owns allocation of @submit_wq
  * @dev: system &struct device
  *
@@ -562,12 +567,15 @@ struct drm_gpu_scheduler {
 	struct delayed_work		work_tdr;
 	struct list_head		pending_list;
 	spinlock_t			job_list_lock;
+	wait_queue_head_t		pending_list_waitque;
 	int				hang_limit;
 	atomic_t                        *score;
 	atomic_t                        _score;
 	bool				ready;
 	bool				free_guilty;
 	bool				pause_submit;
+	bool				pause_free;
+	bool				cancel_timeout;
 	bool				own_submit_wq;
 	struct device			*dev;
 };
-- 
2.48.1



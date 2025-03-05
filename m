Return-Path: <linux-kernel+bounces-547181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C87A503E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9523AEE1E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47062500C5;
	Wed,  5 Mar 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFqJpVOM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D492054FA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190052; cv=none; b=In5kA2Uoa5aqN+zskJe2rtGKMxmSK/Nilt5W69eHvCvGVx9LATKy6Zh0vRoIA4MwjmykXqPNqAZ2+aAJ9hZr2pQce6tft/jMPIBv9iW95Dse7kKStzLRAslgEQpyP77Jkmg6ERSjZuKJJ2zBYP3tt5d7ZSgBUAXcE7+9KjwxFR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190052; c=relaxed/simple;
	bh=zIEeetKUTm0IuyongYlHLFcQs8fidnoZvNOum1B6Meo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUUJnoXJ4OkILWf/z8YgW0wUf1K2Dr+GRqZdgFBSSkcswvOItzw/dfmQ/OzQ4YPg+0ZFvvZJuJ7EsDq9MRAhhHALUiPwsX4J6yFzXe9JAz3ZngsbD0hZ0eQt1piHHK1aHsd9QvM0VPbF1JR6MmSZbVrY6Uyi1jmoXHzH8YerKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFqJpVOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB09C4CED1;
	Wed,  5 Mar 2025 15:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741190051;
	bh=zIEeetKUTm0IuyongYlHLFcQs8fidnoZvNOum1B6Meo=;
	h=From:To:Cc:Subject:Date:From;
	b=nFqJpVOMRycveemwDsbazoTPRUFoTsgImJC9/7MOjvuExCby4x7ZoLePxanm60LBk
	 WpHfohZbhGi9Dc2NVPE2qGIskN8V/IzqkSv/bz2PmNfLyfX+Fhe2Zjv1j+DjwLAu9i
	 9YqdUAZchQfxDzMsbGcD/uL97nsJ8ZpdSdzgJIKIKEeedDJ7xjoMl26i3HOKdkxmVE
	 zSD7jRicSA3GPZdPQeRx63DYNvks7bJ0LYOB1UqLjf3Upe5IKgUo52gkfYlygh3kZI
	 BbwSG5dS6WDbh5uA5iUtLZalMsv/c/dNk73hmKyegBxajFIVFIgrza6Nw+ubBFVyBH
	 oIVDCFWMlLY1A==
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
Subject: [PATCH v2 1/2] drm/sched: Fix outdated comments referencing thread
Date: Wed,  5 Mar 2025 16:53:26 +0100
Message-ID: <20250305155326.153596-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPU scheduler's comments refer to a "thread" at various places.
Those are leftovers from commit a6149f039369 ("drm/sched: Convert drm
scheduler to use a work queue rather than kthread").

Replace all references to kthreads.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
Changes in v2:
  - Speak consistently about work items. (Danilo)
  - Remove Fixes: tags. (Danilo)
---
 drivers/gpu/drm/scheduler/sched_entity.c |  8 ++++----
 drivers/gpu/drm/scheduler/sched_main.c   | 24 +++++++++++++-----------
 include/drm/gpu_scheduler.h              | 10 +++++-----
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 87f88259ddf6..f9811420c787 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -538,10 +538,10 @@ void drm_sched_entity_select_rq(struct drm_sched_entity *entity)
 		return;
 
 	/*
-	 * Only when the queue is empty are we guaranteed that the scheduler
-	 * thread cannot change ->last_scheduled. To enforce ordering we need
-	 * a read barrier here. See drm_sched_entity_pop_job() for the other
-	 * side.
+	 * Only when the queue is empty are we guaranteed that
+	 * drm_sched_run_job_work() cannot change entity->last_scheduled. To
+	 * enforce ordering we need a read barrier here. See
+	 * drm_sched_entity_pop_job() for the other side.
 	 */
 	smp_rmb();
 
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c634993f1346..c97655aa7ab4 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -389,7 +389,7 @@ static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
  * drm_sched_job_done - complete a job
  * @s_job: pointer to the job which is done
  *
- * Finish the job's fence and wake up the worker thread.
+ * Finish the job's fence and resubmit the work items.
  */
 static void drm_sched_job_done(struct drm_sched_job *s_job, int result)
 {
@@ -549,9 +549,10 @@ static void drm_sched_job_timedout(struct work_struct *work)
 
 	if (job) {
 		/*
-		 * Remove the bad job so it cannot be freed by concurrent
-		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
-		 * is parked at which point it's safe.
+		 * Remove the bad job so it cannot be freed by a concurrent
+		 * &struct drm_sched_backend_ops.free_job. It will be
+		 * reinserted after the scheduler's work items have been
+		 * cancelled, at which point it's safe.
 		 */
 		list_del_init(&job->list);
 		spin_unlock(&sched->job_list_lock);
@@ -597,10 +598,10 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 
 	/*
 	 * Reinsert back the bad job here - now it's safe as
-	 * drm_sched_get_finished_job cannot race against us and release the
+	 * drm_sched_get_finished_job() cannot race against us and release the
 	 * bad job at this point - we parked (waited for) any in progress
-	 * (earlier) cleanups and drm_sched_get_finished_job will not be called
-	 * now until the scheduler thread is unparked.
+	 * (earlier) cleanups and drm_sched_get_finished_job() will not be
+	 * called now until the scheduler's work items are submitted again.
 	 */
 	if (bad && bad->sched == sched)
 		/*
@@ -613,7 +614,8 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
 	 * Iterate the job list from later to  earlier one and either deactive
 	 * their HW callbacks or remove them from pending list if they already
 	 * signaled.
-	 * This iteration is thread safe as sched thread is stopped.
+	 * This iteration is thread safe as the scheduler's work items have been
+	 * cancelled.
 	 */
 	list_for_each_entry_safe_reverse(s_job, tmp, &sched->pending_list,
 					 list) {
@@ -678,9 +680,9 @@ void drm_sched_start(struct drm_gpu_scheduler *sched, int errno)
 	struct drm_sched_job *s_job, *tmp;
 
 	/*
-	 * Locking the list is not required here as the sched thread is parked
-	 * so no new jobs are being inserted or removed. Also concurrent
-	 * GPU recovers can't run in parallel.
+	 * Locking the list is not required here as the scheduler's work items
+	 * are currently not running, so no new jobs are being inserted or
+	 * removed. Also concurrent GPU recovers can't run in parallel.
 	 */
 	list_for_each_entry_safe(s_job, tmp, &sched->pending_list, list) {
 		struct dma_fence *fence = s_job->s_fence->parent;
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 50928a7ae98e..d8bfd46c1117 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -192,7 +192,7 @@ struct drm_sched_entity {
 	 * @last_scheduled:
 	 *
 	 * Points to the finished fence of the last scheduled job. Only written
-	 * by the scheduler thread, can be accessed locklessly from
+	 * by drm_sched_entity_pop_job(). Can be accessed locklessly from
 	 * drm_sched_job_arm() if the queue is empty.
 	 */
 	struct dma_fence __rcu		*last_scheduled;
@@ -426,14 +426,14 @@ struct drm_sched_backend_ops {
 	 * Drivers typically issue a reset to recover from GPU hangs, and this
 	 * procedure usually follows the following workflow:
 	 *
-	 * 1. Stop the scheduler using drm_sched_stop(). This will park the
-	 *    scheduler thread and cancel the timeout work, guaranteeing that
-	 *    nothing is queued while we reset the hardware queue
+	 * 1. Stop the scheduler using drm_sched_stop(). This will cancel the
+	 *    scheduler's work items, guaranteeing that nothing is queued while
+	 *    we reset the hardware queue.
 	 * 2. Try to gracefully stop non-faulty jobs (optional)
 	 * 3. Issue a GPU reset (driver-specific)
 	 * 4. Re-submit jobs using drm_sched_resubmit_jobs()
 	 * 5. Restart the scheduler using drm_sched_start(). At that point, new
-	 *    jobs can be queued, and the scheduler thread is unblocked
+	 *    jobs can be queued, and the scheduler's work items are resubmitted.
 	 *
 	 * Note that some GPUs have distinct hardware queues but need to reset
 	 * the GPU globally, which requires extra synchronization between the
-- 
2.48.1



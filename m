Return-Path: <linux-kernel+bounces-528957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6EA41E73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB33441E84
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B3B248861;
	Mon, 24 Feb 2025 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I76oiVmT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F121930C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398489; cv=none; b=Dj+ZHXTnCXUoRQZMp5PKEKOvCw2H8PHZ913v9maLgPGQ1q929ta75kC4ph6KLq4pqXEWtbTKYbYSM6kvJTLL+vnn4OMI0d/cpn3KdOrxGEQKNM8MEC5Y3W2BKRI9phXtfXwNL3a6pSxhLwlxqw/LAfak1BIQZRzbB2zSifXO96A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398489; c=relaxed/simple;
	bh=bHUmAqP5o3dfa2+psfxX7v2KUkg9rRZ2bnm//h3yhy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DeHwWcolb0xLh2XRLD5GTRuDPpzNOwEjMY7VYKwqAiBtJUt5/qXPGiLE3vTh2csLuA5VENqqAnsp6tvNX40dlNBEdHfvqh8IhGY2REackeIwKG4qW/2eRBe5ACT52Pu4p39HTuex1MaO5R8gYobnrf4xdkbQJyO/6OQdDjy0dMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I76oiVmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF4DC4CEE6;
	Mon, 24 Feb 2025 12:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740398488;
	bh=bHUmAqP5o3dfa2+psfxX7v2KUkg9rRZ2bnm//h3yhy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I76oiVmTHTALVI6rwTF/jqSynNjv69UJQEOJLUmE/AfNjew2+65IIM315c5tSE07W
	 tI9uWLiHo/FW5BKYrCN/sdgwD9ACeY0PaqXlMsIyEEuegRyfXERcdamG33SX4+T9tI
	 U/Hff31HatDUvwZcixUaGEOuRitYhE+aLSgYd7xGibmLee1a4Z/xyZXDMy0bOctjwy
	 jNjg3RvCjq+DYHO4Urg2ykKvZTzgNSpzAvNdBEpbOboThIFbT2zdFLk1fhJ23ZchLP
	 lbvfqWm2A3/GRe05OcNioCXjTJyH8fTxvl3JdsBNcb6eoWNLTDVTP9cwXoDOVAeIYt
	 1K2Haqd3vPvKg==
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
Subject: [PATCH v6 2/3] drm/sched: Document run_job() refcount hazard
Date: Mon, 24 Feb 2025 13:01:04 +0100
Message-ID: <20250224120104.26211-4-phasta@kernel.org>
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
 drivers/gpu/drm/scheduler/sched_main.c | 9 ++++++---
 include/drm/gpu_scheduler.h            | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 8c36a59afb72..965021e76fde 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1217,20 +1217,23 @@ static void drm_sched_run_job_work(struct work_struct *w)
 	drm_sched_job_begin(sched_job);
 
 	trace_drm_run_job(sched_job, entity);
+	/*
+	 * The run_job() callback must by definition return a fence whose
+	 * refcount has been incremented for the scheduler already.
+	 */
 	fence = sched->ops->run_job(sched_job);
 	complete_all(&entity->entity_idle);
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
index 5d0394f40aae..c59a903deebe 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -447,6 +447,7 @@ struct drm_sched_backend_ops {
 	 * * On success: dma_fence the driver must signal once the hardware has
 	 * completed the job ("hardware fence").
 	 * * On failure: NULL or an ERR_PTR.
+	 *
 	 */
 	struct dma_fence *(*run_job)(struct drm_sched_job *sched_job);
 
-- 
2.48.1



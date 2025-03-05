Return-Path: <linux-kernel+bounces-546861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C24A4FFAF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB8F177365
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854BF24BC1E;
	Wed,  5 Mar 2025 13:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUJBL0wN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20B724A070
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179969; cv=none; b=OBJhbQs8rCqTtdmAA+1ElaDRa2TwQyMn3YDF+VgihBynFKVsVD5/yKmHLmrFw/TM/FsZ/qHg8FzoQZ3CyU+tJ49BSL08JcbAue5fKGSokSdS+Q3G+ajN2TXSDX4NRKc5jjYuX+hqEx7bHJlTvuLuyVtgFeLRroe8DjVmsg4OC94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179969; c=relaxed/simple;
	bh=VnltsXK2yo0tjAFJEBLC6Hm+o1kgcKTB55+828iZ6bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVEhYuHb/53FZjD8u5AU5uYQvlTay9cpcdR/lLR65nzBQkzGO73OGP5pTSekuT4dEvE9EBySqX+dZXU0OS2See/iNJ1NVqfVgQu5VfGRuNEzv6OzOCG5GKmHvW5hLWnN2PcoCU4pP1eokhs/L5egnA7qL3LSs75xngbC5gwW8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUJBL0wN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A8DC4CEE2;
	Wed,  5 Mar 2025 13:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741179968;
	bh=VnltsXK2yo0tjAFJEBLC6Hm+o1kgcKTB55+828iZ6bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUJBL0wNT4YmROIrj4Fp2+MnlOAoyUpnAWfKf9lhouge7LMBwpm+iS5PadAjKA6M5
	 07c+5QCfZ5Gd3AUd+wKzRars0LItrkJdLkeVSWHR5Ns6U2dXS6KU9Taj4wGGot14VQ
	 QQesttSeKg1Jt+YIhxYNeCMstaWM1bcuL3tpb0JLC9+bJPOek37+e0ANE6brNx3L0O
	 Xuz+0aaRsrCvY6gow7pQN37FRbmDqrdMRmMPWjPTVGOcBMvHT8XyyzrInN4UKBYo28
	 MP5RojZv3a78c8uYwJu7/5Pv/MaXF3mAFVpdXu1CPEtsER4UjT7DpCodoZjjM/28ed
	 1lh/KEKbMMCVg==
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
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v7 2/3] drm/sched: Document run_job() refcount hazard
Date: Wed,  5 Mar 2025 14:05:51 +0100
Message-ID: <20250305130551.136682-4-phasta@kernel.org>
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

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c634993f1346..c8da6b4edf0a 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1216,20 +1216,23 @@ static void drm_sched_run_job_work(struct work_struct *w)
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
-- 
2.48.1



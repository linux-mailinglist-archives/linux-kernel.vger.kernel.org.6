Return-Path: <linux-kernel+bounces-559103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F809A5EF97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D34D317B297
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E26261398;
	Thu, 13 Mar 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqL+fq/l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D814900B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858292; cv=none; b=Vk/cGaWK1Tdvu7BdYMGaZ0Tw0ycx8YyGMPlkLNMI9eJHDOVh32j1UQbFYldYxjjy/3bJ2lGMbphtuwoUwbgc5VGBw1vgHTutKFl1GEMpa29XXWII8WHjcpJTe07ma6berSPBhVbxJwgwdZT1OOXqFyzK33EGWNnihFxYkJj/xI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858292; c=relaxed/simple;
	bh=KzcPX5aFNSENYiyWmPKs6DdjY4qW1KEAD7qnBC2uPzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uWynEgv91hAKmQphlp7DSWQYgWP9a3Dk4eceZkbgPhLx7DIq9TTnIsdLc1m2TkAuIImu5wtug/Hhu5JJEE1ziUKAc+Mdrz0GRT7EU17iaA+qu3v39gDTAVWdKZVF8F4uHLcYiTqf5yz0P6HqM7zKR/X7a0eC7Ft+j1H5j62i5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqL+fq/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29AFC4CEDD;
	Thu, 13 Mar 2025 09:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741858291;
	bh=KzcPX5aFNSENYiyWmPKs6DdjY4qW1KEAD7qnBC2uPzg=;
	h=From:To:Cc:Subject:Date:From;
	b=IqL+fq/lOrx2GHPF3cFWiCwW0BxjGBHhRxjOQEHiHu73ZP48yxhPCxjHHdh0PoP6x
	 kr7ADyX6Y4W/HsGnkc3W7hGfpOnZRweWssxmz0lc8tyQxViUuDhJUI8RCTJfggB4UL
	 P+ECpPldPKWfOu0spwDRcTItmhoIklnzF0PHI0h6Oq0r4T9t1bB0o2oUJ1yI8LSTtH
	 iZHWosaDHK7pHwzv98PrfK9rd36rbGKXOaIzZ36esvqoM2F/8GraBnHmk+udn81uUl
	 PRHPUwFGMLhjKeOwjE1Yt/FsijXBxmjqzpEbXN1wZXl7p5fGjDPwtVdCtviH1d3BUd
	 kw4H40PmR8iRw==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/sched: Clarify docu concerning drm_sched_job_arm()
Date: Thu, 13 Mar 2025 10:30:54 +0100
Message-ID: <20250313093053.65001-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The documentation for drm_sched_job_arm() and especially
drm_sched_job_cleanup() does not make it very clear why
drm_sched_job_arm() is a point of no return, which it indeed is.

Make the nature of drm_sched_job_arm() in the docu as clear as possible.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 4d4219fbe49d..829579c41c6b 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -828,11 +828,15 @@ EXPORT_SYMBOL(drm_sched_job_init);
  *
  * This arms a scheduler job for execution. Specifically it initializes the
  * &drm_sched_job.s_fence of @job, so that it can be attached to struct dma_resv
- * or other places that need to track the completion of this job.
+ * or other places that need to track the completion of this job. It also
+ * initializes sequence numbers, which are fundamental for fence ordering.
  *
  * Refer to drm_sched_entity_push_job() documentation for locking
  * considerations.
  *
+ * Once this function was called, you *must* submit @job with
+ * drm_sched_entity_push_job().
+ *
  * This can only be called if drm_sched_job_init() succeeded.
  */
 void drm_sched_job_arm(struct drm_sched_job *job)
@@ -1017,9 +1021,12 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
  * Drivers should call this from their error unwind code if @job is aborted
  * before drm_sched_job_arm() is called.
  *
- * After that point of no return @job is committed to be executed by the
- * scheduler, and this function should be called from the
- * &drm_sched_backend_ops.free_job callback.
+ * drm_sched_job_arm() is a point of no return since it initializes the fences
+ * and their sequence number etc. Once that function has been called, you *must*
+ * submit it with drm_sched_entity_push_job() and cannot simply abort it by
+ * calling drm_sched_job_cleanup().
+ *
+ * This function should be called in the &drm_sched_backend_ops.free_job callback.
  */
 void drm_sched_job_cleanup(struct drm_sched_job *job)
 {
@@ -1027,10 +1034,15 @@ void drm_sched_job_cleanup(struct drm_sched_job *job)
 	unsigned long index;
 
 	if (kref_read(&job->s_fence->finished.refcount)) {
-		/* drm_sched_job_arm() has been called */
+		/* The job has been processed by the scheduler, i.e.,
+		 * drm_sched_job_arm() and drm_sched_entity_push_job() have
+		 * been called.
+		 */
 		dma_fence_put(&job->s_fence->finished);
 	} else {
-		/* aborted job before committing to run it */
+		/* The job was aborted before it has been committed to be run;
+		 * notably, drm_sched_job_arm() has not been called.
+		 */
 		drm_sched_fence_free(job->s_fence);
 	}
 
-- 
2.48.1



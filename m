Return-Path: <linux-kernel+bounces-544369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF70A4E098
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFA03A8615
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8349204F78;
	Tue,  4 Mar 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3K9tKpm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBC204F65
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097651; cv=none; b=ZAcUDUlVCxoE8xx5S3G5nHBZzbMCBLUu+1pkOpRaaRGjNoNq+UnmNhqhzELwqXE10MgZMOH/zPJAJkTSX7yFXl/SUHxjiD45/iwZjGp5Abt/DVIwbKTQDJBkaikPtiB5HN9DVx2BcpFvYj9iXCAWDKoj0nWgkDze/VFm+O52ghA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097651; c=relaxed/simple;
	bh=kUUHqPubu3Hi755v/SEctdBCsR+sFrtHh2SfYt9GoKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXmrS8DCbyrSaULP1Re6ywCQkZWCLyu45PMAu/GjhAmstyDy0gCMPTkj2cX9/axxlEX4LWVM0zyaRGBg34hd27lD6y0a5O51hBa0ot6VZs9SiiTd3H1g3lRiCHUazVTAeG6RWr4ioC1d3vyiCKgiP8l7UycCWoELo3r9DRS2r1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3K9tKpm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7450C4CEEB;
	Tue,  4 Mar 2025 14:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097650;
	bh=kUUHqPubu3Hi755v/SEctdBCsR+sFrtHh2SfYt9GoKI=;
	h=From:To:Cc:Subject:Date:From;
	b=K3K9tKpmE3BeEYu2AiwAQvhlAfNCEDVEO8RhmBVWswSS+t1BE7OYBhziYgs+KPQT9
	 /xNIEbGh8EOUARZgqKsIhowQ4b12rlzUULnQBQUaZqD1QVF316Fe8XQOEw1/txaxX+
	 rZGNfLC1wlYxybTii2bl6sEkD2ISXTYawlRsfmKvAeMrHvl+M9kmVVraVPCyKLhQLZ
	 C4YL7XSOFR+U/xIBh+sg3M53q8yawXRvZGsE9R5O2YoXkOU3+mPMQIlcyACEV6y091
	 86ZNAbY4oW0q8DEGp+aZrPX6v6D6ZUCZYZ32KabZHXQkUW3Px1vT2KOzjypv3vjaLB
	 6uux/5+x8hsCA==
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
Subject: [PATCH v2] drm/sched: drm_sched_job_cleanup(): correct false doc
Date: Tue,  4 Mar 2025 15:13:47 +0100
Message-ID: <20250304141346.102683-2-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm_sched_job_cleanup()'s documentation claims that calling
drm_sched_job_arm() is a "point of no return", implying that afterwards
a job cannot be cancelled anymore.

This is not correct, as proven by the function's code itself, which
takes a previous call to drm_sched_job_arm() into account. In truth, the
decisive factors are whether fences have been shared (e.g., with other
processes) and if the job has been submitted to an entity already.

Correct the wrong docstring.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
Changes in v2:
  - Also adjust comment about arm inside function's body. (Tvrtko)
---
 drivers/gpu/drm/scheduler/sched_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index c634993f1346..7e71e89cea89 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -1013,11 +1013,13 @@ EXPORT_SYMBOL(drm_sched_job_has_dependency);
  * Cleans up the resources allocated with drm_sched_job_init().
  *
  * Drivers should call this from their error unwind code if @job is aborted
- * before drm_sched_job_arm() is called.
+ * before it was submitted to an entity with drm_sched_entity_push_job().
  *
- * After that point of no return @job is committed to be executed by the
- * scheduler, and this function should be called from the
- * &drm_sched_backend_ops.free_job callback.
+ * Since calling drm_sched_job_arm() causes the job's fences to be initialized,
+ * it is up to the driver to ensure that fences that were exposed to external
+ * parties get signaled. drm_sched_job_cleanup() does not ensure this.
+ *
+ * This function must also be called in &struct drm_sched_backend_ops.free_job
  */
 void drm_sched_job_cleanup(struct drm_sched_job *job)
 {
@@ -1028,7 +1030,7 @@ void drm_sched_job_cleanup(struct drm_sched_job *job)
 		/* drm_sched_job_arm() has been called */
 		dma_fence_put(&job->s_fence->finished);
 	} else {
-		/* aborted job before committing to run it */
+		/* aborted job before arming */
 		drm_sched_fence_free(job->s_fence);
 	}
 
-- 
2.48.1



Return-Path: <linux-kernel+bounces-522533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A532A3CB90
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0951D178578
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576AC2586EC;
	Wed, 19 Feb 2025 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rIr77q9B"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BC2580EB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000943; cv=none; b=VKA8dzRfLq95cfhMHreuNVb9Qu35TEk7H6nATNou3awX/gjy+i0vsaHB7qHYKcuz0BKUD54Y0UnfccCSqsbzumQePuW+fikkMKt8bWIhvecW/50F8yq5KC0/QK63lcWRrBlfoXrcBCdqy9tgGCW4S2cRJviWBFxrPStHYyKCaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000943; c=relaxed/simple;
	bh=WsDGpL2fEviDXSUWkU+RRcxY5xlZyjNnyRn8isw5Jbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T4xfsoc9CtREwTG9I9YJ2D0nN+84g5t3eksVH6QPdVC0XzjOogQTVakMWnK8riwrJPLElcSLz1IYs/LLKhWNImXl6SDy2e+4PC+V+7sAutGyo3ZnkwjSahcqBsTfJT/wxpsTEcWKKa18pLbieNy9d5wcs2lgbw4jQpYX+NThX18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rIr77q9B; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aMp0X/kKH/xLP0BxZclKAhaRvsa7RWoi/0q4q55kxFc=; b=rIr77q9B5LxPxJh7jMvZAl/XZX
	UviseiwzgTaV41nYBP7AVP7cQ7PeQiAm1ocoZmibLfvV+/wWgKmKKvQq/pHx3jkKTWePT8XLAPA5y
	QU2b5+tKsqEAdJiI0ZOCsBCuUpV+pczr6EpuWQzJOcMtuuy+RUUI+K6DR2MK/2nixKtA2KFVmwlCB
	HzkbdiOCoK/lEQmTZrQb0vmtkSYJjqw3kZnhJnpEvQNcYEqQn8sL8Nko37X3HX2CPLwIbRl7CiQhw
	Mx3L38qYYFWgKQyACSB3MUjkNowrxUhXNxgdRHQN3x6kg9uUurOzehZu86LI1cigsFnrKFscTGxeX
	WSdL6PEQ==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkrj9-00F1SN-HI; Wed, 19 Feb 2025 22:35:37 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	siqueira@igalia.com
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 3/3] drm/amdgpu: Trigger a wedged event for every type of reset
Date: Wed, 19 Feb 2025 18:35:17 -0300
Message-ID: <20250219213517.281556-4-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219213517.281556-1-andrealmeid@igalia.com>
References: <20250219213517.281556-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of only triggering a wedged event for complete GPU resets,
trigger for all types, like soft resets and ring resets. Regardless of
the reset, it's useful for userspace to know that it happened because
the kernel will reject further submissions from that app.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 16 +++++++++-------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 24ba52d76045..36738c1a5b59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6123,9 +6123,6 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	atomic_set(&adev->reset_domain->reset_res, r);
 
-	if (!r)
-		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
-
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 698e5799e542..1082b957e7b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,8 +91,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
-	int idx;
-	int r;
+	int idx, ret = 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
 		dev_info(adev->dev, "%s - device unplugged skipping recovery on scheduler:%s",
@@ -141,8 +140,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		 * we'll fall back to full GPU reset.
 		 */
 		drm_sched_wqueue_stop(&ring->sched);
-		r = amdgpu_ring_reset(ring, job->vmid);
-		if (!r) {
+		ret = amdgpu_ring_reset(ring, job->vmid);
+		if (!ret) {
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_stop(&ring->sched, s_job);
 			atomic_inc(&ring->adev->gpu_reset_counter);
@@ -170,9 +169,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		 */
 		set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
 
-		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
-		if (r)
-			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
+		ret = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
+		if (ret)
+			dev_err(adev->dev, "GPU Recovery Failed: %d\n", ret);
 	} else {
 		drm_sched_suspend_timeout(&ring->sched);
 		if (amdgpu_sriov_vf(adev))
@@ -180,6 +179,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 exit:
+	if (!ret)
+		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+
 	drm_dev_exit(idx);
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
-- 
2.48.1



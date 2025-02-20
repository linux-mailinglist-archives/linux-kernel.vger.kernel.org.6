Return-Path: <linux-kernel+bounces-524221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9408A3E0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94D27022E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06E212D96;
	Thu, 20 Feb 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="DKV5Chvh"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F481212B0B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740068891; cv=none; b=hIWEkRKSN+0sl2JXJOftfxCUTCXrTrqlr5kiSx4VDwDvoS5dKwE6b1zUEKDXpsa1T6OyTmsRzd9EuBhNSBnlZKNT60HjzDKERnf930aX2bMfhKlf20zZuHIwamc2PDkouQaTLYAjfms312mFSd/4S6VFl15DATIMNQq4brJEhiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740068891; c=relaxed/simple;
	bh=sGE7hNhiEeq3xAlLS05H4pGZx5fBJNUwbm2A+6GSnpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I82E6IimfIPNB1oCrFd9uD8UQKvrgiKh+gOi0X6qbfVphCJ+x1wtP/74xJF7t1TOXOJdn6GnUVQ3d0kZO0IoAuWvcHDjS+Wixjt5h0Y/rMCRv3GoQ10x3Z975mwjKIndxbobRLSRfmcStaH1+FT2G9ihL45qRbtJLBtVM28RRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=DKV5Chvh; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Le8WVOEy30QeG3s/aHaLL2Z+h6Ona2+zkOtS7UkAOtQ=; b=DKV5Chvh9NBQCKNssE6KXWYZ5C
	gfzVuHk11YYrXCu5hJOppqfZEr7kR7XVtXpFdnyr3s1WYKgaYYwaDnIoE8P2xXNX/jYxcOWeGRDzn
	8xSHZUqBqHuqJc/RMSa5OtNTrTrof12cPo1y03QDYmWQ2SGQzsvY/w7VyoDZBe72GGXnR+/E3+IiL
	fXlujtsYZ4PxMcNJvososVlYAKYXVigWPlE1Bsdp6YrhP7uBLZtrvBiouhLytKpLh4N6XS0SB2HQi
	xEmsH9bDLUqMm49xlqlgZknOUgtTyaWZigF7iqqEtzCJ4LtAYmlGmleqJD8rA1Vb/w3JOJJHEoVGE
	JmIYuSzg==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tl9P5-00FS04-7u; Thu, 20 Feb 2025 17:28:05 +0100
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
Subject: [PATCH v2 3/3] drm/amdgpu: Trigger a wedged event for every type of reset
Date: Thu, 20 Feb 2025 13:27:50 -0300
Message-ID: <20250220162750.343139-4-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220162750.343139-1-andrealmeid@igalia.com>
References: <20250220162750.343139-1-andrealmeid@igalia.com>
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
v2: Keep the wedge event in amdgpu_device_gpu_recover() and add and
    extra check to avoid triggering two events.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 698e5799e542..9948ea33d2c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -91,8 +91,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
-	int idx;
-	int r;
+	bool gpu_recover = false;
+	int idx, ret = 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
 		dev_info(adev->dev, "%s - device unplugged skipping recovery on scheduler:%s",
@@ -141,8 +141,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
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
@@ -170,9 +170,11 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		 */
 		set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
 
-		r = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
-		if (r)
-			dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);
+		ret = amdgpu_device_gpu_recover(ring->adev, job, &reset_context);
+		if (ret)
+			dev_err(adev->dev, "GPU Recovery Failed: %d\n", ret);
+		else
+			gpu_recover = true;
 	} else {
 		drm_sched_suspend_timeout(&ring->sched);
 		if (amdgpu_sriov_vf(adev))
@@ -180,6 +182,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	}
 
 exit:
+	/* Avoid sending two wedge events for the same reset */
+	if (!ret && !gpu_recover)
+		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+
 	drm_dev_exit(idx);
 	return DRM_GPU_SCHED_STAT_NOMINAL;
 }
-- 
2.48.1



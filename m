Return-Path: <linux-kernel+bounces-533931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B1BA46071
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA991899246
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DB21D3C0;
	Wed, 26 Feb 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="SLaeXKrr"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9765921B9C1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575493; cv=none; b=CpacX5G5x+nyjYCpwSad/nRIBVEh5Hda7cweLgXo7h/O79R3lHm//nfo+V7Djv7Kd90/9BLKywd3BI++nnzd+W7bYQ1dGv4js2hDBEBQyPu0Pryd4ODzZ5U+wFRcCMqvFLyjGsSGaIelotieMtkzpZ0JW9gn9/TXBCeQ/Ec3Azs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575493; c=relaxed/simple;
	bh=eycO/kASFwLYW9hX24QtdGg9sf3TO/EKg5hIszY8pWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P4P4OPj7BWE0fydC3cOCD+D4lQ0hiA6WZC2u8wKm9gusSWB7BpVhMkQMaPIE+ldeOWegvLIj2bI6iBQ8YdlCx0XgO+5GPyOFx+BdahFEAIGzU9BBJ/JHSZVCiVKXdbo4CdqC+xBuw/BUyCXU/D5cTQrh3ybcMtZkuZmdUusi2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=SLaeXKrr; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VWcU7yMm2YN0QLOsb6yyKZ0nl0TCOlQKOQKYheBKv+M=; b=SLaeXKrrmUNKF6OXzyS6A8UFzR
	57i5ricWO1V10tV7/8HRnQaAV9XbXno14qYY7MOBPn9Dp5+EPXGHhMdEppwUuCxjOyv/SE+IPCIoW
	Amj1KwDWNZKgc6VmmR/pZ6Yt3uvH4RSZ3FKXR4T6/scGWLVJoyChg05zD/iqyO9K8NQbuvC86mCtt
	ciwoKfXdbuF6KggNd3y8YuQ2mTIkmUztMcdBEH8kWfgpjbNE4UuZnb4Aah4bx2u5alJMn3gmRPee6
	i7pvDbZYKPK7LJ161YGwLKX9Jidwxr6bkEiQ89wyHyZt+iTzrgqClRLmjVCZEGk3/EHRWui8WzbPb
	6WNZKmtQ==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnHC1-000yOs-3B; Wed, 26 Feb 2025 14:11:23 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	siqueira@igalia.com
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] drm/amdgpu: Create a debug option to disable ring reset
Date: Wed, 26 Feb 2025 10:11:18 -0300
Message-ID: <20250226131118.1012223-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Prior to the addition of ring reset, the debug option
`debug_disable_soft_recovery` could be used to force a full device
reset. Now that we have ring reset, create a debug option to disable
them in amdgpu, forcing the driver to go with the full device
reset path again when both options are combined.

This option is useful for testing and debugging purposes when one wants
to test the full reset from userspace.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 5 +++--
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 69895fccb474..75dc4b962d64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1186,6 +1186,7 @@ struct amdgpu_device {
 	bool                            debug_use_vram_fw_buf;
 	bool                            debug_enable_ras_aca;
 	bool                            debug_exp_resets;
+	bool                            debug_disable_gpu_ring_reset;
 
 	bool				enforce_isolation[MAX_XCP];
 	/* Added this mutex for cleaner shader isolation between GFX and compute processes */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 95a05b03f799..edeb12c816e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -136,6 +136,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_USE_VRAM_FW_BUF = BIT(3),
 	AMDGPU_DEBUG_ENABLE_RAS_ACA = BIT(4),
 	AMDGPU_DEBUG_ENABLE_EXP_RESETS = BIT(5),
+	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET = BIT(6),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2221,6 +2222,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: enable experimental reset features\n");
 		adev->debug_exp_resets = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_GPU_RING_RESET) {
+		pr_info("debug: ring reset disabled\n");
+		adev->debug_disable_gpu_ring_reset = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 7b79b0f39ba1..8ab23182127e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,8 +137,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
 	/* attempt a per ring reset */
-	if (amdgpu_gpu_recovery &&
-	    ring->funcs->reset) {
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "Ring reset disabled by debug mask\n");
+	} else if (amdgpu_gpu_recovery && ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n", s_job->sched->name);
 		/* stop the scheduler, but don't mess with the
 		 * bad job yet because if ring reset fails
-- 
2.48.1



Return-Path: <linux-kernel+bounces-538459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CFBA498F6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8F01898DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9C926AAB5;
	Fri, 28 Feb 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NVqGX+HB"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920426BD8F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744854; cv=none; b=bP5hB/AntHjY+2TazzRwUbKKNgYpCSxvSGMbnG96Lwjg9ZR/L8H92KBPcvTEhZ4IrQ+hRDHrTkNeL7CrvlvMebH21A3FPGJ/djOxVkqISFoehgaPV2Sfo9EHBcgacDe5Dskb/B0cu1QpFQpITawt9b7/+J1JMNLxMHwe80Z2DeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744854; c=relaxed/simple;
	bh=HzMaW1uEgwpPIvyxOJJS9smwowYzWnbPEbs/U4cFNyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qe3OMo0R2F1caCapltn+KhHRzHbJGU3NmdCJOcW7lH2hY3f6we4UiInyui7kosQnZPv/Lv/yItjpOnBxE5Bk6If0RO5aH87xEouBAppHSzwoJ0Fmxye7yPSWaIEDmHOiro1NCwFHyN9VCKStmhpsGVBAKuOXDd/y0JGgGE2w4t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NVqGX+HB; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mdaQrTB1GlcYbOWB+bn3mxjKfUdFg1iAkJgoLN6PJOs=; b=NVqGX+HBHXQCoiX63hot6o6iL+
	5m9b0yntFRKSGwYflb7iGDb3qUG0oM5LNKXFF8no0OzTy4zFBmYVcrG/cblQBIRDgfycxURte5rmw
	H+qWrpuuVgQaw+Wi/Mwd+UdMY31T+NPTZLlJ8ByRZk7zoMzpJlLGLODzgwc8PKuH0fj6UGgtJLKfE
	xy/N/NTBZZDRIFHuEbXYms+iSWhpDlVgC1gSuzYWz/Y1YjsHFeERzAauh4RvajibCLk2By0pzMCRA
	IXndIMH6qU8ZTZEVCsOfCQ0C49JLguqk5hnr+PaSyrma++bD7Yvj14umXf5EtySOf1f7Z6K51ONBy
	t+IkIjLA==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnzFj-0021Hz-Tg; Fri, 28 Feb 2025 13:14:10 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	amd-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
	siqueira@igalia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	Raag Jadav <raag.jadav@intel.com>,
	rodrigo.vivi@intel.com,
	jani.nikula@linux.intel.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 2/2] drm/amdgpu: Make use of drm_wedge_app_info
Date: Fri, 28 Feb 2025 09:13:53 -0300
Message-ID: <20250228121353.1442591-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228121353.1442591-1-andrealmeid@igalia.com>
References: <20250228121353.1442591-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To notify userspace about which app (if any) made the device get in a
wedge state, make use of drm_wedge_app_info parameter, filling it with
the app PID and name.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 00b9b87dafd8..e06adf6f34fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6123,8 +6123,23 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 
 	atomic_set(&adev->reset_domain->reset_res, r);
 
-	if (!r)
-		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
+	if (!r) {
+		struct drm_wedge_app_info aux, *info = NULL;
+
+		if (job) {
+			struct amdgpu_task_info *ti;
+
+			ti = amdgpu_vm_get_task_info_pasid(adev, job->pasid);
+			if (ti) {
+				aux.pid = ti->pid;
+				aux.comm = ti->process_name;
+				info = &aux;
+				amdgpu_vm_put_task_info(ti);
+			}
+		}
+
+		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
+	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 3ed9cbcab1ad..8ab23182127e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -89,6 +89,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
+	struct drm_wedge_app_info aux, *info = NULL;
 	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring->adev;
 	int idx;
@@ -127,6 +128,9 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		dev_err(adev->dev,
 			"Process information: process %s pid %d thread %s pid %d\n",
 			ti->process_name, ti->tgid, ti->task_name, ti->pid);
+		aux.pid = ti->pid;
+		aux.comm = ti->process_name;
+		info = &aux;
 		amdgpu_vm_put_task_info(ti);
 	}
 
@@ -150,7 +154,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			amdgpu_fence_driver_force_completion(ring);
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched, 0);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, info);
 			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
 			goto exit;
 		}
-- 
2.48.1



Return-Path: <linux-kernel+bounces-538458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458BDA498F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E363BDFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0D326BD9C;
	Fri, 28 Feb 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bcDax7Gt"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9526B949
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744851; cv=none; b=bVwtCr72wlG5whGpvdMpox3TAMOXOFJzGMT0Q2RK9fWxQEyl5zre7ddEKSX3SAzN/HOekHGD7q9wvEfQI2gUZNenU9mPzXoQ/Dw3lNIhKJOvIX/ocJQ0hHSICCUwDqehmaWThXDvr+5fUeSzps8tWnhxR2IufLEDyJEC7TJHHdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744851; c=relaxed/simple;
	bh=tSfZwH27MfV/+pDGZw2pHj2sBnT1ahZEiiivOUSSLno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qlDObxy5mZv8Jrb0DqYAeZhyD31/x43q5jg2wa5I5pWnrFPyvFB5YU3e3dLHhRrhBnVOgOzInL3aer+tOeoRWj8SoWa7Ik7sic8T7HqZw8Uaky4ImiE/BjTRcuLhlpoWkFZ2d5rHRmig8olGfbTDDhqr/D6ayVos2UE3PULp/sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bcDax7Gt; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NJbhh7XsQfBTvljJbX0bt5Q488yVrXVP75JXT3KFpOk=; b=bcDax7GtVcyMNk3NNVy4l/Wyl3
	w71vCR9Wmm4RvMRE6tn8fhes1avnhkJ9cIKOMayDCwRmwGSYChuxOWkxZzvO1rmdjhkx7jsoYKvq5
	FmTP6Vl/QtAznstQM45e+V/DEfNm+Ds7l3xvLNVtedZW5URQ09g8PuDOVq5ngXajkrZQjck0zdiVN
	vYos2eKIfH7Hf1uGPLZUJ6GuRZ7NcZJTuEis0m8DDMsC4pK/2P/roINscGSPQQpGS/Jady08NAV4U
	IQe0X6yhvxWx+rE0VYLB8mLyYhnHhKOkG2TKD3GBLSVtD8NAcrtEr5vIYTbikeLY8FiFSu1fqxS64
	Q6z8vHvw==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tnzFf-0021Hz-PX; Fri, 28 Feb 2025 13:14:06 +0100
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
Subject: [PATCH 1/2] drm: Create an app info option for wedge events
Date: Fri, 28 Feb 2025 09:13:52 -0300
Message-ID: <20250228121353.1442591-2-andrealmeid@igalia.com>
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

When a device get wedged, it might be caused by a guilty application.
For userspace, knowing which app was the cause can be useful for some
situations, like for implementing a policy, logs or for giving a chance
for the compositor to let the user know what app caused the problem.
This is an optional argument, when `PID=-1` there's no information about
the app caused the problem, or if any app was involved during the hang.

Sometimes just the PID isn't enough giving that the app might be already
dead by the time userspace will try to check what was this PID's name,
so to make the life easier also notify what's the app's name in the user
event.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  2 +-
 drivers/gpu/drm/drm_drv.c                  | 16 +++++++++++++---
 drivers/gpu/drm/i915/gt/intel_reset.c      |  3 ++-
 drivers/gpu/drm/xe/xe_device.c             |  3 ++-
 include/drm/drm_device.h                   |  8 ++++++++
 include/drm/drm_drv.h                      |  3 ++-
 7 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 24ba52d76045..00b9b87dafd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6124,7 +6124,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	atomic_set(&adev->reset_domain->reset_res, r);
 
 	if (!r)
-		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ef1b77f1e88f..3ed9cbcab1ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -150,7 +150,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			amdgpu_fence_driver_force_completion(ring);
 			if (amdgpu_ring_sched_ready(ring))
 				drm_sched_start(&ring->sched, 0);
-			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
 			goto exit;
 		}
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 17fc5dc708f4..48faafd82a99 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -522,6 +522,7 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
  * drm_dev_wedged_event - generate a device wedged uevent
  * @dev: DRM device
  * @method: method(s) to be used for recovery
+ * @info: optional information about the guilty app
  *
  * This generates a device wedged uevent for the DRM device specified by @dev.
  * Recovery @method\(s) of choice will be sent in the uevent environment as
@@ -534,13 +535,14 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
  *
  * Returns: 0 on success, negative error code otherwise.
  */
-int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
+int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
+			 struct drm_wedge_app_info *info)
 {
 	const char *recovery = NULL;
 	unsigned int len, opt;
 	/* Event string length up to 28+ characters with available methods */
-	char event_string[32];
-	char *envp[] = { event_string, NULL };
+	char event_string[32], pid_string[15], comm_string[TASK_COMM_LEN];
+	char *envp[] = { event_string, pid_string, comm_string, NULL };
 
 	len = scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=");
 
@@ -562,6 +564,14 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
 	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
 		 "but recovered through reset" : "needs recovery");
 
+	if (info) {
+		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
+		snprintf(comm_string, sizeof(comm_string), "APP=%s", info->comm);
+	} else {
+		snprintf(pid_string, sizeof(pid_string), "%s", "PID=-1");
+		snprintf(comm_string, sizeof(comm_string), "%s", "APP=none");
+	}
+
 	return kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
 }
 EXPORT_SYMBOL(drm_dev_wedged_event);
diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index d6dc12fd87c1..928b9f048b6a 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -1424,7 +1424,8 @@ static void intel_gt_reset_global(struct intel_gt *gt,
 		kobject_uevent_env(kobj, KOBJ_CHANGE, reset_done_event);
 	else
 		drm_dev_wedged_event(&gt->i915->drm,
-				     DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
+				     DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET,
+				     NULL);
 }
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index fc4a49f25c09..8a349c7daf24 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -1037,7 +1037,8 @@ void xe_device_declare_wedged(struct xe_device *xe)
 
 		/* Notify userspace of wedged device */
 		drm_dev_wedged_event(&xe->drm,
-				     DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET);
+				     DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET,
+				     NULL);
 	}
 
 	for_each_gt(gt, xe, id)
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 6ea54a578cda..8b9d614257e6 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -30,6 +30,14 @@ struct pci_controller;
 #define DRM_WEDGE_RECOVERY_REBIND	BIT(1)	/* unbind + bind driver */
 #define DRM_WEDGE_RECOVERY_BUS_RESET	BIT(2)	/* unbind + reset bus device + bind */
 
+/**
+ * struct drm_wedge_app_info - information about the guilty app of a wedge dev
+ */
+struct drm_wedge_app_info {
+	pid_t pid;
+	char *comm;
+};
+
 /**
  * enum switch_power_state - power state of drm device
  */
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index a43d707b5f36..8fc6412a6345 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -482,7 +482,8 @@ void drm_put_dev(struct drm_device *dev);
 bool drm_dev_enter(struct drm_device *dev, int *idx);
 void drm_dev_exit(int idx);
 void drm_dev_unplug(struct drm_device *dev);
-int drm_dev_wedged_event(struct drm_device *dev, unsigned long method);
+int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
+			 struct drm_wedge_app_info *info);
 
 /**
  * drm_dev_is_unplugged - is a DRM device unplugged
-- 
2.48.1



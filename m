Return-Path: <linux-kernel+bounces-412265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9109D065B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 22:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 716A7B21935
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 21:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72791DDA2F;
	Sun, 17 Nov 2024 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBxJFWof"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0831A1DAC9F
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731879684; cv=none; b=A57EOJAWmMWL8pU5b5xSCsLz4dFmXFqiniQ/J1QuwmRvKBVI/CoQTxVtTuY4DvLQuFRLIiLlZIegJOi9AO+XacZU4KuQ/3H1gIT7tZIzTaSsEXAPyEzsPskhAhSbpVKVMgIQiy0smozs3ViBcbdXP3779opxYRyVdbhMPFOiyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731879684; c=relaxed/simple;
	bh=/cOfPkpd6SZTTBYypystrFRCWYI1NiB41/KJ0ldfhPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VPsJPkNsucSblVdGvmGUrkWuXubfqlzAkbDbPES+cYW01oUV7rmux1WWcC9dc+6K4BmVYCbbPm0S8pHGINZqZ6lBpQ1ykQzqduSSoEuYpuNokS0JHB5rkkoc0yOXFy6SgSw9/u/FacA2sqaIc8NXJUgtW3gRkHdFSkScU4HVYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBxJFWof; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5cfbc911b6cso1043822a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 13:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731879681; x=1732484481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7QhgHhDq9UM5kwsDpNieVyeNit+/tY8NdIt6P3NvHSo=;
        b=GBxJFWofNNAlxo74yMZc0OtJXEpogzKS6exApNv8f4Pan/YSoWb1SAZP+WtyYEdPDw
         QQUeSPXscJ0DCcNkCtWwIJq5kA0toJd2qe5IIYkb2Us811tpB1Ruvor0HfALSGYgnkMU
         kJBA8tFVGkw4lCcszKwnrHIAw3d3PMQVLo3H/sjXRgH8tAUi1YD1ADV9IUXCDqtQCACz
         Itd/iBm0vHf1fucH9p7af9rLPfHGOeNQxxft7Il9eS6oCb1Lt3Ye5E8TCfAwz/KP5CW0
         F53MBP47Zh4JLzHEzAy0Xj6jSYFhV0C5zLapf95Xxu0LZud0Rn/+1XWs/XlkGfkZG8bt
         9UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731879681; x=1732484481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QhgHhDq9UM5kwsDpNieVyeNit+/tY8NdIt6P3NvHSo=;
        b=Rjiks0mx/mSTuEImgV9TulMZbtrVtedP4w2TZqHXH0gYyn9vPWHyqBCKF3UVb/SF+w
         QYtARBJwTCQ7zaQ7p+xYZafvwfKQXPQ9ph/Ir86G7pmEIYeyjEEji10PdHP1QIeCPGsg
         NVfqGgeZ1cEnJRqMRxa5EsrZ6wrcFpF9YaAhgGj7UBQn3fzTbkMZefs7l1Ikec9tbY9q
         N1EpbDyPWMf+POyqOMz/3JjLLWVqUFVMvBK7xQUU0cG1lfkU0HnMRl46vCVmZvJ+3ozd
         PSLhv0Mp2gpgugkXXgZLGKXUsixIjvMPybOhxRCwBQ4UIkEa/htDyYs3C+gTbEL/lacN
         qCUA==
X-Forwarded-Encrypted: i=1; AJvYcCVYc3IE/4jRwEPFDLoqn3ihYi6OP9xw3Oiwn4Tc6NZApnhjZmOsNSrMo/GPcvBtoCLbjcbQfrZe3I4823M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjb1BlFL7rD7jglGkMSlXEjZtvPw3oS4NarGrNzbJ40DtsHQyU
	ALhVjtJR0W8glK7vD2JLUxkpQY00DFrKWX+k9gOWHFuMOW5jXDPM
X-Google-Smtp-Source: AGHT+IHLO8CjTNvg5Ey8wF5T2MNa4RjkrrHgz2YWo/58Bo8BwvrPaau4iiFlMHnFiTnxWwXwQjr2NQ==
X-Received: by 2002:a17:907:d29:b0:a9a:294:cb30 with SMTP id a640c23a62f3a-aa4834122e4mr903810766b.16.1731879681020;
        Sun, 17 Nov 2024 13:41:21 -0800 (PST)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at. [62.178.82.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cfc8a3c139sm488079a12.50.2024.11.17.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 13:41:19 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: Melissa Wen <mwen@igalia.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com,
	Christian Gmeiner <cgmeiner@igalia.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
Date: Sun, 17 Nov 2024 22:41:08 +0100
Message-ID: <20241117214110.162547-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Gmeiner <cgmeiner@igalia.com>

Add a new ioctl, DRM_IOCTL_V3D_PERFMON_SET_GLOBAL, to allow
configuration of a global performance monitor (perfmon).
Use the global perfmon for all jobs to ensure consistent
performance tracking across submissions. This feature is
needed to implement a Perfetto datasources in user-space.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
Changes in v3:
- Reworked commit message.
- Refined some code comments.
- Added missing v3d_perfmon_stop(..) call to v3d_perfmon_destroy_ioctl(..).

Changes in v2:
- Reworked commit message.
- Removed num_perfmon counter for tracking perfmon allocations.
- Allowing allocation of perfmons when the global perfmon is active.
- Return -EAGAIN for submissions with a per job perfmon if the global perfmon is active.
---

---
 drivers/gpu/drm/v3d/v3d_drv.c     |  1 +
 drivers/gpu/drm/v3d/v3d_drv.h     |  8 ++++++
 drivers/gpu/drm/v3d/v3d_perfmon.c | 42 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_sched.c   | 14 ++++++++---
 drivers/gpu/drm/v3d/v3d_submit.c  | 10 ++++++++
 include/uapi/drm/v3d_drm.h        | 15 +++++++++++
 6 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index d7ff1f5fa481..3c89f0daa5b8 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -214,6 +214,7 @@ static const struct drm_ioctl_desc v3d_drm_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_VALUES, v3d_perfmon_get_values_ioctl, DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(V3D_SUBMIT_CPU, v3d_submit_cpu_ioctl, DRM_RENDER_ALLOW | DRM_AUTH),
 	DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_COUNTER, v3d_perfmon_get_counter_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(V3D_PERFMON_SET_GLOBAL, v3d_perfmon_set_global_ioctl, DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver v3d_drm_driver = {
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index cf4b23369dc4..a0d920ec2b1d 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -179,6 +179,12 @@ struct v3d_dev {
 		u32 num_allocated;
 		u32 pages_allocated;
 	} bo_stats;
+
+	/* To support a performance analysis tool in user space, we require
+	 * a single, globally configured performance monitor (perfmon) for
+	 * all jobs.
+	 */
+	struct v3d_perfmon *global_perfmon;
 };
 
 static inline struct v3d_dev *
@@ -584,6 +590,8 @@ int v3d_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv);
 int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *file_priv);
+int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *file_priv);
 
 /* v3d_sysfs.c */
 int v3d_sysfs_init(struct device *dev);
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 156be13ab2ef..df72171d8c80 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -312,6 +312,9 @@ static int v3d_perfmon_idr_del(int id, void *elem, void *data)
 	if (perfmon == v3d->active_perfmon)
 		v3d_perfmon_stop(v3d, perfmon, false);
 
+	/* If the global perfmon is being destroyed, set it to NULL */
+	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
+
 	v3d_perfmon_put(perfmon);
 
 	return 0;
@@ -383,6 +386,7 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 {
 	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
 	struct drm_v3d_perfmon_destroy *req = data;
+	struct v3d_dev *v3d = v3d_priv->v3d;
 	struct v3d_perfmon *perfmon;
 
 	mutex_lock(&v3d_priv->perfmon.lock);
@@ -392,6 +396,13 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 	if (!perfmon)
 		return -EINVAL;
 
+	/* If the active perfmon is being destroyed, stop it first */
+	if (perfmon == v3d->active_perfmon)
+		v3d_perfmon_stop(v3d, perfmon, false);
+
+	/* If the global perfmon is being destroyed, set it to NULL */
+	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
+
 	v3d_perfmon_put(perfmon);
 
 	return 0;
@@ -451,3 +462,34 @@ int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
 
 	return 0;
 }
+
+int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *file_priv)
+{
+	struct v3d_file_priv *v3d_priv = file_priv->driver_priv;
+	struct drm_v3d_perfmon_set_global *req = data;
+	struct v3d_dev *v3d = to_v3d_dev(dev);
+	struct v3d_perfmon *perfmon;
+
+	if (req->flags & ~DRM_V3D_PERFMON_CLEAR_GLOBAL)
+		return -EINVAL;
+
+	perfmon = v3d_perfmon_find(v3d_priv, req->id);
+	if (!perfmon)
+		return -EINVAL;
+
+	/* If the request is to clear the global performance monitor */
+	if (req->flags & DRM_V3D_PERFMON_CLEAR_GLOBAL) {
+		if (!v3d->global_perfmon)
+			return -EINVAL;
+
+		xchg(&v3d->global_perfmon, NULL);
+
+		return 0;
+	}
+
+	if (cmpxchg(&v3d->global_perfmon, NULL, perfmon))
+		return -EBUSY;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 08d2a2739582..38690740f593 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -120,11 +120,19 @@ v3d_cpu_job_free(struct drm_sched_job *sched_job)
 static void
 v3d_switch_perfmon(struct v3d_dev *v3d, struct v3d_job *job)
 {
-	if (job->perfmon != v3d->active_perfmon)
+	struct v3d_perfmon *perfmon = v3d->global_perfmon;
+
+	if (!perfmon)
+		perfmon = job->perfmon;
+
+	if (perfmon == v3d->active_perfmon)
+		return;
+
+	if (perfmon != v3d->active_perfmon)
 		v3d_perfmon_stop(v3d, v3d->active_perfmon, true);
 
-	if (job->perfmon && v3d->active_perfmon != job->perfmon)
-		v3d_perfmon_start(v3d, job->perfmon);
+	if (perfmon && v3d->active_perfmon != perfmon)
+		v3d_perfmon_start(v3d, perfmon);
 }
 
 static void
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index d607aa9c4ec2..9e439c9f0a93 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -981,6 +981,11 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
 		goto fail;
 
 	if (args->perfmon_id) {
+		if (v3d->global_perfmon) {
+			ret = -EAGAIN;
+			goto fail_perfmon;
+		}
+
 		render->base.perfmon = v3d_perfmon_find(v3d_priv,
 							args->perfmon_id);
 
@@ -1196,6 +1201,11 @@ v3d_submit_csd_ioctl(struct drm_device *dev, void *data,
 		goto fail;
 
 	if (args->perfmon_id) {
+		if (v3d->global_perfmon) {
+			ret = -EAGAIN;
+			goto fail_perfmon;
+		}
+
 		job->base.perfmon = v3d_perfmon_find(v3d_priv,
 						     args->perfmon_id);
 		if (!job->base.perfmon) {
diff --git a/include/uapi/drm/v3d_drm.h b/include/uapi/drm/v3d_drm.h
index 87fc5bb0a61e..7c2ad9d0270d 100644
--- a/include/uapi/drm/v3d_drm.h
+++ b/include/uapi/drm/v3d_drm.h
@@ -43,6 +43,7 @@ extern "C" {
 #define DRM_V3D_PERFMON_GET_VALUES                0x0a
 #define DRM_V3D_SUBMIT_CPU                        0x0b
 #define DRM_V3D_PERFMON_GET_COUNTER               0x0c
+#define DRM_V3D_PERFMON_SET_GLOBAL                0x0d
 
 #define DRM_IOCTL_V3D_SUBMIT_CL           DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_SUBMIT_CL, struct drm_v3d_submit_cl)
 #define DRM_IOCTL_V3D_WAIT_BO             DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_WAIT_BO, struct drm_v3d_wait_bo)
@@ -61,6 +62,8 @@ extern "C" {
 #define DRM_IOCTL_V3D_SUBMIT_CPU          DRM_IOW(DRM_COMMAND_BASE + DRM_V3D_SUBMIT_CPU, struct drm_v3d_submit_cpu)
 #define DRM_IOCTL_V3D_PERFMON_GET_COUNTER DRM_IOWR(DRM_COMMAND_BASE + DRM_V3D_PERFMON_GET_COUNTER, \
 						   struct drm_v3d_perfmon_get_counter)
+#define DRM_IOCTL_V3D_PERFMON_SET_GLOBAL  DRM_IOW(DRM_COMMAND_BASE + DRM_V3D_PERFMON_SET_GLOBAL, \
+						   struct drm_v3d_perfmon_set_global)
 
 #define DRM_V3D_SUBMIT_CL_FLUSH_CACHE             0x01
 #define DRM_V3D_SUBMIT_EXTENSION		  0x02
@@ -765,6 +768,18 @@ struct drm_v3d_perfmon_get_counter {
 	__u8 reserved[7];
 };
 
+#define DRM_V3D_PERFMON_CLEAR_GLOBAL    0x0001
+
+/**
+ * struct drm_v3d_perfmon_set_global - ioctl to define a global performance
+ * monitor that is used for all job. If a global performance monitor is
+ * defined, jobs with a self-defined performance monitor are not allowed.
+ */
+struct drm_v3d_perfmon_set_global {
+	__u32 flags;
+	__u32 id;
+};
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.47.0



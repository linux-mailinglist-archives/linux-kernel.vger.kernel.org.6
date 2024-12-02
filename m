Return-Path: <linux-kernel+bounces-427660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 575149E047A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A0C169730
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A41F20408C;
	Mon,  2 Dec 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt027bi2"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A123203712
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148386; cv=none; b=PAclPbMeKYFltkSrpatIdU1uncUE2x1f4N69tSZoWtLB2vfsxQMGGPeYvJHMQl1L9+Nl8KAf0KOGgV0Xk6tZhx8aiPYcP3NfNgZn8AySmVvMFkFXDd3STJK1MJBRQpB7O02mYFiFPyszXhYzSMwdR52/bbaYgDkljqhpiYJdZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148386; c=relaxed/simple;
	bh=8g0XkQSm2bu+p9gSbj8G5PyazebOHmfgoRKK17r8RH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZtVnnNE8PlZk/m5vVK4WkPv98o+w+pZPiX/XwM9KFY0PPUlN3MkTbFjuMit4kxxg6fgeCM6IQpgGzSP+wBwYuvex2DW1VW/1TIc4+SjRGLKhRwQxp6YuQ/e0C1/RqZ38jXkL5WG90vLKJyIDlHlYjQokrubPSzAhAIIyPsUXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt027bi2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa51b8c5f4dso630657266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733148382; x=1733753182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOw5aKer918R+GPLPrMDEaNawIu96Hv3OhcGYY02/sE=;
        b=Lt027bi230AV7Zw0sowxxGb1G8gmpWV0Gj9qAA1KQPwftVQ6kNO/CRU+VqAJNhLg2N
         ul/LDAHrSeXwOk6b0Y+pHS4EbGzUYctdVBfzkL/+bTsC0vO4+CJOstV41P6QpPNPrIec
         XmtTUAKg5Yj27a2/DQnqkvjhMygI+uOk+G3Q+u8WEi5La6B7jifeJhhOJSVhO/6FyzBr
         eG1KwsD5tQVRPjl4fi34CjYA53DQS7eLViXW539STPoSwjj0eymtJH75Z4EcwdhRPQXX
         VaYfzu/Q0YECDsoCa3opgh2YxZNA4jMdplrimul4mIbaT2I2fozSzJOwBVqtmBayNlcN
         ZL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148382; x=1733753182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOw5aKer918R+GPLPrMDEaNawIu96Hv3OhcGYY02/sE=;
        b=oPkyWg3c9+VLVRxI8zmnZMjdPUZU0z1OLsG8aA2PW3afOWW+foDJ2751ML4fVeTJTX
         TecWice9MGen4bId7PooiR54gyGqMTf8WhwpwKPIVN50oTE+IrlG+G9mLOuH+2GyrvJv
         dKInGKNekmtaaYosHVAxkCNzFUpJgd15LAB4lo/260psxSF9uEdhOKn+TbGaC0MEaxXm
         /CvMaVnOLy/YCeidvJm3cCfw0Ta4KKjoZdFCxlwUlCL4NRj2oMRMnqUCP2h/V8+BI0J9
         WxeZKvAviQas8Dg3g5l0prlnSL53GkGhayapsp2JoaGMHljAt5SNFf3LGPc+354oxVlF
         PhPA==
X-Forwarded-Encrypted: i=1; AJvYcCUOUHTSIAowEmqUcHWDpXcD4k505CP4JDMytssgZvZpP5ciWzu+qmweLjmrZIFkxYMMgl2RyqrI0YhAYjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2AfAykcWQc1qqiKTXdr0ON5Kqv1Java88/h+7xacex8cVUVUM
	QzlVhkyujeNSEgRMc0gth5dOchBZ4YJ5OTAM8qLo/gwaDpGpFav4
X-Gm-Gg: ASbGncskHZKB4neQHQrOtJcE0ETpiKUxgAjWJoQ6F26nzw3JAjIyWn/uacBcyVUDQpM
	FaQA8ZPzQFU+9SFBjaR/RT0DR4znIjuIdc0mqEFiUWogMdfxx+nIHhHjGsCkWZDSvJi1RPbNiYh
	f8j9UEUTBFG3M7tIlj8YsvwB8r/cTQRSE+QiUN/le2a43KarKKPVbE21koX0AG6/9YNnRHUzIJt
	fPs3ydzTa3IwFIok5uxuEgGVlTHm7U4jX2ztT691gKdqFuZ4ZHv6o4t1jEREuRqly3RTm9i5DiJ
	6HuviZKhW/5j4SWBSew/oON2PWAhKeulhI4=
X-Google-Smtp-Source: AGHT+IH6ZCzkk1EA5lX0p1IOT+zymQfHxPv08GrP+s5FRfXJK4c5xSbCNlJ5zk2biFUBJY/zGu21vA==
X-Received: by 2002:a17:906:9d2:b0:aa5:451c:ce29 with SMTP id a640c23a62f3a-aa58102b501mr1859891366b.39.1733148381190;
        Mon, 02 Dec 2024 06:06:21 -0800 (PST)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at. [62.178.82.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5996c11b4sm510616766b.7.2024.12.02.06.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:06:18 -0800 (PST)
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
Subject: [PATCH v4] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
Date: Mon,  2 Dec 2024 15:06:13 +0100
Message-ID: <20241202140615.74802-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.47.1
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
Changes in v4:
- Rebased on drm-misc-next.
- Factored out a small change as separate patch.
- Fixed some grammar mistakes: s/job/jobs.

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
 drivers/gpu/drm/v3d/v3d_drv.c     |  1 +
 drivers/gpu/drm/v3d/v3d_drv.h     |  8 +++++++
 drivers/gpu/drm/v3d/v3d_perfmon.c | 37 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_sched.c   | 14 +++++++++---
 drivers/gpu/drm/v3d/v3d_submit.c  | 10 +++++++++
 include/uapi/drm/v3d_drm.h        | 15 +++++++++++++
 6 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index fb35c5c3f1a7..8e5cacfa38d3 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -224,6 +224,7 @@ static const struct drm_ioctl_desc v3d_drm_ioctls[] = {
 	DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_VALUES, v3d_perfmon_get_values_ioctl, DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(V3D_SUBMIT_CPU, v3d_submit_cpu_ioctl, DRM_RENDER_ALLOW | DRM_AUTH),
 	DRM_IOCTL_DEF_DRV(V3D_PERFMON_GET_COUNTER, v3d_perfmon_get_counter_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(V3D_PERFMON_SET_GLOBAL, v3d_perfmon_set_global_ioctl, DRM_RENDER_ALLOW),
 };

 static const struct drm_driver v3d_drm_driver = {
diff --git a/drivers/gpu/drm/v3d/v3d_drv.h b/drivers/gpu/drm/v3d/v3d_drv.h
index de73eefff9ac..dc1cfe2e14be 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.h
+++ b/drivers/gpu/drm/v3d/v3d_drv.h
@@ -183,6 +183,12 @@ struct v3d_dev {
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
@@ -594,6 +600,8 @@ int v3d_perfmon_get_values_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv);
 int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
 				  struct drm_file *file_priv);
+int v3d_perfmon_set_global_ioctl(struct drm_device *dev, void *data,
+				 struct drm_file *file_priv);

 /* v3d_sysfs.c */
 int v3d_sysfs_init(struct device *dev);
diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index b4c3708ea781..a1429b9684e0 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -313,6 +313,9 @@ static int v3d_perfmon_idr_del(int id, void *elem, void *data)
 	if (perfmon == v3d->active_perfmon)
 		v3d_perfmon_stop(v3d, perfmon, false);

+	/* If the global perfmon is being destroyed, set it to NULL */
+	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
+
 	v3d_perfmon_put(perfmon);

 	return 0;
@@ -398,6 +401,9 @@ int v3d_perfmon_destroy_ioctl(struct drm_device *dev, void *data,
 	if (perfmon == v3d->active_perfmon)
 		v3d_perfmon_stop(v3d, perfmon, false);

+	/* If the global perfmon is being destroyed, set it to NULL */
+	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
+
 	v3d_perfmon_put(perfmon);

 	return 0;
@@ -457,3 +463,34 @@ int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,

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
index 99ac4995b5a1..a6c3760da6ed 100644
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
index 2376c73abca1..97b1faf04fc4 100644
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
@@ -766,6 +769,18 @@ struct drm_v3d_perfmon_get_counter {
 	__u8 reserved[7];
 };

+#define DRM_V3D_PERFMON_CLEAR_GLOBAL    0x0001
+
+/**
+ * struct drm_v3d_perfmon_set_global - ioctl to define a global performance
+ * monitor that is used for all jobs. If a global performance monitor is
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
2.47.1



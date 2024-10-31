Return-Path: <linux-kernel+bounces-391275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340829B84A7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 21:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580DF1C21A62
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 20:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352C41CB306;
	Thu, 31 Oct 2024 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAN/+hYX"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486601411EE
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 20:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407912; cv=none; b=e/UCCqYZpHx7iAJxOS3irptizFHkVx3DC2s7OBgmIHB23FdDTtPba1S8bdFotgPOWRRaQc7P133isk5kYviATgkBO6ccvDPSYnhxTO3KrBdtID/EMCxQn++2CWtpBG2MI4ARCkKqZaolocKwnz1AxpDZvh51Onx6auKT5q7GCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407912; c=relaxed/simple;
	bh=OQuhFSR77dCOBBVb5+5+2TWkQQE1onU7NDs8wBl9TYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c6kdbCTBdptlRa5TeEsUSELN3XAiCTwHZ085J9CBX70M2AulTozbVccSnpdHXLEjjrFziNk38jgh4ClSCwHpA01MpDp2IaFI07iYj4vA6Rd1s5UImpVfdjuBUPWIZ0QCU2ZwtpguX87mtbVEpYNVygSrDvYfp1KjSdUjX8i7hCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAN/+hYX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d808ae924so765840f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730407904; x=1731012704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7TKLW+tNyc+ixhto9+v9npiESfus2TEfzItXeH9SqQ4=;
        b=SAN/+hYX9KUmgUd7KG2XJFTdgHcZpupWau+uysrUcDCPvrwJSTOe9xLDQ5WuXvNg9k
         FimT2lhc9WShJlXGeFvQdKh/u2Duk7x6J/Cfe4O8jUheethhUPifRvGjothcNSu5LEQe
         gngBuHJUh7Vq6chaP08kJJop5habbQEJVpyOfvHEeLxa/ikeiUmMCUKAaGY7ze561HWN
         sh3qeihJmr/hR8H3BmxRNwUa9SNfPpmWfS2YLWzFJV8mH559vegndYDc7F3U6ls641iv
         sJoyQCoi/aMM5zC6sWkosx3K3XjcWrK3ZrT8ly9OVZoE+Fo5tnC0mGtlhqDLSIC4jBlb
         ruow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730407904; x=1731012704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TKLW+tNyc+ixhto9+v9npiESfus2TEfzItXeH9SqQ4=;
        b=dPLkbZ4AFlUu9GL/VcpthCgi7EYfH+lHmGQOLL8plE6SR4H9jecVvWMbBXK0oHjPJz
         etOvTOSCFKmm75szBQlkUo3aRLdK8uoRmVy9sFjFd7fOuY7Aur8OJ48vbjrF6o1Z7aSp
         LQ01IIFxiK5Kxc/I9kYlQGXpuVVZCgQIL+KWdbueJSwxIDy+/b/D5RlfZWMexrdmdao9
         iZYx0DlsHBnQMLMq3hRXw4mFK6b18rf6GncBuvuLtLf1qDYw9Yl2f6C6IoGZyhe9gWA2
         Wo1OVSB/Jbl4v9Ta3Cw3BCOPv3GyFApCXh/as3hg/YRXuv4j16ZMIph/qwvuWbwrrSB+
         FQcg==
X-Forwarded-Encrypted: i=1; AJvYcCVqj6IFHwubbH7YjjI1AtZZTTHjFD6nF/MStbW5nHAdRi/7OCmqt4dT2lO1HVrBQT0nC8m8ZEWs+khPZ5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlDp2Ziek8H4eVXmDLKRS5T4+QGC95KzNIyWPEMSW1daTDNp4M
	gxT2ndov6/lxneMiS6O0yHPC3lCW/1wrsTrpHp/O5ri5JOacyf2O
X-Google-Smtp-Source: AGHT+IEsUj0VmR8SbEGLFZOPMwI3LzTQblury6cZ3YW7j5hSI35+WSoXpyO8ZD9Z9ppE+mwAJmqexg==
X-Received: by 2002:adf:e3c9:0:b0:37d:4a80:c395 with SMTP id ffacd0b85a97d-3806113ce39mr14122019f8f.21.1730407904116;
        Thu, 31 Oct 2024 13:51:44 -0700 (PDT)
Received: from localhost.localdomain (62-178-82-42.cable.dynamic.surfer.at. [62.178.82.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7435sm3141796f8f.52.2024.10.31.13.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 13:51:43 -0700 (PDT)
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
Subject: [PATCH v2] drm/v3d: Add DRM_IOCTL_V3D_PERFMON_SET_GLOBAL
Date: Thu, 31 Oct 2024 21:51:38 +0100
Message-ID: <20241031205140.541907-1-christian.gmeiner@gmail.com>
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
performance tracking across submissions.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>

---
Changes in v2:
- Reworked commit message.
- Removed num_perfmon counter for tracking perfmon allocations.
- Allowing allocation of perfmons when the global perfmon is active.
- Return -EAGAIN for submissions with a per job perfmon if the global perfmon is active.
---
 drivers/gpu/drm/v3d/v3d_drv.c     |  1 +
 drivers/gpu/drm/v3d/v3d_drv.h     |  8 ++++++++
 drivers/gpu/drm/v3d/v3d_perfmon.c | 34 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/v3d/v3d_sched.c   | 14 ++++++++++---
 drivers/gpu/drm/v3d/v3d_submit.c  | 10 +++++++++
 include/uapi/drm/v3d_drm.h        | 15 ++++++++++++++
 6 files changed, 79 insertions(+), 3 deletions(-)

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
index 156be13ab2ef..bf42303c292b 100644
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
@@ -451,3 +454,34 @@ int v3d_perfmon_get_counter_ioctl(struct drm_device *dev, void *data,
 
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
index 87fc5bb0a61e..709724fe28e6 100644
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
+/*
+ * struct drm_v3d_perfmon_set_global - ioctl to define a
+ * global performance counter that is used if a job has
+ * not assigned one on its own.
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



Return-Path: <linux-kernel+bounces-563155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D64A6379A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C30188ED81
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 21:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779EA1E1E0D;
	Sun, 16 Mar 2025 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ZHpRVe4M"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB5195980
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742161980; cv=pass; b=kbLDYHlDIm1n1e35OB2gHzyI7FyV+akK848sWiufEHOckGF07rBiw3Fpz6DuWKsnWFLEJygmT8ZcY2QPI2LupQ3Q/slGzmgzzvsMpfkJUmIbPCrP9Xbg4FHZ5gcVUbCS+ixAhvg5kxxHghOYiTLMgYIVoyrXd7T3PPIlK5daiz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742161980; c=relaxed/simple;
	bh=qQA6OTbNF47rAmXGv9h09a0c0Mv/WtSxx25UgAWigyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMzloUiE43koeifcjYfuco3g6II/d21E6ZDPehAeQUZ/ej1XIYFkhWKZ7oboaVjnJEfyfXg4vdKNQYK5XIiEyfGbDTNQdnV3z9nyD3a3XDynwcgWPuJU2GyR5hQ08hJ9By87IIH7QjpStZPkTOxc+9B5gMAesuTiBNESNMNlaZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=ZHpRVe4M; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742161952; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mHKAZTWd8u3cotcpn0328vk/MmJzjHsvgG0P42iH4s/Qjq0bvhpNu+9QQI8+i9m30KCLlQxzpUiuk8wFZtQZ0Lc+deIMy+hMMdzYC0EzSqWan7A3+pGpyUmsqJayfCnljBL9rzeYaJWarUGcFQaTBVFZNPjyKoYFY5zIVaFFB3Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742161952; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HhL0GLMTz2Ju84VAoiVwHc8lIHzsuy6JBZH84oiDEiA=; 
	b=DZsjZ5H5bFy2W5RiGYoc4UBCGG5y2Z/ha7laT81a/ooTwFPR1F38U+r7ZsUxYcDPxogzh12Olm4t8EHXEbSosIEMwU42kvAT5mmW369Z6Q4tcltNLKUS0lJZPzVbzc8c80+DjFutKr7QtzUYjTfUlczwh2XieKMyi1VvwsmBtBs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742161952;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HhL0GLMTz2Ju84VAoiVwHc8lIHzsuy6JBZH84oiDEiA=;
	b=ZHpRVe4M4ssdlXYj6NFI43ewVkNTwBuYFugnRtcdQBUFmnHAVYLS10soUUKkG9Hn
	IehuFGuxKvl1SldX846LVLKe63tNLnI7iA0dmnLN5yX2mm+lvVTkDLP5VJhYo680II7
	R7xudXVajPCE4fOvNqw7sdx1pYNx3wbNjP3inCjA=
Received: by mx.zohomail.com with SMTPS id 1742161951219560.9766150699046;
	Sun, 16 Mar 2025 14:52:31 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/panthor: Add driver IOCTL for setting BO labels
Date: Sun, 16 Mar 2025 21:51:33 +0000
Message-ID: <20250316215139.3940623-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
References: <20250316215139.3940623-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow UM to label a BO for which it possesses a DRM handle.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 31 +++++++++++++++++++++++++++
 include/uapi/drm/panthor_drm.h        | 14 ++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 310bb44abe1a..f41b8946258f 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1330,6 +1330,35 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
 	return 0;
 }
 
+static int panthor_ioctl_label_bo(struct drm_device *ddev, void *data,
+				  struct drm_file *file)
+{
+	struct drm_panthor_label_bo *args = data;
+	struct drm_gem_object *obj;
+	const char *label;
+	int ret = 0;
+
+	obj = drm_gem_object_lookup(file, args->handle);
+	if (!obj)
+		return -ENOENT;
+
+	if (args->len && args->label) {
+		label = strndup_user(u64_to_user_ptr(args->label), args->len + 1);
+		if (IS_ERR(label)) {
+			ret = PTR_ERR(label);
+			goto err_label;
+		}
+	} else
+		label = NULL;
+
+	panthor_gem_label_bo(obj, label);
+
+err_label:
+	drm_gem_object_put(obj);
+
+	return ret;
+}
+
 static int
 panthor_open(struct drm_device *ddev, struct drm_file *file)
 {
@@ -1399,6 +1428,7 @@ static const struct drm_ioctl_desc panthor_drm_driver_ioctls[] = {
 	PANTHOR_IOCTL(TILER_HEAP_CREATE, tiler_heap_create, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(TILER_HEAP_DESTROY, tiler_heap_destroy, DRM_RENDER_ALLOW),
 	PANTHOR_IOCTL(GROUP_SUBMIT, group_submit, DRM_RENDER_ALLOW),
+	PANTHOR_IOCTL(LABEL_BO, label_bo, DRM_RENDER_ALLOW),
 };
 
 static int panthor_mmap(struct file *filp, struct vm_area_struct *vma)
@@ -1508,6 +1538,7 @@ static void panthor_debugfs_init(struct drm_minor *minor)
  * - 1.2 - adds DEV_QUERY_GROUP_PRIORITIES_INFO query
  *       - adds PANTHOR_GROUP_PRIORITY_REALTIME priority
  * - 1.3 - adds DRM_PANTHOR_GROUP_STATE_INNOCENT flag
+ * - 1.4 - adds DRM_IOCTL_PANTHOR_LABEL_BO ioctl
  */
 static const struct drm_driver panthor_drm_driver = {
 	.driver_features = DRIVER_RENDER | DRIVER_GEM | DRIVER_SYNCOBJ |
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 97e2c4510e69..1a7ed567d36a 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -127,6 +127,9 @@ enum drm_panthor_ioctl_id {
 
 	/** @DRM_PANTHOR_TILER_HEAP_DESTROY: Destroy a tiler heap. */
 	DRM_PANTHOR_TILER_HEAP_DESTROY,
+
+	/** @DRM_PANTHOR_LABEL_BO: Label a BO. */
+	DRM_PANTHOR_LABEL_BO,
 };
 
 /**
@@ -977,6 +980,15 @@ struct drm_panthor_tiler_heap_destroy {
 	__u32 pad;
 };
 
+/**
+ * struct drm_panthor_label_bo - Arguments passed to DRM_IOCTL_PANTHOR_LABEL_BO
+ */
+struct drm_panthor_label_bo {
+	__u32 handle;
+	__u32 len;
+	__u64 label;
+};
+
 /**
  * DRM_IOCTL_PANTHOR() - Build a Panthor IOCTL number
  * @__access: Access type. Must be R, W or RW.
@@ -1019,6 +1031,8 @@ enum {
 		DRM_IOCTL_PANTHOR(WR, TILER_HEAP_CREATE, tiler_heap_create),
 	DRM_IOCTL_PANTHOR_TILER_HEAP_DESTROY =
 		DRM_IOCTL_PANTHOR(WR, TILER_HEAP_DESTROY, tiler_heap_destroy),
+	DRM_IOCTL_PANTHOR_LABEL_BO =
+		DRM_IOCTL_PANTHOR(WR, LABEL_BO, label_bo),
 };
 
 #if defined(__cplusplus)
-- 
2.48.1



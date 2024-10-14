Return-Path: <linux-kernel+bounces-364499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD62A99D561
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA951C23102
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3991C303D;
	Mon, 14 Oct 2024 17:15:02 +0000 (UTC)
Received: from erminea.space (erminea.space [51.250.125.203])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 177651C0DD6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.250.125.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926102; cv=none; b=cseoWQA/MzRiU3FL+lgRTwmXQJyq4Sow40e7gmgHwXShWHibXTHncEl716+9EmM0vVNe4QnV3lbqybQGtqNwETcOUvDYU2clpu7PYG96SC5PBBHI4MHkpfIykVtoYfmvsPm2AY/PSKiuHpr+6AtlIo0EivKtacFBTl8BS5JbCJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926102; c=relaxed/simple;
	bh=O8OGoWMGZ2OnMDIalxJe5SyY6FwRPz7uMByJnZiyGJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o1EloC0RmmqGWCShAW6dZSc3s8wijGlC/WiZeZlGwhr9KO9+IkOO8FgHXTZ3+ATdJh6VlT3bG7zTJUVAEVSNpUREdpxgI6Zia2+uX4UW7icVZPMznRZkw4AU7sFLOXFMdu8WnBv0DbZy49d8QoJcgjwNiHgVyadqN2TajR7xzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erminea.space; spf=pass smtp.mailfrom=erminea.space; arc=none smtp.client-ip=51.250.125.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=erminea.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=erminea.space
Received: (qmail 16812 invoked from network); 14 Oct 2024 17:08:16 -0000
Received: from localhost. (HELO erminea.space) (127.0.0.1)
  by 0.0.0.0 with SMTP; 14 Oct 2024 17:08:16 -0000
Received: from localhost.localdomain ([37.204.49.201])
	by erminea.space with ESMTPSA
	id YP79JwBQDWeoQQAAH+dm7w
	(envelope-from <mustela@erminea.space>); Mon, 14 Oct 2024 20:08:16 +0300
From: Peter Shkenev <mustela@erminea.space>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: use generic dumb_map_offset implementation
Date: Mon, 14 Oct 2024 20:07:58 +0300
Message-ID: <20241014170801.71231-1-mustela@erminea.space>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, virtio uses its own dumb_map_offset implementation,
virtio_gpu_mode_dumb_mmap. It works similarly to generic implementation,
drm_gem_dumb_map_offset, and using the generic implementation is
preferable (and making drivers to do so is a task stated on the DRM
subsystem's TODO list).

Thus, make driver use the generic implementation. This includes
VIRTGPU_MAP ioctl so it cannot be used to circumvent rules imposed by
drm_gem_dumb_map_offset (imported objects cannot be mapped).

Signed-off-by: Peter Shkenev <mustela@erminea.space>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c   |  1 -
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 15 ---------------
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  3 ++-
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index ffca6e2e1c9a..909808398d66 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -184,7 +184,6 @@ static const struct drm_driver driver = {
 	.postclose = virtio_gpu_driver_postclose,
 
 	.dumb_create = virtio_gpu_mode_dumb_create,
-	.dumb_map_offset = virtio_gpu_mode_dumb_mmap,
 
 	DRM_FBDEV_SHMEM_DRIVER_OPS,
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 7db48d17ee3a..aefbb49481f1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -99,21 +99,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	return ret;
 }
 
-int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
-			      struct drm_device *dev,
-			      uint32_t handle, uint64_t *offset_p)
-{
-	struct drm_gem_object *gobj;
-
-	BUG_ON(!offset_p);
-	gobj = drm_gem_object_lookup(file_priv, handle);
-	if (gobj == NULL)
-		return -ENOENT;
-	*offset_p = drm_vma_node_offset_addr(&gobj->vma_node);
-	drm_gem_object_put(gobj);
-	return 0;
-}
-
 int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 			       struct drm_file *file)
 {
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index e4f76f315550..13f3ed60a0e5 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -30,6 +30,7 @@
 #include <linux/uaccess.h>
 
 #include <drm/drm_file.h>
+#include <drm/drm_gem.h>
 #include <drm/virtgpu_drm.h>
 
 #include "virtgpu_drv.h"
@@ -80,7 +81,7 @@ static int virtio_gpu_map_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_virtgpu_map *virtio_gpu_map = data;
 
-	return virtio_gpu_mode_dumb_mmap(file, vgdev->ddev,
+	return drm_gem_dumb_map_offset(file, vgdev->ddev,
 					 virtio_gpu_map->handle,
 					 &virtio_gpu_map->offset);
 }
-- 
2.46.2



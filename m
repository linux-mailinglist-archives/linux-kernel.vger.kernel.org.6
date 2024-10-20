Return-Path: <linux-kernel+bounces-373498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDA19A5770
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 01:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C6812822B5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 23:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A174F1991BD;
	Sun, 20 Oct 2024 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="WMq6dWaU"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F771990CE
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729465719; cv=pass; b=M+ITHLwnuFYtCIuRZqi289Y8hhfZHoLvxuKscMrHVT0kALS+3xGdIMySUeOz0DYrXsCJnOrEx72/2JSz+gmVan9hmAc2XDrjlhNwYaXX8Z+jreWhiq2c1T7Q7n3QPVs2xLz6Tc6RXivQOexlommS9jo7HbgNkR8LcXs/bVcSfmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729465719; c=relaxed/simple;
	bh=GG+yAJEPibPNTwOOPr76s9wPVqp5W4O4sdKPRu9S7ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXAf+EKHH8yCfU57V6BkhwlRv102i5ldD0wDqxsOgcquSpO7+W7M4ThzgKgw1dpdp1yGRDy7BYlxnKuBFkxfttN4Dc8FEZ/GEK5Y9rYKZb0+GV2RaZqH8Wni7AjYi15FtMaLGv28+R2ajTkMcV1VhgCpNqww2GcPmnH3HAVlxyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=WMq6dWaU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1729465707; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d/H/pOGfCSEFfRKwoys+TLlZo7n1Lae+zWnmdaSDT/O7HPAfJTJolW4Abo9m9M/LVN5G2fj3P1vKP1DId8V9VMwxXvuCMCufB1ntWlHm6vhGbbeKCuQZ/SAnYFNtpZ7xX0DTQKJAKY1hoaIZ+BMVVm+x9957PXgwQKNvnPSrmwQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1729465707; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NSMo1G/5mzlO6sSUsZnRrHjoUcA/glI1EUTfxStqJa0=; 
	b=IYEC5kav78yWOWSs7wFbOoc48wxJJeoN2jSnqPv4/PEnHa9MSBezgwIdqst3bBZza4E7yTrgRaDMTQ6J4p1CcIxEypI+HCqqOP829OfvX4oj/eTWdyeX53ez18dYQxJB8MlTspa5jbaY9ZX4PpJjQrGRLq6ijO83mjl2UK/Ness=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1729465707;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NSMo1G/5mzlO6sSUsZnRrHjoUcA/glI1EUTfxStqJa0=;
	b=WMq6dWaU7D5GB2HEZs2emoYjNzUIEVdCjH/ODFj5w+cd6sHpxB6/9X8d/3iWDiy3
	VT6xAdBavi8td7mwrinN7/iUTscKBiVnXqdLdEYY0z6WsdjWcwrGEOBrXglHRxSAd6n
	DBCK/jpVr03gSFBGJNOdNFwqVQeKdRPAcLcE2uqk=
Received: by mx.zohomail.com with SMTPS id 172946570460449.947607983647686;
	Sun, 20 Oct 2024 16:08:24 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Rob Clark <robdclark@gmail.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Kim Dongwon <dongwon.kim@intel.com>,
	Kasireddy Vivek <vivek.kasireddy@intel.com>
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v3 2/2] drm/virtio: New fence for every plane update
Date: Mon, 21 Oct 2024 02:08:03 +0300
Message-ID: <20241020230803.247419-2-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
References: <20241020230803.247419-1-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Dongwon Kim <dongwon.kim@intel.com>

Having a fence linked to a virtio_gpu_framebuffer in the plane update
sequence would cause conflict when several planes referencing the same
framebuffer (e.g. Xorg screen covering multi-displays configured for an
extended mode) and those planes are updated concurrently. So it is needed
to allocate a fence for every plane state instead of the framebuffer.

Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
[dmitry.osipenko@collabora.com: rebase, fix up, edit commit message]
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  7 ++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 58 +++++++++++++++++---------
 2 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 64c236169db8..5dc8eeaf7123 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -194,6 +194,13 @@ struct virtio_gpu_framebuffer {
 #define to_virtio_gpu_framebuffer(x) \
 	container_of(x, struct virtio_gpu_framebuffer, base)
 
+struct virtio_gpu_plane_state {
+	struct drm_plane_state base;
+	struct virtio_gpu_fence *fence;
+};
+#define to_virtio_gpu_plane_state(x) \
+	container_of(x, struct virtio_gpu_plane_state, base)
+
 struct virtio_gpu_queue {
 	struct virtqueue *vq;
 	spinlock_t qlock;
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index ab7232921cb7..2add67c6b66d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -67,11 +67,28 @@ uint32_t virtio_gpu_translate_format(uint32_t drm_fourcc)
 	return format;
 }
 
+static struct
+drm_plane_state *virtio_gpu_plane_duplicate_state(struct drm_plane *plane)
+{
+	struct virtio_gpu_plane_state *new;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	__drm_atomic_helper_plane_duplicate_state(plane, &new->base);
+
+	return &new->base;
+}
+
 static const struct drm_plane_funcs virtio_gpu_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.reset			= drm_atomic_helper_plane_reset,
-	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
+	.atomic_duplicate_state = virtio_gpu_plane_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_plane_destroy_state,
 };
 
@@ -139,11 +156,13 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 	struct virtio_gpu_object *bo;
 
 	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+	vgplane_st = to_virtio_gpu_plane_state(plane->state);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
-	if (vgfb->fence) {
+	if (vgplane_st->fence) {
 		struct virtio_gpu_object_array *objs;
 
 		objs = virtio_gpu_array_alloc(1);
@@ -152,13 +171,11 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
 		virtio_gpu_array_lock_resv(objs);
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
-					      width, height, objs, vgfb->fence);
+					      width, height, objs,
+					      vgplane_st->fence);
 		virtio_gpu_notify(vgdev);
-
-		dma_fence_wait_timeout(&vgfb->fence->f, true,
+		dma_fence_wait_timeout(&vgplane_st->fence->f, true,
 				       msecs_to_jiffies(50));
-		dma_fence_put(&vgfb->fence->f);
-		vgfb->fence = NULL;
 	} else {
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
 					      width, height, NULL, NULL);
@@ -248,12 +265,14 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 	struct drm_device *dev = plane->dev;
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 	struct virtio_gpu_object *bo;
 
 	if (!new_state->fb)
 		return 0;
 
 	vgfb = to_virtio_gpu_framebuffer(new_state->fb);
+	vgplane_st = to_virtio_gpu_plane_state(new_state);
 	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
 
 	drm_gem_plane_helper_prepare_fb(plane, new_state);
@@ -261,10 +280,11 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 	if (!bo || (plane->type == DRM_PLANE_TYPE_PRIMARY && !bo->guest_blob))
 		return 0;
 
-	if (bo->dumb && (plane->state->fb != new_state->fb)) {
-		vgfb->fence = virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context,
+	if (bo->dumb) {
+		vgplane_st->fence = virtio_gpu_fence_alloc(vgdev,
+						     vgdev->fence_drv.context,
 						     0);
-		if (!vgfb->fence)
+		if (!vgplane_st->fence)
 			return -ENOMEM;
 	}
 
@@ -274,15 +294,15 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
 					struct drm_plane_state *state)
 {
-	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 
 	if (!state->fb)
 		return;
 
-	vgfb = to_virtio_gpu_framebuffer(state->fb);
-	if (vgfb->fence) {
-		dma_fence_put(&vgfb->fence->f);
-		vgfb->fence = NULL;
+	vgplane_st = to_virtio_gpu_plane_state(state);
+	if (vgplane_st->fence) {
+		dma_fence_put(&vgplane_st->fence->f);
+		vgplane_st->fence = NULL;
 	}
 }
 
@@ -295,6 +315,7 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_output *output = NULL;
 	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_plane_state *vgplane_st;
 	struct virtio_gpu_object *bo = NULL;
 	uint32_t handle;
 
@@ -307,6 +328,7 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 
 	if (plane->state->fb) {
 		vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+		vgplane_st = to_virtio_gpu_plane_state(plane->state);
 		bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
 		handle = bo->hw_res_handle;
 	} else {
@@ -326,11 +348,9 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 			(vgdev, 0,
 			 plane->state->crtc_w,
 			 plane->state->crtc_h,
-			 0, 0, objs, vgfb->fence);
+			 0, 0, objs, vgplane_st->fence);
 		virtio_gpu_notify(vgdev);
-		dma_fence_wait(&vgfb->fence->f, true);
-		dma_fence_put(&vgfb->fence->f);
-		vgfb->fence = NULL;
+		dma_fence_wait(&vgplane_st->fence->f, true);
 	}
 
 	if (plane->state->fb != old_state->fb) {
-- 
2.47.0



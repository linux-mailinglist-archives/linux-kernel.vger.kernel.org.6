Return-Path: <linux-kernel+bounces-389911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F25849B72D4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507A5B233C9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC83136664;
	Thu, 31 Oct 2024 03:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee88jRex"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630D12FB2E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730344895; cv=none; b=VumQRe06bUyOWE2tSNTLUuTSzOKayDCvvDGCeIxvtbaEeHHRkws7XZDLbVnZg4fdvgO7EuKZNH+SSUCjQ/JpjsjIleamUSiatNhPZei2Bb+XMov6Xihwpl+6UHET6Z4xBDei1ktFeLIwp1RPxmaB54hShdmZuR4ZEnTLEB/zKnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730344895; c=relaxed/simple;
	bh=oW2wdop8FS3JNzC6J+JP+T3oTUsRHNR2yFw85yO2Jvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ti1B9oSNV0EIZOeJM19GOwj4NKrHrjWpUI26zonvGR183YI8Z1MwR5+0hliHoL5rNDyicT6X9f2oICTM/OjMdOnb/1QO/s3mpounmpwAyYVemwfmnMfST8wWcoWliOndEbwT+l4CvI4r84NKvAODlcZ0zsrSIhRyrPiWKnRo2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ee88jRex; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730344891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8sQ6ECpE0IwrsdCAvpsqRFFkwrnz/OlwUrybT8imC7k=;
	b=ee88jRexujcLLKJIgVNLW1xgI/EG70thki/dAaVs97pllgJ30g7qCrF1D58Gg+x1cJia9P
	rJ+LMp3JXMH+kyp8rmNGTAZRdokgZotCk8ztqj3Dmu7joSpJ73PrlSJhLeCncBDcUvLRLe
	1GXFpPiC11wcbQxs6AIiYdl67/JDy0k=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-BsWe0DdGN9CPftT-1f1nuA-1; Wed, 30 Oct 2024 23:21:29 -0400
X-MC-Unique: BsWe0DdGN9CPftT-1f1nuA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-20c9673e815so7008685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 20:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730344888; x=1730949688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sQ6ECpE0IwrsdCAvpsqRFFkwrnz/OlwUrybT8imC7k=;
        b=P6JQ4AMKHCdJlJJODrxCV2yBazsfT5Bi3leu5CmbrfVhtZn17hvr93dpW9NxZs9Rfd
         uLMM1ru4vfel4phA7kewJUyqEPDYGj+JmsV4MANMRR88DD7NuJLhd2N1K7VrFLv2Oz3h
         YlQho+aTRZsBX9a6Usbyc+QcXYOX5dq/2tTYoBltIxWx5hy5iOjjJzmfmIb+UGEr0KFB
         Y3LsvETCMJLGgu7KVAu4EyhKDqTHPz3OAbWGk8empV7pXHJjQOm3klBwGOm+1cy4DWIz
         cmnC1JT9ycYvisU7cXOQ0WMRVBTwgDWt0IfZV3MZElt8YPkQxWUR70GKITLlIklEBalX
         Pe6g==
X-Forwarded-Encrypted: i=1; AJvYcCXkJFmgvb/ESWEUsYCZJg9/H8jH9FqU714hpyR4Y533OxhJ8e7/HVdKIvnaZBA6iuGx12llGOOKd+XPFAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+9GySnrjXkj0KEibYnIuBWZ2OUSD3ocNVUv0x67iokDh3qDAp
	NPhnzJ7QaPoXOA1NGKQIqvZSj/har7ACcOSdKESfHVX9zavDbSdnU+0jySLU9R/0zryETxRWKTs
	9W+FyVcHarIXf6oLakyQDyvN0FNCIbtjGe4+eSg0Msv3n5i1lGIneBqPBSITO3w==
X-Received: by 2002:a17:903:32cb:b0:20b:6f02:b4e5 with SMTP id d9443c01a7336-21103aaa7d3mr23517925ad.9.1730344888530;
        Wed, 30 Oct 2024 20:21:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHDYCAFpYo8N/jjR1uoLGhu50lPjTnHW2PUKlDZJcn/tiny8wUqPMNnLzbxeRP5gnfGgVO2A==
X-Received: by 2002:a17:903:32cb:b0:20b:6f02:b4e5 with SMTP id d9443c01a7336-21103aaa7d3mr23517695ad.9.1730344888095;
        Wed, 30 Oct 2024 20:21:28 -0700 (PDT)
Received: from zeus.elecom ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105706891sm2772665ad.69.2024.10.30.20.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 20:21:27 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ryosuke Yasuoka <ryasuoka@redhat.com>
Subject: [PATCH] drm/virtio: Add drm_panic support
Date: Thu, 31 Oct 2024 12:20:59 +0900
Message-ID: <20241031032101.2836264-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jocelyn Falempe <jfalempe@redhat.com>

Virtio gpu supports the drm_panic module, which displays a message to
the screen when a kernel panic occurs.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  28 +++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 161 +++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 156 +++++++++++++++++++++++-
 3 files changed, 339 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 64c236169db8..765698a6dfa3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -125,7 +125,14 @@ struct virtio_gpu_object_array {
 	struct drm_gem_object *objs[] __counted_by(total);
 };
 
+#define MAX_INLINE_CMD_SIZE   96
+#define MAX_INLINE_RESP_SIZE  24
+#define VBUFFER_SIZE	      (sizeof(struct virtio_gpu_vbuffer) \
+			      + MAX_INLINE_CMD_SIZE		 \
+			      + MAX_INLINE_RESP_SIZE)
+
 struct virtio_gpu_vbuffer;
+struct virtio_gpu_vbuffer_inline;
 struct virtio_gpu_device;
 
 typedef void (*virtio_gpu_resp_cb)(struct virtio_gpu_device *vgdev,
@@ -329,12 +336,26 @@ void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_unref_resource(struct virtio_gpu_device *vgdev,
 				   struct virtio_gpu_object *bo);
+void virtio_gpu_panic_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
+					      uint64_t offset,
+					      uint32_t width, uint32_t height,
+					      uint32_t x, uint32_t y,
+					      struct virtio_gpu_object_array *objs,
+					      struct virtio_gpu_fence *fence,
+					      struct virtio_gpu_vbuffer *vbuf);
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint64_t offset,
 					uint32_t width, uint32_t height,
 					uint32_t x, uint32_t y,
 					struct virtio_gpu_object_array *objs,
 					struct virtio_gpu_fence *fence);
+void virtio_gpu_panic_cmd_resource_flush(struct virtio_gpu_device *vgdev,
+					 struct virtio_gpu_vbuffer *vbuf,
+					 uint32_t resource_id,
+					 uint32_t x, uint32_t y,
+					 uint32_t width, uint32_t height,
+					 struct virtio_gpu_object_array *objs,
+					 struct virtio_gpu_fence *fence);
 void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id,
 				   uint32_t x, uint32_t y,
@@ -399,6 +420,7 @@ void virtio_gpu_ctrl_ack(struct virtqueue *vq);
 void virtio_gpu_cursor_ack(struct virtqueue *vq);
 void virtio_gpu_dequeue_ctrl_func(struct work_struct *work);
 void virtio_gpu_dequeue_cursor_func(struct work_struct *work);
+void virtio_gpu_panic_notify(struct virtio_gpu_device *vgdev);
 void virtio_gpu_notify(struct virtio_gpu_device *vgdev);
 
 int
@@ -435,6 +457,12 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 					enum drm_plane_type type,
 					int index);
 
+struct virtio_gpu_vbuffer_inline {
+	struct virtio_gpu_vbuffer base;
+	u8 cmd_buf[MAX_INLINE_CMD_SIZE];
+	u8 resp_buf[MAX_INLINE_RESP_SIZE];
+};
+
 /* virtgpu_fence.c */
 struct virtio_gpu_fence *virtio_gpu_fence_alloc(struct virtio_gpu_device *vgdev,
 						uint64_t base_fence_ctx,
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a72a2dbda031..84b65f6b0906 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -26,6 +26,8 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_panic.h>
 
 #include "virtgpu_drv.h"
 
@@ -108,6 +110,28 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 	return ret;
 }
 
+/* For drm panic */
+static void virtio_gpu_panic_update_dumb_bo(struct virtio_gpu_device *vgdev,
+					    struct drm_plane_state *state,
+					    struct drm_rect *rect,
+					    struct virtio_gpu_object_array *objs,
+					    struct virtio_gpu_vbuffer *vbuf)
+{
+	struct virtio_gpu_object *bo =
+		gem_to_virtio_gpu_obj(state->fb->obj[0]);
+	uint32_t w = rect->x2 - rect->x1;
+	uint32_t h = rect->y2 - rect->y1;
+	uint32_t x = rect->x1;
+	uint32_t y = rect->y1;
+	uint32_t off = x * state->fb->format->cpp[0] +
+		y * state->fb->pitches[0];
+
+	virtio_gpu_array_add_obj(objs, &bo->base.base);
+
+	virtio_gpu_panic_cmd_transfer_to_host_2d(vgdev, off, w, h, x, y,
+						 objs, NULL, vbuf);
+}
+
 static void virtio_gpu_update_dumb_bo(struct virtio_gpu_device *vgdev,
 				      struct drm_plane_state *state,
 				      struct drm_rect *rect)
@@ -131,6 +155,24 @@ static void virtio_gpu_update_dumb_bo(struct virtio_gpu_device *vgdev,
 					   objs, NULL);
 }
 
+/* For drm_panic */
+static void virtio_gpu_panic_resource_flush(struct drm_plane *plane,
+					    struct virtio_gpu_vbuffer *vbuf,
+					    uint32_t x, uint32_t y,
+					    uint32_t width, uint32_t height)
+{
+	struct drm_device *dev = plane->dev;
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_framebuffer *vgfb;
+	struct virtio_gpu_object *bo;
+
+	vgfb = to_virtio_gpu_framebuffer(plane->state->fb);
+	bo = gem_to_virtio_gpu_obj(vgfb->base.obj[0]);
+
+	virtio_gpu_panic_cmd_resource_flush(vgdev, vbuf, bo->hw_res_handle, x, y,
+					    width, height, NULL, NULL);
+}
+
 static void virtio_gpu_resource_flush(struct drm_plane *plane,
 				      uint32_t x, uint32_t y,
 				      uint32_t width, uint32_t height)
@@ -359,11 +401,123 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	virtio_gpu_cursor_ping(vgdev, output);
 }
 
+static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
+					 struct drm_scanout_buffer *sb)
+{
+	struct virtio_gpu_object *bo;
+
+	if (!plane->state || !plane->state->fb || !plane->state->visible)
+		return -ENODEV;
+
+	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
+
+	/* try to vmap it if possible */
+	if (!bo->base.vaddr) {
+		int ret;
+
+		ret = drm_gem_shmem_vmap(&bo->base, &sb->map[0]);
+		if (ret)
+			return ret;
+	} else {
+		iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
+	}
+
+	sb->format = plane->state->fb->format;
+	sb->height = plane->state->fb->height;
+	sb->width = plane->state->fb->width;
+	sb->pitch[0] = plane->state->fb->pitches[0];
+	return 0;
+}
+
+struct virtio_gpu_panic_object_array {
+	struct ww_acquire_ctx ticket;
+	struct list_head next;
+	u32 nents, total;
+	struct drm_gem_object *objs;
+};
+
+static void *virtio_panic_buffer;
+
+static void virtio_gpu_panic_get_vbuf(struct virtqueue *vq,
+				      struct virtio_gpu_vbuffer *vbuf,
+				      struct list_head *reclaim_list)
+{
+	unsigned int len;
+
+	/* waiting vbuf to be used */
+	while (1) {
+		if (vbuf == virtqueue_get_buf(vq, &len))
+			break;
+	}
+	list_add_tail(&vbuf->list, reclaim_list);
+}
+
+static void virtio_panic_flush(struct drm_plane *plane)
+{
+	struct virtio_gpu_object *bo;
+	struct drm_device *dev = plane->dev;
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct drm_rect rect;
+	struct virtio_gpu_vbuffer_inline *vbuf_inline_dumb_bo;
+	struct virtio_gpu_vbuffer_inline *vbuf_inline_resource_flush;
+
+	vbuf_inline_dumb_bo = virtio_panic_buffer;
+	vbuf_inline_resource_flush = virtio_panic_buffer + VBUFFER_SIZE;
+
+	rect.x1 = 0;
+	rect.y1 = 0;
+	rect.x2 = plane->state->fb->width;
+	rect.y2 = plane->state->fb->height;
+
+	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
+
+	struct drm_gem_object obj;
+	struct virtio_gpu_panic_object_array objs = {
+		.next = { NULL, NULL },
+		.nents = 0,
+		.total = 1,
+		.objs = &obj
+	};
+	struct list_head reclaim_list;
+	struct virtio_gpu_vbuffer *entry, *tmp;
+
+	INIT_LIST_HEAD(&reclaim_list);
+
+	if (bo->dumb)
+		virtio_gpu_panic_update_dumb_bo(vgdev,
+						plane->state,
+						&rect,
+						(struct virtio_gpu_object_array *)&objs,
+						&vbuf_inline_dumb_bo->base);
+
+	virtio_gpu_panic_resource_flush(plane, &vbuf_inline_resource_flush->base,
+					plane->state->src_x >> 16,
+					plane->state->src_y >> 16,
+					plane->state->src_w >> 16,
+					plane->state->src_h >> 16);
+	virtio_gpu_panic_notify(vgdev);
+
+	virtio_gpu_panic_get_vbuf(vgdev->ctrlq.vq,
+				  &vbuf_inline_dumb_bo->base,
+				  &reclaim_list);
+	virtio_gpu_panic_get_vbuf(vgdev->ctrlq.vq,
+				  &vbuf_inline_resource_flush->base,
+				  &reclaim_list);
+
+	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
+		if (entry->objs)
+			drm_gem_object_put(&objs.objs[0]);
+		list_del(&entry->list);
+	}
+}
+
 static const struct drm_plane_helper_funcs virtio_gpu_primary_helper_funcs = {
 	.prepare_fb		= virtio_gpu_plane_prepare_fb,
 	.cleanup_fb		= virtio_gpu_plane_cleanup_fb,
 	.atomic_check		= virtio_gpu_plane_atomic_check,
 	.atomic_update		= virtio_gpu_primary_plane_update,
+	.get_scanout_buffer	= virtio_drm_get_scanout_buffer,
+	.panic_flush		= virtio_panic_flush,
 };
 
 static const struct drm_plane_helper_funcs virtio_gpu_cursor_helper_funcs = {
@@ -383,6 +537,13 @@ struct drm_plane *virtio_gpu_plane_init(struct virtio_gpu_device *vgdev,
 	const uint32_t *formats;
 	int nformats;
 
+	/* allocate panic buffers */
+	if (index == 0 && type == DRM_PLANE_TYPE_PRIMARY) {
+		virtio_panic_buffer = drmm_kzalloc(dev, 2 * VBUFFER_SIZE, GFP_KERNEL);
+		if (!virtio_panic_buffer)
+			return ERR_PTR(-ENOMEM);
+	}
+
 	if (type == DRM_PLANE_TYPE_CURSOR) {
 		formats = virtio_gpu_cursor_formats;
 		nformats = ARRAY_SIZE(virtio_gpu_cursor_formats);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 0d3d0d09f39b..b9b8e6a5c314 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -36,12 +36,6 @@
 #include "virtgpu_drv.h"
 #include "virtgpu_trace.h"
 
-#define MAX_INLINE_CMD_SIZE   96
-#define MAX_INLINE_RESP_SIZE  24
-#define VBUFFER_SIZE          (sizeof(struct virtio_gpu_vbuffer) \
-			       + MAX_INLINE_CMD_SIZE		 \
-			       + MAX_INLINE_RESP_SIZE)
-
 static void convert_to_hw_box(struct virtio_gpu_box *dst,
 			      const struct drm_virtgpu_3d_box *src)
 {
@@ -311,6 +305,40 @@ static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
 	return sgt;
 }
 
+/* For drm_panic */
+static int virtio_gpu_panic_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
+					   struct virtio_gpu_vbuffer *vbuf,
+					   struct virtio_gpu_fence *fence,
+					   int elemcnt,
+					   struct scatterlist **sgs,
+					   int outcnt,
+					   int incnt)
+{
+	struct virtqueue *vq = vgdev->ctrlq.vq;
+	int ret;
+
+	if (vgdev->has_indirect)
+		elemcnt = 1;
+
+again:
+
+	if (vq->num_free < elemcnt) {
+		virtio_gpu_panic_notify(vgdev);
+		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
+		goto again;
+	}
+
+	ret = virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
+	WARN_ON(ret);
+
+	vbuf->seqno = ++vgdev->ctrlq.seqno;
+	trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf), vbuf->seqno);
+
+	atomic_inc(&vgdev->pending_commands);
+
+	return 0;
+}
+
 static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 				     struct virtio_gpu_vbuffer *vbuf,
 				     struct virtio_gpu_fence *fence,
@@ -368,6 +396,36 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	return 0;
 }
 
+/* For drm_panic */
+static int virtio_gpu_panic_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
+						     struct virtio_gpu_vbuffer *vbuf,
+						     struct virtio_gpu_fence *fence)
+{
+	struct scatterlist *sgs[3], vcmd, vresp;
+	int elemcnt = 0, outcnt = 0, incnt = 0, ret;
+
+	/* set up vcmd */
+	sg_init_one(&vcmd, vbuf->buf, vbuf->size);
+	elemcnt++;
+	sgs[outcnt] = &vcmd;
+	outcnt++;
+
+	/* set up vresp */
+	if (vbuf->resp_size) {
+		sg_init_one(&vresp, vbuf->resp_buf, vbuf->resp_size);
+		elemcnt++;
+		sgs[outcnt + incnt] = &vresp;
+		incnt++;
+	}
+
+	ret = virtio_gpu_panic_queue_ctrl_sgs(vgdev, vbuf,
+					      fence, elemcnt,
+					      sgs, outcnt,
+					      incnt);
+
+	return ret;
+}
+
 static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 					       struct virtio_gpu_vbuffer *vbuf,
 					       struct virtio_gpu_fence *fence)
@@ -422,6 +480,21 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	return ret;
 }
 
+/* For drm_panic */
+void virtio_gpu_panic_notify(struct virtio_gpu_device *vgdev)
+{
+	bool notify;
+
+	if (!atomic_read(&vgdev->pending_commands))
+		return;
+
+	atomic_set(&vgdev->pending_commands, 0);
+	notify = virtqueue_kick_prepare(vgdev->ctrlq.vq);
+
+	if (notify)
+		virtqueue_notify(vgdev->ctrlq.vq);
+}
+
 void virtio_gpu_notify(struct virtio_gpu_device *vgdev)
 {
 	bool notify;
@@ -567,6 +640,44 @@ void virtio_gpu_cmd_set_scanout(struct virtio_gpu_device *vgdev,
 	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
 
+/* For drm_panic */
+static void virtio_gpu_panic_alloc_cmd(struct virtio_gpu_device *vgdev,
+				       struct virtio_gpu_vbuffer *vbuf,
+				       int cmd_size)
+{
+	vbuf->buf = (void *)vbuf + sizeof(*vbuf);
+	vbuf->size = cmd_size;
+	vbuf->resp_cb = NULL;
+	vbuf->resp_size = sizeof(struct virtio_gpu_ctrl_hdr);
+	vbuf->resp_buf = (void *)vbuf->buf + cmd_size;
+}
+
+/* For drm_panic */
+void virtio_gpu_panic_cmd_resource_flush(struct virtio_gpu_device *vgdev,
+				   struct virtio_gpu_vbuffer *vbuf,
+				   uint32_t resource_id,
+				   uint32_t x, uint32_t y,
+				   uint32_t width, uint32_t height,
+				   struct virtio_gpu_object_array *objs,
+				   struct virtio_gpu_fence *fence)
+{
+	struct virtio_gpu_resource_flush *cmd_p;
+
+	virtio_gpu_panic_alloc_cmd(vgdev, vbuf,
+				   sizeof(struct virtio_gpu_resource_flush));
+	cmd_p = (void *)vbuf->buf;
+	vbuf->objs = objs;
+
+	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_RESOURCE_FLUSH);
+	cmd_p->resource_id = cpu_to_le32(resource_id);
+	cmd_p->r.width = cpu_to_le32(width);
+	cmd_p->r.height = cpu_to_le32(height);
+	cmd_p->r.x = cpu_to_le32(x);
+	cmd_p->r.y = cpu_to_le32(y);
+
+	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
+}
+
 void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
 				   uint32_t resource_id,
 				   uint32_t x, uint32_t y,
@@ -591,6 +702,39 @@ void virtio_gpu_cmd_resource_flush(struct virtio_gpu_device *vgdev,
 	virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
 }
 
+/* For drm_panic */
+void virtio_gpu_panic_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
+					      uint64_t offset,
+					      uint32_t width, uint32_t height,
+					      uint32_t x, uint32_t y,
+					      struct virtio_gpu_object_array *objs,
+					      struct virtio_gpu_fence *fence,
+					      struct virtio_gpu_vbuffer *vbuf)
+{
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
+	struct virtio_gpu_transfer_to_host_2d *cmd_p;
+	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
+
+	if (virtio_gpu_is_shmem(bo) && use_dma_api)
+		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+					    bo->base.sgt, DMA_TO_DEVICE);
+
+	virtio_gpu_panic_alloc_cmd(vgdev, vbuf,
+				   sizeof(struct virtio_gpu_transfer_to_host_2d));
+	cmd_p = (void *)vbuf->buf;
+	vbuf->objs = objs;
+
+	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D);
+	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
+	cmd_p->offset = cpu_to_le64(offset);
+	cmd_p->r.width = cpu_to_le32(width);
+	cmd_p->r.height = cpu_to_le32(height);
+	cmd_p->r.x = cpu_to_le32(x);
+	cmd_p->r.y = cpu_to_le32(y);
+
+	virtio_gpu_panic_queue_fenced_ctrl_buffer(vgdev, vbuf, fence);
+}
+
 void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
 					uint64_t offset,
 					uint32_t width, uint32_t height,
-- 
2.47.0



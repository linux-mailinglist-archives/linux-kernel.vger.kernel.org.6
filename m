Return-Path: <linux-kernel+bounces-259941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FEC93A030
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D861C21CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B50D152190;
	Tue, 23 Jul 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fe1Murik"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C322C14F138
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721735370; cv=none; b=DXr3Pt+agJ/Zr+DfVi2L8wyxOwaBUc9y7VGd0YkSahxJA5Hof5n2Pi2j9GBfCnYuWOs4H7ThX826T6rpShQ689xTqg79emsCo6DL2xceOUGR7p1suKNVVL/wt1jX9aiLpxkXQISwIdeoKXAcD2zhq/k+AuhhELaZ4jIhQc3xFSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721735370; c=relaxed/simple;
	bh=LxT6+jyOIpCoghRau5phDC+SR0btVX3iQlRJplL8vA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOZbaUoOWMzvMeQsZ0C2GyUKirw5MYou2fkvkXzQtUByYZPyuUPYbP8+DLcnBVcJawda9/JDvXSGWwdFclVrrvT0wh5bbI7YwCLzbeWe4eqfErb0tVZWPUVJ/XUxC8/yVKLOfgFJnOzWWwhfyHHjlv/pU8Yu5a8hYVySdq6Hd8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fe1Murik; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721735367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xQW7PzkgTK5bZ57HfJLbFbPh4lNQWanF14yylB62UJM=;
	b=fe1MurikZ69R0pcbMBGTo2VXS6Zc8bnJQSrzHcRluYx8OleIxXCj8p58orWzJi34bPt/vV
	RnJsVYpXYVJJ6T6pyvRu4vu7o1PoM48x7e1Zqwun7T/2bqo0SDdA+Xbw7sb4T7j0EpcJGw
	VfOmfWH99wXt/JTUP6TzAw5dYwvHSOk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-oLoHgXnNPlyMEFX5TBBORQ-1; Tue,
 23 Jul 2024 07:49:26 -0400
X-MC-Unique: oLoHgXnNPlyMEFX5TBBORQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FD9E1955D48;
	Tue, 23 Jul 2024 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.194.104])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78209195605A;
	Tue, 23 Jul 2024 11:49:20 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: gurchetansingh@chromium.org,
	tzimmermann@suse.de,
	mripard@kernel.org,
	olvaffe@gmail.com,
	kraxel@redhat.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com
Cc: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Sergio Lopez <slp@redhat.com>
Subject: [PATCH 1/2] drm/virtio: introduce the HOST_PAGE_SIZE feature
Date: Tue, 23 Jul 2024 07:49:13 -0400
Message-ID: <20240723114914.53677-2-slp@redhat.com>
In-Reply-To: <20240723114914.53677-1-slp@redhat.com>
References: <20240723114914.53677-1-slp@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Introduce a new feature, HOST_PAGE_SIZE, that indicates the host
provides its page size as a value in virtio_gpu_config.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_drv.h |  2 ++
 drivers/gpu/drm/virtio/virtgpu_kms.c | 13 ++++++++++---
 include/uapi/linux/virtio_gpu.h      |  5 +++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 188e126383c2..026fc061db6d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -149,6 +149,7 @@ static unsigned int features[] = {
 	VIRTIO_GPU_F_RESOURCE_UUID,
 	VIRTIO_GPU_F_RESOURCE_BLOB,
 	VIRTIO_GPU_F_CONTEXT_INIT,
+	VIRTIO_GPU_F_HOST_PAGE_SIZE,
 };
 static struct virtio_driver virtio_gpu_driver = {
 	.feature_table = features,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index bb7d86a0c6a1..5ce795deb1eb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -249,6 +249,7 @@ struct virtio_gpu_device {
 	bool has_resource_blob;
 	bool has_host_visible;
 	bool has_context_init;
+	bool has_host_page_size;
 	struct virtio_shm_region host_visible_region;
 	struct drm_mm host_visible_mm;
 
@@ -262,6 +263,7 @@ struct virtio_gpu_device {
 	uint32_t num_capsets;
 	uint64_t capset_id_mask;
 	struct list_head cap_cache;
+	uint32_t host_page_size;
 
 	/* protects uuid state when exporting */
 	spinlock_t resource_export_lock;
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 5a3b5aaed1f3..11cccc3ca560 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -124,7 +124,7 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	struct virtio_gpu_device *vgdev;
 	/* this will expand later */
 	struct virtqueue *vqs[2];
-	u32 num_scanouts, num_capsets;
+	u32 num_scanouts, num_capsets, host_page_size;
 	int ret = 0;
 
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
@@ -197,6 +197,12 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_CONTEXT_INIT)) {
 		vgdev->has_context_init = true;
 	}
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_HOST_PAGE_SIZE)) {
+		vgdev->has_host_page_size = true;
+		virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
+				host_page_size, &host_page_size);
+		vgdev->host_page_size = host_page_size;
+	}
 
 	DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible",
 		 vgdev->has_virgl_3d    ? '+' : '-',
@@ -204,8 +210,9 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		 vgdev->has_resource_blob ? '+' : '-',
 		 vgdev->has_host_visible ? '+' : '-');
 
-	DRM_INFO("features: %ccontext_init\n",
-		 vgdev->has_context_init ? '+' : '-');
+	DRM_INFO("features: %ccontext_init %chost_page_size\n",
+		 vgdev->has_context_init ? '+' : '-',
+		 vgdev->has_host_page_size ? '+' : '-');
 
 	ret = virtio_find_vqs(vgdev->vdev, 2, vqs, callbacks, names, NULL);
 	if (ret) {
diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 0e21f3998108..120e41bf83a5 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -64,6 +64,10 @@
  * context_init and multiple timelines
  */
 #define VIRTIO_GPU_F_CONTEXT_INIT        4
+/*
+ * Config struct contains host page size
+ */
+#define VIRTIO_GPU_F_HOST_PAGE_SIZE      5
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -363,6 +367,7 @@ struct virtio_gpu_config {
 	__le32 events_clear;
 	__le32 num_scanouts;
 	__le32 num_capsets;
+	__le32 host_page_size;
 };
 
 /* simple formats for fbcon/X use */
-- 
2.45.2



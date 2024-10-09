Return-Path: <linux-kernel+bounces-357350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E98F997036
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3EE28379B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2E41A3034;
	Wed,  9 Oct 2024 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5tPzXOg"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1D91A2642
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488083; cv=none; b=b9VypM6g/DZZ0bn9pTs82tFZRdJiG4sfzPAd3e612BFLcx4vZQMc02Wks+AG8r/VUK1s7wFjYOdbWu/Zjv4KOv3QQgRnV/TkzRgsLCLZuhnGTiqBFux5EbCgsRWSrc2vTbCjvx8vQe2Zz4dat0kz7JC3oOlffOQZmgLpfpK3Mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488083; c=relaxed/simple;
	bh=8Qo1xgzNQ91iVBEp7MZxdgGxuMcEnTqTZTdF1nZvJUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KyAYVF+qO0iuZQXl+zz4w8tMqwhQbEI7y/lRATAGfOF5pP1nyPxT06EsV8vRbfgZGi/9DoP4ac9L3/O3rLCeCB6+QaXmM0T2TPUKXn904OqRUEixmucJ7VzUo6sscg15r8r2OfKRDTv5bQXakfiow6LHPCz60musEwd7a7vNLnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5tPzXOg; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a340f9dd8aso38399125ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728488081; x=1729092881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFDfzJZBmX0OW0gKK+D7bIIFquXbidETG25kxSWdouk=;
        b=R5tPzXOgGST14bvQ1v7wJc722CxuaariB76CR8zO+07NzPZn16Hox1hzkXfcVxisLf
         BoRheZHDCyB6TEVbNcQdrk0Kvkc+pA9n8mk21m/fn1r8VaUc/23AfoybE1rM8mm3E+k/
         QKDJ8/qNX70rkyKc+ZrH6K7/yfdr9c6DKttIxkCX45hWOcf6S/RVFDjg8OEHpSefocy3
         o6LDCUTPBDJVnrE51uy7ylNA+926P0KG3hElo8OfDtvUNMs8gAqolEpFyu2msAunTdVp
         QvooH0/rqH+tgNUPzJb0Efbg3R4fqwcRudbe80LHbESW8yy8g4S1YXOzw1XsybUDkIbu
         XC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488081; x=1729092881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFDfzJZBmX0OW0gKK+D7bIIFquXbidETG25kxSWdouk=;
        b=lYUxb9FPG6sishKwbROrU8TntCfrwag2Do1txY9uK1i30XgZtBvChKWPgKHLc7uLly
         b1j0PvegsJfslpiLv8SMDkVYp5SRY1OYUaAlgNS7Jl0iVka9pkIIgmmFCv+hYSqfxWlV
         zVEvI8YnYYAegefXEdeEM3v/4s3ks4doDfkppIsIWk1n0JIZXejWQk2P+f4hTSFBO9Ub
         OTGhUsjN53GO4EJKvldOODYe0FcJjbjmpSMEguKZmbiZuxd4GJP1dU4HyjgOMPzFG6Gt
         oSw2lfPoG+xit9qX0SLyVyWWg0Pynk8sCccEyRWPUE0IXjp4tkC7FVgDbsegsi+hqgXm
         i9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOLuBl1ibU2tT49vCogKVqe5SBSjJOj/U76ZcmCTt15YAMz4DelkVs8oTv5jXkbUJ7uGiFFm35ldZY9OI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ZFgu/xO34cOBiJbwf+VK308j8Qi9t4dk/ke0shm583Qi50oT
	NAO2KVVzplS9dxlktnh1YeBZaGEJGn21aL+4PrVczDJfiuuRT6Xw
X-Google-Smtp-Source: AGHT+IFSWQdhz5NbDzCxT/tXnpjeGF/Bt1wDAndcbVIkishpcthQRf8wue6EgmdszDA8n4vpRDt9NQ==
X-Received: by 2002:a05:6e02:b41:b0:3a0:c23f:9647 with SMTP id e9e14a558f8ab-3a397ced853mr26033065ab.1.1728488080914;
        Wed, 09 Oct 2024 08:34:40 -0700 (PDT)
Received: from localhost.localdomain ([113.102.167.241])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7e9f6830081sm8615742a12.41.2024.10.09.08.34.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Oct 2024 08:34:40 -0700 (PDT)
From: huangwenyu1998@gmail.com
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	sgarzare@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	huangwenyu1998@gmail.com
Subject: [PATCH v3] virtio: Make vring_new_virtqueue support for packed vring
Date: Wed,  9 Oct 2024 23:34:30 +0800
Message-Id: <20241009153430.90318-1-huangwenyu1998@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenyu Huang <huangwenyu1998@gmail.com>

It used for testing in tools/virtio/vringh_test.c.
If vring_new_virtqueue supports packed vring, we can add support for
packed vring to vringh and test it.

Signed-off-by: Wenyu Huang <huangwenyu1998@gmail.com>
---
Changes in v2: Make the commit title and description more clearer.
Changes in v3: Remove the declaration of __vring_new_virtqueue_split and
			   __vring_new_virtqueue_packed and move the definition of
			   these two functions.
 drivers/virtio/virtio_ring.c | 228 +++++++++++++++++++----------------
 1 file changed, 121 insertions(+), 107 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..91fbfdef2be8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -223,15 +223,6 @@ struct vring_virtqueue {
 #endif
 };
 
-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					       struct vring_virtqueue_split *vring_split,
-					       struct virtio_device *vdev,
-					       bool weak_barriers,
-					       bool context,
-					       bool (*notify)(struct virtqueue *),
-					       void (*callback)(struct virtqueue *),
-					       const char *name,
-					       struct device *dma_dev);
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
 static void vring_free(struct virtqueue *_vq);
 
@@ -1138,6 +1129,66 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
 	return 0;
 }
 
+static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
+					       struct vring_virtqueue_split *vring_split,
+					       struct virtio_device *vdev,
+					       bool weak_barriers,
+					       bool context,
+					       bool (*notify)(struct virtqueue *),
+					       void (*callback)(struct virtqueue *),
+					       const char *name,
+					       struct device *dma_dev)
+{
+	struct vring_virtqueue *vq;
+	int err;
+
+	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
+	if (!vq)
+		return NULL;
+
+	vq->packed_ring = false;
+	vq->vq.callback = callback;
+	vq->vq.vdev = vdev;
+	vq->vq.name = name;
+	vq->vq.index = index;
+	vq->vq.reset = false;
+	vq->we_own_ring = false;
+	vq->notify = notify;
+	vq->weak_barriers = weak_barriers;
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
+	vq->broken = true;
+#else
+	vq->broken = false;
+#endif
+	vq->dma_dev = dma_dev;
+	vq->use_dma_api = vring_use_dma_api(vdev);
+	vq->premapped = false;
+	vq->do_unmap = vq->use_dma_api;
+
+	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+		!context;
+	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+
+	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
+		vq->weak_barriers = false;
+
+	err = vring_alloc_state_extra_split(vring_split);
+	if (err) {
+		kfree(vq);
+		return NULL;
+	}
+
+	virtqueue_vring_init_split(vring_split, vq);
+
+	virtqueue_init(vq, vring_split->vring.num);
+	virtqueue_vring_attach_split(vq, vring_split);
+
+	spin_lock(&vdev->vqs_list_lock);
+	list_add_tail(&vq->vq.list, &vdev->vqs);
+	spin_unlock(&vdev->vqs_list_lock);
+	return &vq->vq;
+}
+
 static struct virtqueue *vring_create_virtqueue_split(
 	unsigned int index,
 	unsigned int num,
@@ -1160,7 +1211,7 @@ static struct virtqueue *vring_create_virtqueue_split(
 	if (err)
 		return NULL;
 
-	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
+	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
 				   context, notify, callback, name, dma_dev);
 	if (!vq) {
 		vring_free_split(&vring_split, vdev, dma_dev);
@@ -2050,36 +2101,29 @@ static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
 	virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
 }
 
-static struct virtqueue *vring_create_virtqueue_packed(
-	unsigned int index,
-	unsigned int num,
-	unsigned int vring_align,
-	struct virtio_device *vdev,
-	bool weak_barriers,
-	bool may_reduce_num,
-	bool context,
-	bool (*notify)(struct virtqueue *),
-	void (*callback)(struct virtqueue *),
-	const char *name,
-	struct device *dma_dev)
+static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
+					       struct vring_virtqueue_packed *vring_packed,
+					       struct virtio_device *vdev,
+					       bool weak_barriers,
+					       bool context,
+					       bool (*notify)(struct virtqueue *),
+					       void (*callback)(struct virtqueue *),
+					       const char *name,
+					       struct device *dma_dev)
 {
-	struct vring_virtqueue_packed vring_packed = {};
 	struct vring_virtqueue *vq;
 	int err;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
-		goto err_ring;
-
 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
 	if (!vq)
-		goto err_vq;
+		return NULL;
 
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
 	vq->vq.index = index;
 	vq->vq.reset = false;
-	vq->we_own_ring = true;
+	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
 #ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
@@ -2100,26 +2144,52 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
-	err = vring_alloc_state_extra_packed(&vring_packed);
-	if (err)
-		goto err_state_extra;
+	err = vring_alloc_state_extra_packed(vring_packed);
+	if (err) {
+		kfree(vq);
+		return NULL;
+	}
 
-	virtqueue_vring_init_packed(&vring_packed, !!callback);
+	virtqueue_vring_init_packed(vring_packed, !!callback);
 
-	virtqueue_init(vq, num);
-	virtqueue_vring_attach_packed(vq, &vring_packed);
+	virtqueue_init(vq, vring_packed->vring.num);
+	virtqueue_vring_attach_packed(vq, vring_packed);
 
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 	spin_unlock(&vdev->vqs_list_lock);
 	return &vq->vq;
+}
 
-err_state_extra:
-	kfree(vq);
-err_vq:
-	vring_free_packed(&vring_packed, vdev, dma_dev);
-err_ring:
-	return NULL;
+static struct virtqueue *vring_create_virtqueue_packed(
+	unsigned int index,
+	unsigned int num,
+	unsigned int vring_align,
+	struct virtio_device *vdev,
+	bool weak_barriers,
+	bool may_reduce_num,
+	bool context,
+	bool (*notify)(struct virtqueue *),
+	void (*callback)(struct virtqueue *),
+	const char *name,
+	struct device *dma_dev)
+{
+	struct vring_virtqueue_packed vring_packed = {};
+	struct virtqueue *vq;
+
+	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
+		return NULL;
+
+	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
+					context, notify, callback, name, dma_dev);
+	if (!vq) {
+		vring_free_packed(&vring_packed, vdev, dma_dev);
+		return NULL;
+	}
+
+	to_vvq(vq)->we_own_ring = true;
+
+	return vq;
 }
 
 static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
@@ -2598,69 +2668,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 }
 EXPORT_SYMBOL_GPL(vring_interrupt);
 
-/* Only available for split ring */
-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					       struct vring_virtqueue_split *vring_split,
-					       struct virtio_device *vdev,
-					       bool weak_barriers,
-					       bool context,
-					       bool (*notify)(struct virtqueue *),
-					       void (*callback)(struct virtqueue *),
-					       const char *name,
-					       struct device *dma_dev)
-{
-	struct vring_virtqueue *vq;
-	int err;
-
-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return NULL;
-
-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
-	if (!vq)
-		return NULL;
-
-	vq->packed_ring = false;
-	vq->vq.callback = callback;
-	vq->vq.vdev = vdev;
-	vq->vq.name = name;
-	vq->vq.index = index;
-	vq->vq.reset = false;
-	vq->we_own_ring = false;
-	vq->notify = notify;
-	vq->weak_barriers = weak_barriers;
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
-	vq->broken = true;
-#else
-	vq->broken = false;
-#endif
-	vq->dma_dev = dma_dev;
-	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
-	vq->do_unmap = vq->use_dma_api;
 
-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
-		!context;
-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
-
-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
-		vq->weak_barriers = false;
-
-	err = vring_alloc_state_extra_split(vring_split);
-	if (err) {
-		kfree(vq);
-		return NULL;
-	}
-
-	virtqueue_vring_init_split(vring_split, vq);
-
-	virtqueue_init(vq, vring_split->vring.num);
-	virtqueue_vring_attach_split(vq, vring_split);
-
-	spin_lock(&vdev->vqs_list_lock);
-	list_add_tail(&vq->vq.list, &vdev->vqs);
-	spin_unlock(&vdev->vqs_list_lock);
-	return &vq->vq;
-}
 
 struct virtqueue *vring_create_virtqueue(
 	unsigned int index,
@@ -2840,7 +2848,6 @@ int virtqueue_reset(struct virtqueue *_vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_reset);
 
-/* Only available for split ring */
 struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int num,
 				      unsigned int vring_align,
@@ -2852,13 +2859,20 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      void (*callback)(struct virtqueue *vq),
 				      const char *name)
 {
-	struct vring_virtqueue_split vring_split = {};
+	struct vring_virtqueue_split vring_split = {};	
 
-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return NULL;
+	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+		struct vring_virtqueue_packed vring_packed = {};
+		vring_packed.vring.num = num;
+		vring_packed.vring.desc = pages;
+		return __vring_new_virtqueue_packed(index, &vring_packed,
+						    vdev, weak_barriers,
+						    context, notify, callback,
+						    name, vdev->dev.parent);
+	}
 
 	vring_init(&vring_split.vring, num, pages, vring_align);
-	return __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
+	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
 				     context, notify, callback, name,
 				     vdev->dev.parent);
 }
-- 
2.43.0



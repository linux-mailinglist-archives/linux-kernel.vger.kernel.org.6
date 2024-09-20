Return-Path: <linux-kernel+bounces-334652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D807897D9F8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 22:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84650B229C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 20:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF2184542;
	Fri, 20 Sep 2024 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFvDYkww"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2916A94F
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726863708; cv=none; b=iBNb1Z8tJ001yL9C4he30bTnQj4rG30raajp4V09Nt4xPMGB81mUgmZUkntqkJtpFOGfDIcFJ7OAedU4yBuKU1MzP4cyVlZSv/OSeg0kuCs1EQU57/Web6uSaiq4Wif5+AoO6TKonxMOZnVRk6tzuAkyLu3NrRgSmnSQGkzLAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726863708; c=relaxed/simple;
	bh=bMEPSv2kVF7+Bmfj9t123gvcgI+oCzcjkKtnoMHWnl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dqjmc7o+YHGhfJQkZXnmBJnxEat5lWMisjeuzng4ZlLuNkn3/rBNLAkuKogUbb8iIgMs2jfaBwu4peN1P4OoB04Ian7tVUCsHXEZik49t8OgD8LZ88otZIE4u6cO+foa30WbEX27lXIS9thT89c3jR6qZASGYiNMr9d0bkButdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFvDYkww; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71788bfe60eso2121959b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 13:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726863706; x=1727468506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FTMqPqwuPFmCmq0ZrkAlktDHceHAk8HhbetHzAPo6pQ=;
        b=QFvDYkwwrnkA9BMpV6AKXd727J09KVRyyi3GgENJyiR5AXLsVoLbseLG8+U0kE4ktZ
         Y/+2YLnvUZ6kzfRdt9iPpNgGCwfdoLCelMwpt/AQPPJCQHTFVAuvS9Z+Y8zDd8RNbQpt
         SqzC4Nn9/5wa1jeXhj97zs+G5MRnzHbkiQVq2FOhcAPaJiDwiDdM4RP55csE7FDZ40mJ
         Me7hvFHjGb4fC3RyCQHE/uuidcwaIH8WnNPW+7OTTFueh4x93FKdl1tqu6ta0jdBA2Ot
         uUlVuUuZyyJ3pmpedPdvBc7JIxAMYKWR+2QsUPiQlVJIJciWADTmW6d5Vc3PqDff3Avb
         sHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726863706; x=1727468506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTMqPqwuPFmCmq0ZrkAlktDHceHAk8HhbetHzAPo6pQ=;
        b=YHDxkpx+RfNqzxesjHPSOnpPWuQzeO5B9LtbTscoJikmu7CmbHFmSr/snELd7aN2Pk
         IN/GOJs1JaX7j4xKpkZSanGhRN+lneBnP4bMNL3ipFz6sJ5N6u47n/2qdkAhvmPs1La/
         qS1FP0ENCLDYrS/evxUXHTsT4lnCLzVSx5YFnA+UXpada6MCW0XKvmg1xf1q7vc26Tha
         VhYXUo6m4yXSufOt17tFShZf1oanRYmjC7pUfpIwigNRrJqG/eBhNk4k5wRcPCl9JrZG
         b9siv+YqY9Sc9hHbkEDeB2bWOgEyTVLmrR0rPnqa+/1uXrQOwlehHflXnE4k7bk0kO/b
         QxOg==
X-Forwarded-Encrypted: i=1; AJvYcCW03kfRokxGLWTthmQw8RVIedKmA4ja/PDRoBm5i443J1HEtowDxDGd9O18GZelMxBqURRLZB4e59jjcvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsSElEBNsTPmF7K6XGiIQ/9tRcmrySDY0eeUwgLwbTdOdfB24u
	m0PBNrknVdpcm6eTCYL5X6QTS+U7VoMapPY1B7qkBogLRyF3nhKs
X-Google-Smtp-Source: AGHT+IHo5zUSsx2wi0HM7klfzPYPSI8TQWNLHP/Niytv1S4QuOX4QBc+2TurH/N9hquzETnnwxXz8g==
X-Received: by 2002:a05:6a00:1405:b0:714:3de8:a616 with SMTP id d2e1a72fcca58-7199ca03a00mr6023594b3a.19.1726863705794;
        Fri, 20 Sep 2024 13:21:45 -0700 (PDT)
Received: from localhost.localdomain ([183.11.36.73])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944bc4752sm10219520b3a.203.2024.09.20.13.21.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Sep 2024 13:21:45 -0700 (PDT)
From: Wenyu Huang <huangwenyu1998@gmail.com>
X-Google-Original-From: Wenyu Huang <huangwenyuu@outlook.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: Make vring_new_virtqueue support for packed vring
Date: Sat, 21 Sep 2024 04:21:41 +0800
Message-Id: <20240920202141.89446-1-huangwenyuu@outlook.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wenyu Huang <huangwenyu1998@gmail.com>

It's also available for packed ring now.

Signed-off-by: Wenyu Huang <huangwenyu1998@gmail.com>
---
 drivers/virtio/virtio_ring.c | 153 +++++++++++++++++++++--------------
 1 file changed, 92 insertions(+), 61 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..664a0c40ee05 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -223,7 +223,7 @@ struct vring_virtqueue {
 #endif
 };
 
-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
+static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 					       struct vring_virtqueue_split *vring_split,
 					       struct virtio_device *vdev,
 					       bool weak_barriers,
@@ -232,6 +232,15 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					       void (*callback)(struct virtqueue *),
 					       const char *name,
 					       struct device *dma_dev);
+static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
+					       struct vring_virtqueue_packed *vring_packed,
+					       struct virtio_device *vdev,
+					       bool weak_barriers,
+					       bool context,
+					       bool (*notify)(struct virtqueue *),
+					       void (*callback)(struct virtqueue *),
+					       const char *name,
+					       struct device *dma_dev);
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
 static void vring_free(struct virtqueue *_vq);
 
@@ -1160,7 +1169,7 @@ static struct virtqueue *vring_create_virtqueue_split(
 	if (err)
 		return NULL;
 
-	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
+	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
 				   context, notify, callback, name, dma_dev);
 	if (!vq) {
 		vring_free_split(&vring_split, vdev, dma_dev);
@@ -2064,62 +2073,21 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	struct device *dma_dev)
 {
 	struct vring_virtqueue_packed vring_packed = {};
-	struct vring_virtqueue *vq;
-	int err;
+	struct virtqueue *vq;
 
 	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
-		goto err_ring;
-
-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
-	if (!vq)
-		goto err_vq;
-
-	vq->vq.callback = callback;
-	vq->vq.vdev = vdev;
-	vq->vq.name = name;
-	vq->vq.index = index;
-	vq->vq.reset = false;
-	vq->we_own_ring = true;
-	vq->notify = notify;
-	vq->weak_barriers = weak_barriers;
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
-	vq->broken = true;
-#else
-	vq->broken = false;
-#endif
-	vq->packed_ring = true;
-	vq->dma_dev = dma_dev;
-	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
-	vq->do_unmap = vq->use_dma_api;
-
-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
-		!context;
-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
-
-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
-		vq->weak_barriers = false;
-
-	err = vring_alloc_state_extra_packed(&vring_packed);
-	if (err)
-		goto err_state_extra;
-
-	virtqueue_vring_init_packed(&vring_packed, !!callback);
+		return NULL;
 
-	virtqueue_init(vq, num);
-	virtqueue_vring_attach_packed(vq, &vring_packed);
+	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
+					context, notify, callback, name, dma_dev);
+	if (!vq) {
+		vring_free_packed(&vring_packed, vdev, dma_dev);
+		return NULL;
+	}
 
-	spin_lock(&vdev->vqs_list_lock);
-	list_add_tail(&vq->vq.list, &vdev->vqs);
-	spin_unlock(&vdev->vqs_list_lock);
-	return &vq->vq;
+	to_vvq(vq)->we_own_ring = true;
 
-err_state_extra:
-	kfree(vq);
-err_vq:
-	vring_free_packed(&vring_packed, vdev, dma_dev);
-err_ring:
-	return NULL;
+	return vq;
 }
 
 static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
@@ -2599,7 +2567,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 EXPORT_SYMBOL_GPL(vring_interrupt);
 
 /* Only available for split ring */
-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
+static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 					       struct vring_virtqueue_split *vring_split,
 					       struct virtio_device *vdev,
 					       bool weak_barriers,
@@ -2612,9 +2580,6 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	struct vring_virtqueue *vq;
 	int err;
 
-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return NULL;
-
 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
 	if (!vq)
 		return NULL;
@@ -2662,6 +2627,66 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	return &vq->vq;
 }
 
+static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
+					       struct vring_virtqueue_packed *vring_packed,
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
+	vq->packed_ring = true;
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
+	err = vring_alloc_state_extra_packed(vring_packed);
+	if (err) {
+		kfree(vq);
+		return NULL;
+	}
+
+	virtqueue_vring_init_packed(vring_packed, !!callback);
+
+	virtqueue_init(vq, vring_packed->vring.num);
+	virtqueue_vring_attach_packed(vq, vring_packed);
+
+	spin_lock(&vdev->vqs_list_lock);
+	list_add_tail(&vq->vq.list, &vdev->vqs);
+	spin_unlock(&vdev->vqs_list_lock);
+	return &vq->vq;
+}
+
 struct virtqueue *vring_create_virtqueue(
 	unsigned int index,
 	unsigned int num,
@@ -2840,7 +2865,6 @@ int virtqueue_reset(struct virtqueue *_vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_reset);
 
-/* Only available for split ring */
 struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int num,
 				      unsigned int vring_align,
@@ -2853,12 +2877,19 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      const char *name)
 {
 	struct vring_virtqueue_split vring_split = {};
+	struct vring_virtqueue_packed vring_packed = {};
 
-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return NULL;
+	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
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



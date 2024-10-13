Return-Path: <linux-kernel+bounces-362696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C44199B825
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 05:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AAB0B21804
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 03:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD88B12D1F1;
	Sun, 13 Oct 2024 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Idikom3Q"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF7B2F32
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728790360; cv=none; b=gDjmv2hu98rimguxjw3mCE/bElsezwpyV85rv5jwjuqEQv0x6ECn4TZ7oOcHN9K5nkDSOkutsUxz1aRYt6i6knJjCAqvo38Z87B0Fs5an0h19CCxK6deKA1sNTlatXJXwQIMytiaxD70bI7eQ6Nu0qjWFPQidCjcLaj97BdusTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728790360; c=relaxed/simple;
	bh=b/r7nnGAEajhcM57aoLq3WGAdPoQf1aL5t2Qt/0m8R8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q8HVbFSkBbCh+E4xhYAy3DJG3Fba05pBk+VmIGBYzanW7fm9R4vmEgCKJEpFr9ot6W07n7KHlfyEY+j5cL5+YLPi5vTtYZq/w848710Uvl2K7eSevmnH8VwRk8eXHMMouS+Y808pT+FOq9EfnL3cTF7nWM5fgzuWXYLbJty2iNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Idikom3Q; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e52582d0bso536599b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 20:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728790358; x=1729395158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xzBVAz8kAMSFkf4uczHREZRRQClnQ/S7CR3RyTQw2jY=;
        b=Idikom3QMjNGMdqKPmuWPJubThxhiCQdoFpzXDrb8WVsBEViqykBtQi3mn2NjamkeY
         QIh+aSeubxZy2Q+CBMsK4v4UNubbntoXKa/rg1UyMwPnbSPzLgQ7cpyVc5DwjXa75LyQ
         IFD/4s/lhACRex0PIu6t5sB1zgT3FbACtaFc6oD3aoY2z9ZjS59mu/cR9CWXDPOwX+PT
         AmDv33T3scFEBMU4ocRKoC2D5mez3tr/vH21sKFoZoEG+eP5z5NOYPf7MKuGl70wE1+Q
         VY2wa8EsPR1D2xFUHU1wLyXS9UKjMcV6HPvdQSAPUsg0b4/ObsZtUoYjUryijRcif4ws
         0YqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728790358; x=1729395158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzBVAz8kAMSFkf4uczHREZRRQClnQ/S7CR3RyTQw2jY=;
        b=Qk2qQZZhio5nmaCRhLDaQC4IFUOLHTOP752NqJ59UhRyIpQOiDP17NQqDvlfDbEiy3
         RemHU4bPQC/lT96RmmtL23HwYDRkKub2xjksQsf5Gmt/NHwtomxRWYEUavG5mmdYJ6gY
         BfLAIHDREVF6QuliKfi20LK0C+TddDsLU1XNg4ocmL1vj1CNozp6H6OyVZe4ix68/ix7
         S+oJIZvii+fOIxFhmDTwRH5z2cDP077Z+mFe7vjycy5oX0O0sGvCl2RZHyXT/Abqcap5
         XNcK+9HG9RyEpMfIzSCZnlyKMzSjXu/Sg5Dg8rhtebCMnX3LxGPMKqpecwCOJXCXbCjV
         aS+A==
X-Forwarded-Encrypted: i=1; AJvYcCX03YfNoPgAvuydnmaUslVr0xkb1z2kMoJGG7nXOPD5hpEWXPle6+mT3W6dM0enyKLu8ZF30wy2xPDyUfI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/Bh54xYJ8PP7DsSXkwwP1IhRxZ7mumLtRllFsP3HTVLdWDbJ
	UI3fdEqdVjI47ULUQa+T6UNBCzMdOzk4UiayHm0mtadbsd4SRh5vHBoPMZ0tbgDyvA==
X-Google-Smtp-Source: AGHT+IFeXdE82hfhaEpZlCJILrJa+7H7lKr5+YsoxzEPv7cgyQch5VXYvwEoNQsP0IZ1rirP5ILr/w==
X-Received: by 2002:a05:6a20:e188:b0:1c0:e997:7081 with SMTP id adf61e73a8af0-1d8c95ddd6emr5759215637.29.1728790357463;
        Sat, 12 Oct 2024 20:32:37 -0700 (PDT)
Received: from localhost.localdomain ([175.45.38.98])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71e6164e825sm40098b3a.61.2024.10.12.20.32.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 12 Oct 2024 20:32:37 -0700 (PDT)
From: huangwenyu1998@gmail.com
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	sgarzare@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	huangwenyu1998@gmail.com
Subject: [PATCH v4] virtio: Make vring_new_virtqueue support for packed vring
Date: Sun, 13 Oct 2024 11:32:33 +0800
Message-Id: <20241013033233.65026-1-huangwenyu1998@gmail.com>
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
Changes in v4: Fix checkpatch warnings/errors.
 drivers/virtio/virtio_ring.c | 227 +++++++++++++++++++----------------
 1 file changed, 121 insertions(+), 106 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index be7309b1e860..5fce2cce2358 100644
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
@@ -2854,11 +2861,19 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 {
 	struct vring_virtqueue_split vring_split = {};
 
-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return NULL;
+	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+		struct vring_virtqueue_packed vring_packed = {};
+
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



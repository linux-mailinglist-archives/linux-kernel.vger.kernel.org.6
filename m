Return-Path: <linux-kernel+bounces-351712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E899151F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED6D1F23885
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 07:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B11369BB;
	Sat,  5 Oct 2024 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUtppEGf"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF676036
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728114129; cv=none; b=ZKYo4YfF4ThO4XdY2KEoa+2jChF766H1pIuboaL0e2fJNBb8UZg8pp7U+mBx6lte0OnKNqwgbQ8SeYneSo2YjHUufgDvin2FG9Y8whykrzC0smcvQOBQhKEbMFdC1X93RM0+10f+iTeVsMffnZuWVOcvrhZd/nKXu7dqUKK/SCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728114129; c=relaxed/simple;
	bh=4o2ZBouF/RIEL8PVlxLCIYfr3i1YsvyNkXY0A9TrhDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FdlU4lR12rVnEgW7fetaCwYll8HGFFWiK7EpPZ3DgURMa63gmfPgeAPjixGoHdalxF+SjZMZrMezWVs9UvBZSHBSVY16J7iqVU043BkaL7tZ0qe79WndKTBaSkfR5QqweKQOQoF8wJInEOLVGUbb8AqV6uPmgvfAQ8xY2h+gkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUtppEGf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so2395822a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 00:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728114127; x=1728718927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOFEUyKULg3jg189V7VdXZrfZtPhx0+n63wz8tInHPg=;
        b=jUtppEGf9VMZi5jrALrhQ9RVeOhJAhEOt40gOh3+Mh3MYL+wgdNOPVfLZRnrOLkgmq
         jo40LYSHJ5wZm52cNvf3Csjf9MDV/T6dJrt1PWkCEpYMzlvUcYBPIQvz/ndlyfNNwByA
         hUxQ8BDN+johlc2cCkstylFEQ43F/u3I8Qg6/CVUcuCqSbQrBEH3T1LSLx8WAikG8/Jv
         ipZpDWRRJHe5ppE9Q9mHS3i3eyv/LTlqiISB4/aPNC7CeRBHHaACKJ/If43RJR7mBRlv
         cCMPPM3c96LrK724WVzeEsENu4Sn9+qMXQ9tJSmxzYR+Hz2Nm4WizkiE+q4mfDMRv37H
         B9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728114127; x=1728718927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOFEUyKULg3jg189V7VdXZrfZtPhx0+n63wz8tInHPg=;
        b=u33MBKIwgkgUvK+Shx0wYLaKspkQQ0d8GJgekHF1WeX/JQzt75n8/KoUhhtqMLSxjt
         c+iZx2q53HkwhEHTs3Vjx+eSLGUO0M5+Uq4pmPUq37iK5Lmi1fgarYWowEd6xuWgU/7e
         QUge6tOu/pso5SuQjqNMmBm8Jfdq8fsWDcyAMZF5C6u6J3MZX+QJg6j4Ka8Tb8uIdgu8
         aaZCIzQ5nSOx607rE4IjdStBY+xH7FqYh4TZS7MvRszQBj9Ye7/e7xs2ta8ex14s14Hi
         7CXJ3m7ZrFTSXJf/VBIbR6m0CRBucUn2HRywGjPLucMQrstN09sFw2o/mjhMY3E0VEeW
         Y+6g==
X-Forwarded-Encrypted: i=1; AJvYcCV1nKX5vo5mefra2ae3Onpq2JqgHMj3juvgxCMGjPftJ0DzSVa6JXPK7Y90/yWFdlWKwZCUoK5cHW3tGKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo0RsW/tzw4jnJJohnyWFouuWeTxmUnO1+xAv0CwtjYCYsIsUY
	uZ8HpiB/jm9a0akGtj1YWsCQ+lMD0rTza1x3S56q6lgkWqCCjgfY
X-Google-Smtp-Source: AGHT+IGEHwuzQqCSQvYTkfhD03hBps5slTUoC0Afed/i2Wdmjp/eCFJaabgxuJJkMzy54qqGQqUjNg==
X-Received: by 2002:a05:6a21:3983:b0:1d6:d0d3:c520 with SMTP id adf61e73a8af0-1d6dfa24bb7mr8661281637.9.1728114126841;
        Sat, 05 Oct 2024 00:42:06 -0700 (PDT)
Received: from localhost.localdomain ([222.78.61.133])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71df0cd14f8sm983179b3a.65.2024.10.05.00.42.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Oct 2024 00:42:06 -0700 (PDT)
From: huangwenyu1998@gmail.com
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	huangwenyu1998@gmail.com
Subject: [PATCH v2] virtio: Make vring_new_virtqueue support for packed vring
Date: Sat,  5 Oct 2024 15:42:01 +0800
Message-Id: <20241005074201.52727-1-huangwenyu1998@gmail.com>
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



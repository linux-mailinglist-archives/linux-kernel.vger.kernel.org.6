Return-Path: <linux-kernel+bounces-365385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B1699E18E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28E5B1C21465
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC4C1CACFC;
	Tue, 15 Oct 2024 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEuDTBij"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242B18A6A8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982223; cv=none; b=b/slacg2zpMhqLGunu7jm2qDUcfXMvUVb92mMjC+ElOlfdXzTU8M58sKeB+vQMzww36q4lQRtkKhNQzvmNsTVYKC+0fs9TkRuuzKvgG+4UmOxjLjvVdM4PyFBYYTtjtUzNHD1O3NZMQfhIsgSSMlzf8p0Huxd3RQjAQynL1p4zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982223; c=relaxed/simple;
	bh=OXRU4KCn2kIlSfOd2jYcKs3VGK4P0jUjafXTysl+nFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVgU8KI5m8BXmsSw6cYHZh+KBJFBph82sQBngfYisMiRTPAMKFFq9cq3pGU6ch+K5w6Ii7w3EpQRyEG6N1l+MwTX8XzZDJua6cE2hiJQa4rXJ3cq5BVuCPzKCo22Nyt4M+fWoCW7kffSImWoCSz9pab9vw7cipBIn4zUgULCUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEuDTBij; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728982220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zkv7G2y4DHYIAgdR9yw1tOjiXCJvZxXHEN8jtOVZgE0=;
	b=gEuDTBijyc6SAo/itWBkoduiiNb4jY5/hDuMoCm6ZKs9LDRbrAwPSgtItgVsfEjbvyIu3K
	HhvB65KnOGlf4q6hwhPXX7+qyiy1eTKGY3vTNOJFOwyyvi7EOZnsomin0M/EPVEqm1B44L
	ZLx/SRguyKRDktLvKu8WgwAWJsTDmt8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-9SOFW0TZPrSf49KbbxGXRg-1; Tue, 15 Oct 2024 04:50:19 -0400
X-MC-Unique: 9SOFW0TZPrSf49KbbxGXRg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7afce523b84so1090838285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728982218; x=1729587018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkv7G2y4DHYIAgdR9yw1tOjiXCJvZxXHEN8jtOVZgE0=;
        b=GJtqNsluG/RAL6ZqkkauUoE3JMSkHaQGbVMphi+30951xQFXPLyvSdCHFwNMRVbM1L
         K8k2nfpTlzGGpgYqn4uCI4XSNj+Kw7/RRmgZpBV/16nbpjdzlSv7kmJwQCTQ5VlVOjRg
         X4TWTyxQuHgYA2SnmQ3h9QJLBAvXWr3U50R4uQxB7Ig8n6VT1orlvO3E4tMkuuIj2L3C
         dWTaeOLxcttQcgCudSpZBo/Hz/tiYBS/Mvf+Sv6TVPqbxLQYguFtLqkamLWec6OuS+So
         5OUgyFkzbV8oAiOWCoVk4wRujk4EIgkfOoYL6wA7803y9kQ/SwQb9Xf+Q8gfulnUe5hi
         3oyA==
X-Forwarded-Encrypted: i=1; AJvYcCUyOVZTXa+mWM7acyB5k+tYSNVJLJfQmlnS73GlZWdLZOHSy5ikxgpzPVBwtxPKqPep3wKzCROpm4XZmbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzabY/NBpL6tEzDdi7IwRLYZYglTkmyekchpXyo+Pi4h86tA3uD
	y8tdfxz7KsDwpayFal+PnPMZqjziwwn+rYlFVjZmJaEGaDJRctUNf8HNF6xBcpUZBLvsu97+UHS
	X1LF4x1k76CeNy2jn7gm8DHaNn3ALfCif3Wabxgz2bj6m1u432+Y8mM8ExI7UUg==
X-Received: by 2002:a05:620a:29c6:b0:7b0:a9c1:64a3 with SMTP id af79cd13be357-7b11a37a266mr2132160685a.39.1728982218275;
        Tue, 15 Oct 2024 01:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMIuvtAdGfcowqrIhPYxqBnPaenpFGZrHqxVqtrDxQLneKEUO7Zw7nn2UxzFf11+TQQBklkQ==
X-Received: by 2002:a05:620a:29c6:b0:7b0:a9c1:64a3 with SMTP id af79cd13be357-7b11a37a266mr2132158785a.39.1728982217760;
        Tue, 15 Oct 2024 01:50:17 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136170512sm43736785a.32.2024.10.15.01.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 01:50:17 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:50:12 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: huangwenyu1998@gmail.com
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] virtio: Make vring_new_virtqueue support for packed
 vring
Message-ID: <e7hs4gacqrg3sc3hbi5avlsoaqbnkuk4xpeodfzth5kdchoemh@cilgkvn6a3kw>
References: <20241013033233.65026-1-huangwenyu1998@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241013033233.65026-1-huangwenyu1998@gmail.com>

On Sun, Oct 13, 2024 at 11:32:33AM +0800, huangwenyu1998@gmail.com wrote:
>From: Wenyu Huang <huangwenyu1998@gmail.com>
>
>It used for testing in tools/virtio/vringh_test.c.
>If vring_new_virtqueue supports packed vring, we can add support for
>packed vring to vringh and test it.

I already asked this in v3, but didn't get an answer:

   Are you also working on that changes?

>
>Signed-off-by: Wenyu Huang <huangwenyu1998@gmail.com>
>---
>Changes in v2: Make the commit title and description more clearer.
>Changes in v3: Remove the declaration of __vring_new_virtqueue_split and
>                           __vring_new_virtqueue_packed and move the definition of
>                           these two functions.
>Changes in v4: Fix checkpatch warnings/errors.
> drivers/virtio/virtio_ring.c | 227 +++++++++++++++++++----------------
> 1 file changed, 121 insertions(+), 106 deletions(-)

The patch LGTM, but maybe we can merge it when we have also the tests 
using it.

Anyway:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>index be7309b1e860..5fce2cce2358 100644
>--- a/drivers/virtio/virtio_ring.c
>+++ b/drivers/virtio/virtio_ring.c
>@@ -223,15 +223,6 @@ struct vring_virtqueue {
> #endif
> };
>
>-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>-					       struct vring_virtqueue_split *vring_split,
>-					       struct virtio_device *vdev,
>-					       bool weak_barriers,
>-					       bool context,
>-					       bool (*notify)(struct virtqueue *),
>-					       void (*callback)(struct virtqueue *),
>-					       const char *name,
>-					       struct device *dma_dev);
> static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> static void vring_free(struct virtqueue *_vq);
>
>@@ -1138,6 +1129,66 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
> 	return 0;
> }
>
>+static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>+					       struct vring_virtqueue_split *vring_split,
>+					       struct virtio_device *vdev,
>+					       bool weak_barriers,
>+					       bool context,
>+					       bool (*notify)(struct virtqueue *),
>+					       void (*callback)(struct virtqueue *),
>+					       const char *name,
>+					       struct device *dma_dev)
>+{
>+	struct vring_virtqueue *vq;
>+	int err;
>+
>+	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
>+	if (!vq)
>+		return NULL;
>+
>+	vq->packed_ring = false;
>+	vq->vq.callback = callback;
>+	vq->vq.vdev = vdev;
>+	vq->vq.name = name;
>+	vq->vq.index = index;
>+	vq->vq.reset = false;
>+	vq->we_own_ring = false;
>+	vq->notify = notify;
>+	vq->weak_barriers = weak_barriers;
>+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>+	vq->broken = true;
>+#else
>+	vq->broken = false;
>+#endif
>+	vq->dma_dev = dma_dev;
>+	vq->use_dma_api = vring_use_dma_api(vdev);
>+	vq->premapped = false;
>+	vq->do_unmap = vq->use_dma_api;
>+
>+	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>+		!context;
>+	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>+
>+	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>+		vq->weak_barriers = false;
>+
>+	err = vring_alloc_state_extra_split(vring_split);
>+	if (err) {
>+		kfree(vq);
>+		return NULL;
>+	}
>+
>+	virtqueue_vring_init_split(vring_split, vq);
>+
>+	virtqueue_init(vq, vring_split->vring.num);
>+	virtqueue_vring_attach_split(vq, vring_split);
>+
>+	spin_lock(&vdev->vqs_list_lock);
>+	list_add_tail(&vq->vq.list, &vdev->vqs);
>+	spin_unlock(&vdev->vqs_list_lock);
>+	return &vq->vq;
>+}
>+
> static struct virtqueue *vring_create_virtqueue_split(
> 	unsigned int index,
> 	unsigned int num,
>@@ -1160,7 +1211,7 @@ static struct virtqueue *vring_create_virtqueue_split(
> 	if (err)
> 		return NULL;
>
>-	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
>+	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
> 				   context, notify, callback, name, dma_dev);
> 	if (!vq) {
> 		vring_free_split(&vring_split, vdev, dma_dev);
>@@ -2050,36 +2101,29 @@ static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
> 	virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
> }
>
>-static struct virtqueue *vring_create_virtqueue_packed(
>-	unsigned int index,
>-	unsigned int num,
>-	unsigned int vring_align,
>-	struct virtio_device *vdev,
>-	bool weak_barriers,
>-	bool may_reduce_num,
>-	bool context,
>-	bool (*notify)(struct virtqueue *),
>-	void (*callback)(struct virtqueue *),
>-	const char *name,
>-	struct device *dma_dev)
>+static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>+					       struct vring_virtqueue_packed *vring_packed,
>+					       struct virtio_device *vdev,
>+					       bool weak_barriers,
>+					       bool context,
>+					       bool (*notify)(struct virtqueue *),
>+					       void (*callback)(struct virtqueue *),
>+					       const char *name,
>+					       struct device *dma_dev)
> {
>-	struct vring_virtqueue_packed vring_packed = {};
> 	struct vring_virtqueue *vq;
> 	int err;
>
>-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
>-		goto err_ring;
>-
> 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
> 	if (!vq)
>-		goto err_vq;
>+		return NULL;
>
> 	vq->vq.callback = callback;
> 	vq->vq.vdev = vdev;
> 	vq->vq.name = name;
> 	vq->vq.index = index;
> 	vq->vq.reset = false;
>-	vq->we_own_ring = true;
>+	vq->we_own_ring = false;
> 	vq->notify = notify;
> 	vq->weak_barriers = weak_barriers;
> #ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>@@ -2100,26 +2144,52 @@ static struct virtqueue *vring_create_virtqueue_packed(
> 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> 		vq->weak_barriers = false;
>
>-	err = vring_alloc_state_extra_packed(&vring_packed);
>-	if (err)
>-		goto err_state_extra;
>+	err = vring_alloc_state_extra_packed(vring_packed);
>+	if (err) {
>+		kfree(vq);
>+		return NULL;
>+	}
>
>-	virtqueue_vring_init_packed(&vring_packed, !!callback);
>+	virtqueue_vring_init_packed(vring_packed, !!callback);
>
>-	virtqueue_init(vq, num);
>-	virtqueue_vring_attach_packed(vq, &vring_packed);
>+	virtqueue_init(vq, vring_packed->vring.num);
>+	virtqueue_vring_attach_packed(vq, vring_packed);
>
> 	spin_lock(&vdev->vqs_list_lock);
> 	list_add_tail(&vq->vq.list, &vdev->vqs);
> 	spin_unlock(&vdev->vqs_list_lock);
> 	return &vq->vq;
>+}
>
>-err_state_extra:
>-	kfree(vq);
>-err_vq:
>-	vring_free_packed(&vring_packed, vdev, dma_dev);
>-err_ring:
>-	return NULL;
>+static struct virtqueue *vring_create_virtqueue_packed(
>+	unsigned int index,
>+	unsigned int num,
>+	unsigned int vring_align,
>+	struct virtio_device *vdev,
>+	bool weak_barriers,
>+	bool may_reduce_num,
>+	bool context,
>+	bool (*notify)(struct virtqueue *),
>+	void (*callback)(struct virtqueue *),
>+	const char *name,
>+	struct device *dma_dev)
>+{
>+	struct vring_virtqueue_packed vring_packed = {};
>+	struct virtqueue *vq;
>+
>+	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
>+		return NULL;
>+
>+	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
>+					context, notify, callback, name, dma_dev);
>+	if (!vq) {
>+		vring_free_packed(&vring_packed, vdev, dma_dev);
>+		return NULL;
>+	}
>+
>+	to_vvq(vq)->we_own_ring = true;
>+
>+	return vq;
> }
>
> static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
>@@ -2598,69 +2668,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> }
> EXPORT_SYMBOL_GPL(vring_interrupt);
>
>-/* Only available for split ring */
>-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>-					       struct vring_virtqueue_split *vring_split,
>-					       struct virtio_device *vdev,
>-					       bool weak_barriers,
>-					       bool context,
>-					       bool (*notify)(struct virtqueue *),
>-					       void (*callback)(struct virtqueue *),
>-					       const char *name,
>-					       struct device *dma_dev)
>-{
>-	struct vring_virtqueue *vq;
>-	int err;
>-
>-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>-		return NULL;
>-
>-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
>-	if (!vq)
>-		return NULL;
>-
>-	vq->packed_ring = false;
>-	vq->vq.callback = callback;
>-	vq->vq.vdev = vdev;
>-	vq->vq.name = name;
>-	vq->vq.index = index;
>-	vq->vq.reset = false;
>-	vq->we_own_ring = false;
>-	vq->notify = notify;
>-	vq->weak_barriers = weak_barriers;
>-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>-	vq->broken = true;
>-#else
>-	vq->broken = false;
>-#endif
>-	vq->dma_dev = dma_dev;
>-	vq->use_dma_api = vring_use_dma_api(vdev);
>-	vq->premapped = false;
>-	vq->do_unmap = vq->use_dma_api;
>
>-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>-		!context;
>-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>-
>-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>-		vq->weak_barriers = false;
>-
>-	err = vring_alloc_state_extra_split(vring_split);
>-	if (err) {
>-		kfree(vq);
>-		return NULL;
>-	}
>-
>-	virtqueue_vring_init_split(vring_split, vq);
>-
>-	virtqueue_init(vq, vring_split->vring.num);
>-	virtqueue_vring_attach_split(vq, vring_split);
>-
>-	spin_lock(&vdev->vqs_list_lock);
>-	list_add_tail(&vq->vq.list, &vdev->vqs);
>-	spin_unlock(&vdev->vqs_list_lock);
>-	return &vq->vq;
>-}
>
> struct virtqueue *vring_create_virtqueue(
> 	unsigned int index,
>@@ -2840,7 +2848,6 @@ int virtqueue_reset(struct virtqueue *_vq,
> }
> EXPORT_SYMBOL_GPL(virtqueue_reset);
>
>-/* Only available for split ring */
> struct virtqueue *vring_new_virtqueue(unsigned int index,
> 				      unsigned int num,
> 				      unsigned int vring_align,
>@@ -2854,11 +2861,19 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
> {
> 	struct vring_virtqueue_split vring_split = {};
>
>-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>-		return NULL;
>+	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
>+		struct vring_virtqueue_packed vring_packed = {};
>+
>+		vring_packed.vring.num = num;
>+		vring_packed.vring.desc = pages;
>+		return __vring_new_virtqueue_packed(index, &vring_packed,
>+						    vdev, weak_barriers,
>+						    context, notify, callback,
>+						    name, vdev->dev.parent);
>+	}
>
> 	vring_init(&vring_split.vring, num, pages, vring_align);
>-	return __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
>+	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
> 				     context, notify, callback, name,
> 				     vdev->dev.parent);
> }
>-- 
>2.43.0
>



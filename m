Return-Path: <linux-kernel+bounces-337667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC24984D41
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F3BB20548
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EA513D89D;
	Tue, 24 Sep 2024 22:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrdgFOgL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A548480043
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215359; cv=none; b=pO83Y/S+Fn4sUwuv0Xcjazb18KYh9UyDIV/e/gUWkvJ+SD3PcXup41ZUEhyBocjmQTp1pZtk9YEccwtgf7I2L62dA3eK4yj71XTy4vefHemol1uf0jDAYReZQeCoe/F7XwdPKjD0P6mcYONFmaSuWC7K8ELHj/2+TOuBRlq7ZVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215359; c=relaxed/simple;
	bh=pu5G5qXLTl3zSGB+7dQNsdrINE8JNYhjhl+yhhCbdIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s23PnBMqVk1NFCNIyoSvPGjpJNGGEG1bAIwzzpvukAX8skORVAS9L0rn9oRybEKSZP/ZL0DXl/3vGOmyGG4h+qgFnKj+mhe9655dKf8iLym1fTftos345SG0Vb83D8HoO6O9MXVtqJz9PJ7sN0A1Q57gnBoKp8oRhE9M/nDuIr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrdgFOgL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727215356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p08RO7jNAHbqAPJ0LfZ/6PkDLGb4/JJG3jEYdwRpx2U=;
	b=SrdgFOgL5BteIT1bO+F6tZjNnKpy8qCk5Q/0g/tGX4bMZexV6vknR6LkigabOrIScQ+9j8
	qS13kVpYO7adhWiQkYCXEaInud05RxWEKWY13m2WaCBHVUEo+T6fpWWjQ4671AHnfgQqZG
	Ae09HBtaQCOswFkA8rOfMxrDfcDPdp8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-ni67PjrKNpykW7H6zWP21A-1; Tue, 24 Sep 2024 18:02:35 -0400
X-MC-Unique: ni67PjrKNpykW7H6zWP21A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-378929f1a4eso3049293f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 15:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727215354; x=1727820154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p08RO7jNAHbqAPJ0LfZ/6PkDLGb4/JJG3jEYdwRpx2U=;
        b=ekjW1eedXyR92qm1P8DHTvYeaIM/G82dkYDzx4QV6rzf7AqxrWTZbyVCLVEh4voro2
         4jLMxj2uSiTwcKq+qQ7hr9YXCXiOjd/XnRTk6dcxgfC/Ok5UlO6lTdS9Ce4NR7zHYWen
         LSsrhHYOOg+SXnj77AqlQ9qXVKisuwh6QkvuViM4VzomqAy1L+toF1BjkTupWC3030oh
         Ty6rKnfQFlYWuZOBsb9obqO8ksOuyQPl8x3dn0rHZ9WGFQI4UlItHvpnjpdSwP2P/EJu
         dmudF45DsEXkSx4j0lNb5oZYONDToNf/9Dd3IQ4gedTKhEqZnDgicWGENogj3KpD7A35
         +gPw==
X-Forwarded-Encrypted: i=1; AJvYcCXRlJlsvOeDfpZtXiS14QF8J7wY3DNEQZmEg57bG48EzumnxiRPBLrW6yx5PZdQxSzwf0BkMm7LUkO74Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVHDEXIpn1jVw0XKmrCTPxipaz4eO9sqvA9g447X1+YkOr2f3
	5lYYHPuB9kKsMhwzftE6TaY+Psnhrc0itQIKJJPjPS3QHrcfEglEGuA+s7uemu3u8CejN2ZhkeC
	H7666/6Ju6G6ykIus9nDjFbZ+jstEVn+e/ZRK+RrxL7XW/HLGlVvv1KXfpkXa3A==
X-Received: by 2002:adf:c006:0:b0:374:c142:80e7 with SMTP id ffacd0b85a97d-37cc245c0d7mr469099f8f.1.1727215354152;
        Tue, 24 Sep 2024 15:02:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE798q0O7Fe/wwcjVDfqt4MNQ2Rk3GAssMMKcDml1GPXBnju2SlRN5umha2Yafd8UUyK6orbQ==
X-Received: by 2002:adf:c006:0:b0:374:c142:80e7 with SMTP id ffacd0b85a97d-37cc245c0d7mr469086f8f.1.1727215353661;
        Tue, 24 Sep 2024 15:02:33 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7405:9900:56a3:401a:f419:5de9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2f96f6sm2496359f8f.87.2024.09.24.15.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 15:02:29 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:02:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wenyu Huang <huangwenyu1998@gmail.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: Make vring_new_virtqueue support for packed vring
Message-ID: <20240924175414-mutt-send-email-mst@kernel.org>
References: <20240920202141.89446-1-huangwenyuu@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240920202141.89446-1-huangwenyuu@outlook.com>

On Sat, Sep 21, 2024 at 04:21:41AM +0800, Wenyu Huang wrote:
> From: Wenyu Huang <huangwenyu1998@gmail.com>
> 
> It's also available for packed ring now.
> 
> Signed-off-by: Wenyu Huang <huangwenyu1998@gmail.com>


More specifically, what are you trying to address here?
Which configuration did not work but does now?

> ---
>  drivers/virtio/virtio_ring.c | 153 +++++++++++++++++++++--------------
>  1 file changed, 92 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..664a0c40ee05 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -223,7 +223,7 @@ struct vring_virtqueue {
>  #endif
>  };
>  
> -static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> +static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  					       struct vring_virtqueue_split *vring_split,
>  					       struct virtio_device *vdev,
>  					       bool weak_barriers,
> @@ -232,6 +232,15 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  					       void (*callback)(struct virtqueue *),
>  					       const char *name,
>  					       struct device *dma_dev);
> +static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
> +					       struct vring_virtqueue_packed *vring_packed,
> +					       struct virtio_device *vdev,
> +					       bool weak_barriers,
> +					       bool context,
> +					       bool (*notify)(struct virtqueue *),
> +					       void (*callback)(struct virtqueue *),
> +					       const char *name,
> +					       struct device *dma_dev);
>  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
>  static void vring_free(struct virtqueue *_vq);
>  
> @@ -1160,7 +1169,7 @@ static struct virtqueue *vring_create_virtqueue_split(
>  	if (err)
>  		return NULL;
>  
> -	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
> +	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
>  				   context, notify, callback, name, dma_dev);
>  	if (!vq) {
>  		vring_free_split(&vring_split, vdev, dma_dev);
> @@ -2064,62 +2073,21 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	struct device *dma_dev)
>  {
>  	struct vring_virtqueue_packed vring_packed = {};
> -	struct vring_virtqueue *vq;
> -	int err;
> +	struct virtqueue *vq;
>  
>  	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
> -		goto err_ring;
> -
> -	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
> -	if (!vq)
> -		goto err_vq;
> -
> -	vq->vq.callback = callback;
> -	vq->vq.vdev = vdev;
> -	vq->vq.name = name;
> -	vq->vq.index = index;
> -	vq->vq.reset = false;
> -	vq->we_own_ring = true;
> -	vq->notify = notify;
> -	vq->weak_barriers = weak_barriers;
> -#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> -	vq->broken = true;
> -#else
> -	vq->broken = false;
> -#endif
> -	vq->packed_ring = true;
> -	vq->dma_dev = dma_dev;
> -	vq->use_dma_api = vring_use_dma_api(vdev);
> -	vq->premapped = false;
> -	vq->do_unmap = vq->use_dma_api;
> -
> -	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> -		!context;
> -	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> -
> -	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> -		vq->weak_barriers = false;
> -
> -	err = vring_alloc_state_extra_packed(&vring_packed);
> -	if (err)
> -		goto err_state_extra;
> -
> -	virtqueue_vring_init_packed(&vring_packed, !!callback);
> +		return NULL;
>  
> -	virtqueue_init(vq, num);
> -	virtqueue_vring_attach_packed(vq, &vring_packed);
> +	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
> +					context, notify, callback, name, dma_dev);
> +	if (!vq) {
> +		vring_free_packed(&vring_packed, vdev, dma_dev);
> +		return NULL;
> +	}
>  
> -	spin_lock(&vdev->vqs_list_lock);
> -	list_add_tail(&vq->vq.list, &vdev->vqs);
> -	spin_unlock(&vdev->vqs_list_lock);
> -	return &vq->vq;
> +	to_vvq(vq)->we_own_ring = true;
>  
> -err_state_extra:
> -	kfree(vq);
> -err_vq:
> -	vring_free_packed(&vring_packed, vdev, dma_dev);
> -err_ring:
> -	return NULL;
> +	return vq;
>  }
>  
>  static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
> @@ -2599,7 +2567,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
>  EXPORT_SYMBOL_GPL(vring_interrupt);
>  
>  /* Only available for split ring */
> -static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> +static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>  					       struct vring_virtqueue_split *vring_split,
>  					       struct virtio_device *vdev,
>  					       bool weak_barriers,
> @@ -2612,9 +2580,6 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	struct vring_virtqueue *vq;
>  	int err;
>  
> -	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> -		return NULL;
> -
>  	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
>  	if (!vq)
>  		return NULL;
> @@ -2662,6 +2627,66 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	return &vq->vq;
>  }
>  
> +static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
> +					       struct vring_virtqueue_packed *vring_packed,
> +					       struct virtio_device *vdev,
> +					       bool weak_barriers,
> +					       bool context,
> +					       bool (*notify)(struct virtqueue *),
> +					       void (*callback)(struct virtqueue *),
> +					       const char *name,
> +					       struct device *dma_dev)
> +{
> +	struct vring_virtqueue *vq;
> +	int err;
> +
> +	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
> +	if (!vq)
> +		return NULL;
> +
> +	vq->vq.callback = callback;
> +	vq->vq.vdev = vdev;
> +	vq->vq.name = name;
> +	vq->vq.index = index;
> +	vq->vq.reset = false;
> +	vq->we_own_ring = false;
> +	vq->notify = notify;
> +	vq->weak_barriers = weak_barriers;
> +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> +	vq->broken = true;
> +#else
> +	vq->broken = false;
> +#endif
> +	vq->packed_ring = true;
> +	vq->dma_dev = dma_dev;
> +	vq->use_dma_api = vring_use_dma_api(vdev);
> +	vq->premapped = false;
> +	vq->do_unmap = vq->use_dma_api;
> +
> +	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
> +		!context;
> +	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
> +
> +	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> +		vq->weak_barriers = false;
> +
> +	err = vring_alloc_state_extra_packed(vring_packed);
> +	if (err) {
> +		kfree(vq);
> +		return NULL;
> +	}
> +
> +	virtqueue_vring_init_packed(vring_packed, !!callback);
> +
> +	virtqueue_init(vq, vring_packed->vring.num);
> +	virtqueue_vring_attach_packed(vq, vring_packed);
> +
> +	spin_lock(&vdev->vqs_list_lock);
> +	list_add_tail(&vq->vq.list, &vdev->vqs);
> +	spin_unlock(&vdev->vqs_list_lock);
> +	return &vq->vq;
> +}
> +
>  struct virtqueue *vring_create_virtqueue(
>  	unsigned int index,
>  	unsigned int num,
> @@ -2840,7 +2865,6 @@ int virtqueue_reset(struct virtqueue *_vq,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_reset);
>  
> -/* Only available for split ring */
>  struct virtqueue *vring_new_virtqueue(unsigned int index,
>  				      unsigned int num,
>  				      unsigned int vring_align,
> @@ -2853,12 +2877,19 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  				      const char *name)
>  {
>  	struct vring_virtqueue_split vring_split = {};
> +	struct vring_virtqueue_packed vring_packed = {};
>  
> -	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> -		return NULL;
> +	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
> +		vring_packed.vring.num = num;
> +		vring_packed.vring.desc = pages;
> +		return __vring_new_virtqueue_packed(index, &vring_packed,
> +						    vdev, weak_barriers,
> +						    context, notify, callback,
> +						    name, vdev->dev.parent);
> +	}
>  
>  	vring_init(&vring_split.vring, num, pages, vring_align);
> -	return __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
> +	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
>  				     context, notify, callback, name,
>  				     vdev->dev.parent);
>  }
> -- 
> 2.43.0



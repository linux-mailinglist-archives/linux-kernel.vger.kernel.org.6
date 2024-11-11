Return-Path: <linux-kernel+bounces-403685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D59C3909
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03CA281095
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D821547F2;
	Mon, 11 Nov 2024 07:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQM9QBYB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FEC73176
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731310227; cv=none; b=U3Ra0ykpG5wVykzRislRmf0cyPTxcXV/CXaR7fzs3zW/oIJTcHoA8bChD5ZDcdVQ9gCIX+M83YjOLBHf7miN9knjkKqOXGPtwOuYXq6CgLyhEbw1uYTPl3kKlG5CD+YKi66OX0QWRg+2U4yacpK942D20taol/4tJPlpmMBMADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731310227; c=relaxed/simple;
	bh=y7m+qe/6Hk9OqmIwKPFA2Ws457l9mrlbLZfBIIaqhx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2j8WRQY0qPRpOycoGN+t2zYDtvTuetPhRYuim5zHzvFm3f3bXqnJree/3mUmlEwPJSXHf2sFJMXuxt/zRCBPMtlu6D+UaoZGmgVP+hPBS6EqDdcdY6nGDXrrDnKrKNCTE34Y/JKz64y9ZS9LGiOxOeiKykKBgweWw3Hmn7wW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQM9QBYB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731310224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YXJTAPJRJSE40v52va9xJnnCxZQQit5rD5JjIYG43lo=;
	b=WQM9QBYBIUdZWainUdzyGyLjAb5J0OCD4y/o3zdjJaGxNFRzesD4DCxtcOhQO6vkAWM6qe
	WOLR9W1nTGp+2sMrQDQr1Hvo1aM+9Mm6CfXgMgxfzavh9f4T2csQV7Y4xQWCUKDAjX2NaZ
	zKRMvEzeLX8idihLpmSyy3zHnMaJ2vs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-0zaEqePdPUO1wS-CoBw5nw-1; Mon, 11 Nov 2024 02:30:22 -0500
X-MC-Unique: 0zaEqePdPUO1wS-CoBw5nw-1
X-Mimecast-MFC-AGG-ID: 0zaEqePdPUO1wS-CoBw5nw
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2fb5cdaba8aso26501711fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 23:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731310221; x=1731915021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXJTAPJRJSE40v52va9xJnnCxZQQit5rD5JjIYG43lo=;
        b=tzVwxGRaotCLOUYsxKSEywGDubLUAKXln2GyiyT2Q20+ISyi1+/Www4aG6JoXbd6Py
         vsqvN1y9NeEX7Y8LZsCDM/muMR99/ELZtoXsc31tOzh4YYpdGKF+doFgruze5coMrq/I
         FROa08SQd7iThvblZIbk5Dz/ftuKvajmpcU04LqARxF6l501mTcCIMNgp69fj9ulL75A
         BUSNoxhE7O+yW1hpx4jQAxayT6UP2T0ncMHXpKZjbr94plSKCoPn2G94+o5L+8nSJBj6
         BxnaQwKTLeor3jtyOYEhYxN5x3a5UBq9Ffdq9U1Je+jhTAmmLXQx3SEPVwrP5mgLm2SX
         H89w==
X-Forwarded-Encrypted: i=1; AJvYcCWAe3Kt3zOkviJfsJC4Ug7lnSLskBuCLiJgNJpH9pdeNkaEVhxXL8khy5JxkXCdFlQO7KisV3t+HGcv9NI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9zOLxqdzQDrPlcgfXxw4R5STUkxKN7tJygXxLnPO5FpIf/I9g
	gbV2NWeT7kFsesHJYvvqVw3P6lDhHVkxoxueuvaBCTrfXmpjC4gDGO9NF1jpGJ+NKJMYl7SEzSy
	YQGiHhwe5HBXnWIsbQfbvU51IusjdAv1ACWM8qrarS86z8peCelj49oF7yq/pTg==
X-Received: by 2002:a05:6512:1108:b0:539:89a8:600f with SMTP id 2adb3069b0e04-53d862c7292mr7325555e87.23.1731310220802;
        Sun, 10 Nov 2024 23:30:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbA8GHrAoHhI8IG5qB5I52hrPURR4gyZorTCm5EgyxcOpYDfczigvh0oECQWwPpX6q7xCCzw==
X-Received: by 2002:a05:6512:1108:b0:539:89a8:600f with SMTP id 2adb3069b0e04-53d862c7292mr7325532e87.23.1731310220304;
        Sun, 10 Nov 2024 23:30:20 -0800 (PST)
Received: from redhat.com ([2.52.135.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a176d6sm564756866b.13.2024.11.10.23.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 23:30:19 -0800 (PST)
Date: Mon, 11 Nov 2024 02:30:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_ring: skip cpu sync when mapping fails
Message-ID: <20241111022931-mutt-send-email-mst@kernel.org>
References: <20241111025538.2837-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111025538.2837-1-jasowang@redhat.com>

On Mon, Nov 11, 2024 at 10:55:38AM +0800, Jason Wang wrote:
> There's no need to sync DMA for CPU on mapping errors. So this patch
> skips the CPU sync in the error handling path of DMA mapping.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

DMA sync is idempotent.
Extra work for slow path.  Why do we bother?

> ---
>  drivers/virtio/virtio_ring.c | 98 +++++++++++++++++++++---------------
>  1 file changed, 57 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index be7309b1e860..b422b5fb22db 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -441,8 +441,10 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
>   */
>  
>  static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
> -					   const struct vring_desc *desc)
> +					   const struct vring_desc *desc,
> +					   bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	u16 flags;
>  
>  	if (!vq->do_unmap)
> @@ -450,16 +452,18 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
>  
>  	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
>  
> -	dma_unmap_page(vring_dma_dev(vq),
> -		       virtio64_to_cpu(vq->vq.vdev, desc->addr),
> -		       virtio32_to_cpu(vq->vq.vdev, desc->len),
> -		       (flags & VRING_DESC_F_WRITE) ?
> -		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	dma_unmap_page_attrs(vring_dma_dev(vq),
> +			     virtio64_to_cpu(vq->vq.vdev, desc->addr),
> +			     virtio32_to_cpu(vq->vq.vdev, desc->len),
> +			     (flags & VRING_DESC_F_WRITE) ?
> +			     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +			     attrs);
>  }
>  
>  static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
> -					  unsigned int i)
> +					  unsigned int i, bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	struct vring_desc_extra *extra = vq->split.desc_extra;
>  	u16 flags;
>  
> @@ -469,20 +473,22 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
>  		if (!vq->use_dma_api)
>  			goto out;
>  
> -		dma_unmap_single(vring_dma_dev(vq),
> -				 extra[i].addr,
> -				 extra[i].len,
> -				 (flags & VRING_DESC_F_WRITE) ?
> -				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_single_attrs(vring_dma_dev(vq),
> +				       extra[i].addr,
> +				       extra[i].len,
> +				       (flags & VRING_DESC_F_WRITE) ?
> +				       DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				       attrs);
>  	} else {
>  		if (!vq->do_unmap)
>  			goto out;
>  
> -		dma_unmap_page(vring_dma_dev(vq),
> -			       extra[i].addr,
> -			       extra[i].len,
> -			       (flags & VRING_DESC_F_WRITE) ?
> -			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_page_attrs(vring_dma_dev(vq),
> +				     extra[i].addr,
> +				     extra[i].len,
> +				     (flags & VRING_DESC_F_WRITE) ?
> +				     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				     attrs);
>  	}
>  
>  out:
> @@ -717,10 +723,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  		if (i == err_idx)
>  			break;
>  		if (indirect) {
> -			vring_unmap_one_split_indirect(vq, &desc[i]);
> +			vring_unmap_one_split_indirect(vq, &desc[i], true);
>  			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
>  		} else
> -			i = vring_unmap_one_split(vq, i);
> +			i = vring_unmap_one_split(vq, i, true);
>  	}
>  
>  free_indirect:
> @@ -775,12 +781,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  	i = head;
>  
>  	while (vq->split.vring.desc[i].flags & nextflag) {
> -		vring_unmap_one_split(vq, i);
> +		vring_unmap_one_split(vq, i, false);
>  		i = vq->split.desc_extra[i].next;
>  		vq->vq.num_free++;
>  	}
>  
> -	vring_unmap_one_split(vq, i);
> +	vring_unmap_one_split(vq, i, false);
>  	vq->split.desc_extra[i].next = vq->free_head;
>  	vq->free_head = head;
>  
> @@ -804,7 +810,8 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
>  
>  		if (vq->do_unmap) {
>  			for (j = 0; j < len / sizeof(struct vring_desc); j++)
> -				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
> +				vring_unmap_one_split_indirect(vq,
> +							&indir_desc[j], false);
>  		}
>  
>  		kfree(indir_desc);
> @@ -1221,8 +1228,10 @@ static u16 packed_last_used(u16 last_used_idx)
>  }
>  
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> -				     const struct vring_desc_extra *extra)
> +				     const struct vring_desc_extra *extra,
> +				     bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	u16 flags;
>  
>  	flags = extra->flags;
> @@ -1231,24 +1240,28 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>  		if (!vq->use_dma_api)
>  			return;
>  
> -		dma_unmap_single(vring_dma_dev(vq),
> -				 extra->addr, extra->len,
> -				 (flags & VRING_DESC_F_WRITE) ?
> -				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_single_attrs(vring_dma_dev(vq),
> +				       extra->addr, extra->len,
> +				       (flags & VRING_DESC_F_WRITE) ?
> +				       DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				       attrs);
>  	} else {
>  		if (!vq->do_unmap)
>  			return;
>  
> -		dma_unmap_page(vring_dma_dev(vq),
> -			       extra->addr, extra->len,
> -			       (flags & VRING_DESC_F_WRITE) ?
> -			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		dma_unmap_page_attrs(vring_dma_dev(vq),
> +				     extra->addr, extra->len,
> +				     (flags & VRING_DESC_F_WRITE) ?
> +				     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +				     attrs);
>  	}
>  }
>  
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
> -				    const struct vring_packed_desc *desc)
> +				    const struct vring_packed_desc *desc,
> +				    bool skip_sync)
>  {
> +	unsigned long attrs = skip_sync ? DMA_ATTR_SKIP_CPU_SYNC : 0;
>  	u16 flags;
>  
>  	if (!vq->do_unmap)
> @@ -1256,11 +1269,12 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>  
>  	flags = le16_to_cpu(desc->flags);
>  
> -	dma_unmap_page(vring_dma_dev(vq),
> -		       le64_to_cpu(desc->addr),
> -		       le32_to_cpu(desc->len),
> -		       (flags & VRING_DESC_F_WRITE) ?
> -		       DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +	dma_unmap_page_attrs(vring_dma_dev(vq),
> +			     le64_to_cpu(desc->addr),
> +			     le32_to_cpu(desc->len),
> +			     (flags & VRING_DESC_F_WRITE) ?
> +			     DMA_FROM_DEVICE : DMA_TO_DEVICE,
> +			     attrs);
>  }
>  
>  static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
> @@ -1389,7 +1403,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	err_idx = i;
>  
>  	for (i = 0; i < err_idx; i++)
> -		vring_unmap_desc_packed(vq, &desc[i]);
> +		vring_unmap_desc_packed(vq, &desc[i], true);
>  
>  free_desc:
>  	kfree(desc);
> @@ -1539,7 +1553,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	for (n = 0; n < total_sg; n++) {
>  		if (i == err_idx)
>  			break;
> -		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
> +		vring_unmap_extra_packed(vq,
> +					 &vq->packed.desc_extra[curr], true);
>  		curr = vq->packed.desc_extra[curr].next;
>  		i++;
>  		if (i >= vq->packed.vring.num)
> @@ -1619,7 +1634,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  		curr = id;
>  		for (i = 0; i < state->num; i++) {
>  			vring_unmap_extra_packed(vq,
> -						 &vq->packed.desc_extra[curr]);
> +						 &vq->packed.desc_extra[curr],
> +						 false);
>  			curr = vq->packed.desc_extra[curr].next;
>  		}
>  	}
> @@ -1636,7 +1652,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
>  			len = vq->packed.desc_extra[id].len;
>  			for (i = 0; i < len / sizeof(struct vring_packed_desc);
>  					i++)
> -				vring_unmap_desc_packed(vq, &desc[i]);
> +				vring_unmap_desc_packed(vq, &desc[i], false);
>  		}
>  		kfree(desc);
>  		state->indir_desc = NULL;
> -- 
> 2.31.1



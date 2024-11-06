Return-Path: <linux-kernel+bounces-397946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CEC9BE2CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E3E283B86
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41EE1DB37C;
	Wed,  6 Nov 2024 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWxMOJu/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338691D7E37
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730885892; cv=none; b=TQaTaszSTu9HG5aY+0BDJg8gcswMco+XD0UaqG7/sr4mFusrRv/tBhJNXMebYCIj55SA9XpCWzCCtxYsJYHAvRCQdbDDZOSLaMnqJO8cU2OfSyqCFDd4O5KangSyGtgpDykVp4XCz3ut6KVZjlMNJsiS1oPGJ/YtJbpaHDz7tBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730885892; c=relaxed/simple;
	bh=qhojXh+8f8lqP8dlnX6invA3j3Nx0LRtuYC4ZQVzoPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXsBEH00Jm6kmfhj8fNe/18/CHJml0IAIHUTZBZ3xbtJkyUUe6XOYtSMHwMfQuJbtandJa9Mv9xlaYjVr5FIvH+patHsC/PUdqBlAYOraSaGA05T64aABHogd0krS30d74NRdXh6tBspEbGWE6V+NdZ0mmjV56jT0egdFDBcVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWxMOJu/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730885889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tvxcs3klJ/A4YbjBLveb2yNbDmkidjq6Jed3PsW1XAQ=;
	b=XWxMOJu/j5he44yKEA7T2euz2vvIynMnafaKIecB2IrNqbPOgKTvjw6f5dx6KLfq865Jfx
	a2GsvOdBiiyMNHqpZ81mMkEAw7Vnc6Dd5kJggD9dn3Yr1CfBV0xPPlGsjaB71t1xsmz8Ex
	otZmMjgFC4ma3O9jirZH8NIrVTInsQ4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-MQc5-5Y-MlqFFXHdpGHToQ-1; Wed, 06 Nov 2024 04:38:06 -0500
X-MC-Unique: MQc5-5Y-MlqFFXHdpGHToQ-1
X-Mimecast-MFC-AGG-ID: MQc5-5Y-MlqFFXHdpGHToQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-431673032e6so38121015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 01:38:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730885885; x=1731490685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tvxcs3klJ/A4YbjBLveb2yNbDmkidjq6Jed3PsW1XAQ=;
        b=g4zC+yLgTs4vnKW1TN12XUUC56s9Fyd1pPEXTdG8Jge7KuC9dVhKaaJ2hH2y6qjLb/
         B7tiQVgBwvYjkP8bARq0HPq4FpSbdRLHfMC+6RL4tkoMm1ul4bVJONpIjSz5XNQe7ltL
         cLWst/vuv+lOtLUERGRAAOKx1Hzx+Fy9HgKArgH8jhj/WWqkNtW7dMqP8/1mlRMqqEKm
         THmyWIAhe641R+31Pkd1wVSuNH4tJjb9cfjLB/mxsyiKVl8sgIWZHka/N7mGK6gIKgmP
         sLXFnEnvvulMYMYIY1lhRwntafRVP4iIRWkW7Acx7OEW9ZKA3reqIe+1OqyBsEVXH2m4
         Y+nA==
X-Forwarded-Encrypted: i=1; AJvYcCW1u8OQhVRiJkPSMJOQQmxp+TZ3EX2T7WBaWhThiKKpg5HK1M163Byc5bwqAHHtwq1HnSHm3qPrpa2m5uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJlYGKTQwWry0bqQ6hKyvgcJngcwnijDMUa+87UJHuEnWxISk
	A7WkHKy4lE8ligi5o6eQx40vPqq4WaNB+VV8tKGY6zpOyaIpk4n4xyB/2X2WnlKAPAHvyJL6BQT
	5Oq229W11N8L06lVUNpK97W0Mxsa9HmXmeNZxthSyymfc9pcef97kuUUv1zk1LQ==
X-Received: by 2002:a05:600c:3b14:b0:431:5f1c:8352 with SMTP id 5b1f17b1804b1-431bb97740fmr240931815e9.5.1730885883274;
        Wed, 06 Nov 2024 01:38:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrNcL0u88UTcm0hhm2RVRrbbZfDvlaPei1PJ2BPq0B+lSLvjDXJBZ45DuzBOhT4k68spyimg==
X-Received: by 2002:a05:600c:3b14:b0:431:5f1c:8352 with SMTP id 5b1f17b1804b1-431bb97740fmr240930955e9.5.1730885881380;
        Wed, 06 Nov 2024 01:38:01 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4d1fsm18449065f8f.38.2024.11.06.01.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:38:00 -0800 (PST)
Date: Wed, 6 Nov 2024 04:37:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jasowang@redhat.co, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	mie@igel.co.jp
Subject: Re: [PATCH] virtio-pci: Add MSI support
Message-ID: <20241106043714-mutt-send-email-mst@kernel.org>
References: <20240712142914.16979-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712142914.16979-1-manivannan.sadhasivam@linaro.org>

On Fri, Jul 12, 2024 at 07:59:14PM +0530, Manivannan Sadhasivam wrote:
> Virtio spec has so far only supported MSI-X and INTX for receiving the
> interrupts from the virtio device on PCI transport. But this becomes a
> limiting factor for devices supporting only MSI (plus INTX emulation) as
> they have to use the legacy INTX emulation which is limited to one IRQ per
> PCIe function.
> 
> But this now addressed with the help of a proposal to the Virtio spec
> adding MSI support [1]. Based on that, let's implement MSI support in the
> virtio-pci driver.
> 
> The Virtio spec proposal reuses the existing MSI-X infrastructure, like the
> config_msix_vector/queue_msix_vector fields of the Virito common config
> structure. Following that, MSI support in virtio-pci driver is also added
> on top of the existing MSI-X implementation and it mostly reuses the MSI-X
> code base. The existing vp_find_vqs_msix() API is modified to support MSI
> along with MSI-X.
> 
> The preference for interrupt allocation is still given to MSI-X as per the
> spec. The driver will try to allocate MSI only if both of the MSI-X
> allocations (one vector for each queue and 2 vectors) fails. As like MSI-X,
> driver will try to allocate one MSI vector for each queue first, and if
> that fails, it will try to allocate 2 vectors (one for config queue and one
> shared for queues). If both of them fails, driver will fallback to the
> legacy INTX as usual.
> 
> For keeping the changes minimal, existing 'virtio_pci_device::msix_enabled'
> flag is used to indicate the status of MSI and MSI-X. Rest of the MSI-X
> functionalities such as IRQ affinity are also reused for MSI (but the
> affinity setting really depends on the underlying IRQCHIP controller).
> 
> [1] https://lore.kernel.org/virtio-comment/20240712140144.12066-1-manivannan.sadhasivam@linaro.org/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

So I think the spec versions are mostly acceptable to people.
So you want TC to vote as is or tweak it?

In any case, this patch has to be rebased to be applied.



> ---
>  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++------
>  drivers/virtio/virtio_pci_common.h |  2 +-
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index f6b0b00e4599..6f80b0c46c5f 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -100,11 +100,11 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
>  }
>  
>  static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> -				   bool per_vq_vectors, struct irq_affinity *desc)
> +				   bool per_vq_vectors, struct irq_affinity *desc,
> +				   unsigned int flags)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	const char *name = dev_name(&vp_dev->vdev.dev);
> -	unsigned int flags = PCI_IRQ_MSIX;
>  	unsigned int i, v;
>  	int err = -ENOMEM;
>  
> @@ -288,7 +288,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  		struct virtqueue *vqs[], vq_callback_t *callbacks[],
>  		const char * const names[], bool per_vq_vectors,
>  		const bool *ctx,
> -		struct irq_affinity *desc)
> +		struct irq_affinity *desc, unsigned int flags)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	u16 msix_vec;
> @@ -310,7 +310,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
>  	}
>  
>  	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors,
> -				      per_vq_vectors ? desc : NULL);
> +				      per_vq_vectors ? desc : NULL, flags);
>  	if (err)
>  		goto error_find;
>  
> @@ -407,11 +407,23 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>  	int err;
>  
>  	/* Try MSI-X with one vector per queue. */
> -	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
> +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
> +			       desc, PCI_IRQ_MSIX);
>  	if (!err)
>  		return 0;
>  	/* Fallback: MSI-X with one vector for config, one shared for queues. */
> -	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
> +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
> +			       desc, PCI_IRQ_MSIX);
> +	if (!err)
> +		return 0;
> +	/* Try MSI with one vector per queue. */
> +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
> +			       desc, PCI_IRQ_MSI);
> +	if (!err)
> +		return 0;
> +	/* Fallback: MSI with one vector for config, one shared for queues. */
> +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
> +			       desc, PCI_IRQ_MSI);
>  	if (!err)
>  		return 0;
>  	/* Is there an interrupt? If not give up. */
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index 7fef52bee455..a5062ca85f3b 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -77,7 +77,7 @@ struct virtio_pci_device {
>  
>  	struct virtio_pci_admin_vq admin_vq;
>  
> -	/* MSI-X support */
> +	/* MSI/MSI-X support */
>  	int msix_enabled;
>  	int intx_enabled;
>  	cpumask_var_t *msix_affinity_masks;
> -- 
> 2.25.1



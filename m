Return-Path: <linux-kernel+bounces-399881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A2F9C05CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BD21C222EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAE420EA4A;
	Thu,  7 Nov 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z1U9tTb2"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF71F4739
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730982540; cv=none; b=B+2DS3dQUg6dfHBbh44A2ng/7VF+KAoM/kZELh/lQ5Wcrj390QkMOKUtadvZTaAWSpyh77Bqq0blwWzqLUHTFZoUQYXxwiiHgBcotCRQn46yRgerFPE1dV8QzYap6BI+j/ipmn/eCBGXDibE8V1q+FrGMvfkCNCn42qmbMt0ygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730982540; c=relaxed/simple;
	bh=9BcOmOmm3N32NIK3Xi22fcULUmMeJrOyDzDJ5YxiHyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwT3Snp5hh5uLMKnLGT9QqX1PYMeJuIVthamjrol4byaTvifjf+9RyIZRT1e2aZRt3cpN434/tAnvv1Xl8mWMF6lh031A7EeJa8ma4K5nY7OewLx9G3FyDs4SObWx274ozA2tQpArewSfzXsIXhcgkCfyttcUb+HeTuqSM/SgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z1U9tTb2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e8607c2aso868915e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 04:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730982536; x=1731587336; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=szLWPnOjFdN+6LPjkfncw3oSvCaCr+ooHV/EdsRYR3s=;
        b=z1U9tTb2NF1ZBjWndrqGQ7MpwiC19zY/taGWw89gmJt/RgIk0r87ZZdPLBOx/Jk0KL
         W4VZfSdFJ5qPcdvCtAskBu2fjyv4qb44/7BJ+fxVbsmD5N8PdQSGtcCX5VNWxFHDQurx
         pXglhswgwKx0rwtZGNTxgOgvRbd/Ja9SossoLUkje9NtgIrlaPQmcYZLy7LabpSQcfYl
         Gb/Ihv9xd+OYJUQjec8W7cjssHtQMyWLN2jjJZld6gMo0v4syPzrqhAHtFVc/T5HhUK8
         5GSKgKcnknBaai4hAWV3fCrKY7whApF3lcsr3fI5ZNK5XTYof5gNDuUbm4jAUc6nYdUl
         82hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730982536; x=1731587336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szLWPnOjFdN+6LPjkfncw3oSvCaCr+ooHV/EdsRYR3s=;
        b=q68KDUAGzgL4651P68vrxuRqZge3+jJOyc3c0qnEFfz4LUq40h3fk3ClhfsXiwyp9+
         rh6n0WYXQZRdSPgo02Spp6NFjoY5Mw+jWmVvujuiOahF4QIWPsi1RBC4Fyv5lYGBF1KY
         G02zAjIk0g2EkdR9JheVID4MTgmOSbr+fedikRsf/7cvWoKb5tNlbFTx/E3qY6zlnD8e
         L5uCZEwNvOQHGFj5f7ZEyri9Vka85s27WsK7DGNNMp1BQRC0kXhtpCdGfPXhZaik2zsn
         u+UlwUW68ZLUafj6dVVTzU8f0F9p8av0koEFqLXI3VolRnRvz1DUHExB8fQIE0ersP+7
         8cjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGwChvqMMb5mdBlmq0dDvfUGBW5Gr1HYr0NGlNNUHF2mDnMe6EHfaeTAZIoeIhGS44CPSgQrEM2kq4yxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/DCTDm9RuPNetBVbBcrWiSL76WF8FiFJzYwfyXN+B2fEuBui
	zILnZXnE8OgVbNznxbgvmYZLL14UDNKBEt9TGfKJnKBd3Xb4+iAap2UdNWVBvdBjm/cNpyXhiRk
	=
X-Google-Smtp-Source: AGHT+IEaAJwLpucwqXX6/1LU7Wtk9LtMp74U+I4nOuVP5xwgdT0fFXZ4o3TIuzYTlDKlaaQAboMBJA==
X-Received: by 2002:a05:6512:a8e:b0:53b:1625:bcf8 with SMTP id 2adb3069b0e04-53b348dac0cmr22676843e87.30.1730982536094;
        Thu, 07 Nov 2024 04:28:56 -0800 (PST)
Received: from thinkpad ([89.101.241.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9978afsm1584950f8f.52.2024.11.07.04.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:28:54 -0800 (PST)
Date: Thu, 7 Nov 2024 12:28:53 +0000
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.co, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	mie@igel.co.jp
Subject: Re: [PATCH] virtio-pci: Add MSI support
Message-ID: <20241107122853.smxqk7mlb25lscmu@thinkpad>
References: <20240712142914.16979-1-manivannan.sadhasivam@linaro.org>
 <20241106043714-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106043714-mutt-send-email-mst@kernel.org>

On Wed, Nov 06, 2024 at 04:37:57AM -0500, Michael S. Tsirkin wrote:
> On Fri, Jul 12, 2024 at 07:59:14PM +0530, Manivannan Sadhasivam wrote:
> > Virtio spec has so far only supported MSI-X and INTX for receiving the
> > interrupts from the virtio device on PCI transport. But this becomes a
> > limiting factor for devices supporting only MSI (plus INTX emulation) as
> > they have to use the legacy INTX emulation which is limited to one IRQ per
> > PCIe function.
> > 
> > But this now addressed with the help of a proposal to the Virtio spec
> > adding MSI support [1]. Based on that, let's implement MSI support in the
> > virtio-pci driver.
> > 
> > The Virtio spec proposal reuses the existing MSI-X infrastructure, like the
> > config_msix_vector/queue_msix_vector fields of the Virito common config
> > structure. Following that, MSI support in virtio-pci driver is also added
> > on top of the existing MSI-X implementation and it mostly reuses the MSI-X
> > code base. The existing vp_find_vqs_msix() API is modified to support MSI
> > along with MSI-X.
> > 
> > The preference for interrupt allocation is still given to MSI-X as per the
> > spec. The driver will try to allocate MSI only if both of the MSI-X
> > allocations (one vector for each queue and 2 vectors) fails. As like MSI-X,
> > driver will try to allocate one MSI vector for each queue first, and if
> > that fails, it will try to allocate 2 vectors (one for config queue and one
> > shared for queues). If both of them fails, driver will fallback to the
> > legacy INTX as usual.
> > 
> > For keeping the changes minimal, existing 'virtio_pci_device::msix_enabled'
> > flag is used to indicate the status of MSI and MSI-X. Rest of the MSI-X
> > functionalities such as IRQ affinity are also reused for MSI (but the
> > affinity setting really depends on the underlying IRQCHIP controller).
> > 
> > [1] https://lore.kernel.org/virtio-comment/20240712140144.12066-1-manivannan.sadhasivam@linaro.org/
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> So I think the spec versions are mostly acceptable to people.
> So you want TC to vote as is or tweak it?
> 

The feedback (and the conclusion) on the spec patch was to remove the INTx
fallback and use single MSI vector. So both spec and this patch needs to be
changed to accomodate that.

- Mani

> In any case, this patch has to be rebased to be applied.
> 
> 
> 
> > ---
> >  drivers/virtio/virtio_pci_common.c | 24 ++++++++++++++++++------
> >  drivers/virtio/virtio_pci_common.h |  2 +-
> >  2 files changed, 19 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index f6b0b00e4599..6f80b0c46c5f 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -100,11 +100,11 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
> >  }
> >  
> >  static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > -				   bool per_vq_vectors, struct irq_affinity *desc)
> > +				   bool per_vq_vectors, struct irq_affinity *desc,
> > +				   unsigned int flags)
> >  {
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	const char *name = dev_name(&vp_dev->vdev.dev);
> > -	unsigned int flags = PCI_IRQ_MSIX;
> >  	unsigned int i, v;
> >  	int err = -ENOMEM;
> >  
> > @@ -288,7 +288,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >  		struct virtqueue *vqs[], vq_callback_t *callbacks[],
> >  		const char * const names[], bool per_vq_vectors,
> >  		const bool *ctx,
> > -		struct irq_affinity *desc)
> > +		struct irq_affinity *desc, unsigned int flags)
> >  {
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	u16 msix_vec;
> > @@ -310,7 +310,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
> >  	}
> >  
> >  	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors,
> > -				      per_vq_vectors ? desc : NULL);
> > +				      per_vq_vectors ? desc : NULL, flags);
> >  	if (err)
> >  		goto error_find;
> >  
> > @@ -407,11 +407,23 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> >  	int err;
> >  
> >  	/* Try MSI-X with one vector per queue. */
> > -	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
> > +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
> > +			       desc, PCI_IRQ_MSIX);
> >  	if (!err)
> >  		return 0;
> >  	/* Fallback: MSI-X with one vector for config, one shared for queues. */
> > -	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
> > +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
> > +			       desc, PCI_IRQ_MSIX);
> > +	if (!err)
> > +		return 0;
> > +	/* Try MSI with one vector per queue. */
> > +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx,
> > +			       desc, PCI_IRQ_MSI);
> > +	if (!err)
> > +		return 0;
> > +	/* Fallback: MSI with one vector for config, one shared for queues. */
> > +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx,
> > +			       desc, PCI_IRQ_MSI);
> >  	if (!err)
> >  		return 0;
> >  	/* Is there an interrupt? If not give up. */
> > diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> > index 7fef52bee455..a5062ca85f3b 100644
> > --- a/drivers/virtio/virtio_pci_common.h
> > +++ b/drivers/virtio/virtio_pci_common.h
> > @@ -77,7 +77,7 @@ struct virtio_pci_device {
> >  
> >  	struct virtio_pci_admin_vq admin_vq;
> >  
> > -	/* MSI-X support */
> > +	/* MSI/MSI-X support */
> >  	int msix_enabled;
> >  	int intx_enabled;
> >  	cpumask_var_t *msix_affinity_masks;
> > -- 
> > 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்


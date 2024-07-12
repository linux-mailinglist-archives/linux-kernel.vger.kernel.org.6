Return-Path: <linux-kernel+bounces-250769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23E592FC9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879B0282F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5187A171E49;
	Fri, 12 Jul 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ex+o8sMM"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A01E4A9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794734; cv=none; b=ZbVx6HOobFRmTJDVDeAj8tAxmvC7lumj+Osp8afxV44TSaTkdWU4HBKkxX36LZC/M06oONsYSq4bZx+OJFgARXdI4hQ3l4LmyX57rmTF6QnOYeHgRwaHlOfzuGBtpXi+Nsskuwfcjf3/HQuqTfpXzZCOcF0n2X6qOtP6ItBJbwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794734; c=relaxed/simple;
	bh=VFCopUPBEjTjvEEJyJCDdw6ihpAQYILE8dCAvZP7nzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHNJ2o7s4JSmyZx/IXpdM4Ekl2NYD/5ucBv3NJvkgX9zKIMxFhMgZH5oalzqZWn11z6c+X5FIj14GPjMdcfxHz1DAtyWOwUq0qkjsYAi99AcA0dHv1ce9PIsw0Z+h185VxgSi75t8Bly/u/E6UFg5wiIUK4pyxTkrML9+O2y8tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ex+o8sMM; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c46c8b0defso1088234eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720794732; x=1721399532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L8xzGj3vpubQKIl5IQbW92b7Jx4PGoJxyBPX5y3yAQE=;
        b=Ex+o8sMMqiRImMTbMYoC5hReTMcV97RcMfVdMDsSLMs1h3edYydUmX795AoNI4ru+0
         EU8gsKZjtjVFVZtL69YI/nAEQgk4xm1zui/k1fdSCCY0GvMCwuPkbEh90KNM8Y+6KGEY
         N7q4GjMBfQup97ivMtFDiE1M8G4cCLq0nzl/gjep4qA1yngEtH8SwDtKh0zLV/pnw9Zm
         nikLtsOtYPV7iT5uExaqU6Fnb9qkZNxp7SA2Hd29CTwx4Xr87113U0LhqYOu5elSVXQ2
         h0qe0B1dWXugWCGohDPzbNOL9P7mN1guopksEnoavw/oEa2A9wK4390vPJsIHaPQOhFs
         JRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794732; x=1721399532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8xzGj3vpubQKIl5IQbW92b7Jx4PGoJxyBPX5y3yAQE=;
        b=ZRY6ltCFSebTpccuodI8yRdsEQ4xzv30U29rhRmgllRUMjzJUeKyAOB/zNCdBI7nGy
         ced5bsumWVxAEt9fKmHYwxWppctlEfquxRH4T3oYvXF9W3TvXHP2Lf9H3QrxjKysa7Pj
         0ypJvtbTC0iZfD/QoVKcGuBrxx9LfL5Q/uBHXSWgT/UK91aaH0b7LMw9q6Tj0+R3bKpt
         VaWjJpxKapvT6v7zcEapc/W+0imsoDhvsHaRqPhDeCPOOcgaTjrKcCyMY9gFjBdJHrH1
         nSAE/uyQCSxtdFN9mFct1lXKveY1pFZVpO3mmeapk5JfJ815j14xHfNzhXsXirchsnK/
         fOqA==
X-Forwarded-Encrypted: i=1; AJvYcCXqEG8W5ckFbrjV8eyOo2A5h0gSm9fkR0Z9Z0l7E0+Q7Qacy5/xSZarAaqdjNx1JUTyJie5dhM/yoqqPPrW3xokzzJdb34FtxlsVNN9
X-Gm-Message-State: AOJu0YxRfdSOnTESk3dnHtSIaxAQCgQcE4/36YmlxghbMl1icOi80niR
	C7MnHg72hTmAjNoPsZPQTh2521uH7DnYhRACcBFDEj45bTWYEUuZ0Ib7QFMMYA==
X-Google-Smtp-Source: AGHT+IEqKgGv8X4d1PLEand1okJOTyiilqjq0/2Hga1bEFuVpLT//VwEmjG8yjliBCOFR49jaJ4bKA==
X-Received: by 2002:a05:6359:740f:b0:1aa:a19e:f1a4 with SMTP id e5c5f4694b2df-1aade0883ecmr887161555d.1.1720794731681;
        Fri, 12 Jul 2024 07:32:11 -0700 (PDT)
Received: from thinkpad ([120.60.61.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d60117b61sm5920291a12.22.2024.07.12.07.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:32:11 -0700 (PDT)
Date: Fri, 12 Jul 2024 20:02:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mst@redhat.com, jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	mie@igel.co.jp
Subject: Re: [PATCH] virtio-pci: Add MSI support
Message-ID: <20240712143202.GB3571@thinkpad>
References: <20240712142914.16979-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240712142914.16979-1-manivannan.sadhasivam@linaro.org>

+ Jason Wang (email got truncated).

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
> 

-- 
மணிவண்ணன் சதாசிவம்


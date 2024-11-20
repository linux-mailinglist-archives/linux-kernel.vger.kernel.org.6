Return-Path: <linux-kernel+bounces-415363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E19D3500
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F213B2587B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5457D16F8E5;
	Wed, 20 Nov 2024 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIFS3H17"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830FB166F16
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089913; cv=none; b=fm2c9VcnORZTJkYkEPZH0aCFkjg2E5EXqcWkU3vXA/Wh38CqXbDuATM2yKmpDEGzS0qMBzZLsGVxn9+tRxTv5GObqsdQQSPkPH3gfdWuW9eKyC1CAD+agh/UuZ6RhaTVKTdSrJzCdLpi7ndyrUoS45KYROxl2TbRpnWwLf0EnRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089913; c=relaxed/simple;
	bh=8c4RY0owHoz5An/7xGsvontCEb/FG4VsXHaUAG4EBZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuEV1/sUIYOTlXnJS8YSpkUuFUO0c8NbdCZHJGBqqEnM6OyfZv+pFA5LpcC+s4PaUNnXrD1NKBdMoLUng7rj6hl6rvWtuo0muyotvnY3T+Hna2fElj2ExwovYvP+kQxFwAGrLrIevg7qEibqujUGyAHg00qmNEtX5/EG4nv91k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FIFS3H17; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so55217735e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 00:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732089907; x=1732694707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRgDfoaQT9KNI5x6/6yzE+UnJrhXzmTHlyAUFtH2BlU=;
        b=FIFS3H17mQY8pwTarpQ0y2+fPZ7eIXhnMJbJzZmuIdRx4I0Vp+h/41TwfS2N9KR+bo
         nqCDnj7an/RLZ1y9RTlE69FLtIgrcHsqLOEaWyT+AJiGU18103kq1cm/EZ4DdsMIH8iq
         17IksWMZPmOmhgLmfHBKKE35syhXd0edaBYwIOh/JuoKjdiuehutl8FXERNDlqFrvWWG
         Gnd5Ubd/D6QZJov43N2DRCHQ933R6NfIalBwhdaXnRkXxvmq1RkVjMIGx/p0KghyKtkj
         Iczo/PDfmI5/1Ggd7ZCUqy8gf1X0E5usLoG5KrEF0kW9lEd9f/M/qzEJR/CPVOEnZSNK
         rQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732089907; x=1732694707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRgDfoaQT9KNI5x6/6yzE+UnJrhXzmTHlyAUFtH2BlU=;
        b=EUiV/bptBhaTjANyL5EsyNKhl+2E5PstC3sMKrhNOtPK+IOgrl7RpwFISjYHaTPeSu
         2Q7RYR8qW5y7me9GWAabXOPeTjy/W/VrPsSfUTlOoRlOD9gj571vaoZYTEvvYp5G8KSv
         ZloK+nhXo876EZMIfEoK9UpCZ64aexu+Yfoitl8ZXEmu24UinAJb4o8X9LfGYqC400Sa
         26moX85EW+Z6zYOllCQJT0LKR+HwZSM7RJeDwzxsNtj7z2DRbVLzHsw9LkemxQq/h+aa
         1G8UzZfx1D9p2L0EnJI5zxLtspww0HGiu0qJNWyUb/gUes/EqRjdf52C2hcFUNv98mEo
         g1og==
X-Forwarded-Encrypted: i=1; AJvYcCXDp1ZunWUpjmXVBTSqBuY8anoV7w3OTlwQLROWC87kjfx+FtukWfCgR1aHNbh4xQp6VEMS2rx8btFcwMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMBBXGuZCuTtZwHnopzG137m2oZc6wp9ylf3TRkFkn5APk70C
	YRoJmLWK0zfWeNlblNlT0sRuc+cStTUu5hFIGvuEc9JXD5zkQ7pLzpT8TCex6wE=
X-Google-Smtp-Source: AGHT+IEFny7M03Y934XV3HYBrb4ejakxQGcLpkJMphiZM1V77YWoi33QS9ejQpOi9Dvb73myIts4lQ==
X-Received: by 2002:a05:600c:1d93:b0:42b:ac3d:3abc with SMTP id 5b1f17b1804b1-4334f01548dmr15750715e9.24.1732089906850;
        Wed, 20 Nov 2024 00:05:06 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b4643100sm10021045e9.39.2024.11.20.00.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 00:05:06 -0800 (PST)
Date: Wed, 20 Nov 2024 11:05:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	schalla@marvell.com, vattunuru@marvell.com, ndabilpuram@marvell.com,
	jerinj@marvell.com, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Satha Rao <skoteshwar@marvell.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] vdpa/octeon_ep: enable support for multiple
 interrupts per device
Message-ID: <b799bf24-876a-41da-b297-d2323c314674@stanley.mountain>
References: <20241120070508.789508-1-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120070508.789508-1-sthotton@marvell.com>

On Wed, Nov 20, 2024 at 12:34:50PM +0530, Shijith Thotton wrote:
> @@ -63,44 +80,53 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
>  static void octep_free_irqs(struct octep_hw *oct_hw)
>  {
>  	struct pci_dev *pdev = oct_hw->pdev;
> +	int irq;
> +
> +	for (irq = 0; irq < oct_hw->nb_irqs && oct_hw->irqs; irq++) {
> +		if (oct_hw->irqs[irq] < 0)
> +			continue;
>  
> -	if (oct_hw->irq != -1) {
> -		devm_free_irq(&pdev->dev, oct_hw->irq, oct_hw);
> -		oct_hw->irq = -1;
> +		devm_free_irq(&pdev->dev, oct_hw->irqs[irq], oct_hw);
>  	}
> +
>  	pci_free_irq_vectors(pdev);
> +	kfree(oct_hw->irqs);

You should add:

	oct_hw->nb_irqs = 0;
	oct_hw->irqs = NULL;

Otherwise if reset is called twice in a row, before re-initializing the IRQs it
results in a use after free.

>  }
>  
>  static int octep_request_irqs(struct octep_hw *oct_hw)
>  {
>  	struct pci_dev *pdev = oct_hw->pdev;
> -	int ret, irq;
> +	int ret, irq, idx;
>  
> -	/* Currently HW device provisions one IRQ per VF, hence
> -	 * allocate one IRQ for all virtqueues call interface.
> -	 */
> -	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
> +	ret = pci_alloc_irq_vectors(pdev, 1, oct_hw->nb_irqs, PCI_IRQ_MSIX);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "Failed to alloc msix vector");
>  		return ret;
>  	}
>  
> -	snprintf(oct_hw->vqs->msix_name, sizeof(oct_hw->vqs->msix_name),
> -		 OCTEP_VDPA_DRIVER_NAME "-vf-%d", pci_iov_vf_id(pdev));
> +	oct_hw->irqs = kcalloc(oct_hw->nb_irqs, sizeof(int), GFP_KERNEL);

This isn't free on the ->release() path or whatever.  octep_free_irqs() is
called on reset() but we rely on devm_ to free the IRQs on ->release().  Use
devm_kcalloc() here as well, probably.

> +	if (!oct_hw->irqs) {
> +		ret = -ENOMEM;
> +		goto free_irqs;
> +	}
>  
> -	irq = pci_irq_vector(pdev, 0);
> -	ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
> -			       oct_hw->vqs->msix_name, oct_hw);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to register interrupt handler\n");
> -		goto free_irq_vec;
> +	memset(oct_hw->irqs, -1, sizeof(oct_hw->irqs));

This works, but it would be more normal to just leave it zeroed and check for
zero instead of checking for negatives.  There is never a zero IRQ.  See my blog
for more details:
https://staticthinking.wordpress.com/2023/08/07/writing-a-check-for-zero-irq-error-codes/

regards,
dan carpenter

> +
> +	for (idx = 0; idx < oct_hw->nb_irqs; idx++) {
> +		irq = pci_irq_vector(pdev, idx);
> +		ret = devm_request_irq(&pdev->dev, irq, octep_vdpa_intr_handler, 0,
> +				       dev_name(&pdev->dev), oct_hw);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to register interrupt handler\n");
> +			goto free_irqs;
> +		}
> +		oct_hw->irqs[idx] = irq;
>  	}
> -	oct_hw->irq = irq;
>  
>  	return 0;
>  
> -free_irq_vec:
> -	pci_free_irq_vectors(pdev);
> +free_irqs:
> +	octep_free_irqs(oct_hw);
>  	return ret;
>  }
>  

regards,
dan carpenter


Return-Path: <linux-kernel+bounces-246491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD4F92C29F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C43281BE2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29E31B86F8;
	Tue,  9 Jul 2024 17:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="on28x9a3"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FA91B86CC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546637; cv=none; b=ou2/JY++ZEbmrzjABYD3UALwcKWQXmsdJMU25lvGPipysbOLWaaCHZ2ZcyjTcyGayfqPNngVd5SJgTMuEz7TFZQs772GfpmtUabHmUl8dbYgfso2ahVrySTqIaYy2K98zTisBWGG1aoZ2zsQu6qU1c2Cc0D7uTIdFcj6TQqGISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546637; c=relaxed/simple;
	bh=ogMRUdIc4ADrzG/PEEr6kl01MPyEFM24XNmW5f60p9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fprztUfAQSjMSXAqSSb0Vm7n2VbDtyAVDzPEG3pvDQxCX9zdVSWHEb38Y02M7ofa6duK5mUWHU1PBHgQOFEajqoKWiiunu275gnGUehNLjOx+41Z/bdpEVnEQpvYiYPIXJNQ6/dNkI5aq8OqMWCzhHwRJrpaR3q6dsLvR6TPnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=on28x9a3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b0e9ee7bcso3285292b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 10:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720546635; x=1721151435; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B0urqfDNvv1tv+Q+hpyHqmS7MWBKqnamW85qTWzSce8=;
        b=on28x9a3N4i3NdZSQgRHUAubInbTs6Ltqt46Lrv/xpuGU+SZD5VGrHoTIRN8KUbx9d
         krTxQA60pO5F7Vc5P1KtDt9tBjpyzkYCxCodZnfEoeC6rzfZcCMI2FGBRdUMDLd++YhD
         L0JDbA/+EVngL5NQ4UHMp/4OS2v79li4LFw2locJUDn678BscN0xHNtCz0/2W73RZlY4
         0XbNgkd+4FKKkS2k7J8qS4SHhYTLG07EkYQFHaYLr/yVO0uhEkEc2GY4ZqeqstzeZC8T
         5auv+bB013EjTYApTtDRCgFCVYm4b0bXQKgdv7FbrbWyUhXOQl/gX3T1Rtal1iye4FLF
         2JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546635; x=1721151435;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0urqfDNvv1tv+Q+hpyHqmS7MWBKqnamW85qTWzSce8=;
        b=PTV65wYXkVcumMcYUmCQlYMcmg96KhJf1i8gmSJnjwEmKTNQBAzDuZNf63IBvliPTQ
         gl8+o+AVK7JihXeyG5jfIPIH/xJHOUSiRQG8+dj25/ZyqXAnw8pJOycKe7DveWqwx1qC
         p4Dgzi1KtWtcxHU74btv17AMy8StCmGke1nrTmqnLWC0RaYbnR07F8LIz2B4JArpaJOO
         XJtr+606ePkc5L3IJk/67roGvkDbSGvrEQiZWe3LmDyB6JwNq1oFobAxFy09k+f+Cvq6
         u1/hsPjjgS1+fbBCm1IbEoJpaMmopQEwhC3NqVju8h1zBrA/KHxKvWqqAdqwvafwMLBX
         mQlg==
X-Forwarded-Encrypted: i=1; AJvYcCUDwKcMX2AVHFyTMMwEWV5cTeNlTaODawE4091Bn+d6NhuHQPP+YnSCYVYyeuLjH1izZSVak1Tnacl8a50kwOpppHeb48xR9+rSIl+T
X-Gm-Message-State: AOJu0YyOxI2woS9M+TNToBCo0Mnuj8M1iJg3UZNbnhqvHFqAOAub/rGs
	/bcDNMQRQuP3RvOt4uxtnazn7DLBvatH/iJ3iHnL30e0BUtE66pv6c0pXBE4nLTo+LKl3RGRdeY
	=
X-Google-Smtp-Source: AGHT+IHx+1Lqq1O27WMTXLu9Z/BR76ZVx0k0WA7fdp656XoslrBJOBGT82uo7q3bzXESr0Htjqsi3A==
X-Received: by 2002:a05:6a20:7283:b0:1c2:74b4:a05d with SMTP id adf61e73a8af0-1c29821d04bmr4059026637.23.1720546634720;
        Tue, 09 Jul 2024 10:37:14 -0700 (PDT)
Received: from thinkpad ([117.193.213.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad52d1sm18734885ad.305.2024.07.09.10.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:37:13 -0700 (PDT)
Date: Tue, 9 Jul 2024 23:07:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: MSIs not freed in GICv3 ITS driver
Message-ID: <20240709173708.GA44420@thinkpad>
References: <20240708153933.GC5745@thinkpad>
 <865xtf4woi.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <865xtf4woi.wl-maz@kernel.org>

On Mon, Jul 08, 2024 at 06:31:57PM +0100, Marc Zyngier wrote:
> Mani,
> 
> On Mon, 08 Jul 2024 16:39:33 +0100,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > Hi Marc, Thomas,
> > 
> > I'm seeing a weird behavior with GICv3 ITS driver while allocating MSIs from
> > PCIe devices. When the PCIe driver (I'm using virtio_pci_common.c) tries to
> > allocate non power of 2 MSIs (like 3), then the GICv3 MSI driver always rounds
> > the MSI count to power of 2 to find the order. In this case, the order becomes 2
> > in its_alloc_device_irq().
> 
> That's because we can only allocate EventIDs as a number of ID
> bits. So you can't have *1* MSI, nor 3. You can have 2, 4, 8, or
> 2^24. This is a power-of-two architecture.
> 

Ah okay.

> > So 4 entries are allocated by bitmap_find_free_region().
> 
> Assuming you're calling about its_alloc_device_irq(), it looks like a
> bug. Or rather, some laziness on my part. The thing is, this bitmap is
> only dealing with sub-allocation in the pool that has been given to
> the endpoint. So the power-of-two crap doesn't really matter unless
> you are dealing with Multi-MSI, which has actual alignment
> requirements.
> 

Okay.

> >
> > But since the PCIe driver has only requested 3 MSIs, its_irq_domain_alloc()
> > will only allocate 3 MSIs, leaving one bitmap entry unused.
> > 
> > And when the driver frees the MSIs using pci_free_irq_vectors(), only 3
> > allocated MSIs were freed and their bitmap entries were also released. But the
> > entry for the additional bitmap was never released. Due to this,
> > its_free_device() was also never called, resulting in the ITS device not getting
> > freed.
> > 
> > So when the PCIe driver tries to request the MSIs again (PCIe device being
> > removed and inserted back), because the ITS device was not freed previously,
> > MSIs were again requested for the same ITS device. And due to the stale bitmap
> > entry, the ITS driver refuses to allocate 4 MSIs as only 3 bitmap entries were
> > available. This forces the PCIe driver to reduce the MSI count, which is sub
> > optimal.
> > 
> > This behavior might be applicable to other irqchip drivers handling MSI as well.
> > I want to know if this behavior is already known with MSI and irqchip drivers?
> > 
> > For fixing this issue, the PCIe drivers could always request MSIs of power of 2,
> > and use a dummy MSI handler for the extra number of MSIs allocated. This could
> > also be done in the generic MSI driver itself to avoid changes in the PCIe
> > drivers. But I wouldn't say it is the best possible fix.
> 
> No, that's terrible. This is just papering over a design mistake, and
> I refuse to go down that road.
> 

Agree. But what about other MSI drivers? And because of the MSI design, they
also round the requested MSI count to power of 2, leading to unused vectors and
those also wouldn't get freed. I think this power of 2 limitation should be
imposed at the API level or in the MSI driver instead of silently keeping unused
vectors in irqchip drivers.

> > 
> > Is there any other way to address this issue? Or am I missing something
> > completely?
> 
> Well, since each endpoint handled by an ITS has its allocation tracked
> by a bitmap, it makes more sense to precisely track the allocation.
> 
> Here's a quick hack that managed to survive a VM boot. It may even
> work. The only problem with it is that it probably breaks a Multi-MSi
> device sitting behind a non-transparent bridge that would get its MSIs
> allocated after another device. In this case, we wouldn't honor the
> required alignment and things would break.
> 
> So take this as a proof of concept. If that works, I'll think of how
> to deal with this crap in a more suitable way...
> 

This works fine. Now the ITS driver allocates requested number of MSIs, thanks!

- Mani

> 	M.
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 3c755d5dad6e6..43479c9e7f8d2 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3475,15 +3475,16 @@ static void its_free_device(struct its_device *its_dev)
>  
>  static int its_alloc_device_irq(struct its_device *dev, int nvecs, irq_hw_number_t *hwirq)
>  {
> -	int idx;
> +	unsigned long idx;
>  
>  	/* Find a free LPI region in lpi_map and allocate them. */
> -	idx = bitmap_find_free_region(dev->event_map.lpi_map,
> -				      dev->event_map.nr_lpis,
> -				      get_count_order(nvecs));
> -	if (idx < 0)
> +	idx = bitmap_find_next_zero_area(dev->event_map.lpi_map,
> +					 dev->event_map.nr_lpis, 0, nvecs, 0);
> +	if (idx >= dev->event_map.nr_lpis)
>  		return -ENOSPC;
>  
> +	bitmap_set(dev->event_map.lpi_map, idx, nvecs);
> +
>  	*hwirq = dev->event_map.lpi_base + idx;
>  
>  	return 0;
> @@ -3653,9 +3654,9 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>  	struct its_node *its = its_dev->its;
>  	int i;
>  
> -	bitmap_release_region(its_dev->event_map.lpi_map,
> -			      its_get_event_id(irq_domain_get_irq_data(domain, virq)),
> -			      get_count_order(nr_irqs));
> +	bitmap_clear(its_dev->event_map.lpi_map,
> +		     its_get_event_id(irq_domain_get_irq_data(domain, virq)),
> +		     nr_irqs);
>  
>  	for (i = 0; i < nr_irqs; i++) {
>  		struct irq_data *data = irq_domain_get_irq_data(domain,
> 
> -- 
> Without deviation from the norm, progress is not possible.

-- 
மணிவண்ணன் சதாசிவம்


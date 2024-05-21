Return-Path: <linux-kernel+bounces-184495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034F08CA77B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6AA2281D86
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BAD2E85A;
	Tue, 21 May 2024 04:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVz2pMIx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DD46125
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716266750; cv=none; b=j4yckhH4W20iLJtKDu9l9m+ghW5ESRIjDyBhdmPSwaY4WOpJ4A22P9eSW+TdqjxuCK5q92wySCZ12CkrMM1jdZtp3Hhaq6C1M7YcU2aR21vBqVkQE1QCmCl0W0svPCUQHw8H5SyvQZzbCxvWC9Z/Ys9qr7tskfhKS9G8SCrFwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716266750; c=relaxed/simple;
	bh=p3Y9bg7d+YbBIYXEb4Y1aAsTwlznHdS3rV/1bUmAjz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdDOkvAPzUsLJQIpyFBeQE/KjNK5BMLZySDpuqJI5iAQHe0mslPA7CkyCRAECSYEeLjTkduvln5ehxtdac4fDPb2EwRYUSXcmIB0j+1H7tpQId+KWVq53np2l5sQxH8qs5OiCdPnAy2SabrS0oDeN8nUWoACqZjuLCaZ6nxuC98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cVz2pMIx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716266747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr/Lj/QEJVokUuTusNqYmXna8XGFmwM2A2fm3gIEflI=;
	b=cVz2pMIxJb0cB0PnrKC0N0sFci+0y3aAy5Iscx0kVcTlW5WQ3Q09IN9v+5i+/S84zNl0P1
	miGUYqzPzOGjH+LrjqFuSD8xQD2KxsIXHRLjMlb3BEuV7fXdkjuTNH8eJ4ePvA0ZmOWOxX
	6hVtDXFlBgWqGzObeLYlo9tfSxlJHE0=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-HPQAypqpO9ykYV4DnO_Pfw-1; Tue, 21 May 2024 00:45:46 -0400
X-MC-Unique: HPQAypqpO9ykYV4DnO_Pfw-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7fb1865f1c1so6126004241.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716266745; x=1716871545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr/Lj/QEJVokUuTusNqYmXna8XGFmwM2A2fm3gIEflI=;
        b=gTQBptdwOMC2WT/Xx//1RM9KyR9WExcLkpFsQ30+foIRJ67hjYNUgwlj3j7g0o8yic
         4F7q5LAN2rULL7/Ym0YMFaohq2wj0TCyhzZ0dNGK2Ai+LZkLtsCRqb7lGUPHZ3+9e95R
         h745YZI5dS8KW7qyQDtFLPp+Rl+uiY5e25l53iUV4mPuJl6IJ35lk8n43XrlBl7q6c/X
         GdKD7nl12MOBojNYmIFexeUcyYe8OLrll6aUraNPRQw7zphyporT42uGg9n8rhNIyE6y
         yb6AwmdtVmyMW54vXus9FD3kbk1C2jcFEL6bB3FJrT98DX4Q7fJx17dQGrA9qm7YFNyO
         obkA==
X-Forwarded-Encrypted: i=1; AJvYcCVR6ZGvdahZyHhct2Zpw72cGjm17y77ICOdoRQyIOIxAZ1RsS48BdlnIY/1fPDBlIAoMcGj7Mr8TphUJFBySZ2KI2QO4f0fMwOoS78I
X-Gm-Message-State: AOJu0YzghWgtZ9Al9YraO1ql+cAaeqIGHoQob4pv6hBCjOYVGnM1v74C
	RBUXFPTV2p8jaH81H9FEjJ8KaFbZOV03ylKma4jd/PrTepVctUnfcUD6JpH4y12FDBpFmRjWP6m
	RC6APRyMkFdMd4n6a9xGZVloNJoWzcw2OOHv8YpA/LWt3Q5GcCvgiO5Kqkhj3+Q==
X-Received: by 2002:a05:6102:f0c:b0:47e:f6f4:ff55 with SMTP id ada2fe7eead31-48077e0b862mr33274800137.20.1716266745673;
        Mon, 20 May 2024 21:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZqTatzHAFDg1/LKoHiRtJSPbxNMP2E08/6y7nLNNsNstKTAorXNYaCEOr/mxCeVmpvaha5Q==
X-Received: by 2002:a05:6102:f0c:b0:47e:f6f4:ff55 with SMTP id ada2fe7eead31-48077e0b862mr33274791137.20.1716266745335;
        Mon, 20 May 2024 21:45:45 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e25735ceesm99142321cf.11.2024.05.20.21.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 21:45:44 -0700 (PDT)
Date: Mon, 20 May 2024 21:45:43 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, will@kernel.org, 
	linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] iommu/dma: Fix domain init
Message-ID: <jrzrf3vz2rhcrwazsxuljuyhru4mstyzuhjx4uawcfmjlmvipd@lu6usxz22ved>
References: <721fa6baebb0924aa40db0b8fb86bcb4538434af.1716232484.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <721fa6baebb0924aa40db0b8fb86bcb4538434af.1716232484.git.robin.murphy@arm.com>

On Mon, May 20, 2024 at 08:14:44PM GMT, Robin Murphy wrote:
> Despite carefully rewording the kerneldoc to describe the new direct
> interaction with dma_range_map, it seems I managed to confuse myself in
> removing the redundant force_aperture check and ended up making the code
> not do that at all. This led to dma_range_maps inadvertently being able
> to set iovad->start_pfn = 0, and all the nonsensical chaos which ensues
> from there. Restore the correct behaviour of constraining base_pfn to
> the domain aperture regardless of dma_range_map, and not trying to apply
> dma_range_map constraints to the basic IOVA domain since they will be
> properly handled with reserved regions later.
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: e28a114243d1 ("iommu/dma: Make limit checks self-contained")

I'm seeing this upstream as ad4750b07d34 ("iommu/dma: Make limit checks self-contained") now.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>  drivers/iommu/dma-iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 89a53c2f2cf9..1ec89ca75c59 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -685,15 +685,15 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
>  
>  	/* Check the domain allows at least some access to the device... */
>  	if (map) {
> -		dma_addr_t base = dma_range_map_min(map);
> -		if (base > domain->geometry.aperture_end ||
> +		if (dma_range_map_min(map) > domain->geometry.aperture_end ||
>  		    dma_range_map_max(map) < domain->geometry.aperture_start) {
>  			pr_warn("specified DMA range outside IOMMU capability\n");
>  			return -EFAULT;
>  		}
> -		/* ...then finally give it a kicking to make sure it fits */
> -		base_pfn = max(base, domain->geometry.aperture_start) >> order;
>  	}
> +	/* ...then finally give it a kicking to make sure it fits */
> +	base_pfn = max_t(unsigned long, base_pfn,
> +			 domain->geometry.aperture_start >> order);
>  
>  	/* start_pfn is always nonzero for an already-initialised domain */
>  	mutex_lock(&cookie->mutex);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 



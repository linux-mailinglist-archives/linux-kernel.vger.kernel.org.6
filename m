Return-Path: <linux-kernel+bounces-424428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F2B9DB43D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 09:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9179280AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 08:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB89415748F;
	Thu, 28 Nov 2024 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="GtSaFwNV"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900DB156F55
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732783839; cv=none; b=OTQ+AQkq+KP8sKnpo42G4J+JVGWbdGKZbembMFV6UgGjFMAbNaGEQXKFTLR68Cbyfs3FFhiIJtX3yW7h2Gt+zUmrtA4OPtIVsnxFvNBoX06ot4/vWz5K38c1jgFttYYyIAPuHfBqOwmIE+kkES4keEBcVy8LXZok5+SXuK7HCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732783839; c=relaxed/simple;
	bh=vIFqCvcR+eOrT5Ry8ljKGnELxDLiTTF3hdIn2rwdnAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRS/m3jvdkt25vsMSaCPrx/rLDyNnRwIJsjLeGqJXht3Punxqy4XOm4IVEhytJeJ7nuTovkieaRbH1Unz1RJDOHnBUvG+MyQCwtlQXfDsx1I8WGgQL8u/1NLO4dgGs8ZbdN9Cm2LTXKiIovaOe5y4T6+l+OaAQ5lceFBQSjSDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=GtSaFwNV; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 2DB864076170;
	Thu, 28 Nov 2024 08:50:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2DB864076170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1732783834;
	bh=nwx20sUNV3V48B4S4LmEJCdAcHoPAPUS+hQHRsPUw28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtSaFwNVMauDMCCpLqY2eZjkdLk2gojBhKUd3OrInZ2f1xM1a0EsWbyZHAoI6v1G/
	 B3mPtytBMIkHHfogITJwzI4JioRo5PeMlVO7ySSWR0wduCb25h1uxJZm7h/8ad+30T
	 g5lFX+wR2xYS2NPLifE5s+NiHkdtc6rX/3TCxgOc=
Date: Thu, 28 Nov 2024 11:50:30 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] dma-debug: fix physical address calculation for struct
 dma_debug_entry
Message-ID: <20241128-caa8ebcbb224ba75d406a450-pchelkin@ispras.ru>
References: <20241127185926.168102-1-pchelkin@ispras.ru>
 <20241128035011.GA13047@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128035011.GA13047@lst.de>

On Thu, 28. Nov 04:50, Christoph Hellwig wrote:
> Is it ok for you if I fold in the following cleanup to have a helper
> instead of the duplicate very dense expression?
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 27ade2bab531..e43c6de2bce4 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -1377,6 +1377,18 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
>  	}
>  }
>  
> +static phys_addr_t virt_to_paddr(void *virt)
> +{
> +	struct page *page;
> +
> +	if (is_vmalloc_addr(virt))
> +		page = vmalloc_to_page(virt);
> +	else
> +		page = virt_to_page(virt);
> +
> +	return page_to_phys(page) + offset_in_page(virt);
> +}
> +
>  void debug_dma_alloc_coherent(struct device *dev, size_t size,
>  			      dma_addr_t dma_addr, void *virt,
>  			      unsigned long attrs)
> @@ -1399,9 +1411,7 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
>  
>  	entry->type      = dma_debug_coherent;
>  	entry->dev       = dev;
> -	entry->paddr	 = page_to_phys((is_vmalloc_addr(virt) ?
> -				vmalloc_to_page(virt) : virt_to_page(virt))) +
> -				offset_in_page(virt);
> +	entry->paddr	 = virt_to_paddr(virt);
>  	entry->size      = size;
>  	entry->dev_addr  = dma_addr;
>  	entry->direction = DMA_BIDIRECTIONAL;
> @@ -1424,9 +1434,7 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
>  	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
>  		return;
>  
> -	ref.paddr = page_to_phys((is_vmalloc_addr(virt) ?
> -			vmalloc_to_page(virt) : virt_to_page(virt))) +
> -			offset_in_page(virt);
> +	ref.paddr = virt_to_paddr(virt);
>  
>  	if (unlikely(dma_debug_disabled()))
>  		return;

No problem. It actually looks more readable.

--
Thanks,
Fedor


Return-Path: <linux-kernel+bounces-200619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED658FB275
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE261F25BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90304146A70;
	Tue,  4 Jun 2024 12:39:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7661422B4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504787; cv=none; b=eS4klpZpKYUZ4cbw0iytdv6Drb9lernMhOg2e/GzuxQFHF7qF+ZZ/899yK3fzVHX1ls0dRkIWH4HtjtiECz1ml0m+e7JkOmUSJb/mboVMl2Y1EkeyKK4tN2HkCrqAQVW+Tc1jsr3duiKoOk536P/Z+ukN1JDxZQjCHcR+QaTauc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504787; c=relaxed/simple;
	bh=uTsztnqbT4iOcXiermoEhzWU5FdfFGzOa8AsZ4gZ2Q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajTnmxJ7V2MbaV0F5B4lXh+FRo71JbCRxn+X0v4iKeGLJfRAwwnu+q/qnppb0JcWA+TsMIB7XRVka5I8OXmWGoQNxj/Zwc33nZER2eHY3yhfnSsm0evUgE2tr1DaSk8oQjB4ZR5mLAcG55diWVA3gGOJcwVD3paYmqiLJsy9pc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A57451063;
	Tue,  4 Jun 2024 05:40:09 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E75D3F64C;
	Tue,  4 Jun 2024 05:39:41 -0700 (PDT)
Message-ID: <f688bf74-7d12-459c-b8b7-b85aaafc3785@arm.com>
Date: Tue, 4 Jun 2024 13:39:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: direct: Optimize the code for the dma_direct_free
 function
To: kunyu <kunyu@nfschina.com>, hch@lst.de, m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240604084100.51464-1-kunyu@nfschina.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240604084100.51464-1-kunyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2024 9:41 am, kunyu wrote:
> The 'is_swiotlb-for-alloc' and 'dev_isdma_coherent' judgment functions
> need to be called multiple times, so they are adjusted to variable
> judgment, which can improve code conciseness.
> 
> Signed-off-by: kunyu <kunyu@nfschina.com>
> ---
>   kernel/dma/direct.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

It's hardly concise to add *more* code than was there before... :/

Personally I don't think shaving a handful of characters off each 
invocation has any positive impact on readability in this case, while 
the extra visual indirection, and breaking consistency with the rest of 
this file, definitely has a negative one.

Also note that these "functions" are already just inline wrappers around 
a single variable dereference - for my arm64 build at least, this patch 
has no effect at all on the generated object code, since the compiler 
can still optimise out the locals (so at least it doesn't make things 
*worse* by forcing it to allocate a larger stack frame).

Thanks,
Robin.

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4d543b1e9d57..041e316ad4c0 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -315,23 +315,24 @@ void dma_direct_free(struct device *dev, size_t size,
>   		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
>   {
>   	unsigned int page_order = get_order(size);
> +	bool swiotlb_for_alloc = is_swiotlb_for_alloc(dev);
> +	bool is_dma_coherent = dev_is_dma_coherent(dev);
>   
>   	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
> +	    !force_dma_unencrypted(dev) && !swiotlb_for_alloc) {
>   		/* cpu_addr is a struct page cookie, not a kernel address */
>   		dma_free_contiguous(dev, cpu_addr, size);
>   		return;
>   	}
>   
>   	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
> -	    !dev_is_dma_coherent(dev) &&
> -	    !is_swiotlb_for_alloc(dev)) {
> +	    !is_dma_coherent && !swiotlb_for_alloc) {
>   		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
>   		return;
>   	}
>   
>   	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
> -	    !dev_is_dma_coherent(dev)) {
> +	    !is_dma_coherent) {
>   		if (!dma_release_from_global_coherent(page_order, cpu_addr))
>   			WARN_ON_ONCE(1);
>   		return;


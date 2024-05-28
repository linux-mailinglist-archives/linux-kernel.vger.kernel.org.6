Return-Path: <linux-kernel+bounces-192869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0C18D2351
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70690284D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847194E1DD;
	Tue, 28 May 2024 18:31:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB46517E8E6
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716921092; cv=none; b=Nr7KbeTXWVJFU3ykYv2iO0pCjuJCzIpPQ2vOqJwhZYnXb7lwfyU6t5N4mgBiH+3jnnSYsXenUaz8V/GIMQJpvbdNGHiDlwP3Y5Uxu4DiQNk914QQ7pf0r/2RcLkDAACBQHMxWRPzPLpbScs7kAw4VvFMdTM0DI+yGb3LVzM11vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716921092; c=relaxed/simple;
	bh=vCmeOebE2/PfKzBSGDN/NHIlwucHYheNUwR33EE922k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irelf9n6F2U4lcVlHlCeqdDSkGcyHzKbU0gFSKzeLDXzn8OVPHH5ftBuymS9uK1miHr287poNOLEEyw7DbATh9jRo4I9Sb7n6V2JZyN9tJsZpB01SrF0mnSdEdNr3b0VzjgsY898KC5KcZWQywGH7SlR8yoLynWKMYiQ1RBFjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45609339;
	Tue, 28 May 2024 11:31:53 -0700 (PDT)
Received: from [10.57.39.137] (unknown [10.57.39.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1C733F641;
	Tue, 28 May 2024 11:31:27 -0700 (PDT)
Message-ID: <e2176278-e65e-4c05-8b05-55323198c462@arm.com>
Date: Tue, 28 May 2024 19:31:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iommu/dma: Make SG mapping and syncing robust
 against empty tables
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>
References: <20240527232625.462045-1-andriy.shevchenko@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240527232625.462045-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-05-28 12:26 am, Andy Shevchenko wrote:
> DMA mapping and syncing API might be called for the empty SG table where
> number of the original entries is 0 and a pointer to SG list may be not
> initialised at all. This all worked until the change to the code that
> started dereferensing SG list without checking the number of the
> original entries against 0. This might lead to the NULL pointer
> dereference if the caller won't perform a preliminary check for that.
> Statistically there are only a few cases in the kernel that do such a
> check.

Yes, the ones which play the rather fragile trick of keeping a 
potentially-invalid scatterlist around and relying on its orig_nents 
value to be able to tell whether they're supposed to be using it or not. 
It's not the DMA API's job to hide bugs in callers trying to be clever 
but failing.

> However, any attempt to make it alinged with the rest 99%+ cases
> will be a regression due to above mentioned relatively recent change.
> Instead of asking a caller to perform the checks, just return status quo
> to SG mapping and syncing callbacks, so they won't crash on
> uninitialised SG list.
> 
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Closes: https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> Fixes: 861370f49ce4 ("iommu/dma: force bouncing if the size is not cacheline-aligned")
> Fixes: 8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/iommu/dma-iommu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index f731e4b2a417..83c9013aa341 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1108,6 +1108,9 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> +	if (nelems < 1)
> +		return;
> +

This nicely illustrates how wrong said callers are, since even if it 
*were* legitimate to attempt to map a 0-length scatterlist, it still 
wouldn't be valid to sync it after the initial mapping didn't succeed.

Thanks,
Robin.

>   	if (sg_dma_is_swiotlb(sgl))
>   		for_each_sg(sgl, sg, nelems, i)
>   			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
> @@ -1124,6 +1127,9 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>   	struct scatterlist *sg;
>   	int i;
>   
> +	if (nelems < 1)
> +		return;
> +
>   	if (sg_dma_is_swiotlb(sgl))
>   		for_each_sg(sgl, sg, nelems, i)
>   			iommu_dma_sync_single_for_device(dev,
> @@ -1324,6 +1330,9 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
>   	struct scatterlist *s;
>   	int i;
>   
> +	if (nents < 1)
> +		return nents;
> +
>   	sg_dma_mark_swiotlb(sg);
>   
>   	for_each_sg(sg, s, nents, i) {


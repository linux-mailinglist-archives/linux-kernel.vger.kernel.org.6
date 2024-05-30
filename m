Return-Path: <linux-kernel+bounces-194863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1008D4339
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 04:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B9286010
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186318036;
	Thu, 30 May 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ayh5bLhP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60917984
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034398; cv=none; b=VheVP1q1kec5R+Jto9TQP0ascB1IXxwCsILGWy1JIDB/AkfQKsANZjGrM4GzRtCDXOJy0OUn5IsTx4A/nviPPEc4UyKqBUsQJ3agAdoZbFiEamZ2eB8EP+/Fm9TLHhBiysyw/JuBHLRPullWLKrY8ymN11n788f9jVALTWJJY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034398; c=relaxed/simple;
	bh=gABtIQ1IVnWtIpyNnlREUkUWdePI1O7IO8tBxNUdv9s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V99U1azW+KLDxE5nCPTULAAZTLnmoPGERrVwILQdgjIfkDONzdPtr8JidBppIrBOyFrYOwFRzgDQUre+ESzr4NMsV7BJp+8c2eqMp5mACzTvs46a3ZQi70UHlq1yfqAYBqmhzCTSj5F8RN43OrlqeW82F+3EBnze1vgIEdDnJZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ayh5bLhP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717034397; x=1748570397;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gABtIQ1IVnWtIpyNnlREUkUWdePI1O7IO8tBxNUdv9s=;
  b=Ayh5bLhPcbI2r9lXYSCrhpiStojEWZXNUqjEkhKehq2V9n7agDHsN3NW
   HtTp0nCWRhPJ4U+J6EMbYA3nabWbmRlIGtK6swL89rXb+k9Hlf2pBLamG
   fbqEwOkBrTCxon83DRO0bS8hU2TddrgvDttEGC/AWulnw8BTU01h4SGC1
   Xu/zXiOL48lpJ7id3MIWsyqFwxUJJejLr343xrZOgaoEMhVIVEkB2uHV7
   jAAeL2WEfG03Z6stDXFzL8WQVeDK0Qw5Lr7B2QdiiJpSKaFKckKSbAwjl
   yWxU6VmFwt3SE9mrwswM5gjPMhcn5yhvRySLYBoONJqvmo806GT/P6Cnu
   A==;
X-CSE-ConnectionGUID: 9w1xEtJARyaBnQmfZrVF1g==
X-CSE-MsgGUID: pYp3jDYQTQ+3ewofFJDRnA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13603749"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13603749"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 18:59:56 -0700
X-CSE-ConnectionGUID: e2ThULVYQjWFaAgrf64Qxw==
X-CSE-MsgGUID: ZnxPBhm4TZ2ocKKCJ+0d9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35737116"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 29 May 2024 18:59:51 -0700
Message-ID: <960bfc23-22b3-48d1-baa6-2707767875c5@linux.intel.com>
Date: Thu, 30 May 2024 09:57:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/20] drm/msm: Use iommu_paging_domain_alloc()
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240529053250.91284-1-baolu.lu@linux.intel.com>
 <20240529053250.91284-7-baolu.lu@linux.intel.com>
 <jd7df7jshswukstxwbfoxuswyltyemdmkx272i5mpldlfsk4t7@ad36olyvmw27>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <jd7df7jshswukstxwbfoxuswyltyemdmkx272i5mpldlfsk4t7@ad36olyvmw27>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 4:21 PM, Dmitry Baryshkov wrote:
> On Wed, May 29, 2024 at 01:32:36PM +0800, Lu Baolu wrote:
>> The domain allocated in msm_iommu_new() is for the @dev. Replace
>> iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.
>>
>> Update msm_iommu_new() to always return ERR_PTR in failure cases instead
>> of NULL.
> Please don't mix unrelated changes, because ...
> 
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/gpu/drm/msm/msm_iommu.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>> index d5512037c38b..f7e28d4b5f62 100644
>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>> @@ -407,9 +407,9 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
>>   	struct msm_iommu *iommu;
>>   	int ret;
>>   
>> -	domain = iommu_domain_alloc(dev->bus);
>> -	if (!domain)
>> -		return NULL;
>> +	domain = iommu_paging_domain_alloc(dev);
>> +	if (IS_ERR(domain))
>> +		return ERR_CAST(domain);
>>   
>>   	iommu_set_pgtable_quirks(domain, quirks);
>>   
>> @@ -441,7 +441,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
>>   	struct msm_mmu *mmu;
>>   
>>   	mmu = msm_iommu_new(dev, quirks);
>> -	if (IS_ERR_OR_NULL(mmu))
>> +	if (IS_ERR(mmu))
>>   		return mmu;
> NAK, not having an IOMMU is a poor but legit usecase for some of devices
> which don't have IOMMU support yet (for example because of the buggy
> implementation for which we were not able to get all the hooks in).
> 
> Please don't break compatibility for existing platforms.

Sure. I will remove this line of change. Though I have no idea in which
case msm_iommu_new() could return NULL after this patch.

Best regards,
baolu


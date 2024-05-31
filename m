Return-Path: <linux-kernel+bounces-196175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2075C8D5877
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 04:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11B11F2676D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 02:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271BE6F2EB;
	Fri, 31 May 2024 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmZL7lZl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E357CA6
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120809; cv=none; b=rm/EQpgpv1t9EiFlD+lnFKUrTiKyv3IHvXXE0dXbaDGBHJdJNk7ikxtzhu/yFlZePx9IL0EGogupKAs9MkdU4vHv45ZT7D31seaQQeemu2BCJ2aB0rpwNUIUjGeD7MVMNzrTkIUG/DPxWpQpz+vvlBQ1rPwo4ZlD0IL2OBcrYbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120809; c=relaxed/simple;
	bh=2fUiLAe0vLP2hoMqQ1N3E6uckKGVMNj5dHoJ19Y+sN0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rCPpCq0kYp+GpCzCUu/bG/FYRLjHmlWs9laS6LtHLgi4RhDBw1LRaA6MAMzjrYMrPlAe55beC2p7dsdOkfINIWEgN+uCoeA9OSa9z/Qn68N5/8TJfBVfvrac2eSeBjZo5+IeX+zqr2KLA6IF5WaXlBdE5ZHlCH6X3Et4Kt5dQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmZL7lZl; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717120808; x=1748656808;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2fUiLAe0vLP2hoMqQ1N3E6uckKGVMNj5dHoJ19Y+sN0=;
  b=kmZL7lZlV2Gm4OBXmcDU1jfoCGjPPJjDYBbJnj+twYdE3LjtyzXcurWQ
   aS+eZdITfwQXSqRd4BUqxuNNnEBIMyNQaeJ8UqeVWhxYPsIgkwdECDUZi
   +NMHcYyrZTueDTRlKayHBg44k2V3OJxSoTPkDsyG0CyOn7WPQp2egMDFq
   TII16fFCDJovpqysA9RT4E7iKMlNpuL12rV9QjWr81FSln8waBARt1lIv
   u0UyzEQ7EMZB2YFIhGKKu45/0+ZsavHBSqc0/rg817pRtq+rHBDLkfFDR
   uNX/XGudOGdyF7wakhwTq3SttGgV3blkPEiQaKB6N5azXOT08a70AdLLT
   A==;
X-CSE-ConnectionGUID: CvxAf+ESQWCf4AZBXJ7/XA==
X-CSE-MsgGUID: qecW2XQzSHa6cbHmyA0BpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17479951"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="17479951"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 19:00:08 -0700
X-CSE-ConnectionGUID: U2f5FXHqTNiG/j8alR7vOg==
X-CSE-MsgGUID: +b1UL6wJRJyLg9EzJxqHvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="40936569"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 30 May 2024 19:00:02 -0700
Message-ID: <dda59cd5-b227-4f42-a7f2-b9fe03e1b020@linux.intel.com>
Date: Fri, 31 May 2024 09:57:54 +0800
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
 <960bfc23-22b3-48d1-baa6-2707767875c5@linux.intel.com>
 <CAA8EJppZU5yy4g85oMWzV_O9Qo91-Cr6d+W9Rz+K+mS6tfU8kw@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAA8EJppZU5yy4g85oMWzV_O9Qo91-Cr6d+W9Rz+K+mS6tfU8kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/30/24 3:58 PM, Dmitry Baryshkov wrote:
> On Thu, 30 May 2024 at 04:59, Baolu Lu<baolu.lu@linux.intel.com>  wrote:
>> On 5/29/24 4:21 PM, Dmitry Baryshkov wrote:
>>> On Wed, May 29, 2024 at 01:32:36PM +0800, Lu Baolu wrote:
>>>> The domain allocated in msm_iommu_new() is for the @dev. Replace
>>>> iommu_domain_alloc() with iommu_paging_domain_alloc() to make it explicit.
>>>>
>>>> Update msm_iommu_new() to always return ERR_PTR in failure cases instead
>>>> of NULL.
>>> Please don't mix unrelated changes, because ...
>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/gpu/drm/msm/msm_iommu.c | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
>>>> index d5512037c38b..f7e28d4b5f62 100644
>>>> --- a/drivers/gpu/drm/msm/msm_iommu.c
>>>> +++ b/drivers/gpu/drm/msm/msm_iommu.c
>>>> @@ -407,9 +407,9 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
>>>>       struct msm_iommu *iommu;
>>>>       int ret;
>>>>
>>>> -    domain = iommu_domain_alloc(dev->bus);
>>>> -    if (!domain)
>>>> -            return NULL;
>>>> +    domain = iommu_paging_domain_alloc(dev);
>>>> +    if (IS_ERR(domain))
>>>> +            return ERR_CAST(domain);
>>>>
>>>>       iommu_set_pgtable_quirks(domain, quirks);
>>>>
>>>> @@ -441,7 +441,7 @@ struct msm_mmu *msm_iommu_gpu_new(struct device *dev, struct msm_gpu *gpu, unsig
>>>>       struct msm_mmu *mmu;
>>>>
>>>>       mmu = msm_iommu_new(dev, quirks);
>>>> -    if (IS_ERR_OR_NULL(mmu))
>>>> +    if (IS_ERR(mmu))
>>>>               return mmu;
>>> NAK, not having an IOMMU is a poor but legit usecase for some of devices
>>> which don't have IOMMU support yet (for example because of the buggy
>>> implementation for which we were not able to get all the hooks in).
>>>
>>> Please don't break compatibility for existing platforms.
>> Sure. I will remove this line of change. Though I have no idea in which
>> case msm_iommu_new() could return NULL after this patch.
> So, even without this chunk you are going to break the no-IOMMU case.
> Please don't. This will result in a regression report and a revert.
> 
> Instead please provide a way for the existing drivers to continue
> working. For example, something like:
> 
> if (IS_ERR(mmu) && ERR_PTR(mmu) == -ENODEV))
>      return NULL;

Oh I see. msm_iommu_new() returning NULL indicates a no-IOMMU case,
right? So perhaps we can make it explicit like below?

         if (!device_iommu_mapped(dev))
                 return NULL;

         domain = iommu_paging_domain_alloc(dev);
         if (IS_ERR(domain))
                 return ERR_CAST(domain);

Best regards,
baolu


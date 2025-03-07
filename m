Return-Path: <linux-kernel+bounces-551024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F2EA5670D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6222F177659
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC2D218587;
	Fri,  7 Mar 2025 11:49:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453912153EC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348184; cv=none; b=TC/j/C5ldNkC6IqTNguU7pmCP0FFJBBDo+oCSpGMg+ptqTNSM1e9/SGClwtQbPLR4s5K65tYvDF8YZKZfA9+YjI0zr/0+Mu34k8VVluFArxLBAtQAcaJJX/5DcVmGQm0J9Hr4h2XU1Mf6LLpLlt1mbSBl8PEbm6OnmzPjLLKlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348184; c=relaxed/simple;
	bh=OOL9Yt2PfarWTfF1ME78RLYxsldwgaMz4Dw92UJa588=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNksuCRCxeFdVq6ZoPbkhpluxhT5AQzvGpY6fnDiBKsai6GDq1Grt3c4JGHoAyu1O87LUCtu5Xdczasj0S7vf9xa4RrRZg6Yx5bbhNOBeq5j+71KjSgRwnCyJN65JGfpIn6AZnhB8XThhzjLtldP0rco7Ve3nGCAXVwwww3q9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0027E150C;
	Fri,  7 Mar 2025 03:49:53 -0800 (PST)
Received: from [10.57.37.135] (unknown [10.57.37.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D04DA3F673;
	Fri,  7 Mar 2025 03:49:38 -0800 (PST)
Message-ID: <d9a6c611-2a19-4830-964d-44b711fffb08@arm.com>
Date: Fri, 7 Mar 2025 11:49:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] iommu: Sort out domain user data
To: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, joro@8bytes.org, will@kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <da7cc6d365ec6a77f6e6007f898eb3de2e581f80.1741294235.git.nicolinc@nvidia.com>
 <fabd6483-af48-4893-b539-2835640c5316@linux.intel.com>
 <Z8qKyvNyNU6dkN7V@Asurada-Nvidia>
 <16690409-1cb5-4b58-93fb-e5919ff1fc1f@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <16690409-1cb5-4b58-93fb-e5919ff1fc1f@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-03-07 7:03 am, Baolu Lu wrote:
> On 2025/3/7 13:57, Nicolin Chen wrote:
>> On Fri, Mar 07, 2025 at 10:28:20AM +0800, Baolu Lu wrote:
>>> On 3/7/25 05:00, Nicolin Chen wrote:
>>>> From: Robin Murphy<robin.murphy@arm.com>
>> Robin had remarks here, wrt iommu_set_fault_handler():
>>
>>>> The fact is that all these cookie types are
>>>> mutually exclusive, in the sense that combining them makes zero sense
>>>> and/or would be catastrophic (iommu_set_fault_handler() on an SVA
>>>> domain, anyone?) - the only combination which*might* be reasonable is
>>>> perhaps a fault handler and an MSI cookie, but nobody's doing that at
>>>> the moment, so let's rule it out as well for the sake of being clear 
>>>> and
>>>> robust.
>> [...]
>>>> @@ -224,10 +234,10 @@ struct iommu_domain {
>>>>                  phys_addr_t msi_addr);
>>>>    #endif
>>>> -    union { /* Pointer usable by owner of the domain */
>>>> -        struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
>>>> -    };
>>>> -    union { /* Fault handler */
>>>> +    union { /* cookie */
>>>> +        struct iommu_dma_cookie *iova_cookie;
>>>> +        struct iommu_dma_msi_cookie *msi_cookie;
>>>> +        struct iommufd_hw_pagetable *iommufd_hwpt;
>>>>            struct {
>>>>                iommu_fault_handler_t handler;
>>>>                void *handler_token;exs
>>> My feeling is that IOMMU_COOKIE_FAULT_HANDLER isn't exclusive to
>>> IOMMU_COOKIE_DMA_IOVA; both might be used for kernel DMA with a paging
>>> domain.
>>>
>>> I am afraid that iommu_set_fault_handler() doesn't work anymore as the
>>> domain's cookie type has already been set to IOMMU_COOKIE_DMA_IOVA.
>> All three existing iommu_set_fault_handler() callers in the tree
>> are UNMANAGED domain users:
>>     5    451  drivers/gpu/drm/msm/msm_iommu.c <<msm_iommu_gpu_new>>
>>               iommu_set_fault_handler(iommu->domain, 
>> msm_fault_handler, iommu);
>>     6    453  drivers/infiniband/hw/usnic/usnic_uiom.c 
>> <<usnic_uiom_alloc_pd>>
>>               iommu_set_fault_handler(pd->domain, 
>> usnic_uiom_dma_fault, NULL);
>>     8    118  drivers/remoteproc/remoteproc_core.c <<rproc_enable_iommu>>
>>               iommu_set_fault_handler(domain, rproc_iommu_fault, rproc);
>>
>> On the other hand, IOMMU_COOKIE_DMA_IOVA is a private cookie for
>> dma-iommu only.
>>
>> So, I think we are probably fine?
> If all existing use cases are for UNMANAGED domains, that's fine. And
> when iommu_set_fault_handler() is miss-used, we already have a WARN_ON()
> there.

Right, it would be illogical for a driver to set a fault handler on a 
DMA domain since it doesn't control the IOVA space to be able to do any 
fault-handling, and iommu-dma itself isn't ever going to use a fault 
handler because it expects the DMA API to be used correctly and thus no 
faults to occur.

TBH at this point I view the fault_handler stuff as a legacy interface 
which we don't really want to encourage use of anyway - it's already 
proven not to be great for any true fault handling since many drivers 
can only call report_iommu_fault() in IRQ context. If some new case does 
come up in future where this mutual exclusion gets in the way, I would 
say that's the point where we then look at reworking the whole thing 
into a dedicated "fault notifier" mechanism instead, which could then 
logically be orthogonal to the IOVA-space-owner cookie.

Thanks,
Robin.


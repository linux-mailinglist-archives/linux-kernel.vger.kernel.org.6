Return-Path: <linux-kernel+bounces-212547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D789062F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFD6B22045
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A19132123;
	Thu, 13 Jun 2024 04:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="misHY6wx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48527131E33
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718251731; cv=none; b=aY+V7Gk05bBgBfBZZmxm9iHFQ8bHyi2uY4fcxJxNgVEN52NhjkW6m+aTxHAkw0NudbGVhCMFWV0L5YZeIS1SQh7tMBHIu7p795kpChivzdF0uTdgF52tGEVdXWnLe+fFV4EwrIQP4AfiadjEJ37degAnHBKRQ8vkORKSqLs6OWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718251731; c=relaxed/simple;
	bh=ajeT9+Gf5biNuSQMg2imTr9noC4B0yFdWOKjAHdIKMw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AuLtoNlGEwOT2mLgE0AxC0Us6a+0ksU/B4WsjBXgyGbDaBunidG6sF359Kb5wStEkG6Rfy6FT4MdVCl9XMVXk1MBopuUpLjibDP5MaDJ/dEaa+KCzENk6pNSrHYqmhMw4luKV9uvggaD2pYdMP4myE6MF7Hfhj0Ifhcg1lqiTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=misHY6wx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718251730; x=1749787730;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ajeT9+Gf5biNuSQMg2imTr9noC4B0yFdWOKjAHdIKMw=;
  b=misHY6wxucf7hWmho/PnCdTZfRYzHAGpKi6Kraw6l4UfMbBGZzdOKdq3
   7NVseoS++Yg3UWN9VUY+LcxBS6ErEiwJLxne6xdG0j495px1d8RH3/svi
   Bt3v/FrRzCN7YdCfCPU01rczz10OkDI3xuehZqXL5imtOsoW4Vrq0LGpE
   mTbkSys9Kr9VP7orDSghmd7AT4Oo/HwFRfPKfJYbqmg8H4UoQfn+jVbtB
   51w7bCuWwJ38XWr4+XKI8mqUsfgjRS83ZbSh+gf3NHqu+5bA9RLB/V7Ip
   ODA6jNOyVNO4IeusDs1MgFp20t7ENnFJAjJmzgsfm25Pnaa2NtIFGlW6H
   w==;
X-CSE-ConnectionGUID: Fn/3mSDgQNKYBtKqFvawoA==
X-CSE-MsgGUID: H6nReVDGRtiVH8ooKCBcCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15201640"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="15201640"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 21:08:49 -0700
X-CSE-ConnectionGUID: 8I+I/9rBRAeDwe2qqr6GJg==
X-CSE-MsgGUID: ze7hntVvT7q1BWCe2u/eCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="45134745"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 12 Jun 2024 21:08:45 -0700
Message-ID: <28cc9b55-3c2f-47cf-9961-853a1e5f7790@linux.intel.com>
Date: Thu, 13 Jun 2024 12:06:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/10] iommu: Remove sva handle list
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527658A85092F88329EB73E98CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <afaf133b-7175-467f-a254-060b66b9cb4e@linux.intel.com>
 <BN9PR11MB527693E470478D92564A31718CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240612130554.GR791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612130554.GR791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:05 PM, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2024 at 09:35:23AM +0000, Tian, Kevin wrote:
>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>> Sent: Thursday, June 6, 2024 2:07 PM
>>>
>>> On 6/5/24 4:15 PM, Tian, Kevin wrote:
>>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>>> Sent: Monday, May 27, 2024 12:05 PM
>>>>>
>>>>> -	list_for_each_entry(handle, &mm->iommu_mm->sva_handles,
>>>>> handle_item) {
>>>>> -		if (handle->dev == dev) {
>>>>> -			refcount_inc(&handle->users);
>>>>> -			mutex_unlock(&iommu_sva_lock);
>>>>> -			return handle;
>>>>> -		}
>>>>> +	/* A bond already exists, just take a reference`. */
>>>>> +	attach_handle = iommu_attach_handle_get(group, iommu_mm-
>>>>>> pasid, IOMMU_DOMAIN_SVA);
>>>>> +	if (!IS_ERR(attach_handle)) {
>>>>> +		handle = container_of(attach_handle, struct iommu_sva,
>>>>> handle);
>>>>> +		refcount_inc(&handle->users);
>>>>> +		mutex_unlock(&iommu_sva_lock);
>>>>> +		return handle;
>>>>>    	}
>>>>
>>>> It's counter-intuitive to move forward when an error is returned.
>>>>
>>>> e.g. if it's -EBUSY indicating the pasid already used for another type then
>>>> following attempts shouldn't been tried.
> 
> Yes, it looks like iommu_sva_bind_device() should fail with EBUSY if
> the PASID is already in use and is not exactly the same SVA as being
> asked for here.
> 
> It will eventually do this naturally when iommu_attach_device_pasid()
> is called with an in-use PASID, but may as well do it here for
> clarity.
> 
> Also, is there a missing test for the same mm too?
> 
> I'd maybe change iommu_attach_handle() to return NULL if there is no
> handle and then write it like:
> 
> if (IS_ERR(attach_handle) && PTR_ERR(attach_handle) != -ENOENT) {
> 	ret = PTR_ERR(attach_handle);
> 	goto out_unlock;
> }
> 
> if (!IS_ERR(attach_handle) && attach_handle->domain->mm == mm) {
>     /* Can re-use the existing SVA attachment */
> }
> 

Okay, I will change it like below:

--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -91,11 +91,20 @@ struct iommu_sva *iommu_sva_bind_device(struct 
device *dev, struct mm_struct *mm
         attach_handle = iommu_attach_handle_get(group, iommu_mm->pasid, 
IOMMU_DOMAIN_SVA);
         if (!IS_ERR(attach_handle)) {
                 handle = container_of(attach_handle, struct iommu_sva, 
handle);
+               if (attach_handle->domain->mm != mm) {
+                       ret = -EBUSY;
+                       goto out_unlock;
+               }
                 refcount_inc(&handle->users);
                 mutex_unlock(&iommu_sva_lock);
                 return handle;
         }

+       if (PTR_ERR(attach_handle) != -ENOENT) {
+               ret = PTR_ERR(attach_handle);
+               goto out_unlock;
+       }
+
         handle = kzalloc(sizeof(*handle), GFP_KERNEL);
         if (!handle) {
                 ret = -ENOMEM;

>>>> Does it suggest that having the caller to always provide a handle
>>>> makes more sense?
> 
> I was thinking no just to avoid memory allocation.. But how does the
> caller not provide a handle? My original draft of this concept used an
> XA_MARK to indicate if the xarray pointed to a handle or a domain
> 
> This seems to require the handle:
> 
> -	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
> -	if (curr) {
> -		ret = xa_err(curr) ? : -EBUSY;
> +	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
> 
> Confused.

XA_MARK was used to indicate whether the stored pointer was an iommu
domain or an attach handle. Since this series removes
iommu_get_domain_for_dev_pasid(), there is no longer any need to store
the domain pointer at all.

> 
>>> I'm neutral on this since only sva bind and iopf path delivery currently
>>> require an attach handle.
>>
>> let's hear Jason's opinion.
> 
> At least iommu_attach_handle_get() should not return NULL if there is
> no handle, it should return EBUSY as though it couldn't match the
> type.

Agreed.

> 
> Jason

Best regards,
baolu


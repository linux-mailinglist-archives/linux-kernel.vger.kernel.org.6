Return-Path: <linux-kernel+bounces-207261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0854C9014C7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 09:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67DB3B21344
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5482F1B94F;
	Sun,  9 Jun 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FX/SwxAw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ACACA40
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 07:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717917937; cv=none; b=G1WhBY2+vwGCpeFJwn/IBvduuQ93eSqJ58v1spemyiYT1g9avTzuUhnT3PrhMONl0XRav8aAFqnoUEH4mv6/Ly3KNHHzsasBFwDpZbBktOHUe6pOT2Uhbq2lyE3tNVfeqH56SbnRMxPicy0mYa31rx6/9slbUU382vT19sZrTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717917937; c=relaxed/simple;
	bh=K3P3j3+HEA0MK46dMBTksMk7DNYLcOy/Q618IvXC3SI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pzGS2ZgV6f2julIqBszqv4bTZFqDFaBHkV0QbUwP++1RS0Iu9BzOkjG6b/9Of/xv+nI4XLRnVDiOGi7H/W/2SWLJ5ZlSC6dmfq7CtWOZ4pCh3Vy9x+lszj3crUmeybdu8HzUHRFj95A+8F9sa0erBv43W/w77ICxHzxsLT4FOMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FX/SwxAw; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717917936; x=1749453936;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K3P3j3+HEA0MK46dMBTksMk7DNYLcOy/Q618IvXC3SI=;
  b=FX/SwxAwi5Sa8ZHFmRBdIN8HF1XLsP0MZoy6o6bN4J4mVGvHEuSsDlgF
   Bik31rOwrSpEI8vvnFqWgL9+qbd1TO0VQKtyJFSixIi0ir2Ty5R65F9xN
   HumRwu0hgdJ7VaKO580ZqnjNVvMka7xHvy0h548xGB7i1jjTLLgNNqY2y
   hXHH1BeuMsPOO6CRI7k5ymrJ0NIA5ikKN+JrxfDY2FLnHlYZNFlIVtqLs
   prghu8iT1Z0ZKx8fULj59kkBwRsg5pFP0MhlYDHpbtkAeXdxKkh3l5vQE
   7VKzYJgW9nTFNWvWW9ZelBXSspAM+tzQN17wrQ3e7HuPGhVw7uiphokJb
   A==;
X-CSE-ConnectionGUID: aGBYyLCuS7+LV2IADnFjmg==
X-CSE-MsgGUID: WD0RndWgQ2G+SrdteBuh/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11097"; a="14716611"
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="14716611"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2024 00:25:35 -0700
X-CSE-ConnectionGUID: CkxalOE7RICGx/8i7OWDCw==
X-CSE-MsgGUID: e43F6EiSS1+O9bOD+4Gz0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,225,1712646000"; 
   d="scan'208";a="38862352"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 09 Jun 2024 00:25:32 -0700
Message-ID: <996ad6df-c499-4070-b3a9-1cdccfcf5d09@linux.intel.com>
Date: Sun, 9 Jun 2024 15:23:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FC9E1E7CF82BF51BC1FD8CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276FC9E1E7CF82BF51BC1FD8CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/7/24 5:30 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 27, 2024 12:05 PM
>>
>> Add iopf-capable hw page table attach/detach/replace helpers. The pointer
>> to iommufd_device is stored in the domain attachment handle, so that it
>> can be echo'ed back in the iopf_group.
> 
> this message needs an update. now the device pointer is not in the
> attach handle.

The iommufd_device pointer is in the attach handle provided by iommufd 
in attach or replace path.

> and there worths a explanation about VF in the commit msg.
> 
>> @@ -376,7 +377,10 @@ int iommufd_hw_pagetable_attach(struct
>> iommufd_hw_pagetable *hwpt,
>>   	 * attachment.
>>   	 */
>>   	if (list_empty(&idev->igroup->device_list)) {
>> -		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
>> +		if (hwpt->fault)
>> +			rc = iommufd_fault_domain_attach_dev(hwpt, idev);
>> +		else
>> +			rc = iommu_attach_group(hwpt->domain, idev-
>>> igroup->group);
> 
> Does it read better to have a iommufd_attach_device() wrapper with
> above branches handled internally?

Yes. Will do this in the next version.

> 
>>
>> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>> +{
>> +	struct device *dev = idev->dev;
>> +	int ret;
>> +
>> +	/*
>> +	 * Once we turn on PCI/PRI support for VF, the response failure code
>> +	 * could not be forwarded to the hardware due to PRI being a shared
> 
> you could but just doing so is incorrect. 😊
> 
> s/could/should/

Done.

> 
>> +	 * resource between PF and VFs. There is no coordination for this
>> +	 * shared capability. This waits for a vPRI reset to recover.
>> +	 */
> 
> this may go a bit further to talk about supporting it requires an emulation
> in iommufd (i.e. pause any further fault delivery until vPRI reset). It is a
> future work so disable it for VF at this point.

Yes.

> 
>> +void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable
>> *hwpt,
>> +				     struct iommufd_device *idev)
>> +{
>> +	struct iommufd_attach_handle *handle;
>> +
>> +	handle = iommufd_device_get_attach_handle(idev);
>> +	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
>> +	iommufd_auto_response_faults(hwpt, handle);
>> +	iommufd_fault_iopf_disable(idev);
>> +	kfree(handle);
> 
> this assumes that the detach callback of the iommu driver needs to drain
> in-fly page requests so no further reference to handle or queue new req
> to the deliver queue when it returns, otherwise there is a use-after-free
> race or stale requests in the fault queue which auto response doesn't
> cleanly handle.
> 
> iirc previous discussion reveals that only intel-iommu driver guarantees
> that behavior. In any case this should be documented to avoid this being
> used in a non-conforming iommu driver.
> 
> If I misunderstood, some comment why no race in this window is also
> appreciated. 😊

Yes. The iommu driver needs to guarantee that there will be no iopf
request for a RID or PASID after the domain has been detached. This
implies that:

- IOMMU hardware should not put further iopf in its hardware queue if
   the domain has been detached.
- Before the domain detachment is complete, the iommu driver should
   flush all iopf targeting the detached domain in the hardware page
   request queue.

> 
>> +}
>> +
>> +static int __fault_domain_replace_dev(struct iommufd_device *idev,
>> +				      struct iommufd_hw_pagetable *hwpt,
>> +				      struct iommufd_hw_pagetable *old)
>> +{
>> +	struct iommufd_attach_handle *handle, *curr = NULL;
>> +	int ret;
>> +
>> +	if (old->fault)
>> +		curr = iommufd_device_get_attach_handle(idev);
>> +
>> +	if (hwpt->fault) {
>> +		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +		if (!handle)
>> +			return -ENOMEM;
>> +
>> +		handle->handle.domain = hwpt->domain;
>> +		handle->idev = idev;
>> +		ret = iommu_replace_group_handle(idev->igroup->group,
>> +						 hwpt->domain, &handle-
>>> handle);
>> +	} else {
>> +		ret = iommu_replace_group_handle(idev->igroup->group,
>> +						 hwpt->domain, NULL);
>> +	}
>> +
>> +	if (!ret && curr) {
>> +		iommufd_auto_response_faults(old, curr);
>> +		kfree(curr);
>> +	}
> 
> In last version you said auto response is required only when switching
> from fault-capable old to fault-incapable new. But above code doesn't
> reflect that description?

What the current code does is auto-respond to all page faults targeting
the old fault-capable hwpt. I'm also okay if we decide to limit this to
flushing page faults only if the new hwpt is *not* fault-capable.

Best regards,
baolu


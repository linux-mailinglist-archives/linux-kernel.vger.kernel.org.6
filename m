Return-Path: <linux-kernel+bounces-183383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EB58C9844
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 05:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCB41C217B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 03:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D61101E6;
	Mon, 20 May 2024 03:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UFrZocsn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C878C2ED
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716175829; cv=none; b=Qula1GROgJt53xZJ8rKBKPd9X4wzhXgrR0pz+LIrA8+7aToxb3TZNsBE57dh4q7ciVG/rpE+BT3Qv6+3Ef09fKjAc6mQqE387kqw/2fbhFu1+QMG0+ua/4ELEJNKOgJeZNiPwDdYstyoX37rXEolIU3hcmw+7/WJwhjC+DWXtY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716175829; c=relaxed/simple;
	bh=ikOTYfj5UG4dTpauR7CDHRmki8gXIROQCt77kT2U4jI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=E7nE4yKWu2gTj89793M+YQgReJ7ecBQKg1Qojb6a1AgBO/quJW+zIGDUBh2fkIer92ycKY1gyYVbwnuugeiScRM+9u33dtQ3Wb1q0DuIEmUibZXo/5BavlqVml41NV8OCfMV77LBd+eiQban/LdgTpa3ZEac6JXVYVneeT3o2rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UFrZocsn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716175827; x=1747711827;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ikOTYfj5UG4dTpauR7CDHRmki8gXIROQCt77kT2U4jI=;
  b=UFrZocsn/BVFw/FcEI83In0q2CtplFV9VreutNHpjKH08nVJLxAirw3t
   MmwV0DfQac2cs0pzmrHsETGdJpcXRE6GmHVb56qdr2kQ5HyYyh1qCwTzk
   MiOqEmAVyrOUbhQXsT991b843q3ZvCqlyMRdBB4rOoqYLo0k4Je1pEA/e
   eK7YNOg6dDEWfl5XRdNEN8XMbeyg+muNk+mzyRw7Q33baw6iN+h2C7aPl
   acsKdxr7rCbSyFpeSrvKXF8a/f48sRvsDHnKICrUNochpWFOadGauN9P+
   NAaoSsoqk3jIzLjvMsyUApv1rCOAuR3LJ8nMs2Vgqot4RkXnViIHrq/gI
   A==;
X-CSE-ConnectionGUID: tfp12MR8TOiiyz+NtPWPzw==
X-CSE-MsgGUID: xvJ2tzb3TpaEJNU1TH94ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="15229124"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="15229124"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:30:27 -0700
X-CSE-ConnectionGUID: kpasQPeuTTi6K6G9JAdx7A==
X-CSE-MsgGUID: w+5CVyV1T867FyHDbsuZiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32297108"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 19 May 2024 20:30:21 -0700
Message-ID: <f88b9fea-3941-49d6-ad54-4be29bc6d034@linux.intel.com>
Date: Mon, 20 May 2024 11:28:30 +0800
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
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <20240508001121.GN4718@ziepe.ca>
 <a03d3bf6-0610-427c-bf2a-5f6c410e220e@linux.intel.com>
 <BN9PR11MB5276F21755C883FE7EC784228CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <733e3788-d303-4b75-aa97-d97489a7f0bf@linux.intel.com>
 <BN9PR11MB527685B9D96675AA8A3CE78E8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527685B9D96675AA8A3CE78E8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 11:26 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 20, 2024 8:41 AM
>>
>> On 5/15/24 3:57 PM, Tian, Kevin wrote:
>>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>>> Sent: Wednesday, May 8, 2024 6:05 PM
>>>>
>>>> On 2024/5/8 8:11, Jason Gunthorpe wrote:
>>>>> On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
>>>>>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-
>> priv.h
>>>>>> index ae65e0b85d69..1a0450a83bd0 100644
>>>>>> --- a/drivers/iommu/iommu-priv.h
>>>>>> +++ b/drivers/iommu/iommu-priv.h
>>>>>> @@ -36,6 +36,10 @@ struct iommu_attach_handle {
>>>>>>     			struct device	*dev;
>>>>>>     			refcount_t	users;
>>>>>>     		};
>>>>>> +		/* attach data for IOMMUFD */
>>>>>> +		struct {
>>>>>> +			void		*idev;
>>>>>> +		};
>>>>> We can use a proper type here, just forward declare it.
>>>>>
>>>>> But this sequence in the other patch:
>>>>>
>>>>> +       ret = iommu_attach_group(hwpt->domain, idev->igroup->group);
>>>>> +       if (ret) {
>>>>> +               iommufd_fault_iopf_disable(idev);
>>>>> +               return ret;
>>>>> +       }
>>>>> +
>>>>> +       handle = iommu_attach_handle_get(idev->igroup->group,
>>>> IOMMU_NO_PASID, 0);
>>>>> +       handle->idev = idev;
>>>>>
>>>>> Is why I was imagining the caller would allocate, because now we have
>>>>> the issue that a fault capable domain was installed into the IOMMU
>>>>> before it's handle could be fully setup, so we have a race where a
>>>>> fault could come in right between those things. Then what happens?
>>>>> I suppose we can retry the fault and by the time it comes back the
>>>>> race should resolve. A bit ugly I suppose.
>>>>
>>>> You are right. It makes more sense if the attached data is allocated and
>>>> managed by the caller. I will go in this direction and update my series.
>>>> I will also consider other review comments you have given in other
>>>> places.
>>>>
>>>
>>> Does this direction imply a new iommu_attach_group_handle() helper
>>> to pass in the caller-allocated handle pointer or exposing a new
>>> iommu_group_set_handle() to set the handle to the group pasid_array
>>> and then having iomm_attach_group() to update the domain info in
>>> the handle?
>>
>> I will add new iommu_attach/replace/detach_group_handle() helpers. Like
>> below:
>>
>> +/**
>> + * iommu_attach_group_handle - Attach an IOMMU domain to an IOMMU
>> group
>> + * @domain: IOMMU domain to attach
>> + * @group: IOMMU group that will be attached
>> + * @handle: attach handle
>> + *
>> + * Returns 0 on success and error code on failure.
>> + *
>> + * This is a variant of iommu_attach_group(). It allows the caller to
>> provide
>> + * an attach handle and use it when the domain is attached. This is
>> currently
>> + * only designed for IOMMUFD to deliver the I/O page faults.
>> + */
>> +int iommu_attach_group_handle(struct iommu_domain *domain,
>> +                             struct iommu_group *group,
>> +                             struct iommu_attach_handle *handle)
>>
> 
> "currently only designed for IOMMUFD" doesn't sound correct.
> 
> design-wise this can be used by anyone which relies on the handle.
> There is nothing tied to IOMMUFD.
> 
> s/designed for/used by/ is more accurate.

Done.

Best regards,
baolu


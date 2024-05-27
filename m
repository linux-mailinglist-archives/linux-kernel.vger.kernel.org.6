Return-Path: <linux-kernel+bounces-189984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED0C8CF808
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB076B20BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBED2523A;
	Mon, 27 May 2024 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPnQS+F3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABD0323D
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 03:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779979; cv=none; b=meBRrOLdIdJYd+JwcUvpWwtwyfIrDEIuLPlHc76KwM4z4ZucgbSrdaEAxpJIa6gfXREzzI1kvMrlBwhanlMcXYSMeCn7BgPKIsxK4vgK9J5WR0wgwScYRdzn1imcjNQvQ4S7As5AuVAclDkARIlL9W2vtD4LVBPCnHU9Y3mLw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779979; c=relaxed/simple;
	bh=WUffBdqEOLaqOF4z5j7m0MYHmGFH6sMH9X3Tl+Gf3Oo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lxdyIC8yJW0TJaKU+cmWXsWM4VJgpehwiO2MoOZQdCU4p3WbF4rB7gIPIFDjpMYruqI8x0lgRLOeVfVhcblE1a3lkEUCy97wFe6vm5zNwW5/YDIMbUcC+6/nNq9LmmgAQKqKgzOX1higoZcZDiID4onIfJDywRFIvoRv/rLMQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPnQS+F3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716779977; x=1748315977;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WUffBdqEOLaqOF4z5j7m0MYHmGFH6sMH9X3Tl+Gf3Oo=;
  b=JPnQS+F3oRsijSaev/JqyA3KzHaW7AeKdEseFKqcZGf+Sow/cZQ812Ih
   c2rzRRsrJGSjWTela0bJ8OWDHnmyxGsnOns1KSCgi7PCEQIUWGjknpkjN
   DaLgtjT6jSxMBl8f+dzh6QJ+ZNCp8BbobRY8f77zmXmNI6UJfVkENAZDg
   ieQsyOQNQxMOZTfK+NvWHF+PBOENjXxJYdDJPY/3MlYzcPkFVcxFYye/l
   zYSjsA1eo39Vr2S9dWoWnzJ7zCmiFgkPnoIaabHNyf/c9cJE848CxwUtL
   qZvSG3hhLsIWU3Ww+V8LDMaADscLyspn+Fi5QoiIXjn/bahwdqA23wMou
   g==;
X-CSE-ConnectionGUID: zi/AwH8SRPiGGmfUs8hmtA==
X-CSE-MsgGUID: WATcmLJ3STWaXBSM8TYzrQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="23745169"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="23745169"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 20:18:46 -0700
X-CSE-ConnectionGUID: YBoarlh6TfqWW41Ts+TVpg==
X-CSE-MsgGUID: wGMRZsJGTMaNhj4qW0iMaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39177191"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 26 May 2024 20:18:43 -0700
Message-ID: <2b84f4f0-14a7-4232-932f-617e0a1b53d4@linux.intel.com>
Date: Mon, 27 May 2024 11:16:41 +0800
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
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b09f96db-8451-4de9-81c5-312cffdfd4fc@linux.intel.com>
 <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240524142446.GP69273@ziepe.ca>
 <BN9PR11MB527647FF053E249E27F4B43C8CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527647FF053E249E27F4B43C8CF02@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/27/24 9:33 AM, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Friday, May 24, 2024 10:25 PM
>>
>> On Mon, May 20, 2024 at 03:39:54AM +0000, Tian, Kevin wrote:
>>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>>> Sent: Monday, May 20, 2024 10:19 AM
>>>>
>>>> On 5/15/24 4:50 PM, Tian, Kevin wrote:
>>>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>>>> Sent: Tuesday, April 30, 2024 10:57 PM
>>>>>>
>>>>>> @@ -308,6 +314,19 @@ int iommufd_hwpt_alloc(struct
>> iommufd_ucmd
>>>>>> *ucmd)
>>>>>>    		goto out_put_pt;
>>>>>>    	}
>>>>>>
>>>>>> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
>>>>>> +		struct iommufd_fault *fault;
>>>>>> +
>>>>>> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
>>>>>> +		if (IS_ERR(fault)) {
>>>>>> +			rc = PTR_ERR(fault);
>>>>>> +			goto out_hwpt;
>>>>>> +		}
>>>>>> +		hwpt->fault = fault;
>>>>>> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
>>>>>> +		hwpt->domain->fault_data = hwpt;
>>>>>> +	}
>>>>>
>>>>> this is nesting specific. why not moving it to the nested_alloc()?
>>>>
>>>> Nesting is currently a use case for userspace I/O page faults, but this
>>>> design should be general enough to support other scenarios as well.
>>>
>>> Do we allow user page table w/o nesting?
>>>
>>> What would be a scenario in which the user doesn't manage the
>>> page table but still want to handle the I/O page fault? The fault
>>> should always be delivered to the owner managing the page table...
>>
>> userspace always manages the page table, either it updates the IOPTE
>> directly in a nest or it calls iommufd map operations.
>>
>> Ideally the driver will allow PRI on normal cases, although it will
>> probably never be used.
>>
> 
> But now it's done in a half way.
> 
> valid_flags in normal cases doesn't accept a fault ID. but we then
> handle the fault ID flag generally above.
> 
> I'd like to see a consistent message throughout the path.

Okay, I see. I think valid_flags logic is doing the right thing. It
indicates that user space page fault on a paging hwpt is not supported
yet, but it leaves the room to grow it in the future.

I will post v6 of this series soon to address some obvious issues
identified during this v5 review cycle. Thanks to all review comments.

Best regards,
baolu


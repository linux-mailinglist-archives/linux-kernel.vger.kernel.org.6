Return-Path: <linux-kernel+bounces-332226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBFE97B6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CFC2812C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 02:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909A8524B0;
	Wed, 18 Sep 2024 02:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qa1I5ZYI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35E184F
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 02:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726628189; cv=none; b=XUdMmwxmFGQ142SxCNOnHUyKox5e/2eMTd345Fh4bDAHF53Pg4sRreQ2Xp4bluLjYs95aHQkvK/D8zAwEByIkgLFJNpA6dujP2H1XLUOrLaurh0eZK0Pz7w5T9OeGnthu32AId+shK+p0OgikG2RUAl0aR061ag6Bn28wIx+GTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726628189; c=relaxed/simple;
	bh=jfV1RhFfuwcL2DBL7JBs5X8V0JAe8SDgKzVTqryCgYM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kJOEazKfA5RNX0+VRLTBb6DujOgQLreY0OPJ9NfBn/j1Mq8WW91ontoAdk2X452/PKsThCYvWrP7lD+QB1pQY5lDJcVlikSHDYSX7ps3vsPJAcgsXPEbgvQ+Et9XZbLDF8K2ZiZJFkp7lFuVvZX0A4VeVDainPZufFo4j62asa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qa1I5ZYI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726628188; x=1758164188;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jfV1RhFfuwcL2DBL7JBs5X8V0JAe8SDgKzVTqryCgYM=;
  b=Qa1I5ZYIK11vGHeS33FMqsjCmJh0O7Bm2xHEpbO3qd29JQPEMsHkdpOr
   UFmSEXXX9aWey0Wb1gZc95/D2O3o63LtZbLa4RYht5gfxJ/rKHYLuXMs7
   sK2fxr9Ob2KSOuDKBh6oUZh93UmQzUD0qXDeY+7IJVt18zZVWB5bPCzGa
   dcO3LCI9QwyB+TxbJiUE6lOj0R1YsHkGfypDbCmQ1XsGRccGHxGJXNjJB
   fII0l47UboRlZjFbOD3EiJpGnCmStyYv9g3MMR6rTGzC9oaD2qDrwoxhE
   In8qkAGrB+TWn4q1C9Z7y4QohBKDBhzN1O0PAuAMuqSZx4l+bgeIUxLo7
   A==;
X-CSE-ConnectionGUID: +oB5Sfa7RuO3NEogvYFn6Q==
X-CSE-MsgGUID: CjWdMim6Se+kPULleKc8+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25402803"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25402803"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 19:56:27 -0700
X-CSE-ConnectionGUID: Pioonrk5QvSloefnrV7rng==
X-CSE-MsgGUID: YJTNIi/uQ/WvYq4MZWjlrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69622982"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 17 Sep 2024 19:56:24 -0700
Message-ID: <a5e0ff3c-a48f-4f2f-bf6a-551ebec21559@linux.intel.com>
Date: Wed, 18 Sep 2024 10:52:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 "j.granados@samsung.com" <j.granados@samsung.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Klaus Jensen <its@irrelevant.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
 <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
 <BL1PR11MB52713D3D5947C66AE463FA4B8C662@BL1PR11MB5271.namprd11.prod.outlook.com>
 <e0a1347f-877e-445c-9158-7584ae200bff@linux.intel.com>
 <BN9PR11MB527611131A808B78C8E0E8388C662@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c8708b95-14b9-4545-84f7-6f45161456cc@linux.intel.com>
 <20240915134928.GD869260@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240915134928.GD869260@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/24 9:49 PM, Jason Gunthorpe wrote:
> On Sat, Sep 14, 2024 at 01:49:44PM +0800, Baolu Lu wrote:
>> On 2024/9/14 10:53, Tian, Kevin wrote:
>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>> Sent: Saturday, September 14, 2024 9:18 AM
>>>>
>>>> On 9/14/24 8:52 AM, Tian, Kevin wrote:
>>>>>> From: Joel Granados via B4 Relay
>>>>>> <devnull+j.granados.samsung.com@kernel.org>
>>>>>>
>>>>>> From: Joel Granados<j.granados@samsung.com>
>>>>>>
>>>>>> IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM.
>>>>>> Move
>>>>>> all Page Request Queue (PRQ) functions that handle prq events to a new
>>>>>> file in drivers/iommu/intel/prq.c. The page_req_des struct is now
>>>>>> declared in drivers/iommu/intel/prq.c.
>>>>>>
>>>>>> No functional changes are intended. This is a preparation patch to
>>>>>> enable the use of IO page faults outside the SVM/PASID use cases.
>>>>> Do we want to guard it under a new config option e.g.
>>>>> CONFIG_INTEL_IOMMU_IOPF? it's unnecessary to allocate resources
>>>>> for the majority usages which don't require IOPF.
>>>>>
>>>>> Baolu?
>>>> The OS builder doesn't know if Linux will run on a platform with PRI-
>>>> capable devices. They'll probably always enable this option if we
>>>> provide it.
>>> hmm then why do we need a SVM option? In reality I haven't seen
>>> a platform which supports IOPF but no pasid/SVM. so the reason
>>> for whether to have an option should be same between IOPF/SVM.
>>>
>>> IMHO the point of options is to allow reducing footprint of the kernel
>>> image and many options are probably always enabled in distributions...
>> To be honest, I would hope to remove the SVM option some day. It's
>> nothing special except listening to an external notification and
>> synchronize the caches when the page table is updated. It's common to
>> all cases where a page table is shared between the IOMMU and another
>> component.
>>
>> As for CONFIG_INTEL_IOMMU_IOPF, my suggestion is that we don't need to
>> add any unnecessary options unless we see a real need.
> You could possibly bundle the SVA and IOPF options together
> 
> I called the new option on the ARM side CONFIG_ARM_SMMU_V3_IOMMUFD
> which seems like a reasonable cut point against embedded vs server.

Probably I will consider this after this series. This is not intel iommu
specific, hence it's better to make it consistent for all drivers.

Thanks,
baolu


Return-Path: <linux-kernel+bounces-222072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD7A90FC7D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB1B1F21C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C786D2E3E9;
	Thu, 20 Jun 2024 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrUQuRNe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626B12D058
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863494; cv=none; b=uoDAPnYpvCJbP5YsfYgcpzUG5auY5h54NaGdmBS87xKADUoUjs4Ga7qJv1Zfcjfp5LY1iPkNWTYAbr5NgvimRRZCr+LAL3TI74pygF2nQoxIFf7d/7VcpFDvinDdMd7OX4m/cVHMN2MSbsI9hwc8x4v5nEzFdkhYquYfzfhRxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863494; c=relaxed/simple;
	bh=vlw1Xnl3Aqyy7xA2S0lJNKJLn4915SM0HlRt5Nli4IA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J3hOdOV+6ph3LgCrbLaVHgNbmmGiTWKO9Oqu6RGxPKv8AZtFwQIDOX6EDyPQfYyF7ZE9TGMiWvcHTIwlYdl22SPaK6pusnTqenSlyZJNpt7Vtl2QxENJUr2UXPMFvMG6QPCRWXmvsWB5db4hm1EVGzGY26bZQKMu/FSFJ60rG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrUQuRNe; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718863493; x=1750399493;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vlw1Xnl3Aqyy7xA2S0lJNKJLn4915SM0HlRt5Nli4IA=;
  b=HrUQuRNegmX2PRAKM7Pni6NsayvjTrKQIe5JRbCN/RODK+RpdSnGGZFY
   r52qJ0hFi4XfmSe3CYAJUh7T2ash5okYiQ4AiY3RQ2eOGloAbZUtLkx53
   qW27fONnLJvUBlAxWNXEXNn6XX+pDrXeHvJotn3sT92IItcHxnp+izJzd
   oPgSmlMZ1E/SuZFEY91nCCSZVmCtHdi/B9Dw1Yj7gXGm502vATc/dMWkJ
   n1N4fXIr26TsoLRF6Fwjxv16thD5w4d1w8+IKxBF6NgVUSXM23AOqGVnu
   /AvufQ+Bnri3cVeRmKKAl/S+gGilLulBrdWKIcUZ6LhBS2fJmHzQbmxTN
   Q==;
X-CSE-ConnectionGUID: RXZJRrgnQp2kmJEs7g69Ug==
X-CSE-MsgGUID: W+R/1/O0TT+Wvqi/WIQyFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15960255"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15960255"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 23:04:52 -0700
X-CSE-ConnectionGUID: cDENORhvTZyFxg7y/amIzA==
X-CSE-MsgGUID: YoUrRknBSoK9WeItoJLONA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42244721"
Received: from pugong-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 23:04:49 -0700
Message-ID: <0129a8fa-a2e2-481d-8577-53f2ad47ef10@linux.intel.com>
Date: Thu, 20 Jun 2024 14:04:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix missed device TLB cache tag
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240619015345.182773-1-baolu.lu@linux.intel.com>
 <20240619164620.GN791043@ziepe.ca>
 <1dfb467d-f25a-4270-8a36-a048f061e2aa@linux.intel.com>
 <BN9PR11MB5276F76798E61D231D861A2F8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
 <976d4054-6306-4325-a112-5cf69b0c6f34@linux.intel.com>
 <BN9PR11MB5276E106E53A3DFE184FEC698CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276E106E53A3DFE184FEC698CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/6/20 11:57, Tian, Kevin wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Thursday, June 20, 2024 11:14 AM
>>
>> On 6/20/24 11:04 AM, Tian, Kevin wrote:
>>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>>> Sent: Thursday, June 20, 2024 8:50 AM
>>>>
>>>> On 6/20/24 12:46 AM, Jason Gunthorpe wrote:
>>>>> On Wed, Jun 19, 2024 at 09:53:45AM +0800, Lu Baolu wrote:
>>>>>> When a domain is attached to a device, the required cache tags are
>>>>>> assigned to the domain so that the related caches could be flushed
>>>>>> whenever it is needed. The device TLB cache tag is created selectively
>>>>>> by checking the ats_enabled field of the device's iommu data. This
>>>>>> creates an ordered dependency between attach and ATS enabling paths.
>>>>>>
>>>>>> The device TLB cache tag will not be created if device's ATS is enabled
>>>>>> after the domain attachment. This causes some devices, for example
>>>>>> intel_vpu, to malfunction.
>>>>> What? How is this even possible?
>>>>>
>>>>> ATS is controlled exclusively by the iommu driver, how can it be
>>>>> changed without the driver knowing??
>>>> Yes. ATS is currently controlled exclusively by the iommu driver. The
>>>> intel iommu driver enables PCI/ATS on the probe path after the default
>>>> domain is attached. That means when the default domain is attached to
>>>> the device, the ats_supported is set, but ats_enabled is cleared. So the
>>>> cache tag for the device TLB won't be created.
>>> I don't quite get why this is specific to the probe path and the default
>>> domain.
>> The issue is with the domain attaching device path, not specific to the
>> probe or default domain.
>>
>>> dmar_domain_attach_device()
>>> {
>>> 	cache_tag_assign_domain();
>>> 	//setup pasid entry for pt/1st/2nd
>>> 	iommu_enable_pci_caps();
>>> }
>>>
>>> seems that for all domain attaches above is coded in a wrong order
>>> as ats is enabled after the cache tag is assigned.
>> Yes, exactly. But simply changing the order isn't future-proof,
>> considering ATS control will eventually be moved out of iommu drivers.
> I'm not sure the way this patch goes is future-proof either. Ideally the devtlb
> cache tag should always be assigned together with enabling the ats capability
> then in that case we won't have a case assigning a tag upon info->ats_supported
> at attach and then check info->ats_enabled run-time for flush.

Yes, creating the required cache tag when enabling the ATS feature makes
more sense.

> 
> and order-wise it makes slightly more sense to assign cache tag at end of
> the attach function after all other configurations have been completed.
> 
> with that I prefer to a simple fix by reverting the order instead of adding
> unnecessary run-time overhead for unclear future. 😊

Okay, I will follow this way to fix it.

Best regards,
baolu


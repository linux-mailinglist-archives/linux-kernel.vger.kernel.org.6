Return-Path: <linux-kernel+bounces-248572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1486E92DF28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4626B1C2187D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65B64963F;
	Thu, 11 Jul 2024 04:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ucg8wWPp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DDC376E4
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720673109; cv=none; b=cShxjdCG4Wm5fbhiMizj53jkAX6XNl8H7G+1Y8S+8B23MfjIct1T0kw5a5Ytf7ZVVITJhaZOd18c2ryO+4oYqYY04ZsD+dieSdMAov0nz6DmyxzfLywgVCUrlLVY003AP3fRfYvroAosiAgeOm/IeTPgxAKGFEIc1x106gt+N8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720673109; c=relaxed/simple;
	bh=SLE8iv1gS/925bWtDCRkm6vcnRWpUcxElWCPVPn23FQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tAKuJOqEdnxr0ktmLMX0fSudXitaIGRT50FgXL2q+NfapHvBT8bTuaU5WJYsZIO20zTweDeb9I4Bw75irfKyRvFqYn4Mc+L3/IFyRFyeY8Jc4wwow4TYJMMsgd4ZLXBybA/uRioIOV6pnByKHqU8l4K3JaOwRxEDQHwwx4SC2zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ucg8wWPp; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720673106; x=1752209106;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SLE8iv1gS/925bWtDCRkm6vcnRWpUcxElWCPVPn23FQ=;
  b=Ucg8wWPpspoAv8fFOCZBaRcxUZNsWY8h03MzCwsfh0xj3L7WRVKrqcHK
   94wY0iI0u1DXd4JQsILuL7OWeSEW2CL+kkiXzacZEZYgCNpiot5my3Qqu
   PqYIMuHLTIs5MjpECoh6ocNWQGiPaUe/vtcLEiqRd9lS+yoTPOUi2tag4
   Jh6Ce056I/SRSF+2MOoWNYqiLFcDhe+ZvkPA+4GYWgHstYq/fkKFCo5qO
   fADB9Ki+CG0GqP5zhLCRlKpHnxZyxYFqdZo9UPB+FZR+91ZFzUSrwWiHs
   FWuvk5W1ktuEmG8wwRuQusZgyRE3fdNE+8lqUnx52ebHJgD+6V8eZErbB
   A==;
X-CSE-ConnectionGUID: OVd4Rpe+T+qZEHOljQAJGA==
X-CSE-MsgGUID: mcWytCB3QOyVe0oCyMbVaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21903977"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="21903977"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 21:45:05 -0700
X-CSE-ConnectionGUID: E6ssgs+dSTayW9Q3JUCXmg==
X-CSE-MsgGUID: NY4EQmyVSNaQ1mBLcLGioQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="53613772"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 10 Jul 2024 21:45:02 -0700
Message-ID: <9b3b05c0-b43a-4a56-b885-f79ef9efb38b@linux.intel.com>
Date: Thu, 11 Jul 2024 12:42:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu: Convert response code from failure to invalid
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EC68D1BBB52C9E6DDE558CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276EC68D1BBB52C9E6DDE558CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 5:56 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, July 10, 2024 4:34 PM
>>
>> In the iopf deliver path, iommu_report_device_fault() currently responds
>> a code of "Response Failure" to the hardware if it can't find a suitable
>> iopf-capable domain where the page faults should be handled. The Response
>> Failure is defined in PCI spec (section 10.4.2.1) as a catastrophic error,
>> and the device will disable PRI for the function.
>>
>> Failing to dispatch a set of fault messages is not a catastrophic error
>> and the iommu core has no code to recover the PRI once it is disabled.
>>
>> Replace it with a response code of "Invalid Response".
>>
>> Fixes: b554e396e51c ("iommu: Make iopf_group_response() return void")
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/io-pgfault.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
>> index cd679c13752e..b8270ee5dcdb 100644
>> --- a/drivers/iommu/io-pgfault.c
>> +++ b/drivers/iommu/io-pgfault.c
>> @@ -229,7 +229,7 @@ void iommu_report_device_fault(struct device *dev,
>> struct iopf_fault *evt)
>>   err_abort:
>>   	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
>>   			     fault->prm.pasid);
>> -	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
>> +	iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
>>   	if (group == &abort_group)
>>   		__iopf_free_group(group);
>>   	else
> 
> this doesn't match the spec words on the use of INVALID:
> 
>    One or more pages within the associated PRG do not exist or
>    requests access privilege(s) that cannot be granted. Unless the
>    page mapping associated with the Function is altered, re-issuance
>    of the associated request will never result in success.
> 
> this situation is not related to the permission of page mapping. Instead
> it's a global problem applying to all functions submitting page requests
> at this moment.
> 
> Though using FAILURE affects more functions sharing the PRI interface,
> it also proactively avoids adding more in-fly requests to worsen the
> low memory situation.
> 
> So none of the options looks perfect to me, but the existing code
> responding FAILURE is more aligned to the spec?

Fair enough. Perhaps we can keep the existing code as-is unless any real
issues arise.

Thanks,
baolu


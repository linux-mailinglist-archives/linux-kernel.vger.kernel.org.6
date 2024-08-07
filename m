Return-Path: <linux-kernel+bounces-277364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40492949FB8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AD01C22434
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 06:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1029D1B14E9;
	Wed,  7 Aug 2024 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dvvi+dGF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB8A1B0125
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723011604; cv=none; b=s/nIHYbMNtLnDape2pU1s7fMzqiqSiQvNsbV5SrQfW7AT76bpsmtk5TLzx+Es9v1iMvazOb5sD+45YNjlIn4vjZ2d9GIVdcnKVbCzugX8IGfcoXSyITkGcpKaQEBq54qUC5SH80At41F49aqkOUWFq61sSpqDr4rrPoGEvsUr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723011604; c=relaxed/simple;
	bh=pmEsQvVsnUBZVMPMZOtOgn4YYeyloOie+2mHcRCpDZE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k3jLC++V1dH/7YkEV+7IYgyUepqVOJNuRvyMRQAgjKNTQ3FSdGNojZv7UpYw4LdE96wo6TzrpJT3Qg2XtNFtx4mSHzPFLF2Iz6CxEAnrIwtuluFqzUVNDn2nUmWnGPvMcMc/emdt+WQg0+fQbNUpm7Z+/2NWA2tzAeHkxr002SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dvvi+dGF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723011603; x=1754547603;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pmEsQvVsnUBZVMPMZOtOgn4YYeyloOie+2mHcRCpDZE=;
  b=dvvi+dGFfFKq8nGPUPY5tZWNeqdLQ2VTlOWr1MC5ipbBMIp/mLCffRcc
   cz0wyGH9MPf+Fq/kkfn5yjQ56XJQCUh5VdGxjHP6RL0/4h5q8qsXbBV1L
   hUHw6se96pnRvv+yglp25iVYP32iHvpX9PrfaWIrw+qfwH9KA5+VPG8wE
   5NQNsI7yKEbx/yUSRhZzbgSrV2LlCJBEJtTiAX19blXegv+9B1ARhieha
   IYj13TcATOWUp02CtCuYtPfA56U20EN92/+YGQ3mS2TavpMTHm6ie/FLz
   S7rnIwI3huyg7XUzwHdEUUuFcmPRaKD8EoBbfQN9zWSKQElMcWxmDNvrx
   A==;
X-CSE-ConnectionGUID: wAvP8NlTSG+ZHWC23DSHag==
X-CSE-MsgGUID: DcAYCYjNTbClWsDNb9N01Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="21205736"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="21205736"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 23:20:02 -0700
X-CSE-ConnectionGUID: Rudh3TqXSAeD6tWluQKebw==
X-CSE-MsgGUID: ERtoUNbCQxCR8WzVHqxSwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="56678918"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 23:20:00 -0700
Message-ID: <59eb2544-1c85-4fde-87be-4d97e1f0a246@linux.intel.com>
Date: Wed, 7 Aug 2024 14:19:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] iommu/vt-d: Always reserve a domain ID for
 identity setup
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-4-baolu.lu@linux.intel.com>
 <20240806170653.GL676757@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240806170653.GL676757@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/7 1:06, Jason Gunthorpe wrote:
> On Tue, Aug 06, 2024 at 10:39:37AM +0800, Lu Baolu wrote:
>> We will use a global static identity domain. Reserve a static domain ID
>> for it.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 723ea9f3f501..c019fb3b3e78 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>>   	 * entry for first-level or pass-through translation modes should
>>   	 * be programmed with a domain id different from those used for
>>   	 * second-level or nested translation. We reserve a domain id for
>> -	 * this purpose.
>> +	 * this purpose. This domain id is also used for identity domain
>> +	 * in legacy mode.
>>   	 */
>> -	if (sm_supported(iommu))
>> -		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
>> +	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
> That should probablyturn into an IDA someday, it would likely be more
> memory efficient than bitmap_zalloc()

I have tried to. But I failed to find a suitable ida interface to
calculate the count of allocated domain IDs to replace bitmap_weight()
in below code.

static ssize_t domains_used_show(struct device *dev,
                                  struct device_attribute *attr, char *buf)
{
         struct intel_iommu *iommu = dev_to_intel_iommu(dev);
         return sysfs_emit(buf, "%d\n",
                           bitmap_weight(iommu->domain_ids,
                                         cap_ndoms(iommu->cap)));
}
static DEVICE_ATTR_RO(domains_used);

Thanks,
baolu


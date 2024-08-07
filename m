Return-Path: <linux-kernel+bounces-277965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC8D94A8BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF501C21C47
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719ED1EA0BD;
	Wed,  7 Aug 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXo/A0Lb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99F61E7A4A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723037890; cv=none; b=jQLgOVJbLUqjhdmOu2wzmwS2xcU8EuOSNbJiKxznCVkMj07tRl/gCSs8E1GoT5HNgCr7tCHsOTHx4hDMeyMsB4MFhr5h5GiSDlUVb89+1BThThFInEDEKggokqKuK6xJvmaLmlTuhhaWVHVK6JsAgGyUrgAyURniJgnBA/wj/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723037890; c=relaxed/simple;
	bh=8E+5rwum8fVy4BEAqRKNZbtya7ZImyQ0RcqP3Uspdew=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AcyytIlPHy9mMxbkDRi3smncAP2H0xMxPWuxANmzC5bwTqKKc8ld9TKOQ69GVmS31f+lCj+k+SlEgoUHbFxarHtvl4AWmNatvdiEu8dYJJ+jVWa8/RoMP7i2eoSO3fRFE+DGUIdMrE60mmFUSoeCgeuLAbL/IEri9enpTBnZO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXo/A0Lb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723037888; x=1754573888;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8E+5rwum8fVy4BEAqRKNZbtya7ZImyQ0RcqP3Uspdew=;
  b=NXo/A0LbOfQDx+S+WwfYj6HDWiWex25+OBB9mpdi7IZTXt55yt5wMbLV
   AqPiCTv9p6dOPVMDkvSvQ7DfJ1ef0yMfPt6WvjIF15ai2mY60i/XO7S20
   zXqYNEg0RMaTA7FN1Ousb0PBVT2UN/px/d1Yi8vD06tuOF3zGzq/zKZy7
   9jnV+FDqO/SoJ5sx22TBkjtTXZgo+YldUW1QL9NP8inbJyH4w0KkppHkn
   av+1jECRrU9xZIBHVZfZVN5xpkYn3wmjGWA1NzU6EOkO0iurTWD4DLHrq
   8DB4wvYz53tbqNOHs4ssoZs++HE2xtvbWaqm3zaGcmfhWRs7GsPTgLqCH
   g==;
X-CSE-ConnectionGUID: W4jsmiNOQnSVw5Cn6vlbUw==
X-CSE-MsgGUID: eGdCG2UpSgWUQoIyHKkD2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="20920638"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="20920638"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:38:07 -0700
X-CSE-ConnectionGUID: 5PWdJycfQFWPmloguS5tDg==
X-CSE-MsgGUID: tnL82JK3RZS+CCuKL+HC0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="80103515"
Received: from menghaix-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 06:38:05 -0700
Message-ID: <d70c2de2-c0c9-49cb-bbc7-773fd615067f@linux.intel.com>
Date: Wed, 7 Aug 2024 21:38:02 +0800
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
 <59eb2544-1c85-4fde-87be-4d97e1f0a246@linux.intel.com>
 <20240807120913.GC8473@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240807120913.GC8473@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/7 20:09, Jason Gunthorpe wrote:
> On Wed, Aug 07, 2024 at 02:19:57PM +0800, Baolu Lu wrote:
>> On 2024/8/7 1:06, Jason Gunthorpe wrote:
>>> On Tue, Aug 06, 2024 at 10:39:37AM +0800, Lu Baolu wrote:
>>>> We will use a global static identity domain. Reserve a static domain ID
>>>> for it.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/intel/iommu.c | 6 +++---
>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index 723ea9f3f501..c019fb3b3e78 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -1440,10 +1440,10 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>>>>    	 * entry for first-level or pass-through translation modes should
>>>>    	 * be programmed with a domain id different from those used for
>>>>    	 * second-level or nested translation. We reserve a domain id for
>>>> -	 * this purpose.
>>>> +	 * this purpose. This domain id is also used for identity domain
>>>> +	 * in legacy mode.
>>>>    	 */
>>>> -	if (sm_supported(iommu))
>>>> -		set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
>>>> +	set_bit(FLPT_DEFAULT_DID, iommu->domain_ids);
>>> That should probablyturn into an IDA someday, it would likely be more
>>> memory efficient than bitmap_zalloc()
>> I have tried to. But I failed to find a suitable ida interface to
>> calculate the count of allocated domain IDs to replace bitmap_weight()
>> in below code.
> For something debugging like that just use
>    idr_for_each_entry()
>       count++;

Yeah! It works.

> It is a weird thing to put in sysfs in the first place...

Agreed. But it has been there for years. :-)

Thanks,
baolu


Return-Path: <linux-kernel+bounces-237172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8535791ED0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0341F21AF7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80586168A8;
	Tue,  2 Jul 2024 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsgOg2Lc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB538F72
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 02:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888387; cv=none; b=R5TRnrAX0LwutcNj5lGm0ym2qiF1y3IA7d21li73DDIUEDfYSPC/H33ZALkERH7yI0e0bbdn7qgBDYGBFgrSstSdCJJeYbNs9t6oAY7eV2NuIgv8mTAbM+uP6n/SwFWCfocZLionxTCIITTva2dF2USBOsofRMttsxHIrl5bDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888387; c=relaxed/simple;
	bh=RkJQYIkoIrzZKZ364yDgAnJtAxVNLliR1yNVFjmRBEI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aFY6mBj7yLngwD/th/uvJJvEmkKNaoL4D9wwzMcRJ3c/f8nMmDQiPChucDia9MI2K19j5H5KOWb50/o1lN6BOgQRxzvt4QBj405xNNixx8RjVnIHtXS0wYSz/BOe3wRrHR6FLjs5QOtmizAK12EImxAg6hr4L0LZEmU68hRWU3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsgOg2Lc; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719888386; x=1751424386;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RkJQYIkoIrzZKZ364yDgAnJtAxVNLliR1yNVFjmRBEI=;
  b=OsgOg2LckeRh7vWUHWfCSji/7M/vmSaiIp6j3TNx/gS6rVa3VxIGcric
   IGgBZZzDRtoO9yEWMaw5pG3JJJ04IylMW0ZLwIDuVo9NNw+4lUBMr0quC
   THyJ3hymEXh4w+1Qvv1UhQRaWX9PYBvbPMraWiL4ORpfvdUnxNeAfZF8b
   RP3FKb5Izq58NZ7cAl1HI4TzUTIqKwPHYKSFQSkaTr41pW2O4fkbQZf/L
   YJAm3yBnYBpv0bFDlbADoz5eKyG2h66Qor/6itjOhojCZHKnpfQXnIH9W
   MQD/BT8YgjYv3ulbQKVhNf9WRs/XEPHjCQApdRSgEb+fnqfjfnY7auZ3N
   g==;
X-CSE-ConnectionGUID: ohndHe+TRJucM6j1HIHt1w==
X-CSE-MsgGUID: NtJtSofKQxuV2Jzh75Aemw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="12349768"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="12349768"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 19:46:26 -0700
X-CSE-ConnectionGUID: k5dAhMTNRuWpYJib56uj7A==
X-CSE-MsgGUID: xCmr/RUkRXWXwL/IkrC8Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="76905817"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jul 2024 19:46:24 -0700
Message-ID: <5a8802e3-feda-49bf-b11b-2ba6c236305e@linux.intel.com>
Date: Tue, 2 Jul 2024 10:43:41 +0800
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
Subject: Re: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for context
 change
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
 <20240701112317.94022-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276502F9B5AB45EE9BF28628CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <14a7db3a-663a-4e3f-b29c-a733e98efc32@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <14a7db3a-663a-4e3f-b29c-a733e98efc32@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/2/24 9:47 AM, Baolu Lu wrote:
> On 7/2/24 9:11 AM, Tian, Kevin wrote:
>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>> Sent: Monday, July 1, 2024 7:23 PM
>>> +
>>> +    /*
>>> +     * For scalable mode:
>>> +     * - Domain-selective PASID-cache invalidation to affected domains
>>> +     * - Domain-selective IOTLB invalidation to affected domains
>>> +     * - Global Device-TLB invalidation to affected functions
>>> +     */
>>> +    if (flush_domains) {
>>> +        /*
>>> +         * If the IOMMU is running in scalable mode and there might
>>> +         * be potential PASID translations, the caller should hold
>>> +         * the lock to ensure that context changes and cache flushes
>>> +         * are atomic.
>>> +         */
>>> +        assert_spin_locked(&iommu->lock);
>>> +        for (i = 0; i < info->pasid_table->max_pasid; i++) {
>>> +            pte = intel_pasid_get_entry(info->dev, i);
>>> +            if (!pte || !pasid_pte_is_present(pte))
>>> +                continue;
>>> +
>>> +            did = pasid_get_domain_id(pte);
>>> +            qi_flush_pasid_cache(iommu, did,
>>> QI_PC_ALL_PASIDS, 0);
>>> +            iommu->flush.flush_iotlb(iommu, did, 0, 0,
>>> DMA_TLB_DSI_FLUSH);
>>> +        }
>>> +    }
>>> +
>>> +    __context_flush_dev_iotlb(info);
>>> +}
>> this only invalidates devtlb w/o PASID. We miss a pasid devtlb 
>> invalidation
>> with global bit set.
> 
> I am not sure about this. The spec says "Global Device-TLB invalidation
> to affected functions", I am not sure whether this implies any PASID-
> based-Device-TLB invalidation.

I just revisited the spec, Device-TLB invalidation only covers caches
for requests-without-PASID. If pasid translation is affected while
updating the context entry, we should also take care of the caches for
requests-with-pasid.

I will add below line to address this.

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 9a7b5668c723..91db0876682e 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -932,6 +932,7 @@ void intel_context_flush_present(struct 
device_domain_info *info,
                         did = pasid_get_domain_id(pte);
                         qi_flush_pasid_cache(iommu, did, 
QI_PC_ALL_PASIDS, 0);
                         iommu->flush.flush_iotlb(iommu, did, 0, 0, 
DMA_TLB_DSI_FLUSH);
+                       pasid_cache_invalidation_with_pasid(iommu, did, i);
                 }
         }

Thanks!

Best regards,
baolu


Return-Path: <linux-kernel+bounces-237258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 714BB91EDF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A30A1F23205
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F273BBE2;
	Tue,  2 Jul 2024 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1yZFs5E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220E83211
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719895879; cv=none; b=Y0GHYfAUqaP5l/eXDjOQAAcbGDlHc1YoBNlRIhFtrx3FZ6MUkB2vj955Ytw02KqFaNn2dD+roQJoTFxQ2ewnRY7MlyVaVS8AK+huGgJN0nTcWW6mTurPMnK1VpLu8KoQm5m3XaO1ckM/OgSv5TGFx80yt6S78FTtcVlU59AQjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719895879; c=relaxed/simple;
	bh=BgEqGKPBXNB8p6U6fNmzefzLImB1jpeu7knmRPeKL7Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UYTiSEmxGUeK1M6ptalCZ2b2AVchqA1ZPnuLkYcU56ne7lHiDlCFapg6T0wG3eQ/rtDjG4j6k2lIL9CNLV8OFW77bW+ZRCAixPkw8MFujSwxJeROnZoWncMX5llpJy4YSBTOE7RTfxRClx9kM5cJh5f25JrGskGwkM0acEIlOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1yZFs5E; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719895877; x=1751431877;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BgEqGKPBXNB8p6U6fNmzefzLImB1jpeu7knmRPeKL7Q=;
  b=C1yZFs5ECGe5msi5lRZOO0/j2NX9VO3PEv+c4zWcsAncehxrS7JM/Afm
   gRbrVTZyhb+r1/uXP5SF2mHv/3zFAUHYptimyJmW7BrK9w9GacnNNdBjR
   +JmLMMrC3MQwWRYVQjzzaeK/DNy6NgB/yDSqBcF2Fy4hfmcVNYG652Sgh
   VT470QlXiP7vTcFVF/V/2yf8auOrl4qFcJ7p/9QqFtcx9NjpIq1KpBWpN
   mgpjQbroCqnCxycCibd8YKsNrDpzy3F5ondH1eIEgHByb0adrjqJnLTSw
   beforetZhl0xoPUIkyzm/Kq0xvTl16hfKhsRLanf0QEcdWBsmBBUjRgu1
   w==;
X-CSE-ConnectionGUID: nuXXk8sVShSyvtxCBBdweQ==
X-CSE-MsgGUID: cjO95z15R2Ww64cKDdOMPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="27671510"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27671510"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:51:16 -0700
X-CSE-ConnectionGUID: sx5Ip4NYRuK3REUZty9ASg==
X-CSE-MsgGUID: 2hg9bg/wQQOP7/yQgCBVPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76935222"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:51:14 -0700
Message-ID: <1c9204d9-d9da-4785-b375-368b5ba9ec78@linux.intel.com>
Date: Tue, 2 Jul 2024 12:51:12 +0800
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
 <5a8802e3-feda-49bf-b11b-2ba6c236305e@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5a8802e3-feda-49bf-b11b-2ba6c236305e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/7/2 10:43, Baolu Lu wrote:
> On 7/2/24 9:47 AM, Baolu Lu wrote:
>> On 7/2/24 9:11 AM, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Monday, July 1, 2024 7:23 PM
>>>> +
>>>> +    /*
>>>> +     * For scalable mode:
>>>> +     * - Domain-selective PASID-cache invalidation to affected domains
>>>> +     * - Domain-selective IOTLB invalidation to affected domains
>>>> +     * - Global Device-TLB invalidation to affected functions
>>>> +     */
>>>> +    if (flush_domains) {
>>>> +        /*
>>>> +         * If the IOMMU is running in scalable mode and there might
>>>> +         * be potential PASID translations, the caller should hold
>>>> +         * the lock to ensure that context changes and cache flushes
>>>> +         * are atomic.
>>>> +         */
>>>> +        assert_spin_locked(&iommu->lock);
>>>> +        for (i = 0; i < info->pasid_table->max_pasid; i++) {
>>>> +            pte = intel_pasid_get_entry(info->dev, i);
>>>> +            if (!pte || !pasid_pte_is_present(pte))
>>>> +                continue;
>>>> +
>>>> +            did = pasid_get_domain_id(pte);
>>>> +            qi_flush_pasid_cache(iommu, did,
>>>> QI_PC_ALL_PASIDS, 0);
>>>> +            iommu->flush.flush_iotlb(iommu, did, 0, 0,
>>>> DMA_TLB_DSI_FLUSH);
>>>> +        }
>>>> +    }
>>>> +
>>>> +    __context_flush_dev_iotlb(info);
>>>> +}
>>> this only invalidates devtlb w/o PASID. We miss a pasid devtlb 
>>> invalidation
>>> with global bit set.
>>
>> I am not sure about this. The spec says "Global Device-TLB invalidation
>> to affected functions", I am not sure whether this implies any PASID-
>> based-Device-TLB invalidation.
> 
> I just revisited the spec, Device-TLB invalidation only covers caches
> for requests-without-PASID. If pasid translation is affected while
> updating the context entry, we should also take care of the caches for
> requests-with-pasid.
> 
> I will add below line to address this.
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 9a7b5668c723..91db0876682e 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -932,6 +932,7 @@ void intel_context_flush_present(struct 
> device_domain_info *info,
>                          did = pasid_get_domain_id(pte);
>                          qi_flush_pasid_cache(iommu, did, 
> QI_PC_ALL_PASIDS, 0);
>                          iommu->flush.flush_iotlb(iommu, did, 0, 0, 
> DMA_TLB_DSI_FLUSH);
> +                       pasid_cache_invalidation_with_pasid(iommu, did, i);

Should be

	devtlb_invalidation_with_pasid(iommu, info->dev, i);

Sorry for the typo.

Best regards,
baolu


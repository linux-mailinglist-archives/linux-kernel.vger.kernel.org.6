Return-Path: <linux-kernel+bounces-363047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7E899BD49
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE9A1C21530
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C5112B71;
	Mon, 14 Oct 2024 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DR9/Piwp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC28F9D9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869110; cv=none; b=XImCLvkM4lWH55uEJaIe/6lpLz9nZXgslbpe5QFfD4eU6RLEcyRv6WAcoTw++21Q0IqPx74zcirum6C40ye02cdGn5G3LUxe3OmT5x1yDJtmAccLuXit5u9qvfD0OR7oA/Ed+OyAkaqU3syJ2w4S7nVbwXG8yPM6fz7epMIs5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869110; c=relaxed/simple;
	bh=/UGDAC+4PK1ck+fBKjjaMv0EW+NPqEfMx+m4dWl/y/g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t+xq0w9cMQ7XfnMuav3MRQ4CLtkD4vQbus8MgoHRuLiX5uEq5gyyzBbHuDMdf4KK3SXwLdG4/udWeCYPk+qLPYUWIY6CxJABfQAv1b04PlM0GLStI4o2VUfRHlc0JOSViQxjsAKxtTRDB+YmlTq5YNnyUedLiM4BvYUqYd9Q+NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DR9/Piwp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728869108; x=1760405108;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/UGDAC+4PK1ck+fBKjjaMv0EW+NPqEfMx+m4dWl/y/g=;
  b=DR9/Piwp9GCmnIrS7628fEwxs3R66gJpPcPw/d5wAmryUD5k0Zs3TicO
   1Xz7MHNQs0kXaWthNszrHX9+yLtEdOurBZgxN+jMGLukVjDu8H9Bl4gXl
   C8OpzrY276mJdEBJeT9qeUh5jgABqMnLFiIbDLooLYf2z/SC+bj0/btaV
   gAsp5Lkj4LSvC4pg3+7UexPkHE3jn5mpkOUGyzgNpPpCkxFovj7eTh7nU
   3O2wFeSZF+7sabrpet/Le59aHkFzshK7+H22X54Ap1DLybHGzRBY2dUH3
   +LnBUWAfqWz7slWNY1lhIvIUGo0B5rY5qHKSXx8UYFEn1B+b3cl1NchSU
   Q==;
X-CSE-ConnectionGUID: 4XYGdq9IQ9+PycRa1BqoSQ==
X-CSE-MsgGUID: Uj0lquRkSJeLnkv7VpKF2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="38847169"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="38847169"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:25:08 -0700
X-CSE-ConnectionGUID: ynU1ahT2T1amC3rS/YcacQ==
X-CSE-MsgGUID: qCjarkRsQHu5eA7haGiJyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="81420591"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:25:06 -0700
Message-ID: <7f829e9e-5db9-4861-8a58-27a57edbd9da@linux.intel.com>
Date: Mon, 14 Oct 2024 09:25:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iommu/vt-d: Enhance compatibility check for paging
 domain attach
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-4-baolu.lu@linux.intel.com>
 <20241011162703.GL762027@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241011162703.GL762027@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/12 0:27, Jason Gunthorpe wrote:
> On Fri, Oct 11, 2024 at 12:27:18PM +0800, Lu Baolu wrote:
> 
>> @@ -1623,27 +1623,15 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>>   
>>   	copied_context_tear_down(iommu, context, bus, devfn);
>>   	context_clear_entry(context);
>> -
>>   	context_set_domain_id(context, did);
>>   
>> -	/*
>> -	 * Skip top levels of page tables for iommu which has
>> -	 * less agaw than default. Unnecessary for PT mode.
>> -	 */
>> -	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
>> -		ret = -ENOMEM;
>> -		pgd = phys_to_virt(dma_pte_addr(pgd));
>> -		if (!dma_pte_present(pgd))
>> -			goto out_unlock;
>> -	}
> 
> Yikes, this is nasty racy stuff, glad to see it go
> 
> But should the agaw stuff be in its own patch?

The agaw stuff is now in the paging domain allocation path.

'agaw' represents the levels that the page table could support. With the
domain allocation callbacks always have a valid device pointer, the page
table levels of a domain could be determined during allocation.

When the domain is attached to a new device, the domain's levels will be
checked again the iommu capabilities of the device. If the iommu is not
capable of supporting the page levels, -EINVAL (not compatible) will be
returned, suggesting that the caller should use a new domain for the
device.

> 
>> @@ -3506,27 +3483,26 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
>>   	if (domain->dirty_ops && !ssads_supported(iommu))
>>   		return -EINVAL;
>>   
>> -	/* check if this iommu agaw is sufficient for max mapped address */
>> -	addr_width = agaw_to_width(iommu->agaw);
>> -	if (addr_width > cap_mgaw(iommu->cap))
>> -		addr_width = cap_mgaw(iommu->cap);
>> -
>> -	if (dmar_domain->max_addr > (1LL << addr_width))
>> +	if (dmar_domain->iommu_coherency !=
>> +			iommu_paging_structure_coherency(iommu))
>>   		return -EINVAL;
>> -	dmar_domain->gaw = addr_width;
>> -
>> -	/*
>> -	 * Knock out extra levels of page tables if necessary
>> -	 */
>> -	while (iommu->agaw < dmar_domain->agaw) {
>> -		struct dma_pte *pte;
>> -
>> -		pte = dmar_domain->pgd;
>> -		if (dma_pte_present(pte)) {
>> -			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
>> -			iommu_free_page(pte);
>> -		}
>> -		dmar_domain->agaw--;
>> +
>> +	if (domain->type & __IOMMU_DOMAIN_PAGING) {
> 
> It looks like this entire function is already never called for
> anything but paging?
> 
> The only three callers are:
> 
> 	.default_domain_ops = &(const struct iommu_domain_ops) {
> 		.attach_dev		= intel_iommu_attach_device,
> 		.set_dev_pasid		= intel_iommu_set_dev_pasid,
> 
> and
> 
> static const struct iommu_domain_ops intel_nested_domain_ops = {
> 	.attach_dev		= intel_nested_attach_dev,
> 
> And none of those cases can be anything except a paging domain by
> definition.

A nested domain is not a paging domain. It represents a user-space page
table that nested on a parent paging domain. Perhaps I overlooked
anything?

> 
> So this if should go away, or be turned into a WARN_ON.
> 
> Jason

Thanks,
baolu


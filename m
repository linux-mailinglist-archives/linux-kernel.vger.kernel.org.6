Return-Path: <linux-kernel+bounces-201676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9508FC1A8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 04:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE6C1C22B43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6756BFC0;
	Wed,  5 Jun 2024 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EsY/6fza"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8BC6BB5C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 02:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717553963; cv=none; b=JQfUUYumvlJDJ6rRjNoVpVDXex2TkwttUO8xr1YVVZlaxfnW5exawe/3WWmwp8OvvpLK+Yx+FbL0KBMkmXoA25zEbCsCpuAB6ogcyyVAB2BPMh2uQvF4n6Mm0i/Ze1VZmXBtydy6Wl97aKaqfb90d7jn+YUmyupovjNvC0HT7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717553963; c=relaxed/simple;
	bh=ltMu19Jhp3GbFGcA2fm3gdSE2xNB69BJvpou5y05Rk8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a7MJVhAbengGfGu5jQSgZA5qWJC1BUlhQLiy/YT/uQztpuhSH8cX2JN1mE/xYJvq1fDQGF6eUcNzQNYftUKRwR4czubrSSXPu0KO5BDJFe1MXDy5BWmmqRfj3uqHPDKOT3ji17fggLNpXxxuwno89RQw/VYxJGzWPbA79CNPeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EsY/6fza; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717553962; x=1749089962;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ltMu19Jhp3GbFGcA2fm3gdSE2xNB69BJvpou5y05Rk8=;
  b=EsY/6fzaMWkSmjhHdNv2B4XTAWVCCnUEWM9vq9n8PU+YekD29ejItSQI
   dnF1EchuccLzHXMRrBwuhtJZ8nf32wCOwoVZdbkQc9eS09OywbM5WBaw1
   oAbF1hurZo2Z/iJ8v9/XhCrqn3/Hg1CUvS0fRGb3FqAM5BACWGEl5VeQS
   bvX5QB8g5tUYgWnz4K5sO/tOG3izWf8W6QzW5S0tUoZMhbNs5pjV8lgHk
   zG4ViZW9B2ZRcL0kdOU36VvjA68ugRgrgUYcmDpIhgAjBvcJSsLdxc2l7
   UBWeSd3E4tzhhhps2AkcmAu8BZWDavM5mcg426nvKVzKFDJ/GKnXj4gmW
   Q==;
X-CSE-ConnectionGUID: pCXJ6F5YSvOqYfEO2q8dMA==
X-CSE-MsgGUID: R0yBtEzSTE2Qdb/XTDaBsw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13943658"
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="13943658"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 19:19:21 -0700
X-CSE-ConnectionGUID: FGVrFuVIQBaxMHhZMYR1kQ==
X-CSE-MsgGUID: graUDyw+RrSGOo9FPK/s4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,215,1712646000"; 
   d="scan'208";a="42545124"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 04 Jun 2024 19:19:16 -0700
Message-ID: <02e88f89-a277-433d-9ccc-af4318a8e80f@linux.intel.com>
Date: Wed, 5 Jun 2024 10:17:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/22] iommufd: Use iommu_user_domain_alloc()
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-3-baolu.lu@linux.intel.com>
 <20240604165145.GD21513@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240604165145.GD21513@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 12:51 AM, Jason Gunthorpe wrote:
> On Tue, Jun 04, 2024 at 09:51:14AM +0800, Lu Baolu wrote:
>> Replace iommu_domain_alloc() with iommu_user_domain_alloc().
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommufd/hw_pagetable.c | 20 +++++---------------
>>   1 file changed, 5 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
>> index 33d142f8057d..ada05fccb36a 100644
>> --- a/drivers/iommu/iommufd/hw_pagetable.c
>> +++ b/drivers/iommu/iommufd/hw_pagetable.c
>> @@ -127,21 +127,11 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>>   	hwpt_paging->ioas = ioas;
>>   	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
>>   
>> -	if (ops->domain_alloc_user) {
>> -		hwpt->domain = ops->domain_alloc_user(idev->dev, flags, NULL,
>> -						      user_data);
>                                                       ^^^^^^^^^^^^
> 
>> -		if (IS_ERR(hwpt->domain)) {
>> -			rc = PTR_ERR(hwpt->domain);
>> -			hwpt->domain = NULL;
>> -			goto out_abort;
>> -		}
>> -		hwpt->domain->owner = ops;
>> -	} else {
>> -		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
>> -		if (!hwpt->domain) {
>> -			rc = -ENOMEM;
>> -			goto out_abort;
>> -		}
>> +	hwpt->domain = iommu_user_domain_alloc(idev->dev, flags);
>> +	if (IS_ERR(hwpt->domain)) {
> 
> Where did the user_data go???

The user_data is not used in allocating a paging user domain, so I
skipped it.

> 
> If you are going to wrapper the op function then all the args need to
> be provided.

Yes. Agreed.

> I'm not sure there is value in having vfio and vdpa call this
> variation since they won't pass a user_data or flags?
> 
> Do you imagine there will ever be a difference between what
> domain_alloc_user(dev, 0, NULL, NULL) returns from
> domain_alloc_paging(dev) ?

No.

> 
> That seems like questionable driver behavior to me.

In my first try, I simply replaced iommu_domain_alloc() with a new
paging domain allocation interface. On second thought, it occurred to me
why not use separate interfaces for different purposes? Even though from
an iommu perspective, they both use paging domains.

The @flags and @user_data are defined in uapi/linux/iommufd.h, which is
specific to iommufd. Wrapping them in a common interface for broader use
seems awkward.

So, perhaps we could return to my original idea? Let's just expose one
interface, iommu_paging_domain_alloc(), and replace iommu_domain_alloc()
with it everywhere?

Best regards,
baolu


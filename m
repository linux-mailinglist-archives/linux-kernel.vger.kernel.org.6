Return-Path: <linux-kernel+bounces-175904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B557C8C26E0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D5F1F24B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05E517088F;
	Fri, 10 May 2024 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVaBOVNp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA28F48
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351418; cv=none; b=JNJstT503lQHRp8YUHb+zLt1Q4AgEWifOP8lr0UM3N18qQyQKqtQIAcymhqP39r+0pAh3t7jz3V86pwjanmHVqSiGlzFUQkMp0hU18vKFAMEM8CkIqg2R/e6/XIhdXYlm73aplB09nORgp2GM39PUKXWShegPNfHj1FIeaz6u74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351418; c=relaxed/simple;
	bh=LIbQqBfXiUQWjgKPgqrUUa+UphuLCLU3qDB80BDLpXQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U2tUNvNJtgP8NYorNZrqoriaMejWhXvkjHErcd5yhCN8zhvp9HB8PFYQ5Uf1WUTV/MBURuTfp0Uq1uWjXdc8jBedgFJL4K4lk60M6+xmzDCnqZniEuzTLv8PXBBPzQLoOwMFAg8UAlqiBBwnEcEipa0c08NpP8OenKJpzrDjqOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVaBOVNp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715351416; x=1746887416;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LIbQqBfXiUQWjgKPgqrUUa+UphuLCLU3qDB80BDLpXQ=;
  b=VVaBOVNpjmoBoUxSUc8zAJ5Hxffw9VdojOR/Mrsy+D9VD9zsewPfxMFl
   V4uO7EbEq9RaAzuv2q2p8u1BgxYI/rX9eLb4ktAZL9EShfdB5dJ/WVoRc
   NrNPiVUAnTrZqVSIG6ERhk2U/hsjERZ/vpROmcfuWiuxfMyyVm/ByvX0E
   0OGGoqYkwVih4vhvb7Ev2Q7VG6zuUrWOZJBMxd50dvhAY0EhliKi4BPH5
   1oYXis86LUrfmnWezKzeEx/OUnQqSJ82UuFfGuZ4MwBPr/6pw9EoqEGIU
   3gDYCYOa1BWGl5oVDsycEmgZwjjxNi9gPaTwCw7OnZcMWsgrIlFhzbf6u
   Q==;
X-CSE-ConnectionGUID: A/mb9hbOQ1iaQ9IVEeBL+A==
X-CSE-MsgGUID: geQeREXiR4+Q9QifBs0Xug==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11183760"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="11183760"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:30:16 -0700
X-CSE-ConnectionGUID: HTI9vF/7RI2VfKszHrCNuw==
X-CSE-MsgGUID: WxrUp9inRAi5T4Vg+dNe/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="34147847"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:30:14 -0700
Message-ID: <0de7c71f-571a-4800-8f2b-9eda0c6b75de@linux.intel.com>
Date: Fri, 10 May 2024 22:30:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
 <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
 <20240510133824.GW4718@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240510133824.GW4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/10 21:38, Jason Gunthorpe wrote:
> On Fri, May 10, 2024 at 11:14:20AM +0800, Baolu Lu wrote:
>> On 5/8/24 8:04 AM, Jason Gunthorpe wrote:
>>> On Tue, Apr 30, 2024 at 10:57:04PM +0800, Lu Baolu wrote:
>>>> @@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>>>>    	if (group == &abort_group)
>>>>    		goto err_abort;
>>>> -	group->domain = get_domain_for_iopf(dev, fault);
>>>> -	if (!group->domain)
>>>> +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
>>>> +	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
>>>> +		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);
>>> That seems a bit weird looking?
>> Agreed.
>>
>>> get_attach_handle_for_iopf(dev,
>>>      (fault->prm.flags &
>>>      IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ? fault->prm.pasid : IOMMU_NO_PASID,
>>>      group);
>> The logic here is that it tries the PASID domain and if it doesn't
>> exist, then tries the RID domain as well. I explained this in the commit
>> message:
>>
>> "
>> ... if the pasid table of a device is wholly managed by user space,
>> there is no domain attached to the PASID of the device ...
>> "
> Okay, it needs a comment in the code, and the RID fallback should be
> based aroudn checking for a NESTING domain type which includes the
> PASID table. (ie ARM and AMD not Intel)
It appears that Intel is just special. ARM, AMD, and RISC-V all support
a NESTING domain which includes the PASID table. So, how about defining
a special NESTING domain type for Intel? Like this,

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 35ae9a6f73d3..09b4e671dcee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -173,6 +173,8 @@ struct iommu_domain_geometry {

  #define __IOMMU_DOMAIN_NESTED  (1U << 6)  /* User-managed address 
space nested
                                               on a stage-2 translation 
       */
+#define __IOMMU_DOMAIN_PASID   (1U << 7)  /* User-managed domain for a
+                                             specific PASID*/

  #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
  /*
@@ -204,6 +206,9 @@ struct iommu_domain_geometry {
  #define IOMMU_DOMAIN_SVA       (__IOMMU_DOMAIN_SVA)
  #define IOMMU_DOMAIN_PLATFORM  (__IOMMU_DOMAIN_PLATFORM)
  #define IOMMU_DOMAIN_NESTED    (__IOMMU_DOMAIN_NESTED)
+#define IOMMU_DOMAIN_NESTED_PASID                              \
+                               (__IOMMU_DOMAIN_NESTED |        \
+                                __IOMMU_DOMAIN_PASID)

And current IOMMU_DOMAIN_NESTED domain type is just for a nesting domain
with PASID table.

The Intel IOMMU driver will convert to use IOMMU_DOMAIN_NESTED_PASID in
the PASID interface series.

> We shouldn't just elevate a random PASID to the RID if it isn't
> approprite..

If above propose looks good to you, then I just need to add a domain
type check before RID fallback.

Best regards,
baolu


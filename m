Return-Path: <linux-kernel+bounces-245088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC2B92AE11
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 04:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D22282C48
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7CF3A267;
	Tue,  9 Jul 2024 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QW6bfgDJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB643AB4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720491225; cv=none; b=UyJoz3Q/fj1YpH951mFX1Ik8dM1t39oKoN9/8mcqlb3I9nfHkgEkh4NN3q8Nm9+OPSfp0HtbGLwOCw4fP8bqd5KOxtRGZxdOThp30MdnONUYdTw4/dtvlW1AsRI/i1uEjzbaEmbfpDFG3ga4gQmtmbIKOVgaUQIV2/tRd40p2So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720491225; c=relaxed/simple;
	bh=qmfe73rj7uPFO7PgvLZEQThh1iERDsTRnG6XRTqML+c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XniVQ0zT582l17HUiKC++l32d4SFciGf+RJ9ANb/EQaCSurc+Q39EQ9qE3bz0y5xnlIY7rYSVaVj2x9KRwhLuO+eaLewgykNBexMMpg7CV7l5iwVjJ+0jdqMm4v8RjmZZbXS8Wt5aZYCOEWX7cH27dlJHF4KpqTfCZ/JarycuIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QW6bfgDJ; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720491224; x=1752027224;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qmfe73rj7uPFO7PgvLZEQThh1iERDsTRnG6XRTqML+c=;
  b=QW6bfgDJ9zu1GSu/Vhjq8NDRjN2OmjJTqgHF3lknRZAGaCwVvXxln4ND
   4a1BtjTK9O9s4809LzuunswiY6fF+ckgPsjZaReGwL7ypVBoR4+LWnf7z
   SgJ/7Ttmi5l5Nbg8tSTBvfuEDWwe0dpJjoeyfQRlD2LT7E+H7m/LQnjv8
   pOlfBiyjIPEacnP3Hyyi2GmkQ8PMByb+ZUYOO6jxegKRgAc/m7Vbp2ukg
   ecNP/bFHm7Qc9qz729wLJrvbpfzQ6DWtFK569T5NRQYrCFjZIQtmeoe6U
   wqX7KIa5fDhUn+WH4gtK0132vKSItklb1JtAN5mbqA6TMhwzPVsU/Q0d3
   w==;
X-CSE-ConnectionGUID: CmBAvXmCQZqY14jy0DFBgQ==
X-CSE-MsgGUID: OwI1PYMhTZSsF9eXko5lEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17824232"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="17824232"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 19:13:42 -0700
X-CSE-ConnectionGUID: d5zKqABkTUWp4MS7DXpD4g==
X-CSE-MsgGUID: AnVNl0FXQyWJ4eCG+5lDGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52100309"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jul 2024 19:13:33 -0700
Message-ID: <56911ed6-d819-4882-9c7e-bfe4ba5826c2@linux.intel.com>
Date: Tue, 9 Jul 2024 10:10:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 catalin.marinas@arm.com, kernel-team@android.com, Yi Liu
 <yi.l.liu@intel.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Kalle Valo <kvalo@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/21] iommu: Refactoring domain allocation interface
To: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <172009858593.2049787.5200500337719932334.b4-ty@kernel.org>
 <20240708163407.GC14050@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240708163407.GC14050@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 12:34 AM, Jason Gunthorpe wrote:
> On Thu, Jul 04, 2024 at 03:18:56PM +0100, Will Deacon wrote:
>> On Mon, 10 Jun 2024 16:55:34 +0800, Lu Baolu wrote:
>>> The IOMMU subsystem has undergone some changes, including the removal
>>> of iommu_ops from the bus structure. Consequently, the existing domain
>>> allocation interface, which relies on a bus type argument, is no longer
>>> relevant:
>>>
>>>      struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>>>
>>> [...]
>> Applied a few of these to iommu (iommufd/paging-domain-alloc), thanks!
>>
>> [01/21] iommu: Add iommu_paging_domain_alloc() interface
>>          https://git.kernel.org/iommu/c/a27bf2743cb8
>> [02/21] iommufd: Use iommu_paging_domain_alloc()
>>          https://git.kernel.org/iommu/c/26a581606fab
>> [03/21] vfio/type1: Use iommu_paging_domain_alloc()
>>          https://git.kernel.org/iommu/c/60ffc4501722
>> [04/21] vhost-vdpa: Use iommu_paging_domain_alloc()
>>          https://git.kernel.org/iommu/c/9c159f6de1ae
>> [05/21] drm/msm: Use iommu_paging_domain_alloc()
>>          https://git.kernel.org/iommu/c/45acf35af200
>>
>> [10/21] wifi: ath10k: Use iommu_paging_domain_alloc()
>>          https://git.kernel.org/iommu/c/d5b7485588df
>> [11/21] wifi: ath11k: Use iommu_paging_domain_alloc()
>>          https://git.kernel.org/iommu/c/ef50d41fbf1c
>>
>> [14/21] RDMA/usnic: Use iommu_paging_domain_alloc()
>>          https://git.kernel.org/iommu/c/3b10f25704be
>> [15/21] iommu/vt-d: Add helper to allocate paging domain
>>          https://git.kernel.org/iommu/c/9e9ba576c259
> Great, Lu can you please split the remaining by subsystem and try to
> get them to go through subsystem trees? Joerg can take the leftovers
> at rc6/7 or something like that so we can finish this.

Yes, sure. I guess I need to wait until 6.11-rc1 is out. It's a bit late
in the cycle for the subsystem trees to accept brand new changes.

> I think this is enough that Intel and AMD could now assert that dev is
> non-null?

Yes.

Thanks,
baolu


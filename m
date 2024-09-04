Return-Path: <linux-kernel+bounces-314829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFA796B9A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDDAA2824E4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5FC1CF7CC;
	Wed,  4 Sep 2024 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNTtsFDU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186EE126C01
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448050; cv=none; b=Z/8tuPSbs5vHhky6x7QFFopWaHuMf1Qhv7NachMbr9oPBVYaft3gL5fUtp6Qxctmhc0QUmgH4WxJPfvnLNfGZI+Zt8OX5gvaWr8MIyjhFMvKD4yMJH5znGKB0YOZrLU2h+CYD++5GMLmIMnCC242tV08I0Q7k271jYsvlwTmutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448050; c=relaxed/simple;
	bh=eDTMmqHcKakV+eu5KMZsB8ghVe3220P8EhKpBMiK70k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lTYOWYFFt1W5KjIrrcSpxmMoLCXsGPuLYJPxItq4Tm9fG4Lx0e9I1EID9jIrhOslFpUB2wZDzx26aH5Q4pvds5CVH+qMrpOVPg2WnHDGChIwLh7SkRMP7DS4O34t7Khw4E43tUZNxL/vgYBkTs9zfxf8wJhAxaXDGOiHLXW5xho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNTtsFDU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725448047; x=1756984047;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eDTMmqHcKakV+eu5KMZsB8ghVe3220P8EhKpBMiK70k=;
  b=HNTtsFDU5ngnb5aLnd1546T2SISvsVQXKfmTdSStMBukVIVw3Qr3/EVH
   cFqWLW8qCwD6NNAC2/QRya6sQxs4pML8lqGxW+kb6V2TDU6PExMPBEnVP
   uweibmI3QT8swfgJ8r0+f7XfSmC+gzJ5jTVJIdzaK+MCwNd7XgMIOfTFq
   GsMdvaHtdpp5Ty5ZDJMRMlU9rvvgLvgef3gakUK/ZeheIaKxorBYOp/Ke
   BP/pUfo1uwY69LqhAZy3ASA+ZDo26GeSuC+NfoKciSicZAzEnRBj5mpjg
   8h6oHUZgMdBrI3ljxrEm2HriZJ5bcvupR1XImkEXabubLgsHmzNSIT2mc
   g==;
X-CSE-ConnectionGUID: dO+or9c6Qf6jfgjSonehfg==
X-CSE-MsgGUID: MsJbcnxYQ5iYjRrBLsq9+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34762750"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="34762750"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:07:25 -0700
X-CSE-ConnectionGUID: O3hIF7RmTs+KegW31R2H1w==
X-CSE-MsgGUID: AR30nyffTYOGBbqbEKp/Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="69865844"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 04:07:22 -0700
Message-ID: <c94d1463-4710-41fa-9936-fca1a0c2a275@linux.intel.com>
Date: Wed, 4 Sep 2024 19:07:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Klaus Jensen <its@irrelevant.dk>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH RFC PREVIEW 1/6] iommu/vt-d: Separate page request queue
 from SVM
To: Joel Granados <j.granados@samsung.com>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
 <20240826-iopf-for-all-v1-1-59174e6a7528@samsung.com>
 <CGME20240826130923eucas1p285627a5a210e62fbb0187962b1f8dde5@eucas1p2.samsung.com>
 <242056a5-9d16-415a-9913-0add5b050f47@linux.intel.com>
 <20240904091223.f3olpzrv5lkgekfe@joelS2.panther.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240904091223.f3olpzrv5lkgekfe@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/4 17:12, Joel Granados wrote:
> On Mon, Aug 26, 2024 at 09:09:14PM +0800, Baolu Lu wrote:
>> On 2024/8/26 19:40, Klaus Jensen wrote:
>>> From: Joel Granados<j.granados@samsung.com>
>>>
>>> IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM. Move
>>> all Page Request Queue (PRQ) functions that handle prq events to a new
>>> file in drivers/iommu/intel/prq.c. The page_req_des struct is made
>>> available in drivers/iommu/intel/iommu.h.
>>>
>>> No functional changes are intended. This is a preparation patch to
>>> enable the use of IO page faults outside the SVM and nested use cases.
>>>
>>> Signed-off-by: Joel Granados<j.granados@samsung.com>
>>> ---
>>>    drivers/iommu/intel/Makefile |   2 +-
>>>    drivers/iommu/intel/iommu.c  |  18 +--
>>>    drivers/iommu/intel/iommu.h  |  40 +++++-
>>>    drivers/iommu/intel/prq.c    | 290 ++++++++++++++++++++++++++++++++++++++++
>>>    drivers/iommu/intel/svm.c    | 308 -------------------------------------------
>>>    5 files changed, 331 insertions(+), 327 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
>>> index c8beb0281559..d3bb0798092d 100644
>>> --- a/drivers/iommu/intel/Makefile
>>> +++ b/drivers/iommu/intel/Makefile
>>> @@ -1,6 +1,6 @@
>>>    # SPDX-License-Identifier: GPL-2.0
>>>    obj-$(CONFIG_DMAR_TABLE) += dmar.o
>>> -obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o
>>> +obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o prq.o
>>>    obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
>>>    obj-$(CONFIG_DMAR_PERF) += perf.o
>>>    obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
>> Thanks for the patch! Now that IOPF is separate from SVA, the Kconfig
>> needs to be updated accordingly.
>>
>> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
>> index f52fb39c968e..2888671c9278 100644
>> --- a/drivers/iommu/intel/Kconfig
>> +++ b/drivers/iommu/intel/Kconfig
>> @@ -15,6 +15,7 @@ config INTEL_IOMMU
>>           select DMA_OPS
>>           select IOMMU_API
>>           select IOMMU_IOVA
>> +       select IOMMU_IOPF
> This will force IOMMU_IOPF when INTEL_IOMMU is selected. You do this in
> order to use IOPF if available, but it wont conflict with Intel IOMMU's
> that do not support IOPF. right?

Intel VT-d includes a bit in the capability registers that indicates
whether PRI is supported by the hardware. Therefore, there should be no
conflict.

Thanks,
baolu


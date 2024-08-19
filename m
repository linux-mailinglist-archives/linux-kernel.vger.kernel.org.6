Return-Path: <linux-kernel+bounces-291473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E12956310
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 07:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF13282A6D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212614A4F7;
	Mon, 19 Aug 2024 05:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgISst9n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBA614659F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 05:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724044551; cv=none; b=qalIOI8s/LfRYtf/8ObaoC+0ii31rIVUkwKnqW2oUQogVtKN4fK6N8uFwJ4FMLj2efGn9XpCFQ2idukU1YJURLIPS90FBtqrRzSXkTPgnNMCy8SlsA/RIZqbhHQ6fhs5THmomBnDhtfjaZTBq/HXKp4JOMZHismO4vDOB6vv3R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724044551; c=relaxed/simple;
	bh=FH84NqXMmYQxct+pNbHOTikAc9M2DCQnAN/tLhxOfpI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bUkpKWgEbv+eaDM7WCayaOGM4SMw07SnhICYu9KbKIPUy3Qfg/ASa/bTrbK8EUr381LMWtd/PTpQUdMImQ/DWa2QiYgZ0ZXEFOoz5Z6FiGGLKWVtx3HJskLaPmRkDSyzWoHy107SInR6uuFdrEf0lj3F9blf4OpDCnOHRQlbJ80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgISst9n; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724044550; x=1755580550;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FH84NqXMmYQxct+pNbHOTikAc9M2DCQnAN/tLhxOfpI=;
  b=FgISst9naa81BuZN/FexWz0gUiKFfeFWM7tpFUH2HhvlTgsMAkcReN7s
   W9DkPNVBIIiphjRcR2xNEUiqYiA8QjBA6uyXcIBm+uamu4ChrCyve1TNN
   xKcXV0Q55oldTFa+vnP0Nl5c4Bo3rZsHStonzmiRpauxUqJzMZoKrllob
   efyRgxGKm3J39zP477qSPTfwluuJIiHf+OTD+SUkI/QEhSixa3H1s7TYK
   e1F9+LcF6qv1sbxt50zRCmHhpDis/pR7+geZAFxZsq+GC5xlek+YtXdX/
   CMFvdz2Qb47Ts1s1bgdU64xUeX1dYZSUZT7/bPg29mCwb1sxD4KYl6q0/
   A==;
X-CSE-ConnectionGUID: xXmGkqmdSKChS3k+iBVFjA==
X-CSE-MsgGUID: ykSi/4c5QI+hKv+AquIFuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="21808862"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="21808862"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 22:15:49 -0700
X-CSE-ConnectionGUID: v32yweszTM+YyGfGKx5NBw==
X-CSE-MsgGUID: cWYyih86S8SyR2XYfoTZ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="90993163"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 22:15:47 -0700
Message-ID: <eb58cbad-1f28-480b-9b46-76d6d0c8b62b@linux.intel.com>
Date: Mon, 19 Aug 2024 13:15:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <511f140b-2792-47b0-b366-cbbad6e80239@intel.com>
 <3631c0ca-4c8d-4cef-aa40-13e3acd22123@linux.intel.com>
 <580e0907-cd58-45d3-8ba8-7344e5644354@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <580e0907-cd58-45d3-8ba8-7344e5644354@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/8/19 12:51, Yi Liu wrote:
> On 2024/8/19 11:34, Baolu Lu wrote:
>> On 2024/8/19 11:14, Yi Liu wrote:
>>> On 2024/8/16 18:49, Lu Baolu wrote:
>>>> Currently, PCI PASID is enabled alongside PCI ATS when an iommu 
>>>> domain is
>>>> attached to the device and disabled when the device transitions to 
>>>> block
>>>> translation mode. This approach is inappropriate as PCI PASID is a 
>>>> device
>>>> feature independent of the type of the attached domain.
>>>>
>>>> Enable PCI PASID during the IOMMU device probe and disables it 
>>>> during the
>>>> release path.
>>>>
>>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>   drivers/iommu/intel/iommu.c | 27 +++++++++++++--------------
>>>>   1 file changed, 13 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>>> index 9ff8b83c19a3..5a8080c71b04 100644
>>>> --- a/drivers/iommu/intel/iommu.c
>>>> +++ b/drivers/iommu/intel/iommu.c
>>>> @@ -1322,15 +1322,6 @@ static void iommu_enable_pci_caps(struct 
>>>> device_domain_info *info)
>>>>           return;
>>>>       pdev = to_pci_dev(info->dev);
>>>> -
>>>> -    /* The PCIe spec, in its wisdom, declares that the behaviour of
>>>> -       the device if you enable PASID support after ATS support is
>>>> -       undefined. So always enable PASID support on devices which
>>>> -       have it, even if we can't yet know if we're ever going to
>>>> -       use it. */
>>>> -    if (info->pasid_supported && !pci_enable_pasid(pdev, 
>>>> info->pasid_supported & ~1))
>>>> -        info->pasid_enabled = 1;
>>>> -
>>>>       if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>>>>           !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>>>>           info->ats_enabled = 1;
>>>> @@ -1352,11 +1343,6 @@ static void iommu_disable_pci_caps(struct 
>>>> device_domain_info *info)
>>>>           info->ats_enabled = 0;
>>>>           domain_update_iotlb(info->domain);
>>>>       }
>>>> -
>>>> -    if (info->pasid_enabled) {
>>>> -        pci_disable_pasid(pdev);
>>>> -        info->pasid_enabled = 0;
>>>> -    }
>>>>   }
>>>>   static void intel_flush_iotlb_all(struct iommu_domain *domain)
>>>> @@ -4110,6 +4096,16 @@ static struct iommu_device 
>>>> *intel_iommu_probe_device(struct device *dev)
>>>>           }
>>>>       }
>>>> +    /*
>>>> +     * The PCIe spec, in its wisdom, declares that the behaviour of 
>>>> the
>>>> +     * device is undefined if you enable PASID support after ATS 
>>>> support.
>>>> +     * So always enable PASID support on devices which have it, 
>>>> even if
>>>> +     * we can't yet know if we're ever going to use it.
>>>> +     */
>>>> +    if (info->pasid_supported &&
>>>> +        !pci_enable_pasid(pdev, info->pasid_supported & ~1))
>>>> +        info->pasid_enabled = 1;
>>>> +
>>>>       intel_iommu_debugfs_create_dev(info);
>>>>       return &iommu->iommu;
>>>> @@ -4128,6 +4124,9 @@ static void intel_iommu_release_device(struct 
>>>> device *dev)
>>>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>>>       struct intel_iommu *iommu = info->iommu;
>>>> +    if (info->pasid_enabled)
>>>> +        pci_disable_pasid(to_pci_dev(dev));
>>>> +
>>>
>>> would it make sense to move this behind the
>>> intel_iommu_debugfs_remove_dev(info)? This seems to mirror the order 
>>> of the
>>> intel_iommu_probe_device(). Or you may set info->pasid_enabled to 0 
>>> in case
>>> of any code uses it before info is freed if keeping this order. 
>>> Otherwise,
>>> lgtm. thanks for the quick action. 🙂
>>
>> The info->pasid_enabled change should not impact the behavior of
>> intel_iommu_debugfs_remove_dev(), and I didn't find any issue during my
>> test.
>>
>> Anyway, to make it more consistent with previous behavior, maybe I could
>> move the part where we turn on/off pasid to the end of the probe and the
>> start of the release.
> 
> yeah, this looks ok. And you may consider to clear info->pasid_enabled
> when it's disabled. I guess it does not affect device_rbtree_remove(),
> intel_pasid_teardown_sm_context(), intel_pasid_free_table() nor the
> intel_iommu_debugfs_remove_dev(), but good to clear it as it to
> reflect the status.:)

Done.

Thanks,
baolu


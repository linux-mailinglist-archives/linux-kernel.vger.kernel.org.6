Return-Path: <linux-kernel+bounces-291389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6747F956175
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BF61C214E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EC9139CEE;
	Mon, 19 Aug 2024 03:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7jbB+l1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDDB2F4A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724038497; cv=none; b=d9+SMtelzEC2KMQBuCK/pg6SYnR7rWC8s0z1+kcQeIdO520KmsE9aeg6ZcbtdTV4fcBpK1Wdcw41Q6RCxy+bmyZY0ibgmg+aPbeGdnwxLhOG+rJZ8vhw1ZoPS2MPRkxdrbZ7ztrwcJ657hVHSkG4TK78zAaxK9BgDrk3ndTbfmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724038497; c=relaxed/simple;
	bh=OoUUZOAulltQacWH4AzegysZeKuUdfHCfIyZe7W/jrA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fHzD+l4gRKd/L8s8aNCmZuF8wYln1hz1+wdYp3olVojmWwKkV7QiJ3N4blQoqO04z0HoNrthqVutEhScZFMYWwdEmj/5Qvk0PM8+H2ZZA6xP5M2T1XHDwwB9nVuZrJ3fcKCTxBKJ8vmWZHcGv8i5ZH0RWXzFwvdQsLEABMpAMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7jbB+l1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724038495; x=1755574495;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OoUUZOAulltQacWH4AzegysZeKuUdfHCfIyZe7W/jrA=;
  b=S7jbB+l1X69y1SdBKnkFDacTm3XPR0Jilq6N/OK93VtknAUY3HiNUI4n
   M+KTQji1tFK8mZOxxFW6QNTEx5ijT+PZ5tZQmNtH7DhNwEszrI6CGLPDm
   iLoneX7YMj5ftSssfIeqcAeqMZGlusFoVX8UG+zV8XIp5b6xq7nN3U0pY
   qSWERrRb47tlGUUh+Fk6CcgGqhsvYi9+kR3sRJO7Ib38Wbp24uDgWb4du
   NnNa5g6Cef0cngncVEsR5b0vcVRqh3AjqjMKwvcOobNwbVcaZOGKXntcZ
   imwyxEdp/1Bkrjg+YJ5819WsN62q1dEAbXUUsVQ7BGhobvCx78wSumBaV
   A==;
X-CSE-ConnectionGUID: mXVsR/aBSEqUKZK4VvqqGw==
X-CSE-MsgGUID: Lllwc8h4QLu5ZLRnmhIC+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22418348"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22418348"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:34:55 -0700
X-CSE-ConnectionGUID: m/Fr8l+HTHegHghwaKC9Dg==
X-CSE-MsgGUID: Flunx/QZTJaGThITwK1U9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="83458792"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:34:52 -0700
Message-ID: <3631c0ca-4c8d-4cef-aa40-13e3acd22123@linux.intel.com>
Date: Mon, 19 Aug 2024 11:34:50 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <511f140b-2792-47b0-b366-cbbad6e80239@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/8/19 11:14, Yi Liu wrote:
> On 2024/8/16 18:49, Lu Baolu wrote:
>> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
>> attached to the device and disabled when the device transitions to block
>> translation mode. This approach is inappropriate as PCI PASID is a device
>> feature independent of the type of the attached domain.
>>
>> Enable PCI PASID during the IOMMU device probe and disables it during the
>> release path.
>>
>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 27 +++++++++++++--------------
>>   1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 9ff8b83c19a3..5a8080c71b04 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1322,15 +1322,6 @@ static void iommu_enable_pci_caps(struct 
>> device_domain_info *info)
>>           return;
>>       pdev = to_pci_dev(info->dev);
>> -
>> -    /* The PCIe spec, in its wisdom, declares that the behaviour of
>> -       the device if you enable PASID support after ATS support is
>> -       undefined. So always enable PASID support on devices which
>> -       have it, even if we can't yet know if we're ever going to
>> -       use it. */
>> -    if (info->pasid_supported && !pci_enable_pasid(pdev, 
>> info->pasid_supported & ~1))
>> -        info->pasid_enabled = 1;
>> -
>>       if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>>           !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>>           info->ats_enabled = 1;
>> @@ -1352,11 +1343,6 @@ static void iommu_disable_pci_caps(struct 
>> device_domain_info *info)
>>           info->ats_enabled = 0;
>>           domain_update_iotlb(info->domain);
>>       }
>> -
>> -    if (info->pasid_enabled) {
>> -        pci_disable_pasid(pdev);
>> -        info->pasid_enabled = 0;
>> -    }
>>   }
>>   static void intel_flush_iotlb_all(struct iommu_domain *domain)
>> @@ -4110,6 +4096,16 @@ static struct iommu_device 
>> *intel_iommu_probe_device(struct device *dev)
>>           }
>>       }
>> +    /*
>> +     * The PCIe spec, in its wisdom, declares that the behaviour of the
>> +     * device is undefined if you enable PASID support after ATS 
>> support.
>> +     * So always enable PASID support on devices which have it, even if
>> +     * we can't yet know if we're ever going to use it.
>> +     */
>> +    if (info->pasid_supported &&
>> +        !pci_enable_pasid(pdev, info->pasid_supported & ~1))
>> +        info->pasid_enabled = 1;
>> +
>>       intel_iommu_debugfs_create_dev(info);
>>       return &iommu->iommu;
>> @@ -4128,6 +4124,9 @@ static void intel_iommu_release_device(struct 
>> device *dev)
>>       struct device_domain_info *info = dev_iommu_priv_get(dev);
>>       struct intel_iommu *iommu = info->iommu;
>> +    if (info->pasid_enabled)
>> +        pci_disable_pasid(to_pci_dev(dev));
>> +
> 
> would it make sense to move this behind the
> intel_iommu_debugfs_remove_dev(info)? This seems to mirror the order of the
> intel_iommu_probe_device(). Or you may set info->pasid_enabled to 0 in case
> of any code uses it before info is freed if keeping this order. Otherwise,
> lgtm. thanks for the quick action. 🙂

The info->pasid_enabled change should not impact the behavior of
intel_iommu_debugfs_remove_dev(), and I didn't find any issue during my
test.

Anyway, to make it more consistent with previous behavior, maybe I could
move the part where we turn on/off pasid to the end of the probe and the
start of the release.

Additional change likes below?

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5a8080c71b04..76b317f1d1de 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4096,6 +4096,8 @@ static struct iommu_device 
*intel_iommu_probe_device(struct device *dev)
                 }
         }

+       intel_iommu_debugfs_create_dev(info);
+
         /*
          * The PCIe spec, in its wisdom, declares that the behaviour of the
          * device is undefined if you enable PASID support after ATS 
support.
@@ -4106,8 +4108,6 @@ static struct iommu_device 
*intel_iommu_probe_device(struct device *dev)
             !pci_enable_pasid(pdev, info->pasid_supported & ~1))
                 info->pasid_enabled = 1;

-       intel_iommu_debugfs_create_dev(info);
-
         return &iommu->iommu;
  free_table:
         intel_pasid_free_table(dev);

Thanks,
baolu


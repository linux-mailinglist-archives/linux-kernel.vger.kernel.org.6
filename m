Return-Path: <linux-kernel+bounces-265120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A6E93ECFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3F61F21D07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D18681AC6;
	Mon, 29 Jul 2024 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNwi5MWI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D42C69B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722231158; cv=none; b=Krn+53pbHFJd3yAyNieYq9fOTlVyn5sIymqt/EmKUkSAicMJekvAeRikjLk7JTITMgapwTrFjs0P17+nccsxfWWBPMOJHVWLSQ45QABAtuMSzEux4oQbR0jd4jDvy9ZJrLIkSkpfZBco3sOtgbq7dIZfkCHTRdEXqLj9zwTco8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722231158; c=relaxed/simple;
	bh=TeAd1UWqkQWn01iDGQgMTDQb1gOifysLSoVfT9RgD5Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AI25CXkdzEhawz6hSW2HSIrLZL0j30SGGop77UkrQ6T8iGKFvkw7QsISLEv60ruavhk7xS/btCOlSNsFocKVcSFbWpl+nojyxo4ay7oJdFqZuwCFtJgr5aZGm4eEdMUMi/okkTyokbtFkyMhEOwRTL7HEoI4uEgFrdq5sEz6fFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNwi5MWI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722231157; x=1753767157;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TeAd1UWqkQWn01iDGQgMTDQb1gOifysLSoVfT9RgD5Y=;
  b=gNwi5MWI/Y5QZZAnQJ317ChyFKddnC5QoMfbLSJv0KjnSZ7svn6+IfqZ
   Jx7Hp81DZkXNC7tGqio4t5n4q1DaSWI0gtI7S0F8DrZU5QGLoViW07aHD
   uMWIT3PcwlkZIf8HPyNK6O2R7RCezkQ+rYcjX+6vpa3a3Q5Cv9k19ylhi
   hRgX8q/woIy7HWdwBdFOrqXB7cshLwymv3gfN3k5ABwg7O6gZCsDzCowY
   GnYQiSZLvzQ9X4/WUEyAcmIBXV9qKM+/Wxt3S2uxrcSHZKmzkVlbnAJoF
   Mk4ixKZSOmgrVNcuqIlQ58pIrNBZqmPS6RSDdy76jEHXbK6l2o7KnDQyC
   g==;
X-CSE-ConnectionGUID: Exa6J5cRSGOwIbdRpFx30w==
X-CSE-MsgGUID: dXan31P9SvKo6KXWayaLSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="30578901"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="30578901"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 22:29:35 -0700
X-CSE-ConnectionGUID: cIQozIwKSiOGAViHIwXSGA==
X-CSE-MsgGUID: V+jb0EG5Sl+ZBrQwyLgOfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="58445410"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.238.251]) ([10.124.238.251])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 22:29:31 -0700
Message-ID: <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
Date: Mon, 29 Jul 2024 13:29:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Nicolin Chen <nicolinc@nvidia.com>, Michael Shavit <mshavit@google.com>,
 Mostafa Saleh <smostafa@google.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 wanghaibin.wang@huawei.com, yuzenghui@huawei.com, tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
To: Will Deacon <will@kernel.org>, Kunkun Jiang <jiangkunkun@huawei.com>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240724102417.GA27376@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/7/24 18:24, Will Deacon wrote:
> On Wed, Jul 24, 2024 at 05:22:59PM +0800, Kunkun Jiang wrote:
>> On 2024/7/24 9:42, Kunkun Jiang wrote:
>>> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> 1797                 while (!queue_remove_raw(q, evt)) {
>>> 1798                         u8 id = FIELD_GET(EVTQ_0_ID, evt[0]);
>>> 1799
>>> 1800                         ret = arm_smmu_handle_evt(smmu, evt);
>>> 1801                         if (!ret || !__ratelimit(&rs))
>>> 1802                                 continue;
>>> 1803
>>> 1804                         dev_info(smmu->dev, "event 0x%02x
>>> received:\n", id);
>>> 1805                         for (i = 0; i < ARRAY_SIZE(evt); ++i)
>>> 1806                                 dev_info(smmu->dev, "\t0x%016llx\n",
>>> 1807                                          (unsigned long
>>> long)evt[i]);
>>> 1808
>>> 1809                         cond_resched();
>>> 1810                 }
>>>
>>> The smmu-v3 driver cannot print event information when "ret" is 0.
>>> Unfortunately due to commit 3dfa64aecbaf
>>> ("iommu: Make iommu_report_device_fault() return void"), the default
>>> return value in arm_smmu_handle_evt() is 0. Maybe a trace should
>>> be added here?
>> Additional explanation. Background introduction:
>> 1.A device(VF) is passthrough(VFIO-PCI) to a VM.
>> 2.The SMMU has the stall feature.
>> 3.Modified guest device driver to generate an event.
>>
>> This event handling process is as follows:
>> arm_smmu_evtq_thread
>>      ret = arm_smmu_handle_evt
>>          iommu_report_device_fault
>>              iopf_param = iopf_get_dev_fault_param(dev);
>>              // iopf is not enabled.
>> // No RESUME will be sent!
>>              if (WARN_ON(!iopf_param))
>>                  return;
>>      if (!ret || !__ratelimit(&rs))
>>          continue;
>>
>> In this scenario, the io page-fault capability is not enabled.
>> There are two problems here:
>> 1. The event information is not printed.
>> 2. The entire device(PF level) is stalled,not just the current
>> VF. This affects other normal VFs.
> Oh, so that stall is probably also due to b554e396e51c ("iommu: Make
> iopf_group_response() return void"). I agree that we need a way to
> propagate error handling back to the driver in the case that
> 'iopf_param' is NULL, otherwise we're making the unexpected fault
> considerably more problematic than it needs to be.
> 
> Lu -- can we add the -ENODEV return back in the case that
> iommu_report_device_fault() doesn't even find a 'iommu_fault_param' for
> the device?

Yes, of course. The commit b554e396e51c was added to consolidate the
drivers' auto response code in the core with the assumption that driver
only needs to call iommu_report_device_fault() for reporting an iopf.

Thanks,
baolu


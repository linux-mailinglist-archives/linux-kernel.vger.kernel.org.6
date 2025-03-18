Return-Path: <linux-kernel+bounces-566205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DA3A674DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F74718897FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBC520C482;
	Tue, 18 Mar 2025 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e7PimAhd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F420C473
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303981; cv=none; b=Onzp3PfV+l8oydOpkzDjzVOeGZZhPDoPd+ZPuTMRNM9HCd7RG7Lg9KJ3hfxuhXF0bQ9RVdn8CkkVj2i5/T152ZWMosqGTzS6KIqxdC9UM780kxWCWnIpIMpuRoBvdWq5meVTs3ZS1Dk5uWKdH5wvZ4pxsy6EKvvo32SVhr9dmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303981; c=relaxed/simple;
	bh=mAuH0S02yMCdtPuWVY9sxG79ge2AvLgJkSor1CmebnM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SPY3mk4wupjjp12AFQOHcFoLNmJY4wEgQ4xS36JXNVsJ0BTT25YjmxJvsTOto1famcMYqcjex3qDBKRvd1R60kwPnT/NfeK85CNrA5mIw1whUi6G/4Q+ZmQ0WX4gvfWGUkRMHJAC8q0JBYJ0Ur+LTAz+J8Kozw0s9D+sjlrz3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e7PimAhd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742303976; x=1773839976;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mAuH0S02yMCdtPuWVY9sxG79ge2AvLgJkSor1CmebnM=;
  b=e7PimAhdsDwGaQHr0M9nWihCGFzBhFmSaVB3qIvRPM7TFVEybiPdlMWc
   tD/Mjw3yrcyZIAyHXHUfeDIbejUILWKjxFnz8C+ULaPYguLkCM6/irUlL
   grWeQ1/ly41QZNGsrartCJJdEHEpXksXlo8uwcCsfslBSwFQ/qw1TORN8
   F2UGzhRawezRPbPIi7MGa8XuEQOYj5xH2euqzeG/uHDZ0AfkEfT5XBukK
   l9f24zxElHfuNFY9n50Rh1aq2Mpf5RE/QEMlGAQapP6UDK8cdHr3RMKlj
   jyRT5cYhFGg1N94MQf2Sll2GlNE7xq70PYeZZopR+7ZxPYMbRo7rvykrT
   g==;
X-CSE-ConnectionGUID: KtoCrAwIQkynlvGjHhb5Kg==
X-CSE-MsgGUID: l2UjeskySbmiMQDTTey4SA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43360027"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43360027"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:19:36 -0700
X-CSE-ConnectionGUID: IaVQRtKCR725LYbzUUHy/Q==
X-CSE-MsgGUID: hNvzQEnoQ9Kjh9n2yZoyTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="122232135"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.41]) ([10.124.241.41])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:19:32 -0700
Message-ID: <b5cfd488-645e-4448-9544-35cb677772d0@linux.intel.com>
Date: Tue, 18 Mar 2025 21:19:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Fenghua Yu <fenghuay@nvidia.com>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/8] iommu/vt-d: Put iopf enablement in domain attach
 path
To: Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <20250313051953.4064532-4-baolu.lu@linux.intel.com>
 <010af39d-6158-4aa8-90ad-0084d5767e2d@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <010af39d-6158-4aa8-90ad-0084d5767e2d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/2025 5:58 PM, Yi Liu wrote:
> On 2025/3/13 13:19, Lu Baolu wrote:
>> Update iopf enablement in the driver to use the new method, similar to
>> the arm-smmu-v3 driver. Enable iopf support when any domain with an
>> iopf_handler is attached, and disable it when the domain is removed.
>>
>> Place all the logic for controlling the PRI and iopf queue in the domain
>> set/remove/replace paths. Keep track of the number of domains set to the
>> device and PASIDs that require iopf. When the first domain requiring iopf
>> is attached, add the device to the iopf queue and enable PRI. When the
>> last domain is removed, remove it from the iopf queue and disable PRI.
> 
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> 
> a nit. It appears to me the PRI cap and IOMMU PRI enable bit is set in the
> probe_device() now after the below patch. This commit now is more dealing
> with iopf_refcount and adding the device to the iopf queue.
> 
> https://lore.kernel.org/linux-iommu/20250228092631.3425464-6- 
> baolu.lu@linux.intel.com/

Yes. With the device not adding to the iommu iopf queue, the IOMMU core
will respond to the device with IOMMU_PAGE_RESP_INVALID.

Thanks,
baolu


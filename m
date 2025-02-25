Return-Path: <linux-kernel+bounces-530623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0760A435E3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB96D177B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2AF257447;
	Tue, 25 Feb 2025 07:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g4BapXeX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840D19F495
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740466906; cv=none; b=iRCJPu2TBM9RYnvuPz5tI7RtFukhIyI22IEbFo4/e7jYj//b+CzJyR0iYLnmNT8gA5NUwfp9TKHaWutXwP6tgYdK0pleJObb5PkIdcSlt8osMpWv8bhtZ9c6IOnQAibDcqDNJRji/myt5ydVz/7PVetXRWuterR2sNCT3u42q3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740466906; c=relaxed/simple;
	bh=DKqBKC4FjxhMkoEJUSZOc+8sSEa1bIVOfaEeP2C4xaI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WA1kNuXiEemBfedMyw0E0R/UkcI0n5xgQ1gew/JyVTKhdU+TnQ0tgH+wC1d4Hm7uSPlYimKp4RBBaz1NADVaRIzMPPbZ2T8VQHGtqeUAkgNk+MA2GRDoAgikgc/D30rQw1zLkmSlrbhFsxsU186FAXewuqUwWBnHSlXyxEgqdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g4BapXeX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740466905; x=1772002905;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DKqBKC4FjxhMkoEJUSZOc+8sSEa1bIVOfaEeP2C4xaI=;
  b=g4BapXeXUH+EzfaZZCRhUs2UOV6jaAPYXywROcPLWpxWBK5+fB4Err/W
   hkeQJqEwgA596mEDvqpRX6huHV/uBwuHxbAemKGATqk8OWanvJg7rwntG
   Vo5rRPe6rwduDke0779w4W62p21FE6LHyiQW91yDJYmWqcW8508CMA1b0
   pQd4hDKEAGUBwm64riCpyCcWaOjgeY1YCy76MUyIBcGKlXOlCNLm+8/B1
   XYtWuLu3+jWI+MiXaK6c2P+0Ta2ooVJislLmyShTY0xBxaQBgklcS8Apx
   9e7rBO3J/Y3e+i5mNDzd2k0XC2L0p3jX/mMtJ0DfIl00YmTvlcI7M+hN2
   Q==;
X-CSE-ConnectionGUID: YoPy1KMFQSCatkQQmMV2yQ==
X-CSE-MsgGUID: fb+GUSbZSKSQQFXfsDtXxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41140231"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="41140231"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:01:44 -0800
X-CSE-ConnectionGUID: i5AIK804TnaA9XaVAdnWig==
X-CSE-MsgGUID: ZDfrC+/MSS2pJk35HQJI3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121242705"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.105]) ([10.124.240.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 23:01:41 -0800
Message-ID: <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
Date: Tue, 25 Feb 2025 15:01:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250225064831.63348-1-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/25 14:48, Yunhui Cui wrote:
> We found that executing the command ./a.out &;reboot -f (where a.out is a
> program that only executes a while(1) infinite loop) can probabilistically
> cause the system to hang in the intel_iommu_shutdown() function, rendering
> it unresponsive. Through analysis, we identified that the factors
> contributing to this issue are as follows:
> 
> 1. The reboot -f command does not prompt the kernel to notify the
> application layer to perform cleanup actions, allowing the application to
> continue running.
> 
> 2. When the kernel reaches the intel_iommu_shutdown() function, only the
> BSP (Bootstrap Processor) CPU is operational in the system.
> 
> 3. During the execution of intel_iommu_shutdown(), the function down_write
> (&dmar_global_lock) causes the process to sleep and be scheduled out.
> 
> 4. At this point, though the processor's interrupt flag is not cleared,
>   allowing interrupts to be accepted. However, only legacy devices and NMI
> (Non-Maskable Interrupt) interrupts could come in, as other interrupts
> routing have already been disabled. If no legacy or NMI interrupts occur
> at this stage, the scheduler will not be able to run.
> 
> 5. If the application got scheduled at this time is executing a while(1)-
> type loop, it will be unable to be preempted, leading to an infinite loop
> and causing the system to become unresponsive.
> 
> To resolve this issue, the intel_iommu_shutdown() function should not
> execute down_write(), which can potentially cause the process to be
> scheduled out. Furthermore, since only the BSP is running during the later
> stages of the reboot, there is no need for protection against parallel
> access to the DMAR (DMA Remapping) unit. Therefore, the following lines
> could be removed:

Good summary! Thank you!

> 
> down_write(&dmar_global_lock);
> up_write(&dmar_global_lock);
> 
> After testing, the issue has been resolved.
> 
> Fixes: 6c3a44ed3c55 ("iommu/vt-d: Turn off translations at shutdown")
> Co-developed-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index cc46098f875b..6d9f2e56ce88 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2871,16 +2871,12 @@ void intel_iommu_shutdown(void)
>   	if (no_iommu || dmar_disabled)
>   		return;
>   
> -	down_write(&dmar_global_lock);
> -
>   	/* Disable PMRs explicitly here. */
>   	for_each_iommu(iommu, drhd)

Removing the locking for for_each_iommu() will trigger a suspicious RCU
usage splat. You need to replace this helper with a raw
list_for_each_entry() with some comments around it to explain why it is
safe.

>   		iommu_disable_protect_mem_regions(iommu);
>   
>   	/* Make sure the IOMMUs are switched off */
>   	intel_disable_iommus();
> -
> -	up_write(&dmar_global_lock);
>   }
>   
>   static struct intel_iommu *dev_to_intel_iommu(struct device *dev)

Thanks,
baolu


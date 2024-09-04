Return-Path: <linux-kernel+bounces-314709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D7E96B756
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B70B02859E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BDA1CDA09;
	Wed,  4 Sep 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UugeXufx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22265145B35
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443404; cv=none; b=nfFu/WuVDkTLaKRArK7OmVLWUMM7nYfk+STcvzVUlMtJnL9Kl4/omFAbXsm0jxk5PqYogRUy/tPhGd2qw/mrns1pqPYgdxaP0pnBIIYhFEjNLU1sYsQGEZS0zVFf5av94aG9I4B38Ta3QksVmNHMN64bTdOxGg9/13mO8RHL9Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443404; c=relaxed/simple;
	bh=aaB0YSpYA6l5ZPYyfistw17D1sw3OVjLeevGcL2o5M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDM9+ZZQ5bFqtiknMJMtFbe6f4m5IMnxnT1AEulw7gw+2shPxRLNTd5VRJm/XhEShYWtNsNOqmZF0J0dUg1bWNzKGRv/JTOP8vpUtJAAdntOp4h9oORLmlWT0ZRDj2y75q8PDkFY005rjDdkA7EkLPHczicZq5L0ZRvFyJyxWFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UugeXufx; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725443402; x=1756979402;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aaB0YSpYA6l5ZPYyfistw17D1sw3OVjLeevGcL2o5M0=;
  b=UugeXufxMJd+4e/kDMf6CCDDN5l1d8P+NlYDSHy2reKgEStakQ0bMqGn
   A5qqgqtlWYAj8BkE8lFM8yYyZeak0bH1i54CqiH1x8gQHKSJnyFo3/NZ1
   fBRuakKvkzZXq7V1fVfg6rqXuWXI3kkr+Vlsh+n4WGU65nDOBKB8a3jHl
   weLBhn9vWwEWHEh6SP31oiwB3JN2gFZcIjYCwlAYwN+b7AkG0E4X5i2Rb
   UqTm2eWJefTYU+9s8rxYY3w4tzw/8afUu0hDpXzajoQBLEruPYf9QdTfb
   0L0+DML896e2LecPgRq+hnu1/iGZ6xXlz8b4iRrsoAWeN0jAut38dyqXF
   A==;
X-CSE-ConnectionGUID: N+oaIwkJSjSH9vXCp35u5w==
X-CSE-MsgGUID: W3x+an0SSqKMk1O0If8u9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24045573"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24045573"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:50:02 -0700
X-CSE-ConnectionGUID: YoZwp93IT6uZ7EIeBr69lA==
X-CSE-MsgGUID: t8P8L4jQS5CxWHeJKdEXdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="64870890"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.125.241.1]) ([10.125.241.1])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 02:50:01 -0700
Message-ID: <3159e4ba-1c39-4a79-a844-c52c08fe41b9@linux.intel.com>
Date: Wed, 4 Sep 2024 17:49:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix 'Null pointer dereferences' issue
To: Qianqiang Liu <qianqiang.liu@163.com>, dwmw2@infradead.org,
 baolu.lu@linux.intel.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240903144601.8149-1-qianqiang.liu@163.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240903144601.8149-1-qianqiang.liu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/3/2024 10:46 PM, Qianqiang Liu wrote:
> Passing null pointer "pdev" to "pci_enable_pasid", which dereferences it.
> Check the "pdev" is null or not before passing to "pci_enable_pasid".
>
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9f6b0780f2ef..a1e54f334330 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3935,7 +3935,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   	 * So always enable PASID support on devices which have it, even if
>   	 * we can't yet know if we're ever going to use it.
>   	 */
> -	if (info->pasid_supported &&
> +	if (info->pasid_supported && pdev &&
>   	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))

You hit any issue with specific ver kernel ? seems impossible to hit
such NULL pointer issue with the latest kernel for which you sent
this patch.

Thanks,
Ethan

>   		info->pasid_enabled = 1;
>   


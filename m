Return-Path: <linux-kernel+bounces-314008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4CE96ADA3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A931C210AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BAA4A3F;
	Wed,  4 Sep 2024 01:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huvyxdod"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FED433E1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725412272; cv=none; b=fEKxkyTqKA7xBc8fzNm0uu57qxuQAfgF/IpJmHK/+fEyaaHwNOHlc8Co0FXr9w8Vztb8m9DbDovz5Dp98t1iVLLoxEtvQX5NBMQY9PRuH2T4ZYH9S8wDNpEnij0m9dJ3jhHiRYYgyFzw3rLun5j83A96oZubOS3gOhT9u4Lg5Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725412272; c=relaxed/simple;
	bh=8BC7FzP4Q1lvmL9sCvkKiQcdYN6y5h4YZB1KZs4BpSc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DIg7I4B5BDnHOVs42RnvQbGSDVg7FcOxslVBakqiRC/dXqdxi6lH4hiZaYZkf0D+YplqyaEwR3Jy1j6/YmCW2McefSTB+jUm13KSmy0wTr4p1a0MgS15pA4Xxm9wcAgglBkfAfl27tooNRBBPkgbxcZ0nQjyBhFMuu1KQcBcI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huvyxdod; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725412270; x=1756948270;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8BC7FzP4Q1lvmL9sCvkKiQcdYN6y5h4YZB1KZs4BpSc=;
  b=huvyxdodeg2CNDgVOQY9NQJ2vi/emq7QM1zBGOvjop9noTqvI0no3tFQ
   NJu7k43FPq3ka8IEjeHuvf+CYYnjaRM8HAhtW4vaAmk0cUS3T/QjucGba
   Y72rM5wNcw2s69yALJ6jDCNt0ClmxW6QAymI1trEFhXVIvAhmAbXv74Qh
   27fA59tJeHaqv/mz8tqoQCIMU5TyQSsKayqlJl4w0kzLmENMiKbCGHtK+
   znsGQv111gi1CzyOQQ7vC3kc8spP/EI92OeGlU2+/JUEDaYICuow3VXA2
   CugAKuu6j4cbpLyuRL17RNTVEmrSVIer6lMPwTzsHiAgarME7WG89pg1U
   Q==;
X-CSE-ConnectionGUID: oCR5B/LuSImdPS4Mx4ngnQ==
X-CSE-MsgGUID: gmGtqk95S023GwuN45cqUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="35433677"
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="35433677"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 18:11:10 -0700
X-CSE-ConnectionGUID: so6Yhu5ZTGWjlkqV/KVXXw==
X-CSE-MsgGUID: e/7MQH6/QbG6nqD+2Ilkzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="95898345"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 03 Sep 2024 18:11:08 -0700
Message-ID: <874b493e-a669-4d54-9ba3-45cd23b075d7@linux.intel.com>
Date: Wed, 4 Sep 2024 09:07:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix 'Null pointer dereferences' issue
To: Qianqiang Liu <qianqiang.liu@163.com>, dwmw2@infradead.org
References: <20240903144601.8149-1-qianqiang.liu@163.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240903144601.8149-1-qianqiang.liu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 10:46 PM, Qianqiang Liu wrote:
> Passing null pointer "pdev" to "pci_enable_pasid", which dereferences it.
> Check the "pdev" is null or not before passing to "pci_enable_pasid".
> 
> Signed-off-by: Qianqiang Liu<qianqiang.liu@163.com>
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
>   		info->pasid_enabled = 1;

'info->pasid_supported=true' implies that pdev should never be NULL.
There's no need for an extra check.

Thanks,
baolu


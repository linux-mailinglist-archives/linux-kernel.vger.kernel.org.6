Return-Path: <linux-kernel+bounces-280559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D073C94CC23
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5243E1F21CE4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655F818DF8E;
	Fri,  9 Aug 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8/2MNye"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4717217556C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191935; cv=none; b=cAKrlDg4c4T5jfmt+c1f+NnODbmurk1jkwTix/sxAWQqjAFsa8CesnwV5JgeDRrQxWbp/8/6+IQunIgI6wRkgkmrqmAIjowCwYBBgo2wodc+hXDw/BC4NDJuiTUaXX4b8R63wmp9D9XNjFATKdmhOQND0EJGv/tuV/No4BT+zxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191935; c=relaxed/simple;
	bh=F00eSuBFRJ85i8bjy/BwzYYFaPqWwWC37gyvZLr183s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xh336yudZ7hXgP8O7Vbs4rE8RP+P1zBkUGiRu9mEAnSndrcqB2u2GjxTARniFRd6fZT+lEokQzOAYhLprldy1gQJFC/N4NegHpJpHELuOLn0B5rBu09A+sDHGOcW6IKSrNsNJ79bMNMzaxvz0Z1QMCGp8gcQ/+C14dnql4wYZKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8/2MNye; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723191934; x=1754727934;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F00eSuBFRJ85i8bjy/BwzYYFaPqWwWC37gyvZLr183s=;
  b=a8/2MNyeplU+qdTMA0n1BK9YAX8ZqPf6fbkLvnpKocw+Y3Jn1wwg653o
   Pwn81vRExIHS+U59YSaGkdpMPj1bjbm5ZDRUcfk2GIFFlAq8E0CP6JUaz
   0S0y+XPKMn9eu1xhEBuZjU1+k+WJjCBozTtEhvQLPsNeilbrCycv/S/zu
   rcUIr2C/eGP32hRmpywwoR6e3y0xuXolJIQqw6mFsAns8Ry/lz0MdHnT6
   kyfy9+UmUgr/9X7+a2bgc+JaHMg5YBTLqYgLdh+sR2hSqWtp57/PWgylg
   +UCjFcFZO+P4Y3tBEx3ra7xXuWd/NaS/zo6E5hwKGNj/GoV+z6MvuwlkO
   A==;
X-CSE-ConnectionGUID: Agyw9boeRSG4s46g9GxRXA==
X-CSE-MsgGUID: gwizILP3SquXBqL4LCGsEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31982548"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="31982548"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:25:34 -0700
X-CSE-ConnectionGUID: 9tfv5GZfR262HjFhJ08/Yw==
X-CSE-MsgGUID: G669TIP1Q7qizs7qpyIVGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57468923"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:25:32 -0700
Message-ID: <4d1f761b-993d-4c13-a296-111bc3b39141@linux.intel.com>
Date: Fri, 9 Aug 2024 16:25:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] vt-d/iommu: Refactor quirk_extra_dev_tlb_flush()
To: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20240809025431.14605-1-tina.zhang@intel.com>
 <20240809025431.14605-5-tina.zhang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240809025431.14605-5-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/9 10:54, Tina Zhang wrote:
> Extract the core logic from quirk_extra_dev_tlb_flush() into a new
> helper __quirk_extra_dev_tlb_flush(). This helper is for accommodating
> for both individual and batched TLB invalidation commands, thereby
> streamlining the process for handling device-specific TLB flush quirks.
> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 55 +++++++++++++++++++++++++++++--------
>   drivers/iommu/intel/iommu.h |  4 +++
>   2 files changed, 47 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9ff8b83c19a3..160d569015b4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4875,6 +4875,41 @@ static void __init check_tylersburg_isoch(void)
>   	       vtisochctrl);
>   }
>   
> +static inline void __quirk_extra_dev_tlb_flush(struct device_domain_info *info,
> +					       unsigned long address, unsigned long mask,
> +					       u32 pasid, u16 qdep,
> +					       struct qi_batch *batch)
> +{
> +	u16 sid;
> +
> +	if (likely(!info->dtlb_extra_inval))
> +		return;
> +
> +	sid = PCI_DEVID(info->bus, info->devfn);
> +	if (batch == NULL) {
> +		if (pasid == IOMMU_NO_PASID)
> +			qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> +					   qdep, address, mask);
> +		else
> +			qi_flush_dev_iotlb_pasid(info->iommu, sid,
> +						 info->pfsid, pasid,
> +						 qdep, address, mask);
> +	} else {
> +		if (pasid == IOMMU_NO_PASID)
> +			qi_batch_add_dev_iotlb_desc(info->iommu, sid,
> +						    info->pfsid, qdep,
> +						    address, mask, batch);
> +		else
> +			qi_batch_add_dev_iotlb_pasid_desc(info->iommu,
> +							  sid,
> +							  info->pfsid,
> +							  pasid, qdep,
> +							  address,
> +							  mask,
> +							  batch);
> +	}
> +}

How about moving this helper into cache.c? That's its only or major
consumer, right?

By the way, in which case could 'batch' be a NULL?

Thanks,
baolu


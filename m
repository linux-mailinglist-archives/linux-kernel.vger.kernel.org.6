Return-Path: <linux-kernel+bounces-377341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5775A9ABD79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1915C28130B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F1613AD05;
	Wed, 23 Oct 2024 04:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNpELxqX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484A41EA80
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729658990; cv=none; b=fy+/ulJE5UfeJv/GD66tCKS+uQ4YE1AFt4j1hFBPK+g+yC6I24tefV9hkL6R2TJtw0PxQGA6UWPuaEUOTmjvb3P2MhCHj/FTVOYeIq7v/frAQXb7qF6bJNC73OXwPrHmBjwTfnKdfM4rP14DFwhFcfxcnamDM0ZOVYy/qn4PM0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729658990; c=relaxed/simple;
	bh=f2yXnjITIt85IcBIn57+JEnGX7bPxudFkpc0kQq6JdM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qYoEw3TtlHq108R8bXZZl3kZkkEVO1Ys3rBlbW+hQ5qm2iIxLzbu4lcgELB0+OcsVPYX/gCHkWIv9hji/6Sdez22zHVYjPKTGt0pZCRDmpCOMWS/Podmh10vXIMk+9cKl23R/vYPF4QF0Hh225CsbSFEtDRSpC3KKmTa/tktynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNpELxqX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729658989; x=1761194989;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f2yXnjITIt85IcBIn57+JEnGX7bPxudFkpc0kQq6JdM=;
  b=bNpELxqXbntBYQMfbkP6IQJ7srmoR34pRKYi7JS4tqt1SHsyhH/6OuN/
   1uuBREPQcfDiNA96JVy3X3irJobfRCG04X+bwyPaETWTCB8OKyktOy2d9
   TICYQrKqMFpdY3SN2RzypH9v0XBTRdHUEM9aF+TeawvkXer8m/0zRsCbN
   P2HWO8Icf5Zt/YcywnQ9Jxpio0+h9Sm7klJXqK/GpcWSRRC8lKxbnOWan
   OMImgZuaYwhSmHbWRobPjEELRhQ4fRNJklBqdQFCOU2xZbTg8DvgpITZP
   B3LaK6mgNZdqQQW2Oy6+LhlV3+3fnrFc80seZT38ZS6/8EVZR49k4g0QC
   w==;
X-CSE-ConnectionGUID: 6I8q+Uv1Q8GysHnWmJpztQ==
X-CSE-MsgGUID: FfJnyPlgSfiNxZbGsdmJPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29104546"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29104546"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 21:49:49 -0700
X-CSE-ConnectionGUID: Xa3vEpUyTyWSg/nBXKZ4jA==
X-CSE-MsgGUID: Zgp435YRS3em+cbkWuPnqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="79651501"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 21:49:46 -0700
Message-ID: <813d32e8-e84c-4744-bc2c-b76adc10d00f@linux.intel.com>
Date: Wed, 23 Oct 2024 12:49:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, chao.p.peng@intel.com,
 Kyung Min Park <kyung.min.park@intel.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Fix checks in pgtable_walk()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20241022095017.479081-1-zhenzhong.duan@intel.com>
 <20241022095017.479081-3-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241022095017.479081-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/22 17:50, Zhenzhong Duan wrote:
> It's not accurate to dump super page as non-present page,
> meanwhile bit7 in first level page table entry is PAT bit,

Can you please explain how the 'bit7 in first level page table entry' is
relevant to the changes made in this patch?

Also, please make full use of the maximum length of the commit message
line.

> also pointer pte is never NULL in pgtable_walk() context.
> 
> Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA fault occurs")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8288b0ee7a61..fec5cc1147f3 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -707,14 +707,14 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
>   	while (1) {
>   		offset = pfn_level_offset(pfn, level);
>   		pte = &parent[offset];
> -		if (!pte || (dma_pte_superpage(pte) || !dma_pte_present(pte))) {
> +		if (!dma_pte_present(pte)) {
>   			pr_info("PTE not present at level %d\n", level);
>   			break;
>   		}
>   
>   		pr_info("pte level: %d, pte value: 0x%016llx\n", level, pte->val);
>   
> -		if (level == 1)
> +		if (level == 1 || dma_pte_superpage(pte))
>   			break;
>   
>   		parent = phys_to_virt(dma_pte_addr(pte));

Thanks,
baolu


Return-Path: <linux-kernel+bounces-316501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DB896D067
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186611F234B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4441E193090;
	Thu,  5 Sep 2024 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNCyCSYJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ED7158D9C;
	Thu,  5 Sep 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521477; cv=none; b=JmiIXzZj9nZQ+GYnS3D2pPMXhoN9lv9tJKUK1bKVm6WKzaEh2/ssHRQPA2VMpYgYtcwIPzBFFJJarbuQGuiuvlsmB3/MV3pcALPc7Qg+uUwBGqIHC9qXnNLjS7iNHN8f/7xKVvL+7eQw+2Jt2yPC+UcRs8oKjCtO7H6T06KRmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521477; c=relaxed/simple;
	bh=0tEXOCRmzQvGMaQ2Hf74owmJ+GaCBBkJPS65VLgWbYU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RPqxlHgIhETZ7QZOpCVZT6RqU7CjV5Mewp/Mgbl3h6W3+/rqUEMRgpBuKBg4LQn1Ti9ST247rBmwIBbvAHgjx4vGkXzQ9ijGoYH1UYRhWBJfJhHAzsxA3/FAaj/hXL6/Ly5xyFOFnCqy8NS7cctg4nIOlonifH1nZ286szDalPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNCyCSYJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725521476; x=1757057476;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0tEXOCRmzQvGMaQ2Hf74owmJ+GaCBBkJPS65VLgWbYU=;
  b=NNCyCSYJDYzNCAvjDrsV5GWoE5aI72INGU43HLRAqr/fUadgzRSAulrM
   l9xlcbVr42yd3FaeZuo4WSP2LT0ZMb0x1jgvFajIX2o9pNeAnxwBal5mV
   Wku1SFtPg65RHBAN6otIwMbcu9IqRiSgGrWSEkbEELQKHVxde8O4Q1wBv
   92bEmsBsUKOwqFEmDFiMU3PXLcR9FVotDcBuza3J3VpYFnwfscgNrhuuy
   KRCXh+ZLKX000HPE25DiChP8X4NAiEa7VrWaTzaRhsAOwW0MoqH80ZsJX
   iYVIuHle3dBoR4+ODVZ9hlY2bYJJwh1Ub/Vn4qB+p4BW33Z+MGgxW5AXe
   Q==;
X-CSE-ConnectionGUID: rBz5Cn30T1uED1J5gun29w==
X-CSE-MsgGUID: y63fpwSbQzCBOQDosTVoTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="41692524"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="41692524"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 00:31:15 -0700
X-CSE-ConnectionGUID: fjBK3sV2TWOBdAa43gJwcA==
X-CSE-MsgGUID: E/XBXnZfTTyYntLIrP4IBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="70451136"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 00:31:12 -0700
Message-ID: <45a3ae40-6e59-43b4-ae57-d159bd2b54df@linux.intel.com>
Date: Thu, 5 Sep 2024 15:31:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 linux-doc@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Add kernel parameters to limit V1 page-sizes
To: Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Vasant Hegde <vasant.hegde@amd.com>
References: <20240905072240.253313-1-joro@8bytes.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240905072240.253313-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/5 15:22, Joerg Roedel wrote:
> From: Joerg Roedel<jroedel@suse.de>
> 
> Add two new kernel command line parameters to limit the page-sizes
> used for v1 page-tables:
> 
> 	nohugepages     - Limits page-sizes to 4KiB
> 
> 	v2_pgsizes_only - Limits page-sizes to 4Kib/2Mib/1GiB; The
> 	                  same as the sizes used with v2 page-tables
> 
> This is needed for multiple scenarios. When assigning devices to
> SEV-SNP guests the IOMMU page-sizes need to match the sizes in the RMP
> table, otherwise the device will not be able to access all shared
> memory.
> 
> Also, some ATS devices do not work properly with arbitrary IO
> page-sizes as supported by AMD-Vi, so limiting the sizes used by the
> driver is a suitable workaround.
> 
> All-in-all, these parameters are only workarounds until the IOMMU core
> and related APIs gather the ability to negotiate the page-sizes in a
> better way.
> 
> Signed-off-by: Joerg Roedel<jroedel@suse.de>
> ---
>   Documentation/admin-guide/kernel-parameters.txt | 17 +++++++++++------
>   drivers/iommu/amd/amd_iommu.h                   |  1 +
>   drivers/iommu/amd/amd_iommu_types.h             |  4 ++++
>   drivers/iommu/amd/init.c                        |  8 ++++++++
>   drivers/iommu/amd/io_pgtable.c                  |  2 +-
>   5 files changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..6d6630aec46c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -333,12 +333,17 @@
>   					  allowed anymore to lift isolation
>   					  requirements as needed. This option
>   					  does not override iommu=pt
> -			force_enable - Force enable the IOMMU on platforms known
> -				       to be buggy with IOMMU enabled. Use this
> -				       option with care.
> -			pgtbl_v1     - Use v1 page table for DMA-API (Default).
> -			pgtbl_v2     - Use v2 page table for DMA-API.
> -			irtcachedis  - Disable Interrupt Remapping Table (IRT) caching.
> +			force_enable    - Force enable the IOMMU on platforms known
> +				          to be buggy with IOMMU enabled. Use this
> +				          option with care.
> +			pgtbl_v1        - Use v1 page table for DMA-API (Default).
> +			pgtbl_v2        - Use v2 page table for DMA-API.
> +			irtcachedis     - Disable Interrupt Remapping Table (IRT) caching.
> +			nohugepages     - Limit page-sizes used for v1 page-tables
> +				          to 4 KiB.

Intel iommu driver has a similar option 'intel_iommu=sp_off'

	sp_off [Default Off]
		By default, super page will be supported if Intel IOMMU
		has the capability. With this option, super page will
		not be supported.

Is it possible to consolidate these two into a single
"iommu.nohugepages=1"?

> +			v2_pgsizes_only - Limit page-sizes used for v1 page-tables
> +				          to 4KiB/2Mib/1GiB.
> +
>   
>   	amd_iommu_dump=	[HW,X86-64]
>   			Enable AMD IOMMU driver option to dump the ACPI table

Thanks,
baolu


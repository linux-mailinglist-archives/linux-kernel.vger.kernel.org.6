Return-Path: <linux-kernel+bounces-310522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B48967DE6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61201C21E49
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA82D2BB04;
	Mon,  2 Sep 2024 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hi7CnpxQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C77273F9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244686; cv=none; b=LDleFylO7Vx2Lu70NEHOT1IH/bYhY7I2Szp96m0l6iawmekefnAyHWdNsFr1AkprSXU6Lycs4Cgf9ahJ0oB9xIQwRcLqCgKkQp30nukQp/ToLqy2mrG0pfRyg+0BpRE9s1yOAbJmLzhoNvPqUkVHfFKIBNmIguhNpIastss9Uvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244686; c=relaxed/simple;
	bh=ZuAo2ecop6gc7mqzQ6fpPAqXDU8HXYGy/NGQivWqyfE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NIB4LwLRXGGlcdNgWBzKWGGBh0fbVYGYwh5asaMMuieC5st5OWn8YVUs7Duamkt+2oGUFMugA1ieeeysXFYwj2jBI60F1CGq8zOvOTfivFIh5rAHK2kYj/n9sXVVN+jz531bV/rYc1B/PdMWSabKZxDIJAKe0hIqcp6zMJoPFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hi7CnpxQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244684; x=1756780684;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZuAo2ecop6gc7mqzQ6fpPAqXDU8HXYGy/NGQivWqyfE=;
  b=Hi7CnpxQug9eT5XAgSSdQvjFzd4rNX20OKYflZSAeSqqnw0UGV2qM2+q
   i9hqLTep+8bnyVQ7Dsx821nQK+8zkyFp61jRtQWFDGEMtj0ysI63sMKXj
   XLdRDHbXvMOBOKhzDMDBCZedS6fnohP5Tu3EQHeTxmprOgHbX5ABMB4Y5
   39t7RxY+8DrCcDiX3nfQZPsQGYTnbsDHute3AupRRvcDIFp28s34kSc5t
   ebAA0cTz1fSf7pB0uvFQBaRJSIdqPCZCb99BbhKU6tvT5XVi57HbcBr+S
   c1f/pWTdzH+X93i99ee3VOgFIGB+7P60kdyOFQSP/Ap29/SODIlsVAdu8
   A==;
X-CSE-ConnectionGUID: xfDdajmeS9yDpQbJHF7ghw==
X-CSE-MsgGUID: a53yGAU7T+mBowkRHNYgHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="27572843"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="27572843"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:38:04 -0700
X-CSE-ConnectionGUID: 4r16Da/8RNSJRPL2iE8G8w==
X-CSE-MsgGUID: L9CtQ+afQvipDyErkYAYTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69271303"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2024 19:38:01 -0700
Message-ID: <59fe0bf4-76e2-43cb-84e7-e044c2407c4c@linux.intel.com>
Date: Mon, 2 Sep 2024 10:34:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] iommu/vt-d: Convert to use static identity domain
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240809055431.36513-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 1:54 PM, Lu Baolu wrote:
> Intel's IOMMU driver used a special domain called 1:1 mapping domain to
> support the domain of type IOMMU_DOMAIN_IDENTITY, which enables device
> drivers to directly utilize physical addresses for DMA access despite
> the presence of IOMMU units.
> 
> The implementation of the 1:1 mapping domain is influenced by hardware
> differences. While modern Intel VT-d implementations support hardware
> passthrough translation mode, earlier versions lacked this feature,
> which requires a more complex implementation approach.
> 
> The 1:1 mapping domain for earlier hardware was implemented by associating
> a DMA domain with an IOVA (IO Virtual Address) equivalent to the
> physical address. While, for most hardware supporting passthrough mode,
> simply setting the hardware's passthrough mode is sufficient. These two
> modes were merged together in si_domain, which is a special DMA domain
> sharing the domain ops of an ordinary DMA domain.
> 
> As the iommu core has evolved, it has introduced global static identity
> domain with "never fail" attach semantics. This means that the domain is
> always available and cannot fail to attach. The iommu driver now assigns
> this domain directly at iommu_ops->identity_domain instead of allocating
> it through the domain allocation interface.
> 
> This converts the Intel IOMMU driver to embrace the global static
> identity domain. For early legacy hardwares that don't support
> passthrough translation mode, ask the iommu core to use a DMA type of
> default domain. For modern hardwares that support passthrough
> translation mode, implement a static global identity domain.
> 
> The whole series is also available at
> 
> https://github.com/LuBaolu/intel-iommu/commits/vtd-static-identity-domain-v4
> 
> Change log:
> v4:
>   - Add a new patch to remove has_iotlb_device flag as suggested by
>     Jason.
>     https://lore.kernel.org/linux-iommu/20240807121712.GD8473@ziepe.ca/
> 
> v3:https://lore.kernel.org/linux-iommu/20240806023941.93454-1-baolu.lu@linux.intel.com/
>   - Kevin worried that some graphic devices might still require identity
>     domain. Forcing DMA domain for those drivers might break the existing
>     functionality.
>     https://lore.kernel.org/linux-iommu/BN9PR11MB52761FF9AB496B422596DDDF8C8AA@BN9PR11MB5276.namprd11.prod.outlook.com/
> 
>     After confirmed with the graphic community, we decouple "igfx_off"
>     kernel command from graphic identity mapping with the following commits:
>     ba00196ca41c ("iommu/vt-d: Decouple igfx_off from graphic identity mapping")
>     4b8d18c0c986 ("iommu/vt-d: Remove INTEL_IOMMU_BROKEN_GFX_WA").
> 
> v2:https://lore.kernel.org/linux-iommu/20231205012203.244584-1-baolu.lu@linux.intel.com/
>   - Re-orgnize the patches by removing 1:1 mappings before implementing
>     global static domain.
> 
> v1:https://lore.kernel.org/linux-iommu/20231120112944.142741-1-baolu.lu@linux.intel.com/  
> 
> Lu Baolu (7):
>    iommu/vt-d: Require DMA domain if hardware not support passthrough
>    iommu/vt-d: Remove identity mappings from si_domain
>    iommu/vt-d: Always reserve a domain ID for identity setup
>    iommu/vt-d: Remove has_iotlb_device flag
>    iommu/vt-d: Factor out helpers from domain_context_mapping_one()
>    iommu/vt-d: Add support for static identity domain
>    iommu/vt-d: Cleanup si_domain
> 
>   drivers/iommu/intel/iommu.h  |   2 -
>   drivers/iommu/intel/iommu.c  | 468 +++++++++++++++--------------------
>   drivers/iommu/intel/nested.c |   2 -
>   3 files changed, 201 insertions(+), 271 deletions(-)

Queued for v6.12-rc1.

Thanks,
baolu


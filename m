Return-Path: <linux-kernel+bounces-233881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5012491BEA5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F12282788
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEBD1586D3;
	Fri, 28 Jun 2024 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5H7dNBw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500352E64A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577987; cv=none; b=rZUygNzmhXh74ZJtqToaCls2EQPaGmDHz9cUuCgYp0s2AEszoHVJTdq2hKGIE+Ur5K0kSbgfgl7aLQb3h9Cseuey6CK7tuEJzWQ/BlSFLcCu3fe8T0dfsuFIJ6/7uCvPCaRLRPrn7IENowZtMsCPS35rkLGcgM8ZT+A7jKXM8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577987; c=relaxed/simple;
	bh=iP72sjx0dw/MwgE+xmP0d2ItZCoMMkXEZyU0W+SEO5o=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=p3lZoIsFWKyzsVnG5QsibsR2XNUj0/AuJ+GKZkvHJaaTcfDC/zNqVnlpg3KwxQGGw6+vaAfXgTAbN7KaQAbzwepJgS6iQUvbjEfYXZ7M2qvb4e+yqq3hamUZ9AQHq/4R9ZsVVQCtINpDFnEsKFhnbVQirsKDASG/yDasZThRe3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5H7dNBw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719577986; x=1751113986;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iP72sjx0dw/MwgE+xmP0d2ItZCoMMkXEZyU0W+SEO5o=;
  b=j5H7dNBwT5k8Ju9xJo+tNe0mGaMxEhVwVktQi/ioU9Far072qobBVysA
   lhZnE1PX8swjsCmE/hfsw3Le12ft338q7SQQ2I9rpx0igsSiPgfDm0SOA
   OM5Pjddeu/l4kkKuHE7Ez+2ql6Fmqh91hCI8bnJIqPud5l+m3Gof7r0Z7
   E1QoDwMmQZEh2+w82GhiuyETWo3lRLPXIxLQiG0XXScF3Gsli3QLaWKXX
   NdsLhiukgMrAlVlaV+HLmfirKpH10aIr0ycqJd28rDuWLANxPJ57o/hto
   Y/pkYXNbZCdMM8hJGmJqpb4nALIm7aOPwp7+Prei5QQtxT2VZZbEfPZnc
   Q==;
X-CSE-ConnectionGUID: DI1Je+qvTKSocW8jgDDzkw==
X-CSE-MsgGUID: y/KAE3DzSLKYC3m8YZq+NQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="12299774"
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="12299774"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 05:33:05 -0700
X-CSE-ConnectionGUID: 8ZksAHdgQ3upAMxwF8GTzw==
X-CSE-MsgGUID: rZ8Cq3WYRyyuvf5sMQtcqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,169,1716274800"; 
   d="scan'208";a="44563171"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 05:33:03 -0700
Message-ID: <fbede9a0-cfbc-4782-99c1-803f611c28b1@linux.intel.com>
Date: Fri, 28 Jun 2024 20:33:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, yj.chiang@mediatek.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] iommu: Remove iommu_sva_unbind_gpasid
To: Mark-PK Tsai <mark-pk.tsai@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20240628113011.3535-1-mark-pk.tsai@mediatek.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240628113011.3535-1-mark-pk.tsai@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/28 19:30, Mark-PK Tsai wrote:
> This is a left over of commit 0c9f17877891
> ("iommu: Remove guest pasid related interfaces and definitions")
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> ---
>   include/linux/iommu.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 17b3f36ad843..225403cfe614 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -785,8 +785,6 @@ extern int iommu_attach_device(struct iommu_domain *domain,
>   			       struct device *dev);
>   extern void iommu_detach_device(struct iommu_domain *domain,
>   				struct device *dev);
> -extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -				   struct device *dev, ioasid_t pasid);

Not sure why this still remains there. But it seems not alone.

$ git grep iommu_sva_unbind_gpasid
Documentation/userspace-api/iommu.rst:  int 
iommu_sva_unbind_gpasid(struct iommu_domain *domain,
include/linux/iommu.h:extern int iommu_sva_unbind_gpasid(struct 
iommu_domain *domain,

I believe the document should also be removed.

>   extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>   extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>   extern int iommu_map(struct iommu_domain *domain, unsigned long iova,

Best regards,
baolu


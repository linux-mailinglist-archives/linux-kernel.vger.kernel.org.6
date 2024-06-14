Return-Path: <linux-kernel+bounces-214179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490E8908095
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601051C212CB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 01:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995B11822CF;
	Fri, 14 Jun 2024 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bxvcHYOA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2C8158D86
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718327962; cv=none; b=DDWEnFsj+svdYk7ftxmdxzylyT1XtJ42RyAec6JgjSuM3DgSIviAdz+sAb+PHAwJj2l6xplLs3zKkzc642oeGylVvawqmHUg+qLg84roxZtyfGAIzC9GltcKOP3iAuLaZLONKOmF0H8NijJyzDfRWKxmREi9ErzRBxk1FigRfX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718327962; c=relaxed/simple;
	bh=Y3xFmer/bJb5jwuUcExtgxCX4BjTUCWoKsvdsQB96HE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GbHS/XKAVFtUhDsrcaQvbjUY8rLRZXxxQZB3bN+j/I+TPr4A80rXdLumHg4KbVZ3Z0XMRjQFuUqG9udl04AB2zv7EGDg4wESm9QwHr+YAXYbgImMCJ8KJ44ID2GYSfAzhEiyuBKOdjRCh9Bw1a2cBUiIy8Vh+BvAZFK3VhGzW1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bxvcHYOA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718327962; x=1749863962;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y3xFmer/bJb5jwuUcExtgxCX4BjTUCWoKsvdsQB96HE=;
  b=bxvcHYOA1Cf0+0dGc46OlEDTW11ps98Jl+GcbiRUVZ7m+p4JYmbH2TSR
   7thwNGZafpzmUE64R4RQ7ZQEYcv6RpSpjFEzKiTOYYocQtKukPDYqcTHM
   tdZh8jSTmfOY3BeBsTyZrRbPyB/bu6gU82mFTQjpVG0WtgMwh0HRmBC15
   zQjpm3y2PC0B/tt/PgiRCr8uruY/sFo9I9H10izD0sNNj/jP20uPmJdkR
   W0mfCpygDND4U7tSVez2adlk/085ZcHOlWbfUG6EugQS9J/tZFrUA2yWB
   18cKW3ODA6QrHan7OdPRYnxz2t8wIKwq9UcDJYKTMJyr0MtcxoYs0MFZX
   A==;
X-CSE-ConnectionGUID: y8M6PZSvQyeLLAPqfM4exw==
X-CSE-MsgGUID: y1Ji3HiJS7KOgjZEb16b0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15346722"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15346722"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:19:22 -0700
X-CSE-ConnectionGUID: srtDBUcgR/GMQOGdRXhpKQ==
X-CSE-MsgGUID: B49IlPj3TwGU3zZoYVf2og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40266698"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 13 Jun 2024 18:19:18 -0700
Message-ID: <1a053b9c-6cbf-4b8c-9d23-731b8a22c747@linux.intel.com>
Date: Fri, 14 Jun 2024 09:16:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
 <20240612133732.GW791043@ziepe.ca>
 <013afe9a-756f-4c85-baa1-977bea6be395@linux.intel.com>
 <20240613114948.GA791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240613114948.GA791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 7:49 PM, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2024 at 12:23:17PM +0800, Baolu Lu wrote:
> 
>>   struct iommu_ops {
>>          bool (*capable)(struct device *dev, enum iommu_cap);
>> @@ -600,6 +598,7 @@ struct iommu_ops {
>>          struct iommu_domain *blocked_domain;
>>          struct iommu_domain *release_domain;
>>          struct iommu_domain *default_domain;
>> +       bool user_pasid_table;
>>   };
> Yeah, maybe spell it
> 
>    u8 user_pasid_table : 1;

Done.

Best regards,
baolu


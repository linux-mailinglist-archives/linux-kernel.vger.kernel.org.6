Return-Path: <linux-kernel+bounces-310525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88F7967DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7CE1F2287F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE3224A08;
	Mon,  2 Sep 2024 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDSL4wtu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D151F125DB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244894; cv=none; b=IAZu98wu/kSIJHbgr6Cu+DjNgjKd3MKd/c+KYcGupZdoSODXaewHzyT0yCWpjeqGCV5/cJITDqr9rrjBGzn1apw9Zc5bV6/wFOSTMVO6XB4Fx2FnBzNsyTdkQurTeusJNygF6b3+4kP7dHf7d6foIlTRj0MX7agULCCBekyw3OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244894; c=relaxed/simple;
	bh=fPmbLSUA16Yr1yhBmQ/34GpFWwoHllKNmL+2+w1CtS4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kLOe3aBk370EXEw41btIDSuf7qBKixB7Ooya74Sw+HS4Wg1C90ko3HHatJMfgzTEzp0HxQ06kl7UeHkRtKSP7m4kHn3fALO3PVXW4kqtgF4V+RcFw4YXVR6d/VwUeZCtVUrmT2z4Y9UZwnDuJpd6TxuUq3F5B1ZsBRPBV2XU0NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDSL4wtu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244892; x=1756780892;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fPmbLSUA16Yr1yhBmQ/34GpFWwoHllKNmL+2+w1CtS4=;
  b=aDSL4wtuqIiyFEmyOPVzKmYGD3nrNsADmllbtvv7jAtgg3zxYPqwNGuD
   aVDQy3FxeJ3aEQ8qPcNxlH+REzMVa75DjUgr7tyRXhoKK//spCG6lgLMy
   Q3HnUpF63SVPkTPEzdS9H2k/1Hpzbkvlax/kCtrn6H8R/tbII+ouX9Bdu
   beB4Zq6RZ+hK6l57ZitBeeeATDWBaKKklvBumHxF2+941mq0he93SPhGp
   8+xccuHA63uQODS9nLyV8cBmPlwIbrdMPZ50XpojFqOcqd7aAaTJS87oM
   cXqXt65/F4sHL2BAApz+gLsRQWGzFv5mz897VewyAyjYj/PAAxE1HuYWQ
   w==;
X-CSE-ConnectionGUID: w9j6NHubRbu+dP9xh/dQpA==
X-CSE-MsgGUID: QRKsGQkUTyGaZysrMcL5YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="41292027"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="41292027"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:41:32 -0700
X-CSE-ConnectionGUID: zwbRTF3nTuSsKtEKIkegnA==
X-CSE-MsgGUID: VxX0hpXaSS+gSZ6xa9Yj1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="64826977"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 01 Sep 2024 19:41:31 -0700
Message-ID: <8e9d96af-0a1d-493b-9ad6-154330902216@linux.intel.com>
Date: Mon, 2 Sep 2024 10:37:37 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move PCI PASID enablement to probe
 path
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <20240819051805.116936-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240819051805.116936-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/24 1:18 PM, Lu Baolu wrote:
> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
> attached to the device and disabled when the device transitions to block
> translation mode. This approach is inappropriate as PCI PASID is a device
> feature independent of the type of the attached domain.
> 
> Enable PCI PASID during the IOMMU device probe and disables it during the
> release path.
> 
> Suggested-by: Yi Liu<yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> Reviewed-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)

Queued for v6.12-rc1.

Thanks,
baolu


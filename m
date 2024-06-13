Return-Path: <linux-kernel+bounces-212557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC10906328
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8261B1C21FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 04:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD96F132C3B;
	Thu, 13 Jun 2024 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YT2QtwFa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58852446CF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254220; cv=none; b=J1JGzNRYCKNiXYd7I89J2lMG7CRMmiG5DOamsJEwh0NVOvgCVkI0UZ3zqxyMp0qYgx03ZLr7kQTB2fnykPNbR+gsoqgyjTT5e4ChkH1UX/4nFBDXEPg25wGRZq8N2hkGqc83QpnWchadoum93lud6OT5mQQQJdCV684F8pa1sQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254220; c=relaxed/simple;
	bh=CZrtrf8crQja7wO1mkA1ifii1KCTrpRJ1BM17B9Ba/8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fYrwUVNw7kCKzz9LcLXQ+K5Yrktv8MjIqpFR4JtmpIkEHdPfb5HddLuArpMkGSkzKsuCxWRiZnpJ1+0WoXmc9/yxfIQQ3dpEHuY1+i++RwvWqRoMtxBBe+Vu4BwTTXIoSPSoIYIyt8rZIiaTRnZyiRppKqsCa28WQaJMG187QeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YT2QtwFa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718254218; x=1749790218;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CZrtrf8crQja7wO1mkA1ifii1KCTrpRJ1BM17B9Ba/8=;
  b=YT2QtwFah9d1Io/sU8f/zpoJMHNGyjnrUkhbsU9a26yJt51mCsh1QGkJ
   42QTzFuFflK6R0LwviJOKfbH4RfxV6ZnpWQP7E/urnHeiNAl0bWTmjzWt
   bxPWgw8iq4uSJ102PQjBkFJQ6r++pQIiZWDas/TTgvMBAzOYEIMO71tKX
   pcyLg4cF6s5rlnrgAWMFHADArOKwD0zZe4cRGib2JRoTGYZh+OPHymb7n
   N3+Zugik7ILkMvbSYUCnu3l41xrqSXKfxmOq5Yq7GXV8YrfBNFMErnoDq
   R6o/el+DP9xfxYXILrFbfSGyI7ZhukxTDFA2N2p+ZGHOIgqnuZZMwkgO+
   Q==;
X-CSE-ConnectionGUID: /S0QqsOoR7m+Ys14LA61Mw==
X-CSE-MsgGUID: Y1kVRwkVQ7OnV+ZyF0NPoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12047529"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12047529"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 21:50:18 -0700
X-CSE-ConnectionGUID: x5UnoJ9AQvmH++aW966J8w==
X-CSE-MsgGUID: eiM8bmmaTjywYF1Vu6P/KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44968157"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 12 Jun 2024 21:50:15 -0700
Message-ID: <bc702b48-627f-4145-8c9b-684880a73edb@linux.intel.com>
Date: Thu, 13 Jun 2024 12:47:55 +0800
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
Subject: Re: [PATCH v6 04/10] iommu: Extend domain attach group with handle
 support
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-5-baolu.lu@linux.intel.com>
 <20240612134120.GX791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612134120.GX791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:41 PM, Jason Gunthorpe wrote:
> On Mon, May 27, 2024 at 12:05:11PM +0800, Lu Baolu wrote:
>> Unlike the SVA case where each PASID of a device has an SVA domain
>> attached to it, the I/O page faults are handled by the fault handler
>> of the SVA domain. The I/O page faults for a user page table might
>> be handled by the domain attached to RID or the domain attached to
>> the PASID, depending on whether the PASID table is managed by user
>> space or kernel. As a result, there is a need for the domain attach
>> group interfaces to have attach handle support. The attach handle
>> will be forwarded to the fault handler of the user domain.
>>
>> Add some variants of the domain attaching group interfaces so that they
>> could support the attach handle and export them for use in IOMMUFD.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu-priv.h |  8 +++
>>   drivers/iommu/iommu.c      | 99 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 107 insertions(+)
> I don't have an objection to it like this, but I wonder if we could be
> smaller to teach iommu_attach_device_pasid to use IOMMU_NO_PASID to
> attach the handle to the rid?
> 
> It would have an if there to call the  __iommu_attach_group() instead
> of the pasid attach ?

This is a good idea. I guess that in the future, we will have
iommu_attach_device_pasid(IOMMU_NO_PASID) to replace
iommu_attach_group(). The group->domain and domain_ops::attach_dev will
also be removed.

I'd suggest making such refactoring in a separate series with wider
discussions. For now, let's make this special interface for iommufd.

Best regards,
baolu


Return-Path: <linux-kernel+bounces-516039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C84EA36C51
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5EE7A4782
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 06:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5016CD1D;
	Sat, 15 Feb 2025 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bc9VwDy5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF1C2ED
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739601334; cv=none; b=Jk7LI78whO+dOiPO59gDbvJ6qV/4cTN4PK0MP7cT4eVh0D5BYRixt05xPIZL9OFOloEN0Xo2eRS4J7RKPLjD+3i7r1Y49XG/cfwiSPJn1AsHdb40p66KNGcOeItqjTy0D4LFZAoweJypffHbmmoa1ds8ytEqQUx6DAXh6h3HEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739601334; c=relaxed/simple;
	bh=iF+zpsw/w3yis5jYA8csklSC8c6chkrdzn9KEliIO6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3MF5kaa4vXowZcUcHnH1mc7FfHhuntI399gRpMIwcgkZ43byyqcro2V3gJzqlyI0zDKOe8PJsY691VnB5Dm3s/BSA5ZDx5KsYLqztdeZ2jTjizTi31a5nCDqguM1FTsrF4aphcc4aKLPjLw+G2Vj/t+CxVjPu7po+B3kQVpPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bc9VwDy5; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739601332; x=1771137332;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iF+zpsw/w3yis5jYA8csklSC8c6chkrdzn9KEliIO6s=;
  b=bc9VwDy5Vk281UezAgmVCj/3KqSDP4WbfvIn/lVHucgzLlGtcZLvnaOQ
   dXLgmirPK3Bwfj3ahsJPpzNgMAy2VRAzYSx77mSDe/oj7nk2VuKhstbTp
   PC6jU8/QYWY9OYwnoe6YwArz04DmHd4Eyrz0zqQ0NubZg1ZjtqjpUP+ne
   SNmPXuXHuYjysy2PNRR40UZMNKBChlrspU0ovH6koP4b6+mMool8OsM/j
   MZAAmmLX2KissXtm8QcqCKRRG1sCW+VHFQgVnwvuapChrU1/XDoEUmj2E
   O0vxUhJGBjijVNgTGpDaxU7JZYD5WPN0qqg/3eW+elDkbCiND2VXQVcYY
   w==;
X-CSE-ConnectionGUID: b4M5sCr7TLueaRVFYqH6nw==
X-CSE-MsgGUID: jn8Re0Z0R0OYPLqrt31YSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50568120"
X-IronPort-AV: E=Sophos;i="6.13,288,1732608000"; 
   d="scan'208";a="50568120"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 22:35:31 -0800
X-CSE-ConnectionGUID: uD3zkcvZSyyHBEeaPCN6WQ==
X-CSE-MsgGUID: gNIFc69yT+qM+cM1EqglsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118271208"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 22:35:28 -0800
Message-ID: <4ee09fd2-92c6-4295-88ca-1cc061135417@linux.intel.com>
Date: Sat, 15 Feb 2025 14:32:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] iommufd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
 Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang <wangzhou1@hisilicon.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-12-baolu.lu@linux.intel.com>
 <Z67rghQyQrjb5sT1@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Z67rghQyQrjb5sT1@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 15:06, Nicolin Chen wrote:
> On Fri, Feb 14, 2025 at 02:11:03PM +0800, Lu Baolu wrote:
>> The iopf enablement has been moved to the iommu drivers. It is unnecessary
>> for iommufd to handle iopf enablement. Remove the iopf enablement logic to
>> avoid duplication.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommufd/device.c          |   1 -
>>   drivers/iommu/iommufd/fault.c           | 111 ++++++------------------
>>   drivers/iommu/iommufd/iommufd_private.h |   3 -
>>   3 files changed, 28 insertions(+), 87 deletions(-)
> This is in conflict with my fault patches that Jason just took
> a couple days ago:
> https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/? 
> h=for-next
> 
> I think it needs a rebase, perhaps on the branch mentioned here:
> https://lore.kernel.org/linux-iommu/20250213150836.GC3754072@nvidia.com/

Yes, sure. I will rebase it in the next version to avoid the conflict.

Thanks,
baolu


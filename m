Return-Path: <linux-kernel+bounces-175244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DED8C1CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DE21C21AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC840148FFA;
	Fri, 10 May 2024 03:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwYtapUI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C3413BAC8
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311307; cv=none; b=pTtqhQfOvZUXKuHHAbq0MrbHiyAaCfZ/cAXUy3jWvcZobwvgDX5jgvWZAD8wo4h9PhqR7aFKdpmP3jthusxsPpXewlam9Klo4YYhYYH2udqpsfR/HhPF1x7uFb3S5ZxWlY9EfOuqHf4CnAb8JTTQ/D7yQbzFFJp8F+xKfa7MKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311307; c=relaxed/simple;
	bh=fPVJrhZEYUI+SsesiqExa8OII6CVAsM+KT62Fck9Rik=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XWp3e3HyJl2IR+/N3orX0UuzsAMXkUmbSkew+vznCX+/0iSbSRxd19lb+FxQoJ4dzY6peAVkPOQlW5dZbN66zmZYls1JTKG8ekvKthmCbuo+ZkrrkfJE8L4NHTWsSqYrJlSAsenpPezWXrWRjcZSuG6qM4TEFblhMzHbrKe/l4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwYtapUI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715311306; x=1746847306;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fPVJrhZEYUI+SsesiqExa8OII6CVAsM+KT62Fck9Rik=;
  b=cwYtapUIRgOwOvmS38gvP5rJe2sPKgCCzduGze99No588eJ5w30RJL9w
   7+L/zSUzdHF5NSVFrAjLkDOJU6f1hRGkZDLiL4I03w86j8sZvBq8FjgYC
   1HJISANcYn6l6LrPdxJQrHnsOCsTbKhdLVQKvW22T7wr7n1GOxojHfVWZ
   uOaPJt2WMoJ5HW4D7H/WGAcS4PX6VagbuqI3wL1EJm21cXbq1R+l2wp0L
   A7NJGrEIb2dMgnh2T6dwUQ0FK3YXRBXxkYjiY+kdwGkFVLeGZGJXa9ygG
   wAFcPOFe5Jrx+9458HnCqIFHBnrha2CU0yo/u2Jrkb/sFkzLeNIrCLiiI
   g==;
X-CSE-ConnectionGUID: bNUO8NfQQ5yrMOtxWluUog==
X-CSE-MsgGUID: 9TX/Rk4YQF+DZpZX/bRrpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15081466"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="15081466"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 20:21:45 -0700
X-CSE-ConnectionGUID: eSsYCvnLScGnz0BLJXcK6w==
X-CSE-MsgGUID: XpWBGYUJTx2MnxFq6z+pUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29531328"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 09 May 2024 20:21:42 -0700
Message-ID: <065cfc43-b164-4817-9be7-8f37585742ec@linux.intel.com>
Date: Fri, 10 May 2024 11:20:01 +0800
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
Subject: Re: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
 <20240508001840.GO4718@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240508001840.GO4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 8:18 AM, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 10:57:07PM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
>> index 13125c0feecb..6357229bf3b4 100644
>> --- a/drivers/iommu/iommufd/fault.c
>> +++ b/drivers/iommu/iommufd/fault.c
>> @@ -15,6 +15,124 @@
>>   #include "../iommu-priv.h"
>>   #include "iommufd_private.h"
>>   
>> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>> +{
>> +	int ret;
>> +
>> +	if (idev->iopf_enabled)
>> +		return 0;
>> +
>> +	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
>> +	if (ret)
>> +		return ret;
>> +
>> +	idev->iopf_enabled = true;
>> +
>> +	return 0;
>> +}
> I would greatly prefer we remove this from the drivers :\ I guess it
> is Ok for now
> 
> Doesn't this need a counter? We can have many fault capable PASIDs?
> That will get changed in the PASID series?

Okay, let's design this more gracefully after the PASID interfaces are
landed. For now, we assume that the device driver will do this.

Best regards,
baolu


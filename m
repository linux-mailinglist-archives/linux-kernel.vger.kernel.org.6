Return-Path: <linux-kernel+bounces-173038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2588BFAA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0581C22070
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511DC7F47B;
	Wed,  8 May 2024 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGfwL3Ek"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2752179DC5
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162714; cv=none; b=udQvYR/FJBf29roPs4t94r5Uv0xRQYY0pSzhJTp7uMETW7r3+gXeE2sfK42LT8qMA0HYn8NsVlEXCT0/8Xd6G0H7WN8nvgNomskGfftWP0ZosBRDHclNSwT8ogX1ulGyxjLKHRn0c5b1DnK0oHlxggzg46yQ+aH+FKveTVvqGdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162714; c=relaxed/simple;
	bh=G4McmKXGrbsG7hhqIl363OQbT8PymU5AYalg5sCJHdc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kfNKtS6dvpSbXeRUV/T2Zr5KisVHdyfSy8wvW4VlAhQRnJwCjySTAYaOVrMhoJIf8bQvF3fVxCRIV3ba3M2TO21E/Pb7LWWa2/GJ7Hxc8R5EhM/r017SjS8YngVkAxQfx/1hCBCMVEvZkNM6govaNacrcJiSrJL+egghbnILNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGfwL3Ek; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715162712; x=1746698712;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G4McmKXGrbsG7hhqIl363OQbT8PymU5AYalg5sCJHdc=;
  b=FGfwL3Eky2Zk2uHmD7AEG5zOTC6z0hXYr6hGu11l8bcqXINv3eSNDOxZ
   ZVSldpjfsMXzew+OH+jzzRI8XUCfRqZjnUMoQh+yTuUlQCbU2ofHBwqVr
   9SsSNv4v1EN29uLKKo4UfbHTG2pBwt+NWKzI9uL1SU9mmcWy7IHmZeCMl
   s/vL3ndf1YARV8FcMElx+8xbG2dnF4HlsdXosNCkYjPyNKWo3qe6cSJTb
   lpAj0OnzyqwKd0SAqer+24cV1MKzB0hByy7OTF9nYv9HuSf8Az4xOoBYn
   kB+UM2WjSwEaP73cDvUGPWOgzFdBihiqXGYgFSiNurtBZKhexK/IyolYq
   A==;
X-CSE-ConnectionGUID: Qcr/ruMjSguXuTxIXyo2lQ==
X-CSE-MsgGUID: IxrDbhUYSGGaVZpgXVtIXQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="22404979"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="22404979"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 03:05:11 -0700
X-CSE-ConnectionGUID: kMX3erAoQoGyrL1Vb2FspA==
X-CSE-MsgGUID: qnk/TkvhR0edV/MFwBNYEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; 
   d="scan'208";a="28778593"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2024 03:05:08 -0700
Message-ID: <a03d3bf6-0610-427c-bf2a-5f6c410e220e@linux.intel.com>
Date: Wed, 8 May 2024 18:05:06 +0800
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
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <20240508001121.GN4718@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240508001121.GN4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/8 8:11, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>> index ae65e0b85d69..1a0450a83bd0 100644
>> --- a/drivers/iommu/iommu-priv.h
>> +++ b/drivers/iommu/iommu-priv.h
>> @@ -36,6 +36,10 @@ struct iommu_attach_handle {
>>   			struct device	*dev;
>>   			refcount_t	users;
>>   		};
>> +		/* attach data for IOMMUFD */
>> +		struct {
>> +			void		*idev;
>> +		};
> We can use a proper type here, just forward declare it.
> 
> But this sequence in the other patch:
> 
> +       ret = iommu_attach_group(hwpt->domain, idev->igroup->group);
> +       if (ret) {
> +               iommufd_fault_iopf_disable(idev);
> +               return ret;
> +       }
> +
> +       handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
> +       handle->idev = idev;
> 
> Is why I was imagining the caller would allocate, because now we have
> the issue that a fault capable domain was installed into the IOMMU
> before it's handle could be fully setup, so we have a race where a
> fault could come in right between those things. Then what happens?
> I suppose we can retry the fault and by the time it comes back the
> race should resolve. A bit ugly I suppose.

You are right. It makes more sense if the attached data is allocated and
managed by the caller. I will go in this direction and update my series.
I will also consider other review comments you have given in other
places.

Best regards,
baolu


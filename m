Return-Path: <linux-kernel+bounces-212651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD55F906456
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592DFB22DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4C4137C4B;
	Thu, 13 Jun 2024 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MGAgzDHQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E497137924
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261227; cv=none; b=iiopnBMonBYtHlsuR8By0ctIOrkCNvvr4EKTX9YAxe4orQDq+dpDTtXBu3CUhvH952r8do2ME1QQBolzyHB+xo/NhNvfilmm0gnmLwT/5aDhnXRMhloUc3rXcW8gqJHLpJTFwXYbHUw5LIBrpdqTWO90rf8MmQJKx1uK4Oip1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261227; c=relaxed/simple;
	bh=hKFBgo1zxsvPe2XZH3PZju070f1XZgJSoxjnv76xuss=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IdZ2riujQqaHYhQ3IR1zzTu1ig3X3UqeYWYqBjc6AjuYYYiE01vX5nqEgtmk4whB5sNxI338NyipXvGHBCfHgtJgOdvn0lDxO8x7LAuNo1m7ZMBPBZGD/oBygEbxPZEBbPXUldG2luPhJm0ul11nt8F2l3Rmroj85A/LI/hzPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MGAgzDHQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718261226; x=1749797226;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hKFBgo1zxsvPe2XZH3PZju070f1XZgJSoxjnv76xuss=;
  b=MGAgzDHQwGD0TqrbxdBJvXDDNr104kWZKZSmD2d2nwoF/REuOjALJkfg
   8JZOol0ddOOwFPeGyN3cWsQInMAAAcGKk1bazqzthJ7xCP4GSrtJ1PiMg
   jFUwnqn6PHqSJsJk8R22GMBcKMI9lc0SLvsR5MEMS830bPLFz8Jbhwx+8
   LFL8Ed8zzcJNEbMskJCe7xok8jPe7if3Tsln45rlG5Ehd2fcR2Me+yWxu
   9mURx/Z6E4BRV0I2zv12XaDoqHYPk+MWqJFVBXEK3TrB1xzBSfGMPNPbg
   R6nyuU5Vle5vvSKF7/q8JFMGXfOWX/fyAJV0G58k9ru7e+H1Fuk85lPWL
   w==;
X-CSE-ConnectionGUID: cftHbgbJTBKl4r7ZTh+VQg==
X-CSE-MsgGUID: Szm8+iUTQaK0ZVcyAp0Kfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32546796"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="32546796"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:47:06 -0700
X-CSE-ConnectionGUID: HnzvIUYeRd2KKrf3gOlWZw==
X-CSE-MsgGUID: yKKRf0CPSI6AvloXzCwYhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40149228"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa009.jf.intel.com with ESMTP; 12 Jun 2024 23:47:02 -0700
Message-ID: <75d459d5-1d04-4d10-bc04-71ea83e55ccc@linux.intel.com>
Date: Thu, 13 Jun 2024 14:44:43 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 06/10] iommufd: Add iommufd fault object
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-7-baolu.lu@linux.intel.com>
 <BN9PR11MB527615EC664698C340A0CA878CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a17113d3-500e-45ef-a2d2-747d890c9c5e@linux.intel.com>
 <20240612132531.GV791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612132531.GV791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:25 PM, Jason Gunthorpe wrote:
> On Sat, Jun 08, 2024 at 05:58:34PM +0800, Baolu Lu wrote:
> 
>>>> +static int iommufd_fault_fops_release(struct inode *inode, struct file *filep)
>>>> +{
>>>> +	struct iommufd_fault *fault = filep->private_data;
>>>> +
>>>> +	iommufd_ctx_put(fault->ictx);
>>>> +	refcount_dec(&fault->obj.users);
>>>> +	return 0;
> 
> This is in the wrong order, dec users before ctx_put.

Done.

Best regards,
baolu


Return-Path: <linux-kernel+bounces-183322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE68C97A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 03:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB3281761
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE4B6FC6;
	Mon, 20 May 2024 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKaxybCj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925DA367
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716168365; cv=none; b=FgjH5e43d6Ymc2juwRnvsiOgn97k6r1x9OBnW2vm547mw5M82CBeRu8U532wrMDWvuDz9MfOZ/70W2tZ0iMffBuBGPGNV5yyL+OC8+1f+y2VHc+Sj3tp1RuoPqBaibPRpM+jG4i0Dsbdzm2q3cBLsbE16cCKUnvjG1wuaxf6HoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716168365; c=relaxed/simple;
	bh=TtwtjcXrrA11KTveXffexyVsNN0b1pCRGDvph290NUQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tp7XDYyHMVrCvDmrM+ewDlAdIb4w0kn9dKBq/UNP5pbxhi2kk5DgA3ojcuo4t3tRwEP9h7hDQ05ToMR1wMiZYHDdCa7UZXimxR9VQ/kEF8cP+NUcLUJ8H5zdFVyFPT7ObC5yAbERlA0W/iM0+OaQNAKMdtGb51L/MCa4aGDwyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKaxybCj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716168364; x=1747704364;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TtwtjcXrrA11KTveXffexyVsNN0b1pCRGDvph290NUQ=;
  b=iKaxybCj5OqAkxvTzBC7AXSpbhYxkGxiT5dvqURUO3348U9qR/AXeptN
   K9/Q+BxLb+zBoh5XdscFlbMSaQSiZImeiVpt0e8878EFSr5IuKRImim8w
   0JfEjT+arQ2VpokWiw1+7zE9aoBZH2Jn/rWzavBz+c1uvxv3DHE8NYgXb
   Ez1o7WS/WrUDbLkrMZEf4Cu1tXrzmGJs0H86KQPfhR5HHy1epwIoq5rDa
   LKpeUFG4NtdUnTYTl2K1y4C45fMKu6N0JCzxejW0eo/sh1eScblLAgGYZ
   86fttRji4l6wn/+mC591j5xucuYLLsxbGMMB5dx0XNdoWw4jSpT8g0I1c
   Q==;
X-CSE-ConnectionGUID: GuknArGuStW0lYxIE6r0tA==
X-CSE-MsgGUID: NOqtds/cSQmQsKjXxG1/gw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12498183"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12498183"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 18:26:04 -0700
X-CSE-ConnectionGUID: SI+sGxD1SaWg/GFY7brOWg==
X-CSE-MsgGUID: db5ZHzgxSsuIxnX9A7ZDYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="36786047"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 19 May 2024 18:26:01 -0700
Message-ID: <79bacf16-dfa6-42c7-b02d-117985e38472@linux.intel.com>
Date: Mon, 20 May 2024 09:24:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 4:37 PM, Tian, Kevin wrote:
>> +static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user
>> *buf,
>> +					size_t count, loff_t *ppos)
>> +{
>> +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
>> +	struct iommufd_fault *fault = filep->private_data;
>> +	struct iommu_hwpt_page_response response;
>> +	struct iommufd_device *idev = NULL;
>> +	struct iopf_group *group;
>> +	size_t done = 0;
>> +	int rc;
>> +
>> +	if (*ppos || count % response_size)
>> +		return -ESPIPE;
>> +
>> +	mutex_lock(&fault->mutex);
>> +	while (count > done) {
>> +		rc = copy_from_user(&response, buf + done, response_size);
>> +		if (rc)
>> +			break;
>> +
>> +		if (!idev || idev->obj.id != response.dev_id)
>> +			idev = container_of(iommufd_get_object(fault->ictx,
>> +							       response.dev_id,
>> +
>> IOMMUFD_OBJ_DEVICE),
>> +					    struct iommufd_device, obj);
>> +		if (IS_ERR(idev))
>> +			break;
>> +
>> +		group = xa_erase(&idev->faults, response.cookie);
>> +		if (!group)
>> +			break;
> is 'continue' better?

If we can't find a matched iopf group here, it means userspace provided
something wrong. The current logic is that we stop here and tell
userspace that only part of the faults have been responded to and it
should retry the remaining responses with the right message.

Best regards,
baolu


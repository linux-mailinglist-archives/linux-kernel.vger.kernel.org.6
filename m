Return-Path: <linux-kernel+bounces-183353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6478C97E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBCA1C21556
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3859BA47;
	Mon, 20 May 2024 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eg3+9A+8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B9C79EF
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171646; cv=none; b=EBWIcWYcDANIxueEDW7WnpSTmf426H/LplnUoXTOIBfulKfBQvTUnlHLTDU0b/y1rBK2KRiPyXvXTJfq9SbzZs9QVXO1nUfUbe5QA19SF87eZfNg/7Y455+Sl9XuQqiTQN7QE+InezFm/nTv/HunGvwcMRiLMfKZmKntF5fpBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171646; c=relaxed/simple;
	bh=HmTOhh9HFJBHTh79UxzuMR2rO3zHP4siktUZD+OBd/0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X4sr5oCjIjfZayUUaI+N+HPEWQJs4Nh5qCXSivNUdV2QPyOpkS6V/5anf1dTnFXNibnTYp445sS1uFOgr7/Td4pYvunUH6WstbvUyv8rylDs12mAKpIGUVFMbOacWq5Pw7KQjLuIO/MH925DQQHnfXr4tIPdPuzsAqTZNcZYSDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eg3+9A+8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716171644; x=1747707644;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HmTOhh9HFJBHTh79UxzuMR2rO3zHP4siktUZD+OBd/0=;
  b=eg3+9A+8l6zG3oTAQ8rqWyRQtb2CFll4IxSiZ0OfGEamOH0mPp81vZIG
   Dtz6MD9jcoF7qgbW7D6KehKD9UHQb0Cku9SIrwQotAuS+UPPBCsnTE5Jp
   DG0Z2x0OSyXS0kaTiGti+Y3OUyaoXSQoFp7wa1UQr8F/lOzjd53mg8Q+w
   7wjVDIzOk0hwVssMYEmIPP+uPbC7myCwxpyWDcCn7WcDW6s1JClrKjTnD
   n28OQhs1Ml83s5UJl7RJZiyVj8e1xuUbozAYL5XavMniCnY/ddWHrOdcd
   aXYao8wcIRtuh0maFEPdBu/ilQ8apfB7KeOipROI+k/7aU0exglqomHr0
   Q==;
X-CSE-ConnectionGUID: mQFIdrUURomTEnX5ZofhsA==
X-CSE-MsgGUID: 86JrXgsQTC+vharbcfkqCw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12466669"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12466669"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 19:20:44 -0700
X-CSE-ConnectionGUID: 0+13nvqtSJi+hGLjcBYcKA==
X-CSE-MsgGUID: I4mEjD1XR6mn5Z5VCt6elQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32286015"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 19 May 2024 19:20:39 -0700
Message-ID: <b09f96db-8451-4de9-81c5-312cffdfd4fc@linux.intel.com>
Date: Mon, 20 May 2024 10:18:49 +0800
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
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 4:50 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>>
>> @@ -227,7 +233,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx
>> *ictx,
>>   	refcount_inc(&parent->common.obj.users);
>>   	hwpt_nested->parent = parent;
>>
>> -	hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
>> +	hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
>>   					      parent->common.domain,
>> user_data);
> 
> it reads slightly better to clear the fault bit and still pass in flags.
> 

Done.

-       hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
+       hwpt->domain = ops->domain_alloc_user(idev->dev,
+                                             flags & 
~IOMMU_HWPT_FAULT_ID_VALID,
                                               parent->common.domain, 
user_data);

>> @@ -308,6 +314,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd
>> *ucmd)
>>   		goto out_put_pt;
>>   	}
>>
>> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
>> +		struct iommufd_fault *fault;
>> +
>> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
>> +		if (IS_ERR(fault)) {
>> +			rc = PTR_ERR(fault);
>> +			goto out_hwpt;
>> +		}
>> +		hwpt->fault = fault;
>> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
>> +		hwpt->domain->fault_data = hwpt;
>> +	}
> 
> this is nesting specific. why not moving it to the nested_alloc()?

Nesting is currently a use case for userspace I/O page faults, but this
design should be general enough to support other scenarios as well.

Best regards,
baolu


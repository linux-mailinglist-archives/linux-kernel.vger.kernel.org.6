Return-Path: <linux-kernel+bounces-277318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7142B949F33
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9430E1C22B97
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F760193078;
	Wed,  7 Aug 2024 05:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="My6lnOYo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57917192B73
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723008915; cv=none; b=Romirsa0RlmHDxu4WJ/hSRyLbj2va+mXwgbDH/fJwWf6oVNW6DDFvvIJK46CSeBa/6avyT6FsZXa2QONjvJqZe8MSAyI1ksHrpPBpVPqOy0aVGJPPnAlepRE2fn/RYf0uCWjs8hYYqWXIXfstxrrXMKJwBtL+GDIqHvKUpPw7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723008915; c=relaxed/simple;
	bh=hGVnw0pu3bPOom0FlMmVfOfs7KNbrtqDnyGrJinkMHE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=efuvLSYY53vudaEI2OXk2O8M+G4pj1RwCF0BH6Fcv3pmSnhJcqPqPpGgfeJdcrhx1N8WwMjkG/yWBKUTPfH9DMXwXvwjDMheqbMoGUMncYCVi0Mibncjazaw2Qjw2GhnA2OswtU1u2ioKJOoeYd8cYSm1vbxT1pi09MgfXf6KS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=My6lnOYo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723008912; x=1754544912;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hGVnw0pu3bPOom0FlMmVfOfs7KNbrtqDnyGrJinkMHE=;
  b=My6lnOYoBpZ/a9o/me8e+bLz4BV6nWzgJODflmumHdbFqX3C6cHWRC0y
   zHU3U2KsoRdGtGpWmhD5UFO3usPbQPui44EhyjR3PzkG1dB29SMh0Ky+p
   TCp6z3Cp6WXwvKn3bI94iSz9q5if++SPGtWimNsKB9ITFMvIQEOE1kFOs
   0D0LoR/bFsCPtCHxBCOUbVa4PPw0Jx5yWdDT699UXHo4hPA95BMUO6j7a
   EUofM7PkvV1eZPrkqTSufeY2WwFbEqKl+yB6FVnjZkDzj3ttT9MJToh+M
   cGJbQh/P3UpPgfRLXoEsYhrXWlzzoqmE5VDYiDaR7EOJKrntC5moP/sD+
   Q==;
X-CSE-ConnectionGUID: wCMa+Ie/Sey1Y6oATPCbFA==
X-CSE-MsgGUID: oS71XXBhTSuk5m0sEJYESA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38567742"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="38567742"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 22:35:10 -0700
X-CSE-ConnectionGUID: UHCp/JICRoOljhNN5St32A==
X-CSE-MsgGUID: +FbrnZteQeqM/PO8cAPXGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="56956181"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 22:35:06 -0700
Message-ID: <315e95d4-064d-4322-a9d3-97e96c013b4d@linux.intel.com>
Date: Wed, 7 Aug 2024 13:35:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
 Kunkun Jiang <jiangkunkun@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
 Michael Shavit <mshavit@google.com>, Mostafa Saleh <smostafa@google.com>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 wanghaibin.wang@huawei.com, yuzenghui@huawei.com, tangnianyao@huawei.com
Subject: Re: [bug report] iommu/arm-smmu-v3: Event cannot be printed in some
 scenarios
To: Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com>
 <7d5a8b86-6f0d-50ef-1b2f-9907e447c9fc@huawei.com>
 <20240724102417.GA27376@willie-the-truck>
 <c2f6163e-47f0-4dce-b077-7751816be62f@linux.intel.com>
 <CAN6iL-QvE29-t4B+Ucg+AYMPhr9cqDa8xGj9oz_MAO5uyZyX2g@mail.gmail.com>
 <5e8e6857-44c9-40a1-f86a-b8b5aae65bfb@huawei.com>
 <20240805123001.GB9326@willie-the-truck> <ZrDwolC6oXN44coq@google.com>
 <20240806124943.GF676757@ziepe.ca> <ZrJIM8-pS31grIVR@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZrJIM8-pS31grIVR@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/6 23:58, Pranjal Shrivastava wrote:
> On Tue, Aug 06, 2024 at 09:49:43AM -0300, Jason Gunthorpe wrote:
>> On Mon, Aug 05, 2024 at 03:32:50PM +0000, Pranjal Shrivastava wrote:
>>> Here's the updated diff:
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index a31460f9f3d4..ed2b106e02dd 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -1777,7 +1777,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>>>   		goto out_unlock;
>>>   	}
>>>   
>>> -	iommu_report_device_fault(master->dev, &fault_evt);
>>> +	ret = iommu_report_device_fault(master->dev, &fault_evt);
>>>   out_unlock:
>>>   	mutex_unlock(&smmu->streams_mutex);
>>>   	return ret;
>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>> index 0e3a9b38bef2..7684e7562584 100644
>>> --- a/drivers/iommu/intel/svm.c
>>> +++ b/drivers/iommu/intel/svm.c
>>> @@ -532,6 +532,9 @@ void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
>>>   	bool last_page;
>>>   	u16 sid;
>>>   
>>> +	if (!evt)
>>> +		return;
>>> +
>> I'm not sure this make sense??
>>
>> The point of this path is for the driver to retire the fault with a
>> failure. This prevents that from happing on Intel and we are back to
>> loosing track of a fault.
>>
>> All calls to iommu_report_device_fault() must result in
>> page_response() properly retiring whatever the event was.
>>
>>> +static void iopf_error_response(struct device *dev, struct iommu_fault *fault)
>>> +{
>>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>>> +	struct iommu_page_response resp = {
>>> +		.pasid = fault->prm.pasid,
>>> +		.grpid = fault->prm.grpid,
>>> +		.code = IOMMU_PAGE_RESP_INVALID
>>> +	};
>>> +
>>> +	ops->page_response(dev, NULL, &resp);
>>> +}
>> The issue originates here, why is this NULL?
>>
>> void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>> {
>>
>> The caller has an evt? I think we should pass it down.
> Hmm, I agree, I don't see `iommu_report_device_fault` be called anywhere
> with a NULL evt. Hence, it does make sense to pass the evt down and
> ensure we don't lose track of the event.
> 
> I'm assuming that we retired the if (!evt) check from intel->page
> response since we didn't have any callers of intel->page_response
> with a NULL evt. (Atleast, for now, I don't see that happen).
> 
> Lu, Will -- Any additional comments/suggestions for this?

No. If evt is passed down in the above code, there is no need to add
such check anymore.

Thanks,
baolu


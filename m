Return-Path: <linux-kernel+bounces-175238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8D08C1CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5172B20FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB5E1494C6;
	Fri, 10 May 2024 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZuWgeuR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1F5490E
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310967; cv=none; b=P1Z24nF4ZAt1XHRteWVheaDk3fk1y2XiScHq3ohr2wuEr83P2xyjORTd/JY+Qew4fbvndnLenY2n4qno78VO91m4Lw2IEJpb6mWkZytFp/8dz9CXlFlD8alYs+UkftVR0/c7owcSBVZQXXH+cYnUCUxwsCUHD+FAvfx/HJ9xFo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310967; c=relaxed/simple;
	bh=pDWGi20NXI+FF8nL+CvvJf3mfQcL2cl7VqETYXjiX7k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K9IJkbElcDbflOtwQkqKyDr+lar6XKrW8nZ9Zsc96nQm5azyxKkwiX8pv5Il02U/wMmkcAiKmAqAqXdWhg63T2D8jtnZgU572fQAhiQotwInuqqvODif4XZndlHeSmf4L6oXq+xZIo5EEMaH1KOCxUpsuEOZdF5328txGLvlnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZuWgeuR; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715310965; x=1746846965;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pDWGi20NXI+FF8nL+CvvJf3mfQcL2cl7VqETYXjiX7k=;
  b=SZuWgeuR4IZhr7+ndlRpQ8W+cf/zg8kUP0sJ8KGpP2i/7eHij+o8pWdr
   soc/aM2fQ9PREYZmaf6zzkW5nrKNe8OctPrNOAuqTkZxNfgWhq5dzJ2fP
   Mk+mDb3xGp9kKaYK5GclbbbcA0tI9e8gv9RYiUtnwlbLBFg5k8QOeEMR6
   Uju1l1xhKnEQ5SelP0xd15NFDDW/ovsgLTWx/PZP9mAUW3FKM6CELzzQw
   MkybSeJiywN8CkjKU1wiRGGpzl8kurjhGPVuXJ9mwzB0ZcrwknCDGQQQy
   7beaCfELnhzsQBT87//XAUkvPpB7NIf9ftx4VZYk0wTyNw2OvSCknL4oN
   A==;
X-CSE-ConnectionGUID: a0QywTKbQC645POPEu8y5g==
X-CSE-MsgGUID: kwfYdp1mR3ClG9o/H4qtEw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11209002"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11209002"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 20:16:05 -0700
X-CSE-ConnectionGUID: 6k3t8mu3T5CHeD2PV0HUGg==
X-CSE-MsgGUID: yA5s8BzaQkajU6Im3Oq7sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="34324289"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 09 May 2024 20:16:01 -0700
Message-ID: <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
Date: Fri, 10 May 2024 11:14:20 +0800
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
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240508000454.GM4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 8:04 AM, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 10:57:04PM +0800, Lu Baolu wrote:
>> @@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>>   	if (group == &abort_group)
>>   		goto err_abort;
>>   
>> -	group->domain = get_domain_for_iopf(dev, fault);
>> -	if (!group->domain)
>> +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
>> +	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
>> +		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);
> That seems a bit weird looking?

Agreed.

> get_attach_handle_for_iopf(dev,
>     (fault->prm.flags &
>     IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ? fault->prm.pasid : IOMMU_NO_PASID,
>     group);

The logic here is that it tries the PASID domain and if it doesn't
exist, then tries the RID domain as well. I explained this in the commit
message:

"
.. if the pasid table of a device is wholly managed by user space,
there is no domain attached to the PASID of the device ...
"

Perhaps I can improve it like this,

	int rc = -EINVAL;
	...
	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
		rc = get_attach_handle_for_iopf(dev, fault->prm.pasid, group);
	if (rc)
		rc = get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);

	if (rc || !group->attach_handle->domain->iopf_handler)
		goto err_abort;

Best regards,
baolu


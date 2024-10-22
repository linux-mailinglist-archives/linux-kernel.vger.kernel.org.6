Return-Path: <linux-kernel+bounces-375392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D79BB9A9563
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098AC1C23056
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D459B71;
	Tue, 22 Oct 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="giiiYsjP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8BA927
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729560025; cv=none; b=P2hNaa+XFDcCN2o9Y9Ifaa8by/CMw361Pc8K4ibUzIm3+vGJVKRY23hkKSlURZ3h8M+vCmAz0Ok7wkayfDUH0cy3Nf1QxbaXm/+ElL4AuQIVEWkb8YHHmrzYoZQdxDxgXrqn4tf/skHn4sENXLDtFvpXiCvtNajGLKhCPD8zSGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729560025; c=relaxed/simple;
	bh=EWiBoJpoeyyGXAyHgV69kCYNkfohDdWIG43VJ3+aqTo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hWu0K58zyZe8zX3wwBJ3PeuLG/z068noiHgWB0btN5c1fGjwq74bNJMAVynHGvl9YZ314rkVhztkQBkyg+IWIzVZ95/keyVE/tk4kUihSsFxmSGWGYkIxKTPFtSYJJhn6mKWjZZTCO2TKjeDZSuC9lruFjp3crYasX3oJDY0UhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=giiiYsjP; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729560024; x=1761096024;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EWiBoJpoeyyGXAyHgV69kCYNkfohDdWIG43VJ3+aqTo=;
  b=giiiYsjP3RfFJTvPF+ltxYXPxKr29p5P8ySf/EhRkfOwCbgKekap+LQu
   oKMa+yzluoUDQBUKzccseEd0s8rKiPtZ7EIruZ6/+gra8bm4ip1AB4bVN
   mtNsN1s25Z5fbQSI/gH+zOcYLpLdzNllX+n/iuz3s4XcWvVbiM0wS9I7o
   3X29F8ABVz6hXnEdjkfPjJisj8I/36T/LSfvir2Mqvn9GwTiQYCAAYITi
   lXyX1lcU3uD+g3A7lqczIgHa7Ve2543G3OIa9E9xW3W9maivQEvtAmias
   PLJlqYh7rVtLRQH4HWf9o+JkdSlJvk2RGM9Z97hBE2dJ3MA810oBI2usL
   A==;
X-CSE-ConnectionGUID: Dt56Pd8ISLu+2PLEpfxd8g==
X-CSE-MsgGUID: P3LIbA2GTCCm2E+rJkU4Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="32997842"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="32997842"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:20:23 -0700
X-CSE-ConnectionGUID: qLJOB7KRR/i1YfQ/OEBFlQ==
X-CSE-MsgGUID: I56rwBfDSRqiRUGFZPbaaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="80059248"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 18:20:21 -0700
Message-ID: <df7aee6a-1cd3-4d81-b95d-686ab8e8a9da@linux.intel.com>
Date: Tue, 22 Oct 2024 09:20:19 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Enhance compatibility check for paging
 domain attach
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20241021085125.192333-1-baolu.lu@linux.intel.com>
 <20241021085125.192333-4-baolu.lu@linux.intel.com>
 <20241021124615.GC3576661@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241021124615.GC3576661@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/21 20:46, Jason Gunthorpe wrote:
> On Mon, Oct 21, 2024 at 04:51:20PM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
>> index 433c58944401..96016bc40f94 100644
>> --- a/drivers/iommu/intel/nested.c
>> +++ b/drivers/iommu/intel/nested.c
>> @@ -40,7 +40,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>>   	 * The s2_domain will be used in nested translation, hence needs
>>   	 * to ensure the s2_domain is compatible with this IOMMU.
>>   	 */
>> -	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
>> +	ret = paging_domain_compatible(&dmar_domain->s2_domain->domain, dev);
>>   	if (ret) {
>>   		dev_err_ratelimited(dev, "s2 domain is not compatible\n");
>>   		return ret;
> This dev_err shouldn't be here, this path would be userspace
> triggerable.

Yes, agreed. I will remove this dev_err in a separated patch.

Thanks,
baolu


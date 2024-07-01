Return-Path: <linux-kernel+bounces-235634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A291D7BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D186F2845E1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 05:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E6251C42;
	Mon,  1 Jul 2024 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k6jkrFIS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF742AB7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719813352; cv=none; b=J1v0ktSwiJNR3BEd006kUGMALkaTN667YImktqOxWJucH/0jBEQaCY8L/PGRWt6ugnfnBkJzLIClAdc36achramUxI1oW0X5GHfriVfv4QowubS6Xdm27Vke7ZW4fzt/db7KLe5j1Y+Ov0Rar5CaRpNx9kfWt6Gm/c1esdNl3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719813352; c=relaxed/simple;
	bh=zoolY0j9tBgKN2MEBj7jMgK5u98hB3qhLdhkSd0qq80=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NryxKfZyAWLXv6osvdGD7fMVGK/AIvjtIKMnFY+MDEjThxVSBJ/48n48A5Z1GWaRim5QQ4NMbNnYEdpTd5MbWhcQwddEDCxFBZP+myV8xygBFRCmNmuwmDuJzuflmNEHj2noyqSXMlXeVqwE2Spxjkym/gyZvnUzVkzndZs0lks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k6jkrFIS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719813351; x=1751349351;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zoolY0j9tBgKN2MEBj7jMgK5u98hB3qhLdhkSd0qq80=;
  b=k6jkrFISEf2XhyFCtRpoqa1C+C6CfBPuQdahFHTp5iFe9uHjCGW7LWsg
   R9vQgj3SXJjggakyZfypvVxBDbO35rrA2cIsd8CRz5527sXq6kBMNMIrZ
   F1l3sg8mDTJ+qpys10cTsRGmoNOUzH4BMrOrybygjLdCRErifA2Zo3F0w
   ulH0/qC0jh4yi43IWaCw8gmHu2/GeFo/P6KLg0+Ej748DjckuQr/ykcz/
   3/2FzyY6B1Mp5xgIfvVjO30mlZR1Lzqj4T7TrWsHHbQR6zgeb6lDmXV+m
   +ASu6CtNZLqcrC4SN+d7kGDhzq0T2Av0/ug/BruxkCgf/lyd5y1qfmOSB
   g==;
X-CSE-ConnectionGUID: DZIsdyR+Rte1OdAd5KBvZg==
X-CSE-MsgGUID: Zurd5dN5Rh6p2ZkfAoMPcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="19817041"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="19817041"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 22:55:17 -0700
X-CSE-ConnectionGUID: YvK3MWzjQP6f2lsibkttYQ==
X-CSE-MsgGUID: p91iEwuIRdqyjcfXzEouHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="49860164"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.229.145]) ([10.124.229.145])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 22:55:14 -0700
Message-ID: <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>
Date: Mon, 1 Jul 2024 13:55:12 +0800
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
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
 <Zn8oZ80p0p1bHgBC@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Zn8oZ80p0p1bHgBC@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/29 5:17, Jason Gunthorpe wrote:
> On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
>> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>> +{
>> +	struct device *dev = idev->dev;
>> +	int ret;
>> +
>> +	/*
>> +	 * Once we turn on PCI/PRI support for VF, the response failure code
>> +	 * should not be forwarded to the hardware due to PRI being a shared
>> +	 * resource between PF and VFs. There is no coordination for this
>> +	 * shared capability. This waits for a vPRI reset to recover.
>> +	 */
>> +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
>> +		return -EINVAL;
> I don't quite get this remark, isn't not supporting PRI on VFs kind of
> useless? What is the story here?

This remark is trying to explain why attaching an iopf-capable hwpt to a
VF is not supported for now. The PCI sepc (section 10.4.2.1) states that
a response failure will disable the PRI on the function. But for PF/VF
case, the PRI is a shared resource, therefore a response failure on a VF
might cause iopf on other VFs to malfunction. So, we start from simple
by not allowing it.

Best regards,
baolu


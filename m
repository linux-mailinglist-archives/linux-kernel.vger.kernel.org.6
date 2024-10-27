Return-Path: <linux-kernel+bounces-383648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9669B1EBA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D14281FEA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E88175D4F;
	Sun, 27 Oct 2024 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ftDe3q0m"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD6316DEA9
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730039171; cv=none; b=mg5Aa0bVTUPhyMI0p+2tVlKglmcdyOh8WhmtNyKS53OJKmYpWAhIdbq+M3Sn/r5HsElVDtQjC4OsFOzfHr1OnF2b4Ghw5NDoDsyMGc8l0EngJ/F/zi3WIMTCXkbfL7KpAeGg/JmUNw3BignEuB8ipCBXZHIXVFvGNEnuv2l89YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730039171; c=relaxed/simple;
	bh=F3T/AAYdoHuTTV/VVVzRbtlg/svgZJGhDsfrjIIQP8E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uzHGyDh8uF3J0EWzqZ9+joiFdW0S+8AXB6LvsYnImEc4L8S6QupEXhl79qE8BF0cIIVsb5OfO0dSqURv9U7pa7uxyFvPnFTHgSLoiAL8pW/WwYQC5ooWeSYC0K/0c5TqfYdXWcjCGpg28u1mx3trvOmHnlzYkA5qqg5FqHfcsNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ftDe3q0m; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730039169; x=1761575169;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F3T/AAYdoHuTTV/VVVzRbtlg/svgZJGhDsfrjIIQP8E=;
  b=ftDe3q0mGFjhmLT7JA0NYBiAVxSjl6N97HxYfeeaYh8TPpvsDwiakAio
   BHrB+hvzHQ6Pr1d7GZBDHGW+NEnR30x1k9lLUBvYm8EUulxJSRpKe42Ju
   XgJtth/Omnb7v/zyffsrlOAhVbeWh5Y5NmUaOpEDpBjALtM626igrMSqG
   uRz0pUDzCxQZD0mLZp0ihZPfCF3zoi3rpBBKrrb0V8koN+M5g/bp/mg/S
   AXxxw0e9QA7kovJz4u+El4eAxVwn6QpZlH7gEa7FD7/2I6u+PzulxPwrH
   kmRCd8PJLz29o1exRktWgnliqSOQZKa7McRi6433ui4p/OpN29tLJb+Ha
   A==;
X-CSE-ConnectionGUID: BeeRorzIRNaR03YtWru+zA==
X-CSE-MsgGUID: 8uvXX93XR36ztapTibROig==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="41019060"
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="41019060"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 07:26:08 -0700
X-CSE-ConnectionGUID: DfJI0M8vRpu4hdIaqKiwRQ==
X-CSE-MsgGUID: 8Jp4mR4jSKighrximlALbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,237,1725346800"; 
   d="scan'208";a="81002937"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 07:26:05 -0700
Message-ID: <e030bf31-330c-4734-be13-634174c7b099@linux.intel.com>
Date: Sun, 27 Oct 2024 22:26:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
To: Zhangfei Gao <zhangfei.gao@linaro.org>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
 <20241016152503.GB4020792@ziepe.ca>
 <CABQgh9FCJcOa0G0Kj__NUm-Q8C9uH4ud04XcHv+3c48T2qEnug@mail.gmail.com>
 <20241017120518.GI4020792@ziepe.ca>
 <CABQgh9EnEqDKkxg3VUgjSqBzz27h8B3Ct4w=A0vR6JK=d7fXHQ@mail.gmail.com>
 <20241017130805.GA926121@ziepe.ca>
 <f218230c-ae01-4168-b36e-5e502de6b3db@linux.intel.com>
 <CABQgh9GU4xp=7Svs_Ni=bvNKECKKUjHgq4d-FjT5Y_4wu44kDA@mail.gmail.com>
 <CABQgh9HYDRVOYtL=jgc4CqX0XhNmCtBDOCm8S6_mgBzBtZVk7Q@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CABQgh9HYDRVOYtL=jgc4CqX0XhNmCtBDOCm8S6_mgBzBtZVk7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/27 22:12, Zhangfei Gao wrote:
> On Fri, 18 Oct 2024 at 10:45, Zhangfei Gao<zhangfei.gao@linaro.org> wrote:
>> Hi, Baolu
>>
>> On Fri, 18 Oct 2024 at 09:58, Baolu Lu<baolu.lu@linux.intel.com> wrote:
>>> On 2024/10/17 21:08, Jason Gunthorpe wrote:
>>>> On Thu, Oct 17, 2024 at 08:35:24PM +0800, Zhangfei Gao wrote:
>>>>
>>>>> Yes, you are right
>>>>>    I am using SRIOV vf and stall feature, so is_virtfn == true
>>>>>
>>>>> Our ACC devices are fake pci endpoint devices which supports stall,
>>>>> And they also supports sriov
>>>>>
>>>>> So I have to ignore the limitation.
>>>> I see, so that is more complicated.
>>>>
>>>> Lu, what do you think about also checking if the PCI function has PRI
>>>> ? If not PRI assume the fault is special and doesn't follow PRI rules?
>>>>
>>>> Or maybe we can have the iommu driver tag the event as a PRI/not-PRI
>>>> fault?
>>> This limitation applies to PRI on PCI/SRIOV VFs because the PRI might be
>>> a shared resource and current iommu subsystem is not ready to support
>>> enabling/disabling PRI on a VF without any impact on others.
>>>
>>> In my understanding, it's fine to remove this limitation from the use
>>> case of non-PRI on SRIOV VFs. Perhaps something like below?
>>>
>> #include <linux/pci-ats.h>
>>>          if (dev_is_pci(dev)) {
>>>                  struct pci_dev *pdev = to_pci_dev(dev);
>>>                  if (pdev->is_virtfn && pci_pri_supported(pdev))
>>>                          return -EINVAL;
>>>          }
>> Yes, this works on our platform.
> Will you send this patch?
> 
> Tested-by: Zhangfei Gao<zhangfei.gao@linaro.org>

Can you please make this change a formal patch by yourself? As I don't
have hardware in hand, I'm not confident to accurately describe the
requirement or verify the new version during the upstream process.

Thanks,
baolu


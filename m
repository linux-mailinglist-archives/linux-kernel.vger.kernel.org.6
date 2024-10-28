Return-Path: <linux-kernel+bounces-384815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E49B2EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 12:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FB71F21826
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10B11DE4E4;
	Mon, 28 Oct 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO1sk16j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6F1DE4CC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730114283; cv=none; b=P9G79KvmY7R4S1pPyflOM9iTLkHFUv/gffrXAZyMdJgR54/HqrSDbScKHZatB8gFu2Ml2spo9e93J//OJrZNEQNlJ4Zo3bWJXthLCDBWckJg0auEoGwzwB0Z5F5ioESisQZMuhRAFNGrSPr/CVOEPo4eyv/S78x7w8S3ZGy3iO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730114283; c=relaxed/simple;
	bh=qjVGBpR1S2TEli0oGkFxxnd/RYJtrtefnmNKY3XIAhY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gk+mlmS+ZuE2FbfVjdWRJvsLGuntLbOnPH/pbELywvj4qNsCuq/Dq5sLLvBq1uhK+ku/bB0TgCkCYu1NkiHY7YT0BCXKkD9rCmUvmeJFYZmYZSOtyhaTNFnF/I2T5sjC4/ZJXG3PL8UMIkMMdKRwZfL3zkNc7fItjIW5gGfGB50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO1sk16j; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730114281; x=1761650281;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qjVGBpR1S2TEli0oGkFxxnd/RYJtrtefnmNKY3XIAhY=;
  b=gO1sk16jIis1ehIc5m2MRENeTPJJ8wE/GkqxzFyopSqVaTzEL82j3j3e
   NxPKWpl5ohX41scZzwtz3WbXtAW6Nme2ogTBh5YQVeXEwNso1bnivkkHW
   TOnb4x6zuyoXiuS/HBt7maAXp/Mupn+XAI4gLKzWUC0dfTO+e/GShPADF
   g7faySiEt8L5bOw5IvC+hpQ5u59aTwq72Le4xIR9w6xg8il70fxxv6Eva
   tBM9SocO9Mncdmz52XxMVAo4tnn7QKtJfN3KJIg7b+jh6+tCPjq6187uK
   M+V4FTq9y9oMkYA+QZlH3Sfqmk81AUGUXmcRwShMNhOxSlTKTIYdrHi1u
   Q==;
X-CSE-ConnectionGUID: deGiC11HRdO59UYuJ4if6Q==
X-CSE-MsgGUID: fPfRxMdTTvKY95pV8FafOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40806150"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40806150"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:18:01 -0700
X-CSE-ConnectionGUID: cMHtlpa8QiKJfMOKRlBNYA==
X-CSE-MsgGUID: FUbb+LdIQqC3BdMxIJRguQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="119049975"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.228]) ([10.124.240.228])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 04:17:56 -0700
Message-ID: <98187461-f308-4242-b2c6-eca9fc9daf38@linux.intel.com>
Date: Mon, 28 Oct 2024 19:17:54 +0800
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
 <e030bf31-330c-4734-be13-634174c7b099@linux.intel.com>
 <CABQgh9EQjEpHLn76g0Fdu7L6PwmYbiJxuPT-OSPKo7SrN7dAgQ@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CABQgh9EQjEpHLn76g0Fdu7L6PwmYbiJxuPT-OSPKo7SrN7dAgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/28 17:56, Zhangfei Gao wrote:
> On Sun, 27 Oct 2024 at 22:26, Baolu Lu <baolu.lu@linux.intel.com> wrote:
> 
>>
>> Can you please make this change a formal patch by yourself? As I don't
>> have hardware in hand, I'm not confident to accurately describe the
>> requirement or verify the new version during the upstream process.
>>
> 
> OK, how about this one
> 
> Subject: [PATCH] iommufd: modify iommufd_fault_iopf_enable limitation
> 
> iommufd_fault_iopf_enable has limitation to PRI on PCI/SRIOV VFs
> because the PRI might be a shared resource and current iommu
> subsystem is not ready to support enabling/disabling PRI on a VF
> without any impact on others.
> 
> However, we have devices that appear as PCI but are actually on the
> AMBA bus. These fake PCI devices have PASID capability, support
> stall as well as SRIOV, so remove the limitation for these devices.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/iommufd/fault.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> index bca956d496bd..8b3e34250dae 100644
> --- a/drivers/iommu/iommufd/fault.c
> +++ b/drivers/iommu/iommufd/fault.c
> @@ -10,6 +10,7 @@
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/pci.h>
> +#include <linux/pci-ats.h>
>   #include <linux/poll.h>
>   #include <uapi/linux/iommufd.h>
> 
> @@ -27,8 +28,12 @@ static int iommufd_fault_iopf_enable(struct
> iommufd_device *idev)
>           * resource between PF and VFs. There is no coordination for this
>           * shared capability. This waits for a vPRI reset to recover.
>           */
> -       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> -               return -EINVAL;
> +       if (dev_is_pci(dev)) {
> +               struct pci_dev *pdev = to_pci_dev(dev);
> +
> +               if (pdev->is_virtfn && pci_pri_supported(pdev))
> +                       return -EINVAL;
> +       }
> 
>          mutex_lock(&idev->iopf_lock);
>          /* Device iopf has already been on. */

Looks fine to me, but you need to use the "git sendemail" command to
post the patch. Otherwise, the maintainer has no means to pick your
patch with tools like b4.


Return-Path: <linux-kernel+bounces-310518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9E7967DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 473F6B239B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438332A8D0;
	Mon,  2 Sep 2024 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vv+/QfVO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892E24A08
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244585; cv=none; b=A7sZyq82hvcyUsztYRslpg1XDV4Fm3j/Ae9FNUqO60D3liz4alyvuoCSjCguljhdW9OYdB7fv58fgYzI7DlToQrSv/fUchjc3/UEbqSk8WeKZQ5n/e1gjU+ME/Z+lW7taCFST0FnZuy7a0z77p/flGsJqcacJueaMSA/M9PgzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244585; c=relaxed/simple;
	bh=9TWBEP1W2odfG5AZesB2boBh32Tq9C28e342rwopCt0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yeg0Fww61hTNJ/k0VUF2+kA3cLc04+En/heUz/bbGW8Bn/c5ifFBR+6qMis2gjWqLDg1DA1X8dkjVESSWAzamV6/gNjCkiU2B+X+XtcjxB+NtK6nJ7ufcMDHyx12UFK5yC4C9Vhb5szbqioQiGvFJniFwVV36f7dp4mckHTkhEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vv+/QfVO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244585; x=1756780585;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9TWBEP1W2odfG5AZesB2boBh32Tq9C28e342rwopCt0=;
  b=Vv+/QfVOTwP/vUlJ3745uWpsxOS34JZ/lgDv0udLhfwtQpG5FdzU8sXO
   gjaIAzPtie4mH1ozpFnK3EeNveyR5x7+Z/+sc1BX2JcFJ39ReeBzYaZhM
   AZfhIiQa8ai0JtVd1fsch3WxnCp/fxeI7wbER2TafRRbGoKFiIwiTJ7MS
   sOtgZ94HuMizpsYj142DhaGYeZQtM3K4Gkd29lr7hF9ZdVz2brBwZ/xao
   PIhmVpK12wcaksV3tzttsXKx5N4hwMmQLxCE7ofxei4tX7F9eTFvUYV6I
   W1eYSGeDe5r7fuocNFkFfYqnzq7cB8AbryCkURsjsOmxlI89m+s1GMsY/
   g==;
X-CSE-ConnectionGUID: PRRXlpeKRYKCn+NfEx9rOQ==
X-CSE-MsgGUID: Y+pbpp9sTY+jQC5mk1k5xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="27572789"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="27572789"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:36:24 -0700
X-CSE-ConnectionGUID: x1+7OkB9QW6MuGhrWw25HQ==
X-CSE-MsgGUID: TaSAebGNTXmixHuLC5l07A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69271055"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2024 19:36:23 -0700
Message-ID: <d3338276-fd8b-4d84-974e-6a07157406d1@linux.intel.com>
Date: Mon, 2 Sep 2024 10:32:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Batch IOTLB/dev-IOTLB invalidation
To: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20240815065221.50328-1-tina.zhang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240815065221.50328-1-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/24 2:52 PM, Tina Zhang wrote:
> IOTLB and dev-IOTLB invalidation operations are performance-critical.
> The current implementation in the VT-d driver submits these commands
> individually, leading to some inefficiencies due to the IOMMU
> programming and invalidation command processing overhead for each
> operation.
> 
> This patch series enhances the efficiency of Queue Invalidation (QI)
> operations by adding support for batch processing. Microbenchmarks
> show that with a DSA device working in SVA, batching IOTLB and dev-IOTLB
> invalidations can decrease the time spent in qi_submit_sync()
> by roughly more than 800 cycles.
> 
> Changelog
> v3:
>   * Rebased on 6.11-rc3.
>   * Updated commit messages which are revised by Baolu.
>   * Dropped the refactoring quirk_extra_dev_tlb_flush() patch.
>   * Added "Add qi_batch for dmar_domain" patch which is provided by Baolu.
> 
> v2:
>   * Rebased on 6.11-rc2.
>   * Updated commit messages.
>   * Added changes of refactoring IOTLB/Dev-IOTLB invalidation logic
>     and quirk_extra_dev_tlb_flush() logic.
> 
> v1:
>   https://lore.kernel.org/linux-iommu/20240517003728.251115-1-tina.zhang@intel.com/
> 
> Lu Baolu (1):
>    iommu/vt-d: Add qi_batch for dmar_domain
> 
> Tina Zhang (3):
>    iommu/vt-d: Factor out invalidation descriptor composition
>    iommu/vt-d: Refactor IOTLB and Dev-IOTLB flush for batching
>    iommu/vt-d: Introduce batched cache invalidation
> 
>   drivers/iommu/intel/cache.c  | 239 ++++++++++++++++++++++++++---------
>   drivers/iommu/intel/dmar.c   |  93 +-------------
>   drivers/iommu/intel/iommu.c  |   6 +-
>   drivers/iommu/intel/iommu.h  | 126 ++++++++++++++++++
>   drivers/iommu/intel/nested.c |   1 +
>   drivers/iommu/intel/svm.c    |   5 +-
>   6 files changed, 316 insertions(+), 154 deletions(-)

Queued for v6.12-rc1.

Thanks,
baolu


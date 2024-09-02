Return-Path: <linux-kernel+bounces-310528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FD4967DF0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89921C21E1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520A93E479;
	Mon,  2 Sep 2024 02:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExIJsVnW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551822C859
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244943; cv=none; b=rrop926cuUAbgTP1TPPrcgpi4dJrAXHPosybLEhimLLaGQJYF6kvIz+0yNkKNfYlkhl/VHkcog8OYVgQhdowxQfHxYKsMZhBoEP7ZxJWrQjG6+o4Kp/ht1sIfRyCBKxKRxN+Jr+X1FLUzlPa7NKIGxeUFwZFattrd3FKUB51wWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244943; c=relaxed/simple;
	bh=YUG9ZFJPv1MmEhh/dMS0E9qSNXQCjEHsf8ftV/H2c4U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J2rETFHXnk8fde88Wu5vurnSpKXP2508D/zJvNN1IH/5TRiWKypRxsBxHFH5Yaa7EYzNdjqWZGfCT9EY36IAO28zfjibXL/tIwn3L3V5RIX1qpaVey6Gse9ARyRI4EN8YoittKG/uBLOWeGu+1pSlK9Lc5/eE5RYkG8bpTPScxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExIJsVnW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244943; x=1756780943;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YUG9ZFJPv1MmEhh/dMS0E9qSNXQCjEHsf8ftV/H2c4U=;
  b=ExIJsVnWGkxRZqnDF4N4fdKzYsZlf2kOGy2NCz5HEz75G62nf5s4LQLq
   ligij8RVF7P2t9kwiCGN7nmsEFjcrgaNmto0ZfyuHDlaIHGY/qCCJPmlM
   dOPUjMGJH4PzZo7bJABOIKbUz7t4CPGi68o/5SpciJhb4OffssgwYgjj4
   itKncCE04PsGvYW0dTsLUimQleZpzc7NXhTBUJhLA/tiMTaUSbIlvylKY
   p3NQP9iDgWsk05GFa8Ge2FDoRmUSmX+i9HXEmFCOFSVuQ1/BMnAscKhc6
   kMA4pCMlVTZbOLiW9Emsx51YIcRMTfYelgLU+YZTQ4nfuWejWObLsgCrS
   A==;
X-CSE-ConnectionGUID: JVo8oxjwQjaWrXr/c+TrYQ==
X-CSE-MsgGUID: q7F1h8idTXq6VnAWv7JuUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="27602758"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="27602758"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:42:22 -0700
X-CSE-ConnectionGUID: Gp8ga8umRpW3hhzqlA9dhA==
X-CSE-MsgGUID: KOg916wbTIGHfgFNJt8hzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69110999"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 01 Sep 2024 19:42:19 -0700
Message-ID: <8ec85e40-211a-4fe4-98d6-fc0acb9aeccb@linux.intel.com>
Date: Mon, 2 Sep 2024 10:38:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Unconditionally flush device TLB for
 pasid table updates
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <20240820030208.20020-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240820030208.20020-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/24 11:02 AM, Lu Baolu wrote:
> The caching mode of an IOMMU is irrelevant to the behavior of the device
> TLB. Previously, commit <304b3bde24b5> ("iommu/vt-d: Remove caching mode
> check before device TLB flush") removed this redundant check in the
> domain unmap path.
> 
> Checking the caching mode before flushing the device TLB after a pasid
> table entry is updated is unnecessary and can lead to inconsistent
> behavior.
> 
> Extends this consistency by removing the caching mode check in the pasid
> table update path.
> 
> Suggested-by: Yi Liu<yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)

Queued for v6.12-rc1.

Thanks,
baolu


Return-Path: <linux-kernel+bounces-520934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2DEA3B159
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 07:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2945188B147
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 06:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808941B87F4;
	Wed, 19 Feb 2025 06:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPfxm+V6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2051BAEF8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944927; cv=none; b=TKuw21fKmoGold9udEagSE+3gP5v+W3DThCZFsnm0meX7f31Lw5hPGoBeaYf6aQF62/iLFsJjrDE1zeTljwjwRajxvbyQeCrr1hb5HMOzgzHdBcNdtC8y92sxe9htSipTt3Zyj/ss5JzTHdUy5lNwOQegON+3X0skrljamO79Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944927; c=relaxed/simple;
	bh=KjpYYG/KKSxKeVYVZIzx1tumhkfjES6+uEjUpium104=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MT8zyFdyVG24yJiLpzdYkane5ZgyVd1+l36Seo+aL9s3Z6F6GmLFADRp4SiWZOBLU2LRoI40yKaki4xTa10Gq5vqiG/WZVVFRyJa0S6NoMQ2J9Eyh9YSQ0UKhM7nS0sBeC4LMslORhlP942Rk+ccVhy7BG1ZOTcRCnN+N2Y+R38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPfxm+V6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739944926; x=1771480926;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KjpYYG/KKSxKeVYVZIzx1tumhkfjES6+uEjUpium104=;
  b=hPfxm+V6DAYPTvBuz9fxEky4oGTUhZh7GQ8iMhxUYk0jczAWXS+p5qCq
   3tT5SeSgdZYU4cQ1/iE23u5e5hp5i9wJHcrIJL4juDJC80N/qctu0q+Iv
   WU+fi4DJZLHQTPSbcqHiI8rSRW48dTkX5TWxeLQETva8ktnEaLovov8EN
   zOGERLe4XaJbDtf0tt7xjUUbAdy3EntwDHe6EVHo1RxB68mM/egO8/AyE
   i9rzxo9FamCfhUsO7KoBSUKqA/EpcBcU1lEkLfXXKxwbQyk1rNa9T6Tza
   NQtP5G6J3R4S3bpWxClX1cXKxMorYLvuar+pnRffia8/JKqkBphZdH+I8
   A==;
X-CSE-ConnectionGUID: AylTHuovTsyWOJMq4QWHlg==
X-CSE-MsgGUID: +zbHQvqCQPmsvwk2zIT6+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40925466"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="40925466"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 22:02:05 -0800
X-CSE-ConnectionGUID: qmJ6BvPDR9a4Gg0Lh5N98A==
X-CSE-MsgGUID: IEs/MSOVRRqefGp8wzDFYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="119729197"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.17]) ([10.124.240.17])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 22:02:02 -0800
Message-ID: <e21e71c4-d627-4150-996b-893fe5bd4726@linux.intel.com>
Date: Wed, 19 Feb 2025 14:02:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Dave Jiang <dave.jiang@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Zhangfei Gao <zhangfei.gao@linaro.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dmaengine: idxd: Remove unnecessary
 IOMMU_DEV_FEAT_IOPF
To: Fenghua Yu <fenghuay@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-10-baolu.lu@linux.intel.com>
 <94b6f4fa-8a92-47a1-8938-b838ce19d122@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <94b6f4fa-8a92-47a1-8938-b838ce19d122@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/2/19 6:55, Fenghua Yu wrote:
> On 2/13/25 22:11, Lu Baolu wrote:
>> The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a 
>> no-op.
>> It will also be removed from the iommu driver in the subsequent patch.
>> Remove it to avoid dead code.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thank you, Fenghua.

Can you please update your contact email in MAINTAINERS file.

Thanks,
baolu


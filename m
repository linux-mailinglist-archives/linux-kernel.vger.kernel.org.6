Return-Path: <linux-kernel+bounces-333097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479B297C3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1BB1C22473
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20241B285;
	Thu, 19 Sep 2024 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1IKUsMC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D9E1CD1F
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 04:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726721378; cv=none; b=LX17jQuZWqcB2HKIQjOEZuxpFAPuK5NZ7BjD4UqWC8TgbXeaovubBT7d+k5TQAcl/Qgj/R3167f4POtmuoZ3+w1RIfRfiAnNNU7exjD6HgaBIS1eQQM/9pWTK8bG4duY8Kis9ZsyjMsf78kkbuK6ML4DRABEFGSiLv7kg3xs85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726721378; c=relaxed/simple;
	bh=H3YvGkTpFeoPDN5wi0RdOSRjHHmnuaoIA73Eys9KfIw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IdbAsxa+JWdosI9dvgwUz9dA5zql/ePKWdW/CFz5+gnAIIpnCed+iv9212rSsCip3vdTe8I2+NpiZQhE6B0uP7xE065azuVaUn2WR0Tgm1r6AVTH+lPtpA7vufG1Yiau+Cuq074h7KAOBvye835Pr04MGdKewC8yb8PFL2OQ3P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1IKUsMC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726721376; x=1758257376;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H3YvGkTpFeoPDN5wi0RdOSRjHHmnuaoIA73Eys9KfIw=;
  b=m1IKUsMCrC3JdgU/3QM9BN4Ivn8kGOTR27obzxhIlVu6PCYlqucv+Vh8
   HeCYLDIUjEFXRE7sjYt15aPyYO/tf8SYKOKrdwckMrIZT+6iUepFzHvoY
   /ZF+1Tvg0djDfakABCFTi9pPaD0v+iGPqFgN1SgSz17JWunVR+ANjtGvL
   6pvvHX17k0SblOkTi2/aeKa8zhXNtHKLm9ulLLNcR9x8FScQrai6czFbO
   K8lriHjK49/S0erikO4dv561oNLtepqg5IauYtbtwnuerZI7G7CkQRi1/
   A1dvk93k35ZpzwvSm308C5La32GjEnkv6ybR8EUL72lYW9hkeOQPF6mJr
   Q==;
X-CSE-ConnectionGUID: qkU0SOkmQ2akLmZtCiYdHg==
X-CSE-MsgGUID: y6pzdovCT3mgXEuefuP1qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="36331313"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="36331313"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 21:49:36 -0700
X-CSE-ConnectionGUID: cqXILBR+QembfQ+6/Vsxtg==
X-CSE-MsgGUID: 3Rjb/cTQT5u9ebj2P9oDJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="74157565"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 18 Sep 2024 21:49:33 -0700
Message-ID: <7a532573-9e59-41c6-bf57-f50cad502e57@linux.intel.com>
Date: Thu, 19 Sep 2024 12:45:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Convert comma to semicolon
To: Chen Ni <nichen@iscas.ac.cn>, will@kernel.org, robin.murphy@arm.com,
 joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com,
 smostafa@google.com
References: <20240919035356.2798911-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240919035356.2798911-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/19/24 11:53 AM, Chen Ni wrote:
> Replace comma between expressions with semicolons.
> 
> Using a ',' in place of a ';' can have unintended side effects.
> Although that is not the case here, it is seems best to use ';'
> unless ',' is intended.
> 
> Found by inspection.
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Chen Ni<nichen@iscas.ac.cn>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

A typo in commit e3b1be2e73dbe ("iommu/arm-smmu-v3: Reorganize struct
arm_smmu_ctx_desc_cfg").

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
baolu


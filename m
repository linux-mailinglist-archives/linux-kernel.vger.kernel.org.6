Return-Path: <linux-kernel+bounces-570634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C50A6B2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 03:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C437887248
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0EF1DF968;
	Fri, 21 Mar 2025 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4+OgPPe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7C1C5D46
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742523321; cv=none; b=TrmkppNoiObreW7TohQv+5s4sLerlsh9KTuXmZBUEbZlGFNuv32PofjYvtqT1t/qseu/3/funCRXj3FhKBkVTme2CrIRx+0sUhftOGxnXPv5ERgOzxpVxE/zNHc/XA90pHKCLSNVMbopbWye04kTlmbP4tCB+OvXIRvji/QV+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742523321; c=relaxed/simple;
	bh=BozcqSjBaUvQxOBddqwiOyYHQ86Jidgzcjeb9YrQUuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xypn1nLaEu8hpK108NTNTEfe5SHXK30xjo+/CxZC4a4NACKlbSp27qsEuFotsuzquHrOBFAxzq3s5NTe9F2Bddtg1xGz0nsTWupSoaNh1Ag9qFD1eFuhtxlST+KXgmj3YiJEL4hqujg11WcbiXQzDh5pPCUM1vjvxf/jOmZJ+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4+OgPPe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742523317; x=1774059317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BozcqSjBaUvQxOBddqwiOyYHQ86Jidgzcjeb9YrQUuk=;
  b=I4+OgPPeTsU8aSVZXWTS5cY8s0//qQlgbestwU6MWcDD6o3kpJaE/s4p
   VwirKGJiegIxeAwIfOM53/fc+BSdGeZwLwUvI2RJ+tRs2E2iwSJd+CyBl
   sEO4F3eCsQdGcTRcfsiM/nFO3vmN1+jtLQZJ3AifFqrHonqXf5i8pXRGe
   F05iTQC5y8nou6ltMIAwvqoWFbMjcXvpZA6Gz8JpNwCBhshsZ/I2otXtI
   zf+QCI6xn57Ix3JTrL4XF7u/6VxTKl1rcCiNEQXx3es4tf8VT/dOPsZ69
   7HuVS03DQ5E19wrxmdRVXMHiNY7Uyu96ZjSyZ3Oxg9EKktc5RSKDJw1s+
   A==;
X-CSE-ConnectionGUID: eWZNpC+7TYOHW+5hxrZHxQ==
X-CSE-MsgGUID: yQGWVXlaQqW+n1SYt53uQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43910565"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43910565"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:15:16 -0700
X-CSE-ConnectionGUID: jJUvwO6TSgGcYgMuUkcMEw==
X-CSE-MsgGUID: GoadUQBARzSfJlmltw1sDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="127425633"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 19:15:14 -0700
Message-ID: <3506c422-6508-42f6-8624-b968b7ffba08@linux.intel.com>
Date: Fri, 21 Mar 2025 10:11:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] iommu: make inclusion of arm/arm-smmu-v3 directory
 conditional
To: Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
References: <12652899.O9o76ZdvQC@devpool47.emlix.com>
 <6164975.lOV4Wx5bFT@devpool47.emlix.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6164975.lOV4Wx5bFT@devpool47.emlix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 17:19, Rolf Eike Beer wrote:
> Nothing in there is active if CONFIG_ARM_SMMU_V3 is not enabled, so the whole
> directory can depend on that switch as well.
> 
> Fixes: e86d1aa8b60f ("iommu/arm-smmu: Move Arm SMMU drivers into their own subdirectory")
> Signed-off-by: Rolf Eike Beer<eb@emlix.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>


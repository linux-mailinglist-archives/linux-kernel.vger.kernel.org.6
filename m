Return-Path: <linux-kernel+bounces-547407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 082C0A506AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4857E1722B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C281A304A;
	Wed,  5 Mar 2025 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mjL4ep04"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644A250C02
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196728; cv=none; b=FQhs89G3StkqzF6NXUXnrw7n7wWC1/ENvVZMkSUb3SvJ7WoSJhq3gVP6nDdYz94nuN1Bap23884mFuqejUnC/F5bNL7zlC3XNP+jFsLorJSFYZYpx8ecXZDhG8hs1VOfN1F+IonMbFlxosDRcuvF2Qwut0XBg2iNTt1jjn+Zvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196728; c=relaxed/simple;
	bh=XjEOiS/qFvdC8RqvVQX+N3LEfTa/dkn8FPGhmC3N5cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TR1rGa6u/sbiwTKhf+ZIuPk+4uxICdLMF+wPwYzX4LFdxdCrR1OCEuPwl8GXRJR2MJWTxUuo+Z+NTiKFCGOooLr4z4yU3WYJPrPzOEOspT4SJxFXbnzwmDel2HWE8dhrQloMOaPN/4HasP57q82QgOM5fvKINqAfWdZQsg+6JnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mjL4ep04; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741196727; x=1772732727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XjEOiS/qFvdC8RqvVQX+N3LEfTa/dkn8FPGhmC3N5cg=;
  b=mjL4ep04t7YBDYb+wdDHdWr3yz0LJU6GzbnXEmPMD8V+sYkVmWgIDep3
   ucDYs9lZDoRko4LYcjf53NzySveGVmHMZBw3lbOPMN8FTFUzAvk9ZlrHh
   TKvy6NgFKNa/IoLwzPGiX+q5pcuFdDrKLZ1zPFTBivZ8pJu7DzxJb5bFO
   hElovnUvXYmZuUnkAHoMJOEAsyn4ymy/wJkEI+xKX5LoLBHfnoddU6J73
   TChq0XCnoN2PSqVSYjzK1UsjvAZ0URuNV+TBmvq+Kcy5wiuczeojBPAMJ
   ciyJqKoLInacHfja0hRUBglPZsZSfthIErRbigYOLPkne8ER5H2sx/VQ2
   A==;
X-CSE-ConnectionGUID: tNaHxDqARvytJmWZsuGSdA==
X-CSE-MsgGUID: 03clK3BdRS2XcbUYZXEJTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42313829"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42313829"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 09:45:16 -0800
X-CSE-ConnectionGUID: eTHwaUUkQAiiW+OWn98utg==
X-CSE-MsgGUID: tbds7TsvRSqUoqM3Yaunxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118930553"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 05 Mar 2025 09:45:05 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpsnk-000LLi-26;
	Wed, 05 Mar 2025 17:45:00 +0000
Date: Thu, 6 Mar 2025 01:44:41 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iommu: Sort out domain user data
Message-ID: <202503060130.fkBIRmys-lkp@intel.com>
References: <74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5e9f822c9c683ae884fa5e71df41d1647b2876c6]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-Sort-out-domain-user-data/20250304-045529
base:   5e9f822c9c683ae884fa5e71df41d1647b2876c6
patch link:    https://lore.kernel.org/r/74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc%40nvidia.com
patch subject: [PATCH v3 1/3] iommu: Sort out domain user data
config: csky-randconfig-r111-20250305 (https://download.01.org/0day-ci/archive/20250306/202503060130.fkBIRmys-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250306/202503060130.fkBIRmys-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503060130.fkBIRmys-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/iommu.c:2040:9: sparse: sparse: statement expected after case label
   drivers/iommu/iommu.c: note: in included file (through include/linux/mutex.h, include/linux/notifier.h, include/linux/clk.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +2040 drivers/iommu/iommu.c

  2026	
  2027	void iommu_domain_free(struct iommu_domain *domain)
  2028	{
  2029		switch (domain->cookie_type) {
  2030		case IOMMU_COOKIE_DMA_IOVA:
  2031			iommu_put_dma_cookie(domain);
  2032			break;
  2033		case IOMMU_COOKIE_DMA_MSI:
  2034			iommu_put_msi_cookie(domain);
  2035			break;
  2036		case IOMMU_COOKIE_SVA:
  2037			mmdrop(domain->mm);
  2038			break;
  2039		default:
> 2040		}
  2041		if (domain->ops->free)
  2042			domain->ops->free(domain);
  2043	}
  2044	EXPORT_SYMBOL_GPL(iommu_domain_free);
  2045	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


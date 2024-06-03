Return-Path: <linux-kernel+bounces-198648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48588D7BAB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1B12817DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 06:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E132C859;
	Mon,  3 Jun 2024 06:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iDt2XIKu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841A1799B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 06:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396700; cv=none; b=Ntd2vdGikfZYtd7OowkFmUkVcFwr8foSa567MVMPrICB+PLpIP8zpfLLQS3bQUANf7ngDjCWqdlZv6eeQnRI82F5DTBowzGN0y96dMt8dyE3UzhC1ccBmOGbdXd2zCTVz7BqIFVtTeuHs3XfFzSEoCSjgpX8PRZ12yRukxau9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396700; c=relaxed/simple;
	bh=sWk1wjilan0FFkoMfarqiXPdTbXDabBugnGDpneW2S0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NLZZGpTmZLvNVbWFoMH1PEI9PFIRDjfTlTTovqjp395lqYJ45UbxcXwZDV/FdaK7OUkhOSrcKX60U9ioU0II6bRBXxsY4ntV2LDXfHnhwubHvLFxyZQ7nayoFrSp7CEQvzj0+KmBbRehRBCIm9kVDFOMsfHcyEKsWaPuOLsSUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iDt2XIKu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717396698; x=1748932698;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sWk1wjilan0FFkoMfarqiXPdTbXDabBugnGDpneW2S0=;
  b=iDt2XIKuLmqfIPMz9OdEzxKFbGqSj0MkHrylYdUiQdsZg5rytjoSxtdr
   vCbyNNVBX1fe1LX5d/KYHtTdAe13ifgSS1Oqh56dKas+FJsxVf6T93QxK
   Z+aPT217z2mpn3THc+DH/w+TmVxlNBl86PR0fvU92skjAX43KAQma2u/D
   8adzqUUvRzM9mHX7nf2MZz+JVApXfplzCpRz1uJgLdffAIBdqHtOAuHGj
   UbSZfbSC86Z05bOw2guW1A4CF42mSn9OfHCQzDyG7CGCiFggBaLpK9W9U
   oorctdw6lB7suJNylpHGz10xQzkRswqc3JX5yr9lc5C3oTIkk5cjRoVgT
   A==;
X-CSE-ConnectionGUID: PAzzZ8H2Qn+oPV4d0MBeYg==
X-CSE-MsgGUID: K+XXk+UGROiUdfU+l3nJdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="24450898"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="24450898"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 23:38:17 -0700
X-CSE-ConnectionGUID: 0LpvD4CmR6efmfyTX6pFjg==
X-CSE-MsgGUID: cfxoBYY6Ql25MZ5fM1ITyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="67620487"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 02 Jun 2024 23:38:16 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sE1KX-000L6z-16;
	Mon, 03 Jun 2024 06:38:10 +0000
Date: Mon, 3 Jun 2024 14:37:54 +0800
From: kernel test robot <lkp@intel.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>
Subject: drivers/iommu/io-pgtable-arm.c:330:13: error: void value not ignored
 as it ought to be
Message-ID: <202406031408.wNSVlKLV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c3f38fa61af77b49866b006939479069cd451173
commit: 9257959a6e5b4fca6fc8e985790bff62c2046f20 locking/atomic: scripts: restructure fallback ifdeffery
date:   12 months ago
config: arc-randconfig-r022-20230104 (https://download.01.org/0day-ci/archive/20240603/202406031408.wNSVlKLV-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240603/202406031408.wNSVlKLV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406031408.wNSVlKLV-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/io-pgtable-arm.c: In function 'arm_lpae_install_table':
>> drivers/iommu/io-pgtable-arm.c:330:13: error: void value not ignored as it ought to be
     330 |         old = cmpxchg64_relaxed(ptep, curr, new);
         |             ^
--
   drivers/iommu/io-pgtable-dart.c: In function 'dart_install_table':
>> drivers/iommu/io-pgtable-dart.c:168:13: error: void value not ignored as it ought to be
     168 |         old = cmpxchg64_relaxed(ptep, curr, new);
         |             ^
   drivers/iommu/io-pgtable-dart.c:157:25: warning: variable 'new' set but not used [-Wunused-but-set-variable]
     157 |         dart_iopte old, new;
         |                         ^~~


vim +330 drivers/iommu/io-pgtable-arm.c

c896c132b01895 Laurent Pinchart   2014-12-14  310  
fb3a95795da53d Robin Murphy       2017-06-22  311  static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
fb3a95795da53d Robin Murphy       2017-06-22  312  					     arm_lpae_iopte *ptep,
2c3d273eabe8b1 Robin Murphy       2017-06-22  313  					     arm_lpae_iopte curr,
9abe2ac834851a Hector Martin      2021-11-20  314  					     struct arm_lpae_io_pgtable *data)
fb3a95795da53d Robin Murphy       2017-06-22  315  {
2c3d273eabe8b1 Robin Murphy       2017-06-22  316  	arm_lpae_iopte old, new;
9abe2ac834851a Hector Martin      2021-11-20  317  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
e1d3c0fd701df8 Will Deacon        2014-11-14  318  
9abe2ac834851a Hector Martin      2021-11-20  319  	new = paddr_to_iopte(__pa(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
fb3a95795da53d Robin Murphy       2017-06-22  320  	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
fb3a95795da53d Robin Murphy       2017-06-22  321  		new |= ARM_LPAE_PTE_NSTABLE;
e1d3c0fd701df8 Will Deacon        2014-11-14  322  
77f3445866c39d Will Deacon        2017-06-23  323  	/*
77f3445866c39d Will Deacon        2017-06-23  324  	 * Ensure the table itself is visible before its PTE can be.
77f3445866c39d Will Deacon        2017-06-23  325  	 * Whilst we could get away with cmpxchg64_release below, this
77f3445866c39d Will Deacon        2017-06-23  326  	 * doesn't have any ordering semantics when !CONFIG_SMP.
77f3445866c39d Will Deacon        2017-06-23  327  	 */
77f3445866c39d Will Deacon        2017-06-23  328  	dma_wmb();
2c3d273eabe8b1 Robin Murphy       2017-06-22  329  
2c3d273eabe8b1 Robin Murphy       2017-06-22 @330  	old = cmpxchg64_relaxed(ptep, curr, new);
2c3d273eabe8b1 Robin Murphy       2017-06-22  331  
4f41845b340783 Will Deacon        2019-06-25  332  	if (cfg->coherent_walk || (old & ARM_LPAE_PTE_SW_SYNC))
2c3d273eabe8b1 Robin Murphy       2017-06-22  333  		return old;
2c3d273eabe8b1 Robin Murphy       2017-06-22  334  
2c3d273eabe8b1 Robin Murphy       2017-06-22  335  	/* Even if it's not ours, there's no point waiting; just kick it */
41e1eb2546e9c8 Isaac J. Manjarres 2021-06-16  336  	__arm_lpae_sync_pte(ptep, 1, cfg);
2c3d273eabe8b1 Robin Murphy       2017-06-22  337  	if (old == curr)
2c3d273eabe8b1 Robin Murphy       2017-06-22  338  		WRITE_ONCE(*ptep, new | ARM_LPAE_PTE_SW_SYNC);
2c3d273eabe8b1 Robin Murphy       2017-06-22  339  
2c3d273eabe8b1 Robin Murphy       2017-06-22  340  	return old;
e1d3c0fd701df8 Will Deacon        2014-11-14  341  }
e1d3c0fd701df8 Will Deacon        2014-11-14  342  

:::::: The code at line 330 was first introduced by commit
:::::: 2c3d273eabe8b1ed3b3cffe2c79643b1bf7e2d4a iommu/io-pgtable-arm: Support lockless operation

:::::: TO: Robin Murphy <robin.murphy@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


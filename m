Return-Path: <linux-kernel+bounces-423992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22F69DAF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CCFB21D91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6B2036E8;
	Wed, 27 Nov 2024 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="REzW9AoZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2145F9DD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732744401; cv=none; b=eIx2vRz3kvV0mu68R88+nqoRDR1w4rXLS6L9oUYTPv3Rkm+Zz7kkhnq+OO4W3ZkXG/j0LEPf86qMRme4JWqOC203pd7L9ISkQh1Y/zfRmVPLRfoQoLFDNceOoQyYUD0FnZSOCMNIYwpRK2GdMD/9Ddle/DLnQEu00pxAvqaL+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732744401; c=relaxed/simple;
	bh=afDgfOVBPK1rhMh8cctzVGb7mAQcptELThnP3o0NWS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IAPuiD9kEOir5COJwicNuvAjSAqO8AYAWq+Ij/rZYPUYBUQokwSMDP2uJB8m7AXxq8kDdj78iflK/Kivbw+cNTtbcRc55tvO0NZPXOjWQNnSk5nLCGd4/ITBs6EF+bntfITlH02f71bRP2mu4opEcC9d4YgvCZ4TkAIj874gSVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=REzW9AoZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732744400; x=1764280400;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=afDgfOVBPK1rhMh8cctzVGb7mAQcptELThnP3o0NWS4=;
  b=REzW9AoZ54X9EzLUcnuw51S2Pmf+vUm13OD6qZK93W3YdeMYRCuD+3Lz
   ica/45N/sgtYqzkiHHqyQ73npaeqSWEYCScNhybQWuaHUFBgbzeCXnHkx
   2+PbTKkJHF3mN4kmclbEV8L1NgT26Unw1jUlmztLsutJn87AsFjP1VHSb
   hoDecHYo6fUWflUvan7Fanxc/pzW0oXlonH+LcKckcDo6Ehpo3xHcSTzr
   VwCo4iSr3Nbfxa8SiaiG8RxqQYNAx2UsE6Ife1/RBcuoRsVy+t1Y1kc00
   TMEB4Y+Tk9O1M+Empl0EjcYnY1axiHBcGFbexBF3mLJklVrLVxOAEJFe1
   A==;
X-CSE-ConnectionGUID: mK7mISNARiu08IB4aaqy7w==
X-CSE-MsgGUID: 8hv3ZfUSScaMe3IAsM0qeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="36892542"
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="36892542"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 13:53:16 -0800
X-CSE-ConnectionGUID: ctfl7FEgTtecpr9CXdF1jw==
X-CSE-MsgGUID: X9IScREUStea+rlq5uxOkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,190,1728975600"; 
   d="scan'208";a="92148097"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Nov 2024 13:53:15 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGPyC-0008Nv-0p;
	Wed, 27 Nov 2024 21:53:12 +0000
Date: Thu, 28 Nov 2024 05:52:45 +0800
From: kernel test robot <lkp@intel.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-pci1xxxx.c:373:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202411280502.mjhGM5yh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   91dbbe6c9ffe5eded9a3e75d773ff92da8d2bc57
commit: 9538edeb72c989a4b90964ae4bba107eaf21a791 spi: mchp-pci1xxxx: DMA support for copying data to and from SPI Buf
date:   10 months ago
config: sh-randconfig-r131-20241122 (https://download.01.org/0day-ci/archive/20241128/202411280502.mjhGM5yh-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241128/202411280502.mjhGM5yh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411280502.mjhGM5yh-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/spi/spi-pci1xxxx.c:369:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/spi/spi-pci1xxxx.c:369:22: sparse:     expected void *base
   drivers/spi/spi-pci1xxxx.c:369:22: sparse:     got void [noderef] __iomem *
   drivers/spi/spi-pci1xxxx.c:371:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/spi/spi-pci1xxxx.c:371:22: sparse:     expected void *base
   drivers/spi/spi-pci1xxxx.c:371:22: sparse:     got void [noderef] __iomem *
>> drivers/spi/spi-pci1xxxx.c:373:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:373:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-pci1xxxx.c:373:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:374:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:374:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-pci1xxxx.c:374:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:375:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:375:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-pci1xxxx.c:375:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:376:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:376:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-pci1xxxx.c:376:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:377:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:377:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-pci1xxxx.c:377:9: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:379:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:379:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-pci1xxxx.c:379:9: sparse:     got void *

vim +373 drivers/spi/spi-pci1xxxx.c

   362	
   363	static void pci1xxxx_spi_setup_dma_from_io(struct pci1xxxx_spi_internal *p,
   364						   dma_addr_t dma_addr, u32 len)
   365	{
   366		void *base;
   367	
   368		if (!p->hw_inst)
   369			base = p->parent->dma_offset_bar + SPI_DMA_CH0_WR_BASE;
   370		else
   371			base = p->parent->dma_offset_bar + SPI_DMA_CH1_WR_BASE;
   372	
 > 373		writel(DMA_INTR_EN, base + SPI_DMA_CH_CTL1_OFFSET);
   374		writel(len, base + SPI_DMA_CH_XFER_LEN_OFFSET);
   375		writel(lower_32_bits(dma_addr), base + SPI_DMA_CH_DAR_LO_OFFSET);
   376		writel(upper_32_bits(dma_addr), base + SPI_DMA_CH_DAR_HI_OFFSET);
   377		writel(lower_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_RSP_BUF_OFFSET(p->hw_inst)),
   378		       base + SPI_DMA_CH_SAR_LO_OFFSET);
   379		writel(upper_32_bits(SPI_PERI_ADDR_BASE + SPI_MST_RSP_BUF_OFFSET(p->hw_inst)),
   380		       base + SPI_DMA_CH_SAR_HI_OFFSET);
   381	}
   382	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


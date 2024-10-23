Return-Path: <linux-kernel+bounces-377662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB6C9AC202
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D87C1C25FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D6115D5C5;
	Wed, 23 Oct 2024 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SYQLKkoP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE715CD55
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672962; cv=none; b=qo/dJhBhCIgRQVInjLxOEzUkqGO8qMyc5ksOGuoxqaFRn2/4znMoLOeVSa9G9HEywsW9hCNOABy7oj9FlAgsWZdB1pXiv4fZETQMHZ9bdafg0NiTAFxo3vIcws5QojhqMehZN9FsnHiKAs1zUHlKTgDHkNWJkHWq5ChFyBFqdnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672962; c=relaxed/simple;
	bh=it7iOZzrSGyV18dKm/xYlDLf2JyYaFHTrOEwgjHFvkA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I08fjBagvTz9GLxKARPKKUUaYRRglL7HmmqhwzK7sysNAdSlalEpQsTsEn4ME3alwnuFkQCGs6my5VRD3Tc7F8Amfmu//JUTVALXxWIbGTPbE3os0N4+3RO/Ak+QGh459oATtPEhRUjvtk59H0qK3b1xw2adOjyaIR//qVg7e8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SYQLKkoP; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729672960; x=1761208960;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=it7iOZzrSGyV18dKm/xYlDLf2JyYaFHTrOEwgjHFvkA=;
  b=SYQLKkoPI+9S0eO6NsDlqEsDxDKQk9Ht9jVVD528DRNdpJA0Dzk4q3oM
   CGUT1gcGh8l2vfaTHRjNEGYzsu7oQXx46TmWqCB9xlBPANL3UOOwVpSej
   ntnVlkY4Vb9Bg2OURIPRkmSM7147bFAGQ3LiItlvI0EnnIR6adc010ipt
   crgq11l/YHZHDZq3SOZe1beanMMt/xgRUKNFsKFDA01WhisZka5kM8VcQ
   mxKCKIwkD4eq69s96Q6+m5k233nrrMCr/vPjzCJkVmVWVgp3uWCFBNH4/
   yzzj/8f7Vj3Q0fSsh7j2DH/rMlctebVSzNei1xHO7a/MkD9n3XxHigFFq
   g==;
X-CSE-ConnectionGUID: tW7klmsFQ1eqcl9ybL76Jw==
X-CSE-MsgGUID: DgXAkXmUQY2XIRvF/HU2xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="28690625"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="28690625"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:42:39 -0700
X-CSE-ConnectionGUID: y8+BnbJDSDmEYVOejeDJ/g==
X-CSE-MsgGUID: IIbzzS3xSbKYk3b7F1AH5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84941557"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 23 Oct 2024 01:42:38 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3Wwt-000Ug1-1Q;
	Wed, 23 Oct 2024 08:42:35 +0000
Date: Wed, 23 Oct 2024 16:41:35 +0800
From: kernel test robot <lkp@intel.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-pci1xxxx.c:373:34: sparse: sparse: incorrect type in
 argument 2 (different address spaces)
Message-ID: <202410231613.esFBi2e7-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2ee9f594da826bea183ed14f2cc029c719bf4da
commit: 9538edeb72c989a4b90964ae4bba107eaf21a791 spi: mchp-pci1xxxx: DMA support for copying data to and from SPI Buf
date:   9 months ago
config: mips-randconfig-r131-20241020 (https://download.01.org/0day-ci/archive/20241023/202410231613.esFBi2e7-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20241023/202410231613.esFBi2e7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410231613.esFBi2e7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/spi/spi-pci1xxxx.c:369:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/spi/spi-pci1xxxx.c:369:22: sparse:     expected void *base
   drivers/spi/spi-pci1xxxx.c:369:22: sparse:     got void [noderef] __iomem *
   drivers/spi/spi-pci1xxxx.c:371:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *base @@     got void [noderef] __iomem * @@
   drivers/spi/spi-pci1xxxx.c:371:22: sparse:     expected void *base
   drivers/spi/spi-pci1xxxx.c:371:22: sparse:     got void [noderef] __iomem *
>> drivers/spi/spi-pci1xxxx.c:373:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:373:34: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:373:34: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:374:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:374:26: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:374:26: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:375:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:375:46: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:375:46: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:376:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:376:46: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:376:46: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:378:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:378:21: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:378:21: sparse:     got void *
   drivers/spi/spi-pci1xxxx.c:380:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
   drivers/spi/spi-pci1xxxx.c:380:21: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/spi/spi-pci1xxxx.c:380:21: sparse:     got void *

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


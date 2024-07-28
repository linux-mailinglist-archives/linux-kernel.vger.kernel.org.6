Return-Path: <linux-kernel+bounces-264814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E094793E8B6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 19:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB6E1C2161F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 17:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396BB57333;
	Sun, 28 Jul 2024 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TtwZATEv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A517756
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722186078; cv=none; b=cWm1AqtkQVJrzkBOPoV2OVSYoxELpIBLOVCDnfWQEFOXeieLiy6TINvb0v5OYo6VslIEtWcFH/UIP4EuiFQOnelIRfT4I1f2ZR57KdlwacGj/7SVqGfPxiyrXwZfRcnHcxdt4C6z9J+udmqeI37OG8B+HDN9i5RtSBh6pfUXK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722186078; c=relaxed/simple;
	bh=ic7tYNR8SCg7FkpcLLwbj2dRQBWZUZqX0bhfVSd5DiA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oQsVZigpzW5lDp8mWEqDiqfxjtQiSDxSKMznARDjWnYvcmXS6Xupy1R5OxeAfe3OEl4rksIr9hznq1KzTazujj1zX0Z2/DdQwvdQdqVBYrf6eCExFL+RLBggT0lnzRzUBV23Jb7gPJynYnX9gisnpTyC8UMeNJtvIbtCMvEvEZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TtwZATEv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722186075; x=1753722075;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ic7tYNR8SCg7FkpcLLwbj2dRQBWZUZqX0bhfVSd5DiA=;
  b=TtwZATEv9lu5NRDKpKbpeQhnjiP+KgFIp3TFkdn8aFguj5y+jNQNWz2i
   YqF0McyX9tdSwuY8bKUX3MZe3GAowbPDni78YuUJNiCt3SeoZPQ47zplt
   l47EvB7bK3cDFlKT2LTCMXKzGivVUR+0WatXZmCymS+Lhb86ZTfw9JQGq
   Xpbs4TmFsrAY96KzLKpz2Xx5qYdx41SzslYz9P7gM3CdUKoUMa9IdrSxs
   hocx7Fx7iOj2D2R7WL7AYqcwW6e7GmcxOVvhf3KHhY2xbW66YZ2U6xBbD
   ryPEAw/oLANrOhgoX9GpsD1gFsF+c5AFC7NXMm/Xmc+zNxPvnlme2o4aE
   Q==;
X-CSE-ConnectionGUID: EPczSMs/Qn+ALkHiKA9Mow==
X-CSE-MsgGUID: 4uj40NagR1mJMglG7pb8+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="45343133"
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="45343133"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2024 10:01:15 -0700
X-CSE-ConnectionGUID: HHCUlLaETEqJKZVc6nVUiQ==
X-CSE-MsgGUID: 3u5/u5npTSOIJv5QQu0F+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,244,1716274800"; 
   d="scan'208";a="76984027"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 28 Jul 2024 10:01:14 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sY7Gh-000qzE-2s;
	Sun, 28 Jul 2024 17:01:11 +0000
Date: Mon, 29 Jul 2024 01:00:39 +0800
From: kernel test robot <lkp@intel.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-pci1xxxx.c:373:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202407290017.blX9ckyE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5437f30d3458ad36e83ab96088d490ebfee844d8
commit: 9538edeb72c989a4b90964ae4bba107eaf21a791 spi: mchp-pci1xxxx: DMA support for copying data to and from SPI Buf
date:   6 months ago
config: sh-randconfig-r133-20240727 (https://download.01.org/0day-ci/archive/20240729/202407290017.blX9ckyE-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240729/202407290017.blX9ckyE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407290017.blX9ckyE-lkp@intel.com/

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
 > 369			base = p->parent->dma_offset_bar + SPI_DMA_CH0_WR_BASE;
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


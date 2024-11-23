Return-Path: <linux-kernel+bounces-418964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F75B9D67DF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 07:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F52B281BAA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 06:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B2A1662E7;
	Sat, 23 Nov 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDQGY+Mf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6670829405
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732344560; cv=none; b=iiOp09i+Dh5PwasYYhQx2ISGx4JrKRbedzHWF4+7EdASl1olGFO2bb79bhU2GZibCZdZj/DBeugOLgV6wg7k0voNAIBvfyhVaLNiRVaJWuxtTm7BlIMTyAaIIEsWSwqjhNlaY04tPckH3FVPUIWrOS9S57J4f0ke8Vt1pqDOh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732344560; c=relaxed/simple;
	bh=gW35Ha7gO4QWdWA4k6QSSsjT4xbUXw7Vsyy31OFPbaI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mXyfjXnmlYdNZhjFEwSuIfMT2tQKWhIifZrs7lRyOMZtWHc1v1DAovz4R4klQySY3I2pt/5pl3DRiKncIGA5V4VQgusk/6VYL+oCyj3m232WSZJciIK+cXZmhw3aJ13jA3zFGr2psF3H9kuzVhzCSjecYzgRnXCQdziq8fJu+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDQGY+Mf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732344558; x=1763880558;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gW35Ha7gO4QWdWA4k6QSSsjT4xbUXw7Vsyy31OFPbaI=;
  b=BDQGY+MfnNytL4z4m7jREP6nDbSx1DkAlAujM7aFfu+BfU2zcJu/d8vY
   cD2hDpgL7nhaLfHR9zQIGF8c84eF5Q0jSi/jkKoZzHlbBakPwQdO031cx
   q0W93HXo/xxNkS/qEXBRge9npJWcVe6Cgm6xR1x6Hkz9Ix4LyEFakWCz6
   N5w1uwArl+Bt1rKD7PAV6/EPWr9wp+ZSYLnYOWL5in4YEaNOSVvQMSPl0
   vF6YQOGYa2aW+CPcaJF2wlafyRVhVUKfK6XaJyupAqV9E5yYK2lDWt9e8
   ZuIAIOt78fMtAu9r6sb0T2K+eAs6CjaYtqmelmZT6Lxb/2JsuCsohSkc6
   A==;
X-CSE-ConnectionGUID: QLeBbaKvSwqnXHA+sJOdUw==
X-CSE-MsgGUID: 5AyGCfTCQraBmI+o0qRbng==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43881146"
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="43881146"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 22:49:17 -0800
X-CSE-ConnectionGUID: oek+gPJvRvSoSUqK/U46UA==
X-CSE-MsgGUID: 7Y+DKgPuTzuxS8XLpIdJcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,178,1728975600"; 
   d="scan'208";a="91210467"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 22 Nov 2024 22:49:16 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEjxC-0004Tr-0p;
	Sat, 23 Nov 2024 06:49:14 +0000
Date: Sat, 23 Nov 2024 14:48:46 +0800
From: kernel test robot <lkp@intel.com>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: drivers/spi/spi-pci1xxxx.c:373:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202411231439.49BinLEA-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2a163a4cea153348172e260a0c5b5569103a66a3
commit: 9538edeb72c989a4b90964ae4bba107eaf21a791 spi: mchp-pci1xxxx: DMA support for copying data to and from SPI Buf
date:   10 months ago
config: sh-randconfig-r131-20241122 (https://download.01.org/0day-ci/archive/20241123/202411231439.49BinLEA-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241123/202411231439.49BinLEA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411231439.49BinLEA-lkp@intel.com/

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


Return-Path: <linux-kernel+bounces-423033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5519DA194
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0A8FB22A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE213A899;
	Wed, 27 Nov 2024 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OSgcrPJ/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118A4689
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683109; cv=none; b=iuKwLahJwJIwWpBZRUkhoYLSkP8nBQziQHv3Rv3gDnMewqABuQmMfwlXiL1PitQ49ILWVXlgIvU4RRTACks0V3XmaFyBW0cDH6NY3rv5IiF1PhmkNuWjjGQ8km3aq/UQWWOD5DcjF+glNp3ePk9N7nft7uDdbNBlSgmf4DvfJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683109; c=relaxed/simple;
	bh=rDqGQIiBGrnO8ab9HsEnLELUlAJiAni0oDe+TfrUmOE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KGCMjBB6x1p3Kua/xGgdx/qeMPSE7l9SRGDXDg3KCqIub+F61ndHq4N++mNSCBZJV2pghFzeIgfDHcSGOT/bUM7FT0sGu5ocZAQFYJBzLVAVSDMXNC3wwM3RTspZ8FeehbyWegySQFbk6nvTacJhJJlyEX0ip1XBLnwwj/CkOmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OSgcrPJ/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732683105; x=1764219105;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rDqGQIiBGrnO8ab9HsEnLELUlAJiAni0oDe+TfrUmOE=;
  b=OSgcrPJ/kEs6uAu+uze+uQB31lwgAaD8zikmz/KRCglT7GsKVMX8TPws
   kZFqkqikVTHypzwtJ44wpBdtPDnurnRsQ7RlljZJPvY38vT5UuR2JtDHE
   KMK4P8EJ/iOICduiwvTxoYXPysa/2iwHbmODvjKTxqxnN8Ry1bEDpZ663
   yPDCzgBpAvJuAVCHY92Q1Z2pc8/PwJDY4fz85Gu+OXV/8IJXKc7ypn1Yh
   0tr8FZq8NP9VLeYxS+JqJvlY26lwKHGqyAeahJUY9rDv+VLr/2pUnJqI6
   l/3NnoBOFeMZ9fJTqeoU5284MmRx4JRpxjjm4Lqz8i0t5CFPwbHlNWb3u
   A==;
X-CSE-ConnectionGUID: Cz+69IE7SlSDoliQM3Dh3g==
X-CSE-MsgGUID: mm0T9326RP6EcAvHRHEwFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="50274326"
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="50274326"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2024 20:51:45 -0800
X-CSE-ConnectionGUID: Vhr3Wk0cRnuuPtUorzG83A==
X-CSE-MsgGUID: vaFudJz9SP25dCP1r/IHZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,188,1728975600"; 
   d="scan'208";a="91440882"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Nov 2024 20:51:43 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGA1d-0007il-0T;
	Wed, 27 Nov 2024 04:51:41 +0000
Date: Wed, 27 Nov 2024 12:51:30 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/korina.c:391:20: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202411271231.FyTfh6jG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   798bb342e0416d846cf67f4725a3428f39bfb96b
commit: 6ef92063bf94cd8a6fa9fea3a82596955eb25424 net: korina: Make driver COMPILE_TESTable
date:   3 years, 7 months ago
config: mips-randconfig-r122-20241112 (https://download.01.org/0day-ci/archive/20241127/202411271231.FyTfh6jG-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241127/202411271231.FyTfh6jG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411271231.FyTfh6jG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/korina.c:408:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct dma_reg *ch @@     got struct dma_reg [noderef] __iomem *tx_dma_regs @@
   drivers/net/ethernet/korina.c:408:33: sparse:     expected struct dma_reg *ch
   drivers/net/ethernet/korina.c:408:33: sparse:     got struct dma_reg [noderef] __iomem *tx_dma_regs
   drivers/net/ethernet/korina.c:415:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct dma_reg *ch @@     got struct dma_reg [noderef] __iomem *rx_dma_regs @@
   drivers/net/ethernet/korina.c:415:33: sparse:     expected struct dma_reg *ch
   drivers/net/ethernet/korina.c:415:33: sparse:     got struct dma_reg [noderef] __iomem *rx_dma_regs
>> drivers/net/ethernet/korina.c:391:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:391:20: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:391:20: sparse:     got unsigned int *
>> drivers/net/ethernet/korina.c:392:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:392:31: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:392:31: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:394:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:394:33: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:394:33: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:397:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:397:28: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:397:28: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:400:20: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:400:20: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:400:20: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:401:20: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:401:20: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:401:20: sparse:     got unsigned int *
>> drivers/net/ethernet/korina.c:391:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:391:20: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:391:20: sparse:     got unsigned int *
>> drivers/net/ethernet/korina.c:392:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:392:31: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:392:31: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:394:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:394:33: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:394:33: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:397:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:397:28: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:397:28: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:400:20: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:400:20: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:400:20: sparse:     got unsigned int *
   drivers/net/ethernet/korina.c:401:20: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/net/ethernet/korina.c:401:20: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/net/ethernet/korina.c:401:20: sparse:     got unsigned int *

vim +391 drivers/net/ethernet/korina.c

0fc96939a97ffd drivers/net/ethernet/korina.c Thomas Bogendoerfer 2021-04-19  387  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  388  static inline void korina_abort_dma(struct net_device *dev,
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  389  					struct dma_reg *ch)
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  390  {
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19 @391  	if (readl(&ch->dmac) & DMA_CHAN_RUN_BIT) {
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19 @392  		writel(0x10, &ch->dmac);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  393  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  394  		while (!(readl(&ch->dmas) & DMA_STAT_HALT))
860e9538a9482b drivers/net/ethernet/korina.c Florian Westphal    2016-05-03  395  			netif_trans_update(dev);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  396  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  397  		writel(0, &ch->dmas);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  398  	}
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  399  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  400  	writel(0, &ch->dmadptr);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  401  	writel(0, &ch->dmandptr);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  402  }
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  403  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  404  static void korina_abort_tx(struct net_device *dev)
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  405  {
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  406  	struct korina_private *lp = netdev_priv(dev);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  407  
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19 @408  	korina_abort_dma(dev, lp->tx_dma_regs);
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  409  }
ef11291bcd5f96 drivers/net/korina.c          Florian Fainelli    2008-03-19  410  

:::::: The code at line 391 was first introduced by commit
:::::: ef11291bcd5f963c72e7ba5952be3e3c97463d2c Add support the Korina (IDT RC32434) Ethernet MAC

:::::: TO: Florian Fainelli <florian.fainelli@telecomint.eu>
:::::: CC: Jeff Garzik <jeff@garzik.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-232415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CD991A88A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610771F2269D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6B195801;
	Thu, 27 Jun 2024 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QYo7o9H6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4AB1957F0
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719496812; cv=none; b=gPHOMmDzsJm+nCV5dEzb40sv8BW+hyzQBV7SjQ1b3hpXg0OIMuK6KbMG6IPs3q6iXPUAVCqI+epjXsKG80QC3wl9rhn9OjjdkjHkXFIS1RoPPZEhMOMBxX2VmCC/olFQpydH60oJuXZmk/+W3+SWLWEhvKUQ8+XqMNXLaxQ8pto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719496812; c=relaxed/simple;
	bh=LgBGKtBwZfpMFDGPGG2/N4d17mEMbtxMcO4dCLtOSEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StWCTTMtmEZGed3a1BYOPKVKRbW0fyXAKJK8uz9JoBGEFG1b2Dq6eBrvnx1fHbV/i2bTizaXGOlJmn2jo7WLctX1JY4gMa7kSf4ZuqT5DziJZZ44OAGMcTWYA2M54YQJf+neD0sZnDOmGUG+wpUNbIDdXKYkMiuldUQD1c8313U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QYo7o9H6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719496810; x=1751032810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LgBGKtBwZfpMFDGPGG2/N4d17mEMbtxMcO4dCLtOSEE=;
  b=QYo7o9H6njLhtw+pG2Kvwl7DEbJ9xgSANNBQzb4MYg+rXurmKI3d3Kyf
   TYNgXf2iExW4dbED31XdriWb4reJcQbM6edqpWpQ0Ja/SCQ1V894n3oct
   Qq+hP/tPuPtgU9k38Na8oY+sq/p/0ADMM6Jeq7KCcQVFdE1xs2hOG3fTR
   sxTsbdNVr3hYpO1VY4/FmblKckXS87P6oCmjih5WGD6znMZFK3Y4Euw17
   WsIgRq4BZv70vBrlc6pcFzkIhpFyPpnfM91Fi6UX/0WBpt+qrlOtqrtpT
   yVF0QsUoHwKzLs3151zXYk9yr4DcNWdCNH5Wa9aTjtRsU85e16v0rjLTg
   w==;
X-CSE-ConnectionGUID: AwNo5jP4TVqso38BU2iUgQ==
X-CSE-MsgGUID: utLgLmUWRDCiGouCbIv3fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27311568"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="27311568"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:00:10 -0700
X-CSE-ConnectionGUID: LTr6F1fYT9yQlGDVhYBTqw==
X-CSE-MsgGUID: /muBcJOpTIuJq4B1D1IPIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="48739501"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2024 07:00:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sMpfR-000GG5-1J;
	Thu, 27 Jun 2024 14:00:05 +0000
Date: Thu, 27 Jun 2024 21:59:05 +0800
From: kernel test robot <lkp@intel.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Stefan Agner <stefan@agner.ch>
Cc: oe-kbuild-all@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Subject: Re: [PATCH] mtd: nand: Add support for M5441x NFC
Message-ID: <202406272154.v694SvQb-lkp@intel.com>
References: <20240620-upstream-nfc-mcf5441x-v1-1-69b64807d7a6@yoseli.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620-upstream-nfc-mcf5441x-v1-1-69b64807d7a6@yoseli.org>

Hi Jean-Michel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e5b3efbe1ab1793bb49ae07d56d0973267e65112]

url:    https://github.com/intel-lab-lkp/linux/commits/Jean-Michel-Hautbois/mtd-nand-Add-support-for-M5441x-NFC/20240625-144333
base:   e5b3efbe1ab1793bb49ae07d56d0973267e65112
patch link:    https://lore.kernel.org/r/20240620-upstream-nfc-mcf5441x-v1-1-69b64807d7a6%40yoseli.org
patch subject: [PATCH] mtd: nand: Add support for M5441x NFC
config: sh-randconfig-001-20240627 (https://download.01.org/0day-ci/archive/20240627/202406272154.v694SvQb-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406272154.v694SvQb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406272154.v694SvQb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/mtd/nand/raw/vf610_nfc.c: In function 'vf610_nfc_probe':
>> drivers/mtd/nand/raw/vf610_nfc.c:844:29: warning: unused variable 'child' [-Wunused-variable]
     844 |         struct device_node *child;
         |                             ^~~~~


vim +/child +844 drivers/mtd/nand/raw/vf610_nfc.c

962c35ef1e6834 drivers/mtd/nand/raw/vf610_nfc.c Miquel Raynal        2018-07-20  837  
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  838  static int vf610_nfc_probe(struct platform_device *pdev)
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  839  {
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  840  	struct vf610_nfc *nfc;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  841  	struct mtd_info *mtd;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  842  	struct nand_chip *chip;
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  843  	struct nand_chip *pdata;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02 @844  	struct device_node *child;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  845  	int err;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  846  	int irq;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  847  
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  848  	nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  849  	if (!nfc)
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  850  		return -ENOMEM;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  851  
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  852  	nfc->dev = &pdev->dev;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  853  	chip = &nfc->chip;
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  854  	pdata = dev_get_platdata(&pdev->dev);
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  855  	if (pdata)
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  856  		*chip = *pdata;
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  857  
960823a226b37e drivers/mtd/nand/vf610_nfc.c     Boris Brezillon      2015-12-10  858  	mtd = nand_to_mtd(chip);
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  859  
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  860  	mtd->owner = THIS_MODULE;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  861  	mtd->dev.parent = nfc->dev;
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  862  
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  863  	/*
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  864  	 * We keep the MTD name unchanged to avoid breaking platforms
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  865  	 * where the MTD cmdline parser is used and the bootloader
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  866  	 * has not been updated to use the new naming scheme.
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  867  	 */
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  868  	if (!nfc->dev->of_node)
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  869  		mtd->name = "NAND";
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  870  	else
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  871  		mtd->name = DRV_NAME;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  872  
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  873  	irq = platform_get_irq(pdev, 0);
3549fecd10d24b drivers/mtd/nand/raw/vf610_nfc.c Zhu Wang             2023-08-03  874  	if (irq < 0)
3549fecd10d24b drivers/mtd/nand/raw/vf610_nfc.c Zhu Wang             2023-08-03  875  		return irq;
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  876  
2d77b08eaf0b2f drivers/mtd/nand/raw/vf610_nfc.c Cai Huoqing          2021-09-01  877  	nfc->regs = devm_platform_ioremap_resource(pdev, 0);
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  878  	if (IS_ERR(nfc->regs)) {
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  879  		dev_err(nfc->dev, "Unable to map registers!\n");
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  880  		return PTR_ERR(nfc->regs);
8e5473c07a181c drivers/mtd/nand/raw/vf610_nfc.c Jean-Michel Hautbois 2024-06-20  881  	}
456930d80a2da1 drivers/mtd/nand/vf610_nfc.c     Stefan Agner         2015-09-02  882  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


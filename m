Return-Path: <linux-kernel+bounces-306102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ED4963919
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF60B2179B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F5A145323;
	Thu, 29 Aug 2024 03:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kqreyw9R"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D34D8C6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724903687; cv=none; b=ZUgFwf3uKppTBTGtODRVmTOQPu53F5zjDIkRLboZ/lE5UANeilcZhJR4UXEJMWhvPjdY2tfrGrI/hvWmqTe0zc5fPQMsb04j7mjtGhSgQ7IAfBJk5ieSlGC0FgSrdQ/MVW7qmKcAQ7LDi1KS8+UKliAxupUoK2I68X8aFvTgIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724903687; c=relaxed/simple;
	bh=sF0iGMOK+Lwj1e0gMx/2nuQN7xoRc9d6g+UIAuerDlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mAAfr5xweOIhyJS/juHJVLUP/o5/ekdO5QYZLTTSc2jcd0s4tRofmfLnfbl0jHIkkeL/Ed1OuMykot9VXjhE15WV8LW8hx0XE9mEfJ6PdObGl9O0ZpuM5V3VPgIwDzHA3uDhIixEz4tvhv7yJ35hakFHAgwvQyAFSKN/Ih6tXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kqreyw9R; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724903685; x=1756439685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sF0iGMOK+Lwj1e0gMx/2nuQN7xoRc9d6g+UIAuerDlY=;
  b=Kqreyw9RuzlpB5w0EKVmnJtP3hzjCDj/JH70/9vcO4XuezDhHYpETvzf
   O3Z6sunF3FB87MCQ2peKfc5dWyWG4bZ0vWdoUAP7sZa8oHvGula08ZAs2
   22Mk2byPFKVaYhLyMnc9Lj/IWwiqIbAyABQbsyfMVGAokMqJ1y8CVL5rK
   rgVmSvDrvx/Qvx07qwyU9LDeQYKEEbN5MVDvOoOEoctFheTpO17VlpFcp
   AUL0dt4ac7qmxitG4a45mBCGQ2MLUChVyo56KWJQQtCHZxbR5+y1vQ6OI
   IW4fxtjzhl6r2bj8Qy1B8whvdL3lKxw+70J7mBmNHhBXWRmg0eO8Y+7lL
   A==;
X-CSE-ConnectionGUID: 2mP+I1uTT7C2jKw/34VdpA==
X-CSE-MsgGUID: WKXD+KFOR/WI2iFSl15jBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="45988092"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="45988092"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 20:54:44 -0700
X-CSE-ConnectionGUID: H8229kuBQhCqOQ1BZAW+NA==
X-CSE-MsgGUID: wCahuuRASLyhUGYuwZV7Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="67805003"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Aug 2024 20:54:43 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjWF6-000Ldy-1j;
	Thu, 29 Aug 2024 03:54:40 +0000
Date: Thu, 29 Aug 2024 11:54:31 +0800
From: kernel test robot <lkp@intel.com>
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: drivers/pci/controller/dwc/pcie-designware.c:898:50: error: '%d'
 directive output may be truncated writing between 1 and 11 bytes into a
 region of size 3
Message-ID: <202408291130.0S7KrQvL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Serge,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d5d547aa7b51467b15d9caa86b116f8c2507c72a
commit: 939fbcd568fd294034c96edc92ff5b9de1a5fce8 PCI: dwc: Add Root Port and Endpoint controller eDMA engine support
date:   1 year, 6 months ago
config: x86_64-sof-customedconfig-atom-defconfig (https://download.01.org/0day-ci/archive/20240829/202408291130.0S7KrQvL-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408291130.0S7KrQvL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408291130.0S7KrQvL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-designware.c: In function 'dw_pcie_edma_detect':
>> drivers/pci/controller/dwc/pcie-designware.c:898:50: error: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Werror=format-truncation=]
     898 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
         |                                                  ^~
   In function 'dw_pcie_edma_irq_verify',
       inlined from 'dw_pcie_edma_detect' at drivers/pci/controller/dwc/pcie-designware.c:949:8:
   drivers/pci/controller/dwc/pcie-designware.c:898:46: note: directive argument in the range [-2147483648, 22]
     898 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
         |                                              ^~~~~~~
   drivers/pci/controller/dwc/pcie-designware.c:898:17: note: 'snprintf' output between 5 and 15 bytes into a destination of size 6
     898 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +898 drivers/pci/controller/dwc/pcie-designware.c

   878	
   879	static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
   880	{
   881		struct platform_device *pdev = to_platform_device(pci->dev);
   882		u16 ch_cnt = pci->edma.ll_wr_cnt + pci->edma.ll_rd_cnt;
   883		char name[6];
   884		int ret;
   885	
   886		if (pci->edma.nr_irqs == 1)
   887			return 0;
   888		else if (pci->edma.nr_irqs > 1)
   889			return pci->edma.nr_irqs != ch_cnt ? -EINVAL : 0;
   890	
   891		ret = platform_get_irq_byname_optional(pdev, "dma");
   892		if (ret > 0) {
   893			pci->edma.nr_irqs = 1;
   894			return 0;
   895		}
   896	
   897		for (; pci->edma.nr_irqs < ch_cnt; pci->edma.nr_irqs++) {
 > 898			snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
   899	
   900			ret = platform_get_irq_byname_optional(pdev, name);
   901			if (ret <= 0)
   902				return -EINVAL;
   903		}
   904	
   905		return 0;
   906	}
   907	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


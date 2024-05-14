Return-Path: <linux-kernel+bounces-178223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE59B8C4AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 02:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62F32B2204C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 00:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8217F6;
	Tue, 14 May 2024 00:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/TMvp4n"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A525680
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 00:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715648047; cv=none; b=F9moVToCuKqgg6gAq+tQHktUfyAd2pRwfFifbEjSc3AU7o4EXdjbIKvIXdgzo5JqCH9jZ0nNaFIiyP/mMPLdZn9pPp5UASpx8n+Zm1mXJia5vFTgQ0uFj5FYyMH2YslJtm9v5lPV1jLSLmfU+p4fTSeZh+AlTYLT0w+zz0ohMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715648047; c=relaxed/simple;
	bh=4uyK/kbqvGAtgHNJRvxsUvNS7/zejH+K4JGLEiuXUkM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cfoP9A9ETDLH8fLaD8qkzDCsmT3c+3s0SoOF3FmKnN6VeXcGcvNym4NsCCmW5aNirfKE9vtq5jdPRld3uSUAeZrFwzrUMSKtcunQGyZ/4a8NgPB2pDlgWYWFQrIFpTxKviewEROLWZRrtFImyDW2nzm6y+5sv3nO/vB7aSbMQa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/TMvp4n; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715648045; x=1747184045;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4uyK/kbqvGAtgHNJRvxsUvNS7/zejH+K4JGLEiuXUkM=;
  b=Y/TMvp4n2m2xf7M4RZwb1gDvns93b02fI+WhrfT5HY32kBseTKGPhl6u
   CSZRxcN4xXJeWLC77xZDjBgV6X2pO2C8C8IQnZVH17rOV146zAnwzbdRB
   1n4vT/VX8nDF4n6RvgNM7RWYcfm/ZQzonQLQVJAUwHuALOujRNkyISJyp
   ajCEdUZXCx3ddns0HEB4/lcRb0BpWzCkuw7sukYJGdVS8adJ9ryAzONc4
   HYrGMfdu7MuqC02AlVMzsjXUv48Q5irFFzgMm/Iwhps4/gKlRda4kTdmt
   kblOnA5syrCUyydf5JUAbO+zdnxTJf5U1ulVnX2z4t76kAd443QnbZtXv
   A==;
X-CSE-ConnectionGUID: aBKFQx8uT7GVwC7/18ydnA==
X-CSE-MsgGUID: Oa5slsxhSv2WVDSGZ3twyQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="34121443"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="34121443"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 17:54:05 -0700
X-CSE-ConnectionGUID: MuLZh9cURaiASTpc5x1IlQ==
X-CSE-MsgGUID: vACrAPNhRc2FjB5a2CM6uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="34950062"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 May 2024 17:54:03 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6gQa-000Apt-2Y;
	Tue, 14 May 2024 00:54:00 +0000
Date: Tue, 14 May 2024 08:53:05 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: drivers/pci/controller/dwc/pci-imx6.c:564:5-8: Unneeded variable:
 "ret". Return "0" on line 608
Message-ID: <202405140813.2qtZhEsV-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Frank,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a7c840ba5fa78d7761b9fedc33d69cef44986d79
commit: 0c9651c21f2a09672a983e4c43a74824eca3b174 PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET
date:   2 months ago
config: arm64-randconfig-r054-20240514 (https://download.01.org/0day-ci/archive/20240514/202405140813.2qtZhEsV-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405140813.2qtZhEsV-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pci-imx6.c:564:5-8: Unneeded variable: "ret". Return "0" on line 608

vim +564 drivers/pci/controller/dwc/pci-imx6.c

3f7cceeab895fc drivers/pci/controller/dwc/pci-imx6.c Leonard Crestez     2018-10-08  560  
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  561  static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  562  {
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  563  	unsigned int offset;
e6f1fef04c2539 drivers/pci/host/pci-imx6.c           Andrey Smirnov      2016-05-02 @564  	int ret = 0;
e3c06cd063d69d drivers/pci/host/pci-imx6.c           Christoph Fritz     2016-04-05  565  
e8e4d4e95701a1 drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  566  	switch (imx6_pcie->drvdata->variant) {
e6f1fef04c2539 drivers/pci/host/pci-imx6.c           Andrey Smirnov      2016-05-02  567  	case IMX6SX:
e3c06cd063d69d drivers/pci/host/pci-imx6.c           Christoph Fritz     2016-04-05  568  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
e3c06cd063d69d drivers/pci/host/pci-imx6.c           Christoph Fritz     2016-04-05  569  				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
e6f1fef04c2539 drivers/pci/host/pci-imx6.c           Andrey Smirnov      2016-05-02  570  		break;
73abd0bf89d275 drivers/pci/controller/dwc/pci-imx6.c Gustavo A. R. Silva 2020-07-21  571  	case IMX6QP:
e6f1fef04c2539 drivers/pci/host/pci-imx6.c           Andrey Smirnov      2016-05-02  572  	case IMX6Q:
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  573  		/* power up core phy and enable ref clock */
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  574  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  575  				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  576  		/*
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  577  		 * the async reset input need ref clock to sync internally,
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  578  		 * when the ref clock comes after reset, internal synced
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  579  		 * reset time is too short, cannot meet the requirement.
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  580  		 * add one ~10us delay here.
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  581  		 */
87cb312777b5dc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-04-14  582  		usleep_range(10, 100);
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  583  		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  584  				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
e6f1fef04c2539 drivers/pci/host/pci-imx6.c           Andrey Smirnov      2016-05-02  585  		break;
9b3fe6796d7c0e drivers/pci/dwc/pci-imx6.c            Andrey Smirnov      2017-03-28  586  	case IMX7D:
9b3fe6796d7c0e drivers/pci/dwc/pci-imx6.c            Andrey Smirnov      2017-03-28  587  		break;
178e244cb6e209 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu         2021-12-24  588  	case IMX8MM:
fb3217e2cfc6a5 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu         2023-01-16  589  	case IMX8MM_EP:
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  590  	case IMX8MQ:
530ba41250b69d drivers/pci/controller/dwc/pci-imx6.c Richard Zhu         2023-01-16  591  	case IMX8MQ_EP:
3db1e531e44429 drivers/pci/controller/dwc/pci-imx6.c Richard Zhu         2022-09-02  592  	case IMX8MP:
c435669a41dd4e drivers/pci/controller/dwc/pci-imx6.c Richard Zhu         2023-01-16  593  	case IMX8MP_EP:
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  594  		offset = imx6_pcie_grp_offset(imx6_pcie);
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  595  		/*
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  596  		 * Set the over ride low and enabled
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  597  		 * make sure that REF_CLK is turned on.
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  598  		 */
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  599  		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  600  				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  601  				   0);
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  602  		regmap_update_bits(imx6_pcie->iomuxc_gpr, offset,
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  603  				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  604  				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
2d8ed461dbc9bc drivers/pci/controller/dwc/pci-imx6.c Andrey Smirnov      2019-02-01  605  		break;
e6f1fef04c2539 drivers/pci/host/pci-imx6.c           Andrey Smirnov      2016-05-02  606  	}
e6f1fef04c2539 drivers/pci/host/pci-imx6.c           Andrey Smirnov      2016-05-02  607  
e6f1fef04c2539 drivers/pci/host/pci-imx6.c           Andrey Smirnov      2016-05-02 @608  	return ret;
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  609  }
4d1821e729b5d2 drivers/pci/host/pci-imx6.c           Bjorn Helgaas       2016-03-14  610  

:::::: The code at line 564 was first introduced by commit
:::::: e6f1fef04c253955004efea35aea2e4bc59f49b6 PCI: imx6: Use enum instead of bool for variant indicator

:::::: TO: Andrey Smirnov <andrew.smirnov@gmail.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


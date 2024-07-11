Return-Path: <linux-kernel+bounces-249151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A661692E7B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0E71F20F54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D246A15ECDB;
	Thu, 11 Jul 2024 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WSGJf1Ai"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2915B0E5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720698866; cv=none; b=kNX8vjI+bZotevVx1KDYp8kvKYfscI6vC6E+bvPAeRIk3p/QK7Gz6lowM6TsdvjnoxEqPLnQTEh+SniEfJ3JgvdRmAiI3YC+Mw7hmjqAkFUqGxghZ3yiJ1obviDfheREdiPqEiSJhuLStBVdgCsFF7hI8BRlDoepyKwGAdQJM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720698866; c=relaxed/simple;
	bh=GYItkA+pjOofIuPg+Nv3z7NU9TVj+vHwJBg4ucKCyYM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YeRg+feQizoC2nuK8Kjt0VWzZXx/yrBrjy5lKVjBgZOTIfaukR5wVLpqpkTtzhuJyD42pN20I/3i/QbADtW5eUd/vtSO3rP67UbmTJ9uAIHavJdpXaooy/qtr0N8I/mvN/aijMOMQvYeBeSSAd6xLgXFr7+YTzszTUGcKET5ltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WSGJf1Ai; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720698864; x=1752234864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GYItkA+pjOofIuPg+Nv3z7NU9TVj+vHwJBg4ucKCyYM=;
  b=WSGJf1AiuIu5pDAxaImjL8cF3jkX3h6/TH7ks8+up9b4rKMW4yQ1pV5l
   47GOxLcwgfHn1uoQWg4PcXR/eJH0IEYuTNLEPdrilB+7hsO0+5cqxVevn
   ja+A3dfmMOScYyF+U0G6B+z/35MK+aPi6/K0o06h9xKPjlaetjT39RrUH
   OoCy9S0Op25NFdpxDstsdNV23ZAJ5KPPBv6Ji1HEwPPWmKoVzSE93nic3
   AWSpUKS91EYZ3zOM41F8CM7nMamzz2fDKV24L2WOcj7mz3SFSbXAvR0MZ
   C1+ykrSrRCAjeJNQssoCPuD9UufRH5XT65DJhI08qopSK2YctyBaOwY31
   g==;
X-CSE-ConnectionGUID: 03trkIZJS+O1+BJmotNJUQ==
X-CSE-MsgGUID: gu3f63XQSGujcAwuBs11Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21889801"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="21889801"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 04:54:24 -0700
X-CSE-ConnectionGUID: zXzOrVypSuGlUZKwCDcVZQ==
X-CSE-MsgGUID: MU7nCr+gRuKAeXKQawz8LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48428715"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Jul 2024 04:54:22 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRsNP-000ZEO-2F;
	Thu, 11 Jul 2024 11:54:19 +0000
Date: Thu, 11 Jul 2024 19:53:26 +0800
From: kernel test robot <lkp@intel.com>
To: WANG Xuerui <git@xen0n.name>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>
Subject: drivers/pci/controller/pcie-mediatek.c:925:43: warning: '%d'
 directive output may be truncated writing between 1 and 10 bytes into a
 region of size 6
Message-ID: <202407111957.xE3bLmJi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9d9a2f29aefdadc86e450308ff056017a209c755
commit: 3f301dc292eb122eff61b8b2906e519154b0327f LoongArch: Replace -ffreestanding with finer-grained -fno-builtin's
date:   11 months ago
config: loongarch-randconfig-001-20240711 (https://download.01.org/0day-ci/archive/20240711/202407111957.xE3bLmJi-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407111957.xE3bLmJi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407111957.xE3bLmJi-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/pcie-mediatek.c: In function 'mtk_pcie_parse_port':
>> drivers/pci/controller/pcie-mediatek.c:925:43: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Wformat-truncation=]
     925 |         snprintf(name, sizeof(name), "port%d", slot);
         |                                           ^~
   drivers/pci/controller/pcie-mediatek.c:925:38: note: directive argument in the range [0, 2147483647]
     925 |         snprintf(name, sizeof(name), "port%d", slot);
         |                                      ^~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:925:9: note: 'snprintf' output between 6 and 15 bytes into a destination of size 10
     925 |         snprintf(name, sizeof(name), "port%d", slot);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:932:45: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 4 [-Wformat-truncation=]
     932 |         snprintf(name, sizeof(name), "sys_ck%d", slot);
         |                                             ^~
   drivers/pci/controller/pcie-mediatek.c:932:38: note: directive argument in the range [0, 2147483647]
     932 |         snprintf(name, sizeof(name), "sys_ck%d", slot);
         |                                      ^~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:932:9: note: 'snprintf' output between 8 and 17 bytes into a destination of size 10
     932 |         snprintf(name, sizeof(name), "sys_ck%d", slot);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:940:45: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 4 [-Wformat-truncation=]
     940 |         snprintf(name, sizeof(name), "ahb_ck%d", slot);
         |                                             ^~
   drivers/pci/controller/pcie-mediatek.c:940:38: note: directive argument in the range [0, 2147483647]
     940 |         snprintf(name, sizeof(name), "ahb_ck%d", slot);
         |                                      ^~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:940:9: note: 'snprintf' output between 8 and 17 bytes into a destination of size 10
     940 |         snprintf(name, sizeof(name), "ahb_ck%d", slot);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:945:45: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 4 [-Wformat-truncation=]
     945 |         snprintf(name, sizeof(name), "axi_ck%d", slot);
         |                                             ^~
   drivers/pci/controller/pcie-mediatek.c:945:38: note: directive argument in the range [0, 2147483647]
     945 |         snprintf(name, sizeof(name), "axi_ck%d", slot);
         |                                      ^~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:945:9: note: 'snprintf' output between 8 and 17 bytes into a destination of size 10
     945 |         snprintf(name, sizeof(name), "axi_ck%d", slot);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:950:45: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 4 [-Wformat-truncation=]
     950 |         snprintf(name, sizeof(name), "aux_ck%d", slot);
         |                                             ^~
   drivers/pci/controller/pcie-mediatek.c:950:38: note: directive argument in the range [0, 2147483647]
     950 |         snprintf(name, sizeof(name), "aux_ck%d", slot);
         |                                      ^~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:950:9: note: 'snprintf' output between 8 and 17 bytes into a destination of size 10
     950 |         snprintf(name, sizeof(name), "aux_ck%d", slot);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:955:46: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 3 [-Wformat-truncation=]
     955 |         snprintf(name, sizeof(name), "obff_ck%d", slot);
         |                                              ^~
   drivers/pci/controller/pcie-mediatek.c:955:38: note: directive argument in the range [0, 2147483647]
     955 |         snprintf(name, sizeof(name), "obff_ck%d", slot);
         |                                      ^~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:955:9: note: 'snprintf' output between 9 and 18 bytes into a destination of size 10
     955 |         snprintf(name, sizeof(name), "obff_ck%d", slot);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:960:46: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 3 [-Wformat-truncation=]
     960 |         snprintf(name, sizeof(name), "pipe_ck%d", slot);
         |                                              ^~
   drivers/pci/controller/pcie-mediatek.c:960:38: note: directive argument in the range [0, 2147483647]
     960 |         snprintf(name, sizeof(name), "pipe_ck%d", slot);
         |                                      ^~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:960:9: note: 'snprintf' output between 9 and 18 bytes into a destination of size 10
     960 |         snprintf(name, sizeof(name), "pipe_ck%d", slot);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:965:47: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
     965 |         snprintf(name, sizeof(name), "pcie-rst%d", slot);
         |                                               ^~
   drivers/pci/controller/pcie-mediatek.c:965:38: note: directive argument in the range [0, 2147483647]
     965 |         snprintf(name, sizeof(name), "pcie-rst%d", slot);
         |                                      ^~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:965:9: note: 'snprintf' output between 10 and 19 bytes into a destination of size 10
     965 |         snprintf(name, sizeof(name), "pcie-rst%d", slot);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:971:47: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 2 [-Wformat-truncation=]
     971 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
         |                                               ^~
   drivers/pci/controller/pcie-mediatek.c:971:38: note: directive argument in the range [0, 2147483647]
     971 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
         |                                      ^~~~~~~~~~~~
   drivers/pci/controller/pcie-mediatek.c:971:9: note: 'snprintf' output between 10 and 19 bytes into a destination of size 10
     971 |         snprintf(name, sizeof(name), "pcie-phy%d", slot);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +925 drivers/pci/controller/pcie-mediatek.c

637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  910  
4f6f0460448d57 drivers/pci/host/pcie-mediatek.c       Honghui Zhang 2017-08-10  911  static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  912  			       struct device_node *node,
4f6f0460448d57 drivers/pci/host/pcie-mediatek.c       Honghui Zhang 2017-08-10  913  			       int slot)
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  914  {
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  915  	struct mtk_pcie_port *port;
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  916  	struct device *dev = pcie->dev;
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  917  	struct platform_device *pdev = to_platform_device(dev);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  918  	char name[10];
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  919  	int err;
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  920  
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  921  	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  922  	if (!port)
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  923  		return -ENOMEM;
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  924  
1eacd7b84e0413 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10 @925  	snprintf(name, sizeof(name), "port%d", slot);
e2dcd20b1645a7 drivers/pci/controller/pcie-mediatek.c Dejin Zheng   2020-06-03  926  	port->base = devm_platform_ioremap_resource_byname(pdev, name);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  927  	if (IS_ERR(port->base)) {
4f6f0460448d57 drivers/pci/host/pcie-mediatek.c       Honghui Zhang 2017-08-10  928  		dev_err(dev, "failed to map port%d base\n", slot);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  929  		return PTR_ERR(port->base);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  930  	}
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  931  
4f6f0460448d57 drivers/pci/host/pcie-mediatek.c       Honghui Zhang 2017-08-10  932  	snprintf(name, sizeof(name), "sys_ck%d", slot);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  933  	port->sys_ck = devm_clk_get(dev, name);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  934  	if (IS_ERR(port->sys_ck)) {
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  935  		dev_err(dev, "failed to get sys_ck%d clock\n", slot);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  936  		return PTR_ERR(port->sys_ck);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  937  	}
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  938  
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  939  	/* sys_ck might be divided into the following parts in some chips */
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  940  	snprintf(name, sizeof(name), "ahb_ck%d", slot);
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  941  	port->ahb_ck = devm_clk_get_optional(dev, name);
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  942  	if (IS_ERR(port->ahb_ck))
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  943  		return PTR_ERR(port->ahb_ck);
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  944  
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  945  	snprintf(name, sizeof(name), "axi_ck%d", slot);
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  946  	port->axi_ck = devm_clk_get_optional(dev, name);
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  947  	if (IS_ERR(port->axi_ck))
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  948  		return PTR_ERR(port->axi_ck);
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  949  
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  950  	snprintf(name, sizeof(name), "aux_ck%d", slot);
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  951  	port->aux_ck = devm_clk_get_optional(dev, name);
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  952  	if (IS_ERR(port->aux_ck))
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  953  		return PTR_ERR(port->aux_ck);
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  954  
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  955  	snprintf(name, sizeof(name), "obff_ck%d", slot);
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  956  	port->obff_ck = devm_clk_get_optional(dev, name);
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  957  	if (IS_ERR(port->obff_ck))
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  958  		return PTR_ERR(port->obff_ck);
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  959  
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  960  	snprintf(name, sizeof(name), "pipe_ck%d", slot);
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  961  	port->pipe_ck = devm_clk_get_optional(dev, name);
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  962  	if (IS_ERR(port->pipe_ck))
6be22343cc546b drivers/pci/controller/pcie-mediatek.c Chunfeng Yun  2019-04-10  963  		return PTR_ERR(port->pipe_ck);
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  964  
4f6f0460448d57 drivers/pci/host/pcie-mediatek.c       Honghui Zhang 2017-08-10  965  	snprintf(name, sizeof(name), "pcie-rst%d", slot);
608fcac7ce31b9 drivers/pci/host/pcie-mediatek.c       Philipp Zabel 2017-07-19  966  	port->reset = devm_reset_control_get_optional_exclusive(dev, name);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  967  	if (PTR_ERR(port->reset) == -EPROBE_DEFER)
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  968  		return PTR_ERR(port->reset);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  969  
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  970  	/* some platforms may use default PHY setting */
4f6f0460448d57 drivers/pci/host/pcie-mediatek.c       Honghui Zhang 2017-08-10  971  	snprintf(name, sizeof(name), "pcie-phy%d", slot);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  972  	port->phy = devm_phy_optional_get(dev, name);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  973  	if (IS_ERR(port->phy))
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  974  		return PTR_ERR(port->phy);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  975  
4f6f0460448d57 drivers/pci/host/pcie-mediatek.c       Honghui Zhang 2017-08-10  976  	port->slot = slot;
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  977  	port->pcie = pcie;
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  978  
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  979  	if (pcie->soc->setup_irq) {
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  980  		err = pcie->soc->setup_irq(port, node);
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  981  		if (err)
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  982  			return err;
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  983  	}
b099631df160ec drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  984  
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  985  	INIT_LIST_HEAD(&port->list);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  986  	list_add_tail(&port->list, &pcie->ports);
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  987  
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  988  	return 0;
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  989  }
637cfacae96fa6 drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-05-21  990  

:::::: The code at line 925 was first introduced by commit
:::::: 1eacd7b84e0413f55fbc0c61874f745cc5e2ed9e PCI: mediatek: Switch to use platform_get_resource_byname()

:::::: TO: Ryder Lee <ryder.lee@mediatek.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


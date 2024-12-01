Return-Path: <linux-kernel+bounces-426723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A205F9DF705
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 20:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0F216229A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03151D88DB;
	Sun,  1 Dec 2024 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGFU8LaJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336971D79B4;
	Sun,  1 Dec 2024 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733082719; cv=none; b=K8Mi7K5Zhxu62Yptosa2nDF1+booA4gFT9EiW4jNDfz7W6weNE7UML9lTVe68UMdEZynwFEgpztjooQo1bkBE2p9J4kJ3Oc7SoL0rPARwJlrpV3oeVl/jtM5THfaB7lPbgHNbMLvRkLecShcdzmaHVFIWgvNaCCHjevzUcQ5RUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733082719; c=relaxed/simple;
	bh=L4sWQwS8YgSCnvpkiITIwcHkOsXhtDgPDy4uKwt3uF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzZVDo5056VKpRxPRHUiP0MndnlLpbLSD/rW3RclyxZNpgmhMPGxST/b/opLYSa4ekr1VhVk7S+5vlM4AhmNqtVTEEeE05QyCDYpDpm4C446int5GRz/4E4RPg+Ycb88SvFrEcYSqlp4LJHVnFtld0hv2L/YYapqh5DV5Fypnao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGFU8LaJ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733082716; x=1764618716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L4sWQwS8YgSCnvpkiITIwcHkOsXhtDgPDy4uKwt3uF8=;
  b=AGFU8LaJjvY2iFw/5DIeWH5J8SCWhEnoX9dI2yhhhLRpYV5++Yx7QWyT
   Bdn9lWot0cjFafRbIX/OqxexarP47/LDbMzM7vx4qD//8OOOykT0cdpfd
   mmH2/zhVba92xgLCwhqPSiRB7E1JgrHMCm4mccm7t7Nh/QcRH8hR6iNWV
   i58p9RE+x2zbuXOqQ/0ynEkVo2dyiSTDrOuqFKU8tMGLeJqe3w3Mc+wUI
   xnzRHSZUzlthq8m49yo9LY/njC7SuO280oPTkhSvMwu7+/5oYkIqp0uVm
   zRkKEgzTAnNUBXD7WJN9FRR+q1TIC/FKOr1Msx7+XFkJnfqsNOeyOsSDJ
   g==;
X-CSE-ConnectionGUID: 1+F+wDa+RTWcIYAsDlCuig==
X-CSE-MsgGUID: sze4zAeCRRquB5N3Q4/S2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11273"; a="44626202"
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="44626202"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2024 11:51:55 -0800
X-CSE-ConnectionGUID: EhFBen21QuywjJaLFyYAdQ==
X-CSE-MsgGUID: 6jIBKtLgSm2grwfuOsD/xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,201,1728975600"; 
   d="scan'208";a="93392888"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa009.fm.intel.com with ESMTP; 01 Dec 2024 11:51:51 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tHpyu-0001oL-31;
	Sun, 01 Dec 2024 19:51:48 +0000
Date: Mon, 2 Dec 2024 03:51:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Peng Fan <peng.fan@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 12/18] clk: imx: add support for i.MX8MN anatop clock
 driver
Message-ID: <202412020318.WUBdIsyd-lkp@intel.com>
References: <20241201174639.742000-13-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241201174639.742000-13-dario.binacchi@amarulasolutions.com>

Hi Dario,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelvesa/clk/imx]
[also build test ERROR on shawnguo/for-next clk/clk-next linus/master v6.12 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dario-Binacchi/clk-imx8mm-rename-video_pll1-to-video_pll/20241202-015316
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git clk/imx
patch link:    https://lore.kernel.org/r/20241201174639.742000-13-dario.binacchi%40amarulasolutions.com
patch subject: [PATCH v4 12/18] clk: imx: add support for i.MX8MN anatop clock driver
config: arc-randconfig-002-20241202 (https://download.01.org/0day-ci/archive/20241202/202412020318.WUBdIsyd-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241202/202412020318.WUBdIsyd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412020318.WUBdIsyd-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/clk/imx/clk-imx8mn.c: In function 'imx8mn_clocks_probe':
>> drivers/clk/imx/clk-imx8mn.c:323:33: error: implicit declaration of function 'imx8m_anatop_get_clk_hw' [-Werror=implicit-function-declaration]
     323 |         hws[IMX8MN_CLK_DUMMY] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_DUMMY);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/imx/clk-imx8mn.c:323:31: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     323 |         hws[IMX8MN_CLK_DUMMY] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_DUMMY);
         |                               ^
   drivers/clk/imx/clk-imx8mn.c:324:29: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     324 |         hws[IMX8MN_CLK_24M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_24M);
         |                             ^
   drivers/clk/imx/clk-imx8mn.c:325:29: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     325 |         hws[IMX8MN_CLK_32K] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_32K);
         |                             ^
   drivers/clk/imx/clk-imx8mn.c:331:40: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     331 |         hws[IMX8MN_AUDIO_PLL1_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL1_REF_SEL);
         |                                        ^
   drivers/clk/imx/clk-imx8mn.c:332:40: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     332 |         hws[IMX8MN_AUDIO_PLL2_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL2_REF_SEL);
         |                                        ^
   drivers/clk/imx/clk-imx8mn.c:333:39: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     333 |         hws[IMX8MN_VIDEO_PLL_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_VIDEO_PLL_REF_SEL);
         |                                       ^
   drivers/clk/imx/clk-imx8mn.c:334:38: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     334 |         hws[IMX8MN_DRAM_PLL_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_DRAM_PLL_REF_SEL);
         |                                      ^
   drivers/clk/imx/clk-imx8mn.c:335:37: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     335 |         hws[IMX8MN_GPU_PLL_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_GPU_PLL_REF_SEL);
         |                                     ^
   drivers/clk/imx/clk-imx8mn.c:336:40: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     336 |         hws[IMX8MN_M7_ALT_PLL_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_M7_ALT_PLL_REF_SEL);
         |                                        ^
   drivers/clk/imx/clk-imx8mn.c:337:37: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     337 |         hws[IMX8MN_ARM_PLL_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_ARM_PLL_REF_SEL);
         |                                     ^
   drivers/clk/imx/clk-imx8mn.c:338:38: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     338 |         hws[IMX8MN_SYS_PLL3_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL3_REF_SEL);
         |                                      ^
   drivers/clk/imx/clk-imx8mn.c:340:32: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     340 |         hws[IMX8MN_AUDIO_PLL1] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL1);
         |                                ^
   drivers/clk/imx/clk-imx8mn.c:341:32: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     341 |         hws[IMX8MN_AUDIO_PLL2] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL2);
         |                                ^
   drivers/clk/imx/clk-imx8mn.c:342:31: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     342 |         hws[IMX8MN_VIDEO_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_VIDEO_PLL);
         |                               ^
   drivers/clk/imx/clk-imx8mn.c:343:30: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     343 |         hws[IMX8MN_DRAM_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_DRAM_PLL);
         |                              ^
   drivers/clk/imx/clk-imx8mn.c:344:29: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     344 |         hws[IMX8MN_GPU_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_GPU_PLL);
         |                             ^
   drivers/clk/imx/clk-imx8mn.c:345:32: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     345 |         hws[IMX8MN_M7_ALT_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_M7_ALT_PLL);
         |                                ^
   drivers/clk/imx/clk-imx8mn.c:346:29: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     346 |         hws[IMX8MN_ARM_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_ARM_PLL);
         |                             ^
   drivers/clk/imx/clk-imx8mn.c:347:30: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     347 |         hws[IMX8MN_SYS_PLL1] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1);
         |                              ^
   drivers/clk/imx/clk-imx8mn.c:348:30: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     348 |         hws[IMX8MN_SYS_PLL2] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2);
         |                              ^
   drivers/clk/imx/clk-imx8mn.c:349:30: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     349 |         hws[IMX8MN_SYS_PLL3] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL3);
         |                              ^
   drivers/clk/imx/clk-imx8mn.c:352:39: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     352 |         hws[IMX8MN_AUDIO_PLL1_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL1_BYPASS);
         |                                       ^
   drivers/clk/imx/clk-imx8mn.c:353:39: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     353 |         hws[IMX8MN_AUDIO_PLL2_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL2_BYPASS);
         |                                       ^
   drivers/clk/imx/clk-imx8mn.c:354:38: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     354 |         hws[IMX8MN_VIDEO_PLL_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_VIDEO_PLL_BYPASS);
         |                                      ^
   drivers/clk/imx/clk-imx8mn.c:355:37: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     355 |         hws[IMX8MN_DRAM_PLL_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_DRAM_PLL_BYPASS);
         |                                     ^
   drivers/clk/imx/clk-imx8mn.c:356:36: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     356 |         hws[IMX8MN_GPU_PLL_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_GPU_PLL_BYPASS);
         |                                    ^
   drivers/clk/imx/clk-imx8mn.c:357:39: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     357 |         hws[IMX8MN_M7_ALT_PLL_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_M7_ALT_PLL_BYPASS);
         |                                       ^
   drivers/clk/imx/clk-imx8mn.c:358:36: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     358 |         hws[IMX8MN_ARM_PLL_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_ARM_PLL_BYPASS);
         |                                    ^
   drivers/clk/imx/clk-imx8mn.c:359:37: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     359 |         hws[IMX8MN_SYS_PLL3_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL3_BYPASS);
         |                                     ^
   drivers/clk/imx/clk-imx8mn.c:362:36: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     362 |         hws[IMX8MN_AUDIO_PLL1_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL1_OUT);
         |                                    ^
   drivers/clk/imx/clk-imx8mn.c:363:36: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     363 |         hws[IMX8MN_AUDIO_PLL2_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL2_OUT);
         |                                    ^
   drivers/clk/imx/clk-imx8mn.c:364:35: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     364 |         hws[IMX8MN_VIDEO_PLL_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_VIDEO_PLL_OUT);
         |                                   ^
   drivers/clk/imx/clk-imx8mn.c:365:34: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     365 |         hws[IMX8MN_DRAM_PLL_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_DRAM_PLL_OUT);
         |                                  ^
   drivers/clk/imx/clk-imx8mn.c:366:33: warning: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     366 |         hws[IMX8MN_GPU_PLL_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_GPU_PLL_OUT);


vim +/imx8m_anatop_get_clk_hw +323 drivers/clk/imx/clk-imx8mn.c

   303	
   304	static int imx8mn_clocks_probe(struct platform_device *pdev)
   305	{
   306		struct device *dev = &pdev->dev;
   307		struct device_node *np = dev->of_node;
   308		void __iomem *base;
   309		int ret;
   310	
   311		base = devm_platform_ioremap_resource(pdev, 0);
   312		if (WARN_ON(IS_ERR(base)))
   313			return PTR_ERR(base);
   314	
   315		clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws,
   316						  IMX8MN_CLK_END), GFP_KERNEL);
   317		if (WARN_ON(!clk_hw_data))
   318			return -ENOMEM;
   319	
   320		clk_hw_data->num = IMX8MN_CLK_END;
   321		hws = clk_hw_data->hws;
   322	
 > 323		hws[IMX8MN_CLK_DUMMY] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_DUMMY);
   324		hws[IMX8MN_CLK_24M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_24M);
   325		hws[IMX8MN_CLK_32K] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_32K);
   326		hws[IMX8MN_CLK_EXT1] = imx_get_clk_hw_by_name(np, "clk_ext1");
   327		hws[IMX8MN_CLK_EXT2] = imx_get_clk_hw_by_name(np, "clk_ext2");
   328		hws[IMX8MN_CLK_EXT3] = imx_get_clk_hw_by_name(np, "clk_ext3");
   329		hws[IMX8MN_CLK_EXT4] = imx_get_clk_hw_by_name(np, "clk_ext4");
   330	
   331		hws[IMX8MN_AUDIO_PLL1_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL1_REF_SEL);
   332		hws[IMX8MN_AUDIO_PLL2_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL2_REF_SEL);
   333		hws[IMX8MN_VIDEO_PLL_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_VIDEO_PLL_REF_SEL);
   334		hws[IMX8MN_DRAM_PLL_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_DRAM_PLL_REF_SEL);
   335		hws[IMX8MN_GPU_PLL_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_GPU_PLL_REF_SEL);
   336		hws[IMX8MN_M7_ALT_PLL_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_M7_ALT_PLL_REF_SEL);
   337		hws[IMX8MN_ARM_PLL_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_ARM_PLL_REF_SEL);
   338		hws[IMX8MN_SYS_PLL3_REF_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL3_REF_SEL);
   339	
   340		hws[IMX8MN_AUDIO_PLL1] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL1);
   341		hws[IMX8MN_AUDIO_PLL2] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL2);
   342		hws[IMX8MN_VIDEO_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_VIDEO_PLL);
   343		hws[IMX8MN_DRAM_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_DRAM_PLL);
   344		hws[IMX8MN_GPU_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_GPU_PLL);
   345		hws[IMX8MN_M7_ALT_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_M7_ALT_PLL);
   346		hws[IMX8MN_ARM_PLL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_ARM_PLL);
   347		hws[IMX8MN_SYS_PLL1] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1);
   348		hws[IMX8MN_SYS_PLL2] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2);
   349		hws[IMX8MN_SYS_PLL3] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL3);
   350	
   351		/* PLL bypass out */
   352		hws[IMX8MN_AUDIO_PLL1_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL1_BYPASS);
   353		hws[IMX8MN_AUDIO_PLL2_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL2_BYPASS);
   354		hws[IMX8MN_VIDEO_PLL_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_VIDEO_PLL_BYPASS);
   355		hws[IMX8MN_DRAM_PLL_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_DRAM_PLL_BYPASS);
   356		hws[IMX8MN_GPU_PLL_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_GPU_PLL_BYPASS);
   357		hws[IMX8MN_M7_ALT_PLL_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_M7_ALT_PLL_BYPASS);
   358		hws[IMX8MN_ARM_PLL_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_ARM_PLL_BYPASS);
   359		hws[IMX8MN_SYS_PLL3_BYPASS] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL3_BYPASS);
   360	
   361		/* PLL out gate */
   362		hws[IMX8MN_AUDIO_PLL1_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL1_OUT);
   363		hws[IMX8MN_AUDIO_PLL2_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_AUDIO_PLL2_OUT);
   364		hws[IMX8MN_VIDEO_PLL_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_VIDEO_PLL_OUT);
   365		hws[IMX8MN_DRAM_PLL_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_DRAM_PLL_OUT);
   366		hws[IMX8MN_GPU_PLL_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_GPU_PLL_OUT);
   367		hws[IMX8MN_M7_ALT_PLL_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_M7_ALT_PLL_OUT);
   368		hws[IMX8MN_ARM_PLL_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_ARM_PLL_OUT);
   369		hws[IMX8MN_SYS_PLL3_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL3_OUT);
   370	
   371		/* SYS PLL1 fixed output */
   372		hws[IMX8MN_SYS_PLL1_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1_OUT);
   373		hws[IMX8MN_SYS_PLL1_40M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1_40M);
   374		hws[IMX8MN_SYS_PLL1_80M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1_80M);
   375		hws[IMX8MN_SYS_PLL1_100M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1_100M);
   376		hws[IMX8MN_SYS_PLL1_133M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1_133M);
   377		hws[IMX8MN_SYS_PLL1_160M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1_160M);
   378		hws[IMX8MN_SYS_PLL1_200M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1_200M);
   379		hws[IMX8MN_SYS_PLL1_266M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1_266M);
   380		hws[IMX8MN_SYS_PLL1_400M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1_400M);
   381		hws[IMX8MN_SYS_PLL1_800M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL1_800M);
   382	
   383		/* SYS PLL2 fixed output */
   384		hws[IMX8MN_SYS_PLL2_OUT] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2_OUT);
   385		hws[IMX8MN_SYS_PLL2_50M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2_50M);
   386		hws[IMX8MN_SYS_PLL2_100M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2_100M);
   387		hws[IMX8MN_SYS_PLL2_125M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2_125M);
   388		hws[IMX8MN_SYS_PLL2_166M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2_166M);
   389		hws[IMX8MN_SYS_PLL2_200M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2_200M);
   390		hws[IMX8MN_SYS_PLL2_250M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2_250M);
   391		hws[IMX8MN_SYS_PLL2_333M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2_333M);
   392		hws[IMX8MN_SYS_PLL2_500M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2_500M);
   393		hws[IMX8MN_SYS_PLL2_1000M] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_SYS_PLL2_1000M);
   394	
   395		hws[IMX8MN_CLK_CLKOUT1_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_CLKOUT1_SEL);
   396		hws[IMX8MN_CLK_CLKOUT1_DIV] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_CLKOUT1_DIV);
   397		hws[IMX8MN_CLK_CLKOUT1] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_CLKOUT1);
   398		hws[IMX8MN_CLK_CLKOUT2_SEL] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_CLKOUT2_SEL);
   399		hws[IMX8MN_CLK_CLKOUT2_DIV] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_CLKOUT2_DIV);
   400		hws[IMX8MN_CLK_CLKOUT2] = imx8m_anatop_get_clk_hw(IMX8MN_ANATOP_CLK_CLKOUT2);
   401	
   402		/* CORE */
   403		hws[IMX8MN_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mn_a53_sels, base + 0x8000);
   404		hws[IMX8MN_CLK_A53_SRC] = hws[IMX8MN_CLK_A53_DIV];
   405		hws[IMX8MN_CLK_A53_CG] = hws[IMX8MN_CLK_A53_DIV];
   406	
   407		hws[IMX8MN_CLK_M7_CORE] = imx8m_clk_hw_composite_core("arm_m7_core", imx8mn_m7_sels, base + 0x8080);
   408	
   409		hws[IMX8MN_CLK_GPU_CORE] = imx8m_clk_hw_composite_core("gpu_core", imx8mn_gpu_core_sels, base + 0x8180);
   410		hws[IMX8MN_CLK_GPU_SHADER] = imx8m_clk_hw_composite_core("gpu_shader", imx8mn_gpu_shader_sels, base + 0x8200);
   411	
   412		hws[IMX8MN_CLK_GPU_CORE_SRC] = hws[IMX8MN_CLK_GPU_CORE];
   413		hws[IMX8MN_CLK_GPU_CORE_CG] = hws[IMX8MN_CLK_GPU_CORE];
   414		hws[IMX8MN_CLK_GPU_CORE_DIV] = hws[IMX8MN_CLK_GPU_CORE];
   415		hws[IMX8MN_CLK_GPU_SHADER_SRC] = hws[IMX8MN_CLK_GPU_SHADER];
   416		hws[IMX8MN_CLK_GPU_SHADER_CG] = hws[IMX8MN_CLK_GPU_SHADER];
   417		hws[IMX8MN_CLK_GPU_SHADER_DIV] = hws[IMX8MN_CLK_GPU_SHADER];
   418	
   419		/* CORE SEL */
   420		hws[IMX8MN_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", base + 0x9880, 24, 1, imx8mn_a53_core_sels, ARRAY_SIZE(imx8mn_a53_core_sels));
   421	
   422		/* BUS */
   423		hws[IMX8MN_CLK_MAIN_AXI] = imx8m_clk_hw_composite_bus_critical("main_axi", imx8mn_main_axi_sels, base + 0x8800);
   424		hws[IMX8MN_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mn_enet_axi_sels, base + 0x8880);
   425		hws[IMX8MN_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_bus("nand_usdhc_bus", imx8mn_nand_usdhc_sels, base + 0x8900);
   426		hws[IMX8MN_CLK_DISP_AXI] = imx8m_clk_hw_composite_bus("disp_axi", imx8mn_disp_axi_sels, base + 0x8a00);
   427		hws[IMX8MN_CLK_DISP_APB] = imx8m_clk_hw_composite_bus("disp_apb", imx8mn_disp_apb_sels, base + 0x8a80);
   428		hws[IMX8MN_CLK_USB_BUS] = imx8m_clk_hw_composite_bus("usb_bus", imx8mn_usb_bus_sels, base + 0x8b80);
   429		hws[IMX8MN_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mn_gpu_axi_sels, base + 0x8c00);
   430		hws[IMX8MN_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mn_gpu_ahb_sels, base + 0x8c80);
   431		hws[IMX8MN_CLK_NOC] = imx8m_clk_hw_composite_bus_critical("noc", imx8mn_noc_sels, base + 0x8d00);
   432	
   433		hws[IMX8MN_CLK_AHB] = imx8m_clk_hw_composite_bus_critical("ahb", imx8mn_ahb_sels, base + 0x9000);
   434		hws[IMX8MN_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mn_audio_ahb_sels, base + 0x9100);
   435		hws[IMX8MN_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb", base + 0x9080, 0, 1);
   436		hws[IMX8MN_CLK_IPG_AUDIO_ROOT] = imx_clk_hw_divider2("ipg_audio_root", "audio_ahb", base + 0x9180, 0, 1);
   437		hws[IMX8MN_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mn_dram_core_sels, ARRAY_SIZE(imx8mn_dram_core_sels), CLK_IS_CRITICAL);
   438	
   439		/*
   440		 * DRAM clocks are manipulated from TF-A outside clock framework.
   441		 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
   442		 * as div value should always be read from hardware
   443		 */
   444		hws[IMX8MN_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000);
   445		hws[IMX8MN_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mn_dram_apb_sels, base + 0xa080);
   446	
   447		hws[IMX8MN_CLK_DISP_PIXEL] = imx8m_clk_hw_composite_flags("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500, CLK_SET_RATE_PARENT);
   448		hws[IMX8MN_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mn_sai2_sels, base + 0xa600);
   449		hws[IMX8MN_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mn_sai3_sels, base + 0xa680);
   450		hws[IMX8MN_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mn_sai5_sels, base + 0xa780);
   451		hws[IMX8MN_CLK_SAI6] = imx8m_clk_hw_composite("sai6", imx8mn_sai6_sels, base + 0xa800);
   452		hws[IMX8MN_CLK_SPDIF1] = imx8m_clk_hw_composite("spdif1", imx8mn_spdif1_sels, base + 0xa880);
   453		hws[IMX8MN_CLK_ENET_REF] = imx8m_clk_hw_composite("enet_ref", imx8mn_enet_ref_sels, base + 0xa980);
   454		hws[IMX8MN_CLK_ENET_TIMER] = imx8m_clk_hw_composite("enet_timer", imx8mn_enet_timer_sels, base + 0xaa00);
   455		hws[IMX8MN_CLK_ENET_PHY_REF] = imx8m_clk_hw_composite("enet_phy", imx8mn_enet_phy_sels, base + 0xaa80);
   456		hws[IMX8MN_CLK_NAND] = imx8m_clk_hw_composite("nand", imx8mn_nand_sels, base + 0xab00);
   457		hws[IMX8MN_CLK_QSPI] = imx8m_clk_hw_composite("qspi", imx8mn_qspi_sels, base + 0xab80);
   458		hws[IMX8MN_CLK_USDHC1] = imx8m_clk_hw_composite("usdhc1", imx8mn_usdhc1_sels, base + 0xac00);
   459		hws[IMX8MN_CLK_USDHC2] = imx8m_clk_hw_composite("usdhc2", imx8mn_usdhc2_sels, base + 0xac80);
   460		hws[IMX8MN_CLK_I2C1] = imx8m_clk_hw_composite("i2c1", imx8mn_i2c1_sels, base + 0xad00);
   461		hws[IMX8MN_CLK_I2C2] = imx8m_clk_hw_composite("i2c2", imx8mn_i2c2_sels, base + 0xad80);
   462		hws[IMX8MN_CLK_I2C3] = imx8m_clk_hw_composite("i2c3", imx8mn_i2c3_sels, base + 0xae00);
   463		hws[IMX8MN_CLK_I2C4] = imx8m_clk_hw_composite("i2c4", imx8mn_i2c4_sels, base + 0xae80);
   464		hws[IMX8MN_CLK_UART1] = imx8m_clk_hw_composite("uart1", imx8mn_uart1_sels, base + 0xaf00);
   465		hws[IMX8MN_CLK_UART2] = imx8m_clk_hw_composite("uart2", imx8mn_uart2_sels, base + 0xaf80);
   466		hws[IMX8MN_CLK_UART3] = imx8m_clk_hw_composite("uart3", imx8mn_uart3_sels, base + 0xb000);
   467		hws[IMX8MN_CLK_UART4] = imx8m_clk_hw_composite("uart4", imx8mn_uart4_sels, base + 0xb080);
   468		hws[IMX8MN_CLK_USB_CORE_REF] = imx8m_clk_hw_composite("usb_core_ref", imx8mn_usb_core_sels, base + 0xb100);
   469		hws[IMX8MN_CLK_USB_PHY_REF] = imx8m_clk_hw_composite("usb_phy_ref", imx8mn_usb_phy_sels, base + 0xb180);
   470		hws[IMX8MN_CLK_GIC] = imx8m_clk_hw_composite_critical("gic", imx8mn_gic_sels, base + 0xb200);
   471		hws[IMX8MN_CLK_ECSPI1] = imx8m_clk_hw_composite("ecspi1", imx8mn_ecspi1_sels, base + 0xb280);
   472		hws[IMX8MN_CLK_ECSPI2] = imx8m_clk_hw_composite("ecspi2", imx8mn_ecspi2_sels, base + 0xb300);
   473		hws[IMX8MN_CLK_PWM1] = imx8m_clk_hw_composite("pwm1", imx8mn_pwm1_sels, base + 0xb380);
   474		hws[IMX8MN_CLK_PWM2] = imx8m_clk_hw_composite("pwm2", imx8mn_pwm2_sels, base + 0xb400);
   475		hws[IMX8MN_CLK_PWM3] = imx8m_clk_hw_composite("pwm3", imx8mn_pwm3_sels, base + 0xb480);
   476		hws[IMX8MN_CLK_PWM4] = imx8m_clk_hw_composite("pwm4", imx8mn_pwm4_sels, base + 0xb500);
   477		hws[IMX8MN_CLK_GPT1] = imx8m_clk_hw_composite("gpt1", imx8mn_gpt1_sels, base + 0xb580);
   478		hws[IMX8MN_CLK_GPT2] = imx8m_clk_hw_composite("gpt2", imx8mn_gpt2_sels, base + 0xb600);
   479		hws[IMX8MN_CLK_GPT3] = imx8m_clk_hw_composite("gpt3", imx8mn_gpt3_sels, base + 0xb680);
   480		hws[IMX8MN_CLK_GPT4] = imx8m_clk_hw_composite("gpt4", imx8mn_gpt4_sels, base + 0xb700);
   481		hws[IMX8MN_CLK_GPT5] = imx8m_clk_hw_composite("gpt5", imx8mn_gpt5_sels, base + 0xb780);
   482		hws[IMX8MN_CLK_GPT6] = imx8m_clk_hw_composite("gpt6", imx8mn_gpt6_sels, base + 0xb800);
   483		hws[IMX8MN_CLK_WDOG] = imx8m_clk_hw_composite("wdog", imx8mn_wdog_sels, base + 0xb900);
   484		hws[IMX8MN_CLK_WRCLK] = imx8m_clk_hw_composite("wrclk", imx8mn_wrclk_sels, base + 0xb980);
   485		hws[IMX8MN_CLK_CLKO1] = imx8m_clk_hw_composite("clko1", imx8mn_clko1_sels, base + 0xba00);
   486		hws[IMX8MN_CLK_CLKO2] = imx8m_clk_hw_composite("clko2", imx8mn_clko2_sels, base + 0xba80);
   487		hws[IMX8MN_CLK_DSI_CORE] = imx8m_clk_hw_composite("dsi_core", imx8mn_dsi_core_sels, base + 0xbb00);
   488		hws[IMX8MN_CLK_DSI_PHY_REF] = imx8m_clk_hw_composite("dsi_phy_ref", imx8mn_dsi_phy_sels, base + 0xbb80);
   489		hws[IMX8MN_CLK_DSI_DBI] = imx8m_clk_hw_composite("dsi_dbi", imx8mn_dsi_dbi_sels, base + 0xbc00);
   490		hws[IMX8MN_CLK_USDHC3] = imx8m_clk_hw_composite("usdhc3", imx8mn_usdhc3_sels, base + 0xbc80);
   491		hws[IMX8MN_CLK_CAMERA_PIXEL] = imx8m_clk_hw_composite("camera_pixel", imx8mn_camera_pixel_sels, base + 0xbd00);
   492		hws[IMX8MN_CLK_CSI1_PHY_REF] = imx8m_clk_hw_composite("csi1_phy_ref", imx8mn_csi1_phy_sels, base + 0xbd80);
   493		hws[IMX8MN_CLK_CSI2_PHY_REF] = imx8m_clk_hw_composite("csi2_phy_ref", imx8mn_csi2_phy_sels, base + 0xbf00);
   494		hws[IMX8MN_CLK_CSI2_ESC] = imx8m_clk_hw_composite("csi2_esc", imx8mn_csi2_esc_sels, base + 0xbf80);
   495		hws[IMX8MN_CLK_ECSPI3] = imx8m_clk_hw_composite("ecspi3", imx8mn_ecspi3_sels, base + 0xc180);
   496		hws[IMX8MN_CLK_PDM] = imx8m_clk_hw_composite("pdm", imx8mn_pdm_sels, base + 0xc200);
   497		hws[IMX8MN_CLK_SAI7] = imx8m_clk_hw_composite("sai7", imx8mn_sai7_sels, base + 0xc300);
   498	
   499		hws[IMX8MN_CLK_ECSPI1_ROOT] = imx_clk_hw_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0);
   500		hws[IMX8MN_CLK_ECSPI2_ROOT] = imx_clk_hw_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0);
   501		hws[IMX8MN_CLK_ECSPI3_ROOT] = imx_clk_hw_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0);
   502		hws[IMX8MN_CLK_ENET1_ROOT] = imx_clk_hw_gate4("enet1_root_clk", "enet_axi", base + 0x40a0, 0);
   503		hws[IMX8MN_CLK_GPIO1_ROOT] = imx_clk_hw_gate4("gpio1_root_clk", "ipg_root", base + 0x40b0, 0);
   504		hws[IMX8MN_CLK_GPIO2_ROOT] = imx_clk_hw_gate4("gpio2_root_clk", "ipg_root", base + 0x40c0, 0);
   505		hws[IMX8MN_CLK_GPIO3_ROOT] = imx_clk_hw_gate4("gpio3_root_clk", "ipg_root", base + 0x40d0, 0);
   506		hws[IMX8MN_CLK_GPIO4_ROOT] = imx_clk_hw_gate4("gpio4_root_clk", "ipg_root", base + 0x40e0, 0);
   507		hws[IMX8MN_CLK_GPIO5_ROOT] = imx_clk_hw_gate4("gpio5_root_clk", "ipg_root", base + 0x40f0, 0);
   508		hws[IMX8MN_CLK_GPT1_ROOT] = imx_clk_hw_gate4("gpt1_root_clk", "gpt1", base + 0x4100, 0);
   509		hws[IMX8MN_CLK_GPT2_ROOT] = imx_clk_hw_gate4("gpt2_root_clk", "gpt2", base + 0x4110, 0);
   510		hws[IMX8MN_CLK_GPT3_ROOT] = imx_clk_hw_gate4("gpt3_root_clk", "gpt3", base + 0x4120, 0);
   511		hws[IMX8MN_CLK_GPT4_ROOT] = imx_clk_hw_gate4("gpt4_root_clk", "gpt4", base + 0x4130, 0);
   512		hws[IMX8MN_CLK_GPT5_ROOT] = imx_clk_hw_gate4("gpt5_root_clk", "gpt5", base + 0x4140, 0);
   513		hws[IMX8MN_CLK_GPT6_ROOT] = imx_clk_hw_gate4("gpt6_root_clk", "gpt6", base + 0x4150, 0);
   514		hws[IMX8MN_CLK_I2C1_ROOT] = imx_clk_hw_gate4("i2c1_root_clk", "i2c1", base + 0x4170, 0);
   515		hws[IMX8MN_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", base + 0x4180, 0);
   516		hws[IMX8MN_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", base + 0x4190, 0);
   517		hws[IMX8MN_CLK_I2C4_ROOT] = imx_clk_hw_gate4("i2c4_root_clk", "i2c4", base + 0x41a0, 0);
   518		hws[IMX8MN_CLK_MU_ROOT] = imx_clk_hw_gate4("mu_root_clk", "ipg_root", base + 0x4210, 0);
   519		hws[IMX8MN_CLK_OCOTP_ROOT] = imx_clk_hw_gate4("ocotp_root_clk", "ipg_root", base + 0x4220, 0);
   520		hws[IMX8MN_CLK_PWM1_ROOT] = imx_clk_hw_gate4("pwm1_root_clk", "pwm1", base + 0x4280, 0);
   521		hws[IMX8MN_CLK_PWM2_ROOT] = imx_clk_hw_gate4("pwm2_root_clk", "pwm2", base + 0x4290, 0);
   522		hws[IMX8MN_CLK_PWM3_ROOT] = imx_clk_hw_gate4("pwm3_root_clk", "pwm3", base + 0x42a0, 0);
   523		hws[IMX8MN_CLK_PWM4_ROOT] = imx_clk_hw_gate4("pwm4_root_clk", "pwm4", base + 0x42b0, 0);
   524		hws[IMX8MN_CLK_QSPI_ROOT] = imx_clk_hw_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0);
   525		hws[IMX8MN_CLK_NAND_ROOT] = imx_clk_hw_gate2_shared2("nand_root_clk", "nand", base + 0x4300, 0, &share_count_nand);
   526		hws[IMX8MN_CLK_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_hw_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_count_nand);
   527		hws[IMX8MN_CLK_SAI2_ROOT] = imx_clk_hw_gate2_shared2("sai2_root_clk", "sai2", base + 0x4340, 0, &share_count_sai2);
   528		hws[IMX8MN_CLK_SAI2_IPG] = imx_clk_hw_gate2_shared2("sai2_ipg_clk", "ipg_audio_root", base + 0x4340, 0, &share_count_sai2);
   529		hws[IMX8MN_CLK_SAI3_ROOT] = imx_clk_hw_gate2_shared2("sai3_root_clk", "sai3", base + 0x4350, 0, &share_count_sai3);
   530		hws[IMX8MN_CLK_SAI3_IPG] = imx_clk_hw_gate2_shared2("sai3_ipg_clk", "ipg_audio_root", base + 0x4350, 0, &share_count_sai3);
   531		hws[IMX8MN_CLK_SAI5_ROOT] = imx_clk_hw_gate2_shared2("sai5_root_clk", "sai5", base + 0x4370, 0, &share_count_sai5);
   532		hws[IMX8MN_CLK_SAI5_IPG] = imx_clk_hw_gate2_shared2("sai5_ipg_clk", "ipg_audio_root", base + 0x4370, 0, &share_count_sai5);
   533		hws[IMX8MN_CLK_SAI6_ROOT] = imx_clk_hw_gate2_shared2("sai6_root_clk", "sai6", base + 0x4380, 0, &share_count_sai6);
   534		hws[IMX8MN_CLK_SAI6_IPG] = imx_clk_hw_gate2_shared2("sai6_ipg_clk", "ipg_audio_root", base + 0x4380, 0, &share_count_sai6);
   535		hws[IMX8MN_CLK_UART1_ROOT] = imx_clk_hw_gate4("uart1_root_clk", "uart1", base + 0x4490, 0);
   536		hws[IMX8MN_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", base + 0x44a0, 0);
   537		hws[IMX8MN_CLK_UART3_ROOT] = imx_clk_hw_gate4("uart3_root_clk", "uart3", base + 0x44b0, 0);
   538		hws[IMX8MN_CLK_UART4_ROOT] = imx_clk_hw_gate4("uart4_root_clk", "uart4", base + 0x44c0, 0);
   539		hws[IMX8MN_CLK_USB1_CTRL_ROOT] = imx_clk_hw_gate4("usb1_ctrl_root_clk", "usb_bus", base + 0x44d0, 0);
   540		hws[IMX8MN_CLK_GPU_CORE_ROOT] = imx_clk_hw_gate4("gpu_core_root_clk", "gpu_core", base + 0x44f0, 0);
   541		hws[IMX8MN_CLK_USDHC1_ROOT] = imx_clk_hw_gate4("usdhc1_root_clk", "usdhc1", base + 0x4510, 0);
   542		hws[IMX8MN_CLK_USDHC2_ROOT] = imx_clk_hw_gate4("usdhc2_root_clk", "usdhc2", base + 0x4520, 0);
   543		hws[IMX8MN_CLK_WDOG1_ROOT] = imx_clk_hw_gate4("wdog1_root_clk", "wdog", base + 0x4530, 0);
   544		hws[IMX8MN_CLK_WDOG2_ROOT] = imx_clk_hw_gate4("wdog2_root_clk", "wdog", base + 0x4540, 0);
   545		hws[IMX8MN_CLK_WDOG3_ROOT] = imx_clk_hw_gate4("wdog3_root_clk", "wdog", base + 0x4550, 0);
   546		hws[IMX8MN_CLK_GPU_BUS_ROOT] = imx_clk_hw_gate4("gpu_root_clk", "gpu_axi", base + 0x4570, 0);
   547		hws[IMX8MN_CLK_ASRC_ROOT] = imx_clk_hw_gate4("asrc_root_clk", "audio_ahb", base + 0x4580, 0);
   548		hws[IMX8MN_CLK_PDM_ROOT] = imx_clk_hw_gate2_shared2("pdm_root_clk", "pdm", base + 0x45b0, 0, &share_count_pdm);
   549		hws[IMX8MN_CLK_PDM_IPG]  = imx_clk_hw_gate2_shared2("pdm_ipg_clk", "ipg_audio_root", base + 0x45b0, 0, &share_count_pdm);
   550		hws[IMX8MN_CLK_DISP_AXI_ROOT]  = imx_clk_hw_gate2_shared2("disp_axi_root_clk", "disp_axi", base + 0x45d0, 0, &share_count_disp);
   551		hws[IMX8MN_CLK_DISP_APB_ROOT]  = imx_clk_hw_gate2_shared2("disp_apb_root_clk", "disp_apb", base + 0x45d0, 0, &share_count_disp);
   552		hws[IMX8MN_CLK_CAMERA_PIXEL_ROOT] = imx_clk_hw_gate2_shared2("camera_pixel_clk", "camera_pixel", base + 0x45d0, 0, &share_count_disp);
   553		hws[IMX8MN_CLK_DISP_PIXEL_ROOT] = imx_clk_hw_gate2_shared2("disp_pixel_clk", "disp_pixel", base + 0x45d0, 0, &share_count_disp);
   554		hws[IMX8MN_CLK_USDHC3_ROOT] = imx_clk_hw_gate4("usdhc3_root_clk", "usdhc3", base + 0x45e0, 0);
   555		hws[IMX8MN_CLK_TMU_ROOT] = imx_clk_hw_gate4("tmu_root_clk", "ipg_root", base + 0x4620, 0);
   556		hws[IMX8MN_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_clk", "ipg_root", base + 0x43a0, 0);
   557		hws[IMX8MN_CLK_SDMA2_ROOT] = imx_clk_hw_gate4("sdma2_clk", "ipg_audio_root", base + 0x43b0, 0);
   558		hws[IMX8MN_CLK_SDMA3_ROOT] = imx_clk_hw_gate4("sdma3_clk", "ipg_audio_root", base + 0x45f0, 0);
   559		hws[IMX8MN_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root_clk", "sai7", base + 0x4650, 0, &share_count_sai7);
   560		hws[IMX8MN_CLK_SAI7_IPG] = imx_clk_hw_gate2_shared2("sai7_ipg_clk", "ipg_audio_root", base + 0x4650, 0, &share_count_sai7);
   561	
   562		hws[IMX8MN_CLK_GPT_3M] = imx_clk_hw_fixed_factor("gpt_3m", "osc_24m", 1, 8);
   563	
   564		hws[IMX8MN_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
   565	
   566		hws[IMX8MN_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
   567						   hws[IMX8MN_CLK_A53_CORE]->clk,
   568						   hws[IMX8MN_CLK_A53_CORE]->clk,
   569						   hws[IMX8MN_ARM_PLL_OUT]->clk,
   570						   hws[IMX8MN_CLK_A53_DIV]->clk);
   571	
   572		imx_check_clk_hws(hws, IMX8MN_CLK_END);
   573	
   574		ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
   575		if (ret < 0) {
   576			imx_unregister_hw_clocks(hws, IMX8MN_CLK_END);
   577			return dev_err_probe(dev, ret,
   578					     "failed to register hws for i.MX8MN\n");
   579		}
   580	
   581		imx_register_uart_clocks();
   582	
   583		dev_info(dev, "NXP i.MX8MN ccm clock driver probed\n");
   584		return 0;
   585	}
   586	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


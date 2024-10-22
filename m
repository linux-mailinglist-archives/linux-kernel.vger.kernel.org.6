Return-Path: <linux-kernel+bounces-376780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D949AB5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B8D2836EC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0550A1C9DCD;
	Tue, 22 Oct 2024 18:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDBDrwYe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BCB1BD51B;
	Tue, 22 Oct 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620599; cv=none; b=kzVFiSqIqCZIkMGeh1ipSarWPdNJ4dt/To+GmKFYlb+D8FaJGXL6Ioij+5OnZNp3MGMZJQVwYcHd7cV/pmpdmZb9WVfC0r57lquhc2uti3v+VH+SEIhx1QcSe5ARdTZ2RqNY6GTPuIY3fIpTky8nhWQD//l1mBDmMSYzC1yBiiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620599; c=relaxed/simple;
	bh=OYH9WPNs01cYeqbOUy3BVBhL9OiM6lYYx0bzKdkMt4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuLybqoq7ToDEJfFA90J9qkQpr0ODaLCdt3C67Ul+qcyXyTlklVZrqWK5MWVoolyW7yEzowHjIpxK6rbtiHsQ3OOW4uo6QBVOGQCbAcmgyLs6MpichEVIlvFGp36YiyRC/GXTBzPNAC/dIqliLbB33dHSpbMzcBsqBz9ElWYQGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDBDrwYe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729620598; x=1761156598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OYH9WPNs01cYeqbOUy3BVBhL9OiM6lYYx0bzKdkMt4Y=;
  b=JDBDrwYe6rsK8FOK/8LUdpF0iw0aS0BoTCDq6b681cWon4LGeWpsruqo
   NnRwtq1a6dTMTj0HZSzuHBLNp9bWRE6+d5kAkY5jC3xnsx8fz67sEDZCf
   4z90N1hF4edYvmXFDG7W73/grMJ/3Es9kNLL0EmeqhnwlsGRVrEZXoOZk
   yznUwFbxmM451e5xz++lVzFe838a6mAlGDDIxCq9aUA7k2v3LGKkIojfF
   AePx5160zfx2ZzuRI5CTKdcyl47Wv7MLQdc7kxy+liCLdZ1thLFOgIyS9
   pXsXsZ1CZwj94J9YnRwpX9h+PSUMLl1ICfnMvEK7mXG6gikXAzwJRhVT3
   g==;
X-CSE-ConnectionGUID: dW2vxwTXQ9CNnJfSa5yGcQ==
X-CSE-MsgGUID: 0qngaPPCTkyMxfmB7M/u/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32869494"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="32869494"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 11:09:57 -0700
X-CSE-ConnectionGUID: ED0qKapQQDK2hjuRPfgUpg==
X-CSE-MsgGUID: fzS0ty/STD6leYXJa+oPDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80363723"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 Oct 2024 11:09:54 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t3JKJ-000TvB-1G;
	Tue, 22 Oct 2024 18:09:51 +0000
Date: Wed, 23 Oct 2024 02:09:17 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Aisheng Dong <aisheng.dong@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/4] clk: imx: lpcg-scu: SW workaround for errata
 (e10858)
Message-ID: <202410230141.3xLvkclt-lkp@intel.com>
References: <20241018-imx-clk-v1-v2-1-92c0b66ca970@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-imx-clk-v1-v2-1-92c0b66ca970@nxp.com>

Hi Peng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d61a00525464bfc5fe92c6ad713350988e492b88]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/clk-imx-lpcg-scu-SW-workaround-for-errata-e10858/20241018-175440
base:   d61a00525464bfc5fe92c6ad713350988e492b88
patch link:    https://lore.kernel.org/r/20241018-imx-clk-v1-v2-1-92c0b66ca970%40nxp.com
patch subject: [PATCH v2 1/4] clk: imx: lpcg-scu: SW workaround for errata (e10858)
config: arm64-randconfig-r061-20241022 (https://download.01.org/0day-ci/archive/20241023/202410230141.3xLvkclt-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241023/202410230141.3xLvkclt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410230141.3xLvkclt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/imx/clk-lpcg-scu.c: In function 'lpcg_e10858_writel':
>> drivers/clk/imx/clk-lpcg-scu.c:49:13: warning: variable 'reg1' set but not used [-Wunused-but-set-variable]
      49 |         u32 reg1;
         |             ^~~~


vim +/reg1 +49 drivers/clk/imx/clk-lpcg-scu.c

    45	
    46	/* e10858 -LPCG clock gating register synchronization errata */
    47	static void lpcg_e10858_writel(unsigned long rate, void __iomem *reg, u32 val)
    48	{
  > 49		u32 reg1;
    50	
    51		writel(val, reg);
    52	
    53		if (rate >= 24 * HZ_PER_MHZ || rate == 0) {
    54			/*
    55			 * The time taken to access the LPCG registers from the AP core
    56			 * through the interconnect is longer than the minimum delay
    57			 * of 4 clock cycles required by the errata.
    58			 * Adding a readl will provide sufficient delay to prevent
    59			 * back-to-back writes.
    60			 */
    61			reg1 = readl(reg);
    62		} else {
    63			/*
    64			 * For clocks running below 24MHz, wait a minimum of
    65			 * 4 clock cycles.
    66			 */
    67			ndelay(4 * (DIV_ROUND_UP(1000 * HZ_PER_MHZ, rate)));
    68		}
    69	}
    70	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


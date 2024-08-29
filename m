Return-Path: <linux-kernel+bounces-305945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 370179636C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 02:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B513F1F23A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4987DA95E;
	Thu, 29 Aug 2024 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2ZRuufV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82B33C9;
	Thu, 29 Aug 2024 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890721; cv=none; b=L/16IwEwZXLiIHzvax1zgFhJkmY0u0deuFfLKQ/YDvyELx977gJvlfR/HerPaxfn+MecjX37ofhTHeYrOBONTvN0XVd8bQCjnrolyMKNdsrtitPuISNrXDMnlWExqp/H5UVxKpoHniZBWY4Oiau/XJrGTuu0csbY6C0GWerqR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890721; c=relaxed/simple;
	bh=JS57zOOV3O/UH7xonHh/DDsPR5hEbfRvwHiP+7Zq0s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jv1Ub+txY1t21qSFTSDG99Xa2ezGRyagdMZ601cZA/3rymDFRpir6PPbBXUEaJj/v5BHki9rP5whqm7vDLoJpX+9bUJEYrP3p4YNs47HmW1azYLuwNGozIoaRpXYTBw5Pqodt0sh57UKRbfXWUcH13de5qPuOq4HecEGNgQUhtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2ZRuufV; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724890719; x=1756426719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JS57zOOV3O/UH7xonHh/DDsPR5hEbfRvwHiP+7Zq0s8=;
  b=A2ZRuufVqiM9+r11HyBFaE/YLcgNSDAi3Royv7NcB8oG5WZgoCjNP1PP
   hG5mSDcAobZmeMBInpl7kr7NJpLNh1bV7o7MUwPwIg6rnE+NZVnrL90m2
   68bX85AN9XBGiFkBNxfUmZHbLpCcznTnIgOTYRvE5pCwC+eCrNfkEY2fJ
   8P0leKSl18Rh168enT8zzBVO7u6Ee8s0MbKfYS3n0/c/RwXGG+qgYkAk5
   BJfii5t+dGSccjXLFFXPNPy3f21m3MLc53oUfXqY1+DujxmRxyrfFiNH0
   MJ5rdCIOMNMDtQQdaUvnw0Rrzf8g73ZNmX9WmySbWoGw0WXKAknSntN2Z
   g==;
X-CSE-ConnectionGUID: MWvm2O2gRFqJbKaVT9GDqQ==
X-CSE-MsgGUID: W8sHxdBCS3W9m/0i1fj6GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="22973551"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="22973551"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 17:18:38 -0700
X-CSE-ConnectionGUID: LypQ0+ovQWepwXB35kZ4gQ==
X-CSE-MsgGUID: /z3S3VrLRWaWDkgrA1eMPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68227056"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 28 Aug 2024 17:18:35 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sjSrw-000LUA-15;
	Thu, 29 Aug 2024 00:18:32 +0000
Date: Thu, 29 Aug 2024 08:18:29 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
Message-ID: <202408290836.KrEafUdK-lkp@intel.com>
References: <20240828062740.1614744-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828062740.1614744-4-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.11-rc5 next-20240828]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-bindings-reset-Add-AST2700-reset-bindings/20240828-143005
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20240828062740.1614744-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
config: microblaze-randconfig-r111-20240829 (https://download.01.org/0day-ci/archive/20240829/202408290836.KrEafUdK-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240829/202408290836.KrEafUdK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408290836.KrEafUdK-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/clk/clk-ast2700.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:235:46: sparse: sparse: self-comparison always evaluates to false
>> drivers/clk/clk-ast2700.c:100:10: sparse: sparse: Initializer entry defined twice
   drivers/clk/clk-ast2700.c:107:10: sparse:   also defined here

vim +100 drivers/clk/clk-ast2700.c

    66	
    67	static const struct ast2700_reset_signal ast2700_reset0_signals[] = {
    68		[SCU0_RESET_SDRAM] = { 1, SCU0_RESET_CTRL1, BIT(0) },
    69		[SCU0_RESET_DDRPHY] = { 1, SCU0_RESET_CTRL1, BIT(1) },
    70		[SCU0_RESET_RSA]     = { 1, SCU0_RESET_CTRL1, BIT(2) },
    71		[SCU0_RESET_SHA3]	= { 1, SCU0_RESET_CTRL1, BIT(3) },
    72		[SCU0_RESET_HACE]	= { 1, SCU0_RESET_CTRL1, BIT(4) },
    73		[SCU0_RESET_SOC]	= { 1, SCU0_RESET_CTRL1, BIT(5) },
    74		[SCU0_RESET_VIDEO]	= { 1, SCU0_RESET_CTRL1, BIT(6) },
    75		[SCU0_RESET_2D]	= { 1, SCU0_RESET_CTRL1, BIT(7) },
    76		[SCU0_RESET_PCIS]	= { 1, SCU0_RESET_CTRL1, BIT(8) },
    77		[SCU0_RESET_RVAS0]		= { 1, SCU0_RESET_CTRL1, BIT(9) },
    78		[SCU0_RESET_RVAS1]		= { 1, SCU0_RESET_CTRL1, BIT(10) },
    79		[SCU0_RESET_SM3]		= { 1, SCU0_RESET_CTRL1, BIT(11) },
    80		[SCU0_RESET_SM4]		= { 1, SCU0_RESET_CTRL1, BIT(12) },
    81		[SCU0_RESET_CRT0]	= { 1, SCU0_RESET_CTRL1, BIT(13) },
    82		[SCU0_RESET_ECC]	= { 1, SCU0_RESET_CTRL1, BIT(14) },
    83		[SCU0_RESET_DP_PCI]	= { 1, SCU0_RESET_CTRL1, BIT(15) },
    84		[SCU0_RESET_UFS]	= { 1, SCU0_RESET_CTRL1, BIT(16) },
    85		[SCU0_RESET_EMMC]	= { 1, SCU0_RESET_CTRL1, BIT(17) },
    86		[SCU0_RESET_PCIE1RST]	= { 1, SCU0_RESET_CTRL1, BIT(18) },
    87		[SCU0_RESET_PCIE1RSTOE]	= { 1, SCU0_RESET_CTRL1, BIT(19) },
    88		[SCU0_RESET_PCIE0RST]		= { 1, SCU0_RESET_CTRL1, BIT(20) },
    89		[SCU0_RESET_PCIE0RSTOE]	= { 1, SCU0_RESET_CTRL1, BIT(21) },
    90		[SCU0_RESET_JTAG]	= { 1, SCU0_RESET_CTRL1, BIT(22) },
    91		[SCU0_RESET_MCTP0] = { 1, SCU0_RESET_CTRL1, BIT(23) },
    92		[SCU0_RESET_MCTP1]		= { 1, SCU0_RESET_CTRL1, BIT(24) },
    93		[SCU0_RESET_XDMA0]	= { 1, SCU0_RESET_CTRL1, BIT(25) },
    94		[SCU0_RESET_XDMA1]	= { 1, SCU0_RESET_CTRL1, BIT(26) },
    95		[SCU0_RESET_H2X1]	= { 1, SCU0_RESET_CTRL1, BIT(27) },
    96		[SCU0_RESET_DP]	= { 1, SCU0_RESET_CTRL1, BIT(28) },
    97		[SCU0_RESET_DP_MCU]	= { 1, SCU0_RESET_CTRL1, BIT(29) },
    98		[SCU0_RESET_SSP]	= { 1, SCU0_RESET_CTRL1, BIT(30) },
    99		[SCU0_RESET_H2X0]	= { 1, SCU0_RESET_CTRL1, BIT(31) },
 > 100		[SCU0_RESET_PORTA_USB]	= { 1, SCU0_RESET_CTRL2, BIT(0) },
   101		[SCU0_RESET_PORTA_PHY3]	= { 1, SCU0_RESET_CTRL2, BIT(1) },
   102		[SCU0_RESET_PORTA_XHCI]	= { 1, SCU0_RESET_CTRL2, BIT(2) },
   103		[SCU0_RESET_PORTB_VHUB1]	= { 1, SCU0_RESET_CTRL2, BIT(3) },
   104		[SCU0_RESET_PORTB_PHY3]	= { 1, SCU0_RESET_CTRL2, BIT(4) },
   105		[SCU0_RESET_PORTB_XHCI]	= { 1, SCU0_RESET_CTRL2, BIT(5) },
   106		/*PORTA EHCI/VHUB share reset */
   107		[SCU0_RESET_PORTA_USB]	= { 1, SCU0_RESET_CTRL2, BIT(6) },
   108		/*PORTB EHCI/VHUB share reset */
   109		[SCU0_RESET_PORTB_USB]	= { 1, SCU0_RESET_CTRL2, BIT(7) },
   110		[SCU0_RESET_UHCI]	= { 1, SCU0_RESET_CTRL2, BIT(8) },
   111		[SCU0_RESET_TSP]	= { 1, SCU0_RESET_CTRL2, BIT(9) },
   112		[SCU0_RESET_E2M0]	= { 1, SCU0_RESET_CTRL2, BIT(10) },
   113		[SCU0_RESET_E2M1]	= { 1, SCU0_RESET_CTRL2, BIT(11) },
   114		[SCU0_RESET_VLINK]	= { 1, SCU0_RESET_CTRL2, BIT(12) },
   115	};
   116	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


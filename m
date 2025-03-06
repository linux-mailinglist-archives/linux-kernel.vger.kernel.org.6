Return-Path: <linux-kernel+bounces-549573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC53A55418
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D23583B7A94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FEB269CE8;
	Thu,  6 Mar 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MKnwTg9X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F58E274264;
	Thu,  6 Mar 2025 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284133; cv=none; b=aguiGCMQ7fGuTSRsPZU59WME6BmeqrPQXk0lp9vaJ58mihln1GKgumM2OV7c6BI3ILmmClufzwJG8mGOZgl85hXYtvhV9gw7XBC/lHYdF3nvFbgFT2orOvnK9jtpRPJEE9ERtei68ojoFnN/q3dLB7NP87hC+Q1S638OCATy884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284133; c=relaxed/simple;
	bh=aS4+MiTQzEhxzLiPX4aqCukgIbUCu3ZfrqEOUCUr7XI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT6unvJLiOYcb48923vdT1kTUxC7ljtIY77krjfXcfUX7GSn/Jsot+bkiu4+z55Neegr6rJ8Kc0iyTkPtLNo8J+ssqfzdhP3SGheM4+V3d7HbcZDo9bHHUfPtiX6bC0TUhKqMoxZeyNzELHzsoR0o5VwpJdf2zrDdq8bjd0sJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MKnwTg9X; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741284132; x=1772820132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aS4+MiTQzEhxzLiPX4aqCukgIbUCu3ZfrqEOUCUr7XI=;
  b=MKnwTg9XfCk6OiNaEjttE9+DTjc85JWsvokG+p046iUSrJhUSD5a6Z83
   XFiedEPYQjJ3OStqDUpgpu/KJrSbwV9W1xGXuiiZJBlr7PqQkGPRGaxrN
   Jb9xDmw2xEdn88dQc2mRaQYvWoa3+V68oim6+kCAyyu2sziTd1dtkusXk
   ilnYRNrk5PpiIvHAGgSXJsS8+DnzPPZo1sKpyFDoIBJyQUbppfcNVeC9l
   hz45HsOzWy1gUJiDakGqtBSP5dz9nDEJ7ewzJ1I9choVsPoIlEuMt3oq/
   bHMh0afnIrmVN6BDcaAnoZX+MNtLII1E+pnr0GU+M3bKJ4HsrZkrKwU9h
   w==;
X-CSE-ConnectionGUID: wT9EdGW1TxK7BDKySn/TOg==
X-CSE-MsgGUID: UNvUsp7QRb+Lpq14g28BLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42447282"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42447282"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 10:01:54 -0800
X-CSE-ConnectionGUID: gNpnIM6CT4yTMEC2oo0i5w==
X-CSE-MsgGUID: 7bbIzenPRDe7V8jlIyKzsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="119280835"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 06 Mar 2025 10:01:51 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqFXY-000NQI-0V;
	Thu, 06 Mar 2025 18:01:48 +0000
Date: Fri, 7 Mar 2025 02:01:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v9 3/3] clk: aspeed: add AST2700 clock driver
Message-ID: <202503070117.mMjnpop8-lkp@intel.com>
References: <20250224095506.2047064-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224095506.2047064-4-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc5 next-20250306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-binding-clock-ast2700-modify-soc0-1-clock-define/20250224-175830
base:   linus/master
patch link:    https://lore.kernel.org/r/20250224095506.2047064-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v9 3/3] clk: aspeed: add AST2700 clock driver
config: powerpc64-randconfig-r121-20250306 (https://download.01.org/0day-ci/archive/20250307/202503070117.mMjnpop8-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250307/202503070117.mMjnpop8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503070117.mMjnpop8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/clk/clk-ast2700.c:1066:92: sparse: sparse: Using plain integer as NULL pointer

vim +1066 drivers/clk/clk-ast2700.c

   952	
   953	static int ast2700_soc_clk_probe(struct platform_device *pdev)
   954	{
   955		const struct ast2700_clk_data *clk_data;
   956		struct ast2700_clk_ctrl *clk_ctrl;
   957		struct clk_hw_onecell_data *clk_hw_data;
   958		struct device *dev = &pdev->dev;
   959		void __iomem *clk_base;
   960		struct clk_hw **hws;
   961		char *reset_name;
   962		int ret;
   963		int i;
   964	
   965		clk_ctrl = devm_kzalloc(dev, sizeof(*clk_ctrl), GFP_KERNEL);
   966		if (!clk_ctrl)
   967			return -ENOMEM;
   968		clk_ctrl->dev = dev;
   969		dev_set_drvdata(&pdev->dev, clk_ctrl);
   970	
   971		spin_lock_init(&clk_ctrl->lock);
   972	
   973		clk_base = devm_platform_ioremap_resource(pdev, 0);
   974		if (IS_ERR(clk_base))
   975			return PTR_ERR(clk_base);
   976	
   977		clk_ctrl->base = clk_base;
   978	
   979		clk_data = device_get_match_data(dev);
   980		if (!clk_data)
   981			return -ENODEV;
   982	
   983		clk_ctrl->clk_data = clk_data;
   984		reset_name = devm_kasprintf(dev, GFP_KERNEL, "reset%d", clk_data->scu);
   985	
   986		clk_hw_data = devm_kzalloc(dev, struct_size(clk_hw_data, hws, clk_data->nr_clks),
   987					   GFP_KERNEL);
   988		if (!clk_hw_data)
   989			return -ENOMEM;
   990	
   991		clk_hw_data->num = clk_data->nr_clks;
   992		hws = clk_hw_data->hws;
   993	
   994		if (clk_data->scu)
   995			ast2700_soc1_configure_i3c_clk(clk_ctrl);
   996	
   997		for (i = 0; i < clk_data->nr_clks; i++) {
   998			const struct ast2700_clk_info *clk = &clk_data->clk_info[i];
   999			void __iomem *reg;
  1000	
  1001			if (clk->type == CLK_FIXED) {
  1002				const struct ast2700_clk_fixed_rate_data *fixed_rate = &clk->data.rate;
  1003	
  1004				hws[i] = devm_clk_hw_register_fixed_rate(dev, clk->name, NULL, 0,
  1005									 fixed_rate->fixed_rate);
  1006			} else if (clk->type == CLK_FIXED_FACTOR) {
  1007				const struct ast2700_clk_fixed_factor_data *factor = &clk->data.factor;
  1008	
  1009				hws[i] = devm_clk_hw_register_fixed_factor(dev, clk->name,
  1010									   factor->parent->name,
  1011									   0, factor->mult, factor->div);
  1012			} else if (clk->type == DCLK_FIXED) {
  1013				const struct ast2700_clk_pll_data *pll = &clk->data.pll;
  1014	
  1015				reg = clk_ctrl->base + pll->reg;
  1016				hws[i] = ast2700_clk_hw_register_dclk(reg, clk->name, clk_ctrl);
  1017			} else if (clk->type == CLK_HPLL) {
  1018				const struct ast2700_clk_pll_data *pll = &clk->data.pll;
  1019	
  1020				reg = clk_ctrl->base + pll->reg;
  1021				hws[i] = ast2700_clk_hw_register_hpll(reg, clk->name,
  1022								      pll->parent->name, clk_ctrl);
  1023			} else if (clk->type == CLK_PLL) {
  1024				const struct ast2700_clk_pll_data *pll = &clk->data.pll;
  1025	
  1026				reg = clk_ctrl->base + pll->reg;
  1027				hws[i] = ast2700_clk_hw_register_pll(i, reg, clk->name,
  1028								     pll->parent->name, clk_ctrl);
  1029			} else if (clk->type == CLK_UART_PLL) {
  1030				const struct ast2700_clk_pll_data *pll = &clk->data.pll;
  1031	
  1032				reg = clk_ctrl->base + pll->reg;
  1033				hws[i] = ast2700_clk_hw_register_uartpll(reg, clk->name,
  1034									 pll->parent->name, clk_ctrl);
  1035			} else if (clk->type == CLK_MUX) {
  1036				const struct ast2700_clk_mux_data *mux = &clk->data.mux;
  1037	
  1038				reg = clk_ctrl->base + mux->reg;
  1039				hws[i] = devm_clk_hw_register_mux_parent_data_table(dev, clk->name,
  1040										    mux->parents,
  1041										    mux->num_parents, 0,
  1042										    reg, mux->bit_shift,
  1043										    mux->bit_width, 0,
  1044										    NULL, &clk_ctrl->lock);
  1045			} else if (clk->type == CLK_MISC) {
  1046				const struct ast2700_clk_pll_data *misc = &clk->data.pll;
  1047	
  1048				reg = clk_ctrl->base + misc->reg;
  1049				hws[i] = ast2700_clk_hw_register_misc(i, reg, clk->name,
  1050								      misc->parent->name, clk_ctrl);
  1051			} else if (clk->type == CLK_DIVIDER) {
  1052				const struct ast2700_clk_div_data *div = &clk->data.div;
  1053	
  1054				reg = clk_ctrl->base + div->reg;
  1055				hws[i] = devm_clk_hw_register_divider_table(dev, clk->name,
  1056									    div->parent->name, 0,
  1057									    reg, div->bit_shift,
  1058									    div->bit_width, 0,
  1059									    div->div_table,
  1060									    &clk_ctrl->lock);
  1061			} else if (clk->type == CLK_GATE_ASPEED) {
  1062				const struct ast2700_clk_gate_data *gate = &clk->data.gate;
  1063	
  1064				reg = clk_ctrl->base + gate->reg;
  1065				hws[i] = ast2700_clk_hw_register_gate(dev, clk->name, gate->parent,
> 1066								      reg, gate->bit, gate->flags, 0);
  1067	
  1068			} else {
  1069				const struct ast2700_clk_gate_data *gate = &clk->data.gate;
  1070	
  1071				reg = clk_ctrl->base + gate->reg;
  1072				hws[i] = devm_clk_hw_register_gate_parent_data(dev, clk->name, gate->parent,
  1073									       0, reg, clk->clk_idx, 0,
  1074									       &clk_ctrl->lock);
  1075			}
  1076	
  1077			if (IS_ERR(hws[i]))
  1078				return PTR_ERR(hws[i]);
  1079		}
  1080	
  1081		ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_hw_data);
  1082		if (ret)
  1083			return ret;
  1084	
  1085		return aspeed_reset_controller_register(dev, clk_base, reset_name);
  1086	}
  1087	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


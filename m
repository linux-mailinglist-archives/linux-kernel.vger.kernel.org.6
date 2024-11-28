Return-Path: <linux-kernel+bounces-424315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF4D9DB2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52F2281E20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C8E147C96;
	Thu, 28 Nov 2024 06:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWM4laoq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70151146D45;
	Thu, 28 Nov 2024 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732776672; cv=none; b=cug4r8GDEGnP7FZmRpGRNIcGYb/7W04CLscVmwR8qRH4bNftl8zd0EorZGfOQIABAlDDtp9hnmdqv5ngpxwIoFIfx6Nk7x1WztlmzN2MIdqm2WF8uVq1nx17KGa2mtdYA1xnMNVv2pFqvLsuO+amgzu5D+cKJmZiHm7laOvSTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732776672; c=relaxed/simple;
	bh=r79SPOuhZdVFBIeBPeECtG57hYszo3FLyqaYO+yACxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTTPZAG4PQXoBxMhyja82o8eIp1LEgzPwIHlIoRzr4QoA75zTVwy5zL6i75Ztv1px/OK6Xe6O7qV9Yqh7yAzrL21+LkHhSw9HIktW4e4360wc4CGGa783EyEb10nW8M3kpA7stIGGNCslCcNpYSweKChntadx0ExkSwgzVVCNCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWM4laoq; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732776671; x=1764312671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r79SPOuhZdVFBIeBPeECtG57hYszo3FLyqaYO+yACxk=;
  b=DWM4laoq9PQpAgU1kOZjl+aikDx0wYbLoVyHeCXJlvbUPGw9Q4vGH4ye
   qQ9Fkyu4ttjdD7st9kI3+gWn4kLpcEH+s3NDtcowViUrsaesF1Pgkb/+f
   Gl8lTg9Q8Mhm29snBPpl5uGEh9CnESp4/9sctQC0JGfNRH8CtPXl0QHjl
   rW6OkcbmqfrgSoBsb+SvaVhDlTUuwbE9vU3EiyDNwS+hDQvHFWEVBO/w4
   LovtN7Eh20yfFvCPQVIOWY5AG23lUKZckxPAULIGoPRpgVQnqFJUG380n
   C58tWOWo3Qxw9yilbK2T5H2feSFXWTYu8wU17VKx3wxpO+gHJm92+PDI2
   g==;
X-CSE-ConnectionGUID: pkKc/P/SQymkm5LKhgAS+A==
X-CSE-MsgGUID: mkv2MBWsSbakXcSAmf1R9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11269"; a="20590440"
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="20590440"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2024 22:51:07 -0800
X-CSE-ConnectionGUID: JPKvsDA2RHC8HzUqgFeW6w==
X-CSE-MsgGUID: 4lhVcWE2Tkie8QKkASZ24Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,191,1728975600"; 
   d="scan'208";a="97111216"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 27 Nov 2024 22:51:03 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGYMe-0009Cd-1Q;
	Thu, 28 Nov 2024 06:51:00 +0000
Date: Thu, 28 Nov 2024 14:50:05 +0800
From: kernel test robot <lkp@intel.com>
To: Haylen Chu <heylenay@4d2.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v3 3/3] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <202411281451.lC2FKL6C-lkp@intel.com>
References: <20241126143125.9980-7-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126143125.9980-7-heylenay@4d2.org>

Hi Haylen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2d5404caa8c7bb5c4e0435f94b28834ae5456623]

url:    https://github.com/intel-lab-lkp/linux/commits/Haylen-Chu/dt-bindings-clock-spacemit-Add-clock-controllers-of-Spacemit-K1-SoC/20241128-101248
base:   2d5404caa8c7bb5c4e0435f94b28834ae5456623
patch link:    https://lore.kernel.org/r/20241126143125.9980-7-heylenay%404d2.org
patch subject: [PATCH v3 3/3] clk: spacemit: Add clock support for Spacemit K1 SoC
config: arm-randconfig-001-20241128 (https://download.01.org/0day-ci/archive/20241128/202411281451.lC2FKL6C-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411281451.lC2FKL6C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411281451.lC2FKL6C-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/spacemit/ccu_pll.c:128:16: warning: variable 'old_rate' set but not used [-Wunused-but-set-variable]
     128 |         unsigned long old_rate;
         |                       ^
>> drivers/clk/spacemit/ccu_pll.c:152:2: warning: variable 'val' is uninitialized when used here [-Wuninitialized]
     152 |         val |= entry->reg5 << PLL_SWCR1_REG5_OFF;
         |         ^~~
   drivers/clk/spacemit/ccu_pll.c:130:15: note: initialize the variable 'val' to silence this warning
     130 |         u32 mask, val;
         |                      ^
         |                       = 0
>> drivers/clk/spacemit/ccu_pll.c:141:14: warning: variable 'entry' is used uninitialized whenever 'for' loop exits because its condition is false [-Wsometimes-uninitialized]
     141 |         for (i = 0; i < params->tbl_size; i++) {
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/clk/spacemit/ccu_pll.c:152:9: note: uninitialized use occurs here
     152 |         val |= entry->reg5 << PLL_SWCR1_REG5_OFF;
         |                ^~~~~
   drivers/clk/spacemit/ccu_pll.c:141:14: note: remove the condition if it is always true
     141 |         for (i = 0; i < params->tbl_size; i++) {
         |                     ^~~~~~~~~~~~~~~~~~~~
   drivers/clk/spacemit/ccu_pll.c:127:32: note: initialize the variable 'entry' to silence this warning
     127 |         struct ccu_pll_rate_tbl *entry;
         |                                       ^
         |                                        = NULL
   3 warnings generated.


vim +/val +152 drivers/clk/spacemit/ccu_pll.c

   115	
   116	/*
   117	 * pll rate change requires sequence:
   118	 * clock off -> change rate setting -> clock on
   119	 * This function doesn't really change rate, but cache the config
   120	 */
   121	static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
   122				       unsigned long parent_rate)
   123	{
   124		struct ccu_pll *p = hw_to_ccu_pll(hw);
   125		struct ccu_common *common = &p->common;
   126		struct ccu_pll_config *params = &p->pll;
   127		struct ccu_pll_rate_tbl *entry;
 > 128		unsigned long old_rate;
   129		bool found = false;
   130		u32 mask, val;
   131		int i;
   132	
   133		if (ccu_pll_is_enabled(hw)) {
   134			pr_err("%s %s is enabled, ignore the setrate!\n",
   135			       __func__, __clk_get_name(hw->clk));
   136			return 0;
   137		}
   138	
   139		old_rate = __get_vco_freq(hw);
   140	
 > 141		for (i = 0; i < params->tbl_size; i++) {
   142			if (rate == params->rate_tbl[i].rate) {
   143				found = true;
   144				entry = &params->rate_tbl[i];
   145				break;
   146			}
   147		}
   148		WARN_ON_ONCE(!found);
   149	
   150		mask = PLL_SWCR1_REG5_MASK | PLL_SWCR1_REG6_MASK;
   151		mask |= PLL_SWCR1_REG7_MASK | PLL_SWCR1_REG8_MASK;
 > 152		val |= entry->reg5 << PLL_SWCR1_REG5_OFF;
   153		val |= entry->reg6 << PLL_SWCR1_REG6_OFF;
   154		val |= entry->reg7 << PLL_SWCR1_REG7_OFF;
   155		val |= entry->reg8 << PLL_SWCR1_REG8_OFF;
   156		ccu_update(swcr1, common, mask, val);
   157	
   158		mask = PLL_SWCR3_DIV_INT_MASK | PLL_SWCR3_DIV_FRC_MASK;
   159		val = entry->div_int << PLL_SWCR3_DIV_INT_OFF;
   160		val |= entry->div_frac << PLL_SWCR3_DIV_FRC_OFF;
   161		ccu_update(swcr3, common, mask, val);
   162	
   163		return 0;
   164	}
   165	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


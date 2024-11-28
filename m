Return-Path: <linux-kernel+bounces-424906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461C89DBB09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899D4B20C05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376B51BE87C;
	Thu, 28 Nov 2024 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nsavjth6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B03232;
	Thu, 28 Nov 2024 16:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810134; cv=none; b=P83FlyJT3Fo7to8gBqrWgvkceWPaZrmR6nh3zAEAq/hQwPHBGxc0Eq1VWkPeZIN6JV+OTU4jVgS/Is8FKSc35Q56vOpYZOagNTfoMTAQEoxLKoCbD7oFonCC6x4F7BnK07m4kHJGceSVHKNPBomiAAF7Mnc22dFCxzNoAdefalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810134; c=relaxed/simple;
	bh=zgR7POQipJr92V+u9Tt4pGs3gh2pe3hR7ESpRucymuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cth8vilh/vvOHYVvD2b2rTUKAlBnmD3bHbKZGzgnAR2W5eEMPK42KUY1tb7j0KUP0B30hSStks/W4FjPBxg1pqKX6ggHlVPDbtx9wTgfOAP3TtPzRRPqF0pxF06nxQS5OAAuJGUkFFIWRD2iF7KKSr9phLDb2YTdY/Ke3NpZL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nsavjth6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732810132; x=1764346132;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zgR7POQipJr92V+u9Tt4pGs3gh2pe3hR7ESpRucymuM=;
  b=Nsavjth6yKwhCt9sKsOIMGQIIE9VyFBxCqy8fpstLI+Cr9EyTakqf89I
   mhAvJnijlYwZHvM/Z8Px779mtLQEIWqaMYTNACVqDdoK4RTdIwFAnHXJV
   LCxEMY+M1EQ+qoZ+7lENB1syB+S/namzICSRex/j2gFgfotv15B79w5mS
   rNNTl0pckYu4M4dxpV97PiZAnjDvGciP9BEYzSPzk+jteD7/HIMK2yMp3
   6p5F1vxZABGp3K0KYfA1kPLUwQP9BCc15MNjaFHlAgEgfJtcDDd9khqXN
   KculTBaliv5kLtkqp7bTHjtY0KI8GyUW8WfGFULx5Yhe9BFeUAhGQxcRd
   g==;
X-CSE-ConnectionGUID: rSqTnKEvSD+2SKomZ/2ZcQ==
X-CSE-MsgGUID: 1/Vz7g8nQzCjB+Tm5jFRog==
X-IronPort-AV: E=McAfee;i="6700,10204,11270"; a="32417689"
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="32417689"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2024 08:07:44 -0800
X-CSE-ConnectionGUID: SOiR0bVYTaKLPWXALnNw+Q==
X-CSE-MsgGUID: Z27cMCa4QpyjNYwuD8SyGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="scan'208";a="92659227"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Nov 2024 08:07:40 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tGh3J-0009m6-2g;
	Thu, 28 Nov 2024 16:07:37 +0000
Date: Fri, 29 Nov 2024 00:07:36 +0800
From: kernel test robot <lkp@intel.com>
To: Haylen Chu <heylenay@4d2.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH v3 3/3] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <202411282305.iJ9x0lmj-lkp@intel.com>
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
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20241128/202411282305.iJ9x0lmj-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241128/202411282305.iJ9x0lmj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411282305.iJ9x0lmj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/clk/spacemit/ccu_pll.c: In function 'ccu_pll_set_rate':
>> drivers/clk/spacemit/ccu_pll.c:128:23: warning: variable 'old_rate' set but not used [-Wunused-but-set-variable]
     128 |         unsigned long old_rate;
         |                       ^~~~~~~~
--
   drivers/clk/spacemit/ccu_mix.c: In function 'ccu_mix_set_rate':
>> drivers/clk/spacemit/ccu_mix.c:180:23: warning: variable 'best_rate' set but not used [-Wunused-but-set-variable]
     180 |         unsigned long best_rate = 0;
         |                       ^~~~~~~~~
--
   drivers/clk/spacemit/ccu_ddn.c: In function 'clk_ddn_set_rate':
>> drivers/clk/spacemit/ccu_ddn.c:115:23: warning: variable 'prev_rate' set but not used [-Wunused-but-set-variable]
     115 |         unsigned long prev_rate, rate = 0;
         |                       ^~~~~~~~~


vim +/old_rate +128 drivers/clk/spacemit/ccu_pll.c

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
   141		for (i = 0; i < params->tbl_size; i++) {
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
   152		val |= entry->reg5 << PLL_SWCR1_REG5_OFF;
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


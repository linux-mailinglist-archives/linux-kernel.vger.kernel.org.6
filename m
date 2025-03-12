Return-Path: <linux-kernel+bounces-558388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21062A5E52F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6C73B09F8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF8F1DE3A7;
	Wed, 12 Mar 2025 20:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPp6tt1W"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E111E5B9B;
	Wed, 12 Mar 2025 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810666; cv=none; b=KjRzpRDGptzkbTD+DoUNUPDonrwdCGz24BhUSorJWBqHtFdXnSAWU5+tYN2Pfy2zbliTFHyGiGfG50G82ynQneD9cOGet/ZltOQc0qRI8BlcDd7miFdZRhUG1HUxkLUjbM74eGrrDmzsdUqC6n0NxKN2tKgwvuG78oQYX37KXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810666; c=relaxed/simple;
	bh=v+BY+g55F6T5NMcwLkcGpN4Z2yA59ha5GDHqdirKEVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWnqWRxOL3QLxD3uYYhkmCvPYBvGcYYiB6g/ttMJyAccjDnSBK3AcqWUvM4/3pXKby+63MXONGPanIVGhuqZxF8JGQHkh+VRq5nmeQKVX+yvYuZTDowsGF250+7/keQVYaH8z1vaD/S5COOAobaqfvvr72nEmNOw1lSfF7daJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPp6tt1W; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741810664; x=1773346664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v+BY+g55F6T5NMcwLkcGpN4Z2yA59ha5GDHqdirKEVw=;
  b=cPp6tt1WzSKd2MCxN8MlUTjxEmjZxzSx6uz48v1Kb0UEU0iykDHbERNn
   TYYCqjInHnt2nu+miZrVaG28AVPR7lbhwzW7O9HeDjpEGN1CTlDwZks5z
   kczy4suBh7LNtqIJCgfsW40VwkHfw2fmvLgZjnmCSAgRccG1OjcWEl+pk
   qUX4wBZBmeGnMXtZwZDrJFEkY0IjcXBi2Z5m3T5QA0g3rGlD49EL0dDPy
   fz+w5UMiTs5EjDA7FpSF+zuQnyuNXcDHYa2LFfZ1iWgtx8LtUW8jQCe+7
   AVty6TF3NJxlsqLmzt1+BKdSc8JLFUVJPYA+M2Ypa7GYkeE/USn4n9QYT
   g==;
X-CSE-ConnectionGUID: Po8MfTCDTvuULi84s/lPsg==
X-CSE-MsgGUID: iTwIkpkdSq66z/KksrHpCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="53117508"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="53117508"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 13:17:43 -0700
X-CSE-ConnectionGUID: JTTkifBISISmGQpCwqs/oQ==
X-CSE-MsgGUID: WlY3h+hsT3OFna6ZjLLUfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="120698425"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 12 Mar 2025 13:17:39 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tsSWG-0008rs-2S;
	Wed, 12 Mar 2025 20:17:36 +0000
Date: Thu, 13 Mar 2025 04:17:02 +0800
From: kernel test robot <lkp@intel.com>
To: Haylen Chu <heylenay@4d2.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Haylen Chu <heylenay@outlook.com>, Yixun Lan <dlan@gentoo.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev,
	Inochi Amaoto <inochiama@outlook.com>,
	Chen Wang <unicornxdotw@foxmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 3/5] clk: spacemit: Add clock support for Spacemit K1
 SoC
Message-ID: <202503130314.Y8KFKZWW-lkp@intel.com>
References: <20250306175750.22480-5-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306175750.22480-5-heylenay@4d2.org>

Hi Haylen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on spacemit/for-next]
[also build test WARNING on spacemit/fixes clk/clk-next robh/for-next linus/master v6.14-rc6 next-20250312]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haylen-Chu/dt-bindings-soc-spacemit-Add-spacemit-k1-syscon/20250307-020635
base:   https://github.com/spacemit-com/linux for-next
patch link:    https://lore.kernel.org/r/20250306175750.22480-5-heylenay%404d2.org
patch subject: [PATCH v5 3/5] clk: spacemit: Add clock support for Spacemit K1 SoC
config: powerpc64-randconfig-r131-20250312 (https://download.01.org/0day-ci/archive/20250313/202503130314.Y8KFKZWW-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce: (https://download.01.org/0day-ci/archive/20250313/202503130314.Y8KFKZWW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503130314.Y8KFKZWW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/clk/spacemit/ccu_pll.c:110:9: sparse: sparse: cast truncates bits from constant value (ffffffff7fffffff becomes 7fffffff)

vim +110 drivers/clk/spacemit/ccu_pll.c

    85	
    86	/*
    87	 * PLLs must be gated before changing rate, which is ensured by
    88	 * flag CLK_SET_RATE_GATE.
    89	 */
    90	static int ccu_pll_set_rate(struct clk_hw *hw, unsigned long rate,
    91				    unsigned long parent_rate)
    92	{
    93		struct ccu_pll *p = hw_to_ccu_pll(hw);
    94		struct ccu_common *common = &p->common;
    95		struct ccu_pll_config *params = &p->pll;
    96		const struct ccu_pll_rate_tbl *entry = NULL;
    97		int i;
    98	
    99		for (i = 0; i < params->tbl_size; i++) {
   100			if (rate == params->rate_tbl[i].rate) {
   101				entry = &params->rate_tbl[i];
   102				break;
   103			}
   104		}
   105	
   106		if (WARN_ON_ONCE(!entry))
   107			return -EINVAL;
   108	
   109		ccu_update(swcr1, common, entry->swcr1, entry->swcr1);
 > 110		ccu_update(swcr3, common, (u32)~PLL_SWCR3_EN, entry->swcr3);
   111	
   112		return 0;
   113	}
   114	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


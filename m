Return-Path: <linux-kernel+bounces-509942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8D4A3165C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7F23A48F9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B56260A28;
	Tue, 11 Feb 2025 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAacz2Xz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54D265610;
	Tue, 11 Feb 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739304244; cv=none; b=IkKJhOCvtflOdIlIlImZ0qJTGT3AT2tInwI1N58kzKhF8XF+rvzQIT/JBia8HFFDmtmFip0u/5k5Rn+b8mjwIjYV9OCwtulODQO7K4yuge/lnm8h+1Vtb6zLHM3s+EA2PbM3h92bJA6Ve0AMiLKoBs2VSx4FScmhde1mSBHD7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739304244; c=relaxed/simple;
	bh=+AX2bjNWcBgeVuZYMnS0XA3xsjmS3gSf31qR7edUe2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBl3IVF1JZ2vaVSvQ3MYNBvo0rZ638DglRxheQ0qk7+qnY4hkq0y72CBuln+s3+BEt5WaZ3n1NotI73HVXzyNFvcXY/F0+DDyrkMCVJP7hMabJ3VHQodr309Szd6A58jrCma2RYTJnrULF2pZw/sqYTuoYVCXiTjV32lew743T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAacz2Xz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739304243; x=1770840243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+AX2bjNWcBgeVuZYMnS0XA3xsjmS3gSf31qR7edUe2k=;
  b=PAacz2XzwxUSYFRikJ+L0udtVEXGC5TOfcRMxoRzpDQU3gG/ARKr6BOP
   P2cszckA5ubD9jEGSos4rq61SlbLSsUxp8OAvmAm8eehaBWaqy+hkWXK/
   F6/XilzvM4D3AjUVv1kWg8RMfoozZoy//L/c5d68s3QQUcRRAyvJ75j2T
   rD3kcWiP22iNt0PWBcjdXzyP6IrDVEoHuReCWhplHKfkuHaqcyI23/Azj
   yAAYs8g9J2UHR9eI9Yw7W1JdaoXAXrN9bCIaLOgmYI0f4oRsBs+mCruW2
   7b2+00hgMUvmFBKqetysWdbBRK4im68Y4OiNQhie9ShD4ezn317VRlpwV
   w==;
X-CSE-ConnectionGUID: TcET7ux0RRqCD5PlZUw9VA==
X-CSE-MsgGUID: QzwXXU84Ste6XU7vGg7yVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50576426"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="50576426"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 12:04:02 -0800
X-CSE-ConnectionGUID: oU7pHzeYQ9GS8dLDNz4nMg==
X-CSE-MsgGUID: 8aqitMpsRn2oSq0VGocsVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112569720"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Feb 2025 12:03:57 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1thwU6-0014eB-3A;
	Tue, 11 Feb 2025 20:03:54 +0000
Date: Wed, 12 Feb 2025 04:03:42 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
	linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v8 3/3] clk: aspeed: add AST2700 clock driver
Message-ID: <202502120324.m723zyqS-lkp@intel.com>
References: <20250210085004.1898895-4-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210085004.1898895-4-ryan_chen@aspeedtech.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on pza/reset/next linus/master v6.14-rc2 next-20250210]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-binding-clock-ast2700-modify-soc0-1-clock-define/20250210-165421
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250210085004.1898895-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v8 3/3] clk: aspeed: add AST2700 clock driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20250212/202502120324.m723zyqS-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502120324.m723zyqS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502120324.m723zyqS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/clk/clk-ast2700.c:11:
   In file included from include/linux/platform_device.h:13:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clk/clk-ast2700.c:209:37: warning: unused variable 'soc0_mpll_div8' [-Wunused-const-variable]
     209 | static const struct clk_parent_data soc0_mpll_div8[] = {
         |                                     ^~~~~~~~~~~~~~
>> drivers/clk/clk-ast2700.c:237:37: warning: unused variable 'soc0_ahb' [-Wunused-const-variable]
     237 | static const struct clk_parent_data soc0_ahb[] = {
         |                                     ^~~~~~~~
>> drivers/clk/clk-ast2700.c:337:37: warning: unused variable 'uart13clk' [-Wunused-const-variable]
     337 | static const struct clk_parent_data uart13clk[] = {
         |                                     ^~~~~~~~~
>> drivers/clk/clk-ast2700.c:341:37: warning: unused variable 'uart14clk' [-Wunused-const-variable]
     341 | static const struct clk_parent_data uart14clk[] = {
         |                                     ^~~~~~~~~
>> drivers/clk/clk-ast2700.c:345:37: warning: unused variable 'uart15clk' [-Wunused-const-variable]
     345 | static const struct clk_parent_data uart15clk[] = {
         |                                     ^~~~~~~~~
>> drivers/clk/clk-ast2700.c:349:37: warning: unused variable 'uart16clk' [-Wunused-const-variable]
     349 | static const struct clk_parent_data uart16clk[] = {
         |                                     ^~~~~~~~~
>> drivers/clk/clk-ast2700.c:353:37: warning: unused variable 'soc1_ahb' [-Wunused-const-variable]
     353 | static const struct clk_parent_data soc1_ahb[] = {
         |                                     ^~~~~~~~
>> drivers/clk/clk-ast2700.c:369:37: warning: unused variable 'd_clk_sels' [-Wunused-const-variable]
     369 | static const struct clk_parent_data d_clk_sels[] = {
         |                                     ^~~~~~~~~~
   11 warnings generated.


vim +/soc0_mpll_div8 +209 drivers/clk/clk-ast2700.c

   208	
 > 209	static const struct clk_parent_data soc0_mpll_div8[] = {
   210		{ .fw_name = "soc0-mpll_div8", .name = "soc0-mpll_div8" },
   211	};
   212	
   213	static const struct clk_parent_data mphysrc[] = {
   214		{ .fw_name = "mphysrc", .name = "mphysrc" },
   215	};
   216	
   217	static const struct clk_parent_data u2phy_refclksrc[] = {
   218		{ .fw_name = "u2phy_refclksrc", .name = "u2phy_refclksrc" },
   219	};
   220	
   221	static const struct clk_parent_data soc0_hpll[] = {
   222		{ .fw_name = "soc0-hpll", .name = "soc0-hpll" },
   223	};
   224	
   225	static const struct clk_parent_data soc0_mpll[] = {
   226		{ .fw_name = "soc0-mpll", .name = "soc0-mpll" },
   227	};
   228	
   229	static const struct clk_parent_data axi0clk[] = {
   230		{ .fw_name = "axi0clk", .name = "axi0clk" },
   231	};
   232	
   233	static const struct clk_parent_data soc0_ahbmux[] = {
   234		{ .fw_name = "soc0-ahbmux", .name = "soc0-ahbmux" },
   235	};
   236	
 > 237	static const struct clk_parent_data soc0_ahb[] = {
   238		{ .fw_name = "soc0-ahb", .name = "soc0-ahb" },
   239	};
   240	
   241	static const struct clk_parent_data soc0_uartclk[] = {
   242		{ .fw_name = "soc0-uartclk", .name = "soc0-uartclk" },
   243	};
   244	
   245	static const struct clk_parent_data emmcclk[] = {
   246		{ .fw_name = "emmcclk", .name = "emmcclk" },
   247	};
   248	
   249	static const struct clk_parent_data emmcsrc_mux[] = {
   250		{ .fw_name = "emmcsrc-mux", .name = "emmcsrc-mux" },
   251	};
   252	
   253	static const struct clk_parent_data soc1_clkin[] = {
   254		{ .fw_name = "soc1-clkin", .name = "soc1-clkin" },
   255	};
   256	
   257	static const struct clk_parent_data soc1_hpll[] = {
   258		{ .fw_name = "soc1-hpll", .name = "soc1-hpll" },
   259	};
   260	
   261	static const struct clk_parent_data soc1_apll[] = {
   262		{ .fw_name = "soc1-apll", .name = "soc1-apll" },
   263	};
   264	
   265	static const struct clk_parent_data sdclk[] = {
   266		{ .fw_name = "sdclk", .name = "sdclk" },
   267	};
   268	
   269	static const struct clk_parent_data sdclk_mux[] = {
   270		{ .fw_name = "sdclk-mux", .name = "sdclk-mux" },
   271	};
   272	
   273	static const struct clk_parent_data huartxclk[] = {
   274		{ .fw_name = "huartxclk", .name = "huartxclk" },
   275	};
   276	
   277	static const struct clk_parent_data uxclk[] = {
   278		{ .fw_name = "uxclk", .name = "uxclk" },
   279	};
   280	
   281	static const struct clk_parent_data huxclk[] = {
   282		{ .fw_name = "huxclk", .name = "huxclk" },
   283	};
   284	
   285	static const struct clk_parent_data uart0clk[] = {
   286		{ .fw_name = "uart0clk", .name = "uart0clk" },
   287	};
   288	
   289	static const struct clk_parent_data uart1clk[] = {
   290		{ .fw_name = "uart1clk", .name = "uart1clk" },
   291	};
   292	
   293	static const struct clk_parent_data uart2clk[] = {
   294		{ .fw_name = "uart2clk", .name = "uart2clk" },
   295	};
   296	
   297	static const struct clk_parent_data uart3clk[] = {
   298		{ .fw_name = "uart3clk", .name = "uart3clk" },
   299	};
   300	
   301	static const struct clk_parent_data uart5clk[] = {
   302		{ .fw_name = "uart5clk", .name = "uart5clk" },
   303	};
   304	
   305	static const struct clk_parent_data uart4clk[] = {
   306		{ .fw_name = "uart4clk", .name = "uart4clk" },
   307	};
   308	
   309	static const struct clk_parent_data uart6clk[] = {
   310		{ .fw_name = "uart6clk", .name = "uart6clk" },
   311	};
   312	
   313	static const struct clk_parent_data uart7clk[] = {
   314		{ .fw_name = "uart7clk", .name = "uart7clk" },
   315	};
   316	
   317	static const struct clk_parent_data uart8clk[] = {
   318		{ .fw_name = "uart8clk", .name = "uart8clk" },
   319	};
   320	
   321	static const struct clk_parent_data uart9clk[] = {
   322		{ .fw_name = "uart9clk", .name = "uart9clk" },
   323	};
   324	
   325	static const struct clk_parent_data uart10clk[] = {
   326		{ .fw_name = "uart10clk", .name = "uart10clk" },
   327	};
   328	
   329	static const struct clk_parent_data uart11clk[] = {
   330		{ .fw_name = "uart11clk", .name = "uart11clk" },
   331	};
   332	
   333	static const struct clk_parent_data uart12clk[] = {
   334		{ .fw_name = "uart12clk", .name = "uart12clk" },
   335	};
   336	
 > 337	static const struct clk_parent_data uart13clk[] = {
   338		{ .fw_name = "uart13clk", .name = "uart13clk" },
   339	};
   340	
 > 341	static const struct clk_parent_data uart14clk[] = {
   342		{ .fw_name = "uart14clk", .name = "uart14clk" },
   343	};
   344	
 > 345	static const struct clk_parent_data uart15clk[] = {
   346		{ .fw_name = "uart15clk", .name = "uart15clk" },
   347	};
   348	
 > 349	static const struct clk_parent_data uart16clk[] = {
   350		{ .fw_name = "uart16clk", .name = "uart16clk" },
   351	};
   352	
 > 353	static const struct clk_parent_data soc1_ahb[] = {
   354		{ .fw_name = "soc1-ahb", .name = "soc1-ahb" },
   355	};
   356	
   357	static const struct clk_parent_data soc1_i3c[] = {
   358		{ .fw_name = "soc1-i3c", .name = "soc1-i3c" },
   359	};
   360	
   361	static const struct clk_parent_data canclk[] = {
   362		{ .fw_name = "canclk", .name = "canclk" },
   363	};
   364	
   365	static const struct clk_parent_data rmii[] = {
   366		{ .fw_name = "rmii", .name = "rmii" },
   367	};
   368	
 > 369	static const struct clk_parent_data d_clk_sels[] = {
   370		{ .fw_name = "soc0-hpll_div2", .name = "soc0-hpll_div2" },
   371		{ .fw_name = "soc0-mpll_div2", .name = "soc0-mpll_div2" },
   372	};
   373	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


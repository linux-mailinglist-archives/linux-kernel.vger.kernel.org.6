Return-Path: <linux-kernel+bounces-510761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A76AA32193
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBEF1889175
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC301205ABB;
	Wed, 12 Feb 2025 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RiZjoGPb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A552F271828;
	Wed, 12 Feb 2025 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350655; cv=none; b=G3ihDGGR8HoP9ADHh9nClo9yt2kSlfpMjv4PaKHeRpxvR0c/p97CTnl/OHtN4bydBDLb3RxN8sRNpySG7us2Y024vvrzVWTh8ZeL24NCSmP/BHPrs8Iw6BUy5iRUjjBtokIJM+8p0rq6DbUhN8dQ8DPKHG19aQqt3zWDm7x+EDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350655; c=relaxed/simple;
	bh=vX6/CDrLsi+PiLy4kwaL8vsmQecJaGwqitg7vNz+psg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM7edg4+K5s6dSRr3WcNdq0mANTRBoh8B/LBd/GRJ5udWuuGISGbKrNSbx0l/cfI76WWxfAks4fi1Ing1XghxbcDAp0Yf/cm/MNgPacwv5X/0jnW76ENcvgxjhtjHP8Xn2Z+F0Zn0ucubnlTktlJWFYDFhvWBk1IaepesEvkBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RiZjoGPb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739350654; x=1770886654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vX6/CDrLsi+PiLy4kwaL8vsmQecJaGwqitg7vNz+psg=;
  b=RiZjoGPbeHA4adRY+t71J8ZREbTeuJq+vo3OgvtiulukZkvgeiiagDmW
   qYmgDomwWxR+A/OcDl5GixJZAVZSqpjDK5LlQf9VAsFdd0QPvb5fVm107
   QhIT8i+zrrip41z0EBlOSQ72EoiojRAjjLVqf3x5SgmpH0G/+SnDlJj08
   qL/tSk4Vi3Ht2Zn3NilzNuL05Z4j1dygderbwnRWKWjzcBC2Bjddnc10P
   OsAHlbrkH6xQoWB72TIFXpR5FVUSJmX9yX/KaWQrRdYjQyad5BOY6tmq2
   pFKo67WH4Qy0AiAwG+JgT1fEGsbA2o+Hs3eqL+v+MqNDU8vft2GFHEpoM
   g==;
X-CSE-ConnectionGUID: eaiQqH7+R36DTbJBseTnpw==
X-CSE-MsgGUID: oNF8XexaRxqXC1nGoiMImg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="50630749"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="50630749"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 00:57:33 -0800
X-CSE-ConnectionGUID: dLQFfP+/S8+lS5adRI8UFQ==
X-CSE-MsgGUID: gpKNy4SXS6Kp2XEwreVocg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="117778390"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Feb 2025 00:57:29 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ti8Yg-0015P7-1H;
	Wed, 12 Feb 2025 08:57:26 +0000
Date: Wed, 12 Feb 2025 16:57:10 +0800
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v8 3/3] clk: aspeed: add AST2700 clock driver
Message-ID: <202502121624.f9xpltGE-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on pza/reset/next linus/master v6.14-rc2]
[cannot apply to pza/imx-drm/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Chen/dt-binding-clock-ast2700-modify-soc0-1-clock-define/20250210-165421
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/20250210085004.1898895-4-ryan_chen%40aspeedtech.com
patch subject: [PATCH v8 3/3] clk: aspeed: add AST2700 clock driver
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20250212/202502121624.f9xpltGE-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250212/202502121624.f9xpltGE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502121624.f9xpltGE-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/big_endian.h:14,
                    from include/linux/byteorder/big_endian.h:5,
                    from arch/m68k/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/m68k/include/asm/bitops.h:566,
                    from include/linux/bitops.h:68,
                    from include/linux/of.h:15,
                    from include/linux/clk-provider.h:9,
                    from drivers/clk/clk-ast2700.c:7:
   drivers/clk/clk-ast2700.c: In function 'ast2700_soc1_configure_i3c_clk':
>> drivers/clk/clk-ast2700.c:981:32: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     981 |                                FIELD_PREP(SCU1_CLK_I3C_DIV_MASK,
         |                                ^~~~~~~~~~
   include/uapi/linux/swab.h:118:38: note: in definition of macro '__swab32'
     118 |         (__u32)(__builtin_constant_p(x) ?       \
         |                                      ^
   include/linux/byteorder/generic.h:88:21: note: in expansion of macro '__cpu_to_le32'
      88 | #define cpu_to_le32 __cpu_to_le32
         |                     ^~~~~~~~~~~~~
   arch/m68k/include/asm/io_mm.h:373:26: note: in expansion of macro 'out_le32'
     373 | #define writel(val,addr) out_le32((addr),(val))
         |                          ^~~~~~~~
   drivers/clk/clk-ast2700.c:979:17: note: in expansion of macro 'writel'
     979 |                 writel((readl(clk_ctrl->base + SCU1_CLK_SEL2) &
         |                 ^~~~~~
   drivers/clk/clk-ast2700.c: At top level:
   drivers/clk/clk-ast2700.c:369:37: warning: 'd_clk_sels' defined but not used [-Wunused-const-variable=]
     369 | static const struct clk_parent_data d_clk_sels[] = {
         |                                     ^~~~~~~~~~
   drivers/clk/clk-ast2700.c:353:37: warning: 'soc1_ahb' defined but not used [-Wunused-const-variable=]
     353 | static const struct clk_parent_data soc1_ahb[] = {
         |                                     ^~~~~~~~
   drivers/clk/clk-ast2700.c:349:37: warning: 'uart16clk' defined but not used [-Wunused-const-variable=]
     349 | static const struct clk_parent_data uart16clk[] = {
         |                                     ^~~~~~~~~
   drivers/clk/clk-ast2700.c:345:37: warning: 'uart15clk' defined but not used [-Wunused-const-variable=]
     345 | static const struct clk_parent_data uart15clk[] = {
         |                                     ^~~~~~~~~
   drivers/clk/clk-ast2700.c:341:37: warning: 'uart14clk' defined but not used [-Wunused-const-variable=]
     341 | static const struct clk_parent_data uart14clk[] = {
         |                                     ^~~~~~~~~
   drivers/clk/clk-ast2700.c:337:37: warning: 'uart13clk' defined but not used [-Wunused-const-variable=]
     337 | static const struct clk_parent_data uart13clk[] = {
         |                                     ^~~~~~~~~
   drivers/clk/clk-ast2700.c:237:37: warning: 'soc0_ahb' defined but not used [-Wunused-const-variable=]
     237 | static const struct clk_parent_data soc0_ahb[] = {
         |                                     ^~~~~~~~
   drivers/clk/clk-ast2700.c:209:37: warning: 'soc0_mpll_div8' defined but not used [-Wunused-const-variable=]
     209 | static const struct clk_parent_data soc0_mpll_div8[] = {
         |                                     ^~~~~~~~~~~~~~


vim +/FIELD_PREP +981 drivers/clk/clk-ast2700.c

   974	
   975	static void ast2700_soc1_configure_i3c_clk(struct ast2700_clk_ctrl *clk_ctrl)
   976	{
   977		if (readl(clk_ctrl->base + SCU1_REVISION_ID) & REVISION_ID)
   978			/* I3C 250MHz = HPLL/4 */
   979			writel((readl(clk_ctrl->base + SCU1_CLK_SEL2) &
   980				~SCU1_CLK_I3C_DIV_MASK) |
 > 981				       FIELD_PREP(SCU1_CLK_I3C_DIV_MASK,
   982						  SCU1_CLK_I3C_DIV(4)),
   983			       clk_ctrl->base + SCU1_CLK_SEL2);
   984	}
   985	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-260557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1103093AAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3797B2233D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C489134B1;
	Wed, 24 Jul 2024 02:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2LBbUa1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401DDF58
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786825; cv=none; b=F+oVyx46wGQhavb25Xy7SSpMqlLRc67MbRm1bc+/c16xAAD0NMWZLj/KDBzDes5vghp2o/OHoSsKlRG/hoJHtPYR6ZBkieMj2jbrB1OyLmvHmXaHMcgqNP59A1BhoUCmXxUOinEPt3vuP3fzBpgy1Ft2ItUOoJGiNu15m6Jim64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786825; c=relaxed/simple;
	bh=JD84DGgix5uRu7/svASYYOfJnnNZwn+nQuL3F4CBVak=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=G8blJZXIhIzE7APn1Dqu8hp51pGQ/kLimdP5wg7vXOTqrXNes5FzYRxjs9mizP+13/p9FRPBspLKc8anYQMnFAXk3Pm7ocejhF5/Mqazlzce6JWA1JDh/gzNd5Q+vTje9vaVk5/5fIjcsV94lUkZbteTfkKzkGjcvnBVziibiS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2LBbUa1; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721786823; x=1753322823;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JD84DGgix5uRu7/svASYYOfJnnNZwn+nQuL3F4CBVak=;
  b=G2LBbUa1LRBEEIwR9Y3Whzn4/u+KFvYWXRQE9ibMz/cO3UzvnFnMe2cz
   9J0yiMB+cgB8Oxs1eb+reuujihDd2uFiHZ5BX28ysPian1kwfaf/bMVEL
   TTrxfWz9ZwHdIVWPoFaejEoBKZnbFfKUGuShamBjvWc+N0zfLzaeopvpx
   ngqzggyIsQWe0kHN8oA74r4mh3cFUFtd33IuUQmwGCjKHXA7hRbZepKl0
   an6lp1dPR6CSMWHzVvJ0EGy2epBE5pAaWLWnWI3wUAUdllpEbZku7bYOU
   Czak/CjrGPJEIEDhha0fic8piFAw1AIiky24TPo/DFnVKg4SLF2XXCPYX
   w==;
X-CSE-ConnectionGUID: 41fCwY96Su65pMm4pxhYiQ==
X-CSE-MsgGUID: oPEi7ToEReCP07wr2f61pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30859644"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="30859644"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:07:03 -0700
X-CSE-ConnectionGUID: udWFBBIOQraKjVEYPiwSXg==
X-CSE-MsgGUID: GoEFb5AOQ2uVtDWb67KDyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="53030070"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Jul 2024 19:07:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWRP8-000mYG-1P;
	Wed, 24 Jul 2024 02:06:58 +0000
Date: Wed, 24 Jul 2024 10:06:51 +0800
From: kernel test robot <lkp@intel.com>
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, Yangtao Li <frank.li@vivo.com>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: drivers/clk/thead/clk-th1520-ap.c:260:undefined reference to
 `__udivdi3'
Message-ID: <202407241009.IjYZN3cz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5ad7ff8738b8bd238ca899df08badb1f61bcc39e
commit: ae81b69fd2b1eb4885b352749b1fd1172e2f0f18 clk: thead: Add support for T-Head TH1520 AP_SUBSYS clocks
date:   8 days ago
config: riscv-randconfig-r005-20230829 (https://download.01.org/0day-ci/archive/20240724/202407241009.IjYZN3cz-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407241009.IjYZN3cz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407241009.IjYZN3cz-lkp@intel.com/

All errors (new ones prefixed by >>):

   riscv32-linux-ld: drivers/clk/thead/clk-th1520-ap.o: in function `th1520_pll_vco_recalc_rate':
>> drivers/clk/thead/clk-th1520-ap.c:260:(.text+0x78): undefined reference to `__udivdi3'


vim +260 drivers/clk/thead/clk-th1520-ap.c

   239	
   240	static unsigned long th1520_pll_vco_recalc_rate(struct clk_hw *hw,
   241							unsigned long parent_rate)
   242	{
   243		struct ccu_pll *pll = hw_to_ccu_pll(hw);
   244		unsigned long div, mul, frac;
   245		unsigned int cfg0, cfg1;
   246		u64 rate = parent_rate;
   247	
   248		regmap_read(pll->common.map, pll->common.cfg0, &cfg0);
   249		regmap_read(pll->common.map, pll->common.cfg1, &cfg1);
   250	
   251		mul = FIELD_GET(TH1520_PLL_FBDIV, cfg0);
   252		div = FIELD_GET(TH1520_PLL_REFDIV, cfg0);
   253		if (!(cfg1 & TH1520_PLL_DSMPD)) {
   254			mul <<= TH1520_PLL_FRAC_BITS;
   255			frac = FIELD_GET(TH1520_PLL_FRAC, cfg1);
   256			mul += frac;
   257			div <<= TH1520_PLL_FRAC_BITS;
   258		}
   259		rate = parent_rate * mul;
 > 260		rate = rate / div;
   261		return rate;
   262	}
   263	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


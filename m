Return-Path: <linux-kernel+bounces-407354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FAA9C6C42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A260E2878C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAF11FA857;
	Wed, 13 Nov 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PerTfzZS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E591F80A6;
	Wed, 13 Nov 2024 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492056; cv=none; b=bh/MDXNfKqVSqKzsOeSxETqnA1mrerWwvMyP6MdOAFtbWOo87wgfXKpZVK+WoFvRR/ugOMHCj4si9g3mG/oIQrONxI24aPubJokUVkOraoAn3aKiWA1ezJAbnSoNi1pj8h5NTr8+GK7aT+3PLUo93E0Damk+c2KEvthjnEZPXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492056; c=relaxed/simple;
	bh=ZkMq79c4JGzoIJVfdWDk1J1kcO/pPfiYg79E2+IsnHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmrp3e/qbI3wQ01b/9tSzTCwVTPwDP/yd+xChMrkA7Xmbn7RA6HpfI7xx2OrUSj3grACLs0qosJTqrc3GibRmfxWA+B6moPQsWMubtzRHGeMHAMebJICtYLEgjoLVS6Wug/vJ6pR8s4kZU4Px3O1RM/sXNxy3vzGnn94rD5p9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PerTfzZS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731492054; x=1763028054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZkMq79c4JGzoIJVfdWDk1J1kcO/pPfiYg79E2+IsnHk=;
  b=PerTfzZSExiLH4O+M7QIlzpt56PQDqTMxoPCHgtNEvO9b6+w6pUrd+ZQ
   CU4dDN57Ca0s3UUCi8EIDkydf+4WtdhsxtDgTC4TWRK9KmwnhngK/Qt+m
   IrCnOb8uJJloPvWxkc7QSeVZm0OQO2DOzf3WsrxO+jZRSttZ6pM6NNSFG
   /2OmY7tmP9GwKWjW2NBlguYuUTbBZls0oxcR7YqVz3o8eQtnby+iGYEaF
   UweXWSs0Ryqw78Gu/czXAU3j+PBp/iAtSMadMmjGzBRMWgZpxFhDfQpy3
   o3ICxfkS0ek5ZCnRIGP2EhiAIRViH0Iv0tgRKb7WlZMYSVG5GxbSL2mN4
   w==;
X-CSE-ConnectionGUID: XRxtXpcmSzWAQqeu+E1oeg==
X-CSE-MsgGUID: ZW7iKvrbRWqR1ZZdIMGQYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="35085694"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="35085694"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 02:00:53 -0800
X-CSE-ConnectionGUID: xHi9XD1fRge89TMU/HzhZQ==
X-CSE-MsgGUID: lE+YIcgmQxCsnQn5M+kxkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="92292266"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 13 Nov 2024 02:00:51 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBAB7-0000D7-0W;
	Wed, 13 Nov 2024 10:00:49 +0000
Date: Wed, 13 Nov 2024 18:00:19 +0800
From: kernel test robot <lkp@intel.com>
To: Ragavendra <ragavendra.bn@gmail.com>, mturquette@baylibre.com,
	sboyd@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ragavendra <ragavendra.bn@gmail.com>
Subject: Re: [PATCH] clk:sophgo:clk-cv18xx-pll: Remove uninitialized u32
 parameter and variable
Message-ID: <202411131750.bsCkQYb6-lkp@intel.com>
References: <20241113025318.3667350-1-ragavendra.bn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113025318.3667350-1-ragavendra.bn@gmail.com>

Hi Ragavendra,

kernel test robot noticed the following build errors:

[auto build test ERROR on sophgo/for-next]
[also build test ERROR on sophgo/fixes linus/master v6.12-rc7 next-20241112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ragavendra/clk-sophgo-clk-cv18xx-pll-Remove-uninitialized-u32-parameter-and-variable/20241113-105536
base:   https://github.com/sophgo/linux.git for-next
patch link:    https://lore.kernel.org/r/20241113025318.3667350-1-ragavendra.bn%40gmail.com
patch subject: [PATCH] clk:sophgo:clk-cv18xx-pll: Remove uninitialized u32 parameter and variable
config: arm-randconfig-001-20241113 (https://download.01.org/0day-ci/archive/20241113/202411131750.bsCkQYb6-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241113/202411131750.bsCkQYb6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411131750.bsCkQYb6-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/clk/sophgo/clk-cv18xx-pll.c:80:4: error: use of undeclared identifier 'value'
      80 |                 *value = detected;
         |                  ^
   1 error generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +/value +80 drivers/clk/sophgo/clk-cv18xx-pll.c

80fd61ec46124e Inochi Amaoto 2024-03-09  46  
d666c0d9d14eb5 Ragavendra    2024-11-12  47  
80fd61ec46124e Inochi Amaoto 2024-03-09  48  static int ipll_find_rate(const struct cv1800_clk_pll_limit *limit,
d666c0d9d14eb5 Ragavendra    2024-11-12  49  			  unsigned long prate, unsigned long *rate)
80fd61ec46124e Inochi Amaoto 2024-03-09  50  {
80fd61ec46124e Inochi Amaoto 2024-03-09  51  	unsigned long best_rate = 0;
80fd61ec46124e Inochi Amaoto 2024-03-09  52  	unsigned long trate = *rate;
80fd61ec46124e Inochi Amaoto 2024-03-09  53  	unsigned long pre_div_sel = 0, div_sel = 0, post_div_sel = 0;
80fd61ec46124e Inochi Amaoto 2024-03-09  54  	unsigned long pre, div, post;
d666c0d9d14eb5 Ragavendra    2024-11-12  55  	u32 detected = 0;
80fd61ec46124e Inochi Amaoto 2024-03-09  56  	unsigned long tmp;
80fd61ec46124e Inochi Amaoto 2024-03-09  57  
80fd61ec46124e Inochi Amaoto 2024-03-09  58  	for_each_pll_limit_range(pre, &limit->pre_div) {
80fd61ec46124e Inochi Amaoto 2024-03-09  59  		for_each_pll_limit_range(div, &limit->div) {
80fd61ec46124e Inochi Amaoto 2024-03-09  60  			for_each_pll_limit_range(post, &limit->post_div) {
80fd61ec46124e Inochi Amaoto 2024-03-09  61  				tmp = ipll_calc_rate(prate, pre, div, post);
80fd61ec46124e Inochi Amaoto 2024-03-09  62  
80fd61ec46124e Inochi Amaoto 2024-03-09  63  				if (tmp > trate)
80fd61ec46124e Inochi Amaoto 2024-03-09  64  					continue;
80fd61ec46124e Inochi Amaoto 2024-03-09  65  
80fd61ec46124e Inochi Amaoto 2024-03-09  66  				if ((trate - tmp) < (trate - best_rate)) {
80fd61ec46124e Inochi Amaoto 2024-03-09  67  					best_rate = tmp;
80fd61ec46124e Inochi Amaoto 2024-03-09  68  					pre_div_sel = pre;
80fd61ec46124e Inochi Amaoto 2024-03-09  69  					div_sel = div;
80fd61ec46124e Inochi Amaoto 2024-03-09  70  					post_div_sel = post;
80fd61ec46124e Inochi Amaoto 2024-03-09  71  				}
80fd61ec46124e Inochi Amaoto 2024-03-09  72  			}
80fd61ec46124e Inochi Amaoto 2024-03-09  73  		}
80fd61ec46124e Inochi Amaoto 2024-03-09  74  	}
80fd61ec46124e Inochi Amaoto 2024-03-09  75  
80fd61ec46124e Inochi Amaoto 2024-03-09  76  	if (best_rate) {
80fd61ec46124e Inochi Amaoto 2024-03-09  77  		detected = PLL_SET_PRE_DIV_SEL(detected, pre_div_sel);
80fd61ec46124e Inochi Amaoto 2024-03-09  78  		detected = PLL_SET_POST_DIV_SEL(detected, post_div_sel);
80fd61ec46124e Inochi Amaoto 2024-03-09  79  		detected = PLL_SET_DIV_SEL(detected, div_sel);
80fd61ec46124e Inochi Amaoto 2024-03-09 @80  		*value = detected;
80fd61ec46124e Inochi Amaoto 2024-03-09  81  		*rate = best_rate;
80fd61ec46124e Inochi Amaoto 2024-03-09  82  		return 0;
80fd61ec46124e Inochi Amaoto 2024-03-09  83  	}
80fd61ec46124e Inochi Amaoto 2024-03-09  84  
80fd61ec46124e Inochi Amaoto 2024-03-09  85  	return -EINVAL;
80fd61ec46124e Inochi Amaoto 2024-03-09  86  }
80fd61ec46124e Inochi Amaoto 2024-03-09  87  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


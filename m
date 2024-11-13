Return-Path: <linux-kernel+bounces-407309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D29C6BA1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22484B24339
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A91F80B4;
	Wed, 13 Nov 2024 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YOA2LUPB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877A178CC8;
	Wed, 13 Nov 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490796; cv=none; b=TO7Uyzgl5AeLn0jtlqidgSz783y/H3+LZCkvHYPhWdJnsyVyr5J5Lk/pYnIqvWFz+nu4WuCxT+VO6028JUir7QafrhAwh4d7h0WHAvKBYgIzx46YSooJU1wp0F/EMdPSynIlFEwP3U54KK+UtX3BPWaNKDLydi1wh0e98tveP1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490796; c=relaxed/simple;
	bh=g0Er6a09/kvhBUIyp89V4jG41q3DWR0+PaYSmmH8f/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p5uD1YT6aELYv9yeVJc2UFXS6dvC3Y4h3fXWnjxClS8J3KwYydTIXhGs7QxIFukGEnlOM4PtrdjGB7z9BHFRXDqwl7wxkL0h2jZuaEjEC21RRiXxDySmxH83uVQAeD3VqGw26inUQzBH1Z736Tar7MItOg7Xopbv3YNAepA3yqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YOA2LUPB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731490793; x=1763026793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g0Er6a09/kvhBUIyp89V4jG41q3DWR0+PaYSmmH8f/k=;
  b=YOA2LUPB4epVuwRBDPRZHadLBsvt1HmQMrr50GqNCgzfSGUlyZ+AD4f1
   uvh2mAHBnYgra8PclEyb1WA5FhjgtdVdmkR1qqDDeTh8SQ3H+EPWlIQC4
   MSbBeRPwA+4yo2YpUsyhDmdJqkh6VSWq3umLxhucDgd0JqbyEN67IOAMW
   x60HwNgB9RxPR26e9fkEntJaFIKqr8aUbFhaBKnmVc6gIzBciRfdqUVgv
   HnmmLtDsETSwZBHUusbTzW+Ty2MywIU3Sg/g7/++bAuMpWaSlEUb2aU4+
   wI8aHzq4XbhOOUmSgbDrXSK4c/Ua/QSuvs2dCNuei42bwl9oSm6I1GD7p
   Q==;
X-CSE-ConnectionGUID: sWJVHfgQQEyyntiSGGX3Lw==
X-CSE-MsgGUID: m/QW4VYOTLWzA0fkHbTqvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="48881510"
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="48881510"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 01:39:53 -0800
X-CSE-ConnectionGUID: cPLHfaO3QiKAFtjewtcmSw==
X-CSE-MsgGUID: UFjyCy2WScWg1p9lPGwudA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,150,1728975600"; 
   d="scan'208";a="118755399"
Received: from lkp-server01.sh.intel.com (HELO 80bd855f15b3) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2024 01:39:50 -0800
Received: from kbuild by 80bd855f15b3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tB9ql-0000CT-2I;
	Wed, 13 Nov 2024 09:39:47 +0000
Date: Wed, 13 Nov 2024 17:39:07 +0800
From: kernel test robot <lkp@intel.com>
To: Ragavendra <ragavendra.bn@gmail.com>, mturquette@baylibre.com,
	sboyd@kernel.org, unicorn_wang@outlook.com, inochiama@outlook.com
Cc: oe-kbuild-all@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ragavendra <ragavendra.bn@gmail.com>
Subject: Re: [PATCH] clk:sophgo:clk-cv18xx-pll: Remove uninitialized u32
 parameter and variable
Message-ID: <202411131735.aLFcuMe3-lkp@intel.com>
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
config: i386-buildonly-randconfig-005-20241113 (https://download.01.org/0day-ci/archive/20241113/202411131735.aLFcuMe3-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241113/202411131735.aLFcuMe3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411131735.aLFcuMe3-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/clk/sophgo/clk-cv18xx-pll.c: In function 'ipll_find_rate':
>> drivers/clk/sophgo/clk-cv18xx-pll.c:80:18: error: 'value' undeclared (first use in this function)
      80 |                 *value = detected;
         |                  ^~~~~
   drivers/clk/sophgo/clk-cv18xx-pll.c:80:18: note: each undeclared identifier is reported only once for each function it appears in


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


Return-Path: <linux-kernel+bounces-303117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FD096079D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA36FB217E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091119DFAE;
	Tue, 27 Aug 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikRlgTQ/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D27182B2;
	Tue, 27 Aug 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755100; cv=none; b=AeiquZxxezunRf+dgaqDbS+HG8IUQr6c8gcSHcz7i235jBlDuYSZgi77nRBu0w2MElPIQPLRZwMCuQyRRlD5kBCdQnj1BuoaS+RYctYUla3vuhlzKR63WlyS3Sd1NJGOwJOHJzJHF7MP8xWFnoNnJP19uyJCEodmJt4C3qEvtew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755100; c=relaxed/simple;
	bh=5YCi4i5sFByw03BA9DFgBLqn2Xkexy28Zv+P6xGdrpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkztbrYEiVSCDgv53pfGuwtPpmq+V+rhgcMyBpiWQ29fPz8faq2xN7zlEh2bKjWJRM3zWM1sr7HOM23QQKJcB2Q5TRBTiVIQLmc/UDoSz04puB2OgGzuX/1AyvnUKnP3MWvyQFSL69HkRD81EmOaPeM1g2COuCFy9RWopLC5gv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikRlgTQ/; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724755099; x=1756291099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5YCi4i5sFByw03BA9DFgBLqn2Xkexy28Zv+P6xGdrpw=;
  b=ikRlgTQ/lH3XYxZqzo7QAH53Uh4na7uWbpuUnd9TMisH/XhuVa2bCssg
   P+lxCSwmR6faNGY06/CaMxZznl7HzzCEpd8G0crHtQ+h0RTc9TqqwN8xS
   9Jdm/Dien9F2JjIKSXSHH7jLsYGBfMb+MgluB6KBHvpajnugAwbaG4KYh
   7VQRBfV/0wM9kn4At6sALXfpwY9reD2YDAuUrNz58CiXHDIa/UczMT5N3
   m8w3utST/5gNk93BwGcoqgZ/T+cxCSqJA5jGStU+ivpRAIZbzTY0t6IgN
   Gy5iRhQi6Lr1VnTp/MviKl/53MtHfO2NgDvp0oGyylwZ+5JuPzDv3eIwe
   g==;
X-CSE-ConnectionGUID: 1s35bkclRN+25R1Lu6Rp9g==
X-CSE-MsgGUID: dl3pU5R4Sj+9Rjp4Qk1wcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="34634009"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="34634009"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:38:18 -0700
X-CSE-ConnectionGUID: Z+jbXAbeSBS4e6IuyiA97w==
X-CSE-MsgGUID: eGxP8muFQXWmr65PMRG8Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62809770"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2024 03:38:15 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sitaX-000IX0-1a;
	Tue, 27 Aug 2024 10:38:13 +0000
Date: Tue, 27 Aug 2024 18:37:39 +0800
From: kernel test robot <lkp@intel.com>
To: jiping huang <huangjiping95@qq.com>, mturquette@baylibre.com,
	sboyd@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	jiping huang <huangjiping95@qq.com>
Subject: Re: [PATCH] clk: Delete redundant logic.
Message-ID: <202408271846.xZq9AEQa-lkp@intel.com>
References: <tencent_713186AE6290AC7B8037FD247F5BF04C0308@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_713186AE6290AC7B8037FD247F5BF04C0308@qq.com>

Hi jiping,

kernel test robot noticed the following build warnings:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v6.11-rc5 next-20240827]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/jiping-huang/clk-Delete-redundant-logic/20240826-170900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
patch link:    https://lore.kernel.org/r/tencent_713186AE6290AC7B8037FD247F5BF04C0308%40qq.com
patch subject: [PATCH] clk: Delete redundant logic.
config: i386-buildonly-randconfig-005-20240827 (https://download.01.org/0day-ci/archive/20240827/202408271846.xZq9AEQa-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240827/202408271846.xZq9AEQa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408271846.xZq9AEQa-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/clk/clk.c:2320:14: warning: variable 'parent' is uninitialized when used here [-Wuninitialized]
    2320 |         } else if (!parent || !(core->flags & CLK_SET_RATE_PARENT)) {
         |                     ^~~~~~
   drivers/clk/clk.c:2286:38: note: initialize the variable 'parent' to silence this warning
    2286 |         struct clk_core *old_parent, *parent;
         |                                             ^
         |                                              = NULL
>> drivers/clk/clk.c:2332:16: warning: variable 'old_parent' is uninitialized when used here [-Wuninitialized]
    2332 |         if (parent != old_parent &&
         |                       ^~~~~~~~~~
   drivers/clk/clk.c:2286:29: note: initialize the variable 'old_parent' to silence this warning
    2286 |         struct clk_core *old_parent, *parent;
         |                                    ^
         |                                     = NULL
   2 warnings generated.


vim +/parent +2320 drivers/clk/clk.c

b2476490ef11134 Mike Turquette  2012-03-15  2277  
4dff95dc9477a34 Stephen Boyd    2015-04-30  2278  /*
4dff95dc9477a34 Stephen Boyd    2015-04-30  2279   * calculate the new rates returning the topmost clock that has to be
4dff95dc9477a34 Stephen Boyd    2015-04-30  2280   * changed.
4dff95dc9477a34 Stephen Boyd    2015-04-30  2281   */
4dff95dc9477a34 Stephen Boyd    2015-04-30  2282  static struct clk_core *clk_calc_new_rates(struct clk_core *core,
4dff95dc9477a34 Stephen Boyd    2015-04-30  2283  					   unsigned long rate)
4dff95dc9477a34 Stephen Boyd    2015-04-30  2284  {
4dff95dc9477a34 Stephen Boyd    2015-04-30  2285  	struct clk_core *top = core;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2286  	struct clk_core *old_parent, *parent;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2287  	unsigned long best_parent_rate = 0;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2288  	unsigned long new_rate;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2289  	unsigned long min_rate;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2290  	unsigned long max_rate;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2291  	int p_index = 0;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2292  	long ret;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2293  
4dff95dc9477a34 Stephen Boyd    2015-04-30  2294  	/* sanity */
4dff95dc9477a34 Stephen Boyd    2015-04-30  2295  	if (IS_ERR_OR_NULL(core))
4dff95dc9477a34 Stephen Boyd    2015-04-30  2296  		return NULL;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2297  
4dff95dc9477a34 Stephen Boyd    2015-04-30  2298  	clk_core_get_boundaries(core, &min_rate, &max_rate);
71472c0c06cf9a3 James Hogan     2013-07-29  2299  
4dff95dc9477a34 Stephen Boyd    2015-04-30  2300  	/* find the closest rate and parent clk/rate */
0f6cc2b8e94da54 Jerome Brunet   2017-12-01  2301  	if (clk_core_can_round(core)) {
0817b62cc037a56 Boris Brezillon 2015-07-07  2302  		struct clk_rate_request req;
0817b62cc037a56 Boris Brezillon 2015-07-07  2303  
718af795d3fd786 Maxime Ripard   2022-08-16  2304  		clk_core_init_rate_req(core, &req, rate);
0f6cc2b8e94da54 Jerome Brunet   2017-12-01  2305  
49e62e0d96baf72 Maxime Ripard   2022-10-26  2306  		trace_clk_rate_request_start(&req);
49e62e0d96baf72 Maxime Ripard   2022-10-26  2307  
0f6cc2b8e94da54 Jerome Brunet   2017-12-01  2308  		ret = clk_core_determine_round_nolock(core, &req);
4dff95dc9477a34 Stephen Boyd    2015-04-30  2309  		if (ret < 0)
4dff95dc9477a34 Stephen Boyd    2015-04-30  2310  			return NULL;
035a61c314eb3da Tomeu Vizoso    2015-01-23  2311  
49e62e0d96baf72 Maxime Ripard   2022-10-26  2312  		trace_clk_rate_request_done(&req);
49e62e0d96baf72 Maxime Ripard   2022-10-26  2313  
0817b62cc037a56 Boris Brezillon 2015-07-07  2314  		best_parent_rate = req.best_parent_rate;
0817b62cc037a56 Boris Brezillon 2015-07-07  2315  		new_rate = req.rate;
0817b62cc037a56 Boris Brezillon 2015-07-07  2316  		parent = req.best_parent_hw ? req.best_parent_hw->core : NULL;
1c8e600440c7f50 Tomeu Vizoso    2015-01-23  2317  
4dff95dc9477a34 Stephen Boyd    2015-04-30  2318  		if (new_rate < min_rate || new_rate > max_rate)
4dff95dc9477a34 Stephen Boyd    2015-04-30  2319  			return NULL;
4dff95dc9477a34 Stephen Boyd    2015-04-30 @2320  	} else if (!parent || !(core->flags & CLK_SET_RATE_PARENT)) {
4dff95dc9477a34 Stephen Boyd    2015-04-30  2321  		/* pass-through clock without adjustable parent */
4dff95dc9477a34 Stephen Boyd    2015-04-30  2322  		core->new_rate = core->rate;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2323  		return NULL;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2324  	} else {
4dff95dc9477a34 Stephen Boyd    2015-04-30  2325  		/* pass-through clock with adjustable parent */
4dff95dc9477a34 Stephen Boyd    2015-04-30  2326  		top = clk_calc_new_rates(parent, rate);
4dff95dc9477a34 Stephen Boyd    2015-04-30  2327  		new_rate = parent->new_rate;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2328  		goto out;
1c8e600440c7f50 Tomeu Vizoso    2015-01-23  2329  	}
035a61c314eb3da Tomeu Vizoso    2015-01-23  2330  
4dff95dc9477a34 Stephen Boyd    2015-04-30  2331  	/* some clocks must be gated to change parent */
4dff95dc9477a34 Stephen Boyd    2015-04-30 @2332  	if (parent != old_parent &&
4dff95dc9477a34 Stephen Boyd    2015-04-30  2333  	    (core->flags & CLK_SET_PARENT_GATE) && core->prepare_count) {
4dff95dc9477a34 Stephen Boyd    2015-04-30  2334  		pr_debug("%s: %s not gated but wants to reparent\n",
4dff95dc9477a34 Stephen Boyd    2015-04-30  2335  			 __func__, core->name);
4dff95dc9477a34 Stephen Boyd    2015-04-30  2336  		return NULL;
035a61c314eb3da Tomeu Vizoso    2015-01-23  2337  	}
b2476490ef11134 Mike Turquette  2012-03-15  2338  
4dff95dc9477a34 Stephen Boyd    2015-04-30  2339  	/* try finding the new parent index */
4dff95dc9477a34 Stephen Boyd    2015-04-30  2340  	if (parent && core->num_parents > 1) {
4dff95dc9477a34 Stephen Boyd    2015-04-30  2341  		p_index = clk_fetch_parent_index(core, parent);
4dff95dc9477a34 Stephen Boyd    2015-04-30  2342  		if (p_index < 0) {
4dff95dc9477a34 Stephen Boyd    2015-04-30  2343  			pr_debug("%s: clk %s can not be parent of clk %s\n",
4dff95dc9477a34 Stephen Boyd    2015-04-30  2344  				 __func__, parent->name, core->name);
4dff95dc9477a34 Stephen Boyd    2015-04-30  2345  			return NULL;
4dff95dc9477a34 Stephen Boyd    2015-04-30  2346  		}
4dff95dc9477a34 Stephen Boyd    2015-04-30  2347  	}
b2476490ef11134 Mike Turquette  2012-03-15  2348  
4dff95dc9477a34 Stephen Boyd    2015-04-30  2349  	if ((core->flags & CLK_SET_RATE_PARENT) && parent &&
4dff95dc9477a34 Stephen Boyd    2015-04-30  2350  	    best_parent_rate != parent->rate)
4dff95dc9477a34 Stephen Boyd    2015-04-30  2351  		top = clk_calc_new_rates(parent, best_parent_rate);
035a61c314eb3da Tomeu Vizoso    2015-01-23  2352  
4dff95dc9477a34 Stephen Boyd    2015-04-30  2353  out:
4dff95dc9477a34 Stephen Boyd    2015-04-30  2354  	clk_calc_subtree(core, new_rate, parent, p_index);
b2476490ef11134 Mike Turquette  2012-03-15  2355  
4dff95dc9477a34 Stephen Boyd    2015-04-30  2356  	return top;
b2476490ef11134 Mike Turquette  2012-03-15  2357  }
b2476490ef11134 Mike Turquette  2012-03-15  2358  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


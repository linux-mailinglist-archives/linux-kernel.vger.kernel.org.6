Return-Path: <linux-kernel+bounces-535600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4330A474EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E50D916F709
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6F01E835A;
	Thu, 27 Feb 2025 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RoFOOHtk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58283FB0E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632056; cv=none; b=egLRt/wO09FG0pj5c/iTJag75zyhT9EUokZkYwR27USiU0kvXn3I73bh6lBBF+c7gO3hhVDYvscTbcmQB2zZ/GZCdsuCMY0ycfSmQ+7iEiju179JCO1LngH393tX6+Y5iL0yc12T8xxhP5ubBqNQsyk8XEOhhZk5DQx0tsTNqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632056; c=relaxed/simple;
	bh=NQl3Kropd5OekMlh1r+3EeI5CMMdc9zeGRnG8UmjcIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A13Rr6pWBYjzYWBUWNETIh7BvYRR1WWM1SK7q9U3eIG7DHtUl7sgBfsLdeReqcHdeX5e6v//TkjNRoSW6E5w6JHc7RkTqPcKdeQSq+JKNXWOcHHV/4wcgWGBjAPwEu1rtW/FGm+AgWsYrbzhTsoL5mtpmSLlAPuwLYQ1z0jZ28w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RoFOOHtk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740632055; x=1772168055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NQl3Kropd5OekMlh1r+3EeI5CMMdc9zeGRnG8UmjcIk=;
  b=RoFOOHtk/88F2lPEhqDvMPjeDclXM2ruvPhIrUWeNsj9SgxR73BAr6ZJ
   R7YAbn/mSE6AkTI8+r9H2unKN+hRLHcC8qFiMoW4CENgp26HmV37di+aB
   5BczX6BL7oe4h8E7yDRux7okGXFGX/1Yt7yzG6EJeTLmA/IWOf/dLoUEm
   dqhAoMdCYqLEza3yXgybgoV/pGEI9cPAYEDCcsqWUxXHrhl/DMFigU4Hv
   NNoyzEzQrx+0iyFVnKsJjqkpRhSI98vPKAMhxUKhHKZ89Inq7ZWMeuXOW
   2WRVIyH6Qnm6UXwwMTFKs+oAUEjNbXDImBApP9X8vX6YO9+ArxDCzjZYg
   A==;
X-CSE-ConnectionGUID: qUBzHyyHQPOicyeoWKUw1w==
X-CSE-MsgGUID: 8lWKNR+ZTy6KXID2Rf7S7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40747903"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="40747903"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 20:54:14 -0800
X-CSE-ConnectionGUID: g0+f+jFrTBCBy3FZz0evSA==
X-CSE-MsgGUID: NWB5NZXkR5eKpZmGLK4J/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="116940829"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 26 Feb 2025 20:54:11 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnVuS-000Cre-2c;
	Thu, 27 Feb 2025 04:54:08 +0000
Date: Thu, 27 Feb 2025 12:53:29 +0800
From: kernel test robot <lkp@intel.com>
To: zhongjinji@honor.com, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, yuzhao@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rientjes@google.com, vbabka@suse.cz, zhongjinji@honor.com,
	yipengxiang@honor.com, liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH] mm/page_alloc: make the maximum number of highatomic
 pageblocks resizable
Message-ID: <202502271248.bHUExwvw-lkp@intel.com>
References: <20250226024126.3718-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226024126.3718-1-zhongjinji@honor.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/zhongjinji-honor-com/mm-page_alloc-make-the-maximum-number-of-highatomic-pageblocks-resizable/20250226-121712
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250226024126.3718-1-zhongjinji%40honor.com
patch subject: [PATCH] mm/page_alloc: make the maximum number of highatomic pageblocks resizable
config: x86_64-buildonly-randconfig-006-20250227 (https://download.01.org/0day-ci/archive/20250227/202502271248.bHUExwvw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502271248.bHUExwvw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502271248.bHUExwvw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/page_alloc.c:6262:17: error: field name not in record or union initializer
    6262 |                 .procname       = "highatomic_reserve_ratio",
         |                 ^
   mm/page_alloc.c:6262:17: note: (near initialization for 'page_alloc_sysctl_table')
   mm/page_alloc.c:6263:17: error: field name not in record or union initializer
    6263 |                 .data           = &highatomic_reserve_ratio,
         |                 ^
   mm/page_alloc.c:6263:17: note: (near initialization for 'page_alloc_sysctl_table')
   mm/page_alloc.c:6263:35: error: initialization of 'const char *' from incompatible pointer type 'int *' [-Werror=incompatible-pointer-types]
    6263 |                 .data           = &highatomic_reserve_ratio,
         |                                   ^
   mm/page_alloc.c:6263:35: note: (near initialization for 'page_alloc_sysctl_table[5].procname')
   mm/page_alloc.c:6264:17: error: field name not in record or union initializer
    6264 |                 .maxlen         = sizeof(highatomic_reserve_ratio),
         |                 ^
   mm/page_alloc.c:6264:17: note: (near initialization for 'page_alloc_sysctl_table')
>> mm/page_alloc.c:6264:35: warning: initialization of 'const char *' from 'long unsigned int' makes pointer from integer without a cast [-Wint-conversion]
    6264 |                 .maxlen         = sizeof(highatomic_reserve_ratio),
         |                                   ^~~~~~
   mm/page_alloc.c:6264:35: note: (near initialization for 'page_alloc_sysctl_table[6].procname')
   mm/page_alloc.c:6265:17: error: field name not in record or union initializer
    6265 |                 .mode           = 0644,
         |                 ^
   mm/page_alloc.c:6265:17: note: (near initialization for 'page_alloc_sysctl_table')
>> mm/page_alloc.c:6265:35: warning: initialization of 'const char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    6265 |                 .mode           = 0644,
         |                                   ^~~~
   mm/page_alloc.c:6265:35: note: (near initialization for 'page_alloc_sysctl_table[7].procname')
   mm/page_alloc.c:6266:17: error: field name not in record or union initializer
    6266 |                 .proc_handler   = proc_dointvec_minmax,
         |                 ^
   mm/page_alloc.c:6266:17: note: (near initialization for 'page_alloc_sysctl_table')
   mm/page_alloc.c:6266:35: error: initialization of 'const char *' from incompatible pointer type 'int (*)(const struct ctl_table *, int,  void *, size_t *, loff_t *)' {aka 'int (*)(const struct ctl_table *, int,  void *, long unsigned int *, long long int *)'} [-Werror=incompatible-pointer-types]
    6266 |                 .proc_handler   = proc_dointvec_minmax,
         |                                   ^~~~~~~~~~~~~~~~~~~~
   mm/page_alloc.c:6266:35: note: (near initialization for 'page_alloc_sysctl_table[8].procname')
   mm/page_alloc.c:6267:17: error: field name not in record or union initializer
    6267 |                 .extra1         = SYSCTL_ZERO,
         |                 ^
   mm/page_alloc.c:6267:17: note: (near initialization for 'page_alloc_sysctl_table')
   mm/page_alloc.c:6228:59: warning: missing braces around initializer [-Wmissing-braces]
    6228 | static const struct ctl_table page_alloc_sysctl_table[] = {
         |                                                           ^
   mm/page_alloc.c:6269:9: error: expected identifier or '(' before '{' token
    6269 |         {
         |         ^
   mm/page_alloc.c:6275:10: error: expected identifier or '(' before ',' token
    6275 |         },
         |          ^
   mm/page_alloc.c:6174:12: warning: 'lowmem_reserve_ratio_sysctl_handler' defined but not used [-Wunused-function]
    6174 | static int lowmem_reserve_ratio_sysctl_handler(const struct ctl_table *table,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/suspend.h:5,
                    from mm/page_alloc.c:28:
   include/linux/swap.h:590:12: warning: 'folio_alloc_swap' defined but not used [-Wunused-function]
     590 | static int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask)
         |            ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +6264 mm/page_alloc.c

  6227	
  6228	static const struct ctl_table page_alloc_sysctl_table[] = {
  6229		{
  6230			.procname	= "min_free_kbytes",
  6231			.data		= &min_free_kbytes,
  6232			.maxlen		= sizeof(min_free_kbytes),
  6233			.mode		= 0644,
  6234			.proc_handler	= min_free_kbytes_sysctl_handler,
  6235			.extra1		= SYSCTL_ZERO,
  6236		},
  6237		{
  6238			.procname	= "watermark_boost_factor",
  6239			.data		= &watermark_boost_factor,
  6240			.maxlen		= sizeof(watermark_boost_factor),
  6241			.mode		= 0644,
  6242			.proc_handler	= proc_dointvec_minmax,
  6243			.extra1		= SYSCTL_ZERO,
  6244		},
  6245		{
  6246			.procname	= "watermark_scale_factor",
  6247			.data		= &watermark_scale_factor,
  6248			.maxlen		= sizeof(watermark_scale_factor),
  6249			.mode		= 0644,
  6250			.proc_handler	= watermark_scale_factor_sysctl_handler,
  6251			.extra1		= SYSCTL_ONE,
  6252			.extra2		= SYSCTL_THREE_THOUSAND,
  6253		},
  6254		{
  6255			.procname	= "percpu_pagelist_high_fraction",
  6256			.data		= &percpu_pagelist_high_fraction,
  6257			.maxlen		= sizeof(percpu_pagelist_high_fraction),
  6258			.mode		= 0644,
  6259			.proc_handler	= percpu_pagelist_high_fraction_sysctl_handler,
  6260			.extra1		= SYSCTL_ZERO,
  6261		},
  6262			.procname	= "highatomic_reserve_ratio",
> 6263			.data		= &highatomic_reserve_ratio,
> 6264			.maxlen		= sizeof(highatomic_reserve_ratio),
> 6265			.mode		= 0644,
  6266			.proc_handler	= proc_dointvec_minmax,
  6267			.extra1		= SYSCTL_ZERO,
  6268		},
  6269		{
  6270			.procname	= "lowmem_reserve_ratio",
  6271			.data		= &sysctl_lowmem_reserve_ratio,
  6272			.maxlen		= sizeof(sysctl_lowmem_reserve_ratio),
  6273			.mode		= 0644,
  6274			.proc_handler	= lowmem_reserve_ratio_sysctl_handler,
  6275		},
  6276	#ifdef CONFIG_NUMA
  6277		{
  6278			.procname	= "numa_zonelist_order",
  6279			.data		= &numa_zonelist_order,
  6280			.maxlen		= NUMA_ZONELIST_ORDER_LEN,
  6281			.mode		= 0644,
  6282			.proc_handler	= numa_zonelist_order_handler,
  6283		},
  6284		{
  6285			.procname	= "min_unmapped_ratio",
  6286			.data		= &sysctl_min_unmapped_ratio,
  6287			.maxlen		= sizeof(sysctl_min_unmapped_ratio),
  6288			.mode		= 0644,
  6289			.proc_handler	= sysctl_min_unmapped_ratio_sysctl_handler,
  6290			.extra1		= SYSCTL_ZERO,
  6291			.extra2		= SYSCTL_ONE_HUNDRED,
  6292		},
  6293		{
  6294			.procname	= "min_slab_ratio",
  6295			.data		= &sysctl_min_slab_ratio,
  6296			.maxlen		= sizeof(sysctl_min_slab_ratio),
  6297			.mode		= 0644,
  6298			.proc_handler	= sysctl_min_slab_ratio_sysctl_handler,
  6299			.extra1		= SYSCTL_ZERO,
  6300			.extra2		= SYSCTL_ONE_HUNDRED,
  6301		},
  6302	#endif
  6303	};
  6304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


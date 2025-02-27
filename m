Return-Path: <linux-kernel+bounces-535622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C13E5A47543
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01E016EE34
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BA31FF618;
	Thu, 27 Feb 2025 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FN2ZrDA7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7A915666D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634593; cv=none; b=VNr8r7MpVBlVx8fg0p9jEIPtq38ZWfyKO8f+T1eDBlzfq2LpDW0AaPaoLbGSK4cmRmFH2iF9YOGrofO1i/wvdyk7yysSE9kL/C+IWAWdMJ722VHBpMfVnKbGFqXIQykmPkIkjGXbQdlbh/u2eoD2+18Hu8SvcHbHJpUdym5Gq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634593; c=relaxed/simple;
	bh=qycoDyCUUnRt1gaExP3+q5vKy6BHJkpQXoGJM1YDQCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOgedVjLjkkY3LZdlJeVwJ1j9X7npwCUYhitdD/gzaXEnlW2wVB+0pZqkYIw/huKRNkgJyyxQ59a/1uozjbTdRNi4nYs/UBpjqTBQqVapvxs0Z1zb1N8pUERncd0CuERAHYZzlNMtdu0L2yU7k1sFiRkslExszpNBBUC/uCEKGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FN2ZrDA7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740634592; x=1772170592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qycoDyCUUnRt1gaExP3+q5vKy6BHJkpQXoGJM1YDQCI=;
  b=FN2ZrDA7kgI8d/cAL2QMlluR9Jxw1WuO4ADJtWRv8EIct5B9+xwfj9/Z
   CpxKA3SWaTRNqVkk2reAlM5gx9ezCrYr6SKRKosyhkUSXY0o+SC2u4bs5
   OlllBI3OvkEHCRe7titFwIK2LS0r557Y4j0o3wK5AsnnIftG2qiRGG15v
   DAW+fUASAGkn2pY0n8wCuqD+GshKRl63kc0yKBAvqD6jkHaqs/qo/PvFv
   mOkoVgOMSN/ACwAw65rNmzwm1kDM6QtjvnfFzeDAa5wJDmDpheTs232Vg
   tuWrrZL9yfVdZzCWdOWeojeNVhyKvskOsvpAFa6tnkgK/pSPIaTJIx/c7
   A==;
X-CSE-ConnectionGUID: ZjyD/4PAQoW5spL79K/Vrg==
X-CSE-MsgGUID: xdmW5DSsQYGcDcF4hi+hhQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41530290"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41530290"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:36:31 -0800
X-CSE-ConnectionGUID: +vykHYAPTAWfDOyvQRSYwA==
X-CSE-MsgGUID: GhhMyq7sRECdG3AyF9xi9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="121932813"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 26 Feb 2025 21:36:28 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnWZO-000Cty-0L;
	Thu, 27 Feb 2025 05:36:26 +0000
Date: Thu, 27 Feb 2025 13:35:41 +0800
From: kernel test robot <lkp@intel.com>
To: zhongjinji@honor.com, akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, yuzhao@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rientjes@google.com, vbabka@suse.cz, zhongjinji@honor.com,
	yipengxiang@honor.com, liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH] mm/page_alloc: make the maximum number of highatomic
 pageblocks resizable
Message-ID: <202502271338.7VyyFcoF-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/zhongjinji-honor-com/mm-page_alloc-make-the-maximum-number-of-highatomic-pageblocks-resizable/20250226-121712
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250226024126.3718-1-zhongjinji%40honor.com
patch subject: [PATCH] mm/page_alloc: make the maximum number of highatomic pageblocks resizable
config: x86_64-buildonly-randconfig-003-20250227 (https://download.01.org/0day-ci/archive/20250227/202502271338.7VyyFcoF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502271338.7VyyFcoF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502271338.7VyyFcoF-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> mm/page_alloc.c:6262:17: error: field name not in record or union initializer
    6262 |                 .procname       = "highatomic_reserve_ratio",
         |                 ^
   mm/page_alloc.c:6262:17: note: (near initialization for 'page_alloc_sysctl_table')
>> mm/page_alloc.c:6262:35: error: invalid initializer
    6262 |                 .procname       = "highatomic_reserve_ratio",
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/page_alloc.c:6262:35: note: (near initialization for 'page_alloc_sysctl_table[4].<anonymous>')
   mm/page_alloc.c:6263:17: error: field name not in record or union initializer
    6263 |                 .data           = &highatomic_reserve_ratio,
         |                 ^
   mm/page_alloc.c:6263:17: note: (near initialization for 'page_alloc_sysctl_table')
   mm/page_alloc.c:6263:35: error: invalid initializer
    6263 |                 .data           = &highatomic_reserve_ratio,
         |                                   ^
   mm/page_alloc.c:6263:35: note: (near initialization for 'page_alloc_sysctl_table[5].<anonymous>')
   mm/page_alloc.c:6264:17: error: field name not in record or union initializer
    6264 |                 .maxlen         = sizeof(highatomic_reserve_ratio),
         |                 ^
   mm/page_alloc.c:6264:17: note: (near initialization for 'page_alloc_sysctl_table')
   mm/page_alloc.c:6264:35: error: invalid initializer
    6264 |                 .maxlen         = sizeof(highatomic_reserve_ratio),
         |                                   ^~~~~~
   mm/page_alloc.c:6264:35: note: (near initialization for 'page_alloc_sysctl_table[6].<anonymous>')
   mm/page_alloc.c:6265:17: error: field name not in record or union initializer
    6265 |                 .mode           = 0644,
         |                 ^
   mm/page_alloc.c:6265:17: note: (near initialization for 'page_alloc_sysctl_table')
   mm/page_alloc.c:6265:35: error: invalid initializer
    6265 |                 .mode           = 0644,
         |                                   ^~~~
   mm/page_alloc.c:6265:35: note: (near initialization for 'page_alloc_sysctl_table[7].<anonymous>')
   mm/page_alloc.c:6266:17: error: field name not in record or union initializer
    6266 |                 .proc_handler   = proc_dointvec_minmax,
         |                 ^
   mm/page_alloc.c:6266:17: note: (near initialization for 'page_alloc_sysctl_table')
   mm/page_alloc.c:6266:35: error: invalid initializer
    6266 |                 .proc_handler   = proc_dointvec_minmax,
         |                                   ^~~~~~~~~~~~~~~~~~~~
   mm/page_alloc.c:6266:35: note: (near initialization for 'page_alloc_sysctl_table[8].<anonymous>')
   mm/page_alloc.c:6267:17: error: field name not in record or union initializer
    6267 |                 .extra1         = SYSCTL_ZERO,
         |                 ^
   mm/page_alloc.c:6267:17: note: (near initialization for 'page_alloc_sysctl_table')
   In file included from include/linux/key.h:17,
                    from include/linux/cred.h:13,
                    from include/linux/sched/signal.h:10,
                    from include/linux/rcuwait.h:6,
                    from include/linux/mm.h:35,
                    from mm/page_alloc.c:19:
>> include/linux/sysctl.h:41:41: error: invalid initializer
      41 | #define SYSCTL_ZERO                     ((void *)&sysctl_vals[0])
         |                                         ^
   mm/page_alloc.c:6267:35: note: in expansion of macro 'SYSCTL_ZERO'
    6267 |                 .extra1         = SYSCTL_ZERO,
         |                                   ^~~~~~~~~~~
   include/linux/sysctl.h:41:41: note: (near initialization for 'page_alloc_sysctl_table[9].<anonymous>')
      41 | #define SYSCTL_ZERO                     ((void *)&sysctl_vals[0])
         |                                         ^
   mm/page_alloc.c:6267:35: note: in expansion of macro 'SYSCTL_ZERO'
    6267 |                 .extra1         = SYSCTL_ZERO,
         |                                   ^~~~~~~~~~~
>> mm/page_alloc.c:6228:59: warning: missing braces around initializer [-Wmissing-braces]
    6228 | static const struct ctl_table page_alloc_sysctl_table[] = {
         |                                                           ^
>> mm/page_alloc.c:6269:9: error: expected identifier or '(' before '{' token
    6269 |         {
         |         ^
   mm/page_alloc.c:6275:10: error: expected identifier or '(' before ',' token
    6275 |         },
         |          ^
>> mm/page_alloc.c:6174:12: warning: 'lowmem_reserve_ratio_sysctl_handler' defined but not used [-Wunused-function]
    6174 | static int lowmem_reserve_ratio_sysctl_handler(const struct ctl_table *table,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/suspend.h:5,
                    from mm/page_alloc.c:28:
   include/linux/swap.h:590:12: warning: 'folio_alloc_swap' defined but not used [-Wunused-function]
     590 | static int folio_alloc_swap(struct folio *folio, gfp_t gfp_mask)
         |            ^~~~~~~~~~~~~~~~


vim +6262 mm/page_alloc.c

  6164	
  6165	/*
  6166	 * lowmem_reserve_ratio_sysctl_handler - just a wrapper around
  6167	 *	proc_dointvec() so that we can call setup_per_zone_lowmem_reserve()
  6168	 *	whenever sysctl_lowmem_reserve_ratio changes.
  6169	 *
  6170	 * The reserve ratio obviously has absolutely no relation with the
  6171	 * minimum watermarks. The lowmem reserve ratio can only make sense
  6172	 * if in function of the boot time zone sizes.
  6173	 */
> 6174	static int lowmem_reserve_ratio_sysctl_handler(const struct ctl_table *table,
  6175			int write, void *buffer, size_t *length, loff_t *ppos)
  6176	{
  6177		int i;
  6178	
  6179		proc_dointvec_minmax(table, write, buffer, length, ppos);
  6180	
  6181		for (i = 0; i < MAX_NR_ZONES; i++) {
  6182			if (sysctl_lowmem_reserve_ratio[i] < 1)
  6183				sysctl_lowmem_reserve_ratio[i] = 0;
  6184		}
  6185	
  6186		setup_per_zone_lowmem_reserve();
  6187		return 0;
  6188	}
  6189	
  6190	/*
  6191	 * percpu_pagelist_high_fraction - changes the pcp->high for each zone on each
  6192	 * cpu. It is the fraction of total pages in each zone that a hot per cpu
  6193	 * pagelist can have before it gets flushed back to buddy allocator.
  6194	 */
  6195	static int percpu_pagelist_high_fraction_sysctl_handler(const struct ctl_table *table,
  6196			int write, void *buffer, size_t *length, loff_t *ppos)
  6197	{
  6198		struct zone *zone;
  6199		int old_percpu_pagelist_high_fraction;
  6200		int ret;
  6201	
  6202		mutex_lock(&pcp_batch_high_lock);
  6203		old_percpu_pagelist_high_fraction = percpu_pagelist_high_fraction;
  6204	
  6205		ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
  6206		if (!write || ret < 0)
  6207			goto out;
  6208	
  6209		/* Sanity checking to avoid pcp imbalance */
  6210		if (percpu_pagelist_high_fraction &&
  6211		    percpu_pagelist_high_fraction < MIN_PERCPU_PAGELIST_HIGH_FRACTION) {
  6212			percpu_pagelist_high_fraction = old_percpu_pagelist_high_fraction;
  6213			ret = -EINVAL;
  6214			goto out;
  6215		}
  6216	
  6217		/* No change? */
  6218		if (percpu_pagelist_high_fraction == old_percpu_pagelist_high_fraction)
  6219			goto out;
  6220	
  6221		for_each_populated_zone(zone)
  6222			zone_set_pageset_high_and_batch(zone, 0);
  6223	out:
  6224		mutex_unlock(&pcp_batch_high_lock);
  6225		return ret;
  6226	}
  6227	
> 6228	static const struct ctl_table page_alloc_sysctl_table[] = {
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
> 6262			.procname	= "highatomic_reserve_ratio",
  6263			.data		= &highatomic_reserve_ratio,
  6264			.maxlen		= sizeof(highatomic_reserve_ratio),
  6265			.mode		= 0644,
  6266			.proc_handler	= proc_dointvec_minmax,
  6267			.extra1		= SYSCTL_ZERO,
  6268		},
> 6269		{
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


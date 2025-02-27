Return-Path: <linux-kernel+bounces-535615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A490A47532
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386333AEE1C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BA61F9F5C;
	Thu, 27 Feb 2025 05:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CiNBxKT5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD33A1F5857
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633992; cv=none; b=Y5UcnhPxFuZDO4ShrVG6wcOuM6xwN4kxC9iTMcOOimeojl59wNliNdGjIPy+CGBhXYwvTdF21xcYK6figtfkksHoinKN/WH8fWy5w0R8ZIDVQwlIoNV0iQDCF4EWI25Bc0EeOE6ZGgAPm2CAeCENPx8+DpGL8EVhTAOU24p0KaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633992; c=relaxed/simple;
	bh=QsLOmOWrH2QCKP0gkojxfG4ZAlKdqpTNrpKXybsyags=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB/GXrCsISB7QKM6G1Kv0vh5WMpcdITx9chbtWL2EyRlUhfEmimlHwwWqw7z6mZD6tv4va3pN6iWABpUaFIjWyU5LCDd0xSYpJbTWFloNNYxeYwMvaFx0MnRjn77ZRz26Py39genrcqXvte568HWWdsoP4TtLwJD9E34tia71sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CiNBxKT5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740633991; x=1772169991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QsLOmOWrH2QCKP0gkojxfG4ZAlKdqpTNrpKXybsyags=;
  b=CiNBxKT5wqYPrKOqTvkJgU0asbGgjueLbjhI7y00snQzpifdPPFWZ9xq
   EM1HWaAQGd6fxsAgzToM9SFxxfkRs9JUaRLqPA2M1zLSvEGTZcMPkuDzm
   qgwmGn+daOzNtpjuX6ftNLRbdNR1wKoL2gSZ3TL4j+iYIaIDfieNkrHQx
   PU0FwcHstnbS6iPA32XkpwefsE3aqHaaB2Mtt5LjqBTltNTdCmuKGgYqK
   qBuulnN3B9liRsEiQZVOQvz9rTrcCuJAvALv1xMxF/uajlOa2bKAP2G7M
   PZw2dODmsTAZMCuv3GtZgPClKATSUPkx0lbn36Keh6a0TVpJluZWOxqmZ
   w==;
X-CSE-ConnectionGUID: yGR2jzkpTW6Wrux6WfTDkw==
X-CSE-MsgGUID: iKm330sRSu2wVZk4LuOSZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="41639213"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41639213"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 21:26:30 -0800
X-CSE-ConnectionGUID: 8YA5gkAtSqucOs2B0u928A==
X-CSE-MsgGUID: 9wyp9ikvRE+TXckO1c0Wuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="117409621"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 26 Feb 2025 21:26:28 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tnWPh-000Ct8-0F;
	Thu, 27 Feb 2025 05:26:25 +0000
Date: Thu, 27 Feb 2025 13:25:26 +0800
From: kernel test robot <lkp@intel.com>
To: zhongjinji@honor.com, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, yuzhao@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rientjes@google.com, vbabka@suse.cz, zhongjinji@honor.com,
	yipengxiang@honor.com, liulu.liu@honor.com, feng.han@honor.com
Subject: Re: [PATCH] mm/page_alloc: make the maximum number of highatomic
 pageblocks resizable
Message-ID: <202502271250.KUfFnxnl-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20250227 (https://download.01.org/0day-ci/archive/20250227/202502271250.KUfFnxnl-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250227/202502271250.KUfFnxnl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502271250.KUfFnxnl-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/page_alloc.c:19:
   In file included from include/linux/mm.h:2302:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/page_alloc.c:44:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
   mm/page_alloc.c:2854:2: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
    2854 |         __count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:139:34: note: expanded from macro '__count_zid_vm_events'
     139 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   mm/page_alloc.c:2971:3: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
    2971 |                 __count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:139:34: note: expanded from macro '__count_zid_vm_events'
     139 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   mm/page_alloc.c:4743:2: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
    4743 |         __count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:139:34: note: expanded from macro '__count_zid_vm_events'
     139 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
>> mm/page_alloc.c:6262:3: error: field designator cannot initialize a non-struct, non-union type 'const struct ctl_table[]'
    6262 |                 .procname       = "highatomic_reserve_ratio",
         |                 ^
   mm/page_alloc.c:6263:3: error: field designator cannot initialize a non-struct, non-union type 'const struct ctl_table[]'
    6263 |                 .data           = &highatomic_reserve_ratio,
         |                 ^
   mm/page_alloc.c:6264:3: error: field designator cannot initialize a non-struct, non-union type 'const struct ctl_table[]'
    6264 |                 .maxlen         = sizeof(highatomic_reserve_ratio),
         |                 ^
   mm/page_alloc.c:6265:3: error: field designator cannot initialize a non-struct, non-union type 'const struct ctl_table[]'
    6265 |                 .mode           = 0644,
         |                 ^
   mm/page_alloc.c:6266:3: error: field designator cannot initialize a non-struct, non-union type 'const struct ctl_table[]'
    6266 |                 .proc_handler   = proc_dointvec_minmax,
         |                 ^
   mm/page_alloc.c:6267:3: error: field designator cannot initialize a non-struct, non-union type 'const struct ctl_table[]'
    6267 |                 .extra1         = SYSCTL_ZERO,
         |                 ^
>> mm/page_alloc.c:6268:3: error: expected ';' at end of declaration
    6268 |         },
         |          ^
         |          ;
>> mm/page_alloc.c:6269:2: error: expected identifier or '('
    6269 |         {
         |         ^
>> mm/page_alloc.c:6303:1: error: extraneous closing brace ('}')
    6303 | };
         | ^
   6 warnings and 9 errors generated.


vim +6262 mm/page_alloc.c

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
> 6262			.procname	= "highatomic_reserve_ratio",
  6263			.data		= &highatomic_reserve_ratio,
  6264			.maxlen		= sizeof(highatomic_reserve_ratio),
  6265			.mode		= 0644,
  6266			.proc_handler	= proc_dointvec_minmax,
  6267			.extra1		= SYSCTL_ZERO,
> 6268		},
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
> 6303	};
  6304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-539063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575DBA4A071
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE2B1898FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3F981724;
	Fri, 28 Feb 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHXY9t1a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75C641C63
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740763938; cv=none; b=KQ2r0zlKL61miwy73zJl7ofFm5xIhUOPCYfb397PnmB12xfrWj35q3RhlZyDUu6jUwOdJ2VjcFG7bLxUi0JEKbEaq0RWbLovx1w3C3fDcuXihpS4LRcQ0sOXMv3/t/ltRwgF5ZV5qVxpI0tFzeilhT3HjM8Z1BlTIF6OJ/AtnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740763938; c=relaxed/simple;
	bh=0X35A1fZOS0POJ7BKgK0KyaRi//1aHcM0Zz6yyZC8zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqEuv3TXc4Q59gh8lePD2Xamxdhq3V5kPLjwHkXCHO5RmDdzjcGTJLysHCgfS6BIQCux96h18HtXQJZN6BxjupwMM0ucjUih9N2rS9HHyRw6l6Ql9UYhBWMOamJiX5Mj0kLP9cqhgq1bb5oWCHWFYEyD8r7JqIb1NKJvpZfkZrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHXY9t1a; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740763937; x=1772299937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0X35A1fZOS0POJ7BKgK0KyaRi//1aHcM0Zz6yyZC8zA=;
  b=nHXY9t1amLCmfYXearwBMqrNh7QcTwqkWJdubbPksLGH0ctJkpoulKbo
   EmHpF2BtOhChlZpvraEaxhVmqgXuG8xBz4Qs3IeVTnxbT4YPrwA33LacZ
   ZD4d+aCexBZMFMGDACoDUyWoattIAxqjUx6Pq5jiTsPzaVZRPx5WhT/SG
   5yk6HjJwVLP64sA/arzXM5+WLxFB7skmKUM2unBLy6x4WFAEAs+J540R6
   37PtOwVhdk5T5aaWJusxhFHqyozeZTMH4GTYtDLJaFY4+yj0NT5fLYsFi
   m7C50xRhRd6FfKzplgyqfy7aPmQvqVg2MdDkVXmFnb83zq53FgiAXByRl
   A==;
X-CSE-ConnectionGUID: XXwMRCKjTYKGUDOAhMpSgg==
X-CSE-MsgGUID: IARj9Di7T9m2pLTqz7cB1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="59239411"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="59239411"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 09:32:08 -0800
X-CSE-ConnectionGUID: ShrOUN/VSLW/JqStEV+a/g==
X-CSE-MsgGUID: s5M4XoM+ScKozAGi7ZpenQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148305333"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 09:32:06 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1to4D7-000FHS-0N;
	Fri, 28 Feb 2025 17:31:47 +0000
Date: Sat, 1 Mar 2025 01:31:30 +0800
From: kernel test robot <lkp@intel.com>
To: Brendan Jackman <jackmanb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
	Brendan Jackman <jackmanb@google.com>
Subject: Re: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type
 change
Message-ID: <202503010129.rJvGqZN1-lkp@intel.com>
References: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>

Hi Brendan,

kernel test robot noticed the following build errors:

[auto build test ERROR on d58172d128acbafa2295aa17cc96e28260da9a86]

url:    https://github.com/intel-lab-lkp/linux/commits/Brendan-Jackman/mm-page_alloc-Add-lockdep-assertion-for-pageblock-type-change/20250228-002107
base:   d58172d128acbafa2295aa17cc96e28260da9a86
patch link:    https://lore.kernel.org/r/20250227-pageblock-lockdep-v1-1-3701efb331bb%40google.com
patch subject: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type change
config: x86_64-buildonly-randconfig-002-20250228 (https://download.01.org/0day-ci/archive/20250301/202503010129.rJvGqZN1-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503010129.rJvGqZN1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503010129.rJvGqZN1-lkp@intel.com/

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
>> mm/page_alloc.c:421:3: error: call to undeclared function 'in_mem_hotplug'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     421 |                 in_mem_hotplug() ||
         |                 ^
   mm/page_alloc.c:2857:2: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
    2857 |         __count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:139:34: note: expanded from macro '__count_zid_vm_events'
     139 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   mm/page_alloc.c:2974:3: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
    2974 |                 __count_zid_vm_events(PGALLOC, page_zonenum(page), 1 << order);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:139:34: note: expanded from macro '__count_zid_vm_events'
     139 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   mm/page_alloc.c:4745:2: warning: arithmetic between different enumeration types ('enum vm_event_item' and 'enum zone_type') [-Wenum-enum-conversion]
    4745 |         __count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:139:34: note: expanded from macro '__count_zid_vm_events'
     139 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ~~~~~~~~~~~~~ ^ ~~~~~~~~~~~
   6 warnings and 1 error generated.


vim +/in_mem_hotplug +421 mm/page_alloc.c

   417	
   418	void set_pageblock_migratetype(struct page *page, int migratetype)
   419	{
   420		lockdep_assert_once(system_state == SYSTEM_BOOTING ||
 > 421			in_mem_hotplug() ||
   422			lockdep_is_held(&page_zone(page)->lock));
   423	
   424		if (unlikely(page_group_by_mobility_disabled &&
   425			     migratetype < MIGRATE_PCPTYPES))
   426			migratetype = MIGRATE_UNMOVABLE;
   427	
   428		set_pfnblock_flags_mask(page, (unsigned long)migratetype,
   429					page_to_pfn(page), MIGRATETYPE_MASK);
   430	}
   431	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-347132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1908998CE4D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E832B22051
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2644194A5B;
	Wed,  2 Oct 2024 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRDniC6A"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077F246BA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856068; cv=none; b=GdEy3lmFnAcSKsduQQ7+Yz5P/PJPl5DFwXj0eyAW/MvQPn+PrbGLzVwJ3zcr1ppaFdeWfBECSUMGu/BeXKniau/SAxBhETnuZw7Cl8s1WWkpeVqzbWuYnjf9UNzJbwC1DfxnT4gLLwOBJwdhnziM9iE8ffPMEjNX7sOebyyaI/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856068; c=relaxed/simple;
	bh=GnpLxmCrXFnFkyfp0/uRZ4evunqA7x3FwR9mDDGH6B8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cd/C82/zA5R6f4fJGE73Q2bmpGd8ZAKtTgE1lNLMbA+T/5slLxsz1KVrdjcXhDl3n7Y7pdX9mAh4NSQhwnq3lLe4/7aR2EfNC7CXRVsKfyAB4e5VevlIUHFnCDhVuR+wMuKA1SRDVUquVg8gp82gd3mOUYATu2iDTj1SSLaiG50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRDniC6A; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727856067; x=1759392067;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GnpLxmCrXFnFkyfp0/uRZ4evunqA7x3FwR9mDDGH6B8=;
  b=JRDniC6AOZbESoOq9cE0te4jGnPtfGb5rIveT4jwkbl3eorwATd5VVB5
   DiyXYzf5Vazt18450lkVTmPg8BFEYu61iPJA0nJ7mOOtiNgyhZ3leU84R
   +LNEeDuCoqQU60JoyWbusfD7daLagSfr6Rg7OjgNwb0xxr8jl9L5r2OEA
   YLo4aDchnEiI8k0/sWzEPJ/U00YqRlNmZr6STdX4tfLTnZnIm00hl/B65
   toSBjZtDf6hh0dR34ghNH1luuHPcfKoJ7xbgWP43i0/qsVvpNh5hzrMtK
   VFmo6UYr91UQ4M/ows8ktmCSzMPh/JFPbbe2phS1ZNFkpI0WBK+AIMtD8
   A==;
X-CSE-ConnectionGUID: TzopWRm2SjmfxQGU+bvWSQ==
X-CSE-MsgGUID: nSjotyPkR7eLtuIZzIzdpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="52418445"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="52418445"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 01:01:06 -0700
X-CSE-ConnectionGUID: InD36ZHaQWKgOtt6k2hkCA==
X-CSE-MsgGUID: A3OesCW2S2aX4/6hvFaecA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="74240141"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 02 Oct 2024 01:01:04 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svuIA-000RmW-0K;
	Wed, 02 Oct 2024 08:01:02 +0000
Date: Wed, 2 Oct 2024 16:00:17 +0800
From: kernel test robot <lkp@intel.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/zswap.c:744:52: error: 'struct zswap_lruvec_state' has no member
 named 'nr_disk_swapins'
Message-ID: <202410021530.DnNbPqfN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: e31c38e037621c445bb4393fd77e0a76e6e0899a zswap: implement a second chance algorithm for dynamic zswap shrinker
date:   4 weeks ago
config: x86_64-randconfig-r133-20240215 (https://download.01.org/0day-ci/archive/20241002/202410021530.DnNbPqfN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410021530.DnNbPqfN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410021530.DnNbPqfN-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/zswap.c:97:33: error: 'CONFIG_ZSWAP_COMPRESSOR_DEFAULT' undeclared here (not in a function)
      97 | static char *zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/zswap.c:109:33: error: 'CONFIG_ZSWAP_ZPOOL_DEFAULT' undeclared here (not in a function); did you mean 'CONFIG_NR_CPUS_DEFAULT'?
     109 | static char *zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                 CONFIG_NR_CPUS_DEFAULT
   mm/zswap.c:132:6: error: redefinition of 'zswap_is_enabled'
     132 | bool zswap_is_enabled(void)
         |      ^~~~~~~~~~~~~~~~
   In file included from include/linux/mmzone.h:25,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from mm/zswap.c:16:
   include/linux/zswap.h:62:20: note: previous definition of 'zswap_is_enabled' with type 'bool(void)' {aka '_Bool(void)'}
      62 | static inline bool zswap_is_enabled(void)
         |                    ^~~~~~~~~~~~~~~~
   mm/zswap.c:137:6: error: redefinition of 'zswap_never_enabled'
     137 | bool zswap_never_enabled(void)
         |      ^~~~~~~~~~~~~~~~~~~
   include/linux/zswap.h:67:20: note: previous definition of 'zswap_never_enabled' with type 'bool(void)' {aka '_Bool(void)'}
      67 | static inline bool zswap_never_enabled(void)
         |                    ^~~~~~~~~~~~~~~~~~~
   mm/zswap.c: In function 'swap_zswap_tree':
   mm/zswap.c:244:20: error: 'SWAP_ADDRESS_SPACE_SHIFT' undeclared (first use in this function)
     244 |                 >> SWAP_ADDRESS_SPACE_SHIFT];
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   mm/zswap.c:244:20: note: each undeclared identifier is reported only once for each function it appears in
   mm/zswap.c: At top level:
   mm/zswap.c:489:15: warning: no previous prototype for 'zswap_total_pages' [-Wmissing-prototypes]
     489 | unsigned long zswap_total_pages(void)
         |               ^~~~~~~~~~~~~~~~~
   mm/zswap.c:742:6: error: redefinition of 'zswap_lruvec_state_init'
     742 | void zswap_lruvec_state_init(struct lruvec *lruvec)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/zswap.h:59:20: note: previous definition of 'zswap_lruvec_state_init' with type 'void(struct lruvec *)'
      59 | static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   mm/zswap.c: In function 'zswap_lruvec_state_init':
>> mm/zswap.c:744:52: error: 'struct zswap_lruvec_state' has no member named 'nr_disk_swapins'
     744 |         atomic_long_set(&lruvec->zswap_lruvec_state.nr_disk_swapins, 0);
         |                                                    ^
   mm/zswap.c: At top level:
   mm/zswap.c:747:6: error: redefinition of 'zswap_folio_swapin'
     747 | void zswap_folio_swapin(struct folio *folio)
         |      ^~~~~~~~~~~~~~~~~~
   include/linux/zswap.h:60:20: note: previous definition of 'zswap_folio_swapin' with type 'void(struct folio *)'
      60 | static inline void zswap_folio_swapin(struct folio *folio) {}
         |                    ^~~~~~~~~~~~~~~~~~
   mm/zswap.c: In function 'zswap_folio_swapin':
   mm/zswap.c:753:60: error: 'struct zswap_lruvec_state' has no member named 'nr_disk_swapins'
     753 |                 atomic_long_inc(&lruvec->zswap_lruvec_state.nr_disk_swapins);
         |                                                            ^
   mm/zswap.c: At top level:
   mm/zswap.c:767:6: error: redefinition of 'zswap_memcg_offline_cleanup'
     767 | void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/zswap.h:58:20: note: previous definition of 'zswap_memcg_offline_cleanup' with type 'void(struct mem_cgroup *)'
      58 | static inline void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/zswap.c: In function 'zswap_writeback_entry':
   mm/zswap.c:1029:17: error: implicit declaration of function '__read_swap_cache_async' [-Werror=implicit-function-declaration]
    1029 |         folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   mm/zswap.c:1029:15: warning: assignment to 'struct folio *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1029 |         folio = __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
         |               ^
   mm/zswap.c:1065:24: error: 'ZSWPWB' undeclared (first use in this function)
    1065 |         count_vm_event(ZSWPWB);
         |                        ^~~~~~
   mm/zswap.c:1078:9: error: implicit declaration of function '__swap_writepage'; did you mean 'swap_writepage'? [-Werror=implicit-function-declaration]
    1078 |         __swap_writepage(folio, &wbc);
         |         ^~~~~~~~~~~~~~~~
         |         swap_writepage
   mm/zswap.c: In function 'zswap_shrinker_count':
   mm/zswap.c:1218:44: error: 'struct zswap_lruvec_state' has no member named 'nr_disk_swapins'
    1218 |                 &lruvec->zswap_lruvec_state.nr_disk_swapins;
         |                                            ^
   mm/zswap.c: At top level:
   mm/zswap.c:1458:6: error: redefinition of 'zswap_store'
    1458 | bool zswap_store(struct folio *folio)
         |      ^~~~~~~~~~~
   include/linux/zswap.h:42:20: note: previous definition of 'zswap_store' with type 'bool(struct folio *)' {aka '_Bool(struct folio *)'}
      42 | static inline bool zswap_store(struct folio *folio)
         |                    ^~~~~~~~~~~
   mm/zswap.c: In function 'zswap_store':
   mm/zswap.c:1547:42: error: 'ZSWPOUT' undeclared (first use in this function); did you mean 'PSWPOUT'?
    1547 |                 count_objcg_event(objcg, ZSWPOUT);
         |                                          ^~~~~~~
         |                                          PSWPOUT
   mm/zswap.c: At top level:
   mm/zswap.c:1597:6: error: redefinition of 'zswap_load'
    1597 | bool zswap_load(struct folio *folio)
         |      ^~~~~~~~~~
   include/linux/zswap.h:47:20: note: previous definition of 'zswap_load' with type 'bool(struct folio *)' {aka '_Bool(struct folio *)'}
      47 | static inline bool zswap_load(struct folio *folio)
         |                    ^~~~~~~~~~
   mm/zswap.c: In function 'zswap_load':
   mm/zswap.c:1646:24: error: 'ZSWPIN' undeclared (first use in this function); did you mean 'PSWPIN'?
    1646 |         count_vm_event(ZSWPIN);
         |                        ^~~~~~
         |                        PSWPIN
   mm/zswap.c: At top level:
   mm/zswap.c:1659:6: error: redefinition of 'zswap_invalidate'
    1659 | void zswap_invalidate(swp_entry_t swp)
         |      ^~~~~~~~~~~~~~~~
   include/linux/zswap.h:52:20: note: previous definition of 'zswap_invalidate' with type 'void(swp_entry_t)'
      52 | static inline void zswap_invalidate(swp_entry_t swp) {}
         |                    ^~~~~~~~~~~~~~~~
   mm/zswap.c:1670:5: error: redefinition of 'zswap_swapon'
    1670 | int zswap_swapon(int type, unsigned long nr_pages)
         |     ^~~~~~~~~~~~
   include/linux/zswap.h:53:19: note: previous definition of 'zswap_swapon' with type 'int(int,  long unsigned int)'
      53 | static inline int zswap_swapon(int type, unsigned long nr_pages)
         |                   ^~~~~~~~~~~~
   In file included from include/vdso/const.h:5,
                    from include/linux/const.h:4,
                    from include/linux/list.h:9,
                    from include/linux/module.h:12:
   mm/zswap.c: In function 'zswap_swapon':
   mm/zswap.c:1675:37: error: 'SWAP_ADDRESS_SPACE_PAGES' undeclared (first use in this function)
    1675 |         nr = DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/const.h:34:46: note: in definition of macro '__KERNEL_DIV_ROUND_UP'
      34 | #define __KERNEL_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
         |                                              ^
   mm/zswap.c:1675:14: note: in expansion of macro 'DIV_ROUND_UP'
    1675 |         nr = DIV_ROUND_UP(nr_pages, SWAP_ADDRESS_SPACE_PAGES);
         |              ^~~~~~~~~~~~
   mm/zswap.c: At top level:
   mm/zswap.c:1690:6: error: redefinition of 'zswap_swapoff'
    1690 | void zswap_swapoff(int type)
         |      ^~~~~~~~~~~~~
   include/linux/zswap.h:57:20: note: previous definition of 'zswap_swapoff' with type 'void(int)'
      57 | static inline void zswap_swapoff(int type) {}
         |                    ^~~~~~~~~~~~~
   mm/zswap.c: In function 'swap_zswap_tree':
   mm/zswap.c:245:1: warning: control reaches end of non-void function [-Wreturn-type]
     245 | }
         | ^


vim +744 mm/zswap.c

   741	
   742	void zswap_lruvec_state_init(struct lruvec *lruvec)
   743	{
 > 744		atomic_long_set(&lruvec->zswap_lruvec_state.nr_disk_swapins, 0);
   745	}
   746	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


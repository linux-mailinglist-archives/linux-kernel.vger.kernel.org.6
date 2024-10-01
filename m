Return-Path: <linux-kernel+bounces-346476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A911398C51B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65ACB28464E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658311CC8B5;
	Tue,  1 Oct 2024 18:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcWo7q1s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6B81CC882
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806177; cv=none; b=YRUjf3zzgrhEhjJjgc4r3bYkB9fUMT1Qz9jv/ZWxzYl8Wt5G9bJ1g2KS5HUAa3KUAc8+kWWkpW1QA5U8Zedbp+GQGj+emXUm/q7iOChIsSwhjW74DfKtRE+d0VUje5pH4Yn+OPE7SOWjLNUibB5r8Rv7szX/JmahVeAsa0zE89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806177; c=relaxed/simple;
	bh=zlvfxo2qEOrFbWbhqWeJjndEEma3s30KJa0Jkwvhvns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mhoz9NvRs07EzV574/Vlv9xJ6BVTbvyaxy/fAeU+5mwAaZ0+4QFdTGhbUg6znQgxt47BA4BNYObTtt4bse0hnvxg2fNx3NzVfxF+oWIglTqeyR+39etqyyIPelk0+ME0XRXQB7dOdachAavvfhNDm1rmFchApjjSG2seabvgY2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcWo7q1s; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727806175; x=1759342175;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zlvfxo2qEOrFbWbhqWeJjndEEma3s30KJa0Jkwvhvns=;
  b=hcWo7q1swaPh8wPMYjCkBwNEY0D+Nx6svYs7RsUt0PmVUisufCbgcl4J
   7Yen10jJUTZYxkKd/XkcD5fR/j+8UTvosdMs68Ov7aIc/nTk+caiUzyWU
   cr9GSlzZvzQ0qryYfsl8B2atR2EtkBhYt8Ch/t/soV5I0zQBg8af8g2SP
   wKNB51Pfk84pEzqA5sKr4P3HgwQt06w5W4vX+jkfv07IAgm9DxoRinkuB
   hONzfAqPa4yv8ROYzC7I+muxn62a3/IWJZbg4R8jJQY7rTtV6Br52X/Bu
   Mv4TnvYIfy6Zk4FcQcjOdBDzrbGX7Gv4xjBHrY3eeRLJdTv24505COJnh
   A==;
X-CSE-ConnectionGUID: tBUIAKLnS5CD5m1r3cskWw==
X-CSE-MsgGUID: xbhmj38MR4GJQ/CW2i4uoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="38088750"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="38088750"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 11:09:35 -0700
X-CSE-ConnectionGUID: Wno2GgUeRhi4Bjfjg5qdhA==
X-CSE-MsgGUID: cQFj+qV+SpGCdcj4wba3Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73633196"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 01 Oct 2024 11:09:33 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svhJS-000R21-2X;
	Tue, 01 Oct 2024 18:09:30 +0000
Date: Wed, 2 Oct 2024 02:09:06 +0800
From: kernel test robot <lkp@intel.com>
To: SeongJae Park <sj@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/damon/reclaim.c:252:15: error: implicit declaration of function
 'damon_commit_ctx'
Message-ID: <202410020227.oOh0SBIj-lkp@intel.com>
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
commit: 11ddcfc257a3e8d7b13b42148ee7e783f4876da4 mm/damon/reclaim: use damon_commit_ctx()
date:   3 months ago
config: x86_64-randconfig-001-20231120 (https://download.01.org/0day-ci/archive/20241002/202410020227.oOh0SBIj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020227.oOh0SBIj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020227.oOh0SBIj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/sched.h:38,
                    from include/linux/cgroup.h:12,
                    from include/linux/memcontrol.h:13,
                    from include/linux/damon.h:11,
                    from mm/damon/reclaim.c:10:
   include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
      19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:2890:5: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
    2890 | #if USE_SPLIT_PTE_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:19:45: warning: "CONFIG_SPLIT_PTLOCK_CPUS" is not defined, evaluates to 0 [-Wundef]
      19 | #define USE_SPLIT_PTE_PTLOCKS   (NR_CPUS >= CONFIG_SPLIT_PTLOCK_CPUS)
         |                                             ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mm_types_task.h:20:34: note: in expansion of macro 'USE_SPLIT_PTE_PTLOCKS'
      20 | #define USE_SPLIT_PMD_PTLOCKS   (USE_SPLIT_PTE_PTLOCKS && \
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   include/linux/mm.h:3012:5: note: in expansion of macro 'USE_SPLIT_PMD_PTLOCKS'
    3012 | #if USE_SPLIT_PMD_PTLOCKS
         |     ^~~~~~~~~~~~~~~~~~~~~
   mm/damon/reclaim.c: In function 'damon_reclaim_new_scheme':
   mm/damon/reclaim.c:171:16: error: implicit declaration of function 'damon_new_scheme'; did you mean 'damon_for_each_scheme'? [-Werror=implicit-function-declaration]
     171 |         return damon_new_scheme(
         |                ^~~~~~~~~~~~~~~~
         |                damon_for_each_scheme
   mm/damon/reclaim.c:171:16: warning: returning 'int' from a function with return type 'struct damos *' makes pointer from integer without a cast [-Wint-conversion]
     171 |         return damon_new_scheme(
         |                ^~~~~~~~~~~~~~~~~
     172 |                         &pattern,
         |                         ~~~~~~~~~
     173 |                         /* page out those, as soon as found */
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     174 |                         DAMOS_PAGEOUT,
         |                         ~~~~~~~~~~~~~~
     175 |                         /* for each aggregation interval */
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     176 |                         0,
         |                         ~~
     177 |                         /* under the quota. */
         |                         ~~~~~~~~~~~~~~~~~~~~~~
     178 |                         &damon_reclaim_quota,
         |                         ~~~~~~~~~~~~~~~~~~~~~
     179 |                         /* (De)activate this according to the watermarks. */
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     180 |                         &damon_reclaim_wmarks,
         |                         ~~~~~~~~~~~~~~~~~~~~~~
     181 |                         NUMA_NO_NODE);
         |                         ~~~~~~~~~~~~~
   mm/damon/reclaim.c: In function 'damon_reclaim_apply_parameters':
   mm/damon/reclaim.c:209:15: error: implicit declaration of function 'damon_set_attrs' [-Werror=implicit-function-declaration]
     209 |         err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
         |               ^~~~~~~~~~~~~~~
   mm/damon/reclaim.c:222:9: error: implicit declaration of function 'damon_set_schemes' [-Werror=implicit-function-declaration]
     222 |         damon_set_schemes(ctx, &scheme, 1);
         |         ^~~~~~~~~~~~~~~~~
   mm/damon/reclaim.c:225:24: error: implicit declaration of function 'damos_new_quota_goal'; did you mean 'damos_for_each_quota_goal'? [-Werror=implicit-function-declaration]
     225 |                 goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
         |                        ^~~~~~~~~~~~~~~~~~~~
         |                        damos_for_each_quota_goal
   mm/damon/reclaim.c:225:22: warning: assignment to 'struct damos_quota_goal *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     225 |                 goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
         |                      ^
   mm/damon/reclaim.c:229:17: error: implicit declaration of function 'damos_add_quota_goal'; did you mean 'damos_for_each_quota_goal'? [-Werror=implicit-function-declaration]
     229 |                 damos_add_quota_goal(&scheme->quota, goal);
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 damos_for_each_quota_goal
   mm/damon/reclaim.c:233:22: warning: assignment to 'struct damos_quota_goal *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     233 |                 goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
         |                      ^
   mm/damon/reclaim.c:241:26: error: implicit declaration of function 'damos_new_filter'; did you mean 'damos_for_each_filter'? [-Werror=implicit-function-declaration]
     241 |                 filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
         |                          ^~~~~~~~~~~~~~~~
         |                          damos_for_each_filter
   mm/damon/reclaim.c:241:24: warning: assignment to 'struct damos_filter *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     241 |                 filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
         |                        ^
   mm/damon/reclaim.c:244:17: error: implicit declaration of function 'damos_add_filter'; did you mean 'damos_for_each_filter'? [-Werror=implicit-function-declaration]
     244 |                 damos_add_filter(scheme, filter);
         |                 ^~~~~~~~~~~~~~~~
         |                 damos_for_each_filter
   mm/damon/reclaim.c:247:15: error: implicit declaration of function 'damon_set_region_biggest_system_ram_default' [-Werror=implicit-function-declaration]
     247 |         err = damon_set_region_biggest_system_ram_default(param_target,
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/damon/reclaim.c:252:15: error: implicit declaration of function 'damon_commit_ctx' [-Werror=implicit-function-declaration]
     252 |         err = damon_commit_ctx(ctx, param_ctx);
         |               ^~~~~~~~~~~~~~~~
>> mm/damon/reclaim.c:254:9: error: implicit declaration of function 'damon_destroy_ctx'; did you mean 'mm_destroy_cid'? [-Werror=implicit-function-declaration]
     254 |         damon_destroy_ctx(param_ctx);
         |         ^~~~~~~~~~~~~~~~~
         |         mm_destroy_cid
   mm/damon/reclaim.c: In function 'damon_reclaim_turn':
   mm/damon/reclaim.c:263:23: error: implicit declaration of function 'damon_stop' [-Werror=implicit-function-declaration]
     263 |                 err = damon_stop(&ctx, 1);
         |                       ^~~~~~~~~~
   mm/damon/reclaim.c:273:15: error: implicit declaration of function 'damon_start' [-Werror=implicit-function-declaration]
     273 |         err = damon_start(&ctx, 1, true);
         |               ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/damon_commit_ctx +252 mm/damon/reclaim.c

   195	
   196	static int damon_reclaim_apply_parameters(void)
   197	{
   198		struct damon_ctx *param_ctx;
   199		struct damon_target *param_target;
   200		struct damos *scheme, *old_scheme;
   201		struct damos_quota_goal *goal;
   202		struct damos_filter *filter;
   203		int err;
   204	
   205		err = damon_modules_new_paddr_ctx_target(&param_ctx, &param_target);
   206		if (err)
   207			return err;
   208	
   209		err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
   210		if (err)
   211			goto out;
   212	
   213		err = -ENOMEM;
   214		scheme = damon_reclaim_new_scheme();
   215		if (!scheme)
   216			goto out;
   217		if (!list_empty(&ctx->schemes)) {
   218			damon_for_each_scheme(old_scheme, ctx)
   219				damon_reclaim_copy_quota_status(&scheme->quota,
   220						&old_scheme->quota);
   221		}
   222		damon_set_schemes(ctx, &scheme, 1);
   223	
   224		if (quota_mem_pressure_us) {
   225			goal = damos_new_quota_goal(DAMOS_QUOTA_SOME_MEM_PSI_US,
   226					quota_mem_pressure_us);
   227			if (!goal)
   228				goto out;
   229			damos_add_quota_goal(&scheme->quota, goal);
   230		}
   231	
   232		if (quota_autotune_feedback) {
   233			goal = damos_new_quota_goal(DAMOS_QUOTA_USER_INPUT, 10000);
   234			if (!goal)
   235				goto out;
   236			goal->current_value = quota_autotune_feedback;
   237			damos_add_quota_goal(&scheme->quota, goal);
   238		}
   239	
   240		if (skip_anon) {
   241			filter = damos_new_filter(DAMOS_FILTER_TYPE_ANON, true);
   242			if (!filter)
   243				goto out;
   244			damos_add_filter(scheme, filter);
   245		}
   246	
   247		err = damon_set_region_biggest_system_ram_default(param_target,
   248						&monitor_region_start,
   249						&monitor_region_end);
   250		if (err)
   251			goto out;
 > 252		err = damon_commit_ctx(ctx, param_ctx);
   253	out:
 > 254		damon_destroy_ctx(param_ctx);
   255		return err;
   256	}
   257	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


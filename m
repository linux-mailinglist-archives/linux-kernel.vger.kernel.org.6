Return-Path: <linux-kernel+bounces-551111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFDAA56852
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8629D7AA55A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0F2192EB;
	Fri,  7 Mar 2025 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JVp6f/CY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1626421A433
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351969; cv=none; b=h8Ggagi+FVISpuMoAH7/KD86lTaUYOMSFIjWT6WFS1iFsVsArhod11j1ZnkCsjzSqc7TzpppKMRV3nOqqHMKeFiqq4VxwqkU9Oare1LYKq42dRAGcPzqVgVsgQXLaQigSi16gE7MvjFBGzA5mG5lIu8d7YfZA8QjcFM+YP9ZS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351969; c=relaxed/simple;
	bh=KUe9SSJz9ISvQAEPHqlR4strR/gMPqHS0mOsCVaZh5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFtuQuHC1s5Sh7C1lGF2BA1mwJ0ZE50baNh8DJ2Un/foDg3yvXZTsKkic7NducHpHg8NB0/TA315TS752w4XXjMbYFhmRvluUt+MWv0DeV4oBYn8kQjf//uqr7NAwy2O5hGE5htRTW/HLk80b89ErjKhOaxChjJjTlQooXSlVJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JVp6f/CY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741351958; x=1772887958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KUe9SSJz9ISvQAEPHqlR4strR/gMPqHS0mOsCVaZh5M=;
  b=JVp6f/CY9ew+ZYsWB1uzk9ifnH0SWHyOxWbq3xpKPRLfiO0dI8yAbBk0
   SejF0bJlB3To8JgloKYIgY89PnOBQqRb8hAC7bku7KelZ2I/q9kXKrmOw
   2UaEQ3p9LP0boeFiRBuQwylXcefOQdUQ7gdUnsnCtzSBnqVjlBiSK1hld
   kV1sthDJ5FTM9b/LmafqPys1tUO7z0Ij2Oob3WIpmTzr2oqhvtuzbRAWf
   c5W6/BeDUCoepBNw+M6BNY8urnUt5j/f6lnzrMH0bbmhq2VaxHeJRjisr
   uOB+uLLnm/Ij8nXGQlAkEVyTvurqoyEBPQfXnvVI+aRB8Marejz/vSHf2
   g==;
X-CSE-ConnectionGUID: kD0bqzjqQH+xCx+y5a7BlQ==
X-CSE-MsgGUID: LnS0X4FwSta4LwnvTMAfkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53040237"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="53040237"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:52:37 -0800
X-CSE-ConnectionGUID: HlvgJ0VbQi+RI8/+1dtRZg==
X-CSE-MsgGUID: 5RnjY5gaROC53AggHSIZ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="119820211"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 07 Mar 2025 04:52:33 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqXBR-0000UV-0k;
	Fri, 07 Mar 2025 12:52:19 +0000
Date: Fri, 7 Mar 2025 20:51:04 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com, pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, qyousef@layalina.io,
	hongyan.xia2@arm.com, christian.loehle@arm.com,
	luis.machado@arm.com, qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 5/7 v5] sched/fair: Add push task mechanism for EAS
Message-ID: <202503072035.8PEXiAFe-lkp@intel.com>
References: <20250302210539.1563190-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250302210539.1563190-6-vincent.guittot@linaro.org>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on peterz-queue/sched/core linus/master v6.14-rc5 next-20250306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Guittot/sched-fair-Filter-false-overloaded_group-case-for-EAS/20250303-050850
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250302210539.1563190-6-vincent.guittot%40linaro.org
patch subject: [PATCH 5/7 v5] sched/fair: Add push task mechanism for EAS
config: x86_64-randconfig-003-20250307 (https://download.01.org/0day-ci/archive/20250307/202503072035.8PEXiAFe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503072035.8PEXiAFe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503072035.8PEXiAFe-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'has_pushable_tasks':
   kernel/sched/fair.c:8675:42: error: 'struct cfs_rq' has no member named 'pushable_tasks'
    8675 |         return !plist_head_empty(&rq->cfs.pushable_tasks);
         |                                          ^
   In file included from include/linux/kernel.h:22,
                    from include/linux/cpumask.h:11,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c: In function 'pick_next_pushable_fair_task':
   kernel/sched/fair.c:8685:39: error: 'struct cfs_rq' has no member named 'pushable_tasks'
    8685 |         p = plist_first_entry(&rq->cfs.pushable_tasks,
         |                                       ^
   include/linux/container_of.h:19:33: note: in definition of macro 'container_of'
      19 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   kernel/sched/fair.c:8685:13: note: in expansion of macro 'plist_first_entry'
    8685 |         p = plist_first_entry(&rq->cfs.pushable_tasks,
         |             ^~~~~~~~~~~~~~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:22,
                    from include/linux/cpumask.h:11,
                    from include/linux/energy_model.h:4,
                    from kernel/sched/fair.c:23:
   kernel/sched/fair.c:8685:39: error: 'struct cfs_rq' has no member named 'pushable_tasks'
    8685 |         p = plist_first_entry(&rq->cfs.pushable_tasks,
         |                                       ^
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/plist.h:233:9: note: in expansion of macro 'container_of'
     233 |         container_of(plist_first(head), type, member)
         |         ^~~~~~~~~~~~
   kernel/sched/fair.c:8685:13: note: in expansion of macro 'plist_first_entry'
    8685 |         p = plist_first_entry(&rq->cfs.pushable_tasks,
         |             ^~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:8685:39: error: 'struct cfs_rq' has no member named 'pushable_tasks'
    8685 |         p = plist_first_entry(&rq->cfs.pushable_tasks,
         |                                       ^
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:21:23: note: in expansion of macro '__same_type'
      21 |                       __same_type(*(ptr), void),                        \
         |                       ^~~~~~~~~~~
   include/linux/plist.h:233:9: note: in expansion of macro 'container_of'
     233 |         container_of(plist_first(head), type, member)
         |         ^~~~~~~~~~~~
   kernel/sched/fair.c:8685:13: note: in expansion of macro 'plist_first_entry'
    8685 |         p = plist_first_entry(&rq->cfs.pushable_tasks,
         |             ^~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:483:27: error: expression in static assertion is not an integer
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:20:9: note: in expansion of macro 'static_assert'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:20:23: note: in expansion of macro '__same_type'
      20 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   include/linux/plist.h:233:9: note: in expansion of macro 'container_of'
     233 |         container_of(plist_first(head), type, member)
         |         ^~~~~~~~~~~~
   kernel/sched/fair.c:8685:13: note: in expansion of macro 'plist_first_entry'
    8685 |         p = plist_first_entry(&rq->cfs.pushable_tasks,
         |             ^~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:8697:47: error: 'struct cfs_rq' has no member named 'pushable_tasks'
    8697 |         plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
         |                                               ^
   kernel/sched/fair.c: In function 'fair_remove_pushable_task':
   kernel/sched/fair.c:8772:55: error: 'struct cfs_rq' has no member named 'pushable_tasks'
    8772 |                 plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
         |                                                       ^
   kernel/sched/fair.c: In function 'fair_add_pushable_task':
   kernel/sched/fair.c:8779:63: error: 'struct cfs_rq' has no member named 'pushable_tasks'
    8779 |                         plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
         |                                                               ^
   kernel/sched/fair.c:8781:63: error: 'struct cfs_rq' has no member named 'pushable_tasks'
    8781 |                         plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
         |                                                               ^
   kernel/sched/fair.c: In function 'init_cfs_rq':
   kernel/sched/fair.c:13572:32: error: 'struct cfs_rq' has no member named 'pushable_tasks'
   13572 |         plist_head_init(&cfs_rq->pushable_tasks);
         |                                ^~
   kernel/sched/fair.c: In function 'has_pushable_tasks':
   kernel/sched/fair.c:8676:1: warning: control reaches end of non-void function [-Wreturn-type]
    8676 | }
         | ^


vim +483 include/linux/compiler_types.h

eb111869301e15 Rasmus Villemoes 2019-09-13  481  
d15155824c5014 Will Deacon      2017-10-24  482  /* Are two types/vars the same type (ignoring qualifiers)? */
d15155824c5014 Will Deacon      2017-10-24 @483  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
d15155824c5014 Will Deacon      2017-10-24  484  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


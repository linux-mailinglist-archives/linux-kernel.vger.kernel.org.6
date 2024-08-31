Return-Path: <linux-kernel+bounces-309707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F12966F82
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDD21F236CC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 05:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D8E4D8B0;
	Sat, 31 Aug 2024 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UVxOPUii"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7B08528F
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 05:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725083511; cv=none; b=DjOObd6JR4dpyCoXq9d962sO7sbt6LiPpWWpvQn6ItX3RwjCovtcl9O2SUgPGYc8jOeBZxvwKUev2/Wn6Sz82+pYVitahFslzvcZCtDlV1LPmOOnQG0XuRAAq6nIFIVYPVqIvPT+5AtpaCnr18WE7Foz209q0teasGP71RprTyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725083511; c=relaxed/simple;
	bh=s+6C5rbwIFP7ALjAZXsY0+q7yW2LNJh3v/9z7LKsCBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aPlE7LKYjf4YAxX6H1ztmfmmZBkwu/ykqhHbMUwF9MRH34FFxVsN8+kwq4fMfbDXVStGQORajSc2zutmdrzBzYCDLIGb3PGUXsZ2+/oH4340W+VP4FD7oepFF/0bMg7EzhLO011b30jYEDNi8GjuYtXMstKYmAhnyiL7bczFFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UVxOPUii; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725083510; x=1756619510;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s+6C5rbwIFP7ALjAZXsY0+q7yW2LNJh3v/9z7LKsCBQ=;
  b=UVxOPUii66OYLxM3ChjOAFsh+tEGMMa2gYwFhyU1UBLU+zZlxEypou9L
   2xV5d5SrMC8D7erhnrUoRetm9Gw0RkmSueA37t2wepwjPY6/P9Jw7VYLZ
   u/OH0k563XWghAwAPgYgOjbzuorbvJd0I0f+4kdM29fEswRUhnWDff78K
   A1GZPNA0aXLUf/miE3vqeiCkB5FXfNJdtopiY3bXOIYUL5PASx7SSA089
   A4jraezkl94ziDBtI6F/KfaS9nncy5hw2W5DmmUJd1LF88bxMjKhUWIPx
   z0HXOUR5t9uiqr8n4pwOPWrSfmAZppA43MHa9XzIRS5Oqize1I5+DRYi5
   g==;
X-CSE-ConnectionGUID: HQ4F6RjKSNaus1RcrxqMGA==
X-CSE-MsgGUID: b7vWPQf/TgeC56iScJUnHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="26641529"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="26641529"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 22:51:49 -0700
X-CSE-ConnectionGUID: 2ACZLcgNSI+o2X3bUD9eeg==
X-CSE-MsgGUID: buOyvQfrSdKKGXF0cpXZ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="68996523"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 30 Aug 2024 22:51:47 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skH1V-0002NO-0z;
	Sat, 31 Aug 2024 05:51:45 +0000
Date: Sat, 31 Aug 2024 13:51:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.08.30a 27/33] include/linux/srcu.h:246:37:
 error: 'SRCU_READ_FLAVOR_NORMAL' undeclared
Message-ID: <202408311318.wcMCNEWH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.08.30a
head:   05416eb79213ad6a9770faa795059fdd00adb6e0
commit: d4401cc54f3e2985675be825f5222aff9764ab8b [27/33] srcu: Convert srcu_data ->srcu_reader_flavor to bit field
config: m68k-randconfig-r072-20240831 (https://download.01.org/0day-ci/archive/20240831/202408311318.wcMCNEWH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311318.wcMCNEWH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311318.wcMCNEWH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/notifier.h:16,
                    from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:1432,
                    from include/linux/topology.h:33,
                    from include/linux/irq.h:19,
                    from include/asm-generic/hardirq.h:17,
                    from ./arch/m68k/include/generated/asm/hardirq.h:1,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:8,
                    from arch/m68k/kernel/asm-offsets.c:16:
   include/linux/srcu.h: In function 'srcu_read_lock':
>> include/linux/srcu.h:246:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     246 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h:246:37: note: each undeclared identifier is reported only once for each function it appears in
   include/linux/srcu.h: In function 'srcu_read_lock_nmisafe':
>> include/linux/srcu.h:267:37: error: 'SRCU_READ_FLAVOR_NMI' undeclared (first use in this function)
     267 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
         |                                     ^~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_lock_notrace':
   include/linux/srcu.h:279:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     279 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_down_read':
   include/linux/srcu.h:308:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     308 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_unlock':
   include/linux/srcu.h:323:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     323 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_unlock_nmisafe':
   include/linux/srcu.h:339:37: error: 'SRCU_READ_FLAVOR_NMI' undeclared (first use in this function)
     339 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
         |                                     ^~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_read_unlock_notrace':
   include/linux/srcu.h:348:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     348 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/srcu.h: In function 'srcu_up_read':
   include/linux/srcu.h:365:37: error: 'SRCU_READ_FLAVOR_NORMAL' undeclared (first use in this function)
     365 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^~~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:117: arch/m68k/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1193: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/SRCU_READ_FLAVOR_NORMAL +246 include/linux/srcu.h

   221	
   222	/**
   223	 * srcu_read_lock - register a new reader for an SRCU-protected structure.
   224	 * @ssp: srcu_struct in which to register the new reader.
   225	 *
   226	 * Enter an SRCU read-side critical section.  Note that SRCU read-side
   227	 * critical sections may be nested.  However, it is illegal to
   228	 * call anything that waits on an SRCU grace period for the same
   229	 * srcu_struct, whether directly or indirectly.  Please note that
   230	 * one way to indirectly wait on an SRCU grace period is to acquire
   231	 * a mutex that is held elsewhere while calling synchronize_srcu() or
   232	 * synchronize_srcu_expedited().
   233	 *
   234	 * The return value from srcu_read_lock() must be passed unaltered
   235	 * to the matching srcu_read_unlock().  Note that srcu_read_lock() and
   236	 * the matching srcu_read_unlock() must occur in the same context, for
   237	 * example, it is illegal to invoke srcu_read_unlock() in an irq handler
   238	 * if the matching srcu_read_lock() was invoked in process context.  Or,
   239	 * for that matter to invoke srcu_read_unlock() from one task and the
   240	 * matching srcu_read_lock() from another.
   241	 */
   242	static inline int srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp)
   243	{
   244		int retval;
   245	
 > 246		srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
   247		retval = __srcu_read_lock(ssp);
   248		srcu_lock_acquire(&ssp->dep_map);
   249		return retval;
   250	}
   251	
   252	/**
   253	 * srcu_read_lock_nmisafe - register a new reader for an SRCU-protected structure.
   254	 * @ssp: srcu_struct in which to register the new reader.
   255	 *
   256	 * Enter an SRCU read-side critical section, but in an NMI-safe manner.
   257	 * See srcu_read_lock() for more information.
   258	 *
   259	 * If srcu_read_lock_nmisafe() is ever used on an srcu_struct structure,
   260	 * then none of the other flavors may be used, whether before, during,
   261	 * or after.
   262	 */
   263	static inline int srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp)
   264	{
   265		int retval;
   266	
 > 267		srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
   268		retval = __srcu_read_lock_nmisafe(ssp);
   269		rcu_try_lock_acquire(&ssp->dep_map);
   270		return retval;
   271	}
   272	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


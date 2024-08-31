Return-Path: <linux-kernel+bounces-309784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CB0967060
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D331C21D51
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416C170A24;
	Sat, 31 Aug 2024 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emeGbnJw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FFB13B5AE
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725093596; cv=none; b=oeuZrZCdp9/FqaygNx6WWPXPUe5SqvGTkC9pMF5yStvofjHKTNWsVS/rNDoyLz9hRP9XbYtpSM3DLS1KSAIzbnLBg9VinUZXuVaOWwXMsPTO+7W8h3b5EK44MvhKF0WUbSF6YXRS9Qsyad5HxPZpQ6i249NwvYDxvFvMFlV9tp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725093596; c=relaxed/simple;
	bh=dHu6uhN+37fGJnAu+oKkGVZm3gYFuLDYxsJkYWqXAZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OBGDkGwHmAl4wwK/hzfWbwWKOMCCbvq0gWMeZIQuvC2nh3gmpJ3PiS+1KLGbom/F4OLfNzP3ZTVB1ELzeO+jy2ovgIQye+fuhcQblUGf1TbpqgaUFIUDVQbVO+1Ug6aZroKd+nEmff800/mAFmohV7hbsouvEHgcuQ7Wq0PjEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emeGbnJw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725093594; x=1756629594;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dHu6uhN+37fGJnAu+oKkGVZm3gYFuLDYxsJkYWqXAZs=;
  b=emeGbnJwTvw13oiKEEAUPRagwwzn3w6jj+wx0BrBsheun9JuUgiHvIE6
   fh5xB2eWdrIIMW1+EUbFp+/jECx9wdWA5w4J8feoT/9F0AclhP6oENED+
   ruFFWiCeTpayHQuLw/DQqn8VVBw5udGp+PKJeh8SMebovSUncSMusslxc
   0sjozjdj7X8vDw4ipr9ImhuRzjM0ic0dBqOYYxZYwPeJu77SsQLMqojV9
   l+fjGZFXcDOErHheMp/t8dn+k6fAHLjoVfSrgsw+zUMfgr4DSsfK9Rgx9
   W1gZu7iCGfHaUETl6v8d8jQGSr/aDiZORIKFH7HtMYUhpveyWl16WNqRu
   Q==;
X-CSE-ConnectionGUID: hhPLxI5ERKGPNzD34GFs+g==
X-CSE-MsgGUID: T1/grov8QTKN5Qxih3I+IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="23872631"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="23872631"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 01:39:53 -0700
X-CSE-ConnectionGUID: IHuyiAZuT6i23zfrPPTcLQ==
X-CSE-MsgGUID: W37IpqYXTUCu7W6s9dWESg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="68529408"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 31 Aug 2024 01:39:52 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skJeA-0002TM-04;
	Sat, 31 Aug 2024 08:39:50 +0000
Date: Sat, 31 Aug 2024 16:39:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.08.30a 28/33] include/linux/srcu.h:274:30:
 error: use of undeclared identifier 'SRCU_READ_FLAVOR_LITE'
Message-ID: <202408311649.7FRBYdiC-lkp@intel.com>
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
commit: 23265e8fd7b05be03428c2e7632440d8573e5e7e [28/33] srcu: Add srcu_read_lock_lite() and srcu_read_unlock_lite()
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240831/202408311649.7FRBYdiC-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311649.7FRBYdiC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311649.7FRBYdiC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:17:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:1432:
   In file included from include/linux/memory_hotplug.h:7:
   In file included from include/linux/notifier.h:16:
   include/linux/srcu.h:248:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     248 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
>> include/linux/srcu.h:274:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_LITE'
     274 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
         |                                     ^
   include/linux/srcu.h:295:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NMI'
     295 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
         |                                     ^
   include/linux/srcu.h:307:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     307 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
   include/linux/srcu.h:336:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     336 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
   include/linux/srcu.h:351:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     351 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
   include/linux/srcu.h:367:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_LITE'
     367 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
         |                                     ^
   include/linux/srcu.h:383:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NMI'
     383 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
         |                                     ^
   include/linux/srcu.h:392:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     392 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
   include/linux/srcu.h:409:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     409 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:16:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:16:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:16:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
      99 |                         set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:16:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (that has type 'unsigned long[1]') [-Warray-bounds]
     101 |                 return (set->sig[1] | set->sig[0]) == 0;
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:16:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[1]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];


vim +/SRCU_READ_FLAVOR_LITE +274 include/linux/srcu.h

   253	
   254	/**
   255	 * srcu_read_lock_lite - register a new reader for an SRCU-protected structure.
   256	 * @ssp: srcu_struct in which to register the new reader.
   257	 *
   258	 * Enter an SRCU read-side critical section, but for a light-weight
   259	 * smp_mb()-free reader.  See srcu_read_lock() for more information.
   260	 *
   261	 * If srcu_read_lock_lite() is ever used on an srcu_struct structure,
   262	 * then none of the other flavors may be used, whether before, during,
   263	 * or after.  Note that grace-period auto-expediting is disabled for _lite
   264	 * srcu_struct structures because auto-expedited grace periods invoke
   265	 * synchronize_rcu_expedited(), IPIs and all.
   266	 *
   267	 * Note that srcu_read_lock_lite() can be invoked only from those contexts
   268	 * where RCU is watching.  Otherwise, lockdep will complain.
   269	 */
   270	static inline int srcu_read_lock_lite(struct srcu_struct *ssp) __acquires(ssp)
   271	{
   272		int retval;
   273	
 > 274		srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_LITE);
   275		retval = __srcu_read_lock_lite(ssp);
   276		rcu_try_lock_acquire(&ssp->dep_map);
   277		return retval;
   278	}
   279	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-309747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DC4966FEF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E6A1C20EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A3517C7D8;
	Sat, 31 Aug 2024 07:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="heBtBwxJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E29416EB54
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087897; cv=none; b=QmgESmpJCy8wK+J7J5HM5awlHmXMzqmYqTH/hxUPyHi4e2qrR5TygHpslG3uMDwUgyHBnz5m8YZCE9K3jnF1Hl7nZe/a527PT8hDfvU5H6fYhbQ1ZVyxz4ubhQUsm+7G9sEzU9Fxk2xnK5lD/usbser8umE8Pg1s9JYlfU2Q908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087897; c=relaxed/simple;
	bh=JKEQXIXKED+8Pw8da1C5xAekT7C4EqGCID20YKUKeD4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i5PiazGF7SjIZL3h837QH1hzKRl6Dv8WNpfsMx8ub7HGL6sgTaZ29zcvkJfb0zn9L+tLvuXsl5wttANxMXxsxxDEJO7Q+olSsaVEiSsmMcYKrmD2oZ90FalU/JEEADk9sOMstM8zAyqN8kYppyprNwWRzIyU6lmJ5YXPCKEgJn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=heBtBwxJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725087895; x=1756623895;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JKEQXIXKED+8Pw8da1C5xAekT7C4EqGCID20YKUKeD4=;
  b=heBtBwxJ3Dix+KeH5NajsWqrEzT9Tdh1h4Srx0qwxVrqjeRp7YaXVRIn
   Dr/8YCUkX7GF0dPPckxp7uttxWYdYoHaCZ7VdpMpJ9cSiqF3m9h2106Ks
   GFq5OvAMAoiZs/vYSKn5ZV6cW1g7y+Jytmsvq8Rl7J6ywDErKtKChzEMo
   KB6nv5LbJ1oLYospwNiljGcUC+hsZ3QS65emsYH9NhP/Cxhyq5zL+9RQX
   Iarau37UCY+X37AzbYrBh3UmRTK0lOTdaI83BQiyqQGWtrq98ymMa17TM
   mZiVEUqwKiYsUZu2jXfm5+fW6dJteKVzzbnj2L8khUiw/uBSgRs7NfCdk
   g==;
X-CSE-ConnectionGUID: nZhPBuYMRcuG3Tbs9oEuaQ==
X-CSE-MsgGUID: zx2ds5GOTXibBezCa9OKjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13308911"
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="13308911"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 00:04:52 -0700
X-CSE-ConnectionGUID: hcdCQj+SQbqPVt5aV6izYQ==
X-CSE-MsgGUID: bj9yYPDiSzOxFUV7eOkQZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,191,1719903600"; 
   d="scan'208";a="64467304"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 31 Aug 2024 00:04:50 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1skIAC-0002Pv-0E;
	Sat, 31 Aug 2024 07:04:48 +0000
Date: Sat, 31 Aug 2024 15:04:05 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.08.30a 27/33] include/linux/srcu.h:246:30:
 error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
Message-ID: <202408311452.nS2HBgqc-lkp@intel.com>
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
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240831/202408311452.nS2HBgqc-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240831/202408311452.nS2HBgqc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408311452.nS2HBgqc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:9:
   In file included from include/linux/crypto.h:17:
   In file included from include/linux/slab.h:16:
   In file included from include/linux/gfp.h:7:
   In file included from include/linux/mmzone.h:1432:
   In file included from include/linux/memory_hotplug.h:7:
   In file included from include/linux/notifier.h:16:
>> include/linux/srcu.h:246:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     246 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
>> include/linux/srcu.h:267:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NMI'
     267 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
         |                                     ^
   include/linux/srcu.h:279:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     279 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
   include/linux/srcu.h:308:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     308 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
   include/linux/srcu.h:323:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     323 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
   include/linux/srcu.h:339:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NMI'
     339 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NMI);
         |                                     ^
   include/linux/srcu.h:348:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     348 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
         |                                     ^
   include/linux/srcu.h:365:30: error: use of undeclared identifier 'SRCU_READ_FLAVOR_NORMAL'
     365 |         srcu_check_read_flavor(ssp, SRCU_READ_FLAVOR_NORMAL);
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
         |         ^
   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:13:
   In file included from include/linux/cgroup.h:16:


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


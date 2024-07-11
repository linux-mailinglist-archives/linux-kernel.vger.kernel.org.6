Return-Path: <linux-kernel+bounces-248486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3956792DDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A0B1F21B14
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9814C8B;
	Thu, 11 Jul 2024 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CWP58jLf"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692212F5A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660620; cv=none; b=spEtuB+o0WuIqjEIJJBBUW4XJTjQ5oHgrlBGD4PbuQhrvJrP8+Dz4r7xjBt7K+vLhMGkW6hMt4MTFawh4x8Z7Ue8XQsDD71ePYtopZGubtxZ+Bz+nN94RbSQ1MnoF7DOhaC9I45KzaD7CQeT++PYTjLEszwnjjVM+ekFLtB9nLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660620; c=relaxed/simple;
	bh=CqsYrItIm0jCcEk4sTMjJkjG7HibnX/Wiy1jFW8ZqJo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pEFQfQKF6soWOBCyitSLDjfJvXMmFvjemyjYDKk6NoHD5pL0qOPqN610sk1+2Qks89xIHmGo2lvOUzmHGJhECWj9Lk8tMTBYkBmRu7CjuLwcc8iQscg4d91RDuAlUdFD2JY/KMe9qZxM6hpFttohzaca+E6ECFe+YblgjXPcBKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CWP58jLf; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720660619; x=1752196619;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CqsYrItIm0jCcEk4sTMjJkjG7HibnX/Wiy1jFW8ZqJo=;
  b=CWP58jLfEYmNqz70yE9sHzQubwwZObbTEAvVETdY/YM3Q7H+Xzao+pTl
   C2uO9F4Lf1O/v00ase8gCPmCyZW2f8DQwlJEuktH5NadP6E80g4tuiO84
   B0sDo2XxPoX3/l9+thqi0xI9x8Ael+TYMR/41e4ZU1Lg3nDAwuJ+VQFfP
   pa0OGts/IX0aFuDPz9l3qo/t0PKsCfi8KvbLr9BUNOkbLGFAhDpQapLEv
   7W0tsBLKCi5We/Vl4BNhEuDdGBbpPNAD1GangAa2FEGYi5rWbFNEI1QFS
   IKvWglz9SbRi9xt1IRrfGNRZCoN3dDYagH099bGll4iBrDtBjgS/pp7C+
   Q==;
X-CSE-ConnectionGUID: 2vkL0b9MRom5/qBTbMP0/Q==
X-CSE-MsgGUID: qjTiX/QiQzq9h33hoP1EdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="35555911"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="35555911"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 18:16:58 -0700
X-CSE-ConnectionGUID: ehVvAkArQiii4TmP8+suhw==
X-CSE-MsgGUID: fOtKRAFqTuaobYfQDz5m9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48394218"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Jul 2024 18:16:56 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRiQY-000YZz-1o;
	Thu, 11 Jul 2024 01:16:54 +0000
Date: Thu, 11 Jul 2024 09:16:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:for-neeraj.2024.07.10a 30/42]
 kernel/rcu/tree_stall.h:798:49: error: call to undeclared function
 'csd_lock_is_stuck'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202407110950.SoSbeyIm-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-neeraj.2024.07.10a
head:   6dfea2d3ac9e0874587c0c1d05fd829f520d5458
commit: 3e7a44e2495502599af4ac67d39b9fbbd8217557 [30/42] rcu: Summarize RCU CPU stall warnings during CSD-lock stalls
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240711/202407110950.SoSbeyIm-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407110950.SoSbeyIm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407110950.SoSbeyIm-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:40:
   In file included from include/linux/cpu.h:17:
   In file included from include/linux/node.h:18:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from kernel/rcu/tree.c:53:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from kernel/rcu/tree.c:53:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from kernel/rcu/tree.c:53:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   In file included from kernel/rcu/tree.c:5638:
>> kernel/rcu/tree_stall.h:798:49: error: call to undeclared function 'csd_lock_is_stuck'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     798 |                 if (READ_ONCE(csd_lock_suppress_rcu_stall) && csd_lock_is_stuck()) {
         |                                                               ^
   13 warnings and 1 error generated.


vim +/csd_lock_is_stuck +798 kernel/rcu/tree_stall.h

   725	
   726	static void check_cpu_stall(struct rcu_data *rdp)
   727	{
   728		bool self_detected;
   729		unsigned long gs1;
   730		unsigned long gs2;
   731		unsigned long gps;
   732		unsigned long j;
   733		unsigned long jn;
   734		unsigned long js;
   735		struct rcu_node *rnp;
   736	
   737		lockdep_assert_irqs_disabled();
   738		if ((rcu_stall_is_suppressed() && !READ_ONCE(rcu_kick_kthreads)) ||
   739		    !rcu_gp_in_progress())
   740			return;
   741		rcu_stall_kick_kthreads();
   742	
   743		/*
   744		 * Check if it was requested (via rcu_cpu_stall_reset()) that the FQS
   745		 * loop has to set jiffies to ensure a non-stale jiffies value. This
   746		 * is required to have good jiffies value after coming out of long
   747		 * breaks of jiffies updates. Not doing so can cause false positives.
   748		 */
   749		if (READ_ONCE(rcu_state.nr_fqs_jiffies_stall) > 0)
   750			return;
   751	
   752		j = jiffies;
   753	
   754		/*
   755		 * Lots of memory barriers to reject false positives.
   756		 *
   757		 * The idea is to pick up rcu_state.gp_seq, then
   758		 * rcu_state.jiffies_stall, then rcu_state.gp_start, and finally
   759		 * another copy of rcu_state.gp_seq.  These values are updated in
   760		 * the opposite order with memory barriers (or equivalent) during
   761		 * grace-period initialization and cleanup.  Now, a false positive
   762		 * can occur if we get an new value of rcu_state.gp_start and a old
   763		 * value of rcu_state.jiffies_stall.  But given the memory barriers,
   764		 * the only way that this can happen is if one grace period ends
   765		 * and another starts between these two fetches.  This is detected
   766		 * by comparing the second fetch of rcu_state.gp_seq with the
   767		 * previous fetch from rcu_state.gp_seq.
   768		 *
   769		 * Given this check, comparisons of jiffies, rcu_state.jiffies_stall,
   770		 * and rcu_state.gp_start suffice to forestall false positives.
   771		 */
   772		gs1 = READ_ONCE(rcu_state.gp_seq);
   773		smp_rmb(); /* Pick up ->gp_seq first... */
   774		js = READ_ONCE(rcu_state.jiffies_stall);
   775		smp_rmb(); /* ...then ->jiffies_stall before the rest... */
   776		gps = READ_ONCE(rcu_state.gp_start);
   777		smp_rmb(); /* ...and finally ->gp_start before ->gp_seq again. */
   778		gs2 = READ_ONCE(rcu_state.gp_seq);
   779		if (gs1 != gs2 ||
   780		    ULONG_CMP_LT(j, js) ||
   781		    ULONG_CMP_GE(gps, js))
   782			return; /* No stall or GP completed since entering function. */
   783		rnp = rdp->mynode;
   784		jn = jiffies + ULONG_MAX / 2;
   785		self_detected = READ_ONCE(rnp->qsmask) & rdp->grpmask;
   786		if (rcu_gp_in_progress() &&
   787		    (self_detected || ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY)) &&
   788		    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
   789			/*
   790			 * If a virtual machine is stopped by the host it can look to
   791			 * the watchdog like an RCU stall. Check to see if the host
   792			 * stopped the vm.
   793			 */
   794			if (kvm_check_and_clear_guest_paused())
   795				return;
   796	
   797			rcu_stall_notifier_call_chain(RCU_STALL_NOTIFY_NORM, (void *)j - gps);
 > 798			if (READ_ONCE(csd_lock_suppress_rcu_stall) && csd_lock_is_stuck()) {
   799				pr_err("INFO: %s detected stall, but suppressed full report due to a stuck CSD-lock.\n", rcu_state.name);
   800			} else if (self_detected) {
   801				/* We haven't checked in, so go dump stack. */
   802				print_cpu_stall(gps);
   803			} else {
   804				/* They had a few time units to dump stack, so complain. */
   805				print_other_cpu_stall(gs2, gps);
   806			}
   807	
   808			if (READ_ONCE(rcu_cpu_stall_ftrace_dump))
   809				rcu_ftrace_dump(DUMP_ALL);
   810	
   811			if (READ_ONCE(rcu_state.jiffies_stall) == jn) {
   812				jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
   813				WRITE_ONCE(rcu_state.jiffies_stall, jn);
   814			}
   815		}
   816	}
   817	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


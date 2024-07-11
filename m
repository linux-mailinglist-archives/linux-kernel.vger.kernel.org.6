Return-Path: <linux-kernel+bounces-248521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A1492DE56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B893F1F2235A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 02:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D26D512;
	Thu, 11 Jul 2024 02:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1RR5sUK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED0D50F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664522; cv=none; b=QW/EfFzj13CuJc1G//fgojZFlNk43GVNzx3gtfCVNSwcNL78kq5L3MBUDpS+OVM0XDuQQIEDQNxSakjVnk5k2DfwmWYNb7rnMscaCIuxRuekHUpaz5/8vqFcOzTHe5H6s3AB2SssPAgjFTqaJmmHLDvdaFkozmHlgb94Q63VyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664522; c=relaxed/simple;
	bh=pA8BI3oTyYKOOaVgILZUdJ0293sHMEIW6UHPLXWD8Do=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oCQTjT+VA6QkzLkl0y020gvm4UHyR8PBIeqn0faaDkfJNm+zgpXQeWhz+y0fAcNJHtlfNknZt7RNlUnNFDZUPGVgGrnlK8TQNabqLRwDC1SXpjXpCp93ZuGH+BEwHPehvaQM9u83N08SGqVrQkNT9DY1l1qe6pcNLTA4rI/Jg4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1RR5sUK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720664521; x=1752200521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pA8BI3oTyYKOOaVgILZUdJ0293sHMEIW6UHPLXWD8Do=;
  b=E1RR5sUK0MhhfAciQ9Pd28rmdwgpkz5sKGvwUkhwyo0qtGtytUeadCdM
   eA4tZX6KqQqIWfyLXWRHgTf0AD3U3cTsgWjQEHeOi1bKUCDJyEQThMPBb
   B8Z/b4LqbZkdBT7vTHBmwXwByC46G3rW6uqKIwuYodnXzqrMeGIIQrWmt
   co+ScQ1IMqVlokHCpkWgdaDatxXMGF7pev5JODDosgK2Zg1jfQwF9ltuL
   r3ivscNGHjwlX76JVR/btYqw3UmxuUrEWykFM5LyW37D9ax17wtlBy6UO
   OcIL7gFxHin0vrbA3++6GHh8XpYlwLF22uRsYiNNr1d7+Bnu+mXvgSXly
   w==;
X-CSE-ConnectionGUID: 10vesLn2RuGi62+RQ9w9bQ==
X-CSE-MsgGUID: hahnsbgBT2SHk7N6ofj9tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="40540036"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="40540036"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 19:22:00 -0700
X-CSE-ConnectionGUID: AA26cRu+ShyUf2iowkhOKA==
X-CSE-MsgGUID: 3JpfVcbKR663TyCX61PHjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="71630234"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 10 Jul 2024 19:21:59 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRjRU-000Yde-2c;
	Thu, 11 Jul 2024 02:21:56 +0000
Date: Thu, 11 Jul 2024 10:21:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:for-neeraj.2024.07.10a 30/42]
 kernel/rcu/tree_stall.h:798:63: error: implicit declaration of function
 'csd_lock_is_stuck'
Message-ID: <202407111030.UYYhi3JZ-lkp@intel.com>
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
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240711/202407111030.UYYhi3JZ-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407111030.UYYhi3JZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407111030.UYYhi3JZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/rcu/tree.c:5638:
   kernel/rcu/tree_stall.h: In function 'check_cpu_stall':
>> kernel/rcu/tree_stall.h:798:63: error: implicit declaration of function 'csd_lock_is_stuck' [-Werror=implicit-function-declaration]
     798 |                 if (READ_ONCE(csd_lock_suppress_rcu_stall) && csd_lock_is_stuck()) {
         |                                                               ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


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


Return-Path: <linux-kernel+bounces-443775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DED9EFB99
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63F9188E005
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579A192B9A;
	Thu, 12 Dec 2024 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MF691WmE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2018FC90
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029451; cv=none; b=DAtETVGk+4ufGCJVTLhw3lQ24+6LgQLo2tZo++LL7W3UfI2WshKBRqxMYaPSI2UHch2X/TumEEbVB0YOODrnY13D9NG2AQn7w7Ai3mbO2mbhQQ9qUE6nv1Iy9Yub1fkeLgZBwLSTV8yeeILn+akWrr5vcFGvcaWiHm0LPFhVrdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029451; c=relaxed/simple;
	bh=cFj+AbwVjTfQ/jk/JTbmC7Z5oxEtbIi4pvziQCs8DjM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DWs5mbkrCMUx5ZEkdnL5jrt7ng67s6NOGwBc1D/A9P6QYjCdfdL4SYwUEtSWh/yya5gvWUizP99FTfAikDyidHrCyskovJ3ifQHlb+uHy1WH1cEinusotKCipD/isjf3w96Pt9MiU0lO9VrEuvIpyPu2I7/QiLksRk7YGuWloAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MF691WmE; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734029449; x=1765565449;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cFj+AbwVjTfQ/jk/JTbmC7Z5oxEtbIi4pvziQCs8DjM=;
  b=MF691WmEWHaXK5td4Qfl5x7ENsYuw1kgAGSersbjS1OKpAZQxHOfTeBP
   8gQ4pflcTnkrHFcSLLfKWrP9ncmSs9Hnwh95NIVlXiNpagjlMwxx71nhT
   wwkPjSpuj3VtLEuNMJqvBYRXRCmw3UpVDxQLA8DgSA8iPgmu7SKGtvfrB
   jihUL/vxlCukjRxhLkmF8T+XcNFW+5ZuucU6C8BIphQ+2d9KL5JItbsRL
   l8tcyQPNkRl0b7BkxiOE7SP1M3UqBavz/56EHjsbqL+n0rSWQxGwqNiyR
   1mpTR0ARxvcYx0qC4MOc0Cm6u6zzSmMi+LKMFYfoOv8GOBDLEZv3T83MP
   w==;
X-CSE-ConnectionGUID: BZZGlMO2QUWTJ8EVDl52jQ==
X-CSE-MsgGUID: +KVEdsCiSvOp4OQXyb9Zvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="59864057"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="59864057"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 10:50:47 -0800
X-CSE-ConnectionGUID: q5Rua8y7TzqxOvwLx1xbTA==
X-CSE-MsgGUID: 3iSYiNLzQ76iBejITVcGbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208";a="101343296"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 Dec 2024 10:50:46 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLoGp-000BDm-2N;
	Thu, 12 Dec 2024 18:50:43 +0000
Date: Fri, 13 Dec 2024 02:50:32 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: kernel/sched/syscalls.c:1196:1: sparse: sparse: Using plain integer
 as NULL pointer
Message-ID: <202412130222.TC0e3CgN-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
commit: 04746ed80bcf3130951ed4d5c1bc5b0bcabdde22 sched/syscalls: Split out kernel/sched/syscalls.c from kernel/sched/core.c
date:   7 months ago
config: s390-randconfig-r132-20241212 (https://download.01.org/0day-ci/archive/20241213/202412130222.TC0e3CgN-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241213/202412130222.TC0e3CgN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412130222.TC0e3CgN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/sched/rt.c:1682:67: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:1682:67: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2044:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *task @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2044:40: sparse:     expected struct task_struct *task
   kernel/sched/rt.c:2044:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2067:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/rt.c:2067:13: sparse:    struct task_struct *
   kernel/sched/rt.c:2067:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/rt.c:2417:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2417:54: sparse:     expected struct task_struct *tsk
   kernel/sched/rt.c:2417:54: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2419:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2419:40: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2419:40: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/rt.c:2419:61: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/rt.c:2419:61: sparse:     expected struct task_struct *p
   kernel/sched/rt.c:2419:61: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/deadline.c:2401:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2401:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2401:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2411:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2411:13: sparse:    struct task_struct *
   kernel/sched/deadline.c:2411:13: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2519:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2519:25: sparse:    struct task_struct *
   kernel/sched/deadline.c:2519:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2026:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2026:42: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2026:42: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:2037:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2037:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:2037:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1220:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1220:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1220:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:1444:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1444:38: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1444:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2262:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/deadline.c:2262:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/deadline.c:2262:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/deadline.c:1911:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu * @@
   kernel/sched/deadline.c:1911:14: sparse:     expected struct task_struct *curr
   kernel/sched/deadline.c:1911:14: sparse:     got struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:1987:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:1987:43: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:1987:43: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2566:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2566:38: sparse:     expected struct task_struct *tsk
   kernel/sched/deadline.c:2566:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2568:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/deadline.c:2568:23: sparse:     expected struct task_struct *p
   kernel/sched/deadline.c:2568:23: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/deadline.c:2570:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct sched_dl_entity const *b @@     got struct sched_dl_entity [noderef] __rcu * @@
   kernel/sched/deadline.c:2570:44: sparse:     expected struct sched_dl_entity const *b
   kernel/sched/deadline.c:2570:44: sparse:     got struct sched_dl_entity [noderef] __rcu *
   kernel/sched/deadline.c:2745:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/deadline.c:2745:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/deadline.c:2745:22: sparse:    struct task_struct *
   kernel/sched/deadline.c:2794:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/syscalls.c:206:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/syscalls.c:206:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/syscalls.c:206:22: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/sched.h:2156:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2156:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2156:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2156:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2156:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2156:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2156:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2156:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2328:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2328:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2328:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2156:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2156:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2328:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2328:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2328:9: sparse:    struct task_struct *
   kernel/sched/build_policy.c: note: in included file:
>> kernel/sched/syscalls.c:1196:1: sparse: sparse: Using plain integer as NULL pointer
>> kernel/sched/syscalls.c:1196:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1386:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1386:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1402:6: sparse: sparse: context imbalance in 'sched_getaffinity' - wrong count at exit
   kernel/sched/syscalls.c:1431:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1431:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1676:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1676:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1689:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1689:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/build_policy.c: note: in included file:
   kernel/sched/rt.c:1707:15: sparse: sparse: dereference of noderef expression

vim +1196 kernel/sched/syscalls.c

  1188	
  1189	/**
  1190	 * sys_sched_getattr - similar to sched_getparam, but with sched_attr
  1191	 * @pid: the pid in question.
  1192	 * @uattr: structure containing the extended parameters.
  1193	 * @usize: sizeof(attr) for fwd/bwd comp.
  1194	 * @flags: for future extension.
  1195	 */
> 1196	SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
  1197			unsigned int, usize, unsigned int, flags)
  1198	{
  1199		struct sched_attr kattr = { };
  1200		struct task_struct *p;
  1201		int retval;
  1202	
  1203		if (!uattr || pid < 0 || usize > PAGE_SIZE ||
  1204		    usize < SCHED_ATTR_SIZE_VER0 || flags)
  1205			return -EINVAL;
  1206	
  1207		scoped_guard (rcu) {
  1208			p = find_process_by_pid(pid);
  1209			if (!p)
  1210				return -ESRCH;
  1211	
  1212			retval = security_task_getscheduler(p);
  1213			if (retval)
  1214				return retval;
  1215	
  1216			kattr.sched_policy = p->policy;
  1217			if (p->sched_reset_on_fork)
  1218				kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
  1219			get_params(p, &kattr);
  1220			kattr.sched_flags &= SCHED_FLAG_ALL;
  1221	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-206020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595B390036E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6726C1C22962
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CDB1922F9;
	Fri,  7 Jun 2024 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QzeJl/Mc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5921946BA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763053; cv=none; b=ouqq9kRqoornOzJJGS9qz/HTu1joyPg+9ngbs9w/vSLtYardr7RrtY3RtIB2HPflwDSe2esCHYtCdv2FuGYbJ498kIMXS64C7fugQe9SwKDczsyMExZsbPgCsDlef2OxunNkvVBGFxdrWpDGidoaAQAi3ygi2xS+OS8o4AMiPo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763053; c=relaxed/simple;
	bh=N1hlRbOCKcHP833SkUyB8GG7RhJV0PfAB0d9wMPCfzA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ojukJQI0ECVIn9qFFnkLzOuAn5XwAiQGF8TeZbBVzqpfdMa7lyOmUyIoLr3wBsO/5kGdEsi1mYnJMTHvbgATWyPsuUbCzUycb6H1RsMLpklJGulRuD404ci9h24apMT//7nQrKTmC2RfcMN8vPCW+xnIrutkqjscEl8EBHF9g8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QzeJl/Mc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717763051; x=1749299051;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N1hlRbOCKcHP833SkUyB8GG7RhJV0PfAB0d9wMPCfzA=;
  b=QzeJl/McotCjer/GB6DgWdv9ux1HBZNl9y4JePz52ZNfZiXTMclZE2sM
   3CmdIO0luIQok2UZujjfcEp8cKgSVFH6JMgs83fISslEqO7Plx6D3qS38
   28O+vNUeJ+pIrchAvObUpYWh9qMDi8aoV441UJ42+WBTjSk8Z1yus8yp1
   0ULJMpYgrUYvNx7v+o/b8tcnNxBzRMBTB7I4xhOokKeGGLUWy4RDbzAv2
   8L1psJFdwDd37fXjqVeRUWBWqKr+sik1MilHCJCRD1skcJI+oWktqweuz
   R5tAQteOt9uEIhlRwt3KrnCC3P4YY327mZhAhpL0qhjo/ZCcQOI1VcDQV
   Q==;
X-CSE-ConnectionGUID: 4vDBmWTYRL2xzr/UMC4bmA==
X-CSE-MsgGUID: 2eb9UPgQRa6N2XwYUbklQA==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14598627"
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="14598627"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2024 05:24:10 -0700
X-CSE-ConnectionGUID: DKgdpojQSVqEZyZMtadLwg==
X-CSE-MsgGUID: D+VLWVZiQ0m1UwUZMgp47Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,221,1712646000"; 
   d="scan'208";a="38886572"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 07 Jun 2024 05:24:09 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFYda-0004la-3B;
	Fri, 07 Jun 2024 12:24:06 +0000
Date: Fri, 7 Jun 2024 20:23:06 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:sched/core 1/5] kernel/sched/syscalls.c:1196:1: sparse: sparse:
 Using plain integer as NULL pointer
Message-ID: <202406072031.0qiY7y7d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
head:   c793a62823d1ce8f70d9cfc7803e3ea436277cda
commit: 04746ed80bcf3130951ed4d5c1bc5b0bcabdde22 [1/5] sched/syscalls: Split out kernel/sched/syscalls.c from kernel/sched/core.c
config: s390-randconfig-r113-20240607 (https://download.01.org/0day-ci/archive/20240607/202406072031.0qiY7y7d-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240607/202406072031.0qiY7y7d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406072031.0qiY7y7d-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
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
   kernel/sched/syscalls.c:253:48: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/syscalls.c:253:48: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/syscalls.c:253:48: sparse:    struct task_struct *
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
   kernel/sched/syscalls.c:1402:6: sparse: sparse: context imbalance in 'sched_getaffinity' - different lock contexts for basic block
   kernel/sched/syscalls.c:1431:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1431:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1676:1: sparse: sparse: Using plain integer as NULL pointer
   kernel/sched/syscalls.c:1676:1: sparse: sparse: Using plain integer as NULL pointer
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


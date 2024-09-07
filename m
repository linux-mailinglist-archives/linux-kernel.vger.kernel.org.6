Return-Path: <linux-kernel+bounces-319935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6FA9703EF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 21:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5BA282FE8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 19:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460C5166F2F;
	Sat,  7 Sep 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K44UGWJE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A9136672
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725737671; cv=none; b=YRo2+6aeF5fNgVWaICSXak5Qznl9z2b8op3IhrH+Csh2UCsH8GAwoIthZSB+efEqLlT/KhTmS30Td2sR2gY8J4o7hXy8BVkOe8Fx6cV8E6X/EJ93WL8oDF3OceOK2ifHmh0PGL5TwNDq1RDkMSuvaDq+mv16v7hh1RnnefDyaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725737671; c=relaxed/simple;
	bh=eBLOeO0njVleRkHrTxELRiDKWUgSuiBCvK+fgMbL/es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlYtMKk6i4XWD1Uu4mNGpGnZA+/7zSb4Q9f+BjVwW4innK8zdx2MbWsNE0805Gyd8Lz0lIilO7bTN9+x5/uc4kfhtNvLjd6C701eABjwjwaFsOYQVhlZordAnhYgQtqX66eQSSEXS52LSc8YZxjWZPMtXwA/4sezJx0VWGkjasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K44UGWJE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725737669; x=1757273669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eBLOeO0njVleRkHrTxELRiDKWUgSuiBCvK+fgMbL/es=;
  b=K44UGWJE0MKd0XXvfsgk9TmbWw7MpFQ1/D3HeXttQSFaM1uZJNPX8ep2
   ydgUaoRakufeC5/OEYvADtgLnWbDKVo/h2YZkoUVaUZRg4YeiVFTvciLa
   SuWe0hWo7DG8lDpYv5EQnBnHaZP9ktR7aa6Xn3fPdCfmMTv241x7DOLSr
   ANELs+to2Gs+aV8KrgibUjS/qO8DknNu4f0ZRF2BcnuOBasziZasTGJQx
   ENzkVjFbRlirBCJGRK4w7qkTfTZXdTgJZMvv9Z8nMAsuuRDZLdh8oVEWP
   P3a61DYWyNIISZqjRcCTHUo6kVzFtgdOvDJj8/wRp6V2aWWWZsEHQ1knD
   w==;
X-CSE-ConnectionGUID: AVMUc0SATjG2Gr0h4+55mQ==
X-CSE-MsgGUID: 1lR8S3KSQWqqfvqW5bV0qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24634029"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="24634029"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 12:34:29 -0700
X-CSE-ConnectionGUID: 2dcllja8TxCwx3htGy2xiw==
X-CSE-MsgGUID: dJnO2SvaR2iSgBxJkBQtxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="66801685"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 07 Sep 2024 12:34:26 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn1CS-000CuH-07;
	Sat, 07 Sep 2024 19:34:24 +0000
Date: Sun, 8 Sep 2024 03:33:28 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Kisel <romank@linux.microsoft.com>, oleg@redhat.com,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc
 FS
Message-ID: <202409080315.xFbJCdN5-lkp@intel.com>
References: <20240905212741.143626-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905212741.143626-2-romank@linux.microsoft.com>

Hi Roman,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ad618736883b8970f66af799e34007475fe33a68]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Kisel/ptrace-Get-tracer-PID-without-reliance-on-the-proc-FS/20240906-085121
base:   ad618736883b8970f66af799e34007475fe33a68
patch link:    https://lore.kernel.org/r/20240905212741.143626-2-romank%40linux.microsoft.com
patch subject: [PATCH 1/1] ptrace: Get tracer PID without reliance on the proc FS
config: x86_64-randconfig-122-20240907 (https://download.01.org/0day-ci/archive/20240908/202409080315.xFbJCdN5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240908/202409080315.xFbJCdN5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409080315.xFbJCdN5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/ptrace.c:55:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:55:22: sparse:    struct task_struct *
   kernel/ptrace.c:55:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:74:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *parent @@     got struct task_struct *new_parent @@
   kernel/ptrace.c:74:23: sparse:     expected struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:74:23: sparse:     got struct task_struct *new_parent
   kernel/ptrace.c:75:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *ptracer_cred @@     got struct cred const * @@
   kernel/ptrace.c:75:29: sparse:     expected struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:75:29: sparse:     got struct cred const *
   kernel/ptrace.c:129:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   kernel/ptrace.c:129:18: sparse:     expected struct cred const *old_cred
   kernel/ptrace.c:129:18: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:133:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:133:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:133:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:160:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:160:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:160:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:192:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:192:28: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:192:28: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:198:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:198:30: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:198:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:251:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:251:44: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:251:44: sparse:    struct task_struct *
   kernel/ptrace.c:494:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/ptrace.c:494:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:494:54: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:502:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:502:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:502:53: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:550:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:550:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:550:41: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:552:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sigh @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/ptrace.c:552:50: sparse:     expected struct sighand_struct *sigh
   kernel/ptrace.c:552:50: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/ptrace.c:743:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:743:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:743:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:751:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:751:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:751:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:862:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:862:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:862:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:866:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:866:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:866:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1096:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1096:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1096:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1098:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1098:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1098:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:754:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:754:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:754:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:380:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *l @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:380:30: sparse:     expected struct spinlock [usertype] *l
   kernel/ptrace.c:380:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:456:17: sparse: sparse: context imbalance in 'ptrace_attach' - different lock contexts for basic block
   kernel/ptrace.c:500:38: sparse: sparse: dereference of noderef expression
   include/linux/sched/signal.h:754:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:754:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:754:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:690:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:754:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:754:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:754:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:706:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:754:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:754:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:754:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:754:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:754:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:754:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1255:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block
>> kernel/ptrace.c:1284:67: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/ptrace.c:1284:67: sparse:     expected struct task_struct *tsk
   kernel/ptrace.c:1284:67: sparse:     got struct task_struct [noderef] __rcu *parent

vim +1284 kernel/ptrace.c

  1257	
  1258	SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
  1259			unsigned long, data)
  1260	{
  1261		struct task_struct *child, *tracer;
  1262		long ret;
  1263	
  1264		if (request == PTRACE_TRACEME) {
  1265			ret = ptrace_traceme();
  1266			goto out;
  1267		}
  1268	
  1269		child = find_get_task_by_vpid(pid);
  1270		if (!child) {
  1271			ret = -ESRCH;
  1272			goto out;
  1273		}
  1274	
  1275		if (request == PTRACE_ATTACH || request == PTRACE_SEIZE) {
  1276			ret = ptrace_attach(child, request, addr, data);
  1277			goto out_put_task_struct;
  1278		}
  1279	
  1280		if (request == PTRACE_TRACER) {
  1281			rcu_read_lock();
  1282			tracer = ptrace_parent(current);
  1283			ret = tracer ? task_pid_nr_ns(tracer,
> 1284						task_active_pid_ns(current->parent)) : -ESRCH;
  1285			rcu_read_unlock();
  1286			goto out;
  1287		}
  1288	
  1289		ret = ptrace_check_attach(child, request == PTRACE_KILL ||
  1290					  request == PTRACE_INTERRUPT);
  1291		if (ret < 0)
  1292			goto out_put_task_struct;
  1293	
  1294		ret = arch_ptrace(child, request, addr, data);
  1295		if (ret || request != PTRACE_DETACH)
  1296			ptrace_unfreeze_traced(child);
  1297	
  1298	 out_put_task_struct:
  1299		put_task_struct(child);
  1300	 out:
  1301		return ret;
  1302	}
  1303	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


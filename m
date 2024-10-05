Return-Path: <linux-kernel+bounces-352071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 476399919C8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 20:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11EAB20F46
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 18:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB3A1369BC;
	Sat,  5 Oct 2024 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P9eClJeT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D2B158D92
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728154769; cv=none; b=c544cYutGfYJloe6bVFLBtA7AdBUQF+mL4NCXUzGeIobOzLNS6BhTu5SJtWTJ8M1vfhF/kUrA48ecT8w/a80ngCarjdYZYhdoDpTMgk6XC4jQotVfp8PjjUrX1ZVU3hNzr2no50XLyvB4PklQCAD/Yv9QYe/OeV1hPtAVQhLfok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728154769; c=relaxed/simple;
	bh=v0kGb/c/eiLt64g20rn7RmQb84p7f+t3kzuiU6zSctQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=iK+WdIvIs5pazv98xOmiaQ+bJ675gAfdAJnINl1NzGYe8dHwUFe/H+lZuTig5TzwWlHM8TxsRWV93g6f1hxlNKbkH+BwKj50q98IueRZeMOuQ83MPigBLRSZ+Hp5RUaTdbGruLVXoLJLML73YiokJmOZmakGzPvoKV4Vm0Br8QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P9eClJeT; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728154767; x=1759690767;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v0kGb/c/eiLt64g20rn7RmQb84p7f+t3kzuiU6zSctQ=;
  b=P9eClJeTpuDWMJBRdtttWqd+lr08Bsdtf3fIhNiOpI/x6oyAqaZghN1H
   Kr3yfRwkXMtmzPJcHIDXw6vgsW8M6rB8HOIZMNBHQ09m1vt5OuvZNe2tu
   bKyTb1JMg0+KQsdKhYKbeqG1njz4kCrN6pvhzFexJ7IVvPEseIDbuvy7e
   BgzBxSOgAxL6WHxBE7gOqaQBhd7x2ZtQLB22kaLOZW+M7sapmfe47isrV
   S3q/LUOJIQmiQzAC6EuHUwSWHtl7pFgsAkmC/jmXQaTgnmbcxkZVa3XYt
   OcLfG0tI9TwqyjPx8OFEYz3GqIimhoUBDECDbZKPtwVVb4DUPDRks4UD4
   w==;
X-CSE-ConnectionGUID: UNjRtVGXRrK9lxttmha3iw==
X-CSE-MsgGUID: V5A5RMKgROy4RbrxxDOs6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="26854226"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="26854226"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 11:59:27 -0700
X-CSE-ConnectionGUID: Lao4NQS4RfyWkXDVM2s5Eg==
X-CSE-MsgGUID: rp+AbNSxR9G+4zxppw84dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; 
   d="scan'208";a="75272808"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Oct 2024 11:59:25 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx9zu-0003HS-0o;
	Sat, 05 Oct 2024 18:59:22 +0000
Date: Sun, 6 Oct 2024 02:58:42 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/sched/core.c:1361:21: warning: 'uclamp_mutex' defined but not
 used
Message-ID: <202410060258.bPl2ZoUo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27cc6fdf720183dce1dbd293483ec5a9cb6b595e
commit: d2d6422f8bd17c6bb205133e290625a564194496 x86: Allow to enable PREEMPT_RT.
date:   3 weeks ago
config: x86_64-buildonly-randconfig-002-20241006 (https://download.01.org/0day-ci/archive/20241006/202410060258.bPl2ZoUo-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410060258.bPl2ZoUo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410060258.bPl2ZoUo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/seqlock.h:19,
                    from include/linux/dcache.h:11,
                    from include/linux/fs.h:8,
                    from include/linux/highmem.h:5,
                    from kernel/sched/core.c:10:
>> kernel/sched/core.c:1361:21: warning: 'uclamp_mutex' defined but not used [-Wunused-variable]
    1361 | static DEFINE_MUTEX(uclamp_mutex);
         |                     ^~~~~~~~~~~~
   include/linux/mutex.h:101:22: note: in definition of macro 'DEFINE_MUTEX'
     101 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                      ^~~~~~~~~


vim +/uclamp_mutex +1361 kernel/sched/core.c

71f8bd4600521f kernel/sched.c      Ingo Molnar     2007-07-09  1349  
69842cba9ace84 kernel/sched/core.c Patrick Bellasi 2019-06-21  1350  #ifdef CONFIG_UCLAMP_TASK
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1351  /*
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1352   * Serializes updates of utilization clamp values
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1353   *
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1354   * The (slow-path) user-space triggers utilization clamp value updates which
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1355   * can require updates on (fast-path) scheduler's data structures used to
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1356   * support enqueue/dequeue operations.
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1357   * While the per-CPU rq lock protects fast-path update operations, user-space
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1358   * requests are serialized using a mutex to reduce the risk of conflicting
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1359   * updates or API abuses.
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1360   */
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22 @1361  static DEFINE_MUTEX(uclamp_mutex);
2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1362  

:::::: The code at line 1361 was first introduced by commit
:::::: 2480c093130f64ac3a410504fa8b3db1fc4b87ce sched/uclamp: Extend CPU's cgroup controller

:::::: TO: Patrick Bellasi <patrick.bellasi@arm.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


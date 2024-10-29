Return-Path: <linux-kernel+bounces-387560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB549B52ED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4311C224D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57A92071ED;
	Tue, 29 Oct 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OIiBF6KI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8CE2022FC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231191; cv=none; b=X0IgXl5FKKKOXkQRmY3bQazVit2WTmHJp5TR63ZOJrnYFR4kN64B14J6xWDxj68pWB1RjJdroGdqJDp6ZSnb5ehtEH6KUFpqBSsLv6McFk/qPq2w4PORYDxKGmlcQxiqAOruL3soUKN+bBVGG9EXQgqNixNIaKjzX0fLj8NOw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231191; c=relaxed/simple;
	bh=Z7QlXf2YU3N/KNxyJHoQ6XPPBlvNC7WVHOGloOqRUaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RlpUgn7wXPsMR2SI7U9WCC0d3OiGNLA/mdf+dQJaVNZk4PlSIlvQgDQo+bnvd13+a5I+l96XXXbdSur6PclZJpQzVJEgpik6RxEJq7Fvm7hQRBGu92GV/wri1on3YzV37J0huhjXvLX9CilRN8xRjdBa6Ue8bB9oJl0eGnE8XBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OIiBF6KI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730231189; x=1761767189;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z7QlXf2YU3N/KNxyJHoQ6XPPBlvNC7WVHOGloOqRUaA=;
  b=OIiBF6KIZRBdbmjrCNmAVGBrjbaXV5e+l2mgtYt8YQtJDDR6jgyJ1GMC
   mCUzVFbm0iI7SA6t8LqkCje/t+RTRA9Dy5KtdaDihvxQrnDLJzDGjEuKY
   Cn0ief37C4i7gt7G3oDDe6Hpq54sodLO9lzI05zlMvuYPbuy1mPx7PXeX
   gwI6z0nChI57gXD4+o9/DB1VoNkNP34bZLDrW55cernucDwVImuuYpIAL
   5PD95dz8yeruOJsomeKG5SUsQOl2krpNJTJMnnQG/QsvW3M7dmh1Js4aF
   7NekGfhl/mI8HYMvraUI61OOf2l4oolkCICRv0ohOqMEKhPBKY67eFK9m
   Q==;
X-CSE-ConnectionGUID: pUPMmctBSm6erNAah9fIPw==
X-CSE-MsgGUID: Dln7pBxRQZmYJGNZy00MoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="33697676"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="33697676"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 12:46:29 -0700
X-CSE-ConnectionGUID: CZSNQkzOR7qRKNbF0VjDDQ==
X-CSE-MsgGUID: 3edRBEEIQ4m5jSHDhcTF3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="86630022"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 29 Oct 2024 12:46:26 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5sAa-000e4k-1O;
	Tue, 29 Oct 2024 19:46:24 +0000
Date: Wed, 30 Oct 2024 03:45:33 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Frederic Weisbecker <frederic@kernel.org>
Subject: [tip:timers/core 69/76] kernel/signal.c:1889:37: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202410300348.DgXPJOtf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
head:   1550dde8a537b35dbf066c7f9cfe5f9b360bce0d
commit: 2625b7efcee09ab43c108dfca6ea0b918897a1e8 [69/76] signal: Confine POSIX_TIMERS properly
config: x86_64-randconfig-121-20241029 (https://download.01.org/0day-ci/archive/20241030/202410300348.DgXPJOtf-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241030/202410300348.DgXPJOtf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410300348.DgXPJOtf-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/signal.c: note: in included file (through arch/x86/include/uapi/asm/signal.h, arch/x86/include/asm/signal.h, include/uapi/linux/signal.h, ...):
   include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
   kernel/signal.c:188:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:188:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:188:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:191:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:191:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:191:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:473:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:473:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:473:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:477:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:477:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:477:34: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:499:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct k_sigaction *ka @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:499:53: sparse:     expected struct k_sigaction *ka
   kernel/signal.c:499:53: sparse:     got struct k_sigaction [noderef] __rcu *
   include/uapi/asm-generic/signal-defs.h:83:29: sparse: sparse: multiple address spaces given
   kernel/signal.c:595:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/signal.c:595:9: sparse:     expected struct lockdep_map const *lock
   kernel/signal.c:595:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:692:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/signal.c:692:9: sparse:     expected struct lockdep_map const *lock
   kernel/signal.c:692:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:817:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/signal.c:817:9: sparse:     expected struct lockdep_map const *lock
   kernel/signal.c:817:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:1012:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct lockdep_map const *lock @@     got struct lockdep_map [noderef] __rcu * @@
   kernel/signal.c:1012:9: sparse:     expected struct lockdep_map const *lock
   kernel/signal.c:1012:9: sparse:     got struct lockdep_map [noderef] __rcu *
   kernel/signal.c:1264:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1264:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1264:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1265:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *action @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:1265:16: sparse:     expected struct k_sigaction *action
   kernel/signal.c:1265:16: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/signal.c:1286:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1286:34: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1286:34: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/signal.c:1889:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *l @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1889:37: sparse:     expected struct spinlock [usertype] *l
   kernel/signal.c:1889:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:1901:36: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:1901:36: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:1901:36: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2036:44: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2055:65: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2055:65: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2055:65: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2056:40: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2074:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *psig @@     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand @@
   kernel/signal.c:2074:14: sparse:     expected struct sighand_struct *psig
   kernel/signal.c:2074:14: sparse:     got struct sighand_struct [noderef] __rcu *[noderef] __rcu sighand
   kernel/signal.c:2103:53: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct task_struct *t @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2103:53: sparse:     expected struct task_struct *t
   kernel/signal.c:2103:53: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2104:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2104:34: sparse:     expected struct task_struct *parent
   kernel/signal.c:2104:34: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2133:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2133:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2133:24: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2136:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/signal.c:2136:24: sparse:     expected struct task_struct *parent
   kernel/signal.c:2136:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/signal.c:2169:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2169:17: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2169:17: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2209:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2209:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2209:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2211:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2211:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2211:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2268:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2268:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2268:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2326:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2326:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2326:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2366:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2366:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2366:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2368:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2368:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2368:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2466:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2466:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2466:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2550:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2550:41: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2550:41: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2562:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2562:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2562:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2605:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/signal.c:2605:52: sparse:     expected struct task_struct *tsk
   kernel/signal.c:2605:52: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/signal.c:2607:49: sparse: sparse: cast removes address space '__rcu' of expression
   kernel/signal.c:2645:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/signal.c:2645:49: sparse:     expected struct sighand_struct *sighand
   kernel/signal.c:2645:49: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/signal.c:2978:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2978:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2978:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:2999:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:2999:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:2999:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3066:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3066:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3066:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3068:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3068:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3068:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3219:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3219:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3219:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3222:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3222:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3222:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3611:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3611:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3611:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3623:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3623:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3623:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3628:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3628:35: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3628:35: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:3633:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:3633:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:3633:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4109:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4109:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4109:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4121:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/signal.c:4121:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/signal.c:4121:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/signal.c:4139:11: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct k_sigaction *k @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/signal.c:4139:11: sparse:     expected struct k_sigaction *k

vim +1889 kernel/signal.c

  1884	
  1885	void flush_itimer_signals(void)
  1886	{
  1887		struct task_struct *tsk = current;
  1888	
> 1889		guard(spinlock_irqsave)(&tsk->sighand->siglock);
  1890		__flush_itimer_signals(&tsk->pending);
  1891		__flush_itimer_signals(&tsk->signal->shared_pending);
  1892	}
  1893	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


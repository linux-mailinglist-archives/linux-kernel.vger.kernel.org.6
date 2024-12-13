Return-Path: <linux-kernel+bounces-445581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9959F17DF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 22:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED30188F81E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 21:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7D193073;
	Fri, 13 Dec 2024 21:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aq3XUL5V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBDF191F9C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734124506; cv=none; b=S8WR2pPkoosb4VCMylJ4ESCcyFo//4x6EoRLTmsfX7XpRNEtYBkUSAsvl3+9zHqp+8YV+AhZEzFvQuIVNg+2tPlXhlvTxvQRUg7VMXkuzC2gyM61QV/8tskyVxnnbnh4mnj11B3jDSwMe9avqIw5T3DtrU9sMp/XM04ZmiySaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734124506; c=relaxed/simple;
	bh=i/I3WpypbHaql9r4XIFq3Xili3XfK6hbJAIW+EanM+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SEKFKDCb9sKIM0qnHO+HIWTtAqUFpgyoSd1qBpuY/+pCrXK2vZqUfUWZnyIOh+JKIgBnOC1Gi7xQyJ8I1+ht4URKTd1FwDtS9RTiUk1XNb++aNWCwuc1CIU+be3gTVhoINtUK5Z85Xib8bplzrV4pxUQdZWnSIHeqtkRLsJYsQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aq3XUL5V; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734124504; x=1765660504;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i/I3WpypbHaql9r4XIFq3Xili3XfK6hbJAIW+EanM+M=;
  b=aq3XUL5VoYMDPJYVx9vowy1gXB7SXq2jwUD3W6jgp2K2eB7EziUoSZ0y
   tIyspraTtfleQ0WrAKXDfLqXO2WRSjz783XpGGIamUaLYFSv4gsMLfzRp
   7yGN0YYItlSvCXI6y4pghJv43BIO/nyTRz+bEJSMPkulJv2S/aEXT77Mb
   65JYaha1nMgYdTpliUe7dORC888loMridJZGZ0hjd1dJClHKv6LhtU/5p
   hFvFodxzgLylDzlan2lp2bZQSbE5sQbsGYHLWxe2gai15PuLG452wAzYC
   9NTlvUF/K2jK+vJcc5W12mVry+KWTiysnBV959QhJe+ygpAYfOUZnZd3E
   g==;
X-CSE-ConnectionGUID: QsGbZkxcTAauxgwCZ9B8lA==
X-CSE-MsgGUID: 0V4vNYF1QbOzQMvQ80c0ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="38367765"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="38367765"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 13:15:03 -0800
X-CSE-ConnectionGUID: wcE6vKNJTqyXaaD6yhFqww==
X-CSE-MsgGUID: skKwR9ZvRS6dFn/UBRG55A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97073971"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Dec 2024 13:15:01 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMCzy-000CR1-1H;
	Fri, 13 Dec 2024 21:14:58 +0000
Date: Sat, 14 Dec 2024 05:13:53 +0800
From: kernel test robot <lkp@intel.com>
To: Guo Ren <guoren@linux.alibaba.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Leonardo Bras <leobras@redhat.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andrea Parri <parri.andrea@gmail.com>
Subject: kernel/fork.c:1895:9: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202412140502.R7mSLuL5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   243f750a2df0662bc45119f9dd5d7da031a17f36
commit: cbe82e140bb76e1aa9f808cc841654a25b70d4e5 asm-generic: ticket-lock: Reuse arch_spinlock_t of qspinlock
date:   5 weeks ago
config: riscv-randconfig-r112-20241213 (https://download.01.org/0day-ci/archive/20241214/202412140502.R7mSLuL5-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241214/202412140502.R7mSLuL5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412140502.R7mSLuL5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/fork.c:1790:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:1790:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/fork.c:1790:38: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:1799:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1799:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1799:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:1800:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1800:9: sparse:     expected void const *
   kernel/fork.c:1800:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1800:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1800:9: sparse:     expected void const *
   kernel/fork.c:1800:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1800:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const * @@     got struct k_sigaction [noderef] __rcu * @@
   kernel/fork.c:1800:9: sparse:     expected void const *
   kernel/fork.c:1800:9: sparse:     got struct k_sigaction [noderef] __rcu *
   kernel/fork.c:1801:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:1801:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:1801:33: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/fork.c:1895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock [usertype] *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/fork.c:1895:9: sparse:     expected struct qspinlock [usertype] *lock
   kernel/fork.c:1895:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/fork.c:2193:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2193:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2193:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2197:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2197:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2197:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2511:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *real_parent @@     got struct task_struct * @@
   kernel/fork.c:2511:32: sparse:     expected struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:2511:32: sparse:     got struct task_struct *
   kernel/fork.c:2520:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2520:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2520:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2569:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct list_head *head @@     got struct list_head [noderef] __rcu * @@
   kernel/fork.c:2569:54: sparse:     expected struct list_head *head
   kernel/fork.c:2569:54: sparse:     got struct list_head [noderef] __rcu *
   kernel/fork.c:2589:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2589:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2589:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2611:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2611:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2611:29: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2639:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/fork.c:2639:28: sparse:     expected struct sighand_struct *sighand
   kernel/fork.c:2639:28: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/fork.c:2670:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2670:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2670:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:2672:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/fork.c:2672:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/fork.c:2672:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/fork.c:3115:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct *[assigned] parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/fork.c:3115:24: sparse:     expected struct task_struct *[assigned] parent
   kernel/fork.c:3115:24: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/fork.c:3203:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct const [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/fork.c:3203:43: sparse:     expected struct refcount_struct const [usertype] *r
   kernel/fork.c:3203:43: sparse:     got struct refcount_struct [noderef] __rcu *
   kernel/fork.c:2243:22: sparse: sparse: dereference of noderef expression
   kernel/fork.c: note: in included file (through include/linux/ftrace.h, include/linux/perf_event.h, include/linux/trace_events.h, ...):
   include/linux/ptrace.h:210:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *parent @@
   include/linux/ptrace.h:210:45: sparse:     expected struct task_struct *new_parent
   include/linux/ptrace.h:210:45: sparse:     got struct task_struct [noderef] __rcu *parent
   include/linux/ptrace.h:210:62: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected struct cred const *ptracer_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   include/linux/ptrace.h:210:62: sparse:     expected struct cred const *ptracer_cred
   include/linux/ptrace.h:210:62: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/fork.c:2567:59: sparse: sparse: dereference of noderef expression
   kernel/fork.c:2568:59: sparse: sparse: dereference of noderef expression
--
   kernel/seccomp.c:579:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:579:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:579:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:583:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:583:29: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:583:29: sparse:     got struct spinlock [noderef] __rcu *
>> kernel/seccomp.c:895:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock [usertype] *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/seccomp.c:895:9: sparse:     expected struct qspinlock [usertype] *lock
   kernel/seccomp.c:895:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/seccomp.c:1396:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1396:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1396:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1408:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1408:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1408:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1980:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1980:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1980:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1998:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1998:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1998:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:495:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock [usertype] *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/seccomp.c:495:9: sparse:     expected struct qspinlock [usertype] *lock
   kernel/seccomp.c:495:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/seccomp.c:602:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock [usertype] *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/seccomp.c:602:9: sparse:     expected struct qspinlock [usertype] *lock
   kernel/seccomp.c:602:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/seccomp.c:453:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock [usertype] *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/seccomp.c:453:9: sparse:     expected struct qspinlock [usertype] *lock
   kernel/seccomp.c:453:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/seccomp.c:439:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock [usertype] *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/seccomp.c:439:9: sparse:     expected struct qspinlock [usertype] *lock
   kernel/seccomp.c:439:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/seccomp.c:453:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock [usertype] *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/seccomp.c:453:9: sparse:     expected struct qspinlock [usertype] *lock
   kernel/seccomp.c:453:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/seccomp.c:439:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock [usertype] *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/seccomp.c:439:9: sparse:     expected struct qspinlock [usertype] *lock
   kernel/seccomp.c:439:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/seccomp.c:453:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct qspinlock [usertype] *lock @@     got struct qspinlock [noderef] __rcu * @@
   kernel/seccomp.c:453:9: sparse:     expected struct qspinlock [usertype] *lock
   kernel/seccomp.c:453:9: sparse:     got struct qspinlock [noderef] __rcu *
   kernel/seccomp.c: note: in included file (through include/linux/ptrace.h, include/linux/audit.h):
   include/linux/sched/signal.h:753:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:753:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:753:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:753:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:753:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:753:37: sparse:     got struct spinlock [noderef] __rcu *

vim +1895 kernel/fork.c

^1da177e4c3f41 Linus Torvalds          2005-04-16  1885  
dbd952127d11bb Kees Cook               2014-06-27  1886  static void copy_seccomp(struct task_struct *p)
dbd952127d11bb Kees Cook               2014-06-27  1887  {
dbd952127d11bb Kees Cook               2014-06-27  1888  #ifdef CONFIG_SECCOMP
dbd952127d11bb Kees Cook               2014-06-27  1889  	/*
dbd952127d11bb Kees Cook               2014-06-27  1890  	 * Must be called with sighand->lock held, which is common to
dbd952127d11bb Kees Cook               2014-06-27  1891  	 * all threads in the group. Holding cred_guard_mutex is not
dbd952127d11bb Kees Cook               2014-06-27  1892  	 * needed because this new task is not yet running and cannot
dbd952127d11bb Kees Cook               2014-06-27  1893  	 * be racing exec.
dbd952127d11bb Kees Cook               2014-06-27  1894  	 */
69f6a34bdeea4f Guenter Roeck           2014-08-10 @1895  	assert_spin_locked(&current->sighand->siglock);
dbd952127d11bb Kees Cook               2014-06-27  1896  
dbd952127d11bb Kees Cook               2014-06-27  1897  	/* Ref-count the new filter user, and assign it. */
dbd952127d11bb Kees Cook               2014-06-27  1898  	get_seccomp_filter(current);
dbd952127d11bb Kees Cook               2014-06-27  1899  	p->seccomp = current->seccomp;
dbd952127d11bb Kees Cook               2014-06-27  1900  
dbd952127d11bb Kees Cook               2014-06-27  1901  	/*
dbd952127d11bb Kees Cook               2014-06-27  1902  	 * Explicitly enable no_new_privs here in case it got set
dbd952127d11bb Kees Cook               2014-06-27  1903  	 * between the task_struct being duplicated and holding the
dbd952127d11bb Kees Cook               2014-06-27  1904  	 * sighand lock. The seccomp state and nnp must be in sync.
dbd952127d11bb Kees Cook               2014-06-27  1905  	 */
dbd952127d11bb Kees Cook               2014-06-27  1906  	if (task_no_new_privs(current))
dbd952127d11bb Kees Cook               2014-06-27  1907  		task_set_no_new_privs(p);
dbd952127d11bb Kees Cook               2014-06-27  1908  
dbd952127d11bb Kees Cook               2014-06-27  1909  	/*
dbd952127d11bb Kees Cook               2014-06-27  1910  	 * If the parent gained a seccomp mode after copying thread
dbd952127d11bb Kees Cook               2014-06-27  1911  	 * flags and between before we held the sighand lock, we have
dbd952127d11bb Kees Cook               2014-06-27  1912  	 * to manually enable the seccomp thread flag here.
dbd952127d11bb Kees Cook               2014-06-27  1913  	 */
dbd952127d11bb Kees Cook               2014-06-27  1914  	if (p->seccomp.mode != SECCOMP_MODE_DISABLED)
23d67a54857a76 Gabriel Krisman Bertazi 2020-11-16  1915  		set_task_syscall_work(p, SECCOMP);
dbd952127d11bb Kees Cook               2014-06-27  1916  #endif
dbd952127d11bb Kees Cook               2014-06-27  1917  }
dbd952127d11bb Kees Cook               2014-06-27  1918  

:::::: The code at line 1895 was first introduced by commit
:::::: 69f6a34bdeea4fec50bb90619bc9602973119572 seccomp: Replace BUG(!spin_is_locked()) with assert_spin_lock

:::::: TO: Guenter Roeck <linux@roeck-us.net>
:::::: CC: Kees Cook <keescook@chromium.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


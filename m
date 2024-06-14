Return-Path: <linux-kernel+bounces-215003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE63908D2B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251DC1C21090
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A50DF55;
	Fri, 14 Jun 2024 14:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K+SXoxdU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EFB945A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374632; cv=none; b=PqNc6uVBneY7ipCnFsalYzRfUWyFsEcXI9KxbmMC4NjnveTjvDiBZeD4h3ISMMiup5gipxNjpfK/IM1ErIWOVmw7skxsJpHUCdECjj1Pg/a6fbN175UUzDSmI/rcc6iIVBhM8fA14HNcfq9Vl++lUb7Fat5x0HrUKhO24gEpxRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374632; c=relaxed/simple;
	bh=ww06/t/dzrMah/x1DiGi9NhFCrKyNcnUiKPQyONZxgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZAPt4/hO7KtWtBC48C3D6FhbekaKV9FIAnElQkl8+MTz5AwTuhiycyHCR9Abbh2MAmrFJRFLDukSiDDS+PNtd+PHc3GlanxgkiW7smJwA+M4AbxyB3RjUs1oKNSY9M4ujVHTZx2qNdyPJhX9PILqWd4dYdT9UFhZzDVM4K1JQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K+SXoxdU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718374630; x=1749910630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ww06/t/dzrMah/x1DiGi9NhFCrKyNcnUiKPQyONZxgM=;
  b=K+SXoxdUxmifijPLX98bLlAqMQICrMQrDDi9M6prLXlaFg9DtSeQCfax
   tXTzKo1Ja1Y8BuNksycIMTMzzRL4RdTOr6WEXrxy5n24XOuIRG2iLu8OS
   xENywx4b+1MgQ9mkvgMxl11JCjR43UDvT3MNjYWhHpn2KNWM5nCfjE2li
   rMGew3+TI8eflDE9HxT9QHD8ASdYy2r0upJcpXwIboIpo7E3tXFOABnUi
   61NbWvOuEbooTH9NnUBZCcuTKxwd/gnzDVmtDIjRKlaYU46DlqFNau1OW
   ZHwqP/a1H1ztxn/OT8avs94+QXzgmjlXGay86wgrRjV32qDGlYbcOmFmS
   A==;
X-CSE-ConnectionGUID: zDnpRogES0SsI7Kc8dMYyw==
X-CSE-MsgGUID: V+G1GTXKQemoerx0Q6ZJvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19082659"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="19082659"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:17:06 -0700
X-CSE-ConnectionGUID: gkbRkiTiTRWR/ZU4vNOxUA==
X-CSE-MsgGUID: ZwbLxYX8T6CEVqgw3Jaopw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40599400"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Jun 2024 07:17:03 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sI7jh-0001Ng-1V;
	Fri, 14 Jun 2024 14:17:01 +0000
Date: Fri, 14 Jun 2024 22:16:27 +0800
From: kernel test robot <lkp@intel.com>
To: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	David Arcari <darcari@redhat.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] lockdep: Improve consistency between lockdep and
 hardware hardirqs states
Message-ID: <202406142144.VkJgWut4-lkp@intel.com>
References: <20240613142929.132220-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613142929.132220-1-longman@redhat.com>

Hi Waiman,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on linus/master v6.10-rc3 next-20240613]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Waiman-Long/lockdep-Improve-consistency-between-lockdep-and-hardware-hardirqs-states/20240613-223309
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20240613142929.132220-1-longman%40redhat.com
patch subject: [PATCH] lockdep: Improve consistency between lockdep and hardware hardirqs states
config: parisc-randconfig-001-20240614 (https://download.01.org/0day-ci/archive/20240614/202406142144.VkJgWut4-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240614/202406142144.VkJgWut4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406142144.VkJgWut4-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   WARNING: unmet direct dependencies detected for REGMAP_SPI
   Depends on [n]: SPI [=n]
   Selected by [y]:
   - AD9739A [=y] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])
   In file included from include/linux/lockdep_irqflags.h:5,
   from include/linux/irqflags.h:194,
   from include/asm-generic/cmpxchg-local.h:6,
   from arch/parisc/include/asm/cmpxchg.h:87,
   from arch/parisc/include/asm/atomic.h:10,
   from include/linux/atomic.h:7,
   from arch/parisc/include/asm/bitops.h:13,
   from include/linux/bitops.h:63,
   from include/linux/kernel.h:23,
   from arch/parisc/include/asm/bug.h:5,
   from include/linux/bug.h:5,
   from include/linux/page-flags.h:10,
   from kernel/bounds.c:10:
   include/linux/debug_locks.h: In function '__debug_locks_off':
   include/linux/debug_locks.h:16:16: error: implicit declaration of function 'xchg' [-Werror=implicit-function-declaration]
   16 |         return xchg(&debug_locks, 0);
   |                ^~~~
   In file included from include/asm-generic/preempt.h:5,
   from ./arch/parisc/include/generated/asm/preempt.h:1,
   from include/linux/preempt.h:79,
   from include/linux/lockdep_irqflags.h:7:
   include/linux/thread_info.h: In function 'set_ti_thread_flag':
   include/linux/thread_info.h:89:9: error: implicit declaration of function 'set_bit'; did you mean 'test_bit'? [-Werror=implicit-function-declaration]
   89 |         set_bit(flag, (unsigned long *)&ti->flags);
   |         ^~~~~~~
   |         test_bit
   include/linux/thread_info.h: In function 'clear_ti_thread_flag':
   include/linux/thread_info.h:94:9: error: implicit declaration of function 'clear_bit' [-Werror=implicit-function-declaration]
   94 |         clear_bit(flag, (unsigned long *)&ti->flags);
   |         ^~~~~~~~~
   include/linux/thread_info.h: In function 'test_and_set_ti_thread_flag':
   include/linux/thread_info.h:108:16: error: implicit declaration of function 'test_and_set_bit' [-Werror=implicit-function-declaration]
   108 |         return test_and_set_bit(flag, (unsigned long *)&ti->flags);
   |                ^~~~~~~~~~~~~~~~
   include/linux/thread_info.h: In function 'test_and_clear_ti_thread_flag':
   include/linux/thread_info.h:113:16: error: implicit declaration of function 'test_and_clear_bit'; did you mean 'const___clear_bit'? [-Werror=implicit-function-declaration]
   113 |         return test_and_clear_bit(flag, (unsigned long *)&ti->flags);
   |                ^~~~~~~~~~~~~~~~~~
   |                const___clear_bit
   include/linux/thread_info.h: In function 'test_ti_thread_flag':
   include/linux/bitops.h:56:47: error: implicit declaration of function '_test_bit'; did you mean 'test_bit'? [-Werror=implicit-function-declaration]
   56 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
   |                                               ^~~~~~~~~
   include/linux/bitops.h:48:32: note: in definition of macro 'bitop'
   48 |          const##op(nr, addr) : op(nr, addr))
   |                                ^~
   include/linux/thread_info.h:118:16: note: in expansion of macro 'test_bit'
   118 |         return test_bit(flag, (unsigned long *)&ti->flags);
   |                ^~~~~~~~
   include/linux/thread_info.h: In function 'check_copy_size':
>> include/linux/thread_info.h:249:13: error: implicit declaration of function 'WARN_ON_ONCE' [-Werror=implicit-function-declaration]
   249 |         if (WARN_ON_ONCE(bytes > INT_MAX))
   |             ^~~~~~~~~~~~
   In file included from include/linux/irqflags.h:17:
   include/linux/irqflags.h: In function 'class_irq_constructor':
   include/asm-generic/percpu.h:31:40: error: implicit declaration of function 'raw_smp_processor_id' [-Werror=implicit-function-declaration]
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   |                                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/cleanup.h:228:9: note: in definition of macro '__DEFINE_LOCK_GUARD_0'
   228 |         _lock;                                                                |         ^~~~~
   include/linux/irqflags.h:265:1: note: in expansion of macro 'DEFINE_LOCK_GUARD_0'
   265 | DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
   | ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:475:9: note: in expansion of macro '__compiletime_assert'
   475 |         __compiletime_assert(condition, msg, prefix, suffix)
   |         ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
   487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
   |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
   36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),        |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
   36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),        |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
   49 |         compiletime_assert_rwonce_type(x);                                    |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
   127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                             |                  ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
   231 |         RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
   |         ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   |                               ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
   31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
   |                         ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
   44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
   |                                                     ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
   242 |         arch_raw_cpu_ptr(ptr);                                                |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
   127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                             |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
   146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);               |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
   375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
   |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
   321 |         case 1: pscr_ret__ = stem##1(variable); break;                        |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
   489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
   |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/lockdep_irqflags.h:16:50: note: in expansion of macro 'this_cpu_read'
   16 | #define __lockdep_enabled       (debug_locks && !this_cpu_read(lockdep_recursion))
   |                                                  ^~~~~~~~~~~~~
   include/linux/lockdep_irqflags.h:25:22: note: in expansion of macro '__lockdep_enabled'
   25 |         WARN_ON_ONCE(__lockdep_enabled && this_cpu_read(hardirqs_enabled));       |                      ^~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:209:25: note: in expansion of macro 'lockdep_assert_irqs_disabled'
   209 |                         lockdep_assert_irqs_disabled();       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/irqflags.h:265:26: note: in expansion of macro 'local_irq_disable'
   265 | DEFINE_LOCK_GUARD_0(irq, local_irq_disable(), local_irq_enable())
   |                          ^~~~~~~~~~~~~~~~~
   arch/parisc/include/asm/bitops.h: At top level:
>> arch/parisc/include/asm/bitops.h:21:24: warning: conflicting types for 'set_bit'; have 'void(int,  volatile long unsigned int *)'
   21 | static __inline__ void set_bit(int nr, volatile unsigned long * addr)
   |                        ^~~~~~~
>> arch/parisc/include/asm/bitops.h:21:24: error: static declaration of 'set_bit' follows non-static declaration
   include/linux/thread_info.h:89:9: note: previous implicit declaration of 'set_bit' with type 'void(int,  volatile long unsigned int *)'
   89 |         set_bit(flag, (unsigned long *)&ti->flags);
   |         ^~~~~~~
>> arch/parisc/include/asm/bitops.h:32:24: warning: conflicting types for 'clear_bit'; have 'void(int,  volatile long unsigned int *)'
   32 | static __inline__ void clear_bit(int nr, volatile unsigned long * addr)
   |                        ^~~~~~~~~
>> arch/parisc/include/asm/bitops.h:32:24: error: static declaration of 'clear_bit' follows non-static declaration
   include/linux/thread_info.h:94:9: note: previous implicit declaration of 'clear_bit' with type 'void(int,  volatile long unsigned int *)'
   94 |         clear_bit(flag, (unsigned long *)&ti->flags);
   |         ^~~~~~~~~
>> arch/parisc/include/asm/bitops.h:54:23: error: static declaration of 'test_and_set_bit' follows non-static declaration
   54 | static __inline__ int test_and_set_bit(int nr, volatile unsigned long * addr)
   |                       ^~~~~~~~~~~~~~~~
   include/linux/thread_info.h:108:16: note: previous implicit declaration of 'test_and_set_bit' with type 'int()'
   108 |         return test_and_set_bit(flag, (unsigned long *)&ti->flags);
   |                ^~~~~~~~~~~~~~~~
>> arch/parisc/include/asm/bitops.h:72:23: error: static declaration of 'test_and_clear_bit' follows non-static declaration
   72 | static __inline__ int test_and_clear_bit(int nr, volatile unsigned long * addr)
   |                       ^~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:113:16: note: previous implicit declaration of 'test_and_clear_bit' with type 'int()'
   113 |         return test_and_clear_bit(flag, (unsigned long *)&ti->flags);
   |                ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1 shuffle=1782652799
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2 shuffle=1782652799
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2 shuffle=1782652799
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2 shuffle=1782652799
   make: Target 'prepare' not remade because of errors.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for REGMAP_SPI
   Depends on [n]: SPI [=n]
   Selected by [y]:
   - AD9739A [=y] && IIO [=y] && (SPI [=n] || COMPILE_TEST [=y])


vim +/WARN_ON_ONCE +249 include/linux/thread_info.h

^1da177e4c3f41 Linus Torvalds          2005-04-16  115  
^1da177e4c3f41 Linus Torvalds          2005-04-16  116  static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
^1da177e4c3f41 Linus Torvalds          2005-04-16  117  {
5548fecdff5617 Jeremy Fitzhardinge     2008-01-30 @118  	return test_bit(flag, (unsigned long *)&ti->flags);
^1da177e4c3f41 Linus Torvalds          2005-04-16  119  }
^1da177e4c3f41 Linus Torvalds          2005-04-16  120  
7ad639840acf28 Mark Rutland            2021-11-29  121  /*
7ad639840acf28 Mark Rutland            2021-11-29  122   * This may be used in noinstr code, and needs to be __always_inline to prevent
7ad639840acf28 Mark Rutland            2021-11-29  123   * inadvertent instrumentation.
7ad639840acf28 Mark Rutland            2021-11-29  124   */
7ad639840acf28 Mark Rutland            2021-11-29  125  static __always_inline unsigned long read_ti_thread_flags(struct thread_info *ti)
7ad639840acf28 Mark Rutland            2021-11-29  126  {
7ad639840acf28 Mark Rutland            2021-11-29  127  	return READ_ONCE(ti->flags);
7ad639840acf28 Mark Rutland            2021-11-29  128  }
7ad639840acf28 Mark Rutland            2021-11-29  129  
3b66a1edb01b82 Roman Zippel            2005-11-13  130  #define set_thread_flag(flag) \
3b66a1edb01b82 Roman Zippel            2005-11-13  131  	set_ti_thread_flag(current_thread_info(), flag)
3b66a1edb01b82 Roman Zippel            2005-11-13  132  #define clear_thread_flag(flag) \
3b66a1edb01b82 Roman Zippel            2005-11-13  133  	clear_ti_thread_flag(current_thread_info(), flag)
93ee37c2a6a97e Dave Martin             2018-04-11  134  #define update_thread_flag(flag, value) \
93ee37c2a6a97e Dave Martin             2018-04-11  135  	update_ti_thread_flag(current_thread_info(), flag, value)
3b66a1edb01b82 Roman Zippel            2005-11-13  136  #define test_and_set_thread_flag(flag) \
3b66a1edb01b82 Roman Zippel            2005-11-13  137  	test_and_set_ti_thread_flag(current_thread_info(), flag)
3b66a1edb01b82 Roman Zippel            2005-11-13  138  #define test_and_clear_thread_flag(flag) \
3b66a1edb01b82 Roman Zippel            2005-11-13  139  	test_and_clear_ti_thread_flag(current_thread_info(), flag)
3b66a1edb01b82 Roman Zippel            2005-11-13  140  #define test_thread_flag(flag) \
3b66a1edb01b82 Roman Zippel            2005-11-13  141  	test_ti_thread_flag(current_thread_info(), flag)
7ad639840acf28 Mark Rutland            2021-11-29  142  #define read_thread_flags() \
7ad639840acf28 Mark Rutland            2021-11-29  143  	read_ti_thread_flags(current_thread_info())
7ad639840acf28 Mark Rutland            2021-11-29  144  
7ad639840acf28 Mark Rutland            2021-11-29  145  #define read_task_thread_flags(t) \
7ad639840acf28 Mark Rutland            2021-11-29  146  	read_ti_thread_flags(task_thread_info(t))
3b66a1edb01b82 Roman Zippel            2005-11-13  147  
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  148  #ifdef CONFIG_GENERIC_ENTRY
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  149  #define set_syscall_work(fl) \
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  150  	set_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  151  #define test_syscall_work(fl) \
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  152  	test_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  153  #define clear_syscall_work(fl) \
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  154  	clear_bit(SYSCALL_WORK_BIT_##fl, &current_thread_info()->syscall_work)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  155  
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  156  #define set_task_syscall_work(t, fl) \
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  157  	set_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  158  #define test_task_syscall_work(t, fl) \
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  159  	test_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  160  #define clear_task_syscall_work(t, fl) \
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  161  	clear_bit(SYSCALL_WORK_BIT_##fl, &task_thread_info(t)->syscall_work)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  162  
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  163  #else /* CONFIG_GENERIC_ENTRY */
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  164  
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  165  #define set_syscall_work(fl)						\
5903f61e035320 Gabriel Krisman Bertazi 2020-11-23  166  	set_ti_thread_flag(current_thread_info(), TIF_##fl)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  167  #define test_syscall_work(fl) \
5903f61e035320 Gabriel Krisman Bertazi 2020-11-23  168  	test_ti_thread_flag(current_thread_info(), TIF_##fl)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  169  #define clear_syscall_work(fl) \
5903f61e035320 Gabriel Krisman Bertazi 2020-11-23  170  	clear_ti_thread_flag(current_thread_info(), TIF_##fl)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  171  
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  172  #define set_task_syscall_work(t, fl) \
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  173  	set_ti_thread_flag(task_thread_info(t), TIF_##fl)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  174  #define test_task_syscall_work(t, fl) \
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  175  	test_ti_thread_flag(task_thread_info(t), TIF_##fl)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  176  #define clear_task_syscall_work(t, fl) \
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  177  	clear_ti_thread_flag(task_thread_info(t), TIF_##fl)
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  178  #endif /* !CONFIG_GENERIC_ENTRY */
3136b93c3fb2b7 Gabriel Krisman Bertazi 2020-11-16  179  
e4df1511e1f4bc Peter Zijlstra          2023-01-12  180  #ifdef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
e4df1511e1f4bc Peter Zijlstra          2023-01-12  181  
e4df1511e1f4bc Peter Zijlstra          2023-01-12  182  static __always_inline bool tif_need_resched(void)
e4df1511e1f4bc Peter Zijlstra          2023-01-12  183  {
e4df1511e1f4bc Peter Zijlstra          2023-01-12  184  	return arch_test_bit(TIF_NEED_RESCHED,
e4df1511e1f4bc Peter Zijlstra          2023-01-12  185  			     (unsigned long *)(&current_thread_info()->flags));
e4df1511e1f4bc Peter Zijlstra          2023-01-12  186  }
e4df1511e1f4bc Peter Zijlstra          2023-01-12  187  
e4df1511e1f4bc Peter Zijlstra          2023-01-12  188  #else
e4df1511e1f4bc Peter Zijlstra          2023-01-12  189  
e4df1511e1f4bc Peter Zijlstra          2023-01-12  190  static __always_inline bool tif_need_resched(void)
e4df1511e1f4bc Peter Zijlstra          2023-01-12  191  {
e4df1511e1f4bc Peter Zijlstra          2023-01-12  192  	return test_bit(TIF_NEED_RESCHED,
e4df1511e1f4bc Peter Zijlstra          2023-01-12  193  			(unsigned long *)(&current_thread_info()->flags));
e4df1511e1f4bc Peter Zijlstra          2023-01-12  194  }
e4df1511e1f4bc Peter Zijlstra          2023-01-12  195  
e4df1511e1f4bc Peter Zijlstra          2023-01-12  196  #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
ea8117478918a4 Peter Zijlstra          2013-09-11  197  
0f60a8efe4005a Kees Cook               2016-07-12  198  #ifndef CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES
0f60a8efe4005a Kees Cook               2016-07-12  199  static inline int arch_within_stack_frames(const void * const stack,
0f60a8efe4005a Kees Cook               2016-07-12  200  					   const void * const stackend,
0f60a8efe4005a Kees Cook               2016-07-12  201  					   const void *obj, unsigned long len)
0f60a8efe4005a Kees Cook               2016-07-12  202  {
0f60a8efe4005a Kees Cook               2016-07-12  203  	return 0;
0f60a8efe4005a Kees Cook               2016-07-12  204  }
0f60a8efe4005a Kees Cook               2016-07-12  205  #endif
0f60a8efe4005a Kees Cook               2016-07-12  206  
f5509cc18daa7f Kees Cook               2016-06-07  207  #ifdef CONFIG_HARDENED_USERCOPY
f5509cc18daa7f Kees Cook               2016-06-07  208  extern void __check_object_size(const void *ptr, unsigned long n,
f5509cc18daa7f Kees Cook               2016-06-07  209  					bool to_user);
f5509cc18daa7f Kees Cook               2016-06-07  210  
a85d6b8242dc78 Kees Cook               2016-09-07  211  static __always_inline void check_object_size(const void *ptr, unsigned long n,
f5509cc18daa7f Kees Cook               2016-06-07  212  					      bool to_user)
f5509cc18daa7f Kees Cook               2016-06-07  213  {
81409e9e280588 Kees Cook               2016-08-31  214  	if (!__builtin_constant_p(n))
f5509cc18daa7f Kees Cook               2016-06-07  215  		__check_object_size(ptr, n, to_user);
f5509cc18daa7f Kees Cook               2016-06-07  216  }
f5509cc18daa7f Kees Cook               2016-06-07  217  #else
f5509cc18daa7f Kees Cook               2016-06-07  218  static inline void check_object_size(const void *ptr, unsigned long n,
f5509cc18daa7f Kees Cook               2016-06-07  219  				     bool to_user)
f5509cc18daa7f Kees Cook               2016-06-07  220  { }
f5509cc18daa7f Kees Cook               2016-06-07  221  #endif /* CONFIG_HARDENED_USERCOPY */
f5509cc18daa7f Kees Cook               2016-06-07  222  
b0377fedb65280 Al Viro                 2017-06-29  223  extern void __compiletime_error("copy source size is too small")
b0377fedb65280 Al Viro                 2017-06-29  224  __bad_copy_from(void);
b0377fedb65280 Al Viro                 2017-06-29  225  extern void __compiletime_error("copy destination size is too small")
b0377fedb65280 Al Viro                 2017-06-29  226  __bad_copy_to(void);
b0377fedb65280 Al Viro                 2017-06-29  227  
ad7489d5262d2a Christophe Leroy        2022-03-22  228  void __copy_overflow(int size, unsigned long count);
ad7489d5262d2a Christophe Leroy        2022-03-22  229  
b0377fedb65280 Al Viro                 2017-06-29  230  static inline void copy_overflow(int size, unsigned long count)
b0377fedb65280 Al Viro                 2017-06-29  231  {
ad7489d5262d2a Christophe Leroy        2022-03-22  232  	if (IS_ENABLED(CONFIG_BUG))
ad7489d5262d2a Christophe Leroy        2022-03-22  233  		__copy_overflow(size, count);
b0377fedb65280 Al Viro                 2017-06-29  234  }
b0377fedb65280 Al Viro                 2017-06-29  235  
9dd819a15162f8 Kees Cook               2019-09-25  236  static __always_inline __must_check bool
b0377fedb65280 Al Viro                 2017-06-29  237  check_copy_size(const void *addr, size_t bytes, bool is_source)
b0377fedb65280 Al Viro                 2017-06-29  238  {
c80d92fbb67b2c Kees Cook               2021-06-17  239  	int sz = __builtin_object_size(addr, 0);
b0377fedb65280 Al Viro                 2017-06-29  240  	if (unlikely(sz >= 0 && sz < bytes)) {
b0377fedb65280 Al Viro                 2017-06-29  241  		if (!__builtin_constant_p(bytes))
b0377fedb65280 Al Viro                 2017-06-29  242  			copy_overflow(sz, bytes);
b0377fedb65280 Al Viro                 2017-06-29  243  		else if (is_source)
b0377fedb65280 Al Viro                 2017-06-29  244  			__bad_copy_from();
b0377fedb65280 Al Viro                 2017-06-29  245  		else
b0377fedb65280 Al Viro                 2017-06-29  246  			__bad_copy_to();
b0377fedb65280 Al Viro                 2017-06-29  247  		return false;
b0377fedb65280 Al Viro                 2017-06-29  248  	}
6d13de1489b6bf Kees Cook               2019-12-04 @249  	if (WARN_ON_ONCE(bytes > INT_MAX))
6d13de1489b6bf Kees Cook               2019-12-04  250  		return false;
b0377fedb65280 Al Viro                 2017-06-29  251  	check_object_size(addr, bytes, is_source);
b0377fedb65280 Al Viro                 2017-06-29  252  	return true;
b0377fedb65280 Al Viro                 2017-06-29  253  }
b0377fedb65280 Al Viro                 2017-06-29  254  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


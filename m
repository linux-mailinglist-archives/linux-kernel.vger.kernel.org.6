Return-Path: <linux-kernel+bounces-215002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF39908D27
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB35EB24D78
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9E3C132;
	Fri, 14 Jun 2024 14:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0cNZqCh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD335C82
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374629; cv=none; b=pyXb5ZSQF+xwfv+uV0OQGJat7NAaKi5/tagUG3siT7TfPZ+steAf6DOqwjfGd0xSrGgf+K5Bl0q/NBa0vKo5quDlkNMZtwwM00XWBQzF2+al//jqsg1XlPYVfs8RbzfTB5ONLM8FNLLAzeKh2iv2ul+Qzg8EE7ASYdMyWiobNio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374629; c=relaxed/simple;
	bh=xzZRT8sl/z+bd+DuZkDfp5GuRyPfuGLdZkb20SAZQU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfvcUMHLk9R2evL14b8Kscke7RiipqvvNSJ+GwqLE4MejrMMEKM1Krh3Qryr3Qa/L0uVDuaGb4JQ7Bra03k89NRxB7GFYHcbRJj7uTKo8tVGDCt5VbsX2stCE3znQLn6FRK14BzkRF0p+gLCasOXUsdsv2TZZd6DAfz3HP67emo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0cNZqCh; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718374628; x=1749910628;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xzZRT8sl/z+bd+DuZkDfp5GuRyPfuGLdZkb20SAZQU8=;
  b=e0cNZqChWc3ctDsY6vkZiFS2jTejPCoHbECfL0voyiWKRBK16WLHnRj8
   X4SISDIlAntrL92MggxYTNPv+WEaWZ5keKePQvRYj+uuAGjCFctDzvhDe
   fATmZFzcsb1eq2n7mFFaYiYl6Q+vbLplTFjRWecgfHCEL6o25qBpyAvh5
   VdcJ6BdW8YlDx+Tpd17xXCl1IjqmJnSSc6lMGgZv8+1LmyGlHY2nqUwhJ
   1lgBvJRqjQuWHrv3UxugtHuaK24JjN99gJsV96bq95B6nJbmH2/nzt6Pg
   CcNoaHp77zU3CRtxKefGMZvlh7UvA6v7Y4SW380axR0G3dyCBSLKYZuTm
   Q==;
X-CSE-ConnectionGUID: mzhyx37+TDa75MbWupF3fw==
X-CSE-MsgGUID: /WZuenKRTZy98AdoRZ+aBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="19082654"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="19082654"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 07:17:05 -0700
X-CSE-ConnectionGUID: ll15Bps7RROf4F9ljvDVsw==
X-CSE-MsgGUID: 9JkiORmHQg6cm5hkSwykag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40599399"
Received: from lkp-server01.sh.intel.com (HELO 9e3ee4e9e062) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 14 Jun 2024 07:17:03 -0700
Received: from kbuild by 9e3ee4e9e062 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sI7jh-0001Nb-1K;
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
Message-ID: <202406142213.B8BPBsSw-lkp@intel.com>
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
config: csky-randconfig-002-20240614 (https://download.01.org/0day-ci/archive/20240614/202406142213.B8BPBsSw-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240614/202406142213.B8BPBsSw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406142213.B8BPBsSw-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/lockdep_irqflags.h:5,
                    from include/linux/irqflags.h:194,
                    from include/asm-generic/cmpxchg.h:15,
                    from arch/csky/include/asm/cmpxchg.h:162,
                    from include/asm-generic/atomic.h:12,
                    from arch/csky/include/asm/atomic.h:199,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/csky/include/asm/bitops.h:69,
                    from include/linux/bitops.h:63,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
   include/linux/debug_locks.h: In function '__debug_locks_off':
>> include/linux/debug_locks.h:16:16: error: implicit declaration of function 'xchg' [-Werror=implicit-function-declaration]
      16 |         return xchg(&debug_locks, 0);
         |                ^~~~
   In file included from arch/csky/include/asm/page.h:92,
                    from arch/csky/include/asm/thread_info.h:9,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/csky/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/lockdep_irqflags.h:7:
   include/asm-generic/getorder.h: In function 'get_order':
>> include/asm-generic/getorder.h:38:24: error: implicit declaration of function 'ilog2' [-Werror=implicit-function-declaration]
      38 |                 return ilog2((size) - 1) - PAGE_SHIFT + 1;
         |                        ^~~~~
   include/linux/thread_info.h: In function 'set_ti_thread_flag':
>> include/linux/thread_info.h:89:9: error: implicit declaration of function 'set_bit'; did you mean 'test_bit'? [-Werror=implicit-function-declaration]
      89 |         set_bit(flag, (unsigned long *)&ti->flags);
         |         ^~~~~~~
         |         test_bit
   include/linux/thread_info.h: In function 'clear_ti_thread_flag':
>> include/linux/thread_info.h:94:9: error: implicit declaration of function 'clear_bit' [-Werror=implicit-function-declaration]
      94 |         clear_bit(flag, (unsigned long *)&ti->flags);
         |         ^~~~~~~~~
   include/linux/thread_info.h: In function 'test_and_set_ti_thread_flag':
>> include/linux/thread_info.h:108:16: error: implicit declaration of function 'test_and_set_bit' [-Werror=implicit-function-declaration]
     108 |         return test_and_set_bit(flag, (unsigned long *)&ti->flags);
         |                ^~~~~~~~~~~~~~~~
   include/linux/thread_info.h: In function 'test_and_clear_ti_thread_flag':
>> include/linux/thread_info.h:113:16: error: implicit declaration of function 'test_and_clear_bit'; did you mean 'const___clear_bit'? [-Werror=implicit-function-declaration]
     113 |         return test_and_clear_bit(flag, (unsigned long *)&ti->flags);
         |                ^~~~~~~~~~~~~~~~~~
         |                const___clear_bit
   include/linux/thread_info.h: In function 'test_ti_thread_flag':
>> include/linux/bitops.h:56:47: error: implicit declaration of function '_test_bit'; did you mean 'test_bit'? [-Werror=implicit-function-declaration]
      56 | #define test_bit(nr, addr)              bitop(_test_bit, nr, addr)
         |                                               ^~~~~~~~~
   include/linux/bitops.h:48:32: note: in definition of macro 'bitop'
      48 |          const##op(nr, addr) : op(nr, addr))
         |                                ^~
   include/linux/thread_info.h:118:16: note: in expansion of macro 'test_bit'
     118 |         return test_bit(flag, (unsigned long *)&ti->flags);
         |                ^~~~~~~~
   In file included from include/asm-generic/bitops/atomic.h:68,
                    from arch/csky/include/asm/bitops.h:70:
   include/asm-generic/bitops/instrumented-atomic.h: At top level:
>> include/asm-generic/bitops/instrumented-atomic.h:26:29: warning: conflicting types for 'set_bit'; have 'void(long int,  volatile long unsigned int *)'
      26 | static __always_inline void set_bit(long nr, volatile unsigned long *addr)
         |                             ^~~~~~~
>> include/asm-generic/bitops/instrumented-atomic.h:26:29: error: static declaration of 'set_bit' follows non-static declaration
   include/linux/thread_info.h:89:9: note: previous implicit declaration of 'set_bit' with type 'void(long int,  volatile long unsigned int *)'
      89 |         set_bit(flag, (unsigned long *)&ti->flags);
         |         ^~~~~~~
>> include/asm-generic/bitops/instrumented-atomic.h:39:29: warning: conflicting types for 'clear_bit'; have 'void(long int,  volatile long unsigned int *)'
      39 | static __always_inline void clear_bit(long nr, volatile unsigned long *addr)
         |                             ^~~~~~~~~
>> include/asm-generic/bitops/instrumented-atomic.h:39:29: error: static declaration of 'clear_bit' follows non-static declaration
   include/linux/thread_info.h:94:9: note: previous implicit declaration of 'clear_bit' with type 'void(long int,  volatile long unsigned int *)'
      94 |         clear_bit(flag, (unsigned long *)&ti->flags);
         |         ^~~~~~~~~
>> include/asm-generic/bitops/instrumented-atomic.h:68:29: error: conflicting types for 'test_and_set_bit'; have 'bool(long int,  volatile long unsigned int *)' {aka '_Bool(long int,  volatile long unsigned int *)'}
      68 | static __always_inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
         |                             ^~~~~~~~~~~~~~~~
   include/linux/thread_info.h:108:16: note: previous implicit declaration of 'test_and_set_bit' with type 'int()'
     108 |         return test_and_set_bit(flag, (unsigned long *)&ti->flags);
         |                ^~~~~~~~~~~~~~~~
>> include/asm-generic/bitops/instrumented-atomic.h:82:29: error: conflicting types for 'test_and_clear_bit'; have 'bool(long int,  volatile long unsigned int *)' {aka '_Bool(long int,  volatile long unsigned int *)'}
      82 | static __always_inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
         |                             ^~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:113:16: note: previous implicit declaration of 'test_and_clear_bit' with type 'int()'
     113 |         return test_and_clear_bit(flag, (unsigned long *)&ti->flags);
         |                ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[3]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1 shuffle=1930064556
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1208: prepare0] Error 2 shuffle=1930064556
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:240: __sub-make] Error 2 shuffle=1930064556
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:240: __sub-make] Error 2 shuffle=1930064556
   make: Target 'prepare' not remade because of errors.


vim +/xchg +16 include/linux/debug_locks.h

9a11b49a805665 Ingo Molnar         2006-07-03  12  
9eeba6138cefc0 Frederic Weisbecker 2009-04-11  13  
6eebad1ad303db Peter Zijlstra      2020-06-03  14  static __always_inline int __debug_locks_off(void)
9eeba6138cefc0 Frederic Weisbecker 2009-04-11  15  {
9eeba6138cefc0 Frederic Weisbecker 2009-04-11 @16  	return xchg(&debug_locks, 0);
9eeba6138cefc0 Frederic Weisbecker 2009-04-11  17  }
9eeba6138cefc0 Frederic Weisbecker 2009-04-11  18  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


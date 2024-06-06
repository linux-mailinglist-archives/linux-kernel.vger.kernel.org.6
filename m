Return-Path: <linux-kernel+bounces-205000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFC98FF604
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A36B41C25310
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CC719A2A2;
	Thu,  6 Jun 2024 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvH8u3Jk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3111E13D280
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706113; cv=none; b=u3vkFTcSNnn2g0Mc+e7hxRPzqH4OFkVo2ml40Rb1L8GxUY4anVuARkb/txMOg137xx/F7e5FS4tXBrAANoQuOYani1r5xgPp6CbPDuaFCGvlp5z60E/ku5MHZsMkpAZvH65VxUJkReWbJ9xeYcz0MQMWxvOBTeuIuV57JS2oIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706113; c=relaxed/simple;
	bh=HgzW/erQQ7U3VviKff4iB4lDWZvOJ11pfSzFImr5Fx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNrRcPBgVKOxRFxFAJt9B+x+N9wG8xzZBgTOuyYS9pS8T7aEjzFsR0jN6TOviHAgub/Ogp96s+x+TFgOmF6J30T5M81v9jn+HLYp348BVY9ZmQvOhs6a8vihV0fC3wSvIEP5jJFvmo8mLc766Q+YnbEpfx567Xyo74MpfEsaa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvH8u3Jk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717706110; x=1749242110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HgzW/erQQ7U3VviKff4iB4lDWZvOJ11pfSzFImr5Fx4=;
  b=IvH8u3JkUoBXgFBDM/1NELcp65EO7KoeqREcYKfI7nQ5yzd6iCnOiufx
   T6EYwi5R363S5geu2zIkX7zGhQLoWj7i9ycLNaCuPv1HGyN+pE8Mx+LQY
   hmkVt7bI1xtcbtzZfZOHGW1+b55cdYHHXALjSs8OXIbhb397o5kz8alhT
   GayGYpqOFOZLnYNLwdRHVD7m21kiOdyDZkUD+Og33bSW0QURbtcvvctQd
   8vWwpccHQy5NEZY2rRjgaGmGF8Xrj2dPqnlgXAk65iEr4OaGqkNihXQRD
   emgKkeNfn61gkOPR8SbH4ZaBRar5CinuXhtUBsaflMAreq/cGDl+MfBC3
   w==;
X-CSE-ConnectionGUID: TM4KLn4+QTCtpFqJsGi7bA==
X-CSE-MsgGUID: GChx34LHS3a4lJZ3n1K1ig==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14244957"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14244957"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 13:35:09 -0700
X-CSE-ConnectionGUID: ThyzqUc4Qg2uIqiIi/Xw2w==
X-CSE-MsgGUID: bucYLtpDSgWnnGNo1gn+Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="37943319"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 06 Jun 2024 13:35:07 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFJpB-0003gK-1i;
	Thu, 06 Jun 2024 20:35:05 +0000
Date: Fri, 7 Jun 2024 04:34:08 +0800
From: kernel test robot <lkp@intel.com>
To: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: possible deadlock in trie_delete_elem
Message-ID: <202406070409.D0Nkzcbj-lkp@intel.com>
References: <000000000000277099061a394d13@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000277099061a394d13@google.com>

Hi syzbot,

kernel test robot noticed the following build errors:

[auto build test ERROR on bpf-next/master]
[also build test ERROR on bpf/master linus/master v6.10-rc2 next-20240606]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/syzbot/possible-deadlock-in-trie_delete_elem/20240606-230435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
patch link:    https://lore.kernel.org/r/000000000000277099061a394d13%40google.com
patch subject: possible deadlock in trie_delete_elem
config: sh-defconfig (https://download.01.org/0day-ci/archive/20240607/202406070409.D0Nkzcbj-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070409.D0Nkzcbj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070409.D0Nkzcbj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/percpu.h:7,
                    from ./arch/sh/include/generated/asm/percpu.h:1,
                    from include/linux/irqflags.h:19,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sh/include/asm/cmpxchg.h:74,
                    from arch/sh/include/asm/atomic.h:19,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sh/include/asm/bitops.h:63,
                    from include/linux/bitops.h:63,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/sh/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from kernel/tracepoint.c:5:
   kernel/tracepoint.c: In function 'debug_print_probes':
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/percpu-defs.h:318:16: note: in definition of macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/percpu-defs.h:219:54: note: in definition of macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/percpu-defs.h:320:23: note: in definition of macro '__pcpu_size_call_return'
     320 |         switch(sizeof(variable)) {                                      \
         |                       ^~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/asm-generic/percpu.h:144:16: note: in definition of macro 'this_cpu_generic_read'
     144 |         typeof(pcp) __ret;                                              \
         |                ^~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
   In file included from <command-line>:
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:454:17: note: in definition of macro '__native_word'
     454 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                 ^
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:454:46: note: in definition of macro '__native_word'
     454 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                              ^
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:455:17: note: in definition of macro '__native_word'
     455 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                 ^
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:455:45: note: in definition of macro '__native_word'
     455 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                             ^
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/asm-generic/percpu.h:125:16: note: in definition of macro '__this_cpu_generic_read_nopreempt'
     125 |         typeof(pcp) ___ret;                                             \
         |                ^~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:241:9: note: in expansion of macro '__verify_pcpu_ptr'
     241 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
     231 |         RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
         |         ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
     231 |         RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
         |         ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
     231 |         RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
         |         ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
     231 |         RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
         |         ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:241:9: note: in expansion of macro '__verify_pcpu_ptr'
     241 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
     231 |         RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
         |         ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
     231 |         RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
         |         ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
     231 |         RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
         |         ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
     231 |         RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
         |         ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
>> kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:241:9: note: in expansion of macro '__verify_pcpu_ptr'
     241 |         __verify_pcpu_ptr(ptr);                                         \
         |         ^~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
   kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:18: note: in expansion of macro 'READ_ONCE'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/linux/percpu-defs.h:231:9: note: in expansion of macro 'RELOC_HIDE'
     231 |         RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
         |         ^~~~~~~~~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:9: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:127:29: note: in expansion of macro 'raw_cpu_ptr'
     127 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                             ^~~~~~~~~~~
   include/asm-generic/percpu.h:146:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:375:41: note: in expansion of macro 'this_cpu_generic_read'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:30: note: in expansion of macro 'this_cpu_read_1'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:489:41: note: in expansion of macro '__pcpu_size_call_return'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/tracepoint.c:178:30: note: in expansion of macro 'this_cpu_read'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~
   kernel/tracepoint.c:178:50: error: invalid use of undefined type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                                  ^~
   include/linux/compiler_types.h:467:23: note: in definition of macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:487:9: note: in expansion of macro '_compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \


vim +178 kernel/tracepoint.c

   > 5	#include <linux/module.h>
     6	#include <linux/mutex.h>
     7	#include <linux/types.h>
     8	#include <linux/jhash.h>
     9	#include <linux/list.h>
    10	#include <linux/rcupdate.h>
    11	#include <linux/tracepoint.h>
    12	#include <linux/err.h>
    13	#include <linux/slab.h>
    14	#include <linux/sched/signal.h>
    15	#include <linux/sched/task.h>
    16	#include <linux/static_key.h>
    17	
    18	enum tp_func_state {
    19		TP_FUNC_0,
    20		TP_FUNC_1,
    21		TP_FUNC_2,
    22		TP_FUNC_N,
    23	};
    24	
    25	extern tracepoint_ptr_t __start___tracepoints_ptrs[];
    26	extern tracepoint_ptr_t __stop___tracepoints_ptrs[];
    27	
    28	DEFINE_SRCU(tracepoint_srcu);
    29	EXPORT_SYMBOL_GPL(tracepoint_srcu);
    30	
    31	enum tp_transition_sync {
    32		TP_TRANSITION_SYNC_1_0_1,
    33		TP_TRANSITION_SYNC_N_2_1,
    34	
    35		_NR_TP_TRANSITION_SYNC,
    36	};
    37	
    38	struct tp_transition_snapshot {
    39		unsigned long rcu;
    40		unsigned long srcu;
    41		bool ongoing;
    42	};
    43	
    44	/* Protected by tracepoints_mutex */
    45	static struct tp_transition_snapshot tp_transition_snapshot[_NR_TP_TRANSITION_SYNC];
    46	
    47	static void tp_rcu_get_state(enum tp_transition_sync sync)
    48	{
    49		struct tp_transition_snapshot *snapshot = &tp_transition_snapshot[sync];
    50	
    51		/* Keep the latest get_state snapshot. */
    52		snapshot->rcu = get_state_synchronize_rcu();
    53		snapshot->srcu = start_poll_synchronize_srcu(&tracepoint_srcu);
    54		snapshot->ongoing = true;
    55	}
    56	
    57	static void tp_rcu_cond_sync(enum tp_transition_sync sync)
    58	{
    59		struct tp_transition_snapshot *snapshot = &tp_transition_snapshot[sync];
    60	
    61		if (!snapshot->ongoing)
    62			return;
    63		cond_synchronize_rcu(snapshot->rcu);
    64		if (!poll_state_synchronize_srcu(&tracepoint_srcu, snapshot->srcu))
    65			synchronize_srcu(&tracepoint_srcu);
    66		snapshot->ongoing = false;
    67	}
    68	
    69	/* Set to 1 to enable tracepoint debug output */
    70	static const int tracepoint_debug;
    71	
    72	#ifdef CONFIG_MODULES
    73	/*
    74	 * Tracepoint module list mutex protects the local module list.
    75	 */
    76	static DEFINE_MUTEX(tracepoint_module_list_mutex);
    77	
    78	/* Local list of struct tp_module */
    79	static LIST_HEAD(tracepoint_module_list);
    80	#endif /* CONFIG_MODULES */
    81	
    82	/*
    83	 * tracepoints_mutex protects the builtin and module tracepoints.
    84	 * tracepoints_mutex nests inside tracepoint_module_list_mutex.
    85	 */
    86	static DEFINE_MUTEX(tracepoints_mutex);
    87	
    88	static struct rcu_head *early_probes;
    89	static bool ok_to_free_tracepoints;
    90	
    91	/*
    92	 * Note about RCU :
    93	 * It is used to delay the free of multiple probes array until a quiescent
    94	 * state is reached.
    95	 */
    96	struct tp_probes {
    97		struct rcu_head rcu;
    98		struct tracepoint_func probes[];
    99	};
   100	
   101	/* Called in removal of a func but failed to allocate a new tp_funcs */
   102	static void tp_stub_func(void)
   103	{
   104		return;
   105	}
   106	
   107	static inline void *allocate_probes(int count)
   108	{
   109		struct tp_probes *p  = kmalloc(struct_size(p, probes, count),
   110					       GFP_KERNEL);
   111		return p == NULL ? NULL : p->probes;
   112	}
   113	
   114	static void srcu_free_old_probes(struct rcu_head *head)
   115	{
   116		kfree(container_of(head, struct tp_probes, rcu));
   117	}
   118	
   119	static void rcu_free_old_probes(struct rcu_head *head)
   120	{
   121		call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
   122	}
   123	
   124	static __init int release_early_probes(void)
   125	{
   126		struct rcu_head *tmp;
   127	
   128		ok_to_free_tracepoints = true;
   129	
   130		while (early_probes) {
   131			tmp = early_probes;
   132			early_probes = tmp->next;
   133			call_rcu(tmp, rcu_free_old_probes);
   134		}
   135	
   136		return 0;
   137	}
   138	
   139	/* SRCU is initialized at core_initcall */
   140	postcore_initcall(release_early_probes);
   141	
   142	static inline void release_probes(struct tracepoint_func *old)
   143	{
   144		if (old) {
   145			struct tp_probes *tp_probes = container_of(old,
   146				struct tp_probes, probes[0]);
   147	
   148			/*
   149			 * We can't free probes if SRCU is not initialized yet.
   150			 * Postpone the freeing till after SRCU is initialized.
   151			 */
   152			if (unlikely(!ok_to_free_tracepoints)) {
   153				tp_probes->rcu.next = early_probes;
   154				early_probes = &tp_probes->rcu;
   155				return;
   156			}
   157	
   158			/*
   159			 * Tracepoint probes are protected by both sched RCU and SRCU,
   160			 * by calling the SRCU callback in the sched RCU callback we
   161			 * cover both cases. So let us chain the SRCU and sched RCU
   162			 * callbacks to wait for both grace periods.
   163			 */
   164			call_rcu(&tp_probes->rcu, rcu_free_old_probes);
   165		}
   166	}
   167	
   168	static void debug_print_probes(struct tracepoint_func *funcs)
   169	{
   170		int i;
   171		struct bpf_raw_tp_link *link;
   172	
   173		if (!tracepoint_debug || !funcs)
   174			return;
   175	
   176		for (i = 0; funcs[i].func; i++) {
   177			link = funcs[i].data;
 > 178			int active = this_cpu_read(*(link->link.prog->active));
   179			printk("Probe %d : %p / %p: %s/%d / %i\n", i,
   180					funcs[i].func,
   181					link,
   182					link->link.prog->aux->name,
   183					active,
   184					funcs[i].prio);
   185		}
   186	}
   187	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


Return-Path: <linux-kernel+bounces-205024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704418FF65D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EEC1C2555A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17D41991A0;
	Thu,  6 Jun 2024 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mz5CMrgT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67467197A7A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707993; cv=none; b=f8aFkq52ysNsLT+os5b8Hmlj0Y2R0em/EKnAlJp329lENodDlI+1BP8DO8Ib1iBtX4bNujnzldAtByJCPxD+KNt8NZBzHdMcbayAueh81kxXTWz+DIi+/Ax+mzdLqPsbgexxIjqsjpSLvK9XNXIoFToNqCYp2GytCkmgTU9AOS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707993; c=relaxed/simple;
	bh=myErEFKGd7WTw5a/R1ArvBSUdsAjVQ3aR0gIgnuUV9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBCd4dNj9sztFNAmCQLQ2ojMiEwqTV5/m2+Z58FDFO7inkpnvcPvGPd2gCYSGFrPRGlPj/PR4cepI8PZ5l3LxWlyCEHc6yma+MqNBAv0Cw7rLpGZFcQ8sKkZA520kdUGkCbQzfFO+0EjpKPZXZcSpseriXyOx4FIE2/bm7EFe9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mz5CMrgT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717707992; x=1749243992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=myErEFKGd7WTw5a/R1ArvBSUdsAjVQ3aR0gIgnuUV9c=;
  b=mz5CMrgTfpaboVxVq84zG9jTbt1rw9UQT7gop/9YOJsrWHgG0C3i3ax9
   WcQZeO4NtmRVv3qcaJ5b8LXJ4qW7UqDC6msn1Ar3sGVzZYyBfNlCo5wwU
   8GJfXvfWQ9065HtyZI7uy33vrViGYe6g2wL/fLLudAWCAEKfC/K4F3D9K
   g04BodclAd44EKX2l7NJhRbgOgCC+RHbuW7MFmZcUb4BBiKG3bn0ww/AV
   HmOl+EvS1o2s0vQtTg7ZIXo4/pE/IaGrRSc/WXN0AbBw/y7ksaGBHddyU
   OeQHgaWhSsw0axc39U8TJkQ+Vpf86tOI6DpmoRmfCxkSs3cyrfogU0v8q
   Q==;
X-CSE-ConnectionGUID: vISA5lWXTtW1gT3pxvEsHQ==
X-CSE-MsgGUID: 8g/SJ+uqRxqT6K2GA+z09Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="36933985"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="36933985"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 14:06:31 -0700
X-CSE-ConnectionGUID: 1UdwruAUTO2nx3yCepDPIQ==
X-CSE-MsgGUID: y1VKI3blScyvvxw+zorO4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38048841"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jun 2024 14:06:28 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFKJW-0003iy-20;
	Thu, 06 Jun 2024 21:06:26 +0000
Date: Fri, 7 Jun 2024 05:05:54 +0800
From: kernel test robot <lkp@intel.com>
To: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: possible deadlock in trie_delete_elem
Message-ID: <202406070456.Ke0WsZ9X-lkp@intel.com>
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
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240607/202406070456.Ke0WsZ9X-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project d7d2d4f53fc79b4b58e8d8d08151b577c3699d4a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070456.Ke0WsZ9X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070456.Ke0WsZ9X-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/tracepoint.c:5:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:173:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:500:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     500 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     501 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:507:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     507 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     508 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:519:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     519 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     520 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:528:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     528 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     529 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:318:9: note: expanded from macro '__pcpu_size_call_return'
     318 |         typeof(variable) pscr_ret__;                                    \
         |                ^~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:319:22: note: expanded from macro '__pcpu_size_call_return'
     319 |         __verify_pcpu_ptr(&(variable));                                 \
         |                             ^~~~~~~~
   include/linux/percpu-defs.h:219:47: note: expanded from macro '__verify_pcpu_ptr'
     219 |         const void __percpu *__vpp_verify = (typeof((ptr) + 0))NULL;    \
         |                                                      ^~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:320:16: note: expanded from macro '__pcpu_size_call_return'
     320 |         switch(sizeof(variable)) {                                      \
         |                       ^~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   include/asm-generic/percpu.h:144:9: note: expanded from macro 'this_cpu_generic_read'
     144 |         typeof(pcp) __ret;                                              \
         |                ^~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   include/asm-generic/percpu.h:145:20: note: expanded from macro 'this_cpu_generic_read'
     145 |         if (__native_word(pcp))                                         \
         |                           ^~~
   include/linux/compiler_types.h:454:10: note: expanded from macro '__native_word'
     454 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                 ^
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   include/asm-generic/percpu.h:145:20: note: expanded from macro 'this_cpu_generic_read'
     145 |         if (__native_word(pcp))                                         \
         |                           ^~~
   include/linux/compiler_types.h:454:39: note: expanded from macro '__native_word'
     454 |         (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         |                                              ^
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   include/asm-generic/percpu.h:145:20: note: expanded from macro 'this_cpu_generic_read'
     145 |         if (__native_word(pcp))                                         \
         |                           ^~~
   include/linux/compiler_types.h:455:10: note: expanded from macro '__native_word'
     455 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                 ^
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   include/asm-generic/percpu.h:145:20: note: expanded from macro 'this_cpu_generic_read'
     145 |         if (__native_word(pcp))                                         \
         |                           ^~~
   include/linux/compiler_types.h:455:38: note: expanded from macro '__native_word'
     455 |          sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
         |                                             ^
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   include/asm-generic/percpu.h:146:45: note: expanded from macro 'this_cpu_generic_read'
     146 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                                                           ^~~
   include/asm-generic/percpu.h:125:9: note: expanded from macro '__this_cpu_generic_read_nopreempt'
     125 |         typeof(pcp) ___ret;                                             \
         |                ^~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:487:22: note: expanded from macro 'compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:475:23: note: expanded from macro '_compiletime_assert'
     475 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:467:9: note: expanded from macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   note: (skipping 9 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:487:22: note: expanded from macro 'compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:475:23: note: expanded from macro '_compiletime_assert'
     475 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:467:9: note: expanded from macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   note: (skipping 9 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:487:22: note: expanded from macro 'compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:475:23: note: expanded from macro '_compiletime_assert'
     475 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:467:9: note: expanded from macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   note: (skipping 9 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:487:22: note: expanded from macro 'compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:475:23: note: expanded from macro '_compiletime_assert'
     475 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:467:9: note: expanded from macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   note: (skipping 9 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:487:22: note: expanded from macro 'compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:475:23: note: expanded from macro '_compiletime_assert'
     475 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:467:9: note: expanded from macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:16: error: indirection requires pointer operand ('void' invalid)
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:489:29: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:321:23: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                              ^~~~~~~~~~~~~~~~~
   <scratch space>:68:1: note: expanded from here
      68 | this_cpu_read_1
         | ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:487:22: note: expanded from macro 'compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:475:23: note: expanded from macro '_compiletime_assert'
     475 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:467:9: note: expanded from macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   note: (skipping 7 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:487:22: note: expanded from macro 'compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:475:23: note: expanded from macro '_compiletime_assert'
     475 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:467:9: note: expanded from macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   note: (skipping 9 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:487:22: note: expanded from macro 'compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:475:23: note: expanded from macro '_compiletime_assert'
     475 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:467:9: note: expanded from macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   note: (skipping 9 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:487:22: note: expanded from macro 'compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:475:23: note: expanded from macro '_compiletime_assert'
     475 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:467:9: note: expanded from macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
>> kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
     178 |                 int active = this_cpu_read(*(link->link.prog->active));
         |                                              ~~~~^
   include/linux/percpu-defs.h:489:69: note: expanded from macro 'this_cpu_read'
     489 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                                                                 ^~~
   include/linux/percpu-defs.h:321:31: note: expanded from macro '__pcpu_size_call_return'
     321 |         case 1: pscr_ret__ = stem##1(variable); break;                  \
         |                                      ^~~~~~~~
   include/asm-generic/percpu.h:375:53: note: expanded from macro 'this_cpu_read_1'
     375 | #define this_cpu_read_1(pcp)            this_cpu_generic_read(pcp)
         |                                                               ^~~
   note: (skipping 9 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:487:22: note: expanded from macro 'compiletime_assert'
     487 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                             ^~~~~~~~~
   include/linux/compiler_types.h:475:23: note: expanded from macro '_compiletime_assert'
     475 |         __compiletime_assert(condition, msg, prefix, suffix)
         |                              ^~~~~~~~~
   include/linux/compiler_types.h:467:9: note: expanded from macro '__compiletime_assert'
     467 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   kernel/tracepoint.c:171:9: note: forward declaration of 'struct bpf_raw_tp_link'
     171 |         struct bpf_raw_tp_link *link;
         |                ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   5 warnings and 20 errors generated.


vim +178 kernel/tracepoint.c

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


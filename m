Return-Path: <linux-kernel+bounces-183967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412758CA0BB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DD51C21258
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839C13793F;
	Mon, 20 May 2024 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9JP+zqv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5836227452
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716222705; cv=none; b=LHnnTgYlRJh7GcHHdrFbzk4vPIEbhG7rBhORcqC9xaj5XnckmygbsG1TVGfvGfoQ4tjIGnWS1RhPUrrr5k8ktcB+kd3ecB50TO1C1osYXbRsy2IABI5shPAG3vUKekiOBdbzDA0JmgAHlJZkB/gKUurQge6Jp0VO3HTCV9P/AXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716222705; c=relaxed/simple;
	bh=Dh+uJhI39asicZ2Tx302il4dLC2W4RA5ii2uGeQDU48=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oqVL1f6DH0oRjK6RK2N4woLL4tH7UbxGNealeoMaAOeTAJFfFbwx/nn0m0o0fgZ2Z/xDr6o15/N+Uj3JbHY7MAZtTdMgVzmYislP9m8nBsRPILTCIvDV/kgYmRD4Xjcys1cnTrBT7GMh3N6KVEiKWE4EDoXa5IPvfJW5JKlVcBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9JP+zqv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716222704; x=1747758704;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Dh+uJhI39asicZ2Tx302il4dLC2W4RA5ii2uGeQDU48=;
  b=I9JP+zqvXI0za8A2kwVeXaIm0yPvn7LrUxKZvOld5Qbt18BRk1UgqefT
   CybU839mPJPqzlP2owheSiwwb07FrrM5n7ObnMOMVaBmcvfGnYawXuqLB
   4rFgif7c2y3sO0HSkmP4jpoC+dKq51Kpby8HEJhYdfrv82n514RGy5r+O
   vwWuUSAOrooKy+PgPS+YfdsKXSPHgTTYDsi/t7jRM0gmYYBuZNreE5/7a
   tYoYgq+QFNsZsYTAcRozHs+sA/WnFOmp6gC+Aha9W9yRRPIzmPcrGj8+O
   7TxiuV9LS+FCJwGWuXZtG6Vn2y3dchmyApxPukE0Z/lIUSkTthJqYlCLZ
   g==;
X-CSE-ConnectionGUID: tnNvyE65RVyUyAYXLmLTrw==
X-CSE-MsgGUID: AkQqeqbTQaOkq222vJ9D9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="22969507"
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="22969507"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 09:31:43 -0700
X-CSE-ConnectionGUID: 6vd7fGjrTqmABDzbDSJZxg==
X-CSE-MsgGUID: R3Uus9y+RPapxvAB+VAZoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,175,1712646000"; 
   d="scan'208";a="32503159"
Received: from unknown (HELO 108735ec233b) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 20 May 2024 09:31:41 -0700
Received: from kbuild by 108735ec233b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s95vG-0004y9-1r;
	Mon, 20 May 2024 16:31:38 +0000
Date: Tue, 21 May 2024 00:31:18 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: include/asm-generic/percpu.h:31:40: error: implicit declaration of
 function 'raw_smp_processor_id'
Message-ID: <202405210052.DIrMXJNz-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   eb6a9339efeb6f3d2b5c86fdf2382cdc293eca2c
commit: 24e44cc22aa3112082f2ee23137d048c73ca96d5 mm: percpu: enable per-cpu allocation tagging
date:   4 weeks ago
config: mips-randconfig-r133-20240520 (https://download.01.org/0day-ci/archive/20240521/202405210052.DIrMXJNz-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240521/202405210052.DIrMXJNz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405210052.DIrMXJNz-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/compiler_types.h:151,
                    from <command-line>:
   include/linux/alloc_tag.h: In function '__alloc_tag_ref_set':
>> include/asm-generic/percpu.h:31:40: error: implicit declaration of function 'raw_smp_processor_id' [-Werror=implicit-function-declaration]
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:35:33: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                                 ^~~
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
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:72:10: note: in expansion of macro 'raw_cpu_ptr'
      72 |         *raw_cpu_ptr(&(pcp)) op val;                                    \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:156:9: note: in expansion of macro 'raw_cpu_generic_to_op'
     156 |         raw_cpu_generic_to_op(pcp, val, op);                            \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:401:41: note: in expansion of macro 'this_cpu_generic_to_op'
     401 | #define this_cpu_add_1(pcp, val)        this_cpu_generic_to_op(pcp, val, +=)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:365:25: note: in expansion of macro 'this_cpu_add_1'
     365 |                 case 1: stem##1(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:491:41: note: in expansion of macro '__pcpu_size_call'
     491 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:501:41: note: in expansion of macro 'this_cpu_add'
     501 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
         |                                         ^~~~~~~~~~~~
   include/linux/alloc_tag.h:117:9: note: in expansion of macro 'this_cpu_inc'
     117 |         this_cpu_inc(tag->counters->calls);
         |         ^~~~~~~~~~~~
   In file included from include/linux/smp.h:119,
                    from include/linux/percpu.h:8,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from include/drm/drm_util.h:35,
                    from drivers/gpu/drm/xe/xe_device.h:12,
                    from drivers/gpu/drm/xe/xe_bb.c:10:
   arch/mips/include/asm/smp.h: At top level:
>> arch/mips/include/asm/smp.h:26:19: error: static declaration of 'raw_smp_processor_id' follows non-static declaration
      26 | static inline int raw_smp_processor_id(void)
         |                   ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: previous implicit declaration of 'raw_smp_processor_id' with type 'int()'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                                        ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:35:33: note: in definition of macro 'RELOC_HIDE'
      35 |         (typeof(ptr)) (__ptr + (off));                                  \
         |                                 ^~~
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
     242 |         arch_raw_cpu_ptr(ptr);                                          \
         |         ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:72:10: note: in expansion of macro 'raw_cpu_ptr'
      72 |         *raw_cpu_ptr(&(pcp)) op val;                                    \
         |          ^~~~~~~~~~~
   include/asm-generic/percpu.h:156:9: note: in expansion of macro 'raw_cpu_generic_to_op'
     156 |         raw_cpu_generic_to_op(pcp, val, op);                            \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:401:41: note: in expansion of macro 'this_cpu_generic_to_op'
     401 | #define this_cpu_add_1(pcp, val)        this_cpu_generic_to_op(pcp, val, +=)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:365:25: note: in expansion of macro 'this_cpu_add_1'
     365 |                 case 1: stem##1(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:491:41: note: in expansion of macro '__pcpu_size_call'
     491 | #define this_cpu_add(pcp, val)          __pcpu_size_call(this_cpu_add_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:501:41: note: in expansion of macro 'this_cpu_add'
     501 | #define this_cpu_inc(pcp)               this_cpu_add(pcp, 1)
         |                                         ^~~~~~~~~~~~
   include/linux/alloc_tag.h:117:9: note: in expansion of macro 'this_cpu_inc'
     117 |         this_cpu_inc(tag->counters->calls);
         |         ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/raw_smp_processor_id +31 include/asm-generic/percpu.h

acdac87202a408 travis@sgi.com 2008-01-30  23  
acdac87202a408 travis@sgi.com 2008-01-30  24  /*
acdac87202a408 travis@sgi.com 2008-01-30  25   * Determine the offset for the currently active processor.
acdac87202a408 travis@sgi.com 2008-01-30  26   * An arch may define __my_cpu_offset to provide a more effective
acdac87202a408 travis@sgi.com 2008-01-30  27   * means of obtaining the offset to the per cpu variables of the
acdac87202a408 travis@sgi.com 2008-01-30  28   * current processor.
acdac87202a408 travis@sgi.com 2008-01-30  29   */
acdac87202a408 travis@sgi.com 2008-01-30  30  #ifndef __my_cpu_offset
acdac87202a408 travis@sgi.com 2008-01-30 @31  #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
1e8352784abaed Hugh Dickins   2008-02-23  32  #endif
1e8352784abaed Hugh Dickins   2008-02-23  33  #ifdef CONFIG_DEBUG_PREEMPT
acdac87202a408 travis@sgi.com 2008-01-30  34  #define my_cpu_offset per_cpu_offset(smp_processor_id())
acdac87202a408 travis@sgi.com 2008-01-30  35  #else
acdac87202a408 travis@sgi.com 2008-01-30  36  #define my_cpu_offset __my_cpu_offset
acdac87202a408 travis@sgi.com 2008-01-30  37  #endif
acdac87202a408 travis@sgi.com 2008-01-30  38  

:::::: The code at line 31 was first introduced by commit
:::::: acdac87202a408133ee8f7985076de9d2e0dc5ab percpu: make the asm-generic/percpu.h more "generic"

:::::: TO: travis@sgi.com <travis@sgi.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


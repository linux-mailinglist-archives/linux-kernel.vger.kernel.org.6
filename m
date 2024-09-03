Return-Path: <linux-kernel+bounces-313822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893196AA47
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D565D281F7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268201A4E82;
	Tue,  3 Sep 2024 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iI3Xs8P4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425281A4E7F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725399398; cv=none; b=cWNxJCG0tQRKuAWcZJf4pklgXKMQH4HBUH0q16nRroPwszpnQ00ziRtEmBcYen5j7efBDsXbubqkwtOLtpjslqVpbT7mmwn7xmP30RRTqCA+CL4RRHX5P+Bb9cishdsroxkr35qIIAXid4EBJijp3GZRTg3QjyD7VqA3NP5odOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725399398; c=relaxed/simple;
	bh=tcS3rnIaFXXmzrr6/T8DDKJoXnHxT9hQ8SPrgZrCsao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dM/ZBpUEYksgJ4LXNnmE8XoZtqCIf14amWZTvbhYGspigzgzYVaDwTIO76L7pp97WeVYXAyQI2mLZM/A4V/Q7jzRV2VQHeQAduQ3gzUprOV3W6iFDOpfUN6SB/YUIIRBNJut/nfGR478xy84PcovAfEZqnJPZlKhUWKpJ5eH+qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iI3Xs8P4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725399396; x=1756935396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tcS3rnIaFXXmzrr6/T8DDKJoXnHxT9hQ8SPrgZrCsao=;
  b=iI3Xs8P42TfJMLE7GunKzRciRg8EDwwcKlyx5x+VQQHPzuIzWTCDAZWA
   Ix9IhKttbsrOTgDMKYuypk8rssVsARVaBJrU3LzOTKEEXCBLvezvJ38DE
   WFM78NBaug+flLz0IljPabZY1aYt9B9Ewr943xKUTuqHuTKbHbT3JKsIk
   iPMccqATOomhICC7c4F+h8jHGEtiS7PziPGaFBW9hXGvad2iVhPNjfwW1
   CqJ6Um0dD1p3ovazijXzITMSZgdyKdPaO1OPSMUFBU8+ebngdKEC+N1ub
   FkNaSv+GPBeFM21a1fMOOQLZ/zBX8kND+adbiGxLa9w09poXV9XxU/W92
   Q==;
X-CSE-ConnectionGUID: R1ePGy3sTmyeKWJa1Bz1GA==
X-CSE-MsgGUID: DeTzFbiRShud+rag3XXWUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24142740"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="24142740"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 14:36:36 -0700
X-CSE-ConnectionGUID: US5dvX8aQ6KKTvTQgUzn1Q==
X-CSE-MsgGUID: b8elATLOR3KJeiQlNaO/1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69916558"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 03 Sep 2024 14:36:33 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slbCQ-00079s-0Z;
	Tue, 03 Sep 2024 21:36:30 +0000
Date: Wed, 4 Sep 2024 05:35:46 +0800
From: kernel test robot <lkp@intel.com>
To: Uros Bizjak <ubizjak@gmail.com>, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Uros Bizjak <ubizjak@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] longsoon/percpu: Simplify _percpu_read() and
 _percpu_write()
Message-ID: <202409040542.OSJFk9k7-lkp@intel.com>
References: <20240903102342.36957-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903102342.36957-1-ubizjak@gmail.com>

Hi Uros,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dennis-percpu/for-next]
[also build test WARNING on linus/master v6.11-rc6 next-20240903]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Uros-Bizjak/longsoon-percpu-Simplify-_percpu_read-and-_percpu_write/20240903-182524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-next
patch link:    https://lore.kernel.org/r/20240903102342.36957-1-ubizjak%40gmail.com
patch subject: [PATCH] longsoon/percpu: Simplify _percpu_read() and _percpu_write()
config: loongarch-loongson3_defconfig (https://download.01.org/0day-ci/archive/20240904/202409040542.OSJFk9k7-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240904/202409040542.OSJFk9k7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409040542.OSJFk9k7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/irqflags.h:19,
                    from include/linux/spinlock.h:59,
                    from include/linux/sched.h:2134,
                    from arch/loongarch/kernel/asm-offsets.c:8:
   include/linux/sched/mm.h: In function 'set_active_memcg':
>> arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/sched/mm.h:420:17: note: in expansion of macro 'this_cpu_write'
     420 |                 this_cpu_write(int_active_memcg, memcg);
         |                 ^~~~~~~~~~~~~~
--
   In file included from include/linux/percpu.h:13,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from kernel/panic.c:14:
   include/linux/sched/mm.h: In function 'set_active_memcg':
>> arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/sched/mm.h:420:17: note: in expansion of macro 'this_cpu_write'
     420 |                 this_cpu_write(int_active_memcg, memcg);
         |                 ^~~~~~~~~~~~~~
   kernel/panic.c: In function '__warn':
   kernel/panic.c:670:17: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     670 |                 vprintk(args->fmt, args->args);
         |                 ^~~~~~~
--
   In file included from include/linux/irqflags.h:19,
                    from include/linux/spinlock.h:59,
                    from include/linux/sched.h:2134,
                    from include/linux/sched/mm.h:7,
                    from kernel/cpu.c:6:
   include/linux/sched/mm.h: In function 'set_active_memcg':
>> arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/sched/mm.h:420:17: note: in expansion of macro 'this_cpu_write'
     420 |                 this_cpu_write(int_active_memcg, memcg);
         |                 ^~~~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:5077: Error: no match insn: stx.w	$r14 $r21,$r12
   {standard input}:5084: Error: no match insn: stx.w	$r14 $r21,$r12
--
   In file included from include/linux/irqflags.h:19,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from kernel/audit.c:38:
   include/linux/sched/mm.h: In function 'set_active_memcg':
>> arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/sched/mm.h:420:17: note: in expansion of macro 'this_cpu_write'
     420 |                 this_cpu_write(int_active_memcg, memcg);
         |                 ^~~~~~~~~~~~~~
   kernel/audit.c: In function 'audit_log_vformat':
   kernel/audit.c:1979:9: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1979 |         len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args);
         |         ^~~
   kernel/audit.c:1988:17: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1988 |                 len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
         |                 ^~~
--
   In file included from include/linux/irqflags.h:19,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from kernel/relay.c:17:
   include/linux/sched/mm.h: In function 'set_active_memcg':
>> arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/sched/mm.h:420:17: note: in expansion of macro 'this_cpu_write'
     420 |                 this_cpu_write(int_active_memcg, memcg);
         |                 ^~~~~~~~~~~~~~
   kernel/relay.c: In function 'relay_create_buf_file':
   kernel/relay.c:357:42: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
     357 |         snprintf(tmpname, NAME_MAX, "%s%d", chan->base_filename, cpu);
         |                                          ^
   kernel/relay.c:357:9: note: 'snprintf' output between 2 and 266 bytes into a destination of size 255
     357 |         snprintf(tmpname, NAME_MAX, "%s%d", chan->base_filename, cpu);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/irqflags.h:19,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from mm/slub.c:13:
   include/linux/sched/mm.h: In function 'set_active_memcg':
>> arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/sched/mm.h:420:17: note: in expansion of macro 'this_cpu_write'
     420 |                 this_cpu_write(int_active_memcg, memcg);
         |                 ^~~~~~~~~~~~~~
   mm/slub.c: In function 'put_partials':
   arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   mm/slub.c:2937:9: note: in expansion of macro 'this_cpu_write'
    2937 |         this_cpu_write(s->cpu_slab->partial, NULL);
         |         ^~~~~~~~~~~~~~
   mm/slub.c: In function 'put_cpu_partial':
   arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'struct slab *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   mm/slub.c:2992:9: note: in expansion of macro 'this_cpu_write'
    2992 |         this_cpu_write(s->cpu_slab->partial, slab);
         |         ^~~~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:8207: Error: no match insn: stx.d	$r13 $r21,$r14
   {standard input}:9031: Error: no match insn: stx.d	$r15 $r21,$r13
--
   In file included from include/linux/irqflags.h:19,
                    from include/linux/spinlock.h:59,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/highmem.h:5,
                    from include/linux/bvec.h:10,
                    from include/linux/blk_types.h:10,
                    from include/linux/blkdev.h:9,
                    from mm/swapfile.c:9:
   include/linux/sched/mm.h: In function 'set_active_memcg':
>> arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/sched/mm.h:420:17: note: in expansion of macro 'this_cpu_write'
     420 |                 this_cpu_write(int_active_memcg, memcg);
         |                 ^~~~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:1338: Error: no match insn: stx.w	$r5 $r21,$r12
--
   In file included from include/linux/irqflags.h:19,
                    from include/linux/spinlock.h:59,
                    from include/linux/sched.h:2134,
                    from include/linux/cgroup.h:12,
                    from include/linux/memcontrol.h:13,
                    from mm/memcontrol.c:29:
   include/linux/sched/mm.h: In function 'set_active_memcg':
>> arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/sched/mm.h:420:17: note: in expansion of macro 'this_cpu_write'
     420 |                 this_cpu_write(int_active_memcg, memcg);
         |                 ^~~~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:5759: Error: no match insn: stx.d	$r4 $r21,$r12
   {standard input}:5781: Error: no match insn: stx.d	$r25 $r21,$r12
--
   In file included from include/linux/irqflags.h:19,
                    from include/linux/rcupdate.h:26,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from fs/buffer.c:23:
   include/linux/sched/mm.h: In function 'set_active_memcg':
>> arch/loongarch/include/asm/percpu.h:85:33: warning: initialization of 'long unsigned int' from 'struct mem_cgroup *' makes integer from pointer without a cast [-Wint-conversion]
      85 | #define __pcpu_cast_8(val)      (val)
         |                                 ^
   arch/loongarch/include/asm/percpu.h:89:35: note: in expansion of macro '__pcpu_cast_8'
      89 |         unsigned long __pcp_val = __pcpu_cast_##size(_val);             \
         |                                   ^~~~~~~~~~~~
   arch/loongarch/include/asm/percpu.h:171:36: note: in expansion of macro '_percpu_write'
     171 | #define this_cpu_write_8(pcp, val) _percpu_write(8, pcp, val)
         |                                    ^~~~~~~~~~~~~
   include/linux/percpu-defs.h:368:25: note: in expansion of macro 'this_cpu_write_8'
     368 |                 case 8: stem##8(variable, __VA_ARGS__);break;           \
         |                         ^~~~
   include/linux/percpu-defs.h:490:41: note: in expansion of macro '__pcpu_size_call'
     490 | #define this_cpu_write(pcp, val)        __pcpu_size_call(this_cpu_write_, pcp, val)
         |                                         ^~~~~~~~~~~~~~~~
   include/linux/sched/mm.h:420:17: note: in expansion of macro 'this_cpu_write'
     420 |                 this_cpu_write(int_active_memcg, memcg);
         |                 ^~~~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:1678: Error: no match insn: stx.d	$r13 $r21,$r12
   {standard input}:1733: Error: no match insn: stx.d	$r28 $r21,$r12
..


vim +85 arch/loongarch/include/asm/percpu.h

    81	
    82	#define __pcpu_cast_1(val)	(((unsigned long) val) & 0xff)
    83	#define __pcpu_cast_2(val)	(((unsigned long) val) & 0xffff)
    84	#define __pcpu_cast_4(val)	(((unsigned long) val) & 0xffffffff)
  > 85	#define __pcpu_cast_8(val)	(val)
    86	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


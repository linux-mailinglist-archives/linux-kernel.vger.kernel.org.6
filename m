Return-Path: <linux-kernel+bounces-405581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBDE9C5318
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C408C1F26450
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC292123D6;
	Tue, 12 Nov 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObsaxiO8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB792123E1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406766; cv=none; b=Z7+wCgAnqtr1Ay72dami2fLYsJvUp2mFCtdI+VSl/MLD/DX5kK8pmjeg9lj4i5FrJoQjnVStaJ1+iHm3HkHk8mKup1Gecv9T32fMJeWQBEAsAuZrOoyoRNUyA6+ACpxbXEyKBPBbq+UoH/H7WIc3Eap+qiRK1QdC2H3BkhEUy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406766; c=relaxed/simple;
	bh=hOV0Cyam6/MaGDK/wCOTgJNkoOmx/0lpY0GypN54K+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFiJbdYL/ljFlvjwEeTGOD+EWZn7PmsR9rbcjEt2avDtX3mkGxgQTqYTHZTGM1cCdfvs/sqR0hy4P3WBPtFiKCHxz5dKp8bcI+/oe4wqw1uCZP8jp+LalQb2KRbKelbgIPjnWN+sWwOJot/v/IXDlRXj1H8kg3kTbQNVrxJTVOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObsaxiO8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731406763; x=1762942763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hOV0Cyam6/MaGDK/wCOTgJNkoOmx/0lpY0GypN54K+s=;
  b=ObsaxiO8wCxBjuGXOnW89falT4/h5sl30+kAUdTrGVqHyf6o7N/ih4To
   Hr82Ut8Q48ZYeygBwy++d+IbHK174po3XTxbOzeFYkgnfaKPqA6Trs6B6
   PwbpbL2W2fZZs/chXoTz4cfJZQb5Yr9sI/lMWHIXUony5ceVbz/IF2bjQ
   9UWi+B8La9UlVCsoFAR5g5aNfZ/LqMPisAP3QXhBGjC94+zPp3F2y7VHL
   pjdHwvprF+WQ62DLv2IIunaar4WZ2CBQzdPRLM3ptlgnOHpH1AdW5iPMi
   EcyRUQJv+JWYdCnt8UVrdP0d3AqTvqV1tejh9C46erWDPEdUNn+6BnYio
   Q==;
X-CSE-ConnectionGUID: kQ6gfpjaTVKVaxWPhET9aQ==
X-CSE-MsgGUID: dlt1pk3zQ4iA73sbUK3UGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31405567"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31405567"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 02:19:22 -0800
X-CSE-ConnectionGUID: OvNBB8TvQ8qCQI2O7h2cYQ==
X-CSE-MsgGUID: GV6Wll5HRcGYT+8l9mpCVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87802267"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2024 02:19:14 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAnzL-0000hp-20;
	Tue, 12 Nov 2024 10:19:11 +0000
Date: Tue, 12 Nov 2024 18:18:46 +0800
From: kernel test robot <lkp@intel.com>
To: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	willy@infradead.org, liam.howlett@oracle.com,
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz,
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
	hughd@google.com, minchan@google.com, jannh@google.com,
	shakeel.butt@linux.dev, souravpanda@google.com,
	pasha.tatashin@soleen.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	surenb@google.com
Subject: Re: [PATCH 2/4] mm: move per-vma lock into vm_area_struct
Message-ID: <202411121840.hE2wZKgE-lkp@intel.com>
References: <20241111205506.3404479-3-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111205506.3404479-3-surenb@google.com>

Hi Suren,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 931086f2a88086319afb57cd3925607e8cda0a9f]

url:    https://github.com/intel-lab-lkp/linux/commits/Suren-Baghdasaryan/mm-introduce-vma_start_read_locked-_nested-helpers/20241112-050531
base:   931086f2a88086319afb57cd3925607e8cda0a9f
patch link:    https://lore.kernel.org/r/20241111205506.3404479-3-surenb%40google.com
patch subject: [PATCH 2/4] mm: move per-vma lock into vm_area_struct
config: hexagon-randconfig-002-20241112 (https://download.01.org/0day-ci/archive/20241112/202411121840.hE2wZKgE-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121840.hE2wZKgE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121840.hE2wZKgE-lkp@intel.com/

All warnings (new ones prefixed by >>):

         |                            ^
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:187:1: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:174:10: note: expanded from macro '_SIG_SET_OP'
     174 |         case 4: set->sig[3] = op(set->sig[3]);                          \
         |                 ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:187:1: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:175:20: note: expanded from macro '_SIG_SET_OP'
     175 |                 set->sig[2] = op(set->sig[2]);                          \
         |                                  ^        ~
   include/linux/signal.h:186:24: note: expanded from macro '_sig_not'
     186 | #define _sig_not(x)     (~(x))
         |                            ^
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:1143:
   In file included from include/linux/huge_mm.h:7:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:187:1: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
     187 | _SIG_SET_OP(signotset, _sig_not)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/signal.h:175:3: note: expanded from macro '_SIG_SET_OP'
     175 |                 set->sig[2] = op(set->sig[2]);                          \
         |                 ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
      62 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2234:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:13:
   In file included from arch/hexagon/include/asm/dma.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:13:
   In file included from arch/hexagon/include/asm/dma.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:13:
   In file included from arch/hexagon/include/asm/dma.h:9:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> kernel/dma/direct.c:147:20: warning: shift count >= width of type [-Wshift-count-overflow]
     146 |                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     147 |                     phys_limit < DMA_BIT_MASK(64) &&
         |                     ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
     148 |                     !(gfp & (GFP_DMA32 | GFP_DMA))) {
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
>> kernel/dma/direct.c:147:20: warning: shift count >= width of type [-Wshift-count-overflow]
     146 |                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     147 |                     phys_limit < DMA_BIT_MASK(64) &&
         |                     ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
     148 |                     !(gfp & (GFP_DMA32 | GFP_DMA))) {
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:61: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
>> kernel/dma/direct.c:147:20: warning: shift count >= width of type [-Wshift-count-overflow]
     146 |                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     147 |                     phys_limit < DMA_BIT_MASK(64) &&
         |                     ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
     148 |                     !(gfp & (GFP_DMA32 | GFP_DMA))) {
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:77:54: note: expanded from macro 'DMA_BIT_MASK'
      77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:86: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:68:3: note: expanded from macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   38 warnings and 3 errors generated.
--
   In file included from drivers/iio/adc/fsl-imx25-gcq.c:12:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/iio/adc/fsl-imx25-gcq.c:12:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/iio/adc/fsl-imx25-gcq.c:12:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from drivers/iio/adc/fsl-imx25-gcq.c:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   include/linux/mm.h:877:2: error: call to undeclared function 'vma_lock_init'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     877 |         vma_lock_init(&vma->vm_lock);
         |         ^
   include/linux/mm.h:877:2: note: did you mean 'osq_lock_init'?
   include/linux/osq_lock.h:23:20: note: 'osq_lock_init' declared here
      23 | static inline void osq_lock_init(struct optimistic_spin_queue *lock)
         |                    ^
   In file included from drivers/iio/adc/fsl-imx25-gcq.c:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   include/linux/mm.h:877:22: error: no member named 'vm_lock' in 'struct vm_area_struct'
     877 |         vma_lock_init(&vma->vm_lock);
         |                        ~~~  ^
   include/linux/mm.h:878:7: error: no member named 'vm_lock_seq' in 'struct vm_area_struct'
     878 |         vma->vm_lock_seq = UINT_MAX;
         |         ~~~  ^
   In file included from drivers/iio/adc/fsl-imx25-gcq.c:19:
   In file included from include/linux/regulator/consumer.h:35:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2234:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/iio/adc/fsl-imx25-gcq.c:116:8: warning: shift count is negative [-Wshift-count-negative]
     116 |                      MX25_ADCQ_ITEM(0, chan->channel));
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mfd/imx25-tsadc.h:54:3: note: expanded from macro 'MX25_ADCQ_ITEM'
      54 |                 _MX25_ADCQ_ITEM((item) - 8, (x)) : _MX25_ADCQ_ITEM((item), (x)))
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mfd/imx25-tsadc.h:52:39: note: expanded from macro '_MX25_ADCQ_ITEM'
      52 | #define _MX25_ADCQ_ITEM(item, x)        ((x) << ((item) * 4))
         |                                              ^  ~~~~~~~~~~~~
   8 warnings and 3 errors generated.


vim +147 kernel/dma/direct.c

aea7e2a86a94b25 kernel/dma/direct.c Christoph Hellwig      2021-10-21  117  
26749b3201ab05e kernel/dma/direct.c Christoph Hellwig      2020-06-15  118  static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
92826e967535db2 kernel/dma/direct.c Christoph Hellwig      2022-04-23  119  		gfp_t gfp, bool allow_highmem)
a8463d4b0e47d1f lib/dma-noop.c      Christian Borntraeger  2016-02-02  120  {
90ae409f9eb3bca kernel/dma/direct.c Christoph Hellwig      2019-08-20  121  	int node = dev_to_node(dev);
080321d3b3139b3 lib/dma-direct.c    Christoph Hellwig      2017-12-22  122  	struct page *page = NULL;
a7ba70f1787f977 kernel/dma/direct.c Nicolas Saenz Julienne 2019-11-21  123  	u64 phys_limit;
a8463d4b0e47d1f lib/dma-noop.c      Christian Borntraeger  2016-02-02  124  
633d5fce78a61e8 kernel/dma/direct.c David Rientjes         2020-06-11  125  	WARN_ON_ONCE(!PAGE_ALIGNED(size));
633d5fce78a61e8 kernel/dma/direct.c David Rientjes         2020-06-11  126  
aea7e2a86a94b25 kernel/dma/direct.c Christoph Hellwig      2021-10-21  127  	if (is_swiotlb_for_alloc(dev))
aea7e2a86a94b25 kernel/dma/direct.c Christoph Hellwig      2021-10-21  128  		return dma_direct_alloc_swiotlb(dev, size);
aea7e2a86a94b25 kernel/dma/direct.c Christoph Hellwig      2021-10-21  129  
25a4ce564921db0 kernel/dma/direct.c Petr Tesarik           2023-02-20  130  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
633d5fce78a61e8 kernel/dma/direct.c David Rientjes         2020-06-11  131  	page = dma_alloc_contiguous(dev, size, gfp);
92826e967535db2 kernel/dma/direct.c Christoph Hellwig      2022-04-23  132  	if (page) {
92826e967535db2 kernel/dma/direct.c Christoph Hellwig      2022-04-23  133  		if (!dma_coherent_ok(dev, page_to_phys(page), size) ||
92826e967535db2 kernel/dma/direct.c Christoph Hellwig      2022-04-23  134  		    (!allow_highmem && PageHighMem(page))) {
633d5fce78a61e8 kernel/dma/direct.c David Rientjes         2020-06-11  135  			dma_free_contiguous(dev, page, size);
90ae409f9eb3bca kernel/dma/direct.c Christoph Hellwig      2019-08-20  136  			page = NULL;
90ae409f9eb3bca kernel/dma/direct.c Christoph Hellwig      2019-08-20  137  		}
92826e967535db2 kernel/dma/direct.c Christoph Hellwig      2022-04-23  138  	}
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  139  again:
90ae409f9eb3bca kernel/dma/direct.c Christoph Hellwig      2019-08-20  140  	if (!page)
633d5fce78a61e8 kernel/dma/direct.c David Rientjes         2020-06-11  141  		page = alloc_pages_node(node, gfp, get_order(size));
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  142  	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
f689a3ab7b8ece9 kernel/dma/direct.c Chen Yu                2024-08-31  143  		__free_pages(page, get_order(size));
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  144  		page = NULL;
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  145  
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  146  		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
a7ba70f1787f977 kernel/dma/direct.c Nicolas Saenz Julienne 2019-11-21 @147  		    phys_limit < DMA_BIT_MASK(64) &&
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  148  		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  149  			gfp |= GFP_DMA32;
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  150  			goto again;
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  151  		}
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  152  
fbce251baa6e357 kernel/dma/direct.c Christoph Hellwig      2019-02-13  153  		if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA)) {
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  154  			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  155  			goto again;
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  156  		}
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  157  	}
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  158  
b18814e767a4455 kernel/dma/direct.c Christoph Hellwig      2018-11-04  159  	return page;
b18814e767a4455 kernel/dma/direct.c Christoph Hellwig      2018-11-04  160  }
b18814e767a4455 kernel/dma/direct.c Christoph Hellwig      2018-11-04  161  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


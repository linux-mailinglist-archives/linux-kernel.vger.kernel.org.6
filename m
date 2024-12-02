Return-Path: <linux-kernel+bounces-427976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 027A59E08BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9753916C2F6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C839017B433;
	Mon,  2 Dec 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kziCWNnI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0E15ADB4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733156202; cv=none; b=vBCqt7BV2yTGYORUBbzNnv3KYyivRUX9yi9LZz5BPBaVRiMzGkQOHa25skPyxH02PtG7j6a4FerdSzfSKKj1znQ2vjHhOWDdYSEW82yqLoxAhTfQUzqHvWwHWk0NXmq7MeyIdYLvSBRTn7TxIa1+usarIafd5llBr0MaAIXQInE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733156202; c=relaxed/simple;
	bh=hBjULFugZtlPqAODKe5EOPqdZoFuU9oDax92d1MVL4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hif2cAfj0wSCeDNi01XcACv5U5mjCZHG4noAIosxTUjOLH7VtXkTjbyJys8GKLbP9is//1Z1QHQ9Czmjb8v9q9QJHaquYryIY8RDjEzVJx/cYJ/twaw6bXd+VtC3JezaLrgNPvsRiZ5lYIsb9MoRvhH5xJIu8oVe2YnuQkpcy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kziCWNnI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733156199; x=1764692199;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hBjULFugZtlPqAODKe5EOPqdZoFuU9oDax92d1MVL4E=;
  b=kziCWNnIW5v2xeZeGLU3fYPDkGY8tn7cOW4hcS6o9xkCcaMZEGcM+4IU
   9s4ALSGaB5HqJ3Mn41MF7U7KD0zFXNsK3VvK6bvmh2ymVT7RA8ef8TiwX
   FYDsaF2LdO3gL0nvpZg7I7FDTe3YEbs4llDM0cXlvNSIJkHhiBtSpv50Q
   5Ko6z0g6x/i6NbVXjMmaIoM3TGoTwtbX2js6UdYKH5R4w+ZDWdgZAeaa2
   Tkqztysim7ZK1NEL2xVmWmXHKEkZ3O6QfGf7U1V9nDIcgylCEkBlpALmU
   kC6/Yx/u/fypaP1hLoXbw13blFsnNC3EfMWBvtonO9EaHVoEKjd6QT58F
   A==;
X-CSE-ConnectionGUID: mXioe0YiRjyhVL+RfLTOeA==
X-CSE-MsgGUID: DT9ZihFqTJOV5mdgrmkMxA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33466682"
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="33466682"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 08:16:38 -0800
X-CSE-ConnectionGUID: IGMRNMWsTxOQdaPuxoo3sA==
X-CSE-MsgGUID: MCpR2xj9RRyZFU/yPp/1OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,202,1728975600"; 
   d="scan'208";a="93317340"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 02 Dec 2024 08:16:37 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tI95y-0002a5-2e;
	Mon, 02 Dec 2024 16:16:23 +0000
Date: Tue, 3 Dec 2024 00:15:30 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Lu <luxu.kernel@bytedance.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: oe-kbuild-all@lists.linux.dev, lihangjing@bytedance.com,
	xieyongji@bytedance.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, Xu Lu <luxu.kernel@bytedance.com>
Subject: Re: [PATCH] riscv: mm: Fix alignment of phys_ram_base
Message-ID: <202412022337.YEieoR2g-lkp@intel.com>
References: <20241202101601.48284-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202101601.48284-1-luxu.kernel@bytedance.com>

Hi Xu,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.13-rc1 next-20241128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Lu/riscv-mm-Fix-alignment-of-phys_ram_base/20241202-183801
base:   linus/master
patch link:    https://lore.kernel.org/r/20241202101601.48284-1-luxu.kernel%40bytedance.com
patch subject: [PATCH] riscv: mm: Fix alignment of phys_ram_base
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20241202/202412022337.YEieoR2g-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241202/202412022337.YEieoR2g-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412022337.YEieoR2g-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:27,
                    from include/linux/cpumask.h:11,
                    from arch/riscv/include/asm/processor.h:55,
                    from arch/riscv/include/asm/thread_info.h:42,
                    from include/linux/thread_info.h:60,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from arch/riscv/mm/init.c:10:
   arch/riscv/mm/init.c: In function 'setup_bootmem':
>> arch/riscv/mm/init.c:62:41: error: 'SECTION_SIZE_BITS' undeclared (first use in this function)
      62 | #define RISCV_MEMSTART_ALIGN    (1UL << SECTION_SIZE_BITS)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/math.h:15:46: note: in definition of macro '__round_mask'
      15 | #define __round_mask(x, y) ((__typeof__(x))((y)-1))
         |                                              ^
   arch/riscv/mm/init.c:246:33: note: in expansion of macro 'round_down'
     246 |                 phys_ram_base = round_down(memblock_start_of_DRAM(),
         |                                 ^~~~~~~~~~
   arch/riscv/mm/init.c:247:44: note: in expansion of macro 'RISCV_MEMSTART_ALIGN'
     247 |                                            RISCV_MEMSTART_ALIGN);
         |                                            ^~~~~~~~~~~~~~~~~~~~
   arch/riscv/mm/init.c:62:41: note: each undeclared identifier is reported only once for each function it appears in
      62 | #define RISCV_MEMSTART_ALIGN    (1UL << SECTION_SIZE_BITS)
         |                                         ^~~~~~~~~~~~~~~~~
   include/linux/math.h:15:46: note: in definition of macro '__round_mask'
      15 | #define __round_mask(x, y) ((__typeof__(x))((y)-1))
         |                                              ^
   arch/riscv/mm/init.c:246:33: note: in expansion of macro 'round_down'
     246 |                 phys_ram_base = round_down(memblock_start_of_DRAM(),
         |                                 ^~~~~~~~~~
   arch/riscv/mm/init.c:247:44: note: in expansion of macro 'RISCV_MEMSTART_ALIGN'
     247 |                                            RISCV_MEMSTART_ALIGN);
         |                                            ^~~~~~~~~~~~~~~~~~~~


vim +/SECTION_SIZE_BITS +62 arch/riscv/mm/init.c

  > 10	#include <linux/mm.h>
    11	#include <linux/memblock.h>
    12	#include <linux/initrd.h>
    13	#include <linux/swap.h>
    14	#include <linux/swiotlb.h>
    15	#include <linux/sizes.h>
    16	#include <linux/of_fdt.h>
    17	#include <linux/of_reserved_mem.h>
    18	#include <linux/libfdt.h>
    19	#include <linux/set_memory.h>
    20	#include <linux/dma-map-ops.h>
    21	#include <linux/crash_dump.h>
    22	#include <linux/hugetlb.h>
    23	#ifdef CONFIG_RELOCATABLE
    24	#include <linux/elf.h>
    25	#endif
    26	#include <linux/kfence.h>
    27	#include <linux/execmem.h>
    28	
    29	#include <asm/fixmap.h>
    30	#include <asm/io.h>
    31	#include <asm/kasan.h>
    32	#include <asm/numa.h>
    33	#include <asm/pgtable.h>
    34	#include <asm/sections.h>
    35	#include <asm/soc.h>
    36	#include <asm/tlbflush.h>
    37	
    38	#include "../kernel/head.h"
    39	
    40	u64 new_vmalloc[NR_CPUS / sizeof(u64) + 1];
    41	
    42	struct kernel_mapping kernel_map __ro_after_init;
    43	EXPORT_SYMBOL(kernel_map);
    44	#ifdef CONFIG_XIP_KERNEL
    45	#define kernel_map	(*(struct kernel_mapping *)XIP_FIXUP(&kernel_map))
    46	#endif
    47	
    48	#ifdef CONFIG_64BIT
    49	u64 satp_mode __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL) ? SATP_MODE_57 : SATP_MODE_39;
    50	#else
    51	u64 satp_mode __ro_after_init = SATP_MODE_32;
    52	#endif
    53	EXPORT_SYMBOL(satp_mode);
    54	
    55	#ifdef CONFIG_64BIT
    56	bool pgtable_l4_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
    57	bool pgtable_l5_enabled __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL);
    58	EXPORT_SYMBOL(pgtable_l4_enabled);
    59	EXPORT_SYMBOL(pgtable_l5_enabled);
    60	#endif
    61	
  > 62	#define RISCV_MEMSTART_ALIGN	(1UL << SECTION_SIZE_BITS)
    63	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


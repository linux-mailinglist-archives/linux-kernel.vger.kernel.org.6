Return-Path: <linux-kernel+bounces-248490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CF492DDF9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3ED328248A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5C68BFC;
	Thu, 11 Jul 2024 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NheMEH0P"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669E1523D;
	Thu, 11 Jul 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720661282; cv=none; b=Evbblyr/8UfBZ5vATHJJZuA67HV8hI6D88WQ4dOBgMnpfPwe415Sic/HvnHwflOwGleBPY4csOCg67aQbHTvy9k3v3+j3yUfXJ9o3ZJOt5nobRz375IiQKV8p/1iusNPt8XTaPFvvN3iRDgr+dDzoby7elQcEwgQ1fyyA5Ux2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720661282; c=relaxed/simple;
	bh=vU5CGpETWN9WieRlzuX2bB/uBD2xL9hz7UmKVEWI8ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uayb/8TXpL2Q38tfZFqJHrGq7zeVreC9WuT7Fnm3rRPwNTukgBhk81IPosj9w1nan8qqG5QpRZ/0D5iYasW+JURqSSNud77ClrfFEo0DrGqXkWK0r73tNpI+CMmjXtjhAjmOviGpTiGJng0gXXQiGRbZI2MA8GiYv8Q2zwTYKto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NheMEH0P; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720661281; x=1752197281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vU5CGpETWN9WieRlzuX2bB/uBD2xL9hz7UmKVEWI8ng=;
  b=NheMEH0PM9ti8S26lOi67TqmLEjcmT7e6g3hIKuSb2fMWJBkJExTKOlP
   zirK4EkH8FHBN1hZ7pu8/sk6rRcs1Pm9KhOw+09Ws13a0PDKApPbKpR6K
   wBlC3Pakwz514+DqDA6GnjQAbcsdpPTjwFU39PBiJV7oEs0T/zATVxzBd
   C8HYrmSSZMC1x8jjIh2Hcs4u7P4ZsbjcmjqymHjKQUcHtNmI96wuJtEv7
   /Jrht3nBw+z8xKC37rlwpog7WEeU52L5zZ5XTcBPQu5ZRrBvXYPPvd9Xa
   wHGyf6i89FxGh7N5zmIiY/1PfqdVrjJLewSfZ/KbvEjqA8L4q8joZU9Kd
   A==;
X-CSE-ConnectionGUID: eXVr467fSSCPTSfBdvoc8g==
X-CSE-MsgGUID: e+T2NHPaQWu/rKdyB1WP1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="35557861"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="35557861"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 18:28:00 -0700
X-CSE-ConnectionGUID: zos11QO2S1iX5YHnBSwgBw==
X-CSE-MsgGUID: /08vGTUGRKWFEWZIpsL3vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48292626"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Jul 2024 18:27:57 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRibC-000YaE-2Z;
	Thu, 11 Jul 2024 01:27:54 +0000
Date: Thu, 11 Jul 2024 09:27:16 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ved Shanbhogue <ved@rivosinc.com>, Matt Evans <mev@rivosinc.com>,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v3 4/4] riscv: Stop emitting preventive sfence.vma for
 new userspace mappings with Svvptc
Message-ID: <202407110946.e0VNIrJP-lkp@intel.com>
References: <20240702085034.48395-5-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702085034.48395-5-alexghiti@rivosinc.com>

Hi Alexandre,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.10-rc7]
[cannot apply to next-20240710]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Add-ISA-extension-parsing-for-Svvptc/20240702-171920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240702085034.48395-5-alexghiti%40rivosinc.com
patch subject: [PATCH v3 4/4] riscv: Stop emitting preventive sfence.vma for new userspace mappings with Svvptc
config: riscv-randconfig-001-20240711 (https://download.01.org/0day-ci/archive/20240711/202407110946.e0VNIrJP-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407110946.e0VNIrJP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407110946.e0VNIrJP-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:30:
   In file included from include/linux/pgtable.h:6:
>> arch/riscv/include/asm/pgtable.h:498:1: error: expected statement
   }
   ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:1115:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                           ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:1115:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[3] | set->sig[2] |
                                         ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:1115:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:99:4: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:1115:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:101:11: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return (set->sig[1] | set->sig[0]) == 0;
                           ^        ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:1115:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:1115:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:27: warning: array index 3 is past the end of the array (which contains 1 element) [-Warray-bounds]
                   return  (set1->sig[3] == set2->sig[3]) &&
                                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:1115:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:115:5: warning: array index 2 is past the end of the array (which contains 1 element) [-Warray-bounds]
                           (set1->sig[2] == set2->sig[2]) &&
                            ^         ~
   include/uapi/asm-generic/signal.h:62:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   In file included from arch/riscv/kernel/asm-offsets.c:10:
   In file included from include/linux/mm.h:1115:
   In file included from include/linux/huge_mm.h:8:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:


vim +498 arch/riscv/include/asm/pgtable.h

07037db5d479f9 Palmer Dabbelt          2017-07-10  469  
07037db5d479f9 Palmer Dabbelt          2017-07-10  470  #define pgd_ERROR(e) \
07037db5d479f9 Palmer Dabbelt          2017-07-10  471  	pr_err("%s:%d: bad pgd " PTE_FMT ".\n", __FILE__, __LINE__, pgd_val(e))
07037db5d479f9 Palmer Dabbelt          2017-07-10  472  
07037db5d479f9 Palmer Dabbelt          2017-07-10  473  
07037db5d479f9 Palmer Dabbelt          2017-07-10  474  /* Commit new configuration to MMU hardware */
864609c6a0b5f0 Matthew Wilcox (Oracle  2023-08-02  475) static inline void update_mmu_cache_range(struct vm_fault *vmf,
864609c6a0b5f0 Matthew Wilcox (Oracle  2023-08-02  476) 		struct vm_area_struct *vma, unsigned long address,
864609c6a0b5f0 Matthew Wilcox (Oracle  2023-08-02  477) 		pte_t *ptep, unsigned int nr)
07037db5d479f9 Palmer Dabbelt          2017-07-10  478  {
b5bdff9ee1fdca Alexandre Ghiti         2024-07-02  479  	asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
b5bdff9ee1fdca Alexandre Ghiti         2024-07-02  480  		 : : : : svvptc);
b5bdff9ee1fdca Alexandre Ghiti         2024-07-02  481  
07037db5d479f9 Palmer Dabbelt          2017-07-10  482  	/*
07037db5d479f9 Palmer Dabbelt          2017-07-10  483  	 * The kernel assumes that TLBs don't cache invalid entries, but
07037db5d479f9 Palmer Dabbelt          2017-07-10  484  	 * in RISC-V, SFENCE.VMA specifies an ordering constraint, not a
07037db5d479f9 Palmer Dabbelt          2017-07-10  485  	 * cache flush; it is necessary even after writing invalid entries.
07037db5d479f9 Palmer Dabbelt          2017-07-10  486  	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
07037db5d479f9 Palmer Dabbelt          2017-07-10  487  	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
07037db5d479f9 Palmer Dabbelt          2017-07-10  488  	 */
864609c6a0b5f0 Matthew Wilcox (Oracle  2023-08-02  489) 	while (nr--)
864609c6a0b5f0 Matthew Wilcox (Oracle  2023-08-02  490) 		local_flush_tlb_page(address + nr * PAGE_SIZE);
b5bdff9ee1fdca Alexandre Ghiti         2024-07-02  491  
b5bdff9ee1fdca Alexandre Ghiti         2024-07-02  492  svvptc:
b5bdff9ee1fdca Alexandre Ghiti         2024-07-02  493  	/*
b5bdff9ee1fdca Alexandre Ghiti         2024-07-02  494  	 * Svvptc guarantees that the new valid pte will be visible within
b5bdff9ee1fdca Alexandre Ghiti         2024-07-02  495  	 * a bounded timeframe, so when the uarch does not cache invalid
b5bdff9ee1fdca Alexandre Ghiti         2024-07-02  496  	 * entries, we don't have to do anything.
b5bdff9ee1fdca Alexandre Ghiti         2024-07-02  497  	 */
07037db5d479f9 Palmer Dabbelt          2017-07-10 @498  }
864609c6a0b5f0 Matthew Wilcox (Oracle  2023-08-02  499) #define update_mmu_cache(vma, addr, ptep) \
864609c6a0b5f0 Matthew Wilcox (Oracle  2023-08-02  500) 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
07037db5d479f9 Palmer Dabbelt          2017-07-10  501  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


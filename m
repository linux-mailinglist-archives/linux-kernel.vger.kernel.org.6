Return-Path: <linux-kernel+bounces-248562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E592DF01
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 05:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 602E11F229EC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 03:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F332D512;
	Thu, 11 Jul 2024 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bn9sp7Tz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE41A28B;
	Thu, 11 Jul 2024 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670347; cv=none; b=hRhCQ39PJJ0AvUHNb5fgK6ODZikrcXHxnMCMdoA6CJy/yYMGn7GK9tCrUb8k9XAk0ZCu+CZqJE/N2itxn6vsTxMuvepNLTfqP3hMCctECybrQuqDB7DMlbqL9gu2r/43Rn3g9/vz/ZwKpA1EWksLvt/oV3bEF7x4mdG5DIl/arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670347; c=relaxed/simple;
	bh=2hTfSLerBEhuvk5r/a+JgnS4n9dpEaBnFa1d1Xb3oi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtSbCWWYSqHKZ4ECs5sobcQGl4aNAm+snJt2flAKNzJRVvWBuxo5UeUe9IJRZVhjcpqBbpHhl3Y68hYoYWjeC9SCc5I/eVAZ3LoHnFZcB/EdMMI2t5NYPpJl5ZvjBbIjoY2rQwXBC3SFTa9LBNjKWoyc/a6jBeNZSTO+92EXAwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bn9sp7Tz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720670345; x=1752206345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2hTfSLerBEhuvk5r/a+JgnS4n9dpEaBnFa1d1Xb3oi4=;
  b=bn9sp7TzlZjPlGVNAeqtmut9U2i3G+I9MJBQICDgSyIphjBaOCUcbyZN
   j9R/nSdT7Z63D+O5EsDLjECyWz7YwDtNTCJBYAm/B/qs/k0551I2JU80d
   6yiL/hXFmT+Wgm5jFCG+rdljk7IBVSreNGx0RGekvYHGO1AvC2SJ7ts5J
   9Qb8MFI2IxoaCBn15XfS+ybTZRlDAIte9ocYO3jVT6WsBuVIif5DXytuM
   QbJsXYyVuNHE1H/wsj+E+fa1VPLXa+OHDW9PNprJI4ggiQWETNxG81Toh
   PbcD4jfaQJeuh5ExZUAhgsXnqN695slqnqQ9LTUYXov3I9Q1Tje7ooxwd
   Q==;
X-CSE-ConnectionGUID: fCrUiCwJSw6NOKod64jZ7g==
X-CSE-MsgGUID: oZKYC1a6RMuRT40yK1muMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18168819"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="18168819"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 20:59:05 -0700
X-CSE-ConnectionGUID: ALcnlCyMQ7uK0Tk2qQQtpw==
X-CSE-MsgGUID: 5del/KQDQQ+K0/aVdZeUkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="52730050"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 10 Jul 2024 20:59:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRkxP-000Yiy-31;
	Thu, 11 Jul 2024 03:58:59 +0000
Date: Thu, 11 Jul 2024 11:58:24 +0800
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
Message-ID: <202407111151.m5cK0E6R-lkp@intel.com>
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
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20240711/202407111151.m5cK0E6R-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project a0c6b8aef853eedaa0980f07c0a502a5a8a9740e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407111151.m5cK0E6R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407111151.m5cK0E6R-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/test_bitops.c:10:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/riscv/include/asm/elf.h:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:13:
   In file included from include/linux/uaccess.h:11:
   In file included from arch/riscv/include/asm/uaccess.h:12:
>> arch/riscv/include/asm/pgtable.h:498:1: error: label at end of compound statement is a C23 extension [-Werror,-Wc23-extensions]
     498 | }
         | ^
   1 error generated.


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


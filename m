Return-Path: <linux-kernel+bounces-548221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A4A541EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9141891144
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A22B19CC3A;
	Thu,  6 Mar 2025 05:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XKASTT9E"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46AD19ADB0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741237720; cv=none; b=QsXYhkl5Gj7v7CVFCYjgbQ1M1LrTahX3Y783Ca9kMgbLDJvtQj0IEbNBRkplVg4qIAS2YUunioZSLtPPqgXuVDXPIzL4otAEMtXR2Sib7mJHTnOUxR29dJVEx9ejjMhD42kEcZNU1mW+W3XuJ6UuNW3AxIXcowwnHtwTr4WDRZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741237720; c=relaxed/simple;
	bh=+viV11nQBG/pa4OYx4X5/r1x+AdDiOmvsrgtAtgFNcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krSaI0swqTnSAzLm7+ntcZ9luZeplDWb9lJTe08fo6SG3maMt3aq8c29Ot3D5YrkD60D/uI84CUc1rBAJVs1MGKCxlgVQ3+DviKnu+t3RApkQ5KVHAQD3+AqynS/E4WaK40f5y6XY0KJ6KNw0nTrmQW5qBJH2SKOqpJG76i365k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XKASTT9E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741237719; x=1772773719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+viV11nQBG/pa4OYx4X5/r1x+AdDiOmvsrgtAtgFNcs=;
  b=XKASTT9EAdxp1XFPKhgENYlaU4XQWwa0gQW6fw95RM+7ihGGlzIqcIwx
   kTUmF9rpfScKdATXOZnuYb3Lc7clxZo+iG/gCe8KI+Xoyr7SOvSXCQVo3
   kDWX+vSD+ieyqLdH9y/2lhS/QSznxdCFO+8CtiDyqissFfKmU8tiErn4M
   4WnYuArd8O/ZdUqQYyCFG2c5hOGELdNFRNIVeTtV1UTPi9/4SFeQShFRs
   gXoyWa89W+VowEVZtvlTABiGXzhxDLjXxrfGaqJTmZU07UW8ebCLC7/mL
   vtefeAxaFgcd0J7j00ASaZoBeSb11Zo104puNpn92kiQjdwNsHPgcaIx4
   w==;
X-CSE-ConnectionGUID: j2T0p3JeT3+aroMHIpwbPA==
X-CSE-MsgGUID: 76nbbCKHQ22pLmN32ooJag==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53216191"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="53216191"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 21:08:39 -0800
X-CSE-ConnectionGUID: 3xZfakiyQbySmXPipKosRQ==
X-CSE-MsgGUID: oTR3TydRSpSUiPDMcps1RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119822472"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 05 Mar 2025 21:08:34 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq3TD-000MYs-1d;
	Thu, 06 Mar 2025 05:08:31 +0000
Date: Thu, 6 Mar 2025 13:08:16 +0800
From: kernel test robot <lkp@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] arm64/mm: Refactor __set_ptes() and
 __ptep_get_and_clear()
Message-ID: <202503061237.QurSXHSC-lkp@intel.com>
References: <20250304150444.3788920-5-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304150444.3788920-5-ryan.roberts@arm.com>

Hi Ryan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.14-rc5 next-20250305]
[cannot apply to arm64/for-next/core akpm-mm/mm-everything arm-perf/for-next/perf]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/arm64-hugetlb-Cleanup-huge_pte-size-discovery-mechanisms/20250304-230647
base:   linus/master
patch link:    https://lore.kernel.org/r/20250304150444.3788920-5-ryan.roberts%40arm.com
patch subject: [PATCH v3 04/11] arm64/mm: Refactor __set_ptes() and __ptep_get_and_clear()
config: arm64-randconfig-001-20250305 (https://download.01.org/0day-ci/archive/20250306/202503061237.QurSXHSC-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503061237.QurSXHSC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503061237.QurSXHSC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kernel/asm-offsets.c:12:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/arm64/include/asm/hardirq.h:17:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/arm64/include/asm/io.h:12:
   In file included from include/linux/pgtable.h:6:
>> arch/arm64/include/asm/pgtable.h:639:7: error: duplicate case value '536870912'
           case PUD_SIZE:
                ^
   include/asm-generic/pgtable-nopud.h:20:20: note: expanded from macro 'PUD_SIZE'
   #define PUD_SIZE        (1UL << PUD_SHIFT)
                           ^
   arch/arm64/include/asm/pgtable.h:636:7: note: previous case defined here
           case PMD_SIZE:
                ^
   include/asm-generic/pgtable-nopmd.h:22:20: note: expanded from macro 'PMD_SIZE'
   #define PMD_SIZE        (1UL << PMD_SHIFT)
                           ^
   In file included from arch/arm64/kernel/asm-offsets.c:12:
   In file included from include/linux/ftrace.h:10:
   In file included from include/linux/trace_recursion.h:5:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/arm64/include/asm/hardirq.h:17:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/arm64/include/asm/io.h:12:
   In file included from include/linux/pgtable.h:6:
   arch/arm64/include/asm/pgtable.h:1303:7: error: duplicate case value '536870912'
           case PUD_SIZE:
                ^
   include/asm-generic/pgtable-nopud.h:20:20: note: expanded from macro 'PUD_SIZE'
   #define PUD_SIZE        (1UL << PUD_SHIFT)
                           ^
   arch/arm64/include/asm/pgtable.h:1300:7: note: previous case defined here
           case PMD_SIZE:
                ^
   include/asm-generic/pgtable-nopmd.h:22:20: note: expanded from macro 'PMD_SIZE'
   #define PMD_SIZE        (1UL << PMD_SHIFT)
                           ^
   2 errors generated.
   make[3]: *** [scripts/Makefile.build:102: arch/arm64/kernel/asm-offsets.s] Error 1 shuffle=4064171735
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1264: prepare0] Error 2 shuffle=4064171735
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=4064171735
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=4064171735
   make: Target 'prepare' not remade because of errors.


vim +/536870912 +639 arch/arm64/include/asm/pgtable.h

   626	
   627	static inline void set_ptes_anysz(struct mm_struct *mm, pte_t *ptep, pte_t pte,
   628					  unsigned int nr, unsigned long pgsize)
   629	{
   630		unsigned long stride = pgsize >> PAGE_SHIFT;
   631	
   632		switch (pgsize) {
   633		case PAGE_SIZE:
   634			page_table_check_ptes_set(mm, ptep, pte, nr);
   635			break;
   636		case PMD_SIZE:
   637			page_table_check_pmds_set(mm, (pmd_t *)ptep, pte_pmd(pte), nr);
   638			break;
 > 639		case PUD_SIZE:
   640			page_table_check_puds_set(mm, (pud_t *)ptep, pte_pud(pte), nr);
   641			break;
   642		default:
   643			VM_WARN_ON(1);
   644		}
   645	
   646		__sync_cache_and_tags(pte, nr * stride);
   647	
   648		for (;;) {
   649			__check_safe_pte_update(mm, ptep, pte);
   650			__set_pte(ptep, pte);
   651			if (--nr == 0)
   652				break;
   653			ptep++;
   654			pte = pte_advance_pfn(pte, stride);
   655		}
   656	}
   657	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


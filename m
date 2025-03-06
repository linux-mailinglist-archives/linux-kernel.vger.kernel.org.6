Return-Path: <linux-kernel+bounces-548852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12AA54A1E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696877A25AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243B20ADC9;
	Thu,  6 Mar 2025 11:54:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7C207656
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262069; cv=none; b=McdDS5KkGtDG3xLSI2g9FUWYUW5jSAq7poS0+OveIvpimhLbCZuPHYbOuzMpsHb8riX8F2IcWdiBzjeLtJew7T++jVqjLhDm+HMmASAXvRkkte3W0eEoz8AdiIhmHFoJ215y7o1hPDhMwSpnn8uQQWSnJ4byY6cvTTevUveYtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262069; c=relaxed/simple;
	bh=ka/cUnlF71xhYqkWXR1kGqvQc58sAUxaN7O7aD2DSVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfedIcVPeATpbu6eBX2EcYf0KhBlubtIqUSTrK3urm+ps7yUuxHiHfPCRL8rs2hWNmfpbj0/XhrRQtGYJDCf+3upPYm1OsaSVMXj89Es3QnrfJ1VlU0bqpGox6FVBSvEmE/LkhLzASg2Au7/92NH3xV+sjlFk2zcNwfli5i73gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 271491007;
	Thu,  6 Mar 2025 03:54:40 -0800 (PST)
Received: from [10.1.37.172] (XHFQ2J9959.cambridge.arm.com [10.1.37.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADE103F673;
	Thu,  6 Mar 2025 03:54:24 -0800 (PST)
Message-ID: <169f2d13-8374-48b2-8af1-db412f283e5b@arm.com>
Date: Thu, 6 Mar 2025 11:54:23 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/11] arm64/mm: Refactor __set_ptes() and
 __ptep_get_and_clear()
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304150444.3788920-5-ryan.roberts@arm.com>
 <202503061237.QurSXHSC-lkp@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <202503061237.QurSXHSC-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 05:08, kernel test robot wrote:
> Hi Ryan,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.14-rc5 next-20250305]
> [cannot apply to arm64/for-next/core akpm-mm/mm-everything arm-perf/for-next/perf]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/arm64-hugetlb-Cleanup-huge_pte-size-discovery-mechanisms/20250304-230647
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20250304150444.3788920-5-ryan.roberts%40arm.com
> patch subject: [PATCH v3 04/11] arm64/mm: Refactor __set_ptes() and __ptep_get_and_clear()
> config: arm64-randconfig-001-20250305 (https://download.01.org/0day-ci/archive/20250306/202503061237.QurSXHSC-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503061237.QurSXHSC-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503061237.QurSXHSC-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/arm64/kernel/asm-offsets.c:12:
>    In file included from include/linux/ftrace.h:10:
>    In file included from include/linux/trace_recursion.h:5:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/arm64/include/asm/hardirq.h:17:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/arm64/include/asm/io.h:12:
>    In file included from include/linux/pgtable.h:6:
>>> arch/arm64/include/asm/pgtable.h:639:7: error: duplicate case value '536870912'
>            case PUD_SIZE:
>                 ^
>    include/asm-generic/pgtable-nopud.h:20:20: note: expanded from macro 'PUD_SIZE'
>    #define PUD_SIZE        (1UL << PUD_SHIFT)
>                            ^
>    arch/arm64/include/asm/pgtable.h:636:7: note: previous case defined here
>            case PMD_SIZE:
>                 ^
>    include/asm-generic/pgtable-nopmd.h:22:20: note: expanded from macro 'PMD_SIZE'
>    #define PMD_SIZE        (1UL << PMD_SHIFT)
>                            ^
>    In file included from arch/arm64/kernel/asm-offsets.c:12:
>    In file included from include/linux/ftrace.h:10:
>    In file included from include/linux/trace_recursion.h:5:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:11:
>    In file included from arch/arm64/include/asm/hardirq.h:17:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:14:
>    In file included from arch/arm64/include/asm/io.h:12:
>    In file included from include/linux/pgtable.h:6:
>    arch/arm64/include/asm/pgtable.h:1303:7: error: duplicate case value '536870912'
>            case PUD_SIZE:
>                 ^
>    include/asm-generic/pgtable-nopud.h:20:20: note: expanded from macro 'PUD_SIZE'
>    #define PUD_SIZE        (1UL << PUD_SHIFT)
>                            ^
>    arch/arm64/include/asm/pgtable.h:1300:7: note: previous case defined here
>            case PMD_SIZE:
>                 ^
>    include/asm-generic/pgtable-nopmd.h:22:20: note: expanded from macro 'PMD_SIZE'
>    #define PMD_SIZE        (1UL << PMD_SHIFT)
>                            ^
>    2 errors generated.
>    make[3]: *** [scripts/Makefile.build:102: arch/arm64/kernel/asm-offsets.s] Error 1 shuffle=4064171735
>    make[3]: Target 'prepare' not remade because of errors.
>    make[2]: *** [Makefile:1264: prepare0] Error 2 shuffle=4064171735
>    make[2]: Target 'prepare' not remade because of errors.
>    make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=4064171735
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:251: __sub-make] Error 2 shuffle=4064171735
>    make: Target 'prepare' not remade because of errors.
> 
> 
> vim +/536870912 +639 arch/arm64/include/asm/pgtable.h
> 
>    626	
>    627	static inline void set_ptes_anysz(struct mm_struct *mm, pte_t *ptep, pte_t pte,
>    628					  unsigned int nr, unsigned long pgsize)
>    629	{
>    630		unsigned long stride = pgsize >> PAGE_SHIFT;
>    631	
>    632		switch (pgsize) {
>    633		case PAGE_SIZE:
>    634			page_table_check_ptes_set(mm, ptep, pte, nr);
>    635			break;
>    636		case PMD_SIZE:
>    637			page_table_check_pmds_set(mm, (pmd_t *)ptep, pte_pmd(pte), nr);
>    638			break;
>  > 639		case PUD_SIZE:
>    640			page_table_check_puds_set(mm, (pud_t *)ptep, pte_pud(pte), nr);
>    641			break;

Looks like this needs to be wrapped in `#ifndef __PAGETABLE_PMD_FOLDED`. This
failing config folds the PMD so PMD_SIZE and PUD_SIZE are the same.

Given there are now 2 kernel robot reports, I'll respin the series next week,
giving time for any interim review comments.

Thanks,
Ryan


>    642		default:
>    643			VM_WARN_ON(1);
>    644		}
>    645	
>    646		__sync_cache_and_tags(pte, nr * stride);
>    647	
>    648		for (;;) {
>    649			__check_safe_pte_update(mm, ptep, pte);
>    650			__set_pte(ptep, pte);
>    651			if (--nr == 0)
>    652				break;
>    653			ptep++;
>    654			pte = pte_advance_pfn(pte, stride);
>    655		}
>    656	}
>    657	
> 



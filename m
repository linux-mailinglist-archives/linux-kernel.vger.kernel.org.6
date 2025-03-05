Return-Path: <linux-kernel+bounces-547258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D76A504EA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D35D7A3802
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B24245C18;
	Wed,  5 Mar 2025 16:32:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69DBA27
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192349; cv=none; b=ByKc1iZxLfoFi6j4M3SiDAuU6fc7bvoVEnq4dLUmBTTMoGfXfTjA/ltp1+vrtKjX6gfoIxNWP/u963mjLNYIB4XWclO0UpgrNmgMruydZrdxXGkRuxXkKcdRb4qRNrIhBiK7g6Mwn6z1FXbkWosHbCervHwEGFmSQWtQ7DNL5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192349; c=relaxed/simple;
	bh=3DNtNo0EEazacfPGv43q6KZ3e/o9N6odhUiUYZ1P4QM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4s0RgJXNlxDDJO/X9Ze/NTG4AgxCdIvrShezYGVg5Pp6xCQyyGkWXrAvP6yFpyH1uOIHDSOUmjnS2SBd8Tsz+4I9AvnOke6FjGKlAIxIGL6jTfwF4HllHfUIhCfCaWWePqd4F0c5rHbinOeph4heyQEpIQl6oL/trusY4cDxRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECB8EFEC;
	Wed,  5 Mar 2025 08:32:39 -0800 (PST)
Received: from [10.57.83.152] (unknown [10.57.83.152])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAD883F5A1;
	Wed,  5 Mar 2025 08:32:23 -0800 (PST)
Message-ID: <47fd6aed-cb91-488d-ac2c-92f9ce73887f@arm.com>
Date: Wed, 5 Mar 2025 16:32:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/11] arm64: hugetlb: Use set_ptes_anysz() and
 ptep_get_and_clear_anysz()
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
References: <20250304150444.3788920-6-ryan.roberts@arm.com>
 <202503052315.vk7m958M-lkp@intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <202503052315.vk7m958M-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2025 16:00, kernel test robot wrote:
> Hi Ryan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.14-rc5 next-20250305]
> [cannot apply to arm64/for-next/core akpm-mm/mm-everything arm-perf/for-next/perf]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/arm64-hugetlb-Cleanup-huge_pte-size-discovery-mechanisms/20250304-230647
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20250304150444.3788920-6-ryan.roberts%40arm.com
> patch subject: [PATCH v3 05/11] arm64: hugetlb: Use set_ptes_anysz() and ptep_get_and_clear_anysz()
> config: arm64-randconfig-003-20250305 (https://download.01.org/0day-ci/archive/20250305/202503052315.vk7m958M-lkp@intel.com/config)
> compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503052315.vk7m958M-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503052315.vk7m958M-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/arm64/mm/hugetlbpage.c:12:
>    In file included from include/linux/mm.h:2224:
>    include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      505 |                            item];
>          |                            ~~~~
>    include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
>      511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~ ^
>      512 |                            NR_VM_NUMA_EVENT_ITEMS +
>          |                            ~~~~~~~~~~~~~~~~~~~~~~
>>> arch/arm64/mm/hugetlbpage.c:154:23: warning: parameter 'addr' set but not used [-Wunused-but-set-parameter]
>      154 |                              unsigned long addr,
>          |                                            ^
>    3 warnings generated.
> 
> 
> vim +/addr +154 arch/arm64/mm/hugetlbpage.c
> 
> bc5dfb4fd7bd471 Baolin Wang       2022-05-16  144  
> d8bdcff2876424d Steve Capper      2017-08-22  145  /*
> d8bdcff2876424d Steve Capper      2017-08-22  146   * Changing some bits of contiguous entries requires us to follow a
> d8bdcff2876424d Steve Capper      2017-08-22  147   * Break-Before-Make approach, breaking the whole contiguous set
> d8bdcff2876424d Steve Capper      2017-08-22  148   * before we can change any entries. See ARM DDI 0487A.k_iss10775,
> d8bdcff2876424d Steve Capper      2017-08-22  149   * "Misprogramming of the Contiguous bit", page D4-1762.
> d8bdcff2876424d Steve Capper      2017-08-22  150   *
> d8bdcff2876424d Steve Capper      2017-08-22  151   * This helper performs the break step.
> d8bdcff2876424d Steve Capper      2017-08-22  152   */
> fb396bb459c1fa3 Anshuman Khandual 2022-05-10  153  static pte_t get_clear_contig(struct mm_struct *mm,
> d8bdcff2876424d Steve Capper      2017-08-22 @154  			     unsigned long addr,
> d8bdcff2876424d Steve Capper      2017-08-22  155  			     pte_t *ptep,
> d8bdcff2876424d Steve Capper      2017-08-22  156  			     unsigned long pgsize,
> d8bdcff2876424d Steve Capper      2017-08-22  157  			     unsigned long ncontig)
> d8bdcff2876424d Steve Capper      2017-08-22  158  {
> 49c87f7677746f3 Ryan Roberts      2025-02-26  159  	pte_t pte, tmp_pte;
> 49c87f7677746f3 Ryan Roberts      2025-02-26  160  	bool present;
> 49c87f7677746f3 Ryan Roberts      2025-02-26  161  
> 66251d3eadf78e2 Ryan Roberts      2025-03-04  162  	pte = ptep_get_and_clear_anysz(mm, ptep, pgsize);
> 49c87f7677746f3 Ryan Roberts      2025-02-26  163  	present = pte_present(pte);
> 49c87f7677746f3 Ryan Roberts      2025-02-26  164  	while (--ncontig) {
> 49c87f7677746f3 Ryan Roberts      2025-02-26  165  		ptep++;
> 49c87f7677746f3 Ryan Roberts      2025-02-26  166  		addr += pgsize;

Ahh yes, thanks! Looks like this line can be removed since we no longer need the
address.

Catalin, I was optimistically hoping this might be the final version. If it is,
are you happy to fold this in? Or do you want me to re-spin regardless?

> 66251d3eadf78e2 Ryan Roberts      2025-03-04  167  		tmp_pte = ptep_get_and_clear_anysz(mm, ptep, pgsize);
> 49c87f7677746f3 Ryan Roberts      2025-02-26  168  		if (present) {
> 49c87f7677746f3 Ryan Roberts      2025-02-26  169  			if (pte_dirty(tmp_pte))
> 49c87f7677746f3 Ryan Roberts      2025-02-26  170  				pte = pte_mkdirty(pte);
> 49c87f7677746f3 Ryan Roberts      2025-02-26  171  			if (pte_young(tmp_pte))
> 49c87f7677746f3 Ryan Roberts      2025-02-26  172  				pte = pte_mkyoung(pte);
> d8bdcff2876424d Steve Capper      2017-08-22  173  		}
> 49c87f7677746f3 Ryan Roberts      2025-02-26  174  	}
> 49c87f7677746f3 Ryan Roberts      2025-02-26  175  	return pte;
> d8bdcff2876424d Steve Capper      2017-08-22  176  }
> d8bdcff2876424d Steve Capper      2017-08-22  177  
> 



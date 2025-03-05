Return-Path: <linux-kernel+bounces-547199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8B9A50418
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516B77A99E9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FB2250C0B;
	Wed,  5 Mar 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG1YfyR0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5124A07A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190429; cv=none; b=TwNU3BzDiBs1qljuwhpY2YIOke/QA2e6j+n+dxpMZJhgMdpF3Cnp/CUgcynBgI9vSo9/5q1H8zJmhcO0VZ/0cKFfXvGVQCCERZuXVVtzBXxeYrOwVh/sTt6V5rxV4Agdu6WrL9vHeGMuA/vyTQxahFuJt/Eb7OhSGH5BT3IdGl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190429; c=relaxed/simple;
	bh=+ejXxKQV90DW4dp+iOv5aIiKOpBAg3qGk/MHrDfxAI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GofkRVw6Ni3h1FZLKvG8PVZhKD4Z6uPE6TpIJuypUhXoDIkRi3BfK4sc5jsqqr5ot22NVQsK05b+VxdF6WOrLn7nkaZykWb1Ji9kzYw2JUT1BdxwynMlQ4XUTpXO/EhxP5TA15VmmhCBfqghBR57DFp6NQtizBgwp8dbeF8iIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG1YfyR0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741190428; x=1772726428;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ejXxKQV90DW4dp+iOv5aIiKOpBAg3qGk/MHrDfxAI8=;
  b=iG1YfyR0ZkG04jTh7X3Apb8k/RTwcpNr1za+tnDKUGhotkRdUjt3kg/K
   T4If8os8Af1sSoSIdkZ+KLm3h+0qR/ANorMSII+CI2x45tCIHlYp4oZxJ
   /l4gU3oQyhDMMm+YCq2CwV6JRf2LbG2BKw9YYxkpqRJehEmNRi6DgXviM
   p9isYMGKsD/PRg52/Tt6PTzJ0kheA1sm5UvKBPx38Fio0AM/bWvMyHw0N
   hglGHHfir70S5zhWDds95FZWjPGfQAoK6Co9fp4irteJQwvb9CE1yQv0Y
   LjkxqmL8++C5WjOO596jKoZjgZ4i7FZn09IoJz6rDw2CsfbmaYq4erobZ
   A==;
X-CSE-ConnectionGUID: 9Vr50m+XS7ODtpbfmYzzWQ==
X-CSE-MsgGUID: KiugI+3DSp6HMQEIPBbw/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59707261"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="59707261"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:00:27 -0800
X-CSE-ConnectionGUID: hjYKjvcmR5utfjW6V3Dwbg==
X-CSE-MsgGUID: kLV+FyYORG66FQT1ByJXBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118650255"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 05 Mar 2025 08:00:22 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tprAS-000LBm-0Y;
	Wed, 05 Mar 2025 16:00:20 +0000
Date: Thu, 6 Mar 2025 00:00:01 +0800
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
Subject: Re: [PATCH v3 05/11] arm64: hugetlb: Use set_ptes_anysz() and
 ptep_get_and_clear_anysz()
Message-ID: <202503052315.vk7m958M-lkp@intel.com>
References: <20250304150444.3788920-6-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304150444.3788920-6-ryan.roberts@arm.com>

Hi Ryan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc5 next-20250305]
[cannot apply to arm64/for-next/core akpm-mm/mm-everything arm-perf/for-next/perf]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ryan-Roberts/arm64-hugetlb-Cleanup-huge_pte-size-discovery-mechanisms/20250304-230647
base:   linus/master
patch link:    https://lore.kernel.org/r/20250304150444.3788920-6-ryan.roberts%40arm.com
patch subject: [PATCH v3 05/11] arm64: hugetlb: Use set_ptes_anysz() and ptep_get_and_clear_anysz()
config: arm64-randconfig-003-20250305 (https://download.01.org/0day-ci/archive/20250305/202503052315.vk7m958M-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503052315.vk7m958M-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503052315.vk7m958M-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/mm/hugetlbpage.c:12:
   In file included from include/linux/mm.h:2224:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/mm/hugetlbpage.c:154:23: warning: parameter 'addr' set but not used [-Wunused-but-set-parameter]
     154 |                              unsigned long addr,
         |                                            ^
   3 warnings generated.


vim +/addr +154 arch/arm64/mm/hugetlbpage.c

bc5dfb4fd7bd471 Baolin Wang       2022-05-16  144  
d8bdcff2876424d Steve Capper      2017-08-22  145  /*
d8bdcff2876424d Steve Capper      2017-08-22  146   * Changing some bits of contiguous entries requires us to follow a
d8bdcff2876424d Steve Capper      2017-08-22  147   * Break-Before-Make approach, breaking the whole contiguous set
d8bdcff2876424d Steve Capper      2017-08-22  148   * before we can change any entries. See ARM DDI 0487A.k_iss10775,
d8bdcff2876424d Steve Capper      2017-08-22  149   * "Misprogramming of the Contiguous bit", page D4-1762.
d8bdcff2876424d Steve Capper      2017-08-22  150   *
d8bdcff2876424d Steve Capper      2017-08-22  151   * This helper performs the break step.
d8bdcff2876424d Steve Capper      2017-08-22  152   */
fb396bb459c1fa3 Anshuman Khandual 2022-05-10  153  static pte_t get_clear_contig(struct mm_struct *mm,
d8bdcff2876424d Steve Capper      2017-08-22 @154  			     unsigned long addr,
d8bdcff2876424d Steve Capper      2017-08-22  155  			     pte_t *ptep,
d8bdcff2876424d Steve Capper      2017-08-22  156  			     unsigned long pgsize,
d8bdcff2876424d Steve Capper      2017-08-22  157  			     unsigned long ncontig)
d8bdcff2876424d Steve Capper      2017-08-22  158  {
49c87f7677746f3 Ryan Roberts      2025-02-26  159  	pte_t pte, tmp_pte;
49c87f7677746f3 Ryan Roberts      2025-02-26  160  	bool present;
49c87f7677746f3 Ryan Roberts      2025-02-26  161  
66251d3eadf78e2 Ryan Roberts      2025-03-04  162  	pte = ptep_get_and_clear_anysz(mm, ptep, pgsize);
49c87f7677746f3 Ryan Roberts      2025-02-26  163  	present = pte_present(pte);
49c87f7677746f3 Ryan Roberts      2025-02-26  164  	while (--ncontig) {
49c87f7677746f3 Ryan Roberts      2025-02-26  165  		ptep++;
49c87f7677746f3 Ryan Roberts      2025-02-26  166  		addr += pgsize;
66251d3eadf78e2 Ryan Roberts      2025-03-04  167  		tmp_pte = ptep_get_and_clear_anysz(mm, ptep, pgsize);
49c87f7677746f3 Ryan Roberts      2025-02-26  168  		if (present) {
49c87f7677746f3 Ryan Roberts      2025-02-26  169  			if (pte_dirty(tmp_pte))
49c87f7677746f3 Ryan Roberts      2025-02-26  170  				pte = pte_mkdirty(pte);
49c87f7677746f3 Ryan Roberts      2025-02-26  171  			if (pte_young(tmp_pte))
49c87f7677746f3 Ryan Roberts      2025-02-26  172  				pte = pte_mkyoung(pte);
d8bdcff2876424d Steve Capper      2017-08-22  173  		}
49c87f7677746f3 Ryan Roberts      2025-02-26  174  	}
49c87f7677746f3 Ryan Roberts      2025-02-26  175  	return pte;
d8bdcff2876424d Steve Capper      2017-08-22  176  }
d8bdcff2876424d Steve Capper      2017-08-22  177  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


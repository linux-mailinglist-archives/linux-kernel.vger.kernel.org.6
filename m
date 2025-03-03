Return-Path: <linux-kernel+bounces-542894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D3AA4CF26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA333171C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA223A99C;
	Mon,  3 Mar 2025 23:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jucf/9/P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53C223A58F
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741043878; cv=none; b=q3mED+oAQcvQxK/gWIdemqVTOV+kQvIAunvvbYmE3a6HhOwVt7KGtzJaupNHcjwuN9Ouso3nQBxTLg4jIRPibIzJtC/FRLvcb2xMZj4aZRQuVVH2zwanLyNH03a6/kMd78s/6p5umdM3M6ey51GZy8bQCJsD/QOCOlAJfMU1gCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741043878; c=relaxed/simple;
	bh=SFd9xqY4gRWrEeaGvoL5BbS0dlM1B0xqzUuSgE6I/jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXwu/x7IH+SUAvOsPSTvSIYSMYjd+C9P8leln5NdEPHe5t5TQnqlrTj/CG9N30egTXXPvOA/pS12f1SLzdZU2aQ4JK1kkoTdSf9tVDMdeKqaf9SErNc/eBPkSaCiDv5upFwzgFf2E6qA+xeW5zsK2j0h5bxO0KHa3dZ3CtL9rNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jucf/9/P; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741043876; x=1772579876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SFd9xqY4gRWrEeaGvoL5BbS0dlM1B0xqzUuSgE6I/jU=;
  b=Jucf/9/PDtqTOrha5QPHUWsBRNSj+R7AkUPnU39UXdJJ6iB28mrPLJBv
   LW4SJ78ZWkuzWGD6/wxi0rwKr5f2Y7TZ8ejiSBMw59s20kf+n1grVi/gr
   cI08Q5wmsGaftp7XviwQ0bpJChWBFP7DFxfI8OPiUwULUET2lwFViqcrT
   UOJjKFFnxjr7nxlRUp1a7+G0iXOEYxnq9GYd7pE4qI+2IK9oBqbw9OnMw
   RVAJedwUabKdp/aMgzVU+0TjMRNVksO3/oWWyZufZ+qOOMTeqtfQR5N/O
   pbqAvySp14X0JuD0CIc4P2QBhvGvZAY29M9uQwjil2cOMyZzKrjMuTYmr
   Q==;
X-CSE-ConnectionGUID: 5FtOJCzaQO2HsWdNF4W9Eg==
X-CSE-MsgGUID: aSm3UtzDTHOYOALYnOeH/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41793230"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41793230"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:17:55 -0800
X-CSE-ConnectionGUID: sEVzVHs+QoeNAc8uMv0Xmw==
X-CSE-MsgGUID: WUITPo2qQcmI9dGrnWUvPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118717350"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 03 Mar 2025 15:17:53 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpF2k-000J1o-1t;
	Mon, 03 Mar 2025 23:17:50 +0000
Date: Tue, 4 Mar 2025 07:17:30 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mm/mremap: thread state through move page table
 operation
Message-ID: <202503040721.0r47FGNO-lkp@intel.com>
References: <4cc18ebfc0cb32e9e42d86503cef3265108343e4.1740911247.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc18ebfc0cb32e9e42d86503cef3265108343e4.1740911247.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.14-rc5 next-20250303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-mremap-correctly-handle-partial-mremap-of-VMA-starting-at-0/20250303-192101
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/4cc18ebfc0cb32e9e42d86503cef3265108343e4.1740911247.git.lorenzo.stoakes%40oracle.com
patch subject: [PATCH 7/7] mm/mremap: thread state through move page table operation
config: x86_64-buildonly-randconfig-001-20250304 (https://download.01.org/0day-ci/archive/20250304/202503040721.0r47FGNO-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503040721.0r47FGNO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503040721.0r47FGNO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/mremap.c:11:
   In file included from include/linux/mm.h:2302:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/mremap.c:12:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/mremap.c:581:43: error: too few arguments to function call, expected 5, have 3
     581 |                         move_huge_pud(pmc, old_entry, new_entry);
         |                         ~~~~~~~~~~~~~                          ^
   mm/mremap.c:478:13: note: 'move_huge_pud' declared here
     478 | static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
         |             ^             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     479 |                           unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
         |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings and 1 error generated.


vim +581 mm/mremap.c

   552	
   553	/*
   554	 * Attempts to speedup the move by moving entry at the level corresponding to
   555	 * pgt_entry. Returns true if the move was successful, else false.
   556	 */
   557	static bool move_pgt_entry(struct pagetable_move_control *pmc,
   558				   enum pgt_entry entry, void *old_entry, void *new_entry)
   559	{
   560		bool moved = false;
   561		bool need_rmap_locks = should_take_rmap_locks(pmc, entry);
   562	
   563		/* See comment in move_ptes() */
   564		if (need_rmap_locks)
   565			take_rmap_locks(pmc->old);
   566	
   567		switch (entry) {
   568		case NORMAL_PMD:
   569			moved = move_normal_pmd(pmc, old_entry, new_entry);
   570			break;
   571		case NORMAL_PUD:
   572			moved = move_normal_pud(pmc, old_entry, new_entry);
   573			break;
   574		case HPAGE_PMD:
   575			moved = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
   576				move_huge_pmd(pmc->old, pmc->old_addr, pmc->new_addr, old_entry,
   577					      new_entry);
   578			break;
   579		case HPAGE_PUD:
   580			moved = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
 > 581				move_huge_pud(pmc, old_entry, new_entry);
   582			break;
   583	
   584		default:
   585			WARN_ON_ONCE(1);
   586			break;
   587		}
   588	
   589		if (need_rmap_locks)
   590			drop_rmap_locks(pmc->old);
   591	
   592		return moved;
   593	}
   594	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


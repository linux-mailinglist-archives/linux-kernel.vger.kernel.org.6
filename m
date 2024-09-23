Return-Path: <linux-kernel+bounces-336331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5331898393D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7434A1C21837
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 21:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657184DE0;
	Mon, 23 Sep 2024 21:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTMsb+6y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E765880603
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128310; cv=none; b=r+LJeGgmooQbaE18OBqPRY3C91Uy3PGVqLBMETuXhEaE0n/oX9QEr5yW4Axo3R98X3r9ADF0DqxDrYd/T/f+CBDkCe14VkoRNqTBuaELpjhEWS/DPAmMWziGjxmhu9x1XWvAxg/N97LVdBdHvBiFIVxisulz3MDJFhCXLvXuyPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128310; c=relaxed/simple;
	bh=/XMkitZmQOj9z2uzAc5J+TtyXWp+PA25nrAlg6fz0/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoEq8NrGBwRnX7DnnXjKgqPGUuBF5M9VVQfzjHOHni9ls7wOUa7R5zlWuccFLWzTVkL2o1u4+dpmxD8wbs5bD/u6oykyR+GTZVinD3ROaNHksPW1+91bQQnSYAiQ6iTpEzGz0FZqi13gDACJxmctICd+lnSPaPNARTXt3MZD8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTMsb+6y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727128308; x=1758664308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/XMkitZmQOj9z2uzAc5J+TtyXWp+PA25nrAlg6fz0/M=;
  b=UTMsb+6yyy1zz9IEeidPxG43a2Hhfsq2/6IF49PEzfUAeO49XUrUlE9R
   q2BPNPsI9JVwtUPlmsjN+O06bZitacpwYfcErRLGBSqTllWuV6v8RBmej
   fiXBLTLhYFVygfO3wYJf0+k4Ed2+l14DaP9U4+a3vHV7jyzRVMBEEaaMq
   zZDiC+YAhc+pBPd2I9V9J3xI0s4V1UqxvgfaeMX6pG7ire3vyGWB/mPT9
   zUaMuqg9UnibVGTstY4An5K7uqSAbJvIb7WPHUGyx2fDfJtNed6G9VlYB
   UfHA1qh/h6aimQnlPl8UB4U2gbYCvHSap7IsfETzR2AdwEeZEvAfZoa20
   A==;
X-CSE-ConnectionGUID: lxH5GuveQKaalriOVubfng==
X-CSE-MsgGUID: kKxYNZHmQzutvAzsm4unuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="26214760"
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="26214760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 14:51:48 -0700
X-CSE-ConnectionGUID: /4MnzUCBQaKCwjyStipeVg==
X-CSE-MsgGUID: M9lDCBkKR6q1uYX2h6ZddA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,252,1719903600"; 
   d="scan'208";a="71642673"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 23 Sep 2024 14:51:45 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssqy6-000Hd3-2d;
	Mon, 23 Sep 2024 21:51:42 +0000
Date: Tue, 24 Sep 2024 05:51:11 +0800
From: kernel test robot <lkp@intel.com>
To: Guenter Roeck <linux@roeck-us.net>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	David Hildenbrand <david@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] mm: Make SPLIT_PTE_PTLOCKS depend on the existence of
 NR_CPUS
Message-ID: <202409240546.SJwj9tUj-lkp@intel.com>
References: <20240923142533.1197982-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923142533.1197982-1-linux@roeck-us.net>

Hi Guenter,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Guenter-Roeck/mm-Make-SPLIT_PTE_PTLOCKS-depend-on-the-existence-of-NR_CPUS/20240923-222628
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240923142533.1197982-1-linux%40roeck-us.net
patch subject: [PATCH] mm: Make SPLIT_PTE_PTLOCKS depend on the existence of NR_CPUS
config: s390-defconfig (https://download.01.org/0day-ci/archive/20240924/202409240546.SJwj9tUj-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409240546.SJwj9tUj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409240546.SJwj9tUj-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/s390/mm/gmap.c:12:
   In file included from include/linux/pagewalk.h:5:
   In file included from include/linux/mm.h:2198:
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
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> arch/s390/mm/gmap.c:357:9: error: call to undeclared function 'pmd_pgtable_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     357 |         page = pmd_pgtable_page((pmd_t *) entry);
         |                ^
>> arch/s390/mm/gmap.c:357:7: error: incompatible integer to pointer conversion assigning to 'struct page *' from 'int' [-Wint-conversion]
     357 |         page = pmd_pgtable_page((pmd_t *) entry);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings and 2 errors generated.


vim +/pmd_pgtable_page +357 arch/s390/mm/gmap.c

1e133ab296f3ff Martin Schwidefsky 2016-03-08  343  
1e133ab296f3ff Martin Schwidefsky 2016-03-08  344  /**
1e133ab296f3ff Martin Schwidefsky 2016-03-08  345   * __gmap_segment_gaddr - find virtual address from segment pointer
1e133ab296f3ff Martin Schwidefsky 2016-03-08  346   * @entry: pointer to a segment table entry in the guest address space
1e133ab296f3ff Martin Schwidefsky 2016-03-08  347   *
1e133ab296f3ff Martin Schwidefsky 2016-03-08  348   * Returns the virtual address in the guest address space for the segment
1e133ab296f3ff Martin Schwidefsky 2016-03-08  349   */
1e133ab296f3ff Martin Schwidefsky 2016-03-08  350  static unsigned long __gmap_segment_gaddr(unsigned long *entry)
1e133ab296f3ff Martin Schwidefsky 2016-03-08  351  {
1e133ab296f3ff Martin Schwidefsky 2016-03-08  352  	struct page *page;
7e25de77bc5ea5 Anshuman Khandual  2022-11-25  353  	unsigned long offset;
1e133ab296f3ff Martin Schwidefsky 2016-03-08  354  
1e133ab296f3ff Martin Schwidefsky 2016-03-08  355  	offset = (unsigned long) entry / sizeof(unsigned long);
1e133ab296f3ff Martin Schwidefsky 2016-03-08  356  	offset = (offset & (PTRS_PER_PMD - 1)) * PMD_SIZE;
7e25de77bc5ea5 Anshuman Khandual  2022-11-25 @357  	page = pmd_pgtable_page((pmd_t *) entry);
1e133ab296f3ff Martin Schwidefsky 2016-03-08  358  	return page->index + offset;
1e133ab296f3ff Martin Schwidefsky 2016-03-08  359  }
1e133ab296f3ff Martin Schwidefsky 2016-03-08  360  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


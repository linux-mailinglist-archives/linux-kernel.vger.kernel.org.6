Return-Path: <linux-kernel+bounces-542899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7154DA4CF39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364487A76BD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF911F1311;
	Mon,  3 Mar 2025 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivlyt4av"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E491F20EB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044659; cv=none; b=FZ5bEMM7SFvfKb12GniN0NQ4koeIOh1A/yrLVfZUpQIUJZPooIN9YUB4s1iBl2T4+hEK4ohBGrmYhJ+BT3bUzp0X0f45lLnURfaSRoniLAbVCME+ivjCvqwiw8vdRqf/mZqB7ti7ZYUGdeHLeDzkNF5gBwyszc8l6hfrcJHdUG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044659; c=relaxed/simple;
	bh=jxbIi6utBMKjNCeA4xWPxd8lFamZ4p1d6PoAjO1pqIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuB9kTL5kJFQwn6astfoD37OV7xKZ6+lyHM9zd4x/2bg2mBdm0WbQF0mApJzlv7J0pq9obEsrcXlYplIcUnaBI3AeOu0l4kPEwFRA4RPnJjFFS1zWkI8UjqcCZ4pohGkIfgcx3GWkwG3b7uer7SG6/bdAoAJimtTLZk+R6jR0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivlyt4av; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741044657; x=1772580657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jxbIi6utBMKjNCeA4xWPxd8lFamZ4p1d6PoAjO1pqIU=;
  b=ivlyt4avv9r9sp73bCYgTQ5vghZd9BqO/75YGtMnBzDzleifT4/3FVzj
   JDyC2uY29euaevix9yobB5EiZfLlNqIs0v6ZkqJDNk+f+T7Ei46ZpFCx8
   i+bGAlhIB0lgiU22hBzVG02ZGHwyCW/6OIiA7OdpnnlsdclT3fIZ8OOKx
   7aXVj4HrgmRCrVjZ6fIPSBGO1MOHOYYEU02zW/BHe4gMuxAMzNLjOp2rV
   J5S0knSccs3SelG8tQ6ry/Fe6En496eXO6aPqpYAXEW/4IxhxxY3L4Tfd
   Bx+wvencF6EuXY5Yyy6zDVupa8ywggjKOt5P/xJdl5Ab7reqsT42LjRAD
   g==;
X-CSE-ConnectionGUID: JBf7TFaJS/CYIosgRIC5PQ==
X-CSE-MsgGUID: PgvoKKKyRWmns06S7rqNpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41835543"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="41835543"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 15:30:56 -0800
X-CSE-ConnectionGUID: l0hflE1hSkitjuc8EeEKFw==
X-CSE-MsgGUID: T7+sTy/8RxynuCDRXcPWig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117981115"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 03 Mar 2025 15:30:54 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpFFL-000J2U-2R;
	Mon, 03 Mar 2025 23:30:51 +0000
Date: Tue, 4 Mar 2025 07:30:16 +0800
From: kernel test robot <lkp@intel.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mm/mremap: thread state through move page table
 operation
Message-ID: <202503040759.5zpJdC2i-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master v6.14-rc5 next-20250303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-mremap-correctly-handle-partial-mremap-of-VMA-starting-at-0/20250303-192101
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/4cc18ebfc0cb32e9e42d86503cef3265108343e4.1740911247.git.lorenzo.stoakes%40oracle.com
patch subject: [PATCH 7/7] mm/mremap: thread state through move page table operation
config: x86_64-buildonly-randconfig-005-20250304 (https://download.01.org/0day-ci/archive/20250304/202503040759.5zpJdC2i-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250304/202503040759.5zpJdC2i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503040759.5zpJdC2i-lkp@intel.com/

All warnings (new ones prefixed by >>):

   mm/mremap.c: In function 'move_pgt_entry':
   mm/mremap.c:581:39: error: passing argument 1 of 'move_huge_pud' from incompatible pointer type [-Werror=incompatible-pointer-types]
     581 |                         move_huge_pud(pmc, old_entry, new_entry);
         |                                       ^~~
         |                                       |
         |                                       struct pagetable_move_control *
   mm/mremap.c:478:50: note: expected 'struct vm_area_struct *' but argument is of type 'struct pagetable_move_control *'
     478 | static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
         |                           ~~~~~~~~~~~~~~~~~~~~~~~^~~
>> mm/mremap.c:581:44: warning: passing argument 2 of 'move_huge_pud' makes integer from pointer without a cast [-Wint-conversion]
     581 |                         move_huge_pud(pmc, old_entry, new_entry);
         |                                            ^~~~~~~~~
         |                                            |
         |                                            void *
   mm/mremap.c:478:69: note: expected 'long unsigned int' but argument is of type 'void *'
     478 | static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
         |                                                       ~~~~~~~~~~~~~~^~~~~~~~
   mm/mremap.c:581:55: warning: passing argument 3 of 'move_huge_pud' makes integer from pointer without a cast [-Wint-conversion]
     581 |                         move_huge_pud(pmc, old_entry, new_entry);
         |                                                       ^~~~~~~~~
         |                                                       |
         |                                                       void *
   mm/mremap.c:479:41: note: expected 'long unsigned int' but argument is of type 'void *'
     479 |                           unsigned long new_addr, pud_t *old_pud, pud_t *new_pud)
         |                           ~~~~~~~~~~~~~~^~~~~~~~
   mm/mremap.c:581:25: error: too few arguments to function 'move_huge_pud'
     581 |                         move_huge_pud(pmc, old_entry, new_entry);
         |                         ^~~~~~~~~~~~~
   mm/mremap.c:478:13: note: declared here
     478 | static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
         |             ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/move_huge_pud +581 mm/mremap.c

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


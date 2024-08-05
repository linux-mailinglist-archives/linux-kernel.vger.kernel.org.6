Return-Path: <linux-kernel+bounces-275354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DBD9483CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336E91C21EE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7CE16B3B5;
	Mon,  5 Aug 2024 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K5ld5JID"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425D514A4C9
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722891815; cv=none; b=DfZzQbmPZxJzkIWpY83yBFOhXg5SqccI2aMCc+8UszNdo9z8YjP1sKDpw3G3/JULDQJAPMwBoBoO9jMVJr2ThSerap5e30CjjHihiNA/RqtacD0D3IyDMlYf7+pl2QHGvkL/OdCTHSkRg8oFI+0yl5jiLPpeeKhgsYJsASZnzpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722891815; c=relaxed/simple;
	bh=ybRRc0qCYMWUNdwHoCSea8Pm2hzhy6osyIzBAfrVz2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic+/NhpUonFqqNz4ZJ39xC1awt7zN0yf6u6k6CoIpNGnhCQnqXcnJUHZHmfwqYysMHMNHT48Wxn+Fb3tAjGhmRtf5Eltl9/ZXEzeYdakzvxe2FJ7dJ6v4HwPqJ+zR3OwyURHVxg9X5Cb9043d8Ea9CiSHZxgZpvGmvYSo66P/+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K5ld5JID; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722891813; x=1754427813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ybRRc0qCYMWUNdwHoCSea8Pm2hzhy6osyIzBAfrVz2I=;
  b=K5ld5JIDxxQKk/o/GG4/ElBArar1fDltWzg0yuhmujhGgEWhZBoiDK7a
   W5FbIsvXp10vNQPUpcDun/jabaklo2fT5HmWslFS7dQ9OaJnZa3gwfa+L
   hMlrtEa66ZkXNZMVGDw3KkP6TpDVcefqeGJMxs2lAykDc99LfE0K6HWZw
   ha3XP/6cg7Ak1lJ5V62WTo2xT3t1OV8aug1ZFYR+hfbhC37plfmMEgTGT
   I6j/ayg5caqX28x1b14iBnnN4A9r/V4CoNMLHpqz4Ee2QwwNqb/AHIiyb
   XeWGkfxkaOBB1u7PXsE8zbSn1sFxbnMYnTpXPaNm+9/HZAwr/4WeoNler
   g==;
X-CSE-ConnectionGUID: jf1c6en6ShKRwv9mTWua1g==
X-CSE-MsgGUID: m0JILo5eRkmlYyQWToSwuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="20553524"
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="20553524"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 14:03:33 -0700
X-CSE-ConnectionGUID: k9LgWkaXRaGW8EB5QerMXA==
X-CSE-MsgGUID: RCv3YLyCQwyIuqtAgsrP3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,265,1716274800"; 
   d="scan'208";a="60908630"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 05 Aug 2024 14:03:29 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sb4rX-0003j6-2G;
	Mon, 05 Aug 2024 21:03:27 +0000
Date: Tue, 6 Aug 2024 05:03:00 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 6/9] mm: Make hugetlb mappings go through
 mm_get_unmapped_area_vmflags
Message-ID: <202408060456.yBmmX9hr-lkp@intel.com>
References: <20240729091018.2152-7-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729091018.2152-7-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on s390/features]
[also build test WARNING on akpm-mm/mm-everything powerpc/next powerpc/fixes deller-parisc/for-next arnd-asm-generic/master linus/master v6.11-rc2 next-20240805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/mm-mmap-Teach-generic_get_unmapped_area-_topdown-to-handle-hugetlb-mappings/20240729-171449
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20240729091018.2152-7-osalvador%40suse.de
patch subject: [PATCH v2 6/9] mm: Make hugetlb mappings go through mm_get_unmapped_area_vmflags
config: x86_64-randconfig-012-20240802 (https://download.01.org/0day-ci/archive/20240806/202408060456.yBmmX9hr-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240806/202408060456.yBmmX9hr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408060456.yBmmX9hr-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/mm/hugetlbpage.c:84:1: warning: no previous prototype for 'hugetlb_get_unmapped_area' [-Wmissing-prototypes]
      84 | hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/hugetlb_get_unmapped_area +84 arch/x86/mm/hugetlbpage.c

^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   82  
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   83  unsigned long
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  @84  hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   85  		unsigned long len, unsigned long pgoff, unsigned long flags)
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   86  {
39c11e6c05b7fe arch/x86/mm/hugetlbpage.c  Andi Kleen             2008-07-23   87  	struct hstate *h = hstate_file(file);
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   88  	struct mm_struct *mm = current->mm;
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   89  	struct vm_area_struct *vma;
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   90  
39c11e6c05b7fe arch/x86/mm/hugetlbpage.c  Andi Kleen             2008-07-23   91  	if (len & ~huge_page_mask(h))
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   92  		return -EINVAL;
44b04912fa7248 arch/x86/mm/hugetlbpage.c  Kirill A. Shutemov     2017-07-17   93  
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   94  	if (len > TASK_SIZE)
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   95  		return -ENOMEM;
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16   96  
1e0f25dbf2464d arch/x86/mm/hugetlbpage.c  Kirill A. Shutemov     2017-11-15   97  	/* No address checking. See comment at mmap_address_hint_valid() */
5a8130f2b186ac arch/i386/mm/hugetlbpage.c Benjamin Herrenschmidt 2007-05-06   98  	if (flags & MAP_FIXED) {
a5516438959d90 arch/x86/mm/hugetlbpage.c  Andi Kleen             2008-07-23   99  		if (prepare_hugepage_range(file, addr, len))
5a8130f2b186ac arch/i386/mm/hugetlbpage.c Benjamin Herrenschmidt 2007-05-06  100  			return -EINVAL;
5a8130f2b186ac arch/i386/mm/hugetlbpage.c Benjamin Herrenschmidt 2007-05-06  101  		return addr;
5a8130f2b186ac arch/i386/mm/hugetlbpage.c Benjamin Herrenschmidt 2007-05-06  102  	}
5a8130f2b186ac arch/i386/mm/hugetlbpage.c Benjamin Herrenschmidt 2007-05-06  103  
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  104  	if (addr) {
1e0f25dbf2464d arch/x86/mm/hugetlbpage.c  Kirill A. Shutemov     2017-11-15  105  		addr &= huge_page_mask(h);
1e0f25dbf2464d arch/x86/mm/hugetlbpage.c  Kirill A. Shutemov     2017-11-15  106  		if (!mmap_address_hint_valid(addr, len))
1e0f25dbf2464d arch/x86/mm/hugetlbpage.c  Kirill A. Shutemov     2017-11-15  107  			goto get_unmapped_area;
1e0f25dbf2464d arch/x86/mm/hugetlbpage.c  Kirill A. Shutemov     2017-11-15  108  
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  109  		vma = find_vma(mm, addr);
1e0f25dbf2464d arch/x86/mm/hugetlbpage.c  Kirill A. Shutemov     2017-11-15  110  		if (!vma || addr + len <= vm_start_gap(vma))
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  111  			return addr;
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  112  	}
1e0f25dbf2464d arch/x86/mm/hugetlbpage.c  Kirill A. Shutemov     2017-11-15  113  
1e0f25dbf2464d arch/x86/mm/hugetlbpage.c  Kirill A. Shutemov     2017-11-15  114  get_unmapped_area:
529ce23a764f25 arch/x86/mm/hugetlbpage.c  Rick Edgecombe         2024-03-25  115  	if (!test_bit(MMF_TOPDOWN, &mm->flags))
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  116  		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  117  				pgoff, flags);
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  118  	else
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  119  		return hugetlb_get_unmapped_area_topdown(file, addr, len,
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  120  				pgoff, flags);
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  121  }
fd8526ad14c182 arch/x86/mm/hugetlbpage.c  Kirill A. Shutemov     2013-11-19  122  #endif /* CONFIG_HUGETLB_PAGE */
^1da177e4c3f41 arch/i386/mm/hugetlbpage.c Linus Torvalds         2005-04-16  123  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


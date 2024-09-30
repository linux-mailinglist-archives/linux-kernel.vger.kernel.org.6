Return-Path: <linux-kernel+bounces-343328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EFA9899AF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DE71C2091D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 04:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78B14D8BC;
	Mon, 30 Sep 2024 04:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWd4/XIw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A085BAF0
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 04:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727669092; cv=none; b=A7ICHcx90rREiMnxLGYFShNwpJeQaUjd6Xpwt7QGF4Evo/3sL9v+nHoVXzXzu2gIMbmSpV5PXJFTCXExNbkY5qlHLQ3tFn3CyW+HI7eC0WcdM0BqzULx/VLB7i7gi+d1ITRJAKIqEaKDw/Pv+70km/SeMOtOnMbhhdRyOZZbKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727669092; c=relaxed/simple;
	bh=5BD9iQUjk1C9VLkHoB1fCWk8ChnkGcacFpI2XjJxTJc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ohhjyN0zcm28U/eJYruz+0zKtYqOb8wdBY2B1LHPL+j3ngRHD6DzKI7yzTN0BKN8DpYDEKYbRBuqVee50lK52dq3NtCoDbRVzldzT7l2j5PpVjffEeeDm+Q4gdlETBwkQzjT9SuWqHZy2raUWqW7a6TolvrD7XPKKP35fjNKQdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWd4/XIw; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727669090; x=1759205090;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5BD9iQUjk1C9VLkHoB1fCWk8ChnkGcacFpI2XjJxTJc=;
  b=OWd4/XIwiZAEe6Gb6efn/xrfROR+S1HmshOeWuBOPahKGddZhlnghr2Q
   8t/LXdKV1/RiVu7BQED9YahDF5r5qtJY76XcVo1vgaFHMmgRRd2TNMUdW
   RidgcRoqbivkXBe4QDhWEXenJkhWxgHNmmggRzMLlK28lcf26W+yQsZFz
   uTuQWlY519e7o8kylbejSbLjatSxkud9Viz2BuxjIrSdmLMBr+4qJ6P6Z
   oEQaT4Fx4hl0A2KryDKew6LtCzNGvpK3XFf/jNi2aK75WkbojDWU/w1cN
   W5x7LMr8d6q2o9lIXart7Nj7c/1wa73CsNcnqc20fUGqyZwMOuFi1mjj9
   A==;
X-CSE-ConnectionGUID: jbGxgvlcTpmV460JpqVpwA==
X-CSE-MsgGUID: GdHYLdGAQf2sqsTgpLLJCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="29620331"
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="29620331"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 21:04:49 -0700
X-CSE-ConnectionGUID: vU226D2dTtWndcptjgrPVA==
X-CSE-MsgGUID: ncpuzZocRmeihX+rFwg85g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,164,1725346800"; 
   d="scan'208";a="78107158"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 29 Sep 2024 21:04:47 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sv7eO-000P1f-1x;
	Mon, 30 Sep 2024 04:04:44 +0000
Date: Mon, 30 Sep 2024 12:04:37 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>, Alex Shi <alexs@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: arch/sh/mm/cache-sh4.c:224:13: error: assignment to 'pmd_t *' from
 'int' makes pointer from integer without a cast
Message-ID: <202409301241.wzlwAxsQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9852d85ec9d492ebef56dc5f229416c925758edc
commit: e8c07082a810fbb9db303a2b66b66b8d7e588b53 Kbuild: move to -std=gnu11
date:   2 years, 7 months ago
config: sh-randconfig-001-20240930 (https://download.01.org/0day-ci/archive/20240930/202409301241.wzlwAxsQ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240930/202409301241.wzlwAxsQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409301241.wzlwAxsQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sh/mm/cache-sh4.c: In function 'flush_cache_one':
   arch/sh/mm/cache-sh4.c:99:31: error: 'cached_to_uncached' undeclared (first use in this function); did you mean 'jump_to_uncached'?
      99 |                 exec_offset = cached_to_uncached;
         |                               ^~~~~~~~~~~~~~~~~~
         |                               jump_to_uncached
   arch/sh/mm/cache-sh4.c:99:31: note: each undeclared identifier is reported only once for each function it appears in
   arch/sh/mm/cache-sh4.c: In function 'sh4_flush_cache_mm':
   arch/sh/mm/cache-sh4.c:192:13: error: implicit declaration of function 'cpu_context'; did you mean 'put_io_context'? [-Wimplicit-function-declaration]
     192 |         if (cpu_context(smp_processor_id(), mm) == NO_CONTEXT)
         |             ^~~~~~~~~~~
         |             put_io_context
   arch/sh/mm/cache-sh4.c: In function 'sh4_flush_cache_page':
   arch/sh/mm/cache-sh4.c:224:15: error: implicit declaration of function 'pmd_off' [-Wimplicit-function-declaration]
     224 |         pmd = pmd_off(vma->vm_mm, address);
         |               ^~~~~~~
>> arch/sh/mm/cache-sh4.c:224:13: error: assignment to 'pmd_t *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     224 |         pmd = pmd_off(vma->vm_mm, address);
         |             ^
   arch/sh/mm/cache-sh4.c:225:15: error: implicit declaration of function 'pte_offset_kernel' [-Wimplicit-function-declaration]
     225 |         pte = pte_offset_kernel(pmd, address);
         |               ^~~~~~~~~~~~~~~~~
>> arch/sh/mm/cache-sh4.c:225:13: error: assignment to 'pte_t *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     225 |         pte = pte_offset_kernel(pmd, address);
         |             ^
   arch/sh/mm/cache-sh4.c: In function 'sh4_flush_cache_range':
   arch/sh/mm/cache-sh4.c:276:30: warning: variable 'end' set but not used [-Wunused-but-set-variable]
     276 |         unsigned long start, end;
         |                              ^~~
   arch/sh/mm/cache-sh4.c:276:23: warning: variable 'start' set but not used [-Wunused-but-set-variable]
     276 |         unsigned long start, end;
         |                       ^~~~~
   arch/sh/mm/cache-sh4.c: At top level:
   arch/sh/mm/cache-sh4.c:374:13: warning: no previous prototype for 'sh4_cache_init' [-Wmissing-prototypes]
     374 | void __init sh4_cache_init(void)
         |             ^~~~~~~~~~~~~~


vim +224 arch/sh/mm/cache-sh4.c

^1da177e4c3f41 Linus Torvalds     2005-04-16  197  
^1da177e4c3f41 Linus Torvalds     2005-04-16  198  /*
^1da177e4c3f41 Linus Torvalds     2005-04-16  199   * Write back and invalidate I/D-caches for the page.
^1da177e4c3f41 Linus Torvalds     2005-04-16  200   *
^1da177e4c3f41 Linus Torvalds     2005-04-16  201   * ADDR: Virtual Address (U0 address)
^1da177e4c3f41 Linus Torvalds     2005-04-16  202   * PFN: Physical page number
^1da177e4c3f41 Linus Torvalds     2005-04-16  203   */
f26b2a562b46ab Paul Mundt         2009-08-21  204  static void sh4_flush_cache_page(void *args)
^1da177e4c3f41 Linus Torvalds     2005-04-16  205  {
f26b2a562b46ab Paul Mundt         2009-08-21  206  	struct flusher_data *data = args;
f26b2a562b46ab Paul Mundt         2009-08-21  207  	struct vm_area_struct *vma;
deaef20e9789d9 Paul Mundt         2009-09-09  208  	struct page *page;
f26b2a562b46ab Paul Mundt         2009-08-21  209  	unsigned long address, pfn, phys;
deaef20e9789d9 Paul Mundt         2009-09-09  210  	int map_coherent = 0;
deaef20e9789d9 Paul Mundt         2009-09-09  211  	pmd_t *pmd;
deaef20e9789d9 Paul Mundt         2009-09-09  212  	pte_t *pte;
deaef20e9789d9 Paul Mundt         2009-09-09  213  	void *vaddr;
b638d0b921dc95 Richard Curnow     2006-09-27  214  
f26b2a562b46ab Paul Mundt         2009-08-21  215  	vma = data->vma;
abeaf33a410176 Paul Mundt         2009-10-16  216  	address = data->addr1 & PAGE_MASK;
f26b2a562b46ab Paul Mundt         2009-08-21  217  	pfn = data->addr2;
f26b2a562b46ab Paul Mundt         2009-08-21  218  	phys = pfn << PAGE_SHIFT;
deaef20e9789d9 Paul Mundt         2009-09-09  219  	page = pfn_to_page(pfn);
f26b2a562b46ab Paul Mundt         2009-08-21  220  
e7b8b7f16edc9b Paul Mundt         2009-08-15  221  	if (cpu_context(smp_processor_id(), vma->vm_mm) == NO_CONTEXT)
e7b8b7f16edc9b Paul Mundt         2009-08-15  222  		return;
e7b8b7f16edc9b Paul Mundt         2009-08-15  223  
e05c7b1f2bc4b7 Mike Rapoport      2020-06-08 @224  	pmd = pmd_off(vma->vm_mm, address);
deaef20e9789d9 Paul Mundt         2009-09-09 @225  	pte = pte_offset_kernel(pmd, address);
deaef20e9789d9 Paul Mundt         2009-09-09  226  
deaef20e9789d9 Paul Mundt         2009-09-09  227  	/* If the page isn't present, there is nothing to do here. */
deaef20e9789d9 Paul Mundt         2009-09-09  228  	if (!(pte_val(*pte) & _PAGE_PRESENT))
deaef20e9789d9 Paul Mundt         2009-09-09  229  		return;
^1da177e4c3f41 Linus Torvalds     2005-04-16  230  
deaef20e9789d9 Paul Mundt         2009-09-09  231  	if ((vma->vm_mm == current->active_mm))
deaef20e9789d9 Paul Mundt         2009-09-09  232  		vaddr = NULL;
deaef20e9789d9 Paul Mundt         2009-09-09  233  	else {
b638d0b921dc95 Richard Curnow     2006-09-27  234  		/*
deaef20e9789d9 Paul Mundt         2009-09-09  235  		 * Use kmap_coherent or kmap_atomic to do flushes for
deaef20e9789d9 Paul Mundt         2009-09-09  236  		 * another ASID than the current one.
b638d0b921dc95 Richard Curnow     2006-09-27  237  		 */
deaef20e9789d9 Paul Mundt         2009-09-09  238  		map_coherent = (current_cpu_data.dcache.n_aliases &&
55661fc1f105ed Paul Mundt         2010-12-01  239  			test_bit(PG_dcache_clean, &page->flags) &&
e1534ae95004d6 Kirill A. Shutemov 2016-01-15  240  			page_mapcount(page));
deaef20e9789d9 Paul Mundt         2009-09-09  241  		if (map_coherent)
deaef20e9789d9 Paul Mundt         2009-09-09  242  			vaddr = kmap_coherent(page, address);
deaef20e9789d9 Paul Mundt         2009-09-09  243  		else
bc3e11be88010e Cong Wang          2011-11-25  244  			vaddr = kmap_atomic(page);
deaef20e9789d9 Paul Mundt         2009-09-09  245  
deaef20e9789d9 Paul Mundt         2009-09-09  246  		address = (unsigned long)vaddr;
deaef20e9789d9 Paul Mundt         2009-09-09  247  	}
deaef20e9789d9 Paul Mundt         2009-09-09  248  
abeaf33a410176 Paul Mundt         2009-10-16  249  	flush_cache_one(CACHE_OC_ADDRESS_ARRAY |
deaef20e9789d9 Paul Mundt         2009-09-09  250  			(address & shm_align_mask), phys);
deaef20e9789d9 Paul Mundt         2009-09-09  251  
deaef20e9789d9 Paul Mundt         2009-09-09  252  	if (vma->vm_flags & VM_EXEC)
deaef20e9789d9 Paul Mundt         2009-09-09  253  		flush_icache_all();
deaef20e9789d9 Paul Mundt         2009-09-09  254  
deaef20e9789d9 Paul Mundt         2009-09-09  255  	if (vaddr) {
deaef20e9789d9 Paul Mundt         2009-09-09  256  		if (map_coherent)
deaef20e9789d9 Paul Mundt         2009-09-09  257  			kunmap_coherent(vaddr);
deaef20e9789d9 Paul Mundt         2009-09-09  258  		else
bc3e11be88010e Cong Wang          2011-11-25  259  			kunmap_atomic(vaddr);
^1da177e4c3f41 Linus Torvalds     2005-04-16  260  	}
b638d0b921dc95 Richard Curnow     2006-09-27  261  }
^1da177e4c3f41 Linus Torvalds     2005-04-16  262  

:::::: The code at line 224 was first introduced by commit
:::::: e05c7b1f2bc4b7b28199b9a7572f73436d97317e mm: pgtable: add shortcuts for accessing kernel PMD and PTE

:::::: TO: Mike Rapoport <rppt@linux.ibm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


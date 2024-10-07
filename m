Return-Path: <linux-kernel+bounces-352756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 853D89923CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EA428221B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 05:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD311136672;
	Mon,  7 Oct 2024 05:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ExlhJRqL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85F42AA4
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 05:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728277653; cv=none; b=CDQdf9bvIsLL7bB5aDgBOlyHlyE+B2yKK1FSitaSCBzDfYwcyS6NFbYYo7TmzOoTXmKKnIEBU87x4+Jl2KbC1QOUYMTesPtK6V9kqkWlqbEUf/OTeyJ6xejMyxlIzT9SIFQV9vLZAYcQbfjnmyLyM6xNjxEEglIc69H+zUwY35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728277653; c=relaxed/simple;
	bh=ilDL4Wcf6Tmyau30miOiykib5wiV9EZuzRqaVlwzhV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POVrqZEmCvAN1BqLwfWAtH2XEM/0C44a1MuZFFQXlUN38oVvaOcia3d2GNMW/leF9vZ9rsQDo/6LVGnXjcxCe88fbQKxtSGfzqmzenifgWIljhh0cPWr+xjWHgEHInHPdw1zQWsk+UUA471r0HYW5nYze6HDhpZnHTPgY/xF8MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ExlhJRqL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728277651; x=1759813651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ilDL4Wcf6Tmyau30miOiykib5wiV9EZuzRqaVlwzhV4=;
  b=ExlhJRqL+BSew0NAQTjt5CGum3jQHUZ8OpUTLQuJsMzCHtrkycywUvyh
   J1CHXgpXlMnI1wbSl9Rzq7Lpr/8ji9XlCPI4dYdVFX0R9vxQP4qZzhZu3
   VXx28L0odNJe/KSiTZbWJco/IHD2mTo8/cIdx1ooAQHxF/5T3S/ulTDs7
   0sZYOQClJZYdBHGxd4UYREh0Wx0bJMI01AwpsKl33k0dsqrOFkyxhm8vB
   +hegnVxcbLueZv1LYOALvkf4A5P8ChHfCpnQ3E3O6+r/wz+545yDKt+9v
   FybK4fBG1OxVAqtRU6W08FVCEO7Avxts1kTNTdo0lsmgEwpUZBD7V3A4x
   w==;
X-CSE-ConnectionGUID: DiGYnL3VRSid0KakOSkg2w==
X-CSE-MsgGUID: tOk/cBS1QbmI1iHCVmeVOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="44942191"
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="44942191"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2024 22:07:30 -0700
X-CSE-ConnectionGUID: uTqtuvXcQ6KhVHe04r9JeQ==
X-CSE-MsgGUID: RgTsME9jRz6qcgPmhnnDXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,183,1725346800"; 
   d="scan'208";a="79941926"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 06 Oct 2024 22:07:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxfxu-0004bq-1J;
	Mon, 07 Oct 2024 05:07:26 +0000
Date: Mon, 7 Oct 2024 13:06:49 +0800
From: kernel test robot <lkp@intel.com>
To: Jeongjun Park <aha310510@gmail.com>, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kasong@tencent.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	syzbot+fa43f1b63e3aa6f66329@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH] mm: swap: prevent possible data-race in
 __try_to_reclaim_swap
Message-ID: <202410071223.t0yF8vP8-lkp@intel.com>
References: <20241004142504.4379-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004142504.4379-1-aha310510@gmail.com>

Hi Jeongjun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeongjun-Park/mm-swap-prevent-possible-data-race-in-__try_to_reclaim_swap/20241004-222733
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241004142504.4379-1-aha310510%40gmail.com
patch subject: [PATCH] mm: swap: prevent possible data-race in __try_to_reclaim_swap
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241007/202410071223.t0yF8vP8-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241007/202410071223.t0yF8vP8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410071223.t0yF8vP8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> mm/swapfile.c:203:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
     203 |         if (!folio_trylock(folio))
         |             ^~~~~~~~~~~~~~~~~~~~~
   mm/swapfile.c:254:9: note: uninitialized use occurs here
     254 |         return ret;
         |                ^~~
   mm/swapfile.c:203:2: note: remove the 'if' if its condition is always false
     203 |         if (!folio_trylock(folio))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
     204 |                 goto out;
         |                 ~~~~~~~~
   mm/swapfile.c:190:9: note: initialize the variable 'ret' to silence this warning
     190 |         int ret, nr_pages;
         |                ^
         |                 = 0
   1 warning generated.


vim +203 mm/swapfile.c

bea67dcc5eea0f Barry Song              2024-08-08  177  
a62fb92ac12ed3 Ryan Roberts            2024-04-08  178  /*
a62fb92ac12ed3 Ryan Roberts            2024-04-08  179   * returns number of pages in the folio that backs the swap entry. If positive,
a62fb92ac12ed3 Ryan Roberts            2024-04-08  180   * the folio was reclaimed. If negative, the folio was not reclaimed. If 0, no
a62fb92ac12ed3 Ryan Roberts            2024-04-08  181   * folio was associated with the swap entry.
a62fb92ac12ed3 Ryan Roberts            2024-04-08  182   */
bcd49e86710b42 Huang Ying              2018-10-26  183  static int __try_to_reclaim_swap(struct swap_info_struct *si,
bcd49e86710b42 Huang Ying              2018-10-26  184  				 unsigned long offset, unsigned long flags)
c9e444103b5e7a KAMEZAWA Hiroyuki       2009-06-16  185  {
efa90a981bbc89 Hugh Dickins            2009-12-14  186  	swp_entry_t entry = swp_entry(si->type, offset);
862590ac3708e1 Kairui Song             2024-07-30  187  	struct address_space *address_space = swap_address_space(entry);
862590ac3708e1 Kairui Song             2024-07-30  188  	struct swap_cluster_info *ci;
2c3f6194b008b2 Matthew Wilcox (Oracle  2022-09-02  189) 	struct folio *folio;
862590ac3708e1 Kairui Song             2024-07-30  190  	int ret, nr_pages;
862590ac3708e1 Kairui Song             2024-07-30  191  	bool need_reclaim;
c9e444103b5e7a KAMEZAWA Hiroyuki       2009-06-16  192  
862590ac3708e1 Kairui Song             2024-07-30  193  	folio = filemap_get_folio(address_space, swap_cache_index(entry));
66dabbb65d673a Christoph Hellwig       2023-03-07  194  	if (IS_ERR(folio))
c9e444103b5e7a KAMEZAWA Hiroyuki       2009-06-16  195  		return 0;
c9e444103b5e7a KAMEZAWA Hiroyuki       2009-06-16  196  	/*
bcd49e86710b42 Huang Ying              2018-10-26  197  	 * When this function is called from scan_swap_map_slots() and it's
2c3f6194b008b2 Matthew Wilcox (Oracle  2022-09-02  198) 	 * called by vmscan.c at reclaiming folios. So we hold a folio lock
bcd49e86710b42 Huang Ying              2018-10-26  199  	 * here. We have to use trylock for avoiding deadlock. This is a special
2c3f6194b008b2 Matthew Wilcox (Oracle  2022-09-02  200) 	 * case and you should use folio_free_swap() with explicit folio_lock()
c9e444103b5e7a KAMEZAWA Hiroyuki       2009-06-16  201  	 * in usual operations.
c9e444103b5e7a KAMEZAWA Hiroyuki       2009-06-16  202  	 */
862590ac3708e1 Kairui Song             2024-07-30 @203  	if (!folio_trylock(folio))
862590ac3708e1 Kairui Song             2024-07-30  204  		goto out;
862590ac3708e1 Kairui Song             2024-07-30  205  
b2dbc30a2a909d Jeongjun Park           2024-10-04  206  	/* offset could point to the middle of a large folio */
b2dbc30a2a909d Jeongjun Park           2024-10-04  207  	entry = folio->swap;
b2dbc30a2a909d Jeongjun Park           2024-10-04  208  	offset = swp_offset(entry);
b2dbc30a2a909d Jeongjun Park           2024-10-04  209  	nr_pages = folio_nr_pages(folio);
b2dbc30a2a909d Jeongjun Park           2024-10-04  210  	ret = -nr_pages;
b2dbc30a2a909d Jeongjun Park           2024-10-04  211  
862590ac3708e1 Kairui Song             2024-07-30  212  	need_reclaim = ((flags & TTRS_ANYWAY) ||
2c3f6194b008b2 Matthew Wilcox (Oracle  2022-09-02  213) 			((flags & TTRS_UNMAPPED) && !folio_mapped(folio)) ||
862590ac3708e1 Kairui Song             2024-07-30  214  			((flags & TTRS_FULL) && mem_cgroup_swap_full(folio)));
862590ac3708e1 Kairui Song             2024-07-30  215  	if (!need_reclaim || !folio_swapcache_freeable(folio))
862590ac3708e1 Kairui Song             2024-07-30  216  		goto out_unlock;
862590ac3708e1 Kairui Song             2024-07-30  217  
862590ac3708e1 Kairui Song             2024-07-30  218  	/*
862590ac3708e1 Kairui Song             2024-07-30  219  	 * It's safe to delete the folio from swap cache only if the folio's
862590ac3708e1 Kairui Song             2024-07-30  220  	 * swap_map is HAS_CACHE only, which means the slots have no page table
862590ac3708e1 Kairui Song             2024-07-30  221  	 * reference or pending writeback, and can't be allocated to others.
862590ac3708e1 Kairui Song             2024-07-30  222  	 */
862590ac3708e1 Kairui Song             2024-07-30  223  	ci = lock_cluster_or_swap_info(si, offset);
862590ac3708e1 Kairui Song             2024-07-30  224  	need_reclaim = swap_is_has_cache(si, offset, nr_pages);
862590ac3708e1 Kairui Song             2024-07-30  225  	unlock_cluster_or_swap_info(si, ci);
862590ac3708e1 Kairui Song             2024-07-30  226  	if (!need_reclaim)
862590ac3708e1 Kairui Song             2024-07-30  227  		goto out_unlock;
862590ac3708e1 Kairui Song             2024-07-30  228  
862590ac3708e1 Kairui Song             2024-07-30  229  	if (!(flags & TTRS_DIRECT)) {
862590ac3708e1 Kairui Song             2024-07-30  230  		/* Free through slot cache */
862590ac3708e1 Kairui Song             2024-07-30  231  		delete_from_swap_cache(folio);
862590ac3708e1 Kairui Song             2024-07-30  232  		folio_set_dirty(folio);
862590ac3708e1 Kairui Song             2024-07-30  233  		ret = nr_pages;
862590ac3708e1 Kairui Song             2024-07-30  234  		goto out_unlock;
c9e444103b5e7a KAMEZAWA Hiroyuki       2009-06-16  235  	}
862590ac3708e1 Kairui Song             2024-07-30  236  
862590ac3708e1 Kairui Song             2024-07-30  237  	xa_lock_irq(&address_space->i_pages);
862590ac3708e1 Kairui Song             2024-07-30  238  	__delete_from_swap_cache(folio, entry, NULL);
862590ac3708e1 Kairui Song             2024-07-30  239  	xa_unlock_irq(&address_space->i_pages);
862590ac3708e1 Kairui Song             2024-07-30  240  	folio_ref_sub(folio, nr_pages);
862590ac3708e1 Kairui Song             2024-07-30  241  	folio_set_dirty(folio);
862590ac3708e1 Kairui Song             2024-07-30  242  
862590ac3708e1 Kairui Song             2024-07-30  243  	spin_lock(&si->lock);
862590ac3708e1 Kairui Song             2024-07-30  244  	/* Only sinple page folio can be backed by zswap */
862590ac3708e1 Kairui Song             2024-07-30  245  	if (nr_pages == 1)
862590ac3708e1 Kairui Song             2024-07-30  246  		zswap_invalidate(entry);
862590ac3708e1 Kairui Song             2024-07-30  247  	swap_entry_range_free(si, entry, nr_pages);
862590ac3708e1 Kairui Song             2024-07-30  248  	spin_unlock(&si->lock);
862590ac3708e1 Kairui Song             2024-07-30  249  	ret = nr_pages;
862590ac3708e1 Kairui Song             2024-07-30  250  out_unlock:
862590ac3708e1 Kairui Song             2024-07-30  251  	folio_unlock(folio);
862590ac3708e1 Kairui Song             2024-07-30  252  out:
2c3f6194b008b2 Matthew Wilcox (Oracle  2022-09-02  253) 	folio_put(folio);
c9e444103b5e7a KAMEZAWA Hiroyuki       2009-06-16  254  	return ret;
c9e444103b5e7a KAMEZAWA Hiroyuki       2009-06-16  255  }
355cfa73ddff2f KAMEZAWA Hiroyuki       2009-06-16  256  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


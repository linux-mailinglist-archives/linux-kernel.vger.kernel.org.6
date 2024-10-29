Return-Path: <linux-kernel+bounces-386675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9599B46BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00C31C227F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFDB20494D;
	Tue, 29 Oct 2024 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9qv/qiw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDFD2040AF
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197501; cv=none; b=eP6fFvnW+uKAT3oQCuiA78NoUf/WjmySy3g/giiL4wxvu2aMMnuj56XH+xJzBSirvApiYmy2ltwjTx7gDtW6Hg/+nGNCCN/OXHWz2HNiNc88Y04As8VX86nSz1d7eLk8Tj/IrnLQL5BLkB5V6LmXdGTiIeZbe84lHjgTKwgRdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197501; c=relaxed/simple;
	bh=PjMN8UliST8cUxWYnYu6tMkq0bZKB9E+YnKhp/cEPNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSH8XtubVAOiIzdfc39/05gGJXCXE4Fky8z5TkYx0/FL9CcQJZvHpCJOXr5We192gVist/80s4RBDwIxPB0IPyqhf7sXDu+JVu+GPC84Xm2sxX8M6npAecaTRboxE5NSeNzEKbXSk8GSadSU/NzZkWJo/3eaZ+9xAin579KGYB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9qv/qiw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730197498; x=1761733498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PjMN8UliST8cUxWYnYu6tMkq0bZKB9E+YnKhp/cEPNQ=;
  b=K9qv/qiwGT9PgeXzziQODBDMpZmh0Yg76mQOsjNJz0NikEGqwEuyKnQ0
   2XCduEetDjGopN8xubNytRXUxaPDOrjYOojuTjoqmoqNYLGF88Tg+oAFP
   Jm7B9ZbHwQbLFrRAlgEa7Rw9qzgNxYtz5kSuum6Cf8LR2Stxk0otAkQzi
   f8QXm5+9TtKkeVZcH5rfpFIvDfMSxezVn5SAId0+CwL5SUatqTtyvPBvg
   u8dwo2IIYCMoUE66pzvcwvtc0LRlS7mVP1Pq0RW0zUoeT32Ue9bzHerPs
   aCiFXj+iLViJHqF22B/tFPXVXlvqNLEb4bqCE2XiF3qWxDaEJ1vNHu/PI
   w==;
X-CSE-ConnectionGUID: vkAXKSijQAWgD9jZonhjRQ==
X-CSE-MsgGUID: s0/55fP4SsOAvqaKOOghGw==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="55235006"
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="55235006"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 03:24:57 -0700
X-CSE-ConnectionGUID: zOvFqdxtQWyzgAfG6eKYtw==
X-CSE-MsgGUID: rmaqRUAPT4GR2XKBqvEiNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="82243549"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 29 Oct 2024 03:24:53 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5jP9-000dX2-0C;
	Tue, 29 Oct 2024 10:24:51 +0000
Date: Tue, 29 Oct 2024 18:24:19 +0800
From: kernel test robot <lkp@intel.com>
To: Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v1 1/3] mm/huge_memory: buddy allocator like folio_split()
Message-ID: <202410291853.lBOeTPTK-lkp@intel.com>
References: <20241028180932.1319265-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028180932.1319265-2-ziy@nvidia.com>

Hi Zi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20241029]
[cannot apply to linus/master v6.12-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zi-Yan/mm-huge_memory-buddy-allocator-like-folio_split/20241029-021200
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241028180932.1319265-2-ziy%40nvidia.com
patch subject: [PATCH v1 1/3] mm/huge_memory: buddy allocator like folio_split()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241029/202410291853.lBOeTPTK-lkp@intel.com/config)
compiler: clang version 19.1.2 (https://github.com/llvm/llvm-project 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241029/202410291853.lBOeTPTK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291853.lBOeTPTK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/huge_memory.c:8:
   In file included from include/linux/mm.h:2213:
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
   In file included from mm/huge_memory.c:18:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/huge_memory.c:3342:6: warning: variable 'nr_dropped' set but not used [-Wunused-but-set-variable]
    3342 |         int nr_dropped = 0;
         |             ^
   mm/huge_memory.c:3806:12: warning: unused function 'folio_split' [-Wunused-function]
    3806 | static int folio_split(struct folio *folio, unsigned int new_order,
         |            ^~~~~~~~~~~
   8 warnings generated.


vim +/nr_dropped +3342 mm/huge_memory.c

  3292	
  3293	#define for_each_folio_until_end_safe(iter, iter2, start, end)	\
  3294		for (iter = start, iter2 = folio_next(start);		\
  3295		     iter != end;					\
  3296		     iter = iter2, iter2 = folio_next(iter2))
  3297	
  3298	/*
  3299	 * It splits a @folio (without mapping) to lower order smaller folios in two
  3300	 * ways.
  3301	 * 1. uniform split: the given @folio into multiple @new_order small folios,
  3302	 *    where all small folios have the same order. This is done when
  3303	 *    uniform_split is true.
  3304	 * 2. buddy allocator like split: the given @folio is split into half and one
  3305	 *    of the half (containing the given page) is split into half until the
  3306	 *    given @page's order becomes @new_order. This is done when uniform_split is
  3307	 *    false.
  3308	 *
  3309	 * The high level flow for these two methods are:
  3310	 * 1. uniform split: a single __split_folio_to_order() is called to split the
  3311	 *    @folio into @new_order, then we traverse all the resulting folios one by
  3312	 *    one in PFN ascending order and perform stats, unfreeze, adding to list,
  3313	 *    and file mapping index operations.
  3314	 * 2. buddy allocator like split: in general, folio_order - @new_order calls to
  3315	 *    __split_folio_to_order() are called in the for loop to split the @folio
  3316	 *    to one lower order at a time. The resulting small folios are processed
  3317	 *    like what is done during the traversal in 1, except the one containing
  3318	 *    @page, which is split in next for loop.
  3319	 *
  3320	 * After splitting, the caller's folio reference will be transferred to the
  3321	 * folio containing @page. The other folios may be freed if they are not mapped.
  3322	 *
  3323	 * In terms of locking, after splitting,
  3324	 * 1. uniform split leaves @page (or the folio contains it) locked;
  3325	 * 2. buddy allocator like split leaves @folio locked.
  3326	 *
  3327	 * If @list is null, tail pages will be added to LRU list, otherwise, to @list.
  3328	 */
  3329	static int __folio_split_without_mapping(struct folio *folio, int new_order,
  3330			struct page *page, struct list_head *list, pgoff_t end,
  3331			struct xa_state *xas, struct address_space *mapping,
  3332			bool uniform_split)
  3333	{
  3334		struct lruvec *lruvec;
  3335		struct address_space *swap_cache = NULL;
  3336		struct folio *origin_folio = folio;
  3337		struct folio *next_folio = folio_next(folio);
  3338		struct folio *new_folio;
  3339		struct folio *next;
  3340		int order = folio_order(folio);
  3341		int split_order = order - 1;
> 3342		int nr_dropped = 0;
  3343	
  3344		if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
  3345			if (!uniform_split)
  3346				return -EINVAL;
  3347	
  3348			swap_cache = swap_address_space(folio->swap);
  3349			xa_lock(&swap_cache->i_pages);
  3350		}
  3351	
  3352		if (folio_test_anon(folio))
  3353			mod_mthp_stat(order, MTHP_STAT_NR_ANON, -1);
  3354	
  3355		/* lock lru list/PageCompound, ref frozen by page_ref_freeze */
  3356		lruvec = folio_lruvec_lock(folio);
  3357	
  3358		/*
  3359		 * split to new_order one order at a time. For uniform split,
  3360		 * intermediate orders are skipped
  3361		 */
  3362		for (split_order = order - 1; split_order >= new_order; split_order--) {
  3363			int old_order = folio_order(folio);
  3364			struct folio *release;
  3365			struct folio *end_folio = folio_next(folio);
  3366			int status;
  3367	
  3368			if (folio_test_anon(folio) && split_order == 1)
  3369				continue;
  3370			if (uniform_split && split_order != new_order)
  3371				continue;
  3372	
  3373			if (mapping) {
  3374				/*
  3375				 * uniform split has xas_split_alloc() called before
  3376				 * irq is disabled, since xas_nomem() might not be
  3377				 * able to allocate enough memory.
  3378				 */
  3379				if (uniform_split)
  3380					xas_split(xas, folio, old_order);
  3381				else {
  3382					xas_set_order(xas, folio->index, split_order);
  3383					xas_set_err(xas, -ENOMEM);
  3384					if (xas_nomem(xas, 0))
  3385						xas_split(xas, folio, old_order);
  3386					else
  3387						return -ENOMEM;
  3388				}
  3389			}
  3390	
  3391			split_page_memcg(&folio->page, old_order, split_order);
  3392			split_page_owner(&folio->page, old_order, split_order);
  3393			pgalloc_tag_split(folio, old_order, split_order);
  3394	
  3395			status = __split_folio_to_order(folio, split_order);
  3396	
  3397			if (status < 0)
  3398				return status;
  3399	
  3400			/*
  3401			 * Iterate through after-split folios and perform related
  3402			 * operations. But in buddy allocator like split, the folio
  3403			 * containing the specified page is skipped until its order
  3404			 * is new_order, since the folio will be worked on in next
  3405			 * iteration.
  3406			 */
  3407			for_each_folio_until_end_safe(release, next, folio, end_folio) {
  3408				if (page_in_folio_offset(page, release) >= 0) {
  3409					folio = release;
  3410					if (split_order != new_order)
  3411						continue;
  3412				}
  3413				if (folio_test_anon(release))
  3414					mod_mthp_stat(folio_order(release),
  3415							MTHP_STAT_NR_ANON, 1);
  3416	
  3417				/*
  3418				 * Unfreeze refcount first. Additional reference from
  3419				 * page cache.
  3420				 */
  3421				folio_ref_unfreeze(release,
  3422					1 + ((!folio_test_anon(origin_folio) ||
  3423					     folio_test_swapcache(origin_folio)) ?
  3424						     folio_nr_pages(release) : 0));
  3425	
  3426				if (release != origin_folio)
  3427					lru_add_page_tail(origin_folio, &release->page,
  3428							lruvec, list);
  3429	
  3430				/* Some pages can be beyond EOF: drop them from page cache */
  3431				if (release->index >= end) {
  3432					if (shmem_mapping(origin_folio->mapping))
  3433						nr_dropped++;
  3434					else if (folio_test_clear_dirty(release))
  3435						folio_account_cleaned(release,
  3436							inode_to_wb(origin_folio->mapping->host));
  3437					__filemap_remove_folio(release, NULL);
  3438					folio_put(release);
  3439				} else if (!folio_test_anon(release)) {
  3440					__xa_store(&origin_folio->mapping->i_pages,
  3441							release->index, &release->page, 0);
  3442				} else if (swap_cache) {
  3443					__xa_store(&swap_cache->i_pages,
  3444							swap_cache_index(release->swap),
  3445							&release->page, 0);
  3446				}
  3447			}
  3448		}
  3449	
  3450		unlock_page_lruvec(lruvec);
  3451	
  3452		if (folio_test_anon(origin_folio)) {
  3453			if (folio_test_swapcache(origin_folio))
  3454				xa_unlock(&swap_cache->i_pages);
  3455		} else
  3456			xa_unlock(&mapping->i_pages);
  3457	
  3458		/* Caller disabled irqs, so they are still disabled here */
  3459		local_irq_enable();
  3460	
  3461		remap_page(origin_folio, 1 << order,
  3462				folio_test_anon(origin_folio) ?
  3463					RMP_USE_SHARED_ZEROPAGE : 0);
  3464	
  3465		/*
  3466		 * At this point, folio should contain the specified page, so that it
  3467		 * will be left to the caller to unlock it.
  3468		 */
  3469		for_each_folio_until_end_safe(new_folio, next, origin_folio, next_folio) {
  3470			if (uniform_split && new_folio == folio)
  3471				continue;
  3472			if (!uniform_split && new_folio == origin_folio)
  3473				continue;
  3474	
  3475			folio_unlock(new_folio);
  3476			/*
  3477			 * Subpages may be freed if there wasn't any mapping
  3478			 * like if add_to_swap() is running on a lru page that
  3479			 * had its mapping zapped. And freeing these pages
  3480			 * requires taking the lru_lock so we do the put_page
  3481			 * of the tail pages after the split is complete.
  3482			 */
  3483			free_page_and_swap_cache(&new_folio->page);
  3484		}
  3485		return 0;
  3486	}
  3487	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


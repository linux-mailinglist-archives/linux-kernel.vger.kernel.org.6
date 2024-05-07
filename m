Return-Path: <linux-kernel+bounces-171138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758CD8BE021
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 024021F234E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0735E152E0F;
	Tue,  7 May 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dG+Fu1WM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A0E152E0E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078847; cv=none; b=VhDR+DxSrKsfQjpVM34ud67UD1r5VUceF3Pm0mMTUjV9ghjSjo6+kzOiHMgKQpwKICYHJTbWLuJ4JUQs6yZr+x36mV0LNN3HJELL+Ul7tEj/YzPGkzDmDQTgaGI25CYZ27N/O/fJSN1E106XF6wVvkJ+zd8tpGSwiVDPhtZCWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078847; c=relaxed/simple;
	bh=kiHIBvKNNEpif89Ucvo2CcuI4eCVXIyEwMixKRCDn54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIq3VHW74zAm0teJWen7bUS6iVbS5EchHC+Bw/3awr/tJiKw8m7dnpTcqiJ2aCluumE4N0TwVwoit7FZhfdzqZ2eGO4V6KNhKqmTV9X4CR7WJTJ56ww8+egiId58YQa65DufIJdW19vgDLDBhoiTWkj/wLJUr6TXkJsxo7Cu5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dG+Fu1WM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715078845; x=1746614845;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kiHIBvKNNEpif89Ucvo2CcuI4eCVXIyEwMixKRCDn54=;
  b=dG+Fu1WMIJa/Ym2aB1jeVkcGauEJl7QYIPw+Uatm4rT/F6SAxLrDzB4y
   LFTdX2j5GJ/UgIdlfPCyCDtuM9Xw/G2ZkVa6oH5ibLzToytvebIwcblZk
   vrzOTqFTQeb9LoC+01/+vhdqdW1e6+c8LsDJKHVybHlCfoVYKAD5Qg5Fb
   7NPWNNYZQgqc2CA4IsTGgKmK+j6mM+GrHfoTFbv1Kxwh1SsUZBQ5sdWXb
   CqT2uv+tmTniOgDqxIbi2UhAGxHCsoSPsH18NxDV1p2zNb72GbhIFjxi5
   OEsM244Mx24i1pmRBH36H8qKpjLii+mSY8S0db8W8zVrIv1re7fAsmAF9
   A==;
X-CSE-ConnectionGUID: sWK8e5j0SHOl/JN6KnJ/RA==
X-CSE-MsgGUID: 8s8WYsGPQdSUsNZHGHHfog==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10796746"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="10796746"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:47:25 -0700
X-CSE-ConnectionGUID: 5ljaIkcTQCCN6LE/W+lL4Q==
X-CSE-MsgGUID: Oma28utSTCKv3TBln5qvCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="28466982"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2024 03:47:21 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s4ILu-0001oq-2J;
	Tue, 07 May 2024 10:47:18 +0000
Date: Tue, 7 May 2024 18:46:23 +0800
From: kernel test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	hughd@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	willy@infradead.org, david@redhat.com, ioworker0@gmail.com,
	wangkefeng.wang@huawei.com, ying.huang@intel.com, 21cnbao@gmail.com,
	ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] mm: shmem: add mTHP support for anonymous shmem
Message-ID: <202405071820.2KY0UnDu-lkp@intel.com>
References: <adc64bf0f150bdc614c6c06fc313adeef7dbbbff.1714978902.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc64bf0f150bdc614c6c06fc313adeef7dbbbff.1714978902.git.baolin.wang@linux.alibaba.com>

Hi Baolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20240506]
[cannot apply to linus/master v6.9-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-move-highest_order-and-next_order-out-of-the-THP-config/20240506-164838
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/adc64bf0f150bdc614c6c06fc313adeef7dbbbff.1714978902.git.baolin.wang%40linux.alibaba.com
patch subject: [PATCH 6/8] mm: shmem: add mTHP support for anonymous shmem
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240507/202405071820.2KY0UnDu-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 0ab4458df0688955620b72cc2c72a32dffad3615)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240507/202405071820.2KY0UnDu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405071820.2KY0UnDu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/shmem.c:28:
   In file included from include/linux/ramfs.h:5:
   In file included from include/linux/fs_parser.h:11:
   In file included from include/linux/fs_context.h:14:
   In file included from include/linux/security.h:33:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> mm/shmem.c:1780:10: warning: variable 'folio' is used uninitialized whenever 'while' loop exits because its condition is false [-Wsometimes-uninitialized]
    1780 |                 while (suitable_orders) {
         |                        ^~~~~~~~~~~~~~~
   mm/shmem.c:1795:7: note: uninitialized use occurs here
    1795 |         if (!folio)
         |              ^~~~~
   mm/shmem.c:1780:10: note: remove the condition if it is always true
    1780 |                 while (suitable_orders) {
         |                        ^~~~~~~~~~~~~~~
         |                        1
   mm/shmem.c:1750:21: note: initialize the variable 'folio' to silence this warning
    1750 |         struct folio *folio;
         |                            ^
         |                             = NULL
   mm/shmem.c:1564:20: warning: unused function 'shmem_show_mpol' [-Wunused-function]
    1564 | static inline void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)
         |                    ^~~~~~~~~~~~~~~
   3 warnings generated.


vim +1780 mm/shmem.c

  1741	
  1742	static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
  1743			gfp_t gfp, struct inode *inode, pgoff_t index,
  1744			struct mm_struct *fault_mm, bool huge, unsigned long orders)
  1745	{
  1746		struct address_space *mapping = inode->i_mapping;
  1747		struct shmem_inode_info *info = SHMEM_I(inode);
  1748		struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
  1749		unsigned long suitable_orders;
  1750		struct folio *folio;
  1751		long pages;
  1752		int error, order;
  1753	
  1754		if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
  1755			huge = false;
  1756	
  1757		if (huge || orders > 0) {
  1758			if (vma && vma_is_anon_shmem(vma) && orders) {
  1759				suitable_orders = anon_shmem_suitable_orders(inode, vmf,
  1760								mapping, index, orders);
  1761			} else {
  1762				pages = HPAGE_PMD_NR;
  1763				suitable_orders = BIT(HPAGE_PMD_ORDER);
  1764				index = round_down(index, HPAGE_PMD_NR);
  1765	
  1766				/*
  1767				 * Check for conflict before waiting on a huge allocation.
  1768				 * Conflict might be that a huge page has just been allocated
  1769				 * and added to page cache by a racing thread, or that there
  1770				 * is already at least one small page in the huge extent.
  1771				 * Be careful to retry when appropriate, but not forever!
  1772				 * Elsewhere -EEXIST would be the right code, but not here.
  1773				 */
  1774				if (xa_find(&mapping->i_pages, &index,
  1775					index + HPAGE_PMD_NR - 1, XA_PRESENT))
  1776					return ERR_PTR(-E2BIG);
  1777			}
  1778	
  1779			order = highest_order(suitable_orders);
> 1780			while (suitable_orders) {
  1781				pages = 1 << order;
  1782				index = round_down(index, pages);
  1783				folio = shmem_alloc_hugefolio(gfp, info, index, order);
  1784				if (folio)
  1785					goto allocated;
  1786	
  1787				if (pages == HPAGE_PMD_NR)
  1788					count_vm_event(THP_FILE_FALLBACK);
  1789				order = next_order(&suitable_orders, order);
  1790			}
  1791		} else {
  1792			pages = 1;
  1793			folio = shmem_alloc_folio(gfp, info, index);
  1794		}
  1795		if (!folio)
  1796			return ERR_PTR(-ENOMEM);
  1797	
  1798	allocated:
  1799		__folio_set_locked(folio);
  1800		__folio_set_swapbacked(folio);
  1801	
  1802		gfp &= GFP_RECLAIM_MASK;
  1803		error = mem_cgroup_charge(folio, fault_mm, gfp);
  1804		if (error) {
  1805			if (xa_find(&mapping->i_pages, &index,
  1806					index + pages - 1, XA_PRESENT)) {
  1807				error = -EEXIST;
  1808			} else if (pages == HPAGE_PMD_NR) {
  1809				count_vm_event(THP_FILE_FALLBACK);
  1810				count_vm_event(THP_FILE_FALLBACK_CHARGE);
  1811			}
  1812			goto unlock;
  1813		}
  1814	
  1815		error = shmem_add_to_page_cache(folio, mapping, index, NULL, gfp);
  1816		if (error)
  1817			goto unlock;
  1818	
  1819		error = shmem_inode_acct_blocks(inode, pages);
  1820		if (error) {
  1821			struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
  1822			long freed;
  1823			/*
  1824			 * Try to reclaim some space by splitting a few
  1825			 * large folios beyond i_size on the filesystem.
  1826			 */
  1827			shmem_unused_huge_shrink(sbinfo, NULL, 2);
  1828			/*
  1829			 * And do a shmem_recalc_inode() to account for freed pages:
  1830			 * except our folio is there in cache, so not quite balanced.
  1831			 */
  1832			spin_lock(&info->lock);
  1833			freed = pages + info->alloced - info->swapped -
  1834				READ_ONCE(mapping->nrpages);
  1835			if (freed > 0)
  1836				info->alloced -= freed;
  1837			spin_unlock(&info->lock);
  1838			if (freed > 0)
  1839				shmem_inode_unacct_blocks(inode, freed);
  1840			error = shmem_inode_acct_blocks(inode, pages);
  1841			if (error) {
  1842				filemap_remove_folio(folio);
  1843				goto unlock;
  1844			}
  1845		}
  1846	
  1847		shmem_recalc_inode(inode, pages, 0);
  1848		folio_add_lru(folio);
  1849		return folio;
  1850	
  1851	unlock:
  1852		folio_unlock(folio);
  1853		folio_put(folio);
  1854		return ERR_PTR(error);
  1855	}
  1856	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


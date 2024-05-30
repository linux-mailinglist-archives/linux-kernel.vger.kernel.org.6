Return-Path: <linux-kernel+bounces-194986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A18D457E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0DFB228B7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 06:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF9C3DABE9;
	Thu, 30 May 2024 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMbsC2+o"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E73210197
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051037; cv=none; b=ZALeSxHSREeHPdas1nvCdRef681dNa0B/zJ11eEYxcntztoSy91gZEL9VvSz0wyElvos24HcOWC0DAd0Ak9eHAIpS2n9iI02hAhScwtVV5Ycy6AlvcJcgxG4cmyCj6noLn784AjjpF8sv1EnGlYYJetc9zX2F4bngGDBfL5F9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051037; c=relaxed/simple;
	bh=xYfnI1YzjUptr5lHZs5yUaLN1qMaYn1bInEg9WPBe/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCduZFVs/v2uBDyVkU18HDeX86p0GtqK4yOa3Bd0wOza1MRDfdj++xkVEvFpcnj//8fAiSitI2genGE3dYImMZfa1fX8o4siMeWOxMF4P1B5PMChA8uba0QozrY3WCxC0AW2AlTUMvMcRQA0W09Y3/w6DBk2zQXMpU8Vy7TSlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMbsC2+o; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717051036; x=1748587036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xYfnI1YzjUptr5lHZs5yUaLN1qMaYn1bInEg9WPBe/k=;
  b=jMbsC2+oX/+Gqn4J/veVLPHMJp5QNu0GIn93XZVMmnW0DUhsb9Fcscy3
   1Rz1r+Gi1qMxgLfESdodd2Bfkz5EcbYbaSJO69DBdw+ey4abOLk7IkvUJ
   QBPFsfcvsrhHnWmMiDN8ozeGsn6B2hzN1itMg6y2Yh0PXVGriUTmYkbYO
   npmShRuMFN75A+f2n4UIcvNGqKSkhDTUgzCeZM8rx4RPQqJ+YNPJv2W0v
   egMRHN1+lu1u865fZjNLHMyjKRK8iVt64WtIW42vuSgPwQixXkHp9DXAL
   2oVdi0zIAH4OjWPNzdU66AAcq+Oy1nTJHe1stU2jEDabO7Si2XK4D/gXu
   w==;
X-CSE-ConnectionGUID: +ynnq34/RLqsQ5ZLPRPBfg==
X-CSE-MsgGUID: cndxItsJQyuCiU8+P7V1fg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13693262"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13693262"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 23:37:15 -0700
X-CSE-ConnectionGUID: rlqGgxDjQfSLc44CwICBnw==
X-CSE-MsgGUID: vO77sm1ESBeeSAGc6jOhHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="36263693"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 29 May 2024 23:37:10 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCZPP-000Eta-2k;
	Thu, 30 May 2024 06:37:07 +0000
Date: Thu, 30 May 2024 14:36:59 +0800
From: kernel test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org,
	hughd@google.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	willy@infradead.org, david@redhat.com, wangkefeng.wang@huawei.com,
	ying.huang@intel.com, 21cnbao@gmail.com, ryan.roberts@arm.com,
	shy828301@gmail.com, ziy@nvidia.com, ioworker0@gmail.com,
	da.gomez@samsung.com, p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] mm: shmem: add mTHP support for anonymous shmem
Message-ID: <202405301430.0NRLTOWU-lkp@intel.com>
References: <ec35a23026dd016705d211e85163cabe07681516.1717033868.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec35a23026dd016705d211e85163cabe07681516.1717033868.git.baolin.wang@linux.alibaba.com>

Hi Baolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on next-20240529]
[cannot apply to linus/master v6.10-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Baolin-Wang/mm-memory-extend-finish_fault-to-support-large-folio/20240530-100805
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/ec35a23026dd016705d211e85163cabe07681516.1717033868.git.baolin.wang%40linux.alibaba.com
patch subject: [PATCH v3 4/6] mm: shmem: add mTHP support for anonymous shmem
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240530/202405301430.0NRLTOWU-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project bafda89a0944d947fc4b3b5663185e07a397ac30)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240530/202405301430.0NRLTOWU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405301430.0NRLTOWU-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from mm/shmem.c:28:
   In file included from include/linux/ramfs.h:5:
   In file included from include/linux/fs_parser.h:11:
   In file included from include/linux/fs_context.h:14:
   In file included from include/linux/security.h:33:
   In file included from include/linux/mm.h:2245:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> mm/shmem.c:1748:14: warning: variable 'suitable_orders' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
    1748 |                 } else if (orders & BIT(HPAGE_PMD_ORDER)) {
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:1766:25: note: uninitialized use occurs here
    1766 |                 order = highest_order(suitable_orders);
         |                                       ^~~~~~~~~~~~~~~
   mm/shmem.c:1748:10: note: remove the 'if' if its condition is always true
    1748 |                 } else if (orders & BIT(HPAGE_PMD_ORDER)) {
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:1736:31: note: initialize the variable 'suitable_orders' to silence this warning
    1736 |         unsigned long suitable_orders;
         |                                      ^
         |                                       = 0
   2 warnings generated.


vim +1748 mm/shmem.c

  1728	
  1729	static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
  1730			gfp_t gfp, struct inode *inode, pgoff_t index,
  1731			struct mm_struct *fault_mm, unsigned long orders)
  1732	{
  1733		struct address_space *mapping = inode->i_mapping;
  1734		struct shmem_inode_info *info = SHMEM_I(inode);
  1735		struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
  1736		unsigned long suitable_orders;
  1737		struct folio *folio = NULL;
  1738		long pages;
  1739		int error, order;
  1740	
  1741		if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
  1742			orders = 0;
  1743	
  1744		if (orders > 0) {
  1745			if (vma && vma_is_anon_shmem(vma)) {
  1746				suitable_orders = anon_shmem_suitable_orders(inode, vmf,
  1747								mapping, index, orders);
> 1748			} else if (orders & BIT(HPAGE_PMD_ORDER)) {
  1749				pages = HPAGE_PMD_NR;
  1750				suitable_orders = BIT(HPAGE_PMD_ORDER);
  1751				index = round_down(index, HPAGE_PMD_NR);
  1752	
  1753				/*
  1754				 * Check for conflict before waiting on a huge allocation.
  1755				 * Conflict might be that a huge page has just been allocated
  1756				 * and added to page cache by a racing thread, or that there
  1757				 * is already at least one small page in the huge extent.
  1758				 * Be careful to retry when appropriate, but not forever!
  1759				 * Elsewhere -EEXIST would be the right code, but not here.
  1760				 */
  1761				if (xa_find(&mapping->i_pages, &index,
  1762					    index + HPAGE_PMD_NR - 1, XA_PRESENT))
  1763					return ERR_PTR(-E2BIG);
  1764			}
  1765	
  1766			order = highest_order(suitable_orders);
  1767			while (suitable_orders) {
  1768				pages = 1UL << order;
  1769				index = round_down(index, pages);
  1770				folio = shmem_alloc_folio(gfp, order, info, index);
  1771				if (folio)
  1772					goto allocated;
  1773	
  1774				if (pages == HPAGE_PMD_NR)
  1775					count_vm_event(THP_FILE_FALLBACK);
  1776				order = next_order(&suitable_orders, order);
  1777			}
  1778		} else {
  1779			pages = 1;
  1780			folio = shmem_alloc_folio(gfp, 0, info, index);
  1781		}
  1782		if (!folio)
  1783			return ERR_PTR(-ENOMEM);
  1784	
  1785	allocated:
  1786		__folio_set_locked(folio);
  1787		__folio_set_swapbacked(folio);
  1788	
  1789		gfp &= GFP_RECLAIM_MASK;
  1790		error = mem_cgroup_charge(folio, fault_mm, gfp);
  1791		if (error) {
  1792			if (xa_find(&mapping->i_pages, &index,
  1793					index + pages - 1, XA_PRESENT)) {
  1794				error = -EEXIST;
  1795			} else if (pages == HPAGE_PMD_NR) {
  1796				count_vm_event(THP_FILE_FALLBACK);
  1797				count_vm_event(THP_FILE_FALLBACK_CHARGE);
  1798			}
  1799			goto unlock;
  1800		}
  1801	
  1802		error = shmem_add_to_page_cache(folio, mapping, index, NULL, gfp);
  1803		if (error)
  1804			goto unlock;
  1805	
  1806		error = shmem_inode_acct_blocks(inode, pages);
  1807		if (error) {
  1808			struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
  1809			long freed;
  1810			/*
  1811			 * Try to reclaim some space by splitting a few
  1812			 * large folios beyond i_size on the filesystem.
  1813			 */
  1814			shmem_unused_huge_shrink(sbinfo, NULL, 2);
  1815			/*
  1816			 * And do a shmem_recalc_inode() to account for freed pages:
  1817			 * except our folio is there in cache, so not quite balanced.
  1818			 */
  1819			spin_lock(&info->lock);
  1820			freed = pages + info->alloced - info->swapped -
  1821				READ_ONCE(mapping->nrpages);
  1822			if (freed > 0)
  1823				info->alloced -= freed;
  1824			spin_unlock(&info->lock);
  1825			if (freed > 0)
  1826				shmem_inode_unacct_blocks(inode, freed);
  1827			error = shmem_inode_acct_blocks(inode, pages);
  1828			if (error) {
  1829				filemap_remove_folio(folio);
  1830				goto unlock;
  1831			}
  1832		}
  1833	
  1834		shmem_recalc_inode(inode, pages, 0);
  1835		folio_add_lru(folio);
  1836		return folio;
  1837	
  1838	unlock:
  1839		folio_unlock(folio);
  1840		folio_put(folio);
  1841		return ERR_PTR(error);
  1842	}
  1843	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


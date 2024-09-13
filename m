Return-Path: <linux-kernel+bounces-328053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E732977E66
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7409DB27F33
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616A11D86EE;
	Fri, 13 Sep 2024 11:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nrzd5YW3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECC21865EC
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 11:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226279; cv=none; b=m/sU7i5A8fgMWEopGZObNpbFe2gL0clD9GxcK8JOZIgGmHCHPX8lxXdgHIfbbct30l8C+JlklsQM7LJRwvQMQ9tl57X5t5ed9AHCMq6XEJ39B2m+VeazQ7xmoBsbyBqkN3ejWeb1DV1Ke26wPltPaD+gOfSwpTWFWhbg0TKqjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226279; c=relaxed/simple;
	bh=HjvkmiSlruxquK4va3BDQAYSX/d1hCkrdju7KVhYppk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQKYlcKAqYff2Hlr1hQ6yNV6yWGHtTug6pYpyrBgkLNy4hZ1DpOVH8ob0UOvL2u6e+Uh19jHD4epiTa/ASEGx5PuDsSVsVArKibtHsv4q8O+OQEabyW3ojx1x9b6A4dLKYJy2IoERDeDyYZwrkB1Xis6Fb/OxiDSlxp4aY0JBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nrzd5YW3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726226277; x=1757762277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HjvkmiSlruxquK4va3BDQAYSX/d1hCkrdju7KVhYppk=;
  b=nrzd5YW343BcGEmM0eVKaLOF6eAy2nk74eXo9XJnA5Nu46GW3Hmk/Wkq
   J0d6U4lZkBZrBZMQYVcDYdM+krsiRsj+VXtKq9SfGJdUnOCClmJX9QZGx
   FkLoC0qTp+NKMXBMz1ud1KaNBOQ/IWFnSPYkIO18isemSiKylIFipVya0
   3k7iJO0a0Q+DpbbND5TDeHful183O6/PKicdnK43lZLA/Z4ybi0N8By+8
   2OLi4NV73L3jpus4L+o5exxhhrzx6C0x2iE/DQV1QQ+3fsOgvLsa5EIQ3
   RautGi88Cw1yxn6cj96Kj5+F9ucPU+35zc/klBpv4OD4sCHIKBkWaitio
   Q==;
X-CSE-ConnectionGUID: NxB95/xBR0+CMHvQGBISVQ==
X-CSE-MsgGUID: iCFwoh3LRim3t0TPTRkLhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24663040"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="24663040"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 04:17:56 -0700
X-CSE-ConnectionGUID: Xq58/mCkTKuR4ZAMc7qcug==
X-CSE-MsgGUID: fmuvvWhRSfGTBvFUxsDz8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72127987"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 13 Sep 2024 04:17:53 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sp4JD-0006Ru-0J;
	Fri, 13 Sep 2024 11:17:51 +0000
Date: Fri, 13 Sep 2024 19:16:52 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 4/9] arch/sparc: Teach
 arch_get_unmapped_area{_topdown} to handle hugetlb mappings
Message-ID: <202409131805.4Dlb536A-lkp@intel.com>
References: <20240910080030.1272373-5-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910080030.1272373-5-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on next-20240913]
[cannot apply to s390/features powerpc/next powerpc/fixes deller-parisc/for-next arnd-asm-generic/master linus/master v6.11-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/mm-mmap-Teach-generic_get_unmapped_area-_topdown-to-handle-hugetlb-mappings/20240910-160312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240910080030.1272373-5-osalvador%40suse.de
patch subject: [PATCH v3 4/9] arch/sparc: Teach arch_get_unmapped_area{_topdown} to handle hugetlb mappings
config: sparc-randconfig-002-20240913 (https://download.01.org/0day-ci/archive/20240913/202409131805.4Dlb536A-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240913/202409131805.4Dlb536A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409131805.4Dlb536A-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/sparc/kernel/sys_sparc_32.c: In function 'arch_get_unmapped_area':
>> arch/sparc/kernel/sys_sparc_32.c:55:22: error: 'file_huge_pages' undeclared (first use in this function); did you mean 'file_hugepage'?
      55 |                 if (!file_huge_pages && (flags & MAP_SHARED) &&
         |                      ^~~~~~~~~~~~~~~
         |                      file_hugepage
   arch/sparc/kernel/sys_sparc_32.c:55:22: note: each undeclared identifier is reported only once for each function it appears in


vim +55 arch/sparc/kernel/sys_sparc_32.c

    42	
    43	unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
    44	{
    45		struct vm_unmapped_area_info info = {};
    46		bool file_hugepage = false;
    47	
    48		if (filp && is_file_hugepages(filp))
    49			file_hugepage = true;
    50	
    51		if (flags & MAP_FIXED) {
    52			/* We do not accept a shared mapping if it would violate
    53			 * cache aliasing constraints.
    54			 */
  > 55			if (!file_huge_pages && (flags & MAP_SHARED) &&
    56			    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
    57				return -EINVAL;
    58			return addr;
    59		}
    60	
    61		/* See asm-sparc/uaccess.h */
    62		if (len > TASK_SIZE - PAGE_SIZE)
    63			return -ENOMEM;
    64		if (!addr)
    65			addr = TASK_UNMAPPED_BASE;
    66	
    67		info.length = len;
    68		info.low_limit = addr;
    69		info.high_limit = TASK_SIZE;
    70		if (!file_hugepage) {
    71			info.align_mask = (flags & MAP_SHARED) ?
    72				(PAGE_MASK & (SHMLBA - 1)) : 0;
    73			info.align_offset = pgoff << PAGE_SHIFT;
    74		} else {
    75			info.align_mask = huge_page_mask_align(filp);
    76		}
    77		return vm_unmapped_area(&info);
    78	}
    79	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


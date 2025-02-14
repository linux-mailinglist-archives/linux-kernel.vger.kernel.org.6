Return-Path: <linux-kernel+bounces-515425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15586A364A0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FB87A4F48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCB8267AE8;
	Fri, 14 Feb 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDqGR3z1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC1264FA7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554433; cv=none; b=cE5YrhjLSiKHEkde80OyxllCpjgLzQ8/VisD1bDA/ktDLjJC6EUqfljCCzbqmG2W3/+leYoQMrgcfVMLUPHFBxzDkEWxcCMNgq0rfmr5nAO/gU569Y6AhAp2VEd46hm7HVMXc4+VXkilBZ2IYPqtp8MvYFu9JHXJZHxS/2Hk+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554433; c=relaxed/simple;
	bh=XuBERATq4koO/myUPyeFbtnAkwVl9fmpc81tcDyXjtk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QnTdfme/iNwoa9yhz8o1K/7dpMfwWq67qZwjABRzyxruIeqrD04ak6R3fZw7RaDXwiQKGsPi3cMdK5U+7TV2P3SpgdlJVSXPwZMoZLbm2waeQPJkSNPETs+/cPqi/2YSx6002U1Y9enbt30BpPxNr8CCbzySuR5ByxQBbSFKr3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDqGR3z1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739554431; x=1771090431;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XuBERATq4koO/myUPyeFbtnAkwVl9fmpc81tcDyXjtk=;
  b=dDqGR3z19xCAM/Lj7l+9Y4dgTGD9W7/Z8wFXxOXlNSo4Rc7uXU2jyRYy
   bopJhWh2ARFScMaegaG9RqydINTu/QPaeBzApEJteue7HyqWQ6E6yyDGY
   RyJ3q+Oxm3gHFSqz/YvkNdSWRj2E2nXNK33/twD3EZuUWazEtJVCqtyFv
   5/5I9xlX8HM4C32URqRlgQJHfuxILAQq86GqorhNuaP0xciWmCNNF13uJ
   ckyZTV7WiTCmHqFgTy/QOHX7Fjdls5ad6md9Op7o0Vht3ZhPVCZGSQ2Va
   e2bz6HZaeGgiuBzURS4HDIjRIEthGjb1py3POnk4W5JocV3a88PNwNLwX
   A==;
X-CSE-ConnectionGUID: 3Ej3VHMFTsWuWB1FWxrutg==
X-CSE-MsgGUID: mFmz5yJgTf+/JYg/PSC1gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="50522109"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="50522109"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 09:33:51 -0800
X-CSE-ConnectionGUID: l+8gxMzdTF+HZ5/Dxw0+6Q==
X-CSE-MsgGUID: WEXLWInbQv2dfPnYNUVkOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="144443165"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Feb 2025 09:33:49 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tizZS-0019wZ-23;
	Fri, 14 Feb 2025 17:33:46 +0000
Date: Sat, 15 Feb 2025 01:33:39 +0800
From: kernel test robot <lkp@intel.com>
To: Gang Li <gang.li@linux.dev>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: mm/hugetlb.c:3424 gather_bootmem_prealloc_node() warn: unsigned '_x'
 is never less than zero.
Message-ID: <202502150114.XM31HL0I-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   128c8f96eb8638c060cd3532dc394d046ce64fe1
commit: b78b27d02930f6f0262353080d0f784ce7aa377e hugetlb: parallelize 1G hugetlb initialization
date:   12 months ago
config: riscv-randconfig-r073-20250213 (https://download.01.org/0day-ci/archive/20250215/202502150114.XM31HL0I-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502150114.XM31HL0I-lkp@intel.com/

New smatch warnings:
mm/hugetlb.c:3424 gather_bootmem_prealloc_node() warn: unsigned '_x' is never less than zero.

Old smatch warnings:
include/asm-generic/io.h:1005 virt_to_phys() warn: unsigned '_x' is never less than zero.
arch/riscv/include/asm/atomic.h:204 arch_atomic_fetch_add_unless() warn: inconsistent indenting

vim +/_x +3424 mm/hugetlb.c

79359d6d24df2f Mike Kravetz       2023-10-18  3412  
48b8d744ea841b Mike Kravetz       2021-06-30  3413  /*
48b8d744ea841b Mike Kravetz       2021-06-30  3414   * Put bootmem huge pages into the standard lists after mem_map is up.
5e0a760b44417f Kirill A. Shutemov 2023-12-28  3415   * Note: This only applies to gigantic (order > MAX_PAGE_ORDER) pages.
48b8d744ea841b Mike Kravetz       2021-06-30  3416   */
b78b27d02930f6 Gang Li            2024-02-22  3417  static void __init gather_bootmem_prealloc_node(unsigned long nid)
aa888a74977a8f Andi Kleen         2008-07-23  3418  {
d67e32f26713c3 Mike Kravetz       2023-10-18  3419  	LIST_HEAD(folio_list);
aa888a74977a8f Andi Kleen         2008-07-23  3420  	struct huge_bootmem_page *m;
d67e32f26713c3 Mike Kravetz       2023-10-18  3421  	struct hstate *h = NULL, *prev_h = NULL;
aa888a74977a8f Andi Kleen         2008-07-23  3422  
b78b27d02930f6 Gang Li            2024-02-22  3423  	list_for_each_entry(m, &huge_boot_pages[nid], list) {
40d18ebffb3974 Mike Kravetz       2018-08-17 @3424  		struct page *page = virt_to_page(m);
fde1c4ecf91640 Usama Arif         2023-09-13  3425  		struct folio *folio = (void *)page;
d67e32f26713c3 Mike Kravetz       2023-10-18  3426  
d67e32f26713c3 Mike Kravetz       2023-10-18  3427  		h = m->hstate;
d67e32f26713c3 Mike Kravetz       2023-10-18  3428  		/*
d67e32f26713c3 Mike Kravetz       2023-10-18  3429  		 * It is possible to have multiple huge page sizes (hstates)
d67e32f26713c3 Mike Kravetz       2023-10-18  3430  		 * in this list.  If so, process each size separately.
d67e32f26713c3 Mike Kravetz       2023-10-18  3431  		 */
d67e32f26713c3 Mike Kravetz       2023-10-18  3432  		if (h != prev_h && prev_h != NULL)
79359d6d24df2f Mike Kravetz       2023-10-18  3433  			prep_and_add_bootmem_folios(prev_h, &folio_list);
d67e32f26713c3 Mike Kravetz       2023-10-18  3434  		prev_h = h;
ee8f248d266ec6 Becky Bruce        2011-07-25  3435  
48b8d744ea841b Mike Kravetz       2021-06-30  3436  		VM_BUG_ON(!hstate_is_gigantic(h));
d1c6095572d0cf Sidhartha Kumar    2022-11-29  3437  		WARN_ON(folio_ref_count(folio) != 1);
fde1c4ecf91640 Usama Arif         2023-09-13  3438  
fde1c4ecf91640 Usama Arif         2023-09-13  3439  		hugetlb_folio_init_vmemmap(folio, h,
fde1c4ecf91640 Usama Arif         2023-09-13  3440  					   HUGETLB_VMEMMAP_RESERVE_PAGES);
79359d6d24df2f Mike Kravetz       2023-10-18  3441  		init_new_hugetlb_folio(h, folio);
d67e32f26713c3 Mike Kravetz       2023-10-18  3442  		list_add(&folio->lru, &folio_list);
af0fb9df784174 Michal Hocko       2018-01-31  3443  
b0320c7b7d1ac1 Rafael Aquini      2011-06-15  3444  		/*
48b8d744ea841b Mike Kravetz       2021-06-30  3445  		 * We need to restore the 'stolen' pages to totalram_pages
48b8d744ea841b Mike Kravetz       2021-06-30  3446  		 * in order to fix confusing memory reports from free(1) and
48b8d744ea841b Mike Kravetz       2021-06-30  3447  		 * other side-effects, like CommitLimit going negative.
b0320c7b7d1ac1 Rafael Aquini      2011-06-15  3448  		 */
c78a7f3639932c Miaohe Lin         2021-02-24  3449  		adjust_managed_page_count(page, pages_per_huge_page(h));
520495fe96d74e Cannon Matthews    2018-07-03  3450  		cond_resched();
aa888a74977a8f Andi Kleen         2008-07-23  3451  	}
d67e32f26713c3 Mike Kravetz       2023-10-18  3452  
79359d6d24df2f Mike Kravetz       2023-10-18  3453  	prep_and_add_bootmem_folios(h, &folio_list);
aa888a74977a8f Andi Kleen         2008-07-23  3454  }
fde1c4ecf91640 Usama Arif         2023-09-13  3455  

:::::: The code at line 3424 was first introduced by commit
:::::: 40d18ebffb3974272a920c41f2d74431152cae98 mm/hugetlb: remove gigantic page support for HIGHMEM

:::::: TO: Mike Kravetz <mike.kravetz@oracle.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


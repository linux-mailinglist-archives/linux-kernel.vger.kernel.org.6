Return-Path: <linux-kernel+bounces-446295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6D19F223E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 06:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460801885875
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 05:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB9717BBF;
	Sun, 15 Dec 2024 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7zbmroI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D4ABA4A
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734239528; cv=none; b=lX0/eaXrflHU6hmqYPwYd5VmuIWhjeeVmMH8nZnFQvh5ZFjGfoY4SJVqjDZvnesTc1CVayhNAHTpgzZaotjRKg4dHZWL3KCnz1SbDuJNXhrINP9rfmNcI3U+rz3ud9xTj77WjQ8FdhjvwOv9733tLLVXCBE8UI0Y0+NuNN9FENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734239528; c=relaxed/simple;
	bh=M874uceTCbBNZlkK86xJO6OodHH321Wxg3oIcq122rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj7ohqaU/TTkiBRnAt7cukB+gnVfgSJBXPEGY+ITRs8Vk6E0PnEEPDP1krl4A9mBGsA4lNweLDdkY4K0ZyFPUjDT8qgRmY3BV15RaQkk40VbITk0KbI6vVJXygBkxPBr2jTKsRCRG8PArR508Dug5xl1Rtfqsuh7NhQegCoX7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7zbmroI; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734239526; x=1765775526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M874uceTCbBNZlkK86xJO6OodHH321Wxg3oIcq122rQ=;
  b=T7zbmroIKn6Z68zqpsEvksAVQaPVns20r0qo2dqO9ZwPa3NC+HeNo1pP
   V+e8cTjLanIfeZAXNV9bjyz7viWFAxsrdpvfQV8kQXfeNUz84CCs1KsW8
   VcU1+fl/6OuN8qLlNOqtfBp8bmB4d7GUlGaHRyJrjy5QY6XLlvF+1t/ez
   29WOadcoND6qz5fl4/IIudgDUubNWrg74rWTvC0s/0fjO6Ih3yErIaiZs
   aU2UTrwVZ20FB04YP3/EVSxUiNH9l8zUKMaFm79rZ+WMLmAL45W3hU936
   iPy3cMjoS47/5qm13vYrxb5U4Uiq1JPy4w9A2gUsPD8a4mMSXHcZjsQif
   g==;
X-CSE-ConnectionGUID: nVZntIraSSKPWkObad2FbQ==
X-CSE-MsgGUID: 1uyThwhjQMq9MmThiW+/Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="45339703"
X-IronPort-AV: E=Sophos;i="6.12,235,1728975600"; 
   d="scan'208";a="45339703"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 21:12:06 -0800
X-CSE-ConnectionGUID: AUXLowasSOCO9nGm94JCBw==
X-CSE-MsgGUID: il4/yOdrTzeAdx9rQ30W4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97693867"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 14 Dec 2024 21:12:03 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMgvA-000DRq-3A;
	Sun, 15 Dec 2024 05:12:00 +0000
Date: Sun, 15 Dec 2024 13:11:33 +0800
From: kernel test robot <lkp@intel.com>
To: Liu Shixin <liushixin2@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Kenneth W Chen <kenneth.w.chen@intel.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Nanyong Sun <sunnanyong@huawei.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH] mm: hugetlb: independent PMD page table shared count
Message-ID: <202412151253.G1eTYt78-lkp@intel.com>
References: <20241214104401.1052550-1-liushixin2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214104401.1052550-1-liushixin2@huawei.com>

Hi Liu,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Shixin/mm-hugetlb-independent-PMD-page-table-shared-count/20241214-184912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241214104401.1052550-1-liushixin2%40huawei.com
patch subject: [PATCH] mm: hugetlb: independent PMD page table shared count
config: i386-buildonly-randconfig-006-20241215 (https://download.01.org/0day-ci/archive/20241215/202412151253.G1eTYt78-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412151253.G1eTYt78-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412151253.G1eTYt78-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
>> include/linux/mm.h:3192:21: error: called object type 'void *' is not a function or function pointer
    3192 |         ptdesc_pmd_pts_init(ptdesc);
         |         ~~~~~~~~~~~~~~~~~~~^
   1 error generated.
   make[3]: *** [scripts/Makefile.build:102: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=1966107866
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1263: prepare0] Error 2 shuffle=1966107866
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=1966107866
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=1966107866
   make: Target 'prepare' not remade because of errors.


vim +3192 include/linux/mm.h

  3184	
  3185	static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
  3186	{
  3187		struct folio *folio = ptdesc_folio(ptdesc);
  3188	
  3189		if (!pmd_ptlock_init(ptdesc))
  3190			return false;
  3191		__folio_set_pgtable(folio);
> 3192		ptdesc_pmd_pts_init(ptdesc);
  3193		lruvec_stat_add_folio(folio, NR_PAGETABLE);
  3194		return true;
  3195	}
  3196	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


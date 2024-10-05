Return-Path: <linux-kernel+bounces-351778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 528929915E4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 12:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7616B1C21A22
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08418145A09;
	Sat,  5 Oct 2024 10:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NJ7vn3a+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35749231CA7
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 10:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728123131; cv=none; b=NPqaY4XBXP01S5al2SbhXEl+dECnu69P6cJIiAWVN56XKwPp7+Ldz9PYYWVCNIEou4rFFcRryVar9Xx1ed9qB42DPo5DA9Mllx3N6QwOJKx+QdowZSUnfvvlq/p3jGDRvjBNMmnaymrwQoFJs2gCjU6GeQ9A9NSHO6WsUecSjR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728123131; c=relaxed/simple;
	bh=zu67dF9F6Bjtd+21WJroC+KRLUyJEN+4cOuC2wxCcLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kQiBFZX+IOhPAGE6vgLkG2uh7/5hfpvpyPRGYymUAsBNPZ2S6H8X3U+CKOSztGPGJ0GctONt7revV/6Lb4oLldHMTOeXiiQGH1f7IVfS57mbb9+WzKxmCLtqn2gD98htLmwTDUbzwJio+CRYcZefHYBM8W0mOIZFO1n/veQ9rsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NJ7vn3a+; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728123128; x=1759659128;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zu67dF9F6Bjtd+21WJroC+KRLUyJEN+4cOuC2wxCcLM=;
  b=NJ7vn3a+e2Ub/wHdbzzBcKLq8O5+zX2ONcoUqzI7vuZ2ljiDDt3aj+WS
   OG3pWHcgf3Xkv0+UUleLFZ+KsFBbhqnrWrPhcTwtNFCTfZRMnCwn6JzFU
   P9QfExcpWnAIQ42X5yccOVt1inEI3GvWwJyGWc3n0GI/g2Lzj8vTecQ7A
   /7h43bOI5uos7p7xdxEh3M7kzi6OvfAOPAlq9/R7/jV+bS6s+FwFPspNy
   G10x5B5hAZdrTGuoNHqLm3UzasKL6KCIcJAyn6gXXh7/BPb94euIsnCib
   e4K+WH+CeSZTPdpZTP+gskipirwrrpCE5GJZoRWaJv743IaBXvPS5kIpQ
   Q==;
X-CSE-ConnectionGUID: Sn/XpJLuR++F3Ju1CwepvQ==
X-CSE-MsgGUID: ygrLCofURtuvk3haiFQeYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="26839742"
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="26839742"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2024 03:12:08 -0700
X-CSE-ConnectionGUID: FL33m3gPRAqVXPPn7fSDkg==
X-CSE-MsgGUID: vAoy2gjtRKOkYYQy2NGVVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,180,1725346800"; 
   d="scan'208";a="105801604"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 05 Oct 2024 03:12:05 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sx1lb-0002qQ-17;
	Sat, 05 Oct 2024 10:12:03 +0000
Date: Sat, 5 Oct 2024 18:11:14 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/x86/mm/pat/memtype.c:128:39: error: use of undeclared
 identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
Message-ID: <202410051828.Pb7a79Gu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27cc6fdf720183dce1dbd293483ec5a9cb6b595e
commit: 7a87225ae2c6c317c7b80cf599e5cf0eee699196 x86: remove PG_uncached
date:   4 weeks ago
config: x86_64-randconfig-003-20241002 (https://download.01.org/0day-ci/archive/20241005/202410051828.Pb7a79Gu-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410051828.Pb7a79Gu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410051828.Pb7a79Gu-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/mm/pat/memtype.c:128:39: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
     128 |         unsigned long pg_flags = pg->flags & _PGMT_MASK;
         |                                              ^
   arch/x86/mm/pat/memtype.c:123:29: note: expanded from macro '_PGMT_MASK'
     123 | #define _PGMT_MASK              (1UL << PG_arch_2 | 1UL << PG_arch_1)
         |                                         ^
   include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
     106 |         PG_arch_1,
         |         ^
   arch/x86/mm/pat/memtype.c:134:23: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
     134 |         else if (pg_flags == _PGMT_UC_MINUS)
         |                              ^
   arch/x86/mm/pat/memtype.c:121:33: note: expanded from macro '_PGMT_UC_MINUS'
     121 | #define _PGMT_UC_MINUS          (1UL << PG_arch_2)
         |                                         ^
   include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
     106 |         PG_arch_1,
         |         ^
   arch/x86/mm/pat/memtype.c:152:19: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
     152 |                 memtype_flags = _PGMT_UC_MINUS;
         |                                 ^
   arch/x86/mm/pat/memtype.c:121:33: note: expanded from macro '_PGMT_UC_MINUS'
     121 | #define _PGMT_UC_MINUS          (1UL << PG_arch_2)
         |                                         ^
   include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
     106 |         PG_arch_1,
         |         ^
   arch/x86/mm/pat/memtype.c:155:19: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
     155 |                 memtype_flags = _PGMT_WT;
         |                                 ^
   arch/x86/mm/pat/memtype.c:122:27: note: expanded from macro '_PGMT_WT'
     122 | #define _PGMT_WT                (1UL << PG_arch_2 | 1UL << PG_arch_1)
         |                                         ^
   include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
     106 |         PG_arch_1,
         |         ^
   arch/x86/mm/pat/memtype.c:165:28: error: use of undeclared identifier 'PG_arch_2'; did you mean 'PG_arch_1'?
     165 |                 new_flags = (old_flags & _PGMT_CLEAR_MASK) | memtype_flags;
         |                                          ^
   arch/x86/mm/pat/memtype.c:124:28: note: expanded from macro '_PGMT_CLEAR_MASK'
     124 | #define _PGMT_CLEAR_MASK        (~_PGMT_MASK)
         |                                   ^
   arch/x86/mm/pat/memtype.c:123:29: note: expanded from macro '_PGMT_MASK'
     123 | #define _PGMT_MASK              (1UL << PG_arch_2 | 1UL << PG_arch_1)
         |                                         ^
   include/linux/page-flags.h:106:2: note: 'PG_arch_1' declared here
     106 |         PG_arch_1,
         |         ^
   5 errors generated.


vim +128 arch/x86/mm/pat/memtype.c

0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  125  
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  126  static inline enum page_cache_mode get_page_memtype(struct page *pg)
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  127  {
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16 @128  	unsigned long pg_flags = pg->flags & _PGMT_MASK;
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  129  
35a5a10411d87e arch/x86/mm/pat.c Toshi Kani      2015-06-04  130  	if (pg_flags == _PGMT_WB)
35a5a10411d87e arch/x86/mm/pat.c Toshi Kani      2015-06-04  131  		return _PAGE_CACHE_MODE_WB;
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  132  	else if (pg_flags == _PGMT_WC)
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  133  		return _PAGE_CACHE_MODE_WC;
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  134  	else if (pg_flags == _PGMT_UC_MINUS)
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  135  		return _PAGE_CACHE_MODE_UC_MINUS;
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  136  	else
35a5a10411d87e arch/x86/mm/pat.c Toshi Kani      2015-06-04  137  		return _PAGE_CACHE_MODE_WT;
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  138  }
0dbcae884779fd arch/x86/mm/pat.c Thomas Gleixner 2014-11-16  139  

:::::: The code at line 128 was first introduced by commit
:::::: 0dbcae884779fdf7e2239a97ac7488877f0693d9 x86: mm: Move PAT only functions to mm/pat.c

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


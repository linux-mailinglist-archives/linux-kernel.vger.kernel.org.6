Return-Path: <linux-kernel+bounces-516306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B27AA36F84
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C2E16D9C4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50931DD877;
	Sat, 15 Feb 2025 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BiNsoSA+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE141A5B95
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739637854; cv=none; b=nf9AaERI1S5ylUVqJBKquPjgaO852438/k7gi0NB3xzRamqxaAclHz5oSK+H2VvVR7617umb8w+kKRI7tuI5EYxZKJSx0qU4qqUi7J+yQMxm0dqyVMYu8HFX0WPjYY0kS3oIBEsDLW9Cnplo/yUf0g/HKGJxmv4EpKJ5EOR+COY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739637854; c=relaxed/simple;
	bh=+l7+iy0DBJq4VnUr+KEYWt2/mvZ9DMngN/x4L6oUq8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZuxeqeG63e893S23NmjGS7WNrGUoK5YtYIJwMdmai5yM4fU2eBtD6fefc6Zx8thd1WDiuLkwdIermK6p5HRkUXWou0nIiBSWDulggmo/vnxiQg645H+vAHoDUf46x5uZnIBLsiEwu2IL61gU9hWF9ppsBLmlFo4WRcbp8AQFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BiNsoSA+; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739637851; x=1771173851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+l7+iy0DBJq4VnUr+KEYWt2/mvZ9DMngN/x4L6oUq8Q=;
  b=BiNsoSA+xSH/ARva9GcnOO+3d4g21yV7K4owl34av8l7D81b/a6MUuhe
   2cG/0r4as4i1L1raqW/A5ywAedKgtA1HMYf015s9w1GdwpfJg0eAZLEjw
   V5HF8e+DHaWUquYcIuu/RnUyZtz4oMtwflyMiG1ZV1XBqBlnFTSdBU+hA
   r6beBE43CxM5tP5HN11ah15mdqK4ZGSHRifz5mE0m54icj9lKju5DSNpd
   O6lDqfs1dSD9VT72ZYhYCoV4Xu6RTcdnSE20pBiB9thiCG/qKWVzcSceY
   DFh4aIzvdga5CyxGnmei7Jli/RMYk4KIENCZmrlS/zv5WhoJCednHB4zY
   A==;
X-CSE-ConnectionGUID: jGSjArv6TBCJaQ9fEhNqlQ==
X-CSE-MsgGUID: 6Zs6fYygTI+7eJe7VooKgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="44021007"
X-IronPort-AV: E=Sophos;i="6.13,289,1732608000"; 
   d="scan'208";a="44021007"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 08:44:11 -0800
X-CSE-ConnectionGUID: Mg/qGwZ0Tr+LNeAcUMqnkQ==
X-CSE-MsgGUID: CoKoADpWQ4m5EG+HHRW34g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118352535"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 15 Feb 2025 08:44:06 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tjLGu-001B0F-2d;
	Sat, 15 Feb 2025 16:44:04 +0000
Date: Sun, 16 Feb 2025 00:43:43 +0800
From: kernel test robot <lkp@intel.com>
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH 7/7] mm, swap: simplify folio swap allocation
Message-ID: <202502160013.l8ZYewQK-lkp@intel.com>
References: <20250214175709.76029-8-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214175709.76029-8-ryncsn@gmail.com>

Hi Kairui,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Kairui-Song/mm-swap-avoid-reclaiming-irrelevant-swap-cache/20250215-020239
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250214175709.76029-8-ryncsn%40gmail.com
patch subject: [PATCH 7/7] mm, swap: simplify folio swap allocation
config: x86_64-buildonly-randconfig-002-20250215 (https://download.01.org/0day-ci/archive/20250216/202502160013.l8ZYewQK-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250216/202502160013.l8ZYewQK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502160013.l8ZYewQK-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2208:
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
   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
>> include/linux/swap.h:591:1: error: expected identifier or '('
     591 | {
         | ^
   4 warnings and 1 error generated.
   make[3]: *** [scripts/Makefile.build:102: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=2496405435
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1264: prepare0] Error 2 shuffle=2496405435
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=2496405435
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=2496405435
   make: Target 'prepare' not remade because of errors.


vim +591 include/linux/swap.h

8334b96221ff0d Minchan Kim    2015-09-08  589  
f8d9ff0d052908 Kairui Song    2025-02-15  590  static bool folio_alloc_swap(struct folio *folio, gfp_t gfp_mask);
^1da177e4c3f41 Linus Torvalds 2005-04-16 @591  {
f8d9ff0d052908 Kairui Song    2025-02-15  592  	return false;
^1da177e4c3f41 Linus Torvalds 2005-04-16  593  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  594  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


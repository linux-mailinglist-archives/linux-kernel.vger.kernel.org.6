Return-Path: <linux-kernel+bounces-446314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A999B9F2280
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 08:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179361886BD3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE2200CD;
	Sun, 15 Dec 2024 07:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckT5gaQ0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3CE8831
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 07:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734248780; cv=none; b=Y5oElwBPRrMflzwCUZGCwp6QuVkboV8gpYq5R9jrsj4fjJ4C1iIUFM2wwPP7aELrDm6jxl5LSybgChHiCEQVJJ3ICovsT/i/hl9MxotRvQ4GtAxR+6Rssqcj6sVpmvM8nfhZn55XwA/yWR0noTjchIj/C09Vlj+tK0An7LPj2ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734248780; c=relaxed/simple;
	bh=fC4NPKnJJOUU2ysy6AcJTUfQFOtrN3dJ1Xe8LK0Xltg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9Qmwml7HqMXnnppDdC2jdt4CUJihO3QVg5wlzK40NuuHDEjd9FXOYH1fZ/IzDxGUP5hcNoRdgk3dlRmuUaROizl7M0NePQ28E7+MS8jkUuWJnvFJGFqr5FYKaW1Hc1qXYRQsi/FxVl3Z6HWZq1A+p/tpusoHaEN19vmq5iiFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckT5gaQ0; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734248778; x=1765784778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fC4NPKnJJOUU2ysy6AcJTUfQFOtrN3dJ1Xe8LK0Xltg=;
  b=ckT5gaQ0Q2hUPZcqiTpKcESHSb9b39tS74feSFZiuJoj3l+oIScHQ84Q
   /pDU5l3Objs+wuKVLyvO8OImBszBUd71SxChdWZDE9nau8RYLDxgLxnnX
   G93jzRr0cW04JaCenptF5iZeGh9bZzasOScsGOw+n1JWEHOQ9kvhMQlQ2
   yT35yNzzPCmtEao5YODpC2A6EKaXoE2K1ZrHM413aEdAx+JgqVLtqNqZD
   mKoGcxjGbE5UbCo7MuU+OTOY2sFarsfWuCf64HTRzUkDMY7xU5jz1xMVI
   +AK/A1mgEzD6kAGNQ+FfhraQganSj00BMott5QtMr+aBqZlMq10RAcpXc
   Q==;
X-CSE-ConnectionGUID: g2WNmqOoR0SbQPgNCohisQ==
X-CSE-MsgGUID: iNIOoZSGQASvUA4CZ4dkJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="34563412"
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="34563412"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 23:46:17 -0800
X-CSE-ConnectionGUID: x12cjSA0RaaDKTopkm41FA==
X-CSE-MsgGUID: fOAIFhkFTweeTrvjjotEkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,236,1728975600"; 
   d="scan'208";a="97473203"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 Dec 2024 23:46:15 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMjKO-000DVa-2o;
	Sun, 15 Dec 2024 07:46:12 +0000
Date: Sun, 15 Dec 2024 15:45:52 +0800
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
Message-ID: <202412151541.SQEZStgy-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Liu-Shixin/mm-hugetlb-independent-PMD-page-table-shared-count/20241214-184912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241214104401.1052550-1-liushixin2%40huawei.com
patch subject: [PATCH] mm: hugetlb: independent PMD page table shared count
config: hexagon-randconfig-001-20241215 (https://download.01.org/0day-ci/archive/20241215/202412151541.SQEZStgy-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 2dc22615fd46ab2566d0f26d5ba234ab12dc4bf8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241215/202412151541.SQEZStgy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412151541.SQEZStgy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from kernel/dma/direct.c:7:
   In file included from include/linux/memblock.h:12:
   include/linux/mm.h:3192:21: error: called object type 'void *' is not a function or function pointer
    3192 |         ptdesc_pmd_pts_init(ptdesc);
         |         ~~~~~~~~~~~~~~~~~~~^
>> kernel/dma/direct.c:147:20: warning: shift count >= width of type [-Wshift-count-overflow]
     146 |                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     147 |                     phys_limit < DMA_BIT_MASK(64) &&
         |                     ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
     148 |                     !(gfp & (GFP_DMA32 | GFP_DMA))) {
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
>> kernel/dma/direct.c:147:20: warning: shift count >= width of type [-Wshift-count-overflow]
     146 |                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     147 |                     phys_limit < DMA_BIT_MASK(64) &&
         |                     ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
     148 |                     !(gfp & (GFP_DMA32 | GFP_DMA))) {
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:61: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
>> kernel/dma/direct.c:147:20: warning: shift count >= width of type [-Wshift-count-overflow]
     146 |                 if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     147 |                     phys_limit < DMA_BIT_MASK(64) &&
         |                     ~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
     148 |                     !(gfp & (GFP_DMA32 | GFP_DMA))) {
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:73:54: note: expanded from macro 'DMA_BIT_MASK'
      73 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
         |                                                      ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:86: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:68:3: note: expanded from macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   3 warnings and 1 error generated.


vim +147 kernel/dma/direct.c

aea7e2a86a94b25 kernel/dma/direct.c Christoph Hellwig      2021-10-21  117  
26749b3201ab05e kernel/dma/direct.c Christoph Hellwig      2020-06-15  118  static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
92826e967535db2 kernel/dma/direct.c Christoph Hellwig      2022-04-23  119  		gfp_t gfp, bool allow_highmem)
a8463d4b0e47d1f lib/dma-noop.c      Christian Borntraeger  2016-02-02  120  {
90ae409f9eb3bca kernel/dma/direct.c Christoph Hellwig      2019-08-20  121  	int node = dev_to_node(dev);
080321d3b3139b3 lib/dma-direct.c    Christoph Hellwig      2017-12-22  122  	struct page *page = NULL;
a7ba70f1787f977 kernel/dma/direct.c Nicolas Saenz Julienne 2019-11-21  123  	u64 phys_limit;
a8463d4b0e47d1f lib/dma-noop.c      Christian Borntraeger  2016-02-02  124  
633d5fce78a61e8 kernel/dma/direct.c David Rientjes         2020-06-11  125  	WARN_ON_ONCE(!PAGE_ALIGNED(size));
633d5fce78a61e8 kernel/dma/direct.c David Rientjes         2020-06-11  126  
aea7e2a86a94b25 kernel/dma/direct.c Christoph Hellwig      2021-10-21  127  	if (is_swiotlb_for_alloc(dev))
aea7e2a86a94b25 kernel/dma/direct.c Christoph Hellwig      2021-10-21  128  		return dma_direct_alloc_swiotlb(dev, size);
aea7e2a86a94b25 kernel/dma/direct.c Christoph Hellwig      2021-10-21  129  
25a4ce564921db0 kernel/dma/direct.c Petr Tesarik           2023-02-20  130  	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
633d5fce78a61e8 kernel/dma/direct.c David Rientjes         2020-06-11  131  	page = dma_alloc_contiguous(dev, size, gfp);
92826e967535db2 kernel/dma/direct.c Christoph Hellwig      2022-04-23  132  	if (page) {
92826e967535db2 kernel/dma/direct.c Christoph Hellwig      2022-04-23  133  		if (!dma_coherent_ok(dev, page_to_phys(page), size) ||
92826e967535db2 kernel/dma/direct.c Christoph Hellwig      2022-04-23  134  		    (!allow_highmem && PageHighMem(page))) {
633d5fce78a61e8 kernel/dma/direct.c David Rientjes         2020-06-11  135  			dma_free_contiguous(dev, page, size);
90ae409f9eb3bca kernel/dma/direct.c Christoph Hellwig      2019-08-20  136  			page = NULL;
90ae409f9eb3bca kernel/dma/direct.c Christoph Hellwig      2019-08-20  137  		}
92826e967535db2 kernel/dma/direct.c Christoph Hellwig      2022-04-23  138  	}
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  139  again:
90ae409f9eb3bca kernel/dma/direct.c Christoph Hellwig      2019-08-20  140  	if (!page)
633d5fce78a61e8 kernel/dma/direct.c David Rientjes         2020-06-11  141  		page = alloc_pages_node(node, gfp, get_order(size));
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  142  	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
f689a3ab7b8ece9 kernel/dma/direct.c Chen Yu                2024-08-31  143  		__free_pages(page, get_order(size));
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  144  		page = NULL;
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  145  
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  146  		if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
a7ba70f1787f977 kernel/dma/direct.c Nicolas Saenz Julienne 2019-11-21 @147  		    phys_limit < DMA_BIT_MASK(64) &&
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  148  		    !(gfp & (GFP_DMA32 | GFP_DMA))) {
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  149  			gfp |= GFP_DMA32;
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  150  			goto again;
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  151  		}
de7eab301de7886 lib/dma-direct.c    Takashi Iwai           2018-04-16  152  
fbce251baa6e357 kernel/dma/direct.c Christoph Hellwig      2019-02-13  153  		if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA)) {
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  154  			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  155  			goto again;
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  156  		}
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  157  	}
95f183916d4b0bc lib/dma-direct.c    Christoph Hellwig      2018-01-09  158  
b18814e767a4455 kernel/dma/direct.c Christoph Hellwig      2018-11-04  159  	return page;
b18814e767a4455 kernel/dma/direct.c Christoph Hellwig      2018-11-04  160  }
b18814e767a4455 kernel/dma/direct.c Christoph Hellwig      2018-11-04  161  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


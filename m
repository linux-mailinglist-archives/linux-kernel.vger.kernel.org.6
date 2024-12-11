Return-Path: <linux-kernel+bounces-441732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9439ED338
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CCC1888563
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB71DE89A;
	Wed, 11 Dec 2024 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1sOs//g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FD61DDC3E
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937536; cv=none; b=UZ8C0fansZshQsgvgB495OXb5AcFf8n4W0rCPhXEASzjInAcJIKiw526SZNvkVuXWDHOUaKXyPPeRX8WG01XlPUhYnN51nRuB+3fgLJ4B3WZB5IK18mqCzjOaqvkDO4vNrLB4k/UFhZlbfpT4bggLlBUlvYTSSXXWG4zpBZ+ic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937536; c=relaxed/simple;
	bh=Ck+PVhr4fHniz5Eg+zhhB78UyZZdlCm0HtuiQWn6AFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c97AHr6W1XW4/Oi9wRs3D3aA3wECLlY1ou4YtASPXmXWi15Tg57KiHNfc2KURpAvgvztWtJtXxdDrTNtqUiN+ZF/+P+K7tmhkmmPnnvZrq9i9TuiJvKoebvi4aUwr+Qw3Lt89/UOoH55TOsCZEC4ccOwnX9ylgfOopbetu/KVTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1sOs//g; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733937534; x=1765473534;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ck+PVhr4fHniz5Eg+zhhB78UyZZdlCm0HtuiQWn6AFk=;
  b=N1sOs//gvWV6Z/gjh8MQfdElQZE0dQ70v0FiAcOo2t/wfOnWzoqKgSuw
   ro3zPTukoDJx95s4HtfS+B1fm0BG/OiyArhUXoyPDKWuXNowQGwOW96Jx
   ZhqzdApQcU69TzfPhq/zxkf/CuYt/Fz8m8AwckqT58tVcYXJV3b5sa2S8
   I6MiQIA+xBu9iGiVLhDwQmvVEoB/SBSNo+kxn7fkfjGdQebBx8StlC6QU
   y7u86DDF82cWyOJuioN7epyEsU4wo1Y//ABkLtYK7a60WkALoa86a5JKb
   OThT9LFEIPqtNQr8BPxkWC0OrYUqfZpAJojSOKFAwSdLnK5ip2+HUacG9
   w==;
X-CSE-ConnectionGUID: l874XxqQSPWmerL4a4Q+Yw==
X-CSE-MsgGUID: D/nBKsfDSxqATZpl/mS46g==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34203258"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34203258"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:18:54 -0800
X-CSE-ConnectionGUID: CBUOilqoRsm+7CIBPNeM7Q==
X-CSE-MsgGUID: DwmC44QBSTyW/BFN3cRSbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="95714130"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Dec 2024 09:18:52 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLQML-0006vf-1b;
	Wed, 11 Dec 2024 17:18:49 +0000
Date: Thu, 12 Dec 2024 01:18:16 +0800
From: kernel test robot <lkp@intel.com>
To: Hao Ge <hao.ge@linux.dev>, surenb@google.com, kent.overstreet@linux.dev,
	akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>, Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH v3] mm/alloc_tag: Fix panic when CONFIG_KASAN enabled and
 CONFIG_KASAN_VMALLOC not enabled
Message-ID: <202412120143.l3g6vx8b-lkp@intel.com>
References: <20241211025755.56173-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211025755.56173-1-hao.ge@linux.dev>

Hi Hao,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Hao-Ge/mm-alloc_tag-Fix-panic-when-CONFIG_KASAN-enabled-and-CONFIG_KASAN_VMALLOC-not-enabled/20241211-110206
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20241211025755.56173-1-hao.ge%40linux.dev
patch subject: [PATCH v3] mm/alloc_tag: Fix panic when CONFIG_KASAN enabled and CONFIG_KASAN_VMALLOC not enabled
config: i386-buildonly-randconfig-005-20241211 (https://download.01.org/0day-ci/archive/20241212/202412120143.l3g6vx8b-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120143.l3g6vx8b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120143.l3g6vx8b-lkp@intel.com/

All errors (new ones prefixed by >>):

   lib/alloc_tag.c: In function 'vm_module_tags_populate':
>> lib/alloc_tag.c:409:40: error: 'KASAN_SHADOW_SCALE_SHIFT' undeclared (first use in this function)
     409 |                                  (2 << KASAN_SHADOW_SCALE_SHIFT) - 1) >> KASAN_SHADOW_SCALE_SHIFT;
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~
   lib/alloc_tag.c:409:40: note: each undeclared identifier is reported only once for each function it appears in


vim +/KASAN_SHADOW_SCALE_SHIFT +409 lib/alloc_tag.c

   402	
   403	static int vm_module_tags_populate(void)
   404	{
   405		unsigned long phys_end = ALIGN_DOWN(module_tags.start_addr, PAGE_SIZE) +
   406					 (vm_module_tags->nr_pages << PAGE_SHIFT);
   407		unsigned long new_end = module_tags.start_addr + module_tags.size;
   408		unsigned long phys_idx = (vm_module_tags->nr_pages +
 > 409					 (2 << KASAN_SHADOW_SCALE_SHIFT) - 1) >> KASAN_SHADOW_SCALE_SHIFT;
   410		unsigned long new_idx = 0;
   411	
   412		if (phys_end < new_end) {
   413			struct page **next_page = vm_module_tags->pages + vm_module_tags->nr_pages;
   414			unsigned long more_pages;
   415			unsigned long nr;
   416	
   417			more_pages = ALIGN(new_end - phys_end, PAGE_SIZE) >> PAGE_SHIFT;
   418			nr = alloc_pages_bulk_array_node(GFP_KERNEL | __GFP_NOWARN,
   419							 NUMA_NO_NODE, more_pages, next_page);
   420			if (nr < more_pages ||
   421			    vmap_pages_range(phys_end, phys_end + (nr << PAGE_SHIFT), PAGE_KERNEL,
   422					     next_page, PAGE_SHIFT) < 0) {
   423				/* Clean up and error out */
   424				for (int i = 0; i < nr; i++)
   425					__free_page(next_page[i]);
   426				return -ENOMEM;
   427			}
   428	
   429			vm_module_tags->nr_pages += nr;
   430	
   431			new_idx = (vm_module_tags->nr_pages +
   432				  (2 << KASAN_SHADOW_SCALE_SHIFT) - 1) >> KASAN_SHADOW_SCALE_SHIFT;
   433	
   434			/*
   435			 * Kasan allocates 1 byte of shadow for every 8 bytes of data.
   436			 * When kasan_alloc_module_shadow allocates shadow memory,
   437			 * its unit of allocation is a page.
   438			 * Therefore, here we need to align to MODULE_ALIGN.
   439			 *
   440			 * For every KASAN_SHADOW_SCALE_SHIFT, a shadow page is allocated.
   441			 * So, we determine whether to allocate based on whether the
   442			 * number of pages falls within the scope of the same KASAN_SHADOW_SCALE_SHIFT.
   443			 */
   444			if (phys_idx != new_idx)
   445				kasan_alloc_module_shadow((void *)round_up(phys_end, MODULE_ALIGN),
   446							  (new_idx - phys_idx) * MODULE_ALIGN,
   447							  GFP_KERNEL);
   448		}
   449	
   450		/*
   451		 * Mark the pages as accessible, now that they are mapped.
   452		 * With hardware tag-based KASAN, marking is skipped for
   453		 * non-VM_ALLOC mappings, see __kasan_unpoison_vmalloc().
   454		 */
   455		kasan_unpoison_vmalloc((void *)module_tags.start_addr,
   456					new_end - module_tags.start_addr,
   457					KASAN_VMALLOC_PROT_NORMAL);
   458	
   459		return 0;
   460	}
   461	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


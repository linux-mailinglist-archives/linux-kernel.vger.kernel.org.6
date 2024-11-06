Return-Path: <linux-kernel+bounces-398687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 009069BF4AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28501C22362
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F8A207A26;
	Wed,  6 Nov 2024 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VilI7UWP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A02036E2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915675; cv=none; b=czHhmxupUBCr/w1di5TTazubWrU1kwKrpO3WdoUYiWFQ8PjJnWnpQ2hoib8wSBQMzbCDbhyC8HTc4uY9h8nTdmxwW2NRoyXuQ8rTLm3rHGRlNmF7C8MAR3YzVsR3tYPKUmQBZ0EH8PeFot8U9FRTRioeHaWkuQjoQgYJAvofUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915675; c=relaxed/simple;
	bh=cDz3GbfOlnxsDFkNUWxFouzEfiwqYtJwJJki0uFIs1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD5YWLpT02CO/0sSVUBQQbmHPgcxRxqXB23PaaF2fqQDZ7hG83RD7tsHVms4b9jmZn3H/cgkc0hTxGU179Ti/TUrB2U1WTDdgCProuwVXA4Q47gx1eu3glAIKBMfXavNmbGY32BTc/D+h/oVLg0NhZ9CxHi77LNJ6Or7sIIPGLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VilI7UWP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730915673; x=1762451673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cDz3GbfOlnxsDFkNUWxFouzEfiwqYtJwJJki0uFIs1k=;
  b=VilI7UWPfQV9sT+1bGw2MeVyjJTXL/869c7spv7SQemJZ3NYfBw2vMQB
   +jnLWmG9aEy9M8zlsl8K35BOcatjckFPUN71Hk1fRqDzWqOStvUyt8SwR
   QSSWo4Zioe1fM45MUfUn+qCNN7h+tRPn6geIz6nutivkFCu+vRYtcVYkQ
   zdBGNnZnYEk+GzrRJwTTsf2D5rftv2XLF8MBPgMK70rltd7hmrrqti41U
   DINruTCkKGBOcl68RPlBd/XxhhAVb6Zuc7OTY403mVtWEY7vdRIgACwxX
   AvROC2RIyeKVnGpB4fkWiyShyLBJlbYhVw+X9Hfc/xezz/9uCYF64C85X
   A==;
X-CSE-ConnectionGUID: hHvsxDbeQt69EFcV7RjUnA==
X-CSE-MsgGUID: DjYsRm6fSnKR2443azENPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="48246433"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="48246433"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 09:54:33 -0800
X-CSE-ConnectionGUID: YZVQo7FOSumGqTal8BzSCQ==
X-CSE-MsgGUID: 7nCFTiLDSaaGVdNjepMI+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="115516600"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 06 Nov 2024 09:54:30 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8kEd-000pFe-0h;
	Wed, 06 Nov 2024 17:54:27 +0000
Date: Thu, 7 Nov 2024 01:53:30 +0800
From: kernel test robot <lkp@intel.com>
To: Liviu Dudau <liviu.dudau@arm.com>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Steven Price <steven.price@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH] drm/panthor: Lock XArray when getting entries for heap
 and VM
Message-ID: <202411070115.YPuBa5QX-lkp@intel.com>
References: <20241106120748.290697-1-liviu.dudau@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106120748.290697-1-liviu.dudau@arm.com>

Hi Liviu,

kernel test robot noticed the following build errors:

[auto build test ERROR on drm-misc/drm-misc-next]
[also build test ERROR on linus/master v6.12-rc6 next-20241106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Liviu-Dudau/drm-panthor-Lock-XArray-when-getting-entries-for-heap-and-VM/20241106-200841
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20241106120748.290697-1-liviu.dudau%40arm.com
patch subject: [PATCH] drm/panthor: Lock XArray when getting entries for heap and VM
config: x86_64-buildonly-randconfig-002-20241106 (https://download.01.org/0day-ci/archive/20241107/202411070115.YPuBa5QX-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241107/202411070115.YPuBa5QX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411070115.YPuBa5QX-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/panthor/panthor_heap.c:9:
   In file included from drivers/gpu/drm/panthor/panthor_device.h:10:
   In file included from include/linux/io-pgtable.h:6:
   In file included from include/linux/iommu.h:10:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: error: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: error: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Werror,-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/panthor/panthor_heap.c:354:57: error: declaration of 'struct pathor_heap_pool' will not be visible outside of this function [-Werror,-Wvisibility]
     354 | static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
         |                                                         ^
   drivers/gpu/drm/panthor/panthor_heap.c:358:15: error: incomplete definition of type 'struct pathor_heap_pool'
     358 |         xa_lock(&pool->xa);
         |                  ~~~~^
   include/linux/xarray.h:536:34: note: expanded from macro 'xa_lock'
     536 | #define xa_lock(xa)             spin_lock(&(xa)->xa_lock)
         |                                             ^~
   drivers/gpu/drm/panthor/panthor_heap.c:354:57: note: forward declaration of 'struct pathor_heap_pool'
     354 | static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
         |                                                         ^
   drivers/gpu/drm/panthor/panthor_heap.c:359:22: error: incomplete definition of type 'struct pathor_heap_pool'
     359 |         heap = xa_load(&pool->xa, id);
         |                         ~~~~^
   drivers/gpu/drm/panthor/panthor_heap.c:354:57: note: forward declaration of 'struct pathor_heap_pool'
     354 | static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
         |                                                         ^
   drivers/gpu/drm/panthor/panthor_heap.c:360:17: error: incomplete definition of type 'struct pathor_heap_pool'
     360 |         xa_unlock(&pool->va);
         |                    ~~~~^
   include/linux/xarray.h:537:38: note: expanded from macro 'xa_unlock'
     537 | #define xa_unlock(xa)           spin_unlock(&(xa)->xa_lock)
         |                                               ^~
   drivers/gpu/drm/panthor/panthor_heap.c:354:57: note: forward declaration of 'struct pathor_heap_pool'
     354 | static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
         |                                                         ^
   drivers/gpu/drm/panthor/panthor_heap.c:389:30: error: incompatible pointer types passing 'struct panthor_heap_pool *' to parameter of type 'struct pathor_heap_pool *' [-Werror,-Wincompatible-pointer-types]
     389 |         heap = panthor_heap_from_id(pool, heap_id);
         |                                     ^~~~
   drivers/gpu/drm/panthor/panthor_heap.c:354:75: note: passing argument to parameter 'pool' here
     354 | static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
         |                                                                           ^
   drivers/gpu/drm/panthor/panthor_heap.c:452:30: error: incompatible pointer types passing 'struct panthor_heap_pool *' to parameter of type 'struct pathor_heap_pool *' [-Werror,-Wincompatible-pointer-types]
     452 |         heap = panthor_heap_from_id(pool, heap_id);
         |                                     ^~~~
   drivers/gpu/drm/panthor/panthor_heap.c:354:75: note: passing argument to parameter 'pool' here
     354 | static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
         |                                                                           ^
   10 errors generated.


vim +354 drivers/gpu/drm/panthor/panthor_heap.c

   353	
 > 354	static struct panthor_heap *panthor_heap_from_id(struct pathor_heap_pool *pool, u32 id)
   355	{
   356		struct panthor_heap *heap;
   357	
   358		xa_lock(&pool->xa);
   359		heap = xa_load(&pool->xa, id);
   360		xa_unlock(&pool->va);
   361	
   362		return heap;
   363	}
   364	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


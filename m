Return-Path: <linux-kernel+bounces-346591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E9E98C656
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE6CB22327
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A61CDFB6;
	Tue,  1 Oct 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RECq4Dt2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AB19D894
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812423; cv=none; b=bAaUEoNEWnh05mHCgdvZ9V+GV2hCiS3eq9hczaGCugY2kjsXpcn8DbbxLTEzkYkY/q/DDNs8ht3LvgVOZEP7ue9aEO+futLEBZnj74L/9h711RCVXaaUiZoE7ROZsKdJbZBllFHFYDQt8+lUEr0FNoA6/2GRktyh+yOZXTK1Qqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812423; c=relaxed/simple;
	bh=N+iFeYY2Ea4AzU8bpGJodptN+caCswB4L8BrUxAfJ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nf3sAOJ/sNDA700JRGiqP6cB/SzKMv0DpfHeE1tyj1uDClW4WfZn6iOrSCsmvu/DmUzMS93z9Is89BPkqBSwnFZ7VmF3jEe7pJXoGJdbp4iq2V+Rkw/hMXDevBw2ZU1j4O/QViC3cjFY43S/t8P5i9vIh6TeszOPXJplOI3Ay+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RECq4Dt2; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727812422; x=1759348422;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=N+iFeYY2Ea4AzU8bpGJodptN+caCswB4L8BrUxAfJ+c=;
  b=RECq4Dt2g442NUeojCkBb9RYHFAzB4cB2Kf5iYIGz8U52MlSSPcacwWL
   dJ1FJ4G7j5GE/c5bSGDKrwIppAHuPFWN5x9zWbgJFEe8LJ5KAeGWjH40l
   OeownYf1KlMq26fBuNTly1uAFjt2oJpMNCfGgcUVSQUHOqDIBDy1Uvtw4
   pw6lEfrTjUHuGVnfb2FbDbenbMEVfiT4WtCH5XE+BOdPqwJx5lSOcR2X8
   w2+HYtucr/Y3xG8bnFKCJgYgmF8orht6Uv8VbT3TJcD77OG3NJ/OOVmbM
   OkPcHbaBf7ybVjrJWkfeyjMZqjBYtLFBXKRwUUEu3s+pLTbffqylhtKFy
   w==;
X-CSE-ConnectionGUID: EFgtrzAVQ5m5u++d7ic9cA==
X-CSE-MsgGUID: Wh17nvogSNquSz0YjrtbsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26427985"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="26427985"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 12:53:41 -0700
X-CSE-ConnectionGUID: owKHtO3TSlqTRokwrF6VtQ==
X-CSE-MsgGUID: K9G61R05RPapH9odBWnKGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="74579436"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 01 Oct 2024 12:53:39 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sviwC-000R7Z-2w;
	Tue, 01 Oct 2024 19:53:36 +0000
Date: Wed, 2 Oct 2024 03:53:13 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: mm/slub.c:5000:2: error: call to '__compiletime_assert_641' declared
 with 'error' attribute: BUILD_BUG_ON failed: PERCPU_DYNAMIC_EARLY_SIZE <
 NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu)
Message-ID: <202410020326.iaZIteIx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e32cde8d2bd7d251a8f9b434143977ddf13dcec6
commit: d8fccd9ca5f905533dc6c26cfd1f91beb8691c95 arm64: Allow to enable PREEMPT_RT.
date:   2 weeks ago
config: arm64-randconfig-002-20241002 (https://download.01.org/0day-ci/archive/20241002/202410020326.iaZIteIx-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020326.iaZIteIx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020326.iaZIteIx-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/slub.c:13:
   In file included from include/linux/mm.h:2237:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> mm/slub.c:5000:2: error: call to '__compiletime_assert_641' declared with 'error' attribute: BUILD_BUG_ON failed: PERCPU_DYNAMIC_EARLY_SIZE < NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu)
    5000 |         BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:510:2: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:99:1: note: expanded from here
      99 | __compiletime_assert_641
         | ^
   1 warning and 1 error generated.


vim +5000 mm/slub.c

81819f0fc8285a Christoph Lameter 2007-05-06  4996  
0af8489b0216fa Vlastimil Babka   2022-11-15  4997  #ifndef CONFIG_SLUB_TINY
55136592fedf5c Christoph Lameter 2010-08-20  4998  static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
4c93c355d5d563 Christoph Lameter 2007-10-16  4999  {
6c182dc0de26ef Christoph Lameter 2010-08-20 @5000  	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
a0dc161ae77377 Baoquan He        2022-10-24  5001  			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
a0dc161ae77377 Baoquan He        2022-10-24  5002  			sizeof(struct kmem_cache_cpu));
4c93c355d5d563 Christoph Lameter 2007-10-16  5003  
8a5ec0ba42c491 Christoph Lameter 2011-02-25  5004  	/*
d4d84fef6d0366 Chris Metcalf     2011-06-02  5005  	 * Must align to double word boundary for the double cmpxchg
d4d84fef6d0366 Chris Metcalf     2011-06-02  5006  	 * instructions to work; see __pcpu_double_call_return_bool().
8a5ec0ba42c491 Christoph Lameter 2011-02-25  5007  	 */
d4d84fef6d0366 Chris Metcalf     2011-06-02  5008  	s->cpu_slab = __alloc_percpu(sizeof(struct kmem_cache_cpu),
d4d84fef6d0366 Chris Metcalf     2011-06-02  5009  				     2 * sizeof(void *));
8a5ec0ba42c491 Christoph Lameter 2011-02-25  5010  
8a5ec0ba42c491 Christoph Lameter 2011-02-25  5011  	if (!s->cpu_slab)
8a5ec0ba42c491 Christoph Lameter 2011-02-25  5012  		return 0;
8a5ec0ba42c491 Christoph Lameter 2011-02-25  5013  
8a5ec0ba42c491 Christoph Lameter 2011-02-25  5014  	init_kmem_cache_cpus(s);
4c93c355d5d563 Christoph Lameter 2007-10-16  5015  
8a5ec0ba42c491 Christoph Lameter 2011-02-25  5016  	return 1;
4c93c355d5d563 Christoph Lameter 2007-10-16  5017  }
0af8489b0216fa Vlastimil Babka   2022-11-15  5018  #else
0af8489b0216fa Vlastimil Babka   2022-11-15  5019  static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
0af8489b0216fa Vlastimil Babka   2022-11-15  5020  {
0af8489b0216fa Vlastimil Babka   2022-11-15  5021  	return 1;
0af8489b0216fa Vlastimil Babka   2022-11-15  5022  }
0af8489b0216fa Vlastimil Babka   2022-11-15  5023  #endif /* CONFIG_SLUB_TINY */
4c93c355d5d563 Christoph Lameter 2007-10-16  5024  

:::::: The code at line 5000 was first introduced by commit
:::::: 6c182dc0de26ef97efb6a97a8deab074833764e7 slub: Remove static kmem_cache_cpu array for boot

:::::: TO: Christoph Lameter <cl@linux.com>
:::::: CC: Pekka Enberg <penberg@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


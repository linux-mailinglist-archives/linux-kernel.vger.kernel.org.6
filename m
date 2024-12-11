Return-Path: <linux-kernel+bounces-441484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0709ECF00
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 15:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71758167963
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4D919CCF4;
	Wed, 11 Dec 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nW5chrzA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7A618A6D3
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733928675; cv=none; b=YGeluji/dCj5Ju69wfXZFRlm6CWLEnKC5SEmAeWtZpVdFVRl9V0q29nEF7alG0y9WM4o5O4tsaQJPZGKzprF8vuWWw2WcCBorgjxnqcMZxhVbbCCarHXpXYO3QcpXwQbfiUhadFtoHLu2gDMIohyWpaqSSSYbWtOppPobZnHBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733928675; c=relaxed/simple;
	bh=Vh1QztaHzm+Qph1KJjgwrCQhNw49ue66pzGRs1ZOQhk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mk165isO07zJL3CIGqgl/3ZKOABgXyOVyec8Q075r4FxrwmFVgKEYuvw0CwURWrtb9Ij9wO2M02WWgz4rKhm2e44jX6XiPbMmwsa/c0ukKzkjnb/piEdqAeRyVL4PHFLTY/AOo1PspkN7/YFXKbUopQfRoclorgiKOHGkdFTu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nW5chrzA; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733928674; x=1765464674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vh1QztaHzm+Qph1KJjgwrCQhNw49ue66pzGRs1ZOQhk=;
  b=nW5chrzAUGPsuZHfiFwUv8GS1cBs2rlOgneK4KqCFiXXo7yiYOv8RziE
   tBRubrnBva8bPcaXsuNpUIffrmAN+GNUKkLuKgcBnJzvbyiHAQjPBScHQ
   jFMm8OYH7xm7rNW2A16MH5GYpvtEG5J5Fv9Vomgo0htyZ6mZ+nukaO0PU
   elN0hDNgEpsjUoPueMqDLvbfKLng3KDh9tbXcLckbLdHIY/WqPumzX+Ek
   EZFtB315Y78QqiiR3t+mB/3+xgWxfssQCAAOpRjFu6pP0iNqkQ3x3nYzk
   ACBF8qjo3sYBirACjCqUygpx7O9GrpBSyjUugWgYLSzqxYFYKpPbbDZ/w
   A==;
X-CSE-ConnectionGUID: e62o1qydTrWcdK8+Gjr7LA==
X-CSE-MsgGUID: DgxF40XNSjuklj6DGVodmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34213117"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34213117"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 06:51:13 -0800
X-CSE-ConnectionGUID: y0Cq/jipTOuPs4KOsT0BnA==
X-CSE-MsgGUID: qQPafaD4Rd6MvJxuZmUz5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="96313555"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 11 Dec 2024 06:51:12 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLO3R-0006lh-1F;
	Wed, 11 Dec 2024 14:51:09 +0000
Date: Wed, 11 Dec 2024 22:50:30 +0800
From: kernel test robot <lkp@intel.com>
To: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: arch/powerpc/mm/mem.c:428:2: error: call to
 '__compiletime_assert_303' declared with 'error' attribute: BUILD_BUG_ON
 failed: TASK_SIZE > MODULES_VADDR
Message-ID: <202412112259.KBIIdlFd-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f92f4749861b06fed908d336b4dee1326003291b
commit: 0cc2dc4902f425e346d46deeea2352d9fba75375 arch: make execmem setup available regardless of CONFIG_MODULES
date:   7 months ago
config: powerpc-randconfig-003-20241209 (https://download.01.org/0day-ci/archive/20241211/202412112259.KBIIdlFd-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412112259.KBIIdlFd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412112259.KBIIdlFd-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/powerpc/mm/mem.c:15:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2210:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> arch/powerpc/mm/mem.c:428:2: error: call to '__compiletime_assert_303' declared with 'error' attribute: BUILD_BUG_ON failed: TASK_SIZE > MODULES_VADDR
     428 |         BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:467:2: note: expanded from macro 'compiletime_assert'
     467 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:455:2: note: expanded from macro '_compiletime_assert'
     455 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:448:4: note: expanded from macro '__compiletime_assert'
     448 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:100:1: note: expanded from here
     100 | __compiletime_assert_303
         | ^
   1 warning and 1 error generated.


vim +428 arch/powerpc/mm/mem.c

   413	
   414	struct execmem_info __init *execmem_arch_setup(void)
   415	{
   416		pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
   417		pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
   418		unsigned long fallback_start = 0, fallback_end = 0;
   419		unsigned long start, end;
   420	
   421		/*
   422		 * BOOK3S_32 and 8xx define MODULES_VADDR for text allocations and
   423		 * allow allocating data in the entire vmalloc space
   424		 */
   425	#ifdef MODULES_VADDR
   426		unsigned long limit = (unsigned long)_etext - SZ_32M;
   427	
 > 428		BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


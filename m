Return-Path: <linux-kernel+bounces-354463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF6D993DC9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 027D7B23748
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDA574C08;
	Tue,  8 Oct 2024 04:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FA2Au8LP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172AE33CA
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728360336; cv=none; b=YpZQ2pNJSmgXr0DLkO7nIsgTfbmfkkVIVnZkeEiaNf1ZLECZzcTXq5BdYnkcqOSlvKDxWeTKtCGLv3ABNGTvS9dMPedpb1vnIpdg6NYUQX++lcHABKh8xSG6kKNgcCAdxuFG2t9OfKAQLeCxJXywVUfEbNPQmspz4XSFiEUhgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728360336; c=relaxed/simple;
	bh=qyzD4PsadzxUVE55GeFeHOGsDpckV+GwCvdZII5THgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Otxu4GE3HbrogS61EE2rxUdCJpNAK8YKJOzWCLXPsYymfQjvzqUnVdJuw+GhSQqzX/8NXXsDJ4pDHaq/9Wr49fEB6aAWxJCTdx2RkHsZkw8aX8ItVBzkWAPXDINlbzfup7nPTRPomgEupfMdMpXeLjyNwX1uTXc4qMfngyd9A98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FA2Au8LP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728360334; x=1759896334;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qyzD4PsadzxUVE55GeFeHOGsDpckV+GwCvdZII5THgQ=;
  b=FA2Au8LPxm1u/emYJHH7Lmziu1RdNeHRIEh2xAUHJBEYozeitl63333E
   udARftYUBybe36el4gS13Bbu0TWh9Ptsdz02JXgMG3Fo7pKL6NBGN3mPd
   zrmnCNriSyIwJRnpjxeBoOm4bkjFZCJ9UZQWHLXpa8IeE9iZpNeygI23C
   fyHmfJW4jnEFHw7GZW4mUfp+e1m9IqDDCQvL1+Ye0lzZ74yoXtsXv6ht3
   HmnpAg5D46I3FHYuQglJRsBBDT8PlG7Bf5l5orZUISK47yDRMq0qO9A5q
   8AjXxrgzFPbLembma+ShpQ7F+I6Rm9qM4qjAqESjWM39YL8ZeUMhbZPl2
   A==;
X-CSE-ConnectionGUID: efYexFZtTqqrujuvvUKqCg==
X-CSE-MsgGUID: WzREAHbDTc6dDZK+4ggu5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="31318341"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="31318341"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 21:05:33 -0700
X-CSE-ConnectionGUID: HlEVAGC1QnSr6Y+QgxXyGw==
X-CSE-MsgGUID: Vr4VYJCAR+uRCVzj6cQjhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="75258901"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 07 Oct 2024 21:05:32 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sy1TW-0005se-1F;
	Tue, 08 Oct 2024 04:05:30 +0000
Date: Tue, 8 Oct 2024 12:04:32 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: include/linux/compiler_types.h:510:45: error: call to
 '__compiletime_assert_311' declared with attribute error: BUILD_BUG_ON
 failed: ALIGN_DOWN(MODULES_VADDR, SZ_256M) < TASK_SIZE
Message-ID: <202410081215.NswDGgQf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christophe,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   87d6aab2389e5ce0197d8257d5f8ee965a67c4cd
commit: 2f2b9a3adc66e978a1248ffb38df8477e8e97c57 powerpc/32s: Reduce default size of module/execmem area
date:   6 weeks ago
config: powerpc-randconfig-003-20241008 (https://download.01.org/0day-ci/archive/20241008/202410081215.NswDGgQf-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241008/202410081215.NswDGgQf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410081215.NswDGgQf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   arch/powerpc/mm/book3s32/mmu.c: In function 'mmu_mark_initmem_nx':
>> include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_311' declared with attribute error: BUILD_BUG_ON failed: ALIGN_DOWN(MODULES_VADDR, SZ_256M) < TASK_SIZE
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   arch/powerpc/mm/book3s32/mmu.c:226:9: note: in expansion of macro 'BUILD_BUG_ON'
     226 |         BUILD_BUG_ON(ALIGN_DOWN(MODULES_VADDR, SZ_256M) < TASK_SIZE);
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_311 +510 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  496  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  497  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  498  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  499  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  500  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  501   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  502   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  503   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  504   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  505   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  506   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  507   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  508   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  509  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @510  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  511  

:::::: The code at line 510 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


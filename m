Return-Path: <linux-kernel+bounces-225909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE1913749
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 04:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E85531C20FC2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 02:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAECBE49;
	Sun, 23 Jun 2024 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5MrwW/q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F953C38
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 02:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719108137; cv=none; b=kcvB1IRfez2o16n8Fro+qFH8aN2ma4cUDJbjbacarrCENovyB5eTV15a29Wmt+QzAOeM34DLk9vs7DvH3YI0Z0J6w5zlxSATd/UfL4bOeneaVieabzGlpFoz3EqlwpVUOpNEASiUCCSuaYhlXZCY4YIju0siB4nMeX8Vn9hlJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719108137; c=relaxed/simple;
	bh=yZHEElo6y2Fb3FJIa3A4lkk2Whbxb+o1CP5PTlOLARU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hM25LZqX3LlJx9dcZIxHitYD186GfTMPDW0sRzrBqQBNQroE3/vSoPA38QUW1/qYT+YUMhgQJCu4I9HKWJirE8rE5hDDBqzO0FYFd5z7Zs35O3mf7+N/PMVDAgVnS3GxYo/olfZkSnFA4HmaYwLkpKWHIj29iBDRf8SShNYQ8xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5MrwW/q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719108136; x=1750644136;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yZHEElo6y2Fb3FJIa3A4lkk2Whbxb+o1CP5PTlOLARU=;
  b=V5MrwW/qXvD/0gUKcng3jnXQZy1tBtqG7VkC+RF3eLZGM3RUkiwJzSM8
   wjadaP87XC/ZT6keoTFf95PYS6LqBXKAG2ru+MMoQhTCTv9Pz+evhSSs+
   DYnbX4csY1HGSqQqGa2rofv/T+Qvym0wiGmKuc9VAGJckN8KPJ6otiLUV
   uG5knHJHC1BpRo0ZqbaUN52m3bPQ8gew0xgMSVTzTCladaQSNLuopsIQo
   y5O+FIinduhtiPUIqf9JJYZtwpV31Szszd1XNGpBqTsZ0Y6JuAjzGYqc0
   JxcG9FcPToSjNhoHdYUOgffmS3OtWeXPygGFXhCkZDd36p/Mt1lIaqzdR
   Q==;
X-CSE-ConnectionGUID: uZ2vZTLXQLKYTdRi4zu4Tw==
X-CSE-MsgGUID: ttmNlxxUQ5u6jAjGqyESmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="15938078"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="15938078"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 19:02:12 -0700
X-CSE-ConnectionGUID: lKfGSFodTLWKliQlvnfR+Q==
X-CSE-MsgGUID: 8AJ2sL7wQCKrQ5Xds/NU7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="42921676"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 22 Jun 2024 19:02:10 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sLCYR-000A9g-27;
	Sun, 23 Jun 2024 02:02:07 +0000
Date: Sun, 23 Jun 2024 10:01:26 +0800
From: kernel test robot <lkp@intel.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
Message-ID: <202406230912.F6XFIyA6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f583a3162ffd9f7999af76b8ab634ce2dac9f90
commit: 95ece48165c136b96fae0f6144f55cbf8b24aeb9 locking/atomic/x86: Rewrite x86_32 arch_atomic64_{,fetch}_{and,or,xor}() functions
date:   2 months ago
config: i386-randconfig-061-20240623 (https://download.01.org/0day-ci/archive/20240623/202406230912.F6XFIyA6-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240623/202406230912.F6XFIyA6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406230912.F6XFIyA6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:8:
   In file included from include/linux/atomic.h:7:
   In file included from arch/x86/include/asm/atomic.h:8:
   In file included from arch/x86/include/asm/cmpxchg.h:143:
>> arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly requires more registers than available
     149 |         return __arch_try_cmpxchg64_emu(ptr, oldp, new);
         |                ^
   arch/x86/include/asm/cmpxchg_32.h:131:15: note: expanded from macro '__arch_try_cmpxchg64_emu'
     131 |         asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE                       \
         |                      ^
   arch/x86/include/asm/alternative.h:218:2: note: expanded from macro 'ALTERNATIVE'
     218 |         OLDINSTR(oldinstr, 1)                                           \
         |         ^
   arch/x86/include/asm/alternative.h:168:2: note: expanded from macro 'OLDINSTR'
     168 |         "# ALT: oldnstr\n"                                              \
         |         ^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:8:
   In file included from include/linux/atomic.h:7:
   In file included from arch/x86/include/asm/atomic.h:8:
   In file included from arch/x86/include/asm/cmpxchg.h:143:
>> arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly requires more registers than available
   arch/x86/include/asm/cmpxchg_32.h:131:15: note: expanded from macro '__arch_try_cmpxchg64_emu'
     131 |         asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE                       \
         |                      ^
   arch/x86/include/asm/alternative.h:218:2: note: expanded from macro 'ALTERNATIVE'
     218 |         OLDINSTR(oldinstr, 1)                                           \
         |         ^
   arch/x86/include/asm/alternative.h:168:2: note: expanded from macro 'OLDINSTR'
     168 |         "# ALT: oldnstr\n"                                              \
         |         ^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:8:
   In file included from include/linux/atomic.h:7:
   In file included from arch/x86/include/asm/atomic.h:8:
   In file included from arch/x86/include/asm/cmpxchg.h:143:
>> arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly requires more registers than available
   arch/x86/include/asm/cmpxchg_32.h:131:15: note: expanded from macro '__arch_try_cmpxchg64_emu'
     131 |         asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE                       \
         |                      ^
   arch/x86/include/asm/alternative.h:218:2: note: expanded from macro 'ALTERNATIVE'
     218 |         OLDINSTR(oldinstr, 1)                                           \
         |         ^
   arch/x86/include/asm/alternative.h:168:2: note: expanded from macro 'OLDINSTR'
     168 |         "# ALT: oldnstr\n"                                              \
         |         ^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:8:
   In file included from include/linux/atomic.h:7:
   In file included from arch/x86/include/asm/atomic.h:8:
   In file included from arch/x86/include/asm/cmpxchg.h:143:
>> arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly requires more registers than available
   arch/x86/include/asm/cmpxchg_32.h:131:15: note: expanded from macro '__arch_try_cmpxchg64_emu'
     131 |         asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE                       \
         |                      ^
   arch/x86/include/asm/alternative.h:218:2: note: expanded from macro 'ALTERNATIVE'
     218 |         OLDINSTR(oldinstr, 1)                                           \
         |         ^
   arch/x86/include/asm/alternative.h:168:2: note: expanded from macro 'OLDINSTR'
     168 |         "# ALT: oldnstr\n"                                              \
         |         ^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:8:
   In file included from include/linux/atomic.h:7:
   In file included from arch/x86/include/asm/atomic.h:8:
   In file included from arch/x86/include/asm/cmpxchg.h:143:
>> arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly requires more registers than available
   arch/x86/include/asm/cmpxchg_32.h:131:15: note: expanded from macro '__arch_try_cmpxchg64_emu'
     131 |         asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE                       \
         |                      ^
   arch/x86/include/asm/alternative.h:218:2: note: expanded from macro 'ALTERNATIVE'
     218 |         OLDINSTR(oldinstr, 1)                                           \
         |         ^
   arch/x86/include/asm/alternative.h:168:2: note: expanded from macro 'OLDINSTR'
     168 |         "# ALT: oldnstr\n"                                              \
         |         ^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:8:
   In file included from include/linux/atomic.h:7:
   In file included from arch/x86/include/asm/atomic.h:8:
   In file included from arch/x86/include/asm/cmpxchg.h:143:
>> arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly requires more registers than available
   arch/x86/include/asm/cmpxchg_32.h:131:15: note: expanded from macro '__arch_try_cmpxchg64_emu'
     131 |         asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE                       \
         |                      ^
   arch/x86/include/asm/alternative.h:218:2: note: expanded from macro 'ALTERNATIVE'
     218 |         OLDINSTR(oldinstr, 1)                                           \
         |         ^
   arch/x86/include/asm/alternative.h:168:2: note: expanded from macro 'OLDINSTR'
     168 |         "# ALT: oldnstr\n"                                              \
         |         ^
   In file included from kernel/bpf/core.c:21:
   In file included from include/linux/filter.h:8:
   In file included from include/linux/atomic.h:7:
   In file included from arch/x86/include/asm/atomic.h:8:
   In file included from arch/x86/include/asm/cmpxchg.h:143:
>> arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly requires more registers than available
   arch/x86/include/asm/cmpxchg_32.h:131:15: note: expanded from macro '__arch_try_cmpxchg64_emu'
     131 |         asm volatile(ALTERNATIVE(LOCK_PREFIX_HERE                       \
         |                      ^
   arch/x86/include/asm/alternative.h:218:2: note: expanded from macro 'ALTERNATIVE'
     218 |         OLDINSTR(oldinstr, 1)                                           \
         |         ^
   arch/x86/include/asm/alternative.h:168:2: note: expanded from macro 'OLDINSTR'
     168 |         "# ALT: oldnstr\n"                                              \
         |         ^
   7 errors generated.


vim +149 arch/x86/include/asm/cmpxchg_32.h

aef95dac9ce4f2 Uros Bizjak 2024-04-08  146  
aef95dac9ce4f2 Uros Bizjak 2024-04-08  147  static __always_inline bool arch_try_cmpxchg64(volatile u64 *ptr, u64 *oldp, u64 new)
aef95dac9ce4f2 Uros Bizjak 2024-04-08  148  {
aef95dac9ce4f2 Uros Bizjak 2024-04-08 @149  	return __arch_try_cmpxchg64_emu(ptr, oldp, new);
aef95dac9ce4f2 Uros Bizjak 2024-04-08  150  }
aef95dac9ce4f2 Uros Bizjak 2024-04-08  151  #define arch_try_cmpxchg64 arch_try_cmpxchg64
aef95dac9ce4f2 Uros Bizjak 2024-04-08  152  

:::::: The code at line 149 was first introduced by commit
:::::: aef95dac9ce4f271cc43195ffc175114ed934cbe locking/atomic/x86: Introduce arch_try_cmpxchg64() for !CONFIG_X86_CMPXCHG64

:::::: TO: Uros Bizjak <ubizjak@gmail.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


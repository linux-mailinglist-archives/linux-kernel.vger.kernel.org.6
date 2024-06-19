Return-Path: <linux-kernel+bounces-221595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD94D90F5D7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426291F22848
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A94156C5B;
	Wed, 19 Jun 2024 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RyAGON0j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31C320F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820999; cv=none; b=rkakySqqHgnql6wqckGisaCu0DnrPZ1hSR/IxJa/dYa9Y52xp1CpCYc/PeQ+RGd0mas6g7Mc4f+OQtABWt8jtHT1YdmqtKPBnorGa90lWQSFrf9KNwkwJJ8m3Oxjy/c/zVhIms7dfkX9rUepOB88sWtJjWyh3RnmHrLk1Q8iRnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820999; c=relaxed/simple;
	bh=/0UkGO1fDhL58FqhPy5MBzGoVWcdzMz+KVmdjP6yZ3s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WEZz48iN587POtt2CxflQq/O3PAp353Yvnew31OPJ2Y4cq2F7cqMVr7ql3BPOzSUAhagjZPoKBwkbMNP8Bj1rotVVv4EN9eP9lVRhUdPi7QELmPVr3j2obf0GXOT0Qg+I+tA6Phyj04/mHyhiFapLzSRHRp+hLK+cyB4pib2JsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RyAGON0j; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718820997; x=1750356997;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/0UkGO1fDhL58FqhPy5MBzGoVWcdzMz+KVmdjP6yZ3s=;
  b=RyAGON0jVpI1UD2wwYXHNm6h7X7zUToOKYF/t273Q8iKn8bOjPI2k73Q
   2Ckqx7lGgjPQpP+3PMkZtHelZJaq2KMCJKyFYCti1YrkXBBB5vXJkztUx
   cE5SCyFsBitrmSf78rg9Q4sqNb+jUf/Ri77kEUz0OhKnrbOkQG3+L38+e
   DrTBHzPYhhpmv2Te1OYijcxqXI5inzpjAQb7L8J5mGBsWsULBb/tff24X
   2tK/unvKFXzzHWj3sv5U+UX6YeuwUndOEQ8WS9VFJaSHT8KXcimlfG1/6
   Jo5RX2tgT/2EFX6j+rgpqQRW4Z/k0zJftQHirqrwNqgTijppKMmAYVDzt
   g==;
X-CSE-ConnectionGUID: Yb54f1OrRpiCiJZGYWjJxQ==
X-CSE-MsgGUID: pEf6qsT2RYSGChGwn9YMMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="27194612"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="27194612"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 11:16:36 -0700
X-CSE-ConnectionGUID: bhTo8qKATsmP3dVeqCCbRA==
X-CSE-MsgGUID: mGO2nLsNRuadhYiexVaXkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46365036"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Jun 2024 11:16:34 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sJzrE-0006rK-0m;
	Wed, 19 Jun 2024 18:16:32 +0000
Date: Thu, 20 Jun 2024 02:15:35 +0800
From: kernel test robot <lkp@intel.com>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: include/uapi/linux/bits.h:9:19: warning: right shift count >= width
 of type
Message-ID: <202406200209.graMn6T6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e5b3efbe1ab1793bb49ae07d56d0973267e65112
commit: 300ce44cbe2924aa83330fc5f24e035665f51b03 Merge patch series "Rework & improve riscv cmpxchg.h and atomic.h"
date:   7 weeks ago
config: riscv-randconfig-r042-20230811 (https://download.01.org/0day-ci/archive/20240620/202406200209.graMn6T6-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240620/202406200209.graMn6T6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406200209.graMn6T6-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/bitops.h:19,
                    from include/linux/bitops.h:68,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
   include/asm-generic/bitops/__ffs.h: In function 'generic___ffs':
   include/asm-generic/bitops/__ffs.h:20:22: warning: right shift count >= width of type [-Wshift-count-overflow]
      20 |                 word >>= 32;
         |                      ^~~
   In file included from arch/riscv/include/asm/bitops.h:20:
   include/asm-generic/bitops/__fls.h: In function 'generic___fls':
   include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      18 |         if (!(word & (~0ul << 32))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
      20 |                 word <<= 32;
         |                      ^~~
   include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
         |                            ^~
   In file included from arch/riscv/include/asm/bitops.h:19,
                    from include/linux/bitops.h:68,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/asm-generic/bitops/__ffs.h: In function 'generic___ffs':
   include/asm-generic/bitops/__ffs.h:20:22: warning: right shift count >= width of type [-Wshift-count-overflow]
      20 |                 word >>= 32;
         |                      ^~~
   In file included from arch/riscv/include/asm/bitops.h:20:
   include/asm-generic/bitops/__fls.h: In function 'generic___fls':
   include/asm-generic/bitops/__fls.h:18:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      18 |         if (!(word & (~0ul << 32))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:20:22: warning: left shift count >= width of type [-Wshift-count-overflow]
      20 |                 word <<= 32;
         |                      ^~~
   include/asm-generic/bitops/__fls.h:23:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      23 |         if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:27:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      27 |         if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:31:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      31 |         if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:35:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
         |                            ^~
   include/asm-generic/bitops/__fls.h:39:28: warning: left shift count >= width of type [-Wshift-count-overflow]
      39 |         if (!(word & (~0ul << (BITS_PER_LONG-1))))
         |                            ^~
   In file included from include/linux/atomic.h:7,
                    from include/linux/cpumask.h:14,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:63:
   arch/riscv/include/asm/atomic.h: At top level:
   arch/riscv/include/asm/atomic.h:15:4: error: #error "64-bit atomics require XLEN to be at least 64"
      15 | #  error "64-bit atomics require XLEN to be at least 64"
         |    ^~~~~
   In file included from include/linux/bits.h:7,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:6:
   include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic64_xchg':
>> include/uapi/linux/bits.h:9:19: warning: right shift count >= width of type [-Wshift-count-overflow]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:17:24: note: in expansion of macro 'GENMASK'
      17 |         ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)   \
         |                        ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:58:17: note: in expansion of macro '__arch_xchg_masked'
      58 |                 __arch_xchg_masked(prepend, append,                     \
         |                 ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:85:9: note: in expansion of macro '_arch_xchg'
      85 |         _arch_xchg(ptr, x, ".aqrl", "", "")
         |         ^~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:12:18: note: in expansion of macro 'arch_xchg'
      12 | #define raw_xchg arch_xchg
         |                  ^~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:4047:16: note: in expansion of macro 'raw_xchg'
    4047 |         return raw_xchg(&v->counter, new);
         |                ^~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic64_xchg_acquire':
>> include/uapi/linux/bits.h:9:19: warning: right shift count >= width of type [-Wshift-count-overflow]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:17:24: note: in expansion of macro 'GENMASK'
      17 |         ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)   \
         |                        ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:58:17: note: in expansion of macro '__arch_xchg_masked'
      58 |                 __arch_xchg_masked(prepend, append,                     \
         |                 ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:79:9: note: in expansion of macro '_arch_xchg'
      79 |         _arch_xchg(ptr, x, "", "", RISCV_ACQUIRE_BARRIER)
         |         ^~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:22:26: note: in expansion of macro 'arch_xchg_acquire'
      22 | #define raw_xchg_acquire arch_xchg_acquire
         |                          ^~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:4074:16: note: in expansion of macro 'raw_xchg_acquire'
    4074 |         return raw_xchg_acquire(&v->counter, new);
         |                ^~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic64_xchg_release':
>> include/uapi/linux/bits.h:9:19: warning: right shift count >= width of type [-Wshift-count-overflow]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:17:24: note: in expansion of macro 'GENMASK'
      17 |         ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)   \
         |                        ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:58:17: note: in expansion of macro '__arch_xchg_masked'
      58 |                 __arch_xchg_masked(prepend, append,                     \
         |                 ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:82:9: note: in expansion of macro '_arch_xchg'
      82 |         _arch_xchg(ptr, x, "", RISCV_RELEASE_BARRIER, "")
         |         ^~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:34:26: note: in expansion of macro 'arch_xchg_release'
      34 | #define raw_xchg_release arch_xchg_release
         |                          ^~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:4100:16: note: in expansion of macro 'raw_xchg_release'
    4100 |         return raw_xchg_release(&v->counter, new);
         |                ^~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic64_xchg_relaxed':
>> include/uapi/linux/bits.h:9:19: warning: right shift count >= width of type [-Wshift-count-overflow]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:17:24: note: in expansion of macro 'GENMASK'
      17 |         ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)   \
         |                        ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:58:17: note: in expansion of macro '__arch_xchg_masked'
      58 |                 __arch_xchg_masked(prepend, append,                     \
         |                 ^~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:76:9: note: in expansion of macro '_arch_xchg'
      76 |         _arch_xchg(ptr, x, "", "", "")
         |         ^~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:46:26: note: in expansion of macro 'arch_xchg_relaxed'
      46 | #define raw_xchg_relaxed arch_xchg_relaxed
         |                          ^~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:4123:16: note: in expansion of macro 'raw_xchg_relaxed'
    4123 |         return raw_xchg_relaxed(&v->counter, new);
         |                ^~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic64_cmpxchg':
>> include/uapi/linux/bits.h:9:19: warning: right shift count >= width of type [-Wshift-count-overflow]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:109:24: note: in expansion of macro 'GENMASK'
     109 |         ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)   \
         |                        ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:162:17: note: in expansion of macro '__arch_cmpxchg_masked'
     162 |                 __arch_cmpxchg_masked(sc_sfx, prepend, append,          \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:189:9: note: in expansion of macro '_arch_cmpxchg'
     189 |         _arch_cmpxchg((ptr), (o), (n), ".rl", "", "     fence rw, rw\n")
         |         ^~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: in expansion of macro 'arch_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:4152:16: note: in expansion of macro 'raw_cmpxchg'
    4152 |         return raw_cmpxchg(&v->counter, old, new);
         |                ^~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic64_cmpxchg_acquire':
>> include/uapi/linux/bits.h:9:19: warning: right shift count >= width of type [-Wshift-count-overflow]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:109:24: note: in expansion of macro 'GENMASK'
     109 |         ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)   \
         |                        ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:162:17: note: in expansion of macro '__arch_cmpxchg_masked'
     162 |                 __arch_cmpxchg_masked(sc_sfx, prepend, append,          \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:183:9: note: in expansion of macro '_arch_cmpxchg'
     183 |         _arch_cmpxchg((ptr), (o), (n), "", "", RISCV_ACQUIRE_BARRIER)
         |         ^~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:65:29: note: in expansion of macro 'arch_cmpxchg_acquire'
      65 | #define raw_cmpxchg_acquire arch_cmpxchg_acquire
         |                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:4181:16: note: in expansion of macro 'raw_cmpxchg_acquire'
    4181 |         return raw_cmpxchg_acquire(&v->counter, old, new);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic64_cmpxchg_release':
>> include/uapi/linux/bits.h:9:19: warning: right shift count >= width of type [-Wshift-count-overflow]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:109:24: note: in expansion of macro 'GENMASK'
     109 |         ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)   \
         |                        ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:162:17: note: in expansion of macro '__arch_cmpxchg_masked'
     162 |                 __arch_cmpxchg_masked(sc_sfx, prepend, append,          \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:186:9: note: in expansion of macro '_arch_cmpxchg'
     186 |         _arch_cmpxchg((ptr), (o), (n), "", RISCV_RELEASE_BARRIER, "")
         |         ^~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:77:29: note: in expansion of macro 'arch_cmpxchg_release'
      77 | #define raw_cmpxchg_release arch_cmpxchg_release
         |                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:4209:16: note: in expansion of macro 'raw_cmpxchg_release'
    4209 |         return raw_cmpxchg_release(&v->counter, old, new);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic64_cmpxchg_relaxed':
>> include/uapi/linux/bits.h:9:19: warning: right shift count >= width of type [-Wshift-count-overflow]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:109:24: note: in expansion of macro 'GENMASK'
     109 |         ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)   \
         |                        ^~~~~~~
   arch/riscv/include/asm/cmpxchg.h:162:17: note: in expansion of macro '__arch_cmpxchg_masked'
     162 |                 __arch_cmpxchg_masked(sc_sfx, prepend, append,          \
         |                 ^~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/cmpxchg.h:180:9: note: in expansion of macro '_arch_cmpxchg'
     180 |         _arch_cmpxchg((ptr), (o), (n), "", "", "")
         |         ^~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:89:29: note: in expansion of macro 'arch_cmpxchg_relaxed'
      89 | #define raw_cmpxchg_relaxed arch_cmpxchg_relaxed
         |                             ^~~~~~~~~~~~~~~~~~~~
   include/linux/atomic/atomic-arch-fallback.h:4234:16: note: in expansion of macro 'raw_cmpxchg_relaxed'
    4234 |         return raw_cmpxchg_relaxed(&v->counter, old, new);
         |                ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/cpumask.h:13:
   include/linux/cpumask.h: In function 'cpumask_setall':
   include/linux/bitmap.h:223:44: warning: right shift count >= width of type [-Wshift-count-overflow]
     223 | #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
         |                                            ^~
   include/linux/cpumask.h:543:41: note: in expansion of macro 'BITMAP_LAST_WORD_MASK'
     543 |                 cpumask_bits(dstp)[0] = BITMAP_LAST_WORD_MASK(nr_cpumask_bits);
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:89,
                    from <command-line>:
   include/linux/smp.h: At top level:
   include/linux/smp.h:34:33: error: requested alignment '20' is not a positive power of 2
      34 |         __aligned(sizeof(struct __call_single_data));
         |                                 ^~~~~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:33:68: note: in definition of macro '__aligned'
      33 | #define __aligned(x)                    __attribute__((__aligned__(x)))
         |                                                                    ^
   In file included from include/linux/init.h:5,
                    from include/linux/printk.h:6:
   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, lru) == offsetof(struct folio, lru)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:386:9: note: in expansion of macro 'static_assert'
     386 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |         ^~~~~~~~~~~~~
   include/linux/mm_types.h:388:1: note: in expansion of macro 'FOLIO_MATCH'
     388 | FOLIO_MATCH(lru, lru);
         | ^~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, mapping) == offsetof(struct folio, mapping)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:386:9: note: in expansion of macro 'static_assert'
     386 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |         ^~~~~~~~~~~~~
   include/linux/mm_types.h:389:1: note: in expansion of macro 'FOLIO_MATCH'
     389 | FOLIO_MATCH(mapping, mapping);
         | ^~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, compound_head) == offsetof(struct folio, lru)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:386:9: note: in expansion of macro 'static_assert'
     386 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |         ^~~~~~~~~~~~~
   include/linux/mm_types.h:390:1: note: in expansion of macro 'FOLIO_MATCH'
     390 | FOLIO_MATCH(compound_head, lru);
         | ^~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, index) == offsetof(struct folio, index)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:386:9: note: in expansion of macro 'static_assert'
     386 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |         ^~~~~~~~~~~~~
   include/linux/mm_types.h:391:1: note: in expansion of macro 'FOLIO_MATCH'
     391 | FOLIO_MATCH(index, index);
         | ^~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, private) == offsetof(struct folio, private)"
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                         ^~~~~~~~~~~~~~
   include/linux/build_bug.h:77:34: note: in expansion of macro '__static_assert'
      77 | #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
         |                                  ^~~~~~~~~~~~~~~
   include/linux/mm_types.h:386:9: note: in expansion of macro 'static_assert'
     386 |         static_assert(offsetof(struct page, pg) == offsetof(struct folio, fl))
         |         ^~~~~~~~~~~~~
   include/linux/mm_types.h:392:1: note: in expansion of macro 'FOLIO_MATCH'
     392 | FOLIO_MATCH(private, private);
         | ^~~~~~~~~~~
   include/linux/build_bug.h:78:41: error: static assertion failed: "offsetof(struct page, _mapcount) == offsetof(struct folio, _mapcount)"


vim +9 include/uapi/linux/bits.h

3c7a8e190bc580 Paolo Bonzini 2023-12-12   6  
3c7a8e190bc580 Paolo Bonzini 2023-12-12   7  #define __GENMASK(h, l) \
3c7a8e190bc580 Paolo Bonzini 2023-12-12   8          (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
3c7a8e190bc580 Paolo Bonzini 2023-12-12  @9           (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
3c7a8e190bc580 Paolo Bonzini 2023-12-12  10  

:::::: The code at line 9 was first introduced by commit
:::::: 3c7a8e190bc580813ddd9259f62971c8d2a6b5ad uapi: introduce uapi-friendly macros for GENMASK

:::::: TO: Paolo Bonzini <pbonzini@redhat.com>
:::::: CC: Paolo Bonzini <pbonzini@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


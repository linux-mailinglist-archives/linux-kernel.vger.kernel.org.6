Return-Path: <linux-kernel+bounces-527991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2670A4122D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4345B3AB297
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 23:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0358204C26;
	Sun, 23 Feb 2025 23:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GH+/GYpV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35FB1C863A
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 23:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740352188; cv=none; b=lEgH9oeV9wKWazegh8yog8OfXROm9ZKp4uB7c2sAUn6Kc5NtlxQyv5/2yQ/MnYJopsxjhnA5fcLE1BHWfjJP0ydEwibELm9WSmsJyLwuym7/YdQm5VLVY/c3TbapEwIte1soSrYNrrtOSITItQTxsJDtgwyTwWnNhXyEtuEYnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740352188; c=relaxed/simple;
	bh=/etoAdx0C4MyBW5FOEp4CL7fGOnAi3a+SCK47+Omde8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHgz1UnXYzPhhgJSgrIxNLvrTqc4Vubl5q1znM7tTJv49ypv0nmuxEOG0TWqMRu/L7XuqaExThGqbKyTDQyGMSN+JV+PipVhPHQRLs2ZBuIHrEI2co7muEiQ2lP9xFaWcanUkplTSWm7fpfRVeahcYDjWQSOeQCv5Q6WqQJg+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GH+/GYpV; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740352187; x=1771888187;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/etoAdx0C4MyBW5FOEp4CL7fGOnAi3a+SCK47+Omde8=;
  b=GH+/GYpVVg4AFVaRHJQ9rNw/I0VH7LzC5e6AUjGFFiWa7Ef6bGhamlOC
   5PHLiHIUam3pQ2l7Va/EgbM1aFcJaxiZ5e7RDtzRon8cEHQOIJoxIHkTX
   mJTP6DJXk+G6RdA9brQORyyWw36f//EWHDRPTi1VmbmA1bmT1odltOz8f
   n6Dno5+XyeXfGbwHPG+XbnLNVDfKjauYOnoeNthWz4EaEhzC2Tb6+F4ad
   4jlwjiXuPojyXfZQ6ni9EPFDwybhSxrapl9fXhojsV8RhrnCXnhQ647ui
   4SH8Rubxr2gSOP/gfaaEKEm9h+SRzWHz4aUw7Lw2a68O2DXy4qRADCxwc
   A==;
X-CSE-ConnectionGUID: XeEDiCz9SMuF2pQZoFMMVg==
X-CSE-MsgGUID: JNja1g2eSJGFnC5vm5rr+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="41362409"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="41362409"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 15:09:46 -0800
X-CSE-ConnectionGUID: tpxN0n8yTtOpkyhKwvobMQ==
X-CSE-MsgGUID: NWgQYDqbQeyrjWwteCCA6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116377073"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 23 Feb 2025 15:09:41 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tmL6Q-0007eV-2a;
	Sun, 23 Feb 2025 23:09:38 +0000
Date: Mon, 24 Feb 2025 07:08:49 +0800
From: kernel test robot <lkp@intel.com>
To: Rik van Riel <riel@surriel.com>, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	bp@alien8.de, peterz@infradead.org, dave.hansen@linux.intel.com,
	zhengqi.arch@bytedance.com, nadav.amit@gmail.com,
	thomas.lendacky@amd.com, kernel-team@meta.com, linux-mm@kvack.org,
	akpm@linux-foundation.org, jackmanb@google.com, jannh@google.com,
	mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org,
	Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v13 08/14] x86/mm: global ASID context switch & TLB flush
 handling
Message-ID: <202502240650.kzshiji7-lkp@intel.com>
References: <20250223194943.3518952-9-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223194943.3518952-9-riel@surriel.com>

Hi Rik,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/x86/mm tip/master linus/master v6.14-rc4 next-20250221]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rik-van-Riel/x86-mm-consolidate-full-flush-threshold-decision/20250224-035335
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20250223194943.3518952-9-riel%40surriel.com
patch subject: [PATCH v13 08/14] x86/mm: global ASID context switch & TLB flush handling
config: x86_64-buildonly-randconfig-004-20250224 (https://download.01.org/0day-ci/archive/20250224/202502240650.kzshiji7-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250224/202502240650.kzshiji7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502240650.kzshiji7-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   arch/x86/include/asm/tlbflush.h: In function 'in_asid_transition':
>> arch/x86/include/asm/tlbflush.h:253:43: error: 'mm_context_t' has no member named 'asid_transition'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                                           ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/tlbflush.h:253:22: note: in expansion of macro 'READ_ONCE'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                      ^~~~~~~~~
>> arch/x86/include/asm/tlbflush.h:253:43: error: 'mm_context_t' has no member named 'asid_transition'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                                           ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/tlbflush.h:253:22: note: in expansion of macro 'READ_ONCE'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                      ^~~~~~~~~
>> arch/x86/include/asm/tlbflush.h:253:43: error: 'mm_context_t' has no member named 'asid_transition'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                                           ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/tlbflush.h:253:22: note: in expansion of macro 'READ_ONCE'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                      ^~~~~~~~~
>> arch/x86/include/asm/tlbflush.h:253:43: error: 'mm_context_t' has no member named 'asid_transition'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                                           ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/tlbflush.h:253:22: note: in expansion of macro 'READ_ONCE'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                      ^~~~~~~~~
>> arch/x86/include/asm/tlbflush.h:253:43: error: 'mm_context_t' has no member named 'asid_transition'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                                           ^
   include/linux/compiler_types.h:522:23: note: in definition of macro '__compiletime_assert'
     522 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:542:9: note: in expansion of macro '_compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/tlbflush.h:253:22: note: in expansion of macro 'READ_ONCE'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                      ^~~~~~~~~
>> arch/x86/include/asm/tlbflush.h:253:43: error: 'mm_context_t' has no member named 'asid_transition'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                                           ^
   include/linux/compiler_types.h:498:27: note: in definition of macro '__unqual_scalar_typeof'
     498 |                 _Generic((x),                                           \
         |                           ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   arch/x86/include/asm/tlbflush.h:253:22: note: in expansion of macro 'READ_ONCE'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                      ^~~~~~~~~
   In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:354,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/swait.h:5,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
>> arch/x86/include/asm/tlbflush.h:253:43: error: 'mm_context_t' has no member named 'asid_transition'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                                           ^
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   arch/x86/include/asm/tlbflush.h:253:22: note: in expansion of macro 'READ_ONCE'
     253 |         return mm && READ_ONCE(mm->context.asid_transition);
         |                      ^~~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: arch/x86/kernel/asm-offsets.s] Error 1 shuffle=3847572294
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1264: prepare0] Error 2 shuffle=3847572294
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=3847572294
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=3847572294
   make: Target 'prepare' not remade because of errors.


vim +253 arch/x86/include/asm/tlbflush.h

   247	
   248	static inline bool in_asid_transition(struct mm_struct *mm)
   249	{
   250		if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
   251			return false;
   252	
 > 253		return mm && READ_ONCE(mm->context.asid_transition);
   254	}
   255	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


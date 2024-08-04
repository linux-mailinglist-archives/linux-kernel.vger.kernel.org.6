Return-Path: <linux-kernel+bounces-273836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0D7946EB6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636431C20E4D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755E532C85;
	Sun,  4 Aug 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGQTC/We"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F292E64B
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774938; cv=none; b=tOhz/phddOpon2d+wAkOgFzBg8Hp/ALrv1wNdwViTDKuNFTB7QRI4DvZLM3Rh/rjg4Y6vF9Z69WgeP1CXxw9oj+ZYOJb84FftdX87/viwfIqNLR2e4hKjw0/V0BHvMoeiYuGpypKCAMW6ZaoBmtogBtG/2qprUJvM9Ca4BV6fM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774938; c=relaxed/simple;
	bh=jjKV0xLuptdposzI9dpa1FGLCMj36AteT2gwHbav3fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhKGzwNjUr8J8x0pZIbIsNJX++RBNFL45yOiWU4n4VqOL7z/810XbCQFAotHZGUCvmYtWThlGEfEw8rA5uPHVyakf3Thl8bIrn6FGldXoN4vhnNzFrH+PMX6Wrkwa8ycYO0mYyncrlEviQHz/Al5AJdHO6lGl4KzOb/bus7JIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGQTC/We; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722774937; x=1754310937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jjKV0xLuptdposzI9dpa1FGLCMj36AteT2gwHbav3fY=;
  b=YGQTC/Wefk4GbnXP2AGiK2a6WIVJsDIrMsq68Nmrr+JJwy2hALJY4LNm
   Q5UTqbabk6LBG3xL8NbwoG3rh66Hhqwqy/0Sw/O7P02HeUXmOmefi25oO
   SxwNwnQirkQ4ibLDY6sbByhmx0VyPAZoOZwfkHYDA9LcG45d4YWCKgQt6
   UQP1+YmmfVKxLLzw3hnJeMbBdVzfKFLKoRQVikfcLBBbombDVroJCcXYT
   PwHcRnF0uZxTUJI7ErZpfBFhN++Ht1TZvX18N8+a3+/lmW9sLqa0erM9x
   ojNgE6PzHoCjtIa2h6PJoJh3tnmlBeFpW74pUqSpzLfCVw+w4+iQX4P6D
   w==;
X-CSE-ConnectionGUID: 2cU3BfEVQU64i8HpBA4LEQ==
X-CSE-MsgGUID: jtkusFnjQbamok6HukSykQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31893929"
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="31893929"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 05:35:36 -0700
X-CSE-ConnectionGUID: hjv/Q4J5TVuFOf+Wd6GovQ==
X-CSE-MsgGUID: QMhMauHCSNWfhFi3dBH+ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,262,1716274800"; 
   d="scan'208";a="86465817"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 04 Aug 2024 05:35:33 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1saaSR-0001RA-0w;
	Sun, 04 Aug 2024 12:35:31 +0000
Date: Sun, 4 Aug 2024 20:35:06 +0800
From: kernel test robot <lkp@intel.com>
To: Arnd Bergmann <arnd@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: oe-kbuild-all@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: move sun3 into a top-level platform option
Message-ID: <202408041920.ZhM3RsXp-lkp@intel.com>
References: <20240803140115.3305547-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803140115.3305547-1-arnd@kernel.org>

Hi Arnd,

kernel test robot noticed the following build errors:

[auto build test ERROR on geert-m68k/for-next]
[also build test ERROR on geert-m68k/for-linus soc/for-next gerg-m68knommu/for-next linus/master v6.11-rc1 next-20240802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arnd-Bergmann/m68k-move-sun3-into-a-top-level-platform-option/20240804-001711
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git for-next
patch link:    https://lore.kernel.org/r/20240803140115.3305547-1-arnd%40kernel.org
patch subject: [PATCH] m68k: move sun3 into a top-level platform option
config: m68k-randconfig-r121-20240804 (https://download.01.org/0day-ci/archive/20240804/202408041920.ZhM3RsXp-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce: (https://download.01.org/0day-ci/archive/20240804/202408041920.ZhM3RsXp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408041920.ZhM3RsXp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:15,
                    from include/linux/cpumask.h:11,
                    from include/linux/alloc_tag.h:13,
                    from include/linux/percpu.h:5,
                    from include/linux/arch_topology.h:9,
                    from include/linux/topology.h:30,
                    from include/linux/gfp.h:8,
                    from include/linux/slab.h:16,
                    from arch/m68k/include/asm/pgtable_no.h:11,
                    from arch/m68k/include/asm/pgtable.h:8,
                    from include/linux/pgtable.h:6,
                    from arch/m68k/kernel/head.S:254:
   include/linux/align.h:8:9: warning: "ALIGN" redefined
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |         ^~~~~
   In file included from arch/m68k/kernel/head.S:252:
   include/linux/linkage.h:103:9: note: this is the location of the previous definition
     103 | #define ALIGN __ALIGN
         |         ^~~~~
   In file included from include/linux/panic.h:5,
                    from include/linux/kernel.h:30:
   include/linux/compiler_attributes.h:55:9: warning: "__always_inline" redefined
      55 | #define __always_inline                 inline __attribute__((__always_inline__))
         |         ^~~~~~~~~~~~~~~
   In file included from include/linux/stddef.h:5,
                    from include/linux/container_of.h:6,
                    from include/linux/alloc_tag.h:10:
   include/uapi/linux/stddef.h:8:9: note: this is the location of the previous definition
       8 | #define __always_inline inline
         |         ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:91:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
      91 | #if __has_attribute(__copy__)
         |     ^~~~~~~~~~~~~~~
>> include/linux/compiler_attributes.h:91:20: error: missing binary operator before token "("
      91 | #if __has_attribute(__copy__)
         |                    ^
   include/linux/compiler_attributes.h:104:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     104 | #if __has_attribute(__counted_by__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:104:20: error: missing binary operator before token "("
     104 | #if __has_attribute(__counted_by__)
         |                    ^
   include/linux/compiler_attributes.h:107:10: warning: "__counted_by" redefined
     107 | # define __counted_by(member)
         |          ^~~~~~~~~~~~
   include/uapi/linux/stddef.h:55:9: note: this is the location of the previous definition
      55 | #define __counted_by(m)
         |         ^~~~~~~~~~~~
   include/linux/compiler_attributes.h:116:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     116 | #if __has_attribute(__diagnose_as_builtin__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:116:20: error: missing binary operator before token "("
     116 | #if __has_attribute(__diagnose_as_builtin__)
         |                    ^
   include/linux/compiler_attributes.h:139:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     139 | #if __has_attribute(__designated_init__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:139:20: error: missing binary operator before token "("
     139 | #if __has_attribute(__designated_init__)
         |                    ^
   include/linux/compiler_attributes.h:150:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     150 | #if __has_attribute(__error__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:150:20: error: missing binary operator before token "("
     150 | #if __has_attribute(__error__)
         |                    ^
   include/linux/compiler_attributes.h:161:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     161 | #if __has_attribute(__externally_visible__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:161:20: error: missing binary operator before token "("
     161 | #if __has_attribute(__externally_visible__)
         |                    ^
   include/linux/compiler_attributes.h:198:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     198 | #if __has_attribute(__no_caller_saved_registers__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:198:20: error: missing binary operator before token "("
     198 | #if __has_attribute(__no_caller_saved_registers__)
         |                    ^
   include/linux/compiler_attributes.h:209:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     209 | #if __has_attribute(__noclone__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:209:20: error: missing binary operator before token "("
     209 | #if __has_attribute(__noclone__)
         |                    ^
   include/linux/compiler_attributes.h:226:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     226 | #if __has_attribute(__fallthrough__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:226:20: error: missing binary operator before token "("
     226 | #if __has_attribute(__fallthrough__)
         |                    ^
   include/linux/compiler_attributes.h:252:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     252 | #if __has_attribute(__nonstring__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:252:20: error: missing binary operator before token "("
     252 | #if __has_attribute(__nonstring__)
         |                    ^
   include/linux/compiler_attributes.h:264:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     264 | #if __has_attribute(__no_profile_instrument_function__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:264:20: error: missing binary operator before token "("
     264 | #if __has_attribute(__no_profile_instrument_function__)
         |                    ^
   include/linux/compiler_attributes.h:283:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     283 | #if __has_attribute(__no_stack_protector__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:283:20: error: missing binary operator before token "("
     283 | #if __has_attribute(__no_stack_protector__)
         |                    ^
   include/linux/compiler_attributes.h:294:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     294 | #if __has_attribute(__overloadable__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:294:20: error: missing binary operator before token "("
     294 | #if __has_attribute(__overloadable__)
         |                    ^
   include/linux/compiler_attributes.h:313:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     313 | #if __has_attribute(__pass_dynamic_object_size__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:313:20: error: missing binary operator before token "("
     313 | #if __has_attribute(__pass_dynamic_object_size__)
         |                    ^
   include/linux/compiler_attributes.h:318:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     318 | #if __has_attribute(__pass_object_size__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:318:20: error: missing binary operator before token "("
     318 | #if __has_attribute(__pass_object_size__)
         |                    ^
   include/linux/compiler_attributes.h:342:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     342 | #if __has_attribute(__uninitialized__)
         |     ^~~~~~~~~~~~~~~
   include/linux/compiler_attributes.h:342:20: error: missing binary operator before token "("
     342 | #if __has_attribute(__uninitialized__)
         |                    ^
   include/linux/compiler_attributes.h:388:5: warning: "__has_attribute" is not defined, evaluates to 0 [-Wundef]
     388 | #if __has_attribute(__warning__)


vim +91 include/linux/compiler_attributes.h

a3f8a30f3f0079 Miguel Ojeda 2018-08-30  84  
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  85  /*
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  86   * Optional: only supported since gcc >= 9
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  87   * Optional: not supported by clang
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  88   *
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  89   *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-copy-function-attribute
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  90   */
c0d9782f5b6d71 Miguel Ojeda 2019-02-08 @91  #if __has_attribute(__copy__)
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  92  # define __copy(symbol)                 __attribute__((__copy__(symbol)))
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  93  #else
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  94  # define __copy(symbol)
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  95  #endif
c0d9782f5b6d71 Miguel Ojeda 2019-02-08  96  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


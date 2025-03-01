Return-Path: <linux-kernel+bounces-540069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 760D0A4AD39
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD2716A89F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84A61E32B7;
	Sat,  1 Mar 2025 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QwKemzkL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B891DE3CA;
	Sat,  1 Mar 2025 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740852496; cv=none; b=DViE6/F6Fbft47wRyuUbOky6Ile/TDG0z3LugBwAGtck4fOgVj/KaVVRas9DLN9DhqcWgMOIwKE+8SpG6nnZOkljjGnFVLMeoxAGga15SIqYtIGuvdFj2yfc1FidFzZXXm/OU/ZI/JPoL8JggVGIXHhJx42GxsanWnYMXvmG7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740852496; c=relaxed/simple;
	bh=PiX1wu8b+6I7R3c0MeOnoxbnQpJhEI+8sVFbihVVVZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAPYRRyQ0XrqOwVY5FpwHXmNysXklC96L/m2U+RZcH/IbiMubTz5OzCWJt5Aa9h0MI5pe7TQ0yKl7hE12VE7+D6mD3Xv87eZxF85LbG/0Kjv2L4paGt6HyiKKrG6/BJlWe3Bqi7SR4hsotnIpk24yKi6cH3c26UHVny7BQXDSUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QwKemzkL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740852495; x=1772388495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PiX1wu8b+6I7R3c0MeOnoxbnQpJhEI+8sVFbihVVVZs=;
  b=QwKemzkL5hSTgZSq2j0V0w4OxBJlkb/1Jyrid2AlW5APQf+GtY7TFJvy
   JOHO6Pmmz95moqwSdkQV/xIPqb3EMmmUwhEe2wKg4XItv3rpkYLz38mFS
   uQBt15mdA8CG46dCdRcvwhzoKRz84FNrdIVPfEC00lL6vl6CBRIBUbOzz
   B8U0TJAX9mr14dV7p0shfVtDCd2HQiUJeDtLsEdVPqrs+LY9x1C4FgdAr
   k+OCD3tP+QjG3J7nznUkVolfUua0a+qcUXrAJl6xnh4WgQodmns7clz3D
   o7hO0gYDEnlk2bAr6U7XJGUfe6Ove7WCgxEez8/F/gEy0mVCbmfZnjYdX
   A==;
X-CSE-ConnectionGUID: 1IdvARrPQ+iEzVfdT1r79w==
X-CSE-MsgGUID: n/pFArFKQoaM8nOXciLfMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="59179223"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="59179223"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 10:08:14 -0800
X-CSE-ConnectionGUID: 1XS6H88mTiK5hbuSJhngvA==
X-CSE-MsgGUID: dbBruqprRpacg8LqLQgG9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="117404407"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 01 Mar 2025 10:08:09 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toRFu-000GXg-2a;
	Sat, 01 Mar 2025 18:08:06 +0000
Date: Sun, 2 Mar 2025 02:07:52 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Garg <gargaditya08@live.com>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"apw@canonical.com" <apw@canonical.com>,
	"joe@perches.com" <joe@perches.com>,
	"dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Asahi Linux Mailing List <asahi@lists.linux.dev>
Subject: Re: [PATCH v5] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Message-ID: <202503020112.24wZ1Wcs-lkp@intel.com>
References: <2C9622E6-A2DB-4681-A971-604C79F9955E@live.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2C9622E6-A2DB-4681-A971-604C79F9955E@live.com>

Hi Aditya,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-nonmm-unstable]
[also build test ERROR on linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Garg/lib-vsprintf-Add-support-for-generic-FourCCs-by-extending-p4cc/20250301-003018
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/2C9622E6-A2DB-4681-A971-604C79F9955E%40live.com
patch subject: [PATCH v5] lib/vsprintf: Add support for generic FourCCs by extending %p4cc
config: arm-randconfig-004-20250301 (https://download.01.org/0day-ci/archive/20250302/202503020112.24wZ1Wcs-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 14170b16028c087ca154878f5ed93d3089a965c6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020112.24wZ1Wcs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020112.24wZ1Wcs-lkp@intel.com/

All errors (new ones prefixed by >>):

   lib/test_printf.c:802:17: warning: excess elements in scalar initializer [-Wexcess-initializers]
     802 |                 { 0x41424344, "ABCD (0x41424344)", },
         |                               ^~~~~~~~~~~~~~~~~~~
   lib/test_printf.c:805:17: warning: excess elements in scalar initializer [-Wexcess-initializers]
     805 |                 { 0x41424344, "DCBA (0x44434241)", },
         |                               ^~~~~~~~~~~~~~~~~~~
   lib/test_printf.c:808:30: warning: excess elements in scalar initializer [-Wexcess-initializers]
     808 |                 { le32_to_cpu(0x41424344), "ABCD (0x41424344)", },
         |                                            ^~~~~~~~~~~~~~~~~~~
   lib/test_printf.c:811:30: warning: excess elements in scalar initializer [-Wexcess-initializers]
     811 |                 { be32_to_cpu(0x41424344), "ABCD (0x41424344)", },
         |                                            ^~~~~~~~~~~~~~~~~~~
>> lib/test_printf.c:815:30: error: subscripted value is not an array, pointer, or vector
     815 |         fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:52: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                               ~~~~~^~
>> lib/test_printf.c:815:30: error: subscripted value is not an array, pointer, or vector
     815 |         fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:202:53: note: expanded from macro '__must_be_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
     203 |                                                         "must be array")
         |                                                         ~~~~~~~~~~~~~~~~
   include/linux/compiler.h:201:47: note: expanded from macro '__is_array'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^~
   include/linux/compiler_types.h:483:74: note: expanded from macro '__same_type'
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/compiler.h:197:79: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   lib/test_printf.c:816:30: error: subscripted value is not an array, pointer, or vector
     816 |         fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:52: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                               ~~~~~^~
   lib/test_printf.c:816:30: error: subscripted value is not an array, pointer, or vector
     816 |         fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:202:53: note: expanded from macro '__must_be_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
     203 |                                                         "must be array")
         |                                                         ~~~~~~~~~~~~~~~~
   include/linux/compiler.h:201:47: note: expanded from macro '__is_array'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^~
   include/linux/compiler_types.h:483:74: note: expanded from macro '__same_type'
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/compiler.h:197:79: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   lib/test_printf.c:817:30: error: subscripted value is not an array, pointer, or vector
     817 |         fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:52: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                               ~~~~~^~
   lib/test_printf.c:817:30: error: subscripted value is not an array, pointer, or vector
     817 |         fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:202:53: note: expanded from macro '__must_be_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
     203 |                                                         "must be array")
         |                                                         ~~~~~~~~~~~~~~~~
   include/linux/compiler.h:201:47: note: expanded from macro '__is_array'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^~
   include/linux/compiler_types.h:483:74: note: expanded from macro '__same_type'
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/compiler.h:197:79: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   lib/test_printf.c:818:30: error: subscripted value is not an array, pointer, or vector
     818 |         fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:52: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                               ~~~~~^~
   lib/test_printf.c:818:30: error: subscripted value is not an array, pointer, or vector
     818 |         fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:202:53: note: expanded from macro '__must_be_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
     203 |                                                         "must be array")
         |                                                         ~~~~~~~~~~~~~~~~
   include/linux/compiler.h:201:47: note: expanded from macro '__is_array'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^~
   include/linux/compiler_types.h:483:74: note: expanded from macro '__same_type'
     483 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                                                                          ^
   include/linux/compiler.h:197:79: note: expanded from macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   4 warnings and 8 errors generated.


vim +815 lib/test_printf.c

   792	
   793	static void __init fourcc_pointer(void)
   794	{
   795		static const struct fourcc_struct try_cc[] = {
   796			{ 0x3231564e, "NV12 little-endian (0x3231564e)", },
   797			{ 0xb231564e, "NV12 big-endian (0xb231564e)", },
   798			{ 0x10111213, ".... little-endian (0x10111213)", },
   799			{ 0x20303159, "Y10  little-endian (0x20303159)", },
   800		};
   801		static const struct fourcc_struct try_ch = {
   802			{ 0x41424344, "ABCD (0x41424344)", },
   803		};
   804		static const struct fourcc_struct try_cn = {
   805			{ 0x41424344, "DCBA (0x44434241)", },
   806		};
   807		static const struct fourcc_struct try_cl = {
   808			{ le32_to_cpu(0x41424344), "ABCD (0x41424344)", },
   809		};
   810		static const struct fourcc_struct try_cb = {
   811			{ be32_to_cpu(0x41424344), "ABCD (0x41424344)", },
   812		};
   813	
   814		fourcc_pointer_test(try_cc, ARRAY_SIZE(try_cc), "%p4cc");
 > 815		fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
   816		fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
   817		fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
   818		fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
   819	}
   820	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


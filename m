Return-Path: <linux-kernel+bounces-540060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B61A4AD20
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFA51708C1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499361E570D;
	Sat,  1 Mar 2025 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvTqq/72"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167BF8F7D;
	Sat,  1 Mar 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740850583; cv=none; b=HVLTjDG34U4husWeWUtdZgXNs8uEun9I041uxXZkb22iVva0TbshaCduYApf5QQ1ZZ9RJFDIeKjkcRG58kRCyMGFg/ilVBCOlWnk5DvoKhEJ/UprhyJ2PMLh0BWFY7gIbE7vw1BAVJTwiLeZAPBnyl241fj3/nJNxmgtmIYaVwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740850583; c=relaxed/simple;
	bh=oIdagQIpwhkmdGuXgy1GsDqb6ilGQu3oH5QJWc0gBrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaPEzdLHSzI7jY7apbss/kRReU6+WeNe4Txy1Kphxr/gMy0nS+bpAVc1LE0aC7MB0RpUyl5OPzP403znCd1MDYVourxVcHSCEbs4mDNJyVZwKtfXxjrO/aNlWJu2yjO263T51GlecDe9U8/RpXW/5uJkesKvlylTymO6yvp1SeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvTqq/72; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740850581; x=1772386581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oIdagQIpwhkmdGuXgy1GsDqb6ilGQu3oH5QJWc0gBrA=;
  b=VvTqq/721YgICulg0C0KGkPtOzrEeqGiXJo/xSsqqENL0019rdp6E/wp
   du6m8Jh8DOG6S7AutHiwWo6N5I0ne8OpdmyxZV7wJQFj0BTFfmoc/8nNt
   7l1RYR8TQhhMnJlGDfIo57puJAJXl5lxGJyqJcNrRqDdMPUCfhyxIgVJs
   glsQNU7ez5i/S9e22pmZ++XchChB2AXDta/FiXH4pFs1fOvnox04SYjV/
   t1aK54J+YC2oaHlOF1xkm/H1lN2WcJK/Jw3q0tYzG/CtUDYe7+crhdFhq
   ksZoZGHVqJ8hxeJJ+/p56z0ycIYYkVYQ8gp6rmtz7vpvCvesQU8d54Yiw
   g==;
X-CSE-ConnectionGUID: CnVTMmz0TGuBk0G5mui+Fg==
X-CSE-MsgGUID: B3ZCMevtSOOQ+8Qlh2ta6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11360"; a="44582810"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="44582810"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 09:36:20 -0800
X-CSE-ConnectionGUID: o+w+vXi8TxKY+WZRFpz8kw==
X-CSE-MsgGUID: aj1Srs8VQdql4BUnb1nc/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117482624"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 01 Mar 2025 09:36:15 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toQl2-000GUs-06;
	Sat, 01 Mar 2025 17:36:12 +0000
Date: Sun, 2 Mar 2025 01:35:57 +0800
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
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Asahi Linux Mailing List <asahi@lists.linux.dev>
Subject: Re: [PATCH v5] lib/vsprintf: Add support for generic FourCCs by
 extending %p4cc
Message-ID: <202503020121.qsiw3acQ-lkp@intel.com>
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
config: arc-randconfig-001-20250301 (https://download.01.org/0day-ci/archive/20250302/202503020121.qsiw3acQ-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250302/202503020121.qsiw3acQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503020121.qsiw3acQ-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   lib/test_printf.c: In function 'fourcc_pointer':
>> lib/test_printf.c:802:17: warning: braces around scalar initializer
     802 |                 { 0x41424344, "ABCD (0x41424344)", },
         |                 ^
   lib/test_printf.c:802:17: note: (near initialization for 'try_ch.code')
>> lib/test_printf.c:802:31: warning: excess elements in scalar initializer
     802 |                 { 0x41424344, "ABCD (0x41424344)", },
         |                               ^~~~~~~~~~~~~~~~~~~
   lib/test_printf.c:802:31: note: (near initialization for 'try_ch.code')
   lib/test_printf.c:805:17: warning: braces around scalar initializer
     805 |                 { 0x41424344, "DCBA (0x44434241)", },
         |                 ^
   lib/test_printf.c:805:17: note: (near initialization for 'try_cn.code')
   lib/test_printf.c:805:31: warning: excess elements in scalar initializer
     805 |                 { 0x41424344, "DCBA (0x44434241)", },
         |                               ^~~~~~~~~~~~~~~~~~~
   lib/test_printf.c:805:31: note: (near initialization for 'try_cn.code')
   lib/test_printf.c:808:17: warning: braces around scalar initializer
     808 |                 { le32_to_cpu(0x41424344), "ABCD (0x41424344)", },
         |                 ^
   lib/test_printf.c:808:17: note: (near initialization for 'try_cl.code')
   lib/test_printf.c:808:44: warning: excess elements in scalar initializer
     808 |                 { le32_to_cpu(0x41424344), "ABCD (0x41424344)", },
         |                                            ^~~~~~~~~~~~~~~~~~~
   lib/test_printf.c:808:44: note: (near initialization for 'try_cl.code')
   lib/test_printf.c:811:17: warning: braces around scalar initializer
     811 |                 { be32_to_cpu(0x41424344), "ABCD (0x41424344)", },
         |                 ^
   lib/test_printf.c:811:17: note: (near initialization for 'try_cb.code')
   lib/test_printf.c:811:44: warning: excess elements in scalar initializer
     811 |                 { be32_to_cpu(0x41424344), "ABCD (0x41424344)", },
         |                                            ^~~~~~~~~~~~~~~~~~~
   lib/test_printf.c:811:44: note: (near initialization for 'try_cb.code')
   In file included from include/linux/kernel.h:16,
                    from lib/test_printf.c:9:
>> include/linux/array_size.h:11:52: error: subscripted value is neither array nor pointer nor vector
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                    ^
   lib/test_printf.c:815:37: note: in expansion of macro 'ARRAY_SIZE'
     815 |         fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
         |                                     ^~~~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/init.h:5,
                    from lib/test_printf.c:8:
>> include/linux/compiler.h:201:56: error: subscripted value is neither array nor pointer nor vector
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^
   include/linux/compiler.h:197:79: note: in definition of macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   include/linux/compiler.h:201:35: note: in expansion of macro '__same_type'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:202:58: note: in expansion of macro '__is_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/test_printf.c:815:37: note: in expansion of macro 'ARRAY_SIZE'
     815 |         fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/test_printf.c:815:37: note: in expansion of macro 'ARRAY_SIZE'
     815 |         fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
         |                                     ^~~~~~~~~~
>> lib/test_printf.c:815:29: error: incompatible type for argument 1 of 'fourcc_pointer_test'
     815 |         fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
         |                             ^~~~~~
         |                             |
         |                             struct fourcc_struct
   lib/test_printf.c:784:68: note: expected 'const struct fourcc_struct *' but argument is of type 'struct fourcc_struct'
     784 | static void __init fourcc_pointer_test(const struct fourcc_struct *fc, size_t n,
         |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>> include/linux/array_size.h:11:52: error: subscripted value is neither array nor pointer nor vector
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                    ^
   lib/test_printf.c:816:37: note: in expansion of macro 'ARRAY_SIZE'
     816 |         fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:201:56: error: subscripted value is neither array nor pointer nor vector
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^
   include/linux/compiler.h:197:79: note: in definition of macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   include/linux/compiler.h:201:35: note: in expansion of macro '__same_type'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:202:58: note: in expansion of macro '__is_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/test_printf.c:816:37: note: in expansion of macro 'ARRAY_SIZE'
     816 |         fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/test_printf.c:816:37: note: in expansion of macro 'ARRAY_SIZE'
     816 |         fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
         |                                     ^~~~~~~~~~
   lib/test_printf.c:816:29: error: incompatible type for argument 1 of 'fourcc_pointer_test'
     816 |         fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
         |                             ^~~~~~
         |                             |
         |                             struct fourcc_struct
   lib/test_printf.c:784:68: note: expected 'const struct fourcc_struct *' but argument is of type 'struct fourcc_struct'
     784 | static void __init fourcc_pointer_test(const struct fourcc_struct *fc, size_t n,
         |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>> include/linux/array_size.h:11:52: error: subscripted value is neither array nor pointer nor vector
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                    ^
   lib/test_printf.c:817:37: note: in expansion of macro 'ARRAY_SIZE'
     817 |         fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:201:56: error: subscripted value is neither array nor pointer nor vector
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^
   include/linux/compiler.h:197:79: note: in definition of macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   include/linux/compiler.h:201:35: note: in expansion of macro '__same_type'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:202:58: note: in expansion of macro '__is_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/test_printf.c:817:37: note: in expansion of macro 'ARRAY_SIZE'
     817 |         fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/test_printf.c:817:37: note: in expansion of macro 'ARRAY_SIZE'
     817 |         fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
         |                                     ^~~~~~~~~~
   lib/test_printf.c:817:29: error: incompatible type for argument 1 of 'fourcc_pointer_test'
     817 |         fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
         |                             ^~~~~~
         |                             |
         |                             struct fourcc_struct
   lib/test_printf.c:784:68: note: expected 'const struct fourcc_struct *' but argument is of type 'struct fourcc_struct'
     784 | static void __init fourcc_pointer_test(const struct fourcc_struct *fc, size_t n,
         |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>> include/linux/array_size.h:11:52: error: subscripted value is neither array nor pointer nor vector
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                    ^
   lib/test_printf.c:818:37: note: in expansion of macro 'ARRAY_SIZE'
     818 |         fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:201:56: error: subscripted value is neither array nor pointer nor vector
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^
   include/linux/compiler.h:197:79: note: in definition of macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   include/linux/compiler.h:201:35: note: in expansion of macro '__same_type'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:202:58: note: in expansion of macro '__is_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/test_printf.c:818:37: note: in expansion of macro 'ARRAY_SIZE'
     818 |         fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   lib/test_printf.c:818:37: note: in expansion of macro 'ARRAY_SIZE'
     818 |         fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
         |                                     ^~~~~~~~~~
   lib/test_printf.c:818:29: error: incompatible type for argument 1 of 'fourcc_pointer_test'
     818 |         fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
         |                             ^~~~~~
         |                             |
         |                             struct fourcc_struct
   lib/test_printf.c:784:68: note: expected 'const struct fourcc_struct *' but argument is of type 'struct fourcc_struct'
     784 | static void __init fourcc_pointer_test(const struct fourcc_struct *fc, size_t n,
         |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
--
   test_printf.c: In function 'fourcc_pointer':
   test_printf.c:802:17: warning: braces around scalar initializer
     802 |                 { 0x41424344, "ABCD (0x41424344)", },
         |                 ^
   test_printf.c:802:17: note: (near initialization for 'try_ch.code')
   test_printf.c:802:31: warning: excess elements in scalar initializer
     802 |                 { 0x41424344, "ABCD (0x41424344)", },
         |                               ^~~~~~~~~~~~~~~~~~~
   test_printf.c:802:31: note: (near initialization for 'try_ch.code')
   test_printf.c:805:17: warning: braces around scalar initializer
     805 |                 { 0x41424344, "DCBA (0x44434241)", },
         |                 ^
   test_printf.c:805:17: note: (near initialization for 'try_cn.code')
   test_printf.c:805:31: warning: excess elements in scalar initializer
     805 |                 { 0x41424344, "DCBA (0x44434241)", },
         |                               ^~~~~~~~~~~~~~~~~~~
   test_printf.c:805:31: note: (near initialization for 'try_cn.code')
   test_printf.c:808:17: warning: braces around scalar initializer
     808 |                 { le32_to_cpu(0x41424344), "ABCD (0x41424344)", },
         |                 ^
   test_printf.c:808:17: note: (near initialization for 'try_cl.code')
   test_printf.c:808:44: warning: excess elements in scalar initializer
     808 |                 { le32_to_cpu(0x41424344), "ABCD (0x41424344)", },
         |                                            ^~~~~~~~~~~~~~~~~~~
   test_printf.c:808:44: note: (near initialization for 'try_cl.code')
   test_printf.c:811:17: warning: braces around scalar initializer
     811 |                 { be32_to_cpu(0x41424344), "ABCD (0x41424344)", },
         |                 ^
   test_printf.c:811:17: note: (near initialization for 'try_cb.code')
   test_printf.c:811:44: warning: excess elements in scalar initializer
     811 |                 { be32_to_cpu(0x41424344), "ABCD (0x41424344)", },
         |                                            ^~~~~~~~~~~~~~~~~~~
   test_printf.c:811:44: note: (near initialization for 'try_cb.code')
   In file included from include/linux/kernel.h:16,
                    from test_printf.c:9:
>> include/linux/array_size.h:11:52: error: subscripted value is neither array nor pointer nor vector
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                    ^
   test_printf.c:815:37: note: in expansion of macro 'ARRAY_SIZE'
     815 |         fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
         |                                     ^~~~~~~~~~
   In file included from include/linux/build_bug.h:5,
                    from include/linux/init.h:5,
                    from test_printf.c:8:
>> include/linux/compiler.h:201:56: error: subscripted value is neither array nor pointer nor vector
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^
   include/linux/compiler.h:197:79: note: in definition of macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   include/linux/compiler.h:201:35: note: in expansion of macro '__same_type'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:202:58: note: in expansion of macro '__is_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   test_printf.c:815:37: note: in expansion of macro 'ARRAY_SIZE'
     815 |         fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   test_printf.c:815:37: note: in expansion of macro 'ARRAY_SIZE'
     815 |         fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
         |                                     ^~~~~~~~~~
   test_printf.c:815:29: error: incompatible type for argument 1 of 'fourcc_pointer_test'
     815 |         fourcc_pointer_test(try_ch, ARRAY_SIZE(try_ch), "%p4ch");
         |                             ^~~~~~
         |                             |
         |                             struct fourcc_struct
   test_printf.c:784:68: note: expected 'const struct fourcc_struct *' but argument is of type 'struct fourcc_struct'
     784 | static void __init fourcc_pointer_test(const struct fourcc_struct *fc, size_t n,
         |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>> include/linux/array_size.h:11:52: error: subscripted value is neither array nor pointer nor vector
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                    ^
   test_printf.c:816:37: note: in expansion of macro 'ARRAY_SIZE'
     816 |         fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:201:56: error: subscripted value is neither array nor pointer nor vector
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^
   include/linux/compiler.h:197:79: note: in definition of macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   include/linux/compiler.h:201:35: note: in expansion of macro '__same_type'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:202:58: note: in expansion of macro '__is_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   test_printf.c:816:37: note: in expansion of macro 'ARRAY_SIZE'
     816 |         fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   test_printf.c:816:37: note: in expansion of macro 'ARRAY_SIZE'
     816 |         fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
         |                                     ^~~~~~~~~~
   test_printf.c:816:29: error: incompatible type for argument 1 of 'fourcc_pointer_test'
     816 |         fourcc_pointer_test(try_cn, ARRAY_SIZE(try_cn), "%p4cn");
         |                             ^~~~~~
         |                             |
         |                             struct fourcc_struct
   test_printf.c:784:68: note: expected 'const struct fourcc_struct *' but argument is of type 'struct fourcc_struct'
     784 | static void __init fourcc_pointer_test(const struct fourcc_struct *fc, size_t n,
         |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>> include/linux/array_size.h:11:52: error: subscripted value is neither array nor pointer nor vector
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                    ^
   test_printf.c:817:37: note: in expansion of macro 'ARRAY_SIZE'
     817 |         fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:201:56: error: subscripted value is neither array nor pointer nor vector
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^
   include/linux/compiler.h:197:79: note: in definition of macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   include/linux/compiler.h:201:35: note: in expansion of macro '__same_type'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:202:58: note: in expansion of macro '__is_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   test_printf.c:817:37: note: in expansion of macro 'ARRAY_SIZE'
     817 |         fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   test_printf.c:817:37: note: in expansion of macro 'ARRAY_SIZE'
     817 |         fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
         |                                     ^~~~~~~~~~
   test_printf.c:817:29: error: incompatible type for argument 1 of 'fourcc_pointer_test'
     817 |         fourcc_pointer_test(try_cl, ARRAY_SIZE(try_cl), "%p4cl");
         |                             ^~~~~~
         |                             |
         |                             struct fourcc_struct
   test_printf.c:784:68: note: expected 'const struct fourcc_struct *' but argument is of type 'struct fourcc_struct'
     784 | static void __init fourcc_pointer_test(const struct fourcc_struct *fc, size_t n,
         |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>> include/linux/array_size.h:11:52: error: subscripted value is neither array nor pointer nor vector
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                    ^
   test_printf.c:818:37: note: in expansion of macro 'ARRAY_SIZE'
     818 |         fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:201:56: error: subscripted value is neither array nor pointer nor vector
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                                        ^
   include/linux/compiler.h:197:79: note: in definition of macro '__BUILD_BUG_ON_ZERO_MSG'
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                               ^
   include/linux/compiler.h:201:35: note: in expansion of macro '__same_type'
     201 | #define __is_array(a)           (!__same_type((a), &(a)[0]))
         |                                   ^~~~~~~~~~~
   include/linux/compiler.h:202:58: note: in expansion of macro '__is_array'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                                          ^~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   test_printf.c:818:37: note: in expansion of macro 'ARRAY_SIZE'
     818 |         fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
         |                                     ^~~~~~~~~~
>> include/linux/compiler.h:197:77: error: expression in static assertion is not an integer
     197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
         |                                                                             ^
   include/linux/compiler.h:202:33: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
     202 | #define __must_be_array(a)      __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:59: note: in expansion of macro '__must_be_array'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   test_printf.c:818:37: note: in expansion of macro 'ARRAY_SIZE'
     818 |         fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
         |                                     ^~~~~~~~~~
   test_printf.c:818:29: error: incompatible type for argument 1 of 'fourcc_pointer_test'
     818 |         fourcc_pointer_test(try_cb, ARRAY_SIZE(try_cb), "%p4cb");
         |                             ^~~~~~
         |                             |
         |                             struct fourcc_struct
   test_printf.c:784:68: note: expected 'const struct fourcc_struct *' but argument is of type 'struct fourcc_struct'
     784 | static void __init fourcc_pointer_test(const struct fourcc_struct *fc, size_t n,
         |                                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~


vim +/fourcc_pointer_test +815 lib/test_printf.c

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
 > 802			{ 0x41424344, "ABCD (0x41424344)", },
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


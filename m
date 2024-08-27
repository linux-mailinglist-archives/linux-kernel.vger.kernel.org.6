Return-Path: <linux-kernel+bounces-304051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB1F961924
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E488A285118
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64036158218;
	Tue, 27 Aug 2024 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bic56hyF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096A1F943
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793681; cv=none; b=lyWFFmbMOSxRpDYXEYcMlprijy06ZrlLGaJdY4sxJ26DLpLdZ6zedEQnGHi5liKMjnmiWQi91askkHxOsLg+0GLjwuxRpnMInYzeUfmU2iZz297YuVw2wZw/bzts8smhlupgZWCKVXru8M8m3zFu+BjcdIsPxq6sWfEniZuB2KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793681; c=relaxed/simple;
	bh=xQk45zRQ0xoVZuNXXa/W6qn9zlMrp++9qmVx/q0XDQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e6NEsz99dV5eY1RFGDg8bpO0tLEfS0dFaFG0mTtRVUfpYwemBKZwFnUyFVAA8BufbJFoJQwKi/fzJqgwCtmzHX+kzzCPgFZTogDkGpkcYrT9wKGICxTaw5+FwXdH/4+PSjkR4Npn2gvDdJIs/rrHsfuYhzcRSftg0vghzh0+DV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bic56hyF; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724793679; x=1756329679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xQk45zRQ0xoVZuNXXa/W6qn9zlMrp++9qmVx/q0XDQQ=;
  b=Bic56hyFLVbmdbDjnlhh1qmNZlb7XIQC+bslX2ko7u6QBOyCAmToXhln
   nEycolXUnGZkaEIJtaxUGPW1f6CblIAZqY6UfteutD9OwUVei0qsLMHrW
   hgO3KDI47wp9Wm8nl+l+CtB7ar9xskbpSxX43emu7dSeuXZ0bIBAtGzff
   CQf8+FV5kVTG9+J9sqaKoyF7IpHEYAMDq7ir2f+xS5WkY+oiu67XB8KlH
   xwVS80npOrEZyC0j+IXQNDX2S06qUojh01z7YZjS91GO/JGvR3sPpdmJc
   WmUYsvRzMwEld/dDnZUpiqQP47FtImrnmRi6W5kETX7/OVXUtESZWuNM6
   Q==;
X-CSE-ConnectionGUID: dCdcvNaLTveD77fDFqNuwA==
X-CSE-MsgGUID: chW5UilLQ7qwBsoeBnTaAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34672092"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="34672092"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 14:21:19 -0700
X-CSE-ConnectionGUID: jFcVtE9JTu6u0OxZhRzz2A==
X-CSE-MsgGUID: WkzoaYBySmutTnfA4vn/RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="62727827"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Aug 2024 14:21:17 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sj3co-000K5w-33;
	Tue, 27 Aug 2024 21:21:14 +0000
Date: Wed, 28 Aug 2024 05:21:04 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: include/linux/slab.h:552:15: error: type defaults to 'int' in
 declaration of 'kmem_buckets_create'
Message-ID: <202408280559.FIsoHAAc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ec3f5fc4a91e389ea56b111a73d97ffc94f19c6
commit: b32801d1255be1da62ea8134df3ed9f3331fba12 mm/slab: Introduce kmem_buckets_create() and family
date:   8 weeks ago
config: x86_64-randconfig-072-20240827 (https://download.01.org/0day-ci/archive/20240828/202408280559.FIsoHAAc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240828/202408280559.FIsoHAAc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408280559.FIsoHAAc-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/include/asm/fpu/types.h:355:22: note: in expansion of macro 'PAGE_SIZE'
     355 |         u8 __padding[PAGE_SIZE];
         |                      ^~~~~~~~~
   arch/x86/include/asm/page_types.h:10:33: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT              CONFIG_PAGE_SHIFT
         |                                 ^~~~~~~~~~~~~~~~~
   arch/x86/include/asm/page_types.h:11:47: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE               (_AC(1,UL) << PAGE_SHIFT)
         |                                               ^~~~~~~~~~
   include/linux/mm_types.h:531:6: note: in expansion of macro 'PAGE_SIZE'
     531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |      ^~~~~~~~~
   In file included from include/vdso/const.h:5,
                    from include/linux/const.h:4,
                    from include/linux/list.h:9,
                    from include/linux/swait.h:5,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/page_types.h:10:33: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT              CONFIG_PAGE_SHIFT
         |                                 ^~~~~~~~~~~~~~~~~
   include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
      32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                  ^~~~
   include/linux/mm_types.h:508:41: note: in expansion of macro '__ALIGN_MASK'
     508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   arch/x86/include/asm/page_types.h:11:47: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE               (_AC(1,UL) << PAGE_SHIFT)
         |                                               ^~~~~~~~~~
   arch/x86/include/asm/page_types.h:12:36: note: in expansion of macro 'PAGE_SIZE'
      12 | #define PAGE_MASK               (~(PAGE_SIZE-1))
         |                                    ^~~~~~~~~
   include/linux/mm_types.h:508:62: note: in expansion of macro 'PAGE_MASK'
     508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/linux/mm_types.h:531:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/page_types.h:10:33: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT              CONFIG_PAGE_SHIFT
         |                                 ^~~~~~~~~~~~~~~~~
   include/uapi/linux/const.h:32:61: note: in definition of macro '__ALIGN_KERNEL_MASK'
      32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                                             ^~~~
   include/linux/mm_types.h:508:41: note: in expansion of macro '__ALIGN_MASK'
     508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                         ^~~~~~~~~~~~
   arch/x86/include/asm/page_types.h:11:47: note: in expansion of macro 'PAGE_SHIFT'
      11 | #define PAGE_SIZE               (_AC(1,UL) << PAGE_SHIFT)
         |                                               ^~~~~~~~~~
   arch/x86/include/asm/page_types.h:12:36: note: in expansion of macro 'PAGE_SIZE'
      12 | #define PAGE_MASK               (~(PAGE_SIZE-1))
         |                                    ^~~~~~~~~
   include/linux/mm_types.h:508:62: note: in expansion of macro 'PAGE_MASK'
     508 | #define PAGE_FRAG_CACHE_MAX_SIZE        __ALIGN_MASK(32768, ~PAGE_MASK)
         |                                                              ^~~~~~~~~
   include/linux/mm_types.h:531:18: note: in expansion of macro 'PAGE_FRAG_CACHE_MAX_SIZE'
     531 | #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/page.h:9,
                    from arch/x86/include/asm/thread_info.h:12,
                    from include/linux/thread_info.h:60,
                    from include/linux/spinlock.h:60,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/page_types.h:10:33: warning: "CONFIG_PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
      10 | #define PAGE_SHIFT              CONFIG_PAGE_SHIFT
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/mmzone.h:1757:23: note: in expansion of macro 'PAGE_SHIFT'
    1757 | #if (MAX_PAGE_ORDER + PAGE_SHIFT) > SECTION_SIZE_BITS
         |                       ^~~~~~~~~~
   In file included from include/linux/crypto.h:17,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/slab.h:431:21: error: type defaults to 'int' in declaration of 'kmalloc_caches' [-Werror=implicit-int]
     431 | extern kmem_buckets kmalloc_caches[NR_KMALLOC_TYPES];
         |                     ^~~~~~~~~~~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/swait.h:5,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
   arch/x86/include/asm/page_types.h:10:33: error: expression in static assertion is not an integer
      10 | #define PAGE_SHIFT              CONFIG_PAGE_SHIFT
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/slab.h:527:1: note: in expansion of macro 'static_assert'
     527 | static_assert(PAGE_SHIFT <= 20);
         | ^~~~~~~~~~~~~
   include/linux/slab.h:527:15: note: in expansion of macro 'PAGE_SHIFT'
     527 | static_assert(PAGE_SHIFT <= 20);
         |               ^~~~~~~~~~
   In file included from include/linux/crypto.h:17,
                    from arch/x86/kernel/asm-offsets.c:9:
>> include/linux/slab.h:552:15: error: type defaults to 'int' in declaration of 'kmem_buckets_create' [-Werror=implicit-int]
     552 | kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
         |               ^~~~~~~~~~~~~~~~~~~
   include/linux/slab.h:612:33: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
     612 |                                 __assume_page_alignment __alloc_size(1);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/slab.h:615:33: warning: 'assume_aligned' attribute argument <erroneous-expression> is not an integer constant [-Wattributes]
     615 |                                 __assume_page_alignment __alloc_size(1);
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/slab.h: In function 'kmalloc_noprof':
   include/linux/slab.h:682:78: error: subscripted value is neither array nor pointer nor vector
     682 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
         |                                                                              ^
   include/linux/slab.h:675:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     675 |                 unsigned int index;
         |                              ^~~~~
   include/linux/slab.h: In function 'kmalloc_node_noprof':
   include/linux/slab.h:705:78: error: subscripted value is neither array nor pointer nor vector
     705 |                                 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
         |                                                                              ^
   include/linux/slab.h:698:30: warning: variable 'index' set but not used [-Wunused-but-set-variable]
     698 |                 unsigned int index;
         |                              ^~~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/swait.h:5,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:15,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/highmem.h: In function 'memcpy_from_file_folio':
   include/linux/minmax.h:31:9: error: first argument to '__builtin_choose_expr' not a constant
      31 |         __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),        \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:51:9: note: in expansion of macro 'static_assert'
      51 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:39:28: note: in expansion of macro '__is_signed'
      39 |         (__is_signed(x) == __is_signed(y) ||                    \
         |                            ^~~~~~~~~~~
   include/linux/minmax.h:51:23: note: in expansion of macro '__types_ok'
      51 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:58:17: note: in expansion of macro '__cmp_once'
      58 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:161:33: note: in expansion of macro '__careful_cmp'
     161 | #define min_t(type, x, y)       __careful_cmp(min, (type)(x), (type)(y))
         |                                 ^~~~~~~~~~~~~
   include/linux/highmem.h:596:23: note: in expansion of macro 'min_t'
     596 |                 len = min_t(size_t, len, PAGE_SIZE - offset);
         |                       ^~~~~
   include/linux/minmax.h:31:9: error: first argument to '__builtin_choose_expr' not a constant
      31 |         __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),        \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:51:9: note: in expansion of macro 'static_assert'
      51 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:40:41: note: in expansion of macro '__is_signed'
      40 |                 __is_signed((x) + 0) == __is_signed((y) + 0) || \
         |                                         ^~~~~~~~~~~
   include/linux/minmax.h:51:23: note: in expansion of macro '__types_ok'
      51 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:58:17: note: in expansion of macro '__cmp_once'
      58 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:161:33: note: in expansion of macro '__careful_cmp'
     161 | #define min_t(type, x, y)       __careful_cmp(min, (type)(x), (type)(y))
         |                                 ^~~~~~~~~~~~~
   include/linux/highmem.h:596:23: note: in expansion of macro 'min_t'
     596 |                 len = min_t(size_t, len, PAGE_SIZE - offset);
         |                       ^~~~~
   include/linux/minmax.h:31:9: error: first argument to '__builtin_choose_expr' not a constant
      31 |         __builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),        \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/minmax.h:51:9: note: in expansion of macro 'static_assert'
      51 |         static_assert(__types_ok(x, y),                 \
         |         ^~~~~~~~~~~~~
   include/linux/minmax.h:36:53: note: in expansion of macro '__is_signed'
      36 |         (__builtin_choose_expr(__is_constexpr(x) && __is_signed(x), x, -1) >= 0)
         |                                                     ^~~~~~~~~~~
   include/linux/minmax.h:41:38: note: in expansion of macro '__is_noneg_int'
      41 |                 __is_noneg_int(x) || __is_noneg_int(y))
         |                                      ^~~~~~~~~~~~~~
   include/linux/minmax.h:51:23: note: in expansion of macro '__types_ok'
      51 |         static_assert(__types_ok(x, y),                 \
         |                       ^~~~~~~~~~
   include/linux/minmax.h:58:17: note: in expansion of macro '__cmp_once'
      58 |                 __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
         |                 ^~~~~~~~~~
   include/linux/minmax.h:161:33: note: in expansion of macro '__careful_cmp'
     161 | #define min_t(type, x, y)       __careful_cmp(min, (type)(x), (type)(y))


vim +552 include/linux/slab.h

   551	
 > 552	kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
   553					  unsigned int useroffset, unsigned int usersize,
   554					  void (*ctor)(void *));
   555	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


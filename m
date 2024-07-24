Return-Path: <linux-kernel+bounces-261551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8090593B8C3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB811C215E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D89513C691;
	Wed, 24 Jul 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eONtllEg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9B6139D13
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857363; cv=none; b=uZXIjnFWwwqvM6fbcfCyAYmX+Aqws377Jw/FZpTp7ngXObPqUvaP+bjgizjyhbPqVtavd+pixhiVp1anwrSs3mXWMqW0gLbAtdkLdTHAQky/98HRodGzwOLPuTow+vh3BhGOSs0X3O9u9Qfao5M03nN77j5C0lP9JpmstQIbtB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857363; c=relaxed/simple;
	bh=eQ6sAvGvP9kAWKJJFpBq5NN0fv0rKdXUvf1c8GfdVC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSQq0WPPBxMsTl4JQ0WB58X6nevxee+m2WM/G5OyxPEOkoMwe6opiea6mwNtCBIqFcGQSiTM1ea8Qxb4U03nx/sMxukkMs3Dp8KE67JKAdx0yzlxeE0N2VsJmh9y25gNtdZh7Y7FphECoMm0fQHY5WDU3Mun8L8kdF7FnfFupNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eONtllEg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721857362; x=1753393362;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eQ6sAvGvP9kAWKJJFpBq5NN0fv0rKdXUvf1c8GfdVC8=;
  b=eONtllEglQy53/rfPnw+zzvSndlL/cUpeVZbIdAZwPGYwnrU0PFbJVAe
   1Szp82eAcLMOgAvbrGxz+FmYsY/4dDTlFr8OKz0wiBHwt7mo22ek+A0gK
   JCXM2tLJqrQbB6F30LHeQq5BdEGg7vbXlWy7iW3PX+fzADTAMAa7Hc/AN
   LwdSEwpPYk5kHfJEMktoqF7iJbz/oh1FEx9gyzd5fvc1Pium5UQXX/ptW
   hrtI9wIRl3JoaYnoD6+wwq01K/SqrGeN9+YnTIL8r9cVsxDNh7Hohe/+L
   S1lQHIj43Z0h8B0EQy1CPHTYUdPbUNiYUzqiGZVVZcTqTjgrJvkJrguQm
   g==;
X-CSE-ConnectionGUID: g5m07qsOT7Gr6wNehMPQqw==
X-CSE-MsgGUID: Gp+I3+gDQZyAXLRRjN25lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="12698100"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="12698100"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:42:41 -0700
X-CSE-ConnectionGUID: g9gogmCMRMuznydU/dGl8A==
X-CSE-MsgGUID: CSvgythYQ86prZydRaha9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="57271218"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Jul 2024 14:42:39 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sWjkq-000nSi-1V;
	Wed, 24 Jul 2024 21:42:36 +0000
Date: Thu, 25 Jul 2024 05:41:54 +0800
From: kernel test robot <lkp@intel.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH 2/2] mm: Remove PG_error
Message-ID: <202407250522.sImVfZXf-lkp@intel.com>
References: <20240724010550.1755992-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724010550.1755992-3-willy@infradead.org>

Hi Matthew,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linux/master linus/master v6.10 next-20240724]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/fs-Remove-calls-to-set-and-clear-the-folio-error-flag/20240724-111138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240724010550.1755992-3-willy%40infradead.org
patch subject: [PATCH 2/2] mm: Remove PG_error
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20240725/202407250522.sImVfZXf-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project ad154281230d83ee551e12d5be48bb956ef47ed3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240725/202407250522.sImVfZXf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407250522.sImVfZXf-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/debug.c:10:
   In file included from include/linux/mm.h:2206:
   include/linux/vmstat.h:498:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     498 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from mm/debug.c:18:
   In file included from mm/internal.h:13:
   include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
         |                                    ~~~~~~~~~~~ ^ ~~~
   include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
      49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
         |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
>> mm/debug.c:35:2: error: use of undeclared identifier 'PG_error'; did you mean 'ma_error'?
      35 |         __def_pageflag_names,
         |         ^
   include/trace/events/mmflags.h:103:2: note: expanded from macro '__def_pageflag_names'
     103 |         DEF_PAGEFLAG_NAME(error),                                       \
         |         ^
   include/trace/events/mmflags.h:98:44: note: expanded from macro 'DEF_PAGEFLAG_NAME'
      98 | #define DEF_PAGEFLAG_NAME(_name) { 1UL <<  PG_##_name, __stringify(_name) }
         |                                            ^
   <scratch space>:35:1: note: expanded from here
      35 | PG_error
         | ^
   include/linux/maple_tree.h:383:2: note: 'ma_error' declared here
     383 |         ma_error,
         |         ^
   3 warnings and 1 error generated.
--
   In file included from fs/proc/page.c:2:
   In file included from include/linux/memblock.h:12:
   In file included from include/linux/mm.h:2206:
   include/linux/vmstat.h:498:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     498 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from fs/proc/page.c:2:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from fs/proc/page.c:2:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from fs/proc/page.c:2:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:14:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> fs/proc/page.c:185:35: error: use of undeclared identifier 'PG_error'; did you mean 'ma_error'?
     185 |         u |= kpf_copy_bit(k, KPF_ERROR,         PG_error);
         |                                                 ^~~~~~~~
         |                                                 ma_error
   include/linux/maple_tree.h:383:2: note: 'ma_error' declared here
     383 |         ma_error,
         |         ^
   13 warnings and 1 error generated.


vim +35 mm/debug.c

7cd12b4abfd2f8f Vlastimil Babka 2016-03-15  33  
edf14cdbf9a0e5a Vlastimil Babka 2016-03-15  34  const struct trace_print_flags pageflag_names[] = {
edf14cdbf9a0e5a Vlastimil Babka 2016-03-15 @35  	__def_pageflag_names,
edf14cdbf9a0e5a Vlastimil Babka 2016-03-15  36  	{0, NULL}
edf14cdbf9a0e5a Vlastimil Babka 2016-03-15  37  };
edf14cdbf9a0e5a Vlastimil Babka 2016-03-15  38  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


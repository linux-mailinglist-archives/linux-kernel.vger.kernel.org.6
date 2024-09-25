Return-Path: <linux-kernel+bounces-337878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C5F98508F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160991F2475D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598551428E7;
	Wed, 25 Sep 2024 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drUx5ndJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8A18DF8B;
	Wed, 25 Sep 2024 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727226115; cv=none; b=tHH9kn8JIQbh8eK9dQbzwHxrl1Xf28I+BIHaGRa70CY5vW7pE3skRJnKXqQWmWrXg5elnPfbp9S45qmHcU+2OS6itr6xUNVKRr6+MHFaQxWNXB72PQYE5RQz3TYwn5+cC2UO/i1JgJFaNozh3zhgtET6xpqOhfEgY3UQ+cYssSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727226115; c=relaxed/simple;
	bh=Hnp42PrKfzfKYFo6ILUHY5XMvAkAmXvxiR+pbf7CaC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMnAD2kMWXDLlC6ys4rWPjo+4XYKYZEbb3iC7GICyhdS9oTGBN5velACNkom3UhmqZ45qXy3FtHY7ovxYBwfllTXHIZaeAb1CB4b9hcAfWqEFeHyc/T9gFh85XRqDTfC8FJeI87gTNEq3Wm8zuKQWcSw8j6yi7VWeCBDDAum0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drUx5ndJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727226114; x=1758762114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hnp42PrKfzfKYFo6ILUHY5XMvAkAmXvxiR+pbf7CaC0=;
  b=drUx5ndJS0usk9W7hhdlzD3JrmSf1fNkcrdSYM4FVBu5+hB3i9hfrUCD
   qtDmq1QF+G61a3Y59GdNI5TJPnP2aPNdF5CW1oaE1z7l4xANkc6ED1sFa
   RsPll5gPst8xz4Z5mys9QYi5NbvBV18Np/GNrpulJyW2iN1SSUH8CaHZg
   YRF6w2d8t5YEmqE94iNMY0s/76LA6tqBLZ94hQCCwgWXI9T0E1x2rcSg9
   AZnHwLPlke4jKevhLknQ2vjzsI604ZAM8j6er1P+k+Qxb+XyQyfFYSW8C
   c47ikpcxzWzAb5CSax8dHQkO+UY3p2NxtA8Aw61xKfb8eNSYY8WL2eL5q
   Q==;
X-CSE-ConnectionGUID: 0SbvFaTCT9Ojhv8ZKZ8f+Q==
X-CSE-MsgGUID: scRb83tISBi5w9MVe0GIEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="26202631"
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="26202631"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 18:01:53 -0700
X-CSE-ConnectionGUID: Cwx/qdCnQKe5Hne8tzPqeA==
X-CSE-MsgGUID: EdaeGnIYSqWQqwhZhn+3fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,256,1719903600"; 
   d="scan'208";a="71896695"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 24 Sep 2024 18:01:49 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1stGPa-000J0D-2h;
	Wed, 25 Sep 2024 01:01:46 +0000
Date: Wed, 25 Sep 2024 09:01:27 +0800
From: kernel test robot <lkp@intel.com>
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
	Yann Sionneau <ysionneau@kalrayinc.com>,
	Julian Vetter <jvetter@kalrayinc.com>
Subject: Re: [PATCH v5 1/5] Consolidate __memcpy_{to,from}io and __memset_io
 into iomap_copy.c
Message-ID: <202409250806.Lq8C7QZr-lkp@intel.com>
References: <20240924121432.798655-2-jvetter@kalrayinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924121432.798655-2-jvetter@kalrayinc.com>

Hi Julian,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on soc/for-next akpm-mm/mm-nonmm-unstable arm64/for-next/core linus/master v6.11 next-20240924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Julian-Vetter/Consolidate-__memcpy_-to-from-io-and-__memset_io-into-iomap_copy-c/20240924-202154
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/20240924121432.798655-2-jvetter%40kalrayinc.com
patch subject: [PATCH v5 1/5] Consolidate __memcpy_{to,from}io and __memset_io into iomap_copy.c
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240925/202409250806.Lq8C7QZr-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240925/202409250806.Lq8C7QZr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409250806.Lq8C7QZr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/iomap_copy.c:89:19: error: implicit declaration of function 'IS_ALIGNED' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           while (count && !IS_ALIGNED((unsigned long)from, NATIVE_STORE_SIZE)) {
                            ^
   lib/iomap_copy.c:121:19: error: implicit declaration of function 'IS_ALIGNED' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           while (count && !IS_ALIGNED((unsigned long)to, NATIVE_STORE_SIZE)) {
                            ^
   lib/iomap_copy.c:161:19: error: implicit declaration of function 'IS_ALIGNED' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           while (count && !IS_ALIGNED((unsigned long)dst, NATIVE_STORE_SIZE)) {
                            ^
   3 errors generated.


vim +/IS_ALIGNED +89 lib/iomap_copy.c

    84	
    85	
    86	#ifndef __memcpy_fromio
    87	void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
    88	{
  > 89		while (count && !IS_ALIGNED((unsigned long)from, NATIVE_STORE_SIZE)) {
    90			*(u8 *)to = __raw_readb(from);
    91			from++;
    92			to++;
    93			count--;
    94		}
    95	
    96		while (count >= NATIVE_STORE_SIZE) {
    97	#ifdef CONFIG_64BIT
    98				put_unaligned(__raw_readq(from), (uintptr_t *)to);
    99	#else
   100				put_unaligned(__raw_readl(from), (uintptr_t *)to);
   101	#endif
   102	
   103			from += NATIVE_STORE_SIZE;
   104			to += NATIVE_STORE_SIZE;
   105			count -= NATIVE_STORE_SIZE;
   106		}
   107	
   108		while (count) {
   109			*(u8 *)to = __raw_readb(from);
   110			from++;
   111			to++;
   112			count--;
   113		}
   114	}
   115	EXPORT_SYMBOL(__memcpy_fromio);
   116	#endif
   117	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


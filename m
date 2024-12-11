Return-Path: <linux-kernel+bounces-441733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91819ED33A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1142890AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808CF1DE8BF;
	Wed, 11 Dec 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+UXQrET"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD53B1DE4FF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937538; cv=none; b=M0M0abE/ymFwpY1Ps4wMNI+MXAVHiU/Y0lRJ9dFqL7ClWLncftqkSMgmrt2wvpeH1ToNNcBPGsdnHJhpK2q3MYH2vMiYY4kQRJbD0WyVFy640pGZ3hkPGjI0bRYK7eX/tGnunJkxzHgApvAOMTsTGZk54882wpEHyU1LpLgWf04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937538; c=relaxed/simple;
	bh=6m/FEkErYkTgndplG/4B7TlZAoKTdQWT3a7pXkXaAH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nn+es/ZomKnihDB8bFkwvxEcALghIpKZ/8WQGFRLJQNDbqeiK0vImsNo/2THMbBEqb7HhQMXdHtttFhLwg4rDJuwx+b5lEatFpW3eFZHMXJ1nk+nMBsSrppEerZ87z38yuP27KJZ25oHYjPcnYcZqOrfNr/5x1wH3lkavjYJvF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+UXQrET; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733937536; x=1765473536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6m/FEkErYkTgndplG/4B7TlZAoKTdQWT3a7pXkXaAH8=;
  b=n+UXQrETJ44QMXuIN3KPJBRWtjal7uJvWFzbfO6+AFHPaU4lVG/7nBvB
   HnFVCH0vVD2xLS8SyJSg0hLc02eVVLu+0VbBeUMg0J60hkE9YIgEwN7Mb
   7vtZEO9k2+gX24Z5fHalyHGZr/R1OJx8g8YJwbTt5mSQw2ViTiuccVCsi
   8utF8xLUx63O4Zovoi2vdwuUSdg/iAHd5wFfjvcWE3uAcX5Ee14IFpPCX
   E1uEN5syN0TsaaACBkyAN/yXoHIp3a07EI0HoFgBV4VgeU9SA+qvlCub0
   9oq9ETA9aXv1os1YMFQRZPBV0QKcQSpgYUIvvgR2QraPjNcNfz7ZOV2N4
   A==;
X-CSE-ConnectionGUID: GdZ1WId4TaykoYiijiMuww==
X-CSE-MsgGUID: Tq2LhEZUSgijn5AVnstb7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34203263"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34203263"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:18:54 -0800
X-CSE-ConnectionGUID: eHlOtguiRi6zInkIDQmw4w==
X-CSE-MsgGUID: BlEk8d8eRb+nW6DpBKlySw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="126824513"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 Dec 2024 09:18:52 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLQML-0006vd-0y;
	Wed, 11 Dec 2024 17:18:49 +0000
Date: Thu, 12 Dec 2024 01:18:31 +0800
From: kernel test robot <lkp@intel.com>
To: Junjie Fu <fujunjie1@qq.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, willy@infradead.org, sj@kernel.org,
	Junjie Fu <fujunjie1@qq.com>
Subject: Re: [PATCH RESEND] mempolicy.h: Remove unnecessary header file
 inclusions with no test failure
Message-ID: <202412120124.VtMN4Kk6-lkp@intel.com>
References: <tencent_C12D22B8989E0314FDE7073D6446186E3C09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_C12D22B8989E0314FDE7073D6446186E3C09@qq.com>

Hi Junjie,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on brauner-vfs/vfs.all linus/master v6.13-rc2 next-20241211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Junjie-Fu/mempolicy-h-Remove-unnecessary-header-file-inclusions-with-no-test-failure/20241211-120550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/tencent_C12D22B8989E0314FDE7073D6446186E3C09%40qq.com
patch subject: [PATCH RESEND] mempolicy.h: Remove unnecessary header file inclusions with no test failure
config: i386-buildonly-randconfig-003-20241211 (https://download.01.org/0day-ci/archive/20241212/202412120124.VtMN4Kk6-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120124.VtMN4Kk6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120124.VtMN4Kk6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/z3fold.c:30:
   In file included from include/linux/mm.h:2287:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> mm/z3fold.c:353:3: error: call to undeclared function 'lock_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     353 |                 lock_page(page);
         |                 ^
   mm/z3fold.c:353:3: note: did you mean 'copy_page'?
   arch/x86/include/asm/page_32.h:25:20: note: 'copy_page' declared here
      25 | static inline void copy_page(void *to, void *from)
         |                    ^
>> mm/z3fold.c:355:3: error: call to undeclared function 'unlock_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     355 |                 unlock_page(page);
         |                 ^
   mm/z3fold.c:1052:3: error: call to undeclared function 'lock_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1052 |                 lock_page(page);
         |                 ^
   mm/z3fold.c:1054:3: error: call to undeclared function 'unlock_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1054 |                 unlock_page(page);
         |                 ^
>> mm/z3fold.c:1056:12: error: call to undeclared function 'trylock_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1056 |                 WARN_ON(!trylock_page(page));
         |                          ^
   mm/z3fold.c:1056:12: note: did you mean 'try_get_page'?
   include/linux/mm.h:1527:33: note: 'try_get_page' declared here
    1527 | static inline __must_check bool try_get_page(struct page *page)
         |                                 ^
   mm/z3fold.c:1058:3: error: call to undeclared function 'unlock_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1058 |                 unlock_page(page);
         |                 ^
   1 warning and 6 errors generated.


vim +/lock_page +353 mm/z3fold.c

9a001fc19cccdeb Vitaly Wool 2016-05-20  348  
9a001fc19cccdeb Vitaly Wool 2016-05-20  349  /* Resets the struct page fields and frees the page */
1f862989b04ade6 Vitaly Wool 2019-05-13  350  static void free_z3fold_page(struct page *page, bool headless)
9a001fc19cccdeb Vitaly Wool 2016-05-20  351  {
1f862989b04ade6 Vitaly Wool 2019-05-13  352  	if (!headless) {
1f862989b04ade6 Vitaly Wool 2019-05-13 @353  		lock_page(page);
1f862989b04ade6 Vitaly Wool 2019-05-13  354  		__ClearPageMovable(page);
1f862989b04ade6 Vitaly Wool 2019-05-13 @355  		unlock_page(page);
1f862989b04ade6 Vitaly Wool 2019-05-13  356  	}
5a27aa8220290b6 Vitaly Wool 2017-02-24  357  	__free_page(page);
5a27aa8220290b6 Vitaly Wool 2017-02-24  358  }
5a27aa8220290b6 Vitaly Wool 2017-02-24  359  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


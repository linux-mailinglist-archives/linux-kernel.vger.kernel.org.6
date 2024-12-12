Return-Path: <linux-kernel+bounces-442411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A29EDC6E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D04518898F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550504A29;
	Thu, 12 Dec 2024 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+zYpoSM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396D6AAD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 00:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733962910; cv=none; b=eK5mFoJfuUx5TOi2fgx/dJyhGVQZd9XWUHMLk68puHOVwbXketuLL/RkpPaS5g47H6y1HpgCrD0BJ846/r7iNkFx5hSo48e05FqnaWvaD3py4r1vEO/AWF7DpLW24JxKM6ofKXCycb+wNHM8wKOXG5TltNhOSBOiDUhZm3Bvo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733962910; c=relaxed/simple;
	bh=FelxIjPBucq5C1+rmBwuJ/EZVT8Z9xNGA0BJtP20fjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejc/EYueqXkT9ZBVfsPd/Y/eRUB1cL7cpMB+STcJwY3kySls/Xfr1iyYcgF2gFrCpqffCBPnpLr/TRt+7oYFRnmq6MikYoOPmsjyJKXLS4jRKTULyXiaxTePR+mOp3eWazq+MpXARtlfZg8pzxfYEmG8DWba87MjjFVL9uKmfB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+zYpoSM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733962909; x=1765498909;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FelxIjPBucq5C1+rmBwuJ/EZVT8Z9xNGA0BJtP20fjo=;
  b=S+zYpoSM9zuwlzPpI9G4aKgPhbvYYlX3FojI9L6rAT6V3/u+ovS9Xdzo
   I1si3glpscNFArW8oJsq3ovbs2ZVHnwacWDp4wuwMt+XbTMWFOsEmJZTj
   BLtPkX9uaYZhY7QQk4ZDfcrLX6ee8XDpBBr7nXJtHjbzftB2xbepfS8CX
   761MaQloCyNdkp8uMCKL+fGmceQGfD+UEuXZiA4EE1CuB+3Iu533ofaeN
   KRncAvdQu809RTVlgcsEYPTdgUkWUFLY6rj3cU71ZyC+Yo6CP/UW82p+x
   I5o2aSsjgQUXIlkmNg4hRFkjqMhKKbfF5JOv7bvYyw6ZcJEy2Uw7v6G4h
   Q==;
X-CSE-ConnectionGUID: Uijqe/XxTx++TIUUdQbN6w==
X-CSE-MsgGUID: KHb1dCIFTbmvAE7LlpBdCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34607901"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34607901"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 16:21:48 -0800
X-CSE-ConnectionGUID: Fq+U3FFlTpyMMauzBX2IXw==
X-CSE-MsgGUID: qpJ7kEpITWKBlAt3+1FDFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="100856946"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 Dec 2024 16:21:47 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLWxc-0007Fd-1H;
	Thu, 12 Dec 2024 00:21:44 +0000
Date: Thu, 12 Dec 2024 08:21:18 +0800
From: kernel test robot <lkp@intel.com>
To: Junjie Fu <fujunjie1@qq.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	willy@infradead.org, sj@kernel.org, Junjie Fu <fujunjie1@qq.com>
Subject: Re: [PATCH RESEND] mempolicy.h: Remove unnecessary header file
 inclusions with no test failure
Message-ID: <202412120820.hwzVRrjd-lkp@intel.com>
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
config: sparc64-randconfig-002-20241212 (https://download.01.org/0day-ci/archive/20241212/202412120820.hwzVRrjd-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241212/202412120820.hwzVRrjd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412120820.hwzVRrjd-lkp@intel.com/

All errors (new ones prefixed by >>):

   mm/z3fold.c: In function 'free_z3fold_page':
>> mm/z3fold.c:353:17: error: implicit declaration of function 'lock_page'; did you mean 'alloc_page'? [-Wimplicit-function-declaration]
     353 |                 lock_page(page);
         |                 ^~~~~~~~~
         |                 alloc_page
>> mm/z3fold.c:355:17: error: implicit declaration of function 'unlock_page'; did you mean 'alloc_page'? [-Wimplicit-function-declaration]
     355 |                 unlock_page(page);
         |                 ^~~~~~~~~~~
         |                 alloc_page
   In file included from arch/sparc/include/asm/bug.h:25,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/sched.h:12,
                    from mm/z3fold.c:27:
   mm/z3fold.c: In function 'z3fold_alloc':
>> mm/z3fold.c:1056:26: error: implicit declaration of function 'trylock_page'; did you mean 'try_get_page'? [-Wimplicit-function-declaration]
    1056 |                 WARN_ON(!trylock_page(page));
         |                          ^~~~~~~~~~~~
   include/asm-generic/bug.h:123:32: note: in definition of macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~


vim +353 mm/z3fold.c

9a001fc19cccde Vitaly Wool 2016-05-20  348  
9a001fc19cccde Vitaly Wool 2016-05-20  349  /* Resets the struct page fields and frees the page */
1f862989b04ade Vitaly Wool 2019-05-13  350  static void free_z3fold_page(struct page *page, bool headless)
9a001fc19cccde Vitaly Wool 2016-05-20  351  {
1f862989b04ade Vitaly Wool 2019-05-13  352  	if (!headless) {
1f862989b04ade Vitaly Wool 2019-05-13 @353  		lock_page(page);
1f862989b04ade Vitaly Wool 2019-05-13  354  		__ClearPageMovable(page);
1f862989b04ade Vitaly Wool 2019-05-13 @355  		unlock_page(page);
1f862989b04ade Vitaly Wool 2019-05-13  356  	}
5a27aa8220290b Vitaly Wool 2017-02-24  357  	__free_page(page);
5a27aa8220290b Vitaly Wool 2017-02-24  358  }
5a27aa8220290b Vitaly Wool 2017-02-24  359  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


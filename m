Return-Path: <linux-kernel+bounces-442964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E829A9EE4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 12:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D901884C97
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE231F236D;
	Thu, 12 Dec 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxnbYZwf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5CC21147B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734001429; cv=none; b=pAXWtpLoAnjAXpH/pnlTr3j+3x6cLTxJigGHcQNUwssr+x2tiHNEVWO1J39kjodCuz2Pn3IhXxs1spTZ9VYZ5BNDsigsJNQHcM4KkgCjg8t/hRpfypUGGLF71fFuIF09h2AsTmnM1lt61danZyG0nuehQDsBD8pUCON2HbIEc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734001429; c=relaxed/simple;
	bh=uNi8VYRXqzAJqytMdPO7sC7zCEtCZuyAocnf6y+XjqA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NcEJFVRxmLGNcbb5iY58C8HCIshzAg6S9oPADbiC2n76m7E7HLYsjtC6lZah/2bIy2ltsn28asV4YRn8DpZgIbaP0R7Qtowv8NeQK6nEMFLWCJ0XcMAegMCjtMK6kFydPmewULej4A8EHJX1o2HgBJbKsEF9ol17Xqb6aOjkGoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxnbYZwf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734001428; x=1765537428;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uNi8VYRXqzAJqytMdPO7sC7zCEtCZuyAocnf6y+XjqA=;
  b=FxnbYZwf7BkjA/CyfTSnIUqM/L254TkKzN1v/q+ZOqn7V6vKjJUlX2CN
   RpCzsYcSu0ye7YA/qE8neNNqhtVciY6+Ed23RycZooIU4xRt8sT9ZXUGU
   G0hJ969Tc8J8knx+KXtMbiwnZFMwL9sDaGzFATH3z5jYbt6VNUm2KJ0b8
   1RHhvIbJCv+Zecq3d+Ns0unoCg7dkucbsE1wp6sOpAxR1D0k0LLV//oiq
   zZ9TlBc08PHB/6i67LP9iTqrEYrUn5LUrrVrkYh/cFGdTBEfVytUttJXm
   X/nD/GC9BW4H/Il9OpmpbU+oDPEHl1J4xDKZmTsMUM/IpvdfT5vZc7xgx
   w==;
X-CSE-ConnectionGUID: 9V9TvfMmRP6urb09UhuVrw==
X-CSE-MsgGUID: Z+FCUpkyQFO0JixWMKMOhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34458086"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34458086"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 03:03:47 -0800
X-CSE-ConnectionGUID: NWGq9Z7sTYin7wp2CN7IXw==
X-CSE-MsgGUID: y2xHsOHGSpOGHi0F7iDMIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119444564"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Dec 2024 03:03:45 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLgys-0007kp-1S;
	Thu, 12 Dec 2024 11:03:42 +0000
Date: Thu, 12 Dec 2024 19:02:53 +0800
From: kernel test robot <lkp@intel.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Alexander Potapenko <glider@google.com>
Subject: mm/kmsan/hooks.c:269:14: sparse: sparse: cast removes address space
 '__user' of expression
Message-ID: <202412121809.uLILCZRI-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   231825b2e1ff6ba799c5eaf396d3ab2354e37c6b
commit: 3a8f6f3b469b4075919a3613e182f9a70df92d46 kmsan: enable on s390
date:   5 months ago
config: s390-randconfig-r121-20241212 (https://download.01.org/0day-ci/archive/20241212/202412121809.uLILCZRI-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 2dc22615fd46ab2566d0f26d5ba234ab12dc4bf8)
reproduce: (https://download.01.org/0day-ci/archive/20241212/202412121809.uLILCZRI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412121809.uLILCZRI-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/kmsan/hooks.c:269:14: sparse: sparse: cast removes address space '__user' of expression
   mm/kmsan/hooks.c:271:75: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected void const *user_addr @@     got void [noderef] __user *to @@
   mm/kmsan/hooks.c:271:75: sparse:     expected void const *user_addr
   mm/kmsan/hooks.c:271:75: sparse:     got void [noderef] __user *to
   mm/kmsan/hooks.c:280:50: sparse: sparse: cast removes address space '__user' of expression
   mm/kmsan/hooks.c:306:59: sparse: sparse: Using plain integer as NULL pointer
   mm/kmsan/hooks.c:319:79: sparse: sparse: Using plain integer as NULL pointer
   mm/kmsan/hooks.c:325:79: sparse: sparse: Using plain integer as NULL pointer
   mm/kmsan/hooks.c:421:78: sparse: sparse: Using plain integer as NULL pointer

vim +/__user +269 mm/kmsan/hooks.c

b073d7f8aee4ebf Alexander Potapenko 2022-09-15  247  
75cf0290271bf6d Alexander Potapenko 2022-09-15  248  void kmsan_copy_to_user(void __user *to, const void *from, size_t to_copy,
75cf0290271bf6d Alexander Potapenko 2022-09-15  249  			size_t left)
75cf0290271bf6d Alexander Potapenko 2022-09-15  250  {
75cf0290271bf6d Alexander Potapenko 2022-09-15  251  	unsigned long ua_flags;
75cf0290271bf6d Alexander Potapenko 2022-09-15  252  
75cf0290271bf6d Alexander Potapenko 2022-09-15  253  	if (!kmsan_enabled || kmsan_in_runtime())
75cf0290271bf6d Alexander Potapenko 2022-09-15  254  		return;
75cf0290271bf6d Alexander Potapenko 2022-09-15  255  	/*
75cf0290271bf6d Alexander Potapenko 2022-09-15  256  	 * At this point we've copied the memory already. It's hard to check it
75cf0290271bf6d Alexander Potapenko 2022-09-15  257  	 * before copying, as the size of actually copied buffer is unknown.
75cf0290271bf6d Alexander Potapenko 2022-09-15  258  	 */
75cf0290271bf6d Alexander Potapenko 2022-09-15  259  
75cf0290271bf6d Alexander Potapenko 2022-09-15  260  	/* copy_to_user() may copy zero bytes. No need to check. */
75cf0290271bf6d Alexander Potapenko 2022-09-15  261  	if (!to_copy)
75cf0290271bf6d Alexander Potapenko 2022-09-15  262  		return;
75cf0290271bf6d Alexander Potapenko 2022-09-15  263  	/* Or maybe copy_to_user() failed to copy anything. */
75cf0290271bf6d Alexander Potapenko 2022-09-15  264  	if (to_copy <= left)
75cf0290271bf6d Alexander Potapenko 2022-09-15  265  		return;
75cf0290271bf6d Alexander Potapenko 2022-09-15  266  
75cf0290271bf6d Alexander Potapenko 2022-09-15  267  	ua_flags = user_access_save();
f926e9326f3a79f Ilya Leoshkevich    2024-06-21  268  	if (!IS_ENABLED(CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE) ||
f926e9326f3a79f Ilya Leoshkevich    2024-06-21 @269  	    (u64)to < TASK_SIZE) {
75cf0290271bf6d Alexander Potapenko 2022-09-15  270  		/* This is a user memory access, check it. */
75cf0290271bf6d Alexander Potapenko 2022-09-15  271  		kmsan_internal_check_memory((void *)from, to_copy - left, to,
75cf0290271bf6d Alexander Potapenko 2022-09-15  272  					    REASON_COPY_TO_USER);
75cf0290271bf6d Alexander Potapenko 2022-09-15  273  	} else {
75cf0290271bf6d Alexander Potapenko 2022-09-15  274  		/* Otherwise this is a kernel memory access. This happens when a
75cf0290271bf6d Alexander Potapenko 2022-09-15  275  		 * compat syscall passes an argument allocated on the kernel
75cf0290271bf6d Alexander Potapenko 2022-09-15  276  		 * stack to a real syscall.
75cf0290271bf6d Alexander Potapenko 2022-09-15  277  		 * Don't check anything, just copy the shadow of the copied
75cf0290271bf6d Alexander Potapenko 2022-09-15  278  		 * bytes.
75cf0290271bf6d Alexander Potapenko 2022-09-15  279  		 */
75cf0290271bf6d Alexander Potapenko 2022-09-15  280  		kmsan_internal_memmove_metadata((void *)to, (void *)from,
75cf0290271bf6d Alexander Potapenko 2022-09-15  281  						to_copy - left);
75cf0290271bf6d Alexander Potapenko 2022-09-15  282  	}
75cf0290271bf6d Alexander Potapenko 2022-09-15  283  	user_access_restore(ua_flags);
75cf0290271bf6d Alexander Potapenko 2022-09-15  284  }
75cf0290271bf6d Alexander Potapenko 2022-09-15  285  EXPORT_SYMBOL(kmsan_copy_to_user);
75cf0290271bf6d Alexander Potapenko 2022-09-15  286  

:::::: The code at line 269 was first introduced by commit
:::::: f926e9326f3a79f7e01ac790e2361f44d8ca8320 kmsan: fix kmsan_copy_to_user() on arches with overlapping address spaces

:::::: TO: Ilya Leoshkevich <iii@linux.ibm.com>
:::::: CC: Andrew Morton <akpm@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


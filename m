Return-Path: <linux-kernel+bounces-568021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB98A68CFC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75F118999E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA7A253B74;
	Wed, 19 Mar 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="freIz2aO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C839AD6
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387613; cv=none; b=LI8WweAFHsxIF61UoBZ9T6MmCM8NGTqLoaI8KNkFuf2j+Y8T+koY9CQFAam5WiuaQmWhRT787YL/Oq0hzfgHi/BH2PxQ5QXQqYYEKn1acZcqTfxnpOngoEB7EtmzsyiXeULo1bGp3Fh6ADrNQHd/RlVYAJXhSUNcbMr5RdtYwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387613; c=relaxed/simple;
	bh=xa57tSgVO2bSfFpe/uiDHVLpa1VypzNgVCKttzrIlIo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=k+dvdnIfTrR7aY8dYxjiTH95y0cxW9+eahSIwgdcrIc8+7U1COTdQzjWg5VHkNfCTwglnnUUTixsaydwxjtSWlFhb7MXBamkvqsPuJtcQ/kztAEln491CYCh0JX6QGdli/iO165vHu7BE8BVlnJJ8r7WLlQeW8tPf1kTRh5JZkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=freIz2aO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742387612; x=1773923612;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xa57tSgVO2bSfFpe/uiDHVLpa1VypzNgVCKttzrIlIo=;
  b=freIz2aOyxR/7f8d2Ac4P6J92so0f4kD/3dhUmRWzwqDoC53wJJTzYYe
   axajgo7j455DcE7yv190qiD0w7mC3u6j8o3/8vcgCntvgxS97RA0pV6Xt
   sQv3a26GloftxXwy/0iSXuu0/zS9U1hisTqqp+kLZgUJO3DbJ3Yknp7M5
   odCTb+3j3DkYHZ00aL/QST2qpCWEYiL8WMctdG3gcXgC7qeOedMc0C4f3
   zjj8BDpgUJfBvd6enBVjDg65qO2rgAcaIaYy+3RVDVPX+u6hNz0f5UZp8
   WgL8kZyNIRjvYen3434FK9rXyi1uwlNjAnYvS6odJAl6jbkruVNlrR0pS
   g==;
X-CSE-ConnectionGUID: YCzKSvFVSsOYF1Uxx2zxzw==
X-CSE-MsgGUID: dAx9+G+rTRm8CBT4VhUoLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43495314"
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="43495314"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 05:33:31 -0700
X-CSE-ConnectionGUID: HhyuFifqQIO7meTzw7ShSw==
X-CSE-MsgGUID: uTaxwk3BQYO8Kn3WFFzyRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,259,1736841600"; 
   d="scan'208";a="153621612"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2025 05:33:29 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tusbv-000Efc-0q;
	Wed, 19 Mar 2025 12:33:27 +0000
Date: Wed, 19 Mar 2025 20:33:07 +0800
From: kernel test robot <lkp@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: [tip:WIP.x86/core 1/1] arch/sparc/include/asm/percpu_64.h:8:24:
 error: register name not specified for '__local_per_cpu_offset'
Message-ID: <202503192048.nhPLafD5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ingo,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.x86/core
head:   9262ee6499954dd387e4507e03b84512ab100706
commit: 9262ee6499954dd387e4507e03b84512ab100706 [1/1] compiler/gcc: Make asm() templates asm __inline__() by default
config: sparc64-randconfig-001-20250319 (https://download.01.org/0day-ci/archive/20250319/202503192048.nhPLafD5-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250319/202503192048.nhPLafD5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503192048.nhPLafD5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   include/linux/compiler_types.h:479:29: error: expected '(' before '__inline'
    # define asm_inline __asm__ __inline
                                ^~~~~~~~
   include/linux/compiler_types.h:480:19: note: in expansion of macro 'asm_inline'
    # define asm(...) asm_inline(__VA_ARGS__)
                      ^~~~~~~~~~
   arch/sparc/include/asm/percpu_64.h:8:47: note: in expansion of macro 'asm'
    register unsigned long __local_per_cpu_offset asm("g5");
                                                  ^~~
   In file included from arch/sparc/include/asm/percpu.h:5,
                    from include/linux/irqflags.h:19,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:68,
                    from include/linux/log2.h:12,
                    from kernel/bounds.c:13:
>> arch/sparc/include/asm/percpu_64.h:8:24: error: register name not specified for '__local_per_cpu_offset'
    register unsigned long __local_per_cpu_offset asm("g5");
                           ^~~~~~~~~~~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: kernel/bounds.s] Error 1 shuffle=3065905953
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1269: prepare0] Error 2 shuffle=3065905953
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:251: __sub-make] Error 2 shuffle=3065905953
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:251: __sub-make] Error 2 shuffle=3065905953
   make: Target 'prepare' not remade because of errors.


vim +/__local_per_cpu_offset +8 arch/sparc/include/asm/percpu_64.h

f5e706ad886b6a include/asm-sparc/percpu_64.h      Sam Ravnborg   2008-07-17   6  
48017e5481ce85 arch/sparc/include/asm/percpu_64.h Peter Zijlstra 2020-05-29   7  #ifndef BUILD_VDSO
f5e706ad886b6a include/asm-sparc/percpu_64.h      Sam Ravnborg   2008-07-17  @8  register unsigned long __local_per_cpu_offset asm("g5");
48017e5481ce85 arch/sparc/include/asm/percpu_64.h Peter Zijlstra 2020-05-29   9  #endif
f5e706ad886b6a include/asm-sparc/percpu_64.h      Sam Ravnborg   2008-07-17  10  

:::::: The code at line 8 was first introduced by commit
:::::: f5e706ad886b6a5eb59637830110b09ccebf01c5 sparc: join the remaining header files

:::::: TO: Sam Ravnborg <sam@ravnborg.org>
:::::: CC: David S. Miller <davem@davemloft.net>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


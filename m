Return-Path: <linux-kernel+bounces-417498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB62B9D54C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6882EB20C82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24C1D958E;
	Thu, 21 Nov 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HU12tuye"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0111D79BE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224839; cv=none; b=JIr0xeK6yfAjoWt6rGQxJSwbKIBkDRZGUxubBK617B8rPAmuTn2NKyJyizdp7U8ZUbNbsghb3RYdA50N9e8e6/sI0sunYA59UxpBmWR0UfR9RB/Zi8EixVuOzD0AkQz0t00zNpdMplf5O+kQhQEP3JDPf03tcZ3RWoC72E9vGQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224839; c=relaxed/simple;
	bh=a3qIDIDkQs2n/l8thtEX67VLQxDdPSytm4WNL2bFcqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgtfYw6ngsn6ZZeYAXuaBY4orUNMCgMN17DBGXhvbhpL72v70NV5MmdPFD3XDREmmXHK9vRMo9x6DwMcsJ3WkmFWpmGy6Ybr/if7UlF5MbfcKo6SADu3dyB8mN66fBYUJcLMqMqlvg8ATKpdhhj3vvnIY/usnl0VXSunXuYchTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HU12tuye; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732224838; x=1763760838;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a3qIDIDkQs2n/l8thtEX67VLQxDdPSytm4WNL2bFcqY=;
  b=HU12tuyeWL8syfUTcPVsmTUoGr9JdfSg7z1+oZ8MgK2hlJyo7xPZfxj1
   URdm6FS2hM68RxWg8K1z1gSgpAlrKRhEHXQ2wmLoVFhAAY6es0hGRk3G2
   NREiBfsH8zN9HxAMiFIsFE8qVnHoBVPffTBpxCVfZ1t3lOsGWlJwCueUl
   TMWukv4TYufC4xbhhpIkIlwbZl7of46qpGz3i63Xpq+XEJU54iAXA2Ija
   IQ6ML8QYcPs4u8T7G1Mxj4iPPwC4CiKrkGfPmVzkk0xhdCk6cVLpOz1ba
   gQ2wM9ZHZZ/bWcooEgC1xtUHY7RHFpCS15RhJcFugb2lfEif2+tF9GDE2
   g==;
X-CSE-ConnectionGUID: RoTQ95MRQcidyvzLBZ2Xrw==
X-CSE-MsgGUID: D13/F3/bR4KuYRxE3NQ0Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32421870"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32421870"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:33:56 -0800
X-CSE-ConnectionGUID: UeFKWjvZQf6Q7eNBx7rKHA==
X-CSE-MsgGUID: 4ozob9HCTkiQRNAo2RYHHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="95323280"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 21 Nov 2024 13:33:53 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEEoB-0003NK-0U;
	Thu, 21 Nov 2024 21:33:51 +0000
Date: Fri, 22 Nov 2024 05:33:31 +0800
From: kernel test robot <lkp@intel.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] objtool: Handle different entry size of rodata
Message-ID: <202411220519.OK6FYVwq-lkp@intel.com>
References: <20241119065655.21123-4-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119065655.21123-4-yangtiezhu@loongson.cn>

Hi Tiezhu,

kernel test robot noticed the following build errors:

[auto build test ERROR on v6.12-rc7]
[also build test ERROR on next-20241121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tiezhu-Yang/objtool-Handle-various-symbol-types-of-rodata/20241121-131412
base:   v6.12-rc7
patch link:    https://lore.kernel.org/r/20241119065655.21123-4-yangtiezhu%40loongson.cn
patch subject: [PATCH v3 03/10] objtool: Handle different entry size of rodata
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20241122/202411220519.OK6FYVwq-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241122/202411220519.OK6FYVwq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411220519.OK6FYVwq-lkp@intel.com/

All errors (new ones prefixed by >>):

>> check.c:2109:28: error: use of undeclared identifier 'R_LARCH_32_PCREL'
    2109 |                     reloc_type(reloc) == R_LARCH_32_PCREL)
         |                                          ^
   1 error generated.
   make[5]: *** [tools/build/Makefile.build:105: tools/objtool/check.o] Error 1
   make[5]: *** Waiting for unfinished jobs....
   make[4]: *** [Makefile:70: tools/objtool/objtool-in.o] Error 2
   make[3]: *** [Makefile:73: objtool] Error 2
   make[2]: *** [Makefile:1370: tools/objtool] Error 2
   In file included from arch/x86/kernel/asm-offsets.c:14:
   In file included from include/linux/suspend.h:5:
   In file included from include/linux/swap.h:9:
   In file included from include/linux/memcontrol.h:21:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   1 warning generated.
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


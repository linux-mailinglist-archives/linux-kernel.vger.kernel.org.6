Return-Path: <linux-kernel+bounces-562823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50662A63360
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 03:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3245318917E8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 02:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD11655897;
	Sun, 16 Mar 2025 02:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dn9BW6Ov"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216783398B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742093540; cv=none; b=lXTNMmM5nfxzokJGZqd5hQMkbx2Vg+l1SdysvzaIIDEPg/CL1Hsc3MxmauQIRlH0GlIBCJO8w+BIQ/eoOoXOuSGqEKBK1rpuBNPWJcpCwQAnIEyTe4aRDJuPYuXXrFFuPDLI00jeIaw6JLi0sYvSjSJM03P5iL2FWvLW/ANWhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742093540; c=relaxed/simple;
	bh=mbygglv071lbx3F1zj3bJcWppbkHDWaN8Wlg/CRh29k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QuEUaubhDiQmynQOO8V7lan1yvqMkQhsMjhgF9dLHQYF3Y7PrESPAIy6RiKJ2nWAV+kURPz+qoZNKLanjZzLJm2rJWkF0qWFz56xj+mUBl0u5fewgvZlfxG1dVyixftGj2737NgiSws0zbG5sRlGdbDUV+mr/ya6drFkLFbqpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dn9BW6Ov; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742093538; x=1773629538;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mbygglv071lbx3F1zj3bJcWppbkHDWaN8Wlg/CRh29k=;
  b=dn9BW6Ov4Gd4dwBOm2WeVzZK/NW2tzCjnyHhnbE/FYW8WLmdS2qZbOT4
   tkFAgMWfGzOdaX3nS8/DvsGZik6BEoAk2WhY2COmJxyhN8ac1MFSLJ5tV
   OiYstH2hGfYqglmhvlBTykOqYKnwNcY7LA00conPoxh2f48mKLJnPPs8U
   tq1oLHjTHZ+/zeThGhQXFNkJD47+BbhcjsmI7eOwthlWtt6qAWvdsoSAJ
   HYBOHdgKGWQSLkWQoEMa/rKnDilSi6XfCaAUam3iOVOk/df81P2pj73sp
   pNmGUcnStleYEMHuLjrecOSpCxEKa8fM5SL3YAwHWIoBZEy613kCFt71u
   w==;
X-CSE-ConnectionGUID: RNlL8rweT2eyv5ZQzh5rNQ==
X-CSE-MsgGUID: 9DHtJJkzTQi+BUCYLXtyCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11374"; a="47109148"
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="47109148"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2025 19:52:18 -0700
X-CSE-ConnectionGUID: DmZPFNyiShKQBbU9dEJMFg==
X-CSE-MsgGUID: JzA70DqIS2eX0dJGPC7vQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,251,1736841600"; 
   d="scan'208";a="126486328"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 15 Mar 2025 19:52:15 -0700
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tte6n-000Bnh-1K;
	Sun, 16 Mar 2025 02:52:13 +0000
Date: Sun, 16 Mar 2025 10:51:51 +0800
From: kernel test robot <lkp@intel.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [tip:x86/asm 3/7] lib/test_bitmap.c:1269:2: error: call to
 '__compiletime_assert_279' declared with 'error' attribute: BUILD_BUG_ON
 failed: !__builtin_constant_p(res)
Message-ID: <202503161004.ZmMcxxeB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/asm
head:   9628d19e91f1ef9e7b1321e74a88bfa646d2a8d3
commit: 01ba23bf1b3f9a4035faedc2aa450e251bcc2c7c [3/7] x86/hweight: Use ASM_CALL_CONSTRAINT in inline asm()
config: x86_64-buildonly-randconfig-003-20250316 (https://download.01.org/0day-ci/archive/20250316/202503161004.ZmMcxxeB-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
rustc: rustc 1.78.0 (9b00956e5 2024-04-29)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250316/202503161004.ZmMcxxeB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503161004.ZmMcxxeB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_bitmap.c:1269:2: error: call to '__compiletime_assert_279' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
    1269 |         BUILD_BUG_ON(!__builtin_constant_p(res));
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:542:2: note: expanded from macro 'compiletime_assert'
     542 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:530:2: note: expanded from macro '_compiletime_assert'
     530 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:523:4: note: expanded from macro '__compiletime_assert'
     523 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:20:1: note: expanded from here
      20 | __compiletime_assert_279
         | ^
   1 error generated.


vim +1269 lib/test_bitmap.c

291f93ca339f5b5 Barry Song        2021-08-06  1227  
2356d198d2b4dde Yury Norov        2023-07-17  1228  /*
2356d198d2b4dde Yury Norov        2023-07-17  1229   * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
2356d198d2b4dde Yury Norov        2023-07-17  1230   * To workaround it, GCOV is force-disabled in Makefile for this configuration.
2356d198d2b4dde Yury Norov        2023-07-17  1231   */
dc34d5036692c61 Alexander Lobakin 2022-06-24  1232  static void __init test_bitmap_const_eval(void)
dc34d5036692c61 Alexander Lobakin 2022-06-24  1233  {
dc34d5036692c61 Alexander Lobakin 2022-06-24  1234  	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1235  	unsigned long initvar = BIT(2);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1236  	unsigned long bitopvar = 0;
dc34d5036692c61 Alexander Lobakin 2022-06-24  1237  	unsigned long var = 0;
dc34d5036692c61 Alexander Lobakin 2022-06-24  1238  	int res;
dc34d5036692c61 Alexander Lobakin 2022-06-24  1239  
dc34d5036692c61 Alexander Lobakin 2022-06-24  1240  	/*
dc34d5036692c61 Alexander Lobakin 2022-06-24  1241  	 * Compilers must be able to optimize all of those to compile-time
dc34d5036692c61 Alexander Lobakin 2022-06-24  1242  	 * constants on any supported optimization level (-O2, -Os) and any
dc34d5036692c61 Alexander Lobakin 2022-06-24  1243  	 * architecture. Otherwise, trigger a build bug.
dc34d5036692c61 Alexander Lobakin 2022-06-24  1244  	 * The whole function gets optimized out then, there's nothing to do
dc34d5036692c61 Alexander Lobakin 2022-06-24  1245  	 * in runtime.
dc34d5036692c61 Alexander Lobakin 2022-06-24  1246  	 */
dc34d5036692c61 Alexander Lobakin 2022-06-24  1247  
7adaf37f7f104a7 Alexander Lobakin 2024-03-27  1248  	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
dc34d5036692c61 Alexander Lobakin 2022-06-24  1249  	bitmap_clear(bitmap, 0, BITS_PER_LONG);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1250  	if (!test_bit(7, bitmap))
dc34d5036692c61 Alexander Lobakin 2022-06-24  1251  		bitmap_set(bitmap, 5, 2);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1252  
dc34d5036692c61 Alexander Lobakin 2022-06-24  1253  	/* Equals to `unsigned long bitopvar = BIT(20)` */
dc34d5036692c61 Alexander Lobakin 2022-06-24  1254  	__change_bit(31, &bitopvar);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1255  	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1256  
dc34d5036692c61 Alexander Lobakin 2022-06-24  1257  	/* Equals to `unsigned long var = BIT(25)` */
dc34d5036692c61 Alexander Lobakin 2022-06-24  1258  	var |= BIT(25);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1259  	if (var & BIT(0))
dc34d5036692c61 Alexander Lobakin 2022-06-24  1260  		var ^= GENMASK(9, 6);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1261  
dc34d5036692c61 Alexander Lobakin 2022-06-24  1262  	/* __const_hweight<32|64>(GENMASK(6, 5)) == 2 */
dc34d5036692c61 Alexander Lobakin 2022-06-24  1263  	res = bitmap_weight(bitmap, 20);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1264  	BUILD_BUG_ON(!__builtin_constant_p(res));
dc34d5036692c61 Alexander Lobakin 2022-06-24  1265  	BUILD_BUG_ON(res != 2);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1266  
dc34d5036692c61 Alexander Lobakin 2022-06-24  1267  	/* !(BIT(31) & BIT(18)) == 1 */
dc34d5036692c61 Alexander Lobakin 2022-06-24  1268  	res = !test_bit(18, &bitopvar);
dc34d5036692c61 Alexander Lobakin 2022-06-24 @1269  	BUILD_BUG_ON(!__builtin_constant_p(res));
dc34d5036692c61 Alexander Lobakin 2022-06-24  1270  	BUILD_BUG_ON(!res);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1271  
dc34d5036692c61 Alexander Lobakin 2022-06-24  1272  	/* BIT(2) & GENMASK(14, 8) == 0 */
dc34d5036692c61 Alexander Lobakin 2022-06-24  1273  	res = initvar & GENMASK(14, 8);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1274  	BUILD_BUG_ON(!__builtin_constant_p(res));
dc34d5036692c61 Alexander Lobakin 2022-06-24  1275  	BUILD_BUG_ON(res);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1276  
dc34d5036692c61 Alexander Lobakin 2022-06-24  1277  	/* ~BIT(25) */
dc34d5036692c61 Alexander Lobakin 2022-06-24  1278  	BUILD_BUG_ON(!__builtin_constant_p(~var));
dc34d5036692c61 Alexander Lobakin 2022-06-24  1279  	BUILD_BUG_ON(~var != ~BIT(25));
7adaf37f7f104a7 Alexander Lobakin 2024-03-27  1280  
7adaf37f7f104a7 Alexander Lobakin 2024-03-27  1281  	/* ~BIT(25) | BIT(25) == ~0UL */
7adaf37f7f104a7 Alexander Lobakin 2024-03-27  1282  	bitmap_complement(&var, &var, BITS_PER_LONG);
7adaf37f7f104a7 Alexander Lobakin 2024-03-27  1283  	__assign_bit(25, &var, true);
7adaf37f7f104a7 Alexander Lobakin 2024-03-27  1284  
7adaf37f7f104a7 Alexander Lobakin 2024-03-27  1285  	/* !(~(~0UL)) == 1 */
7adaf37f7f104a7 Alexander Lobakin 2024-03-27  1286  	res = bitmap_full(&var, BITS_PER_LONG);
7adaf37f7f104a7 Alexander Lobakin 2024-03-27  1287  	BUILD_BUG_ON(!__builtin_constant_p(res));
7adaf37f7f104a7 Alexander Lobakin 2024-03-27  1288  	BUILD_BUG_ON(!res);
dc34d5036692c61 Alexander Lobakin 2022-06-24  1289  }
dc34d5036692c61 Alexander Lobakin 2022-06-24  1290  

:::::: The code at line 1269 was first introduced by commit
:::::: dc34d5036692c614eef23c1130ee42a201c316bf lib: test_bitmap: add compile-time optimization/evaluations assertions

:::::: TO: Alexander Lobakin <alexandr.lobakin@intel.com>
:::::: CC: Yury Norov <yury.norov@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


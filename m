Return-Path: <linux-kernel+bounces-440500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D7A9EBF1F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2542841EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 23:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C93211267;
	Tue, 10 Dec 2024 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QiR2JomU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30791AA786
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 23:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733872468; cv=none; b=hc4mpUFevpW5u4YmeSTN0XeKvewpZYuyeBRctwBpGfthItXucCvf0X7STJPA4baNfLWgThbRtGEERRKRIgwbTMqSw22lW/LD6IGh3Eu5mfHebwXvjtMsdPhv8o1Jg4k/QO8gV2cvr5RHZRMU+juupFd+s4DYD1h60V8EGuPKvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733872468; c=relaxed/simple;
	bh=sMxyTXaK1INHLjl0ButgLtdGCEmZY9yLMJrZCZYThKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CKjkLAk7H70AdN9OHVkrsQY6eGyS1wonpsiW3sjiTVSjSR+ijYkuZvRbBo2F5I7ERhOq4BrxQZWhqFhC7o3eDLGDaIG8Ojw45jx0QDFM7XtgGI5VhUXrt4tFzVqRpjh+s9cWJlIuMCJHu/8Sfk5YBkLuqWHf0vikHH6BjsM8jC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QiR2JomU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733872466; x=1765408466;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sMxyTXaK1INHLjl0ButgLtdGCEmZY9yLMJrZCZYThKk=;
  b=QiR2JomUrd4N34n5sVb3TyXPXEqlyqRxuYwNzDHfa6J+fB9HLw6YyJnt
   qxWA6+Ynf5IbB/QTKyhM1hUaEBl/X97gY6l2RE9uG11zuOKNMD393bwg9
   Em8OCpi9gcbbhx6YOo+nCTUxBljDSS20AUScoHXXOagIoTbSNTdFD89eu
   JUt9V+jVT3dSOeI30glhPV0ogKyCUQAo5oFhmTEytqtAz4X6Hzp7MaJ5R
   fauWSbzX4eXNpx7ouXBQRmBQTKT4guQc8iydPC6GKiF/Mo35fPJPvKF3w
   X8m0gQ8Xye6rSjyOZrBU9isdPPy6DBzlSb0kNWbM0jQJkPmuM1YmFvOQr
   A==;
X-CSE-ConnectionGUID: Ia8baK5STEifwQ5hkpjiCg==
X-CSE-MsgGUID: E2Kuu7XtRRSBMQFxPu5Lzw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="37072622"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="37072622"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 15:14:25 -0800
X-CSE-ConnectionGUID: ojG+ZhnvTsyhIf2SJnGYyQ==
X-CSE-MsgGUID: p3OjC40RTQu6in3XZHOkuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="95381248"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 10 Dec 2024 15:14:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tL9Qr-00062l-0j;
	Tue, 10 Dec 2024 23:14:21 +0000
Date: Wed, 11 Dec 2024 07:13:27 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: lib/test_bitmap.c:1269:2: error: call to '__compiletime_assert_319'
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Message-ID: <202412110749.wvVKE7sn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7cb1b466315004af98f6ba6c2546bb713ca3c237
commit: 53585f9ea40a9466ab9c1151f15984513eb542f7 um: enable UBSAN
date:   5 months ago
config: um-randconfig-r131-20241210 (https://download.01.org/0day-ci/archive/20241211/202412110749.wvVKE7sn-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412110749.wvVKE7sn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412110749.wvVKE7sn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_bitmap.c:1269:2: error: call to '__compiletime_assert_319' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
    1269 |         BUILD_BUG_ON(!__builtin_constant_p(res));
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:510:2: note: expanded from macro 'compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:498:2: note: expanded from macro '_compiletime_assert'
     498 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:491:4: note: expanded from macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:248:1: note: expanded from here
     248 | __compiletime_assert_319
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


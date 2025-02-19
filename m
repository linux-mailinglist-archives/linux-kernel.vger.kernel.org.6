Return-Path: <linux-kernel+bounces-520754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC2A3AEC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ACA716AF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89ED7DA95;
	Wed, 19 Feb 2025 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HtRveGUe"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5F346447
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928062; cv=none; b=AbpNZ2pmes8uqmtWOrHgLa8ejLCsbdN6lweksh6bZtvTf1TJYtSezjPqDQ3Yplie1hxawIsUCBUpt3TtPK0XaYHxpU54yF51u5Y4eZJpDTFvlosQjSoz5HSIhGew3nIlX/J4//3xETUvUwfV+s2zhLcnlo92WJlADu0hWMf3/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928062; c=relaxed/simple;
	bh=bmGa4eWhcR5L/dcLtERr3EI/+tCNKeqmsPcoVSPYgqo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qTVrsmjVa/3jvuzEvlbzPqur5/AGgH0UqtZz++RkH7RkVPgnhYX2M4e/Y3JXl9VsuJUrAouGPbpIRsL6mMkHhAEz09DmY1Pnd2q2t+kAaTwj8vcGNXHhZ8uAxEBtTTLhhe2sKyTMtXYj4A6u77ZSkt6bwfEtFvSTOwVpNOANfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HtRveGUe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739928059; x=1771464059;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bmGa4eWhcR5L/dcLtERr3EI/+tCNKeqmsPcoVSPYgqo=;
  b=HtRveGUeFH19MNEtYGdGWlecAJX5h4rD90YP9f14CUDget/U5yBMEKAu
   MxjSX09LAYG0JDUN3sRAYk2tnFtoAp/UPCt/BD2aKrqN+SpT/26eIZ02J
   e5Vwp5ammT01HcG98eZtDH99CxayO2xEjsnJPO1OTU5bG+owjJ+hLs0R9
   RRyaX0ADq4x7WoobPwvp/HzWxPTnlTE+atuaYVZ+2PmUZlpinPSK/+SQ6
   ePOqE0VhDuqXedVwctNcJJWT36R85bLTGPzswp8JYtwF+ivi7kzcLIkKG
   LRk08G8KkpzNY7mbic89uLrBGTIIVIi4VDzwfdYyLICRE+1nEX5QlV6RF
   w==;
X-CSE-ConnectionGUID: UnC7H9oFQneujfmqat6T5w==
X-CSE-MsgGUID: 3Y2+WoFSTuanOIuZOkZHpA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40664950"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="40664950"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 17:20:59 -0800
X-CSE-ConnectionGUID: 996Lsse9T463d1aJofebNg==
X-CSE-MsgGUID: JeTMi8TOSAWz1KALl72DPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; 
   d="scan'208";a="114304361"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 18 Feb 2025 17:20:57 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tkYlj-00013i-0g;
	Wed, 19 Feb 2025 01:20:55 +0000
Date: Wed, 19 Feb 2025 09:20:30 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Yury Norov <yury.norov@gmail.com>
Subject: lib/test_bitmap.c:1269:2: error: call to '__compiletime_assert_135'
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(res)
Message-ID: <202502190910.LTEnPYuL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexander,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6537cfb395f352782918d8ee7b7f10ba2cc3cbf2
commit: 7adaf37f7f104a7ee5f150af491674ccbbfc4114 lib/bitmap: add compile-time test for __assign_bit() optimization
date:   11 months ago
config: um-randconfig-002-20250219 (https://download.01.org/0day-ci/archive/20250219/202502190910.LTEnPYuL-lkp@intel.com/config)
compiler: clang version 21.0.0git (https://github.com/llvm/llvm-project 910be4ff90d7d07bd4518ea03b85c0974672bf9c)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250219/202502190910.LTEnPYuL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502190910.LTEnPYuL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_bitmap.c:1269:2: error: call to '__compiletime_assert_135' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(res)
    1269 |         BUILD_BUG_ON(!__builtin_constant_p(res));
         |         ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^
   include/linux/compiler_types.h:460:2: note: expanded from macro 'compiletime_assert'
     460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^
   include/linux/compiler_types.h:448:2: note: expanded from macro '_compiletime_assert'
     448 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:441:4: note: expanded from macro '__compiletime_assert'
     441 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:252:1: note: expanded from here
     252 | __compiletime_assert_135
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


Return-Path: <linux-kernel+bounces-342300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B851988D3D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 03:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3621A1F22212
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 01:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C05156E4;
	Sat, 28 Sep 2024 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUWOdofk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC31804F
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 01:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727485738; cv=none; b=uk//jqnBBFdHjzRDy6flVRbKzhX+8s3GSvrmvk6qiwmEppPDeRj/VV3jTUegZ2XBHHaDvSklsOAaXR+AxFjVHK3MifSpJrlWkVekR+iSuK4TyDkGEig5r+L9GMn340RmU3hWHGUMvUkD2f00uezO+fgXXOv+eicvnQpwV3C6U98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727485738; c=relaxed/simple;
	bh=tIkbu7bHeOb9D1HI4qL1/B+dDrQy6d8C5FTocTLejP4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ahoFcrSwVfImg/zwL16vGuGkE1xd9I0LAzOO+QiiGkK7uswmw0Ekxyh0Td/zrJL8Cq6hPNHRFo+ZJqpmkM9HTd4N6svS4S0mJtiKPj1oA+TP7EN/zh6SJC8+Afki5nXo20PoFedXj7o8CpsrLahw3yltZUpKnIr/rHnuI3HJe2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUWOdofk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727485735; x=1759021735;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tIkbu7bHeOb9D1HI4qL1/B+dDrQy6d8C5FTocTLejP4=;
  b=WUWOdofk/YnyncKUi9rCjFYUO97PrQBdM1q3JLCla2PW72bo91+y6XhF
   QUPdtBRhysCaLVLCcrJDTB9WA0DtbwsQi/JWSiq7BHA3zU6ZsCmKVhvw0
   uX+jrTPZtpSgWMvnPdeWF0gok+fkBSR0hcgTH8+c2Jc9YRrGysP+GyVGk
   sEJbUaXX/Ccs7uSr3ezKOB2JlF4Ebu2ZhUEI3ZY9ZYes6GbWpcZTmIa4L
   WJnIoJHE7HERkf0cVvOr0pRukmblcZW3QW/MNaUOewJ2AdIJpSfXaw6fd
   mAJ7ab1zWwHEGGYEsQkqXoupqAbyXe6a7NxDGeRGFPzyOUY5y1FNF39Eh
   w==;
X-CSE-ConnectionGUID: SMgBToCRSMayzW81w/26aA==
X-CSE-MsgGUID: 6vYdOhM5QkSg09M7DkL2bA==
X-IronPort-AV: E=McAfee;i="6700,10204,11208"; a="37317531"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="37317531"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 18:08:54 -0700
X-CSE-ConnectionGUID: oYqB2EUSQh+wWoScOCLzlw==
X-CSE-MsgGUID: V8EoWmWmSU+41w/UxEz/OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="72858179"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 Sep 2024 18:08:53 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1suLx5-000MnZ-1R;
	Sat, 28 Sep 2024 01:08:51 +0000
Date: Sat, 28 Sep 2024 09:08:15 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: lib/test_bitmap.c:1278:2: error: call to '__compiletime_assert_323'
 declared with 'error' attribute: BUILD_BUG_ON failed:
 !__builtin_constant_p(~var)
Message-ID: <202409280827.cJhbIO0y-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Johannes,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ad46e8f95e931e113cb98253daf6d443ac244cde
commit: 53585f9ea40a9466ab9c1151f15984513eb542f7 um: enable UBSAN
date:   3 months ago
config: um-randconfig-r073-20240928 (https://download.01.org/0day-ci/archive/20240928/202409280827.cJhbIO0y-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 7773243d9916f98ba0ffce0c3a960e4aa9f03e81)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240928/202409280827.cJhbIO0y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409280827.cJhbIO0y-lkp@intel.com/

All errors (new ones prefixed by >>):

>> lib/test_bitmap.c:1278:2: error: call to '__compiletime_assert_323' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(~var)
    1278 |         BUILD_BUG_ON(!__builtin_constant_p(~var));
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
   <scratch space>:27:1: note: expanded from here
      27 | __compiletime_assert_323
         | ^
   1 error generated.


vim +1278 lib/test_bitmap.c

291f93ca339f5b Barry Song        2021-08-06  1227  
2356d198d2b4dd Yury Norov        2023-07-17  1228  /*
2356d198d2b4dd Yury Norov        2023-07-17  1229   * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
2356d198d2b4dd Yury Norov        2023-07-17  1230   * To workaround it, GCOV is force-disabled in Makefile for this configuration.
2356d198d2b4dd Yury Norov        2023-07-17  1231   */
dc34d5036692c6 Alexander Lobakin 2022-06-24  1232  static void __init test_bitmap_const_eval(void)
dc34d5036692c6 Alexander Lobakin 2022-06-24  1233  {
dc34d5036692c6 Alexander Lobakin 2022-06-24  1234  	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1235  	unsigned long initvar = BIT(2);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1236  	unsigned long bitopvar = 0;
dc34d5036692c6 Alexander Lobakin 2022-06-24  1237  	unsigned long var = 0;
dc34d5036692c6 Alexander Lobakin 2022-06-24  1238  	int res;
dc34d5036692c6 Alexander Lobakin 2022-06-24  1239  
dc34d5036692c6 Alexander Lobakin 2022-06-24  1240  	/*
dc34d5036692c6 Alexander Lobakin 2022-06-24  1241  	 * Compilers must be able to optimize all of those to compile-time
dc34d5036692c6 Alexander Lobakin 2022-06-24  1242  	 * constants on any supported optimization level (-O2, -Os) and any
dc34d5036692c6 Alexander Lobakin 2022-06-24  1243  	 * architecture. Otherwise, trigger a build bug.
dc34d5036692c6 Alexander Lobakin 2022-06-24  1244  	 * The whole function gets optimized out then, there's nothing to do
dc34d5036692c6 Alexander Lobakin 2022-06-24  1245  	 * in runtime.
dc34d5036692c6 Alexander Lobakin 2022-06-24  1246  	 */
dc34d5036692c6 Alexander Lobakin 2022-06-24  1247  
7adaf37f7f104a Alexander Lobakin 2024-03-27  1248  	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
dc34d5036692c6 Alexander Lobakin 2022-06-24  1249  	bitmap_clear(bitmap, 0, BITS_PER_LONG);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1250  	if (!test_bit(7, bitmap))
dc34d5036692c6 Alexander Lobakin 2022-06-24  1251  		bitmap_set(bitmap, 5, 2);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1252  
dc34d5036692c6 Alexander Lobakin 2022-06-24  1253  	/* Equals to `unsigned long bitopvar = BIT(20)` */
dc34d5036692c6 Alexander Lobakin 2022-06-24  1254  	__change_bit(31, &bitopvar);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1255  	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1256  
dc34d5036692c6 Alexander Lobakin 2022-06-24  1257  	/* Equals to `unsigned long var = BIT(25)` */
dc34d5036692c6 Alexander Lobakin 2022-06-24  1258  	var |= BIT(25);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1259  	if (var & BIT(0))
dc34d5036692c6 Alexander Lobakin 2022-06-24  1260  		var ^= GENMASK(9, 6);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1261  
dc34d5036692c6 Alexander Lobakin 2022-06-24  1262  	/* __const_hweight<32|64>(GENMASK(6, 5)) == 2 */
dc34d5036692c6 Alexander Lobakin 2022-06-24  1263  	res = bitmap_weight(bitmap, 20);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1264  	BUILD_BUG_ON(!__builtin_constant_p(res));
dc34d5036692c6 Alexander Lobakin 2022-06-24  1265  	BUILD_BUG_ON(res != 2);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1266  
dc34d5036692c6 Alexander Lobakin 2022-06-24  1267  	/* !(BIT(31) & BIT(18)) == 1 */
dc34d5036692c6 Alexander Lobakin 2022-06-24  1268  	res = !test_bit(18, &bitopvar);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1269  	BUILD_BUG_ON(!__builtin_constant_p(res));
dc34d5036692c6 Alexander Lobakin 2022-06-24  1270  	BUILD_BUG_ON(!res);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1271  
dc34d5036692c6 Alexander Lobakin 2022-06-24  1272  	/* BIT(2) & GENMASK(14, 8) == 0 */
dc34d5036692c6 Alexander Lobakin 2022-06-24  1273  	res = initvar & GENMASK(14, 8);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1274  	BUILD_BUG_ON(!__builtin_constant_p(res));
dc34d5036692c6 Alexander Lobakin 2022-06-24  1275  	BUILD_BUG_ON(res);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1276  
dc34d5036692c6 Alexander Lobakin 2022-06-24  1277  	/* ~BIT(25) */
dc34d5036692c6 Alexander Lobakin 2022-06-24 @1278  	BUILD_BUG_ON(!__builtin_constant_p(~var));
dc34d5036692c6 Alexander Lobakin 2022-06-24  1279  	BUILD_BUG_ON(~var != ~BIT(25));
7adaf37f7f104a Alexander Lobakin 2024-03-27  1280  
7adaf37f7f104a Alexander Lobakin 2024-03-27  1281  	/* ~BIT(25) | BIT(25) == ~0UL */
7adaf37f7f104a Alexander Lobakin 2024-03-27  1282  	bitmap_complement(&var, &var, BITS_PER_LONG);
7adaf37f7f104a Alexander Lobakin 2024-03-27  1283  	__assign_bit(25, &var, true);
7adaf37f7f104a Alexander Lobakin 2024-03-27  1284  
7adaf37f7f104a Alexander Lobakin 2024-03-27  1285  	/* !(~(~0UL)) == 1 */
7adaf37f7f104a Alexander Lobakin 2024-03-27  1286  	res = bitmap_full(&var, BITS_PER_LONG);
7adaf37f7f104a Alexander Lobakin 2024-03-27  1287  	BUILD_BUG_ON(!__builtin_constant_p(res));
7adaf37f7f104a Alexander Lobakin 2024-03-27  1288  	BUILD_BUG_ON(!res);
dc34d5036692c6 Alexander Lobakin 2022-06-24  1289  }
dc34d5036692c6 Alexander Lobakin 2022-06-24  1290  

:::::: The code at line 1278 was first introduced by commit
:::::: dc34d5036692c614eef23c1130ee42a201c316bf lib: test_bitmap: add compile-time optimization/evaluations assertions

:::::: TO: Alexander Lobakin <alexandr.lobakin@intel.com>
:::::: CC: Yury Norov <yury.norov@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


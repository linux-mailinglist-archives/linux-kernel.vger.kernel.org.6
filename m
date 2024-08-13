Return-Path: <linux-kernel+bounces-285552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F12950F88
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6B01F230BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58E21AAE2B;
	Tue, 13 Aug 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhrM7kIN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49326AFB;
	Tue, 13 Aug 2024 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723587146; cv=none; b=tsiD9R03OUoZ5m9RCRmJ5XdE6MIvI5OORlZ3EyXgHqzEz3PsFwhwWa1n7BtS9k534GISbkJwR18lKn8bh6+1eBmGHsQ5wYEAw90DfqbVeE+dJZxav6cHuoWIDVGBLF19EgHoG9RnOaFrlUGmqRTUmf8lzeCnUKv/9TSZ3oT/pA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723587146; c=relaxed/simple;
	bh=nNhcw7GB8NcDgN2OIa/5pzlGkqY40T6fJOTJq7Kn/28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sE4mxUXbDucxoCV3FxIbBBC7yeDpClF8VbHv0ytxWhcjVl5NTEn9uUgVb3YSh67Ql7yI/VrhAA5guC0y2hmbSuTYZ58FLe9EyHSuLcdxKA4fNHWnexVkX8KXTA5tDd4JpwEbfU84YYiSu8KdKYe280aMQ2m2ZCsVDaCz/lXkISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhrM7kIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701E6C32782;
	Tue, 13 Aug 2024 22:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723587144;
	bh=nNhcw7GB8NcDgN2OIa/5pzlGkqY40T6fJOTJq7Kn/28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhrM7kINDPMWXeggXL9i/Sehk6QeQkOlY6YuW3N0PCtlBBKKPIdacuVrDOiMpuc9R
	 JzyV4H8XiE5h1T9b1SD6N6CiM+tRiKKT3e4rmNioBE5Qm2Bnv425bIBn3QxnpAOBsL
	 sm+mUcJLQsA+XYULobmzec4iA5hB+F+6/VSADvIDq4DWPrGliU2+zf8pXIfovm1xhP
	 X0cY2G+XPjBl0fMqkfYOnif8907g4bvwWg335XqYg1O2NM5mSod3aaFXtHk7hHmOGj
	 gxLsC0ERARklGslq/Rc6ocX3dwA4dujazUkb9x4koaLeDd9GILrVoZnAVrKzonVUuK
	 ioyfv7Jzerbyg==
Date: Tue, 13 Aug 2024 15:12:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <kees@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	llvm-bugs@lists.llvm.org
Subject: Re: lib/test_bitmap.c:1278:2: error: call to
 '__compiletime_assert_127' declared with 'error' attribute: BUILD_BUG_ON
 failed: !__builtin_constant_p(~var)
Message-ID: <20240813221221.GA798176@thelio-3990X>
References: <202408131601.Aj9JmK7K-lkp@intel.com>
 <2690861a-e726-4149-98ff-d26ec6d595ac@intel.com>
 <Zru4T-aIsqeM9Fxk@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zru4T-aIsqeM9Fxk@yury-ThinkPad>

On Tue, Aug 13, 2024 at 12:47:27PM -0700, Yury Norov wrote:
> On Tue, Aug 13, 2024 at 04:38:10PM +0200, Alexander Lobakin wrote:
> > From: Kernel Test Robot <lkp@intel.com>
> > Date: Tue, 13 Aug 2024 17:00:56 +0800
> > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   d74da846046aeec9333e802f5918bd3261fb5509
> > > commit: 7adaf37f7f104a7ee5f150af491674ccbbfc4114 lib/bitmap: add compile-time test for __assign_bit() optimization
> > > date:   4 months ago
> > > config: um-randconfig-r132-20240812 (https://download.01.org/0day-ci/archive/20240813/202408131601.Aj9JmK7K-lkp@intel.com/config)
> > > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408131601.Aj9JmK7K-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202408131601.Aj9JmK7K-lkp@intel.com/
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >>> lib/test_bitmap.c:1278:2: error: call to '__compiletime_assert_127' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(~var)
> > >     1278 |         BUILD_BUG_ON(!__builtin_constant_p(~var));
> > >          |         ^
> > >    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
> > >       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> > >          |         ^
> > >    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
> > >       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> > >          |                                     ^
> > >    include/linux/compiler_types.h:460:2: note: expanded from macro 'compiletime_assert'
> > >      460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> > >          |         ^
> > >    include/linux/compiler_types.h:448:2: note: expanded from macro '_compiletime_assert'
> > >      448 |         __compiletime_assert(condition, msg, prefix, suffix)
> > >          |         ^
> > >    include/linux/compiler_types.h:441:4: note: expanded from macro '__compiletime_assert'
> > >      441 |                         prefix ## suffix();                             \
> > >          |                         ^
> > >    <scratch space>:193:1: note: expanded from here
> > >      193 | __compiletime_assert_127
> > >          | ^
> > >    1 error generated.
> > > 
> > > 
> > > vim +1278 lib/test_bitmap.c
> > > 
> > > 291f93ca339f5b Barry Song        2021-08-06  1227  
> > > 2356d198d2b4dd Yury Norov        2023-07-17  1228  /*
> > > 2356d198d2b4dd Yury Norov        2023-07-17  1229   * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
> > > 2356d198d2b4dd Yury Norov        2023-07-17  1230   * To workaround it, GCOV is force-disabled in Makefile for this configuration.
> > > 2356d198d2b4dd Yury Norov        2023-07-17  1231   */
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1232  static void __init test_bitmap_const_eval(void)
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1233  {
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1234  	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1235  	unsigned long initvar = BIT(2);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1236  	unsigned long bitopvar = 0;
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1237  	unsigned long var = 0;
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1238  	int res;
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1239  
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1240  	/*
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1241  	 * Compilers must be able to optimize all of those to compile-time
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1242  	 * constants on any supported optimization level (-O2, -Os) and any
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1243  	 * architecture. Otherwise, trigger a build bug.
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1244  	 * The whole function gets optimized out then, there's nothing to do
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1245  	 * in runtime.
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1246  	 */
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1247  
> > > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1248  	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1249  	bitmap_clear(bitmap, 0, BITS_PER_LONG);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1250  	if (!test_bit(7, bitmap))
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1251  		bitmap_set(bitmap, 5, 2);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1252  
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1253  	/* Equals to `unsigned long bitopvar = BIT(20)` */
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1254  	__change_bit(31, &bitopvar);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1255  	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1256  
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1257  	/* Equals to `unsigned long var = BIT(25)` */
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1258  	var |= BIT(25);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1259  	if (var & BIT(0))
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1260  		var ^= GENMASK(9, 6);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1261  
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1262  	/* __const_hweight<32|64>(GENMASK(6, 5)) == 2 */
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1263  	res = bitmap_weight(bitmap, 20);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1264  	BUILD_BUG_ON(!__builtin_constant_p(res));
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1265  	BUILD_BUG_ON(res != 2);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1266  
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1267  	/* !(BIT(31) & BIT(18)) == 1 */
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1268  	res = !test_bit(18, &bitopvar);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1269  	BUILD_BUG_ON(!__builtin_constant_p(res));
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1270  	BUILD_BUG_ON(!res);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1271  
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1272  	/* BIT(2) & GENMASK(14, 8) == 0 */
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1273  	res = initvar & GENMASK(14, 8);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1274  	BUILD_BUG_ON(!__builtin_constant_p(res));
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1275  	BUILD_BUG_ON(res);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1276  
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1277  	/* ~BIT(25) */
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24 @1278  	BUILD_BUG_ON(!__builtin_constant_p(~var));
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1279  	BUILD_BUG_ON(~var != ~BIT(25));
> > > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1280  
> > > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1281  	/* ~BIT(25) | BIT(25) == ~0UL */
> > > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1282  	bitmap_complement(&var, &var, BITS_PER_LONG);
> > > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1283  	__assign_bit(25, &var, true);
> > > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1284  
> > > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1285  	/* !(~(~0UL)) == 1 */
> > > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1286  	res = bitmap_full(&var, BITS_PER_LONG);
> > > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1287  	BUILD_BUG_ON(!__builtin_constant_p(res));
> > > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1288  	BUILD_BUG_ON(!res);
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1289  }
> > > dc34d5036692c6 Alexander Lobakin 2022-06-24  1290  
> > > 
> > > :::::: The code at line 1278 was first introduced by commit
> > > :::::: dc34d5036692c614eef23c1130ee42a201c316bf lib: test_bitmap: add compile-time optimization/evaluations assertions
> > > 
> > > :::::: TO: Alexander Lobakin <alexandr.lobakin@intel.com>
> > > :::::: CC: Yury Norov <yury.norov@gmail.com>
> > 
> > + Cc Clang folks.
> > 
> > clang-dev 20 issue?
> > 
> > Thanks,
> > Olek
> 
> Seems like that. Looping LLVM-bugs <llvm-bugs@lists.llvm.org>.

It's not, I bisected it to a change in the 17 release. I think this only
shows up with this change because of '-fprofile-instr-generate', which
ARCH=um uses for GCOV, which was only added in commit 32a84cfc6caf
("arch: um: Add Clang coverage support") from 6.8.

I reported this upstream (I don't think llvm-bugs is really monitored
for traffic like this) and cc'd the author of the change that broke
this:

https://github.com/llvm/llvm-project/issues/103479

I think there is a tangential issue with ARCH=um doing its own thing
with the GCOV flags (such that it does not appear to respect
GCOV_PROFILE_... := n) but that just results in not being able to remove
the flags from test_bitmap.o's command.

Cheers,
Nathan


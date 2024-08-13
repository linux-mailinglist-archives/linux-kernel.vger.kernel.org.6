Return-Path: <linux-kernel+bounces-285426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40016950D57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64AE91C223BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BE21A2C2A;
	Tue, 13 Aug 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhsHdHKU"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615C1A2C0F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723578453; cv=none; b=ITxaKs5Mu8aSYXfaR96MEWgeTD18jpmevT0C/Y13UCvvZsvM3ASLiTr3yoFSjRMxVld3v1p5VOe+pu4MkPgLDT3K3lxJH7w3/Yi7lwc4WD1z+ZcqCfz7YVD/cVm8UNFIexicvFBL8W1ETpkHjJIKKJbpue8mqKHPz62hkt5/QdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723578453; c=relaxed/simple;
	bh=D9EmZGcYIFN8nYMccR92qu5/EAch3Hfp/dc2IkePFKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VV/ygr0PD/YW6O818WYvZw6eCippkesmN2eANcokOVx+jWtPjDM0bJMJNcfZtNHA/I44oOwZGCuGcV2SL5uopIRMD29wgWbHOWHJZN5jQZydThZZnIewHWSWQ74h71RMfARQWo6QEwcNAkhT2UOO0jyORwsVt275L4YLwPyvoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhsHdHKU; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d1bb65e906so3869250a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723578451; x=1724183251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q3nYgmk8Cs4TQTo24ByTlBnkZOowuAYQrFozF+3KiU=;
        b=lhsHdHKUwJAetYOYgUgxtZkHIXEYnE5sb0Wfezpm4Yq1E34hMZ9TEo3rrGiOy1O5TF
         1vgPMxH0zbdcwZkqXuHph3tB0FLxafCNycMt4EoUmclItJQTf2w7covADblr0VtFgkrD
         Kj4/Zsj/HQTpbpW/oyJlchGUZ+TQLbwJ8GIhFadC00lXa8fkdYxRERGstJi2wJW6JPvR
         T4bvRuBv4OyJ8k1ytJsoqsDQjMRvciZcCDHSY0OjtV2nbP4IZxmfr+89RJZFh3XUJ9V0
         FGjgEHc+2gdyeYWMk1OE0krFgTlldxHmklYXM5Kt0xghw+9xtvL6IldlnjXANH37neSo
         Uo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723578451; x=1724183251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q3nYgmk8Cs4TQTo24ByTlBnkZOowuAYQrFozF+3KiU=;
        b=wntVFteY11ChvKPNp2dGJdtDaGjrN4anheAoYJ+bNvno513+Q+QjK5D8CQXo1Wj1up
         F5iGZ7JppeT6rN84h8JAzNVrq+WXZNwx7at3HQthrfL3JFOp4bEL6crRS4ieJYlaxJr7
         QZ/aooH4ok88muFJkSJFKbSk2c3qusqxagGJ8m7uo5nv1Q01jt2scng9vvP+9ZD2RULo
         esS/TylO4G3v+iBV/tD2A7ggI8VcRYgBJKMhXuA1fe7JljUbW0xh55ZyV+CAIVgYSegy
         pUkEFgznUaTHOwMJH1RHlX+ZN3zNAvI30R2kFYWOY4SzWQHrDYWMNwGIC0ifn7i+eYjp
         Nlrg==
X-Forwarded-Encrypted: i=1; AJvYcCWvr8p5ij0bqnHvL7IXf75Hgp6qh57AfqOx2FewAOAOQJwgLu7W/oFJ2wX9nfO5fnruA7x9DrIgrmbBDRGbS6wnPtvDV79WLRhu3UUH
X-Gm-Message-State: AOJu0YyKGJhfyssfkEfdlmll+WWMAHFwzpzP+DNFOPZrzCjr++spwQs0
	OhxYi99KQeoQG4Y9c82sotUhf4Z2R/ac4gA1qACQazbdO2V7uDVG
X-Google-Smtp-Source: AGHT+IG8lCzp7wbUsXu/ZQE/fHDUHeqmPZEqw7QhDJ3UBx2HARa4UT5RJdLBClplYVQC2+1y95B9yA==
X-Received: by 2002:a17:90a:668b:b0:2ca:f39c:8d76 with SMTP id 98e67ed59e1d1-2d3aab7b382mr688666a91.39.1723578450490;
        Tue, 13 Aug 2024 12:47:30 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fcfe3e12sm7736720a91.41.2024.08.13.12.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:47:29 -0700 (PDT)
Date: Tue, 13 Aug 2024 12:47:27 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Kees Cook <kees@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	llvm-bugs@lists.llvm.org
Subject: Re: lib/test_bitmap.c:1278:2: error: call to
 '__compiletime_assert_127' declared with 'error' attribute: BUILD_BUG_ON
 failed: !__builtin_constant_p(~var)
Message-ID: <Zru4T-aIsqeM9Fxk@yury-ThinkPad>
References: <202408131601.Aj9JmK7K-lkp@intel.com>
 <2690861a-e726-4149-98ff-d26ec6d595ac@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2690861a-e726-4149-98ff-d26ec6d595ac@intel.com>

On Tue, Aug 13, 2024 at 04:38:10PM +0200, Alexander Lobakin wrote:
> From: Kernel Test Robot <lkp@intel.com>
> Date: Tue, 13 Aug 2024 17:00:56 +0800
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d74da846046aeec9333e802f5918bd3261fb5509
> > commit: 7adaf37f7f104a7ee5f150af491674ccbbfc4114 lib/bitmap: add compile-time test for __assign_bit() optimization
> > date:   4 months ago
> > config: um-randconfig-r132-20240812 (https://download.01.org/0day-ci/archive/20240813/202408131601.Aj9JmK7K-lkp@intel.com/config)
> > compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408131601.Aj9JmK7K-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202408131601.Aj9JmK7K-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> >>> lib/test_bitmap.c:1278:2: error: call to '__compiletime_assert_127' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(~var)
> >     1278 |         BUILD_BUG_ON(!__builtin_constant_p(~var));
> >          |         ^
> >    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
> >       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> >          |         ^
> >    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
> >       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >          |                                     ^
> >    include/linux/compiler_types.h:460:2: note: expanded from macro 'compiletime_assert'
> >      460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >          |         ^
> >    include/linux/compiler_types.h:448:2: note: expanded from macro '_compiletime_assert'
> >      448 |         __compiletime_assert(condition, msg, prefix, suffix)
> >          |         ^
> >    include/linux/compiler_types.h:441:4: note: expanded from macro '__compiletime_assert'
> >      441 |                         prefix ## suffix();                             \
> >          |                         ^
> >    <scratch space>:193:1: note: expanded from here
> >      193 | __compiletime_assert_127
> >          | ^
> >    1 error generated.
> > 
> > 
> > vim +1278 lib/test_bitmap.c
> > 
> > 291f93ca339f5b Barry Song        2021-08-06  1227  
> > 2356d198d2b4dd Yury Norov        2023-07-17  1228  /*
> > 2356d198d2b4dd Yury Norov        2023-07-17  1229   * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
> > 2356d198d2b4dd Yury Norov        2023-07-17  1230   * To workaround it, GCOV is force-disabled in Makefile for this configuration.
> > 2356d198d2b4dd Yury Norov        2023-07-17  1231   */
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1232  static void __init test_bitmap_const_eval(void)
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1233  {
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1234  	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1235  	unsigned long initvar = BIT(2);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1236  	unsigned long bitopvar = 0;
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1237  	unsigned long var = 0;
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1238  	int res;
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1239  
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1240  	/*
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1241  	 * Compilers must be able to optimize all of those to compile-time
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1242  	 * constants on any supported optimization level (-O2, -Os) and any
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1243  	 * architecture. Otherwise, trigger a build bug.
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1244  	 * The whole function gets optimized out then, there's nothing to do
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1245  	 * in runtime.
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1246  	 */
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1247  
> > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1248  	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1249  	bitmap_clear(bitmap, 0, BITS_PER_LONG);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1250  	if (!test_bit(7, bitmap))
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1251  		bitmap_set(bitmap, 5, 2);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1252  
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1253  	/* Equals to `unsigned long bitopvar = BIT(20)` */
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1254  	__change_bit(31, &bitopvar);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1255  	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1256  
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1257  	/* Equals to `unsigned long var = BIT(25)` */
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1258  	var |= BIT(25);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1259  	if (var & BIT(0))
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1260  		var ^= GENMASK(9, 6);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1261  
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1262  	/* __const_hweight<32|64>(GENMASK(6, 5)) == 2 */
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1263  	res = bitmap_weight(bitmap, 20);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1264  	BUILD_BUG_ON(!__builtin_constant_p(res));
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1265  	BUILD_BUG_ON(res != 2);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1266  
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1267  	/* !(BIT(31) & BIT(18)) == 1 */
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1268  	res = !test_bit(18, &bitopvar);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1269  	BUILD_BUG_ON(!__builtin_constant_p(res));
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1270  	BUILD_BUG_ON(!res);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1271  
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1272  	/* BIT(2) & GENMASK(14, 8) == 0 */
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1273  	res = initvar & GENMASK(14, 8);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1274  	BUILD_BUG_ON(!__builtin_constant_p(res));
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1275  	BUILD_BUG_ON(res);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1276  
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1277  	/* ~BIT(25) */
> > dc34d5036692c6 Alexander Lobakin 2022-06-24 @1278  	BUILD_BUG_ON(!__builtin_constant_p(~var));
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1279  	BUILD_BUG_ON(~var != ~BIT(25));
> > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1280  
> > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1281  	/* ~BIT(25) | BIT(25) == ~0UL */
> > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1282  	bitmap_complement(&var, &var, BITS_PER_LONG);
> > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1283  	__assign_bit(25, &var, true);
> > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1284  
> > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1285  	/* !(~(~0UL)) == 1 */
> > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1286  	res = bitmap_full(&var, BITS_PER_LONG);
> > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1287  	BUILD_BUG_ON(!__builtin_constant_p(res));
> > 7adaf37f7f104a Alexander Lobakin 2024-03-27  1288  	BUILD_BUG_ON(!res);
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1289  }
> > dc34d5036692c6 Alexander Lobakin 2022-06-24  1290  
> > 
> > :::::: The code at line 1278 was first introduced by commit
> > :::::: dc34d5036692c614eef23c1130ee42a201c316bf lib: test_bitmap: add compile-time optimization/evaluations assertions
> > 
> > :::::: TO: Alexander Lobakin <alexandr.lobakin@intel.com>
> > :::::: CC: Yury Norov <yury.norov@gmail.com>
> 
> + Cc Clang folks.
> 
> clang-dev 20 issue?
> 
> Thanks,
> Olek

Seems like that. Looping LLVM-bugs <llvm-bugs@lists.llvm.org>.

Thanks,
Yury


Return-Path: <linux-kernel+bounces-431404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 746299E3E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7D0CB33611
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667B420A5ED;
	Wed,  4 Dec 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q6l0doVf"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215920899C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323176; cv=none; b=SayLQWSKxymL8o4DPG0knU7fcPpA4i1XhJEprx6ku95ILMWE1DYCV2eFo+Ii1O2wrkwhldr1VDBr1xkIAR+jq8OJZZ/nuCbOVak0K9LU7HT19joey6MLwXTnrKAketfJPCaP+jHMT1xVNxwL43r67Za7C7Ggkz8EvGFQYwWcItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323176; c=relaxed/simple;
	bh=7vm+GgU7IzYoJVoPQmQEkbgSGw3DdebIEtgOIlj7sr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIxAOg3tTV4HXzli3C3M+cNcsFl+4GhFdzFZKOqmR0kWzYJBBzL3w1HLW1Eddc+3NIfxtrcM7oS6aRYZ/tE6kTMx5pqMgmXjziPd4u/jcB5WsVazbsZPpL14LHhUKiY7ppMgKgPfJO+7hDcOMInFPB9S0neq2/Pnkmzls3lk6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q6l0doVf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a1833367so6178175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733323173; x=1733927973; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u7Deb6ozPBCd5HaUFhdz6hCVVIOvpic/u3v2HTGhW9U=;
        b=q6l0doVfthszIGrrzjjOf+4PrPTNF2YKj8VPyhcjxIkXjY2BXcpn+1zK4No3MOd7DE
         eA6Urr0lz9isJYDloS+E71oJYyULmvpICeKNH/pmS8GfhZI7k9DVznEWnRWELKjHDEFF
         lGLrfp6RYfo9oFyacfthTbLHHhHshRSMmGmeyPKU4MoDCt9YGRe4sHjML9r1ypD/9dwa
         +mfOO1wJn3P5F1dBe6J7M7MUAdNJ3zlLuF9nA+wMs5ds9+rNeIHQ65ppKteUSsWxrymP
         5Ap3/aYcLbM7HK/E+aYtteo+fikcxVyWJOBkHUm274EhKrLNty3y430RgFNMRyJjKD4p
         e1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323173; x=1733927973;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u7Deb6ozPBCd5HaUFhdz6hCVVIOvpic/u3v2HTGhW9U=;
        b=vs0TaVXe8g2dqRye1He2PVMR+TLRv63DwRdyNPNj54KNTk0waUKRIpNywms97jvGlY
         w5AJv3ZwZ4kA3thjjSYUCLC7fpsg7c7IvFH1/HNGKQiRPUq4zYq5i5TncmYPvO9q5oWG
         wnsLQJjGypim1z1FWiwtOJUJ1VZG4nyEBwIexObdKtX/xam5acCTpdkW7PfawnUqncd6
         KQPAVBRXXX2m77krpFYdY80Ip1cFhktWPpNqMTTdEEatwMUoY5Fh0V6LTGqNsN+/tnnY
         Da49YX4/JtAnkL0XY4qzrm1FfEK3/Tl0k5TER/3fwZAMiFpb1gP/4MrcQRwGeaSs/bNx
         LdTg==
X-Forwarded-Encrypted: i=1; AJvYcCVc/M+mBVyapb+hktXfMxltk14wGaNDwbH5bfK0mo5LuwBltyGfsTd6FRdGCFyjy9EZuYPcMmz6RDu40do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jrZoFwWbum4lICi5LeSHeBn7eZKEdURVIS+bNIhfuEVOEFlb
	j7NPdE37cH81cFRGu4H1Q5EZ/FwdHrUFtBZ9EC0Tnsif8nSpp+A13UUdUEsS97U=
X-Gm-Gg: ASbGncuxw/10XnMbLAAql/4rQbfWyjhdeRcq2Fs3idkwXQHTKRdKMh0Uzo1iJi4YDSw
	+FXgufdx05zsxKvFIdsAqaoLFd80hSwWoMAaPQikv/mQxpaNtB7kkUAsiAEUmN2LzOWUvCNdzd4
	aYCnBFL9QihitrPm5hHr/uFoBR9JRMtukm1OwtLWbtK6ygKLwhjPPN+0SBrWYjYJ4bvdh7CQw4U
	YS77DWYylfMHh3c7DUtmF4UgBp9i7leZ2nXOaUD1Dx5APBNZkL1GI0=
X-Google-Smtp-Source: AGHT+IFgNAhlHmTZM9dIRgErvl8+0lGzD3UNMNEnIcEA1d5Rnbb0Ap2o8TKx3zX6wtjKyR3FwkoocA==
X-Received: by 2002:a05:600c:198e:b0:434:9cf6:a2a5 with SMTP id 5b1f17b1804b1-434afb9ecc7mr229792735e9.8.1733323173202;
        Wed, 04 Dec 2024 06:39:33 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d528ab4esm26074105e9.26.2024.12.04.06.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:39:32 -0800 (PST)
Date: Wed, 4 Dec 2024 17:39:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	David Laight <David.Laight@aculab.com>
Cc: linux-s390@vger.kernel.org, clang-built-linux <llvm@lists.linux.dev>,
	linux-block <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: s390: block/blk-iocost.c:1101:11: error: call to
 '__compiletime_assert_557' declared with 'error' attribute: clamp() low
 limit 1 greater than high limit active
Message-ID: <5ffa868f-cbf0-42ae-ae10-5c39b0de05e7@stanley.mountain>
References: <CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsD7mw13wredcZn0L-KBA3yeoVSTuxnss-AEWMN3ha0cA@mail.gmail.com>

Let's add David to the Cc list because he's the expert on clamp().

regards,
dan carpenter

On Wed, Dec 04, 2024 at 04:01:09PM +0530, Naresh Kamboju wrote:
> The s390 builds failed with clang-19 with defconfig on the
> Linux next-20241203 tag due to following build warnings / errors.
> Build pass with gcc-13 defconfig for s390.
> 
> First seen on Linux next-20241203 tag
> GOOD: Linux next-20241128 tag
> BAD: Linux next-20241203 tag
> 
> List of arch and toolchains :
>   s390 defconfig with clang-19
> 
> s390:
>   build:
>     * clang-19-defconfig
>     * korg-clang-19-lkftconfig-lto-full
>     * korg-clang-19-lkftconfig-hardening
>     * korg-clang-19-lkftconfig-lto-thing
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> ===========
> block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557'
> declared with 'error' attribute: clamp() low limit 1 greater than high
> limit active
>  1101 |                 inuse = clamp_t(u32, inuse, 1, active);
>       |                         ^
> include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
>   218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
>       |                                    ^
> include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
>   195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_),
> __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>       |         ^
> include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
>   188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),
>                  \
>       |         ^
> note: (skipping 2 expansions in backtrace; use
> -fmacro-backtrace-limit=0 to see all)
> include/linux/compiler_types.h:530:2: note: expanded from macro
> '_compiletime_assert'
>   530 |         __compiletime_assert(condition, msg, prefix, suffix)
>       |         ^
> include/linux/compiler_types.h:523:4: note: expanded from macro
> '__compiletime_assert'
>   523 |                         prefix ## suffix();
>          \
>       |                         ^
> <scratch space>:38:1: note: expanded from here
>    38 | __compiletime_assert_557
>       | ^
> block/blk-iocost.c:1101:11: error: call to '__compiletime_assert_557'
> declared with 'error' attribute: clamp() low limit 1 greater than high
> limit active
> include/linux/minmax.h:218:36: note: expanded from macro 'clamp_t'
>   218 | #define clamp_t(type, val, lo, hi) __careful_clamp(type, val, lo, hi)
>       |                                    ^
> include/linux/minmax.h:195:2: note: expanded from macro '__careful_clamp'
>   195 |         __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_),
> __UNIQUE_ID(l_), __UNIQUE_ID(h_))
>       |         ^
> include/linux/minmax.h:188:2: note: expanded from macro '__clamp_once'
>   188 |         BUILD_BUG_ON_MSG(statically_true(ulo > uhi),
>                  \
>       |         ^
> note: (skipping 2 expansions in backtrace; use
> -fmacro-backtrace-limit=0 to see all)
> include/linux/compiler_types.h:530:2: note: expanded from macro
> '_compiletime_assert'
>   530 |         __compiletime_assert(condition, msg, prefix, suffix)
>       |         ^
> include/linux/compiler_types.h:523:4: note: expanded from macro
> '__compiletime_assert'
>   523 |                         prefix ## suffix();
>          \
>       |                         ^
> <scratch space>:38:1: note: expanded from here
>    38 | __compiletime_assert_557
>       | ^
> 2 errors generated.
> 
> Links:
> ---
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188938/suite/build/test/clang-19-defconfig/log
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188938/suite/build/test/clang-19-defconfig/history/
> - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20241203/testrun/26188938/suite/build/test/clang-19-defconfig/details/
> 
> Steps to reproduce:
> ------------
> # tuxmake --runtime podman --target-arch s390 --toolchain clang-19
> --kconfig defconfig LLVM_IAS=1
> 
> metadata:
> ----
>   git describe: next-20241203
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   git sha: c245a7a79602ccbee780c004c1e4abcda66aec32
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAPS9UrJkbAKFHktQei7eqW4Y/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAPS9UrJkbAKFHktQei7eqW4Y/
>   toolchain: clang-19
>   config: clang-19-defconfig
>   arch: s390
> 
> --
> Linaro LKFT
> https://lkft.linaro.org


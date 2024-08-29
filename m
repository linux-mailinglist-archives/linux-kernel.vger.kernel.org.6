Return-Path: <linux-kernel+bounces-307242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8DF964AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F97F284E30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2641B3F0B;
	Thu, 29 Aug 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="U7nQokKt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD71B3758
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946718; cv=none; b=M7OczHLpj4mkdQY2wulfysXNhfflq1oM06kzuMm9hgb2fYtt1KlxvlgQIG1RgP+caWLc6EY3p3y2rMdMGrzR/Gx+53/4ArPRCBeu8Tc06dVT2BszORRPtgASCfKuIWLxFe9uRH9SZd99oZQ5KSwMnXxYRPsf+NCWH+fPT2Q9yd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946718; c=relaxed/simple;
	bh=enL+R4/mDhqg479ul4wjJYYKSbXR4Ffy8wE2384arzk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+9OXgP+IGUyxf0kgA/SfW+KRsYrIas95gtAJ0aLfRZCypwUda3TQQ+hnDLRqOLMAdHXM+zQ5r31MQFPsdLANJoM0MYMiYBVqal3e2py6z5mc5xQiGBHxvAKJjdKiFW+gmP/CUoTZ0I4Tg1QfZCkVVnLNR+2SWtY3ZyX2wck8e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=U7nQokKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD8BC4CEC1;
	Thu, 29 Aug 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="U7nQokKt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724946715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UANE9h/sMePegrokI4DmqGV7lrMuMvo3GFklA+kTenY=;
	b=U7nQokKt5iSHum+LkGHGITrD6xgOUU4Md5d92799XRMwIiHy/WDg//foWFg+PIzRt0xTRH
	xhQHbw8ySx/A+nlq5pLRyixoNYbVjExcuwEf2C+eu1ZO5xfT5UgT30P8ttuw+SNHq4PoS5
	x+U4d8loZy0RSQgpnwGTsSLJI5umgAo=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c8b79810 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 15:51:54 +0000 (UTC)
Date: Thu, 29 Aug 2024 17:51:51 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: odd endianness toolchains for crosstool
Message-ID: <ZtCZF_yaHnECJyZ1@zx2c4.com>
References: <YmX7z+BirkA3VAfW@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmX7z+BirkA3VAfW@zx2c4.com>

Hey Arnd,

On Mon, Apr 25, 2022 at 03:39:27AM +0200, Jason A. Donenfeld wrote:
> Hey Arnd,
> 
> I'm again experimenting with switching to your crosstool toolchains for
> WireGuard's CI. I've hit a few snags in the process:
> 
> - For powerpc, gcc needs to be built with `--enable-secureplt
>   --with-long-double-64` in order for musl to run.
> - Need powerpc64le compiler (-mabi=elfv2).
> - Need mipsel compiler.
> - Need aarch64_be compiler.
> - Need armeb compiler.
> - Need mips64el compiler.
> 
> While the existing compilers can all produce code for the wrong endian,
> they hit trouble when trying to link against libgcc. So generally a
> separate full toolchain is supplied for the less common endians.
> 
> I have had success with arm, arm64, mips, x86_64, i386, m68k. If you're
> up for adding the above compilers to the collection, I'd be able to
> complete the transition, and then look into adding a few more
> architectures.
> 
> Jason

I decided to give it another look, seeing if I could replace my musl.cc
compilers with your crosstool ones.

The actual changes required weren't so bad:

    https://git.zx2c4.com/wireguard-linux/commit/?h=update-toolchain

But there's not universal success:

    x86_64 - good
    i386 - good
    arm - good
    armeb - MISSING
    aarch64 - good
    aarch64_be - MISSING
    mips - BROKEN (doesn't like -EB)
    mipsel - MISSING
    mips64 - BROKEN (doesn't like -EB)
    mips64el - MISSING
    powerpc64 - BROKEN (wrong powerpc ABI)
    powerpc64le - MISSING
    powerpc - BROKEN (builds but some binaries segfault)
    m68k - good
    riscv64 - good
    riscv32 - good
    s390 - BROKEN (should be called "s390x" instead)
    um - kinda broken (but not crosstool's problem)

To try these, I've been running:

    ARCH=aarch64 make -C tools/testing/selftests/wireguard/qemu -j$(nproc)

or similar, against this tree:

    $ git clone -b update-toolchain https://git.zx2c4.com/wireguard-linux/

So it looks like it's not quite there, but not bad either. Just FYI in
case you're interested.

Jason


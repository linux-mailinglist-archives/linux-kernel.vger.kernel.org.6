Return-Path: <linux-kernel+bounces-443853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A394D9EFCB6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558D5289FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0DC193084;
	Thu, 12 Dec 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIhlBHXQ"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DEC25948B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032903; cv=none; b=K1FOhUUch4NpPOMljxe0Hb9zogr4zGZPDhrUsdIDMzKgFb4odCmlY2NlHwgOOmPrJ9Mo/2zXfnIYNL7MAViqqC1SM04rKmW9lHb7wWNboHfjIbU5oGdg6rc+Z8OyYqhuY63hm0sOxUs4FFJr0JZnveo9o62HnlM6ZmGWDw4oPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032903; c=relaxed/simple;
	bh=IczXGAF+eM1R/n6n4f5k72EKL4WE9hhqzfJUbDYrWKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCQtQMk+USCdq0C+QVpPXphn+5P5BjEa4tuPgfd8Wn5RMxVz9iX48XX7go/IICPzvLE78gdHwJ2K2e1f8gPmiSKb8be+5ANXhcUbbc3HFmCsjmigQiZIn2gw29AsNF8u+UGpxSn/m68ujR7v4aludZckWKwZ7gFaeGztvNZbnmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PIhlBHXQ; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5189a440a65so488103e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734032899; x=1734637699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BlbbI/g+hRuUgF8qGy3bJAgo11Dj0VWxvIagMZzWOus=;
        b=PIhlBHXQbq98ZmFqAlZAd3bNKAIJkTKuq2mQi0uJq4NoN7A1KEo5sVGgMBc1olSjrE
         aHhsplFimZy6b2Y9jMS4GlMQ5jjOUO5OhAzCZHTS5h0HBi7oBJDsb/6Xh+B8Wg9F4ZGb
         YdIY4XMeNYsYCM5KSpd2UlNyZ+xOoEQ4Cl8riDY6n0O82MriucH1bv2wfm4mtlYgyq0P
         UQ9sZfF/60PvIWHE4vSPBEIIRLSQd/isV32CjrHtVXbGCoHsJ+/RP5JlYVcKbX/CrStC
         ur5lID5czfRheXfHmCt424sJAslxX5Gfc4TXFoNB0LTq2CLuhHz0A5J0UCFzhVyDbbDm
         ejFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032899; x=1734637699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlbbI/g+hRuUgF8qGy3bJAgo11Dj0VWxvIagMZzWOus=;
        b=NEzL8QqgXtepAoPLykodEtcG04+qMIYuJlv0zTusoi/cvofFTUUxRvkIYCdcel5qQV
         fuJZZWlhGL8iX6bMNnvu4AVY/C3sHc4qxjYpiqXVIybYPUF1WZGucPW9IrgHQkVqJKwM
         syv0qQvvrRlJ4CkLOYbknbDAOiVhnOM631U7U2Xw+p3aTt6aP/XffVMKIw6nVY1iAesm
         Z1eC9Zz7yNog8w2fLAL7Nj6a5A/F9BsaIp47dZ1XDm4yROx7eWz91ObVDnspZ/hcbFWK
         AvhPXaXQIuJshOSwt5khQzM/OXsg5aTBZL69cTNYBI7nYCSPocuH/RxIrCVT9PntDuUu
         CMOg==
X-Forwarded-Encrypted: i=1; AJvYcCUkFNs0+yohxWqCk1bsDA/t2cUlJm70ZqVOFhORknt9UNG1/6qoTlHvN0LWaNLi0SNXV5Wnrgfz51Vutc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7eAbyyLCOQx1HJGbKgzCRbyFEKZeLnE83+RINR12cDpxGQq8
	eMfh/EzBIuuHaYkxPoHlfFybFtQ3zwlML94W3+RbsqD3i/R85bPTVhunm6gjUm06ROkdvENVA7h
	Ct8HLGfhGCKH1+Oxri4mk47Za7RVw34pOAKWfog==
X-Gm-Gg: ASbGncuj0dxrzA0iMsW12TR/noZvRGkPLHia/4rSTvcgCBeQu6zzRqByrrD1dH0YuAY
	Gzi6iyHyEfRS2o3jj3Dtw2uw8n7b5VfcBup8m
X-Google-Smtp-Source: AGHT+IFBe0k1ufkZG205NB2FpxYW8UXDiGTPL48pwGMQjlmQbagnb8MkD4Y4QDURyIAwIg3y5dWgFpLofgO5GFaugWY=
X-Received: by 2002:a05:6122:8c17:b0:515:d032:796b with SMTP id
 71dfb90a1353d-518ca48a3d8mr68111e0c.11.1734032899050; Thu, 12 Dec 2024
 11:48:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144306.641051666@linuxfoundation.org> <CA+G9fYuX2BsEOCZPC+2aJZ6mEh10kGY69pEQU3oo1rmK-8kTRg@mail.gmail.com>
 <CA+G9fYu3SmdFKRkSDU0UV=bMs69UHx8UOeuniqTSD9haQ2yBvQ@mail.gmail.com>
In-Reply-To: <CA+G9fYu3SmdFKRkSDU0UV=bMs69UHx8UOeuniqTSD9haQ2yBvQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 13 Dec 2024 01:18:07 +0530
Message-ID: <CA+G9fYvV21_-3QYWh_gmKMRZ89AYn-KM99DbmghsLQJEL2+4Nw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/466] 6.12.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 01:04, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 23:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > On Thu, 12 Dec 2024 at 20:30, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.12.5 release.
> > > There are 466 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > The riscv builds failed on Linux stable-rc linux-6.12.y due to following build
> > warnings / errors.
> >
> > riscv:
> >   * build/gcc-13-defconfig
> >   * build/clang-19-defconfig
> >   * build/clang-nightly-defconfig
> >   * build/gcc-8-defconfig
> >
> > First seen on Linux stable-rc linux-6.12.y v6.12.4-467-g3f47dc0fd5b1,
> >   Good: v6.12.4
> >   Bad:  6.12.5-rc1
> >
> >
> > Build log:
> > -----------
> > kernel/time/timekeeping.c: In function 'timekeeping_debug_get_ns':
> > kernel/time/timekeeping.c:263:17: error: too few arguments to function
> > 'clocksource_delta'
> >   263 |         delta = clocksource_delta(now, last, mask);
> >       |                 ^~~~~~~~~~~~~~~~~
> > In file included from kernel/time/timekeeping.c:30:
> > kernel/time/timekeeping_internal.h:18:19: note: declared here
> >    18 | static inline u64 clocksource_delta(u64 now, u64 last, u64
> > mask, u64 max_delta)
> >       |                   ^~~~~~~~~~~~~~~~~
> > make[5]: *** [scripts/Makefile.build:229: kernel/time/timekeeping.o] Error 1
>
> The bisect log pointing to first bad commit,
>
>     clocksource: Make negative motion detection more robust
>     commit 76031d9536a076bf023bedbdb1b4317fc801dd67 upstream.

This issue was fixed in the upstream by adding the following patch,
  timekeeping: Remove CONFIG_DEBUG_TIMEKEEPING
  commit d44d26987bb3df6d76556827097fc9ce17565cb8 upstream

- Naresh


Return-Path: <linux-kernel+bounces-443839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7591D9EFC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CBB28AC03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1AE18FDB9;
	Thu, 12 Dec 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkBMK40j"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349817BB34
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734032065; cv=none; b=Xk5tSBe9g7eUL8ZccVlJeMUkdyiALhrAnA/5tt1yDkq9oWmsgbfYA74evjgtGvN4yHS54vPAgVDUKFvv0UFJ5i8uX9/z6S65XIm+IcXC3zHJpE0/fsusQIM2419CvrNfpMojzmstIQZjUEnTQMyQXizBIZWtNq+vAbAvIQ7Mzvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734032065; c=relaxed/simple;
	bh=XRQkEkF+swi0B2+vusGEbl3JYtBkHkVO+F1GD117yEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=siZnKxLpKY7Nol0HPpqFdn2HCF6hMhKYG5cPFRwWWReNqZle6NqWwcjRYylt6+1JOMsUZmEW+pa8jqy9XnDCIr0flzcJlNLGUGWeZ7ODwHBsl0bH8LGnSx9TKBcx3CE6O9+d+akkjRAeQHd+bo60WsqnQH7aoTWOBvkHBQkwCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MkBMK40j; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-517aea3ee2aso406922e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734032063; x=1734636863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fTEkwDAcKDq4oSRBOG6s65o3vkDC0MpLM2cxo/UzhJo=;
        b=MkBMK40jSKqSR8MmPqoR1lz0zzkxG8F1HOSnNVsewtxrO3LujinXMjqF2C3VILuu9W
         Q5xwg35KMMU0vF0BP5wOZwSQ/lWhNUnhx7AEC7eZ9AmAb2Gl/LbEgsxKF+7wvRhvxCSr
         a5H1nNCc3WSxTs1ZEADO8MJj97u9FVthuwRlpld3RrV6nvICzQQILyLz/PW1RHNGsM5Z
         HUwlxaPKnN+w6dC94F8SKTsmK51RSAwZ4xQEbA1QCEWXREvzXyWySm6o00Ub1IpwI83u
         P0WmTS/HtHu6TviWUwQSloEJ/jFCUTD++OptkB9oEbJHfSFcJSIFbyjUeQpxbtWDKp7+
         K7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734032063; x=1734636863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTEkwDAcKDq4oSRBOG6s65o3vkDC0MpLM2cxo/UzhJo=;
        b=xHDf7FIj+GDtOgM4gLakxahI0LIZPHGFIqQBayfwtYFHcQfykdtZR2efmEWsdovD9g
         0hNIDyj9PccOqm63HaV12YTd6HWcShLPVrWJUD8mzjRBeIzS+cqSIQPpTHrdr7zHxriD
         0DJ4JcfCn2IReGNdaguA0Rs/eQn96CKKPerYVM13WALCgTZtYkIt/3j9QfEd1/XeUlzh
         jeJVV6dj1sGM8BpqMXcg5EkLZlMaXYv1z0r5GqZCGciBFUJSU5EomEq9tZGwho8LaJqF
         PjHMopSRO8edsUeOroKTQl+yhoX9ENNB2x2fq8opMAvYB7iJkO5XPSYCnAwdLxJwDLp8
         tyJw==
X-Forwarded-Encrypted: i=1; AJvYcCUKInyJOr8MMrI242iURb+/K5Zi+ArWF+vw6dGm1CFNTg4INAuvQVei/3+baRrsSa6bqX/7yfB1+x332h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpqJ6G92ghWQv6zwEvempqXgPPl/D4DyD8VYkRy1A+SN3lQd1
	ZpKdJl9PuR5wuFs8itxdp01diq2ApVn0UINCdnb7VRE1kN10IZ/ygcDSD1qSzrJThvcUxB9wjyf
	7EjP7zIeT4FYK1Y3MhCOWN2iHdfzDje0J3Wpakg==
X-Gm-Gg: ASbGnctjpIxnJCQu9hcquzLkjIq59dFofcKnmh+MrKpNK/h+rIb8ROTwl1Ootyn44gr
	NmFFuQQaRULWHV/6aDvFRkV23kMc69rJxzuFk
X-Google-Smtp-Source: AGHT+IEwsqoADy9CLfQZU9fDxZL8sRYBnIJOakCrDckekfKDwX9cAfY7rdncozWG2knPUrR/hQUKmLlDFG4i+7pUkgw=
X-Received: by 2002:a05:6122:2004:b0:50a:d1e3:82f7 with SMTP id
 71dfb90a1353d-518ca4648bamr40974e0c.8.1734032062910; Thu, 12 Dec 2024
 11:34:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144306.641051666@linuxfoundation.org> <CA+G9fYuX2BsEOCZPC+2aJZ6mEh10kGY69pEQU3oo1rmK-8kTRg@mail.gmail.com>
In-Reply-To: <CA+G9fYuX2BsEOCZPC+2aJZ6mEh10kGY69pEQU3oo1rmK-8kTRg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 13 Dec 2024 01:04:09 +0530
Message-ID: <CA+G9fYu3SmdFKRkSDU0UV=bMs69UHx8UOeuniqTSD9haQ2yBvQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/466] 6.12.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 23:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 12 Dec 2024 at 20:30, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.12.5 release.
> > There are 466 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.5-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> The riscv builds failed on Linux stable-rc linux-6.12.y due to following build
> warnings / errors.
>
> riscv:
>   * build/gcc-13-defconfig
>   * build/clang-19-defconfig
>   * build/clang-nightly-defconfig
>   * build/gcc-8-defconfig
>
> First seen on Linux stable-rc linux-6.12.y v6.12.4-467-g3f47dc0fd5b1,
>   Good: v6.12.4
>   Bad:  6.12.5-rc1
>
>
> Build log:
> -----------
> kernel/time/timekeeping.c: In function 'timekeeping_debug_get_ns':
> kernel/time/timekeeping.c:263:17: error: too few arguments to function
> 'clocksource_delta'
>   263 |         delta = clocksource_delta(now, last, mask);
>       |                 ^~~~~~~~~~~~~~~~~
> In file included from kernel/time/timekeeping.c:30:
> kernel/time/timekeeping_internal.h:18:19: note: declared here
>    18 | static inline u64 clocksource_delta(u64 now, u64 last, u64
> mask, u64 max_delta)
>       |                   ^~~~~~~~~~~~~~~~~
> make[5]: *** [scripts/Makefile.build:229: kernel/time/timekeeping.o] Error 1

The bisect log pointing to first bad commit,

    clocksource: Make negative motion detection more robust
    commit 76031d9536a076bf023bedbdb1b4317fc801dd67 upstream.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

- Naresh


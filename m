Return-Path: <linux-kernel+bounces-549082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A7A54CFD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60DE18981D9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF8156236;
	Thu,  6 Mar 2025 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZimUz2u"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0151519A5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269989; cv=none; b=FwgM69RqHV0X32JLVln2pYwuBKlDzQifc97CHpyZqvUJN0F+YlR2rcM2Yobe5sBXN6GGqS4jDrN4LoROJoxoZlFGsCVdtsI57ZGgEbxcvfOTOhCKNIVEEJPuXJGIYdL+cGHuppgYrzrdUCIlatfP5Tc8YmTosA9ZZXEdPqNlKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269989; c=relaxed/simple;
	bh=8vWkfwZ9uoFTAqFoovaPX7Bjye6a8c5yTgefFSZ3pCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rII0DXGvkssKDstL9cNKzWWIKu7KgmFeTEMqeiWRj9hNsdlc0lybLbkqi1osH5Yuffsx/69Fdc7Q2kbyD7FS+bpi8OjYnAIkj26AEPdX6kDGPsB9pt7WGXYVzZ2A3vEH+AMJPWRCaTjPbt9920WlEYpfO7ujJkou5lgzCG/UZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZimUz2u; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52378c0c2b1so305982e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741269987; x=1741874787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hnDdSUGNxHZHOtmoWx7c7YzOTo1FiWV3Vqxq9lxjEQc=;
        b=jZimUz2u+EsC5z1+bCdpdbXbq3rLfEKxwAb6lp36SSyn4GQihR7udWM5lKFhJmyybi
         5jj8IgYXpKxCAVARFYXi3AqwdQe+vDlEobZstK1rfMUdAauZidsN7zOb5TejnFshJbCt
         880cXjqjCf9kdmDAx0UD+rJHqdezwmzXy8jwaY9W3cYIb4VkgotqINql5w1gU/PuJzgH
         z+P8bXQcYuuP+I9ovhbJMnpSxEmCcuwXu99/zptLJsdkkeefBtmjooShvdgG+BQCFpb9
         aBmMMS0Ba/lOvreVCt2L1+TYuUSwDIb7rDm80DIIlA1VHAPN3i/TCQoqK38b/wfZZOkH
         0/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741269987; x=1741874787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hnDdSUGNxHZHOtmoWx7c7YzOTo1FiWV3Vqxq9lxjEQc=;
        b=qaucZtlOtpAPXnq4/iAcwH9iZTU0hLrnG7rK1wuW8i/sLVEsW8h4vSma8fIE808MRm
         E47rqHcrOtacq2q5zqraZCCO2bbxvBGgbzErpSxFCTW5yDBMXFDcsf1htK2RfUwjMGMY
         0EDDBQ2QN59nmUy/5QrmzCCE6AQJADMFy8+Ntchu26wyGAMxUsmzncrGCp+iYAtHUf2t
         xBDLioY4RGM+mWORAJHAKOfGyyLF6RuH4rwuG7QycCxo4qUQpaJYg7eTB5bC8urYL7YE
         gKrCsUWGeojc1Jv2CLrXGwZLlNUwj/eQoJoZ58LDCvTMgott+wLP4ElD3lN1ObOGDcU6
         uDYg==
X-Forwarded-Encrypted: i=1; AJvYcCW/SzLmNVZQ+RiPIyn9d0ZYuq9vMZz35aBCVdnkwKFhKZJQCL5EtNwGTaCuuZz5HTtB7mfERlr0Eqf9mFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT7YKfJAa90iCDzLXEXoK4/O8RZVHgJFeTNaxo3khXYekwb1Yq
	l+LnWa+sViJc+lSYkZCGAlWQW25U+iyPVyesgRwNeRvcrOADA7AfsQM8m4mua3sQAavZiHE6RmO
	AS5JN0a6ei9lrTKp1rSlACJlEpy6NZG9WzD2Wxw==
X-Gm-Gg: ASbGnctC4S4t/BRQGiYi43+XIkRgBI40hGPnWc+2fvF2LWyXn7+8Wnde2omy1m0qxbu
	SYU1/lw4iJDYBQNSqpFxJPvm1it6QiLyq1d5Z7Y8CLq2hJdn9D0vr2O+xdV9ZfOa5Dc1BpUutpI
	4OIIjmNycG/o52yz7MGIIP8FMm15C2rQeS+crS6CdiOC14ErArSOH8bV5CGaw=
X-Google-Smtp-Source: AGHT+IFYYVIMAXWvuGMo7KhLWndEUFvJgOqbF7iDEk1iAt4N1mORmaJKT3kVe35xC4vstbek2/qR99nsdifAiR58JMA=
X-Received: by 2002:a05:6122:658d:b0:520:4539:4b4c with SMTP id
 71dfb90a1353d-523c6289f5bmr4380467e0c.9.1741269986969; Thu, 06 Mar 2025
 06:06:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305174500.327985489@linuxfoundation.org>
In-Reply-To: <20250305174500.327985489@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Mar 2025 19:36:15 +0530
X-Gm-Features: AQ5f1Jrk2nyka3XPmEIXPsBdkX75IZVBh9HDyYyhUqxg9qoZ6sVv7JRLz0R3L_c
Message-ID: <CA+G9fYufChZpBjB_WG6Qy-L8Gmj-zBbs+PyydaADcsrB42ec0Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/142] 6.6.81-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, clang-built-linux <llvm@lists.linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	nik.borisov@suse.com, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 23:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.81 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.81-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on x86_64 and i386 the defconfig builds failed with clang-20
and gcc-13 the stable-rc v6.6.78-437-g9f243f9dd268

First seen on the v6.6.78-437-g9f243f9dd268
 Good: v6.6.78
 Bad: v6.6.78-437-g9f243f9dd268

* x86_64 and i386, build
  - clang-20-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: x86_64 i386  microcode amd.c 'equiv_id' is used uninitialized
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/x86/kernel/cpu/microcode/amd.c:820:6: error: variable 'equiv_id'
is used uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
  820 |         if (x86_family(bsp_cpuid_1_eax) < 0x17) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


## Source
* Kernel version: 6.6.81-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 9f243f9dd2684b4b27f8be0cbed639052bc9b22e
* Git describe: v6.6.78-437-g9f243f9dd268
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-437-g9f243f9dd268

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-437-g9f243f9dd268/testrun/27508291/suite/build/test/clang-20-lkftconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-437-g9f243f9dd268/testrun/27508300/suite/build/test/clang-20-lkftconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.78-437-g9f243f9dd268/testrun/27508291/suite/build/test/clang-20-lkftconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuO7pCGJaGnX0ygcbTOaEDzr9M/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuO7pCGJaGnX0ygcbTOaEDzr9M/config

## Steps to reproduce
- tuxmake --runtime podman --target-arch x86_64 --toolchain clang-20
--kconfig defconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org


Return-Path: <linux-kernel+bounces-416647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A0A9D4838
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41591F2222D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 07:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E01AB6F8;
	Thu, 21 Nov 2024 07:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bnJr3E3x"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8468818A6B2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732174653; cv=none; b=XmK9bzQUywTMbPULxAlKeKAQ59e1ZS6lQvOaT16FxuLm7rAlsvhjw1W23KuFGuEmUUefqh56JIRaTlT7nn12extYnIQjzfWTNEklUQs6gLFXOEqOezQ9VPh/5lye+5Mv1bH3cop7cOxlj0Km/tGYi9ULcuejr3o7m8ss4KL5zY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732174653; c=relaxed/simple;
	bh=epdwONRPQzvG4Ng2ew7SNAGEQ2TwjDGwbwUNkeG6kjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AjI6H7KmI9+C4S2JTmsSOrQJRCBjnEIHx+R6cvWW2kPNJZIYLmlOL5H/55eNETHacdWufqzFfuUKnr3X3LrrOJnptXv25S58zOo/ZqRsnDwPvbe9UhApV/Ik87Z07ZUCn1DNjsuGCC0veBd+j6t3F4cqh77SPYcsoI2DcOF19Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bnJr3E3x; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-856e8b7d74eso288880241.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 23:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732174649; x=1732779449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1ZLoH1smfbg7/BsnIAPQu/7wAAnykIMDtQj2EWHt+Q=;
        b=bnJr3E3xSvJd4/n2UgQX1b+F9DFLbyWXk6UGiUp6dCM5yFI+9HBDKNfdLZr1i6J4xD
         h7uXi0IFPRyF79FAhaNYs1gGPWeYN/uY0qIa7LUzznUB1Qa7nsF5ih0AQruva+FP7/7B
         Sumll4GVEYme11IGN/Nx1zMzZhfdsQrb2Nb1DiLMErbMiIqULlDasB80IzhxR1X5CXmk
         Y9/yfth9zim4uq0fT9K351sT9lWn60J/aeiBCyyFUr5wFRPhRjLR/J+KCaRJVnxMTMYq
         FiickipXg76Pm9fZCYjvK9bEn+n6giSe7WFtWqckf18WDPbk1jNdk86Izsir5MJWE4rm
         R5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732174649; x=1732779449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1ZLoH1smfbg7/BsnIAPQu/7wAAnykIMDtQj2EWHt+Q=;
        b=J4Eehe97NCqfBJWxq8dOKxKQJMbNBf9UygdJ8ZvBlTQZdjszl2svpcwCatDOALcP7M
         TldYb6H5yj65q/0qc8hL/aOq7AmHUwwdeDiyfyoahfJhnFrGHgvwNdb06nft8lpviN2r
         ncGt1PttCc6MfaJEm1HxpTEPtU8vJTmzWjv+Omy39U6EV3P58SrH6ic4C7T2xqr6OXeV
         fdJb0vingoVxNHcbyzHyKkcNuv7OlxVGcqlf7jFc+CesRVcX/PrnPXbCEZILyDnA4Dc4
         fenaXK1D5Fn6AnhnZ1nn+jChnoK5e2vGoeMAPhikO1CuBUcVCKHJHpGtbX9gzAFLh/DJ
         GvDA==
X-Forwarded-Encrypted: i=1; AJvYcCUiEYBTJPWKcENbQET3+DfGlmRn7aSc7v2MyGlU66Go7lsctT1WMqifFL4O3aaFkRUEw7fFtl/P4t0Iqq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6M2Uy13kTXl7hMjS/6HXbqMrD5T2GVXLIW4ZhlwGYeUuRvzYS
	JFEaE7wBx+CM+6nXNHiZTnoE3X25GRrNb1iD6FYlFEaPXP+C1/nIbmhLHne52/HiaGij2htgGU+
	Mpf0AvL7UsIq+d0AQxo+Tbuck+XSpOs3cwG/uaQ==
X-Google-Smtp-Source: AGHT+IFd6DL09qqOh0gqlQXz8TrLBH2u7Br0PkOW53eLUM5unHdRAV9q+AYPrDsgcccR079NbH6OS/M8xAa1v+t5gQI=
X-Received: by 2002:a05:6102:91b:b0:4ad:595f:bebb with SMTP id
 ada2fe7eead31-4adaf6203d8mr6231578137.27.1732174649280; Wed, 20 Nov 2024
 23:37:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120125629.623666563@linuxfoundation.org>
In-Reply-To: <20241120125629.623666563@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Nov 2024 13:07:17 +0530
Message-ID: <CA+G9fYvy3d162b99zNCXug+m=AUGJ7hhoeDNrOFDjHcxqm_XJQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/82] 6.6.63-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Nov 2024 at 18:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.63 release.
> There are 82 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:56:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.63-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.63-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2c6a63e3d044aa21274c98760650830a22b5d54c
* git describe: v6.6.62-83-g2c6a63e3d044
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.6=
2-83-g2c6a63e3d044

## Test Regressions (compared to v6.6.60-169-g68a649492c1f)

## Metric Regressions (compared to v6.6.60-169-g68a649492c1f)

## Test Fixes (compared to v6.6.60-169-g68a649492c1f)

## Metric Fixes (compared to v6.6.60-169-g68a649492c1f)

## Test result summary
total: 120020, pass: 98405, fail: 1453, skip: 20080, xfail: 82

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 128 total, 128 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* i386: 27 total, 25 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-efivarfs
* kselftest-exec
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-mincore
* kselftest-mqueue
* kselftest-net
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-smoke
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


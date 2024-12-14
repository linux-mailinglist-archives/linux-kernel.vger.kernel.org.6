Return-Path: <linux-kernel+bounces-445962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A1D9F1DE0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B78C167E0F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F7E16A395;
	Sat, 14 Dec 2024 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hXoIvhLC"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F718AE2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734170504; cv=none; b=VXdThzq39V2tOTsuT6ScYRdclX6JKRNoPY5WruAILHk1GSW1E5y/Bb3gyDzR0d6iilTDbKiFzY7TNiRHUPdXzTwr2eiVRmDV4N2OLDBWwea0kW9jNS9iJKWjqCP/UsPfu5CsdnHUOirM5SRdJPXcyH+6HZMKxJUYcb63EqY11/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734170504; c=relaxed/simple;
	bh=L3Ts2vR1tGcJOhL+7WA7EXHct8W4/evMCyaznAj/8PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srljvR93e0rwXB/ojFFBAObFm/yCiTcmJXO3wSKirs/vvQ4GR7QgxE7Te6xAvNpjX5WRYSrFjbGKe9Apz2G5UmyXkPsZuQuuUp8fNjB1MkbzLT1wdIgzj7RYOtmfaoekLSO6cAYHATtkxWKHm3UVY6BsGk5IMucx5FKcDOpU1Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hXoIvhLC; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-51882748165so745040e0c.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 02:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734170500; x=1734775300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6iJmqCbGDdzurGz1nq3IkvqP7Qanek/ZA/cXhzDn70=;
        b=hXoIvhLC27RZ5BMmf9zDZz/h06EjApbyHlZSOVgioyf3jzrIa/dSXwTBWiQ9vuzH+M
         +2r0nrHz2aT82PuZoxivlbS2ptTgM+h03GWdyPsOp7eeTmdfS31iEOnugee+RWCDqpvD
         hF+DT71v3kOf1U6AtVGEGBhnAnpk5Cv9ESy+V2tNGIDsnizaFOFaDCQ7AlEY+QCYuwRJ
         R2vUPq8W6yl+gLTn5XZ0wHI9D2J9Ju69n8Fnir8w/mUOrZyXB3l/hi810mgn3zTOwHVq
         bMgJM0Dfo7z8LQf9FnTTaIBGV3b63GJ5yJfiaf84ZIAtSrRgYjUNwDog+Rd2QwXW4y1n
         3jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734170500; x=1734775300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6iJmqCbGDdzurGz1nq3IkvqP7Qanek/ZA/cXhzDn70=;
        b=S0iYfUBxi2QKtzwRfGck55blflzJvGtc6BkNdkctynmCr6T5+gVY2VfryRmZTs6VTW
         NFOfcIcltUdfoHV8IEZgJbCvWcxqXlefpdwdkmc7w+YHOig/fW4uWHhD5KGLlP/9uc50
         G3X3G9AoNQ2XewtdMZnsepAZ0NrvXPaQKf2nylB53nwIs1uSYnV1dUPmBY/OTPhGIA1T
         X18T9XKbWK9v8kvKCDCAMRaU5o3sO6lDwkFB4PLZydOQ2TN3Ios/6+SxcWDanl9K0Vmn
         HNDTt418zGgHJbc4FrbmXv8SkryweKypjukkGSNI247UauypFgaqJGfpPioFf/NavDQp
         ADSg==
X-Forwarded-Encrypted: i=1; AJvYcCVNBV+plakmGM75MZ7RnBs15s0Yn+EadiyCbCwVWh8FK1+u0TCz7ikEsv/QntaDR1Q6AveeSg/cZ1JmP+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsErtqyX4USgZJvNp4qs+tWRaZzgQ5JEvy15Yj6L9jcLSNicpe
	99kiwthkJoqjoJj64HWk+lmyKtXjnGswb07de65gVJc0iPb2mGa1iGjZNED78LDvqsuW7er/VbN
	YL1VSd3CnQOwS9rnU7UEX8dwjpjx/rg+PHqEmQw==
X-Gm-Gg: ASbGncu/8gsnKQT1hPuykyI6NTpMxcrTnsNYhrVoeObxOmCmJu9Lm0saskaPMolTMZo
	3TnbjBFCA4BlT7SIOZf9bor19WxyKsoNA9xmZqs8vDsupWsX0eGlu2MMeUlm4Fpx+/qheVag=
X-Google-Smtp-Source: AGHT+IHO7/jmhkLsHDBV3zjlqLwhzO6luE30zeMTItXQRQKMazsXibRYrA6dzCFh5ymyTKClcwpgIAZ6Isq71zlxAg0=
X-Received: by 2002:a05:6122:2a05:b0:518:6286:87a4 with SMTP id
 71dfb90a1353d-518ca251874mr5900037e0c.4.1734170500545; Sat, 14 Dec 2024
 02:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213145925.077514874@linuxfoundation.org>
In-Reply-To: <20241213145925.077514874@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 14 Dec 2024 15:31:29 +0530
Message-ID: <CA+G9fYtcVtLEWtv3N1e0jtycdSomHEZ8+LV0k-P8weZUnX10dg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/467] 6.12.5-rc2 review
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

On Fri, 13 Dec 2024 at 20:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.5 release.
> There are 467 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.5-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 602e3159e817475bec9784ba359147d8351e90c2
* git describe: v6.12.4-468-g602e3159e817
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.4-468-g602e3159e817

## Test Regressions (compared to v6.12.3-147-g91ba615b0f09)

## Metric Regressions (compared to v6.12.3-147-g91ba615b0f09)

## Test Fixes (compared to v6.12.3-147-g91ba615b0f09)

## Metric Fixes (compared to v6.12.3-147-g91ba615b0f09)

## Test result summary
total: 115288, pass: 93226, fail: 3813, skip: 18249, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 139 total, 137 passed, 2 failed
* arm64: 54 total, 54 passed, 0 failed
* i386: 18 total, 18 passed, 0 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 40 total, 39 passed, 1 failed
* riscv: 24 total, 23 passed, 1 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 46 total, 46 passed, 0 failed

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
* kselftest-rust
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
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


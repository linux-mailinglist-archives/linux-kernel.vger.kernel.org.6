Return-Path: <linux-kernel+bounces-255989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01DD934772
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091381C20D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B4F3BB50;
	Thu, 18 Jul 2024 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fj3qZ+7p"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CF41746
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279737; cv=none; b=oKb36vf8tixXmFO+7uN4Hd57VLRS14Y9y5TQajGJDnxcDoSNMMJrxYT6sSTTOkyQJ3YFdrH6DFL+2TVpqefhAD24pjrByYjtjnJTse0x8oHKIrPTZwFidLF1wgPrJ5k0XV6JpXFcAAoHk1buBkQroDQ2Y/0GKKbLCST1oQFsfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279737; c=relaxed/simple;
	bh=EoSKuZUqeSjnaf5kfIOeC3Ckwj2scTZiLDwNdkrgTO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FspaDBE/wInrvOzTepTJD1B4O+jOZLZxLn1GgLLo4MwDGkJv5CaGHhJPKzw/vT10H7al5gVKyLOCRpEiYz7JrKYfXOOlnzswhcN80XZi1NZ1cx/4PGzuCqU/XygX2ybIvnz2KF6jk4hsyfJcAKs8tzdZpBsE/bc/k9D/yddshVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fj3qZ+7p; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-80fc4fe7a8eso194385241.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721279733; x=1721884533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A2X/W62oP2UENTv/RdibwUIRfmlpn1GhezLWyGqvYn8=;
        b=fj3qZ+7p63kGXuKmYtR9WNGAaOaftQ/6bS17IYPskJL5FCELEBRev+Ern6AtDOxcvJ
         rE5tzWWchFkOQW8KANT+AOUmPIevVVKmAsta+U1UhGyUxdRdyEp71HRhyWv+d/94pY8j
         a4rOecx/gxgsfIX+B7Y8EId1Vz3vEHdRHDzFlbfn5wYhr0r/AgY9TcBx3/J6utEZ1+QX
         1prJdreBWTvADFakETBIjkeoy5lTrE1qxVgOuhQpTAbytakugMUTMWmQtVcIEZ6SfpuA
         a4b4c/WM923WzCjIe0MtldVdVbsvf2WavC22ljbUwfS98L9Ji9qKN54q+Haa0m0nV7Cs
         1y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721279733; x=1721884533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2X/W62oP2UENTv/RdibwUIRfmlpn1GhezLWyGqvYn8=;
        b=ovjpP0VT2rSRdNoR7CDFTdnefym9LEpL5s5coCtriE/IWil1++dxk+4jpRwnl24xUy
         SV03TSRmXT1YS6L1MjqUBU7kXZqWOM0z5Xsv3p371IP5boNjbFCOxzhxxmUJMHmTS0Ia
         M4jE4F6TKkk5ChluxrpmkRDGli7ott5pgrxD4xGdY1+3t/xQ6WSkoHALG9+JbD7KvhVq
         WRO5r5AUO3QtywJnSF4ZL7DGhTD9LjOwLbIGSW1kNdUgAoVqEQHIwxdNfU4yCfL/J1IZ
         U0cdskoN32flTxImqwdRJqnkEHkduFoJCADw+mleJ2F0zzkdEt/2V1rtM7+JUL9H5Vh+
         dIDg==
X-Forwarded-Encrypted: i=1; AJvYcCUA9BqsPlVXw9FoVpgnDuBe2I9rh7LqaRjaSt1Q1/2ZeI7dLenhjfiHCNKqeFmO+hCDVebO1r5Y4+eEz6NiwqnJE4Q946QFF/taegSJ
X-Gm-Message-State: AOJu0Yx1SZb7xf41fAClBTHAfCr8obwBHfHWwuiun846qikCWTkookHW
	qvmzw2hnEFdCWXs4JdyuFWDxCK2lc5OBlSU55uVyZ5GmmQpWncklSJsFDViXw0EgsrgIHBsce9K
	fOND+0HQ6gpyunzz0pyJqvx93Qu3JtGunIBUDKw==
X-Google-Smtp-Source: AGHT+IEOTlv4MrE+GXCOhrQ9cjudHE4BkNGnZk3JQqnG4xKdAWrXh6CV7m9Mrmc+6hQiMyVvsCwnF7hgD+st9U9UA5Q=
X-Received: by 2002:a05:6102:4b8b:b0:48f:3411:4021 with SMTP id
 ada2fe7eead31-4925c220d90mr1433323137.10.1721279733200; Wed, 17 Jul 2024
 22:15:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063758.061781150@linuxfoundation.org>
In-Reply-To: <20240717063758.061781150@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 18 Jul 2024 10:45:22 +0530
Message-ID: <CA+G9fYtfAbfcQ9J9Hzq-e6yoBVG3t_iHZ=bS2eJbO_aiOcquXQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/109] 5.10.222-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 12:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.222 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.222-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The QEMU arm64 booting kunit enabled boot failed with clang and gcc.

Anders bisected to this as first bad commit,
# first bad commit: [c2ef31fd37ae11e89cb63c73cb7ee05bf4376455]
            arm64/bpf: Remove 128MB limit for BPF JIT programs
            commit b89ddf4cca43f1269093942cf5c4e457fd45c335 upstream.

Reverting the above patch made the boot successful on QEMU arm64.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Boot failed log link [1]
 [1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.221-110-g3fac7bc30eab/testrun/24635930/suite/boot/test/gcc-12-lkftconfig-kunit/log

Links to the details of build and test [2]
 [2] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.221-110-g3fac7bc30eab/testrun/24635930/suite/boot/test/gcc-12-lkftconfig-kunit/details/

Steps to reproduce: [3]
[3] https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2jMce7XoWf551plmM9TzxxlmL4t/reproducer

## Build
* kernel: 5.10.222-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 3fac7bc30eab333862a04cd97d58564bb909e518
* git describe: v5.10.221-110-g3fac7bc30eab
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.221-110-g3fac7bc30eab

## Test Regressions (compared to v5.10.220-285-g6db6c4ec363b)

* qemu-arm64, boot
  - clang-18-defconfig-kunit
  - gcc-12-defconfig-kunit
  - gcc-12-lkftconfig-kunit
  - gcc-8-defconfig-kunit

## Metric Regressions (compared to v5.10.220-285-g6db6c4ec363b)

## Test Fixes (compared to v5.10.220-285-g6db6c4ec363b)

## Metric Fixes (compared to v5.10.220-285-g6db6c4ec363b)

## Test result summary
total: 81147, pass: 65856, fail: 1631, skip: 13601, xfail: 59

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 25 total, 25 passed, 0 failed

## Test suites summary
* boot
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


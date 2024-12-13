Return-Path: <linux-kernel+bounces-444958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6689F0F13
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDB1C162E23
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A8F1E1020;
	Fri, 13 Dec 2024 14:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jie6iTmA"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DFF1B6D0F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100052; cv=none; b=ZYJ6y7iB3Nwk0yxYqsDRhgeG6jh/As/p8kOeOkLs+QZllbGbNM8CjQAInzdXzC7j3I7sDOpGDCjmdAzGJ4xhm5EDdu6T1NBxCGrJjqJI9t/MPxvGu3tVupYIgj+EwJ73Y6LFME1nZhS0z0T2SpzAyJxhVIt93VMWiXAFcNZPm4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100052; c=relaxed/simple;
	bh=Mpm/LRwd7IySOim0PidDsZae2gN8BufbqTdj7uEiDdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcCXfhVN5k43AgNAQMVtC9RrrZJb6C1Y185n1w48PXhZqIH2CyEz0Li/5++ALLVh6UPvlY2gSAJmzDPDXXwsMBdYA+PiwjX5Lmloeyp04AFcV5UbWAxocaxlwXiftmIUKOVJ+c+klhiiJSOcV6eOOeYJpEq311C21141NCI5yiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jie6iTmA; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5188311e61cso506950e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734100049; x=1734704849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jDrucwrqBIUmyUbK2gTGdYC/lYz1YCAOzgB9+QZb9JQ=;
        b=jie6iTmAWqf7KFExCS0HZJroPqnUS0mZ0fvTTJKlq81UnHikvtOzyQBsgosWohpiG1
         P58qIxVB3vZsPwkdpvhjkNfK9CybqZzczO6QWlAWBIYAYtdZPQGlYr4qFXp/B1uesNsD
         K70gT+KBKDZkkgO9nLMalHmx3cOge//403M9aae+FIfxNnRc1h1JBtw+Iso1fx/R/k8y
         INHv6E7iox4L3BJ3qSiHDIR0tl9NMichXcF10rCRvqcKUAFhs1gJft34nWnyK2eGT1xp
         aIluwkUooh8DpyCBe34LAaU5xVfsG7fkZbvfcOSdWSMOuwOmKT063O7LtJhVxPRErnAS
         oXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734100049; x=1734704849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDrucwrqBIUmyUbK2gTGdYC/lYz1YCAOzgB9+QZb9JQ=;
        b=SwfCnqfpWehv3XE6T8QgKuBHwwsiaO0acFq3W+NNiGnDDLUaj7vMtAsu5SUWN3Jo1h
         mlvm58YWSPMZl3INuE7VeQGzqD+bFYRCjyj/UpswVw0aA73B6CrFELY9CcnaoFYqDjG1
         18FnEtdJbWoAJw/JGZuSMq5tm+qnSBL1nxQZaqJ+Ij4QeItyEVQLT9OeT6vaOosxRRo7
         10fhY5spiwx7uF9JBcR4wH+U5fZ9tKspBu0p7re6ucnyX5VDzAS5K4cLYmFFF8c5LXec
         Fj6Nqw6B9KoHs4KFfeIBnm1l61QXphF2r8PRTWx+ycqbgWcHlH7i+Fugt4C8f4DYKZ8k
         4gog==
X-Forwarded-Encrypted: i=1; AJvYcCUtGcWk6yE+mXhNnQ6aRgM7m4Pd6k7lOWXDz0zpEm11hcP9mgmvCvxWc669YyYVoICAVgAx3hPtdjedcH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtn7NdNmQ7CI38RpIGh+LX3lMsmdHgLwGV1/0yzL8rBZja9BAV
	Hz9DL5/YjYthJQtS6QkHNTNO1PnX455mK9GSa0Kz19UjpbhAok+gpkbephCpdP5RgewmIH/5P2O
	XZXbFz2UxagOEfrv6e0mRbgKZoP14m0njU8He1g==
X-Gm-Gg: ASbGncs/cL5Ys7v7T+ndAy/BGGLAyn1A58Wf4q+co3HI3W8E0AG/68ifhl6Tc7dCq1R
	JT4tHUGLikrQGq/VUrbor3iDUixD3mstOoufv+1E=
X-Google-Smtp-Source: AGHT+IF9Zpfo6h5y90m06XlevNuAJRPH+b8VWzhOQ2n7NHbhAbY4bKoFRFrDeNJvMZVeIv6vbwAbVLbWpFW8tTRxZf8=
X-Received: by 2002:a05:6122:a0e:b0:518:a261:adca with SMTP id
 71dfb90a1353d-518ca460b50mr2578122e0c.8.1734100049567; Fri, 13 Dec 2024
 06:27:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144311.432886635@linuxfoundation.org>
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 13 Dec 2024 19:57:18 +0530
Message-ID: <CA+G9fYtbkj_VWQYjPsojO66rRgbcovrWSCDsgcp6PGqWEzGxgw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/565] 5.15.174-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 22:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.174 release.
> There are 565 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.174-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The following build warnings were noticed on Linux stable-rc linux-5.15.y
while building parisc.

* parisc, build
  - gcc-11-allnoconfig
  - gcc-11-defconfigcd
  - gcc-11-tinyconfig

Build log:
-----------
arch/parisc/include/asm/cache.h:28: note: this is the location of the
previous definition
   28 | #define ARCH_KMALLOC_MINALIGN   16      /* ldcw requires
16-byte alignment */
      |
In file included from include/linux/skbuff.h:31,
                 from include/net/net_namespace.h:42,
                 from init/main.c:104:
include/linux/dma-mapping.h:546:47: error: macro "cache_line_size"
passed 1 arguments, but takes just 0
  546 | static inline int dma_get_cache_alignment(void)
      |                                               ^

Links:
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7pt39eCahVwI49vKMQD6qe12I/
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.173-566-g4b281055ccfb/testrun/26287983/suite/build/test/gcc-11-defconfig/log
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.173-566-g4b281055ccfb/testrun/26287983/suite/build/test/gcc-11-defconfig/history/

 Steps to reproduce:
  - # tuxmake --runtime podman --target-arch parisc --toolchain gcc-11
--kconfig defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.174-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 4b281055ccfba614e9358cac95fc81a1e79a5d7e
* git describe: v5.15.173-566-g4b281055ccfb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.173-566-g4b281055ccfb

## Test Regressions (compared to v5.15.171-100-g056657e11366)

## Metric Regressions (compared to v5.15.171-100-g056657e11366)

## Test Fixes (compared to v5.15.171-100-g056657e11366)

## Metric Fixes (compared to v5.15.171-100-g056657e11366)

## Test result summary
total: 54603, pass: 38929, fail: 2776, skip: 12823, xfail: 75

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 22 total, 22 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 22 total, 22 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 24 passed, 0 failed

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


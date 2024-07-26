Return-Path: <linux-kernel+bounces-263552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A1493D79C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9301F24A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE50517CA12;
	Fri, 26 Jul 2024 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yz0gSCKP"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF061CFAF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015023; cv=none; b=hQZ/HJS7vaoxQtcnOBUSjBVlWuIyotwfOK4HfEGUqifMkNJe/c9otiGrpD+vVRWg6JtZMB+BvweMlA1co528+j9VUqVmPIwTyoWkCIa2XUa2LeDXviBTwK4MI+jeJx8AYDBnj1qaR9qHKfZDIBdFjafMGBObsQrXDTyd+kxRFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015023; c=relaxed/simple;
	bh=S8BJyi6Uwi4pGudUQFqxr0+CrXIJCvw64+A1fnLG/HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aq//ajucLgdBidAzuPkIUNJTJQgEAp7nBcfrfcuIwD02whTdwQ06+Z20YeWjXrJ3GG8CJl5VIUVDcZQEA0YJXSw6owlZDjeDDm1IidbsjfUgM/bt6NhH9j/TcWs+eFQkDcOt92CJk0EvTjiDPW4HzEk/5/Gn2vJXNUr6vWqMGH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yz0gSCKP; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-492a774c807so795409137.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722015020; x=1722619820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ja9xurVw5McgAlny9cR/h9JB3vJIBFk+wQhogSUS8hY=;
        b=yz0gSCKPCQaa3KTnL2oidwKVPT1TaHkzDK9BqHvJmxMQHsEuGpziCZWBJ1gy//0UyI
         KLSV1JNS+7wbMllp0IRJ7g13h8FafskRtqv77A3DvU7kRQKZhHoWqwcJCX8hDOAED6mt
         4vQspKMtV4lKw/UgeSgTQVGsR4+IugchRtZBz8CAMxB9PaJ2XVDMHVr5N6A2X8+vnIe3
         sgZhMb0u0Y4C/lTwoX9p5fx3Y08pELpe2r4+ebhPWaOe4+SfI65BCFUD0wOynunLXPwi
         82f+wsmk3jH+oiguZiRi8vk2vF3T3Y4QI0K3fVDI7p/0pjkLZfqhil5/iZ8BACjpC1VF
         ghOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015020; x=1722619820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ja9xurVw5McgAlny9cR/h9JB3vJIBFk+wQhogSUS8hY=;
        b=AKIburMcdf5fl0EcGQJUoeKh0Qn6D+VtLvDTjpBLpeWuhHxTfG35X7Yb6DEGMK5tkS
         aay5s5y2KTvCEWYfEak4jbo3TSdmX6KijkvzcVLdMzBvOyKwJXlVtRBMunOWfZLylpJ3
         CBCChowwE5Iu5rnZdoftXi2mC1D3JoIfMbetgZsYPBPpR2YSJnB0hvk+8MQmV+co5Ftl
         L5DqjuDYeiSTR2p9DmAjlVSpDORocMWKImQb0XsFhv19O2tplivsVx+PRaXe/r1Pnvq6
         mdRlxHAloFh9Cp8SfeFpr3X8CKUC5os716THObjPZR75RbV6KZDtUOaPsEm03kJKlUZX
         1WSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCneQQUIsVzQJyeD9pf3ixf8axn3Px5uUq0N8z/E6bP6Vndqhje02xldqZ31UoGziiJhWmtLvYo22wi6jqXaOsWJU8p8gsuqs8nyeR
X-Gm-Message-State: AOJu0YzYC7smuenhYKiafOvN2Rbn0xwz4P4GIYhETZFUS+Nx7v6GByCd
	ThdwWmCpv23G60PuAV88e9ZwtYW1++gWTfHsoYYHCFnepIHJcd+jWfAQhcPzmg+P0/w0xemFR2g
	vdwZ3Oa+jdJUsjEOwIoAtCvFImBy7gBBg3zjC2Q==
X-Google-Smtp-Source: AGHT+IGRVWcS8NMtCwQCvQ+goUflnuWVyNyUIXLuSij5vzVj6Yor+/yWv4PqUqmRvTY8MIBihZ3/WFJh2pSxeJQJjmI=
X-Received: by 2002:a05:6102:d8c:b0:493:bf74:42f2 with SMTP id
 ada2fe7eead31-493fa1ef1fdmr467338137.17.1722015020145; Fri, 26 Jul 2024
 10:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726070557.506802053@linuxfoundation.org>
In-Reply-To: <20240726070557.506802053@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Jul 2024 23:00:09 +0530
Message-ID: <CA+G9fYv8meGAQm6LacVfUHci3mm9bsueZuCfXFy2C9COpgXXCA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/90] 5.15.164-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Jul 2024 at 12:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.164 release.
> There are 90 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 28 Jul 2024 07:05:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.164-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.164-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8730ae13275d35ced3e5b8bd7320d4e510f782ee
* git describe: v5.15.163-91-g8730ae13275d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.163-91-g8730ae13275d

## Test Regressions (compared to v5.15.163-88-g1d0703aa8114)

## Metric Regressions (compared to v5.15.163-88-g1d0703aa8114)

## Test Fixes (compared to v5.15.163-88-g1d0703aa8114)

## Metric Fixes (compared to v5.15.163-88-g1d0703aa8114)

## Test result summary
total: 91890, pass: 74826, fail: 1744, skip: 15221, xfail: 99

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


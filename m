Return-Path: <linux-kernel+bounces-445990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A55D9F1E3A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 12:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B222E1886073
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD2718D620;
	Sat, 14 Dec 2024 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+wQRzou"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A42187FE4
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734174987; cv=none; b=AoGxC3Zd77gIFQJASmj+lqOUPJ1b6vmrNM/KpsYmNmLUAvNz9mXRyc27jeih3qJ2oQffThjhvHQt4iRzzvHmQwDByTu1/CfGZn9btNr89Ezn9LOf1LhdylxKFvoWHZt397I4hbSnZOv9RM8UYURnm/o7UHycuATmcQC6H80W/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734174987; c=relaxed/simple;
	bh=Bq7EyBCrewGf7WfUYPsT/2jbdKTtf6N3GhCPqzaRkWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wfw5CsGPPzIq/Z8JR9j2/NtCTt4g2iqEpFN/LsUEA3EW6RI0wvXGXv1SVwCUJzZFz/EQ/F60KxMH71loOrUdp7HVzZp2UeHk/8CRAFNHpaTkVEEsZLpTK10FrpPOqhIynEoJxt4L5g8ubviGH8nz+2lnb78mQfS0GEF05JKztoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f+wQRzou; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afdf8520c2so734052137.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 03:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734174983; x=1734779783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTzKYRBN7u7k96cZPNQrKsCkmmERoC0Jn8Dsq8skyqo=;
        b=f+wQRzou3gyRtOV0fZFJsMFYpYhLjR5fOzCzIs1N1WeQCjJ2hdE6UX7ybErwOr30gB
         cIop4UrLITKiA1zpJBtF9pztziX32+Whf4MH+tbxcNGnQmhRQKynPKrDe6wgfXY2wIs0
         ln0eBkHMQb7hMU/dKh7lnB7hI/UHZ7cK/mYfMPD1uBUpByChrdKRvdIkL5FGGPtOZEg5
         ggelCd8D7XCcQ1rwNvGL+HLfqY1A0C79iKLjfE2LevK9YoDKkv9pXwq1Ypi2tObEyK/x
         UelUOk3H5QDCS87XjRBilweBylgL9X7ZNdUtnAuyQzS9OdPB18NkI6JO5RRndxP0myqO
         J6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734174983; x=1734779783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTzKYRBN7u7k96cZPNQrKsCkmmERoC0Jn8Dsq8skyqo=;
        b=T6Fvv48uBV+uZwrRkNljFxNXL6PecjWlcZaJ/0dxsSr8mM0XzXqGSsUc9N/ZIb4EXe
         081y8zGXiyT3YvKfpsZ68XPYiBerjJUXsiDSqSgJciRQ6dW2iJKgQbSfoLa+kQR1cHwq
         2H/Z04Q2SoFjQYdnq4P/y5En4T39vM35M4JAR2jz2ILcyjJz/j1X8Tkl5jLtGCoTMBFw
         uw9xV5LwFXlR+9U/3AqTLTIOF6+Ps7Ht/rlN9xGd1lhxg5jlH9ZjTuMVVtbr6HtQryKP
         jlHiRWqOoMj7S1Q8bIZIDGhNwg44+U49Ck0JmIFIu8iZ6JAA9JRc+VznOuv+yoGmANEf
         /Hiw==
X-Forwarded-Encrypted: i=1; AJvYcCXzjC8qNoxL32VVFudX40/wpaiEqIeVaK2du7w74sDB8J4IU9+6l10WXXL4qoIJPZ6rmBAaZ4NOZq3iL90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzec0qUtehoME5mQ+LnuslLFcmKc/F102k1D8o2NcH/d4c4qD3v
	gmm6azlNsnoyrv3BhERCR6leZ0ARxtMCu0RwAt4IePXSzyWC1sK4uAshkLBWBbnh85XXEFOOjQ/
	qYGCW3srvFdovgQQc6fqPO6469ICtd/g7RQ8iKA==
X-Gm-Gg: ASbGncu58EXBiV8phdywYy13sfCr+g5YXVgsa3Ai+k7+YTuFtcr4SzEO46/M8RUN+Tv
	pM7IX/2Awn1MNqoqY42lK43nqrddtUgKQw+W+v8AwPQQzIrmBl7bVLZzKxBXLLg5C4k5qsiI=
X-Google-Smtp-Source: AGHT+IF0zY/G5VOaxPikTt0DPkKqZJjwV1QHu77sXbzO1ssmJoEODDm+y9fgDuh1dY05j8VxHlt9+0OKE5ho/wRkdQw=
X-Received: by 2002:a05:6102:3587:b0:4b2:49dc:44cf with SMTP id
 ada2fe7eead31-4b25dc619c0mr6694176137.2.1734174983455; Sat, 14 Dec 2024
 03:16:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144253.511169641@linuxfoundation.org>
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 14 Dec 2024 16:46:12 +0530
Message-ID: <CA+G9fYsERkXC7u13A97Yhc_iHup-5uNsFDz_d41=NVpX+QdOBQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/459] 5.10.231-rc1 review
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

On Thu, 12 Dec 2024 at 22:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.231 release.
> There are 459 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.231-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
-----
The following build warning seen with gcc-12 and clang-19 and
clang-nightly builds.

Build warnings:
--------
linux/kernel/sched/fair.c:8653:13: warning: 'update_nohz_stats'
defined but not used [-Wunused-function]
 8653 | static bool update_nohz_stats(struct rq *rq)
      |             ^~~~~~~~~~~~~~~~~

Link:
----
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7sxmkFm8o6GI3rp=
D4gmlFmbVj/

## Build
* kernel: 5.10.231-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2146a7485c27f6f8373bb5570dee22631a7183a4
* git describe: v5.10.230-460-g2146a7485c27
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.230-460-g2146a7485c27

## Test Regressions (compared to v5.10.229-83-gd7359abfa20d)

## Metric Regressions (compared to v5.10.229-83-gd7359abfa20d)

## Test Fixes (compared to v5.10.229-83-gd7359abfa20d)

## Metric Fixes (compared to v5.10.229-83-gd7359abfa20d)

## Test result summary
total: 49631, pass: 35698, fail: 2910, skip: 10999, xfail: 24

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 101 total, 101 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
* i386: 22 total, 22 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 21 total, 21 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
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


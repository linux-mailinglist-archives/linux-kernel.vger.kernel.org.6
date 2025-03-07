Return-Path: <linux-kernel+bounces-551029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CF7A56723
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0183B5549
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFE72185A6;
	Fri,  7 Mar 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JammGEHU"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936B2217F2E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348415; cv=none; b=ofyyL4jQSJNo7xaZfM26e25heafb81lEMi9WqzKWwMTG+RmG2cKWmKjNe1yPGalDYJ6Jkbhqsm3M0mFDLRN9mM/TA8/kd+h6eR/FmJS9quUnLGIUXzjgs1cXzZoS2BpnAB2sb0/1hN1/Qh4fLn3ZqUZvlm0F2iz2s/NJGEFYIyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348415; c=relaxed/simple;
	bh=xE747tlTQLAxgh8NtAjUgxI+rHa9+PyveNJeB4853TU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRYbycDoNtqSLdE5dmBfIDUsUE71Zif2J9HinhADgiTklUuMXuTyCJyuFmFJmvkAGYWXQ8UyRxlcNs9UYLtTGJIzMR+kgHfq/AAKXD0zxjntB/kVQJqRNOEgFMvm5G3sCZd9RamlvrlbWLW4+XuoaUWgn4USHXGDVnB6Dl1Hqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JammGEHU; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86b9b1def28so1517652241.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741348412; x=1741953212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WD9jmJaU5i8Pw2RiIsBAgARfcboGYACiY1rTXf4iik=;
        b=JammGEHUzouohNIJniaLOBy6qBE7IkGJp7HRGnhGl2ArJVV0P+kryHItcYaqpWtL1m
         AxGcP6k+DNyBZwCIvPHJ5zzkuBT59BKGflpf5oMODMZh5Uc1bIOwi68OgSWCEuQwUXNS
         2MtVpJTDz4zlbVah8kcj9/SC2152FnA/fkFfEW0r3QOqo04zLaBQEmFAyd1DLnVo3eR8
         i3W45+K/ab/mvDiy1GP9tZR77cOjq6Mu6b+3+Gv+0uZAuct+TiYcCWhGhcgxp9mK1/2/
         mjJdfeyaMn6A2g8ocDGjv4xTQbQhu0K4emsFZ8f49/FFsbLtGlUFdzmX+M5h4wIOhsgc
         jOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741348412; x=1741953212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WD9jmJaU5i8Pw2RiIsBAgARfcboGYACiY1rTXf4iik=;
        b=qcF2QWPcioH3stvY4h3ZDu+HOdOLAs+VCR+YNJcFi3+CSBYFLe5amsukd4rCQOvEME
         Zpdu+HC41BXRudJ+1NkrVetHeHuTH5G3hqAI6J8FLy8kSNQr9I6ydhwDigIQuE1aj6Pp
         iY4Q7yNvZIjk08bi3xaqTTrEbsiuDpVWc6rsOzPLIORlFnZvJYNq8iObxTRvCQWawoXR
         sic+VMa85STOrY5KjWP18fAzc9dFBqq8PDvhg55yKN4ain3oDomwikPN+3oPIIjRYVqt
         tHF2yumYiEHVnw17d9nILp1vz5S0lynUwNKmsS6ujxm6wgWGVh7RHWL0NnelLuAQVhS2
         MxYA==
X-Forwarded-Encrypted: i=1; AJvYcCXoCDUzlrId1dea88jIEnuKOPrWTVJKV6TgQWxULB4uwtLlgYcACCVKeYZLbbGAy0mo2bp4yNgNlZ6Yb2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS2Pr9Jky58hGmSuZ9nJw2WEtK+gaG7YYOMiqw50e17uLriCE5
	kohBbYjkoNi+kkh44go9OA9di5uXH9OOQZGgncARcf4BLnSJ1j5nHCqdQK+xTmOGbLpkRSqZAcB
	IK1TRGAqBqpd2Vhae0vHlCOZbH1njx7Kf0PuQoA==
X-Gm-Gg: ASbGncsZbkJliD1hHxGPQOoE5/t3LvnyNbm9mxK0VIwVsZXPSwCLHikXJpi3pxtB49B
	+sICHviPUUJJBjAX2PVvK6rLff++YGF7BcbQyIJxlyVqeV8/Q8SMbBWyPnuYqZZOEHHZL0ffYN9
	tUVENDQc0ygO2PaHRlOMHHRrDLEfbbTgJf3BAQRg6nKW7+5PpP0nLJrFL/eOI=
X-Google-Smtp-Source: AGHT+IEok70NVqqxgLDMVhU3m5iaGPJbZFbySmXavI+i0nsu6a0PolvKnH3i/MkXFm3c1wuurNezwxl6ZQGmpGANcr4=
X-Received: by 2002:a05:6102:3caa:b0:4c1:9b88:5c30 with SMTP id
 ada2fe7eead31-4c30a6ad49emr1719230137.19.1741348412369; Fri, 07 Mar 2025
 03:53:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306151414.484343862@linuxfoundation.org>
In-Reply-To: <20250306151414.484343862@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Mar 2025 17:23:20 +0530
X-Gm-Features: AQ5f1Joffh2sqUY2oqDqeKH0v9gxxZrKALDccy4nN82WMvdcgJzBgWa4l53hDcE
Message-ID: <CA+G9fYsOasubSbr1G3p=zu7vVGSCacEK-fJteJFSK_3NXUddkA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/161] 6.1.130-rc2 review
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

On Thu, 6 Mar 2025 at 20:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.130 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.130-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.130-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 029e90ee47c2263f170d2a45370a7785d00ca34f
* git describe: v6.1.128-732-g029e90ee47c2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
28-732-g029e90ee47c2

## Test Regressions (compared to v6.1.128-570-gfdd3f50c8e3e)

## Metric Regressions (compared to v6.1.128-570-gfdd3f50c8e3e)

## Test Fixes (compared to v6.1.128-570-gfdd3f50c8e3e)

## Metric Fixes (compared to v6.1.128-570-gfdd3f50c8e3e)

## Test result summary
total: 103810, pass: 80922, fail: 3936, skip: 18501, xfail: 451

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 46 total, 42 passed, 4 failed
* i386: 31 total, 25 passed, 6 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 15 passed, 3 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 34 passed, 4 failed

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
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
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


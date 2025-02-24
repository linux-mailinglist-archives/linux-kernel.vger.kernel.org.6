Return-Path: <linux-kernel+bounces-528390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4BA41732
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02761747EF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7C6193074;
	Mon, 24 Feb 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oFiToFM2"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B3185B76
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385215; cv=none; b=AYDUV+k8faTTxShgSxksnAkKgqWNqC863Mj/TQ351jhQgaLYSijrfT3PZfMSkzr45KLSgbrWEv4oWYZQzrAMlw6ZuiP0WjMwLaPPWxbihcXWOBbAvJiTeaakQp2ZZfOwzF+LbBk4G89g0iHcQCOelD6G238RbXGPsKjZqsLkHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385215; c=relaxed/simple;
	bh=21E7UgrvRkxRMCUgPTzjSwSV9qomtLwoLuLUv0Zpa7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxU9aA3vvb1C3NR8gNQ0tDuv7D1d42TsjQHWTHFqZeNcob+2Ed/kXLDAxFpHjQ1JErsI8BHEHEfR00yptRT3qUwsjQkgQoQC6/Kv5JBrytULAimNUGu0HxIlBvv/f2nQ7jJRJInwH0/256PV/EvC8Rw/905qjHMOGxMpvJxWmo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oFiToFM2; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5209962eefbso3177145e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740385211; x=1740990011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6r85kezRIutcCGmLi1srTZWWPXuVJ6TvYefvLy8aRc=;
        b=oFiToFM2RRqtIdfQ8GfyOV6Aa/uE/qT62hHNpX3sB7DbKJylU5+bGU3p+fA/etXkQV
         J8MYSbdVhgEkceayh2Yg7BGO701UDjmgp7Vns9hITq+iwPELrEJ/WzTF0BIXA4/cKd2U
         tksZpfCbmU+84sNCUZJzB9o8Gen65mU/wIS3P4oJ1Ntib9i4ge7XibGwgDTAeyHfgZMe
         pveQ+eJmMl+aVn3HNEWhV3l+20NPSDM7woK4nMfR3bV4d3/KJgHc1yaGUnympydo84NC
         TSF7kWfJbv6C7RMor/fZjswVec8ZFHTSG+YrWTnpjd4Q6d7RT8OT60bCG5uLhme/qZjL
         35tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385211; x=1740990011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6r85kezRIutcCGmLi1srTZWWPXuVJ6TvYefvLy8aRc=;
        b=UCBEGF5P0cZnoenDRYQCVmUUf1vQlDQWXHeTWMFC1NqqIwyowcO50vtNwsaHiTwWRt
         EhrL1hZG6YTFLqnmFnQN31xkMFHZB1B8SMpaeJ13Ib0stZf6lG6EVGpTNKGWF+Eo2Eoa
         AQMbqRXMv7IXdv3X6LvmpQUjND8CfXMXjF+12mZB1RS0ytRMaVaSck1NZPokeNLfGKL7
         6fzEFBlccfRuk0JbqQn4Rb2JQ6HTKsA3oIH21dQgd41rwgKLANxAU+v6yY8u68urtJK5
         TuPLwQq2XnMePEpE2f/00WkAJhcX2+N9Q/EQAWfZXWnpJ8VO4qrbU/Xy5Ks/SRxecrsK
         10fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxjWzZoSLhU4qEFUAW5Nk0gTcuLu+LzVt8C6ZUSpRTWbKx8rgM8nUB3RGBgSEiuq7DydgvqA51urVsjns=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdTmWM7XEwygNV6ihK/BlKlK3TbxIDIMyKz9Nnoouf8iX07Aw
	EBrCDS/ktlbSl0XUW7g2Yy2TzygLuFZOcJylIsKJBT6yIh5cDHswTj6f39tbYhyj6uzTATgu+kx
	/EDzg26pf9W8d9eN1K+RHsCLfJJIN8+0RDmnyZQ==
X-Gm-Gg: ASbGncvMgeyP21WRA5FbojLz+gaHoZM79uXZ42gL6Jc65H/st2hzLmBVcNXeKf05TDt
	RDWeH31947VJ1MZXZ1TqKxbz01JlALtATEQ+CaMv+6WTfmccgyVijzd+XTIUCntAmDRoxzVwOzZ
	0hJdktfCuYnZyh2sH4Gn07L06NJ4dV8a0fgS32Cddu
X-Google-Smtp-Source: AGHT+IGGzBs8e4QC3zhjyLv0Q2Kb5xRXaFl1GSs1fX52Ac61Q9Lj9A2GVQb5hQJPza9sD0lao51FBajmXwOvO1rVoSk=
X-Received: by 2002:a05:6122:3190:b0:51f:a02b:45d4 with SMTP id
 71dfb90a1353d-521eeadca66mr5091486e0c.1.1740385210804; Mon, 24 Feb 2025
 00:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104500.178420129@linuxfoundation.org>
In-Reply-To: <20250220104500.178420129@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 24 Feb 2025 13:49:58 +0530
X-Gm-Features: AWEUYZlEaOoTQqQ6ZfWquTdxPh6cQo7pAekxnBccb5yJ3vfsbf5zMYnRWYnbUyE
Message-ID: <CA+G9fYuGk8vO3-OHRe3AHzgDWhNYWpZnuhT3p49zytXgeCN1Gg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/258] 6.13.4-rc2 review
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

On Thu, 20 Feb 2025 at 16:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.4 release.
> There are 258 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.4-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.13.4-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 191ccd3d65d15205ada79613c4f4a38e01e56b28
* git describe: v6.13.3-259-g191ccd3d65d1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.3-259-g191ccd3d65d1

## Test Regressions (compared to v6.13.2-443-gf10c3f62c5fd)

## Metric Regressions (compared to v6.13.2-443-gf10c3f62c5fd)

## Test Fixes (compared to v6.13.2-443-gf10c3f62c5fd)

## Metric Fixes (compared to v6.13.2-443-gf10c3f62c5fd)

## Test result summary
total: 125960, pass: 103347, fail: 3715, skip: 18898, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 137 total, 137 passed, 0 failed
* arm64: 48 total, 48 passed, 0 failed
* i386: 17 total, 17 passed, 0 failed
* mips: 32 total, 32 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 38 total, 38 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 21 total, 20 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 3 total, 3 passed, 0 failed
* x86_64: 44 total, 44 passed, 0 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
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


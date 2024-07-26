Return-Path: <linux-kernel+bounces-263572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B93793D7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E46283C37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9A178CFA;
	Fri, 26 Jul 2024 17:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3DPqiEG"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755D18AEA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016379; cv=none; b=gs7UsMYeKXQhwvweV+YXDoZXwNCLlV7IYQbcuOiSEcwN1rf3M5zfASOrh2lEdL4Lr7KE6DmwbCuZZzzMrRppDIYEM77M+Elgxw/r7XWv+FDHJTCUsbXb1H5k2owPRt05E8MhBzL8hBVJslMZPHtDGfDx2AEx4dwTefGE5Clxt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016379; c=relaxed/simple;
	bh=mkF+Pee6lb1ToWKFNH60jhVzkBYIt8qW1uZTFxDZ+zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uwkwhw7a9G5IY57w9UEmo8BFGwHephOJ1zGMA7Fv7wKayz/eG/goke/yOCiueBvRWZqXhNmUHBkGi6DwE7xB4mFfuVl3mFUQn92Ty9l4J9ruM4pqgDt4loY31Rqpifn09cWCYf8hW3lYwVxjEHNNQpc86Wn5IAlwTMARQ2ESq4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t3DPqiEG; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-822eb80f6e4so266673241.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722016375; x=1722621175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x12eU06nk/b6qPGqlVPTZBZDUnzaXcNsls/AJe1ig14=;
        b=t3DPqiEGgBlk6MyV5HmgqhLZWc1md3vNWVnFZODhW5KoM5aAr4OxZqPr9KeSyapZYZ
         zPqfQQrYEulC2WcPvy6zURRYaU4nlr/v0XQKHB4OxVJAzUcjOpLKDuEC8g3E4VYLGMRI
         jrSceDFa7fPMLlptVwFUtkcySutlgL1dmszsgiLHHtsw3S/VoTGX/crekrS5gPWflQJj
         vT5BECwVs1710TnmV00qst2oAlaqfkHn3Xl6XONkcvJ12HDk3NaswjDi05r5qkuU1fdn
         MMWQkGBG+4EpvO9HOR7J6XZLnlohyvDewcpynrPr48zaOsEjMHGTXWeaK+vJ8ccl5y/Z
         Sipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016375; x=1722621175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x12eU06nk/b6qPGqlVPTZBZDUnzaXcNsls/AJe1ig14=;
        b=D2wgS3uUwysDRrAh5Dk7SsWBAIQL5h8rKnTIK0sXg7JgsUhbHqDGTrAj5VrdR/FV/h
         BDKSaIeDCgf6tsUmNo3oMHpsUpGdbwnqOJ8mnKAVUWSTR58GpFjjR8+jMuNv2tbxJJqT
         npBA/MZrEJQcg2dt4KZsHX9i3utIXXvsqkFaG+szXemCpMb41kR35SmUq+TC8CIu8DKx
         yldVvlaZaGDUGRzO436FgyoWyaxZzk11vtsPB5DX6ESDfm37Dod/Va+env52J+iDMdRy
         wNOy+zWqiqL2wbvrpcsV2Gad4Pn9G17zqdlzuL5bK6jT1QT0fz1efq1zzQHB2xwto+Vp
         lOPg==
X-Forwarded-Encrypted: i=1; AJvYcCXBCp0+TlOsaepzUQL6tfjKMVcpnoCVaGoG3pyBmnhlb4GYsibYLRl089bKEEZZlBq1eCSCjz92XGgNNz2+yfHwFNYK/8yeGOsJQeiN
X-Gm-Message-State: AOJu0YzgHxQMcsI+3yOjnBz1LgE5v6F8f/tV23/IM7fTfzy6sVLMF+n2
	b+aFYiO1u7WKBv5ZgYyUmK8Bycb/YMY+0hAL+yHIPwXzoVGuem/GDQDIM3x+O9CYn5qDIn7LhbG
	HfpUIFlX3rCc2i2biVUFOi57AS+1f+7xjouYhVQ==
X-Google-Smtp-Source: AGHT+IHDXp+ujHJusVxUfPG9lAeVWXV/StaxhOMcw3TgC/hxKR4ZDDwvx8aoDwvUl59nBDgOmeRr6zb1PPKijFBH3E8=
X-Received: by 2002:a05:6102:4425:b0:493:be92:d1f1 with SMTP id
 ada2fe7eead31-493fa607925mr719766137.28.1722016374981; Fri, 26 Jul 2024
 10:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142731.678993846@linuxfoundation.org>
In-Reply-To: <20240725142731.678993846@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Jul 2024 23:22:43 +0530
Message-ID: <CA+G9fYs+KxD_vOFwndGQNHfC8bE5f9-eiCiL6dO0aux7H1ugLA@mail.gmail.com>
Subject: Re: [PATCH 6.9 00/29] 6.9.12-rc1 review
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

On Thu, 25 Jul 2024 at 20:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.12 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.9.12-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 692f6ed6607e027dbe476c8301112605c72385b2
* git describe: v6.9.11-30-g692f6ed6607e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.1=
1-30-g692f6ed6607e

## Test Regressions (compared to v6.9.10-164-gebb35f61e5d3)

## Metric Regressions (compared to v6.9.10-164-gebb35f61e5d3)

## Test Fixes (compared to v6.9.10-164-gebb35f61e5d3)

## Metric Fixes (compared to v6.9.10-164-gebb35f61e5d3)

## Test result summary
total: 253976, pass: 218579, fail: 5284, skip: 29585, xfail: 528

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


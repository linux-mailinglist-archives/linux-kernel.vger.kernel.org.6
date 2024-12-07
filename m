Return-Path: <linux-kernel+bounces-436153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9229E81D8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 20:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0AE18842B4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 19:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BFA153BD7;
	Sat,  7 Dec 2024 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m5/0OEL8"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CC29422
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733601033; cv=none; b=AFiYHycaZVMLJ7Q4FmwKSl90kMsX01CfIoIeXF3ibFg8IlkoWWpyhaIoXAJWcirHs9DNGIP+uvOvv/MNu+hzOaNfqDc8t3f+hhFar9ERJMJCu/3LRDkFToE0uQkDL8/VesYftnb+1BA0KtGWMG+gRgVY7+TO3VfC/glSNMR5oW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733601033; c=relaxed/simple;
	bh=LasN9bNIN9EL+ojIMojzUljyOQcpwv3EZmeltoqkT3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIbdqlQeP+wZDZoBuVZ+5QuzO0Atz4kSsqJWmIU5qFl6A/NmbOrAcsKHLU4V/D/pIOZEPBv7VDbB20AG+jhIAXydnKLm351wVNo4mx6eaacnSdmTVpmdKzw0JoA/wCLfoyCdQ/+M3f3yAEq4W0YrgnD/Qw1Yt1lzr5olwxRXYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m5/0OEL8; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afd68271b6so392356137.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2024 11:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733601031; x=1734205831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pMemEtN4tM9lGXkUkEycvngJOia/lhXbbiYY9m4/38=;
        b=m5/0OEL82oKDe3tCvi5FXlLeeoBzHqz7vf0DAbDyIBwA96z+BtuXZ/ndZIuTBpoPX0
         fJ/b96BxoKFIz4zyhBQH8B26JgGeylHZDZPcVXSe0OXLWJj6v4U3J9eFBX+MSKqxV0FM
         kqSVxSlDcvRX/9yVIqnMwdxCBuzNzhnMVGB4ATnHbxOlrGm+2ybkJ/Tjzs4bFA8LWsUE
         j0Xcge1PhMkYOLjmcbi3jNLaGUgF5riDSKnGErxwBl+Tj6sDmOIyzKu+sVC9z0k8hYOd
         /vVLFoEqnuVkvduF9253oyAwByAPZAxaY8RLODE4n4OgZfcwYGRsUIxfHTLZp46FSkrM
         X8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733601031; x=1734205831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6pMemEtN4tM9lGXkUkEycvngJOia/lhXbbiYY9m4/38=;
        b=Y1CRmsh5kc4xTjKLDVuKJhAqGmKKLxLGsUyT+Cp68SYAZjGsuOAEVJnSZc5jlcHoId
         gZYY44xacnp8ZT0wH6fOTE4YIbx2H7MFiWg8cCos1zSh89kDPEAf3jz+v34ARa4wk+i6
         +de1szhwBqEQ89AWmMvaVnTon5Ra918GZAr6MxXINdVZ1RsWqjq5IdXYnpgE8ph2SZZi
         N7iD10+m7mSFlqqphdCVN0m5tkeOQ2hYZ2MYD6oaCtiWLUQ+Hc8QToqseAhWK+Lj5tZ4
         FmnvOM/iO1fwRCjLc5r541Jj9sWqwgrmN5zNpwiKSILl03hJgsMHxGrw+TOTYoGcKR79
         kBnA==
X-Forwarded-Encrypted: i=1; AJvYcCVY/lvtfc7OpGwF+bNAqHMUDDvCA1VVObHjCTvX4OUi5KzuQSn3bNSZJBDtJwRzon99veGh6jaE9+mzutw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOjQwe0kUtmLO2/yITbn+K+nUocq2tdBOV7TvXmiW7mtnsuiIN
	wGZtOj3+qrOv4pEN4iz9P0uQNT93zFXf1d1hBOLXKnrt2PCfJBaA8drkmKzaR1RP33cGke6daRA
	l3SXhamLGj48RkjRCNLzYLccdzxxy4yyJwob6VQ==
X-Gm-Gg: ASbGnctG3m8pm0N8KreszN6sWCOuQArnbKPoGxZ1L6sXNE9pBY/gFfk5q2sKghxNICb
	2lSMYc+eTsFONpQDtOxIOjOqjce1tyPh7/bHzlhlUSFI0EeMpK4iqSVYngOBUj5ZU
X-Google-Smtp-Source: AGHT+IE2gENhy12bTe+/tsKANEZuiXJ3HVZ8w1wx43rB+V8qnuRXNZgT7/Z0ACMbIPN2eLAYuSn5mRKpOP10D8Fn0qc=
X-Received: by 2002:a05:6102:5094:b0:4af:bf62:ff4a with SMTP id
 ada2fe7eead31-4afcaaa4539mr7391371137.16.1733601030992; Sat, 07 Dec 2024
 11:50:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206143653.344873888@linuxfoundation.org>
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 8 Dec 2024 01:20:19 +0530
Message-ID: <CA+G9fYtsYhXwhewSJUnGAwFmSa5AnOvuREZiOGRCsOUWb6Kx3Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/676] 6.6.64-rc1 review
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

On Fri, 6 Dec 2024 at 20:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.64 release.
> There are 676 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 08 Dec 2024 14:34:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.64-rc1.gz
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

NOTE:
[Not a kernel regressions]
Powerpc clang nightly defconfig builds are failing on stable-rc linux-6.6.y
clang: error: invalid value 'r13' in 'mstack-protector-guard-reg=3D',
expected one of: r2
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2pqeSKGTShWpi3PB2=
dFTogUwhpJ/

## Build
* kernel: 6.6.64-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1415e716e528f373c2804c2209aa7af6706f1e71
* git describe: v6.6.63-677-g1415e716e528
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.6=
3-677-g1415e716e528

## Test Regressions (compared to v6.6.62-83-g2c6a63e3d044)
* powerpc, build
  - clang-nightly-cell_defconfig
  - clang-nightly-defconfig
  - clang-nightly-ppc64e_defconfig

## Metric Regressions (compared to v6.6.62-83-g2c6a63e3d044)

## Test Fixes (compared to v6.6.62-83-g2c6a63e3d044)

## Metric Fixes (compared to v6.6.62-83-g2c6a63e3d044)

## Test result summary
total: 157880, pass: 131063, fail: 2706, skip: 24032, xfail: 79

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 128 total, 128 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* i386: 27 total, 25 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 28 passed, 4 failed
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
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs[
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-ip[
* ltp-ipc
* ltp-ma[
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


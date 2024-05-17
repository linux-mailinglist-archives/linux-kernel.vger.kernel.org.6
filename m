Return-Path: <linux-kernel+bounces-181914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A523A8C8336
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF6A2826FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3DA20B02;
	Fri, 17 May 2024 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwBf/bJi"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2061EF15
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937816; cv=none; b=ilao7yqtL9FQrrDbPAxkgNHtlPy48uLs2e5rypRoImY+7otMwoLzZmV00BMptCpXtGMqK5eMkImN1vLHfQ0xICN61gMrlUrhOflIvHuvJFRg5vitWj+jvnwXmUqgte7iQN7JRrpEweX6awrOh3QKwty9WCGlRLctjs1+d0P/YBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937816; c=relaxed/simple;
	bh=6D0PgZh5ELvFXyTcgoFpJhETrNgNZpsVvz9yn6U8duQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hu3XPXF1gzQByonCrd2nNW1jXD5rKjkay9mWOykj25MY/oiZcO83ZvgWRPCobTt823admrbp7ecRVUDLKZlh3tKarNignvNy2e/aHT7rZNmvU1B0aZbptvAFOLP7FWvj+cFesqsNZZKbbzV1t0cmhB95aLfWWysgVZPBFoeemXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GwBf/bJi; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7f7c0f2b525so154263241.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 02:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715937812; x=1716542612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD99hLiHSRuQQi8zXewF0a0qLZ2u/ioCBSgtrDDxDYA=;
        b=GwBf/bJiY5cSWoQpFfVCBIS0mL/Wa4CM9l6csvdulSk/wfe5+PnVh72DFdKNN+L/0f
         tUZQQV3N0ReV1quY21s55y3APIVCpP2tARGmQHwjVEp+hFRkZ4Gc6zt1F+efVkMsip6o
         bHPkFEIPgtCcX/j4GtHS0zQtPoFYqyrZoF0ZHjqq5iavkVgxjzDD1DZ/mni8cOF8OngQ
         IwOBnjryDPNwIvMeZF58uEd7c40D+IVlk86RG427OH/ewghgLyS+t+WD7wvBXaMaOmA5
         QwZnCIiM7DEGZ8sSnQdxUl/togh6VOh4fHdTkq/XisgBElsjywqu/Z+4DfdvhaaJiwPE
         /3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715937812; x=1716542612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD99hLiHSRuQQi8zXewF0a0qLZ2u/ioCBSgtrDDxDYA=;
        b=OjOpD0AqHlYiF0znIXiLjDpm2EW830JSqYJ5TNQDfjLchqBcHySzLM2qHoAK0E6JJO
         cZzzNyehZFOGG0mY1IfgBfI64eFLqvSs1TUn86oDJ+wnfoWrzmbl9L5YfDAOuq/PMT2d
         HUJ2TzEdvw07T1dAvYv3AnIf3aT1255MAUY8cCGFR0tPHw+HXGPa78Gphjh2H2yh6eGC
         MqCftR3ohiNfISJJ4XZVzLKK+8i4X26evFjdlHV/T6cfucijwGzVWuYYWNEH/naY5sq1
         Eigx0KQ+qNt9QbGLeFfBwv/DERdOwQnNapfCpuGUAhbs+0sSZ5IE5iDR25OeQ7EFMSXZ
         hFDA==
X-Forwarded-Encrypted: i=1; AJvYcCW5jpwGTMdroowcAJ2Z+X2zUnzr3aJVDnw4Owx/LvlNa/8MakU91ZE2FJVHhBOZXwqSOmYKAKoI+G33ACfBiZYB09x/l/5sXMwx5vUG
X-Gm-Message-State: AOJu0YwFDDb2Nb7qw41xbRN9HkG7qQA439fjY85Yk4WN07HNAy8SgOxe
	68vQm3FOSRPVEh3ftwM+JwCxAPt+HjYXHU5agMu2VbsaniK8MrZ59SgfYRZcwFbukglJw0lGUFm
	x2puDYwfUEHSFyr7n3PdXeXqPTu4+Dc03DpM7Mw==
X-Google-Smtp-Source: AGHT+IHogXrZoqTS2h6fvQL9v4LVR6R+zCafq8r2UzEzxLhWlgbkc/Apn+0itECTQLPPVMur+cw6UpIapevQX/6Drj8=
X-Received: by 2002:a05:6102:390c:b0:47b:d6dc:af06 with SMTP id
 ada2fe7eead31-48077e5cb20mr20977968137.26.1715937811935; Fri, 17 May 2024
 02:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516121349.430565475@linuxfoundation.org>
In-Reply-To: <20240516121349.430565475@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 17 May 2024 11:23:19 +0200
Message-ID: <CA+G9fYtzqnwm1GLeiLeRx4ozMc6AGjOLKYuXnjJEQHJFtDEC4A@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/339] 6.8.10-rc3 review
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

On Thu, 16 May 2024 at 14:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.10 release.
> There are 339 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 18 May 2024 12:12:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.10-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.8.10-rc3
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: cb6ab33e1bb7469fd441b6a9c50c92190913ceb3
* git describe: v6.8.9-340-gcb6ab33e1bb7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.9=
-340-gcb6ab33e1bb7

## Test Regressions (compared to v6.8.9)

## Metric Regressions (compared to v6.8.9)

## Test Fixes (compared to v6.8.9)

## Metric Fixes (compared to v6.8.9)

## Test result summary
total: 254634, pass: 220877, fail: 3274, skip: 30101, xfail: 382

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
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
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


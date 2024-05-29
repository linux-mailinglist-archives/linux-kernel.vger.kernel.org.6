Return-Path: <linux-kernel+bounces-193411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EC98D2B7F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 05:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EAE28AC55
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 03:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1651E15B148;
	Wed, 29 May 2024 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNWGDm+d"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2392915B13B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953461; cv=none; b=Ww/YZ7AwNf1mZW/oYUj7LhDuqSLastWkfPBbNoJwuCmD4OdoA3vksW1F7LoycIGz+wFb4L0v7BwrVt5J6swwd48gna68KQlX2tZEhwBwsF/tTMHvAW8plz/NTfo6qq0sZNuNQkCqtC4G3uMIuph+U7VM8QKaxeB/CXPUJeWODWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953461; c=relaxed/simple;
	bh=WGvapV72YXaT1dVi/hBHchlcENMJadbSp+/Yz2t6elQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7fgj46zDcI383dhLDTkqSUwcg3+W0gl3wTMF0Xeq8Se28XccYLc/Zp+TVhdimA/Fm/cf0l+AiC4G7tLX99L6gVl6tP1DBnrwYDFaZExkupG0EpjwtERPCurt7uvliTiCZHBKizl8hsGlOH9pIetNgRGOuOG8ae4GDy51evT4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XNWGDm+d; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-48a39896682so458054137.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716953458; x=1717558258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K4+V+znJx86jqxQqY/ePetAkO7+psXvqg/o/9vnQ1k=;
        b=XNWGDm+dujudbLY30XbraddYKpPequ1vcdTgrl2dsGJ5japWeQgqlYqHPkrfP04XL0
         P2F8XUySBLURx0zjDjf+qt5m0u5EC19cBJoIpldC/OxZLbQzZAUVH7ACfPGjCb/sbYH2
         ubEhzEzH5mlSrUdPAJW1GIaeVf8acM0dabPkHyI1x6iYwm3yYa2mtaoNTVwYJYNyl5/D
         Q7Ifn290eBbL1tRwojx1efZ4C8rHADrXdemRIWr7TmbQPZ21i38PyV36trbP0Q4qyoyg
         9Htpf0l6ueb9f9oIVBSUVhWGAdAooVSG1QOdIzW2yvqkbakNeIHCmFRW1VIhGe7zisCB
         hPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716953458; x=1717558258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K4+V+znJx86jqxQqY/ePetAkO7+psXvqg/o/9vnQ1k=;
        b=EoEvMWhDcEWo6ZX3RoXclhPJKcpIj2d3tfiQSGXxDJIW/Sh9dn0mcQt1naOY3ibIcm
         37ivE4Sm6BK3kkEJUeD4vnCBUu7jMN3RHyeCmEHdjWLwoK/SsDOFF6VtWvgXVStxUTN6
         K43p7jlMj8VpNzZxCPM3kp3cJ42/2tTd3Bq+gz0ZQVX7aYd1zcjUi2cb3AprqzIdY3iC
         vRTXKKnTweMf+GXFx8ZUH0oj3m2fBoHViRU01jncdH6APcs1436sXRtgjmeOsiOZ/8YR
         Dj/EEF8TCeFfLUQv5dszGhJ2Uxonuql8PE+qpJz1yRoraCfavtOfpp6e8EAp9EIuZeQr
         RYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr98Ap5HR8kS/7U+o7RSz0Y1LI+TdteINtaT2iZjFgscjAqZnZlWSrWmCHnbD43vTxi80jMlJRVB41nByEVIc8xrmMBYkOjpfJKI8W
X-Gm-Message-State: AOJu0Yzd0Tr7s1c0+S/Vakd/PRfCJbsrq2PxddaBIVx1LnnyRccTd+FC
	TwTUnwtaLjsfwvSb051dAW0MwSoeIH2Hyt1k9q7j4kWrF5uWYNST/BpRGZdFKsuYiJDMMf/C2cG
	b1MtL5bjXGpA9wLL2DZD6td8Bz3HE03tt3mA1Ow==
X-Google-Smtp-Source: AGHT+IHF79MsyHPfbm23qYs9TFP6U6hAFAvWhrEOwBBivJaORASxht7MtxiGWgL39OIVbZT2P/itPNfpQX1GdGzIY18=
X-Received: by 2002:a67:f307:0:b0:48a:5abc:445c with SMTP id
 ada2fe7eead31-48a5abc4713mr8018251137.14.1716953458007; Tue, 28 May 2024
 20:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527185626.546110716@linuxfoundation.org>
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 29 May 2024 09:00:46 +0530
Message-ID: <CA+G9fYvrzV1Y7bx5hJ0zNNDd9Q4p4KERfnreGS+E5NuCHp1P9A@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/493] 6.8.12-rc1 review
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

On Tue, 28 May 2024 at 00:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.12 release.
> There are 493 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 May 2024 18:53:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.12-rc1.gz
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
* kernel: 6.8.12-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: 5a8ebc9c48a66c537b368b9f2794c7a951769213
* git describe: v6.8.11-494-g5a8ebc9c48a6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.1=
1-494-g5a8ebc9c48a6

## Test Regressions (compared to v6.8.11)

## Metric Regressions (compared to v6.8.11)

## Test Fixes (compared to v6.8.11)

## Metric Fixes (compared to v6.8.11)

## Test result summary
total: 217214, pass: 189122, fail: 2237, skip: 25536, xfail: 319

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 128 total, 128 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 23 total, 23 passed, 0 failed
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


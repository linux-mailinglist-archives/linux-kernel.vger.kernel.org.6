Return-Path: <linux-kernel+bounces-431226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B809E3AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B36281B84
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAD74A33;
	Wed,  4 Dec 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3yqCzJM"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D771B983F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733317274; cv=none; b=WkCbRGZ1Io2WbODBF8KHrXdW+qOuXSCTsJA2QEwmzpnIWEoGy36NIxtLUPZMvQ2JLoNa3dIjwtswpGfopxmi+v6uAyygy2U5DDwdiD2Yw3MLdZdUTeRRMaZkE1SgpuHpmqhvWIySglARTS8HiM1ioYHzNtxZ9MhB9dsMEbbteUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733317274; c=relaxed/simple;
	bh=5ILmEqTiQzWMOMrrhvDVYhyp5VUJ3IUTTE1tEB2Ycdo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4ICIAyGaRU6hXYaJF8HbBMdTOIwHv+zMIx9tO+rY2vNdUdeNGfutCXV0PZ7JoLhtQc2/hHkcU+k9/SNrhWxqKYOLVTxJ05pA+gh/J+OzBCRhslCjqOrummEBR8sDSc3HJOhSWwWkzbpbkiDBMXVZDSE5KQerQ3e8GX/8yP7WXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3yqCzJM; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-85bc7d126b2so1000091241.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733317271; x=1733922071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpV0x8eY3pglXksgasLFNdR3HbZHXmyjX5FpR9r0Yfo=;
        b=o3yqCzJMB5TfxGFVVDs07UYhnRl4QqB46ur2zy/NJ4neu4vp3pAmP5rFOyECLYUpAw
         UG/LIDelBlzDgoL6DsbQ9FQmZj0qK/nHmIkWiCfYa1GW7jnQrQfJ1NbKiAxqlMU7VVFQ
         pwQElR/kGpXIiQ3IcP/Da8XVu9TqlRUTuVliX1J/BAllNfapEyjiMUuDMAis0wzB+JMW
         R2Ighmq/Qz9aAs1zBPTlug8qDc5M9AAXb3Yzd6eZYWDOOaQFdppZ3FFpP6ShHSXPtzuI
         VJKvSs4RHfqsywQbfFw4WBop6QjsXU8wnZnhFXAaF2SfHRYXKfnzabgTEMwork+hr2/4
         U4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733317271; x=1733922071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpV0x8eY3pglXksgasLFNdR3HbZHXmyjX5FpR9r0Yfo=;
        b=ISY8bYWxxZOnPvg344GaQizj6aPbLPZgMz3sVeVai5Jv6qnsEj01qbS3jbQYhCql0C
         sNP12KhAz4Kra3g8VpEJVExMyvERSvyRTTO/JJx2MU88i9jInBc+PA1Y8hFVpxGdIogv
         uxIQzJjT4xxu0PD9LxCW5Nfp6FM3Sa3qJwQ61yV7dsUvg/htthgfRmg2HsH5dCvU4z8p
         cSaJC3ZukgPf9y+7S6B/c2FGlrCIR9rnwYcFPBib4+XcVHQgsmwWO/UN9DN0qRuqffp4
         m/mS87Q6wywbMBvvBS/IRhk8Ke7tITuVrIPysODzL71DBzabZt8YjSA73OqMt99cGfNV
         a8nA==
X-Forwarded-Encrypted: i=1; AJvYcCXNgYCV4Iowb9ZxQY/LjjLOqpfcfdVsM0YqKBm4vX8Y/Tr135RWFk2PYk2ct/DwgwHUFXr9SLUOv86zSC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze0J58W9Rgsng2/i0ynphVrxWjJiPa+WkkEyJ2T/33mLVMQTyg
	m4BHf7qfi05mvyNm0a32LOgdQFywC6O7T8Dxi75H80m7jXmSPTEUrl8H7HWx3EHMg2av6JNkSwJ
	JSMWj/llLN4FJGn5xkQEUTdSpvasfp2dhw/YSnW0rQ5TBkQTrypA=
X-Gm-Gg: ASbGncsXgtL8N2fpna6oF8DvHIQeAI5b9wpawn47TPWu+r8j6E+pQ03+oXox+0hN7ga
	RP6yfBb+Uln+RuXzGNPP37zqHQZxtmq/F
X-Google-Smtp-Source: AGHT+IH+iTIPjsJVLJ1TxqzWa1PXd6bsGmH6/EGI/vqgJHKP761HYaMPr1dif7uYa4ILxAw1c15EM8Qscw23c6n3EfE=
X-Received: by 2002:a05:6102:d93:b0:4af:b127:6742 with SMTP id
 ada2fe7eead31-4afb127685cmr756838137.21.1733317259252; Wed, 04 Dec 2024
 05:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203144743.428732212@linuxfoundation.org>
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Dec 2024 18:30:47 +0530
Message-ID: <CA+G9fYu21yqTvL428TFueMJ1uU1H_u8Vc470dER2CTrNK=Js0g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/826] 6.12.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Michal Suchanek <msuchanek@suse.de>, Nicolai Stange <nstange@suse.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Herbert Xu <herbert@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2024 at 21:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.2 release.
> There are 826 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 05 Dec 2024 14:45:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64 riscv and powerpc.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

1) The allmodconfig builds failed on arm64, arm, riscv and x86_64
     due to following build warnings / errors.

Build errors for allmodconfig:
--------------
drivers/gpu/drm/imx/ipuv3/parallel-display.c:75:3: error: variable
'num_modes' is uninitialized when used here [-Werror,-Wuninitialized]
   75 |                 num_modes++;
      |                 ^~~~~~~~~
drivers/gpu/drm/imx/ipuv3/parallel-display.c:55:15: note: initialize
the variable 'num_modes' to silence this warning
   55 |         int num_modes;
      |                      ^
      |                       =3D 0
1 error generated.
make[8]: *** [scripts/Makefile.build:229:
drivers/gpu/drm/imx/ipuv3/parallel-display.o] Error 1
drivers/gpu/drm/imx/ipuv3/imx-ldb.c:143:3: error: variable 'num_modes'
is uninitialized when used here [-Werror,-Wuninitialized]
  143 |                 num_modes++;
      |                 ^~~~~~~~~
drivers/gpu/drm/imx/ipuv3/imx-ldb.c:133:15: note: initialize the
variable 'num_modes' to silence this warning
  133 |         int num_modes;
      |                      ^
      |                       =3D 0
1 error generated.

2) The powerpc builds failed due to this build warnings / errors.
      ERROR: modpost: "gcm_update"
[arch/powerpc/crypto/aes-gcm-p10-crypto.ko] undefined!

3) As other reported perf build failures
   util/stat-display.c: In function 'uniquify_event_name':
   util/stat-display.c:895:45: error: 'struct evsel' has no member
named 'alternate_hw_config'
     895 |         if (counter->pmu->is_core &&
counter->alternate_hw_config !=3D PERF_COUNT_HW_MAX)
      |                                             ^~

Build errors:
---------------
ERROR: modpost: "gcm_update"
[arch/powerpc/crypto/aes-gcm-p10-crypto.ko] undefined!

## Build
* kernel: 6.12.2-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1b3321bcbfba89474cbae3673f3dac9c456ce4b9
* git describe: v6.12.1-827-g1b3321bcbfba
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.1-827-g1b3321bcbfba

## Test Regressions (compared to v6.12-4-g11741096a22c)
* arm, build
  - gcc-13-lkftconfig-perf

* arm64, build
  - clang-19-allmodconfig
  - gcc-13-lkftconfig-perf

* powerpc, build
  - clang-19-defconfig
  - clang-nightly-defconfig
  - clang-nightly-lkftconfig-hardening
  - clang-nightly-lkftconfig-lto-full
  - clang-nightly-lkftconfig-lto-thing
  - gcc-13-defconfig
  - gcc-13-lkftconfig-hardening
  - gcc-8-defconfig
  - gcc-8-lkftconfig-hardening
  - korg-clang-19-lkftconfig-hardening
  - korg-clang-19-lkftconfig-lto-full
  - korg-clang-19-lkftconfig-lto-thing

* riscv, build
  - clang-19-allmodconfig

* x86_64, build
  - clang-19-allmodconfig
  - gcc-13-lkftconfig-perf

## Metric Regressions (compared to v6.12-4-g11741096a22c)

## Test Fixes (compared to v6.12-4-g11741096a22c)

## Metric Fixes (compared to v6.12-4-g11741096a22c)

## Test result summary
total: 157764, pass: 129957, fail: 2971, skip: 24836, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 138 total, 135 passed, 3 failed
* arm64: 52 total, 50 passed, 2 failed
* i386: 18 total, 17 passed, 1 failed
* mips: 34 total, 33 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 40 total, 27 passed, 13 failed
* riscv: 24 total, 22 passed, 2 failed
* s390: 22 total, 21 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 44 total, 42 passed, 2 failed

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
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


Return-Path: <linux-kernel+bounces-431259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28189E3B3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1BCB2B766
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1B11AF0CD;
	Wed,  4 Dec 2024 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWxOs2wZ"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD831B983E
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318714; cv=none; b=qtbDMiTnscRZ3gpIGSc0BaIFcstbF0yvVtbEfX8ZIp5G7EMgPPvPqFw4yb+EWRYdgis+0nTl4eJIm9l8gr/WgO+QWrwff5pGzn9ZkurruNxI3zsZjdbHJdexSyvMhbKPj8m1qOpMFO2HQBc/QfhkxH59E/VUHM44aBXUHKaHwS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318714; c=relaxed/simple;
	bh=heJcFJZ6wGpaq7N/UtzOsXHKhH2gA7eWMGRP8CzCx6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kzHAoETKNWbsl6d3HFPeqy4Y1qu7AQ2XRSYbI2GdR3wVoKQgOqO1QXkU7VNuIHw/tVH6zz7Kbsp4kP1b1LfRfWjEia2hibzfd84NbWIgBXKZa2RNHjOVfNDcRYsHx8fhJFBE+5DJMksVsx0G0Pcbq3WnM7ze0Xjq54VOLIBFwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wWxOs2wZ; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-85ba8b1c7b9so491769241.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733318712; x=1733923512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyRVQVb/zI9kJmYn91wAT9zCQ5BG7fVZIEQs7VqoMNo=;
        b=wWxOs2wZzXB0N7zRkUvyforSHbq24OcGECtpV22iq0aJU31G9SChXZhQfNrOd/lsht
         2wQIv1p97MZtin5+JXGjpA66JqdigoKJBCvQ+aCFfjCZUMe2Yoe320dBGThXYJbMa2tS
         HbL6JoZSho71jfN9nvSSaAxWPZwZHZfWcVkC+7KRZ0aLMpOTTTA/OtYmxS5pir/y3IaO
         9KiMqov9pxv+THHr92cgw9rJCXIjI/KWK+UJmxrfIqrKFahXvkGOU3LBIDdXaUTNMesH
         NniIDO4njPgB7xp8hPYPKh6t55NnVJ8FWt+VzsTL4uYqMjhpZHXF6qs2DwrGPHM+qtYZ
         TIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733318712; x=1733923512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyRVQVb/zI9kJmYn91wAT9zCQ5BG7fVZIEQs7VqoMNo=;
        b=jqp30Tww0jfH5nlDS486FClExM4tk5BPFS1+hbs5ZTRaQvOBhgS2oG071J25815q9a
         bNOQ4aRCCuHXT2BvSsGjOtcqaaEBfs9oxpYJ3xY1F7Ov1ID707iiVfG1K04502P2BM38
         op7O6gqrrRuRMbS9xm8Sr2bm+dJpzGP4jpfJDZAKNK1C58Mtx/ZhgXLEqTeWrwM5MNTk
         GtOp7LvvX5N5PGZPaVeT6pKsTf8oRqKnpOsVwDSGzkUVYeUHQG+g7mMYC+wGJWKpJMT4
         Z57O0FmYaBpsv0D7IbOJjUDndCzx3L7g3C/VO+DDqVeL+xrDpHP6bQ4oswc8PTtCvVpQ
         l4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKFN0aB6e6JB2FZIbciEFiNptfTKS6Y4NmYHhDn3+gs7eKQGPSL+pBUDZo+WVPffUMK0dppzUr8r8WMdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1pLDIYTh24/l2JNRVbXnhOSYfQ+PVl2LhJFwQDeqx7TUZOg5
	FgSbJ6KNxKMkDe2r1OWoJY5PMmBe/u049blt9ycTjuBLaobpXzpdK6/xOGDf63uQdAdsynQDA/9
	t4aE3OY4YitpYeuS1Z1NBQE2IBoLxDAPCrSwTwA==
X-Gm-Gg: ASbGncthpSAE+ge5sM1LiduD6cVh1K7NqjYvhDhFFghtnukBMgpiKVrjWTUUfnbW4AL
	KY+iws44nTqS8wqrjLkhMuNlDLAFvQb+F
X-Google-Smtp-Source: AGHT+IF5Gr6rLMtOlq5rot61HhOPOQXJX5OJ6mgM08z0lylqA8xx32FyRxPhrJvcFQTp4nhCNYedeZJgiB8KDOM4SZ0=
X-Received: by 2002:a05:6122:620d:20b0:515:1fde:1cb1 with SMTP id
 71dfb90a1353d-5156a8e0b02mr24861742e0c.3.1733318711875; Wed, 04 Dec 2024
 05:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203143955.605130076@linuxfoundation.org>
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Dec 2024 18:55:00 +0530
Message-ID: <CA+G9fYtNvEDcUEuv=QFC84y+pXY1UszoRYOitJztCApLV7-psg@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/817] 6.11.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Herbert Xu <herbert@gondor.apana.org.au>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Michal Suchanek <msuchanek@suse.de>, 
	clang-built-linux <llvm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2024 at 20:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> -----------
> Note, this is will probably be the last 6.11.y kernel to be released.
> Please move to the 6.12.y branch at this time.
> -----------
>
> This is the start of the stable review cycle for the 6.11.11 release.
> There are 817 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 05 Dec 2024 14:36:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64, riscv and powerpc.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The listed below errors are the same as reported on stable-rc linux-6.12.y

1) The allmodconfig builds failed on arm64, arm, riscv and x86_64 due
to following build warnings / errors.

Build error allmodconfig:
------------------------
/drivers/gpu/drm/imx/ipuv3/parallel-display.c:75:3: error: variable
'num_modes' is uninitialized when used here [-Werror,-Wuninitialized]
   75 |                 num_modes++;
      |                 ^~~~~~~~~
/drivers/gpu/drm/imx/ipuv3/parallel-display.c:55:15: note: initialize
the variable 'num_modes' to silence this warning
   55 |         int num_modes;
      |                      ^
      |                       =3D 0
1 error generated.
make[8]: *** [/scripts/Makefile.build:244:
drivers/gpu/drm/imx/ipuv3/parallel-display.o] Error 1
/drivers/gpu/drm/imx/ipuv3/imx-ldb.c:143:3: error: variable
'num_modes' is uninitialized when used here [-Werror,-Wuninitialized]
  143 |                 num_modes++;
      |                 ^~~~~~~~~
/drivers/gpu/drm/imx/ipuv3/imx-ldb.c:133:15: note: initialize the
variable 'num_modes' to silence this warning
  133 |         int num_modes;
      |                      ^
      |                       =3D 0
1 error generated.


2) The powerpc builds failed due to these build warnings / errors.
Build errors on powerpc:
---------------
ERROR: modpost: "gcm_update"
[arch/powerpc/crypto/aes-gcm-p10-crypto.ko] undefined!

3) As other reported perf build failures
Build errors perf:
----------------------
   util/stat-display.c: In function 'uniquify_event_name':
   util/stat-display.c:895:45: error: 'struct evsel' has no member
named 'alternate_hw_config'
     895 |         if (counter->pmu->is_core &&
counter->alternate_hw_config !=3D PERF_COUNT_HW_MAX)
      |                                             ^~


## Build
* kernel: 6.11.11-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 57f39ce086c9b727df2d92ea7ab7cc80e89d7ed2
* git describe: v6.11.10-818-g57f39ce086c9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.10-818-g57f39ce086c9

## Test Regressions (compared to v6.11.9-108-gc9b39c48bf4a)
* arm, build
  - gcc-13-lkftconfig-perf

* arm64, build
  - clang-19-allmodconfig
  - gcc-13-lkftconfig-perf

* i386, build
  - gcc-13-lkftconfig-perf

* powerpc, build
  - clang-19-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig

* riscv, build
  - clang-19-allmodconfig

* x86_64, build
  - clang-19-allmodconfig
  - gcc-13-lkftconfig-perf


## Metric Regressions (compared to v6.11.9-108-gc9b39c48bf4a)

## Test Fixes (compared to v6.11.9-108-gc9b39c48bf4a)

## Metric Fixes (compared to v6.11.9-108-gc9b39c48bf4a)

## Test result summary
total: 130907, pass: 108166, fail: 1524, skip: 21217, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 130 total, 127 passed, 3 failed
* arm64: 42 total, 40 passed, 2 failed
* i386: 18 total, 15 passed, 3 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 27 passed, 5 failed
* riscv: 16 total, 14 passed, 2 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 34 total, 32 passed, 2 failed

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


Return-Path: <linux-kernel+bounces-179754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E58448C64D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 12:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B69C285B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA665A116;
	Wed, 15 May 2024 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrRGK/os"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0C457CB5
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715768082; cv=none; b=CB+ZygltgKVv5d/od+lLVxKZ53mhDsmrUeFT/9U9n6aqciu3ePgcFsQGOWomRg59SAifEFosE7bsoTSkVnoxjVX/uDH3TuD/KsMiyJiqpZ9Dd2oxka4dh0u7Hmkf0sDeprS3XTiiDGje/roEO9kfhab2x9T3K7GJ+YmANSLShdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715768082; c=relaxed/simple;
	bh=5wtdxMtUjgkHkKK7sTxUtfYaL6yVZ/kWJBpAoHlaM3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwt1Rvs1sFb+ppTlNZPBqnru7fn0uBMHDSL4F8cjIPd6svPk9/QFxt4VCLcIJcs00Y4c5zgZCDWLSt1TfCrLLG0967WIb8sNY+90S7gcYv3kE1CZ2v0Q+Rtrib7NsgoA1ZFwVi5PhF5MlcAYruCJgbUnMjsuVeEj7rSg6Ww5TtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrRGK/os; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-47f02dfe3adso1907664137.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 03:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715768080; x=1716372880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXGxS8kWCZgF4bWh/7xTUx4JaoOaC7zO0XIHLxVCXBQ=;
        b=rrRGK/osAh5Jzex3pKDnFt0BmhYUuAUNPCrqYoF/f19lrnjMABJaimajEbZ7HweWrs
         MaOH6evmsamc3bSHF7WK/wlIMJs6roj1XPPsfo9XNf0UhuUvIdUxd5az4qcAzt3+n5M/
         EgHOC+fTteXkSZynkrx4zG6ksjF7oo07dtPa7qaeqEJIYie+Ym/muCwEDw0oA2FwhKAK
         gOTYuiEjwSs5dUnKRCW5hwJyHBws1WgFXTREylfJ30eeeHNXDLrHLaEv2LHQWxHjpSXj
         BMEhvFy2yew5pPoFhlUFH7uAIj8CV9oVoofgXKxZeKUGBQY86QHhruxCzchvyn31jeC3
         lmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715768080; x=1716372880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXGxS8kWCZgF4bWh/7xTUx4JaoOaC7zO0XIHLxVCXBQ=;
        b=A3rhEY6ruXPasvj+bMVJQIfmSUBka1IzcC6thWhwZ5RFOcWJrYmne88ncGXUYzbFz8
         UVMHrw8RBm5cg0C8U83I/l+9LNbNxdG/KjMOxFdmnRJLLtJInelB0smUM1wM3tTD9VNg
         G+ACvvmb12l9+x3Hw5U0qWhR8D/18oXUr2pXCPYcwsb00pAnIFkqc8bj9a5ZtIbyW+qQ
         JIOUGqGatoBWbD8Rq7Teq6ngYVFlpPPDpDwBHU5Wf6IdZ32cO32Nc73Gklw4PP4tLCI1
         VWpIq6XWwLhVJyn21IV1ofTC4nHBeQK0fmUCLPMoii1Z5gIxT6iQSJh1KTbRge+rvOF3
         aAGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Ref1fhYMwv2NcA0+OQ7DMkuldXTDi8lzZkq2iApUvBrP9OHXISDMeu9dPMFcFfW5Xif1vKGdmDRhL9L0ZsgCOioDXFA6YCidpjTR
X-Gm-Message-State: AOJu0YxZQirc2WrbKDL+xTD8YugaoZ5nXRUq/9seC4WHlx1JKbfN/X6h
	8AvYBb2BIVohTDgOPquXSJcU67i7p+9i4Zt+xI1nEN4EjOy8iFu/Ng8q4GwWXybN7oskDO617+T
	z9YBykMUKP169qPhTXrk4eR8L6Q+Ntr721V0Krg==
X-Google-Smtp-Source: AGHT+IEVpMhmub5m6a9M/m2evfzG91ZJZ2NOQ5D/LOxy9Bt9jbhdLVIAkRrHrJ+bK1yW4lSYjjuYxperSFLER0epIyE=
X-Received: by 2002:a05:6102:26c6:b0:47f:fe4:a38c with SMTP id
 ada2fe7eead31-48077db7149mr15601912137.1.1715768080002; Wed, 15 May 2024
 03:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514100957.114746054@linuxfoundation.org>
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 15 May 2024 12:14:28 +0200
Message-ID: <CA+G9fYsUEuzptCHsdpz53kefAzJRD3Hp-2nfn4f_osXkwQnOqA@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/111] 5.10.217-rc1 review
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

On Tue, 14 May 2024 at 13:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.217 release.
> There are 111 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.217-rc1.gz
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

## Build
* kernel: 5.10.217-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: dc5817072861cb3cb0d4af7f071afc3a69abd690
* git describe: v5.10.216-112-gdc5817072861
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
216-112-gdc5817072861

## Test Regressions (compared to v5.10.216)

## Metric Regressions (compared to v5.10.216)

## Test Fixes (compared to v5.10.216)

## Metric Fixes (compared to v5.10.216)

## Test result summary
total: 72324, pass: 57510, fail: 1877, skip: 12891, xfail: 46

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 103 total, 103 passed, 0 failed
* arm64: 30 total, 30 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
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
* ltp-crypto
* ltp-cve
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


Return-Path: <linux-kernel+bounces-223034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8853910C45
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450691F21F06
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A6A1B47C9;
	Thu, 20 Jun 2024 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVy4dqoG"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B01B47C2
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900635; cv=none; b=a+EhKmGcwkPLkasYiOEH5QFBqYgRKvsSJEy1l5sTEVdZOfSVOfNRHVZBqdGf32kMxyT3jyjf05WAjIznCRrOGGXHNHwOuHyf1YSuquiC6slAfnidCRAkdClbfk+KDW473RKPoX55nlhbUvoFkIHZooTzUPSA1+vHd5cYifm8Jiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900635; c=relaxed/simple;
	bh=Fx1smBOU7+g5gN1krwDVwIdwdPcrGDOEe1sKrAvkiEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEuA1MagxZf595x3nt28ykt0ZIIDiC6LZBtKEw6sg0M3p4FvxBGnq9EBnzhQoGqRYraGcOGRtMUJZ6UJgW2LHv3Jm4Iiym9d2drbsh5AYh446ziY+lbk6dbeKgzTR8tqgGIlfnWY+ZsGlDoWYr37K7sTdw1pvjrM9VTtJiJB/rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jVy4dqoG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d203d4682so1348178a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718900632; x=1719505432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlwMIJz/BLrmB2WpkXjrpRTAkcL0lyiD4VvvoeLE5V4=;
        b=jVy4dqoGz5c2AQMRQ+EDk9ZP0lHrRSM7yVcgWsB6xM+nc23/sUwWcuggrsHsQRCSQX
         FvItdD9fuwFrx0ptO3i+X9cgqIWpkkkRQUC3GU9jn3g3mOk+2gnEe9Jin6i+ZBMYweev
         pxnDTfm4sp7MZg1ghc9OAx/LjfA4bXM4eiqGLysINJXlO0gn2s/9m7ihKKC70Iwzjmb3
         1iFsq/Fsyd7xA9yB7m8hWuXhHk1wZ+lIjPU9WrUSHokTwXKixkfsEirPJloCfqydzgbd
         fwVkfKUMfY2tmjDWrddKQYyTC/7gnutHNEGTsZ5+xhfy9pls2+O8yUqol0MvcJC3WI/0
         BFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718900632; x=1719505432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlwMIJz/BLrmB2WpkXjrpRTAkcL0lyiD4VvvoeLE5V4=;
        b=Fn0pWy1xpCRlJ4HjAjSVntakAqCJfRMxQLAmhCXOYmLJdSOwai/vjur0bUKXvAg2uc
         hfHrGUob28WiY2EDcVr8EhmtTthzdfJ4QvKhm4/UaR51UiZGHskdOi9WRKG4u6pSuoEH
         k4oLIyrJqYgCVEVyU4+x3hZR8Llk1MQA/4PH2yM54wMcVAoTb3kDZHZz2CGN67uOZCsF
         E7YUFt3Bk8N50lYzXb5jj9/FDk7mhl/gMWV3ZKFwM/RXwIWSY79mz08JEJCEB/Gk87Fp
         nHKJf2QICp6/eq+oDtQXDFLYXW2KhTzzYiQGXJpfDYt5VHMHbzgqWIwUCSFQkO19ucWa
         r+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUBPXVHvyZRUmuKx+OQKqcY9xKNaTTtUtFZZul0gwqhDdhszHvnYR+l8iBjOrOHsrUz0A88ZMABuBXxYj5Y4scCzO+P2ZwTGdcAiP/x
X-Gm-Message-State: AOJu0Yzqd9gWPW9rVIjlI2OWHGflsXhpbZCvXoS2HvJH/e92pds9QRiy
	101zvg32shwAlt2p6jrGF19MgVQT/y40Mtz3NV18Pk/bdWkFyenNb0YSOacjltqHE47Osheg/Wj
	L9sQOEHqVdDPd87SY9NEcRnTFnnwZxBqiimPiuO89M0O+WfZEBowl8Q==
X-Google-Smtp-Source: AGHT+IEiUurqA8/vupAfbQYgfZXpGG83X+0xfR1yK7bM0GHwHo0LQaZYIH41GdenK+O+unfb1dHXnKUo8wy8Glq5Rs0=
X-Received: by 2002:a50:99c2:0:b0:57c:ff94:c817 with SMTP id
 4fb4d7f45d1cf-57d07e7b28bmr4498282a12.16.1718900631856; Thu, 20 Jun 2024
 09:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125556.491243678@linuxfoundation.org>
In-Reply-To: <20240619125556.491243678@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 21:53:39 +0530
Message-ID: <CA+G9fYsnxHwaPb2YvcLJXrgPRkqJbm7w=cF6b-Ap1mQ7jHHMsA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/217] 6.1.95-rc1 review
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

On Wed, 19 Jun 2024 at 18:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.95 release.
> There are 217 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.95-rc1.gz
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
* kernel: 6.1.95-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.1.y
* git commit: 0891d95b9db39ae51c0edef73f56d41521be9fbd
* git describe: v6.1.94-218-g0891d95b9db3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
4-218-g0891d95b9db3

## Test Regressions (compared to v6.1.94)

## Metric Regressions (compared to v6.1.94)

## Test Fixes (compared to v6.1.94)

## Metric Fixes (compared to v6.1.94)

## Test result summary
total: 171975, pass: 145682, fail: 3002, skip: 23038, xfail: 253

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 33 total, 33 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
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
* kselftest-memfd
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


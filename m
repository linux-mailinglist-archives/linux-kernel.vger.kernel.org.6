Return-Path: <linux-kernel+bounces-205849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE964900143
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6E31F24BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83A18629E;
	Fri,  7 Jun 2024 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tIq8bJrR"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC71850BE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757546; cv=none; b=HigtAh/mOlVyEKFHPWompRv+rVBaSpPFniXPN2+NZEsn63vL0HlMarqJngEXbMcieZBdyhCQsOvAKMb2SBLTazt7ywkvalUP3WcAkspIEBIgR4+tmjAMfatVQb3+edjUJh7qKe10TAHu1t/rgINJsom8fc11sNvjUpJRa+G0NJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757546; c=relaxed/simple;
	bh=gSWSP+7C8UOKUu7+vq+El/x9kf+z97qTlQ+ZsMnmONo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SIEAbSsEF6RWLnFO2vXgonnsCUzMSXzz063xuXYaVUhoIAF6wed9L51UMvj2aeMP8QKBVRiQCxeN3yOCgd/oCLzlc+SMpWz5YojrVcDFL4VgGXIrXeAR8DLREtVR3fJOqbTSA2Xf84zhvR2p3e+Ucevw4paJcme2i9DsNbxDJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tIq8bJrR; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4eb0089b4a2so684640e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717757543; x=1718362343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPbSPneHT7Jvjy5REyHR38Uuhd6bNow/3VWxu5TPx5Y=;
        b=tIq8bJrRHvaLq2zc+PpaXwrjpXJ+G9pHfTizLsRXZroHEm4mxHNKhaN9Ioj/Hjeouu
         ymGmlJpL6kxThdVxj0XWOOb0+OyIPOpg0q1NOR2uy2z6BMXzHz3pZi4IAYoZ3sBVeGz0
         /x5I9lt8CxIPoLOxtEzFkXaxZT36dCUR1a1BCZgFvr3nOyBUdPCfRsmdQctPX5ypRW3B
         xNDNOa4uCHbt/t7Q6KMVQ1R0AcL5u6g+zpOL9bN0gyN81tOGtwm+C1QsDdx8MKdN3DLh
         IHqU6+1fDB0qOWTbSaZrhyzUYH/68r/0DHRm5rmD72ZVw1N+WeoNE5zqmCxiQGCOyxxE
         LkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717757543; x=1718362343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPbSPneHT7Jvjy5REyHR38Uuhd6bNow/3VWxu5TPx5Y=;
        b=UoXQqifjNtQyo9Mq7dL1hIhBVGTZHyaQU4xBXnJ3bV6gORFIOx8CRtXsUsDblPYWzL
         2Ol7ZXiG5LLPTYNZt1Rn9/YxuT8W5OeRTeTKDi6WKXItEmnXu2K8/vYTmGdDgM93xng0
         8lmr7PWXN8MoHXqtZvooHoHuuv9wy1/jW8Wti9YE7yNRfKPWK/fEj2zLDH2c7u6FeGQ7
         hAPE8aIg+p+TuG7Icbv+GOiZAzKEvdmPZeK5zTPtuU/2dGoI8IJByKBCaWYcweO9Ledd
         F3aTRNP3wFKWUPQRFczZBCDIiFPw/a5fPcdSY/RATO5X1tYVf4yel88oY9G2YofkJXES
         Wh4A==
X-Forwarded-Encrypted: i=1; AJvYcCXSKSu+foIsxOrRxV5OQJpAst6oNWOck0781v9SvaEN9oTMGhN83Uwb/f66Vv5xapy0mN+7SCchOf/cMs/sElh+dUTfrYM6dHf0h+aI
X-Gm-Message-State: AOJu0YzFBUfq+Zvc9cCaaoDdtFXjjx8d+FfajAMC9KRHlWS25YCNP3rJ
	H+XqF9Dk9Hmc6rmxjTdxcqlOb49w+oAawMOvCzzmQtnXxUw7lr5w6x4i2AbQMlcOm7CWSAKaJJg
	vhoxDjq0Fbj7Ucrqu7rPRwEaFITfZvHjYNO+h1Q==
X-Google-Smtp-Source: AGHT+IGZgoJBNxvF0IqzZ76RjN/3DL1M26P/4+jxT3RGwhtV8AOnkj8ddXuo2lmlwYIZDVnndDCRiLv2h7nduOcdfRM=
X-Received: by 2002:a1f:7c05:0:b0:4e4:ec86:4240 with SMTP id
 71dfb90a1353d-4eb562a4b69mr2327968e0c.12.1717757542953; Fri, 07 Jun 2024
 03:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org>
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Jun 2024 16:22:11 +0530
Message-ID: <CA+G9fYsnQh6ydxf3asaEvoOE8a1oabcoUp91m3MJRyR6caKJ0A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/744] 6.6.33-rc1 review
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

On Thu, 6 Jun 2024 at 19:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.33 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.33-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Build regressions on Powerpc.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.33-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 39dd7d80cd65769389563028553e9ec89a8f88d1
* git describe: v6.6.32-745-g39dd7d80cd65
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
2-745-g39dd7d80cd65

## Test Regressions (compared to v6.6.32)

* powerpc, build
  - clang-18-cell_defconfig
  - clang-18-defconfig
  - clang-18-maple_defconfig
  - clang-18-ppc64e_defconfig
  - clang-nightly-cell_defconfig
  - clang-nightly-defconfig
  - clang-nightly-maple_defconfig
  - gcc-13-cell_defconfig
  - gcc-13-defconfig
  - gcc-13-maple_defconfig
  - gcc-13-ppc64e_defconfig

## Metric Regressions (compared to v6.6.32)

## Test Fixes (compared to v6.6.32)

## Metric Fixes (compared to v6.6.32)

## Test result summary
total: 193993, pass: 148173, fail: 25962, skip: 18882, xfail: 976

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 33 total, 22 passed, 11 failed
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


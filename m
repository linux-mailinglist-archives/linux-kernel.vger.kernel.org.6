Return-Path: <linux-kernel+bounces-188440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6CD8CE217
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC1B1C216E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C635B1292C9;
	Fri, 24 May 2024 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ms1eZXco"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C882872
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538395; cv=none; b=qWFkoXZe1O31Ud58QxFIm6MWbbgGwtupZc+s9gOvl54cG0O3DTu+H3RxYJZIlZ1LeZPok6EkFZsjN7z9PvV+TjTygm2ABsBYaect0Rd/Ov+mzTzEoV/+TfeRFYsWzewGU/4ul9XWY6OEvL/tlNV6qoolhx+AlMF2YU+b76EkPP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538395; c=relaxed/simple;
	bh=iDZO2JEbL9dapjSXJbuqTSFdvFd4rrdn5qoCA+BDAFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NqGqYjLWWoiVVFXsjrMXwNwKkHVfWLuk++PcEYyoRPS2do2sFFRNdn0gtfMUULuwJbfPfu2aeGfR3oFFdpklDIjJI4GUwrQQa6I0Q25iK45BmiS5LClC9APD9nrlx8UdusdDUtwJm8yjQDysqV0qVrHn0Hx61qb5PwHyXVbU72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ms1eZXco; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-62a0849f5a8so6492927b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716538391; x=1717143191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/vZiBjXa6s1sOVi/WrPbknmQ7jkRff7AyHNLyA3ytY=;
        b=Ms1eZXcod5gDp2LrZ5psO1Od8N3SIEjPDN420Qsm3W6Mmi+mp9ekXUBCkiB+NT/+xf
         46ewgBZmKXAq7cAXkbLBiVm6SAGaQaCjDeKAyiVvh0cncaKfO3FA/UoVS1tSxiJVOos5
         pzcHATprZ2F8Ht/V50/uI6RBFf3jJpPaZMV4DOlnJ7KfhtHQcijScSgmF7XMxKvnvcRR
         3M5f8IqaUUZGuzkYwRocbWdQf9jalobcNIfEPj8Kp7j3m9sSbpjLapL3zERmTmrsA6lk
         0qL9Xk3HeJbJgudWnVxudDd1KcEOZnvDzqebzkAwwTJP/Zvt1zmOF8fWaEwcyywJCKqL
         xVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538391; x=1717143191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/vZiBjXa6s1sOVi/WrPbknmQ7jkRff7AyHNLyA3ytY=;
        b=IYUCv3z7xikuQafdMT0h1ICkKhV87FO8KumvphzDSikz5KGX2Pe8duxd9mf64M/mrW
         PcaAgO6k3UZHHjFkEk8DLfMaI0/pWgcb+Mvovrv4h2/QTev90EyTmrS7CdUK+nbQtlpQ
         vKMWqD9OCAeLpJJQPBydRbpC/BOAxzzGHw4P6Gh1hFm1vB7DXoLDWKCygrCRAWRISSUv
         BFfZ8oHe27otpXAlubyvu7boJ3QtQkoZQVQZzf1R4sX6BeBeDnYlXPp9dAgxdcA6wlzE
         jFLwwfFTpT6UC1z75vXP5YURlQ7Cbq30WwTx29k7dzNo/6H4YOHpHy5CLHI4g2IT/Cdc
         jv6g==
X-Forwarded-Encrypted: i=1; AJvYcCVEzX9UvX2uRy1cDRA/xefvlHIpH/rc9F3doDRjS0uYq+GRkKPwG8psaGdwbA93dyM4JluE1MLd6IZ2V3veB+88VW0L4wylJJv/Ccf6
X-Gm-Message-State: AOJu0YzCZZhUqyG0spIXgg3EogG++0QQi6lXzz8aMLKyfqTxijQDB/TX
	jNklr/qr8OHyBa3EIoabMDKG1y7Khp2stEOuzLLkT3ZpMZynmS0CvrCZF5Jwk5FCt7akpNSyY/X
	K43FJf8IPz1pD0lNSHeB8ov/cNkkgg1ExT4TqPQ==
X-Google-Smtp-Source: AGHT+IFCajKrEg1yHLorioSNG5XEJQo8CoJG16SVt9J/QKpooT2g4jaTIDYwb+RVF+olXqUkqj7x97n5zEGdlOCGaeU=
X-Received: by 2002:a81:9201:0:b0:620:33dc:8357 with SMTP id
 00721157ae682-62a08d7eedbmr15040307b3.18.1716538391212; Fri, 24 May 2024
 01:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130332.496202557@linuxfoundation.org>
In-Reply-To: <20240523130332.496202557@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 24 May 2024 10:13:00 +0200
Message-ID: <CADYN=9K9tbiLPSx9Xg+dMA1WsZNj4Z2cLT9LLYQZn+ckjJzu7Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/45] 6.1.92-rc1 review
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

On Thu, 23 May 2024 at 15:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.92 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.92-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 4 total, 4 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
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


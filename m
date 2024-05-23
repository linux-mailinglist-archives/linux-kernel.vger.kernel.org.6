Return-Path: <linux-kernel+bounces-188041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EB68CDC25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037EA288A56
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E214884DF5;
	Thu, 23 May 2024 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3JEasDy"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DA284A5F
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499962; cv=none; b=OzB/EXy/cfusk7CX605TacxwU3KaZozxUmuMaCnQC9YD5I6wWwsWGdF+xWUPTcsUNtyq8Gg90Sh1pDoyJ6UBULrBaZa4nVnq59c6N1+qWs385LUxQksUC/DFTmhpXEUR9hD7XwBfSPYM0NZe838QdXQKVxM3vnLCiolEGHmNmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499962; c=relaxed/simple;
	bh=zkITAr7CmBWLO2M3b7jQcZH99hzVRibXay5tFUhl/E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YazPzBtzDFhnloKWEYLtk5LwUbldLxk98uyDNOQfwJaLUpJ8guvHu5a5Kb7dwy89yZqOJBjFdH2ZHYbXyVEee5cWIGEcCRKRPV72Clf43XMJq+e9ETltT/YL5b+y4xWI83VcbyT0p+sDWl9TbIqg/gYJosTPUHglECWaKKZoX5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W3JEasDy; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6a8691d736cso17854696d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716499959; x=1717104759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUt0t/lv5Qq1PHFIIh6EL2Y/XsjWxY/5yhdxX3CRxY0=;
        b=W3JEasDy0Tm0bM8Jw6UrZFbR0kTQmIUH5U3je6QKVYoZoBmvbghc9+eA83npXEuDif
         sYstUkwUOxHRiyGj0JIuRcxnPTyP00ut/JJd3W130+iZxOVLEMy6K2kc0ygUvYRWM7FY
         KIHSMSZqEKrG8NBWH8usAUyqQ5wrfIPWfDscHX/ZlRkna+4flOqbglmcPZ8NS6HjGDfi
         n3UaOZhcIOrXUuxYrYvd6cZwPE7ljzo59Lit42/Nh7+LmrTIpu/ryl28hRfdzV/+y6Cv
         AC3ORCJC/geIhGZc/WeQy6XUZUPoN2Y/TraMg+Bb3uG4aAW76g05M6XDf8am0lRmid+3
         6fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716499959; x=1717104759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUt0t/lv5Qq1PHFIIh6EL2Y/XsjWxY/5yhdxX3CRxY0=;
        b=MUSaju5eR1Vc20SofTTi9JXpY5hoSs30wXmbZOQm0WU7YO9bxQqsmt8Z4LCAVLjqJO
         /8ljSFphv7L90/RtIn0r95zG5n6nwLIFd5mPdUtkjA964PiJGGHU1MkIjvwMyptrZu7q
         vjiHHB5Xi6QV4AMZEc9yq2i/eyQw/BcArdTklqd+2KXsnwIo5IgjN2f5TCBWEuAWud4Z
         VStt5iO/JTcQSH9fMTeTRjsqdJtwOBASC88JhHRHgtugRWaA/qcDVizDo9hbhH5lnYYt
         4WjNONih1CBrWfNIXAW08mMYS2xt0MkSeXdhVZfi1DAzGTFsMM9cJSw6XrAf5aJ8tpoj
         /BcA==
X-Forwarded-Encrypted: i=1; AJvYcCU9GnEaIArbBvq4C49jESwHLmoXeAVAu3tstb1RbZYEp6AXnp8q+dlPH7QLAMe8L6qLHpddJSHp4SEnCPe10n3mQFAtsI8J3qtc6KqE
X-Gm-Message-State: AOJu0Yw5grbecPIPgYPjkbU3/Tt/QNzPONb2OjUimjZFMbJTMDQFw68m
	AkGmCVfiyAB2bTIilarVfkNdCRK33TVRIjyTMhEC3CI/lDHtORm0o+/jkyw9zHSk2acMD1+3Q1r
	sB2igGMg1bOPUsGuwsky89jtP/TVozwfO2JUJa77GRAIGlQbjSpksjg==
X-Google-Smtp-Source: AGHT+IEuBNQdLSthf/iTYVwBTUTOk5SUNT6V9pX+RZqJC3Zt89SpmPn2fjjJFos5V7lmOzNq6/+DLzlZhfudIcKNmrs=
X-Received: by 2002:a05:6214:b68:b0:6a8:ed2f:384a with SMTP id
 6a1803df08f44-6ab8f5f4fd9mr72035616d6.30.1716499959388; Thu, 23 May 2024
 14:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130329.745905823@linuxfoundation.org>
In-Reply-To: <20240523130329.745905823@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 23 May 2024 23:32:28 +0200
Message-ID: <CADYN=9LRNB_T1wv2VW8Kqr6raHQKJ5FaiH_ahPYhy0cfvw+RCw@mail.gmail.com>
Subject: Re: [PATCH 6.8 00/23] 6.8.11-rc1 review
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

On Thu, 23 May 2024 at 15:22, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.11 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 128 total, 128 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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
* kselftest-memory-hotplug
* kselftest-mincore
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


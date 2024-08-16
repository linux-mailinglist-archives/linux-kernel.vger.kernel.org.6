Return-Path: <linux-kernel+bounces-289315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFB49544B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C95B219BC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553BD13AD22;
	Fri, 16 Aug 2024 08:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T1On0/6x"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0606CDAB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798039; cv=none; b=JFfbAOSzTy9k9i0f/esvvakX94E1oOztcYima4K6lJhE3nxNtbC5UeDfAS2rCx5G48FpT7GuHT4dSW0HFGhJzaUppKf+YSc4ZaPdvv7oujdfgUdVhkAZKT8EoSinW8sZWG94yYEfmBJaefF9DoFU6okuIcRiziMd/Tzqx0E0Dc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798039; c=relaxed/simple;
	bh=X+mXAbQqboRcObqzKQpaXGDJkEEX7ypQ939Nh+mB3n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbKGIy0tgfVQekQG5QjAqhRgPoBNkutQ83pjQpaQMrrBAgpMf1nlHN7ftrHmBH5T97es07y3iORNCfNBzjFfuqY2iaZfcHOSs1+xhk7XEEPwPme7DMMKV8TV5Rw98UA0UG2fuB0ZApf2Z6/gb+rP9ItHFFpxwCxKBu9o8ZW8cXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T1On0/6x; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so3908568e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723798035; x=1724402835; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y1wA22C8XYQ9wdJsqDDaxVdz3LjGATSDMDKJ8K3/NQA=;
        b=T1On0/6x4CMiXkhoctBq7HPssbWKgpKiOsTUBU8kaMW2V5q75u942q3uInO6tREW+4
         f9x/0B6ymihFxTvNmdycusksrkJcakiu/vRZDts9GEl+I7a1dQPXEkRwEOgBlipdDBue
         oKohRtjz2BRHcT0h8v1fMefO+JbsQgtjlMTSN2UClQt0Cl0QGo/mLvHQuat9p09GJF2F
         yLSpKTULIbuHoZJFqCZIFqTJsIIJmBKWuPv9FbOj0WcG1JE1qSOlVvkNZnxoAGVc8dQP
         1svTO6YBIELXZS/G8V6QdgNLDZIijbIv33/6xh8yKJC9wCng5uwE2+uTY6c+n6K0sBh7
         3I4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723798035; x=1724402835;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1wA22C8XYQ9wdJsqDDaxVdz3LjGATSDMDKJ8K3/NQA=;
        b=Ovk1lrU6hW35a4N2Myyth0kYcD1PsRBd6pq+4dFfF0shY7GPV88tJWkWPsBko0u8/D
         fpexmVSokPIkYP8fWaAXzUTxVW/Oo+On5/k5YaEhzcSLIjb1OlsjXoi7y3B55Yn3sBiV
         pww6Mdy3qMXa73AcWQ8uRaZRvHyToxhMabKMmMVomQiiXUKpfYF/dskq+ey+JZ5r5Qk9
         kxRD+nSb8cJG6aP+HjY5PXgaSYjibA/wVGJ6E89r9snzVdD114/038YXWNU9vinkx+WE
         ou0J1QIhoc4bPjes2uKEEynpP7T7hptuYNxozmWM/JU1ApjwZdBSh4aNmMiLoeHXoptb
         ir5g==
X-Forwarded-Encrypted: i=1; AJvYcCWWnm6jsnmafNxPFpyZR4bqy9A/bTNUAi/kbjSk0Yz2pt2MwQd/wq9wnzPwavWaTZQe+1Zlim0cHrTogth5KPQtGIZkqrSMiKCg/Yuz
X-Gm-Message-State: AOJu0YyHkplX3Svkvxb3ZAYj5e0Jy4bu6OrRIjuKkUpTUK4ZdR6M7Nj9
	lxilSxYJp3FdEgPmRgMakswlJA8FUgf+oCUxlYBL5rRb5a3hKx+/1hqK4aMsndmeZ5QpeFpN7Ro
	Hl9acawLLn9VsSk+DFkRmue+IV7RWdQaTOEs9LC4NVZ4ckwSnn5e3YQ==
X-Google-Smtp-Source: AGHT+IF/yq4eogQpb+KVB6Upi7DipVo81AdBqPCKVZbN7W1SoDT364gYIxNe6Qhgng1hz/D+R0Z49KDYsGPcDoS7noo=
X-Received: by 2002:a05:6512:2346:b0:530:ad8d:dcdb with SMTP id
 2adb3069b0e04-5331c6a1931mr1836355e87.19.1723798034663; Fri, 16 Aug 2024
 01:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815131838.311442229@linuxfoundation.org>
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 16 Aug 2024 10:47:02 +0200
Message-ID: <CADYN=9KdnuT-ng_pyL_NtB7vuYwBRyFxBP104QAGJWtMjGT-pg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/67] 6.6.47-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 16:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.47 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.47-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64 and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.47-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: f44ed2948b39fed7ff60f13f1f4d810c88380e65
* git describe: v6.6.46-68-gf44ed2948b39
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.46-68-gf44ed2948b39

## Test Regressions (compared to v6.6.45-190-ga67ef85bc6ce)

## Metric Regressions (compared to v6.6.45-190-ga67ef85bc6ce)

## Test Fixes (compared to v6.6.45-190-ga67ef85bc6ce)

## Metric Fixes (compared to v6.6.45-190-ga67ef85bc6ce)

## Test result summary
total: 208016, pass: 181890, fail: 2308, skip: 23462, xfail: 356

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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


Return-Path: <linux-kernel+bounces-263564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E0F93D7C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97BF2844B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07545812;
	Fri, 26 Jul 2024 17:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tsnih71t"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830661DFD1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015692; cv=none; b=PURXpIfJRV0W+CKs6sTS2lsZ7Fo8Wfbq3QmBl3KEjO3pz8FTo8BlzUc5ta2zGmmVJEkPJ9Q2pkgBzMt67t4Rst6m07eDWBQmUS0FqLELi5r/2l7m751kz0PV3FVRxoysmdtiVj7xJCf2wJAcj2owDjPDoZDmOQZjUnchjYz1YF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015692; c=relaxed/simple;
	bh=VOVTe8AbHTWQ9OIxXLbvHyvVlS+/yu3LH1L02ekm+vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4FMzQTK11KWTOk8rh+O07jBojMvrtdtAS/R2crOLBqFemzl1DCY0ezD570E34mwhB7NJunxa4qeGyNCpXuLdPEmpg7MtkY/fJfJTmARpkH9afz95qtQRDjmqVjRgqVqYoFxHGnJ0RLyJgg4JOja5Jj5UcK9TO4ZakfuK+EggQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tsnih71t; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f50d8ce6e0so291531e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722015689; x=1722620489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyV4Ranv8hjbex09xbs1+X1ftbwqkjv5OZ97MPZTSe8=;
        b=Tsnih71ta8ZpJ13NASl90l5xUtOcbjsR+7/eGLLj1WUfsU3hhAgGp5Cq6FLYuYyJDL
         iznumbUKcQ9U6yKCpMHbS+FCQCAwR2gVZYHveNTD2Evrjq6UFUkDTAHSIeXu655TXZCr
         3WRsWvl47FedOvr6mZqua2dkEX9WdFdYFcasGOMQy9SaEHJL6qlxBthyHXqnCcoMQ5FR
         fS5PxJE+3aLhj/oyV5gmumO3wjHgMykp9x8vdDIToTOYxlulsa5iH7+NV+J58y5OsVHW
         WAYpmxQR8zLQa4SsPxtskHWYABcKzVmHlxMuhJEu/PjjiyVUQLp4p+KPeTw5nvn9XWma
         Y/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015689; x=1722620489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NyV4Ranv8hjbex09xbs1+X1ftbwqkjv5OZ97MPZTSe8=;
        b=dKp+J/+QlFaFC7O4ZZXta9oTg02sBelU7fcItnTCiwQgBuNh+xpatxzK2qiDIaETd3
         6e3yT6AmECpvMpxXIgi4X1++C/s8y8iiYG6Y9TsEjhnb70wJshQWz4VsfxVuUWq3TZBG
         91LOsXYbp/Rci4VFmXo3FrqshjFhmNMGrHz4N4aJb37o4LgrME4xWe3a/lEz0mmyssrW
         Jmz3GpzTOyK5op/jhpod90JpJiGdu7QQoZJ7DdIyWo9x6fbVmDDoCQVs7J0wYdUG/cb5
         AbfcDoFVKZN+1B5xaVLfYIr5wgdQXDxupN1ElmXkiyJERI90KCt+NqT4WOuRrBWkrIzw
         +0Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUDCIgIFj5QDWibq+bEKPbqKFwobMqttUHiKnJiOm31RKW/CXk92gOn5P/Eoy4FkSHbOcRDMKNPL5WSiCXVScmUTKsIA0H7UQ1s+evj
X-Gm-Message-State: AOJu0Yyi2v46sTMeIDSnYp0nReKnqZ7EYAf3WTy6a0BcYCWy1iZc832d
	hh4aWfuVMp7blKXWTvfEdanXiY//dGAPmxS+29NdFDZwy8yQWd4q1wJK9yPH/1PVlxuLQMXTU8e
	OXVCAtK4kViAa7UZPFsYAGM20VplHDV9Qzyc+Qw==
X-Google-Smtp-Source: AGHT+IEokeUJzGuoeN1XnSD/FY3MN6iOE9X1osOhH1tB1eHXiIhNcjJ4EsQVCYkzHJarrfr3qgb1AqKBU+goVcyYVFs=
X-Received: by 2002:a05:6122:4124:b0:4f2:ebd9:8e12 with SMTP id
 71dfb90a1353d-4f6e68e2368mr177253e0c.5.1722015689388; Fri, 26 Jul 2024
 10:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142728.905379352@linuxfoundation.org>
In-Reply-To: <20240725142728.905379352@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Jul 2024 23:11:18 +0530
Message-ID: <CA+G9fYvsiw97j1nr1ckBtR28bWsbWLpHkCkw13U51nUemfMGkQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/16] 6.6.43-rc1 review
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

On Thu, 25 Jul 2024 at 20:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.43 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.43-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.43-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e83c1018357355c0547e7887022ef46510253e60
* git describe: v6.6.42-17-ge83c10183573
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4=
2-17-ge83c10183573

## Test Regressions (compared to v6.6.41-130-gc74fd6c58fb1)

## Metric Regressions (compared to v6.6.41-130-gc74fd6c58fb1)

## Test Fixes (compared to v6.6.41-130-gc74fd6c58fb1)

## Metric Fixes (compared to v6.6.41-130-gc74fd6c58fb1)

## Test result summary
total: 208041, pass: 178672, fail: 4082, skip: 24852, xfail: 435

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 30 passed, 1 failed

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


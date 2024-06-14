Return-Path: <linux-kernel+bounces-214391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA290838F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8EC283747
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD81482E3;
	Fri, 14 Jun 2024 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gi1hOcjQ"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AE1474C5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718345670; cv=none; b=ZUfqALnl0woxqq11bEsxxBZTfLwK2B24B9xG99ESlN6F/OPKswqTqoo2P4nzHibsapujZHCgmRbWvBwsVLKTHIlGwNaiJnS/LSAntOpk53iVR/Iy1pUh96FuV0LZN5S+U4CW4QnJFLZQFDuPFbDb5LQPCAVHCvVoW9uCCv9tewI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718345670; c=relaxed/simple;
	bh=MytOr15lMP9zYsxVhkxbv0AtZvnkkeakkDkldFUcRxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvD76VEygm+R6AmElecVvzLf0mDR4HwLAAWCP/YHOaOpklR3KbvOzshzSHC7mDU8pJEyej9T9M80Wqp7zUZNA2jqyzU/yA6stnWENkBkCGTwgIdn89nT2c9he+aQ972TY8/zkPocOb5ccSgQ57IDy9ksF8vhHDWJ0o5+0XqPHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gi1hOcjQ; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48c39fe4ee3so450943137.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 23:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718345668; x=1718950468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoQCHg8nTsh29WFdq4yg901so4FoHg732Ietl0cilNY=;
        b=Gi1hOcjQcQZqEvNE79kA13iXLzzPyDrPsPoYeKlymEOQuXOGsY5m13Cztxh3h8j4xI
         0CAQA7oSWuynGDo9mZuff/j+Ymw2n+IR8NK9QeraAFQ2Tpjd4uBrh8gEoS3V+/jXK060
         CcvvgMuMV6oyt2yRO56UpUnMiD9e9tyeVabf8dpXdQn1O9bOTLUfePE8VDZchTXCGH3H
         68voNGNYD0o6ShraEjYYXROZZSvRGXSJ0c2yt5K3piVpqcCRWakpdkvexXhNax8eL6q3
         YpqdMd7HkxznWyaRjWyCrhVUuiRbD6no2OK149mTNAbWrzuc16+xVWbnielNwiIOlcv3
         eTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718345668; x=1718950468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoQCHg8nTsh29WFdq4yg901so4FoHg732Ietl0cilNY=;
        b=fI1dn65bAR9er1/NjSvPy0meogew9/FCXL3mnTsrgPPl0FQe6uTXmktmmlLAeiEUBL
         WHw1YmHHlK/4kNZQy18d9ud7Ifl/cyemUX8gL7rBB8nbrgIleBH7G34PQjatTpEO30A0
         vlcKk4Kydfy82n6Ev71ClIxXYOsCctU+g3nOOYKQyZPEYqYquWwmkJv4GaGP4y+QgxxT
         EicQBDHGFU+Ld5Nu8FMvqeSpaR6MYfsu8PPzJ9P4Uu5pTGoLqwegz7gndzSY8oXkgFR2
         uVH3tveOnpcAIru7tNhluzwjqtm/mZTcqXfqxxN7HDHAw8CnPiuwryypMT++Gn+Zy6Ht
         K9vg==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZRcfYu5pcqjUeF+RuG7mxc3KoPE4tlIck4mXc9YJd3yD5WRbzu55krT6+KAdGzg88E8Kq1j1Jjh3yecWFlF/u9JBdmAAiGScxRfi
X-Gm-Message-State: AOJu0YxPlZY6BmreYXTbzIQhMtrg9Rt8vhrP2pFBdNGh2wqzMDGt6Yrw
	QgESvZLdVIsNmdeP/2cq8Isj7cSYYViHUIo1cgzcqMojcSJZ84LM71+y+n1+URvcdqZA0pvbiiR
	FUqqAmUJy2goWrYlqkhqySa+ZPNE48V3QenEarw==
X-Google-Smtp-Source: AGHT+IEVZCYAAQG7nnH9roHg5Tyj8jl++9tnhsT+t3AfgbA2BKnr0VLls1SY6LHX7bDPAF2WAjTvShgUu929VcT/WkU=
X-Received: by 2002:a05:6102:124f:b0:48c:368c:3673 with SMTP id
 ada2fe7eead31-48dae404fe1mr1824714137.28.1718345667916; Thu, 13 Jun 2024
 23:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113227.389465891@linuxfoundation.org>
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 14 Jun 2024 11:44:16 +0530
Message-ID: <CA+G9fYsPRCZY+n3iJfLj-KhWzNHaG7q8198F+okV7zKPR9NVjA@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/157] 6.9.5-rc1 review
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

On Thu, 13 Jun 2024 at 17:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.5 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.9.5-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.9.y
* git commit: 3fc8ec8cbfb63bed37f4702410201c973a690450
* git describe: v6.9.2-957-g3fc8ec8cbfb6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2=
-957-g3fc8ec8cbfb6

## Test Regressions (compared to v6.9.2-797-g4aee3af1daf2)

## Metric Regressions (compared to v6.9.2-797-g4aee3af1daf2)

## Test Fixes (compared to v6.9.2-797-g4aee3af1daf2)

## Metric Fixes (compared to v6.9.2-797-g4aee3af1daf2)

## Test result summary
total: 163101, pass: 141914, fail: 2059, skip: 19128, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
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


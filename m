Return-Path: <linux-kernel+bounces-205955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44242900297
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317481C2272D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249A18FC6D;
	Fri,  7 Jun 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ENpRDrjN"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE3187358
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760920; cv=none; b=P0tXsnu/ofO3/kvk2PFwNFlwuYx3zbP7t47sU2Kadr1MJqKjGzV3mavDuOvPkXwZg8mPQ9sHDaQ2kgwy5bsGYGv3IQAS6uA4AZP8H304R3NSUp6Lw4dd5JI0M+XKZx17u682oiskipTBpmTaiAjzWvDe2m+0PsGxrSZrYXjWvQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760920; c=relaxed/simple;
	bh=PeHkH+NfrrKJoMuN2ygAp9EcFcYtXM/K53hPDtU04fM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ho2KzSiIpLarPjvszV1BZNzpAwJYlgPsGdG96dytVqv6PY8FoywAJQdspCIb8d8rSv2gbq7+dQdYwVHZD2FaMYH+OOJh1UgsI/SPJkRZgDaAeFDShD4vC2GZDCmnkA6csM6Y8fRFjLm0ORnv1f9oWP+/COvIEu7wSxeNTdv25EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ENpRDrjN; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-80acf1bca86so628650241.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717760917; x=1718365717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/5wtcce17x6OATn8wPdogmtY0ka7nDOqTZMDuD4ISs=;
        b=ENpRDrjN3MmvHTMOmuod19wZITAjdpAPzbDd+dGRdWRs5bg46EDSHLCECtoREulQet
         idGwJMVvO4h5wl7Nq+mJL4REX43IeGy4JaiPj+ami8TlXcqe9yfh9TXhF4BONANqb28K
         TcIxRpsyUjeKSCC+pBJaP5rQtBFR4m3TjnyMteWg2yuvE+8wfZ2ssmfUtPPw30aKDo/R
         C/E2BQOqEZYHG+2hAmWaVp35lMY3aUV4r5eah3v0OPcpElNYuk6Jf0jgDcyKwOJF7pyQ
         zSrfsLveEI/MoAM68flcMnjCsUqFR/I7F2j7F7BZ6IkMy8X3dNkI976161aT2RQ/e7W+
         y97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760917; x=1718365717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/5wtcce17x6OATn8wPdogmtY0ka7nDOqTZMDuD4ISs=;
        b=uEr5rO2Ll41XNI4HBLw74FCu/hWPiaId9dU5XIxAVGM549+aCTF2JArb+IK6Qt5Z1g
         dBxyM3QIOG/g09gR/IykMIt6t7Hx8pxxagEj63Q9O3Eb6CO5HZyk7kpYZqion+ejJrRP
         rJ1IEzcfSIUKG4J80bnrZZwdr+rgT0a14I3Dw6M4jTQgilMge6yz9Df4gIvWSe1UHCcP
         gLksBsyOxKeWutxu+vZ2qOtfDNI1PEThnZvTAIrWmOCRNw1L4qo2gMl2CrVSUd31ZKwE
         9n2uhe8IZvC4l0aixombq04RfN+nNi4GdEoTYR6Z4wnF44xf4IqP8Ns9qE9m5HQtQyf5
         2d6A==
X-Forwarded-Encrypted: i=1; AJvYcCWDjc6bbz4lrPbAFT2qesQijXVlzxJ8bOqdGxORlVuP9YrbYxGsPCKJFUrEc4NvBeuD1UM3oUTgySck0HE9VU79dshHlEqpjLa+FDfz
X-Gm-Message-State: AOJu0Yxbljgjz6qw9GSx9p91x8F08/0U9dUFkxpfOonuSLBAC5Q/C1AK
	RADKdGx8NvnbzFx5J5TxoVkcQRe/RmNf+FY0TFDtYCG3KabpylPC53cRRKlVN8DFgqW8FBloODG
	vCqR039pvtB50wcE7kOzA2SY87azv93pBajf+ww==
X-Google-Smtp-Source: AGHT+IEdwmO0c+MBu1y4ofqEbQghy0qcz8uztrknpjZTw/IJT0CA0vI0J7TGrTqdcGE88Tlz0cCpiu60YEjDyFoXYrs=
X-Received: by 2002:a05:6102:4a57:b0:48a:3fa5:b832 with SMTP id
 ada2fe7eead31-48c27538f02mr1869372137.33.1717760917249; Fri, 07 Jun 2024
 04:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131651.683718371@linuxfoundation.org>
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Jun 2024 17:18:26 +0530
Message-ID: <CA+G9fYvOP-FL7w55vPig3p1iva_MAO+sqWnh3ZwPEopd_y-jow@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
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

On Thu, 6 Jun 2024 at 19:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
Build regressions on Powerpc.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.9.4-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.9.y
* git commit: fcbdac56b0ae848d2259d6b9825f289688a77e0b
* git describe: v6.9.2-803-gfcbdac56b0ae
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2=
-803-gfcbdac56b0ae

## Test Regressions (compared to v6.9.2)
* powerpc, build
  - clang-18-cell_defconfig
  - clang-18-defconfig
  - clang-18-maple_defconfig
  - clang-18-ppc64e_defconfig
  - clang-nightly-cell_defconfig
  - clang-nightly-defconfig
  - clang-nightly-maple_defconfig
  - clang-nightly-ppc64e_defconfig
  - gcc-13-cell_defconfig
  - gcc-13-defconfig
  - gcc-13-maple_defconfig
  - gcc-13-ppc64e_defconfig

## Metric Regressions (compared to v6.9.2)

## Test Fixes (compared to v6.9.2)

## Metric Fixes (compared to v6.9.2)

## Test result summary
total: 139061, pass: 121356, fail: 1981, skip: 15724, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 126 total, 126 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 22 passed, 12 failed
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


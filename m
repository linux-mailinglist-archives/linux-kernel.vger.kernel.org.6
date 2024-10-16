Return-Path: <linux-kernel+bounces-367568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 910EA9A03EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1585A1F20CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD211B6CFE;
	Wed, 16 Oct 2024 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxWtPzgC"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BA5180021
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066535; cv=none; b=a6xeucntqA2pMYn+mQmRdITnUnjSRKM2i1E4A9/M7OwcIIOIZFS5c0ZkK/gWCPel95QWkAyoWvJzQ5HjultcdHla+hXeFXETm6/G+6Bcek5Agjtvpf2CfnM1w6XeuUzlYqXipLiTfj+io1/J+Y17wJlQxOiA8phXzc9ui0eKovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066535; c=relaxed/simple;
	bh=1IuA3bPqqaF9ChAHU+88Fb58RTiFz8iAP0BqIuxg7OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPzm4Ac5fg8vcrCaZY1hTJlG6Fre2+8TYQKiRmhgZNsE4bPRFxjowGYxKD/SveuubG9oRHNXHXEJtbH2xS7GjU+nRLVefrU2rGr3BFl54dX8XsD83ufDec1ZW3cRsUNro7baMj97RnzOFEjBpofAEDBMStsb/8FFJdbBHmDX/GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxWtPzgC; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50d73699e13so420214e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729066531; x=1729671331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcI16q3sDOqKZecGXpjAdaHkVmug7qW5nF3fWN5j7Sg=;
        b=gxWtPzgCcKNNoGeX+LsKsV1X3wHOCrPxLu0ZHy5U0esZm74fesCEwnQ5/2/MgTJJxb
         4C+uUimXuvZmdnhQWj3lXYMCt9DnHcQcMcI6pdQGRtmHjFRDoNvZ9WLI0ebX7xyfYa40
         6qvBbmVfp9ag7x0ggd2c6gjXA5QCKQkMRKXhmAvcYXolRTH4gMUoU64tN56sxnyjGnVd
         Q5qOrt9DdlPAlVzgdUdKd13h5wuh52bRjmLF3ySOsdzs2INIjrfGidOc94LKRPLGgPSv
         hA2oYRZ5ldJLg34eb8RV4NatqlWkMLQtr6j5qTNRfWon75LYhDS/yLUB806JlFRUrVKZ
         f98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066531; x=1729671331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WcI16q3sDOqKZecGXpjAdaHkVmug7qW5nF3fWN5j7Sg=;
        b=AMTeVAN4Im6TIr1AkDnvnbeYua5y/8KHDk/watz4hoM+kPi4oK8K6A8hChpy71gBVo
         c8vTTNRBFrM3k1QMuELFjV1vddbxcDjpcqAiWVM4W98WK2IRHvsZQSydGRL0XCzWqO2+
         7dz6Ze4ZAIH5gcA00lUZNbwgGRRs/roEn11JZ6dTJonTyxdpsl0r3ZyQle4GA2H1Ik0q
         +n8pCmIZLtv7GiumuYSzwG9htNAr+bF0C3UWvwEvQ8H58CRHfA0/IhQUrNBwIqRMrLIN
         vXY/pbadtmdFlCcEXvtFo+ln6i9iiArWhi+x6w+arfjVgcPvG1j02EskioqkB0YKYdBh
         FIjA==
X-Forwarded-Encrypted: i=1; AJvYcCVPZbhFBa593L0u8i5gTkU3Co9k5qOiTS3pst124DcEt6I6KLx0ddFwTlNNSSyhRXfl+FTfeToEqpA3Igk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lWYon4N7EQn8QZUyuCcI2fu+hplhQ/SbgfOKh7a2Mtd8pSrC
	P3VwTPpUobZUSqAyVCO66CY+Rk+4Hb1tuSsHK9YsKn3Bh4cs1Z2mbHZXID8ZeqtAV6oJb5+Muax
	iq/4cFkbbOBwNFzyoLc5X43cLlwXqbUGTYD192WSEPrjQ9tTzaT0=
X-Google-Smtp-Source: AGHT+IHxOwITgnRBE6TVGRHtx87wi7sbYnfJoxuv+8L8wixdpSdQXnE1+VUBsdANoINyaftmyTfT0tGd6kA6S8OH86w=
X-Received: by 2002:a05:6122:10f9:b0:50d:4bd2:bc9b with SMTP id
 71dfb90a1353d-50d8cbc570dmr2383374e0c.0.1729066531501; Wed, 16 Oct 2024
 01:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015112501.498328041@linuxfoundation.org>
In-Reply-To: <20241015112501.498328041@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Oct 2024 13:45:20 +0530
Message-ID: <CA+G9fYtqUBXiXPm1kzEabqSzQy41Bh-OieCgnvNi5jVnHh4dpQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/791] 6.1.113-rc2 review
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

On Tue, 15 Oct 2024 at 16:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.113 release.
> There are 791 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.113-rc2.gz
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
* kernel: 6.1.113-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7e3aa874350e5222a88aac9d02d8bc5a8ff44f80
* git describe: v6.1.112-792-g7e3aa874350e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
12-792-g7e3aa874350e

## Test Regressions (compared to v6.1.110-137-g4f910bc2b928)

## Metric Regressions (compared to v6.1.110-137-g4f910bc2b928)

## Test Fixes (compared to v6.1.110-137-g4f910bc2b928)

## Metric Fixes (compared to v6.1.110-137-g4f910bc2b928)

## Test result summary
total: 205815, pass: 164289, fail: 3758, skip: 37525, xfail: 243

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 270 total, 270 passed, 0 failed
* arm64: 82 total, 82 passed, 0 failed
* i386: 56 total, 52 passed, 4 failed
* mips: 52 total, 50 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 72 total, 68 passed, 4 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 28 total, 28 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 66 total, 66 passed, 0 failed

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
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


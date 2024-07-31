Return-Path: <linux-kernel+bounces-269161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E79942EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648891C21610
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134B1B1409;
	Wed, 31 Jul 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fq0Dk+YT"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99451B012E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429315; cv=none; b=UpzUxkWZUYAkolm97/2tPSFSKomjGWDy3y8EmWoaDHPsSuvOeGZn2Kl05ltQbKqgN8MetgGqzrsMXzQy/W+T4tbCuPrzL0MVABkljcKcgc0edGht3PvFubYkG4nBqDv0/KbNFaVVpIM34Z6M9T8PZdHsGWuprkO+oQPBhe4ViHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429315; c=relaxed/simple;
	bh=F7g6Jwb0g+6zJzbakncV3Hcpjd44JyJqciMFM3KHbkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLUh5MHcbZDTlV5DrrHLGQ1fDhuUlxFH0+0C8+7Z66OJNt4COSqXwc0Pr1vYN3jTWRxM/RCoWjFvgty/UPP7CGyYUlU6KktEEuto4dProZ8b+J9PED/koQ596jDoAFIjnA3xloUtlupuqW21hFmX6Mv0ilnT8BmJY5+amVuAjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fq0Dk+YT; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4929540f38dso1618276137.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722429313; x=1723034113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9plYtmRP80+wBlogJewa2d7p+Jj8DwjpEDlvgRHRWB0=;
        b=Fq0Dk+YTzwRDG/fKkbe/amDNLOOvrkAVP3ALPEeceBaphyCWOkJqGoMmROnmE0oHS9
         sJ4HswK8I5X2L1iugJicSc04QK9box5nTIZIMRUWdWVBQEwJ8R7XTWfLW9/Lh9tY4xQn
         oHM0gXPGCuZJ/0+9+iOHyebktPxC/n/BpARyVOpDyHpJBU8iv8c4fGH6IZvwg5jSouwt
         EiTKlua0Rc5qxgaV0wzm9Z7BAI6wIknmJMagMWSWyxETZ4ak67CKl4iLi+2d9DRgdrmQ
         WT0PKHOcvKVO+KF/Un4aho9RzCtEY4KOeIkaYcs4MmrkcEHK/q9UzYro6/QqBKBDKmPI
         +law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429313; x=1723034113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9plYtmRP80+wBlogJewa2d7p+Jj8DwjpEDlvgRHRWB0=;
        b=teHn7N1Qqm8AczzYF3Yy07HMqlw9VlCAEW+g8Nd/DMBd5terfvf3XTAm4z0oMQ70Ah
         60ZQpzcxbgFU54lv/2xr4V9XwPwVuWIdww5BbYqVbf69uVT8j96TqUpE9bDutCS4xKZk
         IyCgH3KdIQ2QG4Z3gzX6PBWdqEB9X3fxBbmiias8pgaK+BxAavcQ0MB2Enn96AbBGI6K
         KTCmtAV7m5gTvYIOFOnfgXzdeaXMHZoQwZc5TsXh0MocOu7/HJxpOapSA/526DBtwNR3
         49jNkRJXCOFSAzX7T2QFCsE+e1DVwhvrX5I4iHoXKy2QEJnYJn55vx+i3LuQcU0nl2e6
         P2fg==
X-Forwarded-Encrypted: i=1; AJvYcCURHZKpXRX3gOtIxumvjR2lZCrHvgZ4VBolhr5awHRiQMuDjcOmjCd+juniOHFTuLLpe+gD51EIRdlVrH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4etjeWT1mTK0WcxUS3lYzY4s9X3jDSBxKn+fdwQsc39IWYecD
	60sWhWFKHVPguic6mHw9glsYUBnyaQaAmdNJq5NdkkHqlJMbW2NtaASFVyZp/et97ZjyuvzzSBz
	ix4zA3seKk3N+fXkZhmVV1S0nL/imWFTZ+2cHtw==
X-Google-Smtp-Source: AGHT+IGN7M9FJCdRY3tkah4AXjZbzv47boPqqFbb4PPEhjPuCbgfBfVFwzyXe0/MWeRtskwNEueTT6O9SNvE7rYef2A=
X-Received: by 2002:a05:6102:548b:b0:493:e713:c0ff with SMTP id
 ada2fe7eead31-493fa15f9b3mr17451687137.4.1722429312654; Wed, 31 Jul 2024
 05:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730151639.792277039@linuxfoundation.org>
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 31 Jul 2024 18:05:01 +0530
Message-ID: <CA+G9fYuotiGuEVYgNp5hGh3tWJcGykZycfH7kzAC2PgxwPWfrQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/568] 6.6.44-rc1 review
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

On Tue, 30 Jul 2024 at 21:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.44 release.
> There are 568 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.44-rc1.gz
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
* kernel: 6.6.44-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7d0be44d622fe39aeb7f09de19807d1dce272100
* git describe: v6.6.43-569-g7d0be44d622f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4=
3-569-g7d0be44d622f

## Test Regressions (compared to v6.6.42-17-ge83c10183573)

## Metric Regressions (compared to v6.6.42-17-ge83c10183573)

## Test Fixes (compared to v6.6.42-17-ge83c10183573)

## Metric Fixes (compared to v6.6.42-17-ge83c10183573)

## Test result summary
total: 246982, pass: 213532, fail: 3566, skip: 29419, xfail: 465

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


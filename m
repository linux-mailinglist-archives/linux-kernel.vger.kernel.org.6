Return-Path: <linux-kernel+bounces-385439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B8B9B3730
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7384FB2657A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883051DF24D;
	Mon, 28 Oct 2024 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="khQ9o4u+"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582C1DEFC8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134698; cv=none; b=kYisxnoRtcV/reaDY6A3ONUYXACzBYUS3GZqepo0syiunsEjj8fk+lyT8+jUElsPpZzAh23YUJmK2/gMCEVu7zuc6pUfdwDgdLEPT+jra5sgjGVqJvMLO08eDhPV0brUljxHhMfqxSHYgg258TJhrufK+R/3fL1elZr3eKVMl2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134698; c=relaxed/simple;
	bh=ohFw+ea6mebjXd9Sjilyg/BG2rFSmJXUFprHTU/DvE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMjcwRb/8eruiSVClMjT1hLJ4wpE1cEEqJCVdjTOItcDEDxtc8fZTi1CBAVb5ZZaihKpNT7008/4x1jyKUWGFeVX0OfSYHhkN3Rjiz2oTPb/Wkp2jucsZqqX7b388WifEmOOYEPd2NYcx5SX5usVSjLXv4xQ8nOo8gwzxqW2XhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=khQ9o4u+; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4a471fd7ef6so2845680137.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730134695; x=1730739495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnVsJ5BKFWvKL2TerWf9B/X3frU9S9Ng6vfTYMiNZWQ=;
        b=khQ9o4u+YdLmE/0IPi41MzlA5brbiDBTScHx0zljpCh5/prjbNYPCHnyS6KhfznLEC
         QLvWeEtg8tlHJxquNScRl6GvNThhhc4e7ED+k89IY2oYE8yUWBMZ0G2ePxkwH4QkKhpX
         kDT9/gF6j6Jh2ynJabIDKVWvbnOK/KJCaVzTfJkPnpC4ZdVjMHeHQFxOZ0S2Aio59tTo
         2r0CldNJOYr+I/J3zVUGrX95z66AWtUKpd/cQzNPoiFQGj1gtZGG0IlkGSOOfrDwFzRS
         MZLLkpbSaIoLYTbyw0KiUDlJjrZlr5Gt5GrMcBn4f/PXYIRISxApMRpczz0Uj0YZW655
         D9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730134695; x=1730739495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnVsJ5BKFWvKL2TerWf9B/X3frU9S9Ng6vfTYMiNZWQ=;
        b=EM4+jbm1x9628JbCCOarxfJRry20KYAHPmzY++DgDvKP7AQJ3lrbXV3RutZQRMgnBW
         pbK1vakLDKahQX6tQ0rbysQ+/hvSbFVUzAUaovsK0WY09WeQbomw+4+Mdjhay7jDHyj6
         Pxuj6w/xMs3f9uVBfiU1KSZiFH9a8EzNZW1jUYo913QY/BKvUH3VJNANb408TxNlYp/T
         4EBjGpytmy2ZkKeQ8ECcw4/3pex5DGgHlwVM6KvCU/ld+yYzB9/n1HjUovJWHADNFPsS
         INhZyxx2Nj/mLIB/MK+5urPlzOGDbU7L1hnQ1JJnrOwXhlc9Ig5H46CBKFuCq45dsOTM
         NxaA==
X-Forwarded-Encrypted: i=1; AJvYcCW6frWkkArA4iwvy2MEIbqu+qRrMUmcuq1b8kXSvUqLoOcg0x+8AGbH63wCgYTQzSH8YkHURJo20/Qxboc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXkM7soL1X2IQ1oKaAoq1n2UDheD3/JBfFIcjvKh5sxS941J/A
	YWifX+2Mb4bgnpj2eyAL6EOtGsrNrstkdOBcO34bPJb0UphGGWO4ESFKx1HwoGHypUYk0rw2ED0
	ZxFrUv7iTXw+6C1RItwN2wczbhNFDU+iKYxTY7A==
X-Google-Smtp-Source: AGHT+IFiq6qwvAwzp6+NiRfGka4tAO7pBxudWRFNqq1AbzlBJRL/wBO/f7rGlg7YSPkrgQpgB2dEer/JTay1ArDj2V0=
X-Received: by 2002:a05:6102:3706:b0:4a4:ba6d:2a5c with SMTP id
 ada2fe7eead31-4a8f2b8791dmr421264137.10.1730134695515; Mon, 28 Oct 2024
 09:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028062258.708872330@linuxfoundation.org>
In-Reply-To: <20241028062258.708872330@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 28 Oct 2024 22:28:03 +0530
Message-ID: <CA+G9fYstzcgi3wVqxSAnFt5P_HqpVqM-Q8k8ot9oqQN=Tx8bEw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/137] 6.1.115-rc1 review
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

On Mon, 28 Oct 2024 at 12:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.115 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.115-rc1.gz
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
* kernel: 6.1.115-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: eeea9e03a3d455b443e3b05c856570c610582ba1
* git describe: v6.1.113-232-geeea9e03a3d4
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
13-232-geeea9e03a3d4

## Test Regressions (compared to v6.1.113-92-g6a7f9259c323)

## Metric Regressions (compared to v6.1.113-92-g6a7f9259c323)

## Test Fixes (compared to v6.1.113-92-g6a7f9259c323)

## Metric Fixes (compared to v6.1.113-92-g6a7f9259c323)

## Test result summary
total: 96964, pass: 77844, fail: 1736, skip: 17299, xfail: 85

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
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


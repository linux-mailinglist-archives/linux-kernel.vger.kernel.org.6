Return-Path: <linux-kernel+bounces-528364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4FDA416ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1AE718952A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAED24166E;
	Mon, 24 Feb 2025 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDtL7Ii3"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098518EFD4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740384632; cv=none; b=dMhyZlPk5YT13X2FxtwxBynrUqkEoFd3ygQWhvGUHWFRX7523gvqUX2ktFoVvZpu4/6Wgs/LwjV4FfsLS1JxDSAgOXKQlj+IOgkKufdHzNuAZUgXJ3lJSRXYKzLyKytPPQG+Y9ILn/vM46AlDbyCbfRRRD1/Tnynpx2GOHHDz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740384632; c=relaxed/simple;
	bh=u8TrK9hYcC65/WeviX8JWvUBq96uK8ZgDDuf0b8u/ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSHBTgzg5dOO9pikM7oo7c8lw9fiRDAo2RIS4wGHVr06CX6DaWSpSdeRo6gxFy1r23sBo3wQ4kRyZDJbOYLsUaxx931DhMg+9ESMg+lUJY3G0cSAzZVlxnNt/yfH6TILYSBG0lfpM5yLEcOiYc97wWBJQouzfr3qY9pObp4y9nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WDtL7Ii3; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-868fa40bb9aso1244687241.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740384628; x=1740989428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rAfh0+TUi6TP02l6JXkpyL3aEAeCTCEFN0Bf4ro6c4=;
        b=WDtL7Ii3e5ZCQ+E5MAdnHj3IMXVFC4PGp9uY9bQZ6doH2gSTSW7u+wOANozq0gjsBr
         A1rD1fgXmpQd0EJAXfE+rABAsKDmjdw8q6c26SUXqc3oRc9j4ldslefh7K69bcU6rn0M
         m3KBevC0UK1L2BObnjH8uYfq8E3PQwzYYSx6csEdQZLgQHUCwK+HLppkZ09QJSn+O1Fw
         bxYlxavX7rIyGT/hgrcSJbyOBkhphWv6zXBHPO/nrCa9sY5OGIGT7TkYA+OvhQRN4mny
         H+sFi0qS67k1WYO4sd2pYRWk2XWrGxXrMZJDwidFlj19EGqEhZhiBq7Is7Nr/4vAox9Y
         58Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740384628; x=1740989428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rAfh0+TUi6TP02l6JXkpyL3aEAeCTCEFN0Bf4ro6c4=;
        b=PEcqq27P6UyCbyXvibFrHY5GozXanXIXlMK61CJXW+tBaTf0p8vtJmq7QGWsLqbSpJ
         O7CojguQYvTNgyNEteQKcnHIKyrnKDtaIv3WDhlKWAjs3bP3eGPj4Tulf9GTSfZWlR6Z
         QTTaS7NsqIgjdLVxY25AMc09hYOnAZmfq7E5URVuFo8Nmlfzy4Wy96ZN9acBTOoyXJNz
         uWp0ROh2iM1pImUrU3zC6e2WA1KopWHzK2pJ8zoCzQyhO3S9RQMw19BoRPsfVEU2lVWV
         6OLMLbAyLy0qEev0DTXRQK5SkRRo/two+b34kuIaOnsxn0QccqSTBeXhAc2Fa9Lk0PIw
         17Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVluH2i5q8+79DmrJWufdoYtcbGH5wsc4S4LTDm2jJEORGu5QM/yLKmqL9Q3d9MxLjlDatTAye78TsaGw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9UGA7GYzLOEbSt37e4gFJMtynPX8FDOQ0tgCoVFSzoy8LbuwL
	U915fCWbXcNh/85JsDIYmp7DtUkmdxHmvotV3MqWhTDRdVeMan8oVCYaGK9pT8V8NmotznhxruG
	r/d7FXzDc1DZSwe931CCCaHquuIdT/82MQ/++gQ==
X-Gm-Gg: ASbGncv4x5cQzf+TppTPxHY76qF+Nh/lcyDLRgeVIzXd+neS8oV+KEcdpPbZ6tjC6X6
	kQj2IqEV+1cicVUuRXZqUgmyxcSHvz4EXeI/oPbnCDNTk2IBsdAEVsQpoU4o1P097eFFClDuUyy
	FU/x3tBc1ulFE30AVJJIRlHkkGWTPCPiZ7GcyDgMcu
X-Google-Smtp-Source: AGHT+IFtTzjpecd4WNbfJBrPmnNi8gxRNYitwtUYtxG//98YquxYsUWInAxrtNW/QbRt9da1gEn7CzWKqroyZsH5TV8=
X-Received: by 2002:a05:6102:c8c:b0:4bb:e8c5:b172 with SMTP id
 ada2fe7eead31-4bfc0098918mr5692399137.8.1740384628553; Mon, 24 Feb 2025
 00:10:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104545.805660879@linuxfoundation.org>
In-Reply-To: <20250220104545.805660879@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 24 Feb 2025 13:40:16 +0530
X-Gm-Features: AWEUYZkqBO2UQkfmgOsDe-rD71hPOBWtwJTpV4dFszBoXqdjV-sFVpZiDA8Hqo4
Message-ID: <CA+G9fYuoYfGft-2D88dCVQeB5mTvyf6ADkWau172BZs2SD99VQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/569] 6.1.129-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Feb 2025 at 16:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.129 release.
> There are 569 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Feb 2025 10:44:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.129-rc2.gz
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
* kernel: 6.1.129-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: fdd3f50c8e3e56aa4407011c21e440d1f39bf99f
* git describe: v6.1.128-570-gfdd3f50c8e3e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
28-570-gfdd3f50c8e3e

## Test Regressions (compared to v6.1.126-65-gc5148ca733b3)

## Metric Regressions (compared to v6.1.126-65-gc5148ca733b3)

## Test Fixes (compared to v6.1.126-65-gc5148ca733b3)

## Metric Fixes (compared to v6.1.126-65-gc5148ca733b3)

## Test result summary
total: 104367, pass: 81540, fail: 3794, skip: 18597, xfail: 436

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 20 total, 20 passed, 0 failed
* i386: 26 total, 22 passed, 4 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 31 total, 30 passed, 1 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 11 total, 11 passed, 0 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
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
* kselftest-x86
* kunit
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
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


Return-Path: <linux-kernel+bounces-571025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5886A6B811
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264F4189A359
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959231F17E5;
	Fri, 21 Mar 2025 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoW3CxCL"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9ED33F6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550573; cv=none; b=VQgKEixo+NhCnF63XVXyFtOIcFY8gOpJqR4QJSv31JkpBQofmZ9osY2aEgJwujpLJQxBpd813CGZbplWlojOGvfNoM4vrsfejMZT9BL9ClME7/gLjYHdceiK2reSaOXPPLe5dTf8yJfEfi+B03/ihUPffkt0OPhsxEAT16u5WkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550573; c=relaxed/simple;
	bh=FBNNN1T3t59Tmpv8LEr3stQJ8rv7s00/+6zV37RZu2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ld8+C1I4KPUwgR1zfUWZwTb/VTZ+5JcXnVO5n7kgEB/xl8VYhjmRyO5r4WAjTqE6ZVbEvwCRfoFStjgG2howWKiHMAgJZ8HKB30o5efOBqGaMRTPN7yUWawX96E6Prr3sI7n6674xg7t20Qu+DxQaQusOd7eB0eHl630nk2z9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoW3CxCL; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso1880454e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742550569; x=1743155369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rK/B5DzwT3J1GRA+EoLqTvc3oEK9I7okqvwd1BTbP4=;
        b=QoW3CxCLuPdQoU3d5zVzyVvtO7Y4mklFGZ04joWQpKlfm2B99ol+Z3xh1Ew80tfzIu
         Fp+okgFkMUSqq+RGeIBtkK+jJIZHpvBnfE8TawUWNxmU4B0hzzEY+xAbqUBIfHC091wI
         YBGnwq+e4uMgsjoPQl7Rbe5F9jfl8nB8rcJt7dTkflrBMavoVYsLUqBSr4jIMPIQ15S9
         PFjCnd8lSr/wud1AM1aaL3sag5kzRGwj4u6kCDT0HbyKvnyRLAE6mxyXXNRffteP3DaA
         zg9M79k9zbEVEFOgfsMu0eYyIWs46mrgPTurxzzt23hv9akQk/zNGFUnQZeDUIZzTOhN
         UBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742550569; x=1743155369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2rK/B5DzwT3J1GRA+EoLqTvc3oEK9I7okqvwd1BTbP4=;
        b=dRXpkp7Ia93eDr+7DVuPtqgP8wjfc46yRqwZWpmh1wFn40P0HWpuyBCh8fRbykYz8i
         Fs9jbJh50N92Y/5YctrQ5Bk0X26cn5Hy/L1qmzNfMBYzJpa/9T7GY++ijTq7xZRLfsGk
         Ko3xlA4TLGnBMV0et2kvZRCVIz48f1I3UkS7E2tEufF7R1uOubcxZuPtI+q26L3pgJfB
         /U3BFvU8SoVWBwveo7RSYDOMm/H65lj6EnUOJqEsRrwGI/0RFcXplOnviixcoqx2Duwe
         1LFeVedVk5oU1D0uaQzZ0RhXU2vtHvNR0mfzKNmHPVrHxCBWORESUq+MyllnGnxl0s2y
         zbzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDB1tA35xM1+FXeUMtlz62lIKtsjboB4jIk8YeGUB0J1WtoJfunWjlHLht9dKvNMK3zh4NXBfcNEF38Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwj9t0wTa3uPde5oMHinTdeYyvAG7S9Kf502WAzIeAaRjDDQlS
	sf5Fkokx6Z0eaQPV3+D6yunQ3Kk/maK7hMV6qz/thnBVo63FvPxQZ9BBBljPfG3Mg/FzlF6jplF
	ZBj4FubuN+7nXYZTXAJ/Bd7lFdDKFAC2Vz665Mw==
X-Gm-Gg: ASbGncu/Wz/1JhN+V8UutF/mx6ealCOYOdKIcyYrTpd8JWLkDkw72L7bbHUbfYATOD0
	8cqunplhVMTD0xJJskU1r4jrQY9hFUZAPaRBIgRFu1m6zXPJ0aSEwkx9Ug8l44dVWBIpIbzOwVb
	PTimIXWZWDw3WUULhcwNUEW/dW7i3O2icVF3B/mLY=
X-Google-Smtp-Source: AGHT+IGdqoAmjUZRBYqe9DYKyE/4py+xLqdJc6eJ3pKGIusC+9ialfwtptmVRFX5uDkAPwEKoscc2iWLcC0KHsFY6CA=
X-Received: by 2002:a05:6122:f1b:b0:525:9dd5:d55a with SMTP id
 71dfb90a1353d-525a8503a51mr1933130e0c.8.1742550569080; Fri, 21 Mar 2025
 02:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320165654.807128435@linuxfoundation.org>
In-Reply-To: <20250320165654.807128435@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 21 Mar 2025 15:19:17 +0530
X-Gm-Features: AQ5f1JpaG9WtwrsAMyoghNfS-3hKzliKLZSvBSeYdymXpnaW4rCJ_budV-dCn_o
Message-ID: <CA+G9fYs5n0NVPKok7bNwwySMEpY0EKrdDYF03yxHONTuS3vDuA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/166] 6.6.84-rc2 review
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

On Thu, 20 Mar 2025 at 23:24, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.84 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Mar 2025 16:56:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.84-rc2.gz
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
* kernel: 6.6.84-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: bddc6e9322072ac3aa15bd972c5bcbf9f447d246
* git describe: v6.6.83-167-gbddc6e932207
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.8=
3-167-gbddc6e932207

## Test Regressions (compared to v6.6.81-152-ge7347110295b)

## Metric Regressions (compared to v6.6.81-152-ge7347110295b)

## Test Fixes (compared to v6.6.81-152-ge7347110295b)

## Metric Fixes (compared to v6.6.81-152-ge7347110295b)

## Test result summary
total: 129260, pass: 106043, fail: 3203, skip: 19527, xfail: 487

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 46 total, 42 passed, 4 failed
* i386: 31 total, 26 passed, 5 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 23 total, 22 passed, 1 failed
* s390: 18 total, 14 passed, 4 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 37 passed, 1 failed

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
* kselftest-x86
* kunit
* kvm-unit-tests
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


Return-Path: <linux-kernel+bounces-356281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7593995EF6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24D428659E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722011487CD;
	Wed,  9 Oct 2024 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G5JruwTr"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41415DBB3
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728451765; cv=none; b=Li1LxnRu3kHg1iF2hxtJvve/pFuYAtb1fLlm16i8qFwPDhU4FFEJiOU/LnnIeqGGMl+3bp/Q5A6Wddp969QYazs/sYTx7wJWU5NepfpAjgmwOV//PfuEPJFP5O8AaL5uXfl+tGq0gMiI+SeEca3S0sXJPwG2sKEBrRywtg3sR4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728451765; c=relaxed/simple;
	bh=OBoCzZArSFPgtY+XzpCWy7XGfDqTIIl94ILCcqhCr+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d14QzCAButll5+pEWgdb0jn1mTXawtQxD6Ru0ond4+5n6DqKlVzI+tq1GtOe3IH/2rUdwa+a0X2eJNHTldBluvIwEz2TZ9FPNoJMekuybKhXIHAWsmJXxOFflS+dDWsLafXqMXzJ/BGl/9mKy8U5dJIB9fmGKtqdE5X9gIITM44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G5JruwTr; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a3a8e81897so2360995137.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 22:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728451763; x=1729056563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCiKLx9rR66lKJZ0yCzrSNrW64yAvgeD84o2+iatpFA=;
        b=G5JruwTr6yAzbJ+rxUOBzQH9mQP/1ZpV/1PVtO6LgscpPoZxsekoez33g2LdUw7v15
         bTkVVnJR9ZVWULELwFBOk/haB0qs3oH7MCnrg1D6eTY1yRvK1UlPx1cb/NunLyrgUT9R
         WZvOqPDwAqE77BZSnFsC9dwsnArCIsreoDOGez7/l2TAm5cbIyChFXGfImTXUXh3PbhK
         au0LgxxPh3HbPiwbp2G3fIxKpNjjET3Ai6MkXU3Kva4OWEqqMfXq4Ou8W380XEhrlsRk
         1wSjm1VxInOSeThzx7WVqiWsmG/L9Cz6EK5+o+Au5X/hpDSXpSa4/v2xOf6St7SurtvX
         d/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728451763; x=1729056563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCiKLx9rR66lKJZ0yCzrSNrW64yAvgeD84o2+iatpFA=;
        b=i/rh3gZ98i222QPnVrkMGG+pMuVUVQN6Squ6uIZPE/U3vPpLVkZUixfXLqQQzXSkyC
         0Pjn9GuM4H4H2qlCLul4oO4WvRJ4/TrEgzrM0yxT/jBgF4U11jTL3jOo8H/KJoYrfcSj
         C1Ach5zg9d5o6WrjSVia98rM7hWz5fm0JES6fxmFIcQSCCBSy0taoq+b/9M2zM/M8aYI
         eZwmEqUJwWjdgNNkejfm5V0+8VqNvGUnDHWAJoRW9AzsxLVo2lgiVH9KHsSTVGH0SAZz
         oEMYm7LNjid5i4MIml5e4uZtr6MkpWy5Kk10Elrk44nRuogm5uJnu3kqusRsdIBHChpF
         lpMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0msI8RPJNF+voXBSRAstwasVTeTSo2fgDKOHha0BkM6c+V2tZgYS/23Sj/vBmAiilAQOAlG+KuLm7QuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/8TbKep+Kuvl7zKMSwM0NLHT4H6ashP1eAvQKxhC/JJ6isiO
	9HNLODTLXMJ9qRV23FcV5jyTFygFP0hHMXiOSG9Vevcr0xjozWwnHoOq2QZai4N3EDXbhEhy27j
	22W7t7dcR2kTk4nIORhToPbRs6a+3HF28SlizWw==
X-Google-Smtp-Source: AGHT+IEcGCHgN/Nj3U5qhLD6lgrzYU7T8ZcxgAgJFS75WLUI0nZsy/ZitTpWbJ/jXeNp0bK1KTTXpLFNuIpFI+P1egA=
X-Received: by 2002:a05:6102:e0e:b0:4a3:c7ff:8263 with SMTP id
 ada2fe7eead31-4a448e14dbbmr1647756137.20.1728451762845; Tue, 08 Oct 2024
 22:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008115702.214071228@linuxfoundation.org>
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 9 Oct 2024 10:59:11 +0530
Message-ID: <CA+G9fYtKrtzVZve=R_QiUUya5KUpAYn2R5andSk+ghPU21z3Dw@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
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

On Tue, 8 Oct 2024 at 18:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.11.3-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: dd3578144a91f9258e2da8e085a412adc667dba5
* git describe: v6.11.2-559-gdd3578144a91
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.2-559-gdd3578144a91

## Test Regressions (compared to v6.11.1-696-g10e0eb4cf267)

## Metric Regressions (compared to v6.11.1-696-g10e0eb4cf267)

## Test Fixes (compared to v6.11.1-696-g10e0eb4cf267)

## Metric Fixes (compared to v6.11.1-696-g10e0eb4cf267)

## Test result summary
total: 229679, pass: 200671, fail: 2692, skip: 26316, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 129 passed, 2 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 18 total, 16 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 16 total, 14 passed, 2 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 35 total, 35 passed, 0 failed

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
* kselftest-rust
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


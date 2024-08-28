Return-Path: <linux-kernel+bounces-305032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8530796286D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096761F22720
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DB61850A4;
	Wed, 28 Aug 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dMp8wDyM"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34541175D48
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851050; cv=none; b=Zfw75DAUAOxTFpc29Y53xzZS1WCrDsvJER5622Mcnmbttj8lDy8syVQhq3Z2XrC75hwHDP4qgndmmJ3FlHt6LQrBn+Fjuc2lKXU922jho3UrGdnZ/6ApeR3nATfqjLNyNrrc9FMnl06M+SZEW0zCtZ2y9D4iQDEFvafgghRketk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851050; c=relaxed/simple;
	bh=hPDWqLIHM/DnZGu4RmS69ayFXne41WlztcIZGcd8f8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hN0Ys1Mj7s6eOJq/EPBSSKFN/XLwyz4vNpSFRKqtNWgdFOYerFEv0Q/ZWJWCz0d8i+3i+rqgaAYebaxzd985Trsv6plVL47uFRqgsoTwVwf3wy/ytSzTH3Qnw40Kfzw4sB+H8CMLELyMtcHN2lzzxyEmuRjGOnLfI4tFAZdOmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dMp8wDyM; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db16a98d16so1048748b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724851047; x=1725455847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p85AmrzBy9ysQPfxftCN2WfEfLHzF0fIelXYs6ezfX8=;
        b=dMp8wDyMHW1Sj4U8c/zbU7ONSrUx6TJDwDtoxQNeOxP92T2uZCeBZX32/AtJ1M7m7s
         Opf6pD31La5ahEOvW39NRo/bCYjWXKBgQ7odnLun77Fqi3L+ND64WHy9R1MWAz3ipCQb
         XOA3TjLseLSx0pCLf8Zi7P16K4F8V9qPrybiJrm1zg/VYgNZClbHEQ83Mk3OBrOBBgVn
         NEkw3I4cbNdF/QL5H/IA6KxQiQJMDGq0u/KM39ePI6vB0UnM80YXfxp0omd6Hv6wzJr/
         R6vrCZ9030/nudMrgLebMVmM34TGygcuTSdfA00f70+NRdntwQmlDVkY+rh+08IPszes
         uhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851047; x=1725455847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p85AmrzBy9ysQPfxftCN2WfEfLHzF0fIelXYs6ezfX8=;
        b=IG0zdOlba4ITtX2RDqcjvkU79eGA3j1yEwoYcfizEKnzW0a+RD/GIrN06ddXmnlTFS
         /1LiCW5lVzKvDwn8iQPKreJ206cb7oRWUiHULOEfiDNPLqgzk9w7PwmmGnMjOPWsHCJS
         rL+KsSZ8V6I8wREIY8O/w4h78rYpeWsP6pWKO5+E3lZDi1H2MZK1AJ9N2lCigCydmbHA
         Puax7x2huFRo83tz17rlvVQPsWwG2fBKIcL2AdFU+r+qsGdhB6HCb1Gc+ITlwIcbOPiX
         CG+OY3YS38Dqy8JRzvs4cr3JH0YQMEtJUeiYu1Opf+dnJD74lltgTV4Yk44LEfLYeDDu
         6dCg==
X-Forwarded-Encrypted: i=1; AJvYcCXSRPz3LyvN8Gm59Djbf7Nzwq9d1r8J31DPVr0NZGSrI9aVwOalhbG6CGLmfZDux57dak+AfMPl0U5CP5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQdfvdQA4/aJr7gDLeG6dY8q+eHUPSqEqWDJAoxmRpSxevk69B
	mU6+9o6C1brPwglxCZmdd9jSjfz0wSpHHVWSxTV4DV+kkKCJnyI1NUEHS40/go5qjKQOJ+kFkZ+
	xyLj2UMLMwBXrRb853rwotGbuMwdwkEN9FKGw+w==
X-Google-Smtp-Source: AGHT+IG2ZNqmCpvxZnZqXDnDiNptOQpD9bze//Y71Nl6tPd+HcMtO0wrNlyQSgo+kAl6HiZywcc/ScZhP0dm+GM7DHw=
X-Received: by 2002:a05:6808:3026:b0:3da:b3b3:191 with SMTP id
 5614622812f47-3deffbae250mr1974969b6e.48.1724851047220; Wed, 28 Aug 2024
 06:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143833.371588371@linuxfoundation.org>
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 28 Aug 2024 18:47:15 +0530
Message-ID: <CA+G9fYvH=+SD+UxZ0koz4rtm4XxHfG--oZZCpD0svEcODZ9pjQ@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/273] 6.10.7-rc1 review
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

On Tue, 27 Aug 2024 at 20:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.7 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.7-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: aa78b3c4e7eeb94e23ce019c419141739613862e
* git describe: v6.10.6-274-gaa78b3c4e7ee
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.6-274-gaa78b3c4e7ee

## Test Regressions (compared to v6.10.5-26-ga522cad06418)

## Metric Regressions (compared to v6.10.5-26-ga522cad06418)

## Test Fixes (compared to v6.10.5-26-ga522cad06418)

## Metric Fixes (compared to v6.10.5-26-ga522cad06418)

## Test result summary
total: 171554, pass: 150636, fail: 1805, skip: 18905, xfail: 208

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 127 passed, 2 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
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


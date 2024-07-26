Return-Path: <linux-kernel+bounces-263570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FE93D7CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96C0B20EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6F42AAD;
	Fri, 26 Jul 2024 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qSDSl3Rp"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E238DC3
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016118; cv=none; b=TcR9NVS8ZHvPKIakdlIDer1nCVs2aQUXS3c4qSwjgRdJR+Ozj/3S7aiNpYFZjoZdVfxLDi9Xkr5XPd/aImlMZA+IznAbRVAPouASxcIHpHAn/4PBZMkqiZgbc6VRFs4dmIfK8RiFzg1SmsQalBLlJFDVhVNQKE9fOEcBmRaSnZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016118; c=relaxed/simple;
	bh=otPRFuTabGDQ7DAsdpT0OWXU/0cXxSp4T04CdGaalzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ikxj6HOPFXLc/rW4EiCnv0tfrOODG4WJhBbvQSJkso+I9AsHEbg2rKp7ZfFv069wQCiPn6xsc2SzZp/V/Zt/ibOuzPe1h7oL+Ik5sYEv3UtxgkP37tU1GLOK1RmC6/0fvYjmKKK5sp27XnJ1k/F5fft/GPgrmOGSzELEGR+qd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qSDSl3Rp; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4928d2f45e2so794708137.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722016115; x=1722620915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spa65CuiZdVRxM1p2T1rZfFElb+ut95jd1snNIKOAkk=;
        b=qSDSl3RpPj8roVgsn1EoqemIlk9ObuWpUId/lb7aoQBVgZzlVfJeNPEFDJf/Ohvwmw
         SiWleJVty7B6SBFbiqOOHCUOGVySG5m57gPRnAXxiNxJNyNjIt7dmEJbRDY3mDCK0Svk
         bnteSH+lDDPdp1OuJjrPWBFeZVjFrPobEBoebqtfePknNQna9wgSlBTbu8Aub8bckRaF
         E6Omw0HTWgcZ5qwd5VRXvmW4o4BkxCTQKEGQt+T/JV6jAFJVI36nWCncQ0JrOllLNxmx
         rHIzojVGb0lwfxxTJDb5sAeUddO+OSz7in5TSZGHOtQ2O24TnPOR+qhNhVQgbU2lxniI
         z//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016115; x=1722620915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=spa65CuiZdVRxM1p2T1rZfFElb+ut95jd1snNIKOAkk=;
        b=UYJ0BA3ExU/l0ZQdVmTTRcLl1mXB44AtSosVBUTCIUj/YJcS9Zx7lSxMI8wIb6jYWy
         ODpCda04BaXpZHK1KNp7ly4PE5h/s8txeRKNYMhAOccV5YikRqmoCH9kG/B3O4+e2KUP
         W8oSUG28kKmW+I+NESczjuzL5p7+T/mEKESST1xZJCHuGBdBfLBRrnecchbmsR4CfCpx
         pr802VGpnY6m/0kYuiSsnc89A68vaaX6D4AplTBsbV418x4CZwjFlNEfn7nGMtn1RxlB
         uGVn/7ak9NNBeqcH6QsYsNfGJ/YrZy6HiUz+gwcxhSa422jESJH/KXhEK8pyw6byAXt7
         ZLJw==
X-Forwarded-Encrypted: i=1; AJvYcCUpP7Qo6loKbyaKwq1cmBybYDzMv0yZtoi5ypcJjf2rXxylq76RP8MlbmoVktu3hmV+0fDbrIUCfUvudRK45P0GNP2VLPtRo2PzvER3
X-Gm-Message-State: AOJu0Yz1HThTmr8UOzMlrRPkkznXQN1dUy6aXmn/qY72qL57ocK/tmFN
	FZs5PbAx0RGl+HnueMyRN9TjVCv2gUUKJ2AIh++AVO9AA64hctNQd2yAh4DOLL0gNTGwc3seHNJ
	WPFzSWe9JmiC8hTfDNuIvRatpfSn8s0hwhgdh8g==
X-Google-Smtp-Source: AGHT+IFRdvMqwnaaR8cmizGpd3HnNZS5sihGiiwBkO1giU7j3tM3LeR+KNWh/P3+PouzbuRNKJYHM9i+w74yRiGMJL4=
X-Received: by 2002:a05:6102:442b:b0:48f:e683:7b46 with SMTP id
 ada2fe7eead31-493fa15eadcmr656628137.3.1722016114971; Fri, 26 Jul 2024
 10:48:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142731.814288796@linuxfoundation.org>
In-Reply-To: <20240725142731.814288796@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Jul 2024 23:18:23 +0530
Message-ID: <CA+G9fYt-NsFzBhULi-JqQLXSKO123pAvrLTyGqx2eXeLyFJ3yQ@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/29] 6.10.2-rc1 review
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

On Thu, 25 Jul 2024 at 20:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.2 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.2-rc1.gz
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
* kernel: 6.10.2-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: bdc32598d900724563b4f84ff564b8b2273bf298
* git describe: v6.10.1-30-gbdc32598d900
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.1-30-gbdc32598d900

## Test Regressions (compared to v6.10.1)

## Metric Regressions (compared to v6.10.1)

## Test Fixes (compared to v6.10.1)

## Metric Fixes (compared to v6.10.1)

## Test result summary
total: 257000, pass: 223352, fail: 5079, skip: 28035, xfail: 534

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
* x86_64: 31 total, 31 passed, 0 failed

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


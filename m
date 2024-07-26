Return-Path: <linux-kernel+bounces-263559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC2593D7AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A80281746
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C90317CA16;
	Fri, 26 Jul 2024 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQOwzcf0"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B30748A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015200; cv=none; b=n+xRJG1wrLrjoKOJOiMVjajMFY20ESOrSBTkEtaDhloZeuwl+rZ+WPURGNIgBqGsxMq8AwwhUI7mmG8+PTcOhS0TSpayk3AOOxDficXtD4EST3wluXPoo5X5W5oAamP7KrdDnWEoVWWuPG+JbYxn91U6Sn6M19SmbCZzxxnR5Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015200; c=relaxed/simple;
	bh=9CgK1Ue9z+VUAagKzCIPsMBjEzs7eLVbbZi/4euGvjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOAvcr97pjwTH6yqSxLma86qofBDwB47oeMJN02ontXZbBru+RrmF6V9mrvYwJeOEh5J7Lqjjx+XIj3ebWZYt9kmF1eleV7koY6eyXBKHH3Or5n153mSR8mezaBE5FxH1R0CwiFh1W6Zx+QSovGqlLeoE8N3xyFxrLB/ecE0brA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EQOwzcf0; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-492959b906eso791892137.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722015197; x=1722619997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqsc7KoNh5LaQFIPWsU8Ii5R2mQ1JpnvCyqvzMOylK8=;
        b=EQOwzcf0KUHpJG4NP/DHdFhdku+F9Gxw5N0FZgdFkub8QY7m3NK9k07V7lBWvqfmIz
         Gymd6CgXOIp+ozknF1DJRNz3fhnea87LMU2s+ucbkaITM/Ff0dcpD/D1Pz2CNdE0fK1U
         +h2gV3spBAa8vYcetLYwM71FuN/zx2PCWFSRZq0HJatkrPxgp7KErd55b0JdIJiYU68H
         o7VFc6Hg84GiUtCXw4Y0wzbWdOpfPRgGjp9G32Jp/LAzWA59BH+M8T550isMx3Zcrg+k
         sMcZ22GOXmdsNS9XG1D+uIvfoAsXXT8l5bB4jDXY+3/J0oRKyCzkbJtWVZYRewFCsdsy
         0f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015197; x=1722619997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqsc7KoNh5LaQFIPWsU8Ii5R2mQ1JpnvCyqvzMOylK8=;
        b=rfeYhDeOITvzArIQbVnXTPsrXNGTCJDRnA4wHZTVMla8g5ebjH2guqmXw3/hC9yOFC
         FrKEyDoF76JytkMJ8VEC3mQ2yMhYYG7KKhzZEMjecgHo7969ZFlLmV4lqUyO9DJUrRix
         l8MvnhN41O35IbvQCgTd2fYm7iCohDPym+eWqStkIOmjp2mnrJujHY6hU+PWDxYAvyN/
         2pH4I0L+mqbhhTS78yH9lxrAF97HMCwuYlGgoX9BpF0wsQ3o0XHcbXm7S+3y1DFQ72j0
         iAWmDI5CeuU1x6sTZqF3AH2y0Xb9+4QHBOmgLMgd9xRrI7GLM+8qsf4g0lPKX9jhS/CP
         Q6kQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8eRetr50zuAyG41RrYdoO+buyG6bWu3QhepBt7VBpHEEZNbwne/00rX3v3mpLM+Zvi0Y1stpjQVFFi5NMr/0mpS2Xs/E+4P3oIuac
X-Gm-Message-State: AOJu0YzTpspjnShkI2n0dyg34qYHJjORf9sLip7Te548bIMtmYIn8+Yu
	HKOOJZrFZDeOQfWbOt9xhFxtLtpoNm/HdNHrb5kBwXaoei4bM/7Dyyq2MQn5zUFdnldW8nTwpz2
	/74IAGdgPqsQatijSGTLuNejyYr0jbD0Ggi3Ntg==
X-Google-Smtp-Source: AGHT+IFNC1lguyEpatVtrcm8FCHBK7XQaB2Y6jWPiH1DApVuXYlKniVVzU3PfXglDRl6FFTFF12m1/pdl8xsVTMXF5g=
X-Received: by 2002:a05:6102:358d:b0:48f:c062:75ae with SMTP id
 ada2fe7eead31-493fa819b11mr488034137.8.1722015196600; Fri, 26 Jul 2024
 10:33:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725142733.262322603@linuxfoundation.org>
In-Reply-To: <20240725142733.262322603@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 26 Jul 2024 23:03:05 +0530
Message-ID: <CA+G9fYv9MqRUxoAaUsmi6Hq3xp5LT8vFyG+ZovgaNwcPowy1vw@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/59] 5.10.223-rc1 review
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

On Thu, 25 Jul 2024 at 20:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.223 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.223-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.223-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 0f0134bb137e987ea2c432d03486a58a70840903
* git describe: v5.10.222-60-g0f0134bb137e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.222-60-g0f0134bb137e

## Test Regressions (compared to v5.10.221-110-g3fac7bc30eab)

## Metric Regressions (compared to v5.10.221-110-g3fac7bc30eab)

## Test Fixes (compared to v5.10.221-110-g3fac7bc30eab)

## Metric Fixes (compared to v5.10.221-110-g3fac7bc30eab)

## Test result summary
total: 90841, pass: 73287, fail: 2151, skip: 15338, xfail: 65

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 25 total, 25 passed, 0 failed

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


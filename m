Return-Path: <linux-kernel+bounces-256005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07409347B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A69282B78
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BA14D8C3;
	Thu, 18 Jul 2024 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhBDbOKt"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F34501A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721281380; cv=none; b=TlO7GXVLTa4oCllWGTC1XFjYUAYbC8L5cQFT8G8N+D3WdEzcnEaNBqNq+d+DUvCB5GYQQaYzomnTqASbOY97omVkCjCfZkOs/BjLt3DMDi3uJPy6iwevXwYZbrpTdMfYd5afnrST7B9QtW5/KD0Jhax03aCqoCTkb+SBVb+COng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721281380; c=relaxed/simple;
	bh=r3xnGagx4ZthBzuU0hwQn+oAgPu79TSzpYSUUD05+9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aN4ftQpK+wVmqtkZ6npgiEO6v2/tZANnVGfAUzyEGgrowXFVna4fJADFfo10/D/sgRMn+UehBhCpwwCQJQtEe1ybsFpknkbwJrbeX/TQ1BK8KWJX8B82Oo6pxO+eiwmTomXAgdzXA9BJY6p2VePoGCVmnjR7I/M9JdbTcP2ZZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rhBDbOKt; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-8225a1f4d5fso138705241.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721281378; x=1721886178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtOloMrdbyKRqwgvMAtslxCxX95F2NZOqbDgAe7suXs=;
        b=rhBDbOKtQlIpcrhLk5QyyaExZPuurHAzoCOptInXf9kaGgxKZ2NlxZqWJSFDdIWv5P
         AbJBHXx3nEi4D/vIOjTXBromxokVCUnjgA8y59kjfKl+8ie/BS3ELunt97WpiDwLAXdd
         OATopgdu8DVZPk3OKChN8EPK/zomguPwqLJVLm7K1PCd5qxZdMdlQHO3FnXKuU59BscY
         3WvVtMrjn+BwRWep5jDpPpzERxm5v8RJulEXj2o2NQ9niHVs1PzXI+ecydWbIsTWl1+L
         u+D3mx056SIFxQ0Ge92KhcmOjDGaAAN11mKF31UCtiiLWZKFCtkHC2t/12ckJQcz3Xvf
         LIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721281378; x=1721886178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtOloMrdbyKRqwgvMAtslxCxX95F2NZOqbDgAe7suXs=;
        b=OTiOrjCo11JpFq66tuWlBnpYC7tBuj1uxAeLVZokxzbKyvfO7KQ5lQM93DcaU9JKW0
         VzA8Oilz8sV/XA2J39qml6VSBQ5oa5zcU+z+slKukIqwJg/QW7c2bK6jwNRIHlbPvEqw
         NfVgoRT/0mc4frHeoKOAhlccFeJkLNmp688SlA0aKQp/NkVfX9u03u/fRzH39BZqVv+W
         Y6pyf4FAm19R6Ft4nvtpEp/OuZCHAs/WvGhTopIVmL1HgDJDoyYrXKlqEpf7EoJ9Avoa
         GTIr/jHt1Fibx6MCnUuSDgK7dfCrStAi7oULYOw6xGf0k1qJGqd/Eu/2e8KyHDr1ivot
         c3HA==
X-Forwarded-Encrypted: i=1; AJvYcCUu1VEK1Ez0QZXvxlPtgzFjJcpFtrwJhRNcdtWOt1qn4rO0XrJPdikVOiCJH6Rrd80zPVU+HDdx6UIZttjGJZNoqh+MqTHe/5WLb6In
X-Gm-Message-State: AOJu0YzdDj4oL/MOVLDEl//JGhGjSfzwQ79jnQJHbOm8ZbWCEBd/XxhI
	Ys+YKSgLqZ9oNfmgImT5egfJ5ALgMwGh+3qgW7sJDfo5y5NOQwxtWSBVWOoEm0NQjv80kKLMCCT
	mwbaeGf+lt7B+G1Tq1LFQIrEEIDt/2YmBuwwrLA==
X-Google-Smtp-Source: AGHT+IHo48/VuA6FA9O3qJYr3auC1eNUX38955i0sshhbnmGFehMSpwIFcP0A8sEQi8qZL3ZFWo9Eqff6B5AEaQW5HA=
X-Received: by 2002:a05:6102:149d:b0:48f:ea84:4837 with SMTP id
 ada2fe7eead31-491598b5136mr5536906137.9.1721281377998; Wed, 17 Jul 2024
 22:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063752.619384275@linuxfoundation.org>
In-Reply-To: <20240717063752.619384275@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 18 Jul 2024 11:12:46 +0530
Message-ID: <CA+G9fYsf5d4H0Tme9D+aqAchpHo_8Yzq7EB0xZWb2CUbNByCHA@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/79] 5.4.280-rc2 review
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

On Wed, 17 Jul 2024 at 12:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.280 release.
> There are 79 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.280-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.280-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4fb5a81f104646353fb38c79e16e02395338a782
* git describe: v5.4.279-80-g4fb5a81f1046
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
79-80-g4fb5a81f1046

## Test Regressions (compared to v5.4.278-184-geee0f6627f74)

## Metric Regressions (compared to v5.4.278-184-geee0f6627f74)

## Test Fixes (compared to v5.4.278-184-geee0f6627f74)

## Metric Fixes (compared to v5.4.278-184-geee0f6627f74)

## Test result summary
total: 97896, pass: 78819, fail: 1682, skip: 17324, xfail: 71

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 132 total, 132 passed, 0 failed
* arm64: 33 total, 31 passed, 2 failed
* i386: 21 total, 15 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 28 total, 28 passed, 0 failed

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


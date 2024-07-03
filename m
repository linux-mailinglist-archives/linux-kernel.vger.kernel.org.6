Return-Path: <linux-kernel+bounces-240022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71023926809
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947B51C2131C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004F18754A;
	Wed,  3 Jul 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llSk4iQD"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324017B4E8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030970; cv=none; b=vFPeBOCHmmj/WfeybqrAzIaemUeCmYsVJaQmNPlQ395ES95AlwVsR2lcHzXkbnMtZhfhBGiaxBl7pp/m9zf27egAfQyTvsw1xYs9uwG2HldWTdaVcx+DNjLkEalvlQw+OdS38sTJqHcdzFapRhO45OCrJZi5WPdAZ4GTtvl3dZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030970; c=relaxed/simple;
	bh=/VpfopDdBJqybxcmcYuCrbmMEGO159jxoReMIiv7UxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+iqJWmYddPTTPXDv5Z5QJ3OBZEzwtjDc4RFXOm7tVbKQZbzdBcVQwZBVmBksVTXFwRNPv1Fz0iVDTKiikLfQ3cYDwX0Tx0JnDvXSU50UWe/j2SEX4MG04/lLdG1fPfd12pdnny7iOqvrWXfiWA5RGN7WiUIYywdAnQum1jjkIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=llSk4iQD; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-80f8dc709eeso1166555241.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720030967; x=1720635767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lutnZZkFQNrPT1eWeDjIvCFMR4EQlZRCPH9vYtM3N5Y=;
        b=llSk4iQDCh8RWzORTtn1vGV/XbqM4H4IHGVqiBbM0fC0Bos8IslUwV/qJJ1AlYSOtE
         r4Stg/D7kfCuu7OiHL/lk6iX8UQIdFIw4piizW2h0rdkO7gBE5l5mFkXqOXsp7jyZ3Jt
         BEugU6sDvKiRE5UkUC30dWqbl9Ys0J/rT8+LGphz5wYU3lG64FBv8nJT6pV6O4MmrdAQ
         7HEJfuW3fS/MQwkWD4QeA2dyf0fy4xbcnz2L7SoW3zm59ca8j59bMlY5OYE2ej4BUqu5
         rA6F03goao3Ui+RZokTY1F+dlUPTtNk4cj1eByhl08IHeEI4VmLx6Iknz0XCiLtUjaW+
         xCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030967; x=1720635767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lutnZZkFQNrPT1eWeDjIvCFMR4EQlZRCPH9vYtM3N5Y=;
        b=YVaFsHtzi85xhY8oq4NJnz2YIHceo1d+rBYfhejjz9hbIxmbcvM0yLA2hrncxn7+OW
         oqsSsDqyL2XGZOa8enbPhHB1eWSflMNPJWwH1UUr2A1DTOXIILAHHlOdP5KgE0Xdfs+K
         E+JvM+VUP17V1s1mJlRQc/DNa1Sct+dKSekPKWx+26Hbtsc2GX2ykKtI41b5X3ZeTDje
         Z/xiceBPo64ejfAfc9b+xbEgAZdtBVvGJCXC/x0BZRhgniFAR7BtVDAhp7bjbLpG7evV
         gSzCws3W0iRcdeRFxRpqo+Zeu/rX8H1SdHnDoxhjGfWMCpaOVE3KnGXjsJsO+cktnxUi
         GMuw==
X-Forwarded-Encrypted: i=1; AJvYcCWDACJOZ3qDOCF57Uyp1BZRodMTE8wsZsxLGIVGI23kggNLknywl0RwaHi1tPDF22/2zZz6hd8y0FshqZ8auR7ofBrwj3DP4GXJSk3T
X-Gm-Message-State: AOJu0YzxKL0nGSYqF53weoQGcCo9VaRZL9gG7jRxqjhirifww3OATCDx
	F6dvRR80VQ8OO7rYcJp5cqm87M+UQOlAmKTDeds6T6nGc/bjlSDWyvUv2fpYGqNlItXej3ifgUd
	TulewegUVaZMp4LyquIGHdhEEpdbNjJLN7q48SA==
X-Google-Smtp-Source: AGHT+IFpo8fAUFUxFe0XR29oyqi5sap+b0XoPBzzgzJgzGnPTgyl68a3ag8cVeM9fud5rxa6d6z4HiMdoyBo7onLUX8=
X-Received: by 2002:a05:6102:549e:b0:48f:1bc6:345c with SMTP id
 ada2fe7eead31-48faf06a80bmr11310839137.14.1720030967212; Wed, 03 Jul 2024
 11:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170226.231899085@linuxfoundation.org>
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 23:52:36 +0530
Message-ID: <CA+G9fYvvPTUkjTukNZ+Y0Cm5QdHocv1qHFzZkkB0mL86yPj1iA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/128] 6.1.97-rc1 review
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

On Tue, 2 Jul 2024 at 22:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.97 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.97-rc1.gz
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
* kernel: 6.1.97-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 54f35067ea4e1147c1351417237ab846a0b37ed9
* git describe: v6.1.96-129-g54f35067ea4e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.9=
6-129-g54f35067ea4e

## Test Regressions (compared to v6.1.94-218-g0891d95b9db3)

## Metric Regressions (compared to v6.1.94-218-g0891d95b9db3)

## Test Fixes (compared to v6.1.94-218-g0891d95b9db3)

## Metric Fixes (compared to v6.1.94-218-g0891d95b9db3)

## Test result summary
total: 223345, pass: 192480, fail: 2666, skip: 27820, xfail: 379

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

## Test suites summary
* boot
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
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
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-test
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


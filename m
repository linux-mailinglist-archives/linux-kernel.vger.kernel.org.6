Return-Path: <linux-kernel+bounces-577204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C3AA719CF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0383F3AF9DE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AA21F94C;
	Wed, 26 Mar 2025 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uox5S6vi"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5743D6F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001366; cv=none; b=Rt86/I6OJN2H/2hp0hUBFd8R3wUD6lX8bc9X/s65ZDj2XQYd1KGVLe3eA7QFn0wL4Kn3pD5jK4cS+0t5+sZUZg7y6mkrV7NFQ2iDEJVDklXl7KS1ElsIokhFIOjx9S8JpiLaGuySg2S3ZHXbHBUS47rJY/qaJhqB1ztG+rCKu34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001366; c=relaxed/simple;
	bh=i5hMjU1U1CkBVthPy1e8u9OZ2c98Rx6n2+cQ6fD3/LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQbJ8N6XLA9UJ4HhOLM2DBT38Ixf9JlaGei2MGg1TN0M0EBJx02yBhdgPkEBCSS7T6ALZ26qj+b68zMGet0uxpmLim21ySIfujidoWdTUzyFoLtEnFBfz1VgP9YwAC7q8AkmZ0SNiy2puzAikeRjdCD4oo/4r5euNasCPlQ89KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uox5S6vi; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3f422d6e3b0so1883831b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743001364; x=1743606164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsQsH6ANdGylJ4qh5rKlnocfjpKm1sZHbMXP7G2f3lY=;
        b=Uox5S6vigTD5AJnYOiVhKHoufrC3S9Puy09KDkKYY4ChxMxk606ZWj8Gc3lqvOMfCj
         ZE9msCd7RYSCJHEDnNWmpL9dqJkmGRM0DHBU9s+9UwH50lZZ5lpJPjBHZNnvuJvHyan4
         2yM950BViAFhwbWS0AmAvCIKzS4jFrPZy5wm3dTbkiQr6oQYi9JVk7GhSrjxFHDO8Suk
         s1xUPR6hWhiNeAWuYIPmX3vub5gPlm48Qb73eN2VxtiqubE59WfX7Vcgi2Xlk3Bxipwn
         91FtO8zg9ZwzcTsRRZNy0mHQWA2lOayUd3I7b1NMMRCaMlVftp+7m/EjnnL/GtuBCnAj
         8+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743001364; x=1743606164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsQsH6ANdGylJ4qh5rKlnocfjpKm1sZHbMXP7G2f3lY=;
        b=lP0z2PeVbUeR3AGs+mpa/xknFVe176KoZ6d9P57X8RZZapRbyq9JF8OpDf7ui8jDeU
         Tp5AZ9Td6vZvgfcJ4zPIhgTgfl6bvJz/DnHOzHU6Mq/cqYjLjFpkXhjvHMS0AYREWFX2
         ovpd3bMVeE9Q4lAAH7pU4uTiybNo9MamUALa1xmsfYz2lxx2HiY9wSDruFcmO1bYzA2U
         ONNK6KtbJgzglsnXhVzMHHHvudTmotNt9pFhbxLcPyfHfx11L9wVGCWi5XUnPatQzUPq
         nnpRS0ReAcS028Zr+tKI2jGfpjPJrXK1d+Haj4cDGRIfduHHpb8PvB8dlpWsosVUi8nd
         kGbA==
X-Forwarded-Encrypted: i=1; AJvYcCXwiVK50nolLMDIB2grygw7PlWwG4banCE4L9jBzjSPoo1/57c6/qzSuHgt9WfmFlUvrjHaKfx80ZqMU34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2L3HS8SjNqIsaq4+HUzHgJFeW42x0rbhy9lKSU5AGzoHaHXqn
	DcZ4K6lreZQ3Qcbi55giGGvIyPvui0MUT4nwG8vDdDQnjSXZhGVBY5InC4A1GcgcKmuker2assR
	hqw67SloHrMfaAQE33+OPYXTxnBdZ0NY4/i5fZg==
X-Gm-Gg: ASbGncssxt+fRDRyaD7NiKLShHf4l9WNjFy0cYGRbVd6pnFON6+XjDPsIYT9+i7tj4s
	1+SQD6ZB8z4CKJmEBcllsrUW3NrLCcj0iwyntW6gO039SLvZvHG3mPc0Exji7gtpsWmsa1CRpxu
	GLyFu7Nix4XarvdzTE0CFDlj78F/Dx9z13PDJ1yy82ii/yo88TAxLpcYOxX5Q=
X-Google-Smtp-Source: AGHT+IHdcefyjBpzy0SXc/gjf6ixzyEAvMSxlQARHmWO0KujbdT/yemJQiyccWHif1y+OoGvmwj/eDGDDvZ15smLS5c=
X-Received: by 2002:a05:6808:189a:b0:3f8:7c69:561b with SMTP id
 5614622812f47-3febf72652cmr12310211b6e.14.1743001363865; Wed, 26 Mar 2025
 08:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325122149.058346343@linuxfoundation.org>
In-Reply-To: <20250325122149.058346343@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 26 Mar 2025 20:32:31 +0530
X-Gm-Features: AQ5f1JrWdvxkbIUeJHzGZu_R-JluYE3DALzZRXxu_gTDRsdp-_SvEVbZdV9RPOA
Message-ID: <CA+G9fYvOjHPg14GCU4kLQF+PukgjsXUAY2sLCB=dwYMTa3iRmg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/119] 6.13.9-rc1 review
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

On Tue, 25 Mar 2025 at 18:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.9 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

## Build
* kernel: 6.13.9-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3d21aad34dfa8c234590743dfbe06d6bdf633301
* git describe: v6.13.7-362-g3d21aad34dfa
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.7-362-g3d21aad34dfa

## Test Regressions (compared to v6.13.7-242-g14de9a7d510f)

## Metric Regressions (compared to v6.13.7-242-g14de9a7d510f)

## Test Fixes (compared to v6.13.7-242-g14de9a7d510f)

## Metric Fixes (compared to v6.13.7-242-g14de9a7d510f)

## Test result summary
total: 130921, pass: 107776, fail: 3814, skip: 19331, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 57 passed, 1 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 43 passed, 1 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 25 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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


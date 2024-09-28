Return-Path: <linux-kernel+bounces-342447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4327B988F38
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D5F282214
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A6C187FF2;
	Sat, 28 Sep 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8ZIn3Cx"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6285A1862BD
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 12:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727527189; cv=none; b=RtDwVp/79MzANPjQ0yFr1kLIpOxyjpD0Cd0vRPkFkQH+NvN3kuGOr3mfIMuN2jQ6HE6yy6AAB27Q1W0XZHjHdoEtWiRvllfchZp/QlL1xdev7SaRxWgOjsKMTvfKKtQZhwQEM4TVVR8WS7ElVYyJNima+ldOqpRgXvTzvz/imGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727527189; c=relaxed/simple;
	bh=Jd2f0dlDcPMOFbdqGDhafd2lnXj21geAWRFPp1RpJ3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+pLfkQi3sKFIkt7AeXavWsNuoc725CIUsAFqUXugvNPprF70Cc7b3BS5nqW4YyH/D4rBOtbLLQsDCu4dstWmBUlEpMQ8QUcEvcAejTririvAWF+8+uBVFWGiMstnEgjHAiz+a/VRyRUP0k+rLQdQ4rUsWyA/auL+S3jR7tkSic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e8ZIn3Cx; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-84e85014badso946669241.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727527185; x=1728131985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1l4GbE6hWpgjJgZXEVqIt2NtnbNkJOGS31/1kVeUq8=;
        b=e8ZIn3Cx0OMYc9rvb7RBB2NvfUDesiregVjY7/ec3Wdn4sA0L+NqIPLMxgTbJPXQYu
         zQztkWRO0dWDA5NgfaVpQi3dqK3wWqiOiuBdDd0XRJGOy6aVg4AZU6wOwxzMIge001kR
         Mq/D4GHs34LHNpt72tFb1WZHtqI/gyH0iiESyp+xxTyQkGh8TET86wPlfs+3H3YvjHHq
         HfJVdZe9/ggZo7Pe7D77+ihiaVVLXwGPKJTTtbfbkj5XZOc6gPW7JHXuQ4oqEjMmFsda
         LUVDRuf+UA5JJTc81WcfXBsC3TrH7f/6attapcKWOii3SPhrAijIADcBEp6PFYg6O9XS
         CnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727527185; x=1728131985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1l4GbE6hWpgjJgZXEVqIt2NtnbNkJOGS31/1kVeUq8=;
        b=vvkgXQ2csHjx5D4UCcFGCYS/erzew/UQXr1E8zXwN5EhWfq32bxtVIkmsq7rDNlfGF
         7GTPHGburztamP+AEEfz/OMa1rFcFIkN/9dADPn/i0CvbET387NwfTRuNBAMTflcAv1k
         yQ+h9DPc5e+/9130Wtss/1tzNQRnQXqkQB8laPaNL0Z3MU+jC1Sjr5jYVHgs4pVAEOGo
         ZQifOdk4w6+IoP0yJBw0W8y6yB3Gh3fD1wRSCM6Hd3TIZ5syo7dHAhDc3rMoaZZlgq+s
         HUSxHsmUhU7EJVbcTlULrmZgUGh71tiaTL82M7YHQor9+Ot6bF7oF1zvsd1WaUvYjcuj
         GW6g==
X-Forwarded-Encrypted: i=1; AJvYcCWmKYfrBWn+aBq0STxGiz0pIN/pZJwkpk5jUCeQeVsqsGX/wmaqK+1y5yiOynMOyUcl+09hQwHSzXL9lnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnq/rmznPfYgFQYPP4a3l0TfJlDFK1PCH0WEvFyQKj8lC08CTG
	Zfh2q87nH1d31pfDN2QC7ekvfK5fO/8BDTRfVDqUU0mUHkZ0Gxq/f9eAVOJrJv5hDqPRDicuoIy
	c0p3P+h4MnbmxhElEoYzD6AtgEAf6qFvdKiNUpA==
X-Google-Smtp-Source: AGHT+IHrJ/aX5w3TTLreZp6GtZMKWertuN3NS+/aHPuhBEZcF46fPwpckAVPGWcEarhi0ktZEoS0MirMF2O/RFaYqgQ=
X-Received: by 2002:a05:6102:cc9:b0:48f:447d:7915 with SMTP id
 ada2fe7eead31-4a2d7f48a84mr4704207137.15.1727527185128; Sat, 28 Sep 2024
 05:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927121719.897851549@linuxfoundation.org>
In-Reply-To: <20240927121719.897851549@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 28 Sep 2024 18:09:33 +0530
Message-ID: <CA+G9fYs9Z-yukxgVCVwgOKM0Q0N0hZecqYhWb9BNsrzeU8NxHQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/73] 6.1.112-rc1 review
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

On Fri, 27 Sept 2024 at 18:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.112 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.112-rc1.gz
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
* kernel: 6.1.112-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4f910bc2b928f935a8a8203ccfa7be8456ac8f29
* git describe: v6.1.110-137-g4f910bc2b928
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
10-137-g4f910bc2b928

## Test Regressions (compared to v6.1.110-64-gdc7da8d6f263)

## Metric Regressions (compared to v6.1.110-64-gdc7da8d6f263)

## Test Fixes (compared to v6.1.110-64-gdc7da8d6f263)

## Metric Fixes (compared to v6.1.110-64-gdc7da8d6f263)

## Test result summary
total: 146051, pass: 125727, fail: 2019, skip: 18116, xfail: 189

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 7 total, 7 passed, 0 failed
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


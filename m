Return-Path: <linux-kernel+bounces-289314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AB79544B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8551F233D3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B5C13AA53;
	Fri, 16 Aug 2024 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EXfZY+eJ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFD3137903
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797958; cv=none; b=q2SNI4uoHsJdoqnFN0uwHlKBCz0cyEePEJB6QJXesMnq2bQbh6KdvFMPTrno4RkKeqd65DGha8cGiTpQKy9ibcejWc3Qzi3I1Gss0IvY/MWAS12dx4n+F867GGFYv6ICWtFyqcquASVe63R6JB+74KmEoy9q3zqChLkd2v+r1LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797958; c=relaxed/simple;
	bh=l/cqChJg/Qri4UK2uKbK3Vo1Mya7dlt6OUhrF+Ts1Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJjxoTaKuCMi2RPDTAaZ9vxWnGUkncgWv7FA8GncLHftTI1L7loweFR2YeFPxutg75ozFUkZlmVqzlhV6EIGQiO10N+lomyUygXPpZpUdCC/z8wNO4XhPPBBeH4EVYoajupVye2MuUErwJ3cgIVP8Cy6ILLlJDfi9bV+btAAS+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EXfZY+eJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7aa212c1c9so214242766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723797955; x=1724402755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJckoRh5CnaAaQkEaSAtT4W0I5ueEE7s+w6QDeInXtc=;
        b=EXfZY+eJew+YTKgcADP8BKRZryu6p6V+Ndjt9HihYjNF21ViZFx2OwzCKdmh5VuoGP
         TZHGhqHrZ3eyOCJCCsDby1i4JiTYufm4wbRwCrzGe0ujDjjFTbLjXbUD/7ZAprbBvkfO
         mGz93NQpTcsXyr1dHdsn5n7Ei8t7j3C5gN2JVfhTkuMOGYGHPjx+XicvgKS5MRzVLzOy
         Fm844go8fCnA6rxBOtvzj8L6vASlnTfmDtYpIWc44PveI4DFdG4R9EcBdjLoZGdtLPXX
         QAS/w1PUDmRrUM1M4yvqv1H66NM/FgGGJCBTymsIiU7R6NHTzhTbVQ2gzHdWRwh8Xdly
         liqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723797955; x=1724402755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJckoRh5CnaAaQkEaSAtT4W0I5ueEE7s+w6QDeInXtc=;
        b=i5GaRv0GFdHI7W5BENmAKXyq0Ph/9qwKGZ2kBbMItCb5eJqKEiuq28781lHkcVDK/q
         Kvguh0VT8Vbv8gXdyAIM58+mOP6/S4ouEva+rFpJWBcpfy0+hK8Qya3zCv0OZ+nKplVn
         08V7G0d4akKUDC0Ch+G5zNtuAo/0rqJi0mbK/L+tZQmWMuU3aN6QVTOXHvFPmVvwUSL+
         ndpGM1VdENzDeKL8xYk35bWoITsaHYTdS83sZjb1FSg7xnST3TVCg+yy6OQ6lmJnsbKi
         lKZ7UKu9J/SApAPj6839Z0v8QA0mkX8PaZcIjgOOjFJUBTpYJV/b7kxltifidaOlsFS0
         7JlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWViFHVUmtzvSnp40KhL4+uDKbEHUyyTzjYnUd/zYCxiJO8m5gbNgebofYNJeV5mJ5Ewyac0dxVgwyvn2J2709FHFVk2YPifnFUj815
X-Gm-Message-State: AOJu0Yw6RAHVrQE1yWqhP9BEKPNdzt8cZO8Twuoi9m0qMIebs4TsLvsO
	PNZ6MZQq/ZZdBVbEq0XeOMNtKlkb9LR49F+33TMSYbkg88S+wg1r0Q45cWE4d2+5jsxqxSGMiQP
	UFLChtww0F+UU9DgQBxyl05CAdomm8NYlRsj0UEgHhgNnmMgZH+k=
X-Google-Smtp-Source: AGHT+IH7RfoI3zCZ18l1bcOSWl0DD/OyHznDjT1xZTI8Gokc7IBOc4WLg21syXDGg7iJYFGi4t6uaJxwgE/Oz36dr2Y=
X-Received: by 2002:a17:907:6d12:b0:a72:7245:ec0a with SMTP id
 a640c23a62f3a-a8392a47243mr135538166b.58.1723797955238; Fri, 16 Aug 2024
 01:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815131831.265729493@linuxfoundation.org>
In-Reply-To: <20240815131831.265729493@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 16 Aug 2024 10:45:42 +0200
Message-ID: <CADYN=9L-zL+r+K-XwMGQrs0AqOB8F=k-mE=ULxv+z_DpCMixAg@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/22] 6.10.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 15:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.6 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64 and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.6-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: a812f2032d1ccdc36ece9248c14ac3ec8a936cec
* git describe: v6.10.5-23-ga812f2032d1c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10.5-23-ga812f2032d1c

## Test Regressions (compared to v6.10.4-264-gb18fc76fca1a)

## Metric Regressions (compared to v6.10.4-264-gb18fc76fca1a)

## Test Fixes (compared to v6.10.4-264-gb18fc76fca1a)

## Metric Fixes (compared to v6.10.4-264-gb18fc76fca1a)

## Test result summary
total: 246703, pass: 216815, fail: 2082, skip: 27407, xfail: 399

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 127 passed, 2 failed
* arm64: 41 total, 40 passed, 1 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 26 total, 24 passed, 2 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 18 passed, 1 failed
* s390: 14 total, 12 passed, 2 failed
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
* kselftest-timesync-off
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


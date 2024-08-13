Return-Path: <linux-kernel+bounces-284178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4EA94FDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27B41F22E22
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118443BBFB;
	Tue, 13 Aug 2024 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zalPNQyd"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78020433CB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531062; cv=none; b=kZFIbDDsXuNgwxK6tEFAF8Z0i/rIH5rNVCeiomfZie+mCI8tY6SVAi2Gw9hn/YA1iowWzjGaVZWupSZJ4fsTTYbLh0nwRAVcMZsu8snlSixHeUNnIaDzBetlM5qdn0o19Gpvj6e/tyXg8rESuq84UvTtLrsnnq0wXlN4ZI/YWt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531062; c=relaxed/simple;
	bh=575e9iWW7nVzsNnISGsVET3xlrP7uHg5pfRLkBr0wKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukcAuhEpYgiPeZ2LOGAhROVmH0s6fXYWXywOG2imWuzfph3Pc2XBUs+gTZPbBaTmhTWDBqNhNBa+WPDBxqvLY2/xXbPuGjm6bah8yW1d5bUT6t5N8r0X4YusO5i8eoAgs8/QdjV9WfK9Pe65kYPHa4TDgyc70jGyEVfKuyn5ltk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zalPNQyd; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-49297ff2594so1964060137.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723531058; x=1724135858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Uz2Jmkcns8d749Zb3uEheyiW3HdBXWgL66GZJZE6ys=;
        b=zalPNQydwUQhZc2NPVV2lUFrfBWJ0CBbv0J5AYk0yMCrygVxumbbipMXTzy3D8FBL7
         x0ZeWJHgdUJ5f+i64cEFdZyi+khKObCPPMtulFD6wAkzXdr5yeSzc18QeHZUWMCmmxdk
         FcWDs82OtdVbKixH8WaqCM10wW2zAVVdxAGzCOQOHTGjmSCYLaI0kbDfZCGI/I2HsKKf
         Uwxs4Agkbsdn+ODhVgLy1X5Eit1HzLnP7yAbuzbT2njDUJZryRjSAOQWyjgCDclub6MU
         AZzPAt4SnXVtrGxYQrzYZdJyLFGqkp2u8GERIuCmkPJxDwztR/DRrHI/L+HBatY7xi7E
         gN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723531058; x=1724135858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Uz2Jmkcns8d749Zb3uEheyiW3HdBXWgL66GZJZE6ys=;
        b=wyv4m4f5oT+59g5biXmGEItxnbjvzupAmiIeaR/42JP/kLU52xmNvFTVrzLUCg8FID
         mT9Vv4+1e7cKrzout1EEcZBtw9gw4lDjzpv4mOuA4kX1oKauA6CfUVV7zhtyI3zpkoLB
         8Dm5XD9hjyxPTsFVZjuZYntDgYxlIngy5q9hYlW6kyWbjQdzIEGQ0H7lnhC3eHzJ3rzG
         V05JwFo52//8kgBfNE3DeW0o1WnnnBhSgbrSK/Vs+H1PZI3wNTdC0dOpxylW6E7WbdZq
         ImWex85UEotoIAtsIo6ZloAl77EUOc+2oltSW4uckPxnDSQAg7bkRulaKp59kWKoEK6F
         FzAg==
X-Forwarded-Encrypted: i=1; AJvYcCWZZuFFG2ukb5a1QRRhlDUAX8YwGFVxkcK3N2j4CghUNmpCid7VUu6bEJPcw7YlYBef+Qg8FJNr3GHeq5A/1dtjStMALSJAmmOdwkPZ
X-Gm-Message-State: AOJu0Yy8cgnXOJnGM9Uw1dgzO0yzg5dCoPGAhSH/39eqaNENp2JiN7XL
	uufKiYZ1Z0OY8x0neKy1vzTBHS3/EDe3a22C5bJwgrGxG2I+5gE1z6cAkiDcjBP1kXhKHIY+J1J
	Lj4eX/aS6/VSkOJwkpskDZ2gwYo/Jg0+52ekGNg==
X-Google-Smtp-Source: AGHT+IG2ESwnitTYkOo+FWcD0VMQpDANASDmAv4xD5kcE/eORlZ/8BV827KZrPu2hYKcoCO7M7t0/kYVHpLcMQxKyfU=
X-Received: by 2002:a05:6102:f0a:b0:493:e66f:6bac with SMTP id
 ada2fe7eead31-497439bd960mr3103700137.11.1723531058330; Mon, 12 Aug 2024
 23:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812160132.135168257@linuxfoundation.org>
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Aug 2024 12:07:26 +0530
Message-ID: <CA+G9fYsPJQ_fFjrr3tXCeByq+jHG9yHbwC6W66eo_+J8vmuiyw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/189] 6.6.46-rc1 review
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

On Mon, 12 Aug 2024 at 21:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.46 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.46-rc1.gz
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
* kernel: 6.6.46-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: a67ef85bc6ceebaf7fd3d7159f070b823d1dfdae
* git describe: v6.6.45-190-ga67ef85bc6ce
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4=
5-190-ga67ef85bc6ce

## Test Regressions (compared to v6.6.44-122-g272b28faf61f)

## Metric Regressions (compared to v6.6.44-122-g272b28faf61f)

## Test Fixes (compared to v6.6.44-122-g272b28faf61f)

## Metric Fixes (compared to v6.6.44-122-g272b28faf61f)

## Test result summary
total: 188519, pass: 163267, fail: 2264, skip: 22632, xfail: 356

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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


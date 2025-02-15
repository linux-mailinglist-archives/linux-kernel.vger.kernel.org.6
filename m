Return-Path: <linux-kernel+bounces-516195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A843A36DF9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3363817112E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CF11ACEC6;
	Sat, 15 Feb 2025 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b/+w0UIL"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E319D06A
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739621541; cv=none; b=dn9pp19c4Rn2uBeRWWUx79c9iHOL1k5Aw+thOCcuPBaYbZuT3cQsnPEydALgN4i70ZpOJXPOjANeOYS6MobmGU3fk3xlk3510UKK/5lSrBVX6ZjlkK+1pVprBwA2rTrAUlHz5hC+siUQt0uE6Np99RNmkPiBDxLUE6nFoQKHl5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739621541; c=relaxed/simple;
	bh=qm7JqI8ig6K5eAnFPE39CQ1/XQZUUQaMrkJkh/owUOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdjG7EtA4vIqkna9KaY71KqmG9tVxuBC4DFw+hS1e1SK3fCE5KbjRUtVi9tSegSoXsFZdryQ7p5TwmMiUOYH7Z+fPe2Rm6a/a+/OtEEEKGM1+bJNo9w0xK1xIAixxeva5DSknPuBTAwIBlZOAus6t+xYzjsXTaObP5N9eYxiiO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b/+w0UIL; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4bbe0d2189aso868288137.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 04:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739621538; x=1740226338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzyW5lFbonLTH6dEaUk/CVs9DpxDfukUfwlAaCnLwjg=;
        b=b/+w0UILDazyQX9EQuetSbFsX0LGMSEfSX4g5Deq44xuevwDI3TZ6poEy+wP+yn9NW
         O6+0CATIA5ThpJJ+ebg/w57eKlmB3Jrhnksrg03rTozjR4KKOLhh2oR1cse7Xxpn8kQs
         r6MTbsKKxTelpw860tBt6V/QzIkw+iYlbYHVcl/bycrqUHcn/qOz4uDClFZBMylmkPeS
         Io3yurdVFAZ1lx2WX3IFPu/dy4G8YWMYZ6qIDfC/sA/Rky9QUDqe2a1uzATdSZGYHbih
         LJ54IqxNtZ/U7nPAod3jtuxl4vUtRQ8OQ2esyLtpKRz3+AzlmpvKW7Ie9VIVSBXXSO0q
         0UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739621538; x=1740226338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzyW5lFbonLTH6dEaUk/CVs9DpxDfukUfwlAaCnLwjg=;
        b=CO4CZMBzoZCYfOE+vTFHNFjHR5HXoPHW8AG/7bNmng5aSy8+UbHgye0vuPjp2+MrXs
         dE40Vb7p2yrNYJcr/cx/msQk3OXczsdN45JC1a/L9ns5wFxH6EVILT1nnvTuJGcIQCA5
         I/p640RqhwpIJMtHeTtKO2rMV61c1rcMXaN7ZMS0Mg2NwAm3E/RSr/f3XPOPNLBbIDEd
         8PCi7kCowYbg5lcv/yGY0mE0w/78RSQ88pnSnthRhkkLeSp2mequJ8SBWJpcRh6tmm4w
         iy8jL0NtWQjDMod2zoXg2tbQ0qqpfcvLAJ6U4QgcA7qk47nNtgEqJcQdOaESzvIx5lFe
         yPSw==
X-Forwarded-Encrypted: i=1; AJvYcCU145DgVEx4ITXff5Rcing0KleP0duzCxLrRCVaTZdCMCZyPJoV1hYRcQ/6NOgi8D29J9xtT0WqycrBO/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVDhLTucOeSjn4+K50n9d4Q7Ox7hP+X0WGf21yhH1VPws4u7Ko
	oCE0tjhySbmNwPzUweFC6Rkt0lqFKZtpEFcph2ankQzixfZXg10t2ekU2mlxKcsSnOKpcG9+6hr
	EY/FzEMfb7Wkd8WXyjggQPHST+kxsjeSzEVfVSg==
X-Gm-Gg: ASbGncsF30r7wioL3ceewFnhN88GiHeXDZ/6py51WTDVUhuecGEDgPCCwuVGSP35FxR
	/lEs615K+drXK0Ku3Jqkn3JICdGWOxqS0ETNSfHP5rxsLLhk+BXwf5lFanLDh84KtYyrmdOyVuM
	PupCc4G+GEE6oho8CJLyNeuEWQ1/KJY/M=
X-Google-Smtp-Source: AGHT+IG+qAaL9INIii0CYjn4sxooc4GBiJBUznHaqojYczUXsH1b2QBXbNmC4WxQ129FZ9ODjRKh+gTNEJ7w4OX7SZk=
X-Received: by 2002:a05:6102:3fa8:b0:4bb:e6bc:e164 with SMTP id
 ada2fe7eead31-4bd3fe8d0d1mr1766320137.25.1739621538337; Sat, 15 Feb 2025
 04:12:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213142407.354217048@linuxfoundation.org>
In-Reply-To: <20250213142407.354217048@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 15 Feb 2025 17:42:06 +0530
X-Gm-Features: AWEUYZlYUCeB6Xdq7w2fGkp4n_51VEaKcRaaeoXlSkD-V7Bi0gZgwQIacbP_7zA
Message-ID: <CA+G9fYsnK2+tfv3Oy6PoVuVDn52dPEejb68Gh7Lx69GyJzOS8w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/273] 6.6.78-rc1 review
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

On Thu, 13 Feb 2025 at 20:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.78 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.78-rc1.gz
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
* kernel: 6.6.78-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e4f2e2ad0f5f9ba880bae6771875ab6c3b9eb64e
* git describe: v6.6.77-274-ge4f2e2ad0f5f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.7=
7-274-ge4f2e2ad0f5f

## Test Regressions (compared to v6.6.75-390-ge5534ef3ba23)

## Metric Regressions (compared to v6.6.75-390-ge5534ef3ba23)

## Test Fixes (compared to v6.6.75-390-ge5534ef3ba23)

## Metric Fixes (compared to v6.6.75-390-ge5534ef3ba23)

## Test result summary
total: 56711, pass: 45681, fail: 1533, skip: 9334, xfail: 163

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 38 total, 37 passed, 1 failed
* i386: 26 total, 24 passed, 2 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 18 total, 18 passed, 0 failed
* s390: 13 total, 12 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 32 total, 32 passed, 0 failed

## Test suites summary
* boot
* commands
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


Return-Path: <linux-kernel+bounces-555805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A430DA5BD04
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0413ACAF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DED1230D0D;
	Tue, 11 Mar 2025 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLi5tZwW"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1222E22F169
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687185; cv=none; b=HG81RXHhC8xdIgJgJVDwZTJWKyN1bgbhF8PBE/gxQPynYDVJP1tEUHydDPaLQoGnaAH8T+OtaGJwZE/WuTbYm/DMbbtySQItvuX7rDMZvC0p52dfh4NJxWg/nr09ANeXAZhiXc9bkOxAHJ/xG5ti7I7FhiEPav1AfSEft/hwMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687185; c=relaxed/simple;
	bh=J6C8/Z6Xx8/zFFOEjzG8rTwrunoZ1TZVpwoUTteC8vY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGM8QnL3V/RwHKI5MkZeYAGuR6/Pz8Lclbt2OPLf/Ufkwd0YGCCDdZDCgxmecKb/H7p7Nqnk+oNGG8TxdNJ7/sZK2LwVccT2V7v8frfV2tAIUJ4Yw43FMcF3w/pW9+sfAGdKRCfCZpl3a9RB7OJFXDi5y4c8GYI6sDjFIt/+/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KLi5tZwW; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86d30787263so2338218241.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741687183; x=1742291983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgHHBhkd8eGrFbDvShJ9s51yYCl4gvLMZWScZVFv3YY=;
        b=KLi5tZwWKpK9DepepfEUUNBlNZnBK113ZGEcIp5STtzZjA+Sy6G6LjRZAb/doqeVYD
         dbT7cNOIu4VW4GqOBx8m9CUdJl8Z32rFIgxaO2oTGdsQ/QUQU1eA1NosxEpw3RAep20x
         ivawIVQQPOYN/YzU8SjBwzLVWuBvwzAMmMXXZh3MRjO5qrrief/wUAhZ+W6x6vXxz3xR
         74T7yfFVLnwtsuPaAC5sybp5I5z9ZtYd2N23RT9WfAIdgKtbn3noJOVYJeIYdCzPVq7W
         U0GaK5f8ibFzxYucFAB9++vfQkaVDeJ819p5CWrcYodNajyB2i72HNSTRoyrl0NzxxSE
         0BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687183; x=1742291983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgHHBhkd8eGrFbDvShJ9s51yYCl4gvLMZWScZVFv3YY=;
        b=oQ5f2xLkdK8t6PR/yxrnxtLNTsnAo/bX6vWF2ftMcFb92Ir5S9Z7bUNokvv2RkMrGV
         dqpj23i1/JMEUZcIol3R9cmCiKMTXgkY++tPiorWS91ksKGLtdypA6zNZLWrp93x/2jD
         dQ93q9JSouLvfBxXEqvg0DWtJOmqSO18VWKiTk/7dwGznPNEkXsQ1g4Ltzlga3OxcEjL
         v5fz7j90aMf4HYJQyVrOTm6+GRQ//haT943jX4qV1xgZn8vkm/9M6i1qko8lV9xcbbzu
         MdSaHRtv5lYojtIqeHstpE9lyZk/xlNnHjZLFIuPsONhzOVViBFEnd0I0hXJlpi4EmIm
         6L3A==
X-Forwarded-Encrypted: i=1; AJvYcCWJQFVzSz7eKYwH0oO+FQsgwR6KMpTG5yOqCacvkd3JfBBBGHGcWH7yiBBYSTEkg0YZL9Kf+lIhiA2f3FU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2v9/bLtG0W5QO5s7eqJ9IN3eCDwBbSKdjyXpuYyFk5HprzHEI
	ni+qRTIXP1X/YhH998T/x2Kz1itNq5tgHir7f0aCrpftdqkxKbRpL/GEqa8Q5G8Ug+lEw3qtDr3
	JYnt6FtBDpJCm7ID2IC4mEj9Ds5AWE+Yyz8yhZw==
X-Gm-Gg: ASbGncsU6Qwy41nMdMyh4FHZsgGDf00wybB2p5yO9AJYEUbrmo4yB+ui4idDKy4k5jK
	CHt/yUox9yXIt+fOZ3CA8s5nhPHEnTzmtxnz59+kLHQimDNS2SlsEFPuIuHED21sErSBbQl1U+U
	nm/32BPqfDNTFKWX1qjuy63D4xPG6ilSdWVSOT988eKvPfImLjXlv6xETLiA==
X-Google-Smtp-Source: AGHT+IEW83Xnyj3HCDdDUXd2rQkKJnkka7mSV0uybfERQkgxMEzczr5vd28/ptt47EuXiJbo0OiVMm7z6oH6+1A7haw=
X-Received: by 2002:a05:6102:54a3:b0:4c1:875e:2215 with SMTP id
 ada2fe7eead31-4c30a534d15mr10077749137.1.1741687182836; Tue, 11 Mar 2025
 02:59:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310170427.529761261@linuxfoundation.org>
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Mar 2025 15:29:31 +0530
X-Gm-Features: AQ5f1JqYM1OaGivq8FkIREmdHHUgpx2t5idwxKUVtIfiFKEINVp-cx4s8kAVB-M
Message-ID: <CA+G9fYtqPxzb==RHUbxfDuiABnJxC5pBRzGR0JKQF1voxRpqKA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/109] 6.1.131-rc1 review
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

On Mon, 10 Mar 2025 at 23:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.131 release.
> There are 109 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.131-rc1.gz
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
* kernel: 6.1.131-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 5ccfb4c1075fee3b843050158af9660c9489f04a
* git describe: v6.1.130-110-g5ccfb4c1075f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
30-110-g5ccfb4c1075f

## Test Regressions (compared to v6.1.128-732-g029e90ee47c2)

## Metric Regressions (compared to v6.1.128-732-g029e90ee47c2)

## Test Fixes (compared to v6.1.128-732-g029e90ee47c2)

## Metric Fixes (compared to v6.1.128-732-g029e90ee47c2)

## Test result summary
total: 72879, pass: 56029, fail: 3089, skip: 13542, xfail: 219

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 46 total, 42 passed, 4 failed
* i386: 31 total, 25 passed, 6 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 15 passed, 3 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 38 passed, 0 failed

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


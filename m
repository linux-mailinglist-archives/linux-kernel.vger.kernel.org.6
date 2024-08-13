Return-Path: <linux-kernel+bounces-285176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8410E950A28
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85251C22A94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F61A08AF;
	Tue, 13 Aug 2024 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWreRup1"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624E1CA9E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566638; cv=none; b=J+7emBRBChkL76uwioYoJPNejeKr0cKvaLqqpqC+527AvzmWobm7tmgQU/RC+RL8woB/N3hSVmGqeXbAErXzpUbCIj162cCyWrUmUP7gtkQZ9XIkta5dNZ4c0fDp+37r9Yy3IqsoixK7s26xeUGkt2zlbCXvclSAvS/zWHu+s8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566638; c=relaxed/simple;
	bh=+kXd5lQBlmgt4ODhbDWegMf9ii18tWOxfLuvIC/UtU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzyOB2bClSwXJAyuJNPj+sAqVirkIBUbmabPrqg/+ZWRWIIaOKeNOb0Lmt8vWWcX63gkNxUbvNNeyALxiawGIFx5bdgPtjOlzxKg4bzmO3ROGb0EaFE7oR+VCk9ArJceGUD66/50cHo6KuVa3CmMbtAG34ZLdvGNVfgmiOSUCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nWreRup1; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4f8dbdbba98so18711e0c.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723566634; x=1724171434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcOkVGVomQgpIlgkRw2uEX+wAov9nzcGjYicRdhvNpA=;
        b=nWreRup1FTbnKIJwOFhXnY9pqtM8JI9C91eBdU6pFYsE++Q665NLwzmKl/UkcHMpmv
         ARmr04tVM3uMfu2hS2mLPzEzh2xEW6nE9n9NveHm0tPa7vOAt/Li33jLJmhkhU67G3YN
         nUs+g9ORoVV3PWm281zKnXZvuGCUHIJzm2zKKIFkcueyhaU3mz8qW4JsrwtMpv1hKK8N
         ckaaqkhCDhXzvn0SP76LtR/RCBFuco4zasZzaANrIqovl5eWPySA/Nxt4SlpmksNGQxW
         oe+HcndO0mxD+LF4wZykvPYxBzCRdjU4WrmSQxKforA8PapcTWYmIQqgT1PUqvCvV6QZ
         nCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723566634; x=1724171434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcOkVGVomQgpIlgkRw2uEX+wAov9nzcGjYicRdhvNpA=;
        b=VH0jt7cS5POKQzXjN3K264eCq68tu1Tkab/zd8jKrdyNp6rY4pkWP7i1jWbzoq7oCF
         nFYqLd7/XRG6+uoscAmao3WmKBWmoHx0Xm74K3bjrbP/6X4YKsP1g31d4LFpuRaae0XI
         39OISf85R66HnT5oZejdSLsrPDunT2Lqgp/zh9fY/T5ZrPMIx5jHPHI/sJVDSgK8dHRi
         ZZP/0GDb2zljnbjfFBgXOn4aW9uh6i676ZZS0lNkaQIpH89M8ZY9uRA9lXOGqlk86wwz
         JueByATubz0KvsCC2HhTlbFLCw9d95UPihuRh5Uif/RcLf+O/flz6qlWa+RRVjFJcdBG
         UdFA==
X-Forwarded-Encrypted: i=1; AJvYcCWB9y7EFpwimiOd0Iksm7Z0FX3fY3Vp8sXPtf7py49YH1KmNZNxW/JlSsLfOsYWRWmh6jkM8nWpFXm3Dg0J7w68PoWaLd+hXW0MPPhA
X-Gm-Message-State: AOJu0YzPubc3XeCyQUAAGLZEoDAVLmT4bWb+5u46LAwdxScb0/wlnw7p
	OoP1PVz4Hf6g8Z0X+qBMxP8YVamtykzkDqDv4jp2yoHQKI5RYbJhooh/4w2dMd6xwMumrm4kZhF
	3Tjo4M7CNdQksJuuPlaJpbQS/JV5fWxtC4j1XSg==
X-Google-Smtp-Source: AGHT+IFU2kpn0vuuQICPaDAMggyIuddBpewr8z4/Dc9irwuRYKKCgZ66IiMoSL/+f+SHq/Zuf1+9i3z0clFf39M+P+I=
X-Received: by 2002:a05:6122:2002:b0:4f5:19b2:5435 with SMTP id
 71dfb90a1353d-4fac17fb19emr2537940e0c.2.1723566634139; Tue, 13 Aug 2024
 09:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813061957.925312455@linuxfoundation.org>
In-Reply-To: <20240813061957.925312455@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Aug 2024 22:00:22 +0530
Message-ID: <CA+G9fYtev5H05e9-BpRPaifWekO_xBNXVz0Ev9ps-hFXcVN8ZQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/149] 6.1.105-rc2 review
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

On Tue, 13 Aug 2024 at 11:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.105 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Aug 2024 06:19:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.105-rc2.gz
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
* kernel: 6.1.105-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 9bd7537a3dd0286970c1962438e04c42993f76a9
* git describe: v6.1.104-150-g9bd7537a3dd0
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
04-150-g9bd7537a3dd0

## Test Regressions (compared to v6.1.103-87-g54b8e3a13b43)

## Metric Regressions (compared to v6.1.103-87-g54b8e3a13b43)

## Test Fixes (compared to v6.1.103-87-g54b8e3a13b43)

## Metric Fixes (compared to v6.1.103-87-g54b8e3a13b43)

## Test result summary
total: 315861, pass: 270713, fail: 3868, skip: 40792, xfail: 488

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 270 total, 270 passed, 0 failed
* arm64: 82 total, 82 passed, 0 failed
* i386: 56 total, 56 passed, 0 failed
* mips: 52 total, 50 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 72 total, 70 passed, 2 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 28 total, 28 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 65 total, 65 passed, 0 failed

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


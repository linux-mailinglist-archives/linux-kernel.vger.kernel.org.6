Return-Path: <linux-kernel+bounces-407440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 696A99C6D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10395B27FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B41326AEC;
	Wed, 13 Nov 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByvS2wbe"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B41C8776
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731496209; cv=none; b=q0LzETjk6ziizPO6ZxgK4dFRRs4iDjhmVtEi6njehZNW+g5oVMd5+3sj6ljeZkFbpirPAtyNS5l4PhUPf/9UQuvGvyJ3wsF1NNBIxvhSsZJFihOhxPq8kgoJWocEEDm91MVVxg5KoziAK9viNWkxJLZHCw4iWx4zLb561eKXZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731496209; c=relaxed/simple;
	bh=o7ZakQlIa2lYgRR3nNgwkZEcN6aiF+WrAxBCWIkUVWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbhkxGnIVjxoYT2gEz1wugFRUw5WxSx87BDhx4TKPIwV2ui/Hmmd5sWu9YeWWWHtDKdGWwm5arwhvXEKSCv8gZhdlSwgh/LKoi4txnzVOn95aWJvmzYQ+nbGPesi36GRzUFp+QAGXSibTfqugQ5YU2iyyqmD34UHUnj8AejMJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ByvS2wbe; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-513d1a9552cso2795314e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731496207; x=1732101007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLRHbq0yedycOi7moHqeorbuEFrpPo0av/ZRKrfN6MQ=;
        b=ByvS2wbenltC3anw9uvXRO9+tjHbHx/06f/xCdiRKNZfFREMqykYGwYvM3mw8ID67+
         YV1MAUP21tmucxs8hcwiBVpIKdzlv5+ivjiRw1PyVhjunc+JXWwxV4xPd4qZEh84J2D3
         VbHa5QN/X0vfGNv5RevmMMcXlxBj/fU6p6C7S0DmpBsMsekcUX2jUhwq8y3jczn5qMAR
         w7BwJlacRvbd3rD/CstlCx8rPNsBY+G0gbl9UVCdlQIlDIe8JT5zJ8JCEALTUwRowHkp
         DIryeRFOMBo3QR+UEoD4roALRxeYvRJkByUGwFLszpGeNKYErxTpV3jfKX70A2EHHl9M
         LnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731496207; x=1732101007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLRHbq0yedycOi7moHqeorbuEFrpPo0av/ZRKrfN6MQ=;
        b=ueG3IUpg051THNtFUBZzNrmY7tT8rU52ft2t2Dp5azNTR5WXT+UwPYGEEK8YavsJzZ
         L5UtLwE4i3GfDVxCFc0fLN1XQOfnB3HKwif2vhZQLS+Qp3+8MqR1K0IObkoCAd3/Ok8H
         2INBYCjQGQT65fAccual34AOfDJhyB3hR853ybKfaJ66OV6rvuR7fjaQXUbtoXiIoEkg
         SX9ZAifL115vk8Jh/6i9xSupIPyZUNIy0aGAQLZXFmDNvPmnLEVWDDgdoHJESgkwS/ua
         IHWTlJFuFRxxzR6meewOnxSMhWzDlaqXkQTSVcSC9Zdg6uRLDMk6nhocVRu3MSmlFUwp
         C5Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWut9lMLI0BKO5gE8hXVfjJgPr9AfmbeM/7ohl4fcguKOnmdj5bd+KPx2G7upJEND7YZfCuUdx+3sf+yVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyPk0niExsim11k10RFdR0TKO8h4JvbR6cuoK8op5GfesXfy8R
	4W6WL5LU4ssVGsdopUWfb2XR0fNL4rcavMTAKktyqTXuqh9xbM/UdJMVhZymU+v/GNLE4Wijt4J
	aL/TN8NCEzrBsvquXUyKQTQNvDbcRUWLf0AkFiA==
X-Google-Smtp-Source: AGHT+IFYtql4PZnERxqsx1iVt7t5SNiqWamwYFmQtWq0EQx64r3jMppMGLMQpLIRJQlVFtUDuYAk+p5YKLimNZuqqvg=
X-Received: by 2002:a05:6122:181c:b0:4f6:b094:80aa with SMTP id
 71dfb90a1353d-51401e8d209mr20290230e0c.9.1731496206871; Wed, 13 Nov 2024
 03:10:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101848.708153352@linuxfoundation.org>
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Nov 2024 16:39:55 +0530
Message-ID: <CA+G9fYuvsU3hfJd_3tDsv1HpB_hBPTpzcyGqJ1bRhUcwmhKMjw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/119] 6.6.61-rc1 review
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

On Tue, 12 Nov 2024 at 16:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.61 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.61-rc1.gz
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
* kernel: 6.6.61-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ba4164ffa865e6dc8d86c0605cdf762aae20e49b
* git describe: v6.6.60-120-gba4164ffa865
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.6=
0-120-gba4164ffa865

## Test Regressions (compared to v6.6.57-484-g2daffc45f637)

## Metric Regressions (compared to v6.6.57-484-g2daffc45f637)

## Test Fixes (compared to v6.6.57-484-g2daffc45f637)

## Metric Fixes (compared to v6.6.57-484-g2daffc45f637)

## Test result summary
total: 207451, pass: 172242, fail: 2343, skip: 32689, xfail: 177

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 257 total, 257 passed, 0 failed
* arm64: 81 total, 81 passed, 0 failed
* i386: 55 total, 51 passed, 4 failed
* mips: 52 total, 50 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 64 total, 62 passed, 2 failed
* riscv: 38 total, 38 passed, 0 failed
* s390: 28 total, 26 passed, 2 failed
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


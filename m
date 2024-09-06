Return-Path: <linux-kernel+bounces-318267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E896EADA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F293EB20E20
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE5F13E88C;
	Fri,  6 Sep 2024 06:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/NpNEbn"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75213D243
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 06:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725605078; cv=none; b=fZ4fZp+oNcThmLvgDPrcbAFhw+dqYYSfgv17jQ/6Gij6uc/0Fd/6+PEfIGJt7ItPeFhX07jemcO/5IfUceNRDs2epUrzhzcSMfScpHH32ofMZxWQIUH/nxwkCWauj+awJVKb3A3fBashA3WbqOeUHnqvO/QblVcuJ7zWKqU0xRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725605078; c=relaxed/simple;
	bh=oa3H9YCpx5VYGA2KbkYcPMgZzeKNVh/PFUtLWy3sJ/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXVX1N0/Un55t9irXi7xUbaxIEzsvcrRDg//MrIzmoEWxtMXuYy1NzIi+S7lidpHMzE3N85ox861HBsjOooOTlsSJz6zJeJiN51ZkvfgsxUarGtzCVfMRZNFpO0PvtE6jSkCPSWkCg8epmI+7agPgAfsFI/Z1NlimHU5hNc2gmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/NpNEbn; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-49bcbf7bdb9so486097137.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 23:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725605072; x=1726209872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gP4o7JbisYVim+/wPjL+HDCs0/A0dQBHIFGkvw0INA=;
        b=q/NpNEbnM88Iy4LVeCO+y6wBPn/oRbBwowPadxJ9OVTj9NQH9/lqaZxsWxDpExVmcX
         PZQO6a0uR1R5ZqAm2vjWXTCQsaNTIHX+IwIo9lIUn1W8sFcFV/MrRpzwAINCcIAl6J+b
         Pc+/A/VY/6YzEJvf9M1mF5oiNPqpkmkN4beIrxUStUi1JwLuMOffa+VBkGoyewiuJ83o
         GG2Kp57AdBIj920eNZdg8UehQ6ZTFOaLcleXPyoRwoqOJ51S+WIIzeWODb7RfsJ0uNmU
         Koc5HpoTOnqvooCPQPxjEiF5Awj6XAPOEG38mJQ5A0eJtzzRl/72PVxJlCtJg2Pc2mlx
         JNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725605072; x=1726209872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gP4o7JbisYVim+/wPjL+HDCs0/A0dQBHIFGkvw0INA=;
        b=GyQ0Bk4pMw7MXBkvjs4DCg3zlteTU/Fz34g7E6XyGtyv37YTT0498GHjh3mt3ynZd9
         dC5UKQaXO5koHfv2D9GtJ27+LvjP02+jw83hM8n8Cdhxc0WoCJagkYpHJT0V/tBvdhcC
         KLicIjUXudP/KcVOI8EA8C3UB/T3Ldp+tki3etxeigRkl5oAMJAac9gVU7JtZ6fWxUfr
         bndlfTKLbN0NX2ANCjcqWZlN6ErCFKMANTH9XhkE8JHw2kS6AfEY9tmRe2kqX03zXYiX
         kce7Z5TrzTNtWejYSBqZroOfF/iucKt9tw1Jr5OKxnkwTV+FncDcjyAz+KdUBNRhTg+Q
         QTzg==
X-Forwarded-Encrypted: i=1; AJvYcCXJeCqWWsATBwo9Jztwz3UI+ETvR0uPdOnxoMlUk9+9+lCUckJmE+PAqeOM9kHfUwRLR1CzZR3beM40cWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzySzpHTRKtn8vnMQKtvPPXIUOQFo8E799xHECbyqbt+IXLF0FA
	Zvn7oPc8hrn178Hr3vSN6rhAusR7VayT9cmnnw2tLCdD46wSgmHGdKvQL4QVEi/AmGLT+c+7DNv
	MHALPEXy/YnB+0EvWG1M/Z77BVwVxV6qfoQllZg==
X-Google-Smtp-Source: AGHT+IHuUmzECAJSrwF2r14ymHpo71IMGLjs7axdWUb+JN+ClsSfKWQfo8MjNbsnf5TglvLkxKmzZ17gWcctxFVA+yk=
X-Received: by 2002:a05:6102:b02:b0:492:a93d:7cab with SMTP id
 ada2fe7eead31-49bde165666mr2127128137.1.1725605072208; Thu, 05 Sep 2024
 23:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905093716.075835938@linuxfoundation.org>
In-Reply-To: <20240905093716.075835938@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 6 Sep 2024 12:14:20 +0530
Message-ID: <CA+G9fYtr3bs6RbBgLc10QJ2c2Uh4EHiif7bFOD0J+p4rEoCukw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/101] 6.1.109-rc1 review
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

On Thu, 5 Sept 2024 at 15:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.109 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 09:36:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.109-rc1.gz
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
* kernel: 6.1.109-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: be9ed790219a433e9d1aa5ca79fb51e3e52bdb81
* git describe: v6.1.108-102-gbe9ed790219a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
08-102-gbe9ed790219a

## Test Regressions (compared to v6.1.107-72-gde2d512f4921)

## Metric Regressions (compared to v6.1.107-72-gde2d512f4921)

## Test Fixes (compared to v6.1.107-72-gde2d512f4921)

## Metric Fixes (compared to v6.1.107-72-gde2d512f4921)

## Test result summary
total: 190787, pass: 165221, fail: 2316, skip: 22988, xfail: 262

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


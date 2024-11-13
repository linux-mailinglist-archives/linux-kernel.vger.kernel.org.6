Return-Path: <linux-kernel+bounces-407435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141F39C6D64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8206285521
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E111F81A0;
	Wed, 13 Nov 2024 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZ46wYmy"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AAD1FF5F8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495970; cv=none; b=p19xyOisEjjvTEl87EL3tbXH/hy1wlfocC967a5MvBvwjeGbZDeUaWji6TRExAaN0OLFJmcCxBEpLPLbieooM3Nl8Vcb6Au1ZzrHriJXZUPWAtsblERxB5uJ0bX+rPi8k2HC5Rj7tKBOLHcYPIw8NsGQmHrgdiRc619KXW86unw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495970; c=relaxed/simple;
	bh=9w1adhm4OIkWgFRN1hDiDFpoQSbwWNGU96qvtFz9gAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4UR45jR1c0i8aJv3BRFeuo0v2jX8gBYRyPlqXDSlpZZhNuFCLT8NdJTZsh1BTS4d0+dki05/inBRlSFe9Y3u2HTwYbLN5muTi+Fk92+F0b6zs2i/Cz2zd+pBTh1TqwZ3SBDCJT3+Ijw6lEhq6bdR5Kjru5H+z+46pPdiPhcpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZ46wYmy; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84fc9005dccso2513793241.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731495967; x=1732100767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTJceuzTgFN//BIRxDZQ62yaIBfXA/2h6KzjoJYet3Q=;
        b=zZ46wYmyJnE2o7g6sm6RXJ7/24EYHnuOYD88iLb+9V8725pdo3y4C0WD16eFtrTvZy
         0d1JxvIoyTz39KW8PZDG50ZroeSlg4YpIOSeCiiD4TtAY5d7EnolcaREmoNCpgOMTe0O
         V6Oesi7YVOyie6bYKOfYLufan6/w+FLMF3yKQ8fzJqDAxZ+dpJtpXKrQpMESEGAU2+wc
         aO3kK1W6AiafXya4ZFf37iMpstGvasjjqHop34xFXobmhCCHrfBCmGpAWRDDKtdUI10N
         gvUvMK+2SonBlIJx+eNGjS8NzrAXAKl8ueNjgGucRmewx10PSLfmQzU2Cfyy19CD4MR8
         +4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731495967; x=1732100767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTJceuzTgFN//BIRxDZQ62yaIBfXA/2h6KzjoJYet3Q=;
        b=BNnMqblSwVhjbUW0PHsjpcJYr1HPktG6bBgiGjNxbjWo3L9gVkbhuTw+xofJQIzZfG
         kq6/16qPhYigyRSuBiBkxrqx7fzZueZVtIl//6b9sJKgkgOwEUeHnKml6MyXMoG2NkCb
         XquAcjeaT2LM/fcVo1t+neQm+PqU3BBM884x5V5WG8d4+tNUpoZ3vyeIwW71y9defTiS
         +6ss6l5ZlskJV7jQOlE+uoD104vFwzs6qjsSsmqOXJT6nO+g0ms1tOA6ehkjB7LZL+hr
         dsIh6XoeZtSUqIukYnGn1Mj2J2lZSdRCEGI2mJDZFXqV5Rem4hSuBhL3IJSk2H3YRzmV
         Rhew==
X-Forwarded-Encrypted: i=1; AJvYcCULaOEDqiqKUvL5ERpwYADgCzPRrTd6nRxb7Bxn1sP5MWiJUJ/7xoPQzvxFa4MwOSX2/mgUHaZgeysk0zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjPB0VJBcszdJ+KZE+ve7adHgRj62Dgv+YPwfY/2lqs4+1hVVr
	hiOuXWKn6rtJ47JSHDP0RaF4HnINs7XxefZR+MsV9Kj1M7+NqIfN3U4CC33VY+d92z+YTVz0xp5
	d1EHnG9uereT1xvnSXwV9DhQhJh++bKEsisWSDr8C3J+TWofjA/Y=
X-Google-Smtp-Source: AGHT+IGDMocD7bchTeV1O8crofiDsw5L3oHsCEad9aXSKbm2iKz41U8oJ7bQoCv7VzLfFIUKUS9u1m1UWmm2qbJ0Dgs=
X-Received: by 2002:a05:6102:2ac4:b0:4ad:4e7b:10a8 with SMTP id
 ada2fe7eead31-4ad4e7b14edmr850344137.27.1731495967541; Wed, 13 Nov 2024
 03:06:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101900.865487674@linuxfoundation.org>
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Nov 2024 16:35:56 +0530
Message-ID: <CA+G9fYsT27U3v0cDOxRCE53qTDC13f8Tx2QiueD4bWOe-N-nNw@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/184] 6.11.8-rc1 review
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

On Tue, 12 Nov 2024 at 16:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.8 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.11.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: a5b459e185d11096a9edda920413f07fc50f6071
* git describe: v6.11.7-185-ga5b459e185d1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.7-185-ga5b459e185d1

## Test Regressions (compared to v6.11.4-646-g504b1103618a)

## Metric Regressions (compared to v6.11.4-646-g504b1103618a)

## Test Fixes (compared to v6.11.4-646-g504b1103618a)

## Metric Fixes (compared to v6.11.4-646-g504b1103618a)

## Test result summary
total: 312413, pass: 259601, fail: 3622, skip: 49190, xfail: 0

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 262 total, 258 passed, 4 failed
* arm64: 86 total, 86 passed, 0 failed
* i386: 36 total, 32 passed, 4 failed
* mips: 52 total, 50 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 64 total, 62 passed, 2 failed
* riscv: 32 total, 30 passed, 2 failed
* s390: 28 total, 26 passed, 2 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 8 total, 6 passed, 2 failed
* x86_64: 70 total, 70 passed, 0 failed

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


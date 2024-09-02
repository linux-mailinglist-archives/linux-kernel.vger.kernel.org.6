Return-Path: <linux-kernel+bounces-311251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A476968698
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCED01F21FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013791D6C68;
	Mon,  2 Sep 2024 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9FmFyRS"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F7A32
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277769; cv=none; b=hWnPvedM+afsy7IfsrtwOVFWtCgAEQpl/f8FhTksbi6i5G5FRJ4F891S5X+1ZbDCRbggku90zgVh4Ygbl1XFeQeOjx/mU42txUhbenbdLHbzjz8TInYSXBey6KAgg5Vq6McIhciKGVPLzuTpkNv2d9gY6HvxPKwRZcG6ImtXl/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277769; c=relaxed/simple;
	bh=TbsLhDhTwEQZqG/BspoBxQwZG8kUpSJ8LMtZATpnDRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUyQQvGRcGgq2qBg0ZWY3v5IyslT/iqSknAmPEMQRFPx4H/qiLc5v3Gnz5P40qREXLGmY8wnBtuEjPucqHNQ7hk8Wpjmu1S617pEEXw7Pv97u6S2ydKNsnOivUs2An2uRWxzGiE4vw8aGxIyy6JKc0rZLwjq/fwYqjRXWmrROio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9FmFyRS; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-498cf14a848so1465388137.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 04:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725277766; x=1725882566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTifHbeYcxDQuXfliKouQ/B6JHrDG8JJUyn5xqITlps=;
        b=C9FmFyRSL5gYFvVVFkYHnuzhpYU4W7dfEwKqbaPwmzoQvjdm98+FtQ3m9i+Ag/LENe
         +ycLDpSfalL18NoWekmZvnKSL/7TJqsLkBaBTDxeUETFfWFuYXhItWhKS1RTTj1zMxeB
         hSjG6Sv3t5qhY+335mCee/GcaUXtGMII+qbcXvo/lQ9cEYUk4mA/wC4l7YgjIL0NYnfq
         zbwohrZ6NunP7x6QpgcBDPBgWmf/kUOB8oVp2C7rmYtnSu1DO2NUl7ZRK19TP7AUYYv0
         7UR6HNLlNFwAAhqb8mUCxN8Co8NZR/5ALvHsDG3DVA1BYAM3k75dvckcN0RuEZtvw5pm
         QSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725277766; x=1725882566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTifHbeYcxDQuXfliKouQ/B6JHrDG8JJUyn5xqITlps=;
        b=SYBPyvAYPkZ67asFHKfmmbAHIOCeXHg25g5vdtGbCXPezu1Xj6J622DMICkuXfeypm
         W7vACzOmWz1Cu8BHXLfmejVwoPd5JMsuNNCUaZVb60SMucrmIracFbPpiBzWvvJT1d84
         Sqj6O8ZGAlg5H5ncSmwPS042qKNhdphTxkltm2nuyBGIyH9G7hnyexAq04uNpr9DzAww
         d5zsoUyCk7w2R3SJ3i93EaYiYlHFiAdOawjxqVFli/PQPoAlxQ6joqQ28LahgAB7AITG
         sDroZgJ36s+XD7ll09tGICCUs/eq29DZT02WxkHegOLtbJ6NizK7cEBqFPeMi9qjrSEP
         TBxw==
X-Forwarded-Encrypted: i=1; AJvYcCUZPvGQ9N/z/TJU/jNZLuiOF+feIfa2YTNkrUsRsoER8TXxlWnWpW7q9zhCFmgSbaHdnmNuXREwkQ+t0M8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXmzY5WZMtx0YxCRUSU3abVtsmthuv+ktDhb1YxA/JzjUwwv34
	0J6iYn2J18SbIj4EpRb1YZ1uvKb/pWb/GHIgMZuNRdGmb/7qBYtDQ8gO77UbQvb5lWQFtDiHLCk
	rgOvyTUH5+s6nzN8h1mf9VSW4J6Cj5RJSU6N9Eg==
X-Google-Smtp-Source: AGHT+IEqJTMFzAtvhaYcjWv0okauFOgdky9k0/FOXTxZktuO6h2MRkyM3tNfux7MBolYe2+OpW4jCLLHXdWXrfZzrWA=
X-Received: by 2002:a05:6102:3a0d:b0:493:de37:b3ef with SMTP id
 ada2fe7eead31-49a5ae733bbmr19067756137.13.1725277766603; Mon, 02 Sep 2024
 04:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160817.461957599@linuxfoundation.org>
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 17:19:14 +0530
Message-ID: <CA+G9fYvYmpUeain222FMmDCQ=N5qMrBoza=fO-jhNP5romhM3w@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/149] 6.10.8-rc1 review
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

On Sun, 1 Sept 2024 at 22:01, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.8 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 88062a11f41d8d4c9f723337833e4e9ea9324d5a
* git describe: v6.10.7-150-g88062a11f41d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.7-150-g88062a11f41d

## Test Regressions (compared to v6.10.6-274-gaa78b3c4e7ee)

## Metric Regressions (compared to v6.10.6-274-gaa78b3c4e7ee)

## Test Fixes (compared to v6.10.6-274-gaa78b3c4e7ee)

## Metric Fixes (compared to v6.10.6-274-gaa78b3c4e7ee)

## Test result summary
total: 199765, pass: 176468, fail: 1757, skip: 21311, xfail: 229

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 127 passed, 2 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
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
* kss/1_kselftest-capabilities
* kunit
* kvm-unit-tests
* libgpiod
* libhu
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


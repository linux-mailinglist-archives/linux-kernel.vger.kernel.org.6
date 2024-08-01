Return-Path: <linux-kernel+bounces-270923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 550AF94471C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1630F1F26A71
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21EE16EBF2;
	Thu,  1 Aug 2024 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHMCubid"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E5F4503A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502458; cv=none; b=dv7QE6BciTBxBrltKy2cnBaBHEjAkdI0a3D/VOzaxg5Kf7kxgxAoxtEUJ0n+YPQa+nqVTlC+TwpGq3X+rjiLC1WuWkgVz2/rrvAMAj75WI0AOAxVRNV/hWHY9iwFDw4788JaugK+G2F+jw6cyN30No8DQyrmU/g2QNbreufSb6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502458; c=relaxed/simple;
	bh=Kj7c/438Wa9O64kPH+po+5hSx1lbASVplI7UxAzPUEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FRUgtLvSVCrvViqrq5UFO2IG20+EystHSYZMeXdbLe2Dxgtn3tI9AWnkGRqQMNRnBQUeyXzTEMhP/smRAU52OQiSE82ua3u1h4nmcF45QKRna47X4vC9o8sgxcCv3ySJ9mKTPyRL0UENkv0U/KSk3u67mu6JI9gzaTLUcGmfOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHMCubid; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-492a01bce97so1644648137.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722502455; x=1723107255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfY9uGRmgYgwlEYLKB30UoOS/7PZs7LGccJhnUl/vDI=;
        b=EHMCubidmzkH81wJo2yYnrbYuxlBTe5WP3s8bzVWGgTYxOyn0Yn0tvBs0qSLNYUDbj
         VFmEARcEB97rJ2WG2YXYpywJDCt5iqrS0X6nM+qNfzG1WjMXIVhFWMoz37x6IJAU7Mdd
         Fx4xaQWuzf1taAFa4nXOWUp2H2nK/ZYfvu67MIeJfG6SjC0jpYQJDpx/a7T5mvILfevu
         w/0L75UufS+AyXL184oEP/hhycPChliIpsXce42140Wp3l5HbVJYigPVcOG9E6VURycZ
         htZwppFd1ZITwev4ZbFsIGs/k75sOlsZNKqHTbVboiEJq6qrUNxxV6jHjuNHCGuPATZZ
         DOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502455; x=1723107255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfY9uGRmgYgwlEYLKB30UoOS/7PZs7LGccJhnUl/vDI=;
        b=FcOcrXRLcgTCa9rIvDWgrCCFCsjUkYf3fbJfzlg1RAZnMrYXI+X9XsquUa6/YHlr6O
         i5U1IJ9RWzi0hJsVEBxhosb1qqIFgs9AN3LK32MM95mK6oozHE45V++a2JIKnwK1hvkh
         L4PcaiCruJqaWIc/X79NRpbI3rArNoVAP8Oa4vIfCPbpJUJg97zqZpCM4ysd0r72bwFX
         eKdWTppr+YBktxm95tu+0vY0nOpa4nNoO/ogiHtPfG2dF9ir5wp3F4TXltJXpDPrfkri
         lYaZb+Ayy16q45F5RORT0M7OBw6Ji3JDC448VUIe8nQupGyVSwgh72wUVIZNuSaVz/Wk
         u+lg==
X-Forwarded-Encrypted: i=1; AJvYcCUFlmNHroIrrIA3nTE7kng57ImGzSWeoCh71WmD2z38rlvjfuBH9rBRnPD94UVKjO9Z382SPhM7ZNX+i0BymNFxRleFx980Mwqw6WhI
X-Gm-Message-State: AOJu0YwKB2zCMZ9evdPg2N0BgjQlju2GbBdeyp7VktYFz4twHTm+Lgpy
	Acjq2KHqohBSG9S2I9z36kgL6/VSOMOozOmQ9q6LylTKV7q64XyhS3HYiV9sGxmW/xwkLB4f9JE
	wOVyDw6vyRaJECG8gSaRb6UvMz8e0xf889p/0WA==
X-Google-Smtp-Source: AGHT+IH6JdzRzhUBNvL2xB5DHRVjVsFJqjvuKiRftt7np+NNTPuZnk8Z59nka/DWI3U/OK1VV95z5DjFAvqMAmId0sQ=
X-Received: by 2002:a05:6102:3a0b:b0:492:773e:a362 with SMTP id
 ada2fe7eead31-4945099babamr2044736137.25.1722502455326; Thu, 01 Aug 2024
 01:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731100057.990016666@linuxfoundation.org>
In-Reply-To: <20240731100057.990016666@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 1 Aug 2024 14:24:03 +0530
Message-ID: <CA+G9fYv9fyCLmJirVSpgQm2kNb7vHdnstREKCisxHCT7XJww7A@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc3 review
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

On Wed, 31 Jul 2024 at 15:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.103 release.
> There are 440 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Aug 2024 09:59:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.103-rc3.gz
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
* kernel: 6.1.103-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: dbbffaaee18872f4ae741cf2bcb726583b65c069
* git describe: v6.1.102-441-gdbbffaaee188
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
02-441-gdbbffaaee188

## Test Regressions (compared to v6.1.101-14-gdc0e6d516f8a)

## Metric Regressions (compared to v6.1.101-14-gdc0e6d516f8a)

## Test Fixes (compared to v6.1.101-14-gdc0e6d516f8a)

## Metric Fixes (compared to v6.1.101-14-gdc0e6d516f8a)

## Test result summary
total: 171958, pass: 147513, fail: 2121, skip: 22066, xfail: 258

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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


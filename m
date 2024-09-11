Return-Path: <linux-kernel+bounces-324846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C41BE97517A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AB33B29353
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278C915C13F;
	Wed, 11 Sep 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gf4c9HYI"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AFA73477
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056681; cv=none; b=JaZBtD3vaj6XRZ7n2Tastt1ZFSgryQUb/8UZW0vWC9sKsP3HNliLz6tWdXJGNVNt4lnJDLCwMjPL0K0CYrBOm+Kt2EtX9RrFTMuy5O35yyXkgywidU95D0jzttWbUsYNLQLnroul5zLjDFTgOmJqg2r7scJ09+YEoeKW56IWmrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056681; c=relaxed/simple;
	bh=xH58OJ+sXl2b826OYiPHRd9NE5L94C4pw9hdMWq1/Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlUOjSvXF7AMDEs1GyC31M4d513vEQMoezgUA9I+Z/Aujz6n2NugtesQZwCxcQC2gsYfiOCgtGeOWJmvCfR6gFiRDPioDn08ElryglgLpPaL1kFU0zsncSoROwXtz1CDDGk8xgBOBWj12FCl+PRp3PCmME66tX2zVGfgutNrEgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gf4c9HYI; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-49bd221ef66so621511137.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726056679; x=1726661479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho+7AIPs7Mj1ey3Hhl/CyW2qOQaHptxWFNtHcun401k=;
        b=gf4c9HYImzE4UQuTDxxLIbuD1wb7gR8Wcdxq8r7ggiVlnWPfLpdLiYbeI7h+kBHbqK
         tMnZuVVt3i3hP7KqjrjHvtH1ehY6K6t0iwaFz20z+ST91Km3oPPiKBo2Z2tWd3nxnMCs
         DukAkcTFKlYwP1k68+rx05UDN/e2EYgkS8hPJMcUWtAPOD/FUCJr62Dr+hmFMLhUS7dJ
         bpEyfXo8SEggkFOnzpSFzMpPCBB5EVyFMjPQAwCt/MXInLdyRgjjCu6NTY8PAUptbwS2
         LYod8DQtixfM8UPOBU0doXhaqMsVaNNzQe7IhFehR8BuRhpFoxE9dD4JteV9U0cDpvKQ
         N2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726056679; x=1726661479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ho+7AIPs7Mj1ey3Hhl/CyW2qOQaHptxWFNtHcun401k=;
        b=L8Eyp4sonqjDaWcn+VwrRjCd0YyShAnrnaBn4KSVrUvafOiCb5mHejU23Srru0fH9M
         /gE2zRLeYlrbHg8EWAg3Ffs02maE9+FL5AnHnIShQ5AZdBd5d3+ObPsYjHUE7/dor6rt
         4H6YB20iK3v1pLvTpkJVSiiTCdlCKYprFwL0/YClxgy4679PrFoNtCt1GCmV1qn0txII
         Gnl9pZdZzfnMOncpSDpzINkYv1J+acMqa5itc4WTXPQ2lUKJQDVM21AWrTmoXJa+gYhs
         gd6YPPXtNvgrJ7meRmoPIm8gqiDgFUA27IxRt3caqyzqd/S27m5T4CsdY3N8g+l/Sfru
         BuNA==
X-Forwarded-Encrypted: i=1; AJvYcCWFStX39/wPgkhslYGFBhHW4843RZC9sDVgeQUgWa3JFAsZdPKTLe8/7+JxHOdRD4qKHCIrVL099mw+bZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9dh19tQPTzYo6SnF5mJfYS4+IgSbvRbjGnzODFFwuRaxL77H6
	BVG6qgblnH9WNWiEjBhVzG6Doz4UPC/5I5b9FDEHynhveOyTh7zPMgRwluwx+9dKkBJOaIwmU7A
	bMuPQVPadq0Qx62U7hwLI0k4pHVAXWxXdOSnS2g==
X-Google-Smtp-Source: AGHT+IHAGLp8FFMpwA9BUsKJ9g/3gCMiYlxWvo5DEgx4Tv4M+C4I//vvNIEVPZXKv5ZFtVnEuoo+K2MZ6alrUTtiRsE=
X-Received: by 2002:a05:6102:c8a:b0:492:a8b5:b980 with SMTP id
 ada2fe7eead31-49c2429fd01mr2260268137.27.1726056678709; Wed, 11 Sep 2024
 05:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092554.645718780@linuxfoundation.org>
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 11 Sep 2024 17:41:06 +0530
Message-ID: <CA+G9fYuLkVvqToMRRDri2Co+EavEezCFeBmT9YkVTTqT+HrnJw@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/186] 5.10.226-rc1 review
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

On Tue, 10 Sept 2024 at 16:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.226 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.226-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.226-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b5b733d78a833f5453a1af52e5d2498023d526d3
* git describe: v5.10.225-187-gb5b733d78a83
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.225-187-gb5b733d78a83

## Test Regressions (compared to v5.10.224-152-gee485d4aa099)

## Metric Regressions (compared to v5.10.224-152-gee485d4aa099)

## Test Fixes (compared to v5.10.224-152-gee485d4aa099)

## Metric Fixes (compared to v5.10.224-152-gee485d4aa099)

## Test result summary
total: 89639, pass: 74081, fail: 2028, skip: 13468, xfail: 62

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 6 total, 6 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 25 total, 25 passed, 0 failed

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


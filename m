Return-Path: <linux-kernel+bounces-445992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 444D49F1E3E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 12:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565B1167C5E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BF2188733;
	Sat, 14 Dec 2024 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bpE7uABj"
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BA026AC3
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734175868; cv=none; b=Gqk6FyfQSUTCao0twH0+TazKEA6mBdMdgPiCbyY5T7XNtrw8IaD8LaDxZhi0yMDGrsAs7rptBw/9JrovchtlDlQRLR0+dSQubYY/wuUHEn9jNHKErg1Wx1ggG6CCK56HCI97QAu9o+yBggIAPZeEwmVOZmD017gFE25O9KflPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734175868; c=relaxed/simple;
	bh=43KipVF2Pw9z9cbEu8cqB5aRcp1OXj1CCOXfSA/uzxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EMewuRbB9HwyLza8RxZI7PFgSLtMFHkRfrwKFRGy3+tgTZKK7gtoWJURHujGIDzN497GpptPd5Y9z59bxhEu89S/m/y+PV2paMuLQ5vSK4ygkkvAHvpyh7J3iCqGimcK+jajGA+pTAdcj2aYeiK5mqgIXiVv3VmGBnXn01hrZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bpE7uABj; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-85c5eb83a7fso1160438241.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 03:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734175865; x=1734780665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wINs/DBTC9EuYVviwDfcguB0KxOhCrZVx41yGsRcNl4=;
        b=bpE7uABj+TNsTfSCvSlWunO66JtgwhhCPDxD5gIxsTFVhf+amrwZowE3kQcMPgIOww
         bYg8DDH7qZH080YdeDBAX4bgHoKjmVizMtOtJnqqkyGz+LbseCblkQaer1hlb59js5Eg
         ZmqSqD964c4MpzeM5CUvxjxgGL5mK4MCWNnvnQ6YbKyEDlOPXplSa+H4jea5u0WOFTrQ
         OyDwhLoDXJSgAkAnrMLXOLjkStENTwpwkklnOnLEQROQ3ebNbBfejgh5z8qmYcWIShxw
         IgpK9Cj8LoVOk9cIldbbgq8OMF2RICW2AL3uwyMDa6fBaTYjkYa1dKur22Gx1Mg3HV0u
         9rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734175865; x=1734780665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wINs/DBTC9EuYVviwDfcguB0KxOhCrZVx41yGsRcNl4=;
        b=rO960C61pzCd/WeIKm9DaC3PtZmfItUuIksPc7KnJc/DlXJzRSTQ6cpboKMBD7suFg
         gC0RsAuBOXwjv7j8k6mtfDKZSmHEe95nZcgfgJgUVI4f+oH+SAjTSBJPe0uMlasM+PTI
         HWUTlqXlCIIA+Chh7aMbpEM8+d7GdeutLVnJwnZJ26EVkCKL1aCSBdh5v3zWa5OqyE/t
         +MQUM2VXgzqlyb5QxOmjDB0ZeaGb8Y/otUe3t8C4dDVpsEbD8+cLgsH06afpno0mtkQj
         +t7sFpYp+qzwCuBazoT3ruImnIxwnrdvIJIsCReok/S/I/ldusIE/awp/vOWmuXQ7rIT
         Zr/w==
X-Forwarded-Encrypted: i=1; AJvYcCVJPNNxJAK3aN8LjQMbG+KEpTSu4ZXA7IcIIrDwjwoK7A4oKX18agWz4TGkSk3jlVgKfUc+yFSCAtQpve4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56LZShZIEmteQmJLoNklnTgrcjs3cuOj8QCvSane60xfI3DFP
	3xArREgyKum2oYIgw2qG4eoSFcv/3X+po4mkTFeXjrOPdcukVtYk7f625FVd+D748BJRec19zZq
	nEQxIE16KJ5llavo5lS74/OBKLRO7JsVzVLDzVw==
X-Gm-Gg: ASbGncvm+afFAkNkpWFGVD2P1texVAvnB93zvIITbdI9gZIiUi0TR0WL0Aq+wu7d2tK
	Ft83DgJagq8tuo8LnxybaeI/pVnWgFet6KwPzJq1HrD0ak6QMKq/8RyBivZPRS9O8Xe4HfYE=
X-Google-Smtp-Source: AGHT+IEwYSeSwQnKxUnjb0hVBvPLVZybDxCStSvKb6yannr0dzdp2jqI6+z05U/J+Az5fkcBa9FGHXcxZrNj9a0n4ck=
X-Received: by 2002:a05:6102:54a8:b0:4b1:1eb5:8ee5 with SMTP id
 ada2fe7eead31-4b25db8d319mr6446493137.25.1734175865046; Sat, 14 Dec 2024
 03:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213145847.112340475@linuxfoundation.org>
In-Reply-To: <20241213145847.112340475@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 14 Dec 2024 17:00:53 +0530
Message-ID: <CA+G9fYvcGBDRDqY7KzM_RrsY+G2n-nj9S5GT6vKYn+MYxNGmGg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/316] 5.4.287-rc2 review
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

On Fri, 13 Dec 2024 at 20:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.287 release.
> There are 316 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Dec 2024 14:57:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.287-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.287-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ce5516b3ce83b6b8b6f21d8b972e509420b4b551
* git describe: v5.4.286-317-gce5516b3ce83
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
86-317-gce5516b3ce83

## Test Regressions (compared to v5.4.285-68-gc655052e5fd8)

## Metric Regressions (compared to v5.4.285-68-gc655052e5fd8)

## Test Fixes (compared to v5.4.285-68-gc655052e5fd8)

## Metric Fixes (compared to v5.4.285-68-gc655052e5fd8)

## Test result summary
total: 53416, pass: 36691, fail: 3492, skip: 13211, xfail: 22

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 132 total, 132 passed, 0 failed
* arm64: 32 total, 30 passed, 2 failed
* i386: 20 total, 14 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 28 total, 28 passed, 0 failed

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
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-commands
* ltp-containers
* ltp-controllers
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


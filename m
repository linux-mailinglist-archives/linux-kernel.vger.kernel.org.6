Return-Path: <linux-kernel+bounces-241113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B59927729
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769151F22E4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D751AE87F;
	Thu,  4 Jul 2024 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DROiH7XZ"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271711ACE62
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099635; cv=none; b=ch3opbDjuNFwDIxpdEe68c2U0uzz5ob3dGvc2FQ8pd0DmMgjov+n2Yxv7LK/lFTyZDS6Ma/ipyWnArpQXv8PtuyNTUo54R/VJcwe+wM4w9GSTnufUF7RMTZspttI5Tj5FjJp/20XT6V+YASLkffkPfQgNgbJgOqaaJI0dbfZUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099635; c=relaxed/simple;
	bh=nD4dlFykd0rag83nMKMbIxA95FBUzMYgo1O2Eewwq0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DXYavOTYQPoR05OdyGVdgka80wXPg0TQRnbTmVwQ46HjB9uYlW60JFAUMINse+fAWSjTFMICpun3lAmvhXVz2yrOkhlEaEgBS301FTkfF/Fz04mZbYGQEnqnSqQrDcQu9BTWfb8rQLArq/m25J0Zgth1iT57ngxfhPQE4wELRd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DROiH7XZ; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f2e2d03ecbso388860e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 06:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720099633; x=1720704433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcUcUtX7e7qX8Zg3ofi0CJpQeDuqdz1vevOFSzSU7OE=;
        b=DROiH7XZXscMh1b6a6XqJrDmRONZB26VJHM9sJZOLUtcP1enUxKz4EmmqARPJyDpC6
         gziGBZk+E/nrpiQoTq3+uikrfCgoGDj7Llp4u4jqU5fxzIHOAL2LbV+4MCCMBJNz3I7x
         f5d0VU9ezgiXi4lPg4o90JAeznPR0GrzU1rQO4nIxth1VDgewwJLGLDB9f/NHxnvdHTA
         hGWdpJ2oNdDqTCfFrYwH60zcEDggvzW58cAEe9OL+Bonec0iYH/BX27g9DDwiJXrmOU0
         rog+ak/U99oUro649c9sEwOSUB+iyaMsGMn6G22ORI2Tu0zb0C9aORcm/xqN7feryS3X
         63IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720099633; x=1720704433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcUcUtX7e7qX8Zg3ofi0CJpQeDuqdz1vevOFSzSU7OE=;
        b=XLjdx5/QsWZDpHpYpoKIXPbeRxvA5tW6/aEGQumi5EbdZg2GuLTFmWQ3KzqKeDJdtL
         zQ9RvdtEqkmRiJEBc6VD6vs+nZvY61VD2zfAVyyfQONAoShnBHZ8P3QyQYvJRQCcu8t/
         RV5P9XrSqq/btwdjaVGIFZNQdYi2IrXFy2yhyUmmIKZaFN7NxGzJ6u4oMVKrfrKfXN9Z
         1MxYjgUu/oHSyfXkWsMKofUCtQ8bzmkYzsg3HHYWOzp9UtxCBbC/N4jSwBwIgVvIb3Um
         v8C1jWo1MzQYDsFuf8pzsSikFK5nRKt9aoymMRexrtO9kA27R2pnjd3llweF7jqLAtKP
         gjnA==
X-Forwarded-Encrypted: i=1; AJvYcCVaZ2N/nzsPv4B2PaqQl7dIa6OiiThjJJGeK24GwWGFut3XIbCuMYfb+KUUf427u844P+wW+FGqEulG6sAK4+bE7XxILm+8QwbjFcHI
X-Gm-Message-State: AOJu0YzEblK1Wj9ij97mAQjMWJokg22a+rG0JudjdbXf26QwgoyiWHys
	RyhidQClqGNcWLQk2ok72v8dsr5zNqrbzdcSiW17uCfhlQjtlcNBDt2jff7sBNZt4dd3PFkvy9X
	qBEK8ou40UNIlJXQmOkziA3XFvMmgCkOCA9GfSw==
X-Google-Smtp-Source: AGHT+IFXTAkShQutIlODaFkW/XCcuIVPd7eCwSuN5P4hK7O4yvbWqnC9eeky0EmDFKopq7ju/gRVhcTihk9V57g5D4I=
X-Received: by 2002:a05:6122:4491:b0:4d3:34f4:7e99 with SMTP id
 71dfb90a1353d-4f2f5e234admr889385e0c.0.1720099632987; Thu, 04 Jul 2024
 06:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703102913.093882413@linuxfoundation.org>
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Jul 2024 18:57:01 +0530
Message-ID: <CA+G9fYtbcy5eRrJSuqGPJxQi58V99GFtepxgOYj7qXHmoD0R0g@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/356] 5.15.162-rc1 review
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

On Wed, 3 Jul 2024 at 16:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.162 release.
> There are 356 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jul 2024 10:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.162-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.162-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ba1631e1a5ccf4fa69f692369f3f80f200b2678b
* git describe: v5.15.161-357-gba1631e1a5cc
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.161-357-gba1631e1a5cc

## Test Regressions (compared to v5.15.161)

## Metric Regressions (compared to v5.15.161)

## Test Fixes (compared to v5.15.161)

## Metric Fixes (compared to v5.15.161)

## Test result summary
total: 132177, pass: 108849, fail: 2842, skip: 20352, xfail: 134

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
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


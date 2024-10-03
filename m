Return-Path: <linux-kernel+bounces-349145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAF498F1B8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B701C212A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49E419F419;
	Thu,  3 Oct 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wETjuZ8D"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351A19E7ED
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966594; cv=none; b=hT3Dm28OqKYSYLA+BkC9nVvwrUrgPrOLG8LNofNar/IQnPoIJfzMWzPbHgez5WL+12y3nmCYeBELCLXKi2K47ARg4Zl2467XasIOkbQYFmKQoC33hDqYbFnA2pFb0eKXiayWYeypZNQJuKrHl8Wtmv4eNlZJ5wTqt6G1SDIeVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966594; c=relaxed/simple;
	bh=nzrT9txoUNm2tCbFCELuiWr769P/fLWk67w2gdUIfNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2QT0Alw/uarBytr6ped0q133rSxVAn+kaQ9LZD/gHY+Al/GOIUb97SF7monrDBs/2nTcx2EIzYyYvPSh7nNo+JIxBxcdT5rONjJog1+Gg56polIKw3KMyQS/Bz5zHryJ7w5nbJ29cCwQ2RdVkdy8EBRDeij/hmLkpKpx3YzcaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wETjuZ8D; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4a3b97cfbf8so432852137.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727966589; x=1728571389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzPMIwM47GdFMCQF2aB/8Fmv8rw2SCurIv7fQEUearg=;
        b=wETjuZ8D90NfaPHpHL3MsxPKJzGNV0vab//CJoknU1YixSxdVxgxDKEsVA+VUTWFBE
         1OtUEaFfVC+VVE+fSI1QROMvcYN0Hx2NbtPaffX8M32d8k0s6RaDj3+wEzI3201YuZ1R
         dKOTCXmryYoR0wZvwLnQsizg0mqubONHm7lDj9OeplPauz247YZfLMEdgz78KZx8WyXm
         XGAatp7WCbJEADxfhRy7gewYKuBlUAPHphV5ZB2SM5XbgqnOvzTS69Thc2FLOS1zwqiU
         fNejxRxQMvh/W6S3D+kclD2jJYgpBBdC8opcr3oKDzXn8tx1M9uQzgrLGOQz1MkRbBlU
         2c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727966589; x=1728571389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzPMIwM47GdFMCQF2aB/8Fmv8rw2SCurIv7fQEUearg=;
        b=dWxOpmk53oq1C/45cpPPlUgmG9mqhv/ZBUTU3fxtAN+Ua45+jVUBPg2fzZfrK5/DQz
         ucqwHN+kVYz/M2PF7TYEj+ZyJVjuCH3wvpiInMknSJn13Ouz/siRG4yropaqe3icJZAC
         /9qdzSrBzClrrzye7tFVZrVTiHeEl9D6jYW/E27sGmLGU3UCQQ4mDoSKmULyt/ZI5a6x
         Hs59KSHnc19/Rq0Lw0vgRSjjGEYjlIw8DbDj/3kj8m21eVi6zG3C70Y3fhLJ3LUxfuDq
         nmErlpjeiHu+oHFbF/lxu24UVvAAgtlQ0DE6J3FJs4RdU1XEh9zUpo5GCNKYsy09t9Qn
         /I/g==
X-Forwarded-Encrypted: i=1; AJvYcCXXbMWQg4vunaVyt87yHwArsXZlk6qUvphQfN0SySvL2pVeKu2yO9mEePSVve5fGG9ojnOL/XrmakqOHig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN8kYBMK4QQ/+TmWy8xnJrxxvxiaV+8eat5CoXL3phlTvdsgkg
	jxhRKsfPbqU7rrByLL6hSuHtxZ4jN2Lbo1m3DmeTrB/6TkS5kmG0W+2cMQf663sg01jM1+WR352
	NpiWZFC9eN1H/ziUYLDHJksK/zrUOIxVVJlw8Ew==
X-Google-Smtp-Source: AGHT+IHeWg3AMl+TwKVwk49s+iH8ah5Trk6MJpXj/71J6Q2kfTA+Kfp/l/dkdK73jpJ/mQ6L4Jh9SUs/ymqKlo/mYG0=
X-Received: by 2002:a05:6102:c46:b0:4a3:d8ab:8938 with SMTP id
 ada2fe7eead31-4a3e6852752mr5954103137.12.1727966589244; Thu, 03 Oct 2024
 07:43:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003103209.857606770@linuxfoundation.org>
In-Reply-To: <20241003103209.857606770@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 3 Oct 2024 20:12:56 +0530
Message-ID: <CA+G9fYvAAKwe_LMb+cXnLoDE1a_Ji2o+C6j=ud64ET3wbiZTBA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/533] 6.6.54-rc2 review
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

On Thu, 3 Oct 2024 at 16:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 533 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 05 Oct 2024 10:30:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.54-rc2.gz
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
* kernel: 6.6.54-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 28c7e30f3bb639399f5f62ae5f201bba7dd69e55
* git describe: v6.6.53-534-g28c7e30f3bb6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.5=
3-534-g28c7e30f3bb6

## Test Regressions (compared to v6.6.51-145-g3ecfbb62e37a)

## Metric Regressions (compared to v6.6.51-145-g3ecfbb62e37a)

## Test Fixes (compared to v6.6.51-145-g3ecfbb62e37a)

## Metric Fixes (compared to v6.6.51-145-g3ecfbb62e37a)

## Test result summary
total: 169067, pass: 148166, fail: 1582, skip: 19133, xfail: 186

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 10 total, 10 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
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


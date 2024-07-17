Return-Path: <linux-kernel+bounces-255501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D366F93418E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032221C21288
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533651822F6;
	Wed, 17 Jul 2024 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJ9C+weO"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3488D469D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238169; cv=none; b=GgzwGciDDt5QSntgX0P8G3YcaVWnjcNqacEDdpp+V++EgYsqnB2HwzirKZzzF4V5ktPPGwkjL1eUPfO6uiPqo2muNY93RpNj+YFm9zY/6TERk3hnZPtAKqLBWKBSVeHFKWPBeI/BLHHb2w69GiY95BFOUM2LeMshrLlVNGSH7Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238169; c=relaxed/simple;
	bh=imJsjbJjC5BO/0I+CVhFcrhloI6xPXF6dE/sgRpbsbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlyAqi01VQMMCLsRobeBeoFH+zPBVAckWA4j1cKWVmPiUFeVjDsQRBh7a+PlqoXoKUvm3s43Vi7QI48bUugHbBLbUpig254tY/LFi0HgLqKSwmqhTF6p6tyjQXfqj3fA6rNBPNU+ggiywM7eBSR3v7sO22fy1ZV9W9kigCkOgXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJ9C+weO; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-48ff6336bbbso397572137.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721238166; x=1721842966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKqzAXRCryiZEV7EYlPm2aB6IfTgW4/PxmTcBeXfLYc=;
        b=aJ9C+weO05BCuMUES1M8qrd0a1WhlHsBTsZMmP80451PKoRj7QsHuwRpgZJ+t+9LHg
         n83cwEOLZC7ksNqriraZdTavsq9tZ99S9Kw8KLUJCnIrgRHw4z2dbv8kAkum2KMgtJ7d
         YZLXuRv1lAOyHWd3UYixFgSst/12viyKoEoryaqeDVChh5ZFfNaxBoeTMfSafs8TPQHd
         rBE1tkL8PVn3iTKmvDwBcmaNs3BLCjjD60MEQyjirIfGnRcUIYTy6EFZG735WsxtQh+x
         TNf/HP+fdlZNoSpyMMqb2eXnadeUdulxzpcEUOqRJCoiqKJeeypRrXWpPw1EzjtV9SMk
         aWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721238166; x=1721842966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKqzAXRCryiZEV7EYlPm2aB6IfTgW4/PxmTcBeXfLYc=;
        b=mxZZkJlwvM/fz/bs1Fp2QECczs0jfD6+Wc0RhbfynfKh9h1c3cdxGs1QpVPaWONwZE
         MuruSh7Ze9NyHy+D6cXF/VndTBUF+I8bLGDZCk7vtYNv3Bx0n4rTYHQ8p5irnCChDTnt
         +E2JQ72MxMHbTEg2n15I/uEMjE8ZW/GNbEGIJ9emMB4KN/kl6d2cvHiPFcnfJrkZxq/m
         ar757Dr35n5nnwtEevviwztgDwg7ZNi+as1AaXOkCrHHGMEPA5rm0D/ofLlmexxyZNDM
         rCAuQmQ61xmloArU1sYxG2Z7ZZBX3z6smE3/XrPLYViRenh+TtzTWi6gWO2/jchZCEM0
         1fjg==
X-Forwarded-Encrypted: i=1; AJvYcCW9FukRq5b3U3c4ZY/wfGSWwPdbG/xZm080VQ3mpkGpexN2t2QOgnpsMpNRC+wcWDtSFAuAEpAIdyn/qo0euVlNDAmH68wGXcpR46HT
X-Gm-Message-State: AOJu0Yx2NGtjVjV7smpBzifT21jSYdhTJYa4D+/cA0OhbAMMk/WD+ZTa
	NaG8e9nm5R5Hw7puR13dzETmjM5s8i5amMpy2VDeGsWa9Bi8PafdOZw8cuFh65lThTFvWEvxWP3
	GFJSPt8WbGgE1jL4uKvAAycE224gnAjTypM7VYA==
X-Google-Smtp-Source: AGHT+IHtXe0A1H5suV6al4yCBqOPwnstQHto1M+99AxS7tG7VGtKb60tWSsPi0pD/O5MedMSjz9tMT1qUOuIyOJvPhU=
X-Received: by 2002:a05:6102:1524:b0:48f:df47:a4a5 with SMTP id
 ada2fe7eead31-491597a6557mr3452607137.11.1721238165943; Wed, 17 Jul 2024
 10:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063804.076815489@linuxfoundation.org>
In-Reply-To: <20240717063804.076815489@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 23:12:34 +0530
Message-ID: <CA+G9fYsx5tFng2+6f52ijVck3dKvygR3cW+F1txb0UP8AK9JKQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/145] 5.15.163-rc2 review
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

On Wed, 17 Jul 2024 at 12:09, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.163 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.163-rc2.gz
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
* kernel: 5.15.163-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b84034c8f228ff36147b71fd57836ae4c4dd684a
* git describe: v5.15.162-146-gb84034c8f228
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.162-146-gb84034c8f228

## Test Regressions (compared to v5.15.161-357-gba1631e1a5cc)

## Metric Regressions (compared to v5.15.161-357-gba1631e1a5cc)

## Test Fixes (compared to v5.15.161-357-gba1631e1a5cc)

## Metric Fixes (compared to v5.15.161-357-gba1631e1a5cc)

## Test result summary
total: 83799, pass: 68345, fail: 1539, skip: 13831, xfail: 84

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 28 total, 28 passed, 0 failed
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


Return-Path: <linux-kernel+bounces-208683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9EB902818
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770BC288194
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5366148841;
	Mon, 10 Jun 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgUBGxyq"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733FF1482F6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042154; cv=none; b=c5/w0jvlg45YaH2YkGYf8Eff25bosqkEf6eRiFVso5JDgwzMhzVZZBVCFBjGsuHbiymeRkjVt8bEmVe8E3spS06nX5pISrIkl10KCnS7mvsPJK6+Su4eOb5LNfjQwCWDp40KdcjRGMrrLJdtdr4UFamq5e02gBvkKFp+OjmehG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042154; c=relaxed/simple;
	bh=dNjI23WLp0imEmdkBxjx2VmizbZl9IeRvfhVp0aj6lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpU1QyEvUK9aV4ZxTe+oHt47zAUz/eoWX00VkHadOa1qmIESMxg+o2h+wY4eM6PAaMTJTfLxOVZcIX0SN/f8NqGIEx4cz8b5wxUF3SQHHZ7w3QbPgHpqWPyo/UcbyDtMi4eIK7YT0bOCb3up6HjRQsd5ZPvkimgUR+IiNcFHoL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dgUBGxyq; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4eb14d993c6so1334468e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718042151; x=1718646951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+JeefLMklHAV+yI9qNZHPNA7M9EgyySno86Vwa9gbA=;
        b=dgUBGxyq/fcVIEtn9zuN40+c8UdD2x5D71HmzNvU6KDq0K9J0WG0i4kd9wE4sGErZG
         jHBH0IRruGIDjajhOrjOrGjWYU8MGE1oRkoq2lCvEdoW7K95k81yEp5Jlg+Pnee2JuPL
         ITM+0Wk9VIkSkWsLj7Qbx+vNBYKdl5fVR6blnUlZBPcILUbIH9r7AfPYnBngZfC3KNSI
         p9/2OY8f2Bf4xXEab69+hBPF7xjnmhowLuDb+dbG6yVPTbCDYZr3Gj+XEzPfs1q7OQkV
         ClXTTx3XmmiR8m/LZqCa50NsABT0n1xVlev3tVhIQZgFO2fiH4C5tke0p74f2emWm9dE
         0sLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042151; x=1718646951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+JeefLMklHAV+yI9qNZHPNA7M9EgyySno86Vwa9gbA=;
        b=a9QwcdMFdotFhQK3jS/RI48bkQw+cGjc7jVdxk56N6jnM40UANJCuylddwEFkQ93W3
         4d6DAYOwR7WDvxAw7WQ1z7FX8P2tYmltjt9uYbh9blYtEDPCdIpHyv8byKwG+4HRLhuz
         /C9bW+7g3mrZZ9Xi0Q6SRonhnVb83XmZ9I3dl1C5XtQZkcoSsLBhNFMb4ZBZ/PHiMx2k
         GmxtUK6oEO3ZOZ5g1CCrZr2R5dqHWiRUSpcazt694ee7OOsyALxsq2fNPAUfd8LZgb5T
         Px3cTL7u2w3fyuiYm23Jxn9oAiFaE+/4ZGCWwnaUmbY3FUWkUdvI2LOZ2BvzVJxDRgcY
         OhNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR4yN3sUOoWQV50jVLEAtvRKoROWe9cGgwik2K5yncZblVSkd05hIYEgt7uNDeqjinOygpHTjaiVOqtzWbYDP6UgJCGp3gvyJnM+kn
X-Gm-Message-State: AOJu0YwRGpjvl9eIPXHnWM/FrRRzZDAl30f7sQ9BQvWSp/ZxztLmlfRt
	46CG6zPR0rdnBPDDrkHGxOyOR5gW065PlI8UUu7XMAzHX43qT9HmbQa2fo90CZh9AZ2Wzvub3Ag
	sveazDTpTIoH6EX6ivVMnvYPnsYw9xzIwtR5CKA==
X-Google-Smtp-Source: AGHT+IEdg744iLrX6ZtbyA6vFCgoj3lzq+ppqtfCzhKioG9uraYqBhXuiuKLGd4W4eaRkB7Qken+1OHN4uBNCiH7lcM=
X-Received: by 2002:a05:6122:16a1:b0:4de:daa8:b8e2 with SMTP id
 71dfb90a1353d-4eb5621e208mr11288152e0c.3.1718042151230; Mon, 10 Jun 2024
 10:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240609113903.732882729@linuxfoundation.org>
In-Reply-To: <20240609113903.732882729@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 10 Jun 2024 23:25:39 +0530
Message-ID: <CA+G9fYs1zvpNDYiRL83Cs5D_o++QHQ5rpwjQHSDCPr3GM1bAQQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/741] 6.6.33-rc2 review
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

On Sun, 9 Jun 2024 at 17:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.33 release.
> There are 741 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 11 Jun 2024 11:36:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.33-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Build regressions on riscv reported.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.33-rc2
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 7fa271200aef4ae8f0bed8a8ed81629ecd5ed2ab
* git describe: v6.6.32-742-g7fa271200aef
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
2-742-g7fa271200aef

## Test Regressions (compared to v6.6.32)

* riscv, build
  - clang-18-defconfig
  - clang-18-lkftconfig
  - gcc-13-defconfig
  - gcc-13-lkftconfig
  - gcc-8-defconfig

## Metric Regressions (compared to v6.6.32)

## Test Fixes (compared to v6.6.32)

## Metric Fixes (compared to v6.6.32)

## Test result summary
total: 237984, pass: 198342, fail: 13030, skip: 26078, xfail: 534

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 33 total, 33 passed, 0 failed
* riscv: 17 total, 6 passed, 11 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-x86
* kselftest-zram
* kunit
* kvm-unit-tests
* libgpiod
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


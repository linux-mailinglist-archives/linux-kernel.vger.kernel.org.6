Return-Path: <linux-kernel+bounces-416893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4949D4C15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 12:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91FE1F21DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFCB1CDA18;
	Thu, 21 Nov 2024 11:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skISQ7z6"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E6F3C47B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732189107; cv=none; b=fmdL2vRU/8/46QF5necG3RPch3mq4nFFII4Z07qsdR6IE40FYjgBA6T/QzzZ8q2Jmfffd5hhzt+AJZMMQJc5ZgNoLiifETyrZomRzDG66dI8bOHpFb6XHpt/fAYhgRd5wPbWRKcKF+v04sSLi9qmD5YigUL0UPd+C48JMng29UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732189107; c=relaxed/simple;
	bh=GoTq39iPiD/MsBXuMgTX/y+bT00dhL9Tn6diA5FsVT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZiXBcbNHkWYguKW7Z+3J3EiIWhJKCy5MKd8y8mEq4w6NIZF45p8kkZsuXWxOcJna/eSc4+QJ+6haOKQ8LZcqNwjEJPr4gD/03eS8CIpCe7Ki92w3e5wqdYZ2qSXmVx+79os2RWCBIz9j0AuEObjL67QQ14tGM9AFLK0j5rsGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skISQ7z6; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5148381f2a4so368988e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 03:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732189104; x=1732793904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7ukX8ZlTj96KIQhfZzpEJEoiPzLwIJpbM5cfdfMhxs=;
        b=skISQ7z6dE8itZoqKWTJDXxDCcYQbP46Dl8EdiRMNDG4UyGCEgd0hPjCTcD5kgm3fJ
         ssy33UZdHwr94FbuCJFspS3p0GtYNbwR+BEj0467tSmhudwgXpZrEyKTsGwaq1OiPpfS
         sXwr7n5ccnMAMpvtQgnRC15n7OWodjxwRjCafjd/luW4MdhE9ggRkMYfU40dnrRcXXUn
         jEoH02i5dYQii4r/rRRjSNCOPnQsH9DwrI+c6+zhyi5mTuo/ls0ZzpzdjTbEWmmIdsAK
         TB3UQKHndQ8ZBkS+phtcvjd1f9q/ri3nWQUxUTD0AA+hldVD8rBZJ4plK0mxMrNRdI+k
         SjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732189104; x=1732793904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7ukX8ZlTj96KIQhfZzpEJEoiPzLwIJpbM5cfdfMhxs=;
        b=o7nzDdnpyQYV60THpf8/HVXO4QEGnz5qujloHPx7+lXRKEdzjZpJiM5Bn5BlEstApE
         TDHuNYEctZXj/Q1bziXGrrs+F8X9U6+y1I4QHaAIbT4JVFkYahe6Ybgf2n2HIEGM/P82
         vnVC0F4y8eo9JTQ2T6s9lAHNe0WR8YItsASv1zTni00Cp7bS9U1BWSr9kAL89xWKuLfC
         F/JHv8htnt9YMlzLa3OyD2Iugge8Ba9JmgNZgqxxbkA+eDy2qINR1rzO+6m3Y9x/z5JI
         k4a/fOgWh7RWZDV4CdN5oj8a6QvIZTDAw3W2fyEF/MiPKQlOS8VY0dDtvkTS+bU9tHYf
         ygmw==
X-Forwarded-Encrypted: i=1; AJvYcCUXje+uXIOzALqKzyc/bYJ5Ms5vNEfsEoLCJkzz/5AC6C71VBrxyihOjpDFgYzBb27VtJQhxHx0xrsoaec=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHDZueA6PRN41O4umlCXPKAM1uzV08VWzSgI0tDUimarPtotc
	1mKW8Tn0rY3uCXeudy4p7JtoReEJ/ROiK4Gzx/2zplbHnx05eeJCuTa7RE6Vd9wFAK7thm/XbeJ
	fWw5IPIFq+/0JOoRjKxp6Chmn69alqcRFGRGnHA==
X-Gm-Gg: ASbGncvqcNMrkDseP1XiMFI/H8a89T1cETMkfsKzYqSDLmxr6a0bQs6XM+e1x3XejkO
	kmfyUINhRVh6k3CA1NzWJGomLwCX6oV5GKIIqvZdaPhb6Rmj7wWrVB6tgCAw3epyh
X-Google-Smtp-Source: AGHT+IEmTnYwUS/GoFS5lHtmsk6MPCKN7/BBErYWheG+A2g8DHXNCtrFTmlMdEgbpvkK0+ZlnzCUB4v1D+drV8T/SYU=
X-Received: by 2002:a05:6122:640c:20b0:514:ea11:4ee5 with SMTP id
 71dfb90a1353d-514ea11529fmr708139e0c.1.1732189104384; Thu, 21 Nov 2024
 03:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120125629.681745345@linuxfoundation.org>
In-Reply-To: <20241120125629.681745345@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Nov 2024 17:08:12 +0530
Message-ID: <CA+G9fYsaZNm2VKnm10tR4dy0DfnE3_FQtkj-E9-SPR-RacXxcw@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/107] 6.11.10-rc1 review
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

On Wed, 20 Nov 2024 at 18:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.10 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:56:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.10-rc1.gz
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
* kernel: 6.11.10-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c9b39c48bf4a40a9445a429ca741a25ba6961cca
* git describe: v6.11.9-108-gc9b39c48bf4a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.9-108-gc9b39c48bf4a

## Test Regressions (compared to v6.11.7-249-g0862a6020163)

## Metric Regressions (compared to v6.11.7-249-g0862a6020163)

## Test Fixes (compared to v6.11.7-249-g0862a6020163)

## Metric Fixes (compared to v6.11.7-249-g0862a6020163)

## Test result summary
total: 154549, pass: 128415, fail: 1847, skip: 24287, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 130 total, 128 passed, 2 failed
* arm64: 42 total, 42 passed, 0 failed
* i386: 18 total, 16 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 30 passed, 1 failed, 1 skipped
* riscv: 16 total, 15 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 34 total, 34 passed, 0 failed

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
* ltp-fs[
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
* ltp-tr[
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


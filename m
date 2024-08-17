Return-Path: <linux-kernel+bounces-290546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A806095558F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 07:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C821F22F3F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B7E84DF1;
	Sat, 17 Aug 2024 05:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yquwr/Xw"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5696E619
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723872966; cv=none; b=W0y/YA13NMo6J4BizQWiOmZoNjZAspt3GYQ9HDML9I9Fd6O69ncCshMQvhhNM298Q1HAe43Xz9/C5JLPrYPic0i4szO1tTqlFYDJvGJhj/fxxGBJ6nvw9cZlEXsOP5HlYZ2chOw8ir4wMNlnTcbqqFCrKwTjAyfIKeHftSlnBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723872966; c=relaxed/simple;
	bh=RM9YaYzvXQ2M5fRjuIbDzSe8exeCQT2/e0fLWHqYB+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oM/dCqYadKFkkMFvwDI+G9qUBMFiScp9EQnJc0mOZM/SgtLqdx+R6MKRK73tEHVp4MJKYD/4fcj/jpgqqagsZiAfvt4lmq1yNFjYHXv2RfgrZAe+rRTXHSFkuiZvBaRGSc8oBweB25SqmRmMRleD4/46tqBOjC3oDjnpzJ+805k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yquwr/Xw; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e11693fbebaso3092516276.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723872961; x=1724477761; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wwnYvivhwo7HTnRYBvPWtXjI94eqOQfUm1vAzlj2GtY=;
        b=Yquwr/Xwf5Xb0n/2gh6BHmxIlOexTsswX9KANXACvxOkNLnTTPpVbgdct9ftbZsohf
         zF91UhC353HKeZmK0ugGLVl/sN8dAQP8q7aTmfe0VMAMwgrxwRTHGdIFIhjHDQ9XUT6N
         mLLEnBTsWpUyscx4JhDp9AxNQEnNkW+E8FsAZhN0ApOQCtB3KYf2NxMQONnQG6E3wG/o
         xLKbKG8TrQFZ/prweE11gici2oELA5QnWCqiOO3mX15KfYjPAt90f6GxsQ+MEN6fZoiV
         bhh05virXd5Fk+qAxZvuhPgqeazjoXKImyvfB0rYPBZ5KS3FTZydkqX1iWBgmNiPDOR+
         l70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723872961; x=1724477761;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwnYvivhwo7HTnRYBvPWtXjI94eqOQfUm1vAzlj2GtY=;
        b=gilmQe/3zU7CLxdh6/Mr+xDg1NzDPC4qicI2SAfJzjsLMB4YwKOu38STy1NHclDb9Z
         8NW2yazNYrN7wh4WbjszZ/hNHPR/WOJSWd/Ht/VqbfHeUwoRlMSlQnelpxLdKgzYs+0w
         2hVTqpPdVSYY5Y1smrswcBZKQ7sZJN2h+KVyQehk0HbwQERBrE56oLAobVykVH2TCtGp
         qIyqfbtezJgaeo8Hk1AqeaC2borMqWZVK9878j6MU8XckShk0JPyW4yl6AFAxU10AySY
         OcJnydERxczWymR494JY11ePZN4fXCHYYwrDya3NjYHCs629oXQiMNzJIJjhhaka2H9/
         SgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkx1L7rbdJzeBrbOH0RJFPmmoDReQV0ljmyV2X5aGvnxBRB3ZEBUZ1KsKSMdkO1ZaVcgon2Qj+bpg9Zg6g0DSw1ACGrYrAMgoIGYEN
X-Gm-Message-State: AOJu0YwefCTaoBrkEOwpIKf7lOtCoKwIVntLEPVGNYjHEEa14n6BPIZQ
	hcRkRhsoLgm8+HYT+C2gol92vjBLTI05ane/ByOxUO45kc7hb55ZwDsCxV31df+S0fn/lBI1w0F
	EWIfHJlf3HNwXsfv3sxoYSH9soPszpmw+/uryQYI2tNIZgVFGcLvQ1A==
X-Google-Smtp-Source: AGHT+IHHUTj4d8yuT4sHOHbpiO6zA0dEVka877xzBWcqshuTl2w7TVskPEncoKVQrmeLFmEvCwAv3UCxu6q81mtXqY8=
X-Received: by 2002:a05:6902:2487:b0:e0b:fcb9:28d6 with SMTP id
 3f1490d57ef6-e1180e6b2eamr5526408276.9.1723872961547; Fri, 16 Aug 2024
 22:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816085226.888902473@linuxfoundation.org>
In-Reply-To: <20240816085226.888902473@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sat, 17 Aug 2024 07:35:50 +0200
Message-ID: <CADYN=9K7BsQrOhQ2RiP_uRUXVQxY2FLOtCMmjsx972asvJY6Ow@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 11:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.6 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 18 Aug 2024 08:52:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.6-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64 and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.6-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: a391301088d22f85440ce149f6c2a63e6f0c72c5
* git describe: v6.10.5-26-ga391301088d2
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10.5-26-ga391301088d2

## Test Regressions (compared to v6.10.4-264-gb18fc76fca1a)

## Metric Regressions (compared to v6.10.4-264-gb18fc76fca1a)

## Test Fixes (compared to v6.10.4-264-gb18fc76fca1a)

## Metric Fixes (compared to v6.10.4-264-gb18fc76fca1a)

## Test result summary
total: 221567, pass: 194733, fail: 1907, skip: 24567, xfail: 360

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 127 passed, 2 failed
* arm64: 41 total, 40 passed, 1 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 26 total, 24 passed, 2 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 18 passed, 1 failed
* s390: 14 total, 12 passed, 2 failed
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


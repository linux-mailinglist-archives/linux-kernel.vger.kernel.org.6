Return-Path: <linux-kernel+bounces-290547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD4955591
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 07:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BD3284BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 05:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4992781ACA;
	Sat, 17 Aug 2024 05:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3u/zd+R"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1956112CDB0
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723873074; cv=none; b=jadBWJ0WOzjYmvrsTZ1nJZ454+KMYJ75wu/4hoNDDZrA53MjrvFi5n1oCoSQDQKy+R6qomlJwQIi6mdOByAtDnbEWm6fK1EwaBaJrVykdLD7ueL3MbzmC7mlxbLqzqjScuYO70PTK3fZ1sdoXwfol93GJx+zKEu+rwVG1875ddw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723873074; c=relaxed/simple;
	bh=ujOztsrgUtLCkTBUlHipOetZmwwdWGPqzCzxoHRIJX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leFvijE1FTIkElg8ejNuV/Y+rz6/s1Fwz8/OU4H0asW6L6ytKqug6TvYx5XCCZQBriSkjF72n6m4undJdjwdUDOfQPfoj9+iDvgfKdG3sjMyEBw0tU99vTMWhwRkfYioqxh+741867EzAhijx/k49Qsj8aCjnqd6c0z2dG9MZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D3u/zd+R; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf6721aae5so13813056d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723873071; x=1724477871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B9dSjIaAHGCyPPaVCWVW6TuKrm6s6S4lX4QXVFVhLL0=;
        b=D3u/zd+RnL3vSADZMD2IiH0NDnw+vPU2DGKBR+xY0sRjWgtWT4pVXvfB7TKFYH1bIL
         hN+r1cPBGrmDa2cjiM5CtASKgVIhP2QPY/yARZi0UKij70IVtrx7QhKuWwgh9B5FYRe/
         HlArbQwbgfQq/C0I/AMZzpHmviQQwRVogMPOR8Lb0AkYtYQnDouEmqqVc+f1Lw8pP+Ql
         ggYPBuLJl3+lFVOdNGRuaA5QiJI7X7FFTIlqJ8yb9kDBFaGfTpxokR3uzZ4qj8dYxxzn
         nLb3BwCwmmNpxpYVaVnZ0RHMTH83cdwLlvYqrXqYPvdtGJ5WY5MCfr1rQ5n7okLSI5pG
         JgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723873071; x=1724477871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9dSjIaAHGCyPPaVCWVW6TuKrm6s6S4lX4QXVFVhLL0=;
        b=ggSW8HcEyD4Ldu5fs6daSHtKzOiuEZ4ReBQNw4jL5lHaJN79ubrzPuwGZ8ndlaMriR
         1d0N8sK349r/hUPFoD43fUAxYp5jLeTg7NweXMQmZZwYuG4LyQ7QfJXQsERgEt7DSFMW
         JUPYjcr0O5IaAMC6FUZW+4m39OyO6A61IVR4Pe5FpNkXs8IXwRhE6NstTk9/RVPcyhxm
         TfkkO6nWYj8Wz7OmDdjc0Rrw0SbpVIQMrcOuPXMCfW4Fa7hGHu/4bbpHxvgX29BTItW+
         /UZxSwS26Mz6c7UeQf+LqEm/3TCHjz4fLJzPU7t/Q0HMhM+fCMhG80fr6DzBkBxrWdMx
         VUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVse2dw5C+fJ+VbZe7QqekdKuS0LF7VLmcg+X9geTC667+CiLRAdWJZxKU59HgxEmhTt47KpG2KpG9/LelE5w+XMiA3HMv0ffvE71ol
X-Gm-Message-State: AOJu0Yw4v4k2wupBjNKVUe5y7oHgkI6Pe03nhkjjhKMAsLZYXJOOQpqd
	5YdCRmlslo4kuBi7JhtLoFnedFwKNj8EfSKpVD4vlRmB0dkvR0E0hInVd1BkwQXBwOV/N2NJfK6
	cfwc8i+mwh3rO66Hi0eBViW0IW91ax9YMnNVk9w==
X-Google-Smtp-Source: AGHT+IE41BzwdEqIQUO+1LkM52qPPXRw28C3Cm6JIiY2t7NJfcA7rB2LPTC97GSof/qDgZo/9EYft+CrYFvMBzjyX0M=
X-Received: by 2002:a05:6214:5f04:b0:6bd:80f0:42c7 with SMTP id
 6a1803df08f44-6bf7ce5b4b5mr59785926d6.42.1723873071026; Fri, 16 Aug 2024
 22:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816095317.548866608@linuxfoundation.org>
In-Reply-To: <20240816095317.548866608@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sat, 17 Aug 2024 07:37:38 +0200
Message-ID: <CADYN=9Jhe2+1Uw9uMQxaBThuR5wudFXoupLduHc0-u+Vxr51XQ@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/255] 5.4.282-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 12:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.282 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 18 Aug 2024 09:52:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.282-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64 and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.282-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: da98fb7f23b59f6e03a312fd33f84927786f36d0
* git describe: v5.4.281-256-gda98fb7f23b5
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.281-256-gda98fb7f23b5

## Test Regressions (compared to v5.4.280-45-g6b3558150cc1)

## Metric Regressions (compared to v5.4.280-45-g6b3558150cc1)

## Test Fixes (compared to v5.4.280-45-g6b3558150cc1)

## Metric Fixes (compared to v5.4.280-45-g6b3558150cc1)

## Test result summary
total: 91832, pass: 75526, fail: 1471, skip: 14777, xfail: 58

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 33 total, 31 passed, 2 failed
* i386: 21 total, 15 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 29 total, 29 passed, 0 failed

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
* kselftest-watchdog
* kselftest-x86
* kunit
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


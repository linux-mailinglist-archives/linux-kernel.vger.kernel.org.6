Return-Path: <linux-kernel+bounces-416694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5919D48E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726B728236F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2591607B7;
	Thu, 21 Nov 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rc09t0l3"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48A143179
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732177943; cv=none; b=QwgkHUQncCBM2MPUb0/xFbFQ43GTmR0Yr+GeEwY9wStjlpHP/lcoCP7dahqS8rxDjZmn8zVnjEd2BCGhJ/O60D4AMFnNMsdN99QeTw2QAD7cTfT2zBfkSXdr43n3OLloQx6eKRN+03Tq3hbv+ify4Me/n+OPRRTEvoSg0DysfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732177943; c=relaxed/simple;
	bh=Gn9ucZ9E0EcmFZeWjEiR1DeUxpJLBsnQNs9UtTwvmg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fl3ZIvOTHB2GOk8V/p2l3Q5XJR/cMt2QCkwyc0rkHlInQ9ZSgG5a/ZygGf07vKPLMhf7riuCQWVpYaZ63WErtr+D6YW5Ssh0fqlL2Lj2zPsI2Jnw+1nND/2BrOKfdn6GbL/IuyU1J5mBWRK/jmGrN4uLMhZ8wtQ1DkDx6dwoLnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rc09t0l3; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-51473420805so281938e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 00:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732177940; x=1732782740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/hfnq9261uIaSvMuhYRCBIshixxVJLL7UsduaU963dM=;
        b=rc09t0l3r7ZBHplGTIoEU253BzoVlYaex49SCx4x1FzZde7Q8kCfLsfXYxBBVLGrdB
         CyLCfzHtXeGM6F7aSTQK9i4JIxBS8g52WTEaOjkTT5Mxfc7AIxov4fBiLmyKzqAd+YVa
         PoxjKMY3WP0pEifKEcHsC8HmN7+JFdfxY0QcGlFhMp46WtxM+nNiDPV/L2EWcNIGPF7z
         TCPqoYo5O2x9Go8hoxsbAYpEXItzVy7qj5XbsAVIHjGza232/ho2K38XYn0eNrX+hHNe
         ZIyLuqhHmZted2eK0CyX6Lvs6KrQInM3Jmny58e5LXpmuRbKs2Uc2vsEpdXSEg//rNR4
         0gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732177940; x=1732782740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hfnq9261uIaSvMuhYRCBIshixxVJLL7UsduaU963dM=;
        b=UBx5bDRRP8uVmTzZIuOJ8tFuiAakEd6oygrneK8Lsl2peTmycwPbWjztIJamb3KKZQ
         U56GzfaB30v5g/PF4FNysr1ThtlfL0poOk9BZTzKZ+Yuf/Nuu51xnmRCbir+2NGyAtzA
         3xgNz7pKvQIqZmWhEKOuBX3etw4+oH9WOqAuTw6BU4Cy2w5TVasL7KK10Ky0Jvt67Ww+
         y7pJQqCgqwPGw11LxiVnn/6XQ+4VQz0YgXJ3Efg9qb0dJ9YCzqKjZTgSsIzVIDNJpirU
         eaDUptvCV83kIk4X6YJ2vQx50hjYRvWKhnlFjU22EGBrEG+1S6ajJ0KRnZ2mayiLCae9
         ilrA==
X-Forwarded-Encrypted: i=1; AJvYcCXsyuq2k7xO+2fyUqYHc/JYs3VUrpOhXRauAEcrw9xql1+336tY4UB9xD/fN9wu6hltQPrzSTdzBuHhrus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1jTuf4SYMHRVWdBagB6btRaoOeiTBWOs8WplrcIIw46dEWMQB
	BJA07USN2PAwFIugEDTGZuO77IjhcEBQDiOeCVYawmrNimfYn8siKqavlRnZYrWy1zRXiG9VcGQ
	9hAYdrMPQKnLqVTqIU0HZQ0y0+Y94yDPyInJXJw==
X-Gm-Gg: ASbGncuCfdCpO0WP53ycQ7LCojMH9H1Bx4rir6VWEEm1s6O1cEKaZ63kTG/Tfqw23dI
	cJ73GEqGcZ3v+nBdXu1s378MWytt35XwE8w==
X-Google-Smtp-Source: AGHT+IHVDE8AvaZkTUEg9c6y8xfUST+4vKOew4KzEHJoiByr/mrf+Yzrqp+6Ius/EEVjXJgp83zkEWRA31bEbTyqeek=
X-Received: by 2002:a05:6122:a0b:b0:50d:3ec1:1531 with SMTP id
 71dfb90a1353d-514cfb79818mr6386395e0c.8.1732177940674; Thu, 21 Nov 2024
 00:32:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120125809.623237564@linuxfoundation.org>
In-Reply-To: <20241120125809.623237564@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Nov 2024 14:02:09 +0530
Message-ID: <CA+G9fYt=ntvdU30W2jZRSUcAqzrKyuCfDH3nDwRB3STd6uOnPw@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/73] 6.1.119-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 18:31, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.119 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Nov 2024 12:57:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.119-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The parisc builds failed on stable-rc linux-6.1.y.

* parisc, build
  - gcc-11-allmodconfig
  - gcc-11-allnoconfig
  - gcc-11-defconfig
  - gcc-11-tinyconfig

Build log:
---------
In file included from include/linux/skbuff.h:31,
                 from include/net/net_namespace.h:43,
                 from fs/nfs_common/grace.c:9:
include/linux/dma-mapping.h:546:47: error: macro "cache_line_size"
passed 1 arguments, but takes just 0
  546 | static inline int dma_get_cache_alignment(void)
      |

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.118-74-g43ca6897c30a/testrun/25943312/suite/build/test/gcc-11-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.118-74-g43ca6897c30a/testrun/25943312/suite/build/test/gcc-11-defconfig/details/

## Build
* kernel: 6.1.119-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 43ca6897c30a8511928abff403a2977ca7b33ab8
* git describe: v6.1.118-74-g43ca6897c30a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.118-74-g43ca6897c30a

## Test Regressions (compared to v6.1.116-139-gb9e54d0ed258)

* parisc, build
  - gcc-11-allmodconfig
  - gcc-11-allnoconfig
  - gcc-11-defconfig
  - gcc-11-tinyconfig

## Metric Regressions (compared to v6.1.116-139-gb9e54d0ed258)

## Test Fixes (compared to v6.1.116-139-gb9e54d0ed258)

## Metric Fixes (compared to v6.1.116-139-gb9e54d0ed258)

## Test result summary
total: 93097, pass: 73479, fail: 1803, skip: 17732, xfail: 83

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 134 total, 134 passed, 0 failed
* arm64: 40 total, 40 passed, 0 failed
* i386: 27 total, 25 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 11 total, 11 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
* x86_64: 32 total, 32 passed, 0 failed

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


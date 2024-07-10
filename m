Return-Path: <linux-kernel+bounces-247592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5F992D1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84551283D2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307BD19066E;
	Wed, 10 Jul 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQTrE6Pm"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F11190059
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614666; cv=none; b=fHBybtb8yNiksEAgMWX3oG3CTb2n/E8Bq8ileiJAIS1tFCr4E8kbTdTjhDnQ9SJBEffh8ubOWkjKwcnloVZr44qQ3nkRk1Nbni0qPAMU7uQRUNiDVdD4+s2xNhJjUyFspK5Q6nNywFRT80LntX8WO+wgmrvPqIn/Rg2IlzJREdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614666; c=relaxed/simple;
	bh=j2CB1IYugxTa0rXRRo+PzEw6wqFVB3MyPRvpWsJp/qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ktvfd7QG6voQ7VIkrowcQVnXSfXI+hPj0EIsLDqoJRlTYkxxswzzp/mbCsQnwhKDY52z/5NW4O8xApkM4QLr99AVJAeveO2us8u1y90IlTcWQ1aLGbMvP4j85PoVHkZ3Fnb/RbTtRDR4Dd1xk5h94INY6TcnzC3cKtrX2qbPiuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQTrE6Pm; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4f2fd568899so433552e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720614663; x=1721219463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yx5K/74FS6SU2gZ9vr31wzdS+iWH8sI+s/sfE4t8SU0=;
        b=FQTrE6Pmweg6nmmlg/I41VX7IBYAC3KPtaGFcSHcF8kNS60AWTWVWjjucTONjXBHaN
         S2uPOfVTCMYhUr0gV8+dQnA+hvdbo4bZsInlUipENYMz4d7ejOlvf4yQgVb1oOstkMK5
         STa8baadFTUU7TdFSqe6ipZ7SFHlV9BCDKn4HLhc/XrBOFXM0sRuBox34aD0ZXqdHTYC
         AKMyQImQ7NU0m+4/iPZIgCO/HyIrE9/v3zZg7gx0isLlNnR9xzijLhtqTU3ZrdWCT1XH
         mCWMg8sg2z4Y/tsJRxfBkZMQcqtY7hMYVVkKymFfRP1T5QqZfHWfLN22BBbcxf4BIP8O
         qvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614663; x=1721219463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx5K/74FS6SU2gZ9vr31wzdS+iWH8sI+s/sfE4t8SU0=;
        b=A3m5K2LL5di0PL5SpiPNqpf5RDSQOLbRHVWmwwbSXoe8Cfuio9vv8GQQ7vTM/yNz3l
         LNZxmYncH3Yvqn4norPQIxmF6GTDgLxSMKiRks2btUqf6XKqxOO4wlsqiID/xDQbl+sO
         +PtwAAgVmy6knXguEiZt/j2GA11Ezp+y7tVwh/FZ91OE3TEEg2WhSowdWdoU8Hn/wzOP
         JVW5AJ5W55NB9YWo3hfPw3PpIdoSAkxzSg3VpE3o+SWC7dMf52Hcp0s3BUIHjRfWoVAl
         mJKeWgeQYQ4PE6E3O6NCzupG5Hc8B7eB0F0o6zJqJ2PVdmiFkw9f/D9W0BL6lAydYxOP
         qpgg==
X-Forwarded-Encrypted: i=1; AJvYcCWIOTbb0xBqJ762rh0EJsYgkanrgCVKCXmIErxxC8pPgrYmx1BgLrC5jhUXPubkt3EuCB4YM0+B0v/YH03nzk0f/G1R1iS4K8BbZ2hw
X-Gm-Message-State: AOJu0YzOWXZMTP3oWK2J3GkkluIaeguI03JWswmse4mZSO7Je9R7V3OL
	0yx/mmPqygUYmWEFgOYx0ExctUxa+wS7tJK0+0DrujpYPT1FMaGq9X0jQq7K2lYw+Ksb0MuU7HV
	QLead/L4ybDr+i9RcYYBtN35NVjULvESVCkSHWg==
X-Google-Smtp-Source: AGHT+IEnrOL1Ef9b4qJMG/aI4rTGiGMeiNh1rANHAMpP1crKDydeBnuAVTvcgZZsLkksfqrE4YlJ5vw2AyweNG7013I=
X-Received: by 2002:a05:6122:12bc:b0:4f2:ffa6:dbd5 with SMTP id
 71dfb90a1353d-4f3a35c890emr2508024e0c.6.1720614663476; Wed, 10 Jul 2024
 05:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709110658.146853929@linuxfoundation.org>
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Jul 2024 18:00:51 +0530
Message-ID: <CA+G9fYvs8EmAaxoxzHuEhr73+ppK7=o95yxUkJRE4U7RUjvyEg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/139] 6.6.39-rc1 review
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

On Tue, 9 Jul 2024 at 16:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.39 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Jul 2024 11:06:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.39-rc1.gz
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

NOTES:
1) The Powerpc build regressions reported and bisected [1]
Email thread link,
 [1] https://lore.kernel.org/stable/CA+G9fYvcbdKN8B9t-ukO2aZCOwkjNme8+XhLcL=
-=3Dwcd+XXRP6g@mail.gmail.com/

2) The new Build warnings noticed on arm64 [2]
arch/arm64/net/bpf_jit_comp.c: In function 'bpf_int_jit_compile':
arch/arm64/net/bpf_jit_comp.c:1651:17: warning: ignoring return value
of 'bpf_jit_binary_lock_ro' declared with attribute
'warn_unused_result' [-Wunused-result]
 1651 |                 bpf_jit_binary_lock_ro(header);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Build
* kernel: 6.6.37-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ca32fab2f2f9ffc305606cc41fe02e41bce06dd6
* git describe: v6.6.36-164-gca32fab2f2f9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
6-164-gca32fab2f2f9

## Test Regressions (compared to v6.6.38-140-g3be0ca2a17a0)

* powerpc, build
  - clang-18-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig


## Metric Regressions (compared to v6.6.38-140-g3be0ca2a17a0)

## Test Fixes (compared to v6.6.38-140-g3be0ca2a17a0)

## Metric Fixes (compared to v6.6.38-140-g3be0ca2a17a0)

## Test result summary
total: 256613, pass: 222330, fail: 3270, skip: 30550, xfail: 463

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 30 passed, 4 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 31 total, 31 passed, 0 failed

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


Return-Path: <linux-kernel+bounces-220909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B7390E906
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C5C28577F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F2136E0E;
	Wed, 19 Jun 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DVS98LIM"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7980BFF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795450; cv=none; b=b7xqogEh8kT+YGLsNfsCpLqyidJRMzDEcCsrxn76v26aBNL1DUPLTL7RYnuD7wIHmxwfwvcV0c32CznNn/tt8kQpSQg85dz4sfxG6AmZZi4ZoS5W5HxL5AUmEzNdaBhoxmfHqZK27kRCTal4/fhnq3AhL8f9qxTVAtRxs61sIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795450; c=relaxed/simple;
	bh=HHv4mKktzf9+XNRopNBA4+5IjO1uSYcu3PMupO19558=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oY/O6vsiJ5hrTgo7b2KbL+4SmTQmZGhFh2KUckGN/h4QTG/K0lW86gu1jyh/ddn37kZoPS0Vz6okdEdHaiY+z5hxjgjt0X1oEpn4DziCWniYowSUU2NrOOEBi/MwKLhDwlEp4hglWMRPMGTBg5iPTScwoNYGOeFE6Oe+IeQohaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DVS98LIM; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4ecf11aa0d6so1924325e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718795447; x=1719400247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQvMGJZrhyrI19KD2mJN9dgC/lGVs+C5Y3KiDHg0cy8=;
        b=DVS98LIM8+sYspRJRYqA6e8Apk0vHMESRD/9vE/KaA/wdfj4Ne1vx7VT+r4W++he87
         mGDZtrEFAu8s/8/L6bobIwXl5zksyK/LcGf4TdWjrGh04FAWrsAaRsYuV1qcXpDlYbG8
         18h7+b3XuDaMlqqcBMQt3QuBqWQ4ciTtoNTWyk6YOF1fCX49KlFL4JOI0Q11GoWpfjU/
         xvfBjc1PhoHNWaXsxtOn7+ix7wkS9Svzcvog1B2GOx5jXh193Mzg+SSPUV4mCaBDQaSe
         JRzvyw5b53RYDWiW35C/Iia7mpTAKV0AkjBNc4bEKG9ZoZO8lXF3BVzina8aVHoTleM2
         29CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718795447; x=1719400247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQvMGJZrhyrI19KD2mJN9dgC/lGVs+C5Y3KiDHg0cy8=;
        b=T57l3n9V0bIWmXTm8FtQIvSe1Vs5uSLmTNLhLEb7B3VHXQMvO7blMG6IcSkXPjcs39
         ys+1hqMpfmumIXLtZUH35AxTCwuPcXWNF3UGJ601qtsz1wohHtSTJBLDqInTEc0qRxO3
         Kp4OpfQj9VKMv8LwCqyJI+avG/lq2eqye41FEh6xMLU46X8RHIHWZHMGR8tgc0nyz+29
         h1KsSEpWwjxCZVPw6Usg96PY3GnnmVpPIdyIVxWW2yD9spb70OBNEE7b6qv/BjDEGwjQ
         +YTAL7T8NYBHRAfBID9lqzSHQ6AuRwo0ClyHUXvLdn/nwqUR7QwTRqDEZbrx37dmD8nl
         2jcA==
X-Forwarded-Encrypted: i=1; AJvYcCV4+N0ToE7g1Rb5V/RQS8kSdhEKHYO3yRCYzi6L4j+E0WcIw/3KKTNXfEQdULfe/qQrBGoo0e88s7phzT66wZCujXnJa3sU5fXGgoJI
X-Gm-Message-State: AOJu0Yzka5Me892ghYVxRvwx91AFD3n8hr51QK1uXxU2iZjafDpVpET5
	8vxVcd/hCUUexYSpnoq463rJPeD0hIZP5tsKNN7wgHfqH/qje9KRI54+sNeD6RJFTfHxMWorHgZ
	mRUmcXRPAEmzS2RjFmhyj5flnSOzgxS5sP/qoHw==
X-Google-Smtp-Source: AGHT+IEo3vf1oUGzG99mjqU8s1NDWqJZQSEdCX4+1c22HnC5JtjpGdMsT6RsBslaHgQIWWx6rf3M4XHyXsm989HKaF4=
X-Received: by 2002:a05:6122:3c46:b0:4ed:6eb:567e with SMTP id
 71dfb90a1353d-4ef277b5a89mr2576452e0c.13.1718795447207; Wed, 19 Jun 2024
 04:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618123407.280171066@linuxfoundation.org>
In-Reply-To: <20240618123407.280171066@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 19 Jun 2024 16:40:35 +0530
Message-ID: <CA+G9fYtLXLAnEemRSk5dLXbuju--ga++Jt9wF0=FHSPZ7fEhWQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/770] 5.10.220-rc1 review
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

On Tue, 18 Jun 2024 at 18:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.220 release.
> There are 770 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 20 Jun 2024 12:32:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.220-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.10.220-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-5.10.y
* git commit: 7927147b02fc59fa7d326be121ef2a599edda19d
* git describe: v5.10.219-771-g7927147b02fc
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.219-771-g7927147b02fc

## Test Regressions (compared to v5.10.219)

## Metric Regressions (compared to v5.10.219)

## Test Fixes (compared to v5.10.219)

## Metric Fixes (compared to v5.10.219)

## Test result summary
total: 128385, pass: 101019, fail: 5547, skip: 21723, xfail: 96

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 104 total, 104 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 23 total, 23 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 27 total, 27 passed, 0 failed

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


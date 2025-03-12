Return-Path: <linux-kernel+bounces-557528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27115A5DA66
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E3A3B4E48
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAF23E251;
	Wed, 12 Mar 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ykJtVod8"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E1E23C8B3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775138; cv=none; b=ErPAam41oP86RJLFHAG5zo73ujoDcnsHueeObyycb6ArS33yKv4ZviIRW7XdwAu+i3J/V/pax/KSiEFdlaSLDOlZn8lZjNb1NbWBK8FTAOWILSgN7ARTl3Ao71UuO5BMRRNpFLfmbkfQbbZQm9BZME9FIACIBkVRcsINUHTVWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775138; c=relaxed/simple;
	bh=PDHO7y+ERlJAnN05ImfV1yuUpp0i/lJuWqtTfGpzzzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SW/gjS2e4tWdIpa/nqEFkL8vh+nJyZ0m9x0+cUNQNs6fuzNY82MdzIiMtbQIk4P/RnadQ1ZyJ18HPoFyD+6bFQNGE1lpK/uwMj1VvFlzntdoHqrNHdrb/Q3QcmWoVDgwO1fK3M9Kn/uBjrUXeWF6kmDO3tnVDuCcWDIZTA0P5T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ykJtVod8; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5240764f7c1so1498668e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741775135; x=1742379935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGtpHZfxRNzO6OoMpHooKBsRfISaZAIh8bkBtSxi4jk=;
        b=ykJtVod8q5rZWeryyKys+KQUnJbZ9bbfdm8dbbiczIQ+8NKlRUtNuqi024vl+83qIS
         LQAHBYGVOhir3s/BVvq2IthQwmAGrDOnZggcFzd894t6WhfyNl+LSr8C3K6cQzpMg8Gd
         D6eiLJHAmAB4RBCHBauzxihWO0wvcjLqkzcQDVeMz8K0zRhzh+iN0tUBlAVObWgSp1De
         /IvIqCaZURWPrf072k/XZCfR/lCHUM4itDYBkmpf4dEqaqMl6EtbI63890FrKocagHMT
         VPjfPUJsQHhsdwoVy2EixKOvBRcjWi/0weg2Lhnlsul5leJ8cc64qeYMFv3ryRJdNEZg
         sYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775135; x=1742379935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGtpHZfxRNzO6OoMpHooKBsRfISaZAIh8bkBtSxi4jk=;
        b=OnK3CcdbBLON79gN8v6sYiMjn5fGnSMJO4I/Cg9hhsZ/k9kRFSGdxrI2oZPvWhWhFA
         1hXFzqcs0aSlu3mdaYdiDLhDEYWXWQf4Vnv66xRVe9Rrtyq/R8CFp4vAY9lTvIpwKRpw
         HRaXkepg9liREJDE7DDdwG/A6CQxoiUv+g/Vweg6OvVhLmrrlNvf/MLPC0hR1+MArs9B
         ANE6ClpZNz4VZp8DB8RhlAp3HyvuQRIvBySrY9fFS+1IwsZRCpXamCUNKZw6Taid+FZN
         tCCzGf0qNENrh/EPm2esURrt6/y3A33eNnNYxgCWSN5Vj2XvnbbtNdZzPHk3yDZlTEkR
         iGvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZe9gkkppSshbZOD8uDsJKcfm3r1rljwn5n5VaZ+CQ1HZF3r31jNU70tmH5jQoIzD8ALlShjM0ZhZ5lMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEhvQ7sjZV3jpwV2UuoMyi2CWq9IQ17VmqoGSzjAivxevNaMTL
	a/SmM7FEDqg8CECVNJWLozgj74O2xNj6k1sYwsvY1SGEieUEzigfnjPSE14flzktewBBZ/2rdDF
	qV+9Y9EY7xMbbx2y9nGchca0SDKaRP5MG/I8/Og==
X-Gm-Gg: ASbGncvmdkZ5U9ZDG8/uX+hda32COR+XU9UDci3/1X7NF9XjXw+CiPiqgH+SsXXV1kp
	0/3x2qB9ZatPMzysBpyg2QETP0279fXeK+oNaRXHZ2NuJ82q6yRzVDNkUpmaZShcnAzZ6vLuMnT
	J29B9DN0iZykoivEWYAAere/KeQwopPwr2odiNT0PYq4vlc3bTbr2qdmi9bpA=
X-Google-Smtp-Source: AGHT+IFL0HreR/KlcTDMM5OcMZYgMMEODEZdj0hq7LqEb2TK1xUYjtp9ukuN5QzK8OoEYGp1qR9p2Zj/muGfbshTL10=
X-Received: by 2002:a05:6122:828e:b0:520:51a4:b84f with SMTP id
 71dfb90a1353d-524198002dbmr4416579e0c.4.1741775135572; Wed, 12 Mar 2025
 03:25:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311144241.070217339@linuxfoundation.org>
In-Reply-To: <20250311144241.070217339@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Mar 2025 15:55:23 +0530
X-Gm-Features: AQ5f1JocR2QVAetGvMUl47oG9R-0y5q4g7PNIHcghhHTaNTnPuThs4tcrPj0feU
Message-ID: <CA+G9fYuK2dHLg5AGVyN98eRKwZQ-aMByvhBLyasHuJRVLNkpHg@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/197] 6.13.7-rc2 review
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

On Tue, 11 Mar 2025 at 20:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 14:41:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.7-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.13.7-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: fca1356f3f511f72adfed5a76ddf17a30241474c
* git describe: v6.13.6-198-gfca1356f3f51
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.6-198-gfca1356f3f51

## Test Regressions (compared to v6.13.3-552-g3244959bfa6b)

## Metric Regressions (compared to v6.13.3-552-g3244959bfa6b)

## Test Fixes (compared to v6.13.3-552-g3244959bfa6b)

## Metric Fixes (compared to v6.13.3-552-g3244959bfa6b)

## Test result summary
total: 131178, pass: 107823, fail: 3844, skip: 19511, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 1 failed, 1 skipped
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 41 passed, 2 failed, 1 skipped
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 25 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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
* kselftest-x86
* kunit
* kvm-unit-tests
* libgpiod
* libhugetlbfs
* log-parser-boot
* log-parser-build-clang
* log-parser-build-gcc
* log-parser-test
* ltp-capability
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-cpuhotplug
* ltp-crypto
* ltp-cve
* ltp-dio
* ltp-fcntl-locktests
* ltp-filecaps
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


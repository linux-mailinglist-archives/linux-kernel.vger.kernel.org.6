Return-Path: <linux-kernel+bounces-188444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A23B8CE224
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C351C1F228DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30056127E12;
	Fri, 24 May 2024 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJ0G3Tme"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18580749C
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716538579; cv=none; b=LGUeJOg2OLc8HUo/wnmsi1ac+H/LiSh90TfEreK10ZZc6ZC7lWM0Q2qP5XPJbTo24wGOyXm9uNbWhpKwYMJMmkEyAzZ4tButllshQJnKPw4cnDwsh5Vt3JRX5yIif7pkxB+aNJ9Yp+c9F01MNOgafgLVjlAOOGAq12RQbabrwmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716538579; c=relaxed/simple;
	bh=MeDCK6s7G5RsTgbi4LteZN2smIgjP9qayVNhnv6zszo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7g6wGHAAUpiuGTnalmEGLmZzdpkWm77wIMrdZadQH74DCy3SYOrHjlRSey8YMsEI28cv6LQBuVVJO5uqDHEKhfOr6es1pY2X+/fKYAKc+Qmq52whVdFipX0WKsyS6aH6feoL94fdMX6GJfpH61flSeyeRUwjTkMLOPPdDv8snM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJ0G3Tme; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ab9e011f62so4782386d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 01:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716538576; x=1717143376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=491QL7gImWzySEIO+B+aisicLu9ctm3NseoNLbGUbCE=;
        b=QJ0G3Tmegx1NVnC+euRmG7VOtqWBCF3mCzDCaCx1afQxq3ArvPEPO98U/ufRbHCUtq
         UZqU0qNBkDQywJ+uXIBZJ4L1YBDFICQND0044SOdJsqwKnw8W74nsQGhFt9iD+jnKGN9
         22Geb5T6EF9bTJUj4mFcGgilaZcFycuNUYWCABSfmvCmL8vyLiyVd4KTNpH0HSbLgjaR
         ci54t9aTLxb6IXo1D3O9DTKFuA3MV/X3+lAiy2hJlef4og9F7ESSY/2dxnUV5joTpl6W
         xAhnnjS6ixtD+7S4E0PftaV204sMhGHhjznvDJkPWfMILbLr4P+PZYyF1I0JSRNXQmux
         +mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716538576; x=1717143376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=491QL7gImWzySEIO+B+aisicLu9ctm3NseoNLbGUbCE=;
        b=q9x48BqwvnUguHjcKnwmXYY5kLb1W6G/rfN5DP/KuT9Cv/t/1fv6QdzCcip+FP4HQp
         CZuETv8IGZROh7zjrZhKAwZM8ao430N9dgaYea3sDQjo3MOIvpX/TdiuE0pxn4THclwS
         MqFvcpb4AOxRkkq+F1DaqANZTXpur7vd2rkpRoY3uxSWyXffQivcOnBs4ArF1ngEhgYx
         JmZocPOFL+h8+gxziu1PRyujHjITevUSdahwL9CvqrdTbB+Bl16Uu+dfs7glQNEqBZeG
         wkT+Dsn+Z2vIxN1WxPw3bZucehMCEyNPk5XeIVBrmUkjTQUZXM3CWm+5J4zJLNXzER6c
         6yFw==
X-Forwarded-Encrypted: i=1; AJvYcCUqWKCntaZKzRJhiWAfugDIC2wPr5uzqaMpNlgfRFJx7X8eY752exQmgZkyV5gSuGJgw+cTjgZA0+1DI6LP4QVTKiE7rRBsk1xiaDNm
X-Gm-Message-State: AOJu0YzILXSxhuzW733dwxAs2cXbJxatUJafLWidwbYYevgQo+T3hT6+
	zh29ZW9Zl1GO3D0VWlunqG89/ZOqMNOUozquO8F5cHXS8Z0vIBpzWTUoIQNyoYP2QIO6ORrKxWO
	0rvtAiFPC576cxP5sc5pJgozZrA+KyC4SWRgiqg==
X-Google-Smtp-Source: AGHT+IHVC62oQsNW/g0hVpJaQDzdwuRDElUhhtZkj6aidknrRT+NitYEiySNd2XcLR6KDYk8m7OTHul1EJZ9fqd9uiM=
X-Received: by 2002:a05:6214:76b:b0:6ab:7ab4:f309 with SMTP id
 6a1803df08f44-6ab8f327f9fmr65300386d6.1.1716538575594; Fri, 24 May 2024
 01:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130327.956341021@linuxfoundation.org>
In-Reply-To: <20240523130327.956341021@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 24 May 2024 10:16:04 +0200
Message-ID: <CADYN=9K12_SjTAp+URCPfsgJB+cm_mJhK_5KSnN-9W3278Wk9g@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/23] 5.15.160-rc1 review
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

On Thu, 23 May 2024 at 15:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.160 release.
> There are 23 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.160-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 31 total, 31 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 8 total, 8 passed, 0 failed
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
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
* ltp-fcntl-locktests
* ltp-filecaps
* ltp-fs
* ltp-fs_bind
* ltp-fs_perms_simple
* ltp-hugetlb
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


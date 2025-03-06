Return-Path: <linux-kernel+bounces-549154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E01A54E48
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE463AB620
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39001A238D;
	Thu,  6 Mar 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yxm1Pk3q"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D751891AA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272743; cv=none; b=HfL/bAA/+M93aKsfnbwEuSMDToiG3dOoltD7CUNDKQMSyozZiWPMgul7KXnhYwpL71dQtA+6ljykOu2BCHC3DzPEBtxFSglyRXa64NxqFE/kp2voTzvO45uUEvJWPMBxqK/GhKdYxBRSUtrPt9voPPwTxMlS6cvj27y09YvVDU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272743; c=relaxed/simple;
	bh=yUu+b2vzGVtm02aX2/54++X00P3YWAnG4YmO83c4ObQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=reTMmdrE52yQXcW1u49YrurTAqXVH3G2y2+rjTT7ftyLHklhWlkny3os7JTeq3FEDdjNvm0zAor0RvWlIInHVSDwm49nzXHrDdbMATYTwo7GlD30lkyzAcj39CeDDZKZMeSLHfetZ19i7mqJCeu83/DMV6x9ITSd5rTSb2F2fvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yxm1Pk3q; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-868ddc4c6b6so317555241.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741272739; x=1741877539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++XXHmZkM/4heXDc+pXKcqrY45A7F6g9wZ+G1XbfvUg=;
        b=Yxm1Pk3qwOpMRKDMBc+EwiZeoHB4+golpu1oQyBLEThc3F+xDLZfqni+ckCQXADIvH
         RDcqJCr8WpUdAX93OYjEIt0mM9S1tYCA4wtq3QOB3OW36sKfv/tvvsCBNzxP+0v3pkGr
         +W4Kar77sIxhfMHbYCTqLhSwAOgzvWsTgRSQmRIWXAo1xliQD10Izgz1l6Swt5JOoHzM
         OJqmE/qQWO5xOYg8GK+oZbk/fSeFXahO0w2y7+QOnkapaogkYCo7AzfMtKNri6N+5My0
         rq0Povpmvh2hrJUFPBVPZfGeFPlaZkKVfWf5Y59/15TeWI7YXY7v8rE8Qpzai0oYRR1j
         xPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741272739; x=1741877539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++XXHmZkM/4heXDc+pXKcqrY45A7F6g9wZ+G1XbfvUg=;
        b=nic073KruWCyAfsl1wb4W7nZQQprgV5c5y3B1soVcfky7/c/gloOAHMRfk97WLinSZ
         O5P+W5JO38xdRGngICnWxS4y1WLAtb5EbMK8upc8Y9uZBQGBsQ2OFnXl4uB6g+t4HcS9
         d8pLsPr3Lhhty5HbGvNjfctvTYCmlZKGshkEYQjHA76HXpKrHIZM1mS9L1syrTRPAY/b
         k3pKJK3y3MHznNMPtq1CIgr2O3Vz6rK80uRBUmn9gbpHc7T0tvx4OuQi5hz80BztFntS
         qc5EVfBD0vSYtrKcydS7XnU+oBdOfEqgUcG7IXHVpibfw8nmNv000u9FIuJZ9a8Oumvq
         u3ww==
X-Forwarded-Encrypted: i=1; AJvYcCXYViabMqcbxfFq3sp+6hRwhuL+q6Bbe+63jIeEArFOGwan1dHMwe0gyzXKltpvXscnBEltvcs2cMxeDOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweb6ftca2gyy6nUS/LyxezA7ajMI4y7TsNFzfhP5sN+mlJB6hP
	Xo4YPj67LN/9m1LvFUsBrTSsIHfSwC/aJKtKnYfO99ft+OTwukvDduOZe21sw1kiy78q5aIX+R4
	Tsfa+SCMgFu2CZ1iT6b9V1e4jkgYzt/boaCKjmQ==
X-Gm-Gg: ASbGncv5Y9BUJLBdamKYGV5tIJx+NyUke82M8MOTM6QnCdRoLx7KQFVpyx6t8QRGANI
	7JGQ+RSW6hws5+ynYTTxav+rGUj1hXmzo1m39YuW1AmkDcZid6JQ3+qqejAMM6jvUA3Zf6SPe8r
	o4hqY2nZwTJr5hYbDqh8nn9giKhLWkv1/6Hrd9KnaxR7ajN505X+pu/1vxTfY=
X-Google-Smtp-Source: AGHT+IHqKw0y7gEoV2UPp2JTXAc45pxenBD9EVRnJ3CNyJRZgT0EsDiICwm8oX0iHkmbYK+jllnu/+N/IxUM9GPv2y4=
X-Received: by 2002:a05:6102:4193:b0:4c1:86bc:f959 with SMTP id
 ada2fe7eead31-4c2e27a6eb3mr5045988137.8.1741272738910; Thu, 06 Mar 2025
 06:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305174505.437358097@linuxfoundation.org>
In-Reply-To: <20250305174505.437358097@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Mar 2025 20:22:06 +0530
X-Gm-Features: AQ5f1JqyKMYONNiG8qjjNgx2bFmT-sq5eEAlVlJjqLc1GhF9Jjc0gVpKZ-epy90
Message-ID: <CA+G9fYucgzxXxrTBUJcgRyJwXk=14S6tL9G-jd4Wm6fM4VaMkw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/176] 6.1.130-rc1 review
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

On Wed, 5 Mar 2025 at 23:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.130 release.
> There are 176 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.130-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.130-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 34da6dd4fda1d2daf1b0df768fe6224d0993e050
* git describe: v6.1.128-747-g34da6dd4fda1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
28-747-g34da6dd4fda1

## Test Regressions (compared to v6.1.128-570-gfdd3f50c8e3e)

## Metric Regressions (compared to v6.1.128-570-gfdd3f50c8e3e)

## Test Fixes (compared to v6.1.128-570-gfdd3f50c8e3e)

## Metric Fixes (compared to v6.1.128-570-gfdd3f50c8e3e)

## Test result summary
total: 75778, pass: 58508, fail: 3115, skip: 13933, xfail: 222

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 139 total, 139 passed, 0 failed
* arm64: 46 total, 42 passed, 4 failed
* i386: 31 total, 25 passed, 6 failed
* mips: 30 total, 25 passed, 5 failed
* parisc: 5 total, 5 passed, 0 failed
* powerpc: 36 total, 33 passed, 3 failed
* riscv: 14 total, 13 passed, 1 failed
* s390: 18 total, 15 passed, 3 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 9 total, 8 passed, 1 failed
* x86_64: 38 total, 38 passed, 0 failed

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


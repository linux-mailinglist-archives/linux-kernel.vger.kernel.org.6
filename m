Return-Path: <linux-kernel+bounces-326130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F099D976367
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2065F1C2298C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237E218F2CF;
	Thu, 12 Sep 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnfQ6JX8"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248D18E74C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127499; cv=none; b=DNnq8WtJbG7TouLD7dsStt47JUILaPhWti5arnPHdW6iG4FDBhk+APcsP1hO5aV8Al5lJLJI1bACoac7Je/kKyQXQSup4DYATCkwYM1Wm2gJirjKKFSWIBRrnde7rGUsVlJz8ZY2COvfS1T3/Xst7sVKA+u/rYKvXPRkRw9RH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127499; c=relaxed/simple;
	bh=xC1te4ZV7NCRpSzkTfMZ3d9wH+EtBADG+lnqfafNM9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ls7XCyb9PkiOyBBFn4l8lFv01D9cBVbAX0A7/jwG5ubbYnXuitPyPbDt8+nD738oXvf4UXBo3q9cc8mCeagPMnnrno6RTKHLaDTrWeraVKXxBvGlVCgq2OTgXj7eDVyBGWD5z/mJ0tdM/O5k9HwPvATHAWIpmhtKVtpftSHiPLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nnfQ6JX8; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-49bbf14d309so211049137.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 00:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726127496; x=1726732296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytrri8HVeuOjFm67RaPu7R4UwxwK22CZCRd3kl8NkYo=;
        b=nnfQ6JX8kwH2tGesXFaIrJVwRySqHyKhhQYHpC2IaSUgWVuRb+vbbnfF2o6qLBRNyV
         PsFrfN79G+zu2GqGdFyjNQzXzPTQRnEob4ujRnytUtmarnsqDf1L6GpUVXD91QhJEoJA
         i02wo17boiuSFxLm5qr13jJK4kPzAYoBD3QXz9igUOBK8zNzPfmYBUJguiC8vNLSZNeH
         d+ZrLqhnfz+hUYgxkBRReASraUnDP2UviitximcM5jTGJzn8YEmtKYjXWC/T0ypTunlq
         4Y0yPYFD5U173Vwz4kIMpBPhRiZYCJkv2bDpXhvfpNGInf33N7J/6luKeVDKmez7CX9B
         Dl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726127496; x=1726732296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ytrri8HVeuOjFm67RaPu7R4UwxwK22CZCRd3kl8NkYo=;
        b=edx1XvoG8KF33IKu9cOfzuTIYllqWGzf7dM4xuYbZ0Nmi1u2pKXbshSdPj0RDe0JBU
         xYhoTNHQI/7VbzoODNfjcoQXe2BfhWNkqvPlaews8bvpngzZelvj5reMkqmgLNBkk6ch
         h5dGTNAn/qOj8VSC8lCCZh8ywXqGNUM8afErAEczysawaO2q9LxU1xzlzW+golkpqdRe
         XQN9UuHOQc9qinhYPE+y0irl9DysBrxSADfTueaouobxmn/keg0zmAiQ4lWS9fkU1SbP
         g+G1S0w4293K5W8f4eJfY4T3Lh83oik2/tAXnQzk3cXnOj5gkqQuC+iy6+6nnvPtl7hO
         Rsiw==
X-Forwarded-Encrypted: i=1; AJvYcCUxY4YMo0KucYdsicIN8rpzDH/F4Pxo+mENvvQadlIx1oog8bzd8ZrbRARzncUUV/vJGiiAE32AJRkYEtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nJ4cfDUMvrd+7K5Y6Uwhejo1pHlM8IIElUmv6MCfVp5It0ie
	xP4UCkzAd45h2qgZLfWk6nyQw342Pzxzbq0wBh8jURFop8HHlgVLvPzH8HIIrYD87JXX6n9BRB5
	6T0RxBUWDzQwvcH1CMzsFmWkqB8n7bAF9e5eGJA==
X-Google-Smtp-Source: AGHT+IEb8x0+Tkg24yEoL5NGtDYmVlyyhHh2gGjb4zt+f4oxmjLyBvkF3YLn82FXT4Kmp9epnXusS6w1aM2c517njJg=
X-Received: by 2002:a05:6102:f13:b0:48f:df47:a4a5 with SMTP id
 ada2fe7eead31-49d414bfe69mr1549983137.11.1726127496479; Thu, 12 Sep 2024
 00:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911130535.165892968@linuxfoundation.org>
In-Reply-To: <20240911130535.165892968@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 12 Sep 2024 13:21:24 +0530
Message-ID: <CA+G9fYuRE8=WkdmpYpP+c8htu32oegFnJEv5CqbxqiUnGE_aXA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/212] 5.15.167-rc2 review
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

On Wed, 11 Sept 2024 at 18:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.167 release.
> There are 212 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Sep 2024 13:05:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.167-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.167-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 0891f8b0a4c865ecf44cedfd6a65f02b110daed3
* git describe: v5.15.166-213-g0891f8b0a4c8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.166-213-g0891f8b0a4c8

## Test Regressions (compared to v5.15.165-216-g36422b23d6d0)

## Metric Regressions (compared to v5.15.165-216-g36422b23d6d0)

## Test Fixes (compared to v5.15.165-216-g36422b23d6d0)

## Metric Fixes (compared to v5.15.165-216-g36422b23d6d0)

## Test result summary
total: 92111, pass: 76605, fail: 1851, skip: 13538, xfail: 117

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 102 total, 102 passed, 0 failed
* arm64: 29 total, 29 passed, 0 failed
* i386: 23 total, 23 passed, 0 failed
* mips: 22 total, 22 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 24 total, 24 passed, 0 failed
* riscv: 6 total, 6 passed, 0 failed
* s390: 9 total, 9 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 25 total, 25 passed, 0 failed

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


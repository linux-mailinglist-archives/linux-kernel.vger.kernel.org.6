Return-Path: <linux-kernel+bounces-399807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072809C0474
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827621F21256
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50800200BA6;
	Thu,  7 Nov 2024 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QQa5UWVl"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064881EF934
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979969; cv=none; b=TICagZtodKJGDcPH2+/H6o9/t8gP4vA3jEnorvKcur3PaB7/eyo8IuHWoorR0WDNd2giFHGj6p3Sy3OTwvrTfSXBvK+MiWibOZegW3fXOhxk+AEQ31/4FZC3+PcmfJjMiwzeTGYNhe2niOnY67evtsAImzj0rUgBlLORRhu9x7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979969; c=relaxed/simple;
	bh=wC0dbBRtbrAeN+fJ+d/gH5t/Z+cCqsSulIC2DhQYfT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auxNY669DOkOcB/BtryqcZEPrHTlNJN34+NlX6Gbo/fvv7XCSKJg+t2tQ4wW2Mea9bIyyCr7Ao0DvRX303K22iRJtondXwfSPuSYRywk/8g56cJ/NGnG99evGt6/c3wHJnFmZBMsOM6aVnG6Cuv5+TpkxBs2Vrkl1kEM8UeunpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QQa5UWVl; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50d58e5bfd2so331568e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730979963; x=1731584763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCktawUadk5I3Ui5sjhCsvj1qspJCjEOYVbOqkLtmDo=;
        b=QQa5UWVl/Q18Qp9KPcyD2uhzjIqxcFR696w5MbUqV3LuVK0cZfv6W60aDF0OBLcpo/
         mZhF4pN0etv8KYQ5NiazUUvmjMt/CtmJEtXFgeufue3epxydaL5I28SOh2Q9RvdqRQc+
         S4WjAwZOvyWpW+lSqM22RXAvz3RB8y1ky2lAzTJ5Y7Vh5R9u4l9sZF4Lhwc1l+NK2Cqh
         wy/Mh1pY6r4S/GRfFR8Phcy+PXvdUpqKdoB4wwecH9+DzncRYpuMx4BWMTSYaw4tjQQY
         jUFsoVtfx23DNx01DLK9knd58g1PLcLJf10Btx1CTmp9RgMPj3d7TcPZLyPZwtkGEKWy
         rB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979963; x=1731584763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCktawUadk5I3Ui5sjhCsvj1qspJCjEOYVbOqkLtmDo=;
        b=s9gHoNChuh/sew435BIa9h+t/LSX/O9FULOosWG9nINZkG3Xjvmr59hgnIsNhkFpRp
         wk/hRkeBxq/QqIFtgaPa8VpmR1+9lzIHdkGELVB1Rd7NZ0Le/u2aiHJvK6bHoFUFEMp5
         strfDuaRhTwlV804j+f/nDBexY4w732I69OqVdc7Y/y9YO56bphkIqRIltnwheXJhDTo
         9YOdEyoqJLOlpLCk/YPTYoD+jIDZ6xSLVI0T0CRYFH9XAPtnmRS4FlMSN3wSUF7FRUI+
         lwggkqTjkSIKZz3ZbLhhgFTbdWjQljaDViGwvkDRvSKnssyGcrMGzjJdx9zvg/OBtcEh
         rqRg==
X-Forwarded-Encrypted: i=1; AJvYcCV1d+MoXtRaqsnWaKnynWhDz3OJGMQf/Kk6kEVBYNad4wIiQthXTFVfzN+9y8zwLUzZz8am0AgChHOIUco=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcx7G4Bexm9dXJr1sVnnmzPtHBgwx+Y60lA5R4f/2tbj7zKy1Y
	/yfB6vuKNXLnjVjD1HWOivlq/DdXQiwu/nRwrasf/ZXm69026j7vkLTIm3sxJ4eBVO2a8tUtEd7
	W/QW0EMevMu1QEA5js9Sq1t6Sv+/MMvl92jTdmQ==
X-Google-Smtp-Source: AGHT+IEwNFkllsRapImy9s6NO7BR7FJd1K8pYIzeIKnABE215cUBZo3UBfhHCQwvCiO9z4nEwHJ1SFmnvxqTSC1Vwk0=
X-Received: by 2002:a05:6122:a18:b0:50d:3ec1:1531 with SMTP id
 71dfb90a1353d-510150e1e84mr42209137e0c.8.1730979961942; Thu, 07 Nov 2024
 03:46:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120308.841299741@linuxfoundation.org>
In-Reply-To: <20241106120308.841299741@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 7 Nov 2024 11:45:50 +0000
Message-ID: <CA+G9fYvk8HbUW7j9bDUm1oDZrQCd6bnvRozAE=ZgEk-vhLvKOA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/151] 6.6.60-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Nov 2024 at 12:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.60 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.60-rc1.gz
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

## Build
* kernel: 6.6.60-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 2daffc45f6370a4bc2ed3736053d864ad7324f3e
* git describe: v6.6.57-484-g2daffc45f637
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.5=
7-484-g2daffc45f637

## Test Regressions (compared to v6.6.57-334-g02900c91433b)

## Metric Regressions (compared to v6.6.57-334-g02900c91433b)

## Test Fixes (compared to v6.6.57-334-g02900c91433b)

## Metric Fixes (compared to v6.6.57-334-g02900c91433b)

## Test result summary
total: 149914, pass: 123278, fail: 1553, skip: 24990, xfail: 93

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


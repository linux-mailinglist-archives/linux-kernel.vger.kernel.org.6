Return-Path: <linux-kernel+bounces-255191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10264933D48
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B951E281F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2421CAB1;
	Wed, 17 Jul 2024 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nX1Ean9X"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577961802C7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221246; cv=none; b=RZiHdMA44HsDArLZyayeybvnC6bByF2dPMEKUtCR9zGNbUT8uG4HMI0PCvYgeDSsunjR0OtjpnEhMRd8kxB4MQ08OIafj7hfDqnT+E+SZxEu3ClzDiWjqGrx/PNzwE4M+ilFjNDs6mhh+pWTpPxcwyGTmM3WsJlLS8Nga1pFkqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221246; c=relaxed/simple;
	bh=6vb13Iy5euZOR4dQ+SlApvRI6h/aNBGj1KptxzqtqHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJLFl40nRivaF6O9ZlXI22ZNh2YOGloCzTLxROlhV/gblNfJ4Bvx30bs3G+s0gzukow8t9oiIhdheyu07VbAIHaZXlQcpTi8VjYOivj7RejJ+SSC1a4Wa4MSuhf5cYq4aKC9ud2o8GdMFcr/3mVwCiM5YPPs5ITjSazRfswdA24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nX1Ean9X; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8102c9a5badso449985241.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721221243; x=1721826043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElVioLoyTQhlcAXqwKpNT5fstW6n6vTuxhpKut5u5V0=;
        b=nX1Ean9X+wVo0Cs7ycVjWISmwwcskN1RGCxdmNcqOUNzLPVk0Xftzue8Fyu/bILiRs
         8nGPlBtn2SGpL6670TgJ47tit7vPAedRRM8aDED8SrjTybKDXAkWovWAj+P/pfszVq81
         KK7gJV4jwk+TdvxZ1e/+P5LQPp2xv1qSI9a+MMru4AXthxCq/BYCu0d5evV5KtBG+6rg
         ZgUnaHEiXMhRF6wrLAYnyxYYREqxfK6pMrGNsPJYYQtJ9y3iQzvh3vIROW0sHNKR5Ma4
         zqcf3EJuAEy/m+Xcb0DhAFbctQxQGQywo619NSNR0hibiHWGotSAlMT/mvO27Y/tHCd0
         O12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721221243; x=1721826043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElVioLoyTQhlcAXqwKpNT5fstW6n6vTuxhpKut5u5V0=;
        b=S8NQzekCGGQKnTd9SkXiaZaIZTLwz4tHq9g8XxauNAZ9mboosR39BzqoDjeGAUEj2Q
         lzDiZSWBFIX3n+0db7b+1dRUaPrZx9loKtZ+14P1W6HiCDB1OL2OkF04ldNbi+S5TM4r
         gTl6AY4PFDFgftyUD/Q4OcPTO0LYDgNeDmB2vIBF23s//ctXO6EVKcbMUJFAxWsfrxEl
         SHwjPztx2QuIO2yngXZBnEwiVqbBUu1mVFW0/brY3W8PR6AMm41tXggAdA8+NStsuYfi
         IFS4KaXddJ2jE0zQlTNFlVXyNXE3mLU9rg7DofpATFRLXEQnuWHfaOa3xALxJSHHk8nW
         LvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWncYYYkq2chpVkWd1Xtp42/Bf4uCCX/ln2oZWazKFfgCvs+dEh+WwJ9up+qqxMoloIqK1/F5TMvyn/Dhcy+GiA3hGmmnfs4iLNn98q
X-Gm-Message-State: AOJu0YxG+TK9DtuxaJVPKtunrbWRyp/+yMK22CMncUVdRCq6yaBB220q
	01tGLmGDSHVVqgWUjUWZuJF1Ehwsm2PA9x1WUI5Bfcc6RvR22kyh84cqeW0DWNvs0Y+oYdFWV7a
	VfFAH8Osqcz68su1O1j2svEAjhQCLKbNmIrmG+Q==
X-Google-Smtp-Source: AGHT+IH5XgJmvEXq/L7FHOyyXK3RkpSHdXHll5ESvSvmSgTLTU4h1DT36ljkuWFPLkfK9rf8NDemDXuqK12zJjQqcyI=
X-Received: by 2002:a05:6102:3f86:b0:48f:ebb7:3919 with SMTP id
 ada2fe7eead31-4915975b217mr1698584137.7.1721221242950; Wed, 17 Jul 2024
 06:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063806.741977243@linuxfoundation.org>
In-Reply-To: <20240717063806.741977243@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 18:30:31 +0530
Message-ID: <CA+G9fYuRu35fggLrOaXZg=ic-pFjq7DRL1moSwmwHW1qejPfuQ@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/142] 6.9.10-rc2 review
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

On Wed, 17 Jul 2024 at 12:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.10 release.
> There are 142 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.10-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.9.10-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 61dff568763322453e014b07c0508620052362da
* git describe: v6.9.8-338-g61dff5687633
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.8=
-338-g61dff5687633

## Test Regressions (compared to v6.9.8-198-g2471237b27c6)

## Metric Regressions (compared to v6.9.8-198-g2471237b27c6)

## Test Fixes (compared to v6.9.8-198-g2471237b27c6)

## Metric Fixes (compared to v6.9.8-198-g2471237b27c6)

## Test result summary
total: 178195, pass: 154558, fail: 2462, skip: 21175, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 33 total, 33 passed, 0 failed
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


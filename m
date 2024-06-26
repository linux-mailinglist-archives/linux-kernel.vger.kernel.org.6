Return-Path: <linux-kernel+bounces-231524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC22E919981
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FFB5B21259
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79ED19306A;
	Wed, 26 Jun 2024 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gx8dpGog"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D229E8F47
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435381; cv=none; b=lMVjeEmYjYPF9yzCtJnQE2SvULqnF0kWRsVG/4Os8FNXw5okpXXnCQuW007jn3tlB/GLB4b6eNCTmneg+BpO6l3ZhWsZl+2M3sEfZUVz3sFn1ki/QHkC4UxElfMZ9CBkEzW86YNH+GWRGzoBTC5k68bErfckbtg2qNWxfYK2LxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435381; c=relaxed/simple;
	bh=LeNd1Sl00me4t5CXJexFKouTM8Rr4gR9mY11ueyyc58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FT4d1dc7c3dUOeOGeLq7z13EgyRIDMQXhUK836nuNG+GrMnY3XKu+zfFosGXn+MPwCYPmJWAfa1r7plp+YggOMxcNy9xxfejTbShzokKFo4/JCGK9aGxsilQ3IMXEDoxO93p6j/Cxq1sVbeITv2t95mKtN+YJYr+7xIr74+JoM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gx8dpGog; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-48f5ca502ecso1058179137.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719435378; x=1720040178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra6xNmZUFmFCQqOuBMuD5M9kR7LWp8krWQ+ZimOxr1M=;
        b=gx8dpGogl0R3SupSS4bydKYy73CeP7XvlEV+1IPk1yi0Us7lc6TuxeR5f58qdztbpC
         dxwa09JsAa5pY3VHw4u5gr0kTPqw11gbKC67uDhvxEGJBf2dAFJTyy++VUQlWv2GN6QC
         ilB2Men9jW+T467sFG+TDfW0meN+m5Esb+neuhPPcRzVhb0B/Hd8wzkwvqmiDSImz7cB
         2c1chItWqzlsjYcIEydWRUED8zddfljYrrYKYidcmWJt0tI3+SfyDfjDQynWOpq+2DEc
         /tiYq7GgD6uhAdS8/27UPGwcMhWEiSoph3YiV3k2RQC0iDUKU/jizt0Ag1wc+9kVsRYG
         gXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719435378; x=1720040178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ra6xNmZUFmFCQqOuBMuD5M9kR7LWp8krWQ+ZimOxr1M=;
        b=L1Mr9z4BUWUqkgCzts7ZFHkD7znj70Lry35gno/6XuB0s9UtvnQeo/Kw/NoL0rULoE
         B0mtJC5azgR8cyNpL5TD9Jjn9Mv8ip//y8vX45FLorsU75su671pEZkePYFo8cnw1vzg
         zXPSibKvOR0GGl5A017vJ3CZhDQOxFQAKrTOuqMo7Z+vYmpY2AqOLF4UMGb7bQ42chK3
         zA4AP947shE/OSY6rpaPgf7tYlsLHTVwUIRRLJmj+B87bTXzdHZ2X/DtE2b0cUnYpbnb
         MJza5E9D0wa0LrzOcmvRiO91TYXyA3IHwzc+1IXfcQ8Wh88Hr2mgROjUzC2VAPUzGmER
         jd6A==
X-Forwarded-Encrypted: i=1; AJvYcCX2/T9kwFhBbouXVzRPiBxE++Pf+D4FGBiS606XAsohb4gF32rf/7qohqFwTpKYylwrJt76qmwTi8CVNioBBeg2v2+H9ciiqIY79ygI
X-Gm-Message-State: AOJu0Yz4mN5GeiE129jjfHI75OgOYrVVrzIHb0mgF+GAGKZmUiQBMCdP
	38KGi+aitAn6YfXJJcqot9Az4RVURxtdpQk7h44yeZJAh/XMiBk/hR5SsxZlGtN9ZzG7JceBhji
	39frL3oDQJn2kI/pAzWHWwsfjLH9etSo0LaHrow==
X-Google-Smtp-Source: AGHT+IGd+fezczxsF8sdBmQyvjpmWSbG+CgYCWeg/ifXeMZVxI6nVEg79pqM2aK66grjjTiS0WLYLkxQuZGABcjv/vo=
X-Received: by 2002:a67:f807:0:b0:48f:46db:7a11 with SMTP id
 ada2fe7eead31-48f52947b56mr8666192137.6.1719435377713; Wed, 26 Jun 2024
 13:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625085537.150087723@linuxfoundation.org>
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 27 Jun 2024 02:26:05 +0530
Message-ID: <CA+G9fYscT-jC378sz7FVw_GSjQYq64=tKgJfvzB+3Gak=9wdvg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/192] 6.6.36-rc1 review
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

On Tue, 25 Jun 2024 at 15:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.36 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.36-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
The arm build regressions reported as described in the previous emails.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.36-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 580e509ea1348fc97897cf4052be03c248be6ab6
* git describe: v6.6.35-193-g580e509ea134
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
5-193-g580e509ea134

## Test Regressions (compared to v6.6.34-268-g0db1e58b51e3)
* arm, build
  - clang-18-defconfig
  - clang-18-lkftconfig
  - gcc-13-defconfig
  - gcc-13-lkftconfig
  - gcc-8-defconfig

## Metric Regressions (compared to v6.6.34-268-g0db1e58b51e3)

## Test Fixes (compared to v6.6.34-268-g0db1e58b51e3)

## Metric Fixes (compared to v6.6.34-268-g0db1e58b51e3)

## Test result summary
total: 234233, pass: 204427, fail: 3373, skip: 26007, xfail: 426

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 109 passed, 18 failed
* arm64: 37 total, 37 passed, 0 failed
* i386: 27 total, 27 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
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
* ltp-ma[
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


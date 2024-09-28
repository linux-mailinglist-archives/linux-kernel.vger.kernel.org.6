Return-Path: <linux-kernel+bounces-342474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4953F988F78
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D486E1F21C7E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03FF188703;
	Sat, 28 Sep 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pETDgV7R"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BC187FFE
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727530982; cv=none; b=GsLo3AB6zRswM85DkYbnhSiMzYy6vLuHSzw6Biu1dzU3wKUmU9PwhvC6zBxbQSpT98zQOhsc60gDlIZUw0JKtBDarz9Ipbi/l9mLE0DcdWXqCUPCMZhS9jrO1IdtoOthU24uuXIL/yrlsmpRB2iulhesmezcn1rOl7EihOXqdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727530982; c=relaxed/simple;
	bh=j8+uLbNk15LUD/swoLKPjamTGdWDzEdyurpg9CKJ4HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sx3yefP3XC222VsBo8Nd1aWF6Plz77HWeMCKF0r34mPt6syb6ibSL6x2eL8Chu5fimT8j8YKGxJzyUfkCMxT+HdJGGaGRffXYp7zSLtgWzE4Gur06ekJylssVGPEZ41t+4qNNlZibmyogRj4VwNoVIbaz1OBmE2P85hbzKAxyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pETDgV7R; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-502b8d7033cso787581e0c.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 06:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727530979; x=1728135779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c53yyAs7E6NtQLNrLLtPZdGoIfca6+dE3YJrHfT4exo=;
        b=pETDgV7RIbkKqe1sV9HRWG6CR823Oyx8EUwTOvXSFTxvxLiOgpmvOxFCcYWoejV6eO
         2xUDhwfKY3MkGeTtvvVDOe9NJjojpr9KOTix10n2Is5kNRmCGA4WB8A9XeV/oN1Ab8KM
         NY1VmAUkb6XFRWeieViT/sQUBKDEIYGIdgQmGf/FJbwW6sg98O99Tu44u/Kmpr5OPV1a
         875xQ6GMg+Ojdo9tOhhGalxW4c3mPzZRU/bMcaU5yWcKcAkGYbWpsoBezQjUYosLernV
         CJZtWnLCPoooXZ+l59l/M/u+3YqXyxxW/ceYe5bVk6NG3X4/O5gN6MwhU7njBapYsDmu
         GYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727530979; x=1728135779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c53yyAs7E6NtQLNrLLtPZdGoIfca6+dE3YJrHfT4exo=;
        b=jl52BAyOgtk/qt3H/vpIs4ZgSkeNpfqwwPtFVzQszFQhrY9r5eI8nwTZpU7zT7jFHS
         /JMgx0ysgyTvWQeFpiOmZZFAGOXIrcIdW4bySmG0EN4Je363hA71ISpl6ruGBcCuYtbv
         1n4UZ9uRduE2xCgdM6NoPHFjoadH5StHDAq6QgeKhFe+AT2uW3SvvJuraw/0utOXSU6R
         catZ5B1sgn4+iGiXEooo4zf1llR54dac69dAAojA1U6kIMPz7mRvSt1dIDVMvkdjP58+
         5yYdVzqBLomJcKWBE3jJQtmJ1glwIvZcf9tzxLEG0S7FwMwZ1LdYr9T61N23P9/6SYdB
         0ZKQ==
X-Forwarded-Encrypted: i=1; AJvYcCU98/53jzgfYQotNICo9rr1iEeVt3DfUubouPijkwvVRBigo9auBJ9Dvymog9J7cmsVnSYOAObkh2Pacxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9YHQYLsO4QscOcuU1KlCnvXPUu54ix4EreKT/3ryWCMyjSiwl
	ZWgs+OURAhH7Qa6udGYPnMRi52zecUmyJlO2c28iW6sbH7usP2P8AhZMIlX6619VvSIc2imDTpH
	hu2k7RsAaliq5zxiZdoj8nxMf1odln/QD7+hYyQ==
X-Google-Smtp-Source: AGHT+IFXav694ULLBUcIHDeEBtyNOQd2icWi28G4aTHq/JtEB90SqMDUHu4yQWX4LIEEwmaG089P2mrQbxxAZaJ7Bdg=
X-Received: by 2002:a05:6122:921:b0:4f6:b094:80b1 with SMTP id
 71dfb90a1353d-507818ca8f7mr4297460e0c.11.1727530979073; Sat, 28 Sep 2024
 06:42:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927121715.213013166@linuxfoundation.org>
In-Reply-To: <20240927121715.213013166@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 28 Sep 2024 19:12:47 +0530
Message-ID: <CA+G9fYskpf=rGsmQ2QCZ2GVvBEuO5Fc5ROWuu4a6udSB9c22GA@mail.gmail.com>
Subject: Re: [PATCH 6.11 00/12] 6.11.1-rc1 review
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

On Fri, 27 Sept 2024 at 18:00, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.1 release.
> There are 12 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.11.1-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cecd751a2d94beedbaab82f5eb42ed19b0bbff41
* git describe: v6.11-13-gcecd751a2d94
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
-13-gcecd751a2d94/

## Test Regressions (compared to v6.11)

## Metric Regressions (compared to v6.11)

## Test Fixes (compared to v6.11)

## Metric Fixes (compared to v6.11)

## Test result summary
total: 225868, pass: 197174, fail: 2806, skip: 25888

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 129 passed, 2 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 35 total, 34 passed, 1 failed

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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


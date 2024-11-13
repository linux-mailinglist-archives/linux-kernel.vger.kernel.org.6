Return-Path: <linux-kernel+bounces-407477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7562E9C6DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081E81F21C15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E1D1FF5F2;
	Wed, 13 Nov 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGFamc9z"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05161FF60C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497310; cv=none; b=JRFZZKWQUomGEoInfcU17XCHxFdxsfv7Dv7JSe9vjzTUucvj1xZtDUEHY1Sp1MTe3WpWMmK4/89DmS9dGFehCLxhEFvT3GolMuZnjFUbCCxNPMJU7aLWxzWneJhJuTRi0RWSbRR2LfjUqowI9InKrKbEpFtu2YtpW9CJdlmkkeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497310; c=relaxed/simple;
	bh=Vks9sp8KQO13fnVv1WgRw4i3Yp4B6y1XL2G/W8zMSNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahaPzYMJDXmwYbpuu4jwQ9rHV1vR4CpmPpR4Pd+uYRrwii+Mfrfbp2FGv2asHBOKUymzGIJigDYVeqtbhoXL3R+EBIFbVKkb8AV5c5f2pz+OReNZrQhbI/1iHgCL550Chg2fNim3iioxmz+AWmRTYf6X9GcPumOUS0/fR1sB0gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hGFamc9z; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5142468fa79so1563750e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731497306; x=1732102106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibM4ruWPAege2vfzEi4k/k+Sw2PCbdPHy12ELWoxDXY=;
        b=hGFamc9zH1ux28FwwpjAfUHridanBej3s5xODY2lOzgEJ4PB5/9WUdSgA8ZiMJdXAW
         gWJUZ8yfX43Uk99kvvBvzkWQMQEZs5jPWF0PVscmkbZPeQaNc3XaIZRn871/e7yrnuqy
         rCDl0IlwkpjM/PGV+4tWMSWpLaFWq8v2qbgJJAB6aTPrQXWbLWns7JlUb7eYmRk6eMH7
         Rtg5sybAxKDcLV7Il1MHUL+mViHYHRMYlvwbQrSxRsqALTDiRMV/o3YI/ARpykcSL1QM
         P5m8JEKpX6VXlIT4CAnMmCRKd3EWqKlGOAoZdHtohqWNNOXV90lUacfxLo9WDh7eBIzd
         BVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731497306; x=1732102106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibM4ruWPAege2vfzEi4k/k+Sw2PCbdPHy12ELWoxDXY=;
        b=AhrAUrxUixyuRFrtKdVl3TRQniCWqgLnLiJqb3cKna6IwkFnrl1ldMZ03fkZIs6y2H
         6PlfqERapw5bss2BaXk92FPIdwUSVjtbokG09cpYMkbgXY5Y5xJhLgfl7TUDXuq5TcVa
         g36I8Jimfdsl21YXDdjDI7YPV/rB86wLvYy57f6NEK/UMP0/F/opcJOWLqQrMC0FKdos
         1xgadO7XVjBk20HHBlgmHPey8FJxMyoUnGsbGtEaWAzohw8JqP6B6u4fZvyrwFOYmaqV
         QyH17cB7H4Zpyq9cLtfKzPRlXw2tqqlDcBT0DHtRnf8AR3vfAZM1Tvsr3lSQY2LJaEVD
         gfRA==
X-Forwarded-Encrypted: i=1; AJvYcCW73yei1LX/L74jCkGjUHwYCcDya2yGV8PtNcHpNmWrr/ZJEH3gal/72Ow8rbPYGnKyzl94nqLwXZnSKRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpyCKhsv/HGjm0y0n3hneBZRf5fIW0WXVZcecvbSjImUecWPJk
	0RGX9gwXVsz59VxgkRovV/a4T7Ot3vdXLMkqW8YqYrUlhTD1BGX+HeSXUV/cBlST7mHfUjWdAsC
	ywOlwfmWVj3HvZzIQCjUC/39wOIj8Ix47VioikA==
X-Google-Smtp-Source: AGHT+IE5XV1UJGSOQRX/qQMMlLJ/XPYR/3FEYamReEoaZPK8Bd0yQizWVt8DCQvzbDo/J6sVtG6e0r6gr6tGnujdFVQ=
X-Received: by 2002:a05:6122:32cf:b0:50d:2317:5b61 with SMTP id
 71dfb90a1353d-51454270f84mr2974738e0c.6.1731497306370; Wed, 13 Nov 2024
 03:28:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101839.777512218@linuxfoundation.org>
In-Reply-To: <20241112101839.777512218@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Nov 2024 16:58:15 +0530
Message-ID: <CA+G9fYtM3KGHE8boa1nvhJn-JNTtMob93KGubiXA+f-ak0OSGQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/76] 5.15.172-rc1 review
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

On Tue, 12 Nov 2024 at 15:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.172 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.172-rc1.gz
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
* kernel: 5.15.172-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 0ef052d947fe31190128abd44cbc8cebc7657c48
* git describe: v5.15.171-77-g0ef052d947fe
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.171-77-g0ef052d947fe

## Test Regressions (compared to v5.15.168-239-g7a95f8fff07f)

## Metric Regressions (compared to v5.15.168-239-g7a95f8fff07f)

## Test Fixes (compared to v5.15.168-239-g7a95f8fff07f)

## Metric Fixes (compared to v5.15.168-239-g7a95f8fff07f)

## Test result summary
total: 100973, pass: 77106, fail: 2830, skip: 20889, xfail: 148

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 203 total, 203 passed, 0 failed
* arm64: 57 total, 57 passed, 0 failed
* i386: 45 total, 45 passed, 0 failed
* mips: 44 total, 44 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 44 total, 44 passed, 0 failed
* riscv: 16 total, 16 passed, 0 failed
* s390: 18 total, 18 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 49 total, 49 passed, 0 failed

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


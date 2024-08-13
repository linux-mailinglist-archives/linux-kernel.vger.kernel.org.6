Return-Path: <linux-kernel+bounces-284203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6717194FE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 09:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB43FB241E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5709150288;
	Tue, 13 Aug 2024 07:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4CVyAna"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FFB4D8B9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533014; cv=none; b=RCgxlt9Jv5f92/G5Tuj1dl06vL532hJxwd+67Ls6l0YAsvKnsLaFZj80We+HRctpkGgqULIvusEDtIMCt/rOyyw7ZFTpc7Lfz0paCKWGnjuc5OUEoAiUII4xE8iX8NRRhGJ63Owk5iPCUR0nyEeJYuzG+Woxu44tN01uubnxpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533014; c=relaxed/simple;
	bh=vROMTYPZA1hbG/rVcd9OwaeuEl2pN85JgkfJTXNAQzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fwPgQzKSuNCZa9K72GWI8VttRw2cqlObNvdC6fT9IhDPzbN+RxmcaN8XPPNOWJdYXAZFMX3QQpLPTQAoQyKpvs9diBUas8rz//I8lctqX8FNNHxKTdt6iKvJRVg1DqMK0pN146AKOnbm9GkzdRIAI1pDn+3tJRNZaLVEHioSemI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z4CVyAna; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-49294bbd279so2187854137.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723533011; x=1724137811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWpt5hrm81pO0HFVAzXbDHOgm5yQRHjKeCNb3+8kYHk=;
        b=Z4CVyAna0U9J/cJ8RvSoCJWELmpJFisN4Wrr9dLPEi0xz+XXcafv9Nk0wQ85aOqoLi
         3AX5+EMzR28siTr3DXP9xTlbpB+i+tVxtNLvgec9+E+DikjRy++cjWHCgY5EqOCjL37/
         iqa5vpCILGZphEqzU224VnqcGc3dEmhk6LD/FmZtRcSqidkew1f6o8uqi0XFN2fKyrtf
         ccusTsmFdjvHln7N656nbdC/1aBdyF8/nuxq9vrfqNWuwuF49iqqfBzFCEMJ3a1fRkDk
         aFLY8Npy4a6Qc8fnUAYx0Zry41GAb146PVVxYTTiCQTBYki1pGRm4P+Emv9y9w6sMBJw
         KdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723533011; x=1724137811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWpt5hrm81pO0HFVAzXbDHOgm5yQRHjKeCNb3+8kYHk=;
        b=O6zuO6b83JGyInLeTeEOCLg5g1KyuOeCBAsDuxxVMaGFE8WJbhh8zpNBlJQfoSLvLz
         7WqOwFvjaB+3uEJ7ZRdnA5Ecfp/wRkN119sFeNe8oEdBtZWEuPKpEsq3uFFBggx+6kWR
         IBrNaSd1tzA8TgKmUjeBEisHSL3eUH4DqeZyShBmRuYCCdn+nQOEkLqVvBopviqfekG+
         nTkqsD6K/BTJ7VlC8AyhAd4mJJEBNVNhdbiQQ28X2/ecJh2IKgvNfX1hEN5JJFN+vFIk
         zb+EqBv4j6N/hbH+tTb84Ye5kVV+x4G5eqcRRFZqKFvvk5eqrTajv9PxVleo1uMRIvft
         cFCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ0Ix22BAtVtpAH43RECFXA+XHf+Fq6z8/NdIs5YaLDPvpoNYWf3C4WG723tKWrh7WC+wWYDX8t7Gr7zLdpKT1bk6cocxi/G7ztalr
X-Gm-Message-State: AOJu0Yzu0wUgeQG2hlKPv/6HLZUqyyJITs8hzsAqkZKLncZxBSkSpARG
	hVSEN7odw4s0ggHAz6sbGwzx6EDXhMvaeD7Eymhy/1W26Rqj7OLW2tCOBUQsXYMIZgYQrND/fcH
	4nVCUzR2PWv/57rNVT5EWw8HaZrtq6zKbSJU2zA==
X-Google-Smtp-Source: AGHT+IHWNtjVPQ97SmyDE7vc05XgRLIP5TFW/d0cX62CVeQ4XzpbMqbYToCfV9aVegqByWYG0KWVvi8nUX3uozUeCX0=
X-Received: by 2002:a05:6102:54a6:b0:494:3a01:e340 with SMTP id
 ada2fe7eead31-49743975053mr3518939137.6.1723533010700; Tue, 13 Aug 2024
 00:10:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812160146.517184156@linuxfoundation.org>
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 13 Aug 2024 12:39:59 +0530
Message-ID: <CA+G9fYs6LCnr8UVXVmTPga-LjA4VuMoEfRP+=LEmQFZQxA+=JA@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/263] 6.10.5-rc1 review
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

On Mon, 12 Aug 2024 at 21:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 14 Aug 2024 16:00:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.5-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b18fc76fca1a63141db3c822c1b169a1ca4bb08a
* git describe: v6.10.4-264-gb18fc76fca1a
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.4-264-gb18fc76fca1a

## Test Regressions (compared to v6.10.3-124-g83c63da99a03)

## Metric Regressions (compared to v6.10.3-124-g83c63da99a03)

## Test Fixes (compared to v6.10.3-124-g83c63da99a03)

## Metric Fixes (compared to v6.10.3-124-g83c63da99a03)

## Test result summary
total: 257536, pass: 224323, fail: 4505, skip: 28188, xfail: 520

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 127 passed, 2 failed
* arm64: 38 total, 37 passed, 1 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 26 total, 24 passed, 2 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 18 passed, 1 failed
* s390: 14 total, 12 passed, 2 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* kselftest-timesync-off
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


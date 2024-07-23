Return-Path: <linux-kernel+bounces-260318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79E93A6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 20:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06731F238BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA6B15887F;
	Tue, 23 Jul 2024 18:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pobr9MNx"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6A3158215
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759893; cv=none; b=XS2b1d3A2AN8y/1yHnJQ52ZZyZGEKM7HcKoIryEFGDQOk12liBQLozm6N/DVlNwpsNCevKuN0yAici2I3D1okl5uqoeuSI7pjFdssvJkxOgIV161519gMn3R5+YjGz1s6NKI5m5Dod1rIelegct+E/SduYcsFjetDIls/HEBBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759893; c=relaxed/simple;
	bh=Ge3WxrotjNrzL00XKRfbP/uNGGHiypyVh6q5S9j+248=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkwHCGdjB+lvAVsNTSNpMSkSHD0xAYMfzzenui7S76tuWDNgGtD2AJbHxxuJqVDIGTfAcQzhmW5jxiTqi98rADF+CQFo4rScMYubJRzMx4oOD5N3W1c128J8ClJcTDVzYPaRwVawtdEC3HeyGL7QwUU9o+mfREdblkxUyFpGa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pobr9MNx; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4929992a5e2so721600137.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 11:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721759889; x=1722364689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipr0XcShgfcsyciYV8wkZgCrL02KTwzXnz9fJeg/Kzg=;
        b=Pobr9MNxjrmXPixvA29418nVy7xXP0NBOmBBraSXf49UXu/KqLalRNoWlHuj+VELY8
         jQvMSbqeB1CyZm3qOmebmvvPqVjZwxqHXok/7CjIm5fot0GFhVUYgQY1Dm4A0M6BB20r
         w2KFgTamPAexK6nJUJ579eK5/k9JOr+I7QQIbHqushgErlu8IZfAHJhymsPIRR198jIX
         VxK+GMtRue32UQedPkBgQCNbS6pEazfzauPkrIDvi3aNkidZ3tPHINtpSsQ98yr3AS/F
         fj7+cwfH1ZhCoIed500+9yV+PVNmVW5uJm/uqchvFy2VUF60nGdd4dHr0MuFNkPuy1jA
         j7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759889; x=1722364689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipr0XcShgfcsyciYV8wkZgCrL02KTwzXnz9fJeg/Kzg=;
        b=q1tj2Kzpdu/KYKGF7k00hLOxZJ57Dc0j3AGT3qNyLXQKOWw1+gNgJmAsTyIE5wNpze
         j7N8aZNaIrgr26TqYNeiIaCuRr915P/C5zLLYU5XcS9MG8DBGmaWlrYczw9/LCSm3Wo0
         jamzIBN+/Ovb1i+tj0aSSccBF4iBFIqhqW984Vw3geQsJTVcugjldvHPiyMz3N14TLni
         SZ0MMxqsQ8D5DiOQ3FrZf88+U2ZY3/YnZPCZOgbbYakBAkoInUH1nSRx3dGcob1a44v8
         9Ov2squztiMYVoT4cRfpYTCNHUt0IFG2YqNej9RXtfuW0hvurX32S3PcWy/tnaH+LfPj
         zs7A==
X-Forwarded-Encrypted: i=1; AJvYcCU7/1EvfpZktPuSlXgPJjo4xQoBpImZ2a78xjQC66YnmTJol0QxNLyBRdd6EKcPJhZ5cSdgVLR6MDHsR3UDRVRCGugsnf5kamdKCHS5
X-Gm-Message-State: AOJu0YyqDn1u2cMnSEgIHxvQrGCFvADufgInAED6pc5WpXtwMJssGkPs
	+Xed4AWKALhM992GB5JBa4Q2fdydLfVrj9P4x+t6TDvwf8ABcDyBusbkxg1IKrDR9PqU0iWrPQJ
	HtWhYGPvDf/EUqDohLeXk7HNbF6r0fNNJhcgy5g==
X-Google-Smtp-Source: AGHT+IGjStf1+gKYAOcRXL39zVgs/kvEBXG3k+m9YVlM9M6yee3F29SJBU/geneXmlXSl3KAjzJKDaacNuqpOml7o7o=
X-Received: by 2002:a05:6102:524c:b0:48f:95cd:e601 with SMTP id
 ada2fe7eead31-49283f764a1mr7019041137.25.1721759889383; Tue, 23 Jul 2024
 11:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723122838.406690588@linuxfoundation.org>
In-Reply-To: <20240723122838.406690588@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Jul 2024 00:07:57 +0530
Message-ID: <CA+G9fYs46y-MYAGFLMPuot1u_xu1Tm8y++MJ=f-sfBv485iw-g@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/11] 6.10.1-rc2 review
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

On Tue, 23 Jul 2024 at 17:59, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jul 2024 12:28:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.1-rc2.gz
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
* kernel: 6.10.1-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: e89ad42bf499062626c95bde62ab0b51d8d9e658
* git describe: v6.10-12-ge89ad42bf499
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
-12-ge89ad42bf499

## Test Regressions (compared to v6.10)

## Metric Regressions (compared to v6.10)

## Test Fixes (compared to v6.10)

## Metric Fixes (compared to v6.10)

## Test result summary
total: 197889, pass: 173134, fail: 2878, skip: 21877, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
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


Return-Path: <linux-kernel+bounces-367524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899779A036C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4168028756F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD311B2193;
	Wed, 16 Oct 2024 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F9SI5TvI"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596F1D014E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065576; cv=none; b=rC4mPYxdWMWKNOFbvL3BMJg2pW1NfTCaQ/kr5GL42ms9k5frJH3Dc7ZtKXX4C2UBNt9JykJJtoOhCWEKgJOT9yKhhw8FtizuiH4gHU6gIbffCKUzdA0TFy5x3klLRbEPeINAG89Nnrq1FWZf0U63xTrtz4QlzW56Rxz8YHOkDN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065576; c=relaxed/simple;
	bh=/BiKXgb/ifi8dpicYpJPPROj1PZWiwo5txuUrOXm8tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lRIc3qm8pZAr2kT1UlvU85jrp2phWia3nDece6gFvHWhObgEzC1mhHqbeqKeauoQdkvXtOAzNXTsInp9Pc42WN5dGhmzXbBqQk+Sww9gWckmATankYL6B95ssyKZYnYS+6V0P4z6oc8XBWSiLQHGuxU+EwTYje7o10LyCWsb8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F9SI5TvI; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50d399891d6so976591e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729065573; x=1729670373; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvCnBTztCAnhD2mHou1d1ZIRw6cIuOdYGceF0zdZt5Q=;
        b=F9SI5TvIRiEUTCVlZXuS0C9ebLIqYl7jaQqwbwgt2YGqXRXHU2kx3HNegEMY4YILNF
         1SgZbIyBYvb7u+lRk1iibyb+mLqeDU4DPxAQUq/95ONW+HE4Z1kaFeMaLVwmkXcKEd9j
         E7p2J+6Ut/441A8Rv2ZiyY7UxIX9RVsqmD3k1PrU0dJzqqT+n1/O8T9Bckuu0SLIer6i
         phcq5P617hwzCFXS3MPw/ppyZT9Cu9jZrvqnNz6WDimlzNUFkZqlKtaYHZXxzB/+eHYg
         XvPJ+c4QRxBTb00JZnvMObiCdNVF48F/2XYeoGO0bm8mTF2x3CgJJIU/JkzafhZgbI/7
         ZQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729065573; x=1729670373;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvCnBTztCAnhD2mHou1d1ZIRw6cIuOdYGceF0zdZt5Q=;
        b=xRxj8agvvE9unBSiuZm7Dvg2S2TP7d72zb6oPp/AQscRJlHkKUL+QMSLxSXmyzsdBK
         StyGtwtptVPnUTlw/9koEnJ0b+GJDFXx52jacvxVAMWnB44b0j26fDRnLiUV9imAQrgd
         QRyFzcbJAno5NqApWYsUw3QXKPJfP+WPjfX0GgLXnWoVzjpRnC/ZO3Ae/BFw5fhPJPN/
         xPlTjctAKSejquWGFBXNDMeRZnmt2NKKSeIgpqlsVNQRG0lF6W1pafzu/5YpnANw+Yed
         jpsYNRsnHe8fKUXON1DD/l4MHJp3TLAa/cZiE7XWl1c/G4b3q0qO3KW42qI3Cgv0aj3r
         E+iA==
X-Forwarded-Encrypted: i=1; AJvYcCU5SQVFPqFopkozxscudQQRajiLMghlK2iBhPESZZ8fukj+Yx5Dz8dJNQnu4KV+LLM5O783msK0XrEPcLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlEYLwZk4gYA5ekkQ0egUBnBP7jSIbaMeY+yHw3eCqESe1VfmJ
	JvgT5nf4S8y8fcjnBJw2JVJdNSZDSC4Xot3TdpeHEJ7BglWbAirTMbb5G0dl5zvq3yyun2WI/+F
	GsrcvkslwvRDKwxw2goJCA2jahHuElduk6iEweQ==
X-Google-Smtp-Source: AGHT+IG4hpwFBZCh4eDUtnLHfS4is5WIEfhKJ8QttRME4agWUgCKIL3gqQiAFbfsookdZ7aXIpHbJF73RL1Vb4bfH5Q=
X-Received: by 2002:a05:6122:1acc:b0:4f5:22cc:71b9 with SMTP id
 71dfb90a1353d-50d374b96e2mr8280137e0c.5.1729065573128; Wed, 16 Oct 2024
 00:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015112327.341300635@linuxfoundation.org>
In-Reply-To: <20241015112327.341300635@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 16 Oct 2024 13:29:22 +0530
Message-ID: <CA+G9fYtmRGt9pXfRk=Bfnac7gbotdw8PcEsSOmD0nUefYHuBpQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/211] 6.6.57-rc2 review
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

On Tue, 15 Oct 2024 at 16:55, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.57 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 17 Oct 2024 11:22:41 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.57-rc2.gz
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
* kernel: 6.6.57-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: a3810192966c3144d8cf988e8a13fc18a2dde677
* git describe: v6.6.56-212-ga3810192966c
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.5=
6-212-ga3810192966c

## Test Regressions (compared to v6.6.54-387-g75430d7252ba)

## Metric Regressions (compared to v6.6.54-387-g75430d7252ba)

## Test Fixes (compared to v6.6.54-387-g75430d7252ba)

## Metric Fixes (compared to v6.6.54-387-g75430d7252ba)

## Test result summary
total: 161514, pass: 133557, fail: 1868, skip: 25978, xfail: 111

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


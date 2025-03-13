Return-Path: <linux-kernel+bounces-558912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8452A5ECFE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3331894F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EEF222562;
	Thu, 13 Mar 2025 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lTBOAUyb"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515D1FBEB6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850904; cv=none; b=L6Pq3Hz4EC6AYEsqG/6Mo6wg/o2MeaDr5U6iB28T8h8OJw6qwqevqKlgTLqXw45vU1OZgbPvHRLR0VV186mEVfX2x2WoskO3TqbuwZ4lvBU8Ppc62ltSCKF9yZHUPS0yN3XB8j1sYu0rEw/+JR2/RKS98bNz/vtZI9k4R0zf5mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850904; c=relaxed/simple;
	bh=JJokp/CKQZLqokfC1w2VhhlIWaQHtkolCqS6Urvxxko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DaB3KOimvJAcwb3JFnOdlHscB6P6ywxY/dQE8/jcmIyOXFVCvgMXfaRXCjIut8eJH5xR4pTHTLZaY2jLLWdnk7rQVbw8K+LD7VSxOeLkzeBXGYNvlJrvLExTDr7ZPLyu0wJOhLh/A4fGJ6tPDB3HWz+gO+29hUfYybibRmYDXAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lTBOAUyb; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523dc366e42so252282e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741850901; x=1742455701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9GsaOplAxyko9C5PtdLfN/NTW4t3muSEZ94FIoQb5g=;
        b=lTBOAUybxs3a4n1SlxvBONF1imvABIVCRVUdDOl6QxHfMBqzfG6WV+DJwJkXdLoL+e
         wGqdAWBlmPAgsw62EZAwD7uoZnG39NiPpyYEah3mNjCu55Fs1GfrMZo5rJsOuSIph2Qi
         h2MlvD9lXHwXkhSJCcBHV2KkrvoghKRMcMearv18JNT4yIgWZXy/cu7WSTSUzDDa/yTC
         lnHH2jK/U/AD90xyjzCfhHLUwPFlah1UhBUVPnjk0bX6aJtzYOr7/jm95rSJNdeECxlP
         ozMs+xrzVQMNJB1ijHsKvb0LCu6hjjeR52j3WmJ12vjGGk4gSYENyhxS9fCC7wV8rBLw
         A70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850901; x=1742455701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9GsaOplAxyko9C5PtdLfN/NTW4t3muSEZ94FIoQb5g=;
        b=qQNdoYUICYbwrvRBH004FKd8EO8G3QhLKYJrEtz6QsMmbXZIHsiQJHQUtsc5nR5mMt
         gcen/MdL1+Cl81GjfKpmF2C/ZVhHN6Z6E5p+bqfcmHeQwOQVaVyMxTs7bkvaa4UBVvJV
         oft/26/192YZKkzPjZmDO2TCwJELr3Ibbf+STKY4IQ99CZ0Efqv+Q6XyQ/Eto0NfQyJ6
         6Cu+jjgGYT82UN1OLPtrw1ZpMjcaf2eyqDzwV6UO39EB4CSXBtz1QWGTc9ohixQiocPe
         EOvH3zFURZWz7kFmi1uLldCMQSAR/XHPUhBb3oii4fKMa54+SXdO/aJs2Erxc41qe/Xa
         6LVw==
X-Forwarded-Encrypted: i=1; AJvYcCX3I5/RETTy0Qd9Atjun/+HLhASs+v7NJXmQUm52H8SkOrly5tJgEwsB0FsQJ+wrm4sWtpHPgD0jJ0oSrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4u6BtzPpYjQ0IUpSIrpMMpqFXoyszGq8lMsoFu6y+PTlGnibN
	CMxYWAo345lL52+q+OdufkP6duMu5JAZJFN02sUJ8YNuBgWwOv7RNkt0PFlPiRKm9DMPCYngew0
	VnADt3GFNwF/Y73UQwH0Zv4Wysf17CnEPHZlr6Q==
X-Gm-Gg: ASbGncuRvBGe48PfWbhWMA/jfRM1yk42eVAwmzMmVG/pDqeL8cOzpkpm7Qj6U/lneJz
	x44eb0QVuVh0IFA4tLNpN3ND8I0O2/IRYvKUrpYViqsoeKdEBQOO6UMqTkcM7Spy1omXuA0hyNm
	GUP+vZ2nicWHV51jgwhHmDteEPutjhJE0baJ6/r2FOnzfgj/cWC1FBFtKpea270oj3yFxerQ==
X-Google-Smtp-Source: AGHT+IEArvJAZ5UguwGcppghBvPRVvfpId0PIyf+pFN+dOk18wNGtp+xcG06YxdIEMdaeCM8A6U4/JtgkmueEDLNCAI=
X-Received: by 2002:a05:6122:910:b0:523:e175:4af1 with SMTP id
 71dfb90a1353d-523e426529emr19254504e0c.6.1741850901634; Thu, 13 Mar 2025
 00:28:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311145758.343076290@linuxfoundation.org>
In-Reply-To: <20250311145758.343076290@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Mar 2025 12:58:08 +0530
X-Gm-Features: AQ5f1JqaWd2v1fXzfup4wZKObpDD9kkTyqWwE96rDq4hwaFSmi5SULaiVlr9Qa0
Message-ID: <CA+G9fYuBvqPiiuXfd3yZaK489KCwoLt9Sk=tR0jMjSp70YxUJQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/462] 5.10.235-rc1 review
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

On Tue, 11 Mar 2025 at 20:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.235 release.
> There are 462 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 14:56:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.235-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

NOTE:
The following build errors noticed on arm, arm64 and x86 builds

net/ipv4/udp.c: In function 'udp_send_skb':
include/linux/minmax.h:20:35: warning: comparison of distinct pointer
types lacks a cast
   20 |         (!!(sizeof((typeof(x) *)1 =3D=3D (typeof(y) *)1)))
      |                                   ^~

Link:
 - https://storage.tuxsuite.com/public/linaro/anders/builds/2uDdzxpnkQaVOXP=
setXcyEGCkjq/

## Build
* kernel: 5.10.235-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 92c950d96187151bf683889647407b8869ea4641
* git describe: v5.10.234-463-g92c950d96187
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10=
.234-463-g92c950d96187

## Test Regressions (compared to v5.10.233-137-g99689d3bdd98)

## Metric Regressions (compared to v5.10.233-137-g99689d3bdd98)

## Test Fixes (compared to v5.10.233-137-g99689d3bdd98)

## Metric Fixes (compared to v5.10.233-137-g99689d3bdd98)

## Test result summary
total: 49601, pass: 34341, fail: 3928, skip: 10994, xfail: 338

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 105 total, 105 passed, 0 failed
* arm64: 32 total, 32 passed, 0 failed
* i386: 25 total, 25 passed, 0 failed
* mips: 25 total, 22 passed, 3 failed
* parisc: 4 total, 0 passed, 4 failed
* powerpc: 24 total, 23 passed, 1 failed
* riscv: 12 total, 12 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 11 total, 10 passed, 1 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 29 total, 29 passed, 0 failed

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


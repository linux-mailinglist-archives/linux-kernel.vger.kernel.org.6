Return-Path: <linux-kernel+bounces-523406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E695AA3D660
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201863B2245
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA3A1F0E58;
	Thu, 20 Feb 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqAiIecD"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362241A7264
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046864; cv=none; b=kTcLrUI9Aj0cD5UOib4QuRbeqWNv7DkEP01T96U8Yyfb5HbpdN0QCLa+OUNzPb9dzQr5cEWc4ZH4XvVU+qvaOhU7+Z/nnb2VVFd4PkpcnT90FopX5Elv9p/brCpNke6lCB+s2sTVIC+7aQVMy+xjuKl3jsrhg6/W53501BAuS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046864; c=relaxed/simple;
	bh=6frE0vp6y3HVTmi9RgUvDBuegudvnfMUnz3iWcIW+d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMt0Oj6BhunXB3iLhhB8GkpopEL9LYLqFT6KrDEcZL60Nz9F4732S0YyAI8GsfF7wc0tS4934KaTxkh6NlAlRj/BMyQ34wRJwlnXsITrfRj3Rbnk59j0h6Lv4pQXHq8RrQkLFjxdx4LDzCBufwAirCxOYdSqrbwvdgOgE8GIq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IqAiIecD; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4be75b2bbceso303784137.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 02:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740046861; x=1740651661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k8Xv75EqcSkSe3mhxEP34uuxE4pk6TaXrXbyxkMwWg=;
        b=IqAiIecDh4Hducuw4a0rcWVhIO6dNGT/SBMbrAc3ogLyj3XypByfCznBzJ1xVd/aLc
         TbJ5PYXR0EGs/iP4SX3c/m7+fPA0q56yxcdsG9a0TNZIUJncaRcpv9QKRSqF7fMDCXOa
         rbCgeI2B1EcxeHvUbqtgxTD0av8u3+N+mPtbFfTJ7mw5WkgQLrRpkdbywqy6Uh5JLxrx
         LtCZmrY0UO6TZ5j7vAJZmYSNAhZmIbkd1HU+PcP8rJb76n3q62oI6xVQADTQ2v5TI2lr
         0tLyIdttZ0hUCwcag8PBe1Br7Ru0xlHYdzdXOfLdJ7XhZxz78qvxFVh6YISbnKXVIXA4
         Juvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740046861; x=1740651661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k8Xv75EqcSkSe3mhxEP34uuxE4pk6TaXrXbyxkMwWg=;
        b=p6q09X7CXAoQoskP7jtUL6Ya9wCIbvtZMotEmoSad6B5pJCm2sSHzUFoAWQIq//hLQ
         9VfuWJ64S2miS1qIJK9njShNu1FizZc0ySKZrxKz6LAGgFjrZcXjIpHV9FAscP93RBzi
         eMotXTYSpIZl8Z6Jv0Z7S2U1Adg26WYxrpa4UWHLQl1cq8KxKM6qUdpDsaozvyVtpkwl
         9KGXz/uRF5CZ9NQYTsRNwT/kk9bPzcAgkcH9Mnov6MzOm+oP939EAnx4SxdAnTaJdGtr
         77/8tCD7wjSRBEVt38dgoADG+6JCONdEVBwPhB72Rai6ZSMVsLWawKBcXvq6YLQ1ADxD
         TuRg==
X-Forwarded-Encrypted: i=1; AJvYcCXb5sn/XIMWpdDmBvOTUrmWNTrQclmnnDFYrRGohDtha5EL0/gLdi8l7kTc5KNxY7mQiOsVnxzowT3v3OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnqhr+o43vEX3Qod7TlJEsllU59TfDY77tIyaq2grxgB3y2ish
	sa/scxyiQV6WOl+1COJTKMjF8h319xmhONFijEt4RUMwuBgxX6L6sSdKitGDPZVTstl1iPPt6Ds
	ApFqvCB6ucOm5U0RBRR1lXkK508UvBj+nG1f3NA==
X-Gm-Gg: ASbGncvy4drBPJrJWOc+wRgiuV+XTkIChI1TDrBG4Pod0+x1NGZOFZlLsMos1hvGT8i
	c6cPsWeQBRfcg63KdmCNye+eM2X9/FXFllOJaoyFBnSBM+GsbSZ2BJNPkSTkCx25oGl+rc3+rqa
	3dYibmUS6/CeuO1uJAES9acB6g2SbB
X-Google-Smtp-Source: AGHT+IFInYZHm7C4hUR/bAXuSMbJRq4zNw1A1MvJ3R7C2CSGTVYb7DE1aF7XXblhP3cvEX3tLRlDXUFwsSNxmjU/8iw=
X-Received: by 2002:a05:6102:419e:b0:4bb:ba51:7d47 with SMTP id
 ada2fe7eead31-4bd3fc1736amr11244784137.4.1740046860944; Thu, 20 Feb 2025
 02:21:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082601.683263930@linuxfoundation.org>
In-Reply-To: <20250219082601.683263930@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Feb 2025 15:50:48 +0530
X-Gm-Features: AWEUYZnjEZHYrIoBpvhmpHthSyaTw2Gu2OpPu2qINvCA060fTS-WHY7Wc0-8vnE
Message-ID: <CA+G9fYv+omVvudRAbqMpAv2zDQKUOkz8pxs2dPv8c8fmiXcJFg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/230] 6.12.16-rc1 review
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

On Wed, 19 Feb 2025 at 14:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.16 release.
> There are 230 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Feb 2025 08:25:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.16-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.16-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cf505a9aecb7b64f05ea37f7304aab81f6f5aef2
* git describe: v6.12.15-231-gcf505a9aecb7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.15-231-gcf505a9aecb7

## Test Regressions (compared to v6.12.13-419-gaa95ced31609)

## Metric Regressions (compared to v6.12.13-419-gaa95ced31609)

## Test Fixes (compared to v6.12.13-419-gaa95ced31609)

## Metric Fixes (compared to v6.12.13-419-gaa95ced31609)

## Test result summary
total: 61807, pass: 49873, fail: 1962, skip: 9939, xfail: 33

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 137 total, 137 passed, 0 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 17 total, 17 passed, 0 failed
* mips: 32 total, 32 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 38 total, 38 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 24 total, 20 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 3 total, 3 passed, 0 failed
* x86_64: 44 total, 44 passed, 0 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
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
* kselftest-x86
* kunit
* kvm-unit-tests
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
* ltp-crypto
* ltp-cve
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


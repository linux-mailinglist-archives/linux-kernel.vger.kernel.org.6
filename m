Return-Path: <linux-kernel+bounces-555679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED9FA5BB2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00C91896228
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C7228C9D;
	Tue, 11 Mar 2025 08:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nj37VOb1"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23675229B17
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 08:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683109; cv=none; b=IlwvykmTBCdqtrTcays/SJNrCk/wJOkHBrHE+dixVBoLJ+EcIPiRtMKLrI6R0RyCzUdyPx7N9OgnXgC/fSYvDHID+NhaCKsXXalY5atS8vGN+EG9+QdzdGbliveZ1gr1WwbYutbFCVwikcqs9DJ1D3doyEItEYGjT55/mFbOUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683109; c=relaxed/simple;
	bh=HPNdhAS6q4hJlEkYVU8ify7rPXAu5A0kWRiO/Tjhf0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0Y3NQH7OA7Cf7M/nsSd95c7R+5YUbK5sjSMMWSXMv7Qc9KRoyoeUZy3hQ+FVbh4DGHmLHPpDRZJOWEGil46gFtemHPu1pDdHik/yKA0GbLEi2Oir+pwJC3hY8Ou/BREft7AqCBsbfPHOABr2UIjl3Tv+Y8cLIbpNiu4TXRgeck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nj37VOb1; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-51eb1823a8eso2387230e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 01:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741683107; x=1742287907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHVvdfi9fw3XBMolrd6Lm9XR3k0CHaCADu/v/LPpSJ8=;
        b=Nj37VOb1JQ/JXrdxTWMHVBulK4JLtUUrmrcf099SkRvKxo8pS6ZrDuKvlRGg/k5vIl
         npvP7U5wUnwfP5h+6FjC5Yw2LIms1zJ+b4eqgo/U5m+Y3VXmpj/URMDxF4zl3CKm4cUn
         yvRHwcKG2Mv1s6oc2SYVUxXaTBlICr+nxI3q3pZSQMt1OpHo5IcriwY6nXdDaN1tPDRs
         p/78525k4qA5ZBUOfk+3guK6vQ3bV5oJSxKlzxiMzlocXExICTQNIpdmiBiMXg9LMX3U
         zFrVvGY6iYBeyQ3y7dz4kYvjo4em25zrE701fyHIlNUsFqK/5Angi7hdZJErDrGaQUQ9
         L9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683107; x=1742287907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHVvdfi9fw3XBMolrd6Lm9XR3k0CHaCADu/v/LPpSJ8=;
        b=p1FMKNZrWpTqlmgoUH+kTM+MKRMz0NxEI1OkhCi4bXxk93tSbQ3gSs35TAx4YPYsQW
         hC7LJdI6Hz4GwUmofWKFLsBVRpEvklLRqzrYdSS8s5H5ycFgfWAP29nSNUeKbG28WYcT
         X5D76oK+bN9jQpUZffsRH7LZg8N2F06iSlvDYLCjmT2owsRaexDEXqJA/dCPhgj2zBUV
         uLKFm7aFj17+N3muNoblk6XH5JWZb76WhYeykLF4zngqGkMLEG+BD2xd6usHU/gNbJ3T
         UZ+U/8bjZCKXsasAAqeR1uihTsFtgzaECVd/xN/qy1HY9Ryp+WlmECUjPSQqp6+MEvMS
         m+Iw==
X-Forwarded-Encrypted: i=1; AJvYcCVQjCc4ErXtBxz8BGwUphndsEv6hhPTsJvUzGDSk9Ftk61S3Ka9dfZ9RjKJ2FunGXohCI36+Wg5Yki81uQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykxqV680T4CrO0x89WPxK5qF4o3j0pXGLxBsPe+iABf2+hMHyJ
	LGyUoxy3bhzPOBQpISNwv2XQeifl7q3qTfluRNwPGqo0NMB4Rivcjg03RAvMlm1l9O8cPbimYTy
	Q/m+YrJn70+VGFkE/zsCZ7slqdsp5vKdEM2JkMg==
X-Gm-Gg: ASbGnctMK+g4/x/MmdqS243Fgs7a+ZC5gsMn8XbjBxQMdsH566fo+z4szxHmF21JYGe
	b3awZxn8JgljPByVGq5bgT7HjWF5xELJ6j4vnaqoh6FZCk2ZwB/Mgr1n5KDVGVxp4hR0n6ekoTp
	8/bNjqAKZlB7YN5vx9OyK5uKA67xTH8Vy4Mulih542Hnis4Rk2KeySnJOY3IwIokOJhnzJ
X-Google-Smtp-Source: AGHT+IFG87WJBUN07axEnNFBQO8GIGA3RY6dJYpFsIX3Fmx/B5ZuwEQC7eC7oUZsVpFKrBt8H5TzNtQSV0BzU0oig0M=
X-Received: by 2002:a05:6102:3c91:b0:4c3:221:8f47 with SMTP id
 ada2fe7eead31-4c30a5ec42dmr9492887137.13.1741683107027; Tue, 11 Mar 2025
 01:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310170545.553361750@linuxfoundation.org>
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Mar 2025 14:21:35 +0530
X-Gm-Features: AQ5f1JooV3MLbYovESnxXnmOYc1t9lEZkMPZWgF3fIOZCs9YHjSOSnUmd-UVZ5Y
Message-ID: <CA+G9fYsm6xnNuPsCSt7zB+-z6xhKrdLkwnHLkFT9XBCPCBf76Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/620] 5.15.179-rc1 review
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

On Mon, 10 Mar 2025 at 23:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.179 release.
> There are 620 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.179-rc1.gz
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
* kernel: 5.15.179-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: cfe01cd80d853c272b062feed8abd34216550de8
* git describe: v5.15.178-621-gcfe01cd80d85
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.178-621-gcfe01cd80d85

## Test Regressions (compared to v5.15.177-25-gcd260dae49a3)

## Metric Regressions (compared to v5.15.177-25-gcd260dae49a3)

## Test Fixes (compared to v5.15.177-25-gcd260dae49a3)

## Metric Fixes (compared to v5.15.177-25-gcd260dae49a3)

## Test result summary
total: 43796, pass: 30152, fail: 2641, skip: 10731, xfail: 272

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 105 total, 105 passed, 0 failed
* arm64: 32 total, 32 passed, 0 failed
* i386: 25 total, 22 passed, 3 failed
* mips: 25 total, 22 passed, 3 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 25 total, 24 passed, 1 failed
* riscv: 10 total, 10 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 28 total, 28 passed, 0 failed

## Test suites summary
* boot
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


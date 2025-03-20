Return-Path: <linux-kernel+bounces-569558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB176A6A4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D8719C4499
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF121CC41;
	Thu, 20 Mar 2025 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rgUBvizD"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E46421C9FE
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469264; cv=none; b=TGITB14XGt5KY7HEF1Ds6pf1gPt5cFLoe2oDpI6EZu/qClW82+KRvQTUF3e0y27P0MELipnH7exzKjtYDww+XbSGc8WOeUWX33uJMDoJ6IKWhAbQo/3HGYSSonZaDGo5ZS7GsXh714EauWG0BB2oOh3aDWEHh2UNNMQndWoU6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469264; c=relaxed/simple;
	bh=gs/RxkOw+9zHjxMDkCWJn6pZjQhNWaAMP47VKIpV66I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xgh4dtrFKt5iKbIGmCHBObbYoQU4p7p686kLo8IZx5IqtBTvonekut7qFl/rnSON/8c80m2NmoMTGMujijALHCchLQdQaQY1TpAmK07iQKueIBrtHPG8Krk16AZptIwXOfrjc1YBDSnZaqnpmNR2N3zR/GJFq9UYZDerFy1ckTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rgUBvizD; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-868ddc4c6b6so251019241.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 04:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742469260; x=1743074060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ/40pKF4KOpdCreVXcSikFdMt28zfpEjIGcB1cZCPY=;
        b=rgUBvizDPaw7hzQx96rC7RD3p/PAk6mPOovnTXdU1EpeJDh5GFTUHYUO5yPgF6DSPd
         N5OmUW4lFL1U+1c0Hu0vx3X3iiweK0UHbzADCNeqbjioaoyiVxMgsgIzy74e2SpIEVXz
         NOlk97Ec85wiMXhv47iKqy10wFwZcZutHdZd8q4Fx3a0W88OBsl6vHS9eyYNnnebpsdi
         wv1+9W+4n2qoaSv1YqGqooOmeisMe1YTfHMX3DN/SvN6xthDWMVaHtTu8T4Lg+LAVEpp
         0xK8fQhExj1iSh11W2smVVE0wwh7p/33JgH+uQryEQzcmGgvv2lFeJILvKS6NPMQ83Nb
         EIKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469260; x=1743074060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZ/40pKF4KOpdCreVXcSikFdMt28zfpEjIGcB1cZCPY=;
        b=N+EERQ2dITN2xu6lUosV+X4lg/XW7u/upfBwxEENRaDsSmvgOpk9E16E1KnkjfMarE
         G9VJPoMsdGarxS88F2WdAe0YoGqF/oSTngnEEqNLYYynC/qIDesPlK0JeoC3Xj7im5v9
         B8jA4FdNmMpgR2Us0oGI/QmVE/5d2MpHGcjxNpJgHT252fGLc5XJOaYXyZQMkinz7D2B
         6datdDm8bM7xMEpmMqGUpADFhsitXkagORQ0S+LqsHP1jzG2xoMczD2iBTW4KwvFTUnS
         nKN3GHMI6v26UIXXaytAaJjZxzNOxNWPDFkIzXkOU1ASDgBE3Fx6wBKxTS3pEZL2f16x
         yzOw==
X-Forwarded-Encrypted: i=1; AJvYcCVve76VKLEpPBAE7tfd9Qkn9uRHI0QgcHNSlKaSI1asJ6xbNwfWPCEsEFlIODh7CltZTaN2n4tDJvvZW0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx67Q88wwpuZiY5/tLvX8hsZZaIlZ1BtrXBDapQd6jHt4Gz3htV
	cUUY2c59i1X/pikck8H0PCZW3oFJKls8Mghj77yETpjOSI5U7xXCWqTab1bnrP+QSOo+wfG4xBJ
	hQ/IrWKvyb0kfnhWiuWXZcF/Y0WtcCniKg5E3pg==
X-Gm-Gg: ASbGncuf63OghqUqpiFmX+hJDrZNqmZnYYteyiVkJ5lHfAamsBzqqUa5J33cUl6Iv9Y
	2zoD5FhfHgrTqPzdHV40Y0VvkfHmBVhdWvbbVKIlj9JkJ1w1ffPMRm261KVk2iYb0P1XPmJo8hA
	3XskBeg2z1aCCeKuxYhpiZhLHaleb4x1ZndxbVoVDKNTEwEJ6semBVrf9tVrO2Wge4mQ==
X-Google-Smtp-Source: AGHT+IHUtzsWp+sZFeHQ/CjaUDM4MAxDpqfXXpGW84EHC4lm9dFq4u1+7xTW8CSUfTYmAkSCBCCAkGX5tv67AWVQENY=
X-Received: by 2002:a05:6102:2926:b0:4c3:6ba1:4129 with SMTP id
 ada2fe7eead31-4c4ec821abfmr4660184137.20.1742469259807; Thu, 20 Mar 2025
 04:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319143027.685727358@linuxfoundation.org>
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Mar 2025 16:44:08 +0530
X-Gm-Features: AQ5f1Jo2_ANbgZbsR4eNysulQg_-IHFoWEtVL_IyMNH6mkLz5qnNtwZaWi_i3TM
Message-ID: <CA+G9fYsFM=9F39+bM+PHpuHXaEvQRw8JzjhxhM7v8HJTb06CbA@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 20:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.8 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Mar 2025 14:29:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


There are two email reports sent out for boot failures on arm64
1) Dragonboard 845c kernel NULL pointer dereference - camss_find_sensor
   - https://lore.kernel.org/all/CA+G9fYuquxGrt81z4FBSEDuvAMpu2qYAoFXwYKpfSuw2YYNS0w@mail.gmail.com/
2) Fast model boot fail Internal error Oops BTI - kernfs_iop_permission
   - https://lore.kernel.org/all/CA+G9fYtucEt8Hp6RsV0o+OWSz1E=hXBvhHa-P9C-bPnb7cyGaQ@mail.gmail.com/T/#u

But, Not sure these two issues are specific to this stable rc round.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.13.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 14de9a7d510fcfb3bd35e275eda09724bda4d440
* git describe: v6.13.7-242-g14de9a7d510f
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.7-242-g14de9a7d510f

## Test Regressions (compared to v6.13.6-198-gfca1356f3f51)

## Metric Regressions (compared to v6.13.6-198-gfca1356f3f51)

## Test Fixes (compared to v6.13.6-198-gfca1356f3f51)

## Metric Fixes (compared to v6.13.6-198-gfca1356f3f51)

## Test result summary
total: 132609, pass: 109017, fail: 3817, skip: 19775, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 2 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 43 passed, 1 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 25 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 49 passed, 1 failed

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


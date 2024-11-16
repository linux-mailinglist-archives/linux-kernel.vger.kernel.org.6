Return-Path: <linux-kernel+bounces-411728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FA69CFEE1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 433991F21FAC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 12:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E1192D67;
	Sat, 16 Nov 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x5RN/HAT"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A766A47
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 12:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731761599; cv=none; b=aMKaSHW6EMJsHUyU+lyJrNAjd3Oq47hK/RlCwS1WhZ8zy+uxbFF76k1z4qxh0/xb5XQcdnBcXQBFvt/R/pt8ldtSCXz9ESwjrHrtRilWedG+razAbNItZ6LUZ5hybxHUjgxcnlOg12fsdo+bzPvtp0/Dt7H/DI7d1/zlHOCZGvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731761599; c=relaxed/simple;
	bh=59otJXTX3TPHZSbpcdpyniMM4ZfEufZ2SuyYmnUp6pk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sT24inKIDp3ni1GXNywlgjgnQChxxScuZUvFaX1xQDk8fjrfOcDo/hCGQS6xKDjkXrUhiwaUUuXwG0KU7GTKDI5TbPKmzyMst9x7V5qvHJ1A35PUypR3mRWUgZNbZ4QzQ+ZCsd8CX66FtycYZuWspZe4JA8SIsCs6yH19zcqXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x5RN/HAT; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-512259c860eso626979e0c.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 04:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731761596; x=1732366396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlNnVnxiQ0/Us6Qy9l4AWDK9nCRlBxYrSIXgIu4HdPo=;
        b=x5RN/HATS32QGuFMptVoTfBlNR+DDBam1jmcoYcCcnGzLMxhf44nJDUIxsvpPdTBgD
         Z+h3VX9Mc+m9jfSqchc1MbUAuT8czKpkhJPD7LR8KPCNxB8P7WDz8ZAeZ47Op0Qyr5NJ
         5idVr1k7BEtn9GdIC3pI475Uti4qcCUMhhJhkROsM//acY57hN9m/FszFAdVSLiiRBDT
         dBT//OpHZiAl4rJKUr+k5RhatycApolbDwAmV6zrAn7NTSZcYmEn0BQ/Sk0FV1m91h82
         acdbppiY2CC7TTBAjF2OsN2v7tWsK5hy2Ez04+qUwPNmv7eifzS3pzKvvu+18DTrdzbL
         a3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731761596; x=1732366396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlNnVnxiQ0/Us6Qy9l4AWDK9nCRlBxYrSIXgIu4HdPo=;
        b=C9YeAZ7qDfcGZcR9sgmORQBAbgEKEgF7erP0Q2nVoBhzYlx/qNmzfmeDpJ2bB9JvO5
         psyciPr9hjOityauwZqEQ5PmcHwvZjjzClaZhWRVjATIAISU7vP+7miWHbAGDpmx88wb
         tv3QUq6KxGT30Yn+wl5C/9HyfE6kjzeCUrgNX6G0HxNw5gspEKBfymKQp9i0ueG5Mnwo
         hQNPDm8Dflp/cSLCDCrdWJRPNVNYmWO2QK1Glc/4c8zqO2FecklzDOfdrctsk2bAO9J7
         Snai+PNycIrYXNmLYR3Ys7HGBeUpoFj7j75MUP1dF76XnCJ/0agNxKFS5HQAPH387/2U
         QRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZxwY2iY8Tbj1ILeG/PUNGKK5/Ovdr6OOwi8P+QL7eyevtAe9/haZASC8k6hOrTga1V7Zvpi8YkZzKLTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCsTJv7KO9qeA44Qy1vASy5ZFUV/JW6AGOdlZKKUvmtih1qG+q
	8YWke9knipMcdbZ6Qpc+APUvgvBAWlMYaQR8J9D6b6+bEEpMQN9KikUvFxHDjcE9ROOXz11fJ2X
	lSJ0pSPlDe4253+f5aejjKB8ZbBGVkrDY+/eSQA==
X-Google-Smtp-Source: AGHT+IEhl/7zaJfBDAMgE7jr6T974RNihwhmyM3AqcuHj/rQo9P5BcBwkz6m6hlI0/17nFhK+cCIFmhp6AhxtaXefmo=
X-Received: by 2002:a05:6102:dc6:b0:4a4:9363:b84c with SMTP id
 ada2fe7eead31-4ad62ab15bcmr6164221137.6.1731761596528; Sat, 16 Nov 2024
 04:53:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115120451.517948500@linuxfoundation.org>
In-Reply-To: <20241115120451.517948500@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 16 Nov 2024 18:23:05 +0530
Message-ID: <CA+G9fYtdzDCDP_RxjPKS5wvQH=NsjT+bDRbukFqoX6cN+EHa7Q@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/67] 5.4.286-rc2 review
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

On Fri, 15 Nov 2024 at 17:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.286 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2024 12:04:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.286-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.286-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: c655052e5fd83d7cfc19a650eb6c4cab30cc22cd
* git describe: v5.4.285-68-gc655052e5fd8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
85-68-gc655052e5fd8

## Test Regressions (compared to v5.4.284-462-g5dfaabbf946a)

## Metric Regressions (compared to v5.4.284-462-g5dfaabbf946a)

## Test Fixes (compared to v5.4.284-462-g5dfaabbf946a)

## Metric Fixes (compared to v5.4.284-462-g5dfaabbf946a)

## Test result summary
total: 57128, pass: 39927, fail: 1369, skip: 15755, xfail: 77

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 132 total, 132 passed, 0 failed
* arm64: 32 total, 30 passed, 2 failed
* i386: 20 total, 14 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 26 total, 26 passed, 0 failed
* riscv: 9 total, 9 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 28 total, 26 passed, 2 failed

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
* kselftest-watchdog
* kselftest-x86
* kunit
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


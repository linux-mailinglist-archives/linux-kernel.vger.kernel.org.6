Return-Path: <linux-kernel+bounces-342449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA49988F3C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 14:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D9E1F2199C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D81187FF6;
	Sat, 28 Sep 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VdRVjdkI"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A218734F
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727527475; cv=none; b=hjyS6psv7Z017eYw639IIjlwIrQemEAm9TZrHcJyEFkIbrrf0KdqwipKnd3ev2rwAm2G6G3vuqnH0DrbOiNtS8XppCaxkuDz4n2jyqAzURHHMglAn0X94NFPB4fOaE86NjqKlHAKzl0z1fAhvDST/X/mhx+I8XcHYC41hbETZkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727527475; c=relaxed/simple;
	bh=GO9Kybgme8G9ShcZhWU3dKPy/9DpcB4TGRFTg/mb2OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0XOjTS7uRYXgR2BBiTxK7pBT30BkL6L+c4ezyCbukm/WtydwJv8P9uhRbZyGDlzsqMgPTZoBb89g/Ox77E5Yn4kHUC32vdmQ/VfJR2wsPtw9I327el1e820nFmlB/ufoO40Ocz46TruahmVo54XgCmvhLxBsO4sUAVDoX7edUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VdRVjdkI; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84e88c2ce05so899670241.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727527472; x=1728132272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu8CwGpH0zPsgWS5Di3OLTvt+aEle/prlAhM72/hucg=;
        b=VdRVjdkI2rz8uyShjYQzFNAx88g/9rZdb8JWEIaVo7NU6sbkPeG80zsq05ciR0a5QR
         hz1cmJuIjPyatWaoKaMRgUhTM16ZjS2ioJkcJ1tSLwnaqj+eliHQBkqr7kfzm1qf/6Mc
         1NogUjxoYur2BKkmlrdKnPY7tF1hbFTw5CwheH1oWPixydMsxtWkIAZ00Nt20kKi7UWP
         cBSh450UvFOEG15EZddzhKalXXZFgAOerJv6C/CclULhxI7ijW9uqBmvgT+ycLQUG/a6
         BM+i2vJYVjJ1yhreJxWAJAxFZ1itTEZ3RdMkbel0mYpYZKzkFFbixYj+Gn3RkjI+uClc
         lG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727527472; x=1728132272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu8CwGpH0zPsgWS5Di3OLTvt+aEle/prlAhM72/hucg=;
        b=MP9sEs8yfu4/ylnQHTpCZ2ghZWZpxZ7Q510JBnBOxLcfT/8O5lwJ6/i+Eaa4s89px5
         8f/cQ+9y5p3DT/voCQFFPhyTCWaJzkGeWHNIKq5OZAajHPBW7AKU1JRYmaf+ep78di/M
         6rIVF56zPT7nOJCJBjK3zk39VSo5/cv/o15746CFvghu5HAYGQJTE8pk7IQMPLLQHimJ
         nr3dPLQCmTWfOuwPtKdAs/GAPMZndlVtJQB/0yMHdOB2ZK29AOUWn0BYOF2uZgwOjLdQ
         gZ0D78mC60BRgvcYSRg+OE6Hgeay/yL9sh2KTsebzj0ao+dt135b7e6nl43zVBVhMuec
         VJBw==
X-Forwarded-Encrypted: i=1; AJvYcCWQTycgSC4etGT0G7BzPwKsZbNWMJj5piZ7NqsQ9XWjCtCZJrfAgqfe78XfJkldugypPYFFz13Cn1k1jeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19AA9VBGLB8DyHmrdVe8bNEPyHwpZUbcwFlcmMvkO8gK82Pkc
	meVzXBQQQOZRmvKkeB/DNB16mwh89bLupCIJE2m4ZYRWUgNtydJ0vplXY4JQ0zTFhNW2+pQ4GKP
	7eKHav4U1Ib9cYpivON60nJ9OzfYZHFmDDKNdcQ==
X-Google-Smtp-Source: AGHT+IF7wCbv7uEqQ39Y7mc7iT4ZkeoJI5PmT1fxWR7B4sLvWW9MW4Lvyr3+hiofSGbveU7pB2oKctHz9L/6YWxL19E=
X-Received: by 2002:a05:6122:3b0e:b0:509:e278:c28a with SMTP id
 71dfb90a1353d-509e278c998mr134507e0c.7.1727527472570; Sat, 28 Sep 2024
 05:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927121718.789211866@linuxfoundation.org>
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 28 Sep 2024 18:14:21 +0530
Message-ID: <CA+G9fYs4GKpXUSFUTage1LDFngjEGZFrWfMMo2oBe0wuWVPUBg@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/58] 6.10.12-rc1 review
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

On Fri, 27 Sept 2024 at 17:58, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.12 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.12-rc1.gz
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
* kernel: 6.10.12-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8b49a95a86047813f754fc406afce23ef0458caf
* git describe: v6.10.10-178-g8b49a95a8604
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.10-178-g8b49a95a8604

## Test Regressions (compared to v6.10.10-122-ge9fde6b546b5)

## Metric Regressions (compared to v6.10.10-122-ge9fde6b546b5)

## Test Fixes (compared to v6.10.10-122-ge9fde6b546b5)

## Metric Fixes (compared to v6.10.10-122-ge9fde6b546b5)

## Test result summary
total: 231568, pass: 203991, fail: 2025, skip: 25083, xfail: 469

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


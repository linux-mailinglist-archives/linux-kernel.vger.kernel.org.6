Return-Path: <linux-kernel+bounces-550998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A22A566CA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4E41887DEA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A972153D5;
	Fri,  7 Mar 2025 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wrat36lj"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F81B042F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347121; cv=none; b=qi3EZPzjkyHP4XMcSYRKeBsPvv4f+qnliMNjYVJ7qGfXjpoiQx/q0A+mLvzZdxsGoe7QQIkQ8cttF198hA2TqbFg736GBomO+QFbJVL9ZAfFCLWrg1vL/BKERXva7zHgpX1KxCXoDcwKZww8ZYWTirz9l2hhATaideNavWPX8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347121; c=relaxed/simple;
	bh=f+BPraS5AJNOD2aTCpOoOgZLm6Ptv8S/6d8vbUiK0zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQvzM78k1BwHK4LizVpOFHs2k6aQ4wsMb6frvpYAGThSo/CgSmjvAx9Suv0wQvyGY6ew8UaIv9dE4XTh5TRBhjrIuZcxrjwF1HJ1XHCT8Ik3MGQiL5EhmoMWKPXdDASu5HGfr9rRFBOxCsHl0OkQoxcxY5F9mxgq8Jd0vV9OCy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wrat36lj; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-520847ad493so1557070e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741347119; x=1741951919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywKNXyQduZtYvoI6jxdhP8hHSFQmxCo5DD38wzTDf7I=;
        b=Wrat36ljBKSFHxabI8w7j7I3xWmKwIfB/exnuJX7L0OgOt/xTXwcfLqORHCtTQf8hG
         PxMZko0Ag8Sh4y5/LAWML2pd6w9FWMzBzoexJqKVyBdh+mvZNb4IAiEyBlt3AQytUp1b
         DdfXvMr+3XSJNL9v24Cv3J7oPSgmXm9uLn7fQwcga4ChS5xwZuKW1ibTwz1C7T9wT5tq
         Rp4BPCte9y7Jghqpsct6INVOcN2FJjZgINaDir0FaicwldM1QHubdj/NdiXUVA2gW6cD
         41MW2gVlQEq6miN98MXsWY7WHgr12+HlCq/tvYSo4ZEFWSUFC5Y0PfVX0SJ2/Mqw4gdP
         aOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741347119; x=1741951919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywKNXyQduZtYvoI6jxdhP8hHSFQmxCo5DD38wzTDf7I=;
        b=ZmjTNhCF5p2mWpoEj/J4VBPKET/GEQUXDsfcqRsy9XeTAcC3Fcs/RFH5YBGAVnQ4a8
         GQDNF2VmnQEw+NvRNEvLZLDZC7G3rCtAh4vUaks74TmE+NiGY7kFg4dqk6w75lqCygDF
         n0013IAAgFnZT0Key+BUNRqNMpQVsAAk5V4jRew8oZfmoHHV4O9P8/8lFp6L8Ei/t0JY
         Q3dRf1M61mw5YjoVlRCvXfMQtKSYU4jXiurcl6wlk9/IXCjiTUYpOocFPYwTobuLte0x
         S0R39IaNZXCSggHGF2Z2Lc0dUgDnnvOAReXbVLg8wpsSyzvmDHGll9BEfvRWWjbLz9lz
         x09Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBXexT9FSYLpJ8LyJKDAfw5AHtKRqWy+JB1pXNpnaVXjJXFOM3Td+jTYE9pfJ0xOMfTXu0RHkmsaFLrX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6bctJ/SEMPOLlCtrvg5jYCqa05F22A9JFZtwLzwoVtnzhuNd
	Yfdy7Esn0ax4LQ8gv8Cl007kkQvWmCkCAuV6EzrReRE4fWgQR8iryN+4Z0/EY3dlpemyfL6VRm/
	G729Y59A7Uc4s/vBLxE9SQuONsrkk5jfxt0kbCQ==
X-Gm-Gg: ASbGncvtaU2n0L5D2DSbKLsKxyYdapsbGmaar5xmMM2OkbrZSDHa3ev3B8r5I+xJVlc
	3AkZzJ/PAWSKaDte1TLbsXc2kMVKeT5GPcDHAY4AtwC0GfTyWZ3HJyXyz8Em/Aqddm7/cvxTdLL
	bboEm24ULcTx3ZvGO1+vWuiyUeLQQXLvhyx2pFB+/AMWPViR5xP/FOz9K8UTE=
X-Google-Smtp-Source: AGHT+IEEoX3qpu6CmSaLeGuLW548G5UTO5B5A9BtNRSS+A2PIW08gpwHLIcHbM2Qnh/gpSxTryWAuaw+5ZOfZzxiwbw=
X-Received: by 2002:a05:6102:809c:b0:4bb:e80b:473d with SMTP id
 ada2fe7eead31-4c30a5a84c0mr1419593137.6.1741347118445; Fri, 07 Mar 2025
 03:31:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306151415.047855127@linuxfoundation.org>
In-Reply-To: <20250306151415.047855127@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Mar 2025 17:01:47 +0530
X-Gm-Features: AQ5f1JpE8AAJ3gh7RSXMtWAe3wo8-y_6_oLsy-2eWfHGaTOHnPUFj3a5CwYb0eg
Message-ID: <CA+G9fYtDNr+w0cd7uiwyTWGvdVGWn9W1UdmRjbzA2JA_-x69yQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/148] 6.12.18-rc2 review
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

On Thu, 6 Mar 2025 at 20:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.18 release.
> There are 148 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.18-rc2.gz
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
* kernel: 6.12.18-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 7d0ba26d403608b56f8de4892c01e4da7e841940
* git describe: v6.12.15-529-g7d0ba26d4036
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12=
.15-529-g7d0ba26d4036

## Test Regressions (compared to v6.12.15-380-gf5c37852dffd)

## Metric Regressions (compared to v6.12.15-380-gf5c37852dffd)

## Test Fixes (compared to v6.12.15-380-gf5c37852dffd)

## Metric Fixes (compared to v6.12.15-380-gf5c37852dffd)

## Test result summary
total: 124530, pass: 101752, fail: 4084, skip: 18630, xfail: 64

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 54 passed, 4 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 42 passed, 2 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 22 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 48 passed, 2 failed

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
* ltp-co[
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


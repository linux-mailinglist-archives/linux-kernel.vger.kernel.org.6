Return-Path: <linux-kernel+bounces-231452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C59198EF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1FD1C21F46
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962BD192B86;
	Wed, 26 Jun 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/HxmmfF"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39C419149F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719433429; cv=none; b=Z9upqeGERvSgpUaV1YEfFYx2TEy8ix5PgEilz3iBMgkDNEpscmgUCQ1waD+gT9FzCLQrGUemqpjd8wirfEb5JDSElzP/9/NK/vxYFuZytbfQsZg4pgAFjhzF8SUXYBcoNuZpsHEAd3r3WpCrtU1dJQQwL/5Jc6hNBbQiocP/WLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719433429; c=relaxed/simple;
	bh=IkcQER4VxVxCmW22fJvINOTjSwgeV2FWwd0BWSEoZkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6+rABxcdtRWjeghzzc9vrtvKkr0mgT09powzUqnsmwSMTfW3yqxY7hgvd2Vk/Yzxcd8Aq90m9T3q6pVnjLiXRgpLatDhfaFmbJ2CpJgiIC9xqYmGtf9jJcRrWR3j2rcIw/XiLSnufTni9PL6muai6IqdsBY0uQ61dyPHAdMRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G/HxmmfF; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4ef65ff63b4so600530e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719433426; x=1720038226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP2LZRgH8ULdbDjWm/y50Lk6JFsIoUem76H40vTjvs4=;
        b=G/HxmmfFlqdK+fz3gVmyBOmgirf05dk8hbKxl8E38k/n2VK3QHoWX6ngLOMrywvODb
         MLe/wxxC9+1dPDqFDUxBNE2bbCYrq//9DHxME8cRzTGVrKpPYZPYzs/svVugmVVM9yDi
         TbhP6tEPpEpGAUGjMhcCpcHBKXUqfdeSjANUPOthXgaDgjZJ9I255RoVXGioMZTAcpKh
         lzHY4O/NWfQljbrAR3d/2wNmSi1QwkbtoPB5jUJAYy3iyfUCdq9PxBMzf8bLtigACDQa
         9x46M1tOe5CJ4PMFyTPAuYMthJmIVSnoF+IkzhgD9u6//51bnfbxva/pxrMp+GdkQzwF
         drmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719433426; x=1720038226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP2LZRgH8ULdbDjWm/y50Lk6JFsIoUem76H40vTjvs4=;
        b=nmYfIbzge3Rv1rgLerq1znZOPIi5tqZgPaYnlnC82V0Ks7bjqZg8dDvywLGIRclJyP
         jj2yudRyxiWuL4GGqCHw78yM3TRs+tf4iXwZPFvrkKus4XXVQejrX/Y1DvwpfvcEqvyA
         LrZoxe2oiBYF1ZckpimTBJLp/pfN6uuDWOQEkzI43+ePMavK2XrPnO4gkzrENaEUMQoy
         aTe7k3iUOMUU4dg8tCBHHGEw9225FbPd+X0aKP9pHIwL7MiHlBmOverY9Kux3PF9saU3
         i9iL49lPjGsyN3C7SrzmEcPn+81THzz49xEwWOXfdjQrxLvIMJqLmcgjf0Tb9OOVVNwn
         T1YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOgjrYty4sseKN5OUKCH1Gs+gTRLqt4cVv+fP8ZBV4+m0kVWGKYs/BOEXkSPp0RWw32CmTdfxLsw8p7VRCDY69tmE979TzK5FbRYIz
X-Gm-Message-State: AOJu0YyU5WYTsKbIaOSXfZRpr4hkJi40WSMYrTRjCQlQ88oarplLKLY8
	TVDy6QLqeaxovUYKjO2AwYloccJ5nPf0s56/OM0tDx5MsgSAkLYDQ1oKlvuVIwKGVRDsLdMIoYp
	3kjwCavdX6Ll2ntcq4Dm71scVKkXglp/89y5OOg==
X-Google-Smtp-Source: AGHT+IFUtCuTvk8mKeKkFT7KylDoeBTpbNSt8GgXuaNobgkE9MIDVP7hqUGu08pkbPShigRCDnFr0dMP8MHLHvtbZr8=
X-Received: by 2002:a05:6122:3127:b0:4ef:9c2c:b2b7 with SMTP id
 71dfb90a1353d-4ef9c2cb76amr1709005e0c.12.1719433426552; Wed, 26 Jun 2024
 13:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625085548.033507125@linuxfoundation.org>
In-Reply-To: <20240625085548.033507125@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 27 Jun 2024 01:53:34 +0530
Message-ID: <CA+G9fYt6VVh3tErWkXyZmRhZqmaJFdG56BL4p_Zametiudy=Sw@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/250] 6.9.7-rc1 review
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

On Tue, 25 Jun 2024 at 15:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.7 release.
> There are 250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.9.7-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 681fedcb9fc66c0647e2ddc9824e0c0179a8b1b8
* git describe: v6.9.6-251-g681fedcb9fc6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.6=
-251-g681fedcb9fc6

## Test Regressions (compared to v6.9.5-282-g93f303762da5)

## Metric Regressions (compared to v6.9.5-282-g93f303762da5)

## Test Fixes (compared to v6.9.5-282-g93f303762da5)

## Metric Fixes (compared to v6.9.5-282-g93f303762da5)

## Test result summary
total: 238338, pass: 205834, fail: 4198, skip: 28306, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 37 total, 37 passed, 0 failed
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


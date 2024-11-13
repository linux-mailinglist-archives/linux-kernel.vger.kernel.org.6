Return-Path: <linux-kernel+bounces-407470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D03599C6DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8B2B2F487
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB10E1FDFAE;
	Wed, 13 Nov 2024 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6HsbNO7"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00A1F80AF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731497031; cv=none; b=AlSP5BeXTzOqbD7y6a414aDkFba9jq+TMrxF5uBOnokXPpQPrJXU3rCN5/LgqdR4ejE3V5KHz2H6pcgbsJbxwS9Wl2C3z/jpoOmgTl9zi2vpzfb9Ec2EOVqbAwzdOZj51gbbDkgSJkXS67ZmMnrVbabQ1YPWzNLK5Vonpi3fz28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731497031; c=relaxed/simple;
	bh=gWwB35iDRGO3IreJbI3AA3gNoaf9ATe6VJvXYYnUzYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nH/GZOQ9Byw9+Tzmu41n+ctQ3EMYe4TbVd9zBuPWPew2Dxh0j84zGVIV7VnYMy5cY9R8vHlqVtq21C6WRA9JSaXzAQHHuwzEvfKrCrdJxA4z3RvbFDIkSuOdWcEInsclBlRUX7J7xnOt77LZDahbr3QXyfMl8HqOtStnH7EtLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f6HsbNO7; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-513d1a9552cso2801775e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731497028; x=1732101828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXWDlI2EiF1lhgwDYvtN/ziCfOh4o3dD2YqZ6uItYPM=;
        b=f6HsbNO76xk8YVt4B0QpIimOteyouzS/acBcQqaCvUnUdr36GzgTsQlDu8h79ZvP/h
         Uu/IEhQIjXjl7UMT2P8+xhzyf2tzfZdLoGVowH9PkY1UynRYEbbbCuXyicdQLBsVtNHp
         vwBM3/gRX0FLUcUXDYqtu6wxw0KGuYzeCiqJCB4fcKQh+FTrk0lY0d3j/TBTvgBlpQYT
         raSgxkm5AlJkttusYjpZX/fRlEGj929E5ksrQN88g061a3owxZJblrNQsDuL1CCyJkV/
         XrDtI1240fMnozq/CfB0bSeInbB1kKiamJmtr47gf0zM8r1zhyID2N6t67yq7oXs3GWd
         WnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731497028; x=1732101828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXWDlI2EiF1lhgwDYvtN/ziCfOh4o3dD2YqZ6uItYPM=;
        b=r8XqMLV/bkGQgrUUGRDVtXGoWJELMqbHUMbOr+gC1x9pcE/y+wkSrIOLWgWUh3JAIq
         I/p+sz22USOjWPtVshSHwcYarA2V7EAhNI8GlW0CqacCSVOh/VGowOE1UAhCpv1yvP/s
         63ye0C66W4jLkpzR+QYV57XBo2/+eMABZWxvZXECGFb4vlHfjMu/o8z51luA5Nf7Cc7r
         mkKVWwylRO01py/508V5ZfTmfSZUoeJ63lyozYd8I7Gfw1lPMwWWAMefrj2f3k9uHrXg
         WSOvihC+pgTNXKZlybOAzzgMFJ8/cN+api6DSL/cHiEShtwGesXPVDO31vWwbo0hFToc
         WNGg==
X-Forwarded-Encrypted: i=1; AJvYcCXs/qYZqFyaxL+zO/TeQ+K6Hyg14akObaHvPYSuGbZpTpJSBfYTQsKnYxR0rxXam/TbdEDx787E3Govuvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLdxwOx/wwU07quzI2EExX3D7Sv/DpOyrs5kn52yZY6Sctq6q
	N125RXQhGhjq8Cm8ZE4lZRoOyurHtaC4Bnh7VjlnxKABF3piTbJsT5wla6WI03sAW2ZAVOvQxYJ
	F7XRwwb2hjPHSPauSzM9EMQl81LHY/nSTEDy2MVA00L7pWsRKmvM=
X-Google-Smtp-Source: AGHT+IGGvLM8pgT//CkiY3rwXUQ9Fmj5zh9FjBQ10Hd8Z1Gm2Iz1Wpdr0yutxfe0P/2ydOyLzCuMYm0QtK/SbauAP1k=
X-Received: by 2002:a05:6122:1697:b0:50c:5683:ad56 with SMTP id
 71dfb90a1353d-51401ba3348mr18377003e0c.3.1731497028273; Wed, 13 Nov 2024
 03:23:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112101844.263449965@linuxfoundation.org>
In-Reply-To: <20241112101844.263449965@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 13 Nov 2024 16:53:37 +0530
Message-ID: <CA+G9fYvtaB2Zmr6mWr03p2WF-ozf6JVSZVyPj03qEZHt8_VzyQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/98] 6.1.117-rc1 review
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

On Tue, 12 Nov 2024 at 15:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.117 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Nov 2024 10:18:19 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.117-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.1.117-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 41a729e6f9a934c7236c526524847c3b92f331d4
* git describe: v6.1.116-99-g41a729e6f9a9
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
16-99-g41a729e6f9a9

## Test Regressions (compared to v6.1.113-359-g17b301e6e4bc)

## Metric Regressions (compared to v6.1.113-359-g17b301e6e4bc)

## Test Fixes (compared to v6.1.113-359-g17b301e6e4bc)

## Metric Fixes (compared to v6.1.113-359-g17b301e6e4bc)

## Test result summary
total: 174222, pass: 141185, fail: 3150, skip: 29700, xfail: 187

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 269 total, 269 passed, 0 failed
* arm64: 81 total, 81 passed, 0 failed
* i386: 55 total, 51 passed, 4 failed
* mips: 52 total, 50 passed, 2 failed
* parisc: 8 total, 8 passed, 0 failed
* powerpc: 64 total, 62 passed, 2 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 28 total, 28 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 14 total, 14 passed, 0 failed
* x86_64: 65 total, 65 passed, 0 failed

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


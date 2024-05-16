Return-Path: <linux-kernel+bounces-180706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DE08C7213
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0971E28287B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 07:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645BD3DB91;
	Thu, 16 May 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KyULS4Fz"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE22BB05
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715844822; cv=none; b=plHcQJw6rnc9bxlQ4EG4pl9eKDxUbVQtSe+/pAUVYt0RppB/kbaAkjvzA82/aDmGJKuXpYIUOKrg/4qEz/TFCbTGLQUERb1g5/mOHzaXjdszHAqfhRFs3jOm1MV5sH6loAr0PtpNyzkXF6Q0k3SHlEjhP7fKZ1RwWMZnP2CS8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715844822; c=relaxed/simple;
	bh=mV3bzfV2I1TjTPcS2ZrQrzUq8aipyYkqsnM4fcoounU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZI9C42cJvrlac4xEVbX/hUH1tHSZ/kcJoOqL310IgN57P6bElWPM2eyxJjn5XpGvV6n09CnxBGgTBrDCUbyHSppk1MGdp996GL+2AMjvcgzPrlNsOA7Aep6la6HXHduGC7P+p3TN4evcmiIqaUQkzhM4ojg5t2YpJOfWzf5GE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KyULS4Fz; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7fbbb2cf3c1so1188812241.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715844818; x=1716449618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIWq/FZE2YXC731qnWaoLEetM8Q50pTmv2YuXDZyF8g=;
        b=KyULS4FzF/SRY53c24Y/rfSUD0+Jeb7fqb8OVVheMZV1DPdEP8KNcW4rxhc5o48JRB
         OjL08KVwK385s23GsZ+DdZn4105KBZj4QE/u3tBYku4lqet3anlwduzrWaBfh/m36LqJ
         WtOUzjcrOuSUbIXCghdS37Bc2tUNNEnlodhpoNFkegUh+f8kv+0Cyyy4ntpQdIhemwPw
         PYrXGBIF1MDyb77PSfc5LG2Glu2/yhcil5B3SHbUatJh5DoszdbaBkQiloim7EZBEvoU
         EnpDX7eGsvQDnkRKvqXYwCtXF2zgZZBLVvd7Qsu8HMAcAwu7LQ3aGHJpicn+lMKo+S0o
         rQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715844818; x=1716449618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIWq/FZE2YXC731qnWaoLEetM8Q50pTmv2YuXDZyF8g=;
        b=t1l0uyLj+vWXPIuXyfMNIjY34eErAfNXfw5ZuWA/K8PhqJaVw+su2Wj32tBcgN1hZC
         3Y0BCBFSnzL82aBnyi5SxrFFJtjeMlgUh/tnQGZGTLCXaPJSEWLuDWYnkVAWN2i55wUB
         kOljKJWZhzjl1wDqmmbuikPY9ganHD0dHYH5gQvjBzMq1WwXwcYkLFKKC33uHb1aa7AQ
         jDMrEgQJ0K0iTZhGgRt13FzYrDoAMw1FN0eV9jDkAo25Zau6Xp5f47G7ZKyJ3EHlkWh+
         fkhvMXAn+BaTaan5umQWn37c9zAjgk9jTYWxN043j9AOiDNK/bqUhjuh9L7yoOEovfIP
         65bw==
X-Forwarded-Encrypted: i=1; AJvYcCWmVWfG7fNOiHIuzpp5fkUIcvYWBDbMncCl0J+yGz01TUCyDh2jwF79ZHbB8QK3Li0NeSj16jYeQNuiMp2f/VlROYiazBQIyjSghKUB
X-Gm-Message-State: AOJu0YzmOd/6EnMWEKUd/KKnFaCA1iQxB5Z7Gcsz/yj5atIsuJHKiOPr
	h0FsuxSDJPJYVOU56A4BjfofA3RUMDeZIO3WMcVSQ192ApBoKlllXAFsYQMXCc5l1cUYBe40Qax
	Uu70lMyeWI3LdsP/jTQOnCkIYtVytIr4yJ2gauw==
X-Google-Smtp-Source: AGHT+IGpRPi8is2Z+QCntAHBaeChPe/gMG90B246WuBKo8Y5w6+Oj96SVZGUzvo02KPLmnyH2zx4kpOyclGT5J1KB+U=
X-Received: by 2002:a05:6102:c86:b0:47e:f116:4535 with SMTP id
 ada2fe7eead31-48077dca716mr18583373137.8.1715844817070; Thu, 16 May 2024
 00:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514100948.010148088@linuxfoundation.org>
In-Reply-To: <20240514100948.010148088@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 16 May 2024 09:33:25 +0200
Message-ID: <CA+G9fYtvj5OEOeAG31vON6vE_NHE8a-3Sqg=ptb4hmf0icLmtg@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/63] 4.19.314-rc1 review
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

On Tue, 14 May 2024 at 13:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.314 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.314-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.314-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-4.19.y
* git commit: 61b47a187ce8efaf5f5b7cd7e2ab6ca1b7da2557
* git describe: v4.19.313-62-g61b47a187ce8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
313-62-g61b47a187ce8/

## Test Regressions (compared to v4.19.313)

## Metric Regressions (compared to v4.19.313)

## Test Fixes (compared to v4.19.313)

## Metric Fixes (compared to v4.19.313)

## Test result summary
total: 42289, pass: 38159, fail: 195, skip: 3906, xfail: 29

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 102 total, 96 passed, 6 failed
* arm64: 28 total, 23 passed, 5 failed
* i386: 15 total, 12 passed, 3 failed
* mips: 19 total, 19 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 19 passed, 5 failed

## Test suites summary
* boot
* kselftest-android
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
* kselftest-efivarfs
* kselftest-filesystems
* kselftest-filesystems-binderfs
* kselftest-filesystems-epoll
* kselftest-firmware
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-ipc
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-lib
* kselftest-membarrier
* kselftest-memfd
* kselftest-memory-hotplug
* kselftest-mincore
* kselftest-mm
* kselftest-mount
* kselftest-mqueue
* kselftest-net
* kselftest-net-forwarding
* kselftest-net-mptcp
* kselftest-netfilter
* kselftest-nsfs
* kselftest-openat2
* kselftest-pid_namespace
* kselftest-pidfd
* kselftest-proc
* kselftest-pstore
* kselftest-rseq
* kselftest-rtc
* kselftest-seccomp
* kselftest-sigaltstack
* kselftest-size
* kselftest-splice
* kselftest-static_keys
* kselftest-sync
* kselftest-sysctl
* kselftest-tc-testing
* kselftest-timens
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user
* kselftest-user_events
* kselftest-vDSO
* kselftest-watchdog
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
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
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


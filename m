Return-Path: <linux-kernel+bounces-411639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 663F99CFD31
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28CAB22261
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 08:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1C2191F7C;
	Sat, 16 Nov 2024 08:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ti1NL4Y+"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934E718F2FC
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731744438; cv=none; b=Rvc78WD9QN7Pgsp/deJ128lbJTuCCLLZI6t1fV2EDkeQ1Kr7x5QOzPdmVYlDVfnPlfezpwCYbhUMWtJQ3z60/irsV0HccXmznM8OrvytrQDiY/ztZWAQpZA+Ai6sNhk3haWUILfLwhc9Vg9EXMre1eWe9om4Wnccohf11ei2KXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731744438; c=relaxed/simple;
	bh=NAIlf6R7JXlWQUkwEAToGNXpP4mKJHRaO2W11Ni98hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIv0Ab8pgQkEVbqzq0Q17j/HL6XHQkok3mP0+vbdzNmMS5qDcQ2B9uhu5PmBvv+jqr0deRJT0U9i7QFTR+zlCf7RVKC1KpbKp06FPuU7kNNCbHjHvW0DEuZyHEtNXRsG72O/Qk/qstzkOrZnNCPdnYIqShcRC0XF+XmtI/eEfh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ti1NL4Y+; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d4a333a87so146753e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731744435; x=1732349235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WmVZTA0OBY9zHSB9Kn5Ws2PBlPlk+7EEemKYnV7uns=;
        b=ti1NL4Y+xgXyh+oYXU0KLWQDzuG0Uxd+K0bCQ4QuqzzSno4i3SuzGqyimfOH3ytV70
         EsHHliDYNLAjJrlR08+nwASkXY64Dewp7Kl98lkZAB8yQ3SuQjtMDqz21KSVY0o1ZZne
         b24rgBwjtkHhCNSLQNBChnTY1rhiOLo4DjBPpTaMEbbfx6iaEhYg+Mz+jKwjDrhQhq1g
         P3AHuUWzfzQ/W7b/D9XkoZQcodY9a+LBe/uP4Q5OVJJB4CPmd1b1rOfEm9AH4fzGnx5R
         78YwhldhoOn+dStgtacMpFbKqNNmZiQ5UXLsy+q+UJfy6BJi3IstiGcKRibybj6lnI1i
         sxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731744435; x=1732349235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WmVZTA0OBY9zHSB9Kn5Ws2PBlPlk+7EEemKYnV7uns=;
        b=BYf00uF6y3YtviCkkZfD2FwwXNfPH0s6ZDgRrvJjyAjai15HL32tO6MnePqyA1K47n
         T836p2W0n4gvsWg6sjYeOV+pe2ce5aMV4TYcJJMhzEA+rGGNjFf8mQ+jLVvY9PxJqGL1
         l4h26nJVrVpuW36bJENpROO4fdLXeVvU7PTIxm5liXUIL3hDQ5cSg++pYcc74u8PooDu
         yxehWU0sdN5PsOmJ+RJ96OOfvailg7TTLXUX4gsjhY9B3AF86dpmhrw/wGNNoO3jeyDY
         Foz29Xe6Dk0pnDHZECDZ8VP4Z4pqRkFtOREzIkgABWaMu4yKMqfJxuS2aFLZLeHcAUKm
         iWgw==
X-Forwarded-Encrypted: i=1; AJvYcCUC6BgS/4TUVYUdiN9lCr3oyIqN2Q5vYhymf1Wxjjf5X1lwkXKMGo9rhyuViwmwxl7m5970nVJyJWDNF6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPQKhbceUFoYxXvqDV2QsnGeP2Hf7fkViBJRIQPKXFwq/PIMqh
	uUQAVGTJFsVXRe9xNTaOktL9O9+sqyx+SdL3t+xuT0Dc/9WyDtbK4Bd16JX7cG2rNiQWlj+Cek5
	rZfTpsbfYdqucemfAWF0OYXa/UO4ZyTpKKWEgZQ==
X-Google-Smtp-Source: AGHT+IHEfkUckBJ9XCrI2yVxSSJFj5t3YJDMntbgNupaqGx3dkUFYzNPzxPNBPxh0TXFSaU2ErN5g16+lB1l2lMkmXs=
X-Received: by 2002:a05:6122:3c4d:b0:4f5:199b:2a61 with SMTP id
 71dfb90a1353d-51477f99aa8mr5580802e0c.9.1731744435541; Sat, 16 Nov 2024
 00:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115063725.892410236@linuxfoundation.org>
In-Reply-To: <20241115063725.892410236@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 16 Nov 2024 13:37:04 +0530
Message-ID: <CA+G9fYuzB_AvjT7tZQy+tH257ztf--cs8Y+y0wF25RuruOS+cw@mail.gmail.com>
Subject: Re: [PATCH 6.11 00/63] 6.11.9-rc1 review
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

On Fri, 15 Nov 2024 at 12:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.9 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 17 Nov 2024 06:37:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.11.9-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.11.9-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 0862a6020163c7b2e1de05e468651684ec642396
* git describe: v6.11.7-249-g0862a6020163
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11=
.7-249-g0862a6020163

## Test Regressions (compared to v6.11.7-185-ga5b459e185d1)

## Metric Regressions (compared to v6.11.7-185-ga5b459e185d1)

## Test Fixes (compared to v6.11.7-185-ga5b459e185d1)

## Metric Fixes (compared to v6.11.7-185-ga5b459e185d1)

## Test result summary
total: 153766, pass: 127727, fail: 1793, skip: 24246, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 130 total, 128 passed, 2 failed
* arm64: 42 total, 42 passed, 0 failed
* i386: 18 total, 16 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 32 total, 31 passed, 1 failed
* riscv: 16 total, 15 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 5 total, 5 passed, 0 failed
* sparc: 4 total, 3 passed, 1 failed
* x86_64: 34 total, 34 passed, 0 failed

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


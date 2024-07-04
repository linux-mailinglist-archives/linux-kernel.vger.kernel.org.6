Return-Path: <linux-kernel+bounces-240632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693F3927029
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA482849E1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 07:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602A1A0B19;
	Thu,  4 Jul 2024 07:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNEjmtuh"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DF21A08A9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720076504; cv=none; b=WmMUqQz5mKyRO9u6/BjUIkCob+6KSqF0ZsKzW229EZucrIAkCkvvHzmy6RSHdC9zTM+cWF6oWEQZ0yhiOf6gbHYhUQ6ajgw3Q7WOEpCW4aAdV9YyXBUe+C2usWqYW9RIeayDmstlvT3lLFW3MPAEXAYrFUieAVNUa24CVhJ7xQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720076504; c=relaxed/simple;
	bh=4J6Q4VwSD0yylmSIknlGxX4CH0ZFq9b0KxuXq82C9dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KAiRMXWXO4cmK1ope3PaZGUMWI17LAmd2C3tQ7PM7rNpkyQ5XfuFcTYjZqbfq1mwyTizCd3rjN10A7m01+OzdLK+v1vh0F/wZs0iRR/zn7oK2N6aKz/QtrEgXMaUOlZigkImlDnPM+rFsco+BTjc1M9GY7GdbpOIJPVX2STN2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNEjmtuh; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-810173a1d0bso110034241.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 00:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720076500; x=1720681300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A08PUl+hTaAUUhC0gqU7oxLUbJhHfUfcU/yb+dzUHw=;
        b=MNEjmtuh6zcue0VQ0sjRcvdwuVZ8US50jOHrJyRKqSVypOTayyCyyq5LyRykZSRuxq
         ID8wmV/w6Mj5+ljI29BIsVM29tGs1gZuiPr69T6/x++6YWPHraA5rx5E5HYLiRjitlLu
         S9AB+8BMC9oJBWtxn1sgIc3Ie7iIAocRie3D6ntJWh8Ys06He3QsmWkp5eoAXEnKm4kt
         OzLs+RjzieTeZ0BDecGtxteaMuyMW9j0IQAL52KQUqYzZ5y3afKXVoeiqu+2OKOS05xn
         JOwaHKIZmzGNlWoejVo3QepRpJhf5RD6SU6ztP6Unj+hoLW9hhH8IithQ/fXNkDfLFUL
         qLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720076500; x=1720681300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3A08PUl+hTaAUUhC0gqU7oxLUbJhHfUfcU/yb+dzUHw=;
        b=gJqhh/k5MDmeNDEXOFwl/aFybB9xQ8QNtjjKvvIt5VA5e83YOz5dshutT3Cj+wQ2KC
         8HcuXqNOaz51jU+lPGmRVgHdQpENnEzPbc3fo81lav6KENMV7iwj1PDtT7WUFXwQ5ums
         Tw2dHEoHHe7Br6XRiXNrGnUhJ9rj29HddBH4M7PrwRHdS9KmaWIO+D9dQuMSxtNjZBWI
         qzrjvA90wegDcOvhJ3P3p8AKDu6nKSDMuGw0Z8QG9Hdq8xUnJ+cjSd9KQTT7CDpo8rsG
         bP3E8jdl2SkVdTvCGORtXnzzLPaIo7aHIKZVUElumk265SI2xkJaJI1WpI+wjbXfrj+k
         n9kA==
X-Forwarded-Encrypted: i=1; AJvYcCWHvJlfb0rkrItUWZk1LCpLpxEOvpY/An+fcGA6/Etuh51sMeY1DRh+Cf3PON8nk/qbQEdYl3ZYAk8ptdluiVZGcVb2cLeLS1C05gIJ
X-Gm-Message-State: AOJu0YwmlfAMhBFAUIHz+HddVLhuJbRJhQxGZQJ0VNSTHqKEspmeKQAQ
	Nd/ccny2d9w91kHA+ZXjySZK7wBwDYV9X1Jr2M1k3k1YgoWJoFyhmSwCj33DU1UMIsE/v5n5pEN
	qqFShbcOlumlKVX0+BsIRiOZxiUfZAfTg48hFIw==
X-Google-Smtp-Source: AGHT+IHcIYtDJuazCBNFAQoLQBJwqcoeJoNHkBtsVGtzekTcj7fNB0ski1RAVS8PxFLBBnCLy50SapZaHrn0ZkUiC4M=
X-Received: by 2002:a05:6122:3546:b0:4d3:cff6:79f0 with SMTP id
 71dfb90a1353d-4f2f3e5f626mr1173325e0c.4.1720076500361; Thu, 04 Jul 2024
 00:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702170243.963426416@linuxfoundation.org>
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 4 Jul 2024 12:31:28 +0530
Message-ID: <CA+G9fYuomD3FRmoh540XNT-Tsv7ZsM1SCY08bX4eEfgn=msymA@mail.gmail.com>
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
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

On Tue, 2 Jul 2024 at 22:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.8 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.8-rc1.gz
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

NOTE:
Reported boot warning on arm64 db845c,
WARNING: CPU: 5 PID: 418 at block/blk-mq.c:262 blk_mq_unquiesce_tagset
(block/blk-mq.c:295 block/blk-mq.c:297))
Reported on below email thread,
 - https://lore.kernel.org/stable/CA+G9fYuK+dFrz3dcuUkxbP3R-5NUiSVNJ3tAcRc=
=3DWn=3DHs0C5ng@mail.gmail.com/

## Build
* kernel: 6.9.8-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 03247eed042d6a770c3a2adaeed6b7b4a0f0b46c
* git describe: v6.9.7-223-g03247eed042d
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.7=
-223-g03247eed042d

## Test Regressions (compared to v6.9.6-251-g681fedcb9fc6)

## Metric Regressions (compared to v6.9.6-251-g681fedcb9fc6)

## Test Fixes (compared to v6.9.6-251-g681fedcb9fc6)

## Metric Fixes (compared to v6.9.6-251-g681fedcb9fc6)

## Test result summary
total: 253786, pass: 219442, fail: 4430, skip: 29914, xfail: 0

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 127 total, 127 passed, 0 failed
* arm64: 36 total, 36 passed, 0 failed
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


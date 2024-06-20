Return-Path: <linux-kernel+bounces-223080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA7910D4D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E045E28166A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EC1AED3C;
	Thu, 20 Jun 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiLQf1Fi"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1AE1AD4B9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901673; cv=none; b=S88ikS6Hq2uKjhBkulIMqbPGJwxJ4vCIas4X8F6JDsge5rqI3e06WdqmjC8z8WUgvsP6Cqmo9puSIuaN4K8DJN7s5On9j6sS6tilJhbmWQ9pc9h9Ee0BoU7JL/3LyW5fV6310Sl5ZQlWdFEy2lGAKCQLFq3HD1FcbR/4U9T3SRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901673; c=relaxed/simple;
	bh=ledX+Evj/xF3pBn7sbfyeIbSq+67i7LKlZzPlN9m8mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxGBkNsGzpIJ/ll7dvNkZg4oYsHagIb7C+oSJS9oAngWGRf9g2ChTdJSfyMbsJwzJhPoYWKdoJZjoZTMXEzWgR/nizPFe7JDVZMaXIfj9tfIcrVyLJnj7BNSIz0y7pDxMJsGV9XdLoTPiNBUguubMhq1Q+8lqjfzVCL0XMzCyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AiLQf1Fi; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d06101d76so1134185a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718901670; x=1719506470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyDn9eW//5EapF5PlqflhBRpLT8Lnv9D1EdTqTgpHRw=;
        b=AiLQf1FiXSfhrnPzEXBP9zJA+reSYBC/MNMtm60ncv+8Gf45b9BCFrm4Iei+9iBt5O
         xmvPvj7MsHn9NwfVe9TLCpVeLJ2qPCIyNd7GZ4rIZXVLbnyreHwngqXCN6rDkuqa8TiJ
         Pr9q/BwDCbyeoDuWLmysQdrhqMAbTophdcwIZAwgdEB3MIskCi4SotrVsCkwZZspD76s
         sFoFIiyzY6g9NAF8nuzqqiTi2Kj5mmBD6sl2pO0QmEhzgVjml8SNRgzxAt+stuymZmzr
         QRE9Y0bL09nT8a8+wtJtuCrtgT+TIqC5XkY7avVsd4NQq71LxOZCRNtnf6AuDQq5ikgV
         k37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718901670; x=1719506470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RyDn9eW//5EapF5PlqflhBRpLT8Lnv9D1EdTqTgpHRw=;
        b=QidHewxJfgzdOBLlsA8gzsvKafHUTBo9EF4mHkCbcwhAp3Vtd1UB6itHuIi/X6cavV
         gcRDVjQpzR9gBxzxL3RipXwQaCSusIb8MsC5JZRACdLYfTowhOdc7NyBkt+t/ZnrlVad
         6Na+pP1/nZ0qD8WvPDCZgHNZkaCIkyB+YtmtkkNBJs+zFdQpAo/sRBScN0QIWDROo5hf
         7h6EUU+RIa700emCmX7nW5T21u/gZjmrAgCKAOXVK7b4RE24dCIbHGLrewT/7L2iWAe0
         qugB27H+M2Rc37ShkPb8EzH9AKLDTguQq1ZWF9a6WRURiVKnb494vhSV6gmzBHHPpHLK
         uGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMbculE739o/stsqYEshA5yHBzR+5NkBK5yO9s82K1jLeIXEZWshfHyIl/twBdbQEumr8vNeVcJbqrjKWACwFbdZTGvC4Nj7ehTPro
X-Gm-Message-State: AOJu0Yzs06r9/M2UkPcnbamskzFaD8SykbqHgh4K32sUJ5FO0u+ls2X/
	1o/g6R0KXGdnY5ENWSVDII6MOtItOKXTqQcHVxWLwu9US8xB2Xx8+6hI6gtQKKf3g2WppgpTou/
	9dNPoVuvRT9aywOiL2pzIcNG7UVl1XgNogqb6JLQJJbf5j9VD6o2JKQ==
X-Google-Smtp-Source: AGHT+IFl6ngpWJx0DPdjF2Ef+KV4yVfuMhOWaSlMpqYuE0wg6ck/d9HSJv2HtpaDd2IMYZ/iHKwb4pqg9xmri2HqBj4=
X-Received: by 2002:a50:a69d:0:b0:57c:c6f0:e229 with SMTP id
 4fb4d7f45d1cf-57d07c5bd8cmr3034648a12.0.1718901669678; Thu, 20 Jun 2024
 09:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619125606.345939659@linuxfoundation.org>
In-Reply-To: <20240619125606.345939659@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 20 Jun 2024 22:10:56 +0530
Message-ID: <CA+G9fYtjcAUnH1LAGVR_H7q9-TbPk2QhZVXJOARUO4hRDhcDcw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/267] 6.6.35-rc1 review
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

On Wed, 19 Jun 2024 at 18:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.35 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.35-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.35-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.6.y
* git commit: 0db1e58b51e37c5cbaa81a40104bd54aad052427
* git describe: v6.6.34-268-g0db1e58b51e3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
4-268-g0db1e58b51e3

## Test Regressions (compared to v6.6.34)

## Metric Regressions (compared to v6.6.34)

## Test Fixes (compared to v6.6.34)

## Metric Fixes (compared to v6.6.34)

## Test result summary
total: 256850, pass: 222555, fail: 3269, skip: 30682, xfail: 344

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 24 total, 24 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

## Test suites summary
* boot
* kselft[
* kselftest-android
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-cgroup
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-cpufreq
* kselftest-drivers-dma-buf
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
* kselftest-ir
* kselftest-kcmp
* kselftest-kexec
* kselftest-kvm
* kselftest-lib
* kselftest-livepatch
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
* kselftest-ptrace
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
* kselftest-x86
* kselftest-zram
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


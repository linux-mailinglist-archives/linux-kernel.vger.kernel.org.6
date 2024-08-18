Return-Path: <linux-kernel+bounces-291049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1D8955C96
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 14:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD57C284992
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 12:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CF5145B2D;
	Sun, 18 Aug 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dv2HD4Jd"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7CB7604F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 12:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723985455; cv=none; b=HxtH1LUs0GJj4v034n98ndN6GG1iGp56SrUmTjri0yHSd7ZXyPNmZugVMJhAsK0/4g5IkTZhOyVKjacd6vC+Xfz9uMLcigtdVSbtxKxcLTteSYDQWMxod+ovMbwUPGqoBEndzw/wGXEAYoIfWxj3rqxtrB1bmF6oIXMltRY1LiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723985455; c=relaxed/simple;
	bh=6k/nrxNRQYfDatfuMr52qkEL9QAA3K48UsYpREl+ahs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZ6TFRrBZVMQuILhGe1Z3swfUkDx0MUWvSgrVutvLdwTpFTr1tyv9gbVY3m3QMPusRZ2+12BZ0coKL+TQQ1rvf0Yzwdbrp8EnDDnXyc9WyN1hYNGP5yH1mLnle7BVOTda/kpY2GMP759jKzrtYeoz2VLoWZyYGZxvnE2ag1wpqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dv2HD4Jd; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6bf825d779eso10784616d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 05:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723985452; x=1724590252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gO3USRcIBFbvufvA0QxGEC0Lsqb5pWiQNJAPyiLyCGM=;
        b=Dv2HD4JdVyRbrdEEPjSXbo0+E7YiR9J4c8+NFOYHPhIAsHu/colvqWhqItWflPQDFG
         CnYl0wFGsE/JZSBN4Ca6SSylmaITQdSAUE7a8sgT9LdN5uIPa5KDmokoK940Ft4vHuqk
         rvkcAMHQT412xG3oxJu2tWJvMnFqs8j7k6vc7E+o+D7XMd0OaNODS2DetC9BzNU3IYvo
         5ykOYGblv5+KL2m23N5UsVnQEcwcKfrRuOQuWKVolU9nSafB2YYV/dsN4WfkE1nkondc
         tDThqa9MrWQmFw2fvzw3PmyIf8ozrVjDcMzZ/E94KF284utEnYKx+D3AvcnoEmydgIwu
         jfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723985452; x=1724590252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gO3USRcIBFbvufvA0QxGEC0Lsqb5pWiQNJAPyiLyCGM=;
        b=wsCI1FtfwKPfIRtzWUPi/vtt2Rtf9zSH6luP/5cWzavPMGtvKoqme4gl8PehLK7fiW
         RfBTWwsn4WrTaTNg29IAMu11qRxgghjau2ZYQP1HZJ00dE/r7QcqwUO9XWiYvO28GdO/
         CyDZLvNBFq1xYNZ/jPVBFgJhGCkLu9OxoCEmttVzOPhAwJuZshydZ9foqWWCATopCity
         LYHESKblOjbiTmLCZwxqH95yI4olYE2CPTPX/L7v5TPDosw7kECordaeZmvWKoo/GqF4
         4ZejdUQa+lNtLlh5b146SxQFaTob+67A5hCaut+tl64uSoCoZnc5GQPUedkFJ8wc+Xq1
         e5sg==
X-Forwarded-Encrypted: i=1; AJvYcCUoCLixwPp3j2HHlXEPpxZ8PALJPz+WWLHRdjTiCpXpgoIPkw/uBIfOaAAqVnrXgfdNQ+qkLHFsBu5fXbRdHlLrHb4ldzup/H7EyuhQ
X-Gm-Message-State: AOJu0YzSJs6qY3sK11XNMu4XTqdt3VBzN3WjyZQyCAdzy0FUMfVNOO6/
	X7Hfme51OaZVrqQe6sD06MNI1X36e7GIZ53T+QewsLDQtJS3N+8TZJwT07+isaBWI+JdO7XUWXd
	7DW3EbW//UiDfOevgjeuP3zPUMt9l4iycjnaorw==
X-Google-Smtp-Source: AGHT+IHIJHY396OL0+RWO2HF9DVJxRjKkKnTwZ3oDw+BFc1rTmcvFgdPNyduAAKuTif6jcwt46IXp2mY4eSG5AW9Es8=
X-Received: by 2002:ad4:434b:0:b0:6bf:8128:5a48 with SMTP id
 6a1803df08f44-6bf81286396mr68955066d6.24.1723985451988; Sun, 18 Aug 2024
 05:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817085406.129098889@linuxfoundation.org>
In-Reply-To: <20240817085406.129098889@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Sun, 18 Aug 2024 14:50:40 +0200
Message-ID: <CADYN=9JBg6MikjzmiZboKNXviRLpV7v7fwTg4fvXDwkok9+gTQ@mail.gmail.com>
Subject: Re: [PATCH 6.10 00/25] 6.10.6-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 18 Aug 2024 at 10:53, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.6 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 19 Aug 2024 08:53:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.6-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64 and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.6-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: a522cad0641894f57925563b4eade679b6d1deb0
* git describe: v6.10.5-26-ga522cad06418
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10.5-26-ga522cad06418

## Test Regressions (compared to v6.10.4-264-gb18fc76fca1a)

## Metric Regressions (compared to v6.10.4-264-gb18fc76fca1a)

## Test Fixes (compared to v6.10.4-264-gb18fc76fca1a)

## Metric Fixes (compared to v6.10.4-264-gb18fc76fca1a)

## Test result summary
total: 177818, pass: 157089, fail: 1802, skip: 18688, xfail: 239

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 128 passed, 1 failed
* arm64: 39 total, 39 passed, 0 failed
* i386: 28 total, 28 passed, 0 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 33 total, 33 passed, 0 failed

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


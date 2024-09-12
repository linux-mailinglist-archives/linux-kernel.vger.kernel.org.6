Return-Path: <linux-kernel+bounces-326009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC6976126
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEA01C20D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 06:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD41898FF;
	Thu, 12 Sep 2024 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnMeLjWH"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839342D7B8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 06:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726121772; cv=none; b=S/4nIDwaUzYOQr/2r9ItYz5iS2zU95r6nmHVhFmTYWiZxyICjKMZhR5TfWK4eQtLyXEbL2QhdpNizXQ1vlfD4i6RvPAOOOhz36j3+NBlCMgln+DHOmwerVIXtpbO9VUVT+a0OMv0ncQYoTWfDHXymqHx5fONBLNhljAdq/H4uEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726121772; c=relaxed/simple;
	bh=NSZ0gFhmnSAWkPLIvkThE/jj2vyRHEZgjI1vgLBE5JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TU2gbSnc3pkzduUpdaZqwtQMCXcl3IqS2u7Vf1oeYQJzqPB5OJOG2aita3E4aV2VcV515J2uIty9lozqJTMKA+vl6VOA6g16L7WXgB5+zLyqEILL/GHXUfWjf6vxqC/cT4Y3ADMixpSsr8AGxmg2XAcMAFPF5wAtn1XBM+Opx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dnMeLjWH; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50108a42fa9so168792e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 23:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726121768; x=1726726568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG7etX+XMtB4JyEWMR7RO6+kiYe96BaV75NlxGPDwcI=;
        b=dnMeLjWHB1PWVH5MnvG22gtT90VS84LNutCPgw/3pOhTrJ8pzPvfqwHo7JscGujKa/
         cPfgq2hgUgCxSpdfBEwGKLtIrNae/zsutKu7zZ6Lp+XrakYY/Nfk8ouColFjDQ5/qGAI
         HI9yLKGKyJA5R9W/NaDdg7f9jejIeWc7QS6TgwkHH67I8NE6mOrCOJz5QCbX0KooazIT
         CZCIurT8LE5KuP2r9mdBuvy9sbEukboyJl6AfWuuOCg+s/MJbYX3WWxOeIWYGsanA3to
         Gu2MxcSapFUYq9ZF6s8DeRUFjLI7wmqZnJhf9eAi1ZGq9CUpPbUN/EAcTuePK6H6k/ZM
         pFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726121768; x=1726726568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG7etX+XMtB4JyEWMR7RO6+kiYe96BaV75NlxGPDwcI=;
        b=TI/iKNIZaf5F8oSzdyORPz3/TUEdtmbKTAfZwd5pX2OkcdRcMgj0/7ywrbozoGVWYc
         7MYsXCPHD2NOMDcmGO+aMXdkYlXEf8bkuC5X2KowwDfHsjtLG8vLJb+aZ6XmqzaQCj83
         emTul/g+6Gr6cnUjWvtL/KW30FCjEfPCusATWtNCYlIzy6KzXBmJpKTEg3kzRqFllSsp
         1pngwIGqnZSO7BplZdMCH292XQAK8Zwb+NZr72b+4s1u/O5fHkflh8m/B1isMr0TxyIt
         QH7QCsQj8O6nCFqH34bBhU1vZGwG74sIBMGghpCWsYzzHH+oYu9bpzi11c2k1unR8J7X
         LVtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlYeJz+lVsfqBNu81xVPVCfsHQRaGu6CHby/pgFn13Q1Z/J3Rns27f5uh6xzSw+woPLQivzl7O2NoeM4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxaTYgnjWv3W1hnhn6BOXlVRxkQJ3fkmnySt77HrtPj/uk/uul
	LIIK4tDUlSlCcVcuKLTHUSfmvwQ7WxZbni0PVjkE5mTdik4EDP270Nh9ZG/ZGEr7bKmiYCeXfJa
	YWo6MIMyW8MqBIoqlLoL3yuVReExTaIBOT9gpig==
X-Google-Smtp-Source: AGHT+IFnKBv5XJbS0vNasn1Vw2sANTpPRzyj0SqebB77rWvDXnyuPcbBolA73RD6RJwTdHu7xtKHHJGmKaO/CemalcU=
X-Received: by 2002:a05:6122:1306:b0:4f5:254e:e111 with SMTP id
 71dfb90a1353d-5032d40e6a1mr1568236e0c.7.1726121768215; Wed, 11 Sep 2024
 23:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911130536.697107864@linuxfoundation.org>
In-Reply-To: <20240911130536.697107864@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 12 Sep 2024 11:45:56 +0530
Message-ID: <CA+G9fYvzUeEMf98sCDqwWDYksYgvRfpgTABEcWUvmjwE-aGa1w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/186] 6.1.110-rc2 review
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

On Wed, 11 Sept 2024 at 18:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.110 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Sep 2024 13:05:08 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.110-rc2.gz
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
* kernel: 6.1.110-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: b844a80a36a118a1da8965067142b0246fc2a88c
* git describe: v6.1.109-187-gb844a80a36a1
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.1=
09-187-gb844a80a36a1

## Test Regressions (compared to v6.1.108-102-gbe9ed790219a)

## Metric Regressions (compared to v6.1.108-102-gbe9ed790219a)

## Test Fixes (compared to v6.1.108-102-gbe9ed790219a)

## Metric Fixes (compared to v6.1.108-102-gbe9ed790219a)

## Test result summary
total: 208365, pass: 180115, fail: 2479, skip: 25484, xfail: 287

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 135 total, 135 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 7 total, 7 passed, 0 failed
* s390: 14 total, 14 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 7 passed, 0 failed
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
* ltp-ip[
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


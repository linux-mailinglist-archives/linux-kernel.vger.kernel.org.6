Return-Path: <linux-kernel+bounces-557568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B17A5DAE4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172BB1895B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEC41D63FF;
	Wed, 12 Mar 2025 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQkImav9"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AB2343B6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776710; cv=none; b=eN9VCBX7TocYQfnRkQ7jT1nqs/OLXAkV+TQ4SQv13q1EVG3OXgjRxHPuozLIpavfueGAVs9H5bxwZUXpwBNNDApsM4dvgVDUrZghr+XWpb80pfm1PiKr122qce9Mgp5WaHXgwf6LiODFbzuX9yvhAGaix/2ggqDnml78WTj/U7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776710; c=relaxed/simple;
	bh=hXSiJkKHJBCdJvH+R4+/RqJzaWY/eGeelD7MrTlv2js=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxvpQpPli9qKVonNTg1ZcE9RUlNPGU9EgCnJkQSkLmQFMZtBCvB9utruGXsCKlDIECpWwQKeDdCktgp5bm2yF+PQhqLrtx4+ojFWWnAeIPY/CM2XuujVQryrtsE0ZJ2+lrBuQWKSclqq/CUvJv9x88Ohy8IWHXfIEXLyheAonY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XQkImav9; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-86911fd168dso2515262241.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 03:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741776708; x=1742381508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofIXHd0nXdS+xLnWIW+XGUrMohg/3SYDu/r8Q0SMWRM=;
        b=XQkImav9+qKA3r+WbThTaGTmC1tmV/Sie/WVuadNrxxU5AjI7xvOBvyP+KO+I9iOGJ
         JAD8cu5iYEt+MKyBc/i4fL9VRT0L0aqb+4HOcRectocqEPIVDteCMonZN2ZM59I3a5bP
         hArmT45qsA176aqkDUOi+bbduaJzfKlcVUqQF0dc6mawhS4qk9vGbG/B2ZOsipFBs1Md
         nV7HpPRaZ0dKOkZs4q7BpeAUG3p9NFHGoRQm8p7Pl20Lci7epoQErEpdmvphMR+x8Wc1
         UDT3N8IgtU+2tAgDMtqfoihnudbeJz2NeIIGhN4andpwVrZnr13mvCPVhQkzYtUOAal1
         Mdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741776708; x=1742381508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ofIXHd0nXdS+xLnWIW+XGUrMohg/3SYDu/r8Q0SMWRM=;
        b=Yf9Sp+WoYzc3tKxE/2fUnFGpojUPzDWiviwTrrw9Uxi8iRjGTrfHOgRIjZV0TLMqP3
         XZndFVXIOOVJqdzINBuK0DOwggKIxEQ9dPKmuIZ3SasE4cIQm7PLUCb1v2+/Uu+nhVdD
         C6tnauDKElRsp3NUJKxag6whBmAjT5H/zsff7FM2GdVxh2qzshfqWhofhRRKGTkHhu/h
         OW1UesH1EB1Hbgix24ctXv94vbWgippv5utbYFAPHI+Kh93MP2biXlklxkiU475ihaZt
         NlykT5UIxUC/GnxmXE5R2Uzk2CKZuKHVDxGW4E+z8O2aObOsHTl7nIzy6dzyT6D8hFRF
         kVFw==
X-Forwarded-Encrypted: i=1; AJvYcCWWK11hiiIMI7iBe1Wqpde1WWJkrLEGpWdd52y40Xowfxt3l2gwogiVeOAJYlxTJujk266/G3d8Ai8XZWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzZ0fWiWO62N0ZM+neDRY06MyG88LUJYMoYDjKnf+McTfVHUFw
	saGJvDSRXdY9QKrqU6SNgGTJA1Jowia1UMb2BFoqFPRqWFzFTQEnDvqWYOHRdTf3Ph4kbjBP9tS
	BIACFVPvpVFi/Lx7N0V1SN6abvTsMotMIu/kcxg==
X-Gm-Gg: ASbGncuh78kFYZGp70X73yg12zO98wZS2QTI1KKJwBOiRJmXTf0CeABjjPamBSGF95V
	HE5Otyc1eJhP2XYZG0FDiAsBJu4AjuUa3gCw1EyhoSToofZ/cfofgVRFQhpSTW8mOTfGxYB2tid
	ey9XJ3/IrPMdVx7h87d56l+w1dg9nqKzhCTJH7c09+8CveGJrE7XTBfXcLPbY=
X-Google-Smtp-Source: AGHT+IExqjwNlPJDVbhRq1gUihp2DfP+lo58w+qtI1pZKKxOFe/VwKkG7rpQaIQKS+9RqW7lVdJCkF4xzButJtwk2EQ=
X-Received: by 2002:a05:6102:808f:b0:4c1:935a:2446 with SMTP id
 ada2fe7eead31-4c30a6aeeb4mr14044886137.19.1741776707905; Wed, 12 Mar 2025
 03:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250311135758.248271750@linuxfoundation.org>
In-Reply-To: <20250311135758.248271750@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 12 Mar 2025 16:21:36 +0530
X-Gm-Features: AQ5f1JoF3cL86ld_u7OGbca9lABCc58A27MGCDo0Tu9RpKsaKCWwzWHaW4rmjTU
Message-ID: <CA+G9fYvZ024_ujvUe=0YJ6xDD-sNHAgjMzX0EJpOGd98RtP-ZA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/616] 5.15.179-rc2 review
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

On Tue, 11 Mar 2025 at 19:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.179 release.
> There are 616 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Mar 2025 13:56:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.179-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.15.179-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 4372970bf8669b796c66bde58c72b591b8934373
* git describe: v5.15.178-617-g4372970bf866
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.178-617-g4372970bf866

## Test Regressions (compared to v5.15.177-25-gcd260dae49a3)

## Metric Regressions (compared to v5.15.177-25-gcd260dae49a3)

## Test Fixes (compared to v5.15.177-25-gcd260dae49a3)

## Metric Fixes (compared to v5.15.177-25-gcd260dae49a3)


## Test result summary
total: 70512, pass: 51509, fail: 3484, skip: 14908, xfail: 611

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 105 total, 105 passed, 0 failed
* arm64: 32 total, 32 passed, 0 failed
* i386: 25 total, 22 passed, 3 failed
* mips: 25 total, 22 passed, 3 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 25 total, 24 passed, 1 failed
* riscv: 10 total, 10 passed, 0 failed
* s390: 12 total, 11 passed, 1 failed
* sh: 12 total, 10 passed, 2 failed
* sparc: 8 total, 7 passed, 1 failed
* x86_64: 28 total, 28 passed, 0 failed

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
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
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


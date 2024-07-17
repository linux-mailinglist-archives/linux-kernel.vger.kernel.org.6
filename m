Return-Path: <linux-kernel+bounces-255483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0B934143
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:15:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84B83B20EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32658182A5C;
	Wed, 17 Jul 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/PW5tOg"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3F23FB1B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236502; cv=none; b=kGVUzQG6mvLKAf7y/1F1niMI1mip2p6Gwm462GPcQHPEWROyMYkRIQ/E1Et2+3q5waJlmwfcYpYl9FNDPU/o39cyfX0wtLExZql1eC16VL9m9vC2nFvV/kjbYG+esIMlVo15u5eJKXYaWC3OvalBzkSD27b/wjnnlGFw434DbCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236502; c=relaxed/simple;
	bh=cw30YfvidqMdAX2ktCxRyPLr2LugrsLeMrCFFWIhdDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0bZlsBPSEm2gn3rEyR32JH1ovuC+R78hx45T/bXPSnO1wB2AgFc0M82JK2ih6N6Rfpo7xuPAeB4WipRdR1nERXV+iwYFQMOuwctWoLc+AsAd6xMUbn/DjJ4xzfrdeh7n7rI1T8q/HzEcR91DB05eNKwPw6ptCV8f1atDL30+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/PW5tOg; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-81065391658so478371241.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721236498; x=1721841298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pDlFW+0uEtRWgzfnhOmL6Q4bRT/kPk7C9hXwCrZE8o=;
        b=S/PW5tOg2qhEo7cr6kbzRCot5hwqsVx81iK8co7ydff8DL5lBY99GEZJN+Mjss6v4l
         eHs9n078yi132RA+jEbK8KWlJJnI9GtGwfarVNDc9lyUPbvflKE45Anad0lG47n66zPT
         tvey3UL87U1y1UJzWaOT81isGOOMBypq4MQrySNwvsFecNrzBvJH7qF++pCqjzSJRd23
         ULrSTjk9Hl1GRr3ZrvGzIAf0hE5TMDhTbOh8Z5ulYuSw5k+sfjEtf2zk4Ka5ezd05qXv
         TmlUdCFZzvDmNx0zZWITVuQDQ5KTF2npQaN1enHEfjRs9ivG4n35oGAU7tU3oacJj8Iq
         pF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721236498; x=1721841298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pDlFW+0uEtRWgzfnhOmL6Q4bRT/kPk7C9hXwCrZE8o=;
        b=Dv/QdZAct8k6c0jcGcPxa66vUUq01LbdmZrsUk4VH5Q33qf4tdwN1TmHjSaeU01KvX
         Du9nmooPpwinZMkRMByDmEuhJYoRNwBdLt76EnbTIbsfaXHz+Fr4a/0oYf7VDbUREaGa
         j6CO3JMftuKLkcTSIHDJbxuG9xNretBTsKEqesB1+Y+2pq7T8R2sorc+1A9hqbT8cXg+
         hKi8UyRY92W5nXqXzEwaZy3SK9b6tEjHSUNVRnaVSusSDH7IiprxR8DNBsCaANaI5Car
         TSCWRnPThccS7r+yD7Da052kLIRXUjBjbgDYqtVDgs7px8/5eChDIWLC/Sxx7qsWkzPy
         1ymA==
X-Forwarded-Encrypted: i=1; AJvYcCVxC03F4LCsJFPDk5FuVhyJAZ/HSky/Wo2ZuRUjKWLLbVI6Xeq2CUV3LsGKN6DGM3PLTSsdL5bW7dwAvkGlRA83dphRGW6sutte7Ee5
X-Gm-Message-State: AOJu0YwoIPLhGzUrl1SXBIuS4nMn5HC/if9Nk+ns1BzNR82rzXMhvkTF
	PLjQ4/GlFJzO7jgkHVRZ66xxJWt1VNfYay1rG5TY2WnZC2fLv1yHFmBLitgIh99eHEt6f/2p1oO
	EdzqG+sHqU5joLmbRuV9dbARufcvcq1HucLxWmw==
X-Google-Smtp-Source: AGHT+IFV2Rs08vOtSHS/pIuDotDwNtFl5dP1U0UR7bwlPlrSRd9Kbn7q6Oa0g3IkIkOG730WdUMEEkNczqEwG3hcXfo=
X-Received: by 2002:a05:6122:d97:b0:4e4:ea24:4c53 with SMTP id
 71dfb90a1353d-4f4df63874amr2705262e0c.3.1721236496976; Wed, 17 Jul 2024
 10:14:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717063802.663310305@linuxfoundation.org>
In-Reply-To: <20240717063802.663310305@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 22:44:45 +0530
Message-ID: <CA+G9fYt51XWL7Od2wno47hEGTiOFYJ2JfhdyZEha7GwjN1K2FQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/122] 6.6.41-rc2 review
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

On Wed, 17 Jul 2024 at 12:10, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.41 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 06:37:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.41-rc2.gz
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
* kernel: 6.6.41-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 6b4f5445e6e6e806a7e9bfbb1e1e5cb73c0e07fc
* git describe: v6.6.38-261-g6b4f5445e6e6
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.3=
8-261-g6b4f5445e6e6

## Test Regressions (compared to v6.6.38-140-g3be0ca2a17a0)

## Metric Regressions (compared to v6.6.38-140-g3be0ca2a17a0)

## Test Fixes (compared to v6.6.38-140-g3be0ca2a17a0)

## Metric Fixes (compared to v6.6.38-140-g3be0ca2a17a0)

## Test result summary
total: 140936, pass: 122778, fail: 1053, skip: 16932, xfail: 173

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 126 total, 126 passed, 0 failed
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
* ltp-sm[
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


Return-Path: <linux-kernel+bounces-269749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F35943668
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFC25284390
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584714AD3F;
	Wed, 31 Jul 2024 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jjb0j9zf"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269B219FF
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454198; cv=none; b=UAj1rEh9sDreeYUb2rmYgQgl4B9pS4Art7G8zGSlo3VGvHBEeHw0dutkvK9Gqsuie//6ewWoW1sRmOnRvJTqFV032ogqwXAdhhLVi0HS1KFFI9mHDW4SurGe9n3e9PfCvhOocfNl7hyZSv91LWuxgBdR3d7qIIuP7fQQeRzu3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454198; c=relaxed/simple;
	bh=8VEBFafnSr9VpBkGUOOfJzMmeWvifxk7DLlZrSgU4b0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACeco+f1wOyqYykiSTR0um+qwfwGrTEbP3W3vaqYXJy3OCjnuo1sc9ycSh1LvLkpr8XFB6su2WPVEDotfM8r8vkQbUphVQ025kuIJG3/KhI6EZ0PdUdDuSFlmRbzDpLGGP6ah/lkZrU6eV5wjuHb8E9vMM8fOSpXkrk9MZOwVeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jjb0j9zf; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f6ac477ff4so3316931e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722454196; x=1723058996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajHV6NX4xbC0/X/XUlTpJgiJmCRqspyluOYbTikblWw=;
        b=Jjb0j9zfPcbIFE3sCYvH1EMgGz9A4BHSQnL6mlo3vnmLktVvyJWLeZCIgfwYYh7VRk
         rPvQHuVVnl+G9uD1z+qVRaRHjYQT7TzgaPY9xu1r5sx8QN/DWnIZ4JtRzzbVVh+KBfzL
         st6yvYMsy1GjW+gnEZWf5m7QkoYSi7osfbJQZVFTIaSaTa5/ckg2y+FTjGnO9tlxcJUV
         GnpFcognvzAnJt7k2swAfTA1N5Bwni+budQMKQluMQ1vl5TPa32RvTE4BtQT24YUWR4n
         VhC7wOn7qgVZAhnC+DsOYmoSHEa0QsjCVS2/m3mGTHmCfUZ7ow+pzxHdV8O+Y5vj4KMo
         4MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722454196; x=1723058996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajHV6NX4xbC0/X/XUlTpJgiJmCRqspyluOYbTikblWw=;
        b=cK4TL6D7+qwfj5TsBI1MPjM0HK+Qk3ZTc9tpKIB/gE6aMSoIDX2cSdunwuum33CNrV
         oSCgJHS1mloYlQ5lFP1Uz/BCOKBcAXnCjp+yW1nJ4z9uhS+/FumKHlKJb2hRt4TTymV/
         8Wfvml7wuGSnBImuwRReHLNtot5uAOOtkRWBMdUEh3TpMfN1KtF/wm77Af9q6KXU2t0a
         MqA0BkDa3cHJpxphK9SfSxZpApmOmQh+S02gwoa4VQZUXBrqmAMMQiDnizEi4XmN6XJD
         aZoDmyCrJ20tAev26jEjIcZy5W8yXZCmtNS+DlVQ7j3d0e+GsKoO9t+XgwKR6tANsZ33
         7C6A==
X-Forwarded-Encrypted: i=1; AJvYcCV/ixMQsaukATHqqxgmPwi7iNZi/yPJrnonlrP0kSQeOQMnJZw3zkGIpx9qT+dVAoUrx2S1nZsnsmd9JRkZJ5cEV2xY8nZse/uLDIl5
X-Gm-Message-State: AOJu0YwTcGuM8zC0KJMYx3W/cGQZIa+Z0tg1xhXlvet9dnnFRwxx3JUv
	fSwg5Z/wgClmwIUk9+nJxXuBeWJ3QrXEvbyg8kgKGfxpfUKPTHMXO9s3h6nh5jhCC/DAhvwnlFx
	L9bCb/jEfUBtNOm5l0G7SsnrDtP5dIjWNiNHgrw==
X-Google-Smtp-Source: AGHT+IFGOh29LmDbgQeNaPW8BywZKqEMuxk4LG7u9wPcpkJp43UNZWjn4ROEnmMSCiHxRRMDEiuIuZJG/HI/Hu5JbdQ=
X-Received: by 2002:a05:6122:3c52:b0:4f5:21fb:5e49 with SMTP id
 71dfb90a1353d-4f896714753mr489423e0c.14.1722454195700; Wed, 31 Jul 2024
 12:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org>
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 1 Aug 2024 00:59:43 +0530
Message-ID: <CA+G9fYsf0tqqUqLsMAZuLhhPVJaJvX7gw7nhdsbScntYVBLMXw@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
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

On Wed, 31 Jul 2024 at 15:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 02 Aug 2024 09:47:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.3-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.10.3-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: df6b86a465e839f8a9912c0de79b3c5681d0f1d9
* git describe: v6.10.2-810-gdf6b86a465e8
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.2-810-gdf6b86a465e8

## Test Regressions (compared to v6.10.1-30-gbdc32598d900)

## Metric Regressions (compared to v6.10.1-30-gbdc32598d900)

## Test Fixes (compared to v6.10.1-30-gbdc32598d900)

## Metric Fixes (compared to v6.10.1-30-gbdc32598d900)

## Test result summary
total: 418796, pass: 365615, fail: 6357, skip: 46059, xfail: 765

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 254 total, 254 passed, 0 failed
* arm64: 72 total, 72 passed, 0 failed
* i386: 54 total, 54 passed, 0 failed
* mips: 48 total, 48 passed, 0 failed
* parisc: 6 total, 6 passed, 0 failed
* powerpc: 68 total, 68 passed, 0 failed
* riscv: 34 total, 34 passed, 0 failed
* s390: 24 total, 24 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 62 total, 62 passed, 0 failed

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


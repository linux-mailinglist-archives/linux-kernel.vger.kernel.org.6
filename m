Return-Path: <linux-kernel+bounces-311614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293FF968B29
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BEF283B9A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FE19F139;
	Mon,  2 Sep 2024 15:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpdVfrQR"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AEB3BB50
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291518; cv=none; b=NmPwX1AYVj7JL4ClYpqExtVcFKd6C7qSHnB9mCUf8GPCT7hDWKusyF/JhTNzuZc7msT7nQ0w6cbP9RGejxwErqbY/4W+uJXjDexPIQF/rr1EYW49WTHvrPxzWbvFYIgCtTLKSqAA40S+Bku1t/o5xs7DyZkw6n8VEOXFEh25Ock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291518; c=relaxed/simple;
	bh=+nfLd6UxJsEWwMxHZZj/0lyToCpTA44CP5Z+n9QIWTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT8rVJSLtKyB2AcPVG/UiL7eOO3Z+1xcUhJKSj7Q+ZgCTMYw3tIUAr/CkjNgzEX4DpZsz4o4S4tIJ9GXK0+K9o56QZ6cl0VtAOCFfeb50R/ClsUL3iuCJLHo28dCnOlg/y0juw78mKfsUb2/RNiDmjyHMI7gyhE9BVdfq3L68+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PpdVfrQR; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4fce352bd28so1209570e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725291515; x=1725896315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkFbpUnzf3sssS4aIyE4C8Gye+7dq6aX/LwYe/LHKK4=;
        b=PpdVfrQRzHn6+AW7Aff87ZRWQWFq0Z6B1GVkVzs7x5iny+qYwJtWC6Jbq7iHAXLgt0
         BR/NbQVicXR9Y+UeLyeL8hs/jrHv4ykdW9ShPLKqKDxSrSHUomf93/EaVQm5IOzO3mM6
         3WmWpiJSeMp0QWqWri5PQrQJ5+PgWKPmVfN+GocpuTODAkNfS2L5elrTHO2c9HDQfxI+
         ng4yhIJP9SJmG6RoteY7XDrl5r50CHAd66cIkR++PgYU9Jwl8gxwMF1tOrnmOi/M+Dvc
         c4zVSfanCusskw+eaZJFdcjnS+tqIEMaHHfBt5uOwVQXW/0RCbtbAtxNxLq5HlrY9Vxq
         VY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725291515; x=1725896315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SkFbpUnzf3sssS4aIyE4C8Gye+7dq6aX/LwYe/LHKK4=;
        b=Gy/b+9U6vL6scHfbm7XdfJAzgwUU7lyDNmGApA/wE8TFRrGxbnfduMGVz0cG/DDgGm
         fzNUzcW9V/GOx0wymZRes80jp/wMktZ0ZMToU8gk5k0g++vX1j73TKvfEuNFMk0A6fC2
         IUQtiyXwHaZDUxhVGpdte0AEMdXopRGtsLDmdkiahqd8AeczzNvrI5w/GSzLqAroi36/
         4m+x3IU+xCeIZ8PKeI0VWuj/qQGaCdjmMsGyaTaS+/iN1I0GKpqoZ96xovw7UW4OF0Kg
         xSQNGXD0KH2EKLfpb/nwZQw909NoLDsgwT7fmXihkVmJ8Xo9p8pWn4i8FtqXhMYrAlBz
         Zwiw==
X-Forwarded-Encrypted: i=1; AJvYcCUmUNlHt1yDJ7ZNRVBm3jNMoz6wSd2Y0+FducqGT348BKu1es9zrABH3d7P46u24wwn+3jzVJC6YyRdcG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5cXxKPpVJ6Kb18i0ZwJj6VTG8wO+h5rrZ4Z/Ig6vbsUdgeff4
	p28bu6TZcu3+39SLxZKwvYnTctxuD8nVNgjNquMhljoFl/PewHs/OfiEevZwQ9EEj59SHU2zSue
	Y6RkC0yh3PYlfkeaBa1P9EdtVePt2VcJv3TNuxw==
X-Google-Smtp-Source: AGHT+IEFiqCPj5ClWa+oAUuBhCOBhK8IXXtwLicW2kMJMvr8eV33HNEKEAufefXW9vtva1PNWsyrq8a7E/8QsHSq1Z0=
X-Received: by 2002:a05:6122:182a:b0:4df:1d06:eeb7 with SMTP id
 71dfb90a1353d-5009ac02acfmr8471169e0c.1.1725291514630; Mon, 02 Sep 2024
 08:38:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160807.346406833@linuxfoundation.org>
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 21:08:23 +0530
Message-ID: <CA+G9fYufnSwnzUdu9wNfSXAw=u6CPnvhYWcNpX8V41h_XatjDw@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/93] 6.6.49-rc1 review
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

On Sun, 1 Sept 2024 at 21:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.49 release.
> There are 93 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.49-rc1.gz
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
* kernel: 6.6.49-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8723d70ba720be0b854d252a378ac45c0a6db8a7
* git describe: v6.6.48-94-g8723d70ba720
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.4=
8-94-g8723d70ba720

## Test Regressions (compared to v6.6.47-342-g0ec2cf1e20ad)

## Metric Regressions (compared to v6.6.47-342-g0ec2cf1e20ad)

## Test Fixes (compared to v6.6.47-342-g0ec2cf1e20ad)

## Metric Fixes (compared to v6.6.47-342-g0ec2cf1e20ad)

## Test result summary
total: 198423, pass: 174521, fail: 1723, skip: 21956, xfail: 223

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 19 total, 19 passed, 0 failed
* s390: 14 total, 13 passed, 1 failed
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
* kselftest-tc-testing
* kselftest-timers
* kselftest-tmpfs
* kselftest-tpm2
* kselftest-user_events
* kselftest-vDSO
* kselftest-x86
* kselftesu
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


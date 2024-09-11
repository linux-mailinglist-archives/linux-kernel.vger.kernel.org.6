Return-Path: <linux-kernel+bounces-324943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA3A975301
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B3D1F235B3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4698193078;
	Wed, 11 Sep 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D/Mq3A6M"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6563418C91D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059467; cv=none; b=WLUzg2Ywof0pNBJJoX0Ku7FZvdFGyzi93lYmKZKRN8f+zVsPnJg8n8dYbWvIqeneMKr01ybgOOEauY1TgW5uBeRIsTiRuo7jDDhzK68+RHk7GO3oa1SKbj124F2PkY76fkUFqI0w3zFACggqlgA7m8NfVE2U+s4Mhi6wEmwXUq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059467; c=relaxed/simple;
	bh=py2pD0Pq0vpzfrzDMAVzVk57MagcEqVYkZhs4XL3Rjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODn7iOk5H+1Z4EHIHUc1v9hvmK041wBXdd50ZzridOEMRVJDCMNldDmb0Re3A0vxnYNqi6wzxrgKrGkCHOr/56pnZINppBj8YeapPdQ7WnDoYM3M7QO0TsmqMRjB3ia3+2i292awPsEHt9BusfJYtUJ91yHlhpgBaKnauYJ1GgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D/Mq3A6M; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-846d414ea6bso1749437241.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726059464; x=1726664264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2zaI7UZ7RWDNU7AWz06LrHmxPf0VmWUXHRPF7+e9M4=;
        b=D/Mq3A6MFLMAS0c05Bq7ihiZ2x2pX0t/sTOs6neYrBtdcXaV7l+vkNQtJ63Uf9WKPM
         C5L4CSwPZbPkwD1ZS//zFvIG7tip/nvvLPvwe/LzZYrcFHR/eQY0FNLLEoSvJQjpKtmb
         NT4zZeh1246e9zXCgA76w4cSW2UQ589Z7eU29xL5m2Zb99XBXr5ZyVU+kI39KjtMmUX+
         OxSnFfyINHuO0AoS0iP92W9VSHywbQjTJwrEWCXqNlt8Za9KTMuo2qT/B57YOvGGvQtH
         rSHyOYT7Sed6ICHo1XzOf6pgwubyQVMRyz4Z4y5DE81OykrnlFPrJiCpYmUed+WDTFMO
         gPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726059464; x=1726664264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2zaI7UZ7RWDNU7AWz06LrHmxPf0VmWUXHRPF7+e9M4=;
        b=GDtoEGd5QyEQpMTumG/K08A5w9nBbfPfahAAFBuPjq2OrV9+gSyNrrZrDfixZiepnQ
         7khxZ5AbOIQ8T9hbnQYTOG+ve5YPuldCbhrSDc6HxqKkns165M2Wcadkif9BE9R1Di0J
         n3mrsTMlcV2wLNlsuMQ896kylHdBQiFkfs/0nxYKf+QR4azv3BMm1i8KCsUVz1tiJY/u
         /B0YPEWOi+exMBfbT4uVBzLg7OlvzfXtagGuCFEpwsLjwfYikA5wx0hKA7kzEYCC1DDv
         mUHKMkLWXL+epJbXo5YyxalaCCds3ZNRc1o2gRgUT06zNVZ06ACyt7MGNQQe62h3/P3r
         TQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCVHPvmoUdA+/AOi87f7q+WWTYJPh9ntWBjXU7QAbxFlN6W2/dDB7UmX3xCujYZMt4Beim6Nage1jMP4RI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Ka8bRYRCxoIJEfvZrVqhJXhpSlI35K/veqRHs/rykVJvYrbk
	sf4/utSQiQ9CkfjUfOmrjxtS7I4NeKfAuSd14c0vgxOZci6AoPHCCTD8NqvmmlgfCfSXjkGiBmn
	V7kmwWDZ/B8Q/cR5HP6H8Q9jZjJbEt86OGc0NsQ==
X-Google-Smtp-Source: AGHT+IG4WUNGKSQ48Wdrr5DaQdJ2TLeXFlWcx8SVurf0AX9TOtlE6d7X1xwM0BWuWDG48CdJ6Uy1+Y3ww1VrqumTpHQ=
X-Received: by 2002:a67:b918:0:b0:498:c4e5:bc4f with SMTP id
 ada2fe7eead31-49bde1e349emr15829954137.17.1726059464250; Wed, 11 Sep 2024
 05:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092545.737864202@linuxfoundation.org>
In-Reply-To: <20240910092545.737864202@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 11 Sep 2024 18:27:33 +0530
Message-ID: <CA+G9fYsutqeYt4YZnEQR++7N6pmN4BqVnZLZgyKpCZm85y+-Ug@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/121] 5.4.284-rc1 review
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

On Tue, 10 Sept 2024 at 15:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.284 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.284-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 5.4.284-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 310fd584bff35c61219eedf5a30224c65506d8af
* git describe: v5.4.283-122-g310fd584bff3
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.2=
83-122-g310fd584bff3

## Test Regressions (compared to v5.4.282-135-g6561e7052c34)

## Metric Regressions (compared to v5.4.282-135-g6561e7052c34)

## Test Fixes (compared to v5.4.282-135-g6561e7052c34)

## Metric Fixes (compared to v5.4.282-135-g6561e7052c34)

## Test result summary
total: 101817, pass: 83941, fail: 1379, skip: 16415, xfail: 82

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 133 total, 133 passed, 0 failed
* arm64: 33 total, 31 passed, 2 failed
* i386: 21 total, 15 passed, 6 failed
* mips: 25 total, 25 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 30 total, 30 passed, 0 failed
* riscv: 6 total, 6 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 29 total, 29 passed, 0 failed

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
* kselftest-openat2
* kselftest-ptrace
* kselftest-rseq
* kselftest-rtc
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


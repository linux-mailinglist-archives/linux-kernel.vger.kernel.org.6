Return-Path: <linux-kernel+bounces-318327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4CA96EBE3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB2A1F23B0D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FDF14B955;
	Fri,  6 Sep 2024 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GIf9Hjmy"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDC14B090
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725607511; cv=none; b=u6lTw2pIYOYAjrLJSegCrvvFlSA+lxAfFLHSPYj8QC+uiWNz5bgg/0Fux4HEod1eXVHuYFdj0SF826DgRaDZ3pFTCO1NUW7Xqzq5uC/nAsGqP5B5WzWPDng3o5IQak7xj/kqdU1JWpbMsccDGp8YlOQIYbFLBOVLJR5RzdWOoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725607511; c=relaxed/simple;
	bh=hHUTo+F86clv8hZFGy7Nfqc1RnwVYm+ghp9EyUqyEy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIewyBWlohM2DzHjUVKGvB0qHv36v860wO7g/F6Bh7LWl2d5Sbbl5RZcfMwrvGqEX6B3uu84y9jolnF4BpIDPEjIid+wN2jjHqfY+k4BGBIuh+NIusWRs0WkQ198nmWm7jJPe8uv2tQC0fICXPsG9HAVi3DEf1aHTdIrEePKnH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GIf9Hjmy; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-502b405aa6dso33237e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725607508; x=1726212308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bD4jIp4EiNuoDLnWdNe8iCiwLr9Pmo5WVVfCTYbkDFU=;
        b=GIf9HjmypNCY1t28yE81AdgmfP7Aakl+Wa/s/2o0MplDQZSawmDa/KWVKx/8YkiwbL
         R9SxkZFEMqdquqdpOaUq+chybQyJPjdg6obcTSvqfgL6aBl71w7g7iTvFdXMikTeChrx
         zWxmfOuozAZlbNvsuJoyEUxWTvIQzjcEyOEGyPn16nFIzo5Lr/JdhsxzZ9urTdS4mqwu
         7Mi4x5ZPEN4e4kMNZQBut61qLGicM8sSSs3eVAS/93mX7ryhOLqlCWppz2aA428ubNCx
         UGRdVZ8CsaDYhNzgWuky7xaxxDdbAdR5bdAkaSvEnPkdb0y+OGpg/q9JCdeDhNKRLazi
         166A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725607508; x=1726212308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD4jIp4EiNuoDLnWdNe8iCiwLr9Pmo5WVVfCTYbkDFU=;
        b=IlY69H/kFNCnEoDGgYY6P53MWJdLng4AILJ7G51erppcPQOs8H657mcI0gPxgsXZmW
         JoTRbVbyhrkEemI7V3vRKNQMoiD4W2Uih8WUf739abejUHdz8ncAeqe8FYw6Am2L6MOB
         uHdeLUMJ/DejXcJuRAwboj7doU7Oi1DwQoqB1bkQuwoE3KkYXgb4EvbVN27TaiTkgKmi
         kUaDBpITDUWy3RXWIKmgASNbxIUr3zIKhwUgiK9ntMPdPrJV+qovinInYB229SAEl5xT
         y+m16LYjeuiXgQ81jKmuj0bV0FplnY3dgtoy7hdLkq4tB6ADkWtgn+bRHb3Tuj6zPG09
         knPA==
X-Forwarded-Encrypted: i=1; AJvYcCUCVYJ1Pf1377yxjgecePYXpPqK7yFck4RSmMm+xpqG0vQ+tGHQwKwh5ux/JQsRAU5erNBm+GEgXqwGy2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtzlv0rK+kJ20hvky7g9Dj5+D6GSiTZPA1TTI7oxGLmzYRV0Tk
	C0jLUA/aXLHhMsP6JHnxbw51zCzddBzJ2ip25pUqNxEBK42SWoSfEJJfP0bPCIP2JbCd5A4Zx5x
	XeAtXB2CGHc1qlW0AQDwRHW4WJWQw21SLxcBkpw==
X-Google-Smtp-Source: AGHT+IF4nW4PoHkQCEvOaOVGHqi5BQRRj2GwYte8sgX3gQwSDWxI9YXWWLzI/UyejNRPmqA+w8HxjUgtuAYIqnX0dUs=
X-Received: by 2002:a05:6122:3104:b0:4f5:1978:d226 with SMTP id
 71dfb90a1353d-50207ebf230mr1549004e0c.3.1725607508218; Fri, 06 Sep 2024
 00:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905163542.314666063@linuxfoundation.org>
In-Reply-To: <20240905163542.314666063@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 6 Sep 2024 12:54:57 +0530
Message-ID: <CA+G9fYvciWJimpEX+0iRRtwC8qNKx7n3U65aqdNrMWRQLwtFNw@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/183] 6.10.9-rc2 review
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

On Thu, 5 Sept 2024 at 22:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.9 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 07 Sep 2024 16:35:01 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.10.9-rc2.gz
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
* kernel: 6.10.9-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 1f09204bb539e1a60467c14bcc447a5f4575fe65
* git describe: v6.10.8-184-g1f09204bb539
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10=
.8-184-g1f09204bb539

## Test Regressions (compared to v6.10.7-150-g88062a11f41d)

## Metric Regressions (compared to v6.10.7-150-g88062a11f41d)

## Test Fixes (compared to v6.10.7-150-g88062a11f41d)

## Test result summary
total: 233159, pass: 204972, fail: 1882, skip: 25816, xfail: 489

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 131 total, 129 passed, 2 failed
* arm64: 43 total, 43 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 3 passed, 1 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 12 total, 11 passed, 1 failed
* s390: 14 total, 13 passed, 1 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 7 total, 6 passed, 1 failed
* x86_64: 35 total, 35 passed, 0 failed

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


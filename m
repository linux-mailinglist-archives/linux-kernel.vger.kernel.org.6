Return-Path: <linux-kernel+bounces-551001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6430AA566CF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 12:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 827127A86D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 11:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A11217701;
	Fri,  7 Mar 2025 11:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w8xhjqii"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C5820FAAC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347213; cv=none; b=XUNpT26eSEBNqEmH+HNKRrqZMivd81tqz8nO6TYRX4wSqN5W4i5/5JgPCUQ8u9UN6EoDL3OwiyOrQU14cak8mvRMgl5A3CPXUB/wK5CpfKWiX3PXvxRtu2Qlqslzo50YJywj24Xg/0ZYszK0IC12QkTKsh1N26Ug3OHNvzepm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347213; c=relaxed/simple;
	bh=UBnBUcC8OdCTN47ndj1+/FiEIQPtdgXbgndHs9HLu+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtM2lWz8FH0nhVt8KXuCjpk1zd+OtU4/uTB44cCIouuCGCwSCI8VZBX3epi+IndOrPIrtrDibI6HLtRCMl615idogfY/YHuMXVG75opfVPiX2bScFnvwJVvujia2bwESWQW3PDF4w+kbqGyjlg8kXl8xmt2yTez4+Vc8CzRAJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w8xhjqii; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86d3805a551so655291241.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 03:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741347210; x=1741952010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFvEW9+gOAumMdwUS8FQ7wKhbDn/YCcr8dlH8XU7VG8=;
        b=w8xhjqiiAQ5m9rAqCWNZhkVLSLCYEqT90KbvD3ayrfks9rYiBcPved7yWMlD9q05tY
         TFBcYE1bzIKFxfmwWbya9IjQeBdQAMtuI7SacWb99+bex0RFVm7KjWWTz9EVBQRwBww4
         Bm9NObD8Eb4UbD+/cLceKMK8oZ661S1PK0zaVvS2INr9vZqc4MYc9jQtnf0v9YhtGcWl
         vnTqT5Kv5i8lYXYGOlbbavTFG9T9qfpIGHEdOux1kOoGuEX9JRlRHH/hFIbjGKCFAhjx
         9vgNZd6r+ulB99O6MXiMrQvXI9ibIRHojFFQEKmVTJBTXghmYXFmk0W2IIvz2ZbGXXOq
         vySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741347210; x=1741952010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFvEW9+gOAumMdwUS8FQ7wKhbDn/YCcr8dlH8XU7VG8=;
        b=ip2Zj2h53hGQKMuz2JgbBOLbTybUhKNDjeHHz2XuDFZXHhXqgH51o9LjPFoV0XNYlx
         LGrrk9hDgoZgUT2/BhYTj5W8FQmGlD6Qg/mMIe0XxywidvVOoakeWBNLX4oyV9DAps3n
         v8PlYOPI3O+juQbk4COFgoY+OJC3T5fGtmUXIVPa7wbC2KVFAd7HeG0gZTVL4/BC5kb5
         OPW1m6J8A65NHEQdH++5ELca0q8lHE8OTzJmXLJndt3CsOCScCNvUSllWk6U51e75v6G
         5Edpo6dhZd5wpBKE+iN8ZbcOnzbZD2wkVBNURghc+XBRjqRd40jd21ZlbWD5MAUc779F
         89kw==
X-Forwarded-Encrypted: i=1; AJvYcCUMEsHwX6xJdJHEoGkY5KX4u3w9zcLKLubnRpw7tcf66kMnLzOL2fIdMhYqlrJch97fXCXyzJPpUhNTFIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Sq8NjCx01fkZNjs0O5OOnoHYTqBhREhs4zXFccBUtxjh4AUi
	vgQOLgugFYw6UqorQVDW9QELY++BK+bJYKmNIE8Xu72hliYRY5a1bRpd2ob6U7B+lqtjh/cM0XU
	bP60Q4jnFH+OWrX7A8N0xLO300ESupMYHMCok4v+GM7Fl6yCeIZQ=
X-Gm-Gg: ASbGncsb0kFXEkldvVisy2Xf49WyywnPEg0Le1KqNk4mwAtjx+kYzhxy84BjTPdmKAg
	facIVrhA5v9ETocs9br5iD59jUgFzHfmqMj8F7igwqP0jGGa7YVgcE+Tr1j+BApzWp1Co5sbwHV
	vOwyHyb4moAzeO5a28Bzy7kUkYRES2zPWyaOJjwkbii7ATcPVqvKUgW/7Vm2Q=
X-Google-Smtp-Source: AGHT+IHJA+j/csP2xeWzCbqhvBUA64gace/4cP60Pao9dUXtJw/yVzXRBp55cl5+h5+kWw/pj+oWqNAn0ryDA2aMF1I=
X-Received: by 2002:a05:6102:2d09:b0:4bb:e1c9:80c6 with SMTP id
 ada2fe7eead31-4c30a344411mr1907125137.0.1741347210593; Fri, 07 Mar 2025
 03:33:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306151416.469067667@linuxfoundation.org>
In-Reply-To: <20250306151416.469067667@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 7 Mar 2025 17:03:19 +0530
X-Gm-Features: AQ5f1JpPpPQ1WqZW24UbFwjCCjLQvm6wQsbezNjruPWCZUfozzH1tlvkj4rl9yI
Message-ID: <CA+G9fYu5pu8-VdefnTHsyBwCdJ34TWb_3U2snGTm2c5pm8ftLA@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/154] 6.13.6-rc2 review
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

On Thu, 6 Mar 2025 at 20:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 154 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Mar 2025 15:13:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.6-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.13.6-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 3244959bfa6b859b760b8bf7d9ab374356a374d5
* git describe: v6.13.3-552-g3244959bfa6b
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.3-552-g3244959bfa6b

## Test Regressions (compared to v6.13.3-555-g30be4aa8b957)

## Metric Regressions (compared to v6.13.3-555-g30be4aa8b957)

## Test Fixes (compared to v6.13.3-555-g30be4aa8b957)

## Metric Fixes (compared to v6.13.3-555-g30be4aa8b957)

## Test result summary
total: 84333, pass: 68272, fail: 2726, skip: 13335, xfail: 0

## Build Summary
* arc: 6 total, 5 passed, 1 failed
* arm: 143 total, 137 passed, 6 failed
* arm64: 58 total, 56 passed, 2 failed
* i386: 22 total, 19 passed, 3 failed
* mips: 38 total, 33 passed, 5 failed
* parisc: 5 total, 3 passed, 2 failed
* powerpc: 44 total, 42 passed, 2 failed
* riscv: 27 total, 24 passed, 3 failed
* s390: 26 total, 25 passed, 1 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 5 total, 3 passed, 2 failed
* x86_64: 50 total, 46 passed, 4 failed

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


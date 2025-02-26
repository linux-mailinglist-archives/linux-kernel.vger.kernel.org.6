Return-Path: <linux-kernel+bounces-533417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF94AA459CA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85D23A3904
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020A212FB5;
	Wed, 26 Feb 2025 09:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tb0lNpVP"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A81E1DFA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740561431; cv=none; b=TXf7agCjeOoHcbyd+G3vDPDtlCQael0xUrxo4xm4pDE+id09Lv+viETPEl4ty1sNSsiqzk1+PUvqNxrS73TQF1bBJ7wKEEbP8iGQ6C6V6Ly7TdwhNFs5rFJ+EiIEXvYTamw8wqIpksk5zT9phAl3NAoA+/ZKz52YsqeuMvYOGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740561431; c=relaxed/simple;
	bh=Hf+VCZQAkJT2meu1sdVN2NPdeG/wTQeLa2BFN9U1kK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aekZP5CzI9/JeukyxxDkpVLQrACd+sWAKwFkmIxZ6mGGm06Lxeb2XMTmoLVsq0ljcnvlXFh0IGGYVKgAx2eI5O3RuIbNpOUf86r22YSKs6jPvzcbEtODZY2Dtokwc5nd49cVtPkZsCI+LMHT1DFkkPv1lqXsFlKjs1My8+UhDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tb0lNpVP; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-520a473d2adso4229274e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740561429; x=1741166229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkYsziU56oM3MwTS4qzMUVuZRmIpV9WQpyZSvh+BG5E=;
        b=tb0lNpVPg6F15WG2pskzFuz/wKuJDmfNDGb5GRJwc/WfHfDNTABWyl2BN+wEG91PCP
         AANb74c+6C5Qx73xtYOOHtGDOZpJFQXmR3oIZew6Bl8VNY3uMcCAowUJynbG/G+4em9X
         CqDkdodj1sTOhKd+Hb6aD4sFEW/3AxT1ef6MGww2pjZJZt97fGAxy7lNq9HJWAjD9vtu
         QK/xHCVeeDYpcYE0qhyUGiL5lrKFPCfaBeBBvXwNagVM02nj83v/fm48QenRX80O1Dau
         82gXk+TGT1zCqlT+LePWFvgtkm/r481KKKQJaJKFBTHrMt6x21ae6Nr4XgFaJp2rely7
         Ykvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740561429; x=1741166229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkYsziU56oM3MwTS4qzMUVuZRmIpV9WQpyZSvh+BG5E=;
        b=S0qbluUGRkqMpvMGAyjXXZOPV0LUe0/+KBXvmFCfs9BvK6RsNwYQfmmBvLdKZzCArf
         NhHW9oUxmkO/XI9Z9s6JgaW/dtxGuFrbu6hFv2Kc/WAbxQ5kazRtfMQV7O7mMW4h6t11
         wYCxxJVaV4q3THulfml2e8C7sNAEnsg7p5GuZBZfWLwMo8h6NDWVR4y6iYHiZ+T/7WT+
         Tl5rup17uG8zpN0wH+LlHrKvN26azp0UagifKM5lXEJg9TW1/mgSOjSr0s4bjoP7Ubax
         55T6ocmL4wLiJgsIfI2a3t5i69q0DlleTGYGhtaoIKilbS3XQkK21cIjuDLlEDdVGT5i
         YZFw==
X-Forwarded-Encrypted: i=1; AJvYcCU0R9CKwz5CGAB1Fgehh+UuzrJ3qkamU8GIyriL2zXHqQe3RGoOWEvu7adpUP5lgamcLwbP2bYw1zXAgew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh48o9AtV5XgN8U2Jo4Lw+1KuNqdmaoiGWtOO+SiUyCgndClt4
	jS1rlh7Mgmrz2PMz2gcypZBnvMBdROGwSESI9c/pb5RqJv+4F9A1Wl3Our6ZCzqiC7k29lU72zb
	MU2aLx8Ouh5iJOYYxGJDPJzD/qnedkeJW4wQ1Kw==
X-Gm-Gg: ASbGncv67jpbGmyHaDWWgyiRixv0TNIP7M0CnhtZunxdF/8tAOIZLQsCE7CM4idwoP3
	TW6NuivLPlE0JAwJG2qkdVGCt7oDvHWKrIewKbiBfFCbRS891XdS6nhlVMqjp/mhMxZ9JeYaVKe
	rdU7dYfm20mLvK19UOGZSR38yB7tACF7vnRG7OAago
X-Google-Smtp-Source: AGHT+IHhFiHsjlOh4HmrLEErJxo2Wlkw5Rir9/OPzCHMjsHipZPzDGQHYAiqeuDUwOBfy9pdIdakUoNmvIbZJ2T+Imk=
X-Received: by 2002:a05:6122:201d:b0:520:4996:7cf2 with SMTP id
 71dfb90a1353d-5224cd6264dmr1654324e0c.10.1740561428792; Wed, 26 Feb 2025
 01:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225064751.133174920@linuxfoundation.org>
In-Reply-To: <20250225064751.133174920@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 26 Feb 2025 14:46:57 +0530
X-Gm-Features: AQ5f1JqZEZmcBTxhk-z2C8v138XsDQ7jKMGbCVbb5921NpSF-DW8iSkGlypOB5E
Message-ID: <CA+G9fYt8kOe_wkQe_iVAwc5qPKUiZWb1=COO88Dj3c8oVWkNMw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/153] 6.12.17-rc2 review
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

On Tue, 25 Feb 2025 at 12:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.17 release.
> There are 153 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Feb 2025 06:47:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.17-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.17-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: f5c37852dffd24f66248b4086ea594060f3299a4
* git describe: v6.12.15-380-gf5c37852dffd
* test details:
https://staging.qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/bui=
ld/v6.12.15-380-gf5c37852dffd/

## Test Regressions (compared to v6.12.15)

## Metric Regressions (compared to v6.12.15)

## Test Fixes (compared to v6.12.15)

## Metric Fixes (compared to v6.12.15)

## Test result summary
total: 125310, pass: 102630, fail: 4192, skip: 18488, xfail: 33

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 137 total, 137 passed, 0 failed
* arm64: 49 total, 49 passed, 0 failed
* i386: 17 total, 17 passed, 0 failed
* mips: 32 total, 32 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 38 total, 38 passed, 0 failed
* riscv: 22 total, 22 passed, 0 failed
* s390: 24 total, 20 passed, 4 failed
* sh: 6 total, 5 passed, 1 failed
* sparc: 3 total, 3 passed, 0 failed
* x86_64: 44 total, 44 passed, 0 failed

## Test suites summary
* boot
* commands
* kselftest-arm64
* kselftest-breakpoints
* kselftest-capabilities
* kselftest-clone3
* kselftest-core
* kselftest-cpu-hotplug
* kselftest-exec
* kselftest-fpu
* kselftest-ftrace
* kselftest-futex
* kselftest-gpio
* kselftest-intel_pstate
* kselftest-ipc
* kselftest-kcmp
* kselftest-kvm
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
* ltp-crypto
* ltp-cve
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


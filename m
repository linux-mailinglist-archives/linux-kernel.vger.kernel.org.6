Return-Path: <linux-kernel+bounces-348576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9936A98E949
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B402F1C21ACE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E1748CFC;
	Thu,  3 Oct 2024 05:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCmicaqn"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6A83C488
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727932201; cv=none; b=ZdWWXlEJi/vevyHy8F4EvjhHENfA74xnPj6OHgmHIXjpQLOua3oKzzF73XTZh5/+ri+j0QEG4pSO8oMxdLZ5ORkFPr2t5ggC4Q7MSFa6O7MBdd+Zy/XLMOulTCUvXSiUkzaTvRb+zjVHQxDzinqDcVHYMQC5kJmnoFVgx3JImEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727932201; c=relaxed/simple;
	bh=qrbLRk/FSxnCiu6axn74hXEdJnOeoT94Cx/ecRppH2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0t7/gN/D/xAOg2WCE0Hd9Chl9Qit3A5in6qvqrpi0dAd9AjRns5catjNqHUtVATWWSHvlns/RiQdmhzvBFifLueoAOMjVUlegE8cc6NUceeFIpPmiHjtGXTH60VxpSiNydUCBMRsFw3Dl1Dsv1E3eyqj41md2NJ5zs5If4YJSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cCmicaqn; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5078bbc3a0bso156878e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727932197; x=1728536997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ywgtKyqh0N3Dye97MVd0kIqtuLbIpst9nSCmWrn174Q=;
        b=cCmicaqn+cI16HmdZJEyNHhXxURySEZp8Y2CYM5Y/XxmPdod2ywxrwJxjmNUPlssFJ
         W9Jv/iIRDNz8l+5KDwZbJaHicUOLRryWUDNwtEUtuIoS8xfJ8SITMhKw8yU/sKDI6anY
         IeY1mZzGglIJly3oxqFQklQld5p8Lvkt1PMKtS60O/rsp2kHdWynVANSebIs1jelQH+n
         som7ZV+wIv8ySrHI7cPXgo7zGkS2+wbI0usYhYfjnzjSAOIcCKM2fCKiq02KMhLU+iif
         mtMP0tGYa/JtqI515X2B4fbT8hhtm0qRFxUhIjlpf+ud9t8r+VAqI9lPrgKZdr3Z8s3o
         FrHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727932198; x=1728536998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ywgtKyqh0N3Dye97MVd0kIqtuLbIpst9nSCmWrn174Q=;
        b=M95Xn0aVbrTjYj4IrmcSFSthalG9HjmQRhaC+OaIjNI65qoi3U+pPjKK+6QYI7lCcL
         3m8Wo92jzCbGpBEp0vQqJirFZ0U+HiFyeeemtp2Dx9/yWPHLjwrwT0/uwpqQ5qxKPlE1
         pG22wP6vS4FapxrRmE0tU2v4DHcBOoOhrt2TUZrngZVXjDImVYOg64fGr4NP2mZ5yu4r
         nl+64ruvmNTsqF0jNM8FfUx7JGCHKTvQkRhT4Yy5pGp8rxJSFJWHvRWiiW9g8hb7xbCt
         1EW0qtg2pHWgadrYtpjWA+uxrXUQI60J+7fuQq0pA/2fxvSyvccsn2vGRu1IYIcJ/9M5
         3ZsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj77BpKQ3R0O8d+ZgE21glZR5wF7NNTnUt4eJYn4ra/KrDol0BASvZ7lNO0rIuDSBK+rZuH/kgl7HGuSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL41HmeUGNOrhIJ6+Du0Wb9yUYsEmdbm6JEkc/ipOsUaY+wGRM
	xzhVWqW/wXrXjiSFdoThnWFe4Ln0bBC3CcFPchUyAV2PCnF9B7K4HqTzTyNwWD3vFTQwgvfNNYS
	X0v4Z/1mFXmZUoA0mh6M3nwa2qzp+BeRb9JNtjw==
X-Google-Smtp-Source: AGHT+IE9u2+/8nC7XjQNdK9e4FXcoT1LUX+A/NRgmnjoZdPr9xDcH7NfQFwxfX9f507kLSYP5FbG/rzvoA7a+mzNSY0=
X-Received: by 2002:a05:6122:794:b0:4f6:a697:d380 with SMTP id
 71dfb90a1353d-50c582122a0mr4539080e0c.10.1727932197603; Wed, 02 Oct 2024
 22:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002125751.964700919@linuxfoundation.org>
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 3 Oct 2024 10:39:45 +0530
Message-ID: <CA+G9fYtcs_bFp_N+Q59Nn_bM2AT0Xm4utdh6vT+Cdvj6D=VP+w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/538] 6.6.54-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Kui-Feng Lee <thinker.li@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 19:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.54 release.
> There are 538 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 04 Oct 2024 12:56:13 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.54-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


As other reported selftests bpf build failed,

libbpf.c: In function 'bpf_object__create_map':
libbpf.c:5215:50: error: 'BPF_F_VTYPE_BTF_OBJ_FD' undeclared (first
use in this function)
 5215 |                         create_attr.map_flags |= BPF_F_VTYPE_BTF_OBJ_FD;
      |                                                  ^~~~~~~~~~~~~~~~~~~~~~
libbpf.c:5215:50: note: each undeclared identifier is reported only
once for each function it appears in

due to commit,
  9e926acda0c2e libbpf: Find correct module BTFs for struct_ops maps and progs.

Build log:
-------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2msz2dGbiCYZjR2hPFlN5xFUOhX/

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.6.54-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 1bbd78667e8e467cac0a2bc31d183b9d9983f448
* git describe: v6.6.53-539-g1bbd78667e8e
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.53-539-g1bbd78667e8e

## Test Regressions (compared to v6.6.51-145-g3ecfbb62e37a)

## Metric Regressions (compared to v6.6.51-145-g3ecfbb62e37a)

## Test Fixes (compared to v6.6.51-145-g3ecfbb62e37a)

## Metric Fixes (compared to v6.6.51-145-g3ecfbb62e37a)

## Test result summary
total: 170988, pass: 150287, fail: 1587, skip: 18917, xfail: 197

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 129 total, 129 passed, 0 failed
* arm64: 41 total, 41 passed, 0 failed
* i386: 28 total, 26 passed, 2 failed
* mips: 26 total, 25 passed, 1 failed
* parisc: 4 total, 4 passed, 0 failed
* powerpc: 36 total, 35 passed, 1 failed
* riscv: 10 total, 10 passed, 0 failed
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
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


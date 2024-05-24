Return-Path: <linux-kernel+bounces-188556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E2A8CE389
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207F11C22007
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174B985636;
	Fri, 24 May 2024 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GREKJUnN"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB14385633
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543147; cv=none; b=Lsdk80l3DfuEa3EzeE1AudxgXqYhc5na2TKbEP3tf2PjvWSeYvKHAAVXbxaB4Uyl32YiEPa2MY7zpll0fuWT9fyZdScfBqUDGjygq7qLduNMv9Mzg1z8rCPLMQK2+30fXnvSsNcA9fTFZNPR/Z7rCqgT2C+JUrM7bk1Rh30KoIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543147; c=relaxed/simple;
	bh=+r+3JkdoTS2WhVcXvGMz1cSz9823Vhc8c1KI2ioY+Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMMpMUP0Omq+9flIXHI3pgx6Jg++m+6uYg1t9VkYliI8FUYw8xKEbailo3k0fciEgKtthZJLjwg4qALnm6rY3IelRDe0AMh/67ZzOQkH8RQdAmxTDrYNcwzB3ELGYN+jorPT4yOEwNEN2KiS/0ma2e/rAnlbDCD8pCenr/Hfbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GREKJUnN; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ab9d3de222so4512246d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716543144; x=1717147944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QobU3V4M9zLBH4ceWs5naausHLldCyE6Lvje0EpDn/I=;
        b=GREKJUnNYJ9C4fagsN9CZ7OxJmbLPKBwOtjfGUBe13BSolz9NO6OYvQxuCRGwh38r+
         IuglzW4vlpPTKsPX8fV5k7WocYNcDpiXhvOte1vPf0CWFjGfcyH+XKbZuNIKAINf9xXH
         YRt6U08zrQDA8A2SgjRyxXa2mAcuJEpWHpNIxqhjem6quvyUx4/qphNKjDsFwdvAEvW0
         L2/cvQOytRIzCe4ym2DE62nJOysWJV4AugM9pS/RiBj9Xx55qZ3WBB+nVvcLfbNHSaYI
         jIVTyPhXRGOYP4cBwCtB72kY2IO0RPjTFnaIjX9/XU3B7XP/KrSdNdnAKfGt863ZL2kd
         tlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716543144; x=1717147944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QobU3V4M9zLBH4ceWs5naausHLldCyE6Lvje0EpDn/I=;
        b=Zfi4bQRDKfSRx7WZ6vO+JXhiLFnuLrfi5YXzJ07vz2+Mc6mN5MaUPPsLxBMuyZPhzN
         75L8H8C74lOj7QOKr2XvBoG6z3AU6z09dldEvoMgJAr/o+zzTdQWnFrHytDcNnv5dmjx
         0awHq3aBtM1V35lY9fHAb2V99jmoDsacrPkmqJCVeNdFG0sOr2nHbtJOUkhxOvAHCCw5
         8PjUzjKm5J3yBkwFW3xikgnF3nVkG7PYvLObboVkWQ6pTKTi/7fioNaOZjtp9WTVS1Ig
         CC0jttzO+tFg0GFGOAtkGuOVcKDsXetTDIZqR82wekTN569pcNvwQiy9X8jqRp8uJpRo
         VVDw==
X-Forwarded-Encrypted: i=1; AJvYcCUZoICuFdz7roXd4acic0cf9oz19VQFUuxuTpOgLf/GjkPEvlNGWM5SK8y1aUphLzU3iVa9iIUdLP4FbQ6XF9jK0XNkzHMaSLhliVwe
X-Gm-Message-State: AOJu0YyCcyiEjHAEAWMxbsyJKfcIf2c6YwmabBkk3pHTp/7V2/xOiP32
	e1zAiTsiEE1ozbtQ4D602mvIIe+3ecT2s5L41AIyvR4k7c0yJgcAV+mIQ4xTFHmzkAxReqCRNJ0
	te4LWCrqKt5Y4YKQuUmNEFnDzU3Ey/IQ+vRFIRQ==
X-Google-Smtp-Source: AGHT+IFjoTKXgMDlyDzfnWuX3M1jKwtPOvvc+KZ+MYplITOHlLZg+z2dEWqjtafHvad6W6+WbomyBD93D2MSib0JiRY=
X-Received: by 2002:a05:6214:4903:b0:6ab:8e5c:e17b with SMTP id
 6a1803df08f44-6abbbc194eamr17864306d6.9.1716543144576; Fri, 24 May 2024
 02:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130330.386580714@linuxfoundation.org>
In-Reply-To: <20240523130330.386580714@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 24 May 2024 11:32:13 +0200
Message-ID: <CADYN=9+OCBJ0qkoB-t7ECCS=c4rHf0YKNZmmYkvu1F9dfkq1Zw@mail.gmail.com>
Subject: Re: [PATCH 6.9 00/25] 6.9.2-rc1 review
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

On Thu, 23 May 2024 at 15:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.9.2 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.9.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.9.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 5 total, 5 passed, 0 failed
* arm: 126 total, 126 passed, 0 failed
* arm64: 38 total, 38 passed, 0 failed
* i386: 29 total, 29 passed, 0 failed
* mips: 23 total, 23 passed, 0 failed
* parisc: 3 total, 3 passed, 0 failed
* powerpc: 34 total, 34 passed, 0 failed
* riscv: 17 total, 17 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 33 total, 33 passed, 0 failed

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
* ltp-cap_bounds
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
* ltp-io
* ltp-ipc
* ltp-math
* ltp-mm
* ltp-nptl
* ltp-pty
* ltp-sched
* ltp-securebits
* ltp-smoke
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* perf
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


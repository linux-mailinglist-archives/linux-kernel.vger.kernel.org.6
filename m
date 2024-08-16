Return-Path: <linux-kernel+bounces-289349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2064954527
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646D7286812
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9330139579;
	Fri, 16 Aug 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIncjH/y"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080584FAD
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799231; cv=none; b=LHxU+Mpmm6ymFf+p+DHbb8VMiAJZXBdAnbfSdkSgYNBXp5KGxda9e/BCmt0cH1QfGRKWXh/pfft5wn3SyLYR7DnCI1EDMajTij10byeDgjTgfc4x8oXNauxfayOC2QD0XIG292VdZ3gZMtTJTbBLewj4xITUPwN++/cZxtYJmRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799231; c=relaxed/simple;
	bh=lkyJn6apocNRqoC0TKeOfnk/JcUHx29C9iaDYTve8QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2rCDlu3k73pmTAzRGvF5XHap4k36kNsLgK5n19xQNwc3amxsy8vkqENb+1nLKTUMjlLqNg4W58qE7eMT+Sp26c2qAx8fSJD01xqRv8IgvwK3G8R1UJpMUtqMTowH7Jh0bGIXjhzxOXiOH//PsrWwfbvxNMosC+seniGSr6r1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oIncjH/y; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so2273220e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723799227; x=1724404027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8a6uIKT4Rr2w50lue0Kw27dst3+ON0jeMNQJhegGkc=;
        b=oIncjH/yT6HwRXtGf42EUy3zJVTaMKN4HJp/fsDmJO63/xsHneeLhKtRrmmBDn7Lx+
         pFMI9VlJVlsvLrWK/wdSqUyXz7ipq34trSchWvvRZuhgK4g2O9IZTCcP0c84AIF4lmIN
         ncHNoZffblo50QzQjMrKsbNzzsInywy527TSP6TowRzSrIqI1yk/Wkug379ApSI9trvd
         5lAoyxKPkTR/lmmLn2MeyPBuiNrXp6rxf8UdzbwH8P/4+psR5jTbxFmHPajWKn0wr0Mv
         bOptpoYQe6jKnn38Zv8C636507iOkpKFDBHShwK52EsguV3+2ViEDvkof/3gKIEav+nM
         xn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723799227; x=1724404027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8a6uIKT4Rr2w50lue0Kw27dst3+ON0jeMNQJhegGkc=;
        b=m0erAZz4gVgkKneh49dIq2PwZzbzf0a/GHXFObI86ommatO5Ypd55P/NPYhM77g9AH
         iPvqQqw5K+qCzCxRpfTXqvlqr5i1bGYI06hHz4WPF/ybhH8lDNDR2n0+IdqICWNALtts
         cBdZzX2R4GpdUVofCD19c4sM/mEq6AhHnlC7JAF92JTVbRrNEmK6omM2WRfaLY8fMH6e
         YPGmAQcnkyO+7NWQQMIrPABycVlSJIiMnF4FQsRqEb39vFf29IaCdKYFdo648HL1+P+H
         6eLyH5++P9wc+dFo2XDOF7Rcw2gBK+imwxJmnEGtclfiOm0Vc9awaqJc6FP7PFI0Hnvd
         lN2g==
X-Forwarded-Encrypted: i=1; AJvYcCWAOYvljA9QkKxBm9OyhelIYuJ0OhauSh10tIil6iVemrMJyxAFcyHJTg7ay45lUrVLU3Nz7Fpn2m6Sw00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXI998kB69pKb/69Ao/oqpDl/sOAbNPQfv2wUK0DrZYsjDUMGY
	XmkXH2wyZyxjOAOdG/FEXIvyS6XuYkEYSySzkAfLeQ9WCL6r3OuoGpUTK8d/SAPxmRBCOCcQWab
	JtzDwbDYgvaQ0gQVysGjjS5jz9Wxb9OmEeEIu2A==
X-Google-Smtp-Source: AGHT+IExrDK8l70AX+TCsQlgMhHX3ojaFYwD9nWp2Z8ttk+cGYowBZSokG/ezQyoGwvYDsImwDZUYnBTBP4yJisocVw=
X-Received: by 2002:a05:6512:4015:b0:52c:812b:6e72 with SMTP id
 2adb3069b0e04-5331c691b75mr1404510e87.1.1723799227229; Fri, 16 Aug 2024
 02:07:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815131852.063866671@linuxfoundation.org>
In-Reply-To: <20240815131852.063866671@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 16 Aug 2024 11:06:55 +0200
Message-ID: <CADYN=9+4TcfTeCqpH6dZtV5ry6wPOzyR13xSYDN=i29-XWxcUA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/196] 4.19.320-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Aug 2024 at 15:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.320 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.320-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro's test farm.
No regressions on arm64, arm, x86_64 and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.320-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: ed3349953afb1f3fbd768757830f73586cee3375
* git describe: v4.19.319-197-ged3349953afb
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.319-197-ged3349953afb

## Test Regressions (compared to v4.19.318-33-g0a1a65dc05b2)

## Metric Regressions (compared to v4.19.318-33-g0a1a65dc05b2)

## Test Fixes (compared to v4.19.318-33-g0a1a65dc05b2)

## Metric Fixes (compared to v4.19.318-33-g0a1a65dc05b2)

## Test result summary
total: 58550, pass: 51683, fail: 321, skip: 6498, xfail: 48

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 102 total, 96 passed, 6 failed
* arm64: 27 total, 22 passed, 5 failed
* i386: 15 total, 12 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 23 total, 18 passed, 5 failed

## Test suites summary
* boot
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
* ltp-smoketest
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


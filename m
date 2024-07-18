Return-Path: <linux-kernel+bounces-256010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E97909347BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 07:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DC1F21EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EE655E4C;
	Thu, 18 Jul 2024 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+KALynM"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C38537F5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721282129; cv=none; b=nBT3LSwhQV5gF08wzC32HBl+KOEYNtZ7NeWZ3b+UIbt676koIj3mKxyotX/rTiqh9WxLE+1x6fH/RvERmY1lb5+NLR5SiU2++Chof9BB/eKYO0Jl7zpN9F8qW2KlxGQBn2T06VTTo3Lzwbc83NGDrYdtB7NIJ1SE7dTX9YUjR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721282129; c=relaxed/simple;
	bh=e3jzj+zv4uKoyWuQ2pepUbVZTtAISYZ4y2Z+m0uWzIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/t3HW4oSGidVZHO1kTVPBjO8PnA+jDeg4exvaf/CpWxgoAej4jaUlyvnZiAqalaTM68fihyzRItHE1N+rsWT7OmQn+HF2W4ayI4CIk6m0vselAO1Wzvha3oGCFn1fkzYlzmPc7mPzhCV1no2hP+CbdoZuRYU8uWoOZnwmyC+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+KALynM; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f2ed802fbcso180732e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 22:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721282126; x=1721886926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UikeJglj4mqEJ1Vgj9mu8IORdC9p9msk12TuLHCn4Uo=;
        b=C+KALynMWxmBm1u7TKKpf+sRFAKULg+wgynYaskbK0GxmXYyFqZRB5jawpO6TfRm39
         t99i1kw2WE4VGlJCb6xVBz/2M8toP7hNyFoDq4WtT4DMxuiyeM+dxlm8SaB+GFykHjsc
         ZN1/FkyjJLM1Yq8RyBuF/5MuQJ/tQeyL8dypXiWnXY37MfqW5rFzrtjEkOlfTHsZ/hRI
         QweMuhessXUwV+Iu645JxEHeYPyc+tRnsbiuvIY34YVIniosswEQGBcYwqelsIQ2HpPr
         o0m58CAW7hF8oAmzdlgsQvIgYnshRYx3eHG7rZvb6PQ174x5xwIOl34ue5H99NaZ2ETg
         0+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721282126; x=1721886926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UikeJglj4mqEJ1Vgj9mu8IORdC9p9msk12TuLHCn4Uo=;
        b=h71ENlGl/ZtcbXDvZ0xMfcFAdqi9DVhDq8vTY2Bds8/asiDz451VOZAM3r/PnsKRzG
         X/SR1hMSOEfnAreYPMxUPLTmM067S+AEabmghAjpiUqLifHd41PI67sMbONWlpSblqCW
         HI7cdflhAuLJcVVQFL+Bq8QNZU2DvnJiZMmfGnYp6/zdHJzVxEvg9hMgshoo4J+KQFLn
         XxFMS3837LIR/C+JRZtoWf25JavjDWW4pgSKNKd2gIpP7dfXwE2i1IQKwNn5dsme+p3v
         XZyXO06q2bI6nv7oAbtttA1reDegSV82cuQUjg+b3zSldsTc6kFiYiFXj72khvThVPaC
         y+9A==
X-Forwarded-Encrypted: i=1; AJvYcCUwIg0DPzI5TC5FmKI7U1/GBHg94nW9hp3R3k3z60vbUyV0Jx04ZCzKm7N2zLnVKJ9WrWnEBisWCU+ldy5yMdkT/clNgm0pxe+RAyWV
X-Gm-Message-State: AOJu0YxX0+aVIIz4epFhOgIl7FMabYY32qbVeFz9rYYvITshMwJKHNmg
	ZOP0/ca4LJbsxL+8pdogCQtpzLGAo5lygeg6AEuwmS5GMPiXhrLeQGNn+DgCrE/PByTohQCr50M
	sgO3Le41AmL84JeWK0Feg1O4kFz2VxXeKV9JXjQ==
X-Google-Smtp-Source: AGHT+IG1mjdqmAC/jqNQitwGKo0lDKe12wqzLLoI6KXv5dgT8yB3brqWRtn8KfCQgAlCWrbkHpnS2zKaPFh02vUSmgM=
X-Received: by 2002:a05:6122:1ac3:b0:4ed:52b:dd29 with SMTP id
 71dfb90a1353d-4f4df63cf8bmr5275151e0c.3.1721282126073; Wed, 17 Jul 2024
 22:55:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717101028.579732070@linuxfoundation.org>
In-Reply-To: <20240717101028.579732070@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 18 Jul 2024 11:25:14 +0530
Message-ID: <CA+G9fYsLr185OmUiR0_BgKndR7_Z7D1Crrj1pxgP4uWiZbFEZw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/66] 4.19.318-rc3 review
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

On Wed, 17 Jul 2024 at 15:42, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.318 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Jul 2024 10:10:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.318-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 4.19.318-rc3
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 8b5720263ede6176702e42155a0e263cfa1f4dba
* git describe: v4.19.317-67-g8b5720263ede
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.317-67-g8b5720263ede

## Test Regressions (compared to v4.19.316-140-g485999dcb7d9)

## Metric Regressions (compared to v4.19.316-140-g485999dcb7d9)

## Test Fixes (compared to v4.19.316-140-g485999dcb7d9)

## Metric Fixes (compared to v4.19.316-140-g485999dcb7d9)

## Test result summary
total: 53301, pass: 47401, fail: 242, skip: 5621, xfail: 37

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


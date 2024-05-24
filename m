Return-Path: <linux-kernel+bounces-188747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 240BB8CE64D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C9CB2147C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 13:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C35E8528D;
	Fri, 24 May 2024 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQc++neL"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D023EDF
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558430; cv=none; b=hF9bp/mTiilEy6fzAP4L987NoY40/flWFerFqu9lyaOLN/2wB9tIR3jSUTyEAZUDK3kiG4wgO6FU+L/MbJPRo6vLpzw40tq0idmGnTg1ggQJAeF6vg/BqQB3QtG1ypJkjL3sJdlIEn6y0exqS5qo+iLUkNCINkQtPmmnufNGels=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558430; c=relaxed/simple;
	bh=J4jKhU2rB31y3MjXeQjXlJ26Ug7+zDBlfBWD4JhyTwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XR03nEjKbupqqEM3SXoUFqEvXpIk4D6LGK2URuZn2HqLBLmc2RM8et3weMC0n4eG2y81P4pYtwd3yVKk/PdCOvu41T0gpVpwFfJzUaloCAT+NtYoltvAIdI+VUnpmuqYt1QonCHWnAXeWCLzNxfXN119DHaBHUotdWk9THCMMxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQc++neL; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43e2bca05e8so42721391cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716558428; x=1717163228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1AdWBPJk5cBe/4Kv5WSEGIK67LQv5wPA9TlUppk5PQ=;
        b=DQc++neLPNuL/r5feGeDtEuCP6oyfxOqaG4ORWrKmk8e7ScBN3BQ9by5c2GXylZB3s
         uC0ZTOExyK4PEWim9l/C0WqhlLIBZsEqBHwzEFIefdSTnloq0YqTWUf1zarpye9XnSFF
         5gJ/5voXhdUwW+0PDT8dWA+ip2fY1zaW+94eiY6J8+NydV2Fdu5P5cQ7I05ONWmazeX1
         eqkwM6CZd4WdZChFi41sJu+1s5ZGDOJc6zeKwULClfQKt0F803Drf1ZJx4fB/uyK+MgV
         B/xLJZHQQKcekzLJePlnLwn0pRG+Ck60ncO+n+/qc1Vd8eTu9X9Xipf4TNC7m/78G5P8
         AUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716558428; x=1717163228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1AdWBPJk5cBe/4Kv5WSEGIK67LQv5wPA9TlUppk5PQ=;
        b=Yk/fbn9KBJDlic3DznYf4Dusn9DU5t0tmARc29/+KzZrYxXfm2dlULicP3i8n8+feO
         texjXx9dIZIgclDc03NlG5dTGnU8H81UQBGcdht00inqbeIWO0kuFQzo5L47lVLr081O
         iWPjzsvJBQHwiAKfw/o83DY38TgFTd4kMnOK4N7L9OxN3n/8tVCdE8cfbeBJz+myxi5t
         VymstnWz5dhBwEuuay1UUMBcBjPH3dqv6iGhKtdGcv27NNRJ9yx0U0wJdImKXEh+QfVT
         iwHegCT+OD/5CZYU+1ENWQll99HdN+EyFQrz/mGehdySpXPEi1ZLfoIEHAMaSXIluu+U
         /0JA==
X-Forwarded-Encrypted: i=1; AJvYcCWhCQT+/6M2/rH9ngAbSpQHim8RvSFkPRmMNajXZpVbF45VGIUF6nWLKhkiGjgc3pv4B52JTcJG6PVCxZLwzStLQ5L7Y+9jc3atRHLc
X-Gm-Message-State: AOJu0Yw0Vew56UrcwrvBXv+ksyfwvWLJdhFlA7Yz/BPQ8x9h2Mj+rhQG
	d4Xbj7SzhKxl54u4KFr1DbwfSe6DpwNqNwel7VlIro+J6PNu/RwDj3J74BUHuYml17a7omIAP12
	ZysKtJ43rpDjE4oxUUGwQGUQnUbvQxUrph/LnoQ==
X-Google-Smtp-Source: AGHT+IHogsSuuy+E3e3pnsuSrATsQOrGLSz4vi3QS2BdvkWUI2SzN070UwMpnAke8bJaN/PfoYBOKxmGy4L0+AdkHEg=
X-Received: by 2002:a05:6214:b33:b0:6ad:5f4b:d79b with SMTP id
 6a1803df08f44-6ad5f4bd983mr8922616d6.16.1716558427864; Fri, 24 May 2024
 06:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523130325.727602650@linuxfoundation.org>
In-Reply-To: <20240523130325.727602650@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 24 May 2024 15:46:56 +0200
Message-ID: <CADYN=9+vnu=a9ZbEXBvtW8OXs6L4xTqokLLDhMDrnjmE+dmqaw@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/18] 4.19.315-rc1 review
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

On Thu, 23 May 2024 at 15:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.315 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 25 May 2024 13:03:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.315-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build Summary
* arc: 10 total, 10 passed, 0 failed
* arm: 103 total, 97 passed, 6 failed
* arm64: 28 total, 23 passed, 5 failed
* i386: 16 total, 13 passed, 3 failed
* mips: 20 total, 20 passed, 0 failed
* parisc: 3 total, 0 passed, 3 failed
* powerpc: 24 total, 24 passed, 0 failed
* s390: 6 total, 6 passed, 0 failed
* sh: 10 total, 10 passed, 0 failed
* sparc: 6 total, 6 passed, 0 failed
* x86_64: 24 total, 19 passed, 5 failed

## Test suites summary
* boot
* kselftest-mm
* kselftest-net-forwarding
* kselftest-timens
* kselftest-user
* kselftest-zram
* kunit
* log-parser-boot
* log-parser-test
* ltp-cap_bounds
* ltp-commands
* ltp-containers
* ltp-controllers
* ltp-crypto
* ltp-cve
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
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


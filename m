Return-Path: <linux-kernel+bounces-325234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E46D97569B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3457B2845D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4CC1A4B84;
	Wed, 11 Sep 2024 15:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uyiycJaK"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD271A3A82
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067667; cv=none; b=eILweAHcpQ9Izs7u7HauY2iu/5NwdtkRNT3muaTbcDyYnvFKt3XRe1bfUUdY0AHdaj5YRLHVc8V8TRRtNJIU5cOjsZ2iHl+dBjSaAjF53BiC1pXMw4pCIR9sQnjZeYa5XTDI9kzzSS4hlUM4Q67+bVo6aZFuYjLx6MbX4/05Pmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067667; c=relaxed/simple;
	bh=hVLkjmjja4YumeOo/ICIYN89vr8whsE1fNmkNLzca3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrEyLtQsUwLeRCmrU6Yw2yyfoEOzSIpalb+utqE46wrAmP00YUkcYR4QvXmfNK722scXd4yXrN+llJfy6/irb4cM87EwV4CaVa8b3bCH49TLJNZW/PVT0aec20KA1bLrxJM7y//klJnMRIQqbuBaeQlrdsgoFOaYgrmgZUowJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uyiycJaK; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6c3552ce7faso9025386d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726067664; x=1726672464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B17khsdsB9SaA53nbjw65jnMre9SuZD0kxsnqYHyGOE=;
        b=uyiycJaKoda9wX8N8HzxkLCj+nnFoL3EBGes+U3MthxOEJD2yg5eASoUgUQ6mWbliz
         qT1KAK9FyQoh9yVMeBR1OOkbdAMf3wGcvy8JYVyQE2MR7CC8QbiUQHFyA7gU5MJlGted
         jWvhlJz+EK1GHMYO4+QDtuKk6nu85Rz14jlJF7X3Uuonlzq4S01zCcUjnDRmjNTBJtzN
         KaQEOYlh49OlEPnGxW77mGv1hc/TxFmJyxNBwoVQdt1M575OBAYypQactX0cT1fLnJT3
         TGAbm+LJtkpzgiC03K8kxhO0DoGp7Xsq/bkHMidH/WAc+00SzoYWM2wZKOwGPl64Vr5d
         i8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067664; x=1726672464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B17khsdsB9SaA53nbjw65jnMre9SuZD0kxsnqYHyGOE=;
        b=Bh4GJSIzrF/Zt1KzOsnWqH6e2SrUlapZPdX399BO5WcYK1q2+8WCeVs/hPPTbm5X/D
         6QEVzxiGcaQ6JxpIH2hwlFUeGBAHtMDVEzyn1S0ntsN762lY+i8N+Ubiu6kh1Yja0tTV
         fYAUaw87acceYZbqqCERpTjF52Fo6wk/jaLSfQRTCiFcOjiS9GvPdJqpN9+F/O2P9TBc
         nbjnSaVRMJZ41IKvYvPZfZE0yGoW8Xc/nhM2hFn/cqdrr/dsV0vX+lPAP4xsmpLud79o
         kUBySxeht5NjL0Rdf8uMhvWLqFnNecMGX2/PFQOZZJ7JiUtoW5e6y6NSJB9xm2QcaLRY
         RGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyc6p9KZOs7dftqTw++U9eEuzrpE96SrMMKUqSk4+7WLx0RHZ+Nb4GWnsimvfhtxPSsBi7WHrNwXNxjPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/kr5rDs59HGcgpnDEdFei41kM+KYu+8jcviPxQ19pzToani/R
	Rgriyr78KUvXC9Qceze+QFGE1fbk7ucqU+BYJleM5SDdR2Nw6qbJ2UV4nn/ewTxnhYNkj/+zRIu
	pZmG7E7+N7nwmvp9VhwzeCnapMzDLcytzOh8Y8g==
X-Google-Smtp-Source: AGHT+IE2sHotIw+W2O/DHyuHZFvH0buTU9s1JRa1Paz60QZm9n1B6kBUw9FGxmBeVDuFcCLNuFiuNnN9P0Ao4E4ynKw=
X-Received: by 2002:ad4:5dc6:0:b0:6c4:d2f9:644e with SMTP id
 6a1803df08f44-6c554d43f77mr112593956d6.12.1726067664557; Wed, 11 Sep 2024
 08:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910094253.246228054@linuxfoundation.org>
In-Reply-To: <20240910094253.246228054@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 11 Sep 2024 20:44:13 +0530
Message-ID: <CA+G9fYtxOA7Ee1omhLT-fMaaBPqNEZQYVHXovLtGgv9jbuxQLA@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/95] 4.19.322-rc2 review
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

On Tue, 10 Sept 2024 at 16:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.322 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:42:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.322-rc2.gz
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
* kernel: 4.19.322-rc2
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: 00a71bfa9b89c96b41773efee1cca378cc1fa5e6
* git describe: v4.19.321-96-g00a71bfa9b89
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19=
.321-96-g00a71bfa9b89

## Test Regressions (compared to v4.19.320-99-g0cc44dd838a6)

## Metric Regressions (compared to v4.19.320-99-g0cc44dd838a6)

## Test Fixes (compared to v4.19.320-99-g0cc44dd838a6)

## Metric Fixes (compared to v4.19.320-99-g0cc44dd838a6)

## Test result summary
total: 116497, pass: 103587, fail: 542, skip: 12283, xfail: 85

## Build Summary
* arc: 20 total, 20 passed, 0 failed
* arm: 204 total, 192 passed, 12 failed
* arm64: 54 total, 44 passed, 10 failed
* i386: 30 total, 24 passed, 6 failed
* mips: 40 total, 40 passed, 0 failed
* parisc: 6 total, 0 passed, 6 failed
* powerpc: 48 total, 48 passed, 0 failed
* s390: 12 total, 12 passed, 0 failed
* sh: 20 total, 20 passed, 0 failed
* sparc: 12 total, 12 passed, 0 failed
* x86_64: 46 total, 36 passed, 10 failed

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
* ltp-syscalls
* ltp-tracing
* rcutorture

--
Linaro LKFT
https://lkft.linaro.org


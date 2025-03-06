Return-Path: <linux-kernel+bounces-548891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BEDA54A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70D03A0522
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C120ADEE;
	Thu,  6 Mar 2025 12:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lhZooeJG"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9451853
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263731; cv=none; b=PEEZlbH2dYUA/xmQsQvHwOj0Cfnej8uGI2d70gx7wRB/7EiR2XiXM742jFHl/klPCc2ADC90Mxgz/PMSPJhZFut3PNdt+J4uXTPh8cluBdruDoKMoZOXUe2PVg0b4Ka93tRVpsARwUO4lM45AncjfdSBb5TarWq99o6Rp57lHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263731; c=relaxed/simple;
	bh=8WpiNtP4SUsV2btOYYsU6TNjuaweKXpboF/a4bcaaGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jn91OIULtm6xXYGM4UaZ6L2NJoJIf5Fp2S8FnLkMAwLsEsifCTK4Z63BSJ3DAJAQOzPPl6ozi1aXUmMJF3GEbllz5wWs7OX9ejfcj3hYjYd5HNev1MPINhuP1f1BmrvdzD7xU0pteDH73VIDF9Od0sLpmINCSJLXRWaIavgsGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lhZooeJG; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523c67dba31so247730e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741263729; x=1741868529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NMaFzP48YFinEhiZrVchmGEvLHB/ao+cnP7Dht42RRM=;
        b=lhZooeJGKHcWX2pgKIrhdsCMV/xzmLFp4cdRGNcr7F5lsq6bGufTMT+029mcA6zmA/
         sS0Dhw+3hXO7lJu4Nk8YOujzswLtrFVJEq8z5DzE9EpDZMSRpS21VJx/WLhrD1aHcLu6
         HUnNTBTyqhzcW0hitGyqb0BJqAEWExi8WiE1ZVKxZAbjyNlscXlv8FeQg2ABysM2wqOI
         SAMtWD+cwBzaeQuN9I9bJ84tyqOBGWRv0fyBzXJ4LOd6n9QbzYipcITRoxxrF3EdKWfx
         aNodIWdmKxEx5JMIUyQ7q5KIOo2QOK6nICF2dFcW1ECS3zjdr99C423yi8eUElK+FRfE
         vktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741263729; x=1741868529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NMaFzP48YFinEhiZrVchmGEvLHB/ao+cnP7Dht42RRM=;
        b=adIEoI8VcmUbjqty6xSgBDvC1S8VsthKtFf6+XXYgDehz9Bxl3P/o+KYNKd1zace6H
         FV2a6PvYZNaf8Frw+RvrUBT59qMKRb1EHaB6rUbuy2MiZXMHtAHcyJz21xoB4tCVgXO2
         VS/z7MX0eTJ+/NBwDkDvVG/RXwJ9yoJA7Zm82c4703uDAjhEHk12QYeHwHFM/kHKloFX
         txq1MebOSeV4fm5AAVfGu01xSkdn0N6DNOROeQYfuCuCepMij50o/1JWPgoozaB+0Rxt
         /+5iWZGLe8TeoI38nb8TNTLFChKCDwF3wnLYE8vCbNnOXJIUvz/wCpVrAJ8nNf+teAiB
         gC/g==
X-Forwarded-Encrypted: i=1; AJvYcCUkRlLFqEHcAmQOo24Pbm5w1rCKbzCRmUbTmfd5mah6hmn3k6EMMvNuKGFO9qozLzJkMjrqMaVuXwCz6iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/9aJWdxa9QPuGGFiyf2s/skzisTVw+qyzpEPMpJxOwsil2Dc
	XoJVcT2B/Du0jE2z5pX8T5dfnokdKcXfVuZQPZhxle0KQPgEfX2poJxDnBjoEKqWMVAHZzgg6qz
	PSJZv9cqfKgWEt5U/IcGa142cj5NBCEXHWVvCvg==
X-Gm-Gg: ASbGncvaTy0T2YrQWu8z9ubyFMIhOOhNHb1vQFehP1If+9WhmoKtc5VLCiF508cSTOU
	rdTzt6mcx5+IBxkCInmh4OMhkzUROZGKjlJzD+aKzs2cYY4m4A+eMvt+G9+Cps+5uEMUBTiVB+N
	6kW0+hRKThY0eH5TijZTJig5lAkbTWcj6p/9iv16plok7eUiGo8AF1r50enA==
X-Google-Smtp-Source: AGHT+IFYww1kZHMpxt5rfe7etSrcj4Kd67QgSomHrhxf7n7GkfeEsvd0m/xOfmDxwX0pwVAOrU/zMPkV6Cfa8MEglrY=
X-Received: by 2002:a05:6122:d21:b0:520:5185:1c31 with SMTP id
 71dfb90a1353d-523c6281025mr4217547e0c.9.1741263728875; Thu, 06 Mar 2025
 04:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305174505.268725418@linuxfoundation.org>
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Mar 2025 17:51:55 +0530
X-Gm-Features: AQ5f1JoHOMnMdoj85LLhhqMa2z8QuDprDq4v5xGuh6PRQjSvUsaQu0qsUl8-2Ow
Message-ID: <CA+G9fYv9CcsWEywck9qivOVtThrmr9UUiu-RdPnrjVs9k5JxTA@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/157] 6.13.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Ryan Roberts <ryan.roberts@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 23:44, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.6 release.
> There are 157 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 07 Mar 2025 17:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm64 the defconfig builds failed with clang-20 and gcc-13
the stable-rc d 6.13.6-rc1 and 6.12.18-rc1.

First seen on the 6.13.6-rc1
 Good: v6.13.3
 Bad: 6.13.6-rc1

* arm64, build
  - clang-20-defconfig
  - clang-nightly-defconfig
  - gcc-13-defconfig
  - gcc-8-defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

This commit is causing build regressions,
  arm64: hugetlb: Fix huge_ptep_get_and_clear() for non-present ptes
  commit 49c87f7677746f3c5bd16c81b23700bb6b88bfd4 upstream.

Build regression: arm64 hugetlbpage.c undeclared identifier 'sz'
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/arm64/mm/hugetlbpage.c:397:28: error: use of undeclared identifier 'sz'
  397 |         ncontig = num_contig_ptes(sz, &pgsize);
      |                                   ^
1 error generated.

## Source
* Kernel version: 6.13.6-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 30be4aa8b95762886fc27cf2a9931e14bce269d4
* Git describe: v6.13.3-555-g30be4aa8b957
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.3-555-g30be4aa8b957

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.3-555-g30be4aa8b957/testrun/27516541/suite/build/test/clang-20-defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.3-555-g30be4aa8b957/testrun/27516541/suite/build/test/clang-20-defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13.3-555-g30be4aa8b957/testrun/27516541/suite/build/test/clang-20-defconfig/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuRCFN4wc8W1MqNki1qddcwCF3/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2tuRCFN4wc8W1MqNki1qddcwCF3/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm64 --toolchain clang-20
--kconfig defconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org


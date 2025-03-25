Return-Path: <linux-kernel+bounces-575596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD61A7049A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 234E31888BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51E13D8A0;
	Tue, 25 Mar 2025 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lJ2c7OP2"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090825A33A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915276; cv=none; b=UPP6GOQPFt6hYgQuVAR7+sxoPbgsdKW/j8bHt3qPSpoawCHK1/y2N5HiFs1J6C0bQR6FM9nzSF4kQ62/Jz7yh+Crd0tBWBSszL5nimEfKoj3WmX8k5jxPsz6oY/5EcYlbgNgdY3Q8VxNmcYR/srAULJBvXibBsEPfBl2VvbZcfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915276; c=relaxed/simple;
	bh=iSmodtdY7Dchcz1A/sUPS+H3SHiLLQyywM4beAv33u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsLDRRufoO/MHCf/Ojj9WSopsZ5KQMVhzu8VJ/PQov4Pf26joxh0YcFQSI6/H4B8Ljvx9S3oFgfqG65DZTV1CoPnmF/jGMOWToaCjtehG5DBYuWOGFx2MEBZBusuqyMqhMBgXdzPjlp5ZFTpO/+jwgiu2rBlEkkssbuGaACTLeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lJ2c7OP2; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523f19d39d3so2756311e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742915274; x=1743520074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ASRZZn4DjAVCiGVwyErb4eVcqvprss3kx2mpnoqQ/Aw=;
        b=lJ2c7OP2ctgy0sc4pykNStYO3q/NHZCwjiKUv8QE7ho11GEihMp+VE05S2NYUJmUJb
         jM4U3gtcEogTOOSekGOjc5BlpmuF47WJqVR9d3r/9HeJgxW+yap4dEDtdMcoD766bCD9
         kF0R5PjdemnYDPc6/fKm4++DrneK0PHlcs6BKRwu03DEDVONg9l/QK0nk/No1op2BaM9
         Owfget9il+fzpy3iTpkw4x35Lnz12id8pVHkNnkvp34+ftBAX9kK27njAfra5KRjfaGY
         V+EQbo72jEYebQHN2MpsRL8UuiHMKgzPFTWMPBmdN9Hykk6lhmXxdcEl3xCMUZ42cosM
         pjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742915274; x=1743520074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASRZZn4DjAVCiGVwyErb4eVcqvprss3kx2mpnoqQ/Aw=;
        b=FFOY6JyvDz427gc+8HKBqiMayNhCJ/k5rOVX+pybptwHEOgfyhirii4oF95zi/cbLa
         ppoG+DduhRYaRwWtruIP/6ng8HCQCW2Cuj7mMH0r2a56NAucF2NrgmA6OaRhoaSqlWCS
         OGh1r3a7gb7TCYqZLmsE8/I1nc1OHOetOwuCA0Bzx1dquNYKqlFn3PwcHirJL4HGCG6B
         ikmXK6+/o7UQ2ntYKn0PSvpeT0lBCOSPWVqq2MrG+Cr81uD2zimA/AmJT/+RYeGuCZQx
         w448Wzfffsfruz7TGMicUAo/DoqC0h6LbNr4Ymm3+hreyuY/xlQgH6d1iYCvtW3XpoCF
         3q6A==
X-Forwarded-Encrypted: i=1; AJvYcCWPBd0KlWKtSHOsmvWU7YhotY6pVkDOHVpoA/0f79vyF3uNAmQqiS8CVqJwJ/m07BmpJvRjlIgROQBw/Us=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx7J/OnVCwMAgPJVIHHD8Tqv+Lms4FtoE+4Iaa97pkW5XHTeCB
	DVvweUwunxrfQsJOjV62/Wsblr7W89DUMMMEe9SqbYixWIfzWz0HHUSBcerJ/ek5BvuRFZ0Hoqu
	At40KKbwWI2w27zNpuLG9Xlx0jUQk5bOHxychxA==
X-Gm-Gg: ASbGncsXJZK48dyYHUxA45FvJFgWB2bSfZb/QkceYT0FQjeHTYpDzeXaqAGslc6TpDO
	0+a2aVEidFdOeMmeduVdvmBSvbUa9w7HBQbZQI872DKtH/yGzpd9lDNrpuimVqTIts4Ik7egM2O
	EsQmEicQv/B9iJ9QB8XR8XS/qyH5cVNfvCNwZxZar+ioibpP4klUjh+fHyz1E=
X-Google-Smtp-Source: AGHT+IGJxNNn58Pr6BXkc8yTC7dt3Dz8oYa2jVHYnOw8DdFwyMT+9nGnrZ/TQ+Sepc3obyBo9xvaY36PFzfQAXxFVmo=
X-Received: by 2002:a05:6122:2810:b0:520:60c2:3fb with SMTP id
 71dfb90a1353d-525a80d5eb4mr10912049e0c.0.1742915273945; Tue, 25 Mar 2025
 08:07:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325122144.259256924@linuxfoundation.org>
In-Reply-To: <20250325122144.259256924@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Mar 2025 20:37:42 +0530
X-Gm-Features: AQ5f1Jo5lbttZtSAb6LnZgDq3AuZotqFT2rixgG9lx0L7Z-hkj4vcw5915tDF-M
Message-ID: <CA+G9fYvWau1nC8wmpWkxG8gWPaRMP9pbkh2eNsAZoUMeRPgzqA@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/77] 6.6.85-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 18:05, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.85 release.
> There are 77 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Mar 2025 12:21:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.85-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regressions on arm64 rk3399 dtb builds failed with gcc-13 the
stable-rc 6.6.85-rc1

First seen on the v6.6.83-245-gc1fb5424adea
 Good: v6.6.84
 Bad: 6.6.85-rc1

* arm64, build
  - gcc-13-defconfig

Regression Analysis:
 - New regression? yes
 - Reproducibility? Yes


Build regression: arm64 dtb rockchip non-existent node or label "vcca_0v9"
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/arm64/boot/dts/rockchip/rk3399.dtsi:221.23-266.4: ERROR
(phandle_references):
/pcie@f8000000: Reference to non-existent node or label "vcca_0v9"

  also defined at arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi:659.8-669.3

## Source
* Kernel version: 6.6.85-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: c1fb5424adea53e3a4d8b2018c5e974f7772af29
* Git describe: v6.6.83-245-gc1fb5424adea
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-245-gc1fb5424adea/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-245-gc1fb5424adea/testrun/27760755/suite/build/test/gcc-13-defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-245-gc1fb5424adea/testrun/27763720/suite/build/test/gcc-13-defconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.83-245-gc1fb5424adea/testrun/27760755/suite/build/test/gcc-13-defconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoHmBcVLd60GQ0SVHWAaZRZfNd/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2uoHmBcVLd60GQ0SVHWAaZRZfNd/config

## Steps to reproduce
 - # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig


--
Linaro LKFT
https://lkft.linaro.org


Return-Path: <linux-kernel+bounces-254436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B990593332C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744C72868D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7EA55884;
	Tue, 16 Jul 2024 20:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EhHa27QI"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469D55893
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163463; cv=none; b=cJsHGU3O6cXX2vKto0YO514UzyNt7fgPClghtMB0Zm32qHMqIMwitMALeLUZIwKN4tNCnk/KUH9gnZdbbQskZ9Qjo5+wOPPVlDsokzIg0VHiLLxNdew2iXPCMNJ7CvT6h4Mvx0EPhCjChMAaxOB8l8sorxQ2izbm8Y2x0hqtVAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163463; c=relaxed/simple;
	bh=JM0oRMdWBUMRn+0LSClZewRtkAE+Dxhx3Y9s7tfEy7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhpMrTSNYe3OJJHpymX3xX8pY6Od4fOLN3F+dBU1ZmcB5p8/h6wcPCGb06vZF0yLwc3on+/ANKeNYUHSTOy4klyJaR3hzxfpc4jBvpeYnqi7yTc6ZgLfmR6BXnve8v4LGUJMgjdsTkn+PjS2d3kpnPhnuDzZnGlj2H6MwvAg5Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EhHa27QI; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38028so7656561a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721163460; x=1721768260; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kUDuJF3m+GLPOXJ4XX+YSbr7/KroHvma3vr0cCZSPE8=;
        b=EhHa27QIdrs62bhBhDEDfrVsh7YRv9lS3xU/riLKgBipN1lxGRDcl8RJOGpD24BKyi
         mUoesxLZ0YIERg9EKZxqjLe5TWOsA5sFDsmook1yOBINzA7zAuhQE8wHp6IlVqiqTR5H
         IPXcbwLZw5+JpCrWkJ9/SYOQP+R2cfNkZNuvfmQpCcILttJJLNJZcCGnnz2q/sxg5DYx
         C3ol+R6bF4K83p/CyVq4xDcYZRQkeN+TndI8Ekk8YLgUzc5CplO2w0G5XkOby2JkBJEG
         4gbXKu9hcLXmABpgN0jmaUHXhsfGbln77dnVUFyJRB38haiN5+c8F1HRhp1VWS7vBXIV
         T2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721163460; x=1721768260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kUDuJF3m+GLPOXJ4XX+YSbr7/KroHvma3vr0cCZSPE8=;
        b=Hj1JQpsCHJBorAd7WI31kwYczwcIesvUdy7wDW91vUDKMJUBI5rDGO3RLpEfCDtAJs
         QnCUPl5dfY+iVUks2dUz+5wPedn5pN2bcTBxIPkbB499ZCB45Sqiavy2goLwfKN+pkyl
         eppEKVliCnfWVlhqDMfR6ja0byDbUEOBdCY6cI9pkkD6w4FWmStJxXkxrA9Kb4YfCce/
         56Wpt13oz+d9ffGGlOCfDMfrv57j8y0oDtmJ9JwrbeaPQ0Mdhmp+IegTyMGEHMo3AHSC
         +Gb47hvig4TbOOsjWgWTOExsNQJUpTbxLYrKI6WcR2Nx9F/UtysG/4BmoAV4m+A6FO6h
         Au7g==
X-Forwarded-Encrypted: i=1; AJvYcCVe2Oad06LFbkW09TIgX7lKGnCpFSG+x2pghIEbpBDxANOABb+Ga5YOrgsJbm8UJNh97EZpT3qYF2AOqBHISJIL8dErMqISccZiH9U1
X-Gm-Message-State: AOJu0YzJn06Ei4gFpJCp27I/yhPNdcvA03Imgram3ELb4+pzm2mccukC
	mxlx9Pgmndhmv6A87S+92p41muO5wIpSCWGZz6Frba78Wgam4TAzo2Co0vkCXbAm0RfR5u9Z6Zg
	lKrj73e/pu0R0LAD9OrW3jG8VAitRSv/cAhGf5g==
X-Google-Smtp-Source: AGHT+IGLZtJwgI1nygx1kF8oyAQhYuN/8m//WR987LuP4jm9fUk6c3m8+vXujyaR4jrSfMvB3zXKs6whSRV5URlbOJo=
X-Received: by 2002:a05:6402:3552:b0:59a:ac4c:9231 with SMTP id
 4fb4d7f45d1cf-59eefeae425mr2231802a12.29.1721163459651; Tue, 16 Jul 2024
 13:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152740.626160410@linuxfoundation.org>
In-Reply-To: <20240716152740.626160410@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 02:27:26 +0530
Message-ID: <CA+G9fYtJwjRPsomCFehVXyw27S1f9Uq6H1ZvH573ekakj7Mdng@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/78] 5.4.280-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.280 release.
> There are 78 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.280-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The 390 builds failed on stable-rc 5.10.222-rc1 review; it has been
reported on 6.6, 6.1, 5.15, 5.10 and now on 5.4.

Started from this round of stable rc on 5.4.280-rc1.

  Good:eee0f6627f74 ("Linux 5.4.279-rc2")
  BAD: 51945679d212 ("Linux 5.4.280-rc1")

* s390, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-defconfig
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-------

arch/s390/include/asm/processor.h: In function '__load_psw_mask':
arch/s390/include/asm/processor.h:259:19: error: expected '=', ',',
';', 'asm' or '__attribute__' before '__uninitialized'
  259 |         psw_t psw __uninitialized;
      |                   ^~~~~~~~~~~~~~~
arch/s390/include/asm/processor.h:259:19: error: '__uninitialized'
undeclared (first use in this function); did you mean
'uninitialized_var'?
  259 |         psw_t psw __uninitialized;
      |                   ^~~~~~~~~~~~~~~
      |                   uninitialized_var
arch/s390/include/asm/processor.h:259:19: note: each undeclared
identifier is reported only once for each function it appears in
arch/s390/include/asm/processor.h:260:9: warning: ISO C90 forbids
mixed declarations and code [-Wdeclaration-after-statement]
  260 |         unsigned long addr;
      |         ^~~~~~~~
arch/s390/include/asm/processor.h:262:9: error: 'psw' undeclared
(first use in this function); did you mean 'psw_t'?
  262 |         psw.mask = mask;
      |         ^~~
      |         psw_t


metadata:
-----
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jKrMGFV9tK3IYnSE2ntEa22g0J/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jKrMGFV9tK3IYnSE2ntEa22g0J/
  git_describe: v5.4.279-79-g51945679d212
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 51945679d212aae61a418eff41370c13da94f94d
  git_short_log: 51945679d212 ("Linux 5.4.280-rc1")
  arch: s390
  toolchain: gcc-12 and clang

Steps to reproduce:
----------
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org


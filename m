Return-Path: <linux-kernel+bounces-240012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6079267E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F49B24C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC92187543;
	Wed,  3 Jul 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GRCidM4S"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BC218628C
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 18:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720030329; cv=none; b=DUNe+hm6PQjFxyoUe5uu4uf7/aHV+dgwoY7zp/fB19EYFUZfOUgsTitNd2xnNi+caEsiAJX0EXpgDIoGEllVTW48IofNyOMC21A5vCqz7Aofsxr4v9Ga8xzsA6wbrsPvhJ0OIlC3NdL4zABr9ZRUH6CHTAHvfG6Xyx5aFnTMdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720030329; c=relaxed/simple;
	bh=fPhCmgnaiDZl2A6WXQkFrJg4shudkED3sjVTlU32HrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFIKTRMuCg+jOVtvHokcopC3IDRLEp2SHNP9KTU4rn8TOV1ub3PyMEWU0uv0zXw5Kd7Suu+pUeL6kJMF5cW58NweTCswS5ZAMDe/P6IZUaNfx3Y/jLe4CmBV0ocVvHkpF1X/A/TsMjM3L1foNuRmTRiWVQYSV/kWI5dRzvrWj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GRCidM4S; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-48fdb95421bso505343137.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720030326; x=1720635126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mr6GiDtRMzhlcU7TEUxy1mdYCuFY8dTCGfwcOk7GP/c=;
        b=GRCidM4SeL7pYPlPyfabz/S6snuxq8hRjBBi8aHFy4JrXWcjOiRvUgctFLSzR5yEtv
         w1b2YuMUlYjJ3/fvx2oAsiSkzOMftpU61bt1vFkdER8z7H2+J81mgYNiS9eI287dk6mJ
         2FPrumA7VOWtdq4O94kYmRJsnskJfuOSIFv9eVIvdgZBjtHnopLshbmuoXbS8iH7/40Q
         dNDQHHIP+9l1v4H5wpHktVjP6gknhMWTp9Sd1DJif3Kgzir96ccWc/TV+Cb2gXgd/YJn
         787T4U1plp4RuEaM1S1PSyZkEzKjuItdl1w2US01DwEYlnlClWJpS7+rNXSaEqR/EQFi
         xraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720030326; x=1720635126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mr6GiDtRMzhlcU7TEUxy1mdYCuFY8dTCGfwcOk7GP/c=;
        b=s1fZuDbD8i8n69N6d9D4Rg/6uHibE8FkBrdBht8RUshGnQd2v99btb4gaRb3Oj+awm
         lNTYSupPcwHMUqctYax8vXSc9mBI6FPeUXOjOEvjMIumShQJj46S5K5WpaNZ/1MFo9ww
         XNFJFgkbLv5/r9+wyqNkG2UPbXgXVzrLUGrO1d57Un00mEbdkUdJNtqzPRtVGh/3IsYe
         wxZ3nrFifv7tR2F3zZfey9xZsfvW2zMn51HMjVG3uM7FtGnz/6yRAIDCAYGyT8pomp3w
         jTyNdW37fidtBhQI3IcrhW3p+USz6qEANvRG5TYIGuhdLG9JkWR1HYY3RcAGdaEfDGFy
         9uXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHNVT6PULcyEguf/AQitRuBo5CDg5v6u9uuPTN0l7+KXv2/NGe90IKgJ0n2np4oq0txpbLptvhSzPM32x1u6Mkrw/4tOtF09N7B4Fx
X-Gm-Message-State: AOJu0Yy7pxILJ0Pplp7RaM3D7Jzt6ullQRel8EXJSXNlnS8CeYn3phRY
	Y8kZWVNdKSJE4HtvaVVflW+1/pxFgFgU5QXK9USrMlZms7H4dTMcRz1F7ddbtEmAmBASJy4LcNl
	d91EghqxrsU/r9k//G59GCmSFUjEM6HAIbNX//Q==
X-Google-Smtp-Source: AGHT+IGGt6bUpa80iJhaddgtZTkRvaBxVD+WY5qQ+Y/sKswvE4heTrLyOi9GRMVgEOs9n0cRyAzD/Roo17eqbs8PbQ4=
X-Received: by 2002:a67:f2d8:0:b0:48f:a858:2b54 with SMTP id
 ada2fe7eead31-48faf140919mr13826176137.26.1720030325982; Wed, 03 Jul 2024
 11:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703102904.170852981@linuxfoundation.org>
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 23:41:54 +0530
Message-ID: <CA+G9fYu8dpsNyqPk53wyq1ZTKmCJ3gUb6JBjH3OM9p2pqL_E-A@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/290] 5.10.221-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 16:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.221 release.
> There are 290 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jul 2024 10:28:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.221-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 builds failed on stable-rc 5.10.221-rc1 due to following build
warnings / errors. These errors were also noticed on stable-rc 5.4.279-rc1.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on s390:

  - gcc-12-defconfig
  - clang-18-defconfig
  - gcc-8-defconfig-fe40093d


Build log:
------
arch/s390/include/asm/cpacf.h: In function 'cpacf_km':
arch/s390/include/asm/cpacf.h:320:29: error: storage size of 'd' isn't known
  320 |         union register_pair d, s;
      |                             ^
arch/s390/include/asm/cpacf.h:320:32: error: storage size of 's' isn't known
  320 |         union register_pair d, s;
      |                                ^
arch/s390/include/asm/cpacf.h:320:32: warning: unused variable 's'
[-Wunused-variable]
arch/s390/include/asm/cpacf.h:320:29: warning: unused variable 'd'
[-Wunused-variable]
  320 |         union register_pair d, s;
      |                             ^               ^

Build log link,
 [1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.220-291-g4d0fada143ed/testrun/24509787/suite/build/test/gcc-12-defconfig/log


Build config url:
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ijXjGemFUwKSWd98LvKtd4i3uF/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ijXjGemFUwKSWd98LvKtd4i3uF/

metadata:
  git_describe: v5.10.220-291-g4d0fada143ed
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_short_log: 4d0fada143ed ("Linux 5.10.221-rc1")
  toolchain: gcc-12
  arch: s390

--
Linaro LKFT
https://lkft.linaro.org


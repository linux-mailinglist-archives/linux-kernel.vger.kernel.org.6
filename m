Return-Path: <linux-kernel+bounces-365394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB5899E1B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D422854F1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D661CF296;
	Tue, 15 Oct 2024 08:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M4HXCAQ7"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175418A6A8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982427; cv=none; b=vA2yuAHlF53k+g4Vl7W4Pe3vJLqNOUpAHMo0wk5yYFNHAtt1Z524ZNduRx9l6vtNrQqA6EdWh4T8iHNbSe1X+riLM3ojVdbkwoSgc34vC3SzAKVP8B/2NBHWfYuhJsW9mKG9xuT+2CfQ+ZKK9D/2oK2Zy3pKVtZMe326qZcWA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982427; c=relaxed/simple;
	bh=mGonrEb1BPUx4D9j4VoLPoRRMOa9lPSnwGc8RZ4M4wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGDOHbsnP05IeQHzCaPfHAvMOSXMwPtHtBxxCBM3DMVCiEruDzHkYXl/vlQ0/8yogCjHsAqCKU45HSgvLamz7bQK4spOuYN6Gei+bXZdosG+X1muibQE7JhExzyAHGpBDfvNjjhHjONwjvm0ZHhdqj4EQPkeg4Mmw4BOqOvIzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M4HXCAQ7; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-50d494ac189so789060e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728982424; x=1729587224; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xxR65U6vScytg2kv+c/PJeOMb0nLoNUa0TL3Lk+ySjQ=;
        b=M4HXCAQ7PrDoVp1CYTk8Gfra/EnxIy2z+WTzoyR8DTMH/h2RjD2hAJr2bbd0VXasNy
         iCGYAEa4iERwfQ7ZUExRwyiIYwpT4qWkzW2oxNR5cmyh12t3YJeLKbHvPkQwupkc96ap
         VvPYgB6ae71H1UXJaYJXOQn40Lv9t4X/wZydRjceURiAw27m9MLFE9khlnS2g4DKvbpz
         wnITuPNQbjrSpV0q7X/Q19AkfwkiSWy0bF83nAD4n6Jkf7cVDvmRQTjagKg2eXpbnVn/
         o0Cl+GfuvuIsiARKLA3wQdMRMW2xRPl6DnnBRPth3s0X+jUXhcGgKlUoI41+pZD4saFV
         /55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728982424; x=1729587224;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxR65U6vScytg2kv+c/PJeOMb0nLoNUa0TL3Lk+ySjQ=;
        b=WoBV9N6dpbztmGXJRTA/KFH15/5UpYgIf/xeMfri79jfWs87F7jGgluRdXreTOUoxj
         JEmK7SXihaIypADTY5wKc8YggHPyabQ24NlvisPH+tcxXoHzmr5SkVJQPowECLN/WTGj
         DoPnrETF3Y1SCpZTDTIZmXcerbhfPkgYgbWISfN/KRVsezJmaYP5l4bhHt4akW9FEnWq
         yqXFBfgPxbIbh3BFkwa0ZBmZU6rhZxGih5ZAJAyjra5nTri2upuYEf4xvUzBI0Cupuew
         9+w4QOAPvuQGbo7SiNSP+hIB8ZB2PlU1jZRCNmwfAIXv6Ggq+7FYY3BPMUoyMHuR5uzt
         4uFA==
X-Forwarded-Encrypted: i=1; AJvYcCWJOXy/hGIWZGKF41qESJWGPn9z8ANDbC0DRnhWrmeBRisT8UyGqjbk9X34hi1tp84qVX5IbOW6DffjClo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBwge3KJOvLy9n6phRTLaNWed6Prgfx2l2TIgACiIEICISNkl
	T23rEHYZk86OTOQKlW+x3kUEVsrJTJZqSF3U51YpGAVx3f0fIeCU4C91QICSIeiKRo5UXS4coHB
	nVWjRw8QlbCtQrey75QZj+vkLiWMEOT7ZtH1fVw==
X-Google-Smtp-Source: AGHT+IHYT/lHJ/KmvqL7SaqGdoczqsfadmaNNg8dY7DEGsvtTmxYpiRRMNBoaPAsZOUeM9hrJ0Cis2z02a5DwvTJsUI=
X-Received: by 2002:a05:6122:209f:b0:50d:35d9:ad5a with SMTP id
 71dfb90a1353d-50d35d9b726mr6394442e0c.5.1728982423743; Tue, 15 Oct 2024
 01:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014141217.941104064@linuxfoundation.org>
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Oct 2024 14:23:32 +0530
Message-ID: <CA+G9fYuaZVQL_h1BYX4LajoMgUzZxJUH5ipdyO_4k36F62Z5DA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/798] 6.1.113-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, linux-s390@vger.kernel.org, 
	Sven Schnelle <svens@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 20:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.113 release.
> There are 798 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.113-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The S390 build broke on the stable-rc linux-6.1.y branch due to
following build warnings / errors.

First seen on v6.1.112-799-gc060104c065d
  GOOD: v6.1.112
  BAD: v6.1.112-799-gc060104c065d

List of regressions,
* s390, build
  - clang-19-allnoconfig
  - clang-19-defconfig
  - clang-19-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-13-allmodconfig
  - gcc-13-allnoconfig
  - gcc-13-defconfig
  - gcc-13-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The bisection pointing to,
  73e9443b9ea8d5a1b9b87c4988acc3daae363832
  s390/traps: Handle early warnings gracefully
    [ Upstream commit 3c4d0ae0671827f4b536cc2d26f8b9c54584ccc5 ]


Build log:
-------
arch/s390/kernel/early.c: In function '__do_early_pgm_check':
arch/s390/kernel/early.c:154:30: error: implicit declaration of
function 'get_lowcore'; did you mean 'S390_lowcore'?
[-Werror=implicit-function-declaration]
  154 |         struct lowcore *lc = get_lowcore();
      |                              ^~~~~~~~~~~
      |                              S390_lowcore
arch/s390/kernel/early.c:154:30: warning: initialization of 'struct
lowcore *' from 'int' makes pointer from integer without a cast
[-Wint-conversion]
cc1: some warnings being treated as errors


Build log link:
---------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwhZnhhAGtyIv600SDYdtypnI/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.112-799-gc060104c065d/testrun/25432580/suite/build/test/gcc-13-defconfig/log

metadata:
----
  git describe: v6.1.112-799-gc060104c065d
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: c060104c065dc2884e301155e32dd955e6bb45b5
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwhZnhhAGtyIv600SDYdtypnI/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwhZnhhAGtyIv600SDYdtypnI/
  toolchain: clang-19 and gcc-13
  config: defconfig
  arch: S390

Steps to reproduce:
-------
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org


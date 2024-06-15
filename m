Return-Path: <linux-kernel+bounces-215832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F9E9097A9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 12:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC95BB2208B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09540376E1;
	Sat, 15 Jun 2024 10:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="swKFqJR4"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933710A11
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718447598; cv=none; b=FfLaNBti8dMi3G2y17k+cKcemNim89qwx5uGn/fjljq6PjawCscwKsB/kr0KP9lGSYeC25ruTd5mdRYAedsFwQsoWgYwg0e+uRyXDFr5WUwqxmoPorO2/OMdfF4ABxpYbDFRlxL8LhZVADdIdWnBt5nc4OwFKfzJOmNHgWK7bYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718447598; c=relaxed/simple;
	bh=EU1gnY2BkWspVSzX6qx6GxRxGvIBOpUKnTm4qkB7WvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzTVUSfldpMTpod4ctfVBga/Y+/MU2dTljFcP8NkLiKoueBpQ5o6isVuxz2gRSuUB/myt6rb5IZEmAW0R61URf6w1BcfC8phR8/Op5ZK3P48MXJNozEKzc8Q7vcDXHm3gyi+S3+QmedjIjvAS2mKxR5JM1H6UL6XSZgQgN0FUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=swKFqJR4; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4ecf11aa0d6so889704e0c.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 03:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718447595; x=1719052395; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kNhxJ8lsLsKUcd80cpqGpDxPPP4z5jSyvizVwaYRNvI=;
        b=swKFqJR4cbu4XNsL6lxAvv85OaNqkkV/KRiBEIIOrqySuHqLXGKwaBpwD2Mh7GtTsD
         plGGaIHsOEHsvTu1r+8WIEJZiDdxL+GXr8iCeUXdfCmrTcB6e4+OyuWP+gEee2ds1Dd8
         PEn6ZSPlPZfZuSzQbieEkFVOJMc7rYcUSztkiRjKLgqPYBDtR+cF9JWCz34xg/VdCsvF
         SaT0PUukbFFKn+8xCQwlVz0abGpj4r8WFx/k2LNeAwz0FAeHUo55wkBXQ4swCC7dvXG5
         pmFy5+zXWCIyJ3xkTsBZD1S/J7tJuyuvnjKQ4zgLsFQZCokQGdW2MOtpx6KBTPSFqPyP
         PT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718447595; x=1719052395;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNhxJ8lsLsKUcd80cpqGpDxPPP4z5jSyvizVwaYRNvI=;
        b=OMGH+qZxKAAYgiYn8we1rLfLyDQQT20gxMShrbP/cjA96bWXz6HX4suGGg32OWrmHa
         epPhK3hGkV4FlH4jTTk5PIsrQlMdy/sCJ8K5YBy8Mgh6m6RLCQSKB5W4JAGB/93XYEvq
         gTsEmRt+tQ+aH7GWokeDLRv+ffDlB8uzww2kZdLTZ2PnJdaRgATmheSE6ZZK/2j5FKPs
         CHEWNrqGtmTFqVofztlwMERWfggB47krGz776KUSan2VRWp3ZpEaCtmXSrvqC+9rhW7h
         mAqPPFpID0LN7jvtuBQG2lehZrQigjiyUX1yAVWyfYjMdEq10AcLQetNDwiciVKxDDXY
         ar/w==
X-Forwarded-Encrypted: i=1; AJvYcCUwA9Ibzxv/46n8ipu70B0ZM8ZDeLSaK2lA8XXY6XB5Ksk8ZR5HeqgOL2O7bedOoP6cB+OLVWLjqziD620Tf5STAz/a3tsCplzTjQjd
X-Gm-Message-State: AOJu0Yy9HLxP6AWX/QRY+2yiyrdqoovVsgeEuf4nakQ+T7MvpJfPrJdS
	btsys/RRSZYtt79S2qBUUA6ZXGHt6MKge2Rn46Rup+zCU6+CWJY6APzfSPXJpo85CvbnobHY4mG
	Eed/fiXIPDnOMRPCzyynk/cuHBNuRCNAxB7dA+Q==
X-Google-Smtp-Source: AGHT+IFoy+c7kUP3aO8IVTdrE+OfR+1MWmkP5LS3gnb3gO/yPNE0qycgoNhwrdcWokJHmP5uM9TdHffodXQX0LyhX7A=
X-Received: by 2002:a05:6122:218c:b0:4ed:682:7496 with SMTP id
 71dfb90a1353d-4ee3f7548f0mr5464427e0c.12.1718447595513; Sat, 15 Jun 2024
 03:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613113227.969123070@linuxfoundation.org>
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 15 Jun 2024 16:03:04 +0530
Message-ID: <CA+G9fYtN0R0=i_oP5ZfUxmBuqatTOY9XDfKCw9wjsQVo=YRAaw@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/213] 4.19.316-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 17:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.316 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.316-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

As other reported,

The arm omap2plus_defconfig builds failed on stable-rc 4.19 due to following
warnings and errors.

* arm, build
  - clang-18-omap2plus_defconfig
  - gcc-12-omap2plus_defconfig
  - gcc-8-omap2plus_defconfig

Build log:
---------
drivers/hsi/controllers/omap_ssi_core.c:653:10: error: 'struct
platform_driver' has no member named 'remove_new'; did you mean
'remove'?
  653 |         .remove_new = ssi_remove,
      |          ^~~~~~~~~~
      |          remove
drivers/hsi/controllers/omap_ssi_core.c:653:23: error: initialization
of 'int (*)(struct platform_device *)' from incompatible pointer type
'void (*)(struct platform_device *)'
[-Werror=incompatible-pointer-types]
  653 |         .remove_new = ssi_remove,
      |                       ^~~~~~~~~~

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Liks:
--
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.315-214-gafbf71016269/testrun/24321970/suite/build/test/gcc-12-omap2plus_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-4.19.y/build/v4.19.315-214-gafbf71016269/testrun/24321970/suite/build/test/gcc-12-omap2plus_defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2hp7W1xcas5CN3psaeGX1n8sAj8/

--
Linaro LKFT
https://lkft.linaro.org


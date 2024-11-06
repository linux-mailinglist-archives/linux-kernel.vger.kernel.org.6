Return-Path: <linux-kernel+bounces-398395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB00A9BF0C4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A38F2830A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 14:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383B1202F7E;
	Wed,  6 Nov 2024 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E487PcQ4"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6611DFE27
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904809; cv=none; b=PMnYA+kfkuvj0Eo9fhTNkf172e7cJ5xEPh0LdIsab/EW3BHRo/hPBWOnoF1+6neBTVfGsUguJxfdsHClRLqjP4j4g8fqjSYQkGHJIRQBHtPsI30UYhfjs2Aazz/fjauKryqVUVvQmQgN5CEnE5e7BSRZmr+PczZcicbvITahiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904809; c=relaxed/simple;
	bh=Jsc2PoIQuQ4AsWmFF8Q6+FWTBnPxjtElzH9JCRFYzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iswh1KbYk4EFI0Ku7KsWzqsDMvZAJ5GQaDq2XtcJH7sS8lRJvxb0ztbTmUV7O/NHS7+Cto1P6tu5HwQ9aRVOOSIYiZx0p4h8TaiudyeCg9o607NSiHjcqGnPUUCGwkHILFEuZU/Rn9Ca0qgwrqVYNi52g/hO7ZsHAHZNOd1GM/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E487PcQ4; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50d58e5bfd2so2299323e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 06:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730904806; x=1731509606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MI7nbg4m00fCCSnSEy5rtRmHnkUgA3x+XzaBxsgKSKs=;
        b=E487PcQ4U8vylo9j2EQSPdnMIjB+aXSgKNawQCEokHYFBVY3SVClIGdvw8IG1hcht0
         eb4MccU5UVF6VKQnqsbZyoOiIocXNFKag1dTot0NtcxLToVTFK6J93M6WnFwdYHdlg1m
         qOLE1C9Ck398f0pvxL6tqVVBb/CKY31xLOrXkCowg0tSVlVDkIegCna2JzQ/LOdP+Zju
         XWGFQkNAoW2cOGbQrLquFigktxSAQanVpVItqmrD6/LQqQSm/L+haglqGptUk2EuSwiU
         LP9IrJpi2KDPrV+EZwVBTpNkAFGKB0i5VVpjyBZcSGPAMsw8SM/JH8LbFvhII+ppS24W
         2V8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730904806; x=1731509606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI7nbg4m00fCCSnSEy5rtRmHnkUgA3x+XzaBxsgKSKs=;
        b=KX0XuidGG2SVa0cSdfCyOJau90hvEBWJKsWWsqcq1vF4ER+n8J5rV9/gPpJ4lQNkx9
         X08h74kdJxankuin6GwzU70n3grs1mPQZzrSPknbfcNl0mWB1nHibf6sFaC7T92r5N6N
         s7cdCFOm0QdF6+N0nnbIewpkP1/Ka9HQYnv7wLucRVFNmmXGrisMwHtyQi4v+mTtYIL0
         feOynnIgR6ZgqgOl/WA7R32sgOA6Qc3lGinG0hSdmli2PR7xSUVHC9cfAJVD5yJloec3
         NhCy7X7kDrou86QrHDUhD4iI7Tz5Jae6t5C9QLAb9SavQ1SOz25xXffbGe5PF9UeIjiK
         xPPA==
X-Forwarded-Encrypted: i=1; AJvYcCUrkcvIjd+seGNzTnpIAlFIerRplfsQjtwM/nTKKD8zJPMvELfbeHY5jRR4Gf8C30GPEQhSZYj2cHnIkTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpeUI1E31VQVxSIeuNrylenDNqf724UoaPXEXGdOKJKlrIJZsj
	oWfNpBcODVIo5+G38PfNpP3lkbA6Wx1M1kTuqXeMfYEoUZfUUvI6RCMEuGnxq/6dBo273U+wXCa
	qcLkV4jWTDbnWI9peLVvKjGKkJ4sGNRdOfyoJDDok670Z0t79Lh0Nrw==
X-Google-Smtp-Source: AGHT+IHs9hyVIriLMV9zWsnUhtPPevFZRCt/0mF2YKsK9ex6H5hpAbYzZ/R5/cPmYMGvyjEh4T44MeVLbN7lSIGnIXQ=
X-Received: by 2002:a05:6122:a18:b0:50d:3ec1:1531 with SMTP id
 71dfb90a1353d-510150e1e84mr38180373e0c.8.1730904806042; Wed, 06 Nov 2024
 06:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120331.497003148@linuxfoundation.org>
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Nov 2024 14:53:14 +0000
Message-ID: <CA+G9fYvqfxYX8r1rMcaiaq-K0xuVf4-pRrS77ovNMHNiA+FPkA@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/462] 5.4.285-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org, Wang Jianzheng <wangjianzheng@vivo.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Yangtao Li <frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Nov 2024 at 12:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.285 release.
> There are 462 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.285-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The arm builds failed with gcc-8, gcc-12 on the Linux stable-rc
linux-5.4.y and linux-4.19.y.

First seen on Linux stable-rc v5.4.284-463-g21641076146f
  Good: v5.4.283-122-g10d97a96b444
  Bad:  v5.4.284-463-g21641076146f

arm:
  build:
    * gcc-8-lkftconfig
    * gcc-12-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---------
drivers/pinctrl/mvebu/pinctrl-dove.c: In function 'dove_pinctrl_probe':
drivers/pinctrl/mvebu/pinctrl-dove.c:787:16: error: implicit
declaration of function 'devm_platform_get_and_ioremap_resource'; did
you mean 'devm_platform_ioremap_resource'?
[-Werror=implicit-function-declaration]
  787 |         base = devm_platform_get_and_ioremap_resource(pdev, 0,
&mpp_res);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                devm_platform_ioremap_resource
drivers/pinctrl/mvebu/pinctrl-dove.c:787:14: warning: assignment to
'void *' from 'int' makes pointer from integer without a cast
[-Wint-conversion]
  787 |         base = devm_platform_get_and_ioremap_resource(pdev, 0,
&mpp_res);
      |              ^
cc1: some warnings being treated as errors


Build image:
-----------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/build-debug.log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/config
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.284-463-g21641076146f/testrun/25690547/suite/build/test/gcc-12-lkftconfig/details/

Steps to reproduce:
------------
   - tuxmake --runtime podman --target-arch arm --toolchain gcc-12
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/config

metadata:
----
  git describe: v5.4.284-463-g21641076146f
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 21641076146f6d3076b915009a45a9b8ac7b78fb
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTfYomC7gxQMBPlC8XecubDfEA/
  toolchain: gcc-12 and gcc-8
  config: lkftconfig
  arch: arm

--
Linaro LKFT
https://lkft.linaro.org


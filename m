Return-Path: <linux-kernel+bounces-303879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E200A96166F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122931C231B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F521C3F2C;
	Tue, 27 Aug 2024 18:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynzGlrWP"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651D1CE6E8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782076; cv=none; b=umcfjMqxHzha3K6v76EgmRqsDLGC7Y6waO8K2p4kUGaiwOJdexFW2mTU9ZEAXQ7WaMQEQLr23qN1uA81iPvTLqsKxy89qJYR3HiKs724V0p1ivy3C9nfO/IIwXi/x+/w3bmVwYFj0UkS2ZXZXYqj1mEnWUIMoxeGeifMgnCZMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782076; c=relaxed/simple;
	bh=lAhAeqgjNAY5g+GAszam7Q3K2oVB0wyj04I9ekuclp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cM1bIuVm0TWNzLXLwJEOrbLTdtLsZ+h5xH9C0Q6YOUyoAsPy/s8y9d5jth7QbPglGXD7g0jqhrAIPJw8Jr+OW1cQdn8MjBgMeWf/a6fVeSvLKCjLnpKBa8bwHDWPFUWf2HYQ5GHM0U+cgq3R+qUjGGCb5rjaGBPVbSTNqoOVTGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynzGlrWP; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5dcd8403656so2922454eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724782074; x=1725386874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/b4dRpNjGudpEwl7Acu5bLfC+npGjFhptD2B2uvvIhs=;
        b=ynzGlrWPuoahcUR55cqwmA9KFr4/KfHyxS8m029Yp5LyuNxc2yrlz8D3wlqcRalQzm
         cB2VvKBZEro8WpT27VIn3cc4t/I9doesblJUY3gGL9tSdPEimkSCqrim2mdqH42rzXPp
         XVqULua6JRwgj9EFb0iW8ReJCPEcHpnzrgkbZCnBQR/PjtctCrHnNQCaPYaAB636gNUC
         FxVL8RP2XcQY4dn/GDfKyaGxyco5X3O1AZHdocBG0czy/nGLfMs5hWF2t7sfmIlNJ5Fj
         YPgAtlbYWposK8xMOBvR9tfx/IP5A2L9BasOlttkD5pLb7TvpXKM9kjohG0F67TcNLs1
         tLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724782074; x=1725386874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/b4dRpNjGudpEwl7Acu5bLfC+npGjFhptD2B2uvvIhs=;
        b=ECvIWJxMKMOTSL2QyqGPqo6YJje+vxsVtyH0iz6vx8JFAaSzANFSIjAuCIqb3G5Ppc
         zA/zes0i2Q/KLhWZMOAhgjTBDBGymx21iDAblD2ZdNnL5+nAg87kdCXLIa2CgwWTTRyx
         MjxSmjrtQoBo6JkdaNoRbzyrSu53qdkyZLF1onzmG8q/UNqxdU3igXoHtSKHGcl8z1Go
         Wm3ZNqL7Hhl6E1hwLx4MdEZx0MFBWZ3vFAGJPFhOsbqt74fSMYUJTCW9+yDSraaSN4i4
         N+Yxh7M50A6SYTO0r/xkPo6qs6vrPv+QWCxojID9s3ezV2v7rKxWfplxLP9g5UKinK5O
         K2UQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7lUh3ThA/Cshx7sjh2+rCIWxYbDfTSd+lXTJkbxh1dt+JpsIx9BSFfnM1zshu0b6r9wr9d6f3cL8MLuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzReDdQDKEEGSrjRAC6Rw3vypGXuaX9OoYMwHfi8Dxso5535jpP
	hy5IaeJhr7FTd/geg6A4RgSS4ua//KCwkIJWsVQy8TdmjAzsZgqolAnUbBNHDI05f4m2musLjMo
	ssV9TDMb4yeLAxeayyhtPXOzJiCGiGyJW2gTpRw==
X-Google-Smtp-Source: AGHT+IFR8RYrS+3AYHKWfyfd4ucpXHOPlxyO3EUNWmKH5WtItwGtOhPVzmXRV9SuRNdjiJdFwEX8Vni9ZUK+S+bHf/o=
X-Received: by 2002:a05:6358:724f:b0:1b5:a043:8f43 with SMTP id
 e5c5f4694b2df-1b5c1ea9182mr1595275155d.0.1724782074350; Tue, 27 Aug 2024
 11:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143838.192435816@linuxfoundation.org>
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 27 Aug 2024 23:37:42 +0530
Message-ID: <CA+G9fYuS47-zRgv9GY3XO54GN_4EHPFe7jGR50ZoChEYeN0ihg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/321] 6.1.107-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, rcu <rcu@vger.kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Zhen Lei <thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 20:47, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.107 release.
> There are 321 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.107-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The tinyconfig builds failed due to following build warnings / errors on the
stable-rc linux-6.1.y and linux-6.6.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
-------
In file included from /kernel/rcu/update.c:49:
/kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
/kernel/rcu/rcu.h:218:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  218 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors

Build log links,
------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFQ5BrEWOun7OOelPa1RMAsXo2/

 metadata:
----
  git describe: v6.1.106-322-gb9218327d235
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: b9218327d235d21e2e82c8dc6a8ef4a389c9c6a6
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFQ5BrEWOun7OOelPa1RMAsXo2/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFQ5BrEWOun7OOelPa1RMAsXo2/
  toolchain: clang-18 and gcc-13
  config: tinyconfig


steps to reproduce:
------
# tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org


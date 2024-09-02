Return-Path: <linux-kernel+bounces-310850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC1968201
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97D72809CB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E411865FE;
	Mon,  2 Sep 2024 08:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bs0s7Uij"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E7154C0B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266008; cv=none; b=F4DOsSXz0vqj36g5nG2wNU0wSjYo5UlRABl8yxsWjM8gH3YxZEtiBFzsvsCpHej20EiQTj0dmL7AlFBP7cvzTYinmBKMKxlJpDt1v4iW3N9T2unINlx4rXN/FK71C+sSv8VUSbC2QgztHTtJPcq1WePGjEQ9wIep0jJ/q7PxdPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266008; c=relaxed/simple;
	bh=PNR1y5jFFyZ/U+8iJvaIrnMTI8sRD1ojmA0BXADfGWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxbw/pGUwFv7kna1SdwnKzAh48JxOQi0BSKagxIQeu7wbfF8nhhAlLlDpEvoEUkEATflsHKl2/ghiZ7qnghZwNz9I8L6tlxPxEXF9sRBZfouC1wfNpEkgr4jrriyRwWMy8Ev+e2aKvRIwPo3mXm5cuj09UMFbSlUfiYb6M5Xis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bs0s7Uij; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-498cffc6a9fso1516389137.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725266005; x=1725870805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kXkIyZQ0PjK6x8WUxNBMo+VFGKPoaaBPUMlbMlC+lj4=;
        b=Bs0s7UijXm7LEFj8GsrFuOStOIIVTdEsAXMqF5L0aTrCdgjgIuS3UIaY6YMxi36/Iy
         vHbl/8QJdNFfFrR752wCbXKEGER/OiYCC36ZmGedr88Dzno+nxgPRukgWCZDfZ2kDnTI
         GjxfHf2h3bB7FNUpBlA5SbSyvN2FhZ/ANWkSNVVhfYGrow9AuLdRswLqgSrxzyFISzZt
         zT9GyX+YfEuLcvbNgklB55W48XIgFn6gNLZ5QRkdBHzwP/3aKLfur3JBsMOXVHm8OE0d
         UqaMUdDFLryf4QY7SG8bD3huvs89iUvWAGB+pkDx8+6eU38E5RbbRdbYyx2HI+OGsQM+
         vCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725266005; x=1725870805;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXkIyZQ0PjK6x8WUxNBMo+VFGKPoaaBPUMlbMlC+lj4=;
        b=Ia4VNysD8VlB3wxnJ3z9CoNxfLZRXtqjATMahKebb4ErN691IH2w6pufBg1ybodMVc
         mwqtu67SzXn/L/vSktjFRdMd1E8B4JpzbqaUxFopPM1mxLbE3Gc3iAK7cSywr2S4wfDT
         LSpurm7rfAiIinQIuzmq0MSRxY5LssbE2OtiZ1Lkbvh7QUd1KD/Tmhbk5IMsGkXi9Gta
         OihKqccexcqWqld3st1u0EqJ4488mJPdecSr4VXxYnn0HR7ue0Vm3kfy2a2GQHcOEWWc
         1DEjKV8bD5HN+/ncB9CyzUZ8rn7GEQcVb6tFLxzgTYwToSCelsV+NdXWOXki2IK8MTGo
         WZzA==
X-Forwarded-Encrypted: i=1; AJvYcCU7BFSYRpgs3EsZZZSpinNIzNvFfEUY84EJylyM2sZnnT2s6Gxf4KtOQ1qgWt+b5zgVOFfpE6VqHJxQB7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE6TrxawqjxkXLdoMqbBpfh6/vPvLaEivVCeRHVesQoPXo6ax9
	nnTgQl21mEQpwHmuVDplhkURvnPfWtwAwhd99jEB/2aq0j5neH8IdmfmJM2jMhBBDhexFZ0MoLn
	3rGejQAI15WSIWrGCBA6c3PwdAKN23b2DtcqJryCo6BDIWbZUMeY=
X-Google-Smtp-Source: AGHT+IFgxqoz93mmdsCr/aVqqjJRfDjqLFg0pIrx7sVX8EGEj0YgIu7R6T9ldniFExdERZD+0nImtPHiL+lQnbVegXM=
X-Received: by 2002:a05:6102:441d:b0:48f:4bba:778c with SMTP id
 ada2fe7eead31-49a774f6011mr7832345137.8.1725266004923; Mon, 02 Sep 2024
 01:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901160814.090297276@linuxfoundation.org>
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 2 Sep 2024 14:03:13 +0530
Message-ID: <CA+G9fYuK+=YW6F+mBMeHAZoUrQQS6-AgAezRfQGEpZui4JUepg@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/151] 5.10.225-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Sept 2024 at 22:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.225 release.
> There are 151 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 03 Sep 2024 16:07:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.225-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The Powerpc defconfig builds failed on Linux stable-rc due to following
build warnings / errors with clang-18 and gcc-12.

This is a same problem on current stable-rc review on
   - 5.4.283-rc1 review
   - 5.10.225-rc1 review
   - 5.15.166-rc1 review

In the case of stable-rc linux-5.10.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Anders bisected this to first bad commit id as,
  fbdev: offb: replace of_node_put with __free(device_node)
  [ Upstream commit ce4a7ae84a58b9f33aae8d6c769b3c94f3d5ce76 ]

build log:
--------
drivers/video/fbdev/offb.c: In function 'offb_init_palette_hacks':
drivers/video/fbdev/offb.c:357:47: error: expected '=', ',', ';',
'asm' or '__attribute__' before '__free'
  357 |                 struct device_node *pciparent
__free(device_node) = of_get_parent(dp);
      |                                               ^~~~~~
drivers/video/fbdev/offb.c:357:47: error: implicit declaration of
function '__free'; did you mean 'kfree'?
[-Werror=implicit-function-declaration]
  357 |                 struct device_node *pciparent
__free(device_node) = of_get_parent(dp);
      |                                               ^~~~~~
      |                                               kfree
drivers/video/fbdev/offb.c:357:54: error: 'device_node' undeclared
(first use in this function)
  357 |                 struct device_node *pciparent
__free(device_node) = of_get_parent(dp);
      |                                                      ^~~~~~~~~~~
drivers/video/fbdev/offb.c:357:54: note: each undeclared identifier is
reported only once for each function it appears in
drivers/video/fbdev/offb.c:358:17: warning: ISO C90 forbids mixed
declarations and code [-Wdeclaration-after-statement]
  358 |                 const u32 *vid, *did;
      |                 ^~~~~
drivers/video/fbdev/offb.c:359:39: error: 'pciparent' undeclared
(first use in this function); did you mean 'xa_parent'?
  359 |                 vid = of_get_property(pciparent, "vendor-id", NULL);
      |                                       ^~~~~~~~~
      |                                       xa_parent
cc1: some warnings being treated as errors


Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.224-152-gee485d4aa099/testrun/24999742/suite/build/test/gcc-12-ppc6xx_defconfig/log

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.10.y/build/v5.10.224-152-gee485d4aa099/testrun/24999742/suite/build/test/gcc-12-ppc6xx_defconfig/history/

metadata:
----
  git describe: v5.10.224-152-gee485d4aa099
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: ee485d4aa099209aaf39d4a5b8fe624ce3b3499d
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lTio0YVAvyu3ldUd5EvqiE4ii0/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lTio0YVAvyu3ldUd5EvqiE4ii0/
  toolchain: clang-18 and gcc-12
  config: defconfig
  arch: powerpc

Steps to reproduce:
---------
 - tuxmake --runtime podman --target-arch powerpc --toolchain gcc-12
--kconfig ppc6xx_defconfig


--
Linaro LKFT
https://lkft.linaro.org


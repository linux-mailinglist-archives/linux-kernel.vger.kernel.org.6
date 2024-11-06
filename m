Return-Path: <linux-kernel+bounces-398438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EFC9BF14E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46951F22B79
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE9203716;
	Wed,  6 Nov 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrnE/KrI"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A720263E
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905981; cv=none; b=Z5aw+apedBEclFaf8a2vIlJdMzo2ofr/lUO4EFi/HOALLIQrlUIQU9BGGEpeRyOa5wrEheYisy7fYM9EyCvltJQVDDJ1MvMwa5cjn3RuQipO//uC/9JdDGKwZITvmLRptXPNAhu3q673chF00cDxW2ya/a2iyqOEMM2zhB0b8aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905981; c=relaxed/simple;
	bh=hJwSnsQSETNFXzvgqfuf9ElowDht9infCxazmOXBa7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn1GcPwVtG8dVoaAJEjqK0kJMw6rdQaip102C6SD7Huo4xkx+xU88h4WotSfWpMkzPmIIfKGrVJV6aAXmLkt51483CXju8+n0mk7t0d72MUlxDCjVojbLJ/Mk5LOVKkX9k7l9OgcxgBeZPJeda7ELQl4Y/Mximio4tTsAd7ROJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CrnE/KrI; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5ebc349204cso3272659eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730905977; x=1731510777; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/s8MXlCqJ3S3d997kkGlOblTEnbIpL85LZHtL6uGm0Q=;
        b=CrnE/KrIw/TiKdKuaCwGjz/Y9hFOIr8AIKFgu/Cm4JOsTl2iR9N6OGlyzYMvDjj4pO
         wBkcR4Q0mX1rtNH51CfKiDSGIzrOFgJhRPtOmMqLOy2UIw9K8t2WQnQ5yOikua/bGzBK
         tM2p16jVHFQ9hrUGTpc8IAoD4GyU5ldQNDx1FcpecKt6pZ3kLdfsy+BaNqsalLYmb3X8
         OUltoc4OT0VDsisz9qagoVAviWfKWQ2hLrutFnFQQoK47j+78dcPTyQy+FuJ5cnBrmPY
         GbDpjr/GhZYizHdLLCYUfldp3xomvJLtyEmiz1fw+X39IC4LdOX/FDWV6+2sf4UhtscF
         UmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730905977; x=1731510777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/s8MXlCqJ3S3d997kkGlOblTEnbIpL85LZHtL6uGm0Q=;
        b=O7ZxBk6DC8c0Pb7P2m1CTPaUvL0NXBYAu2HbTmkcgwLWA0utInbL/5R55uAW7DmIdv
         VC6OAubASH689y+HiFKOEYv8DhmEzvtDFK+0AQjZXi25cv2VfTuw/BSDzWFACogj19bk
         OFXFz02COUKAzZ5H/aEZkHyoiWIT2ILnSYehH0E093jV5TewLUHR57DrxdmEeVb4cVW1
         5axnp8IYPE2wXy7RuTbYiXDJ6+/I973b8r5lWPTr+ESQCByy/8sTGAmMMNaDVclTx6lT
         Xbw9CwnZ53y4suVbBmZ7ZBm8azdS5yMtskqArTSjHheAEEuM+B2D8A0eqFKuBypURfpc
         6WzA==
X-Forwarded-Encrypted: i=1; AJvYcCUrvg5GuS4wjBYISgcwIHcsdAQqXTztn7k4oV6L/Y8l2UukEwSGkG5oyph0Lqj7ygUyJnubaV0oaDFOWJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziylUWpxyt+U01PGpykSQtDrL2OrkLal3d6yV6Axsq/jDFPGsE
	P/26titxEdMomm820j6oUq/q1MJ8CP3R+CqnCfONjP4bI65bkBrc9rGY45qj6IwjueFmkly9IBf
	N3jN4shJlGxelHL5x+wrS/BZyUV/yKd2Kiny0n5qjQWIpKQx4dA9Ssg==
X-Google-Smtp-Source: AGHT+IFK0O+catjkeLn95aRPwfONLUcgvqi/oAotqb/lG7yJa9aCtKL/wkazFs/bxZ/MPrgGD7dqggXgWdBZY7x6muM=
X-Received: by 2002:a05:6218:2814:b0:1b3:9b15:ac01 with SMTP id
 e5c5f4694b2df-1c5f98c5a83mr960654055d.3.1730905977486; Wed, 06 Nov 2024
 07:12:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106120319.234238499@linuxfoundation.org>
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 6 Nov 2024 15:12:46 +0000
Message-ID: <CA+G9fYtjpUJFFV=FdqvW+5K+JL5ZYN4sPfVDjQovqzd7cib39w@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/245] 6.11.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hagar@microsoft.com, 
	broonie@kernel.org, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, Linux btrfs <linux-btrfs@vger.kernel.org>, 
	linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Nov 2024 at 12:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.11.7 release.
> There are 245 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 08 Nov 2024 12:02:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The mips gcc-12 allmodconfig build failed on the Linux stable-rc
linux-6.11.y branch.


First seen on Linux stable-rc v6.11.4-642-g0e21c72fc970

  Good: v6.11.4-397-g4ccf0b49d5b6
  Bad:   v6.11.4-642-g0e21c72fc970

mips:
  build:
    * gcc-12-allmodconfig

Build errors:
-------------
ERROR: modpost: "__cmpxchg_small" [fs/btrfs/btrfs.ko] undefined!

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
- https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11.4-642-g0e21c72fc970/testrun/25700362/suite/build/test/gcc-12-allmodconfig/log
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTbq5WdzEalBxPXBBCuzLUA45b/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTbq5WdzEalBxPXBBCuzLUA45b/config

Steps to reproduce:
------------
   - tuxmake --runtime podman --target-arch mips --toolchain gcc-12
--kconfig allmodconfig

metadata:
----
  git describe: v6.11.4-642-g0e21c72fc970
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 0e21c72fc970e320e6c1ca9d81d2dce4aab95b3b
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTbq5WdzEalBxPXBBCuzLUA45b/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2oTbq5WdzEalBxPXBBCuzLUA45b/
  toolchain: gcc-12
  config: allmodconfig
  arch: mips

--
Linaro LKFT
https://lkft.linaro.org


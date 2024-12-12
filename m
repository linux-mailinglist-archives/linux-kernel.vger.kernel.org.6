Return-Path: <linux-kernel+bounces-443932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E636E9EFDBF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6FD16450C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019261BEF82;
	Thu, 12 Dec 2024 21:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7iN6vLm"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36421AF0C8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734037211; cv=none; b=ur87+vu2FMLqhZhsc/wWBeZCG+all4cnm/J9ZDzJeK/7fZBndbwV8G8go32kLmKPeu2EOb0979nibMdQKJnkU/bZZHiK7WdBvIlzW8JvYrVh0Y1eRdKWwAexbygReqEN47vltdun1dfbYD/fXRNfJpJAZ2hxcprnbfqe4BvLbG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734037211; c=relaxed/simple;
	bh=nC4EmuVP4ntlQc9bu8GJVOZYdMhzB21vlErGfWW8W3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U9CO3lURbbbfjOCgZ96748fp4bKezjuTtiEFrdgnMjSOqs/uBzBjkeovEVpiCFm6sMqe2iVBTyYAWTEr79j3YsFzvpKanktsCof6POXZMCzSOPhAtq84Lh2FNUHiB4XqYKrzbl2eZ4SNvhMQgo6HzPIJEegS3oHnY27qIuY24oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g7iN6vLm; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4afde39e360so218895137.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734037208; x=1734642008; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k6Y1+WixMes/8w7Qpnpmgj9E+CHS4GlCyK+GluDTf58=;
        b=g7iN6vLmX7iT1kCs7eRq3iwoeS56Hcw0FocaPkVbBvMFVFv/rQUCLeLCXLtieSm85U
         s/eXEzG+Jz+CJ1m9f6ab8UAZfDlKmLEd8T0Mx2gF0ZdCfCKXcDAeHgC6eswjmM70V7vs
         f9s5X7nGxOszfy/VgTVc4W5BHVkscaQgekIZiUeqmfnURB3TFUZwY2xUlATGWg8lodTI
         p4RsBzo0Y9BFE64v+LAN9VCpo63UZ5Rd68D6oD48V3K1nvQEEiQdJS+LP7kTKvQEurJr
         1UzW3Ah5In5lRPQvKmiNhEEo+qtdSW6Mc+7zKTXj1KcY8nKzdAyq4bxC1bQNeRV+jMkz
         DscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734037208; x=1734642008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k6Y1+WixMes/8w7Qpnpmgj9E+CHS4GlCyK+GluDTf58=;
        b=l96PcUV4jshRRmog/F6+KFJeBmzC4JSXg/i8BTHfJECF7ggHFAjdLZ6mMTRw7+msdN
         6YPIDC6mQWT821EC7VPdC+9CnSDmwS11OsSCPjgvTf6IRNC17DhaBatgwC3pXpd/5e3Q
         gwCwoMHMkzXrY4Y/E8v7FG9D6YEvBS8Gkorrag9vJVAAk+ZnTdCfNmDCsoNsfowFruWH
         KII6mFG/MTzFDJE2OE6pr1bGJWaJef3K7lsmd0hick4RKxSpJ/PO1DTbZZ/LUuqHAmvo
         vNX45CJvyrd+rgbaMXWcButGkRYXbk3rMqJOIeZZEvmPfxuVRqgwkr58tV9B3CCX018b
         Gjvw==
X-Forwarded-Encrypted: i=1; AJvYcCW578ZdDNHJHrLJzvrIW4VwonQt9U1GHMA55iKxFEO4+PpNenpYbl+N/vmAlbKnJ6yt5Nj/bGz2UU91Bf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuiXNBv6mrtK0axykfhY4JAsZ4QBv75J5JNMxL5vHLVcZj88Mw
	hldmjgZiyooQjCAdymcYmhRbemonI300A+p3PCF/XgUH72yKf3ZngSg4bBvojBlkZ7pq2AErazT
	egbD03MeQ1fPDcnaU6kSjrvO3b7a8x+vhl8YHug==
X-Gm-Gg: ASbGncuZFcllpAVUPLSm5ID3Tl+2Zz736e493lzjNZMGgUOmhCF/Ww2F754uJ/K+5YR
	wbTALNBQXniXxvxnPGZp+SDgvZNjS+RSkEGOE
X-Google-Smtp-Source: AGHT+IGdvT/mhowuOXBJ2aXodZzIiREIHRQvRQBno0frewBNX+LzZcApS40ykgaLhTzbQyOr7inpeeuIlg31e3nkwkQ=
X-Received: by 2002:a05:6102:1591:b0:4b2:5c2a:cc9d with SMTP id
 ada2fe7eead31-4b25d9dff21mr592214137.16.1734037208538; Thu, 12 Dec 2024
 13:00:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212144349.797589255@linuxfoundation.org>
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 13 Dec 2024 02:29:56 +0530
Message-ID: <CA+G9fYu+u4a+63vCCeLo1LdWhvK75B9j-znx7kp2ZVtzK_H4AQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/772] 6.1.120-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Dec 2024 at 21:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.120 release.
> There are 772 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Dec 2024 14:41:35 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.120-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The powerpc builds failed on Linux stable-rc linux-6.1.y due to following build
warnings / errors.

powerpc:
  * build/gcc-13-tqm8xx_defconfig

First seen on Linux stable-rc v6.1.119-773-g9f320894b9c2.
  Good: v6.1.119
  Bad: v6.1.119-773-g9f320894b9c2

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-----
/builds/linux/arch/powerpc/include/asm/page_32.h:16: error:
"ARCH_DMA_MINALIGN" redefined [-Werror]
   16 | #define ARCH_DMA_MINALIGN       L1_CACHE_BYTES
      |
In file included from /builds/linux/include/linux/slab.h:15:
/builds/linux/include/linux/cache.h:104: note: this is the location of
the previous definition
  104 | #define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
      |
cc1: all warnings being treated as errors

The bisection pointed to,
   mm/slab: decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
   commit 4ab5f8ec7d71aea5fe13a48248242130f84ac6bb upstream.

Links:
-------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.119-773-g9f320894b9c2/testrun/26283233/suite/build/test/gcc-13-tqm8xx_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.119-773-g9f320894b9c2/testrun/26283233/suite/build/test/gcc-13-tqm8xx_defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.119-773-g9f320894b9c2/testrun/26283233/suite/build/test/gcc-13-tqm8xx_defconfig/history/

Steps to reproduce:
------------
 # tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig tqm8xx_defconfig


metadata:
----
  git describe: v6.1.119-773-g9f320894b9c2
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 9f320894b9c2f9e21bda8aac6c57a2e6395f8eba
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7iTg4R40CXEIVAGM9hWTEqyjR/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2q7iTg4R40CXEIVAGM9hWTEqyjR/
  toolchain: gcc-13
  config: gcc-13-tqm8xx_defconfig
  arch: powerpc


 --
Linaro LKFT
https://lkft.linaro.org


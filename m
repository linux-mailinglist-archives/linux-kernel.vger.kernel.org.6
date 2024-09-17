Return-Path: <linux-kernel+bounces-331602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E02897AEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A9BB28ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDAA165F0C;
	Tue, 17 Sep 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sstSTs6V"
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C738B171089
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569030; cv=none; b=Shn5HRiiTlBVA5j7OazkBMW6l5V/qbQ6cKQfQennXlkSOco+qjvsFHEJU47/dzCDRhSyCx47MfRu8Sm7E7mnHX9HvxNKX0nATexaC2EKVlDlml1Wm/EZK8szIy0btL9vqRLxXIWjO943+rbEOl2NS29mgLCnghCXeg/3plXiO6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569030; c=relaxed/simple;
	bh=rAUoQ4nus9+gGnXZO4GR16ay3famp7WL4FkpgBIVWUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7YwXiO8VmH72XOBvld9As4AYctLhvwiDmRspaQB749oiGILObGwOPtN7j4IGjmJeilRdqHMAw8coGUvBqdHgjjI5RDaSN/btdmMFNSQp/0NyuTC/Kz4yrSQ4eft3UP8MmCTIe3Uov4KvIq3sIwA9j3bNebJjc8Vh2e758QKlw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sstSTs6V; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-846bc2104c8so2894116241.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726569023; x=1727173823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TiSL4J7L8lMiEUKJ3FGpFS/7E/wv/Xs1VRoLh25eebs=;
        b=sstSTs6VNOKqvK/uhvKhCNmEzG9dK4Mh1KxBFQl5JDZoOgEM8Xh5hc3sBCeryZaMJi
         LG2v/rbPzwqDHlt2xovQx45QiW9TCc+/bxhO5ZexUO07pB6blRLs4OY4V/j0Heq9Kd+d
         a615cKnZkbUMs5Y7nSmGeSce1Bws1pvcHcrKpeVzdHoXqCoRK5sk4jzdU/YO+TLIHNH+
         EsdlEGNkolXiyGdt14FYc0oElpkSJXR7TI+Bh6llzJyI7JH6qQm0IUn9hJtXZtPmvjoU
         rBcwA/NGA0j0tXu7PAclba/fsh2gUVW3nl+/6l85wKsn9lHdat36VXR7RbuqXqLa2ANL
         1mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569023; x=1727173823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiSL4J7L8lMiEUKJ3FGpFS/7E/wv/Xs1VRoLh25eebs=;
        b=sYjRCMCMyPxxp0eGv7TxluKYVwFetvg3lwJP0ehs5Wf4U1+d1QORCJNb2LUdcgQOou
         2b02NaD+SXZqITcKQxAQzg7gd3C7TseTewEwmoxZgYWIEf12gfzwbtohPNvo5A9vzCFi
         BBcUaX5cU7vsN2z4TVUlFs9dt8s52QgAA6zBtgKC/IG8lgt62J8VXT84iKtVva1kfa+U
         ODYHaNJyj4vENpPB02X/OLn5iEOCyAixhjLw1HEYxizi/JLhOLJrnjeRdUQhz23nDVN2
         jFwZH/BIYMwckGLoqja79bpvFZJZ4Xe1UHTTCfwM3e4TxBe95NP9t5MnIrz6u2/uZtyD
         2hIw==
X-Forwarded-Encrypted: i=1; AJvYcCVm7d8UxtHpFjF/3heuHxvIZQINFS7cDfOlKwOebOSnWHr6Of6KgHPMNDNyOYuR6NnSBc8qiHNi2c3CCys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8cuWrPCpYpcGCci5smXbuu0oJeEi1MsXLzZAjv1X9Z4dB3Ies
	8xfLQ/sHzhRVZCdp8fjGlx2aXeZOjETLbIpkJznD4dcDK613xscvFMEFe6l8BA6JJ4s7C7+GaQA
	gx+J9JG6AyWMhlir98lIUzU5ef+SQmxkiCrkvGg==
X-Google-Smtp-Source: AGHT+IEVb9UtvU3qIrJ3hyC4983sMEXpKsLF/53bfiXaTkarBvujHfkK9GFkmBvRc6GUz54Xmq2wvMJKl1xR3mITQ20=
X-Received: by 2002:a05:6102:b0d:b0:493:c261:1a9c with SMTP id
 ada2fe7eead31-49d42165fe1mr12824423137.5.1726569022577; Tue, 17 Sep 2024
 03:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916114224.509743970@linuxfoundation.org>
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 17 Sep 2024 16:00:10 +0530
Message-ID: <CA+G9fYv+OXhNPn87X4O9w8-HzGP04USge-et0b3Y4ncU9tussg@mail.gmail.com>
Subject: Re: [PATCH 6.6 00/91] 6.6.52-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Vasily Gorbik <gor@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 17:38, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.52 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.52-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 builds failed on the Linux stable-rc linux-6.6.y and linux-6.10.y due
to following build warnings / errors with gcc-13 and clang-19 with defconfig.

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


First seen on v6.6.51-92-gfd49ddc1e5f8
  Good: v6.6.51
  BAD:  v6.6.51-92-gfd49ddc1e5f8

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------
arch/s390/kernel/setup.c: In function 'reserve_lowcore':
arch/s390/kernel/setup.c:748:31: error: implicit declaration of
function 'get_lowcore'; did you mean 'setup_lowcore'?
[-Werror=implicit-function-declaration]
  748 |         void *lowcore_start = get_lowcore();
      |                               ^~~~~~~~~~~
      |                               setup_lowcore
arch/s390/kernel/setup.c:748:31: warning: initialization of 'void *'
from 'int' makes pointer from integer without a cast
[-Wint-conversion]
arch/s390/kernel/setup.c:752:21: error: '__identity_base' undeclared
(first use in this function)
  752 |         if ((void *)__identity_base < lowcore_end) {
      |                     ^~~~~~~~~~~~~~~
arch/s390/kernel/setup.c:752:21: note: each undeclared identifier is
reported only once for each function it appears in
In file included from include/linux/bits.h:21,
                 from arch/s390/include/asm/ptrace.h:10,
                 from arch/s390/include/asm/lowcore.h:13,
                 from arch/s390/include/asm/current.h:13,
                 from include/linux/sched.h:12,
                 from arch/s390/kernel/setup.c:21:
include/linux/minmax.h:31:9: error: first argument to
'__builtin_choose_expr' not a constant
   31 |
__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),
 \
      |         ^~~~~~~~~~~~~~~~~~~~~

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.51-92-gfd49ddc1e5f8/testrun/25153617/suite/build/test/gcc-13-defconfig/log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9YUHx7PsQwr4lBdvjITAfP9Pp/

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.51-92-gfd49ddc1e5f8/testrun/25153617/suite/build/test/gcc-13-defconfig/history/

metadata:
----
  git describe: v6.6.51-92-gfd49ddc1e5f8
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: fd49ddc1e5f8121355db23e04b94f6df460a5051
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9YUHx7PsQwr4lBdvjITAfP9Pp/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9YUHx7PsQwr4lBdvjITAfP9Pp/
  toolchain: gcc-13, gcc-8 and clang-19
  config: defconfig
  arch: s390

Steps to reproduce:
---------
 - # tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org


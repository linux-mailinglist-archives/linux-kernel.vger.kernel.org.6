Return-Path: <linux-kernel+bounces-365343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A3999E0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674171C218A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C661CACC9;
	Tue, 15 Oct 2024 08:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cJxQl/vG"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172621C82E6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980496; cv=none; b=L7dWWoDihZFA3VsWi54CKW+7M9+5bK0QA/nfE4N6Suvd+TvWZU8ZOkkvUaJ1N5ovWagXzQvcu3FC2WOnfW7MkP53UqSwtTN+nvRXu9ZkiS/mPQEENn+4D/V/bGC9JqGaUUEhBFx+Xwx68NV3N/pYN8C35h+fHA9hRwy+f8xO0SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980496; c=relaxed/simple;
	bh=zD3HmgW+TlfcyOvp2QLRv/48BOBk+PPPEeanN3RBWTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuxVcVwDTuA8OZ6cnX5PQgz6M18hMsXMTu1SLpCzMp2ld3jh7bji9hSTHlnDKGO/8SjFlkUsdB4sJPD+7cRLy4R8JEHaXNmrhmUaOrV8vsZknBXJq1N3QgApyz8kMYvVt5+YIqmXXgKSIsgyudFLL2NFRIVYzc2vjb6zgDRCDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cJxQl/vG; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-84fb533bb9bso1100321241.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728980493; x=1729585293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lW8e1d56O5rgpMPsi4Gluv5d8nw+f0Vj8iqFfuuPxRg=;
        b=cJxQl/vGpmKCoYKFErbas4jm6IAU2jvM2UrCApMSZcOM0lNU8P5ABW5E6rXEurnSGC
         ATyi8msajb33+8h/hVgq+Zg2/ptVOMgPNLu/7p1HNAmiWQXpG08j1jUpObu/lMWqYTXt
         GLTbsZazjAndN/8fpPLt1ESL7k93Uh+MzpV5HnOxZOqSifqYhuLb1rD2c3OhyAR121Ai
         Zf7FA18zWWXOxiboOg/sV18lll4SE9/xcEXcNT7srWp+DPBlT+l763jCdVwK2owl3EPy
         dUTQtlc4dtTMXRtlV0Nx/3U+mxN/5ZR0T5ty9ruWsLkxchMOe/9I0UassSRe8hEpvX7B
         zQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728980493; x=1729585293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lW8e1d56O5rgpMPsi4Gluv5d8nw+f0Vj8iqFfuuPxRg=;
        b=u6ayyJYj2+T08k0luL9ELwIr+jxQ+ehca1Q+Q1QAllClYb1xSp5d2E47mkih9UGt6x
         Dc1njCMwO9tPJ28gQj9D3CXY1ESimP6r0RQpc5uI/K4Q0cgsBoa5PKnqDbNcm0NO/Tys
         VqloBmX08aRxL5mmr7CE4QlFj0zprb9EyFzOpfWBTUxbzmnyTir0OD+/5QY1ILahoNVA
         AYK2E4aG7ps6CNdqggMhHsTcpiRVTSeLgWiHjLiK2sgL5vzBNQnyOpGHRPEJWKMlACjp
         UQo6P2sh8zL5/OdQY9YqSFLSyKvoaAvg3/JO4aNqilLFOyVAHjt8Acu/G/sDiAGFHJes
         xyXA==
X-Forwarded-Encrypted: i=1; AJvYcCWVyfeJa73RN9ZRZwQ2Y2/s0Jyw1na0y9seWbu9OTOH/6AkosG58psM6qKFF7ntr8pfJiisAcCuo/K5dXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2YDH1K2zwmBIYLCdT4dsw1MZJWrhdrNlxVmGzSRl8J3GPzsAe
	EL/RjMVNEQ2yVQB+iLVz0rD3is3xepuV87SI/ApJ7WMd44WOxiq5uHyPLdaLY2MQ6AcdRYjmU8L
	c9FiC+NB4lCQsrBTJw3/7WQ7kBau5OPlCqUDKILF3bqPsasXewfE=
X-Google-Smtp-Source: AGHT+IFUIwYSu6KbEUAyth9XxFqC5nZrcsAdb62v1PqnR10rTpKu/1c9tc94aN8gqcFnCnBkFhMxBIdlbJj9h25BLbM=
X-Received: by 2002:a05:6102:cd4:b0:493:eebc:d77d with SMTP id
 ada2fe7eead31-4a4659ca79dmr8656632137.15.1728980492921; Tue, 15 Oct 2024
 01:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014141042.954319779@linuxfoundation.org>
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Oct 2024 13:51:21 +0530
Message-ID: <CA+G9fYs-BXW2J-n1R7VO2j-qqpP=3nzYC4a2C7=-fnLTW8OR8w@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/213] 6.6.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 14 Oct 2024 at 20:06, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.57 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.57-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The S390 build broke on the stable-rc linux-6.6.y branch due to
following build warnings / errors.

First seen on v6.6.56-214-g8a7bf87a1018
  GOOD: v6.6.56
  BAD: v6.6.56-214-g8a7bf87a1018

Bisection points to,
  d38c79a1f30ba78448cc58d5dee31c636e16112d
  s390/traps: Handle early warnings gracefully
    [ Upstream commit 3c4d0ae0671827f4b536cc2d26f8b9c54584ccc5 ]

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

Build log:
-------
arch/s390/kernel/early.c: In function '__do_early_pgm_check':
arch/s390/kernel/early.c:177:30: error: implicit declaration of
function 'get_lowcore'; did you mean 'S390_lowcore'?
[-Werror=implicit-function-declaration]
  177 |         struct lowcore *lc = get_lowcore();
      |                              ^~~~~~~~~~~
      |                              S390_lowcore
arch/s390/kernel/early.c:177:30: warning: initialization of 'struct
lowcore *' from 'int' makes pointer from integer without a cast
[-Wint-conversion]
cc1: some warnings being treated as errors
make[5]: *** [scripts/Makefile.build:243: arch/s390/kernel/early.o] Error 1


Build log link:
---------
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwi03QYzWjrOZMpsvCF31N0Oc/
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.56-214-g8a7bf87a1018/testrun/25432877/suite/build/test/gcc-13-defconfig/log

metadata:
----
  git describe: v6.6.56-214-g8a7bf87a1018
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 8a7bf87a1018a21d9dbbc5a794cb9a4fb3243aa0
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwi03QYzWjrOZMpsvCF31N0Oc/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQwi03QYzWjrOZMpsvCF31N0Oc/
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


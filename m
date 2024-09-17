Return-Path: <linux-kernel+bounces-331587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C9297AE93
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 12:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128631C21CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7A16132F;
	Tue, 17 Sep 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQOcBs7I"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9355913E41D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726568194; cv=none; b=X7kI5aPdbO+OsQ3ckLlEJg7K6BGY1TCpN4c46Goih/qhuyxwHsSNUqKEUnlzLc7rkwklgimeEjzpTcTLvg2jVAFjYE6w2kk35v0la0xXAHrfarTMkAQVNIYQaaiBhabgoOcbLBJ5SneCX39M4f3hCgV8m7b99JBRFxGqI8zxJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726568194; c=relaxed/simple;
	bh=7uTw2Xdc4FdW8Wguya1dEDJdgUqDCcIuNIjLGieyNvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Afyz7K2a+yq31u2db2adVC3MICv1VnwBv64qiXikOsR7KO3kvnGNxYyVhYmuVdvLn+DdCHOAmXa3NhJUDqr/74bTJPL3XGyWluQ2/TjBRquy5YpRrtTy3/a1VxMgEaHQ1VB+OKQ4g+qvs3mtV+EWd3CGmFEaAqbQuIBtMQacpoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQOcBs7I; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f77be8ffecso59877821fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 03:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726568190; x=1727172990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2RIH+rGbvMwZNuIYE1wkPZCJpfjU4C5REBdV9ppb+nc=;
        b=gQOcBs7ISRRRcF8NQRrUWN5KXEX7yQxB0ujlmAhsw6KN40QhGIz4/PZf9gKP/BMFZ1
         Y8oXu1XbhFKLa+GsZU1qRVcaVRDP4P6N94MkLbEk9NEySAOQ+3E2jHFCBYXfUfaJleMG
         VSMdI+GLHf8AKpW6Ll0Jpp/gnLkVi1OCsxxRcR/8NcbYHCqEvCBjT3vZCBE278EHfDhq
         KZBlrsSPmhLW2SODeYO9BFXQXyOaGVtyqEVA+i5ytj/yXjv5HoaPGBmrX5T9vMUgn5ka
         8PpWphUYOlYEYTdKjarFWDUMPNQ19/sdAR2GKEIlAhv2sklCGxYExms/srHXVyj8dy4F
         i4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726568190; x=1727172990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RIH+rGbvMwZNuIYE1wkPZCJpfjU4C5REBdV9ppb+nc=;
        b=HiTpGoS7KBNsueVe4BRirPK0b+iBnQkJVmEiDlaF+GbwaiFHzFJ7qnRqd6EQcdONK2
         1MiT5Ohxkn8r398k4BLPrRguUtrYwYx2RnkUyQLedw6vHF5JjENMQurtOmQP5Y2gfOcr
         4CqCF0sDUXotfYoOpovTLW3JPa/2xBMqeXuHgtM2w5Z6hjX10K9p6/IGkeKb658hxlhc
         ONfchLmnGiM37Ybx1eCAcMsvp7Yt+kdtLG2YC9mhdktt23AgqrsTOp8Jl06mqIEA7Uvj
         VbBr5/R+mD9m45nk8sC6Kr4sIP7TXq7z+rxa5oLpqjJcwjjlk4ohHyigAgUUQLHoU1sW
         3YaA==
X-Forwarded-Encrypted: i=1; AJvYcCX0XrpdBZ01AgJyVQodDgtqEXCM0FexHWjqWRsk74ADFJf47AM19QuKOcudR9kThI/54ozTr9py1G0QULg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKZnLBejMAx9IQAu+UbpRBekUHtLzpEl4oSnefCUbLNxUNGcP1
	cPMRJx1inSVOOnCaU8bWo5Nhxg8OPlT6vGwBTrS2nUNjybloCEau1rBtvRnDtJR7Fhinzuuuror
	i8yEm7D9UtqXhAMOTLd/u8JGD5MfxWyEv+HhmSA==
X-Google-Smtp-Source: AGHT+IEwjK+qN1NAncZoepbBFqxMMHpAHTJm2GY7gFtHq4zje3zC3w3ucZADOfEc9PbgoFaEb/FwjyKKPawCwz/1quM=
X-Received: by 2002:a2e:be83:0:b0:2f7:503e:ed43 with SMTP id
 38308e7fff4ca-2f787edf4a8mr102581301fa.26.1726568189502; Tue, 17 Sep 2024
 03:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240916114228.914815055@linuxfoundation.org>
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 17 Sep 2024 15:46:15 +0530
Message-ID: <CA+G9fYvw7WaDjKp+v_snxnhgEzUDD1xZ9udJpqQcgAoQZXK5Vw@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/121] 6.10.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Anders Roxell <anders.roxell@linaro.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 17:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.10.11 release.
> There are 121 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Sep 2024 11:42:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 builds failed on the Linux stable-rc linux-6.10.y and linux-6.6.y due
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


First seen on v6.10.10-122-ge9fde6b546b5
  Good: v6.10.10
  BAD:  v6.10.10-122-ge9fde6b546b5

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------
arch/s390/kernel/setup.c: In function 'reserve_lowcore':
arch/s390/kernel/setup.c:741:31: error: implicit declaration of
function 'get_lowcore'; did you mean 'setup_lowcore'?
[-Werror=implicit-function-declaration]
  741 |         void *lowcore_start = get_lowcore();
      |                               ^~~~~~~~~~~
      |                               setup_lowcore
arch/s390/kernel/setup.c:741:31: warning: initialization of 'void *'
from 'int' makes pointer from integer without a cast
[-Wint-conversion]
cc1: some warnings being treated as errors

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.10.y/build/v6.10.10-122-ge9fde6b546b5/testrun/25149541/suite/build/test/gcc-13-defconfig/log
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9VsokpNpc89Dqg5cG7ddRusdA/

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240909/testrun/25079447/suite/build/test/gcc-13-lkftconfig-kunit/history/

metadata:
----
  git describe: v6.10.10-122-ge9fde6b546b5
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: e9fde6b546b56159c192819586894f0e5b8ff6f3
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9VsokpNpc89Dqg5cG7ddRusdA/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2m9VsokpNpc89Dqg5cG7ddRusdA/
  toolchain: gcc-13, gcc-8 and clang-19
  config: defconfig, tinyconfig and allnoconfig
  arch: s390

Steps to reproduce:
---------
 - # tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org


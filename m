Return-Path: <linux-kernel+bounces-555974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED8DA5BEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09B217108D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41D8254864;
	Tue, 11 Mar 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhbDvEQn"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A0E253F02
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741692506; cv=none; b=L6+mLPLWotGvJMGb1Vn2i4D/jAEcisbZDrGnpl2gkrMP5eSnk+bqibqUJMgau5/R7xDpar9/kul3a4ZZOVtf5yIGJEuzwlymDcUdYS6c1EQehU/mD/Pj/zLgGfzCCoywmt375nej+pC7e6wvLXf+Ab8W4+G4P+AF+BhYSQAiRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741692506; c=relaxed/simple;
	bh=QKhCcFTOKZcxNwRQxkRN6jeyMESZi2oZbe8X5GsoGC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNU3yMcmZQI+xsCqWETS7cym5xac4GXew/FlQWkklqiOdaOIYcJVZQDREycjiF4dde0Q31aE4u7KK1xj7BF4/r5oU2L+NxGFL7j04g7dQnwez8EVP3Mri4mmbMruO9d+eN9j/hSB+vc+DuAMQYXzRT5s9iq0VRD3tO09LWtloMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yhbDvEQn; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523d8c024dfso2015895e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741692503; x=1742297303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XGU9rCwd8wb7Zuc7IQ8VVHLLaLioxo+uOkF+No76Mwg=;
        b=yhbDvEQncBFyIaH1oNff+eSGRhsSf38RCpnSIlZPOyIybLgJAsdIkYCkVycPm9ptTc
         dJDW2I9Js9tI3a3dOfiNOIc0t5TSrdEW9LqRx3gHImF8a55nOrJnCSCz6tdz7UhtYUa0
         EzDYO/JqujwYRQPzIW0FdfKlR9sGwLqBxtI9C6DnxzRAaK7GDBB6zhPuMdYU3y7cmywq
         laUyTvQe/I8mf4TWlhEPEhGKDFQORJ/LuwJOxO2CyUY+rOvG5NC/wIeggsFLFMcEVvYl
         Ernkw2aubfj6cDnWITm4g8TzkmcUhcjSdUJ3RHFresX63Iqyd8txOL+fBVT1nnsuJ3XS
         pFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741692503; x=1742297303;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XGU9rCwd8wb7Zuc7IQ8VVHLLaLioxo+uOkF+No76Mwg=;
        b=djpEHsWsNJ1msDvVa6EfPpXZSeoBf5Z52qXkZtvGzMtYdfuOlR6g+vFZGP4A5iUPyo
         6+THmX82l+YCsiwBat1rlR9rPFx8NTYGfOiF+oH8RqJY7/dzBdxaMYEnffyqWXuPvcc7
         cdIzuw/hg4Xb5mr1PiOK9pvRNUmE9ppZFcP2PFYkSdn8IdIVobd5Rhoa1kRV7w2F8Dul
         S+nwc7GYJ8gq/kEb3bTfth7SDziOW83ywCoqxz2Qd1/QEt5fOf3Gl0jNgMbtMj0w4dKR
         ELr1eWyJwtLRIQLJuwoWvac0aGkV74TbMBxhPEAmidTcXoh4SeRdliJh/TtVH3TxUJdh
         RpGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWu0gS+HaxAPck1bdHz2Eqg5k1Ok13Irk7aLpSdydkvrjWaWZSesGHnVr9CUlhsJ1zRVRz+CJopQFBaPvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1q7YN22vDvkS4BYQEIhwALnzXXQECMFxJcwSk3fJPfjOtnN8b
	fRLPKwzsuACSVKJIeiWXly3L6SGA43L9xrlu1z9MmeAywXWZVPYtbYp5TRurn1hjeaVclhZ0XeC
	1W5iyHKe21UaoD1YtHu6rlI2Ds2dOde2h4KkIAQ==
X-Gm-Gg: ASbGncu+6CCtbnYlHSU+Z20OBq6gFoLotsFjLeOrF/B8FHh9TJjHHcGJP8CQdgzWjiB
	h/FwGbrRS6aq/lANQXqsLPqDc3MRtmOGMTpcWQ1UNjQuvN6BhRrdFlQJkpAJx0zI2mBGgGn54AE
	vrkAG2HbKhAKHO6bEaD9wJRCDrZOvQYBdsGC/nqXukujwsjk9qkV1jX+FAgYhlmrK0reBN
X-Google-Smtp-Source: AGHT+IHIxUX3TDbI9Bj9oJA3tOu4WqU0PQypu14bFgLFUww4xYRu0IZmQmo6M3HEkW5aMwnVyGaVlltG5hRPnuZk/h8=
X-Received: by 2002:a05:6122:54b:b0:50b:e9a5:cd7b with SMTP id
 71dfb90a1353d-523e4173295mr10467772e0c.9.1741692503175; Tue, 11 Mar 2025
 04:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310170434.733307314@linuxfoundation.org>
In-Reply-To: <20250310170434.733307314@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 11 Mar 2025 16:58:12 +0530
X-Gm-Features: AQ5f1Joe9hxo4OYoho7kOI9yVsevhYRVxeCstqHW3mY7SICpOCxe6anJtQDqibQ
Message-ID: <CA+G9fYsooQUTWh7RJ_Z7FauV0Oxr0TOqj6NRFKqrsRwRxZh_mw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/145] 6.6.83-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Mar 2025 at 23:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.83 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.83-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on riscv the defconfig builds failed with clang-20
and gcc-13 the stable-rc 6.6.83-rc1.

First seen on the  6.6.83-rc1
 Good: v6.6.81
 Bad:  v6.6.81-153-g70aba17a9467

* riscv, build
  - clang-20-allmodconfig
  - clang-20-allyesconfig
  - clang-20-defconfig
  - clang-20-lkftconfig
  - gcc-13-allmodconfig
  - gcc-13-allyesconfig
  - gcc-13-defconfig
  - gcc-13-lkftconfig
  - gcc-13-lkftconfig-libgpiod
  - gcc-8-defconfig
  - rv32-clang-20-allnoconfig
  - rv32-clang-20-allyesconfig
  - rv32-clang-20-defconfig
  - rv32-clang-20-lkftconfig
  - rv32-clang-20-tinyconfig
  - rv32-gcc-13-lkftconfig

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Build regression: riscv 'RISCV_ISA_EXT_XLINUXENVCFG' undeclared
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
arch/riscv/kernel/suspend.c: In function 'suspend_save_csrs':
arch/riscv/kernel/suspend.c:14:66: error: 'RISCV_ISA_EXT_XLINUXENVCFG'
undeclared (first use in this function); did you mean
'RISCV_ISA_EXT_ZIFENCEI'?
   14 |         if
(riscv_cpu_has_extension_unlikely(smp_processor_id(),
RISCV_ISA_EXT_XLINUXENVCFG))
      |
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |
  RISCV_ISA_EXT_ZIFENCEI
arch/riscv/kernel/suspend.c:14:66: note: each undeclared identifier is
reported only once for each function it appears in
arch/riscv/kernel/suspend.c: In function 'suspend_restore_csrs':
arch/riscv/kernel/suspend.c:37:66: error: 'RISCV_ISA_EXT_XLINUXENVCFG'
undeclared (first use in this function); did you mean
'RISCV_ISA_EXT_ZIFENCEI'?
   37 |         if
(riscv_cpu_has_extension_unlikely(smp_processor_id(),
RISCV_ISA_EXT_XLINUXENVCFG))
      |
  ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |
  RISCV_ISA_EXT_ZIFENCEI

## Source
* Kernel version: 6.6.83-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 70aba17a9467a99637c9355a7eac2cc5e6b102cd
* Git describe: v6.6.81-153-g70aba17a9467
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.81-153-g70aba17a9467

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.81-153-g70aba17a9467/testrun/27569234/suite/build/test/gcc-13-defconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/tests/build/gcc-13-defconfig
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.81-153-g70aba17a9467/testrun/27569234/suite/build/test/gcc-13-defconfig/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2u8VMDUVvHABJlsXGyG5COTPGZM/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2u8VMDUVvHABJlsXGyG5COTPGZM/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch riscv --toolchain gcc-13
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org


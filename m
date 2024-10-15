Return-Path: <linux-kernel+bounces-365264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449EA99DFAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 699551C21922
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF86189BA7;
	Tue, 15 Oct 2024 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pq9sqDIu"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02D189BBF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978619; cv=none; b=KF2V/hsDBr4bPdnk8Q0QwHDhMXsILRT+F8NP0LhVaNTyyYy3BfFewYgn4Pf3HO2c4vmIytK/oK+xzcO9W/sbCWPko6qyXs3XXvw53kOMpBCC8R+4/cVZ3LWD3Y86IMc2wAGqP6Q4Jkk98ZLCR9A3OZZrwmDsCPfqLAwtMthwa6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978619; c=relaxed/simple;
	bh=vOa6EcRUks3vJ+gN4gguaBuawT8MdWJj35kDikZazRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AS0QeDUfUNhH4F5L1dCsxtjV4bZ2QjKOreImKsfWYEiekiTlLqvdJ5SJ4JuHWmJLfVWgyi7GFmJHkM1k8/NoFux3xPQgIgCNLBVb+pS0FPNSXUXumrZNVNNsak5+UPSPOp9B8V+iMTsXoJGNbySLFYH+Na2DhBMBwxBiJc4HZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pq9sqDIu; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4a487a7519fso539564137.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 00:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728978616; x=1729583416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pLYLixg5lxjAYGEflgM8mT9I/QjIrhiXb1eT8NYFyD8=;
        b=pq9sqDIuUiCN6CgXeF98QqUKUiofaqMEh1s8GRRWDBQn1FKcLaYnpBvYsEWGaCehxq
         V0yGJLFFXrIr3MTAQCQUYhjaJyfrjsOA6SqU5kFQKlgJJbA90nxQRZic9loUybr2cNSV
         jm1t3xppD7nyH0a783KUfnEfhv8rmSQtHsk6bELkOthOaF50AAi5hcmNyUB4SDOsWfBe
         s6Hsp1mLL2LzkwtnvJMYRsqFW617kDDsScA5SzRy6Q2tQIcYW5JTytelx19UBLLW10af
         CsabWjARaCKqIrWoq2rq0PCqiiO0ZBBEunmUzAjUfl1hsxBieQCFsWhHCfmwnq5j/s5p
         eT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978616; x=1729583416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLYLixg5lxjAYGEflgM8mT9I/QjIrhiXb1eT8NYFyD8=;
        b=IlyTHMT3K1yuUuRetvhmmSNIqT6h7oPa2pa5sREBmP4XkWNzDPC+BWDK1ilfwClsn7
         WYEcoX5YBrivRU8k0AA+QR+4s9fOI6yW4gAFQbU/dN3ZmffM36YaR5vJB9hn0Wpmyunj
         CjTZensd/GTeKQB11q+kmOy8PmgkFU/7+IddPzujmlxwCaLbNgM9fht2bG5G/s6OCnUH
         8m1CARX8Cbt7wMcTi8nYtTYvrcuISb8+zk/uMlQnCy+dPFaQyfYXqLeWWd/lG5ML6Vpk
         S4M2/hwbFeYL7oI+ldFrp6nXfY6TiFl32FBIF0AYOu6tiQnVB+cTr8tp18jOGFCGVAj4
         5FBg==
X-Forwarded-Encrypted: i=1; AJvYcCVjG0i3qvKrD4pDbxpZsDiWLWlTj6KMdT9P+bOgxAvnQ0UmFKZqQe9sFxrqI/DpgY1HD5Xwayfxg7eJJss=@vger.kernel.org
X-Gm-Message-State: AOJu0YztqZjywVFkxoiacrLAOPleRasoIQBQVtqEDiF84bLKA7L+ukgF
	T3VZdUxxD91KO9SRrqHz8imTosWsmjxlMmUQ+F4AzFc2FuETnbqAu6gtDsM5xxx2dVpdOwoWJrD
	5Z0R4F7VY/IB1tYWjgt+bqkN7AJh8KDif0ifcSg==
X-Google-Smtp-Source: AGHT+IHJTQgMwy07yt4Kv3cxeA6jaDdGJW3Q76nXmTxUbWPQyJERX0qrCdD9zyui+kZPBA1VduE7XrCzaRDLLhLgFV0=
X-Received: by 2002:a05:6102:3913:b0:493:bb35:d8f9 with SMTP id
 ada2fe7eead31-4a475f0bc31mr6236860137.5.1728978615788; Tue, 15 Oct 2024
 00:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014141044.974962104@linuxfoundation.org> <CA+G9fYsPPmEbjNza_Tjyf+ZweuHcjHboOJfHeVSSVnmEV2gzXw@mail.gmail.com>
In-Reply-To: <CA+G9fYsPPmEbjNza_Tjyf+ZweuHcjHboOJfHeVSSVnmEV2gzXw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Oct 2024 13:20:04 +0530
Message-ID: <CA+G9fYvpCw4Dh5BhKjS4bsWix=i=koK6Kw_jU=9zSOFu-UePBg@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/214] 6.11.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 14 Oct 2024 at 19:55, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.11.4 release.
> > There are 214 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 16 Oct 2024 14:09:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.4-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h

[Adding Reported-by: ]

>
> The S390 build broke on the stable-rc linux-6.11.y branch due to
> following build warnings / errors.
>
> First seen on v6.11.3-215-ga491a66f8da4
>   GOOD: v6.11.3
>   BAD: v6.11.3-215-ga491a66f8da4

This S390 build regressions are noticed on stable-rc branches
 - linux-6.11.y
 - linux-6.6.y
 - linux-6.1.y

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

> List of regressions,
> * s390, build
>   - clang-19-allnoconfig
>   - clang-19-defconfig
>   - clang-nightly-allnoconfig
>   - clang-nightly-defconfig
>   - gcc-13-allmodconfig
>   - gcc-13-allnoconfig
>   - gcc-13-defconfig
>   - gcc-13-tinyconfig
>   - gcc-8-allnoconfig
>   - gcc-8-defconfig-fe40093d
>   - gcc-8-tinyconfig
>
> Build log:
> -------
>   arch/s390/include/asm/cpu_mf.h: Assembler messages:
>   arch/s390/include/asm/cpu_mf.h:165: Error: Unrecognized opcode: `lpp'
>   make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/startup.o] Error 1
>
>   arch/s390/include/asm/atomic_ops.h: Assembler messages:
>   arch/s390/include/asm/atomic_ops.h:83: Error: Unrecognized opcode: `laag'
>   arch/s390/include/asm/atomic_ops.h:83: Error: Unrecognized opcode: `laag'
>   make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/vmem.o] Error 1
>
>   arch/s390/include/asm/bitops.h: Assembler messages:
>   arch/s390/include/asm/bitops.h:308: Error: Unrecognized opcode: `flogr'
>   make[3]: *** [scripts/Makefile.build:244:
> arch/s390/boot/pgm_check_info.o] Error 1
>
>   arch/s390/include/asm/timex.h: Assembler messages:
>   arch/s390/include/asm/timex.h:192: Error: Unrecognized opcode: `stckf'
>   arch/s390/include/asm/timex.h:192: Error: Unrecognized opcode: `stckf'
>   make[3]: *** [scripts/Makefile.build:244: arch/s390/boot/kaslr.o] Error 1
>   make[3]: Target 'arch/s390/boot/bzImage' not remade because of errors.
>   make[2]: *** [arch/s390/Makefile:137: bzImage] Error 2
>
> Build log:
> ---------
>  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.11.y/build/v6.11.3-215-ga491a66f8da4/testrun/25429522/suite/build/test/gcc-13-defconfig/log
>
> metadata:
> ----
>   git describe: v6.11.3-215-ga491a66f8da4
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>   git sha: a491a66f8da4fbfc06aedae9a8b0586d11a51fa9
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQsfudCDSTlwmKIKEozbcVOnCs/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2nQsfudCDSTlwmKIKEozbcVOnCs/
>   toolchain: clang-19 and gcc-13
>   config: defconfig
>   arch: S390
>
> Steps to reproduce:
> -------
> # tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
> --kconfig defconfig
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org


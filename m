Return-Path: <linux-kernel+bounces-228717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E939165E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AD1C22ED2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0153014AD20;
	Tue, 25 Jun 2024 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktLqtgEq"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0A1494A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719313793; cv=none; b=uJXIVsm+4Z85+VCR6cXe6PsTbpRlMgye5aAET/wa8VhQn4JubjPFzmQiJ02YRAsf1ouOAAUC5FWZqUmsH0Ij56dvTTzRrID+F5F9zgTedg2EXjoHNfe4tBvhXUGv7ApGW7qBEvK7Lz56yr+XPCNlhw81HtdWUjIUF7YzRonIcoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719313793; c=relaxed/simple;
	bh=Jqx5709BtugoJVZY8NxxbQN9lreP98TY5Wx/Ks/oQYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFlZWzaXRCeBMQWOVqy1ywaXtFlHggj0g9mV5jXuk/dcZDo/+L76QUPRy01QzkvioIFcyXgkNNUlpgPrGELSaDqrxdXuEGa98At3YB/PUfJczBxB08wUN/hTfbdzEpUtskEogBvKWiBBbOKCwkR7DNhqg1+xRFltvpSYw0g86aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ktLqtgEq; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4ef2006dcdbso1976480e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719313789; x=1719918589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7R5wxQYwGfaVqYk9QukhujZ0AZZW5oBR/ydEPdcFLQY=;
        b=ktLqtgEqTsgsLOw6wbl1i5nZj+ns2kLIfV3gYTu7GBQWXOD5DeiEzObL9uozmI1UzC
         g4EqnO2nbCVuFO4nBgNOoXj62gqfZGWRw68GgWi3jSihs2t/C/nzOf59v4r+D1uOfV4j
         +AILEFikozgn6ndX7m/r2y4F6r8llmadDA9cN7Qhiy+jfkyyvcpjfbt04cpsyMtuHAix
         srJwbSsY/5cMCZvejBWDP2635a7l6hG54xvEryAxk5d/Ckx/GkTi8mMNimYKZFoK9fQ+
         JsK+jgt1znZlAJJmLic7wbcuIdTGW2/bu9RwQjXDpzV3yLD21PIdua52nhfmBSq05DT6
         1Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719313789; x=1719918589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7R5wxQYwGfaVqYk9QukhujZ0AZZW5oBR/ydEPdcFLQY=;
        b=eiVETdtz0FgkKOCrZQW8p9Ay1Y8A7/YexXI4IR9bBq7k6YAnE84V6FkCNAxFMdSJfN
         yZOE7Cd/FuxwEGtQVFFpCLuYAbUduvHfQHQslKiw8CXx/HXUPN1kcyARNOgVwZt9y1lv
         v+YFDhb0AP02yGIYRNtK4lIzAZm4cBNC9x8tuc+CS7XK2KACnngeoSx1UcQA4r3OgoZC
         5ukUXjQlnqOtPWl2Mttr1o/pPV0Pvy4Akdc7/sOBol/DvgboqQ1u8DrtZcDXhMOdyFf3
         ZcMUf++8OcEf+PgUJa00Yvymy2B10f3PwOlVC2z2VoC9zsQvwf+m/VeZrW2CoUCHtc1g
         WTIg==
X-Forwarded-Encrypted: i=1; AJvYcCUzdgkZ+uf8oC01OzGdmzBhL41Xh+Op01E6Ngqt0bEIVV/8xjdQ3UTD4MDKdNVd/Wt/T2Cze2vaLs6wuKqa58YbszrjwIIqIOw4ELps
X-Gm-Message-State: AOJu0Ywx1YnIrPQIwk84JXzeIp2EAIYtE2uGY+9O8dbKK7ZHQTVTwxUe
	kfEvqgwgKfSDLf2sDRSar9kuV/io2w2Xt/ZCsWyIozsj7fuW0E66+qR/ppSDipIzU7kfIhb7N0f
	7oyMNXF5JFVmVLhIKJutHevLUyXD+9ZiD03UdRA==
X-Google-Smtp-Source: AGHT+IGFPvgQg1o9LeRDhdQ+qJIJ+JQi9wNh81iGlEdpy/Tfa/2hvfiRTSb4TnSM/hw5l+hirYUDOyyZZbUacxz0ZYk=
X-Received: by 2002:a05:6122:411d:b0:4ec:fc23:7928 with SMTP id
 71dfb90a1353d-4ef6d892a1dmr5555079e0c.12.1719313789305; Tue, 25 Jun 2024
 04:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625085537.150087723@linuxfoundation.org>
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 25 Jun 2024 16:39:37 +0530
Message-ID: <CA+G9fYuWjzLJmBy+ty8uOCkJSdGEziXs-UYuEQSC-XFb5n938g@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/192] 6.6.36-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 15:18, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.36 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.36-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The arm builds are failing on stable-rc 6.6 branch due to following errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
arm-linux-gnueabihf-ld: drivers/firmware/efi/efi-init.o: in function
`.LANCHOR1':
efi-init.c:(.data+0x0): multiple definition of `screen_info';
arch/arm/kernel/setup.o:setup.c:(.data+0x12c): first defined here
make[3]: *** [scripts/Makefile.vmlinux_o:62: vmlinux.o] Error 1

metadata:
git_repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git_sha:
580e509ea1348fc97897cf4052be03c248be6ab6
git_short_log:
580e509ea134 ("Linux 6.6.36-rc1")

Links:
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2iMq0CHppQGxkVSsEPFtnw08bc6/
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.35-193-g580e509ea134/testrun/24441308/suite/build/test/gcc-13-lkftconfig-debug/log
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.35-193-g580e509ea134/testrun/24441308/suite/build/test/gcc-13-lkftconfig-debug/details/

--
Linaro LKFT
https://lkft.linaro.org


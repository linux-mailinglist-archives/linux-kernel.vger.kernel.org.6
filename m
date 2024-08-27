Return-Path: <linux-kernel+bounces-303650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE26961309
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD711C22656
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDEB1C6F40;
	Tue, 27 Aug 2024 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cshmBU59"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D95519EEA2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773187; cv=none; b=NKw558L/8o6eO8VLWLPl+S/9O12p184rFKuu4MTJS5kbrLySEt0x3icr3FGutB8LqVmLCOF37VODZS1CDpGd3NkXgwd/3tzn7Bcn66yr09vfkI+mwxlgtTGBUajFjoyJNQt1YQigDeBgdJyWdF2rQOelYKtqcqjMX1csZncBWkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773187; c=relaxed/simple;
	bh=J8i0Lb2oWbc6JBapK1BY0lUoCq02D7GVagTSdbkqv1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdcsSRkM2zkOAZszb8c9SxJosYgnFKo54SIuBwzXJm80wWLJ5RXTLMxYfLGjU3O44MJEW5P05OHptce7L9TvB2ni/gxTRlBLp8wKJqWbAFthqgJolxw1SeeNW9PZOpk8ilN1Z+afILfCJxM2C2ZzTNT8jmiCcSdZhjyd26Nq2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cshmBU59; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5dcd8403656so2810549eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724773185; x=1725377985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ABrGPaQeXTHEpHj1nG5eL4qDwA/TNxf5sECkQr9qYBQ=;
        b=cshmBU59B8Y5XavgvLSrMfF/g+ab0w0/qNjaBmPn8DOLpyzD5OfHW28NZoxO+y/oTC
         BrJSIy0yTwDQX7gSxm81rMLhIk1MTNjXSx51UHSRZuE8VxYP5IE4EeJFMOL4FR2/51jP
         6fejy1vw2Q1cIQz3hekKQqAjtD2xRdcfl0IdLNyd/fJVP+6hLH9D2bDNJFicZvbFF/b8
         jlxBTQdCHX43+sQ/2rGVN1RH1SY1RJcYYrwV1WQl+wdrAwGiEiVS8epmlrjbWSFnOJHe
         w/P9zdhuWd4r+18VLvYdph2jW4Ml7UYQXD6el0w4QvHnNdGBN0Y/NKFShBbs03paQD++
         dwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724773185; x=1725377985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABrGPaQeXTHEpHj1nG5eL4qDwA/TNxf5sECkQr9qYBQ=;
        b=NJy/UNvIjh6lXgNtOa6XgrcbH1rQoBIakrXvJFnObc7yF4HCXHb4hUSQTIDUMEOarv
         YEr+GgMeg/1jDC1R/mK6bnAsG1ezPDWO1k7bc82nptRj7kb662UxGZ6mZQJUfUMymtvS
         BjwCkGlWVgDBv2qe6F8CIu2vz+Ke6oOgIBDeDZwUx237goddzEyvPL9PGrAstq1vXRFw
         sTOt+WOu6pYKduigr6bGeoNaa/OaFK4C8Vm4nl4pDkfa6L0KkF5F9SC6oYaUZFn1R4Nz
         aM9P9BEETxxQ0GMooKjooWk/b7vmLWebUDAvlN4MKi2wdHrRqqtnKhtihZZuYQw8IzIY
         fe7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVv/Vpwzf5nWEJUrFv9AEQDVfK1Q6xWNGIKYzWXMVGSOtXWWhUAqVHiSJ/QG+47nk96e23U3Z75GN6jE9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlCAczXxoLj0XFCE9Mtp1wGPKY/lIdDRz9Ml0IwaPI9fSJWwAJ
	Rlj1/yGjmIcbAOdrvfATTaore0am28U++Ph+TbzfA6cb99QnjkHJxgwpeaZ5rhvnbbOWvUqQ+js
	H17xLfHkzJrHAWO1vY1kMhOoZt5AEMfkzMWJhgg==
X-Google-Smtp-Source: AGHT+IE+kcBunpFXfOGpuNdas/X5FdTgaWsUmcSrsoP0VkiG4IG6IRfZg8+GgGc5TZDGinb+7wjme3MyFaQZ0qKWfPE=
X-Received: by 2002:a05:6358:430f:b0:1aa:c49e:587d with SMTP id
 e5c5f4694b2df-1b5c215d7efmr1740185555d.18.1724773185173; Tue, 27 Aug 2024
 08:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827143843.399359062@linuxfoundation.org>
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 27 Aug 2024 21:09:33 +0530
Message-ID: <CA+G9fYuibSowhidTVByMzSRdqudz1Eg_aYBs9rVS3bYEBesiUA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/341] 6.6.48-rc1 review
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

On Tue, 27 Aug 2024 at 20:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.48 release.
> There are 341 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The tinyconfig builds failed due to following build warnings / errors on the
stable-rc linux.6.6.y.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
-------
kernel/rcu/update.c:49:
kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
/kernel/rcu/rcu.h:255:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  255 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors

Build log links,
------
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFMi7HOL2XF8hQWViw6CjE3NAF/

 metadata:
----
  git describe: v6.6.47-342-g0ec2cf1e20ad
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git sha: 0ec2cf1e20adc2c8dcc5f58f3ebd40111c280944
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFMi7HOL2XF8hQWViw6CjE3NAF/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lFMi7HOL2XF8hQWViw6CjE3NAF/
  toolchain: clang-18 and gcc-13
  config: tinyconfig


steps to reproduce:
------
# tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org


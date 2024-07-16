Return-Path: <linux-kernel+bounces-254439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B715C933334
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698031F23007
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6512F757E5;
	Tue, 16 Jul 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLfEyi+Z"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA9A5337F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163670; cv=none; b=JS2mo/kJXtabuypL2dPr1MCa/vyNI/fp8JjtXFZEYu9cWi2A/bNleFt+M0JVMw7XW4UuZBd4/P0Cj8zTvesnBWjWAaoKuLVpWWTGQ+XqZOjKLrAXOiQvwsnPtA7WVOhVCDa+qo6tDbrAnM+UfJEHRJxqvY2dvDUAsdBJeT1Oadg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163670; c=relaxed/simple;
	bh=ZhvJI5sTx3hlaxf+nVUj/uhFdYJslH/ZJYOw6nlbEVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/fblYmtqGKn7cxQqlLD9s4FXHS0pKhb8TXL+c249paSOubTLOJVpfF0m/HheLJ6n+2aBiIOA3mndlQGOk7Q3wuK+6ityGsb8TunaPuOkakpvl/8N0uLjQe6NqXS0wx38AKpF+5QqUMjJ+FFNJnki2mIxKryt+60pI41+9/ccXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gLfEyi+Z; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so272010a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721163667; x=1721768467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fYlSeh/88dyiZHtXFw2OhH5nX5oaBfRET6Js1Ip/Ous=;
        b=gLfEyi+ZAcaUSNZoeaGx4EDHwdqeQCdq+/nsMj3Kdaa4Pntu4YNLsHj1aLS3vrcuFC
         rQ3cWjGJg9esj7zxU2pweD7Z+TxJpk89ub7We7xVLG7kw9VaSJss5Q9UvD2z0J4S3pMP
         v87YezsYdOKGeSO9QJSia+MONPzxDwoJ7AeEj92snlWvf1dwaePUlx1/nxDlmRkrMDhd
         uARSEjLBZYQloSDVkT2MmlLoIMTYX96hx+i+Ma/2tBWG3fV1iFoHAY+usGUOCy87Y61/
         3coV2622gjXQnlGxnHtjkXIN38rK8zhuBTGgtCrz0zPP7eh5CZ5aQA9EYntu4ad21gxE
         JE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721163667; x=1721768467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYlSeh/88dyiZHtXFw2OhH5nX5oaBfRET6Js1Ip/Ous=;
        b=hV+9dZ1IXQmV+NJX0MxmAcNx0KVHzHZK1UVZd3kGs0V6F0fxhLtkoSCG2Ebg410Ehv
         dnuYUCHwtov8dIxzKQLpMaDAV71V7OTFCSEf93NyDjw9A+WVHcYVzxX9wIlUCmyGT3Tt
         J934dbz5e+gh9Ro/DGMtAky0r6Zun1Xhg48i0zonLJo8cAbZOISY7mU3v8MPyqtQQwwN
         p8BHnYVeTfySgTXjGgCRg5Du7UE4cceYL+xXISuVvE+EO0zgJY75LeED4SkBHO6t/+Jl
         XmjIOzCY3Po3JqcRubNetq4QFyJi0Gl5UoGE/MDB8zL7lWnCjDpnoKTkt2t3QyfYYDUb
         MNpg==
X-Forwarded-Encrypted: i=1; AJvYcCVRJQh8zYDyJJemYlgVcb+YCLBWbiXiBYS2vkvcfMWynEUviAOypCUjNUk58AyijSpXe/vQa3oikXprAAiWhiuVqdr7aVJw49NrL/fW
X-Gm-Message-State: AOJu0Yzu0oTQQnBF1V80DAYBk3Jx+doRseJowHayuapUKHnfeFaIJG1+
	UKGxKU8oaPXzP58EgHC5onzw+8r8hzqn4E5e6TVBswJ5SU5JvqDU01xfBRrWuqnBSYoPAl4ylpM
	WOTKAWix04ObAUXjOSqHipmyXXDssRwHd/mBI1w==
X-Google-Smtp-Source: AGHT+IEes7lVzd1zbd+s9TAKyx+L9TnicLPt0I+L7F357KcgZRffzmyibdwIUXmFNYxp+IcOu2mtDYhIAaviAT2JQIk=
X-Received: by 2002:a17:906:231a:b0:a79:7f2e:d308 with SMTP id
 a640c23a62f3a-a79edcf457bmr328307566b.25.1721163667236; Tue, 16 Jul 2024
 14:01:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152738.161055634@linuxfoundation.org>
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 02:30:54 +0530
Message-ID: <CA+G9fYuhFAiB_bnPpAC7sW96cyPHE3wGi+Q+=bNuXcmMzGnu=w@mail.gmail.com>
Subject: Re: [PATCH 4.19 00/66] 4.19.318-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:04, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.318 release.
> There are 66 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.318-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The 390 builds failed on 6.6, 6.1, 5.15, 5.10, 5.4 and 4.19


* s390, build
  - clang-18-allnoconfig
  - clang-18-defconfig
  - clang-18-tinyconfig
  - clang-nightly-allnoconfig
  - clang-nightly-defconfig
  - clang-nightly-tinyconfig
  - gcc-12-allnoconfig
  - gcc-12-defconfig
  - gcc-12-tinyconfig
  - gcc-8-allnoconfig
  - gcc-8-defconfig-fe40093d
  - gcc-8-tinyconfig


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
-------
arch/s390/include/asm/processor.h: In function '__load_psw_mask':
arch/s390/include/asm/processor.h:292:19: error: expected '=', ',',
';', 'asm' or '__attribute__' before '__uninitialized'
  292 |         psw_t psw __uninitialized;
      |                   ^~~~~~~~~~~~~~~
arch/s390/include/asm/processor.h:292:19: error: '__uninitialized'
undeclared (first use in this function); did you mean
'uninitialized_var'?
  292 |         psw_t psw __uninitialized;
      |                   ^~~~~~~~~~~~~~~
      |                   uninitialized_var
arch/s390/include/asm/processor.h:292:19: note: each undeclared
identifier is reported only once for each function it appears in
arch/s390/include/asm/processor.h:293:9: warning: ISO C90 forbids
mixed declarations and code [-Wdeclaration-after-statement]
  293 |         unsigned long addr;
      |         ^~~~~~~~
arch/s390/include/asm/processor.h:295:9: error: 'psw' undeclared
(first use in this function); did you mean 'psw_t'?
  295 |         psw.mask = mask;
      |         ^~~
      |         psw_t

Steps to reproduce:
----------
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org


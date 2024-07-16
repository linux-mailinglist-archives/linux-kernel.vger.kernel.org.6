Return-Path: <linux-kernel+bounces-254425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA6793330D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2513D28409A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B31550297;
	Tue, 16 Jul 2024 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeEWI9Ey"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87708208BA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721162889; cv=none; b=usDv4VDfyJOB4spo2x1i25hLMEhvYxWzLUHJHenO80p8H6bXB1HBWyYQu3a4Ym8V9aMPN9Qr+cqVIqITffKgey+vqrNNN4igKYvVmWVEWs701rKsiH+MScL5tQM+mbATmZlZ2TYF3UiUr/BVDlVP962yc8sXt1bSDFKzaHD6MMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721162889; c=relaxed/simple;
	bh=4Ur9xhTL+sC+z2fRn1LeIE7AdwT2fsvHEHXp8cMQVuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4/A2zeUckluDtkfjRiCms46C+cneKDD87Y6X/ZC4eiACNtX+oi9uiKWYBRSNnXpFF8zXqZ6yBxSnL2EkO+ltEZ64kdbNIeLJLYPbGx0KlJ2laNhK96ct+IIupJXaiBhT/buHm9QygubmEFpHfzt0s+/WTVauDLWCoiWDVBf1rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VeEWI9Ey; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eea8ea8bb0so112216261fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721162885; x=1721767685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c6GNJjXe4aQne+TSaa8LyLS0Eu5HZLIaZpjqqmJNiR4=;
        b=VeEWI9EyciqbuLf9Wa6+20MtEkcqAiPa0hUJdiMZRrfK19fu7kvXwJt26/ApcaKTEd
         3johlFxLkv9XlRej+faKj1CpexjMXPyZyZThJsn475vAOzpLeWRGDSoz0Fp34IC4j4VM
         fyxkDvlmlW2Xz0pHzCRsLPMFjxKwKwIjAKmUnQzq8e864Xx4vO1OMItomdxA9mL87+1I
         irU8Hlhy8NbKe9lud//6DUr9DKYueQ23DzmA13k74Tkog+qOoMcKmKChzqqLYG1WihQK
         ekcxNqYjIn9ubooPSvYwt5+idyhK5cqLcFBbk2Bvi+ePDfNe5rWaGywGCRy7+c8p24xf
         c0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721162885; x=1721767685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6GNJjXe4aQne+TSaa8LyLS0Eu5HZLIaZpjqqmJNiR4=;
        b=OvHZUMhJJIGRkA2Z5vzeCWYUWxGtjM7NBIgCdy2Ia5Y3rD8YmLkxWNc4ZFBSw1GS46
         pCOvUbFI8/9ANaELDD84OEGmFJNHH2XLbYB/7pgNfvv2tF27pre9/lNlatoyQI49LICB
         1N8EYsp/wM0nutu8j+XZNg0ZRP3rJ9Li66e9/ZchhgoseAj8R+adb13y9orQQtQOE9yY
         3PZw0nIShXLKqa/LA7yeDkWLJPsikPZftEqQf6UoGVPQ3i22jM1UFu32PDJiDNPVsRXU
         3A+Pqgka1KHgvZjgniqzEzvdE8z8mOhHiNupYSu0TibsDTsZEoGf/OGxC37YMSfAHIQ1
         6G3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEnCfKCvqlSa+DPfmwfrSQBQj0HoTRMae4yij7INYWhlAAy+CwrmL/AXpXnbcdsbjX09Vi7D9pHUcC3P2CHJnO29RX5XQkJZpk0Vpm
X-Gm-Message-State: AOJu0YyMBd1YqjkdX/6S+ubR6SBuqr550udj4jvbfOHjc4t1F2V15bTu
	GKS9az33llX+ePv1m/VKDb6/wVr0ae1f7u+Sa6tPZxhSa3rnW3c6b+eyhY+1QwAum+UBHv58Yj9
	l/DmqNaUctTWYyRQyzl1zIVobJWgC9v+E8r45JA==
X-Google-Smtp-Source: AGHT+IHWB9+UFZMeujAczzwgAyMeRBak9A7BEJ7/zhXCtvVtyq9dOdepGTchh2FUJeUis1miwAnEDhoODIErtZbpgPQ=
X-Received: by 2002:a2e:8205:0:b0:2ea:e74c:40a2 with SMTP id
 38308e7fff4ca-2eef4173e8emr28566101fa.20.1721162884653; Tue, 16 Jul 2024
 13:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152745.988603303@linuxfoundation.org>
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 17 Jul 2024 02:17:51 +0530
Message-ID: <CA+G9fYskex_Z+r0wxv7XDdPVHrk=8jBPWH601mY_Q2mKDj-T=A@mail.gmail.com>
Subject: Re: [PATCH 5.10 000/108] 5.10.222-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:12, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.10.222 release.
> There are 108 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 18 Jul 2024 15:27:21 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.222-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The 390 builds failed on stable-rc 5.10.222-rc1 review; it has been
reported on 6.6, 6.1, 5.15 and now on 5.10.

Started from this round of stable rc on 5.10.222-rc1

  Good:6db6c4ec363b ("Linux 5.10.221-rc2")
  BAD: 4ec8d630a600 ("Linux 5.10.222-rc1")

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
linux/arch/s390/include/asm/processor.h: In function '__load_psw_mask':
arch/s390/include/asm/processor.h:255:19: error: expected '=', ',',
';', 'asm' or '__attribute__' before '__uninitialized'
  255 |         psw_t psw __uninitialized;
      |                   ^~~~~~~~~~~~~~~
arch/s390/include/asm/processor.h:255:19: error: '__uninitialized'
undeclared (first use in this function)
arch/s390/include/asm/processor.h:255:19: note: each undeclared
identifier is reported only once for each function it appears in
arch/s390/include/asm/processor.h:256:9: warning: ISO C90 forbids
mixed declarations and code [-Wdeclaration-after-statement]
  256 |         unsigned long addr;
      |         ^~~~~~~~
arch/s390/include/asm/processor.h:258:9: error: 'psw' undeclared
(first use in this function); did you mean 'psw_t'?
  258 |         psw.mask = mask;
      |         ^~~
      |         psw_t

metadata:
---------
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2jKrKyHqAZ7eSsKwMSVqDueYpKo/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2jKrKyHqAZ7eSsKwMSVqDueYpKo/
  git_describe: v5.10.221-109-g4ec8d630a600
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: 4ec8d630a6005e1aa82671aca9f6716039f5b6e7
  git_short_log: 4ec8d630a600 ("Linux 5.10.222-rc1")
  arch: s390
  toolchain: gcc-12 and clang-18

Steps to reproduce:
----------
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org


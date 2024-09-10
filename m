Return-Path: <linux-kernel+bounces-323111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 042CA973816
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BBE1C2440B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AEC191F96;
	Tue, 10 Sep 2024 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FL1Y99ET"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB77187862
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972904; cv=none; b=H24hWcWp2Yt8KhNQ4LxZf2k9NbO7/16itGoF5ykxoZswQaSAbJt2Vw2ZLyBj3TvEGfWHZyseXhLtwNJ8dppfA+8lUCuYVbmWJu338W9udsnVqWr5B0DBa8tIG6MXECqdY9qNlO1xca1KNK9otF60HCDuQ+PQ4HRPwK9QWNyRDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972904; c=relaxed/simple;
	bh=SxAkh8uwuAT5ozfDLH78xfu4BSQGaw3OBgkizGvRl1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzDPqk8ekSp4KtYMZballWqJjUYKQugfzsSUW9MJ/D8BL/ThhBS4OSxBsGrffN/Kx9Pj4NANBPfIvu3TO9hmmjBPie719nFzGbY9sNLqfZ2zqpdwN+ARtHWLXVFsZ1zpHHYHDylFEDea1szoFRwpl/Ct/qcRIEQGNuu9QXnVEYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FL1Y99ET; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-50108a42fa9so1402706e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725972901; x=1726577701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VKyjedl/ddqMl2FSPgpGenJy9ELX4V7Sr7TvuPEW+L8=;
        b=FL1Y99ETj94lbEXFmCGW0XZlPfSkzc/bQs52y+09fonLHjt2A07ugzcNKjqK1yYncl
         nCPFN9zF6kWawploi5Skc3fuwyIJyDO+F3A3sTJadpGl7dwE2xmbolmLiD9Q57/nSjif
         O4BjVPJk3qUBZ7MXVTX7frKSF/QaHxz0fFL5i+DQGslDaI29tVeBzCTUDiqf0cp0NGjG
         FtmT0m0FAHiyLLenz5TOO2F93UpZ626Qo+n/h5pmVw8ntZ4GPh1Z86IzNAUSUKJ7Qzys
         lOg5Ox3YCXiGv/4TF/0j8h4qnpm5TU88K8zZUhPFUjr8Y/GyHyvuOvyX9bNa9rpWfkaY
         cs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725972901; x=1726577701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VKyjedl/ddqMl2FSPgpGenJy9ELX4V7Sr7TvuPEW+L8=;
        b=f8ROakTNRIElezHOCX7km7Yg+CRj6/SftYhrpYFHTj3e7AhBShw4hwJTy+JoRLd99J
         nnDKOD6aYAii3Mw8KJ8wIwgegNfE6ue7OrXBl1lwRgY5xJ4PIs+UAnqWSB931lx0KqbM
         ntEc1zsCwW106oDdvr9puSuq7jOZS4BlThxc4Uh7DkDgnAiBsUPukQbbgegX0Jq2FILd
         IfCsVf5ZSrl3K1hx0GlbrcuEBsArIQAyPjwKu/06xDOsa/YaJYfkVkp8cWHb2hAm+yFS
         P2j4jMwHfNfc2ZUp9zgQrhT4Z+A3EzFIXcULmaX8x+Gk5bfrSKRlrn6jKvMvS4nb8T1p
         v7zw==
X-Forwarded-Encrypted: i=1; AJvYcCXSoC06rdrQYRyjQ1EzmcrW6U17ou+NqgIYn6YpsewntWEEc6uLbt2hpFmQS0xrC4d8hsADnd95+X+kyso=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv7whRVjSduX2jL0uYBekdXhtlh9ifhw2EvCey/fLR5TwCQwV2
	n8vKqbW0fbzYsOs0jREACgznpksmsBTvCO5kK+VDeCONG2neYs4C6m/Ro3VZNFb0NEheV66Y7PS
	VAwck5Nxs4apiICID6HIwpk++v4LqwiZrvnKHUA==
X-Google-Smtp-Source: AGHT+IE9Y+kfYN5IvRsvDOEmVUj0DoGGOvJjlae15nGIZcPP3XpU1vBEgCqkifEGq8ljbZO+kQainr+wo6QGkyfH4b4=
X-Received: by 2002:a05:6122:ca7:b0:4ed:12b:ec99 with SMTP id
 71dfb90a1353d-50207bfb04bmr11342577e0c.3.1725972900980; Tue, 10 Sep 2024
 05:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092557.876094467@linuxfoundation.org>
In-Reply-To: <20240910092557.876094467@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 10 Sep 2024 18:24:49 +0530
Message-ID: <CA+G9fYufdd0MGMO1NbXgJwN1+wPHB24_Nrok9TMX=fYKXaxXLA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/192] 6.1.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Peter Zijlstra <peterz@infradead.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 15:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.110 release.
> There are 192 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.110-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The SuperH defconfig builds failed due to following build warnings / errors
on the stable-rc linux-6.1.y.

* SuperH, build
  - gcc-8-defconfig
  - gcc-11-shx3_defconfig
  - gcc-11-defconfig
  - gcc-8-shx3_defconfig

Build log:
--------
In file included from  include/linux/mm.h:29,
                 from  arch/sh/kernel/asm-offsets.c:14:
 include/linux/pgtable.h: In function 'pmdp_get_lockless':
 include/linux/pgtable.h:379:20: error: 'pmd_t' has no member named 'pmd_low'
  379 |                 pmd.pmd_low = pmdp->pmd_low;
      |                    ^
 include/linux/pgtable.h:379:35: error: 'pmd_t' has no member named 'pmd_low'
  379 |                 pmd.pmd_low = pmdp->pmd_low;
      |                                   ^~


Metadata:
--------
  build_name: gcc-11-defconfig
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lsNsLYIfqdkNQOzLLZO4lq580E/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lsNsLYIfqdkNQOzLLZO4lq580E/
  git_describe: v6.1.109-193-gb220bb28da0f
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_sha: b220bb28da0f6a629a0d88be3f8e57ea5025c728
  compiler: {'name': 'sh4-linux-gnu-gcc', 'version': '11',
'version_full': 'sh4-linux-gnu-gcc (Debian 11.4.0-5) 11.4.0'}

Steps to reproduce:
-------
 - # tuxmake --runtime podman --target-arch sh --toolchain gcc-11
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org


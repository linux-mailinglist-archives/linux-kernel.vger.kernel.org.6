Return-Path: <linux-kernel+bounces-204474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C4C8FEF8E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49811C2350E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2AD19883B;
	Thu,  6 Jun 2024 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GE9OG3gr"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1E197A9B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684131; cv=none; b=N8gK31HjljxSkUj3RtNHB1lg3Ip5/yqkW460ioXi6PRFZI47UxVzmn4GVT37VjuydPeyCwIelm975gk6CyK4DCfL+MFOrt4R2KOMrCuGs+iCd7TKMX5H9sG/DQ0m6sAqK6dhkwC/rbb2BgJc1Q4V7ZDKPjJsis/ySjucTmHGpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684131; c=relaxed/simple;
	bh=SuESpoipjH2XBuKfLdMHPYPL7Cn4gPPdzQBAHmXOeUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPAtbb5Ogd1Kt2mc4y6MYwr9n7tXufzjdSu0dYZkTvhMhw9tHpUyAbOWxBkQviV6AJhyoXZ/Atxqb8iGW/c0aJ/t6SkxD07+owlNowQ7L+1EZH6YPVHucz3SenZ5VgbU8tJs93be12R4c3tIqcFJ47DDNDFfeqIg1UWNI4Pc9MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GE9OG3gr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a690c8e64bdso58072366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717684129; x=1718288929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eWeMi1z4JCK+XMEvQCFUyZ6qEqWXaYSEpXs/63PCyO4=;
        b=GE9OG3gr6teeIM1KJnJLDYDmOPqpwHQbbPJVJWWRa8e+qvNahDSuBP9EMHB1Z9zCfS
         DzNtEaVZJJ4hwL/z53TzutQUT24hSRl6vbiND4bdn6PgnyWdAkAouTpQqx3hix5dexEG
         Tw8bNQQp+8XYUV1FNKoIkNbGyZS17Cbwni7AgaebK0j/Q00SVjM7qMXb+ha3Bf9aF/yk
         dCTxuw2+l6l3WLVfqbRE9JribsHXEiX8Arcmt1rVT80LET2F4DugZsoHkP5lSN5VWE7X
         2PmVnHPZe8vtZjOMA31F+a1+FJhF4m5011HBWuVUFIGBbED+puBLT5foYVRTEXYBuMO2
         ziBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684129; x=1718288929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eWeMi1z4JCK+XMEvQCFUyZ6qEqWXaYSEpXs/63PCyO4=;
        b=EFgjGZAVtAc0vMGMV8liO7GAGmGzTkYqO2OKZoVvm1dsjPf0Ki1ysRwKMAvwTWAk41
         Sf0613Voq01qVbYnhNg/cM7ji6EmFaeh4rUDZjxSBVZeW3B1jx/PgsEgj9s+RyPeMPT3
         ek0m2ygCtVSD2B/i4WOHOPVE7kRAnaC4peTS7FYOKm65JvKF6XiYztHkSietgqo7fLZx
         6HN+AFXJ8FaCwkX32c1DCWii7XEhiAclZvxOJ9FWZMPlc5LQfHN0cL/zrmfTdgBWZwrn
         0zvrlAGQHqvlCrcbb2eLJVH9Z9cIzZM1NAsdb0VnKg5agrgoX4kGzYOq6lMhvVmtV6la
         /Q0A==
X-Forwarded-Encrypted: i=1; AJvYcCVNWMWaczSaUhmVuLzKGs/qui8Z6wzpLfhtphWJI3xZa17ifX/YuJhhfWerSYTGhBuT2ueYQclw3n4vkNsfmHCqnmpjVjkfvSIGVt5g
X-Gm-Message-State: AOJu0Yyt0qvLNTQz1wBH+1FwqKDD4mBqkJMPKglu1zam5nhfQMKjYr1I
	uepddtRrAC1Jy05NcMY9+ug0zfeXH2mhE//C5LhdKxL7HR6Ee4Z+QOVUak9SRn0EVzt5hZe/dEg
	fDhV0OdmHVWWB5MU8Gdr09z1bpMS/Rk0wV6TVSEzEzLQBa3L3WS3FCQ==
X-Google-Smtp-Source: AGHT+IG8pQ7JMnVsI3Te2WeC+Hdtmyjd7l9vtYflmm0/97yZOaS7cvIZtnWYmC1G8hdhlyHcRvLuuSiYPVSyaA6Wfbc=
X-Received: by 2002:a50:c315:0:b0:57c:4200:a958 with SMTP id
 4fb4d7f45d1cf-57c4200af44mr1264695a12.35.1717684128664; Thu, 06 Jun 2024
 07:28:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131732.440653204@linuxfoundation.org>
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 6 Jun 2024 19:58:34 +0530
Message-ID: <CA+G9fYu2_bDqLixtW385KX5Vsnrmsi=FxQVgwUgnZ9qztSLW=A@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/744] 6.6.33-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 19:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.33 release.
> There are 744 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.33-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The Powerpc build failures were noticed on stable-rc 6.9, 6.6 and 6.1.
Powerpc:
 - maple_defconfig - gcc-13 - failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arch/powerpc/include/asm/inst.h: In function '__copy_inst_from_kernel_nofault':
arch/powerpc/include/asm/uaccess.h:177:19: error: expected string
literal before 'DS_FORM_CONSTRAINT'
  177 |                 : DS_FORM_CONSTRAINT (*addr)                    \
      |                   ^~~~~~~~~~~~~~~~~~

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2-803-gfcbdac56b0ae/testrun/24217279/suite/build/test/gcc-13-maple_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.9.y/build/v6.9.2-803-gfcbdac56b0ae/testrun/24217279/suite/build/test/gcc-13-maple_defconfig/history/

--
Linaro LKFT
https://lkft.linaro.org


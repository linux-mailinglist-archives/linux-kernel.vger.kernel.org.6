Return-Path: <linux-kernel+bounces-431513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E4C9E3F6B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896F5B2CBF0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B120ADD0;
	Wed,  4 Dec 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lc7VjwwL"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84E21B87C4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733326383; cv=none; b=bfdhnQAe6ZxvWyVRSvctbA84hqsHPntdgG4oiMmct19An1bFxxjOGlgjAuE0o+Zr1alwxTo4gfaPVhdqWx1spw5hIYsQ5nMW30dlnyuRnKezF4pEE/jWAkKhyoA0eJED08PwQkD8zpKdXypnpxChsY7TysazFZ7C4phr/lH7MzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733326383; c=relaxed/simple;
	bh=WKAlhH29xEF4xdMd6IOvEbZvOJijsedbXkd9Fo94v+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6xeHZ9Tajm00edAUlpSsarJ7adElwt10whLYtq5ut/UAeE5OZggfyHfRG379UH5Tt1jgRaKuz2dPFYZ54xrCXRTB/28XRSRmTvAbQ5wwsRn0cj6RTk43H9jmZ78669zqdLGiLtBC+Bscp6/eS8qS2hpQtbFjh+HOTn3rCu9JDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lc7VjwwL; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4afa4094708so355837137.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 07:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733326380; x=1733931180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BM7g2tnTxffenD3gAnjnDpzGPqkZZJws6+BF+fZajU=;
        b=Lc7VjwwLdDhtjzyshExaeLaBucdetu31MNHxwHZ0+0irwnROs763o9LVBguJ6M8BIa
         pGgzp+hfC8ITIXW7h+6rNblFjjNIA8o+wJUJ1JtW4rkyEmpncvM3X8G191IAgS6dB0oF
         wT/uEsIaR0GFSrDg+i5GX0D1gYG31IpBMm60ipz6ne2gLw5/Z1qRk9r1X6tTaVcW/ZKK
         UjACsmtr5z7qAoBfc3ekQ2fjDHXXkqaH1v51WaEwOHqNZVkKbc7buwvorJCWKHIAu2z7
         p3jcaFsDpcCooR3hkzlsEGoq8aqsqI7c/QeQnruaIEYiOnVhVbV+5qr3aYGdroNlWDYD
         7muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733326380; x=1733931180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BM7g2tnTxffenD3gAnjnDpzGPqkZZJws6+BF+fZajU=;
        b=CCnZHVOPqC9S6tIYUpoF7EomwXKbP7M/sQzfnTsVaXoYctrMNgbDvKavrwdau63l+w
         dXrnL0Gu28cMX9rO+r03P23tYb0cOxfWCZ55wPOTc7skDMqBvukIKCz/qXNFwBRuj8WN
         sJ6NYHN1eI1lG//G8tHvgd0W10G0K/KR3PKZD7a2oXUA8QUXN/l5YE+jL/zy9P6yjPAQ
         qXxQbHLb3BwWk+aUkZ+KshqaEvk/Mv9Gkm6Y9fYye247I9UDZS2enoYi0I8hnJ6UH6EB
         zXzvNlaj2JzwSouGegMtsSFQ6MGYddto3dS8UGpJtNjnzLRlhhieyc3VAUdJm6aVoUBG
         8q7w==
X-Forwarded-Encrypted: i=1; AJvYcCWxK7Jk6cpX/966PKDpg6IeZsylbScg9fBhJ7NHsfwtpAJS2uHGtquq0Ou8Hi85nR9My+9HLuHNuD/rsRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYR67oPAeirYmeF9/q8yPIuxKcZg8XnPERi6akV4M1gNd+eWI
	rv9DmC0Mn4yJN7YbtqkAL9GHnYiqJqtc5GsUP2niSBM/6+siyerg0uFtrE2PSA+gqflD2Cm8jq4
	itS3jXA+8Fa4U31qU/RfS/4cOcwORc0Ge1JUVFw==
X-Gm-Gg: ASbGncu6axl/CmNkuEV7PQQ13wtog+ddOQLNlFRuLiUXBQ7AMhQUvDsVViaLIdmr1ao
	8xeCAAh83b8oZ+usQAMug+ozdllYfhjAi
X-Google-Smtp-Source: AGHT+IF0RVZVCMdJkXYjBAAcJHezPOoWCH4jS8XQLyQLEPZuJ7e6SomQNYsR4Mx3bJ489e5yJU/yOjgwrrV33kHvO74=
X-Received: by 2002:a05:6122:1d04:b0:515:c769:9d33 with SMTP id
 71dfb90a1353d-515cf784e53mr6510755e0c.9.1733326380385; Wed, 04 Dec 2024
 07:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203141923.524658091@linuxfoundation.org> <CA+G9fYtXS+Ze5Y8ddtOjZPiYP1NEDhArQhEJYfS3n5pcLdn9Hw@mail.gmail.com>
In-Reply-To: <CA+G9fYtXS+Ze5Y8ddtOjZPiYP1NEDhArQhEJYfS3n5pcLdn9Hw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 4 Dec 2024 21:02:47 +0530
Message-ID: <CA+G9fYuDAAZkgNK4_0Y=wDcTUzs7=ggbni4iJDAPbD9ocq992g@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/138] 4.19.325-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Matthias Schiffer <matthias.schiffer@tq-group.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, noralf@tronnes.org, 
	Sam Ravnborg <sam@ravnborg.org>, simona@ffwll.ch, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Dec 2024 at 19:24, Naresh Kamboju <naresh.kamboju@linaro.org> wro=
te:
>
> On Tue, 3 Dec 2024 at 20:04, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > ------------------
> > Note, this is the LAST 4.19.y kernel to be released.  After this one, i=
t
> > is end-of-life.  It's been 6 years, everyone should have moved off of i=
t
> > by now.
> > ------------------
> >
> > This is the start of the stable review cycle for the 4.19.325 release.
> > There are 138 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 05 Dec 2024 14:18:57 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patc=
h-4.19.325-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-4.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> Regressions on arm.
>
> The arm builds failed with gcc-12 and clang-19 due to following
> build warnings / errors.
>
> Build log:
> ---------
> drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c:177:9: error:
> 'DRM_GEM_CMA_DRIVER_OPS' undeclared here (not in a function)
>   177 |         DRM_GEM_CMA_DRIVER_OPS,
>       |         ^~~~~~~~~~~~~~~~~~~~~~
> make[5]: *** [scripts/Makefile.build:303:
> drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.o] Error 1
>

Anders bisected this down to,

# first bad commit:
   [5a8529fd9205b37df58a4fd756498407d956b385]
   drm/fsl-dcu: Use GEM CMA object functions

- Naresh


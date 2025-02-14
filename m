Return-Path: <linux-kernel+bounces-514933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D01DA35DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65CBC3AB618
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB12263F24;
	Fri, 14 Feb 2025 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jIznVETw"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93565263F26
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536195; cv=none; b=pZTmVj8rGRROeXL2odofYxUjs+HIXECDiCzJAXVO/oUX8Mz2wwfeGNw6wWkt/doHPRTk8JpCDxP0dN4af72oxRGGEWYBBdJQtS0psj3DHvz9BpzJTfzSLBmnuq3dHy7Zz6I5xHSG4SdWdYc2UcJd4+S4+H5QapyxWfsP6biA5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536195; c=relaxed/simple;
	bh=o+9eJVl8CwL4mxIer/X2JlMnYjvZGgitWo5E6XsIP00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEiMhumquzEZ6X/gLqb5UwmORkw9DqorRTVe1Z7AEj17aGjJtofpCjbHR/6XTaDnVVHUfC4Kmkvl8Hc3zlUcyNJFq1lBZKfuvxmACOhVvcU+UO3UJMn7swt/ZIZCCRC8LxOOcNNkwIBtzm9+d14rq5vCmfRMk+wHKHPyjBYrOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jIznVETw; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4bbeb009101so613142137.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739536192; x=1740140992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lTFbAU7wJoF4fOBfb8cWjl4tFAB0huVpYXczHim4Y1o=;
        b=jIznVETwq8/92diQRkc6ubURVuUbxWxObGWy0fYTTNYnFS2bA0Is0SP1zksOKVKmEH
         gzC2IIQLArsP7NWH67thl2+I7QOwC27AHoOy0onLqMJ6Iymapkue2Mk3gC7WCvLCrbhj
         uqtCKuesU6S8iwHfAnuoP3eqbPseN1vwhze1u5TmXPDyEAnRM6swd2KTLIGO0SsnSVUZ
         f2PVAkDzYt6WdHaePrc6gydE7YTCzMp2Iq4JsEj6oSeVtEfGukB+zavGyb2xC/eaG1tU
         yZi+fQ6j6ugoz6rhVk8YTpmJIjuqRUJx3EAFExjDnw7ACcwudWxAIrxkGT76Q9q8kmDm
         mzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536192; x=1740140992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lTFbAU7wJoF4fOBfb8cWjl4tFAB0huVpYXczHim4Y1o=;
        b=iWg4VK1XDBSJSznUTcnXWoPVuorwa53Q3Q+6f8qGfzDpxkGSm3hs2yVSpFJ2b7MIXi
         UjYjKlpCZ8IaNwLQB4ea8REfdH31gITx0T+d8fZs1AuscU6R+MSKCozREcIr9ksrgpNx
         FSFT8Bn3UVrpMCyh7/ui+eDXVmwdbkeMDw36QO+j/t59ErHFcwqGwC8ksUpnUIAtH7B6
         Q+Hhiqdw784fvCMGJBQ0z/DqIETxrbDH4xSDZ/aVoWwiZSijJV1C2WhFv6RkMSY9nCf4
         4xAAfjQDQxRGIlivkevVd3WCkP8LXPeXr7OyktfBuaP4A9CyqiC+dao+LKi7Rj644a3V
         5nXw==
X-Forwarded-Encrypted: i=1; AJvYcCXa0g8q1nlSCzFc2/0qhYPO27u7xqRSDKfGk0bcIjqvaRQnzy8JPWAYodqGTzwPJc4FJuIhJ7sC7v+Du7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcvphXyhl255Hhfadr1tl2cB7Dk4pb2Z9oFH829/L5KM+9jcz
	ltarlT39SfyR+T3gbdkQActFlRpnde+FVhyYVNiU+uj3iuMLpqFxE8XGA1nDKLCj2UR+CedREO7
	S/HUk/66lITRYieS636/tUu5NF5vavmOco9hbyg==
X-Gm-Gg: ASbGnctrab5S+98BK2ZsqTg95I7APylGiThug5EoiOP05c8lQgv0zMTEfXCX21drD9c
	nuU4ka62dBdzwNKyUsPkRccKlvgDkp0WdZTkXY/5Cxef6q6KxSwZ3z8ZA4Hr3bI4HAD0W08UOp9
	fF6rhtQupIOCgc6adHcWaj6p5SmHLhvNI=
X-Google-Smtp-Source: AGHT+IFayjXgqLnPIi5Gj/6+Fnamdf+uE2pl1g6krTGZMHKX9RJajOKZ81JoDlIpuTxR8LgZtuj0I33nc9DhR+zNH3w=
X-Received: by 2002:a05:6102:3a0e:b0:4bb:e14a:944b with SMTP id
 ada2fe7eead31-4bc03781b64mr5853377137.20.1739536192461; Fri, 14 Feb 2025
 04:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213142436.408121546@linuxfoundation.org> <CA+G9fYuVj+rhFPLshE_RKfBMyMvKiHaDzPttZ1FeqqeJHOnSbQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuVj+rhFPLshE_RKfBMyMvKiHaDzPttZ1FeqqeJHOnSbQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 14 Feb 2025 17:59:40 +0530
X-Gm-Features: AWEUYZk1PwH1MSNr9Lf4hA8ve4s44k0qj-QHXi0NZuppFfQe21jEYySxIYPOqJU
Message-ID: <CA+G9fYsVFoLTXYBqpeUN1VUTwy5kXTB82fztK62fMPR6tYxChA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/422] 6.12.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	linux-xfs@vger.kernel.org, chandan.babu@oracle.com, 
	"Darrick J. Wong" <djwong@kernel.org>, Long Li <leo.lilong@huawei.com>, 
	Wentao Liang <vulab@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 14:16, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 13 Feb 2025 at 20:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.12.14 release.
> > There are 422 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 15 Feb 2025 14:23:11 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.14-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Regressions on the arm64, powerpc builds failed with gcc-8/13 and clang
> on the Linux stable-rc 6.12.14-rc1.
>
> Build regression: arm, powerpc, fs/xfs/xfs_trans.c too few arguments
>
> Good: v6.12.13
> Bad:  6.12.14-rc1 (v6.12.13-423-gfb9a4bb2450b)

Anders bisected this to,
# first bad commit:
   [91717e464c5939f7d01ca64742f773a75b319981]
   xfs: don't lose solo dquot update transactions

--
Linaro LKFT
https://lkft.linaro.org


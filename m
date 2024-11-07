Return-Path: <linux-kernel+bounces-400104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F589C0906
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775401C231E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3716321313F;
	Thu,  7 Nov 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQ7zv3BP"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CB21219F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990082; cv=none; b=CEanr9lpUKeLkhfrUcoryijy9ZC0dW3v1Yb693OD1AWSRz3eYKfOeWgQc9cUIqiSQZ3KCeqfbSYtpqwv3D52hLWmzu6o05Amp0LFtjjgj4bWPPBZWRfuBG5QWZuDQDV9/aoJXsV162rzoFAPVi/F8szn1BbZzcQ9fjr5KL2Cb/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990082; c=relaxed/simple;
	bh=sYdP0JlYzj4mQQL95qniZ5n95iC6ImunCygdVJuw3YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDgNZ+bcW3+MPIOfj5FPLtomVDDV57lPZgqQh70ztpEsIa9/QBF5mN8rAAjPWzSmZDWZhFKvYvMVHt41r9ylQn9Nl8lrPY5L0dYtv3CDdYOdL1O+qLMlMTf1eI+ULCalgxsZFw8xVceWnjj9X+OsC41NWSXpiwbyaOd8epszY50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQ7zv3BP; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so8614881fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 06:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730990079; x=1731594879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sFw8yXJLqrkXU5hRV9LHBA5xHB7hRhKhK9JeN1oXec4=;
        b=LQ7zv3BPWWliXdprNS1MplJaIxFfxajUzC0nK9ukyhAgWq6YJ8kZY65cNQJg4k/LNR
         zRF5fAkN+AWbuYr2+4/l+2DmyfxX5nQ0IDv+fA3oGWi/COhL6fziKX3FO6qnQ3cDbJfb
         6X4WUUYeMAdWj9QEKJ1wMCc3yyztCQQ8O71ecxiwyKm+nzd7jFu9Fk8rUpH7AB2zPP0s
         dQWgg0H7ZJotHECOlV61oyUdBKMpBfhMXQGH4uBTqeCBm4KGxd0T5YSykqPOvRPXDu49
         cLEKOMYC5Y4m10eCzXKyNOj8ye2FqWFs5CJrJt7fJx/LCGAFjdmTOgirknC9cOLNQoqa
         yt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730990079; x=1731594879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFw8yXJLqrkXU5hRV9LHBA5xHB7hRhKhK9JeN1oXec4=;
        b=tI6eC33ibdVrrgNEQ/lEdFJ9Z6NFT6AvbGqCSprhnU/siM2XRbDkBKGRrNzNrhf0aN
         0ZPF+OgTlnwQoHdKtD0gU7h4PJOHJGF5r7TaiamSJ1IM/qnxFWYjN8iU34Z/mlVJ3fIo
         /8fJv3R3s+2D9bnDpKJknxcDsTSL9g5DnMd3sQ5TiL9NaKDqs2EN0WK/ejgiujunBSYe
         xCMWnE5OqVrLXzLgu1UsqKM5pRJLwSE3QZOhsKuWGB8NOhOAbxJ41exGsxnNtfhE6WyQ
         n/j6bmw/42E3bmuNOmOtLm9ee8ac/yBjiChpq6vzubwP7bMSnQge8oTSPQD5F5hJs5Q9
         Pw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVy1x68aLWlty7BMBxJPwFtyGEPZYxSTwN5urEmAErNseyILUqdpmgk/2Q4GE+5CJ+UFL0jfkCtL4a9Lu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz69h/43aMbXhGX8EnlYLQ2yPoqrCwt6VE2V1+ZYcaezWaPuGWb
	hnBJ5yOl8jIPhcGO9FGWA91y3gxVtcZHCoowTy+4831ihsogbGWu4l1LcrH8Hu4=
X-Google-Smtp-Source: AGHT+IE6u/vwpetFFBTpREnEATNArVxMnib3hilqhpSQwRreBBwE7Un+H8iFwlJKP4tC/3/OAp4Img==
X-Received: by 2002:a2e:a1ca:0:b0:2fb:9180:250f with SMTP id 38308e7fff4ca-2fcbdfd77bfmr168671801fa.18.1730990079154;
        Thu, 07 Nov 2024 06:34:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff179d7d5dsm2406701fa.108.2024.11.07.06.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 06:34:37 -0800 (PST)
Date: Thu, 7 Nov 2024 16:34:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 0/2] ARM: implement cacheinfo support (for v7/v7m)
Message-ID: <lkxm6m2u25o4qfvpja7qsldqm7zjxejkn6d5qihyxbg2zvntwh@icvun74e6rll>
References: <20241014-armv7-cacheinfo-v2-0-38ab76d2b7fa@linaro.org>
 <CACRpkdbfckBBW5W5sEvz1LwzdOvTKi_fi7tDu+9nPeKumYkPeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbfckBBW5W5sEvz1LwzdOvTKi_fi7tDu+9nPeKumYkPeA@mail.gmail.com>

On Thu, Nov 07, 2024 at 02:55:55PM +0100, Linus Walleij wrote:
> Hi Dmitry,
> 
> On Mon, Oct 14, 2024 at 3:55 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> 
> > Follow the ARM64 platform and implement simple cache information driver.
> > As it reads data from CTR (ARMv6+) and CLIDR (ARMv7+) registers, it is
> > limited to the ARMv7 / ARMv7M, providing simple fallback or just
> > returning -EOPNOTSUPP in case of older platforms.
> >
> > In theory we should be able to skip CLIDR reading and assume that Dcache
> > and Icache (or unified L1 cache) always exist if CTR is supported and
> > returns sensible value. However I think this better be handled by the
> > maintainers of corresponding platforms.
> >
> > Other than just providing information to the userspace, this patchset is
> > required in order to implement L2 cache driver (and in the end CPU
> > frequency scaling) on ARMv7-based Qualcomm devices.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> I added my review tags to the v2 patches, can you put them
> into Russell's patch tracker?

Done, 9432/1 and 9433/1, thank you!

-- 
With best wishes
Dmitry


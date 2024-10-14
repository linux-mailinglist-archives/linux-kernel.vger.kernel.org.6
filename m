Return-Path: <linux-kernel+bounces-363341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF499C106
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E629BB23B99
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E169C1487CE;
	Mon, 14 Oct 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KFXCDXYS"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE0233C9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728890205; cv=none; b=hmiid/8Q/QhhXiPG+wEfimtZlXoHhEuWO6tZMXHg9QLx7YyX2RvqVAsAjYtVaktinVkYRjQnycIcLQ7LAiXeV5loVSSrHj5jKefDvmiJbnounp+3hLTQkYuLwUlLy7aj2eevNPi/XwwEQE2C8i0O61761Dpy+18Fc4RBKNG0R28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728890205; c=relaxed/simple;
	bh=DK+CIo8QEgh56+OiXd7YthWbLGWDz1jv9VxIzy0DvgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ijj9ElmiGiwc5yvrQOtzJtyrqFv7nPUaN2cJ1DcSqEiLUUsSLKtNuZsCgx/3he6YaASk03x6Lb3OwaZHVXoOHV5ny+GhuUYRXvrLOsyln1ii22Jdw/evWRfIUWoIWu+A5FKpZacAPt5EEvxvJS42y/S1/xlalVTM5o1eepJ4R2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KFXCDXYS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e8586b53so1166245e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728890202; x=1729495002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYrGaKIzbaXW4/HOHDYKu2NdNnaNeNcKNsI65YJRIJQ=;
        b=KFXCDXYS7QeXEasuF8NXdw+o7eUKnyhJDpFkTeXTkCYHWulklYdcRklMPUKOrysn+l
         7LTOMglMbHB3wFyll3Dl2Z6bSDqjeUS9Y1URpXLvQQEHuu9CE8VYU2zTbtuhBtt84oVw
         f8SpT3xqodBPIGvsGHIdG21ouVzIdnNvd2RTNFyIRk/bEBTTwRO1WvMxxld5jOx5MAJ5
         tkSh0cK8+aRqEm0pnYodYQVWan1BirobvpJia20UupD+4O/yosxEZq/FsbKG46rmopN4
         ltp+zqNd9QHbvKXFDcEqPFHgNztW8XJ5+3M83YoyxnvmbU/WH0PowOWhdgwtDSU/lBiO
         Nfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728890202; x=1729495002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cYrGaKIzbaXW4/HOHDYKu2NdNnaNeNcKNsI65YJRIJQ=;
        b=cpaysqE4hN+Sil5Jyf7p3R+nLwq0d8xw/DP5QKk7zFA0nNvdOY58MPhJHrGx947dkX
         C2m0EGzZ2CAIJmOqtwte56KazOW0zCC02ZJLs+ixppyaybSQ1z+ALvlPzwpMlkjl2dGR
         QVhb4Z9kB8cIZS+Jo+VWC2Q5ryOtm17XAzRcIqqANrIw6fmwcE+QQnqOqz12W0l3QO7P
         D4RE6dM1O5Jt/I5siuH+gKxSK8FEYIGVRlSgJQCw8h+C71mgwV2ac+4oqvSYnD3jS/J+
         p986lbfoRv/SG17Y2m9tIMThvyb7IUU01jTmDxMOMLhqKtkdlk5iPiRKbd8lN/7Cej7B
         mGxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo//kcJftco2S3UtUulDb93DXeII6eBEiQR5aT7139vtPjsZ4fUny9kZYiAbPhQVI8lwl/ZdAl/imzYog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vhSfbiOoGTA8AbbQZPjWlGa5To/qmkHUzpMAeWLjuNc/rkpt
	9C0L9+BOZ8+OY2MBtpsCP0BZvped4Kbona4CI8CCLRaD0IfdDVMoFo8qYa1X2+i5JQ1+AgPzHvT
	nJ7xip9W+MNX2TTgndctLArdm1d9SUBJO+XX0TA==
X-Google-Smtp-Source: AGHT+IGPExr/iGdzqGOOs1sdsdXchDfXIqGllV+yq5qtcgDH+8WKLL/qB4Dnxru8GItrut/gJbXsTIfYoiaKcgAvmrE=
X-Received: by 2002:a05:6512:3d87:b0:539:eec0:20de with SMTP id
 2adb3069b0e04-539eec02255mr1155970e87.10.1728890201974; Mon, 14 Oct 2024
 00:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37842441-e372-40e9-b0f5-cf69defc2db5@stanley.mountain> <CAMRc=MdFYTtosq53tDFaPSBn11V3P36DOX8xsxRqFhu5iPwUcw@mail.gmail.com>
In-Reply-To: <CAMRc=MdFYTtosq53tDFaPSBn11V3P36DOX8xsxRqFhu5iPwUcw@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 09:16:31 +0200
Message-ID: <CAMRc=Mdsb-93m5X6q6qJUmaomJGdBAOWqSFBY0y7z8KsQ3NA6A@mail.gmail.com>
Subject: Re: [PATCH] fbdev/da8xx-fb: unlock on error paths in suspend/resume
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Helge Deller <deller@gmx.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sekhar Nori <nsekhar@ti.com>, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 9:06=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> On Fri, Oct 11, 2024 at 9:42=E2=80=AFPM Dan Carpenter <dan.carpenter@lina=
ro.org> wrote:
> >
> > Add a missing console_unlock() in the suspend and resume functions on
> > the error paths.
> >
> > Fixes: 611097d5daea ("fbdev: da8xx: add support for a regulator")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/video/fbdev/da8xx-fb.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/da8xx-fb.c b/drivers/video/fbdev/da8xx=
-fb.c
> > index fad1e13c6332..66ff8456b231 100644
> > --- a/drivers/video/fbdev/da8xx-fb.c
> > +++ b/drivers/video/fbdev/da8xx-fb.c
> > @@ -1610,8 +1610,10 @@ static int fb_suspend(struct device *dev)
> >         console_lock();
> >         if (par->lcd_supply) {
> >                 ret =3D regulator_disable(par->lcd_supply);
> > -               if (ret)
> > +               if (ret) {
> > +                       console_unlock();
> >                         return ret;
> > +               }
> >         }
> >
> >         fb_set_suspend(info, 1);
> > @@ -1636,8 +1638,10 @@ static int fb_resume(struct device *dev)
> >
> >                 if (par->lcd_supply) {
> >                         ret =3D regulator_enable(par->lcd_supply);
> > -                       if (ret)
> > +                       if (ret) {
> > +                               console_unlock();
> >                                 return ret;
> > +                       }
> >                 }
> >         }
> >
> > --
> > 2.45.2
> >
>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I technically still maintain this platform so I took a second look and
seeing this[1] made me realize that this driver is no longer used on
any board. The platform data structure is not defined anywhere and
there's no OF compatible list.

This patch can be dropped and I'll send one removing this driver from
the kernel.

Bartosz

[1] https://elixir.bootlin.com/linux/v6.11.3/source/drivers/video/fbdev/da8=
xx-fb.c#L1340


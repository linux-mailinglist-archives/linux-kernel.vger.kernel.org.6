Return-Path: <linux-kernel+bounces-381836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 528FE9B051E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34321F21021
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4081FB8B6;
	Fri, 25 Oct 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sz2pSwUh"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5914884C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865296; cv=none; b=tpZ88NIrucJTsrnOHXPeY1r/4E7Xhh8mIKx8yMdU5oyb7mRyjLxGUdNzTa4kNo4zWiWhf9qzHRpHoVNoFCZ8mFNVrwO5pDz6FJdZayYpfKPF+gwZbqt4ss2t/LCuf6Km1duMQKcPCqzQ2KtPnU4jNIjRsyMG5Ms2gEsLG7w95eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865296; c=relaxed/simple;
	bh=DoSspA7//UMeR1vr8KWf06H1LbH/GE6Hngs6Zz2+erU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQYiMhA/0A6X2C2ABTyb3QGs9wZ2h91jQHOpyRTWhViFuGM/72E8M70/dNTJqE/yiSvyYDFSsPpB0sn6fR1WeO4FinQCacnu+4RlXNpWEhnB0FFjijaR9IskGe6wu5F/LNcc/wQov3iGwSf1NKZvDU0oMjDhf//ZOhpUhBi3dPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sz2pSwUh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fc968b3545so21591931fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729865291; x=1730470091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ST+UyHh/HP6X2Z5LZgfmL+1Z9UxnSzRRcskNFqLwhiQ=;
        b=sz2pSwUhjxhlgNZqdyrrOEINDVURr8tGlPxBqDuDSd+lz99bC4rHLgJn2rBYdOLKi2
         wBRs7LSkPOEa2b/PnHgsaGl30eMaQynxCiJXsbdtfnUpXQKzsK09sxOxSxXiU0q5tN+H
         iJEkf1274wBkOPCiIR7LKhwcuSShRB8Vmt073vZbeUadFewvMyymrqmmVEe143PtFGCM
         rGBTAn6W2mq1AepCywIAysd8LZ3ktsBz5PKcoGYDcdxkLN5/iqgnESOLeXEZsRUIn3su
         2qW0OmX/vkKalvBA5zTGWrmZ+A1o5IRhfVMedEJIV0ApTyRnnX0togMcDNRZy4fBEN18
         0sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729865291; x=1730470091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ST+UyHh/HP6X2Z5LZgfmL+1Z9UxnSzRRcskNFqLwhiQ=;
        b=I7UYHF6dg76WzJwsldWlHb7CQFQDxuVMcJ/v/Yjvz9BKYQFOx6mNNMZ3q1EP8BsIpZ
         Xjblsxp8EhdxVq9SAX3JthSp6Wx3cIozFpx6DjDqXJEoY7b4H0mYF5l3O0RznTDX7t73
         0EXF5tyoGudVui9VxEphoXel4oqx5SiRVN9GzSm4x+YTfqUKEmC1+iw8QppKos2+2+/A
         0MqMWO/Gpb9GnZQYhrIWrkr+JzQsmPNK1fombOQxkEr+bTjCiDUoXsBe5GPREDZLzEnD
         Q3S6IbchdHIfG63feOGuclTkYnvd6NyDbNiIVBZHbICOU5TEUjhvn4N50u3gauzgwqIg
         w64Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQgqiJreCdG5vGdm5es5j/xcq/GjsW0iiOxZAHedAq+U6D/8d0LGWEyeruS0OP+QmEE/+ILd3p9Q90rBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztJ9T4Esn/GtD2BfBm/ya2oOLzKJAy1E83hBlgbh5daI3pAVFC
	NBwsuzM1NRPLJe7QP1XNhucgER1t0gwwigxgUodYI9MfmuvNbpFp6rZIqofqV7f5Afob+I/6e/j
	1zKJ4qKiPs05G8TexD5eUEnm6ZweV1sS7qaAb1g==
X-Google-Smtp-Source: AGHT+IEE/lcC9tVckz9C15HEhaGv155dfI/otmWtIvUhrm9XJj8ptFLkwdKlPuAl7OiPPl/SHQXmVbDusfvmhjlZ32Y=
X-Received: by 2002:a2e:a586:0:b0:2f6:6074:db71 with SMTP id
 38308e7fff4ca-2fc9d315a12mr55696751fa.17.1729865291412; Fri, 25 Oct 2024
 07:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-gpio-notify-sysfs-v2-0-5bd1b1b0b3e6@linaro.org>
 <20241025-gpio-notify-sysfs-v2-1-5bd1b1b0b3e6@linaro.org> <20241025132420.GA155087@rigel>
In-Reply-To: <20241025132420.GA155087@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Oct 2024 16:08:00 +0200
Message-ID: <CAMRc=Mcd8vVCwDvRysMxB00xUD77zmJK1EApFuAEfWpwOhkviw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: sysfs: use cleanup guards for gpiod_data::mutex
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:24=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Fri, Oct 25, 2024 at 02:18:51PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Shrink the code and drop some goto labels by using lock guards around
> > gpiod_data::mutex.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/gpio/gpiolib-sysfs.c | 81 ++++++++++++++++--------------------=
--------
> >  1 file changed, 29 insertions(+), 52 deletions(-)
> >
> > @@ -139,19 +132,17 @@ static ssize_t value_store(struct device *dev,
> >       long value;
> >
> >       status =3D kstrtol(buf, 0, &value);
> > +     if (status)
> > +             return status;
> >
> > -     mutex_lock(&data->mutex);
> > +     guard(mutex)(&data->mutex);
> >
> > -     if (!test_bit(FLAG_IS_OUT, &desc->flags)) {
> > -             status =3D -EPERM;
> > -     } else if (status =3D=3D 0) {
> > -             gpiod_set_value_cansleep(desc, value);
> > -             status =3D size;
> > -     }
> > +     if (!test_bit(FLAG_IS_OUT, &desc->flags))
> > +             return -EPERM;
> >
> > -     mutex_unlock(&data->mutex);
> > +     gpiod_set_value_cansleep(desc, value);
> >
> > -     return status;
> > +     return size;
> >  }
>
> This is a behavioural change as you've moved the decode check before the
> permission check.  Not sure if that is significant or not, so in my
> suggestion I retained the old order.
>
> Cheers,
> Kent.

Yeah, I don't know why it was done. Typically you want to sanitize the
input before anything else and this is what's done almost everywhere
else. I'd keep it like that.

Bart


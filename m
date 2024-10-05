Return-Path: <linux-kernel+bounces-351738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11C1991584
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 11:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F59B22D0D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754313DBBC;
	Sat,  5 Oct 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WfLC4JhM"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F304204E
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728120883; cv=none; b=M67kciH8bDKg9BtZffKFTsqbSESLKBWECNhzsCLZOMk9k611zB2V5SeQf4OLmZNWKCGN/OQF8OAfzTlmJlqfqa5ZpTZzw0iA+oWaQFisQOchk8ySDvH7Cgly2t/We4kk7EpEZ+vrEd206sKqhStR2SfEycSQyjYisnl/dBabYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728120883; c=relaxed/simple;
	bh=fiUhH49Kp4seeyHX7TkGnaJPZFGfeFbjWwxG/JLdVBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aniFDNErk5aS4u9YWV5cv9ngo6rpg//5OjT9UjCQqR2DF7UBqAHmSYOvMVC9zoPj5H1GHt/s7XV9E9o2G3x62TveaxWigv9Dir+aAhgeKrNH1aQ2lk+awWqKt/jkXm1yyJthjpdkPfPP1qMi8rpcKPAYVD6JUuztEQwAz5hvJVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WfLC4JhM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398b2f43b9so3703379e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728120878; x=1728725678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdRTh9Vz7KfZgBWlu5wAeq6WvNphtxZLVDIUOTrDHGQ=;
        b=WfLC4JhMlEXAB9PuRCV7Ukspu5IIbBx85GN/Z7c7+kG/OpleVVthg9ZiHrfYtbH0pn
         vX01kdj9U0rGIJcCC/3Fps9RGgnlblVAwB0O58KbyPmXYFG/6/Pzn+BfqVyDJ0dIQXiV
         uidTIoV0XF1Zr1ceYYR6NDZrV0pX4EnDtpSKi9v93804T888vyU8S6WvwcRHpxMhGiIn
         wnWo++wfV2HIhl9pWY8n4eC0tggiD5aaLP5mxDNbbE3TuRMVZ/9q1pMhujE9AhB9/2xr
         dsWqtrU6jLYsMdXLbWUsBgUFWc7WRWzRS4es+8h3em1mo5nyKCC2nGiN7d+eAwwknFlj
         yW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728120878; x=1728725678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdRTh9Vz7KfZgBWlu5wAeq6WvNphtxZLVDIUOTrDHGQ=;
        b=N98ViAB9bHoG8AZpFLrol/pXfDY2RYMpJ+II4v9/47NG3300wNRsueTe/6fzYxhxzG
         a9pvougglnizwmr7+vcvr3InDwJbAYKEmqoicJWZp+kPRYbKUKIN6JotZOf3jBl1MmIW
         njthNBbtOydcItz6r2NCYG+RgMQuEykB6d4heuVuXEaTTsNZkIbXtw7nBQkfSc7aIqcT
         HtAPQsR0fvrllAnZuCikzccgQQqWc8oAK/M49r/ek/F3wE92YrRSuh7D56/kllWGWkzV
         kU7AyGiTLsqM1XeevwRz7FVPtnsURaPuqh8T9CbKqGdhZAjseHH62JXxIt4OgY455jci
         TIUw==
X-Forwarded-Encrypted: i=1; AJvYcCWSLAYI7Kcu/0GbC0EDCmK3BFzITdXTTJHgFVKYguO8b5Y8pD4EKToHY62WmzFlzLmdYON3HjULIC6axfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVkidAm3sXsOh4l5RgJYNYJl1YeeTlWS3lfAV1v3ooMlx8s9K2
	fca6+SEpK7QuIFFkT4fZeoItN6Wpf2A3pLIFxWQMkpAawKVhwb507etyDlEuhZHotDj+8Q49MaE
	8vkraePrJrWEttCncngMwqHDH3QZ2UFWtNvyQz8HL6mU4abN6
X-Google-Smtp-Source: AGHT+IFBrnGTBwjt7DCokddQrhI8wojfGmC1OYEfCazzWi5Fcm6/QfybzyF89VwekwGvu/kE9WzSDTs+ods7f3e2CVY=
X-Received: by 2002:a05:6512:1111:b0:536:5e7d:6ab3 with SMTP id
 2adb3069b0e04-539a62828cemr3186174e87.27.1728120877963; Sat, 05 Oct 2024
 02:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004-gpio-notify-in-kernel-events-v1-0-8ac29e1df4fe@linaro.org>
 <20241004-gpio-notify-in-kernel-events-v1-4-8ac29e1df4fe@linaro.org> <20241005034604.GA41715@rigel>
In-Reply-To: <20241005034604.GA41715@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 5 Oct 2024 11:34:26 +0200
Message-ID: <CAMRc=MeL9B+oCLb4SFupmBzK5E+JoGfCvtUp-RvYNT=L9i5M1Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] gpiolib: simplify notifying user-space about line requests
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 5:46=E2=80=AFAM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> On Fri, Oct 04, 2024 at 04:43:25PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Instead of emitting the line state change event on request in three
> > different places, just do it once, closer to the source: in
> > gpiod_request_commit().
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/gpio/gpiolib-cdev.c | 6 ------
> >  drivers/gpio/gpiolib.c      | 4 ++--
> >  2 files changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> > index b0050250ac3a..f614a981253d 100644
> > --- a/drivers/gpio/gpiolib-cdev.c
> > +++ b/drivers/gpio/gpiolib-cdev.c
> > @@ -372,8 +372,6 @@ static int linehandle_create(struct gpio_device *gd=
ev, void __user *ip)
> >                               goto out_free_lh;
> >               }
> >
> > -             gpiod_line_state_notify(desc, GPIO_V2_LINE_CHANGED_REQUES=
TED);
> > -
> >               dev_dbg(&gdev->dev, "registered chardev handle for line %=
d\n",
> >                       offset);
>
> This moves the notify to before the desc->flags have been set.
> So the notified will now see the flags as previously set, not what they
> have been requested as.
>

Ah, I got fooled by the libgpiod tests passing. I guess we should
cover that first in tests-kernel-uapi.c.

> That might be acceptible if you subsequently issue GPIO_V2_LINE_CHANGED_C=
ONFIG
> when the flags are set, but that is not done here and you explicitly don'=
t
> notify from here in patch 5 when you add notifying to gpiod_direction_out=
put()
> etc.
>

IMO it doesn't make sense to always emit REQUESTED and CONFIG_CHANGED
events together. The initial config should be part of the request
event. I'll get back to the drawing board.

Bart


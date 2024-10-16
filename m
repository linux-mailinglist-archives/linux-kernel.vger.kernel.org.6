Return-Path: <linux-kernel+bounces-367653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEE09A04F9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2001F1F26764
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B2204F95;
	Wed, 16 Oct 2024 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ffYr+SuA"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E117D378
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069375; cv=none; b=Ve6GkRGFFh8gL4Yww1BamgZz0IzDT4+5nlY6Ui6gpnOO7X90y9/sxqtYmMVCeXCyXEpD80PwquwQ5VManB5jWmKV8VMkzSQogBRqJEvPzOSSQ/KCpXdxUULTmyCKVEogF2yGHT9n6Pxx+Rz+R/MJ8/lwXWYgzB6NVU+Q5IGNxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069375; c=relaxed/simple;
	bh=75iTt326Qo1iifqEbN5oZf1Amvb23K5CfhfwAm1v/I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzNctDZguLsWxj4AQ7I1U8FS42LVCVUl/VjBED9C4Gl2BD371exKlHG/78OmBuHdYaDJ+3tuca3BjY1wKsJEQe5En117UPXHIodcYSBNhL47pZJEW57TS06UIKnHXfV7frgP8cDMW90f7pbZztb1KKA6R4k1QRMztxHnULRjMm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ffYr+SuA; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso79944701fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729069372; x=1729674172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMXUrgToe89xgQYBl4Khev4CKJy7nqDnifoXpIAaoLY=;
        b=ffYr+SuAEq57Co/ObWd+JCYP+ovVsjA0DyPpah9zv/dQFl4XidqtF0/vHypFjv2umJ
         3UEynuggA0nc0h3UozEHp1S6Nqe0rrVLTPolBvLXFz0EFQrWYYg/JyNPfFKcwTtOdn0d
         Uu0vDMOFBk2YDHuUsL17G/sV6EknFk1KnRptYrF9oU1ZBSW4fBwxs5vhdjJ/LUjp/Yxd
         u3uRy4utj2YZ0uvybKu1iWT4aRq491IqGAhU9K87S4/Qx5VEVTS2nFH9nWDWAg+Nsei4
         m63D3L5kiUCDkcwz5NqM5Mr0zFZxFVhU8Yqv24ytATMOZhiSdAEiJKjMM8iU3fw/Ad5T
         T7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729069372; x=1729674172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PMXUrgToe89xgQYBl4Khev4CKJy7nqDnifoXpIAaoLY=;
        b=wz2VKjkADnVSbNtKjkuHP++Ox8pvuLq+cXm3OU3jvr4KBddskC8oc9zE4XYB0xy4pa
         MqoNuJRDVHt0wtnRwH3z0BQwrJSBHzQSoIVEn80QA5ddt2rXKkc8MdTZ158CMc5LX/ld
         0VVb4nkhhQsIgOdmEb37J30N/akXtkHpfaMjHlEMY2YAISEh/Ea/H0hFYw7hTZunBdXP
         JW2uHvUy57P1wXCyrwwVZhVhd3WCpkvPuL+GMIaBo6gA9AN7JuOjufb23JY/QbVOFdiV
         Gat4qi6jEcqoMLzVmtmEcv3IN3KKMCQ5QziZWbdw1/ZYxlV65UuPFo/5LGOvpGegou61
         HH+A==
X-Forwarded-Encrypted: i=1; AJvYcCXw2sek3W2QxWK2GNIuR7m4RSaura8zucPD8WuKcrU3ffBgiV3KxEdp1N8gsdIua2p30g4v9Mofm5hnebQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoqf74Pk7qCbT84Y2i54iKr7+GKEnyC0mzk8/y98zn/xdy22V4
	PPCvcgevyXHLARuoRU9LmZINeI+6SrhOBwS6anWmm3fvtuuDDlmAptR0+Qbuex6MrJ2oYPI/7iZ
	gtXChWDPpNajF3dfTrC+d+COux1yQvcGnOTB4EQ==
X-Google-Smtp-Source: AGHT+IFEaeSkhTvAd3suQ657G7BpFP9kXRA6RSvoZGNdttgtquk3Cngu8YooswMd9rM8I7LI8+LrdfVWQWuwI60zlAY=
X-Received: by 2002:a2e:bc26:0:b0:2fb:36df:3b4 with SMTP id
 38308e7fff4ca-2fb3f2c7231mr93597461fa.34.1729069367998; Wed, 16 Oct 2024
 02:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-gpio-notify-in-kernel-events-v3-0-9edf05802271@linaro.org>
 <20241015-gpio-notify-in-kernel-events-v3-6-9edf05802271@linaro.org>
 <20241016051944.GA42100@rigel> <20241016072730.GA120095@rigel>
 <CAMRc=MeAfuObBodQu24yUnDbYVd7bFQAeimF5U75chcAK69r6Q@mail.gmail.com> <20241016085719.GA195243@rigel>
In-Reply-To: <20241016085719.GA195243@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 16 Oct 2024 11:02:37 +0200
Message-ID: <CAMRc=MfcDK9u1T6=2kNoC-nfjkBHd8d38paZ-DvNG-1BLFr4_g@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] gpiolib: notify user-space about in-kernel line
 state changes
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 10:57=E2=80=AFAM Kent Gibson <warthog618@gmail.com>=
 wrote:
>
> On Wed, Oct 16, 2024 at 09:50:58AM +0200, Bartosz Golaszewski wrote:
> > On Wed, Oct 16, 2024 at 9:27=E2=80=AFAM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > On Wed, Oct 16, 2024 at 01:19:44PM +0800, Kent Gibson wrote:
> > > > On Tue, Oct 15, 2024 at 12:56:18PM +0200, Bartosz Golaszewski wrote=
:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > >
> > > > > -   return gpio_do_set_config(guard.gc, gpio_chip_hwgpio(desc), c=
onfig);
> > > > > +   ret =3D gpio_do_set_config(guard.gc, gpio_chip_hwgpio(desc), =
config);
> > > > > +   if (ret =3D=3D 0) {
> > > > > +           /* These are the only options we notify the userspace=
 about. */
> > > > > +           switch (pinconf_to_config_param(config)) {
> > > > > +           case PIN_CONFIG_BIAS_DISABLE:
> > > > > +           case PIN_CONFIG_BIAS_PULL_DOWN:
> > > > > +           case PIN_CONFIG_BIAS_PULL_UP:
> > > > > +           case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> > > > > +           case PIN_CONFIG_DRIVE_OPEN_SOURCE:
> > > > > +           case PIN_CONFIG_DRIVE_PUSH_PULL:
> > > > > +           case PIN_CONFIG_INPUT_DEBOUNCE:
> > > > > +                   gpiod_line_state_notify(desc,
> > > > > +                                           GPIO_V2_LINE_CHANGED_=
CONFIG);
> > > > > +                   break;
> > > > > +           default:
> > > > > +                   break;
> > > > > +           }
> > > > > +   }
> > > > > +
> > > > > +   return ret;
> > > > >  }
> > > >
> > > > Ah, the debounce - I forgot about that, and other features that cde=
v
> > > > might emulate.
> > > >
> > > > What happens if userspace requests a line with debounce that is
> > > > supported by hardware?  Seems to me we'll see both a LINE_REQUESTED=
 and a
> > > > LINE_CONFIG_CHANGED when the line is requested.
> > > >
> > >
> > > This is problematic for me to test at the moment, as gpiosim doesn't =
support
> > > debounce. Any chance we could make that configurable?  Similarly driv=
e.
> > >
> > > > Conversely, what if a config change impacts features that don't res=
ult in a
> > > > notification from gpiod_set_config(), like active low, or emulated
> > > > drive or debounce?
> > > >
> > >
> > > Bah, drive is emulated in gpiolib itself, so that should be fine.
> > >
> > > When changing config cdev always calls gpiod_direction_input/output()=
, so I
> > > think that covers the active low case.
> > >
> > > But I have a test taking a line from input to output|open_drain and I
> > > get two change events.  The first is the most interesting as it repor=
ts
> > > input|open_drain, the second then reports output|open_drain.
> > > That is due to gpiod_direction_output() calling gpiod_set_config() to
> >
> > No, it never calls gpiod_set_config() but gpio_set_config() which
> > never emits an event.
> >
>
> Depends whether the driver supports drive or not.
>
> If it does then
> line 2858:
>
>                 ret =3D gpio_set_config(desc, PIN_CONFIG_DRIVE_OPEN_DRAIN=
);
>

I'm seeing this:

gpiod_direction_output_nonotify()
  gpio_set_config()
    gpio_set_config_with_argument()
      gpio_do_set_config()
        gc->set_config()

There's no call to gpiod_line_state_notify() in this path.

Bart

> will emit.
>
> So your _nonotify function is calling a bunch of functions that can
> emit.
>
> Cheers,
> Kent.


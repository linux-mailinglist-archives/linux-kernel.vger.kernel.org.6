Return-Path: <linux-kernel+bounces-232482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563BF91A972
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C481C210CE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCED19750B;
	Thu, 27 Jun 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GYnw45iv"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB3196D90
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499457; cv=none; b=Wi+CooLhPZAziPAW00kV/PAO30LNNiAX6bIsH9suoT0AmZSvM9m32Q2XWtSyGOI6KNUlk+p52W02PqcVTmFJzlpozKa3s0JohnoSQbHY60FeKcCBMiT10zd/HP4fEi8SwKQZGYszQl/4CvrLId0R9lZSPtlHk5cFy0UQPrXwMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499457; c=relaxed/simple;
	bh=p9pna17dxJf6leivboS51PbMRGBOvVMhEdQUxZ9JrD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKiBtaW+MuOR2RDkSuhG8UD38DUB0m6jIlPTN1hXCUnyhUXUjAd6rHw/dZ0tR5jcQ0o8PYH3BPFK6NYhkQ4+2ebwFl9i971XwINBELxEIU2BX88w8X8eXz35jLjTzNAMMT5yaJp8NlFk0YDOwh4e2n7a2pX2HOAqYOjlXbMdWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GYnw45iv; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so89977941fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719499453; x=1720104253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mt1PW8KQSjv62tam2HgoKHC53tO1hnyc2ppFsKswIIU=;
        b=GYnw45ivi5vzy0ymsPlijpw1oGk3iqDGFgK22f+u67lJHpyHFY6dvQ7AxhMT/bL1Dn
         +avcWDpwq6q9h29SC1wGZJrofIa21BYAJcUfKy8n+SDACsgVMQbFgvh0AFuk/bMMlDTi
         Vu+nxptL9wuTSzTd5OfVPCTvvQvr4jxqOaTjhTgQVegXfst1diy8JEHLJ2sc0QHHWPLO
         4EsPlqE7ooBxxRlFULLf4iZac59jTMCwpQDJtJ9smSg2qQ+wVzY6JVbznTjVex/FZiOg
         pDSh0U9CYCXcmeval6WjCyoYPo+loyfjoSj5BiePiO2TSmht0t4zy0srrvGLwA6754O9
         ZAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719499453; x=1720104253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mt1PW8KQSjv62tam2HgoKHC53tO1hnyc2ppFsKswIIU=;
        b=LRfX3dtnA/DF4e4rfjFu/eMsv1r0A3PqHcLUGATM1R5cRngSspI+KSbsEE33AdwFWs
         rdbgaDjGPq5Eyojs7BO7zp1+TjIX05EVQXtSy5X6BPLs6pb6ebjFuLiQtk1X1gX918ra
         +zVz41fM4AjCGFad8569iXlnJSwpjA3bdn/M1AErsliplJ3jWqEt9ZdUjw9qmPEQchLO
         IGLBbNPue2+wNbFE+D4FqrxxP970Z7i/mwBS3SjTCWZ+WR4C7wflD9FVb3xGu2RogJPG
         fiRePDZ75jKsYudvwpjgEoUnVAU+uGoSY9pbn0v0PaFMXePK2fxpHrvFxyDAWoTf2Y1O
         IkRQ==
X-Gm-Message-State: AOJu0YzNwO/b77t0ltKrnIHFm07jRz2CKTiGvL19KZvImfvgMeeKBYkV
	pyuxwJpdFt1xBQbDbVUVNQE4LpBvmr03tbjjwDQdQAfFKnAc9aMm9LNdLxHiIeYMBImXqT+PaZG
	8PI4Gmh2AEsKtRecObigDvFjgddGgjMxRuuqzKw==
X-Google-Smtp-Source: AGHT+IE/UK+2UAGr7GImQyszvPkxcQdChPgKb0jw3JthaDznIKKsYeEl6cZTKlYgOhTVGE8hYcPYX+AUlr9ItOLWtHM=
X-Received: by 2002:a2e:9dd5:0:b0:2eb:d816:7a67 with SMTP id
 38308e7fff4ca-2ec5b37864dmr85812961fa.16.1719499453164; Thu, 27 Jun 2024
 07:44:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626052925.174272-1-warthog618@gmail.com> <20240626052925.174272-3-warthog618@gmail.com>
 <CAMRc=Me1_4xjbt51j+gFVzR71VUwMSAm+dT=UtgOY-1xYoAF5g@mail.gmail.com> <20240627142248.GA414403@rigel>
In-Reply-To: <20240627142248.GA414403@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 27 Jun 2024 16:44:02 +0200
Message-ID: <CAMRc=McA2rY=-k83Pkz-P5yu=bT2nE8JhNMiEAP2zFbf95SQqw@mail.gmail.com>
Subject: Re: [PATCH 2/4] gpiolib: cdev: Ignore reconfiguration without direction
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 4:22=E2=80=AFPM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Thu, Jun 27, 2024 at 04:06:21PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Jun 26, 2024 at 7:29=E2=80=AFAM Kent Gibson <warthog618@gmail.c=
om> wrote:
> > >
> > > linereq_set_config() behaves badly when direction is not set.
> > > The configuration validation is borrowed from linereq_create(), where=
,
> > > to verify the intent of the user, the direction must be set to in ord=
er to
> > > effect a change to the electrical configuration of a line. But, when
> > > applied to reconfiguration, that validation does not allow for the un=
set
> > > direction case, making it possible to clear flags set previously with=
out
> > > specifying the line direction.
> > >
> > > Adding to the inconsistency, those changes are not immediately applie=
d by
> > > linereq_set_config(), but will take effect when the line value is nex=
t get
> > > or set.
> > >
> > > For example, by requesting a configuration with no flags set, an outp=
ut
> > > line with GPIO_V2_LINE_FLAG_ACTIVE_LOW and GPIO_V2_LINE_FLAG_OPEN_DRA=
IN
> > > set could have those flags cleared, inverting the sense of the line a=
nd
> > > changing the line drive to push-pull on the next line value set.
> > >
> > > Skip the reconfiguration of lines for which the direction is not set,=
 and
> > > only reconfigure the lines for which direction is set.
> > >
> > > Fixes: a54756cb24ea ("gpiolib: cdev: support GPIO_V2_LINE_SET_CONFIG_=
IOCTL")
> > > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > > ---
> > >  drivers/gpio/gpiolib-cdev.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.=
c
> > > index f7a129d67b7d..ef08b23a56e2 100644
> > > --- a/drivers/gpio/gpiolib-cdev.c
> > > +++ b/drivers/gpio/gpiolib-cdev.c
> > > @@ -1534,12 +1534,14 @@ static long linereq_set_config(struct linereq=
 *lr, void __user *ip)
> > >                 line =3D &lr->lines[i];
> > >                 desc =3D lr->lines[i].desc;
> > >                 flags =3D gpio_v2_line_config_flags(&lc, i);
> > > +               /*
> > > +                * Lines not explicitly reconfigured as input or outp=
ut
> > > +                * are left unchanged.
> > > +                */
> > > +               if (!(flags & GPIO_V2_LINE_DIRECTION_FLAGS))
> > > +                       continue;
> >
> > Series looks good, thanks. I'd say that this bit here calls for at
> > least a debug-level message since we don't return an error unlike v1.
> > What do you think?
> >
>
> The change to the libgpiod Python bindings makes use of this to support
> reconfiguration of subsets, so on its own it isn't an abnormal path and
> I'm not sure it warrants even a debug.
>
> OTOH, I did consider if there should be a check that at least one line
> in the reconfig has a direction, returning an error if there are none, bu=
t
> was on the fence about it and left it out as it added complexity.
>
> Would that make more sense?
> Or do you have a problem with reconfiguring subsets?
>
> Cheers,
> Kent.

I see. Ok, I'll take it as is interpreting it as a feature.

Bart


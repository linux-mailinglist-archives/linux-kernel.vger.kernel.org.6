Return-Path: <linux-kernel+bounces-365104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B3999DD8C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2530A1F24442
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 05:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63759176AC7;
	Tue, 15 Oct 2024 05:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fqqI43QN"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EB43C3C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728970506; cv=none; b=muVflEl2sxuWniVTnEW+kWUBgUAV6cWUsmcG5K9T1ScWJ6EVDXwllHEIslNx968Iq5lxYuYtfwIzjgFHLdhBCUs84Mp+hnypPYFEM9i8k2tk5TPxxrYVuELen+AezuyPEIyE4bfcPS35c3utzQsJW8MtQT011yiL5XtyLnCuxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728970506; c=relaxed/simple;
	bh=JR6gZ2MYyBQRhGGMVIzq353IT1yqvpAlneMgFsqBvhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/k1E0ClwDtrXstYe9BPsQxEhJX0ihRdZ6m0TQNOFc72eHiEpwtOZnpskNRQsBsuIUAl0SWKsgnZej5l3Q2vqUp7NxZmc+1b/377svEoTQBn88yAnVmrT3dRkdXoxWjGyvLPDtKd5rwthc/0XFEuDSTjTtfK4/emtgoUL/WfhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fqqI43QN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso2347080e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728970503; x=1729575303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HWrH+K7cTgTjTPYZ+dL7fGmCBNocSiDK/Hn2JY2vEs=;
        b=fqqI43QNkB+bJpOjwnY8O0LZdEmGzSYuVG+oUajBkNI19xNVzxaF4A5pGBDvsp22Dp
         BNdSOvhl1OE1mqcug0JrlBYvF+dtgplaJckilfupNJGH+05Uptj67GNow7t9tXsLmbfO
         9bbqsnFPZ2htEJODKmaCx0JPvqdoY9vHBvvYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728970503; x=1729575303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HWrH+K7cTgTjTPYZ+dL7fGmCBNocSiDK/Hn2JY2vEs=;
        b=gIc/G65L4oddc5MfJU+qOat5Z8H+uixc4UdqtrqKnI0Llqq1/czUCqUCU7mf+y+UkX
         ksWAQJ/4fyI/qFmfeDYOSQ5YosrVeB9vVagrHJeRxnJqcejwet9F2VjgZboYuaYdVN0w
         p33jY3bRJI8wuzSHBoWt0iK93zpEqh85gYduNT/7B6Okbu883Hg6e59xtNJg8WoEcrcZ
         FHXcTubcmbkZKVFNGKJoVR0E967YEWJhGcjTaWg/pb1uH2XqHCx/F7ZUbiQmWk0WZEpI
         pWtyJWsObrdzWomnxu6Xm5nefbq85F40zAWBofQWE+NZhMf8+v950g7oNDBugvL8sDPi
         zLSg==
X-Forwarded-Encrypted: i=1; AJvYcCXEXkXZi171fz3nw7dwZxf/n0K1v32st/5VlQypIlIKA6r7PN0iWsYBKAb+6+iwehlC/5hXHuF0iNT3cUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+vC4eReYBLBt6MNoPnr9LNS+09cXMJrvHJkDIuS+kSmXPvrL
	uQ1iyqGBFSqQ6/weEEYChnyQe+KwweLC22axXJLkIbLtYGyxQETIBHb8ffseIFkDAMTszUk9kwG
	K/z7vgKZDXPOcKQbvtnwkzj7szp2QL3JK0ETF
X-Google-Smtp-Source: AGHT+IE/CwxLRzqmXVYjkMDrcTm2+DQg9NcGd7Zyw9exDfJ8teYEZF+svaLAA8rUa5571DxzVoiZK6455ROycmYsGCQ=
X-Received: by 2002:a05:6512:1598:b0:539:9155:e8d4 with SMTP id
 2adb3069b0e04-539e54d77ecmr4621333e87.8.1728970503111; Mon, 14 Oct 2024
 22:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-7-wenst@chromium.org>
 <Zwfwv-O9ln-PVMdc@smile.fi.intel.com> <CAGXv+5F=5f4R5AExANxOwgTL6_VbpHdNKKhHnzy_PDcxtcFoEQ@mail.gmail.com>
 <Zwz-benEP4PHbRb2@smile.fi.intel.com>
In-Reply-To: <Zwz-benEP4PHbRb2@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Oct 2024 13:34:52 +0800
Message-ID: <CAGXv+5HtDqf9MbGc53axP276fFA6riM85+Sa7nXHPvZcCb5-Pg@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] i2c: of-prober: Add GPIO support to simple helpers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, 
	Johan Hovold <johan@kernel.org>, Jiri Kosina <jikos@kernel.org>, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 7:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 14, 2024 at 12:06:16PM +0800, Chen-Yu Tsai wrote:
> > On Thu, Oct 10, 2024 at 11:20=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Tue, Oct 08, 2024 at 03:34:25PM +0800, Chen-Yu Tsai wrote:
> > > > Add GPIO support to the simple helpers for the I2C OF component pro=
ber.
> > > > Components that the prober intends to probe likely require their
> > > > regulator supplies be enabled, and GPIOs be toggled to enable them =
or
> > > > bring them out of reset before they will respond to probe attempts.
> > > > Regulator supplies were handled in the previous patch.
> > > >
> > > > The assumption is that the same class of components to be probed ar=
e
> > > > always connected in the same fashion with the same regulator supply
> > > > and GPIO. The names may vary due to binding differences, but the
> > > > physical layout does not change.
> > > >
> > > > This supports at most one GPIO pin. The user must specify the GPIO =
name,
> > > > the polarity, and the amount of time to wait after the GPIO is togg=
led.
> > > > Devices with more than one GPIO pin likely require specific power
> > > > sequencing beyond what generic code can easily support.
>
> ...
>
> > > > +     /* An empty string signals an unnamed GPIO */
> > > > +     if (!ctx->opts->gpio_name[0])
> > > > +             con_id =3D NULL;
> > > > +     else
> > > > +             con_id =3D ctx->opts->gpio_name;
> > >
> > > Can it use positive conditional?
> > >
> > >         if (ctx->opts->gpio_name[0])
> > >                 con_id =3D ctx->opts->gpio_name;
> > >         else
> > >                 con_id =3D NULL;
> >
> > You suggested writing it this way in your reply to v7. Please pick one.
>
> Oh, whatever you will finish with then, sorry for the noise.
>
> ...
>
> > > > +static void i2c_of_probe_simple_disable_gpio(struct device *dev, s=
truct i2c_of_probe_simple_ctx *ctx)
> > > > +{
> > > > +     if (!ctx->gpiod)
> > > > +             return;
> > >
> > > Do you need this check for the future patches?
> >
> > Not sure I follow. The check is needed because this function is called
> > in i2c_of_probe_simple_cleanup(), but the GPIO could have been released
> > earlier in i2c_of_probe_simple_cleanup_early(), and that makes this
> > function a no-op.
>
> Do you have a known race condition then? This is bad. You shouldn't rely =
on
> the sequence of events here, or the serialisation has to be added.
>
> > The helpers for the release side are quite short, but the ones on the
> > request side wrap some conditional and error handling. I think it's
> > better to keep it symmetric?
>
> Yes, but why do you need the above check, I didn't still get...
> I.o.w. you think that there is a gap in time that (if no check) the GPIO
> descriptor might be changed? But then how does it affect anyway the possi=
bility
> that it becomes not NULL even with the current code.

The opposite actually. Either it is always NULL, or it was initially valid,
but the early cleanup function released it and thus it became NULL by the
time this function gets called.

ChenYu

> > > > +     /* Ignore error if GPIO is not in output direction */
> > > > +     gpiod_set_value(ctx->gpiod, !ctx->opts->gpio_assert_to_enable=
);
> > > > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


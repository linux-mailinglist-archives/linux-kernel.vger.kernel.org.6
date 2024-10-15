Return-Path: <linux-kernel+bounces-365721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A3199E874
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54553B25D89
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED021EF081;
	Tue, 15 Oct 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2oN4jST"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BD1EB9E6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728993953; cv=none; b=qFpGmgGzNXBH347Mk6bPPqaC3CqQu3McCLaJSbuHq+LpfXHD7+2UAsgegKL/bBE5GwIrV02CDE4Aqu/QH2uRJkbu7XHPdKoOPxHSE6MT5QJEufFzfiAv8CggEnM83aT2cyQelRQINvpJTXqiVk1YAlK+E0HPgujujogC3n0W0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728993953; c=relaxed/simple;
	bh=TkH6GmEo4c9tnguqpqU/PvDipqNVka108zrquojRkfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FmnEZmApBZGbF7lE+jUkJUIsFacr/ZltrIF6MHdcYNZEfe9SVuvcjxcg5pC6H+yHYrl0eMbIkXwg9s7KsA8tZoLyEK+6G+0nmiDvhh9ZKvd22FIRLdaIs6QansQ/6CialRki9hXQJlzN4QxN5vwncYrS62+nOHagKnmrk2hb9qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e2oN4jST; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5389917ef34so5827479e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 05:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728993950; x=1729598750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pkU2eRjeKvSY6f0pSdTbycrkRgeCmqTec03rjYKyF8=;
        b=e2oN4jSTp0hQjZQT7F/jZLiSUj681eVWGqlZcJyQijdY+/mdOhyPTDZ1V5xwguoIbn
         7P28qyMu1BPQdBLO4/tVDto/TginTNo6iLExtjKz6wHIXUJb9I+WTug1ywopRRBB53yD
         18+9DEIpXjmhGPsCKuV401tlV3Q0gUjH3gHP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728993950; x=1729598750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pkU2eRjeKvSY6f0pSdTbycrkRgeCmqTec03rjYKyF8=;
        b=CPsb3UEgRRS/sbi14ezS1Y4uGztLT0iZ2O4ITyAtbFQFvg8SAE7hv7JjI0fWahYCAy
         PyZq9ANKGDnobH4b8GDrno6lB8ZJOH0pNMBpy6OcAs7Rwk5tLdmCIW/szHgL4Z2YyZEa
         MW5zodp754/rwLaAtdQotzZCI+PRt1EhBtz1yVifhGgrkvWAHpmIK5Vf4dRS3uEcTrly
         32c9hlp0cEOGo1cNYzoml+gJKVeqFdYgoP21u2bx8JjMT2HVrprCoGzeKf+GG0HSruDq
         nbg0tZD9ubUtEAYGAVDvPDRgvQIDCS33Hg6PfVEUTNfiCnrsf6XrCBjOc25Drg+DX9dN
         ENRg==
X-Forwarded-Encrypted: i=1; AJvYcCWfOC+Ahv/4YFwfvnAXhwxtch/ivcJJcXvbNBvCFRdoWiAKIOzLStEpYzVobWv99xzkkLSlBfuS+jh2iUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77sIcqtL1KflicEQ9VXcahDenRSLx6o9ZT2TYQ3/tOn3CYR3X
	ydfIVJaS6fduSthGd7dpDHtu0sae6cSUm9K/HV2+zRn0koOYIVBKVs9IqhX8ofce1mNrHxuUVF7
	Aw+RqbicdQu4mdErtL26MBmIVoCb8EkxYDHSy
X-Google-Smtp-Source: AGHT+IEQXdmQdNm+HUimDjCPdKjEChhYuf8aN9wLvl2NObC3Ky9RVqgYEBecyoCudKfI+sGJ8TfqR02sf0yymk/NXVk=
X-Received: by 2002:a05:6512:3da6:b0:536:a275:9d61 with SMTP id
 2adb3069b0e04-539e551624bmr5918785e87.21.1728993949587; Tue, 15 Oct 2024
 05:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-7-wenst@chromium.org>
 <Zwfwv-O9ln-PVMdc@smile.fi.intel.com> <CAGXv+5F=5f4R5AExANxOwgTL6_VbpHdNKKhHnzy_PDcxtcFoEQ@mail.gmail.com>
 <Zwz-benEP4PHbRb2@smile.fi.intel.com> <CAGXv+5EwSZFoE-Uzb5x1QfknkVfd64Z_uzR0YcvZ_pR9ktGUBA@mail.gmail.com>
 <Zw5PxMOrF8Ape3if@smile.fi.intel.com>
In-Reply-To: <Zw5PxMOrF8Ape3if@smile.fi.intel.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 15 Oct 2024 20:05:38 +0800
Message-ID: <CAGXv+5GXVdLg8+gHTAY2ur1u35HLFqq33DLfef_P3geDr3XrMQ@mail.gmail.com>
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

On Tue, Oct 15, 2024 at 7:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 15, 2024 at 01:31:40PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Oct 14, 2024 at 7:20=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Oct 14, 2024 at 12:06:16PM +0800, Chen-Yu Tsai wrote:
> > > > On Thu, Oct 10, 2024 at 11:20=E2=80=AFPM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Tue, Oct 08, 2024 at 03:34:25PM +0800, Chen-Yu Tsai wrote:
>
> ...
>
> > > > > > +static void i2c_of_probe_simple_disable_gpio(struct device *de=
v, struct i2c_of_probe_simple_ctx *ctx)
> > > > > > +{
> > > > > > +     if (!ctx->gpiod)
> > > > > > +             return;
> > > > >
> > > > > Do you need this check for the future patches?
> > > >
> > > > Not sure I follow. The check is needed because this function is cal=
led
> > > > in i2c_of_probe_simple_cleanup(), but the GPIO could have been rele=
ased
> > > > earlier in i2c_of_probe_simple_cleanup_early(), and that makes this
> > > > function a no-op.
> > >
> > > Do you have a known race condition then? This is bad. You shouldn't r=
ely on
> > > the sequence of events here, or the serialisation has to be added.
> >
> > No there isn't. Explanation below.
> >
> > > > The helpers for the release side are quite short, but the ones on t=
he
> > > > request side wrap some conditional and error handling. I think it's
> > > > better to keep it symmetric?
> > >
> > > Yes, but why do you need the above check, I didn't still get...
> > > I.o.w. you think that there is a gap in time that (if no check) the G=
PIO
> > > descriptor might be changed? But then how does it affect anyway the p=
ossibility
> > > that it becomes not NULL even with the current code.
> >
> > There are two codes paths, either
> >
> >     a) successfully finding a device and enabling it, or
> >     b) exhausting all options and not finding a device, because it was
> >        optional or it is malfunctioning.
> >
> > After either code path, this cleanup function is called.
> >
> > In path (a), the GPIO descriptor is released prior to enabling the devi=
ce,
> > because the descriptor is an exclusive resource, and as soon as the dev=
ice
> > is enabled, its corresponding driver may probe and request the same GPI=
O,
> > and would fail if it was not released.
> >
> > In path (b), nothing was enabled, and the GPIO descriptor was not relea=
sed
> > early.
> >
> > The cleanup function here accounts for both cases, hence the check.
>
> Yes, but the very same check is inside gpiod_set_value(). I'm still puzzl=
ed
> about the duplication. Maybe I'm missing something...

My bad. I did not check if the GPIO descriptor API had these checks.
In that case I will drop the check in this patch.


Thanks
ChenYu

> > A step-by-step description might be clearer:
> >
> > 1. i2c_of_probe_simple_enable()
> >    ...
> >    1a. i2c_of_probe_simple_get_supply()
> >    1b. i2c_of_probe_simple_get_gpiod()
> >    1c. i2c_of_probe_simple_enable_regulator()
> >    1d. i2c_of_probe_simple_set_gpio()
> >
> > 2. Loop through potential component options and probe; if one is found:
> >    2a. i2c_of_probe_simple_cleanup_early()
> >        2a-i. i2c_of_probe_simple_put_gpiod
> >    2b. Enable device and driver's probe() gets called
> >
> > 3. i2c_of_probe_simple_cleanup()
> >    3a. i2c_of_probe_simple_disable_gpio()
> >    3b. i2c_of_probe_simple_put_gpiod()
> >    3c. i2c_of_probe_simple_disable_regulator()
> >    3d. i2c_of_probe_simple_put_supply()
> >
> > > > > > +     /* Ignore error if GPIO is not in output direction */
> > > > > > +     gpiod_set_value(ctx->gpiod, !ctx->opts->gpio_assert_to_en=
able);
> > > > > > +}
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


Return-Path: <linux-kernel+bounces-367417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6380D9A0209
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9E0B252F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED46190073;
	Wed, 16 Oct 2024 07:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eUg6gLVu"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208E4188588
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729062092; cv=none; b=LrnRK9weECxYX9DRP4OkwzvCIIykrz3V3AJIxFuOZu0uHoAEN+cmkINwZIPN/uLJ5ma+P3kR6DDJzMu93nLNz94umVldTswiIPucJpqWv7cxNQ5OAn430Mlkkv8fr4qtT0yqbGKb/6RH+LvArm5y2xUWl1iZeRPrv+odzyr68eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729062092; c=relaxed/simple;
	bh=/Hzo2SkzwwDLKXCO8ZcuSqtq5C1ljEdpc4/rzPIw/Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaxM9AejOsYstZuIq8BUiR+uMglz3KOkEq08GbasiY6khg7IuNEYP82dJrB6vPkdX5qnFBtRFoe1K7UZ7bMiGgFGVqZL2TqqhMDdNzxXs+2mSvJJpNtyHiMhL0fIwPwVwBO6/VwTeDyBPM8tQbmY+9GV43CHcQHBDpJh89MOCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eUg6gLVu; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539fb49c64aso4073365e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729062089; x=1729666889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPSA6U2IhZgMRSFXZK5Yj7RxoQjZFaD6SSlWNz1Yb8o=;
        b=eUg6gLVuBC86WDl2T1PJB7ot1n118NOcGtI9tagwNB5ci0VXw2abchf0hjYHgT7Ihv
         r+TR/AQVOk17Czf+9IMIdx+PLoRqoJoZitaqiUo0z4ltQW33vWnQPVL/Gu8FXZL/jiQi
         G+hvU1L7GRihE00Ieh34wqSkn7IhkFOgayFGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729062089; x=1729666889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPSA6U2IhZgMRSFXZK5Yj7RxoQjZFaD6SSlWNz1Yb8o=;
        b=pTpW5mAzYMh+k+JkfExDKX5c7Sn3uZdV0ExC2xUQybQBxjq4A5ZA/fY5E6EcuCTb0B
         WA45IkSyaH/sR9/d8cN5aIsMfis/kNOUnl4R+/DF84BzWAKYc5+vgsWe//gvhR1VluLu
         kHCflo7aebbYF2rmQFU676kC+N1yKxxgVGAYByAqbS4mm4Rmie3rXZXj+QJVT7ZwXpjq
         F2wxQ4wEN4kS45EAZrLtGctc8AbCC+/PG/QcDV6dd4ekU5ZCD6OVXnOeqWJUg9eRk081
         x0p1x0jR3NbdOIJxXCyk+iXndjAXwagJnTeT5yQZTtZkPnZ+V8exCk5P+c0EdVZ2xRAK
         Y4fg==
X-Forwarded-Encrypted: i=1; AJvYcCU1kl0R8ySOe+m+ccERfVOvcALgeDzTldu/Vdk6M1uru5XcNTQybzfiKIg3WBvqeQ9Ygu8azttzqAv68jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfg/+8kfsXx8QkqCtXeuld4gEA66QlqNblp3oP14F9FaJJazzL
	Qu9/DjS9qf61RYfk/cQDiDCsyqegG2BrqjS5yg/1pxoLTw5e/t+edkIgPmpHZIp5co2Ck+lvKxA
	Z7hz37mZpBKZ7ux4uIEsmQ6JwMSDd3lDV6Yyl
X-Google-Smtp-Source: AGHT+IF9nGtCldCGOeLQrTN0Aa5+OFXxu1e3xzkOPVJhXANUIs3qmwtgnQsHFXF0n+2Y3Vn8cKEwmSavH38AfXohfvY=
X-Received: by 2002:a05:6512:2398:b0:536:741a:6bc5 with SMTP id
 2adb3069b0e04-539e54d6122mr10014310e87.12.1729062089143; Wed, 16 Oct 2024
 00:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-5-wenst@chromium.org>
 <CAD=FV=WRSjk3U9Kau0wqkgv3KB=9jM6wCM9Gs-WxWai35sfxTg@mail.gmail.com>
In-Reply-To: <CAD=FV=WRSjk3U9Kau0wqkgv3KB=9jM6wCM9Gs-WxWai35sfxTg@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 16 Oct 2024 15:01:17 +0800
Message-ID: <CAGXv+5FW0UTjR_ZiqZ8VEOQkBemt54omtJe_aTj3jvScC-LuMw@mail.gmail.com>
Subject: Re: [PATCH v8 4/8] i2c: Introduce OF component probe function
To: Doug Anderson <dianders@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wolfram Sang <wsa@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 1:58=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Oct 8, 2024 at 12:35=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > +int i2c_of_probe_component(struct device *dev, const struct i2c_of_pro=
be_cfg *cfg, void *ctx)
> > +{
> > +       const struct i2c_of_probe_ops *ops;
> > +       const char *type;
> > +       struct i2c_adapter *i2c;
> > +       int ret;
> > +
> > +       ops =3D cfg->ops ?: &i2c_of_probe_dummy_ops;
> > +       type =3D cfg->type;
> > +
> > +       struct device_node *i2c_node __free(device_node) =3D i2c_of_pro=
be_get_i2c_node(dev, type);
> > +       if (IS_ERR(i2c_node))
> > +               return PTR_ERR(i2c_node);
>
> I'm still getting comfortable with the __free() syntax so sorry if I'm
> wrong, but I _think_ the above is buggy. I believe that the definition
> of the free function for "device_node" is from:
>
> DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
>
> ...which means it'll call of_node_put() to free "i2c_node" when it
> goes out of scope. of_node_put() handles NULL pointers but _not_ ERR
> pointers. So I think that if you get an error back and then return via
> the PTR_ERR(i2c_node) then it'll crash because it will try to free an
> ERR pointer. Did I get that right? Presumably you need to instead do:
>
>   return PTR_ERR(no_free_ptr(i2c_node));
>
> ...or change of_node_put() to be a noop for error pointers?

Good catch! As Andy suggested, it should be updated to handle both.
I'll add a patch for this.

> > +struct i2c_of_probe_ops {
> > +       /**
> > +        * @enable: Retrieve and enable resources so that the component=
s respond to probes.
> > +        *
> > +        * Resources should be reverted to their initial state before r=
eturning if this fails.
>
> nit: might be worth explicitly noting that returning -EPROBE_DEFER is
> OK here because this both retrieves resources and enables.

Makes sense. Will do.

> > +        */
> > +       int (*enable)(struct device *dev, struct device_node *bus_node,=
 void *data);
> > +
> > +       /**
> > +        * @cleanup_early: Release exclusive resources prior to enablin=
g component.
>
> nit: change the word "enabling" to "calling probe() on a detected"
> since otherwise it could be confused with the "enable" function above.

Makes sense. Will do.


ChenYu


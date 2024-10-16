Return-Path: <linux-kernel+bounces-367494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6EF9A0303
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F110286375
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E791D131B;
	Wed, 16 Oct 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UiqaUB6z"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AEF1C4A3B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064961; cv=none; b=H8Ufzi0HLyBcUGZQsVO0qS89JFmkBT9HNGFsNpql/1QjPTxw4Vuqy4B+363ruVZVasWM1y/eyY1J3JB4sfHhMHlXpRASQTPtnCUoXCH9KUEsN7FqDtOP0vg1nq2eTMWcOV25+huaBsYuRb9CwFgqZYZbS3FyqmUk3t/HzEBwFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064961; c=relaxed/simple;
	bh=PyStb3/Pmwe3ISP9nOh9GcWb5KrhI9ZlHni3WfxuEa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ND48bYHt5criKemMnvJXB+FsL/NICMUKMzl2Dv+435xDGkiCi/nY8DiHgMmNaQFjEulcR+bOgHxSgJGDqNWvqUVcSvvkZa73w4jw0x517WWgAkanbJ61F2z81urj8rRy2HDLNIMIPnopS7ZKcYu0nwFtpV8E9gC/i2qk8BVOMuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UiqaUB6z; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f72c913aso3449558e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729064957; x=1729669757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QN7AKsuA98PPPT8uDMCj6K1ZQtwWhhEOz7w0/8n7gmE=;
        b=UiqaUB6zqksj4LqvvhwZRd1QcwjbIQhC3Gt3DSCur+h+AhU/fTCKVz84U3GOseihVH
         ySyovaIsgiYYVAmNlg3kc2CeQdKJ1/qta+WsQoO1w1vp6BdAT5q+9S+FBo0gVWqyF9Ta
         skHgXors/JU2Yi2FFkDvL0iK5+2jn+RdDHX8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064957; x=1729669757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QN7AKsuA98PPPT8uDMCj6K1ZQtwWhhEOz7w0/8n7gmE=;
        b=M9V0CBy5ZTE3yZeqUlkhCn7o5Tbqevch8jQw2vwCqtjZNflvnyxQbvudAIcxO57KIj
         UyBUKXr4X1tQ9ghtXAANt6ST51tMq1VSvVe+PLuf7DS485CcFyBE3aA3fksoUU2xaCjr
         TTKVQD6eEeZ7WjnesthHgxQK8WlJg5lYHAzfsdbi5XvRFEvC6gjZZmkMZRPYOKQGWMq3
         SfuWedWU9OjHYNKZXJ+zFL0JeHh1vHF/rYiVN+8m5vPPYRPsShd95INC8RD5+KTwEaBE
         9BrNs9HILjx/BTWVuZonXWTDUZj2ZUnweAZGaqeCpgRngSwmdvHXeoK3+XVy1lBgiwpk
         RsjA==
X-Forwarded-Encrypted: i=1; AJvYcCV6otqoofZdlPv9Rv91UCpRRak7MMb6umGuqYuoOm7Fbk6jUEEzCr/kgHxxD+lEScQm4YbqPuv1sBniaxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybvs5Fq/CnN3wW4AumYD3qo834jQNBcRcM0JmjiwpOkD5kdeog
	eRqh1x0GZtJ2RFZVg+Bi7FVXe8+UiSlanwAT3uqoOHS9qChgO9KQhKZyOV5OJRBmDS0x8eU52BA
	JlLhP4zmcCBzdTBublT40Bio4f9J8SvpQeEAh
X-Google-Smtp-Source: AGHT+IHvTkwvjhIgGqx3Y94zbgKp7DdoAxdd+wPihZcQpAEuvOqZHroRtSnL6ezi7qQpWv1axzh0aG7P3lW1zmgXUYU=
X-Received: by 2002:a05:6512:b08:b0:52e:7542:f469 with SMTP id
 2adb3069b0e04-53a03ea078amr2069607e87.0.1729064956730; Wed, 16 Oct 2024
 00:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008073430.3992087-1-wenst@chromium.org> <20241008073430.3992087-7-wenst@chromium.org>
 <CAD=FV=X+_iYi0_RSakh6bzVYuNpiqUvjHTrL81n8h4dO+WZf9g@mail.gmail.com>
In-Reply-To: <CAD=FV=X+_iYi0_RSakh6bzVYuNpiqUvjHTrL81n8h4dO+WZf9g@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 16 Oct 2024 15:49:05 +0800
Message-ID: <CAGXv+5FTdNqK14OYe=PN5_BcF9Ve7-FyBTKz=mJ+1QiiUzu0_Q@mail.gmail.com>
Subject: Re: [PATCH v8 6/8] i2c: of-prober: Add GPIO support to simple helpers
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

On Wed, Oct 16, 2024 at 2:00=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Oct 8, 2024 at 12:35=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org>=
 wrote:
> >
> > +static void i2c_of_probe_simple_disable_gpio(struct device *dev, struc=
t i2c_of_probe_simple_ctx *ctx)
> > +{
> > +       if (!ctx->gpiod)
> > +               return;
> > +
> > +       /* Ignore error if GPIO is not in output direction */
> > +       gpiod_set_value(ctx->gpiod, !ctx->opts->gpio_assert_to_enable);
>
> I'm not sure I understand the comment. Does disable() ever get called
> when set() wasn't called beforehand? How could it not be in output
> direction?

You're right. I think it was carried over (in my mind) from when it was
still four callbacks.

> >  void i2c_of_probe_simple_cleanup(struct device *dev, void *data)
> >  {
> >         struct i2c_of_probe_simple_ctx *ctx =3D data;
> >
> > +       /* GPIO operations here are no-ops if a component was found and=
 enabled. */
>
> Instead of the above, maybe:
>
> GPIO operations here are no-ops if i2c_of_probe_simple_cleanup_early()
> was called.

Makes sense. Will change.

> Just commenting nits, so:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

I assume this stands even after Andy's suggestion to drop the gpiod check
is applied.

Thanks
ChenYu


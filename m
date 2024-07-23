Return-Path: <linux-kernel+bounces-260349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E130793A7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113811C21A18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535C13E88C;
	Tue, 23 Jul 2024 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jz+4h2FB"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8D13D504
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721762270; cv=none; b=Y3/yUEYGIGtU0B9lKWrksdZT3RjqfystbnXIVXbM/2fWgb7t+BRotNlxVD31QnHvUVZyARqf73PVUdmG3d4XU3y7PM1B3fvYfYiEpJSmn3yMeBinwEJ7y9d7J7jPezKMTr7y3yb7nTj7sgwK7pq+AV89BfSBCvOJ9LfJqoWmzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721762270; c=relaxed/simple;
	bh=MoSUe8UtDKgYAQJpc7bEXz/Ktusv4aoCQejwWcyA59Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Syz6OVu5FqWj19Y+yOuw+NoTn+wXz2yg+N4RCuuZ9j+iGgmxDj2Kfn095EMp7ba7OJlPuQ7dHLhPzah7xNR99vdZo+xgJa4ylm/iG/aPjKkoMlXMUPcuO7YmhDOvmfuyi9XZuHefwtR7HK9xeaYBCTt1Eg5Vv1kyww9Menbh+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jz+4h2FB; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b97097f7fdso18886976d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721762266; x=1722367066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0HgeFN0Ay5AIJvxgptlaXcddVWeUebYTJmY/Mw+Yg0=;
        b=Jz+4h2FBbNBKx0fZMgdQJW0EUD/Tqe4/zP71KkkGCf8qU31INhObZGYtKDar1BArdo
         GJ6jn3bdpxexBjVV5PHr+3n1wuU+Soh5OMvn9hYKNrgu0MBuNx3iwLj3clZGXf6xvMvE
         UbUK2ACWxOvKfuIVzoQy8Ed8hsuv9p3PsNV0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721762266; x=1722367066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0HgeFN0Ay5AIJvxgptlaXcddVWeUebYTJmY/Mw+Yg0=;
        b=rBeSB86rxUKkPwnabLex0qhDKli25qUeL3TWr5QEuR3rQt8F39uzmXDsf8R3G9ws/i
         RjgP6ZDb/eaYh+rLaHu4DGvRsnm7V7DMjSwJH1uHKZU1+cDpgT0hSvTlLah5A1C3FGcK
         lf7wor6fdpCdmDgTr/dNoTD1eOExDtSQJN/wYsmb942anjbF5oYWCoETum7aP5ZtKymK
         WX5MwVlIlD5sKB9QzTZgEzMSroM/pbo1B07BhaS/868n0g2/zDBMS3NiWyMXveO+Nyqd
         x5b9+T6qnA68NBvX7COi8uquBsXPEZbpvnVAlR0RPcA5qAtTixIehwl6MbHBY9n8WAwx
         ZV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2xKGAR5xpCBCmnW5CLfH98onDjjyylHouzSkpmUqwlQeEGXIXjNa0qQuBHWoigIuPsGi6my5VroZ27R2SlXBkUHFGx1BBP9vLScw0
X-Gm-Message-State: AOJu0Ywtvk+8pBufiQsm4E896impXe7M0XxSEtdNy/T3g2JHRUlv+2zT
	YDHfazTawO5oozhTZxW08ai1dj8h4IT5JS/n4C0XqZ5Xwr0+/1CHD+R3wD1NqYvuY6l8zVhxb1c
	=
X-Google-Smtp-Source: AGHT+IEzo8k5j7KOquGfqnp5wweDesdW8cvA3nnIV0TlMQt9tmx3KV2EqKMuNGYiiasWRGjACAF27g==
X-Received: by 2002:a05:6214:27ee:b0:6b5:52da:46f2 with SMTP id 6a1803df08f44-6b98ecf4b5emr5826926d6.6.1721762266074;
        Tue, 23 Jul 2024 12:17:46 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7b4b92c7fsm46536566d6.89.2024.07.23.12.17.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 12:17:44 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-447f8aa87bfso91481cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 12:17:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6DEeSrngMd36Hy9VuEFcTTc/CdA36YnwUPb0oLC1JUJO9b6DlPClBRO/48vfe0PyLyVgFB8UBvSC0G6ppMWqqUexyZV8nHjjLG6Pi
X-Received: by 2002:a05:622a:491:b0:447:d81a:9320 with SMTP id
 d75a77b69052e-44fd4c6382dmr843151cf.20.1721762263871; Tue, 23 Jul 2024
 12:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-0-af473397835d@linaro.org>
 <20240709-topic-sdm450-upstream-tbx605f-panel-v1-2-af473397835d@linaro.org>
In-Reply-To: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-2-af473397835d@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 23 Jul 2024 12:17:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VL1Wxd0veW7N+0Hy=LdKMzNbBang9_EZ9Zo_d-wZOBfw@mail.gmail.com>
Message-ID: <CAD=FV=VL1Wxd0veW7N+0Hy=LdKMzNbBang9_EZ9Zo_d-wZOBfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: add BOE tv101wum-ll2 panel driver
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 9, 2024 at 6:06=E2=80=AFAM Neil Armstrong <neil.armstrong@linar=
o.org> wrote:
>
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makef=
ile
> index 5581387707c6..79c90894b6a4 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0) +=3D panel-boe-b=
f060y8m-aj0.o
>  obj-$(CONFIG_DRM_PANEL_BOE_HIMAX8279D) +=3D panel-boe-himax8279d.o
>  obj-$(CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A) +=3D panel-boe-th101mb31=
ig002-28a.o
>  obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6) +=3D panel-boe-tv101wum-nl6.o
> +obj-$(CONFIG_DRM_PANEL_BOE_TV101WUM_LL2) +=3D panel-boe-tv101wum-ll2.o

nit: please sort. L comes before N.


>  obj-$(CONFIG_DRM_PANEL_DSI_CM) +=3D panel-dsi-cm.o
>  obj-$(CONFIG_DRM_PANEL_LVDS) +=3D panel-lvds.o
>  obj-$(CONFIG_DRM_PANEL_SIMPLE) +=3D panel-simple.o
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c b/drivers/gpu=
/drm/panel/panel-boe-tv101wum-ll2.c
> new file mode 100644
> index 000000000000..5513cb48d949
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-ll2.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Generated with linux-mdss-dsi-panel-driver-generator from vendor devi=
ce tree:
> +//   Copyright (c) 2013, The Linux Foundation. All rights reserved.
> +//   Copyright (c) 2024, Neil Armstrong <neil.armstrong@linaro.org>
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

nit: sort header files?

> +static int boe_tv101wum_ll2_prepare(struct drm_panel *panel)
> +{
> +       struct boe_tv101wum_ll2 *ctx =3D to_boe_tv101wum_ll2(panel);
> +       struct device *dev =3D &ctx->dsi->dev;
> +       int ret;
> +
> +       ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies),
> +                                   ctx->supplies);
> +       if (ret < 0)
> +               return ret;
> +
> +       boe_tv101wum_ll2_reset(ctx);
> +
> +       ret =3D boe_tv101wum_ll2_on(ctx);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to initialize panel: %d\n", ret);

nit: Do you really need this error message? The "_multi" variants are
all chatty and print the error message, so we don't really need this
here...


> +               gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +               return ret;

Shouldn't you turn off the regulators?


> +static int boe_tv101wum_ll2_unprepare(struct drm_panel *panel)
> +{
> +       struct boe_tv101wum_ll2 *ctx =3D to_boe_tv101wum_ll2(panel);
> +       struct device *dev =3D &ctx->dsi->dev;
> +       int ret;
> +
> +       ret =3D boe_tv101wum_ll2_off(ctx);
> +       if (ret < 0)
> +               dev_err(dev, "Failed to un-initialize panel: %d\n", ret);

nit: Do you really need this error message? The "_multi" variants are
all chatty and print the error message, so we don't really need this
here...


> +
> +       gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> +
> +       regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> +
> +       return 0;

Maybe add a comment justifying why you don't return the error code
that boe_tv101wum_ll2_off() returned?


> +static int boe_tv101wum_ll2_get_modes(struct drm_panel *panel,
> +                                     struct drm_connector *connector)
> +{
> +       return drm_connector_helper_get_modes_fixed(connector, &boe_tv101=
wum_ll2_mode);

Random question for you: on panels that don't use the
drm_connector_helper the "bpc" gets set here. Is there a reason why
some panel drivers (like this one) don't set bpc?


> +static int boe_tv101wum_ll2_probe(struct mipi_dsi_device *dsi)
> +{
> +       struct device *dev =3D &dsi->dev;
> +       struct boe_tv101wum_ll2 *ctx;
> +       int ret;
> +
> +       ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return -ENOMEM;
> +
> +       ctx->supplies[0].supply =3D "vsp";
> +       ctx->supplies[1].supply =3D "vsn";
> +
> +       ret =3D devm_regulator_bulk_get(&dsi->dev, ARRAY_SIZE(ctx->suppli=
es),
> +                                     ctx->supplies);

Any chance I can convince you to use devm_regulator_bulk_get_const()?
Then you can list your supply structures as "static const" instead of
having to initialize them via code.


> +       if (ret < 0)
> +               return ret;
> +
> +       ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +       if (IS_ERR(ctx->reset_gpio))
> +               return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +                                    "Failed to get reset-gpios\n");
> +
> +       ctx->dsi =3D dsi;
> +       mipi_dsi_set_drvdata(dsi, ctx);
> +
> +       dsi->lanes =3D 4;
> +       dsi->format =3D MIPI_DSI_FMT_RGB888;
> +       dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BUR=
ST |
> +                         MIPI_DSI_MODE_VIDEO_HSE;
> +
> +       drm_panel_init(&ctx->panel, dev, &boe_tv101wum_ll2_panel_funcs,
> +                      DRM_MODE_CONNECTOR_DSI);
> +       ctx->panel.prepare_prev_first =3D true;
> +
> +       ret =3D drm_panel_of_backlight(&ctx->panel);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "Failed to get backlight\n=
");
> +
> +       drm_panel_add(&ctx->panel);

Any chance you could add devm_drm_panel_add() and then use it? Then
you can fully get rid of your remove and error handling since
devm_mipi_dsi_attach() already exists. Note that this would not change
object lifetimes at all since you're already calling
drm_panel_remove() in your remove code--it would just clean up the
code...


> +static struct mipi_dsi_driver boe_tv101wum_ll2_driver =3D {
> +       .probe =3D boe_tv101wum_ll2_probe,
> +       .remove =3D boe_tv101wum_ll2_remove,
> +       .driver =3D {
> +               .name =3D "panel-boe-tv101wum_ll2",
> +               .of_match_table =3D boe_tv101wum_ll2_of_match,
> +       },
> +};
> +module_mipi_dsi_driver(boe_tv101wum_ll2_driver);
> +
> +MODULE_DESCRIPTION("DRM driver for Boe TV101WUM-LL2 Panel");

Should "Boe" be "BOE" ?


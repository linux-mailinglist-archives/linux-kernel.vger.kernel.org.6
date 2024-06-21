Return-Path: <linux-kernel+bounces-223785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E205911824
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013C8B213A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F58287D;
	Fri, 21 Jun 2024 01:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQczGmzk"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88052F2F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934219; cv=none; b=MLwK9JQIZwSRuxJ1oPqmcJ9bC5wuNTXaQWbigorBnDGML0QzVsPIV3vOU0uQImjbnojwkx4A/m0VqsTTO2BAUE5SQxg4vQB0Dr8WLr2y18ksugHmuDs1ry+TvzbJt7VJCV3bJ3EtRtwI40uoGl5T+5GDOS482ZAkXRWOTyLiGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934219; c=relaxed/simple;
	bh=o34UvPbCxcXcUfT8nN4zJTW0tdEx/03plVr9C6dfJeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dTBSjrdyD08hG2+YxEjw4s5ZiowZUXXhXNj2QtmudQSbHCKMrjTeY9UvUfvZsJNvnoaoRA6Kf2EgErcjs0MaYtELLaA1rp2N+U3zEkkhDTZD9Vo41AsldPr6ltp7tGO08zickMCUVl6QWiIO4X6JClzdfi6QLq/OPOPTpiOJQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQczGmzk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57d203d4682so1786765a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718934216; x=1719539016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t/MykFi1Rd45hp+4W7HG+OPx1GAcGVoTa1TKgwh/O6k=;
        b=JQczGmzkvVDT8AJrSPTfUWkYP9obeeWK1W7QkVtQOei/+75UkWocJUKOzd1/ij1ZKT
         Z/AbVjJCY5ugmecwCTD4YLnccVCbdMGl+rqBgV9KYHcOsdQ7pPZ5z1xSFBs+qTbinbXC
         DhYeeL4xoK+dI7MW6OTbZ9l1eEwuBR7FPcmBLVgApxSoGV+B7tAm9u2yEZA7WhYyPzQA
         mvWg97jQEyoX+4C06Yulj70TFMyjzzlSGNtYrlU4Vge0gobbTVD4MOndtW+MDUiHZ1Lr
         yiTd+N2e7fTiEbkhSeaiIojlp96TuwMQE6yapQkJ1nv6LZ066w/UMGanQc62uhSZrTP7
         X1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718934216; x=1719539016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/MykFi1Rd45hp+4W7HG+OPx1GAcGVoTa1TKgwh/O6k=;
        b=rIPXbfgzUISREqxsWKk6rlhV3dWqcMB09DemwqnGO7a/R1hQMuPshoOpgvAF3GX0lJ
         9Zhid4Oso7mg1yy6na/GUkf0qTaYRHe/ixjkC+GiDu+lWkLzCzvLzAWO8dG6pASHbRqj
         8a/0wXIrs3nuIPyDOyfCJswXL9SnKulYR7Ej7KbZer7GOkkrrSioDTKhu3RH0LVlmMno
         XO5IIzz8pvzUysPohGBjQurf7ml4NvbV4qqHgrqSHfW5fXe8rvhhBLJ36H74q8c3fkY0
         A7XOnfJzXL6Op10PinRfnwnXCJ25PCr4BQ5zwF04hEJCjbKZ2jNpmv8R75O1mqzsUhE2
         Kdcg==
X-Forwarded-Encrypted: i=1; AJvYcCXJzJM/Nk93bKydQG/I4kSIe4tvT9R4upWj5ZEa+MVM7BuWweHOVufQuvMF9aev7CPw6xxxAaHxoLL00ym/BoyQ4vjy0J+jjMll25XB
X-Gm-Message-State: AOJu0YwGyxoLc9p/9JlJ+XrxY4/f5XGZPjBtUjowKu0prPjWNZEaeSW6
	N5jsr0Uka488f+lBnFq2/mZnpLStof65tF3XrKSbnnx9p6eBXpXRTqxZGs0qlDU4E8W6VmRVylp
	TZmpgcuQUFMGcewzSS3tryjJTepDWqsSRrdj/CA==
X-Google-Smtp-Source: AGHT+IEEhJWU5lH/YnMBYpC0VRfm8ILGJplMvmMfCBQAbgBcvoVMdYiAe6GSTbydGUVMd9Wa4ALAYUU1S2QyTH2HSZ0=
X-Received: by 2002:a50:aa8d:0:b0:578:676e:324 with SMTP id
 4fb4d7f45d1cf-57d07e7b2aemr4030050a12.17.1718934215679; Thu, 20 Jun 2024
 18:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620115245.31540-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240620115245.31540-3-lvzhaoxiong@huaqin.corp-partner.google.com> <bmmng663zqsc4xolkh6jdbu6yj637f3k6qbclxgi6fcmm4hv7z@i7ycd36flcha>
In-Reply-To: <bmmng663zqsc4xolkh6jdbu6yj637f3k6qbclxgi6fcmm4hv7z@i7ycd36flcha>
From: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Fri, 21 Jun 2024 09:43:24 +0800
Message-ID: <CA+6=WdT80hcAW4f=UDcO2d3e+ODcRjAQBOUug7M6vgmtAEY1SA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/panel: starry-er88577: add new panel driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 3:56=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, Jun 20, 2024 at 07:52:45PM GMT, Zhaoxiong Lv wrote:
> > The bias IC of this starry-er88577 panel is placed
> > on the panel side, so when the panel is powered on,
> > there is no need to control AVDD and AVEE in the driver,
> > only 3.3v and reset are needed.
> >
> > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com=
>
> > ---
> > Chage since V3:
> > -  1. Adjust the ".clock" assignment format.
> >
> > v3: https://lore.kernel.org/all/20240614145609.25432-3-lvzhaoxiong@huaq=
in.corp-partner.google.com/
> >
> > Chage since V3:
> > -  Separate Starry-er88577 from the panel-kingdisplay-kd101ne3 driver.
> > -  Use mipi_dsi_dcs_set_display_on_multi().
> > -  Use mipi_dsi_dcs_exit_sleep_mode_multi() and mipi_dsi_msleep().
> >
> > v2: https://lore.kernel.org/all/20240601084528.22502-5-lvzhaoxiong@huaq=
in.corp-partner.google.com/
> >
> > Chage since V2:
> > -  Add compatible for Starry er88577 in panel-kingdisplay-kd101ne3 driv=
ers.
> >
> > ---
> >  drivers/gpu/drm/panel/Kconfig                |   9 +
> >  drivers/gpu/drm/panel/Makefile               |   1 +
> >  drivers/gpu/drm/panel/panel-starry-er88577.c | 343 +++++++++++++++++++
> >  3 files changed, 353 insertions(+)
> >  create mode 100644 drivers/gpu/drm/panel/panel-starry-er88577.c
> >
> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kcon=
fig
> > index e54f6f5604ed..a52aa2552ab8 100644
> > --- a/drivers/gpu/drm/panel/Kconfig
> > +++ b/drivers/gpu/drm/panel/Kconfig
> > @@ -781,6 +781,15 @@ config DRM_PANEL_SITRONIX_ST7789V
> >         Say Y here if you want to enable support for the Sitronix
> >         ST7789V controller for 240x320 LCD panels
> >
> > +config DRM_PANEL_STARRY_ER88577
> > +     tristate "Starry er88577 panel"
> > +     depends on OF
> > +     depends on DRM_MIPI_DSI
> > +     depends on BACKLIGHT_CLASS_DEVICE
> > +     help
> > +       Say Y if you want to enable support for panels based on the
> > +       Starry er88577 controller.
> > +
> >  config DRM_PANEL_SONY_ACX565AKM
> >       tristate "Sony ACX565AKM panel"
> >       depends on GPIOLIB && OF && SPI
> > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Mak=
efile
> > index f0203f6e02f4..ecd843a6dc6e 100644
> > --- a/drivers/gpu/drm/panel/Makefile
> > +++ b/drivers/gpu/drm/panel/Makefile
> > @@ -81,6 +81,7 @@ obj-$(CONFIG_DRM_PANEL_SHARP_LS060T1SX01) +=3D panel-=
sharp-ls060t1sx01.o
> >  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) +=3D panel-sitronix-st7701.o
> >  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) +=3D panel-sitronix-st7703.o
> >  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) +=3D panel-sitronix-st7789v.o
> > +obj-$(CONFIG_DRM_PANEL_STARRY_ER88577) +=3D panel-starry-er88577.o
> >  obj-$(CONFIG_DRM_PANEL_SYNAPTICS_R63353) +=3D panel-synaptics-r63353.o
> >  obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) +=3D panel-sony-acx565akm.o
> >  obj-$(CONFIG_DRM_PANEL_SONY_TD4353_JDI) +=3D panel-sony-td4353-jdi.o
> > diff --git a/drivers/gpu/drm/panel/panel-starry-er88577.c b/drivers/gpu=
/drm/panel/panel-starry-er88577.c
> > new file mode 100644
> > index 000000000000..e6088262ee69
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-starry-er88577.c
> > @@ -0,0 +1,343 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Panels based on the ER88577 display controller.
> > + * Author: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include <drm/drm_connector.h>
> > +#include <drm/drm_crtc.h>
> > +#include <drm/drm_mipi_dsi.h>
> > +#include <drm/drm_panel.h>
> > +
> > +#include <video/mipi_display.h>
> > +#include <drm/drm_probe_helper.h>
> > +
> > +struct starry_panel;
> > +
> > +struct panel_desc {
> > +     const struct drm_display_mode *modes;
> > +     unsigned int bpc;
> > +     unsigned long mode_flags;
> > +     enum mipi_dsi_pixel_format format;
> > +     const struct panel_init_cmd *init_cmds;
> > +     int (*init)(struct starry_panel *starry);
> > +     unsigned int lanes;
> > +     bool discharge_on_disable;
> > +     bool lp11_before_reset;
> > +     unsigned int power_off_delay_ms;
> > +};
> > +
> > +struct starry_panel {
> > +     struct drm_panel base;
> > +     struct mipi_dsi_device *dsi;
> > +
> > +     const struct panel_desc *desc;
> > +
> > +     enum drm_panel_orientation orientation;
> > +     struct regulator *vccio;
> > +     struct gpio_desc *reset;
> > +};
> > +
> > +static int starry_er88577_init(struct starry_panel *starry)
> > +{
> > +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D starry->dsi =
};
> > +
> > +     /* T5:HWreset to init_code >=3D 120ms */
> > +     mipi_dsi_msleep(dsi_ctx, 120);
> > +
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0xab, 0xba);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0xba, 0xab);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb1, 0x10, 0x01, 0x47, 0x=
ff);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x0c, 0x14, 0x04, 0x=
50, 0x50, 0x14);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3, 0x56, 0x53, 0x00);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb4, 0x33, 0x30, 0x04);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0xb0, 0x00, 0x00, 0x=
10, 0x00, 0x10, 0x00);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x05, 0x12, 0x29, 0x=
49, 0x40);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x7c, 0x61, 0x4f, 0x=
42, 0x3e, 0x2d, 0x31,
> > +                                  0x1a, 0x33, 0x33, 0x33, 0x52, 0x40, =
0x47, 0x38, 0x34, 0x26,
> > +                                  0x0e, 0x06, 0x7c, 0x61, 0x4f, 0x42, =
0x3e, 0x2d, 0x31, 0x1a,
> > +                                  0x33, 0x33, 0x33, 0x52, 0x40, 0x47, =
0x38, 0x34, 0x26, 0x0e,
> > +                                  0x06);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0xcc, 0x76, 0x12, 0x=
34, 0x44, 0x44, 0x44,
> > +                                  0x44, 0x98, 0x04, 0x98, 0x04, 0x0f, =
0x00, 0x00, 0xc1);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x54, 0x94, 0x02, 0x=
85, 0x9f, 0x00, 0x6f,
> > +                                  0x00, 0x54, 0x00);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x17, 0x09, 0x08, 0x=
89, 0x08, 0x11, 0x22,
> > +                                  0x20, 0x44, 0xff, 0x18, 0x00);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x87, 0x47, 0x05, 0x=
05, 0x1c, 0x1c, 0x1d,
> > +                                  0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f, =
0x0f, 0x0f, 0x0d, 0x0d,
> > +                                  0x13, 0x13, 0x11, 0x11, 0x24);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x06, 0x06, 0x04, 0x=
04, 0x1c, 0x1c, 0x1d,
> > +                                  0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x1f, =
0x0e, 0x0e, 0x0c, 0x0c,
> > +                                  0x12, 0x12, 0x10, 0x10, 0x24);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x21, 0x00, 0x31, 0x=
42, 0x34, 0x16);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0xcb, 0x43);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcd, 0x0e, 0x4b, 0x4b, 0x=
20, 0x19, 0x6b, 0x06,
> > +                                  0xb3);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd2, 0xe3, 0x2b, 0x38, 0x=
08);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x00, 0x01, 0x00, 0x=
0e, 0x04, 0x44, 0x08,
> > +                                  0x10, 0x00, 0x00, 0x00);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x80, 0x09, 0xff, 0x=
ff, 0xff, 0xff, 0xff,
> > +                                  0xff);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x12, 0x03, 0x20, 0x=
00, 0xff);
> > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0x00);
>
> NAK.
>
> This sequence looks _exactly_ like the sequence in
> panel-boe-th101mb31ig002-28a.c.
>
Hi Dmity

We checked the panel-boe-th101mb31ig002-28a.c driver. The init_code is
indeed very similar, but the ICs seem to be different from the names,
and our panels and timings are also different. Do you want us to add
compatibility with Starry in this driver
panel-boe-th101mb31ig002-28a.c?

thanks

> > +
> > +     mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> > +
> > +     mipi_dsi_msleep(dsi_ctx, 120);
> > +
> > +     mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> > +     mipi_dsi_msleep(dsi_ctx, 20);
> > +
> > +     return dsi_ctx.accum_err;
>
> --
> With best wishes
> Dmitry


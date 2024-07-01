Return-Path: <linux-kernel+bounces-235910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFF191DB26
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1480B2861C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F43284A39;
	Mon,  1 Jul 2024 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4ctP++n"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9F05C614
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825081; cv=none; b=V9iTnL7ouV3PtS4G5QJ9soHIcJtNTeIDterXzz4DZFGiRk3UCg2qYLjVypBHHNvyKtP7eemrV6nizz9KhTWlhs8mSaLUvBLAJfH8muE++O2ZGGhA8fo4CyPiPN4bK4tB/woWvuSUwrO6egFBJI3bO2ctw1cRVUanJmawZD2ldQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825081; c=relaxed/simple;
	bh=ZZDuefkVybRKv7eLniy7SDH1/QwWLvpRP8veMGQDDDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGAvatGMAZKAEXnD7bz/Xa+esQx7CtzmFvwwXobU/p5MQbsdv2QU71HvwnRAswIqpBkMTkTbuHljGdHVXWexaJ2RqM9GdF9zwPHatRYqpnbNURTpTIIazViDduPrHjJq8lWXqSe84VqBHP0fjx64OCu/265Gqr8McZ90VbbPXgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h4ctP++n; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-64ad8d7b804so21167787b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719825078; x=1720429878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=279s14TPu3NAq9grtIdz6lApvIxsHo2tIujxIiLRJtk=;
        b=h4ctP++nx3tXoOCGqUEPThF/0zOq8M1EfpcGyU2rprSf9Sb88bP6I4E0vTTM28k5Mm
         nRceZQhH5A322QyTZAQjoq55dkISJLVMwbITP7n87t1dIe73z7CPhIG/v9/yb9g++kiN
         WjFdiZ8ctypXHyMAX8TFamer+TwNhfTAT4HjOQzWhRQEnqcELTMeHVHoP8Ibugerul+x
         vLGq3EKQgZ69+llF0z5YvGi8PQFVOmy8/b4kldiQygR7Ih1+PhLxhup+G/+nz6saxl+R
         j0yI+vug9eq2qt+4wpyOBcr1zaE3zc2IIqqHOpNX6VBJLYwSiqfXKhJA48NpsMJumYL2
         /IDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719825078; x=1720429878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=279s14TPu3NAq9grtIdz6lApvIxsHo2tIujxIiLRJtk=;
        b=vLwSM3dUwMHeGnlU0+7zhJAe0kpCGCEDfgISk7FYkPpos+sxPzxQRqV2E/4Wu4sCXd
         aJQxASK+nzXUUlPs0dzwEIYYNKA++543y0zYApAXhESMoFpgnbu/ZVc5znBkjIZ3qEjo
         Mgui/kqkmqO/Oz+G9MaqWlZnKn8j6kcyBCkZxxCYH+TrXLn2osCuP8SnoPjCCEZIKKTV
         dQgSAmt7KBf3ENkvhhOHrnFXuOYkA4UP6SkZ4OCqRgnOP+w95XKlxrYOahvgSGEHhRy2
         gaOHhpq2Dwp+xc/zZCSbZ/U10PV1ynSdMWF2aEJ5/0yQGsudkn0baRVm/c2mu410BjsK
         3Qzg==
X-Forwarded-Encrypted: i=1; AJvYcCUSXUdtF690pUlkKuAtiVF6rnBAxEh3NsEx7RdpzlbNX1YyWpTul9SKobLeUg/QesZrVrWRhDcqYJjEcKYxbq9BZ/KKjil0xdCfibXJ
X-Gm-Message-State: AOJu0YynJbyoABtnBem6CD+TV1wRXSVoBOl6+0UuhvU3ncgdPMnwmjYk
	+nb8i6ludiQ8OOHrBMXTWvPRuOcH0NDHAGSppvuLRuvvnaXRug560TV+mFuyL9bFb0gcLIVx2XC
	oyVflNeO19cwKjOs7BJ3xip12pMY9CzZIpzPUIQ==
X-Google-Smtp-Source: AGHT+IEnkyIn8A8Q7D/dqG51zS65A3m2K6WhBC9Ohf/ZxxAQQg/JJmdkDQU6wzrdArQnROoMt2dP3o28EdVqFmRyS04=
X-Received: by 2002:a05:690c:319:b0:618:90cc:bc4a with SMTP id
 00721157ae682-64af5a1ca8cmr46087537b3.26.1719825078412; Mon, 01 Jul 2024
 02:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620115245.31540-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240620115245.31540-3-lvzhaoxiong@huaqin.corp-partner.google.com>
 <bmmng663zqsc4xolkh6jdbu6yj637f3k6qbclxgi6fcmm4hv7z@i7ycd36flcha>
 <CA+6=WdT80hcAW4f=UDcO2d3e+ODcRjAQBOUug7M6vgmtAEY1SA@mail.gmail.com> <CA+6=WdRSkQnx5qDn5rCzebEyjx-6Pz5ze0kE0oqvQ3uf5digMQ@mail.gmail.com>
In-Reply-To: <CA+6=WdRSkQnx5qDn5rCzebEyjx-6Pz5ze0kE0oqvQ3uf5digMQ@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 1 Jul 2024 12:11:05 +0300
Message-ID: <CAA8EJposWO_ZXDp0rTSbAPfR0U+C35VjuigR+tZVd+80md+k=w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] drm/panel: starry-er88577: add new panel driver
To: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Jul 2024 at 09:26, zhaoxiong lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> On Fri, Jun 21, 2024 at 9:43=E2=80=AFAM zhaoxiong lv
> <lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
> >
> > On Fri, Jun 21, 2024 at 3:56=E2=80=AFAM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On Thu, Jun 20, 2024 at 07:52:45PM GMT, Zhaoxiong Lv wrote:
> > > > The bias IC of this starry-er88577 panel is placed
> > > > on the panel side, so when the panel is powered on,
> > > > there is no need to control AVDD and AVEE in the driver,
> > > > only 3.3v and reset are needed.
> > > >
> > > > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google=
.com>
> > > > ---
> > > > Chage since V3:
> > > > -  1. Adjust the ".clock" assignment format.
> > > >
> > > > v3: https://lore.kernel.org/all/20240614145609.25432-3-lvzhaoxiong@=
huaqin.corp-partner.google.com/
> > > >
> > > > Chage since V3:
> > > > -  Separate Starry-er88577 from the panel-kingdisplay-kd101ne3 driv=
er.
> > > > -  Use mipi_dsi_dcs_set_display_on_multi().
> > > > -  Use mipi_dsi_dcs_exit_sleep_mode_multi() and mipi_dsi_msleep().
> > > >
> > > > v2: https://lore.kernel.org/all/20240601084528.22502-5-lvzhaoxiong@=
huaqin.corp-partner.google.com/
> > > >
> > > > Chage since V2:
> > > > -  Add compatible for Starry er88577 in panel-kingdisplay-kd101ne3 =
drivers.
> > > >
> > > > ---
> > > >  drivers/gpu/drm/panel/Kconfig                |   9 +
> > > >  drivers/gpu/drm/panel/Makefile               |   1 +
> > > >  drivers/gpu/drm/panel/panel-starry-er88577.c | 343 +++++++++++++++=
++++
> > > >  3 files changed, 353 insertions(+)
> > > >  create mode 100644 drivers/gpu/drm/panel/panel-starry-er88577.c
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/=
Kconfig
> > > > index e54f6f5604ed..a52aa2552ab8 100644
> > > > --- a/drivers/gpu/drm/panel/Kconfig
> > > > +++ b/drivers/gpu/drm/panel/Kconfig
> > > > @@ -781,6 +781,15 @@ config DRM_PANEL_SITRONIX_ST7789V
> > > >         Say Y here if you want to enable support for the Sitronix
> > > >         ST7789V controller for 240x320 LCD panels
> > > >
> > > > +config DRM_PANEL_STARRY_ER88577
> > > > +     tristate "Starry er88577 panel"
> > > > +     depends on OF
> > > > +     depends on DRM_MIPI_DSI
> > > > +     depends on BACKLIGHT_CLASS_DEVICE
> > > > +     help
> > > > +       Say Y if you want to enable support for panels based on the
> > > > +       Starry er88577 controller.
> > > > +
> > > >  config DRM_PANEL_SONY_ACX565AKM
> > > >       tristate "Sony ACX565AKM panel"
> > > >       depends on GPIOLIB && OF && SPI
> > > > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel=
/Makefile
> > > > index f0203f6e02f4..ecd843a6dc6e 100644
> > > > --- a/drivers/gpu/drm/panel/Makefile
> > > > +++ b/drivers/gpu/drm/panel/Makefile
> > > > @@ -81,6 +81,7 @@ obj-$(CONFIG_DRM_PANEL_SHARP_LS060T1SX01) +=3D pa=
nel-sharp-ls060t1sx01.o
> > > >  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7701) +=3D panel-sitronix-st7701=
.o
> > > >  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7703) +=3D panel-sitronix-st7703=
.o
> > > >  obj-$(CONFIG_DRM_PANEL_SITRONIX_ST7789V) +=3D panel-sitronix-st778=
9v.o
> > > > +obj-$(CONFIG_DRM_PANEL_STARRY_ER88577) +=3D panel-starry-er88577.o
> > > >  obj-$(CONFIG_DRM_PANEL_SYNAPTICS_R63353) +=3D panel-synaptics-r633=
53.o
> > > >  obj-$(CONFIG_DRM_PANEL_SONY_ACX565AKM) +=3D panel-sony-acx565akm.o
> > > >  obj-$(CONFIG_DRM_PANEL_SONY_TD4353_JDI) +=3D panel-sony-td4353-jdi=
.o
> > > > diff --git a/drivers/gpu/drm/panel/panel-starry-er88577.c b/drivers=
/gpu/drm/panel/panel-starry-er88577.c
> > > > new file mode 100644
> > > > index 000000000000..e6088262ee69
> > > > --- /dev/null
> > > > +++ b/drivers/gpu/drm/panel/panel-starry-er88577.c
> > > > @@ -0,0 +1,343 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/* Panels based on the ER88577 display controller.
> > > > + * Author: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.co=
m>
> > > > + */
> > > > +
> > > > +#include <linux/delay.h>
> > > > +#include <linux/gpio/consumer.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/of.h>
> > > > +#include <linux/regulator/consumer.h>
> > > > +
> > > > +#include <drm/drm_connector.h>
> > > > +#include <drm/drm_crtc.h>
> > > > +#include <drm/drm_mipi_dsi.h>
> > > > +#include <drm/drm_panel.h>
> > > > +
> > > > +#include <video/mipi_display.h>
> > > > +#include <drm/drm_probe_helper.h>
> > > > +
> > > > +struct starry_panel;
> > > > +
> > > > +struct panel_desc {
> > > > +     const struct drm_display_mode *modes;
> > > > +     unsigned int bpc;
> > > > +     unsigned long mode_flags;
> > > > +     enum mipi_dsi_pixel_format format;
> > > > +     const struct panel_init_cmd *init_cmds;
> > > > +     int (*init)(struct starry_panel *starry);
> > > > +     unsigned int lanes;
> > > > +     bool discharge_on_disable;
> > > > +     bool lp11_before_reset;
> > > > +     unsigned int power_off_delay_ms;
> > > > +};
> > > > +
> > > > +struct starry_panel {
> > > > +     struct drm_panel base;
> > > > +     struct mipi_dsi_device *dsi;
> > > > +
> > > > +     const struct panel_desc *desc;
> > > > +
> > > > +     enum drm_panel_orientation orientation;
> > > > +     struct regulator *vccio;
> > > > +     struct gpio_desc *reset;
> > > > +};
> > > > +
> > > > +static int starry_er88577_init(struct starry_panel *starry)
> > > > +{
> > > > +     struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D starry->=
dsi };
> > > > +
> > > > +     /* T5:HWreset to init_code >=3D 120ms */
> > > > +     mipi_dsi_msleep(dsi_ctx, 120);
> > > > +
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe0, 0xab, 0xba);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe1, 0xba, 0xab);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb1, 0x10, 0x01, 0x47=
, 0xff);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2, 0x0c, 0x14, 0x04=
, 0x50, 0x50, 0x14);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb3, 0x56, 0x53, 0x00=
);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb4, 0x33, 0x30, 0x04=
);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0xb0, 0x00, 0x00=
, 0x10, 0x00, 0x10, 0x00);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x05, 0x12, 0x29=
, 0x49, 0x40);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb9, 0x7c, 0x61, 0x4f=
, 0x42, 0x3e, 0x2d, 0x31,
> > > > +                                  0x1a, 0x33, 0x33, 0x33, 0x52, 0x=
40, 0x47, 0x38, 0x34, 0x26,
> > > > +                                  0x0e, 0x06, 0x7c, 0x61, 0x4f, 0x=
42, 0x3e, 0x2d, 0x31, 0x1a,
> > > > +                                  0x33, 0x33, 0x33, 0x52, 0x40, 0x=
47, 0x38, 0x34, 0x26, 0x0e,
> > > > +                                  0x06);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc0, 0xcc, 0x76, 0x12=
, 0x34, 0x44, 0x44, 0x44,
> > > > +                                  0x44, 0x98, 0x04, 0x98, 0x04, 0x=
0f, 0x00, 0x00, 0xc1);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc1, 0x54, 0x94, 0x02=
, 0x85, 0x9f, 0x00, 0x6f,
> > > > +                                  0x00, 0x54, 0x00);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc2, 0x17, 0x09, 0x08=
, 0x89, 0x08, 0x11, 0x22,
> > > > +                                  0x20, 0x44, 0xff, 0x18, 0x00);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc3, 0x87, 0x47, 0x05=
, 0x05, 0x1c, 0x1c, 0x1d,
> > > > +                                  0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x=
1f, 0x0f, 0x0f, 0x0d, 0x0d,
> > > > +                                  0x13, 0x13, 0x11, 0x11, 0x24);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc4, 0x06, 0x06, 0x04=
, 0x04, 0x1c, 0x1c, 0x1d,
> > > > +                                  0x1d, 0x02, 0x1e, 0x1e, 0x1f, 0x=
1f, 0x0e, 0x0e, 0x0c, 0x0c,
> > > > +                                  0x12, 0x12, 0x10, 0x10, 0x24);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xc8, 0x21, 0x00, 0x31=
, 0x42, 0x34, 0x16);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca, 0xcb, 0x43);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcd, 0x0e, 0x4b, 0x4b=
, 0x20, 0x19, 0x6b, 0x06,
> > > > +                                  0xb3);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd2, 0xe3, 0x2b, 0x38=
, 0x08);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x00, 0x01, 0x00=
, 0x0e, 0x04, 0x44, 0x08,
> > > > +                                  0x10, 0x00, 0x00, 0x00);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xe6, 0x80, 0x09, 0xff=
, 0xff, 0xff, 0xff, 0xff,
> > > > +                                  0xff);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x12, 0x03, 0x20=
, 0x00, 0xff);
> > > > +     mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf3, 0x00);
> > >
> > > NAK.
> > >
> > > This sequence looks _exactly_ like the sequence in
> > > panel-boe-th101mb31ig002-28a.c.
> > >
> > Hi Dmity
> >
> > We checked the panel-boe-th101mb31ig002-28a.c driver. The init_code is
> > indeed very similar, but the ICs seem to be different from the names,
> > and our panels and timings are also different. Do you want us to add
> > compatibility with Starry in this driver
> > panel-boe-th101mb31ig002-28a.c?
> >
> > thanks
> >
> hi dmitry.baryshkov
>
> We tried to make modifications based on the
> panel-boe-th101mb31ig002-28a.c driver, but we encountered some
> problems.
> For example, the panel-boe-th101mb31ig002-28a.c driver will get
> "enable/reset" gpio in the probe() function, but our hardware design
> only has "enable". This will cause an error to be returned in the
> devm_gpiod_get function when we use this driver and the probe()
> function will be interrupted.
> How should we modify this? Can we re-judge the return value of the
> devm_gpiod_get function?

If it is optional, then it should be devm_gpiod_get_optional().

>
> thanks
>
> > > > +
> > > > +     mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> > > > +
> > > > +     mipi_dsi_msleep(dsi_ctx, 120);
> > > > +
> > > > +     mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> > > > +     mipi_dsi_msleep(dsi_ctx, 20);
> > > > +
> > > > +     return dsi_ctx.accum_err;
> > >
> > > --
> > > With best wishes
> > > Dmitry



--=20
With best wishes
Dmitry


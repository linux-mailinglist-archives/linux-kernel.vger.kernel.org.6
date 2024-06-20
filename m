Return-Path: <linux-kernel+bounces-222340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0529090FFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF6B283B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520EE19FA7E;
	Thu, 20 Jun 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OLHSYPwt"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ACE19DF46
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874507; cv=none; b=KKsM7Cu+kdTTP97m5OyiAtlEVwJ+Audzo+NKRbBKbh/S5mo9+278hlFsrMbkRYM3XvbUJfPH7uIAyRx4UcQ/iOMgMm1PLxon+46KuSWU0SOgRHPeTy4jl66HX7i4kvWad7f7+DqMvvAYESeg230Z44VG82boYfHxeaDvTu+7ROc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874507; c=relaxed/simple;
	bh=Uf/DRFaK4xkStOOOomLsrlUHxyWX9dj5leuLl5H+864=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu6sCGavfbDJGWKGbRNPRbTuaIv4XAU8nhnlzEpDsPsI3JL+I8XMOPwggJj3yDkUQh3F82j8EBlutvh879wzgCrrvDFOfES2cIN0xTf6rdzPv2xbDPLIL6iLc0xvHZJa3TCXufZKSbtAdQjf/7Qn+6aswsyHxuQTJuyfCNcH3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OLHSYPwt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00ba6so629290a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718874503; x=1719479303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HqSY3GOs/15VIJ9Rt+TiaY5fHiC8UUyqPG+GopX0FQ=;
        b=OLHSYPwt1WiH1wux5wyzX+q9HjzS2/eguV0pa/semL6DpOwu2nWAP+zuVLC49BYBbi
         9XRbxDR6WekZi4qmqYd8k+wmdUZkcnbJBs4RxzEfh+PbcjN/bN1o53eMRH0IJG1WZGIH
         OfMrFeCkWHg0hAlkhWY8LQ+BOimQlqW3hZUjgYO38vxD5qVgD5UJeg45dJayEtxZ8SDR
         AUTf8OhS25Y9M5No2+j44cH8eCjC6CtwS5oicL1wAuWV3UZpCCaR/Tae5FQFumo3kqGA
         EwnHNBGzh7YW79SDYeSuCBMZfdHqqn+qVujHBiTLAivxkXSascD2/b6HMNmC5KITEgFW
         ghyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874503; x=1719479303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HqSY3GOs/15VIJ9Rt+TiaY5fHiC8UUyqPG+GopX0FQ=;
        b=pJ6x7vOvFfWRqiBqhQIgKczaHSvO+pdc/6y0P8+CK4Jn7iPFcykqAH4m/VRYAoM9RA
         1SL7SyDsIVdqjhGjBJlHCWrFN2GpH45o3dZRcW4bjpVMPpQVvDx3ieP9N6rRkTiqY7Df
         aBsO7ZSXRXL9fi7K1yqwmT7B5ViZDP689nR1FGoqcSQab7GToX2MHyXRoaM6zezNo2BG
         izF15QZAGlZH94FaN/TTwUV6KxLDGpRf/ju5v5he8Z+4Kp0aXCK9M4NKv/SW4873fJ1V
         +Ujr+MNooUQRUmk8A4ICVYuKAMkX07cJeAVIOB39/GX7kaDGXSGiP4yxQZLMuNTeG8Xb
         zVeg==
X-Forwarded-Encrypted: i=1; AJvYcCU/0B4kQ2K2RNbaumG2kzqIAgCBSVvRj8vQcqTmxrmf+5T4bhs2/4S7OifscLr6h3DHpBxCBn7rt+kDEXcLKMRhiGhii09E4a1+F8+4
X-Gm-Message-State: AOJu0YwWw4UNS7V2TtKj/JSg8Rn92JM1axXBit6Sedkku2Ou51o4LB4x
	yx6cN1MlQjJBHkunFPrHIPlxw/9+tePfp06vBjlQhSKOs/7C+1qB8rFsr/KFS9iSGdG3Zcjv1vg
	B5NrQvsiqmpqK3iy2bZ0NLyP9Ot6OhhGWHW4oMw==
X-Google-Smtp-Source: AGHT+IHO5sP2gbpxBB+AMGd4wNamE9Q721oKfWv/dUroSShvJU+KFMT4kGHIsnxr8NwAqlWGAJQN7rLag50g2h0cmh4=
X-Received: by 2002:a50:ee92:0:b0:57c:765b:83a3 with SMTP id
 4fb4d7f45d1cf-57d0bff1a13mr2919665a12.25.1718874502424; Thu, 20 Jun 2024
 02:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614145609.25432-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240614145609.25432-3-lvzhaoxiong@huaqin.corp-partner.google.com> <xiv3rvzpx7l2esosggybp6pheoa4zg3ew6vnhjxewnmvkdy73o@jflkmq77lxxn>
In-Reply-To: <xiv3rvzpx7l2esosggybp6pheoa4zg3ew6vnhjxewnmvkdy73o@jflkmq77lxxn>
From: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Date: Thu, 20 Jun 2024 17:08:11 +0800
Message-ID: <CA+6=WdQpLMQBti_1WBQ9h09fRSf74o0m4YrJqDOqzDAYJ0EyOA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: starry-er88577: add new panel driver
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi Dmitry

We checked the panel-boe-th101mb31ig002-28a.c driver. Although the
init_code is similar, the IC does not seem to be the same from the
name, and our panel and timing are also different.

On Sat, Jun 15, 2024 at 1:25=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Fri, Jun 14, 2024 at 10:56:09PM GMT, Zhaoxiong Lv wrote:
> > The bias IC of this starry-er88577 panel is placed
> > on the panel side, so when the panel is powered on,
> > there is no need to control AVDD and AVEE in the driver,
> > only 3.3v and reset are needed.
> >
> > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com=
>
> >
> > ---
> >
> > Chage since V3:
> >
> > -  Separate Starry-er88577 from the panel-kingdisplay-kd101ne3 driver.
> > -  Use mipi_dsi_dcs_set_display_on_multi().
> > -  Use mipi_dsi_dcs_exit_sleep_mode_multi() and mipi_dsi_msleep().
> >
> > v2: https://lore.kernel.org/all/20240601084528.22502-5-lvzhaoxiong@huaq=
in.corp-partner.google.com/
> >
> > Chage since V2:
> >
> > -  Add compatible for Starry er88577 in panel-kingdisplay-kd101ne3 driv=
ers.
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
> > index 000000000000..a8250a464883
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panel/panel-starry-er88577.c
> > @@ -0,0 +1,343 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Panels based on the JD9365DA display controller.
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
> This looks pretty close to panel-boe-th101mb31ig002-28a.c
>
> > +
> > +     mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> > +
>
>
> --
> With best wishes
> Dmitry


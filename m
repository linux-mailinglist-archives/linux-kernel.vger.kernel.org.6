Return-Path: <linux-kernel+bounces-202024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB978FC6BC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753831F21CE2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A171946DD;
	Wed,  5 Jun 2024 08:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kq6u3j4g"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541849637
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717576762; cv=none; b=dHVShRGUErDW78bIBVFv45g+5CRMWBDy/ZvnBEmssNDBd2/vaVK3n5NmvNwsAxdy61IkzDSbrfhehFsfI5XpehRDkSQd/Ew3OmLT5BEX28qbIOEIIBjrxlSSzxuT0vG+3PRNY44VAR5+bqtj8D/EpvmXFERj73IOudcl8ufyAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717576762; c=relaxed/simple;
	bh=Uyde1GwcRmYQzkcMME858pT8IXlt7YjOaqdfevgl2hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0c/aOwmUUaR8q9AomV45EGuGggTeQOf7nORAFGBMAKNI3KDK6aj9Hx9gwOELEy7c/Hg+zND9U9Re18a2kWxz0HlSgaW5DIPxK+oLwoPejCGZfGaDdnSifMplAxcwpBAmc3/TB2oetNTFw9Eg6dvxcY1/KarN4/6Yhf65aVmF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kq6u3j4g; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b992fd796so2326794e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717576758; x=1718181558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTQe3wg02xrKHSMQnPEBjVMZ37QaY2jveS1Tz9H3zuE=;
        b=Kq6u3j4gG7hkWexFavJgfz64yhv41MZdEsyYMHYCcUJRFQPHBBCJLyrTbVCkHFhG4+
         rjqHsLg0/MIG48/WmHZ0STSHwJ2EIrfMh0EGpIKaLo0E9KHJP6x9WGR/fTnA9FN7CA9j
         pMxazRLab4JplePA0SUDqCaXvePQgjyz3WiaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717576758; x=1718181558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTQe3wg02xrKHSMQnPEBjVMZ37QaY2jveS1Tz9H3zuE=;
        b=L7WTizB+6HNqznJ91LK7ZC5FP/SjuRfdXqN7r0YbvYuWAkxDnDrDugP8J7K4AvOBsA
         PuMatgK4/PYvDVpAhnjKOVFr0XJffCahZhs6xIVU0W4z8vTDyDQkxbS9H48dikyV0MBR
         EmGgidPAtknha+DyEqFB+Tfntmg4NbTQ0iql0RMSAZzK9z+A0NRcdp8bKI3ihP4gSeDx
         XaAJsZMvzGE9KkbnQ/FjGH02GZ6fXQ6ZmEJp6X4U8195bYSwwDKSOvtp/8H7XFNHkjGW
         7ZDunsVJqx0CpCrj+TRDGq1gp0VPQGJeGUPpfEktcyOfRcH0ukS1g8pmx9xGSLKgIzzy
         he1w==
X-Forwarded-Encrypted: i=1; AJvYcCVj9KFbqCQhCV6ecb7lxtQ/N7TjWCaUgLr6Ch7yGkuBSikwZXBwwz/H4yUqI/hr9xBk0i0QaGpcWcIYhLIstk/meWq+2FH1R0qUSuuP
X-Gm-Message-State: AOJu0Yz+0/8RvQ4r8t94HgBbtc4jp/uKRyjSI03F0fNQ/p/krcmsGnit
	FCqJgEFbPHElAaH5FfkGfhpIZ4HGA+AIjnkLQ+EyWRhbNu2CCyZDmVx6IkDSz+18G0CNOLBG9WZ
	+4XgktSw1XRRaVaZhIYz7WQ7Anq5n9oL0mYaS
X-Google-Smtp-Source: AGHT+IFIUpSy7Bc3Z2Gc9M2K1yIEcXoIueZPi0s3tAB2qXRcBbr5JF7ukDJ6mVSXe/Xo3k9oRnzzMucI7T9xriJ7yvc=
X-Received: by 2002:ac2:4c1a:0:b0:52b:88ec:b425 with SMTP id
 2adb3069b0e04-52bab4dd705mr1044549e87.27.1717576758308; Wed, 05 Jun 2024
 01:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530083513.4135052-1-wenst@chromium.org> <20240530083513.4135052-3-wenst@chromium.org>
 <5a5842d7-adad-410b-bac2-9e5cb03ae18c@collabora.com> <CAGXv+5E5zFWVi+QmZj+mMb5jRfv138kz1FQyXiuzpe5Zz2KbZQ@mail.gmail.com>
In-Reply-To: <CAGXv+5E5zFWVi+QmZj+mMb5jRfv138kz1FQyXiuzpe5Zz2KbZQ@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 5 Jun 2024 16:39:07 +0800
Message-ID: <CAGXv+5GHJXh8xnpK6+crfYaUNXWV+W7s8sUopK+=9KhfcuCHeA@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: mediatek: Add mt8173-mfgtop driver
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 6:16=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Thu, May 30, 2024 at 5:59=E2=80=AFPM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 30/05/24 10:35, Chen-Yu Tsai ha scritto:
> > > The MFG (GPU) block on the MT8173 has a small glue layer, named MFG_T=
OP
> > > in the datasheet, that contains clock gates, some power sequence sign=
al
> > > delays, and other unknown registers that get toggled when the GPU is
> > > powered on.
> > >
> > > The clock gates are exposed as clocks provided by a clock controller,
> > > while the power sequencing bits are exposed as one singular power dom=
ain.
> > >
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > > ---
> > >   drivers/clk/mediatek/Kconfig             |   9 +
> > >   drivers/clk/mediatek/Makefile            |   1 +
> > >   drivers/clk/mediatek/clk-mt8173-mfgtop.c | 240 ++++++++++++++++++++=
+++
> > >   3 files changed, 250 insertions(+)
> > >   create mode 100644 drivers/clk/mediatek/clk-mt8173-mfgtop.c
> > >
> > > diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kcon=
fig
> > > index 70a005e7e1b1..9e279c739f1c 100644
> > > --- a/drivers/clk/mediatek/Kconfig
> > > +++ b/drivers/clk/mediatek/Kconfig
> > > @@ -500,6 +500,15 @@ config COMMON_CLK_MT8173_IMGSYS
> > >       help
> > >         This driver supports MediaTek MT8173 imgsys clocks.
> > >
> > > +config COMMON_CLK_MT8173_MFGTOP
> > > +     tristate "Clock and power driver for MediaTek MT8173 mfgtop"
> > > +     depends on COMMON_CLK_MT8173
> > > +     default COMMON_CLK_MT8173
> > > +     select PM_GENERIC_DOMAINS
> > > +     select PM_GENERIC_DOMAINS_OF
> > > +     help
> > > +       This driver supports MediaTek MT8173 mfgtop clocks and power =
domain.
> > > +
> > >   config COMMON_CLK_MT8173_MMSYS
> > >          tristate "Clock driver for MediaTek MT8173 mmsys"
> > >          depends on COMMON_CLK_MT8173
> > > diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Mak=
efile
> > > index eeccfa039896..fdd3a76e12a1 100644
> > > --- a/drivers/clk/mediatek/Makefile
> > > +++ b/drivers/clk/mediatek/Makefile
> > > @@ -77,6 +77,7 @@ obj-$(CONFIG_COMMON_CLK_MT8167_VDECSYS) +=3D clk-mt=
8167-vdec.o
> > >   obj-$(CONFIG_COMMON_CLK_MT8173) +=3D clk-mt8173-apmixedsys.o clk-mt=
8173-infracfg.o \
> > >                                  clk-mt8173-pericfg.o clk-mt8173-topc=
kgen.o
> > >   obj-$(CONFIG_COMMON_CLK_MT8173_IMGSYS) +=3D clk-mt8173-img.o
> > > +obj-$(CONFIG_COMMON_CLK_MT8173_MFGTOP) +=3D clk-mt8173-mfgtop.o
> > >   obj-$(CONFIG_COMMON_CLK_MT8173_MMSYS) +=3D clk-mt8173-mm.o
> > >   obj-$(CONFIG_COMMON_CLK_MT8173_VDECSYS) +=3D clk-mt8173-vdecsys.o
> > >   obj-$(CONFIG_COMMON_CLK_MT8173_VENCSYS) +=3D clk-mt8173-vencsys.o
> > > diff --git a/drivers/clk/mediatek/clk-mt8173-mfgtop.c b/drivers/clk/m=
ediatek/clk-mt8173-mfgtop.c
> > > new file mode 100644
> > > index 000000000000..85fa7a7453ed
> > > --- /dev/null
> > > +++ b/drivers/clk/mediatek/clk-mt8173-mfgtop.c
> > > @@ -0,0 +1,240 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (c) 2024 Google LLC
> > > + * Author: Chen-Yu Tsai <wenst@chromium.org>
> > > + *
> > > + * Based on driver in downstream ChromeOS v5.15 kernel.
> > > + *
> > > + * Copyright (c) 2014 MediaTek Inc.
> > > + * Author: Chiawen Lee <chiawen.lee@mediatek.com>
> > > + */
> > > +
> > > +#include <dt-bindings/clock/mt8173-clk.h>
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pm_domain.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/regmap.h>
> > > +
> > > +#include "clk-gate.h"
> > > +#include "clk-mtk.h"
> > > +
> > > +static const struct mtk_gate_regs mfg_cg_regs =3D {
> > > +     .sta_ofs =3D 0x0000,
> > > +     .clr_ofs =3D 0x0008,
> > > +     .set_ofs =3D 0x0004,
> > > +};
> > > +
> > > +#define GATE_MFG(_id, _name, _parent, _shift, _flags)        \
> > > +             GATE_MTK_FLAGS(_id, _name, _parent, &mfg_cg_regs, _shif=
t, &mtk_clk_gate_ops_setclr, _flags)
> >
> > Extra tabulation: please fix
>
> One tab instead of two? OK.
>
> > > +
> > > +/* TODO: The block actually has dividers for the core and mem clocks=
. */
> > > +static const struct mtk_gate mfg_clks[] =3D {
> > > +     GATE_MFG(CLK_MFG_AXI, "mfg_axi", "axi_mfg_in_sel", 0, CLK_SET_R=
ATE_PARENT),
> > > +     GATE_MFG(CLK_MFG_MEM, "mfg_mem", "mem_mfg_in_sel", 1, CLK_SET_R=
ATE_PARENT),
> > > +     GATE_MFG(CLK_MFG_G3D, "mfg_g3d", "mfg_sel", 2, CLK_SET_RATE_PAR=
ENT),
> > > +     GATE_MFG(CLK_MFG_26M, "mfg_26m", "clk26m", 3, 0),
> > > +};
> > > +
> > > +static const struct mtk_clk_desc mfg_desc =3D {
> > > +     .clks =3D mfg_clks,
> > > +     .num_clks =3D ARRAY_SIZE(mfg_clks),
> > > +};
> > > +
> > > +struct mt8173_mfgtop_data {
> > > +     struct clk_hw_onecell_data *clk_data;
> > > +     struct regmap *regmap;
> > > +     struct generic_pm_domain genpd;
> > > +     struct of_phandle_args parent_pd, child_pd;
> > > +     struct clk *clk_26m;
> > > +};
> > > +
> > > +static const struct of_device_id of_match_clk_mt8173_mfgtop[] =3D {
> > > +     { .compatible =3D "mediatek,mt8173-mfgtop", .data =3D &mfg_desc=
 },
> > > +     { /* sentinel */ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, of_match_clk_mt8173_mfgtop);
> >
> > Please move of_match_clk_mt8173_mfgtop before clk_mt8173_mfgtop_drv for=
 consistency
> > with all the other clock drivers.
>
> Ack.
>
> > > +
> > > +/* Delay count in clock cycles */
> > > +#define MFG_ACTIVE_POWER_CON0        0x24
> > > + #define RST_B_DELAY_CNT     GENMASK(7, 0)   /* pwr_rst_b de-assert =
delay during power-up */
> > > + #define CLK_EN_DELAY_CNT    GENMASK(15, 8)  /* CLK_DIS deassert del=
ay during power-up */
> > > + #define CLK_DIS_DELAY_CNT   GENMASK(23, 16) /* CLK_DIS assert delay=
 during power-down */
> >
> > The reason why I had EVT_FORCE_ABORT and ACTIVE_PWRCTL_EN in my driver =
is to
> > document that we're keeping the event force abort disabled and, more im=
portantly,
> > we are keeping the "active power control" feature disabled.
> >
> > Please, add those two - or at least the ACTIVE_PWRCTL_EN - to keep that=
 documented,
> > or this information will be lost for sure.
> > If in the future the ACTIVE_PWRCTL feature will become usable, it's goi=
ng to be
> > just a 30 seconds change, as the info is already there.
>
> OK.
>
> > > +
> > > +#define MFG_ACTIVE_POWER_CON1        0x28
> > > + #define PWR_ON_S_DELAY_CNT  GENMASK(7, 0)   /* pwr_on_s assert dela=
y during power-up */
> > > + #define ISO_DELAY_CNT               GENMASK(15, 8)  /* ISO assert d=
elay during power-down */
> > > + #define ISOOFF_DELAY_CNT    GENMASK(23, 16) /* ISO de-assert delay =
during power-up */
> > > + #define RST__DELAY_CNT              GENMASK(31, 24) /* pwr_rsb_b as=
sert delay during power-down */
> > > +
> > > +static int clk_mt8173_mfgtop_power_on(struct generic_pm_domain *doma=
in)
> > > +{
> > > +     struct mt8173_mfgtop_data *data =3D container_of(domain, struct=
 mt8173_mfgtop_data, genpd);
> > > +
> > > +     /* drives internal power management */
> > > +     clk_prepare_enable(data->clk_26m);
> > > +
> > > +     /* Power on/off delays for various signals */
> > > +     regmap_write(data->regmap, MFG_ACTIVE_POWER_CON0,
> > > +                  FIELD_PREP(RST_B_DELAY_CNT, 77) |
> > > +                  FIELD_PREP(CLK_EN_DELAY_CNT, 61) |
> > > +                  FIELD_PREP(CLK_DIS_DELAY_CNT, 60));
> >
> > I get that this is kinda odd to read, but still...
> >
> > FIELD_PREP(CLK_DIS_DELAY_CNT, 60) |
> > FIELD_PREP(ACTIVE_PWRCTL_EN, 0));
> >
> > ...please :-)
>
> Sure.
>
> > > +     regmap_write(data->regmap, MFG_ACTIVE_POWER_CON1,
> > > +                  FIELD_PREP(PWR_ON_S_DELAY_CNT, 11) |
> > > +                  FIELD_PREP(ISO_DELAY_CNT, 68) |
> > > +                  FIELD_PREP(ISOOFF_DELAY_CNT, 69) |
> > > +                  FIELD_PREP(RST__DELAY_CNT, 77));
> > > +
> > > +     /* Magic numbers related to core switch sequence and delays */
> > > +     regmap_write(data->regmap, 0xe0, 0x7a710184);
> > > +     regmap_write(data->regmap, 0xe4, 0x835f6856);
> > > +     regmap_write(data->regmap, 0xe8, 0x002b0234);
> > > +     regmap_write(data->regmap, 0xec, 0x80000000);
> > > +     regmap_write(data->regmap, 0xa0, 0x08000000);
> >
> > Is there any way to retrieve information about what those registers are=
?
>
> I asked. They said the project was too long ago, and they could only
> figure out that it had something to do with core switch sequencing and
> delays between each core, which is what I put in the comment there.
>
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int clk_mt8173_mfgtop_power_off(struct generic_pm_domain *dom=
ain)
> > > +{
> > > +     struct mt8173_mfgtop_data *data =3D container_of(domain, struct=
 mt8173_mfgtop_data, genpd);
> > > +
> > > +     /* Magic numbers related to core switch sequence and delays */
> > > +     regmap_write(data->regmap, 0xec, 0);
> > > +
> > > +     /* drives internal power management */
> > > +     clk_disable_unprepare(data->clk_26m);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int clk_mt8173_mfgtop_probe(struct platform_device *pdev)
> > > +{
> > > +     struct device *dev =3D &pdev->dev;
> > > +     struct device_node *node =3D dev->of_node;
> > > +     struct mt8173_mfgtop_data *data;
> > > +     int ret;
> > > +
> > > +     data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> > > +     if (!data)
> > > +             return -ENOMEM;
> > > +
> > > +     platform_set_drvdata(pdev, data);
> > > +
> > > +     data->clk_data =3D mtk_devm_alloc_clk_data(dev, ARRAY_SIZE(mfg_=
clks));
> > > +     if (!data->clk_data)
> > > +             return -ENOMEM;
> > > +
> > > +     /* MTK clock gates also uses regmap */
> > > +     data->regmap =3D device_node_to_regmap(node);
> > > +     if (IS_ERR(data->regmap))
> > > +             return dev_err_probe(dev, PTR_ERR(data->regmap), "Faile=
d to get regmap\n");
> > > +
> > > +     data->child_pd.np =3D node;
> > > +     data->child_pd.args_count =3D 0;
> > > +     ret =3D of_parse_phandle_with_args(node, "power-domains", "#pow=
er-domain-cells", 0,
> > > +                                      &data->parent_pd);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret, "Failed to parse power d=
omain\n");
> > > +
> > > +     devm_pm_runtime_enable(dev);
> > > +     /*
> > > +      * Do a pm_runtime_resume_and_get() to workaround a possible
> > > +      * deadlock between clk_register() and the genpd framework.
> > > +      */
> > > +     ret =3D pm_runtime_resume_and_get(dev);
> > > +     if (ret) {
> > > +             dev_err_probe(dev, ret, "Failed to runtime resume devic=
e\n");
> > > +             goto put_of_node;
> > > +     }
> > > +
> > > +     ret =3D mtk_clk_register_gates(dev, node, mfg_clks, ARRAY_SIZE(=
mfg_clks),
> > > +                                  data->clk_data);
> > > +     if (ret) {
> > > +             dev_err_probe(dev, ret, "Failed to register clock gates=
\n");
> > > +             goto put_pm_runtime;
> > > +     }
> > > +
> > > +     data->clk_26m =3D clk_hw_get_clk(data->clk_data->hws[CLK_MFG_26=
M], "26m");
> > > +     if (IS_ERR(data->clk_26m)) {
> > > +             dev_err_probe(dev, PTR_ERR(data->clk_26m), "Failed to g=
et 26 MHz clock\n");
> > > +             goto unregister_clks;
> > > +     }
> > > +
> > > +     ret =3D of_clk_add_hw_provider(node, of_clk_hw_onecell_get, dat=
a->clk_data);
> > > +     if (ret) {
> > > +             dev_err_probe(dev, ret, "Failed to add clk OF provider\=
n");
> > > +             goto put_26m_clk;
> > > +     }
> > > +
> > > +     data->genpd.name =3D "mfg_apm";
> >
> > "mfg-apm" or "mfg-pwr" please!
>
> Ack.

On second thought, mfg-top seems like a better name, since it matches
the datasheet.

ChenYu

> > Everything else looks good.
> >
> > Thanks for taking care of that, I started this work way too much time a=
go and
> > realistically I wouldn't have been able to finish it due to time constr=
aints.
> >
> > It's great to see that *finally* we can get some GPU upstream on this o=
ld SoC.
> > As its CPUs are really slow, LLVMPipe is quite unusable from a UX persp=
ective
> > hence its only big issue was the lack of 3D HW acceleration.
>
> I think there's still more work on the GPU driver side. I was digging
> through the mailing list to find ways to get it running, and evidently
> it doesn't fully support zink yet.
>
> > This makes machines embedding this SoC usable, and that's simply awesom=
e.
>
> I'll give the patches a week to simmer while I go work on some
> other stuff.
>
> ChenYu


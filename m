Return-Path: <linux-kernel+bounces-209349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C69D903319
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCBB1F27483
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 06:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCCC171E5C;
	Tue, 11 Jun 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQrM8oq8"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48FD171095;
	Tue, 11 Jun 2024 06:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088971; cv=none; b=nsfr/j2z6gMn0J+4o1JaRt7Gi4DZJXLZcp2pF1DH7M44elNOo7uB7gyi51jVFQih8YlbqQ3EP/K5kRG6loSDzQdj+GtokxVJrKxeGWsMxz/yybXcxzU4VcHw7iqifoEgS6zOmHdh5UAzFOqp5Z8G8Obo8iYNV2gwTRxclI6CFOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088971; c=relaxed/simple;
	bh=B+Gy8SEtqx9t6ms371lgzQbEfArEErMx5gqAWNsl6SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTe/WRcQgoo98isw41PIyy7rcu2pGNUPNOsaT5WrWq2aGrlgznXQaHxemZ2wWdhVAFTrJ46ZzcLTgADUcsua9c90yM16atsVqM4lJJKg4jN4NxdmM+iRolZ5Hb/xCgVl2280MqLWgtaqw2lTfV4oAh2vVo7PaWLVCA911yk/q/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQrM8oq8; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7eb9e7f3da2so34607939f.1;
        Mon, 10 Jun 2024 23:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718088968; x=1718693768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIV8kEyDfbkOpTN/DX1sgcJeZ6eCveBn7lNpOasAGh4=;
        b=XQrM8oq8eve8zoaomQoR0PMjVmPb+NKc2FFvfZCHAxSe0AUfJEV7TckDpulvNGWdTd
         15T+lywEAZjwiJJina/SKjR0hPz+hJY6QGmtzpMx/05RZJPEYndNVSRK7VrXgBD6e7RQ
         XR6Hukx4u2MgwS9ExPUnYUaaxGZozZIY/rVw+aQLwyuSODFBb4ejrBaMfDIJ+Wc6O3JK
         Aa9ZlaGxXckV2WmZGqFVg+W++Cfv+LYrEtsygQddSiADZcrBAu+xK5NK40jGnYbx2DpI
         AK9hmjJV314FV8hcbvHNx9SHbNtjZCEAnKSb+L1CLbq4hSds7j+qoMXnzBfQ2nhHtv9v
         e9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718088968; x=1718693768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIV8kEyDfbkOpTN/DX1sgcJeZ6eCveBn7lNpOasAGh4=;
        b=var67mX1l+A+1a2lu1ZLQ8/X3xqQ5HFNmUcOwCz8C12asbQ4X1+WCV/nzEn7SXcUOS
         fRa3wR9qlfMN5bc45pUm5nJytqrskqj+hEEkrbt7nlAbuLju4/C+SrPsBrwh+gZ/3AMY
         yQ8PPp5xP+BEZiZxKHgNAFmPEkh+/dkZyOPmd9UXAoN8yZLbkDjhtIn3Qdqojzq1n08n
         xcdfdyWOyuj8vBSnAK665vK5IUP9R8AGSFYR62YNuaBZuEuIls7ejr9sLTtI9kRr500w
         mnVIzWcbibYjOkPoouyKhMJtEUTFcUh1WuVQxvdpIbg1mb+rhJBqiRRGqiFVQDGGYi1d
         lAvA==
X-Forwarded-Encrypted: i=1; AJvYcCXQQyEh8735TTg2eWeBNDBOA7d0pNkp65f4o685U4722LMMdHBzoDRrClC+gJZcy4C4bvhUfLW9zccv+PTFHWb67rrUPExyevI8ad8bEkHtaj/BHgWk4U8yyuumq/GGiLVckCDSlNQKDOjRHOm2J7uXYtHEIpxuTB8WidjRwx2Z7wYqyQ==
X-Gm-Message-State: AOJu0Yx413igOBOmIO9J2L0gkoj9USr7sO5MeK6mDZR4HvXodTmEedG3
	fETjgsCOLLmw+GbTHDyCQp8HbZsdZnUz2h913gkiwEvtskLYmKT1AA8ibnidrrqJp0fHTS9xbXM
	MthDv2EJTrQdqBqX7flB3nan5M1s=
X-Google-Smtp-Source: AGHT+IF/aIbFJgENwccISyiDw4ED2Yu2mF1rJ9k3fpVdGgufmmvg4Nqe+PWlVb+q3Py3N5/NblY7j5GfNMfnA8pHx5A=
X-Received: by 2002:a92:c047:0:b0:375:86c9:9ec9 with SMTP id
 e9e14a558f8ab-37586c9a260mr97466115ab.11.1718088967543; Mon, 10 Jun 2024
 23:56:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717036278-3515-1-git-send-email-shengjiu.wang@nxp.com>
 <1717036278-3515-4-git-send-email-shengjiu.wang@nxp.com> <20240530090558.53reobf2zea22oi2@pengutronix.de>
 <Zlig/Z7u4nxvKLoQ@lizhi-Precision-Tower-5810> <20240530164510.fyznsyzvqrbu4a4e@pengutronix.de>
 <ZljGi+VPGgDxVYKf@lizhi-Precision-Tower-5810>
In-Reply-To: <ZljGi+VPGgDxVYKf@lizhi-Precision-Tower-5810>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 11 Jun 2024 14:55:55 +0800
Message-ID: <CAA+D8AOnoRouTmtv7VMXan=k9i8yQkBJvmWDEqtCTDizMJyDDA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] reset: imx-aux: Add i.MX auxiliary reset driver
To: Frank Li <Frank.li@nxp.com>
Cc: Marco Felsch <m.felsch@pengutronix.de>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
	p.zabel@pengutronix.de, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	marex@denx.de, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 2:34=E2=80=AFAM Frank Li <Frank.li@nxp.com> wrote:
>
> On Thu, May 30, 2024 at 06:45:10PM +0200, Marco Felsch wrote:
> > On 24-05-30, Frank Li wrote:
> > > On Thu, May 30, 2024 at 11:05:58AM +0200, Marco Felsch wrote:
> > > > Hi,
> > > >
> > > > On 24-05-30, Shengjiu Wang wrote:
> > > > > Add support for the resets on i.MX8MP Audio Block Control module,
> > > > > which includes the EARC PHY software reset and EARC controller
> > > > > software reset. The reset controller is created using the auxilia=
ry
> > > > > device framework and set up in the clock driver.
> > > > >
> > > > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > > > ---
> > > > >  drivers/reset/Kconfig         |   8 ++
> > > > >  drivers/reset/Makefile        |   1 +
> > > > >  drivers/reset/reset-imx-aux.c | 217 ++++++++++++++++++++++++++++=
++++++
> > > >                       ^
> > > > You make use of the auxiliary bus but this isn't a aux driver, it's=
 the
> > > > i.MX8MP EARC reset driver. According the TRM only the EARC reset bi=
ts
> > > > are covered by the AUDIOMIX blk-ctrl.
> > > >
> > > > >  3 files changed, 226 insertions(+)
> > > > >  create mode 100644 drivers/reset/reset-imx-aux.c
> > > > >
> > > > > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > > > > index 7112f5932609..38fdf05b326b 100644
> > > > > --- a/drivers/reset/Kconfig
> > > > > +++ b/drivers/reset/Kconfig
> > > > > @@ -91,6 +91,14 @@ config RESET_IMX7
> > > > >         help
> > > > >           This enables the reset controller driver for i.MX7 SoCs=
.
> > > > >
> > > > > +config RESET_IMX_AUX
> > > > > +       tristate "i.MX Auxiliary Reset Driver"
> > > >                   ^
> > > >               Same applies here
> > > >
> > > > > +       depends on CLK_IMX8MP
> > > > > +       select AUXILIARY_BUS
> > > > > +       default CLK_IMX8MP
> > > > > +       help
> > > > > +         This enables the auxiliary reset controller driver for =
i.MX.
> > > > > +
> > > > >  config RESET_INTEL_GW
> > > > >         bool "Intel Reset Controller Driver"
> > > > >         depends on X86 || COMPILE_TEST
> > > > > diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> > > > > index fd8b49fa46fc..f078da14c327 100644
> > > > > --- a/drivers/reset/Makefile
> > > > > +++ b/drivers/reset/Makefile
> > > > > @@ -14,6 +14,7 @@ obj-$(CONFIG_RESET_BRCMSTB_RESCAL) +=3D reset-b=
rcmstb-rescal.o
> > > > >  obj-$(CONFIG_RESET_GPIO) +=3D reset-gpio.o
> > > > >  obj-$(CONFIG_RESET_HSDK) +=3D reset-hsdk.o
> > > > >  obj-$(CONFIG_RESET_IMX7) +=3D reset-imx7.o
> > > > > +obj-$(CONFIG_RESET_IMX_AUX) +=3D reset-imx-aux.o
> > > > >  obj-$(CONFIG_RESET_INTEL_GW) +=3D reset-intel-gw.o
> > > > >  obj-$(CONFIG_RESET_K210) +=3D reset-k210.o
> > > > >  obj-$(CONFIG_RESET_LANTIQ) +=3D reset-lantiq.o
> > > > > diff --git a/drivers/reset/reset-imx-aux.c b/drivers/reset/reset-=
imx-aux.c
> > > > > new file mode 100644
> > > > > index 000000000000..61c353abc84e
> > > > > --- /dev/null
> > > > > +++ b/drivers/reset/reset-imx-aux.c
> > > > > @@ -0,0 +1,217 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +/*
> > > > > + * Copyright 2024 NXP
> > > > > + */
> > > > > +
> > > > > +#include <linux/auxiliary_bus.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/of_address.h>
> > > > > +#include <linux/of_platform.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/reset-controller.h>
> > > > > +
> > > > > +/*
> > > > > + * The reset does not support the feature and corresponding
> > > > > + * values are not valid
> > > > > + */
> > > > > +#define ASSERT_NONE     BIT(0)
> > > > > +#define DEASSERT_NONE   BIT(1)
> > > > > +#define STATUS_NONE     BIT(2)
> > > > > +
> > > > > +/* When set this function is activated by setting(vs clearing) t=
his bit */
> > > > > +#define ASSERT_SET      BIT(3)
> > > > > +#define DEASSERT_SET    BIT(4)
> > > > > +#define STATUS_SET      BIT(5)
> > > > > +
> > > > > +/* The following are the inverse of the above and are added for =
consistency */
> > > > > +#define ASSERT_CLEAR    (0 << 3)
> > > > > +#define DEASSERT_CLEAR  (0 << 4)
> > > > > +#define STATUS_CLEAR    (0 << 5)
> > > > > +
> > > > > +/**
> > > > > + * struct imx_reset_ctrl - reset control structure
> > > > > + * @assert_offset: reset assert control register offset
> > > > > + * @assert_bit: reset assert bit in the reset assert control reg=
ister
> > > > > + * @deassert_offset: reset deassert control register offset
> > > > > + * @deassert_bit: reset deassert bit in the reset deassert contr=
ol register
> > > > > + * @status_offset: reset status register offset
> > > > > + * @status_bit: reset status bit in the reset status register
> > > > > + * @flags: reset flag indicating how the (de)assert and status a=
re handled
> > > > > + */
> > > > > +struct imx_reset_ctrl {
> > > > > +       u32 assert_offset;
> > > > > +       u32 assert_bit;
> > > > > +       u32 deassert_offset;
> > > > > +       u32 deassert_bit;
> > > > > +       u32 status_offset;
> > > > > +       u32 status_bit;
> > > > > +       u32 flags;
> > > > > +};
> > > >
> > > > Why do we make it this compicated for an simple EARC module reset? =
I
> > > > understand that you want to provide a generic driver which can be
> > > > re-used but there is actual no other user and may will get no other=
 user
> > > > in the future too. Therefore I would like to keep it simple at the
> > > > begin and adapt the code on-demand.
> > >
> > > There are many similar cases. such as
> > > https://elixir.bootlin.com/linux/v6.10-rc1/source/drivers/pci/control=
ler/dwc/pci-layerscape.c#L251
> > >
> > > Previously it use syscon and regmap to a global register space region=
 and
> > > direct operate the register. Now this way will not preferred. It need=
s
> > > export as reset driver. but actually, it just write some bits.
> >
> > It depends, if your reset-controller is part of an complete different
> > device like this EARC reset you're right else you can write to the rese=
t
> > directly within you driver.
>
> These reset bits allocated a global register regions. Such as bit0 for
> pcie0, bit1 for pci1, bit2 for usb0, bit3 for usb1. Hardware pack these
> to misc mmio region.
>
> >
> > > We face the similar problem at difference driver when do upstream.
> > >
> > > One on going a discussion about sim module reset
> > > https://lore.kernel.org/imx/131e46b1-61d9-41de-a225-853b09c765d1@gmai=
l.com/
> > >
> > > We hope an unified and simple method to handle these cases.
> >
> > An unified driver for non-unified reset modules? This makes no sense to
> > me. When it comes to possible quirk handling for different reset module=
s
> > your code gets even more complex.
> >
> > I'm fine with a common code base (driver) if NXP has an common reset
> > controller IP which is added to several SoC. There should be no common
> > code base if this isn't the case.
>
> Some chip have common reset controller IP. Some chip simple packed reset
> bits to one global misc mmio region with other misc control bit, such pow=
er
> on/off / clock source choose / enable debug features.
>
> Here we just consider the second case. Anyway we need handle these case a=
t
> somewhere. 99% case just write bit<n> to register offset. Only difference
> is bit posstion and register offset. If write difference driver for these
> just because bit posstion or offset, there will be many duplicated codes
> under driver/reset.
>
> For example:
> Misc: 0x1000
>       bit0: pcie0 reset
>       bit2: usb0 reset
>       bit3-bit4: pcie clk source select
>       bit5-bit6: usb0 clk source select
>       bit7: pcie0 phy power on
>       bit8: usb0 phy power on.
>
> The difference chip, bit possition will be changed.
> How handle this case corporately?

What's the conclusion for this topic?
Should be the driver general for other cases or specific
for i.MX8MP AudioMIX?

Best regards
Shengjiu Wang
>
> >
> > Regards,
> >   Marco
> >
> >
> > >
> > > Frank
> > >
> > > >
> > > > Regards,
> > > >   Marco
> > > >
> > > > > +struct imx_reset_data {
> > > > > +       const struct imx_reset_ctrl *rst_ctrl;
> > > > > +       size_t rst_ctrl_num;
> > > > > +};
> > > > > +
> > > > > +struct imx_aux_reset_priv {
> > > > > +       struct reset_controller_dev rcdev;
> > > > > +       void __iomem *base;
> > > > > +       const struct imx_reset_data *data;
> > > > > +};
> > > > > +
> > > > > +static int imx_aux_reset_assert(struct reset_controller_dev *rcd=
ev,
> > > > > +                               unsigned long id)
> > > > > +{
> > > > > +       struct imx_aux_reset_priv *priv =3D container_of(rcdev,
> > > > > +                                       struct imx_aux_reset_priv=
, rcdev);
> > > > > +       const struct imx_reset_data *data =3D priv->data;
> > > > > +       void __iomem *reg_addr =3D priv->base;
> > > > > +       const struct imx_reset_ctrl *ctrl;
> > > > > +       unsigned int mask, value, reg;
> > > > > +
> > > > > +       if (id >=3D data->rst_ctrl_num)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       ctrl =3D &data->rst_ctrl[id];
> > > > > +
> > > > > +       /* assert not supported for this reset */
> > > > > +       if (ctrl->flags & ASSERT_NONE)
> > > > > +               return -EOPNOTSUPP;
> > > > > +
> > > > > +       mask =3D BIT(ctrl->assert_bit);
> > > > > +       value =3D (ctrl->flags & ASSERT_SET) ? mask : 0x0;
> > > > > +
> > > > > +       reg =3D readl(reg_addr + ctrl->assert_offset);
> > > > > +       writel(reg | value, reg_addr + ctrl->assert_offset);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int imx_aux_reset_deassert(struct reset_controller_dev *r=
cdev,
> > > > > +                                 unsigned long id)
> > > > > +{
> > > > > +       struct imx_aux_reset_priv *priv =3D container_of(rcdev,
> > > > > +                                       struct imx_aux_reset_priv=
, rcdev);
> > > > > +       const struct imx_reset_data *data =3D priv->data;
> > > > > +       void __iomem *reg_addr =3D priv->base;
> > > > > +       const struct imx_reset_ctrl *ctrl;
> > > > > +       unsigned int mask, value, reg;
> > > > > +
> > > > > +       if (id >=3D data->rst_ctrl_num)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       ctrl =3D &data->rst_ctrl[id];
> > > > > +
> > > > > +       /* deassert not supported for this reset */
> > > > > +       if (ctrl->flags & DEASSERT_NONE)
> > > > > +               return -EOPNOTSUPP;
> > > > > +
> > > > > +       mask =3D BIT(ctrl->deassert_bit);
> > > > > +       value =3D (ctrl->flags & DEASSERT_SET) ? mask : 0x0;
> > > > > +
> > > > > +       reg =3D readl(reg_addr + ctrl->deassert_offset);
> > > > > +       writel(reg | value, reg_addr + ctrl->deassert_offset);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int imx_aux_reset_status(struct reset_controller_dev *rcd=
ev,
> > > > > +                               unsigned long id)
> > > > > +{
> > > > > +       struct imx_aux_reset_priv *priv =3D container_of(rcdev,
> > > > > +                                       struct imx_aux_reset_priv=
, rcdev);
> > > > > +       const struct imx_reset_data *data =3D priv->data;
> > > > > +       void __iomem *reg_addr =3D priv->base;
> > > > > +       const struct imx_reset_ctrl *ctrl;
> > > > > +       unsigned int reset_state;
> > > > > +
> > > > > +       if (id >=3D data->rst_ctrl_num)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       ctrl =3D &data->rst_ctrl[id];
> > > > > +
> > > > > +       /* status not supported for this reset */
> > > > > +       if (ctrl->flags & STATUS_NONE)
> > > > > +               return -EOPNOTSUPP;
> > > > > +
> > > > > +       reset_state =3D readl(reg_addr + ctrl->status_offset);
> > > > > +
> > > > > +       return !(reset_state & BIT(ctrl->status_bit)) =3D=3D
> > > > > +               !(ctrl->flags & STATUS_SET);
> > > > > +}
> > > > > +
> > > > > +static const struct reset_control_ops imx_aux_reset_ops =3D {
> > > > > +       .assert   =3D imx_aux_reset_assert,
> > > > > +       .deassert =3D imx_aux_reset_deassert,
> > > > > +       .status   =3D imx_aux_reset_status,
> > > > > +};
> > > > > +
> > > > > +static int imx_aux_reset_probe(struct auxiliary_device *adev,
> > > > > +                              const struct auxiliary_device_id *=
id)
> > > > > +{
> > > > > +       struct imx_reset_data *data =3D (struct imx_reset_data *)=
(id->driver_data);
> > > > > +       struct imx_aux_reset_priv *priv;
> > > > > +       struct device *dev =3D &adev->dev;
> > > > > +
> > > > > +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > > > +       if (!priv)
> > > > > +               return -ENOMEM;
> > > > > +
> > > > > +       priv->rcdev.owner     =3D THIS_MODULE;
> > > > > +       priv->rcdev.nr_resets =3D data->rst_ctrl_num;
> > > > > +       priv->rcdev.ops       =3D &imx_aux_reset_ops;
> > > > > +       priv->rcdev.of_node   =3D dev->parent->of_node;
> > > > > +       priv->rcdev.dev       =3D dev;
> > > > > +       priv->rcdev.of_reset_n_cells =3D 1;
> > > > > +       priv->base            =3D of_iomap(dev->parent->of_node, =
0);
> > > > > +       priv->data            =3D data;
> > > > > +
> > > > > +       return devm_reset_controller_register(dev, &priv->rcdev);
> > > > > +}
> > > > > +
> > > > > +#define EARC  0x200
> > > > > +
> > > > > +static const struct imx_reset_ctrl imx8mp_audiomix_rst_ctrl[] =
=3D {
> > > > > +       {
> > > > > +               .assert_offset =3D EARC,
> > > > > +               .assert_bit =3D 0,
> > > > > +               .deassert_offset =3D EARC,
> > > > > +               .deassert_bit =3D 0,
> > > > > +               .flags  =3D ASSERT_CLEAR | DEASSERT_SET | STATUS_=
NONE,
> > > > > +       },
> > > > > +       {
> > > > > +               .assert_offset =3D EARC,
> > > > > +               .assert_bit =3D 1,
> > > > > +               .deassert_offset =3D EARC,
> > > > > +               .deassert_bit =3D 1,
> > > > > +               .flags  =3D ASSERT_CLEAR | DEASSERT_SET | STATUS_=
NONE,
> > > > > +       },
> > > > > +};
> > > > > +
> > > > > +static const struct imx_reset_data imx8mp_audiomix_rst_data =3D =
{
> > > > > +       .rst_ctrl =3D imx8mp_audiomix_rst_ctrl,
> > > > > +       .rst_ctrl_num =3D ARRAY_SIZE(imx8mp_audiomix_rst_ctrl),
> > > > > +};
> > > > > +
> > > > > +static const struct auxiliary_device_id imx_aux_reset_ids[] =3D =
{
> > > > > +       {
> > > > > +               .name =3D "clk_imx8mp_audiomix.reset",
> > > > > +               .driver_data =3D (kernel_ulong_t)&imx8mp_audiomix=
_rst_data,
> > > > > +       },
> > > > > +       { }
> > > > > +};
> > > > > +MODULE_DEVICE_TABLE(auxiliary, imx_aux_reset_ids);
> > > > > +
> > > > > +static struct auxiliary_driver imx_aux_reset_driver =3D {
> > > > > +       .probe          =3D imx_aux_reset_probe,
> > > > > +       .id_table       =3D imx_aux_reset_ids,
> > > > > +};
> > > > > +
> > > > > +module_auxiliary_driver(imx_aux_reset_driver);
> > > > > +
> > > > > +MODULE_AUTHOR("Shengjiu Wang <shengjiu.wang@nxp.com>");
> > > > > +MODULE_DESCRIPTION("Freescale i.MX auxiliary reset driver");
> > > > > +MODULE_LICENSE("GPL");
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
> > > > >
> > >


Return-Path: <linux-kernel+bounces-212969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0F7906919
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22225B22596
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0934414036A;
	Thu, 13 Jun 2024 09:39:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735A13F449
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271578; cv=none; b=uQ+C383UnPgNZkJBXwmf6fqDSkMVF+4l+HlNorsQmMHCF+Es+aJp5RPkOLzmbIQ+n27Rz5avD+qOaLFjox59+15nuwZI79q+V/HSc8oi3dC0rDhD9Sdk1ppKDYB+rJ4+enoNmVu/poJ3TiQmvN3Rpj9Of6D1QrdKbo8v0XHe9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271578; c=relaxed/simple;
	bh=iLQX6wuI1C08F/UQlPVe2qnRK6e+oxmbatREJ02+xTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtWdufP69PbSlGGS4VsZmK7mZqngTI/feWurp9QwmEBYz0XpKHxbBrPLpoh7AKkmXKVztY2I4rqpT+7ACLUHnnNmmuEatTyTzZ8wjZPSOBMANivGn8IRNU4Xio+vzXoeKmCFCz+7QH5RTXDMdttQafgkVdmRBvQcp2/egKuamo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1sHgvD-0002DT-Gy; Thu, 13 Jun 2024 11:39:07 +0200
Received: from [2a0a:edc0:2:b01:1d::c5] (helo=pty.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mfe@pengutronix.de>)
	id 1sHgvC-001zsF-Uc; Thu, 13 Jun 2024 11:39:06 +0200
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1sHgvC-008SNC-2h;
	Thu, 13 Jun 2024 11:39:06 +0200
Date: Thu, 13 Jun 2024 11:39:06 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, p.zabel@pengutronix.de,
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, marex@denx.de,
	linux-clk@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] clk: imx: clk-audiomix: Add reset controller
Message-ID: <20240613093906.trc2rahodmhqd4lt@pengutronix.de>
References: <1718243482-18552-1-git-send-email-shengjiu.wang@nxp.com>
 <1718243482-18552-3-git-send-email-shengjiu.wang@nxp.com>
 <20240613081949.yty3hznopp3u2qwq@pengutronix.de>
 <CAA+D8AMc9=bzHKNXyMH5LLerr2kgmKTxacP=1LhocTHgP9Thfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8AMc9=bzHKNXyMH5LLerr2kgmKTxacP=1LhocTHgP9Thfw@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 24-06-13, Shengjiu Wang wrote:
> On Thu, Jun 13, 2024 at 4:20 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > On 24-06-13, Shengjiu Wang wrote:
> > > Audiomix block control can be a reset controller for
> > > Enhanced Audio Return Channel (EARC), which is one of
> > > modules in this audiomix subsystem.
> > >
> > > The reset controller is supported by the auxiliary device
> > > framework.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  drivers/clk/imx/Kconfig               |  1 +
> > >  drivers/clk/imx/clk-imx8mp-audiomix.c | 63 +++++++++++++++++++++++++++
> > >  2 files changed, 64 insertions(+)
> > >
> > > diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
> > > index 6da0fba68225..9edfb030bea9 100644
> > > --- a/drivers/clk/imx/Kconfig
> > > +++ b/drivers/clk/imx/Kconfig
> > > @@ -81,6 +81,7 @@ config CLK_IMX8MP
> > >       tristate "IMX8MP CCM Clock Driver"
> > >       depends on ARCH_MXC || COMPILE_TEST
> > >       select MXC_CLK
> > > +     select AUXILIARY_BUS
> >
> >         select AUXILIARY_BUS if RESET_CONTROLLER
> 
> Do we really need this change?
> 
> I checked other drivers like MCHP_CLK_MPFS, but they don't have
> this condition also.

Since you made the whole reset optional I would like to pull reset
dependency optional as well e.g. pulling it only if you really use it.
In the end the RESET_CONTROLLER is enabled most the time.

> > >       help
> > >           Build the driver for i.MX8MP CCM Clock Driver
> > >
> > > diff --git a/drivers/clk/imx/clk-imx8mp-audiomix.c b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > index b381d6f784c8..517b1f88661b 100644
> > > --- a/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > +++ b/drivers/clk/imx/clk-imx8mp-audiomix.c
> > > @@ -5,6 +5,7 @@
> > >   * Copyright (C) 2022 Marek Vasut <marex@denx.de>
> > >   */
> > >
> > > +#include <linux/auxiliary_bus.h>
> > >  #include <linux/clk-provider.h>
> > >  #include <linux/device.h>
> > >  #include <linux/io.h>
> > > @@ -13,6 +14,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pm_runtime.h>
> > > +#include <linux/slab.h>
> >                 ^
> > This is an unrelated change.
> 
> This is for the fix of this issue
> 
> https://lore.kernel.org/oe-kbuild-all/202405201844.zf7UkDmq-lkp@intel.com/

Thanks for the link.

Regards,
  Marco

> Best regards
> Shengjiu wang
> 
> >
> > Regards,
> >   Marco
> >
> > >
> > >  #include <dt-bindings/clock/imx8mp-clock.h>
> > >
> > > @@ -217,6 +219,63 @@ struct clk_imx8mp_audiomix_priv {
> > >       struct clk_hw_onecell_data clk_data;
> > >  };
> > >
> > > +#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
> > > +
> > > +static void clk_imx8mp_audiomix_reset_unregister_adev(void *_adev)
> > > +{
> > > +     struct auxiliary_device *adev = _adev;
> > > +
> > > +     auxiliary_device_delete(adev);
> > > +     auxiliary_device_uninit(adev);
> > > +}
> > > +
> > > +static void clk_imx8mp_audiomix_reset_adev_release(struct device *dev)
> > > +{
> > > +     struct auxiliary_device *adev = to_auxiliary_dev(dev);
> > > +
> > > +     kfree(adev);
> > > +}
> > > +
> > > +static int clk_imx8mp_audiomix_reset_controller_register(struct device *dev,
> > > +                                                      struct clk_imx8mp_audiomix_priv *priv)
> > > +{
> > > +     struct auxiliary_device *adev __free(kfree) = NULL;
> > > +     int ret;
> > > +
> > > +     if (!of_property_present(dev->of_node, "#reset-cells"))
> > > +             return 0;
> > > +
> > > +     adev = kzalloc(sizeof(*adev), GFP_KERNEL);
> > > +     if (!adev)
> > > +             return -ENOMEM;
> > > +
> > > +     adev->name = "reset";
> > > +     adev->dev.parent = dev;
> > > +     adev->dev.release = clk_imx8mp_audiomix_reset_adev_release;
> > > +
> > > +     ret = auxiliary_device_init(adev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = auxiliary_device_add(adev);
> > > +     if (ret) {
> > > +             auxiliary_device_uninit(adev);
> > > +             return ret;
> > > +     }
> > > +
> > > +     return devm_add_action_or_reset(dev, clk_imx8mp_audiomix_reset_unregister_adev,
> > > +                                     no_free_ptr(adev));
> > > +}
> > > +
> > > +#else /* !CONFIG_RESET_CONTROLLER */
> > > +
> > > +static int clk_imx8mp_audiomix_reset_controller_register(struct clk_imx8mp_audiomix_priv *priv)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +#endif /* !CONFIG_RESET_CONTROLLER */
> > > +
> > >  static void clk_imx8mp_audiomix_save_restore(struct device *dev, bool save)
> > >  {
> > >       struct clk_imx8mp_audiomix_priv *priv = dev_get_drvdata(dev);
> > > @@ -337,6 +396,10 @@ static int clk_imx8mp_audiomix_probe(struct platform_device *pdev)
> > >       if (ret)
> > >               goto err_clk_register;
> > >
> > > +     ret = clk_imx8mp_audiomix_reset_controller_register(dev, priv);
> > > +     if (ret)
> > > +             goto err_clk_register;
> > > +
> > >       pm_runtime_put_sync(dev);
> > >       return 0;
> > >
> > > --
> > > 2.34.1
> > >
> > >
> > >
> 


Return-Path: <linux-kernel+bounces-400018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B559C07D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E511C23A30
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393B02101AB;
	Thu,  7 Nov 2024 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uzm/ufhS"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F362212194
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987007; cv=none; b=goa/VrJJDxyvo/yPuU9P1NwZwBVH1mC5iwP5Q/zSrbUTPF1dlGCjFEjbpHt3JB/J2PPFJeOliRVjPSPy66NQwfbJHw+k2uoIKmEcEy3XVgwvtdQpl0DjdeXwVaY4MIRDLG/dpRZRDFhCkMJjuk9L+OOVbbgOuTBPabWYq7wKKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987007; c=relaxed/simple;
	bh=CdrkMSC49tDl2mQv1mqeIdQHcjwZw0A1/AnqT+7ETn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWls3sNRRvFbf9xtzXlekQdyRfT9qudDEwarnNP0oKp0arrxi3T05jiP48c9TIQgYp4X3JGqp7xftkHmoeuxeE9MEMLJTFpwfgO59PCOekt5LDxU7f0FtzqfqrNffLuMI4vjQDrb0VfftDW+BSecclLL2rX14aX6gMBjkfGSH/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uzm/ufhS; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb58980711so9310721fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730987004; x=1731591804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTaMwPBJtQ/LdLyLH+A1iubTYFAHCFT/bM+1zUoljkk=;
        b=Uzm/ufhSu0N3h3v3dXOQuvMA13OYmBekUA6S/NXSDYzShXiRBx2lvB5xJAGIUwh3Fy
         6C5exFZP2KgHc62/ErY+9rUpVCzktIc11MWuY+40oBv0RB3sbnzmy3HYJTKSqeuJjBpy
         uAIMgO02RElc5jAapyp5zuVKtBJTmv9JnwTQVaj8r1UYpoQbP7Myr1XVUz+ujXPcVt6x
         9YUfr52K/eXrbV7EJKhx45U2zmQKkLWcmGSc8pesII5u4qdMNv71Ieb6VFLJV1IktX1u
         SBDNaRy8JRfd931I2Mp+7vtkCwGursYpJFARprx5YdUXrJnooVvJ2r06MoK95ACIOSxH
         XuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987004; x=1731591804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTaMwPBJtQ/LdLyLH+A1iubTYFAHCFT/bM+1zUoljkk=;
        b=BUXDPBbyyqJZh4bzpu8r9ndmT05wdihAAylr0RRPYctANZSzpF2kEC0jvjZJov7hIX
         MUXgDF6Z35b5bwGjNBpcdKLaWs4Q72GyJ1nKnGxOfJ/KmNfGR7FG2gCTiKCd1DdfFRwl
         FpfFu6kSE3kZa2I11U/v8UCc5XklhVhbhX2TD1D2ZmzebQTWJrXse/qenMTz57UdzQ1a
         K8RmR0jJ1MIZLq8gy/sJ62qNM9IfBmtg0SLhSCQ3RC4JgyZG8pOiV3dA3+iFnHFJ1Aiv
         x+PY9oumAuaSlZW3XzRTbsupX0sVNJ8/9T72UOruhC40CBBdhnN7BzyQUUUqoREKpf1w
         ah7w==
X-Forwarded-Encrypted: i=1; AJvYcCU9YUnBPGM0rZBI68nTL2p23U5/S/NvWd+YF7lbE4n9bK3qjZBO7PgybRABsZdM3NRrlVtwkecteVaZ0jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbohN/yBJU1PcjyesHYYlG8Q5Vh1GmxOZzs7v3f9GG40oswhOo
	ZbvbCeEkKaiQ1HfOa4LVEgqqggwotIElCuAZQh/ufUAHYDrponvrHcNilbL1cNs=
X-Google-Smtp-Source: AGHT+IEEXrpAS4axbz2EtICI+fGeaZacL297HQJJZ5R8O8wDOSGkjXWDf4lfkDOD+6Bag7+pFG1qiQ==
X-Received: by 2002:a05:651c:2209:b0:2fb:4c08:be08 with SMTP id 38308e7fff4ca-2fcbdf6ff42mr222407471fa.11.1730987003678;
        Thu, 07 Nov 2024 05:43:23 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff178dfe0asm2220701fa.23.2024.11.07.05.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:43:22 -0800 (PST)
Date: Thu, 7 Nov 2024 15:43:20 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sandor Yu <sandor.yu@nxp.com>
Cc: "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	"jonas@kwiboo.se" <jonas@kwiboo.se>, "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"robh+dt@kernel.org" <robh+dt@kernel.org>, 
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"vkoul@kernel.org" <vkoul@kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>, "mripard@kernel.org" <mripard@kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>, 
	Oliver Brown <oliver.brown@nxp.com>, 
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>, "sam@ravnborg.org" <sam@ravnborg.org>
Subject: Re: [PATCH v18 6/8] phy: freescale: Add DisplayPort/HDMI Combo-PHY
 driver for i.MX8MQ
Message-ID: <z6p6bewmykmufsghdojr4lvziurmmfpnrr5m4w3pfjlqzobpwr@zq2d2ukjvtac>
References: <cover.1730172244.git.Sandor.yu@nxp.com>
 <411e42c70e71dce33a80059f663fb6c58fb2ac8c.1730172244.git.Sandor.yu@nxp.com>
 <efciuvoptv7qxwauswfseb6zlt5w4fmjdbm3huxfsn63a6bm7u@kfgkkvqoz5x4>
 <PAXPR04MB9448F638D47B5495CF78007AF4522@PAXPR04MB9448.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9448F638D47B5495CF78007AF4522@PAXPR04MB9448.eurprd04.prod.outlook.com>

On Tue, Nov 05, 2024 at 02:05:51PM +0000, Sandor Yu wrote:
> > 
> > On Tue, Oct 29, 2024 at 02:02:14PM +0800, Sandor Yu wrote:
> > > Add Cadence HDP-TX DisplayPort and HDMI PHY driver for i.MX8MQ.
> > >
> > > Cadence HDP-TX PHY could be put in either DP mode or
> > > HDMI mode base on the configuration chosen.
> > > DisplayPort or HDMI PHY mode is configured in the driver.
> > >
> > > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > ---
> > > v17->v18:
> > > - fix build error as code rebase to latest kernel version.
> > >
> > >  drivers/phy/freescale/Kconfig                |   10 +
> > >  drivers/phy/freescale/Makefile               |    1 +
> > >  drivers/phy/freescale/phy-fsl-imx8mq-hdptx.c | 1337
> > ++++++++++++++++++
> > >  3 files changed, 1348 insertions(+)
> > >  create mode 100644 drivers/phy/freescale/phy-fsl-imx8mq-hdptx.c
> > >
> > > diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> > > index dcd9acff6d01a..2b1210367b31c 100644
> > > --- a/drivers/phy/freescale/Kconfig
> > > +++ b/drivers/phy/freescale/Kconfig

[...]

I'm sorry, my email client cut the email.

> > > +static int cdns_hdptx_dp_configure(struct phy *phy,
> > > +                                union phy_configure_opts *opts)
> > > +{
> > > +     struct cdns_hdptx_phy *cdns_phy = phy_get_drvdata(phy);
> > > +
> > > +     cdns_phy->dp.link_rate = opts->dp.link_rate;
> > > +     cdns_phy->dp.lanes = opts->dp.lanes;
> > 
> > Shouldn't this be conditional on set_rate / set_lanes ?
> 
> PHY do not support reconfigure link rate and lane count.

So, you don't support reconfiguring the rate / count, but you still copy
the new rate and lanes into your driver data. That sounds strange.

[...]

> 
> > 
> > > +
> > > +static int cdns_hdptx_phy_set_mode(struct phy *phy, enum phy_mode
> > mode, int submode)
> > > +{
> > > +     struct cdns_hdptx_phy *cdns_phy = phy_get_drvdata(phy);
> > > +     int ret = 0;
> > > +
> > > +     if (mode == PHY_MODE_DP) {
> > > +             hdptx_dp_phy_ref_clock_type(cdns_phy);
> > > +
> > > +             /* PHY power up */
> > > +             ret = hdptx_dp_phy_power_up(cdns_phy);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > > +             hdptx_dp_aux_cfg(cdns_phy);
> > 
> > Why? Don't power up the PHY if you haven't been told to.
> 
> Power on the PHY to enable DP AUX, which is necessary for reading EDID and training the link.

Call phy_power_on() from the DP driver.

> 
> > 
> > > +     } else if (mode != PHY_MODE_HDMI) {
> > > +             dev_err(&phy->dev, "Invalid PHY mode: %u\n", mode);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +static int cdns_hdptx_hdmi_configure(struct phy *phy,
> > > +                                  union phy_configure_opts
> > *opts)
> > > +{
> > > +     struct cdns_hdptx_phy *cdns_phy = phy_get_drvdata(phy);
> > > +     int ret;
> > > +
> > > +     cdns_phy->hdmi.tmds_char_rate = opts->hdmi.tmds_char_rate;
> > > +
> > > +     /* Check HDMI FW alive before HDMI PHY init */
> > > +     ret = hdptx_phy_check_alive(cdns_phy);
> > > +     if (!ret) {
> > > +             dev_err(cdns_phy->dev, "NO HDMI FW running\n");
> > > +             return -ENXIO;
> > > +     }
> > > +
> > > +     /* Configure PHY */
> > > +     if (hdptx_hdmi_phy_cfg(cdns_phy, cdns_phy->hdmi.tmds_char_rate)
> > < 0) {
> > > +             dev_err(cdns_phy->dev, "failed to set phy pclock\n");
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     ret = hdptx_hdmi_phy_power_up(cdns_phy);
> > 
> > it seems to be all over the place :-(
> 
> The PHY has different power-up rules depending on whether it's in DP or HDMI mode. 
> In DP mode, it needs to power up first to enable DP AUX. 
> In HDMI mode, it can power up last.

The main question is why are you powering the PHY from the configure
path at all? There is a phy_power_on() API which should be used by your
HDMI / DP driver instead of handling that in an automagic way.

> 

-- 
With best wishes
Dmitry


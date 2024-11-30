Return-Path: <linux-kernel+bounces-426133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF56C9DEF5D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED782817F9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11614AD24;
	Sat, 30 Nov 2024 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkzHa6u0"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E87080A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732955391; cv=none; b=BfLgZZm2QSyG9kJyai7wikOy2NZoryi+BpIMP2o56qy3C+Xu2FvJ15euBxk4yZPO+cixHq3XtO5U9yK3DLCSFgrQMP/g1qhTX8KDSHCvyjMOhhgK+NaN2lGOGI2551ayg170Ry30qI643pPiJ86e5jQL6dA8fMQ81MKp/Jb9+ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732955391; c=relaxed/simple;
	bh=0fSqyzR++e7auylOPjp0yiY8ODsmjbPZaFBt/OyXsBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+axALYGwG4hsdukkLALLuqu+HY2eb1SYyIdrVB270knKZx8I/0Qk+tCuVXc4RgR71kPmNSHnWHfVu0DLaujDryVS3tEPDfii7hclUJOsp4dTAUxNzxo19MXt55x8MjPEVxTxdGJ88K58xKrUrLDYocx7q4HSvxUm5NLV70tVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HkzHa6u0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53de101525eso3469658e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732955387; x=1733560187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwEfcn5Pby1DuMjHVg1b1o/lcfJvv/jFNZtuiy5rgCw=;
        b=HkzHa6u0UNBNQY+pUjgl/qbTDrT6IFFvje/xc/ylVkCidfqh3wYlHHRv04jq4V1FC3
         B21z9OWxtC6fk/2yrioQcHKtnKkha5NnLRGQsFP5Oj0ORZS/jMlP4Gn0OHunTfttQY/H
         4iDauQU28wHVwxEN+cePCphA4E8S6PMCasp0wf38V5jlwS2FyCnA2tN2N7t+FSCdGg18
         l2h3LQsMw9biL+XpbCYiCiviwORV8PHhHJ9YfUOvS1PrhvGpnXaZxlP/fEH6x+TyfwJS
         tVUzcTr0JuPZETryJgmGNnEeaswkSUYXbjcD0OVBT+dVPf+Sm8j7KefxZb9JLrCamdqN
         vETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732955387; x=1733560187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwEfcn5Pby1DuMjHVg1b1o/lcfJvv/jFNZtuiy5rgCw=;
        b=c3y59UPU0leB6w1xG/5aAGbnMI6K06zXBP4RugRPmR9eNOqxttkjD2JfTFKKktKh+s
         1adKhTpCFCM32FSBTbGBe/843LwKeRPSk3F0wI5JXuzdLefGLWD196XoLF4ra8I5MzC2
         L0glb7zU8HgettD00Wrw0vCMGmS/9TLgj4SVBV2JiNL4kvP66munGm07aQoHyfyaN57U
         TnJ/txJ1tiem/hSIQbuvWHg7f2r1b73YyphRtzBxFwJPtrhwmSOlrAdWO4aV0H8rCaxm
         ZHsuxIm+nLMjyNffua2SvdI9asi3I9WcQCoqQEJgGEs0BZU1KX8N5LpYxCT+T8/Lhr53
         vGRw==
X-Forwarded-Encrypted: i=1; AJvYcCU6PQHmu+hnUVRTSS578aPqhm7ZXERDobL2LA2ZGl0Hcv1kxhv6yTr3PTs07FE8S8GALliHQobIcyEBHmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7PSujtoKlvisnmGSVXlh+pmCwmzoIhdPCXP+ja3hfX1Af8hnS
	n2YYsifKxgEg6s9X8M3K5QtHv+MZ/Y9vnNYQDo7+eYJmor8VlN5FcBB4UAF+p7o=
X-Gm-Gg: ASbGncu3KKTaW4AJs2bh3sIh2D4WUb+xsllOY9P3CW9vH3ksvfnfjTMeTUJrmmIseYy
	GWMQPRo6QKrttCUc+g+44zZwbeALRTmgckdQQw88hzmvLfKHUmtvO0LXMzDD+HnL24P/SIAqfHQ
	96IffspuKbwY78XFhJFUbscJHBuauyYt89xcvtcOeKZk/iW7Na725maIVHYB1ZM4IjUhoFWYf3k
	p5/f/NeXOqgm3g5kTVoO5y5o52BDn+obI8HiIvRHbj3E/wa9r0XdfpYe24lFwFKFc2GRqoprcIY
	ScI9SGADHj+24PIvaBCgIQSHaI4aBg==
X-Google-Smtp-Source: AGHT+IG7msEs9hgIu3ta16vL9mWEiaIEtxRrnODIuHdyaMtVbZhaiQTdxZhi9NhcUgHBW26OK3t30w==
X-Received: by 2002:a05:6512:3f7:b0:53d:f583:81df with SMTP id 2adb3069b0e04-53df5838209mr2781109e87.28.1732955387112;
        Sat, 30 Nov 2024 00:29:47 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a05ebsm703544e87.255.2024.11.30.00.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:29:45 -0800 (PST)
Date: Sat, 30 Nov 2024 10:29:43 +0200
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
Subject: Re: [EXT] Re: [PATCH v18 6/8] phy: freescale: Add DisplayPort/HDMI
 Combo-PHY driver for i.MX8MQ
Message-ID: <foi2sizfkppmunq4yqt4pex47alsvsjyqi3rk32fwyz4f5xepn@zdsx74bzzda4>
References: <cover.1730172244.git.Sandor.yu@nxp.com>
 <411e42c70e71dce33a80059f663fb6c58fb2ac8c.1730172244.git.Sandor.yu@nxp.com>
 <efciuvoptv7qxwauswfseb6zlt5w4fmjdbm3huxfsn63a6bm7u@kfgkkvqoz5x4>
 <PAXPR04MB9448F638D47B5495CF78007AF4522@PAXPR04MB9448.eurprd04.prod.outlook.com>
 <z6p6bewmykmufsghdojr4lvziurmmfpnrr5m4w3pfjlqzobpwr@zq2d2ukjvtac>
 <PAXPR04MB9448D68A5CA9755036E9B23DF42F2@PAXPR04MB9448.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9448D68A5CA9755036E9B23DF42F2@PAXPR04MB9448.eurprd04.prod.outlook.com>

On Tue, Nov 26, 2024 at 02:12:19PM +0000, Sandor Yu wrote:
>  
> > 
> > On Tue, Nov 05, 2024 at 02:05:51PM +0000, Sandor Yu wrote:
> > > >
> > > > On Tue, Oct 29, 2024 at 02:02:14PM +0800, Sandor Yu wrote:
> > > > > Add Cadence HDP-TX DisplayPort and HDMI PHY driver for i.MX8MQ.
> > > > >
> > > > > Cadence HDP-TX PHY could be put in either DP mode or HDMI mode
> > > > > base on the configuration chosen.
> > > > > DisplayPort or HDMI PHY mode is configured in the driver.
> > > > >
> > > > > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > > > > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > > > > ---
> > > > > v17->v18:
> > > > > - fix build error as code rebase to latest kernel version.
> > > > >
> > > > >  drivers/phy/freescale/Kconfig                |   10 +
> > > > >  drivers/phy/freescale/Makefile               |    1 +
> > > > >  drivers/phy/freescale/phy-fsl-imx8mq-hdptx.c | 1337
> > > > ++++++++++++++++++
> > > > >  3 files changed, 1348 insertions(+)  create mode 100644
> > > > > drivers/phy/freescale/phy-fsl-imx8mq-hdptx.c
> > > > >
> > > > > diff --git a/drivers/phy/freescale/Kconfig
> > > > > b/drivers/phy/freescale/Kconfig index dcd9acff6d01a..2b1210367b31c
> > > > > 100644
> > > > > --- a/drivers/phy/freescale/Kconfig
> > > > > +++ b/drivers/phy/freescale/Kconfig
> > 
> > [...]
> > 
> > I'm sorry, my email client cut the email.
> > 
> > > > > +static int cdns_hdptx_dp_configure(struct phy *phy,
> > > > > +                                union phy_configure_opts
> > *opts) {
> > > > > +     struct cdns_hdptx_phy *cdns_phy = phy_get_drvdata(phy);
> > > > > +
> > > > > +     cdns_phy->dp.link_rate = opts->dp.link_rate;
> > > > > +     cdns_phy->dp.lanes = opts->dp.lanes;
> > > >
> > > > Shouldn't this be conditional on set_rate / set_lanes ?
> > >
> > > PHY do not support reconfigure link rate and lane count.
> > 
> > So, you don't support reconfiguring the rate / count, but you still copy the new
> > rate and lanes into your driver data. That sounds strange.
> 
> The PHY will use link rate and lane count to configure its registers

I'm not sure if I follow it. Do you mean that rate / count configuration
is static?

-- 
With best wishes
Dmitry


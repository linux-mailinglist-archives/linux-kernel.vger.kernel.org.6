Return-Path: <linux-kernel+bounces-426132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C839DEF5A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3262F2818A7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279EE14AD17;
	Sat, 30 Nov 2024 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QO9F+vIZ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA282890
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732955292; cv=none; b=ciGkP0DfdRaejL6+gEFjaWEkWfVYnb8yMe+kcQz1DyPphAAxUjSrIZ0FTe/kL/pEZhPQfArKI7dDssMHaabeSSRvMTIrtrqwOFum0GmxPXC+5NvhVWGwW4reITZGs9y+wp69rsYDKpVcHu6EUVYd55B8O0RMqcSJE5Zcf5jmPuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732955292; c=relaxed/simple;
	bh=fYn442T/AQOKnN21tdYpJy8wXXVO0asEBiPBzRbbUe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYhRGBMmWxACzwN4TxafhAlsiun12wef79AYGhh69J2tKDucJatD5CfdE2B8DGbo3LyYtWXT1uayCXkOSd8uKM4GXy/L1wCyWR9fT2gRe9jIjDgO1uN87Wb1OYyIF8UaOkloiu6jhjSm9xsWzpUypFGgUV0VISEQsLN3p9QgWrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QO9F+vIZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53de84e4005so3009228e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 00:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732955289; x=1733560089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cbSnMoGC544U7zX5fIfp831y8T12sKgnt66TAb2i060=;
        b=QO9F+vIZB9VDc/r+6+RJVUK++vVu9vSPPuKe6la2OWKS/Lf7kahpvZhcEO+qA/PG3i
         rwtVfqUilYRFIbYDY2M7fkUefsf+MOqAYp9NJRwVVCeMcHFp49NgygzGZIWbPyE3eCUQ
         C/mWXe9E6aQQ2FcfTgLxZei7W909mYOMorQXOt3LHLhFBmRkPw4vKQIo5Z3BKnw/iZlI
         rLgkhlR3DMHil+0EqTh82+2dF/V3p5E2BSSOYfENYRGWHev4FBqqn4DJ4dFCB0W3hPvz
         2VgF87/HjpXNRVWaqxkuBh0WMUZ58BQsSxnKo7slYggZgxMBC0Vk3/6gX8Czhy0SgfGP
         ofhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732955289; x=1733560089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbSnMoGC544U7zX5fIfp831y8T12sKgnt66TAb2i060=;
        b=jSSMpMyJPZTo2TSCiE5dBA7uObB9XKmTIHMn4kB7mKHYBM0VONqAT5cJnHDIs0tYCk
         goPnJsRnV4j2t99bJt7NJdEeQzRmUsq7B4IICXCLA9S1vhSF1UiuqDEedUNMCPpyKLIA
         wK+Eh9LOqHP9YwGmkzpI/zZtxCn35+f7/tUkZtX/FOg1TJPIGSyi0Zx3Z4YBCDZNS6Uq
         dMGJVRTMXpBSQSPMi6DUNRty4Fyic+OPAUsXXK6Omqtmu/18zySOAfixe3cFmrR7Js7h
         y49y8b+42LSqCinLNUJg+c7VCNhCM6x5RwqAy6RuarPOyMzsvUA1fIYDm2CoJRvFeyDm
         HDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXplgpaHDK8Lh7OgMVmuwOsW819OkvnmpXgc8sOh9qM3/PtYeCmhjphVTJ+Te8filAPzAxKdmswMsU1pRE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5h4fY6ht/eHq40OssMTVhgt6S+w/+34WtQ52wgCy84uUmxZR0
	SCtvF+HTLCCAS0tBBNe4pLpHg3vKXfLoiZsOhBCQwv+MoO9fVb2eYz4ztS5dDwk=
X-Gm-Gg: ASbGnctyWqvY/AYW9XWkvdflRQzU1AVLkadU9lDwyAcjCYYbWtanQuU0ze8AnReyQAj
	s/JWRROdDuNYnPFQQRUzhVJ47NKExSSi2iu0wRKTGDWqUjX41qzEJ63+Fo8AtBDPqpXrRD6xGUg
	za7b6slijuXINo69wDWAu8QAqJV5L50OlU/oEX3P5UdbSJieJgPewZK3+HQheAddABzRdNczDFc
	XyfnoLcWcBUXojUF8hZZvDkD9htAHXIxQSMovs5k74bECQOp2iFJoREKGQ8ZEO6s8QPUKmJ7x4T
	SsJVC3HhLCCkudWX/fZ+fjDua8T4Gw==
X-Google-Smtp-Source: AGHT+IFgWR3gAkOG9mafLXj/TmNlCERT2tB84SZRTKkdRAWB1jZom71zptQRqQUiP9OjF7eSxCiFOQ==
X-Received: by 2002:a05:6512:3c9c:b0:53d:e544:3fda with SMTP id 2adb3069b0e04-53df0114865mr9728745e87.55.1732955288602;
        Sat, 30 Nov 2024 00:28:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df646f2cesm689752e87.121.2024.11.30.00.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 00:28:07 -0800 (PST)
Date: Sat, 30 Nov 2024 10:28:04 +0200
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
Message-ID: <ux55oif6kyp6thojj55ymlcjjgsmqbrc35wtmmfbaun7qlxfuw@k6fi3ea5laty>
References: <cover.1730172244.git.Sandor.yu@nxp.com>
 <411e42c70e71dce33a80059f663fb6c58fb2ac8c.1730172244.git.Sandor.yu@nxp.com>
 <efciuvoptv7qxwauswfseb6zlt5w4fmjdbm3huxfsn63a6bm7u@kfgkkvqoz5x4>
 <PAXPR04MB9448F638D47B5495CF78007AF4522@PAXPR04MB9448.eurprd04.prod.outlook.com>
 <76D430C8-3DBB-4D89-9361-9B5D3EDCF067@linaro.org>
 <PAXPR04MB9448A7F6973D9DAE98115716F42F2@PAXPR04MB9448.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9448A7F6973D9DAE98115716F42F2@PAXPR04MB9448.eurprd04.prod.outlook.com>

On Tue, Nov 26, 2024 at 02:12:04PM +0000, Sandor Yu wrote:
> > 
> > 
> > On 5 November 2024 14:05:51 GMT, Sandor Yu <sandor.yu@nxp.com> wrote:
> > >>
> > >> On Tue, Oct 29, 2024 at 02:02:14PM +0800, Sandor Yu wrote:
> > >> > Add Cadence HDP-TX DisplayPort and HDMI PHY driver for i.MX8MQ.
> > >> >
> > >> > Cadence HDP-TX PHY could be put in either DP mode or HDMI mode
> > base
> > >> > on the configuration chosen.
> > >> > DisplayPort or HDMI PHY mode is configured in the driver.
> > >> >
> > >> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > >> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > >> > ---
> > >> > v17->v18:
> > >> > - fix build error as code rebase to latest kernel version.
> > >> >
> > >> >  drivers/phy/freescale/Kconfig                |   10 +
> > >> >  drivers/phy/freescale/Makefile               |    1 +
> > >> >  drivers/phy/freescale/phy-fsl-imx8mq-hdptx.c | 1337
> > >> ++++++++++++++++++
> > >> >  3 files changed, 1348 insertions(+)  create mode 100644
> > >> > drivers/phy/freescale/phy-fsl-imx8mq-hdptx.c
> > >> >
> > >> > diff --git a/drivers/phy/freescale/Kconfig
> > >> > b/drivers/phy/freescale/Kconfig index dcd9acff6d01a..2b1210367b31c
> > >> > 100644
> > >> > --- a/drivers/phy/freescale/Kconfig
> > >> > +++ b/drivers/phy/freescale/Kconfig
> > >> > @@ -35,6 +35,16 @@ config PHY_FSL_IMX8M_PCIE
> > >> >         Enable this to add support for the PCIE PHY as found on
> > >> >         i.MX8M family of SOCs.
> > >> >
> > >> > +config PHY_FSL_IMX8MQ_HDPTX
> > >> > +     tristate "Freescale i.MX8MQ DP/HDMI PHY support"
> > >> > +     depends on OF && HAS_IOMEM
> > >> > +     depends on COMMON_CLK
> > >> > +     select GENERIC_PHY
> > >> > +     select CDNS_MHDP_HELPER
> > >>
> > >> This can have problems with being satisfied on randconfig builds,
> > >> because CDNS_MHDP_HELPER is deep inside the DRM tree.
> > >
> > >Yes, it should be. Change it to "depend on CDNS_MHDP_HELPER" will
> > eliminate this problem.
> > 
> > No, depending on a non-user-selectable symbol is a bad idea. You should
> > either depend/select all necessary symbols or, better in my opinion, move
> > your helpers out of the DRM tree.
> 
> How about change CDNS_MHDP_HELPER to user selectable? such as
> 
>  config CDNS_MHDP_HELPER
>          tristate "Cadence MHDP Helper driver"
>          help
>            Enable Cadence MHDP helpers for mailbox, HDMI and DP.
>            This driver provides a foundational layer of mailbox communication for
>            various Cadence MHDP IP implementations, such as HDMI and DisplayPort

I'd say, it's a bad idea. Helpers should be automatically selected.

> 
> Finding a suitable location for the helper code is challenging. 
> It needs to be shared among various IP versions (essentially different SoCs) 
> and across different driver types to facilitate mailbox access.
> I've searched the kernel code but haven't found a good precedent. 
> Placing this helper in either drivers/gpu/drm/bridge/cadence or drivers/soc/ (as you previously suggested) has its drawbacks. 
> drivers/gpu/drm/bridge/cadence at least provides better context for readers.

Yes, I understand the issue. However you might as well use drivers/phy/
for the helpers: your DRM driver already depends on GENERIC_PHY, but
there is no dependency from the PHY onto the DRM.

> 
> > 
> > 
> > >
> > >>
> > >> > +     help
> > >> > +       Enable this to support the Cadence HDPTX DP/HDMI PHY
> > driver
> > >> > +       on i.MX8MQ SOC.
> > >> > +
> > >> >  config PHY_FSL_IMX8QM_HSIO
> > >> >       tristate "Freescale i.MX8QM HSIO PHY"
> > >> >       depends on OF && HAS_IOMEM

-- 
With best wishes
Dmitry


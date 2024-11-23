Return-Path: <linux-kernel+bounces-419242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3034F9D6B42
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8EFC1618F2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 19:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C00178383;
	Sat, 23 Nov 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pvz+ltHO"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E06F099;
	Sat, 23 Nov 2024 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732391253; cv=none; b=Xp7w4TCqcfMU1qmOMerUyzwiYdg+OC5hdNmHwtTxRJeg1/7bASq5SeEBOS+kRd3Lfmypy9lIlIb6BlukSxb09z6rHG/bTqfz1i1hlRiQ3f7AvBPcOAAyerDFZSBnYHelcjtmKqn3CfPYRol2wc3HABBvTyEvt2d0IHW6S+8hw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732391253; c=relaxed/simple;
	bh=aZA3trjlfivLV4xAqz8KmDMOR/afSd2+Nsdl23oV524=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/sdgBxcACXOQrc/P1jCUoNCeakIZISpX+dXcuUS5EoGmlQpd7ywh74ifVS3e0APzGXNkRn98/frccg/89pWUBdgmtJ/cVxK0d6l8gDUc1mm9iGNPlA/9ux4JTgEmEt6s8WrylGOiJHWCIrGWYLrhJCSZOpOb/CGN2xC+epk+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pvz+ltHO; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21260cfc918so23196825ad.0;
        Sat, 23 Nov 2024 11:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732391251; x=1732996051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIisu+SInmO8aU5o7J4/R5vnmz4PGenJ0iDGtFRy0GM=;
        b=Pvz+ltHOvi2k5iCj2IQzx8Ra1SNt8U+ZQ0QqBsdWG9UXCAm4a9wMhYyW4YZdcPyfDs
         vKdfUQ62BagHTEaxW8BR/FaOIv25fekplLPeFTjJcfgIwZGQsaBv0FxEu25KCa9t8Mso
         2NhwUJB/yzTpFhctBIobUMttSr+BJFUebYWVRvd6FfXLIC3Oe0YxbFOGO+xA17U2MwNx
         wWpf9wWJfndJmWVKnWeHhNlp6TIzKxUn/xrBw/0qGB19Y3rWyAxPq6/WLKnpWidWB8Cz
         fDls5XtEeW6ZNKkSMswUjaQDmqAEoTRWQHMctnEP2wsk8oUPglEKb3VmacK6kaqEaBql
         S81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732391251; x=1732996051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIisu+SInmO8aU5o7J4/R5vnmz4PGenJ0iDGtFRy0GM=;
        b=tlmjEIPwKN1RcGXgWwbcl9b9009Ll7X2nrvOrcuiv0fWsGMi+amrIK7GBqqIrindhV
         JykV+B9++Fmhtt26YRbA3IwxF/QVO49V9wlV8OInCZ2r2t4SnnCrhRZTGNuNFY7cWmit
         fcK0J/VjxjLGM3XGZ6Tpe7kYhHtGZ9rdvMEkw/eQQcNGn6IMRO3qj8Rc5coAjftW+Qez
         N8Azdvx6ZrVeo48nBGoihJo55QhEXttASO8bGcy6Z6XF5gIcdEibBhOapzw9zmfTNxfq
         p5s5Ihi9d2Slbn6PO8gm3oqodkzEPepOOBG0IFG3CCXBZRa3rfnVe/IrZ/YrT9QaO4Iu
         zu1g==
X-Forwarded-Encrypted: i=1; AJvYcCU1v/nyeF3DAqkG0BkT14ZFNvXCw5xjXoOgnVr3uTETYdYrxLiAIHnvsCN7xw/cIj9HxHlgUDCpuz/lpgb2@vger.kernel.org, AJvYcCVBppl4J0tYR6mgzmm7iEZdtQzilvL0QEW1Re//rTQVMUHbNkbzcwyp1XjG5/oPdCVfuf7Ecs5+I/YE@vger.kernel.org, AJvYcCVu3HVLPurZd6GPdY/HHY0SZ1pxZimHlz+bMxfRZpjvGtsN4Tprp2Y2OTcBadRtJa4J0HQQht/sbE+U@vger.kernel.org
X-Gm-Message-State: AOJu0YyHcfVpcWwwr8uPZxoZPYEK7nMNpzQ45To1c8rEIlE1XF7HwD8J
	dKNruLb8EcRyrN0XBDJHzmAfc5ZfMtQtASdEZ0heVLbctyMWo2iX/8KmJ7tdUXPh91Fr0QBd8T8
	AZJlSU7k/0IIJs6Hc5uae/VrwyWBN9Ngg
X-Gm-Gg: ASbGnctxuP40i3k12iCO9Ui7k7QtlGW4e7ZvUyua5R6If9yNUNZlrSwKpOfEGA7aEMu
	33kQWJy50+2EZfouo1kiXw2NuAy0mbKk=
X-Google-Smtp-Source: AGHT+IER882hxWGxdnLbHc4WL+b6BKZBCKwOSHKs1j9B4N3y0JbmongRgfkv5XWs473nMaR5UvS6LxycIeafIw7+oY8=
X-Received: by 2002:a17:902:ea09:b0:20b:b93f:300a with SMTP id
 d9443c01a7336-2129f72fe53mr91133915ad.7.1732391250925; Sat, 23 Nov 2024
 11:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114065759.3341908-1-victor.liu@nxp.com> <20241114065759.3341908-3-victor.liu@nxp.com>
 <df6ebdde-65f8-4aad-93c7-b1df695bd2ef@denx.de> <AM7PR04MB7046546A882A8D48E135D84698272@AM7PR04MB7046.eurprd04.prod.outlook.com>
 <8a4fd234-4c7b-4a04-990d-3222aaa5172d@denx.de> <AM7PR04MB7046E282FD702ACE5E288F8998202@AM7PR04MB7046.eurprd04.prod.outlook.com>
 <83be0a27-6b6c-4ba6-b9dc-f914a10abace@denx.de> <AM7PR04MB7046587167BF790549B8560F98212@AM7PR04MB7046.eurprd04.prod.outlook.com>
 <c5ab63da-21ec-4c0d-8ecc-3745943d806f@denx.de> <AM7PR04MB7046D404841394382324DE7198232@AM7PR04MB7046.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB7046D404841394382324DE7198232@AM7PR04MB7046.eurprd04.prod.outlook.com>
From: Adam Ford <aford173@gmail.com>
Date: Sat, 23 Nov 2024 13:47:19 -0600
Message-ID: <CAHCN7xJsTo=yRxkqPwvt5hX0UTFvF+gBVOqcjrR2jSq4jKzV3g@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] Revert "clk: imx: clk-imx8mp: Allow media_disp
 pixel clock reconfigure parent rate"
To: Ying Liu <victor.liu@nxp.com>
Cc: Marek Vasut <marex@denx.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "abelvesa@kernel.org" <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>, 
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "rfoss@kernel.org" <rfoss@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>, 
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>, 
	"quic_bjorande@quicinc.com" <quic_bjorande@quicinc.com>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, 
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, 
	"nfraprado@collabora.com" <nfraprado@collabora.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 9:39=E2=80=AFPM Ying Liu <victor.liu@nxp.com> wrote=
:
>
> On 11/22/24, Marek Vasut wrote:
> > On 11/20/24 7:38 AM, Ying Liu wrote:
> >
> > [...]
> >
> > >>> If the DP monitors support typical video modes like 1080p60 with
> > >>> 148.5MHz pixel clock rate, I assume these typical video modes work
> > >>> still ok with this patch at least.  Please help confirm this, since=
 if the
> > >>> alternative solution(*) doesn't stand, we would know those video
> > >>> modes still work ok with my solution(fixed PLL rate).
> > >>
> > >> They do not work with the fixed PLL setting.
> > >
> > > Why?  Did you assign a sensible fixed PLL rate in DT?
> >
> > Whatever was in imx8mp.dtsi does not really work for all the panels.
> > Please keep in mind that the use case I have does not include only
> > 1920x1080 "standard" panels, but also other resolutions.
>
> It looks like you are still sticking to the idea of supporting all potent=
ially
> valid video modes by trying to find an "alternative" solution, while
> neglecting that the solution *could be* never working.
>
> >
> > > Can you please compare clk_summary output for the failing cases
> > > before and after this patch is applied? I assume that if you use
> > > the fixed PLL rate same to the rate which works before this patch is
> > > applied, the typical video modes still just work after this patch is
> > > applied.
> >
> > I'm afraid I do not need to support only typical video modes, but also
> > the other "atypical" modes.
>
> If the "alternative" solution doesn't work, we'll end up using the "fixed
> PLL rate" solution.  It that case, some video modes would be filtered
> out as a sacrifice.
>
> >
> > [...]
> >
> > >> One really nasty way I can think of is -- use find_node_by_compatibl=
e(),
> > >> look up all the relevant DT nodes, parse their clock properties, and
> > >> check whether they all point to the Video PLL or not.
> > >
> > > That's nasty.  It looks even more nasty when considering the fact tha=
t
> > > i.MX93 LCDIF is also driven by imx-lcdif DRM while only i.MX8MP LCDIF
> > > needs the nasty check, because i.MX93 SoC embeds only one LCDIF.
> >
> > The check can be skipped based on compatible string.
> >
> > I agree it is nasty, but it is a start. Are there better ideas ?
>
> No good idea from me.
>
> >
> > >> Maybe the clock subsystem has a better way, like list "neighbor"
> > >> consumers of some specific parent clock or something like that.
> > >
> > > What will imx-lcdif DRM look like by using this way? Get the ancestor=
 PLL
> > > clock of pixel clock(media_disp{1,2}_pix_root_clk), list all child cl=
ocks
> > > (media_disp1_pix and/or media_disp2_pix + other possible clocks) of t=
he
> > > PLL clock in a string array and find media_disp1_pix + media_disp2_pi=
x
> > > in it?
> > >
> > > Doesn't look nice, either.
> >
> > One other option came to my mind -- place a virtual clock between the
> > Video PLL and consumers (LCDIF1/2/LDB), and then have the virtual clock
> > driver do the clock rate negotiation in some .round_rate callback. That
> > is also nasty, but it is another idea. If there is a clock specifically
> > implemented to negotiate best upstream clock rate for all of its
> > consumers, and it is aware of the consumer behavior details and
> > requirements, maybe that could work ?
>
> A mighty virtual clock?  I'm not sure if that would work or not.

From a power-consumption perspective, it seems to me like running the
clocks at the lowest value instead of setting a really high rate which
divides down would save power.

adam
>
> >
> > >> [...]
> > >>
> > >>>> Can something like (*) above be implemented instead, so both Share=
d
> > >> and
> > >>>> separate PLLs would be supported ? That should solve both of our u=
se
> > >>>> cases, right ?
> > >>>
> > >>> I don't see any clear way to implement something like(*).
> > >>>
> > >>> Take the 3 i.MX8MP LCDIFs as one graphic card driven by one imx-lcd=
if
> > >>> DRM instance?  Would it be too intrusive?
> > >>
> > >> Yes, and I think unnecessary, one can simply traverse and parse the =
DT
> > >> to determine the clock assignment?
> > >
> > > Yes, people can traverse and parse DT, but it's nasty.
> > >
> > > In addition, one may argue that now that CLK_SET_RATE_PARENT flag
> > > is set for the pixel clocks, all potential video modes read from EDID
> > > should be supported when only either LVDS display pipeline or MIPI DS=
I
> > > display pipeline is active in the shared PLL case.  This requires one
> > > single DRM instance to detect single or dual active display pipelines
> > > dynamically, hence this single DRM instance becomes necessary.
> >
> > Would single virtual clock which do the frequency negotiation between
> > multiple DRM consumers work too ?
>
> Not sure if it would work or not, but I'm sure that one single DRM instan=
ce
> means atomic check/commit for the display pipelines as a whole, hence
> awareness of active display pipeline number in an atomic way.
>
> >
> > I do not have much to add to the points below.
>
> Regards,
> Liu Ying


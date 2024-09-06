Return-Path: <linux-kernel+bounces-318407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B8096ED4F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2418EB24088
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430A515667E;
	Fri,  6 Sep 2024 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="s/uadl+4"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DA4153835;
	Fri,  6 Sep 2024 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725610434; cv=none; b=ns74hPP3tOT8wqey8lMWQWAJWO55Sb1Om4KC7N9aoY3JOxsy2vms4OMB9DJWKOr2zldQXdBNrERrlhnTVewvPBLp+t8auLW0OBHR57bdIVxRQeXyIP28WtBRK+CjLuR6t98VWYW0ZZJkMUhblXnq+y1NUF/9J+1LqUvqJlkZOf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725610434; c=relaxed/simple;
	bh=VOxkkh/5u3ECueYG8Sem1GcFqEzK/WKjY98n7yggqxg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G33Bm4Wg2enotQ7nV+OEedwkM52uJLpzN8QRmvj2/wkMtc0suDOSqL9svywcb5MbfNLa04rtI+RLyqEiiZYn9XGm3mBD72zNoQvGHkIxjEJiiMZD9MpAnej2ZDDCTVFmQ71gId7aywyc/ryH0H0SmGb78sXnpR8gPrk7T07gO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=s/uadl+4; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1725610424; x=1725869624;
	bh=4WkEZvOd1NHE2AYSSsvpts7kEp2V8Fr8yZ7Qxca0NXs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=s/uadl+4+mu1lDOkKdYEs3hFyGj7HXEyd3fYECKC54FKuMFdTKqUy783XpnbCTigF
	 +ZiZYN+3nEpVPKgQct6tMyorJ0bzXTon4JCQyObP6OQSlrOXaMVSTxHYTqPeOsgycx
	 HfQ3pfbPGGABhsFBAcpo1Kwcz0ifDbd0IIanwxq5TuCOchtgBPgaDrhCViwILa4R3D
	 9ejwkb9DRF+7PpjMLQUz6cAynUQXVSzIzLLXSicxe6dToJB2//7ypVLkt5FUix/7wt
	 eJlYTGSe02COOUewbnF9CLf1ywRznqU4PuHkEsUY3IV6mbQ+cd1aqK20XKO2zSwA0e
	 wz/45aGmIq3lA==
Date: Fri, 06 Sep 2024 08:13:35 +0000
To: Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] clk: clocking-wizard: move dynamic reconfig setup behind flag
Message-ID: <D3Z1U6IHATAI.2Z2L37F10HOSE@protonmail.com>
In-Reply-To: <0161bb1640489c7a677ac26967b65ee1.sboyd@kernel.org>
References: <20240831111056.3864-1-hpausten@protonmail.com> <20240831111056.3864-7-hpausten@protonmail.com> <0161bb1640489c7a677ac26967b65ee1.sboyd@kernel.org>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: b241db668ae37d8b33bab20ad447cb114d9a75e1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Sep 5, 2024 at 8:06 PM BST, Stephen Boyd wrote:
> Quoting Harry Austen (2024-08-31 04:13:26)
> > diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/x=
ilinx/clk-xlnx-clock-wizard.c
> > index 1a65a7d153c35..967eacc28050d 100644
> > --- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> > +++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
> > @@ -1146,20 +1146,6 @@ static int clk_wzrd_probe(struct platform_device=
 *pdev)
> >         if (IS_ERR(clk_wzrd->base))
> >                 return PTR_ERR(clk_wzrd->base);
> >
> > -       ret =3D of_property_read_u32(np, "xlnx,speed-grade", &clk_wzrd-=
>speed_grade);
> > -       if (!ret) {
> > -               if (clk_wzrd->speed_grade < 1 || clk_wzrd->speed_grade =
> 3) {
> > -                       dev_warn(&pdev->dev, "invalid speed grade '%d'\=
n",
> > -                                clk_wzrd->speed_grade);
> > -                       clk_wzrd->speed_grade =3D 0;
> > -               }
> > -       }
> > -
> > -       clk_wzrd->clk_in1 =3D devm_clk_get(&pdev->dev, "clk_in1");
> > -       if (IS_ERR(clk_wzrd->clk_in1))
> > -               return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->clk_=
in1),
> > -                                    "clk_in1 not found\n");
> > -
> >         clk_wzrd->axi_clk =3D devm_clk_get_enabled(&pdev->dev, "s_axi_a=
clk");
> >         if (IS_ERR(clk_wzrd->axi_clk))
> >                 return dev_err_probe(&pdev->dev, PTR_ERR(clk_wzrd->axi_=
clk),
> > @@ -1170,31 +1156,48 @@ static int clk_wzrd_probe(struct platform_devic=
e *pdev)
> >                 return -EINVAL;
> >         }
> >
> > -       ret =3D clk_wzrd_register_output_clocks(&pdev->dev, nr_outputs)=
;
> > -       if (ret)
> > -               return ret;
> > -
> > -       clk_wzrd->clk_data.num =3D nr_outputs;
> > -       ret =3D devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onece=
ll_get, &clk_wzrd->clk_data);
> > -       if (ret) {
> > -               dev_err(&pdev->dev, "unable to register clock provider\=
n");
> > -               return ret;
> > -       }
> > +       if (of_property_read_bool(np, "xlnx,dynamic-reconfig")) {
>
> Is this going to break the existing DTBs? Before the property existed,
> the driver seems to have always tried to read xlnx,speed-grade and then
> setup a notifier, etc. Why would xlnx,speed-grade be set if
> xlnx,dynamic-reconfig wasn't set?

I did wonder about this. What is the kernel's policy on breaking DT ABI?
Especially in this case where there are no such DTs in the kernel source
tree (AMD/Xilinx have their own tools for devicetree generation, e.g. see
the clocking wizard DT node generation TCL script on GitHub [1]). Agree it
would be better to maintain compatibility with existing DTs if it makes
sense to do so though.

In terms of speed grade, as you say it currently only affects how you
would want to interact with the dynamic reconfiguration registers. But
that's not to say that it might be relevant to some other register added in
future (since it is just a generic property of the chip). So using presence
of the xlnx,speed-grade property to indicate dynamic reconfiguration
enablement feels like potentially a bad idea as well.

>
> The binding has implicitly had xlnx,dynamic-reconfig set before this
> patch, and we should strive to maintain that. Perhaps the property
> should be inverted, i.e. xlnx,static-config, and the absence of that
> property can imply the reconfig property.

I don't mind this. A bit of a shame that it's then inverted to how the IP
core is configured through Vivado, but that's not the end of the world.
Unless anyone can think of a better idea, will probably go with this in v2
of this patchset.

Thanks for the review!
Harry

[1]: https://github.com/Xilinx/device-tree-xlnx/blob/master/axi_clk_wiz/dat=
a/axi_clk_wiz.tcl



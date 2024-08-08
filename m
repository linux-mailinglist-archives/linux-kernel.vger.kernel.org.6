Return-Path: <linux-kernel+bounces-278928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60C94B6B8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C5DB21CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A080518784A;
	Thu,  8 Aug 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="iBVcMKBa"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB213210D;
	Thu,  8 Aug 2024 06:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723098616; cv=none; b=Xtk1szLQoEr6HmsApGuYRBskN8/DOKZTey4YXEBUVVewhRq30qJ9R03/kAepWyYa7SLhaW7Bew7CTasRfEA2fyoz9VRMEOGZv+ZS4mkojirx3iMS8vCNqWrYUohvxZFXcBREyYVzZ1I9jdzOVUcdCXUDTrj3ps57v+XCVYHTY1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723098616; c=relaxed/simple;
	bh=UrP8iw0OE7ogizelKeOi79Ygj7z+NMcZ7H7fIroCT84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuGoH4QRmRWv75yJdbybioHec4V0nHZ09hRmiJ7US+ft2n+Sy0QRjA1VInVMJeQ/tmhzN0BwUMcETjzZK22iSKABbspKyxDxskfJv2LJZevTgsNLNzsQPNJ82S4aHiz2ARTi6G8JnVnAspUnjhfCOBrkmKL0r4+we835uJyGvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=iBVcMKBa; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 97E5120ABE;
	Thu,  8 Aug 2024 08:30:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1723098608;
	bh=5IUmp9SbumUTBdk7rCppjKdGf3em04Bl1X4xrMO93e0=;
	h=Received:From:To:Subject;
	b=iBVcMKBa4ggso/z5Cf2H/K0tiNayQx43y1VZn6uF0qa2r4nmdtieG9b3dmVe4UShW
	 7YGKZnCJE8CzqPL3D84rV/DMR7NeLHZyzud7UGY36qxwlx/TL0iyBSW9xdlocBZ8wS
	 l9+cNYEw9pvcwsSoUEDDbMgaPLdbtxfuf41/gB1r5Rdcrtcsy93BOIse67ju0l+8S6
	 Ehji1G2XM3sdw5rmxhSbKuNjMCYAQdr/YF3YybBzXIOcUWbFdiiRt5S6jJ/plWKPb1
	 2jXYyusmYwtWWET5E/LDwFDIGoSydAVvffCJR52DYPEefgBSbODP58hWERGgZw8rKo
	 cjmVO/RFmq71Q==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id 32CB77F911; Thu,  8 Aug 2024 08:30:08 +0200 (CEST)
Date: Thu, 8 Aug 2024 08:30:08 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.li@nxp.com>
Cc: Rafael Beims <rafael@beims.me>,
	Francesco Dolcini <francesco@dolcini.it>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rafael.beims@toradex.com
Subject: Re: [PATCH v1 4/4] arm64: dts: imx8-ss-conn: add PPS channel to the
 FEC nodes
Message-ID: <ZrRl8NwPx8i6H59Y@gaggiata.pivistrello.it>
References: <20240807144349.297342-1-francesco@dolcini.it>
 <20240807144349.297342-5-francesco@dolcini.it>
 <ZrOUGLJPYC/K4MlP@lizhi-Precision-Tower-5810>
 <20240807175148.GA299582@francesco-nb>
 <ee39f8ce-683d-4144-909a-972ce74b95d8@beims.me>
 <ZrPYOWA3FESx197L@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrPYOWA3FESx197L@lizhi-Precision-Tower-5810>

Hello Frank,

On Wed, Aug 07, 2024 at 04:25:29PM -0400, Frank Li wrote:
> On Wed, Aug 07, 2024 at 04:48:19PM -0300, Rafael Beims wrote:
> > On 07/08/2024 14:51, Francesco Dolcini wrote:
> > > On Wed, Aug 07, 2024 at 11:34:48AM -0400, Frank Li wrote:
> > > > On Wed, Aug 07, 2024 at 04:43:49PM +0200, Francesco Dolcini wrote:
> > > > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > >
> > > > > On i.MX8 the FEC PPS channel is routed to the instance 1, not to the
> > > > > default 0.
> > > > According to my understand, it should be board level configuration. FEC
> > > > support output pps to any one. choose which one by board design.
> > > This seems different from the information we got from NXP some time ago,
> > > unfortunately this was happening over some private email exchange and
> > > not documented anywhere public. But the message was about SoC internal
> > > routing, not something at the board level, at least for i.MX8 SoCs that
> > > is what this patch is changing.
> > >
> > > For example to use PPS on i.MX8QXP we need to have this
> > >
> > > IMX8QM_ENET0_REFCLK_125M_25M_CONN_ENET0_PPS 0x06000020
> > >
> > > pinctrl configuration _and_ use PPS channel 1. Same is for i.MX8QP.
> > >

...

> > We have received the information from NXP support that the iMX8X only
> > supports channel 1. Here's the link of the public question I asked:
> >
> > https://community.nxp.com/t5/i-MX-Processors/IMX8X-PPS-output-configuration/m-p/1552154
> >
> > Unfortunately, the response came directly to my e-mail address with no
> > public update, but you can probably check the internal support case number
> > 00500877.

...

> 
> I checked some documents. channel0 route to internal eDMA as dma-request.
> If some boards use it as AVB/MCR. it should be set to 0. If need route
> out chip, it should use channel 1 as pps.
> 
> So I prefer put it into board level files for difference user case.

Fine for me and thanks for looking into this topic.

Let's drop this patch, we'll take care of having the property in the
appropriate board file.

Francesco



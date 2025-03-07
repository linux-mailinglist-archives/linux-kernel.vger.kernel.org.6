Return-Path: <linux-kernel+bounces-550135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AADA55BB2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9983ABEF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFCC63CF;
	Fri,  7 Mar 2025 00:18:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F454C96;
	Fri,  7 Mar 2025 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306694; cv=none; b=dghZ3Yy9ceMnklgBJ3rV/QcOLMQH/JBkf5LBon5iWxLL3k0sBIBaefqIbgujJTDcasw/I+My9DDOO8JBmZoBuTOx8Mey2AH6tnKrfiBYsFZjoDN/kuSJDiwM/2CycC9J3TsaAXMJTkooX0of7EWBLBbrySiq4Qq0nMQUjUzxxog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306694; c=relaxed/simple;
	bh=dejDcuU9K1sv2fPwxhDRh16lZKxCSGyYQuKNHFNnAlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PuOJAKFaqFu5HeNx3L+chAEGEo84ksSA8ibZMs+RB6Ys8BkHS59U8DvdX7X5eWOq5+HR/U37iK2C0mJplLgcCFNwLtcIawG4ETqupSnGPlyO3UgykVP1Zm07ppMa6b/xknkXdlr76yUJs6fG7a9FjBGYl2vDjw52Qxnq3gExIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB1A1169E;
	Thu,  6 Mar 2025 16:18:24 -0800 (PST)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 299A83F673;
	Thu,  6 Mar 2025 16:18:10 -0800 (PST)
Date: Fri, 7 Mar 2025 00:18:03 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Samuel Holland <samuel@sholland.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] clk: sunxi-ng: Add support for update bit
Message-ID: <20250307001803.2e4887d7@minigeek.lan>
In-Reply-To: <3616088.iIbC2pHGDl@jernej-laptop>
References: <20250304012805.28594-1-andre.przywara@arm.com>
	<20250304012805.28594-4-andre.przywara@arm.com>
	<3616088.iIbC2pHGDl@jernej-laptop>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 04 Mar 2025 16:28:48 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

Hi,

> Dne torek, 4. marec 2025 ob 02:27:53 Srednjeevropski standardni =C4=8Das =
je Andre Przywara napisal(a):
> > Some clocks in the Allwinner A523 SoC contain an "update bit" (bit 27),
> > which must be set to apply any register changes, namely the mux
> > selector, the divider and the gate bit.
> >=20
> > Add a new CCU feature bit to mark those clocks, and set bit 27 whenever
> > we are applying any changes.
> >=20
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  drivers/clk/sunxi-ng/ccu_common.h | 4 ++++
> >  drivers/clk/sunxi-ng/ccu_div.c    | 2 ++
> >  drivers/clk/sunxi-ng/ccu_gate.c   | 4 ++++
> >  drivers/clk/sunxi-ng/ccu_mux.c    | 2 ++
> >  4 files changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/c=
cu_common.h
> > index 50fd268329671..d41d33bdff470 100644
> > --- a/drivers/clk/sunxi-ng/ccu_common.h
> > +++ b/drivers/clk/sunxi-ng/ccu_common.h
> > @@ -20,10 +20,14 @@
> >  #define CCU_FEATURE_KEY_FIELD		BIT(8)
> >  #define CCU_FEATURE_CLOSEST_RATE	BIT(9)
> >  #define CCU_FEATURE_DUAL_DIV		BIT(10)
> > +#define CCU_FEATURE_UPDATE_BIT27	BIT(11) =20
>=20
> There is no reason to have "BIT27" in the name of the macro. This is simi=
lar
> to KEY_FIELD, which is generic name and doesn't specify either key or pos=
ition
> of this key field. Maybe just CCU_FEATURE_UPDATE_BIT or something equaly
> generic.

Sure, done. This was mostly in anticipation of the typical Allwinner
behaviour of introducing another update bit at a different location in
the future. But I guess we use a bitmask should that happen.

> With that fixed:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Many thanks!

Cheers,
Andre

>=20
> Best regards,
> Jernej
>=20
> > =20
> >  /* MMC timing mode switch bit */
> >  #define CCU_MMC_NEW_TIMING_MODE		BIT(30)
> > =20
> > +/* Some clocks need this bit to actually apply register changes */
> > +#define CCU_SUNXI_UPDATE_BIT		BIT(27)
> > +
> >  struct device_node;
> > =20
> >  struct ccu_common {
> > diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_=
div.c
> > index 7f4691f09e01f..2d8b98fe4b13a 100644
> > --- a/drivers/clk/sunxi-ng/ccu_div.c
> > +++ b/drivers/clk/sunxi-ng/ccu_div.c
> > @@ -106,6 +106,8 @@ static int ccu_div_set_rate(struct clk_hw *hw, unsi=
gned long rate,
> > =20
> >  	reg =3D readl(cd->common.base + cd->common.reg);
> >  	reg &=3D ~GENMASK(cd->div.width + cd->div.shift - 1, cd->div.shift);
> > +	if (cd->common.features & CCU_FEATURE_UPDATE_BIT27)
> > +		reg |=3D CCU_SUNXI_UPDATE_BIT;
> > =20
> >  	writel(reg | (val << cd->div.shift),
> >  	       cd->common.base + cd->common.reg);
> > diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu=
_gate.c
> > index ac52fd6bff677..0490f95781361 100644
> > --- a/drivers/clk/sunxi-ng/ccu_gate.c
> > +++ b/drivers/clk/sunxi-ng/ccu_gate.c
> > @@ -20,6 +20,8 @@ void ccu_gate_helper_disable(struct ccu_common *commo=
n, u32 gate)
> >  	spin_lock_irqsave(common->lock, flags);
> > =20
> >  	reg =3D readl(common->base + common->reg);
> > +	if (common->features & CCU_FEATURE_UPDATE_BIT27)
> > +		reg |=3D CCU_SUNXI_UPDATE_BIT;
> >  	writel(reg & ~gate, common->base + common->reg);
> > =20
> >  	spin_unlock_irqrestore(common->lock, flags);
> > @@ -44,6 +46,8 @@ int ccu_gate_helper_enable(struct ccu_common *common,=
 u32 gate)
> >  	spin_lock_irqsave(common->lock, flags);
> > =20
> >  	reg =3D readl(common->base + common->reg);
> > +	if (common->features & CCU_FEATURE_UPDATE_BIT27)
> > +		reg |=3D CCU_SUNXI_UPDATE_BIT;
> >  	writel(reg | gate, common->base + common->reg);
> > =20
> >  	spin_unlock_irqrestore(common->lock, flags);
> > diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_=
mux.c
> > index d7ffbdeee9e04..82ee21e0d3a68 100644
> > --- a/drivers/clk/sunxi-ng/ccu_mux.c
> > +++ b/drivers/clk/sunxi-ng/ccu_mux.c
> > @@ -197,6 +197,8 @@ int ccu_mux_helper_set_parent(struct ccu_common *co=
mmon,
> >  	/* The key field always reads as zero. */
> >  	if (common->features & CCU_FEATURE_KEY_FIELD)
> >  		reg |=3D CCU_MUX_KEY_VALUE;
> > +	if (common->features & CCU_FEATURE_UPDATE_BIT27)
> > +		reg |=3D CCU_SUNXI_UPDATE_BIT;
> > =20
> >  	reg &=3D ~GENMASK(cm->width + cm->shift - 1, cm->shift);
> >  	writel(reg | (index << cm->shift), common->base + common->reg);
> >  =20
>=20
>=20
>=20
>=20
>=20



Return-Path: <linux-kernel+bounces-322666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3AE972C08
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D977287FE9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60717BEAE;
	Tue, 10 Sep 2024 08:20:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FC14F9D4
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725956457; cv=none; b=O3gMIVP0yzqtATT8qjmQchRx+tGSc3dOadUr0WmZwcU8ulTmY6/lQy2mMTuQERgKHSeANCdfhpi8eHN9tsy4oSXCFT7RGZvG1EOydJM6ZAsKCHSdISJbm9LR5WuhK62COPNFHq15xvn4+XLR1TAC60mNcfHCD3HJEmHV/ieSiVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725956457; c=relaxed/simple;
	bh=UJ2pcOHuKDDqRC0DWUDoeqFHlPldK8XY4w5VdCUuqCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pxM95fY/O9r7F1cKEwulKo5o2yugKGB0zFPuNyw9pfE72+GDbZRKEZHeL1G2SczOdyoDpCAZ1DDYMmXkbGNpPh6DEM280QPi3YMnft7Avm2XIUGtWN1filVQjdrA3IDAJq08YMQEBibgfM6lykLuoaoMUqmE44MA3ipeZEYWJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1snw7C-00044f-3W; Tue, 10 Sep 2024 10:20:46 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1snw7A-006qsq-WA; Tue, 10 Sep 2024 10:20:45 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1snw7A-0001qu-32;
	Tue, 10 Sep 2024 10:20:44 +0200
Message-ID: <86eebdd7435ec1dc09765f4c4f8cb5ba8d20d785.camel@pengutronix.de>
Subject: Re: [PATCH v4 1/9] reset: amlogic: convert driver to regmap
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Jiucheng Xu
 <jiucheng.xu@amlogic.com>, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Sep 2024 10:20:44 +0200
In-Reply-To: <1jfrqcrgab.fsf@starbuckisacylon.baylibre.com>
References: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
	 <20240906-meson-rst-aux-v4-1-08824c3d108b@baylibre.com>
	 <984d928a37b3db11ae53c07da672ccae0d79734f.camel@pengutronix.de>
	 <1jfrqcrgab.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fr, 2024-09-06 at 16:46 +0200, Jerome Brunet wrote:
> On Fri 06 Sep 2024 at 16:19, Philipp Zabel <p.zabel@pengutronix.de> wrote=
:
> > On Fr, 2024-09-06 at 15:34 +0200, Jerome Brunet wrote:
[...]
> > > +static void meson_reset_offset_and_bit(struct meson_reset *data,
> > > +				       unsigned long id,
> > > +				       unsigned int *offset,
> > > +				       unsigned int *bit)
> > > +{
> > > +	unsigned int stride =3D regmap_get_reg_stride(data->map);
> >=20
> > You know this is always 4. Having a #define for this (that is also used
> > to initialize regmap_config.reg_stride, and for now nr_resets, below)
> > instead of going through an exported function would allow the compiler
> > to optimize this all away:
>=20
> Yes, for now. However, with the auxiliary you may get a regmap with
> different value. I've seen example with stride =3D 1.=20
>=20
> I'll admit is very unlikely but I does not really worth it considering
> how often we'll get through this and how difficult it will be to debug
> if stride ever get different.

Oh right, the aux regmap being passed in from the outside in a later
patch invalidates my point.

[...]
> > > @@ -48,25 +55,13 @@ static int meson_reset_level(struct reset_control=
ler_dev *rcdev,
> > >  {
> > >  	struct meson_reset *data =3D
> > >  		container_of(rcdev, struct meson_reset, rcdev);
> > > -	unsigned int bank =3D id / BITS_PER_REG;
> > > -	unsigned int offset =3D id % BITS_PER_REG;
> > > -	void __iomem *reg_addr;
> > > -	unsigned long flags;
> > > -	u32 reg;
> > > +	unsigned int offset, bit;
> > > =20
> > > -	reg_addr =3D data->reg_base + data->param->level_offset + (bank << =
2);
> > > +	meson_reset_offset_and_bit(data, id, &offset, &bit);
> > > +	offset +=3D data->param->level_offset;
> > > =20
> > > -	spin_lock_irqsave(&data->lock, flags);
> > > -
> > > -	reg =3D readl(reg_addr);
> > > -	if (assert)
> > > -		writel(reg & ~BIT(offset), reg_addr);
> > > -	else
> > > -		writel(reg | BIT(offset), reg_addr);
> > > -
> > > -	spin_unlock_irqrestore(&data->lock, flags);
> > > -
> > > -	return 0;
> > > +	return regmap_update_bits(data->map, offset,
> > > +				  BIT(bit), assert ? 0 : BIT(bit));
> >=20
> > Matter of taste, perhaps, but the BIT() could be moved into
> > meson_reset_offset_and_bit().
>=20
> It's not really related to this particular patch which is about moving
> to regmap.
>=20
> I can add it to another patch if you want

Either way is fine.


regards
Philipp



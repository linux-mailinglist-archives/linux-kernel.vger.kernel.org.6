Return-Path: <linux-kernel+bounces-237495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE52E9239AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7011828277E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368EA155307;
	Tue,  2 Jul 2024 09:19:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8C15359B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911969; cv=none; b=QTbciH243gq5uy514yqmcZLWxRaNiv9OV6IQWrFydT0vS1bM0Gc2Otk6KjnzpcnbldOWNwgVoXzNW3B3RussUBcN5W0ZBzuvanI+SKHr5HlewJJLBHMYrgVUrjzjP3PdLdGRRKyHonzzKEG7wvqTGyf66eO4YQJwDODmolGcEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911969; c=relaxed/simple;
	bh=cNHTFJ/n3QMWAVCGagrw8w6CJDEPeEFn4tz0HcbbJAw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ro4EhceDzNv07yWZowUc4wCfQ7VcGv4UtcVfwlaoH/JgaAC7eSntHHhiVt+u3OGUroqG+JRTKYdQwb6wlStXU/TEmjTkR2tjRdHZacS0fe9X6uNOLmi/PDj2XzXzrEpcy1hrkpAuxzP1WCVL9Ehw9hwufJ9xKTsuzuIkwklXoNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOZfR-0004nV-G7; Tue, 02 Jul 2024 11:19:17 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOZfQ-006Zmn-Sx; Tue, 02 Jul 2024 11:19:16 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOZfQ-0003wH-2l;
	Tue, 02 Jul 2024 11:19:16 +0200
Message-ID: <3fe74a3fc2747c8f9a3f433352720cfed76918ba.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] reset: eyeq: add platform driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: =?ISO-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, =?ISO-8859-1?Q?Gr=E9gory?=
 Clement <gregory.clement@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Date: Tue, 02 Jul 2024 11:19:16 +0200
In-Reply-To: <D2EC7KK40YX5.C3G1SM3FEDJO@bootlin.com>
References: <20240628-mbly-reset-v1-0-2a8294fd4392@bootlin.com>
	 <20240628-mbly-reset-v1-2-2a8294fd4392@bootlin.com>
	 <e9bfd8087ddef3d66f437719530df54a1f6529a4.camel@pengutronix.de>
	 <D2EC7KK40YX5.C3G1SM3FEDJO@bootlin.com>
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

Hi Th=C3=A9o,

On Mo, 2024-07-01 at 18:19 +0200, Th=C3=A9o Lebrun wrote:
[...]
> > Is there any benefit from per-domain mutexes over just a single mutex?
>=20
> Some domains can stay locked for pretty long in theory because of Logic
> built-in self-test (LBIST). This is the reasoning behind
> eqr_busy_wait_locked().
>=20
> Other domains are not concerned by this behavior.
>=20
> More concretely, on EyeQ5, SARCR and ACRP domains can lock their mutexes
> for a relatively long time, and for good reasons. We wouldn't want the
> PCIE domain  to suffer from that if it happens to (de)assert a reset at
> the same time.

Thank you for the explanation.

> >=20
> > > +	void __iomem			*base;
> > > +	const struct eqr_match_data	*data;
> > > +	struct reset_controller_dev	rcdev;
> > > +};
> > > +
> > > +#define rcdev_to_priv(rcdev) container_of(rcdev, struct eqr_private,=
 rcdev)
> >=20
> > Please use checkpatch --strict, and ideally mention when you ignore a
> > warning on purpose. In this case, the macro parameter should named
> > something else, because the last parameter to container_of must be
> > "rcdev" verbatim. This only works by accident because the passed
> > parameter also happens to be called called "rcdev" at all call sites.

Thinking about this again, it would be even better to turn this into a
static inline function instead.

> I have let this CHECK from `checkpatch --strict` slip through indeed.
> Other remaining messages, with explanations, are:
>=20
>  - WARNING: added, moved or deleted file(s), does MAINTAINERS need
>    updating?
>=20
>    This is done in a single patch [0] in the MIPS series to avoid
>    conflicts in between series.
>
>  - CHECK: struct mutex definition without comment
>=20
>    This is about the above mutexes field. Do you want a code comment
>    about the reasoning for one mutex per domain?

Yes, that would be nice. I'm not pedantic about the lock comments
because in reset drivers it's usually pretty obvious what the lock is
used for, but mentioning that the mutexes cover register read-modify-
write plus waiting for LBIST on some domains seems like a good idea.

[...]
> >=20
> > > +static void eqr_assert_locked(struct eqr_private *priv, u32 domain, =
u32 offset)
> > > +{
[...]
> > > +	case EQR_EYEQ6H_SARCR:
> > > +		val =3D readl(base + EQR_EYEQ6H_SARCR_RST_REQUEST);
> > > +		val &=3D ~BIT(offset);
> > > +		writel(val, base + EQR_EYEQ6H_SARCR_RST_REQUEST);
> > > +		writel(val, base + EQR_EYEQ6H_SARCR_CLK_REQUEST);
> >=20
> > This looks peculiar. Why is it ok to write the value read from
> > RST_REQUEST into CLK_REQUEST?
>=20
> What is abstracted away by the hardware on EyeQ5 is not anymore on
> EyeQ6H. Previously a single register was used for requests and a single
> register for status. Now there are two request registers and two status
> registers.
>=20
> Those registers *must be kept in sync*. The register name referencing
> clock is not to be confused with the clock driver of the
> system-controller. It is describing a register within the reset
> controller.
>=20
> This hardware interface is odd, I might add a comment?

Yes, please. With the knowledge that those registers must be kept in
sync, this goes from strange to obvious.


regards
Philipp


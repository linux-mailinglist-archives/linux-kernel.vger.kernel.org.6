Return-Path: <linux-kernel+bounces-408021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8B59C78FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04E91F233C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B84166302;
	Wed, 13 Nov 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KfSdl/4h"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE62309AF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731515807; cv=none; b=dBp6ZxRcbCVfykqWg1n93olLaG7xqyJ/xj+pG9VMM21QzJnZnj47621bpU38A03mGBFlLJWmJBTxtF1eTMANC1HI77IFQ5Ee9mgSH3oJzZm7bGELPIjjhd4zaYHSuxNAY9XbzKsSJTI8ebhA5w3vWHXZNbjNZyF8NtXCW1zgJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731515807; c=relaxed/simple;
	bh=zUjj2YpnzDQN+zgqbGvOnwDqKYJV9hCUkrBjPBwb5us=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9FhN/1VX8eDvg2+tvbXJGZbuNbI+6cNUP1ldyK6JRQIcOBW9o7RijISslJxYd70wwTFZtuNaXFLygIMKq6Y5FePFLwd6re3Hw29QkrAwwhMa4vQolSMReANF9e0H1uu+5y8IOuRxFwpCpq38YfZWih6bnW7Gx1Tt9SbjI0OdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KfSdl/4h; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73436FF809;
	Wed, 13 Nov 2024 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731515803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9J3J4DIjY1obcVq8dHIkKTxRy9zRbs7r5n6ckQhIHo=;
	b=KfSdl/4hyd3NVTVpjQb1fHlEmNH3DLzDPsOq33antFXkcOHpDXM4NYXz32QpejQApoGKdn
	RWfmZU1zhfGCU4o5JtPkhcTf1ISkWYUPCVjr+qO/uDOw5Kle9JPT2Ri2TEy7Muz9Ki6z0U
	iVDfIWWZhpdcz2Vsoj3zE6Zq8VRjiQYoa8fsdPU17VoGJqy22oLjOf5oNGskl5oKnt3jJP
	4yUmIBgPr6YK/FDGPNbBDM5rlUNMD8TNLBEwtYpAWbW0pTwr4c14bCShEiSWgs2SmV6MCY
	PGDRjfs/RcgKE5CFuSn5Kh2Dr9nCZEXXcOaBcv27hK8W62AOQ+Fnkq0IosVXTA==
Date: Wed, 13 Nov 2024 17:36:42 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: core: Fix resolve supply
Message-ID: <20241113173642.4d58645b@kmaincent-XPS-13-7390>
In-Reply-To: <ZzTOWoTT2to6aW5g@finisterre.sirena.org.uk>
References: <20241113153614.1755825-1-kory.maincent@bootlin.com>
	<ZzTOWoTT2to6aW5g@finisterre.sirena.org.uk>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 13 Nov 2024 16:05:46 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Nov 13, 2024 at 04:36:14PM +0100, Kory Maincent wrote:
>=20
> > The regulator should not use the device parent to resolve the regulator
> > supply. It fails to resolve the correct supply when the of_node
> > variable in the regulator_config structure is not within the parent
> > node. =20
>=20
> I can't understand what you are saying here at all.  What is "it", why
> and in what way does it fail and why would we expect it to succeed?  How
> does your proposed change fix whatever the issue is?  The DT binding is
> against the actual device, not the virtual device.  Please describe both
> the problem and the fix more specifically.

Sorry, I was not explicit enough.
=20
> > Fixes: 6261b06de565 ("regulator: Defer lookup of supply to regulator_ge=
t") =20
>=20
> >  static int regulator_resolve_supply(struct regulator_dev *rdev)
> >  {
> >  	struct regulator_dev *r;
> > -	struct device *dev =3D rdev->dev.parent;
> > +	struct device *dev =3D &rdev->dev; =20
>=20
> The rdev is a virtual device, it's not going to have any OF
> configuration

It does:
https://elixir.bootlin.com/linux/v6.11.7/source/drivers/regulator/core.c#L5=
687

My issue is that it does not look for the regulator supply in the OF node
described in the regulator_config structure:
https://elixir.bootlin.com/linux/v6.11.7/source/include/linux/regulator/dri=
ver.h#L445
It looks at the parent device OF node instead.

My use case is that a PSE controller have several PIs (Power Interface) whi=
ch
can have different regulator supply. A regulator device is registered for e=
ach
PIs. The OF node used by the regulator core to lookup for the regulator sup=
ply
is the PSE controller node and its children instead of the node of the PI w=
hich
is described by the regulator_config->of_node.

> , and given that prior to the refactoring in the commit
> you're referencing in the Fixes: we were using the struct device passed
> into regulator_register() which should be the same device as we're using
> here so if there is an issue it doesn't look like it was introduced in
> the refactoring.  What makes you believe that there is an issue in htat
> commit?

Yes you are right I looked at it too quickly sorry.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


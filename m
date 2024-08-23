Return-Path: <linux-kernel+bounces-299249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C35095D1FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D28283A09
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131FC18A6DD;
	Fri, 23 Aug 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J3KKWS89"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D364D1891A3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428051; cv=none; b=peYg3R0zQSSaasHo6E/z8BbGh0oQW+fJnhKJUr8WDfLhe7HjUIRZHmBV0jpK8yk4EgTqMxlql365EJwIe+dRszEqwe9uEs08r8keXLwtaL9ElliBnKSiiWY5/Ruk1d6TKZiAfNFLScU7tE5qUBCqDLhaLmopIG3tCGm18yMOT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428051; c=relaxed/simple;
	bh=hrg4hVQrndpw3oGz1xvPgnkFZbLHiLgZXqYuBQVdKsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tu5nhFnHVcJggqFlUOrbXqgXnw01Ock1zrp9bzwvWsjtWMbSkHVQQIXBVEuKN/Ai8KVSjhFidxtoGDSJt6WjYo//7mLhthh5ZZtnmvpWhYX9PdvGE3bs02JvXOwc6ujcVSeQ4DvunNYCULSRS8xOEEf4AaIpy5SJ+VfBnT8wpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J3KKWS89; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 155B660002;
	Fri, 23 Aug 2024 15:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724428046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXndtgjyosFUz5tRo1q1Sp82wNsQ66T54+uokgzMrmw=;
	b=J3KKWS890Sw1Rr0I9uXcVa2bcZZan9r5EUU57pG2hUPzLr/AwG7/uag2eNrx4+xnFqvfGy
	FoqR6bqNgEun8vtEre4vlcR+h0hurkw76+Ez4Kn+SrhM/OQehTLljVsNUTfviuLa4kyCbC
	JC/7lu2zBC/GadRtcdhhcOCmMValC/9m/auoRd/YbeI0RCz/4HniM4Z4g7T4MdQ8l29x5K
	bLpd3fZCI80pgViNrPxSnoasO3TJMlHJTwZ2ODQOe/jX8mf7rV+P9Mf4nOAnnSWE8xF6Sj
	a9ntcjSVBcll4s5pCobDvBjP87BzH4SFiODEyp3YY6x3rLn2sORNuToXx11qkQ==
Date: Fri, 23 Aug 2024 17:47:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maxim Anisimov <maxim.anisimov.ua@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Martin Kurbanov <mmkurbanov@salutedevices.com>, Michael
 Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>, "Chia-Lin Kao
 (AceLan)" <acelan.kao@canonical.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: spinand: Add support for HeYangTek HYF1GQ4UDACAE
Message-ID: <20240823174723.403a3342@xps-13>
In-Reply-To: <3d14b0c8-3c25-4a9a-b84a-192f071fa919@gmail.com>
References: <20240624061246.5292-1-maxim.anisimov.ua@gmail.com>
	<20240701095906.2bc4a0d2@xps-13>
	<3d14b0c8-3c25-4a9a-b84a-192f071fa919@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Maxim,

maxim.anisimov.ua@gmail.com wrote on Mon, 22 Jul 2024 09:54:55 +0300:

> Hi Miquel,
>=20
> Sorry for late answer. I was on vocation. To be honest, I don't understan=
d very well how this works. One of the OpenWrt developers asked me to send =
this patch to Linux upstream. Related OpenWrt pull request is here https://=
github.com/openwrt/openwrt/pull/15551 . Originally this patch code was take=
n from the device manufacturer's repository https://github.com/keenetic/ker=
nel-49/commit/bacade569fb12bc0ad31ba09bca9b890118fbca7 . I pointed to this =
in the source code. From my side I only adapted the code for successful com=
pilation on the Linux upstream. It's difficult for me to answer your questi=
ons because I don't understand how the spi nand framework works. I can make=
 corrections in the patch but with outside help. Thanks!

I'm sorry I cannot write the changes for you, but I can explain my
point below.

> >> +static int hyfxgq4uda_ooblayout_ecc(struct mtd_info *mtd, int section,
> >> +				   struct mtd_oob_region *region)
> >> +{
> >> +	if (section > 3)
> >> +		return -ERANGE;
> >> +
> >> +	region->offset =3D section * 16 + 8;
> >> +	region->length =3D 8; =20
> > This is: 8-15, 24-31, 40-47, 56-62
> > =20
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int hyfxgq4uda_ooblayout_free(struct mtd_info *mtd, int sectio=
n,
> >> +				   struct mtd_oob_region *region)
> >> +{
> >> +	if (section > 3)
> >> +		return -ERANGE;
> >> +
> >> +	/* ECC-protected user meta-data */
> >> +	region->offset =3D section * 16 + 4;
> >> +	region->length =3D 4; =20
> > This is: 4-7, 20-23, 32-35, 48-51
> >
> > So what about 2-4, 16-19, 36-39, 52-55, 63-64 ?

The OOB area is a specific area where we store:
- the bad block marker: it is at offset 0 and 1 and must be excluded
  from both functions.
- ECC bytes, so data for the correction engine: the amount depend on
  the strength of your correction and the position depends on the
  hardware. If this is not told in the datasheet explicitly you can
  play with flash_erase/nandwrite/nanddump: you can write a known
  pattern to an OOB area with the ECC engine enabled and you'll see
  what bytes have been smashed by the ECC engine.
- the rest is user data (typically jffs2 metadata).

In the current implementation, some bytes are just undefined, which is
not expected.

> > =20
> >> +
> >> +	return 0;
> >> +}

...

> >> +static int hyfxgq4uda_ecc_get_status(struct spinand_device *spinand,
> >> +				     u8 status)
> >> +{
> >> +	struct nand_device *nand =3D spinand_to_nand(spinand);
> >> +
> >> +	switch (status & STATUS_ECC_MASK) {
> >> +	case STATUS_ECC_NO_BITFLIPS:
> >> +		return 0;
> >> +
> >> +	case STATUS_ECC_UNCOR_ERROR:
> >> +		return -EBADMSG;
> >> +
> >> +	case STATUS_ECC_HAS_BITFLIPS:
> >> +		return nanddev_get_ecc_conf(nand)->strength >> 1; =20
> > Maybe an explanation of this line is needed. Is this just guessing or
> > is this defined in the datasheet?

The datasheet should tell you what this bit means. If it means some
bits have been corrected up to half of the strength capability, then
this is fine. But please make sure this is right by using nandbiterrs
-i from the mtd-utils test suite.

> > Also please do not use shifts when you want to divide. Just use / 2
> > which is easier to understand. Compilers know how to optimize that.

This is self explanatory.

Thanks,
Miqu=C3=A8l


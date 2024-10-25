Return-Path: <linux-kernel+bounces-381170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4559AFB86
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0468B238D4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACAA1C07E3;
	Fri, 25 Oct 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fVs95Oif"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEBD148FF3
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729842698; cv=none; b=bgv82/Apn8Gh9Z+mttGFYd37bdKLhxUVOsIlqBSdPf13CzByevowqRXLD764Op99QjeYpG9EGSxAv6OKLZwc1ked2rwYeLVjenuqYOaRpKNON1ZXfqnBbfOcxZa3TRSsRZxZGzzYTGZ8x6kC95/LivFhdhrNh7cldNFEQzJ7ODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729842698; c=relaxed/simple;
	bh=OIrWI3mf8YY8PWF/rxlF2DRIccOVG0e/3GcC6riWNyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NkUoNla+iiK0CWe2tL6ALwpSxLAAYkD2pKHW9EbOHuVpTYD4UVkISHJYNdJGl+mkxwGhZgfOr62rhY7fyuLNzLqwCeK0SUdGskjOxd7xEn5Sbf/tYxRWLle9vMSm0jzKDTw2cneN2DtsXgtptO66u2pQIq5UcrP4WCfp8zWKY3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fVs95Oif; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 912A8FF80D;
	Fri, 25 Oct 2024 07:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729842689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lVBAN1rymyK7VuzJCBezdwk3YLqFB+8QqAHMbWbVMzQ=;
	b=fVs95Oif8DrSyflXMHYkUki/Rlui8+E78aLn8keh625lEMmgyBGba4i3T/us5PHsa5AGNu
	9Bxx33pbY8kRodIQGdnD1xT8TCwcFNdCn4MLWhi5KO3hpT/WD/iJBJQ6EDGIdO+GMS78VY
	jgjHMJLeiKgp/x8mRhNpXjEM/Z/8dcyN64xfYxo7Gwt3OQJtBE9P50+pO9aC1aB6cvC4ih
	njsC60tStqSMI9HyZIFp7R/o8qvDVeSd7D7fxXgJlfr7/Yr1cRoEWxnbmIMW7mtm/x5ioq
	morJDsF1WC/ltE2HNUO6DsJigR0ImAMx8zvNLiHD0EBWV1+AQHA7Yv9+Cu1mpQ==
Date: Fri, 25 Oct 2024 09:51:24 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Michael Walle" <michael@walle.cc>, Mark Brown <broonie@kernel.org>,
 Chia-Lin Kao <acelan.kao@canonical.com>, Md Sadre Alam
 <quic_mdalam@quicinc.com>, "Ezra Buehler"
 <ezra.buehler@husqvarnagroup.com>, Sridharan S N <quic_sridsn@quicinc.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, Alexey Romanov
 <avromanov@salutedevices.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v2 4/5] mtd: spinand: micron: OTP access for
 MT29F2G01ABAGD
Message-ID: <20241025095124.0403bdd6@xps-13>
In-Reply-To: <de27927d-ce37-4c0f-85d0-e32bae3f0ef9@salutedevices.com>
References: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
	<20240827174920.316756-5-mmkurbanov@salutedevices.com>
	<20241001113108.4fdb6360@xps-13>
	<de27927d-ce37-4c0f-85d0-e32bae3f0ef9@salutedevices.com>
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

Hi Martin,

mmkurbanov@salutedevices.com wrote on Mon, 14 Oct 2024 15:48:46 +0300:

> Hi Miquel,
>=20
> On 10/1/24 12:31, Miquel Raynal wrote:
>=20
> >> +#define MICRON_MT29F2G01ABAGD_OTP_PAGES			12
> >> +#define MICRON_MT29F2G01ABAGD_OTP_PAGE_SIZE		2176 =20
> >=20
> > In the core we did add the data size and the OOB size to get the OTP
> > page size. I would prefer something dynamic here as well, otherwise the
> > implementation is very device specific for now reason? =20

						no

>=20
> Do you mean:
> otp_page_size =3D nanddev_page_size(nand) + nanddev_per_page_oobsize(nand)

Yes!

> >> +		size_t i =3D 0;
> >> +
> >> +		/* If all zeros, then the OTP area is locked. */
> >> +		while (i < buf_size && *(uint32_t *)(&buf[i]) =3D=3D 0)
> >> +			i +=3D 4; =20
> >=20
> > Shall we expect buf_size to always be a multiple of 4? (real question) =
=20
>=20
> This function is only for the nand flash MT29F2G01ABAGD that has a page
> size multiple of 4.

Ok.

Thanks,
Miqu=C3=A8l


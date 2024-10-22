Return-Path: <linux-kernel+bounces-375933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836F19A9D70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E40283928
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7024A18E34A;
	Tue, 22 Oct 2024 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QQhlXlUf"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9205A1547C0;
	Tue, 22 Oct 2024 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587074; cv=none; b=L8rmmb8cGNtMudPIebEMMb5CzhGBNHucjvasjE/nALBxYaGxqVcrqpX5uPpr98AAoqg7ZykkMDJPXFpLzI+3uPy+Fmsf7w9krl/JsmVbTWqPNbg1fc4FuL5wnyA2Wp0V4wIk9f0FaX0xNrmxaVFECUlLrHEsrI89ze+Zx/xyp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587074; c=relaxed/simple;
	bh=H70tjXXzl+cCSTX8UTZsYlwAbOEf4NTaF6zm0qX7zw8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJ/PF325Bk29cAQ56UYNPT1+KfXS0zVZ70ScG/C4FlN2ZIpo6ksQs/ldV8f7RGk4t5BpWisnOzNhNpfoQZw2+tMiLx4NWLbQI+N4PZsoofCtJhB01jecsfuyezmBZ2ExQ8eeOZqKTspCdo1/rhO2PLHepitnHqbV9IYiCcUAYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QQhlXlUf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF223E0002;
	Tue, 22 Oct 2024 08:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729587070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TQcS/K1EL6TJRmWoBCyGMGQnz1Ou/w2iE3xeVuMMr/M=;
	b=QQhlXlUfBbPRw4FrGNQz71LqTH9JBAfQIy+uGcFziA3YMgqQDrl+m8asJT6kfpW73K/W0O
	fanUjjjlf9L2zbV0OuuOej0RC5NHuUBS2qKzo59xmg7Fyg0ZP7ofg7PjgWe/Czep9io91f
	mzAJuRw8WVOVI+TRtNhRq3/0ucLb5d5p8oDAjoys8pUO+/XkHCZld1osg1mNNGhYn9MC41
	MJbjldOkZC1dOz+HIg+XmtIAEOILhhRkqz9Szqi/rf7pkHTWntnKxXtDYhXt53REg51NAc
	RVo+RiFKLRO5WBw1FX8jmusCCnFWEPo/xZzkT9gQx09x8dzXF5a/8/X95SUvSA==
Date: Tue, 22 Oct 2024 10:51:09 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
Message-ID: <20241022105109.1906f524@xps-13>
In-Reply-To: <9cfd923a-4bc8-4a6c-986d-8d0c6fd6d9bb@gmail.com>
References: <20241018022519.721914-1-hpchen0nvt@gmail.com>
	<20241018022519.721914-3-hpchen0nvt@gmail.com>
	<20241021103254.1f31205b@xps-13>
	<9cfd923a-4bc8-4a6c-986d-8d0c6fd6d9bb@gmail.com>
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

Hi Hui-Ping,

> >> +
> >> +static int ma35_nand_write_page_hwecc(struct nand_chip *chip, const u=
8 *buf,
> >> +				      int oob_required, int page)
> >> +{ =20
> > The hardware ECC engine should always be disabled by default.
> >
> > Then, in these helpers you should:
> > * enable the ECC engine
> > * do your things
> > * disable the ECC engine =20
>=20
> The ECC engine of the MA35 NAND controller cannot be turned on or off sep=
arately.
>=20
> The ECC engine is activated with the DMA,
>=20
> and it calculates and writes to the OOB during the transfer.

What about:

ECC Algorithm Enable Bit [23] ECCEN

	This field is used to select the ECC algorithm for data
	protecting. The BCH algorithm can correct 8 or 12 or 24 bits.
	0 =3D BCH code encode/decode Disabled.
	1 =3D BCH code encode/decode Enabled.

?

Thanks,
Miqu=C3=A8l


Return-Path: <linux-kernel+bounces-356490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F719961D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D719B289DA5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8118D1885B9;
	Wed,  9 Oct 2024 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CET+bD2a"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4F188586;
	Wed,  9 Oct 2024 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461096; cv=none; b=KXy3r2re+nmGIydNuB1ls7aaHOaper23B6UvX2HCTZKY8nk8n6i9OXkxcngfgUX4mMUoj/LNh2NMbsdfR1usBKXfWRMcNEymlBULNOsM7Tc2O/qAyYcBVht4XYtFdJxoP2SRWy96vpbsg9gzaNz5DNBgzomMaNJxD+JGjgAOy4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461096; c=relaxed/simple;
	bh=PIPJaYVqB/0I9J24VTXd1sy1f8DObF+DnZqOAqQWUuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkZMsqjO5mF5DxC2neFSm19e/SlHWUgr2TmRUG7H98meYiF/YabmgjGxkvYzJWkFWji25/gKLtE1O7bNb1kqd/3RW/anwKUSi1O/7T2LH6GVjjeSEXCt9tIprhRsaXLmuCnI73GjbGd3OeK2eE4yabwuxOUGHjRoW9bqy20wp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CET+bD2a; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D55AB240002;
	Wed,  9 Oct 2024 08:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728461092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZqUu2zXtpPIFf6u2ipPatyPzUjw/B5iwIYSh3KUBBk=;
	b=CET+bD2aQpIFbn83eKT+JAQlvpdrc0gESxRVHARr0UpzskXaayoxehxFYpeqV2I+pGYHf7
	xSvkBl7b89C/+0Gdk47ezTrP7u6qPBIGR5kwqsIzgc3ZKH3047DghYSSp6FbBjBZvoxqlu
	j6zm6Afpuenl/O0Lyd9lpC3DzF1Z91xyY1qE//1L7iEPG9apRogWNH7xuYpKJxsEJ0vFR8
	f7awQRGnelx1xTR53a07BHU3UMyrCGrqIJqTl366jh6Nmmxl0DzFyVPbWQkTKSy/mEAo4/
	0QUCeD6U6SN9pWklqIOJ4bFozd3MC1LJrrtFwXUpIuM/vk9XRWdRR6ANHh7WTg==
Date: Wed, 9 Oct 2024 10:04:50 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
Message-ID: <20241009100450.362e3556@xps-13>
In-Reply-To: <02098767-19ce-407e-88be-24c6259c4053@gmail.com>
References: <20240927020749.46791-1-hpchen0nvt@gmail.com>
	<20240927020749.46791-3-hpchen0nvt@gmail.com>
	<20241001215755.5c2f8465@xps-13>
	<8d5e7755-17fd-4860-bcb0-8c1de04bf0c5@gmail.com>
	<20241008105230.7fd25438@xps-13>
	<02098767-19ce-407e-88be-24c6259c4053@gmail.com>
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

> >>>> +		return 0;
> >>>> +	}
> >>>> +
> >>>> +	ma35_nand_dmac_init(nand);
> >>>> +
> >>>> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
> >>>> +
> >>>> +	/* setup and start DMA using dma_addr */
> >>>> +	dma_addr =3D dma_map_single(nand->dev, (void *)addr, len, DMA_FROM=
_DEVICE);
> >>>> +	ret =3D dma_mapping_error(nand->dev, dma_addr);
> >>>> +	if (ret) {
> >>>> +		dev_err(nand->dev, "dma mapping error\n");
> >>>> +		return -EINVAL;
> >>>> +	}
> >>>> +
> >>>> +	writel((unsigned long)dma_addr, nand->regs + MA35_NFI_REG_DMASA); =
=20
> >>> Please enforce a dma mask of 32 (even though it might be the fault). =
=20
> >> I will change it to dma_addr & 0xffffffff. =20
> > That's not what I mean, I believe you should use the dma API to ask for
> > a mapping within the accessible 32-bit address range. The
> > dma_mapping_error() check should return an error if that's not the
> > case. Then you can safely write the value. =20
>=20
> Here is my misunderstanding: just fill in the dma_addr directly,
>=20
> no type conversion is needed. I have already tested it.

FYI, it only works because the default DMA mask for your device is gonna
be 32 bits. If the reality (what your peripheral DMA can do) was
different than this, you would have to set a different mask explicitly
to make sure the dma-mapping step would not provide buffers which are
out of reach.

Thanks,
Miqu=C3=A8l


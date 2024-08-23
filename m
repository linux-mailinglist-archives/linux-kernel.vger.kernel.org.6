Return-Path: <linux-kernel+bounces-299252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5467795D203
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130CE282766
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E19188A03;
	Fri, 23 Aug 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m0QyDvc+"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECBE1EA84
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724428136; cv=none; b=uAhrsZbxWYJ0EMfC1jTyDfRAcsN7fKXoFw7Gwmpu+eqzruwDyD7Bzk62UvbFjIDC+/hm/f5vR2SVVjW+XPBGaIjBLWn7/ft0OSrgQTfFzvHtzZ+DQD3kdQndc73XC6CrHmKFXWzI0e774HcZiJpMXMGGoFhd+ZxUHJyTYYB3P5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724428136; c=relaxed/simple;
	bh=7nLEhF9MaKyI4Y7ySZZBKiTTvb8ZD3j/5COn+8C7aq8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV7OlFzmDpAjMLE4DJ5XTv3syLKAKf2f8NnAfm37aoWTA44UCNeSR1VeHQ2+syF63oN3w7zmrVQ0BMr9oWm2iYpCVRcM2/rWm2HxqBiDI63s3u+ryG91/uIRhI17lqmUcSlNc8uk5RSs663YpQCK10asF7bucjqvHBBcy70BKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m0QyDvc+; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0CEDC240003;
	Fri, 23 Aug 2024 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724428126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sgE3IvoWI1/Cp/dVJfgn+uI1PxAkHEore+ttPBMGxFA=;
	b=m0QyDvc+RQ5GMNzZExzQSKZ4FVpEep3AA5NJSkPLn+jl/hXzHQD49NngSMrdTrBe3g3Oea
	3sC0cT6u+Z4ibMaTsjU1yDdPaGCP+eOMv/YZWXuwFYmqPC5c39ZrGWAy+mhxK5v131iK8K
	M0UqU2+C7QoBxx2cVBnGaWGitZT5ugfhmX7Sk48MsQ3+VDsTsuN+7+6+ntiw9+jzWRVcI4
	ReW1qEMteOC0nbpob+K65Ax7dYubexYihPnWA7dFb1Rp0+V4RL4aD2uc6XCLRpZkeLBCJg
	QrFfDv2iFpsqnifeajXdnjKsyAWdj9wcrJ3JxwBiA76c7NQATLlosJ0q/b6++w==
Date: Fri, 23 Aug 2024 17:48:43 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 0/2] Add fixups for two-plane serial NAND flash
Message-ID: <20240823174843.6eec8053@xps-13>
In-Reply-To: <CAAyq3SazQFSU9C5Z5YURP9cFdc6gLNJfF2ReQ9Z_-GpzVWhoeQ@mail.gmail.com>
References: <20240718075356.488253-1-linchengming884@gmail.com>
	<20240812105630.2b71ed19@xps-13>
	<CAAyq3SazQFSU9C5Z5YURP9cFdc6gLNJfF2ReQ9Z_-GpzVWhoeQ@mail.gmail.com>
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

Hi Cheng,

linchengming884@gmail.com wrote on Tue, 13 Aug 2024 14:02:44 +0800:

> Hi Miquel,
>=20
> Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2024=E5=B9=B48=E6=9C=
=8812=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:56=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > Hi Cheng,
> >
> > linchengming884@gmail.com wrote on Thu, 18 Jul 2024 15:53:54 +0800:
> > =20
> > > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > >
> > > Macronix serial NAND flash with a two-plane structure
> > > requires insertion of Plane Select bit into the column
> > > address during the write_to_cache operation.
> > >
> > > Additionally, for MX35{U,F}2G14AC, insertion of Plane
> > > Select bit into the column address is required during
> > > the read_from_cache operation. =20
> >
> > I guess if the plane bit is needed for your chips, it is also needed
> > for other whips with two planes? Could it be possible that we never had
> > support for devices with more than one plane and you just fall into a
> > common issue? Maybe we should always add the plane information when
> > there is more than one plane to address? Can you check whether this is
> > specific to Macronix or not?
> > =20
>=20
> I have reviewed the chips listed by each vendor.
>=20
> Micron offers MT29F2G01AB{A,B}GD, MT29F2G01AAAED with two planes;
> however, only MT29F2G01AAAED requires the plane select bit when performing
> program load or read from cache.
>=20
> Link: https://semiconductors.es/pdf-down/M/T/2/MT29F2G01AAAED-MicronTechn=
ology.pdf
>=20
> Winbond provides W25N04KV with two planes, but it does not require the pl=
ane
> select bit for program load or cache read operations.
>=20
> Therefore, we should not always include the plane select bit when dealing=
 with
> multiple planes.
>=20
> > In this case we wouldn't need a specific fixup.
> > =20
>=20
> Based on the above perspective, do we still need to use fixup, or can we =
use
> flags to determine whether the plane select bit is necessary?

I still prefer flags rather than invasive fixup hooks.

>=20
> > >
> > > These flashes have been validated on Xilinx zynq-picozed
> > > board which included Macronix SPI Host.
> > >
> > > Cheng Ming Lin (2):
> > >   mtd: spinand: Add fixups for spinand
> > >   mtd: spinand: macronix: Fixups for Plane Select bit
> > >
> > >  drivers/mtd/nand/spi/core.c     |  7 ++++
> > >  drivers/mtd/nand/spi/macronix.c | 66 ++++++++++++++++++++++++++++++-=
--
> > >  include/linux/mtd/spinand.h     | 17 +++++++++
> > >  3 files changed, 84 insertions(+), 6 deletions(-)
> > > =20
> >
> >
> > Thanks,
> > Miqu=C3=A8l =20
>=20
> Thanks,
> ChengMing Lin


Thanks,
Miqu=C3=A8l


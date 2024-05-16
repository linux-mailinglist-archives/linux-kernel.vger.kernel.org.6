Return-Path: <linux-kernel+bounces-181075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39FE8C7732
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1EA1C22582
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BAD14D6ED;
	Thu, 16 May 2024 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M5r7Jr1r"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979E14D28A
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864729; cv=none; b=XL7heR5nIuOdMNurF0hkwSfx41ChFcNnWNKcQE/KUxgTR5aKQJvEDu3y5tIx6UwX2K0yQCuWNuOvQwRgpJz0LaU4RRT9sZ91bXI9HSlltGMIyCC2GDUernrA/pG4gHAnKTIH5TwpVi3UTCdMyE8llrbqRfUSXntYpSvIUyMzzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864729; c=relaxed/simple;
	bh=tRsA9mcjC7X1q3ymft0k8u1T/0bCU39H1P48jPyX7fE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8hS2AD5e5G9/COuXijWk7JHLJy3c9K0Zk3LwHPf6PTSuwdJHnMMZbflIb7pcCWsWzbK3KRh2ctTfmBu5+fwtZHBNMRNv3JQ6p8dut0xpocEpnL0vmA0NnTZ/Zp3epGl7AMLR8MGPmdUeVVyny1BCW4taz7tYV5/Ehaxchr0r20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M5r7Jr1r; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 779A2FF810;
	Thu, 16 May 2024 13:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715864725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tahKfh/1DJlK3/OTKCEXmpwJffF0zZ1wUE3RarZ3vao=;
	b=M5r7Jr1r0XfTPsjxh1qWfT090A+s4RSCwaxB6oe8GHVOsCU3RJ/lE5ilPZd4WP/7YY8r17
	JhJi19gcZdy8hnovjQUx9DHGb1StGUXJFMqRv2PlomoOlgNxj/91ycHem84JhXwpFm0Uif
	RS1kBpeJAT4Sy0pB+3rwOjgoZzAe8+nsdOBjktHzso+pabO3pTWP/bmor3TkCWFfyLG2ga
	Wg05nAdMtk80eVJtcAkS4yPMlmkhRvgPZvWG5MOCbCilVGP9Avm1HN01BHLXIyAtPDmhBw
	OirXuwMxU9meBbhM5jiBNM51T5fldR7EcLJxuY3m0odJZBdTjNaEr4Oq1tbPcw==
Date: Thu, 16 May 2024 15:05:24 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mtd: nand: mxc_nand: implement exec_op
Message-ID: <20240516150524.24be4aeb@xps-13>
In-Reply-To: <ZkXvyiuB4B2Fbz4l@pengutronix.de>
References: <20240514-mtd-nand-mxc-nand-exec-op-v3-0-3e6f45fd3d82@pengutronix.de>
	<20240514-mtd-nand-mxc-nand-exec-op-v3-2-3e6f45fd3d82@pengutronix.de>
	<20240516103214.57a8ce33@xps-13>
	<ZkXfJ6n-06YqOr39@pengutronix.de>
	<20240516124405.2da1aa23@xps-13>
	<ZkXvyiuB4B2Fbz4l@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Sascha,

s.hauer@pengutronix.de wrote on Thu, 16 May 2024 13:36:42 +0200:

> On Thu, May 16, 2024 at 12:44:05PM +0200, Miquel Raynal wrote:
> > Hi Sascha,
> >=20
> > s.hauer@pengutronix.de wrote on Thu, 16 May 2024 12:25:43 +0200:
> >  =20
> > > On Thu, May 16, 2024 at 10:32:14AM +0200, Miquel Raynal wrote: =20
> > > > Hi Sascha,
> > > >    =20
> > > > > +static const struct nand_op_parser mxcnd_op_parser =3D NAND_OP_P=
ARSER(
> > > > > +	NAND_OP_PARSER_PATTERN(mxcnd_do_exec_op,
> > > > > +			       NAND_OP_PARSER_PAT_CMD_ELEM(false),
> > > > > +			       NAND_OP_PARSER_PAT_ADDR_ELEM(true, 7),
> > > > > +			       NAND_OP_PARSER_PAT_CMD_ELEM(true),
> > > > > +			       NAND_OP_PARSER_PAT_WAITRDY_ELEM(true),
> > > > > +			       NAND_OP_PARSER_PAT_DATA_IN_ELEM(true, MAX_DATA_SIZE)),=
   =20
> > > >=20
> > > > CMD, ADDR, CMD, DATA is the RNDOUT pattern. So it is now working fi=
ne?   =20
> > >=20
> > > Yes, RNDOUT is working now. =20
> >=20
> > Excellent!
> >  =20
> > > > Or did you forget to adapt the patterns to your use case?   =20
> > >=20
> > > Although it looks like the patterns from the pl35x-nand-controller.c,
> > > there is one slight difference. The 'false' in the NAND_OP_PARSER_PAT=
_CMD_ELEM
> > > above has the effect that a plain NAND_OP_PARSER_PAT_DATA_IN_ELEM is
> > > disallowed. =20
> >=20
> > I'm not sure I follow, the above pattern means: a single command cycle
> > is supported, no? =20
>=20
> A single command cycle indeed is and shall be supported. The
> pl35x-nand-controller.c I copied this from has
> NAND_OP_PARSER_PAT_CMD_ELEM(true). With all elements being optional this
> also allows a single NAND_OP_PARSER_PAT_DATA_IN_ELEM()
> (supported_op.data_only_read becomes true). I can't support that, so I
> made the CMD mandatory.

Alright, yeah. Ack.

Thanks,
Miqu=C3=A8l


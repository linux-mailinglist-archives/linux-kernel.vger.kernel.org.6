Return-Path: <linux-kernel+bounces-177592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A97E8C4133
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351AC284E16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE0215219F;
	Mon, 13 May 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g1i1Da3k"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075A14F9CF
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604943; cv=none; b=ZiDMJj7DX9LNJ1IYthEjjYblJzWDtpvk3K3vciyOp5uqbicGvaytz4g4y4FgcUWkMoLuEcw4Mi6Oq4jcrILOOabfIJ6HRszbs7cLDkSEzfN5CyQf5o5jdz+jf29SRfESynblU+82z+RvwTP96eSQpkDD57N+HMYsv5DnO1fFtiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604943; c=relaxed/simple;
	bh=WyQqmoRYC72bmnkeeCcCn8hrnX1D66V3SvpnjS2vG9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cfxe7H4Tj2eGsani0TcCg83qt4fUvX0u7r/37m0CiqSik1zltMC9Fo26BsLCiX+W/qwG8/lmcrwHCuA62w4t0olSfTH1vtS+5poxFzVoalZ2eCOgRa+eHncSJ22PhwTLknGUI/WA61KYahVWtQKTyxrHtrGwkfk0E8r7teFwk9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g1i1Da3k; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EE4920008;
	Mon, 13 May 2024 12:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715604938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fXOKlipIeocUQzOfwGKn0MBsA79zn2u746LrpAvDZD0=;
	b=g1i1Da3kP+zjQ7HKZWHzUahbiO4ThpmVouTm7yztf8HeS5gcwIHXP7qo/inH9mWg9dtQYu
	a84Jou++bHYqc8cyKn44eltgjNfGbXS4gIFGVHjAIli/fAOqieQrOP2HC0/T/msLd8W62d
	fQFM3dr4k2RcXZOPfYFNxWohgnBSwALgGdQsvlsHriimS7UhROuN7tcqMfvIciPmgo3EUX
	Mg7Ijh3SNR1Zxk4i5v21p0PBHyfRwj3ID4wnOmhG2sRFSwkai/5ilRxHjRfC4st4Hmt7Wa
	G8Pmje9X5h5B9TZTjZ1EPj98zul9pTy+L8dK09WQ5D+3igRRnG49O2OpITV3FA==
Date: Mon, 13 May 2024 14:55:36 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mtd: nand: mxc_nand: implement exec_op
Message-ID: <20240513145536.71145b65@xps-13>
In-Reply-To: <ZkHYo6-8SC4RMlsG@pengutronix.de>
References: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
	<20240508-mtd-nand-mxc-nand-exec-op-v2-2-6b7366b7831f@pengutronix.de>
	<20240513091902.2c00d30a@xps-13>
	<20240513093256.363861d1@xps-13>
	<ZkHYo6-8SC4RMlsG@pengutronix.de>
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

> > > > +	for (i =3D 0; i < op->ninstrs; i++) {
> > > > +		instr =3D &op->instrs[i];
> > > > +
> > > > +		nand_op_trace("  ", instr);
> > > > +
> > > > +		switch (instr->type) {
> > > > +		case NAND_OP_WAITRDY_INSTR:
> > > > +			/*
> > > > +			 * NFC handles R/B internally. Therefore, this function
> > > > +			 * always returns status as ready.   =20
> > >=20
> > > This is no longer a standalone function, maybe:
> > >=20
> > > "The controller handles the R/B pin internally, therefore there is
> > > nothing to do here." =20
> >=20
> > And this is actually very wrong.
> >=20
> > You should call wait_op_done() instead.
> >  =20
> > >  =20
> > > > +			 */
> > > > +			break;
> > > > +		case NAND_OP_CMD_INSTR:
> > > > +			if (instr->ctx.cmd.opcode =3D=3D NAND_CMD_PAGEPROG)
> > > > +				host->devtype_data->send_page(mtd, NFC_INPUT); =20
> >=20
> > Actually this is not the right place. You should trigger the transfer
> > from controller SRAM to NAND (and the other way around) in the
> > NAND_OP_DATA_OUT_INSTR case.
> >=20
> > Here you should just call ->send_cmd. =20
>=20
> I tried to get away here with using the standard nand_write_page_raw()
> function. This does multiple NAND_OP_DATA_OUT_INSTR ops before finally
> sending a NAND_CMD_PAGEPROG command. With software BCH ECC I collect all
> data being written in memory and copy it to the controller SRAM en bloc.
> I have to do this after the final NAND_OP_DATA_OUT_INSTR op. During a
> NAND_OP_DATA_OUT_INSTR I don't know if this is going to be the last one
> or if other NAND_OP_DATA_OUT_INSTR ops follow, so I do the copy to SRAM
> right before a NAND_CMD_PAGEPROG.

I fully understand the mindset, but we had too many issues with this
this using ->cmdfunc() and ->cmd_ctrl(), so we introduced ->exec_op()
exactly for this purpose: controller drivers shall not try to guess
what the core wants. The core now provides the full operation and also a
way to check if the operation is supported.

So if something is unsupported, just report it is unsupported.

> I could move the ->send_page() call to NAND_OP_DATA_OUT_INSTR, but then
> I have to overwrite the ecc->write_page_raw() hook.

I guess your issue is the core trying to write the in-band data
and later the oob data. I totally get why you're doing that now, makes
sense, but this is not how ->exec_op() should be implemented, let me
explain (and propose a solution).

In general, it is preferred to have a clean ->exec_op()
implementation (in case we later extend the core) that is capable of
doing the ops correctly and *just* what has been requested. Drivers
should refuse the operations they don't support instead of trying
to work-arouding them. So here the correct way is probably to provide a
->write_page_raw() hook to simply avoid the unsupported ops. In your
case you just need to reference nand_monolithic_write_page_raw() and
you're done.

Also please check the cases you don't support and refuse them in
->exec_op() (both in the normal *and* in the check_only path). This is
also part of ->exec_op()'s design and is very important. I believe you
should take inspiration from the pl35x-nand-controller.c driver which
typically covers all the known-to-be-working cases with just three
patterns filled in a parser structure (true/false means the instruction
is mandatory or can be skipped, please have a look to
pl35x_nandc_op_parser). You will notice all cases in the parser
reference the same function in the end (you can do the same). This way
you know only supported patterns will be used and the core can easily
check whether something "new" is supported or not. Right now the
current mxc ->exec_op() implementation says it supports all
instructions, which is of course a lie.

Side note: Core helpers were initially written with the more flexible
approach, ie. splitting the operations in smaller pieces. This
typically does not work with some controllers such as yours. What I
want is the driver telling the core it should not try to split the ops
if that's the case. I know the core is a bit flacky regarding these
checks. There is currently only the data_only_read supported_op check
that is used for early discovery (see nand_onfi_detect()), but in case
you have issues with this type of situation, let me know, we (I) can
improve the core.

> Also it must be
> clear that the NAND core will never do multiple NAND_OP_DATA_OUT_INSTR
> when programming a page.

That's typically something that could happen (in practice I don't have
any plans for that, this is theoretically speaking), hence using the
nand_op_parser structure will ensure if we ever extend the core, the
driver won't break.

> Side note: I decided to collect the page data in a memory buffer rather
> than in the controller SRAM directly because it seemed too complicated
> and error prone to find the correct offset in SRAM for random column
> addresses. Also the SRAM can only do word and halfword accesses, so I
> additionally would have to emulate byte accesses with read-modify-write
> halfword accesses. While certainly doable I'd like to defer this to a
> future optimisation exercise.

Oh yeah, totally agreed. I saw the implementation and I agree we should
aim for a working driver. Then if you want to improve it for
performance reasons, changes will be welcome.

Thanks,
Miqu=C3=A8l


Return-Path: <linux-kernel+bounces-178551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC32D8C4F52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCD91F223E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0458F6EB45;
	Tue, 14 May 2024 10:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NFTEov9i"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1F6E60F
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681774; cv=none; b=FZOZ32taZdvz6hbO5vRjO0bw+FiK0/V0nQ/VXv1A8qPwFomxG6WgvPKmYWIS1h/NDzqCm2BiwvETEFCAE3mRsiPkk26OLeVqPfDmH3J52dDYNNRKdaZ4u/adFM7j/NpWgUwXGHjM2mh2t7o2pB+sYCVUYbqx7+OssgY831cTqr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681774; c=relaxed/simple;
	bh=5KCYdPg1i7cRHUUyqTeytScT9jaxIL6krJbwXxLmzSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUn5pejWiM9ZDduAfqNrRyKYoZA3HefpdKUOrGhAfFDnuHvzCWOHgsvkV7H6glHiaKaX71PYrFtODGKdgYArT070g13b5q2f/gXhIcb0gpMYx17NZp/q9oEQcdFbDO4UANOFmBf/YgQAT+wzQTOjdzT7P2zvhHWuNgq1LJaUon4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NFTEov9i; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EDDEBC0002;
	Tue, 14 May 2024 10:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715681764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwCC6DgkYOnVAxgMfGgxDNcG6VVfSmS67z1fSU/thog=;
	b=NFTEov9iI5E64TeidBAdI2psIbgOEwyX5cRn4SJ9+5jKxszuZq/KTeBDioN+4kD5T6U1PJ
	xQKIzCNP/jYrLsLwk87WFrSI8JYwwEVkHRxrjkEoVu/riiPUWt0GQArqqhIj7gm0WLPzSW
	ZF0nRax0V84TMBbcHo1YDWbXgiaUzswHF7QU597f0BUCIqW1OCyDdOzg++5X9kg5IJfmgy
	I2b4fLhQluCYiLEt3hh/s0NdBy26ST2YkzAOdLG1JLH6I45C/IWVjjp2ZcEMPWDRxQehiq
	N4GRDvbZY10IuJ433U5mShBNHYppN8WQovPbGgDGAXPQ4z7C8aOExf6CCnodeg==
Date: Tue, 14 May 2024 12:16:02 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mtd: nand: mxc_nand: implement exec_op
Message-ID: <20240514121602.273f788e@xps-13>
In-Reply-To: <ZkMsS1jj-ZTpZyE1@pengutronix.de>
References: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
	<20240508-mtd-nand-mxc-nand-exec-op-v2-2-6b7366b7831f@pengutronix.de>
	<20240513091902.2c00d30a@xps-13>
	<20240513093256.363861d1@xps-13>
	<ZkMsS1jj-ZTpZyE1@pengutronix.de>
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

> > > > +		case NAND_OP_WAITRDY_INSTR:
> > > > +			/*
> > > > +			 * NFC handles R/B internally. Therefore, this function
> > > > +			 * always returns status as ready.   =20
> > >=20
> > > This is no longer a standalone function, maybe:
> > >=20
> > > "The controller handles the R/B pin internally, therefore there is
> > > nothing to do here." =20
>=20
> Ok.
>=20
> >=20
> > And this is actually very wrong.
> >=20
> > You should call wait_op_done() instead. =20
>=20
> No, I don't think so. wait_op_done() is called to wait for the interrupt
> of the controller indicating a basic operation is done. A basic operation
> can be that a command is being sent or an address byte has been sent to
> the chip during an address cycle.
>=20
> With this arbitrary example:
>=20
> 	struct nand_op_instr instrs[] =3D {
> 		NAND_OP_CMD(NAND_CMD_READ0, 0),
> 		NAND_OP_ADDR(4, addrs, 0),
> 		NAND_OP_CMD(NAND_CMD_READSTART, NAND_COMMON_TIMING_NS(conf, tWB_max)),
> 		NAND_OP_WAIT_RDY(NAND_COMMON_TIMING_MS(conf, tR_max),
> 				 NAND_COMMON_TIMING_NS(conf, tRR_min)),
> 		NAND_OP_DATA_IN(len, buf, 0),
> 	};
>=20
> I'll call wait_op_done() once for NAND_CMD_READ0, four times for the NAND=
_OP_ADDR,
> then once again for the NAND_CMD_READSTART command and four times (on i.M=
X27, once
> per subpage) for the NAND_OP_DATA_IN operation. Calling wait_op_done() fo=
r the
> NAND_OP_WAIT_RDY operation woul only timeout because there is no operatio=
n in flight
> currently.

Ah, ok, makes sense as well. If you want (this is not mandatory) you
may want to rename the function wait_instr_done() to fit the core's
naming: an operation being an aggregate of instructions/cycles.

Thanks,
Miqu=C3=A8l


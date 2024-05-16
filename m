Return-Path: <linux-kernel+bounces-180875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A412E8C743D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 11:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DC31C2332F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3BF143880;
	Thu, 16 May 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="haXHGLgz"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E106614387B
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 09:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853500; cv=none; b=V8sfomZ7KIL4YQPB6odbG5O8eSEkJ0OHKmeMO/qoVKP0dOW6ENTr9dGKegaYmlcHVcCUa2ZNtjUOzlo2Z7jlREfu++eRBN20omxbUTT+HtAY564YNIq9teQUzzX+lkbbD2A4uHB9fcFVrIvOeF3Y3DMVnoTOF11SGCk38rTDS8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853500; c=relaxed/simple;
	bh=/Pkjo0O6kPrOQ+pSjbXZ0VxxK1MyzoODYOjlkXO8dN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MAZ42ZfSNqKeX6uRCaj2llzgj2eWF1U/Qtg9fAEpQBiP/eM0D/20bmCv72IzPmrpdxnS63t/W6ektknl2b6Q9vUjwVflClg29EvpGLhyKjnpbM3gf+NhTIr0fnftoNonMpOfyhAlrP/WglZ+VZH1a4QCEWwVaYQE9OF6vuH05u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=haXHGLgz; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B404C6000B;
	Thu, 16 May 2024 09:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715853496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TU3V61Z0wIgectXTOIoDLF/0Qh2EeUmNqA0N7zoS8Fk=;
	b=haXHGLgz3tHlAGjx+O1RqDE769xASBsIP31pnB6qeDP/6DRuA5rEgbCNRfKkoOuh2o8NCJ
	cS9gdO6Y3agDJYU02S6GW66q/YtgfnGnupHOM92XlEN1JXXZmFPP7ZAbRgQgV9tqD8Y+42
	XxoFhWhqQjWSV17YB+pD+PrHSYnxm7J/WKrQ81ahbzZ88hnQHRnB5yPlWapVNQ36OW8GWd
	546YDtKUVZkgodHY01eVqBAyQe53oBoml+aDOhMbhQfYF+M+nYBY9tuLvloq2HAk4FXXtr
	keK+xZncK/Mq/jdl8xhuWTo5zPGO7zn0IbG+KAV6YHlS2KdCCeo15mzntBlzvA==
Date: Thu, 16 May 2024 11:58:12 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Weinberger <richard@nod.at>
Subject: Re: [PATCH] mtd: rawnand: onfi: read parameter pages in one go
Message-ID: <20240516115812.02908822@xps-13>
In-Reply-To: <20240516101350.78e5ee29@xps-13>
References: <20240514134140.1050141-1-s.hauer@pengutronix.de>
	<20240516101350.78e5ee29@xps-13>
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


miquel.raynal@bootlin.com wrote on Thu, 16 May 2024 10:13:50 +0200:

> Hi Sascha,
>=20
> s.hauer@pengutronix.de wrote on Tue, 14 May 2024 15:41:40 +0200:
>=20
> > nand_read_data_op() is not supported by all NAND controllers.
> > nand_change_read_column_op() is not supported or at least is hard to
> > support by NAND controllers that use a different page layout than
> > expected by the NAND core. =20
>=20
> I'm sorry but RNDOUT is not so hard to support, and I know no NAND
> controller without this feature (I think even the first mxc controller
> supports it?). However, the command does not exist on small page NANDs
> (512 bytes).

Nevermind, the ONFI spec (in all versions) states that RNDOUT are
allowed during parameter page reads, regardless of the size of the chip
(at least, that is not mentioned).

> TBH I have never seen such a device myself, so I wonder
> how spread they still are.
>=20
> What may not be supported however are the DATA_IN cycles.
>=20
> > Instead of relying on these functions
> > just read the three parameter pages in one go. =20
>=20
> Bitflips in parameter pages are very rare, they are normally quite
> robust. The proposed solution impacts *all* NANDs, because the I/O
> chip speed is at its lowest. There is no reason in most cases to do
> that.
>=20
> I agree there is a problem with the patch I proposed and we need to
> settle. And we simply cannot make RNDOUT calls randomly here as long as
> we want to support small page NANDs.
>=20
> I believe we should do something like:
>=20
> nand_read_param_page_op(0)
> if (corrupted) {
> 	if (supported.datain)
> 		data_in(); /* this is faster */
> 	else	=09
> 		nand_read_param_page_op(1)

This can't work, there is a single address byte. The parameter page
being 256 bytes, we can't use the address parameter.

So I'm sorry but the solutions are:
- DATA_IN cycles (not always supported but the best)
or if unsupported:
- RNDOUT

Re-reading the three pages would be slower and is not supported by all
controllers anyway. Example of controller not supporting it: qcom [1].
That's why I want the constraints to be fairly well described in the
parser.

[1] https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/qco=
m_nandc.c#L2965

Thanks,
Miqu=C3=A8l


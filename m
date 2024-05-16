Return-Path: <linux-kernel+bounces-181090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB3C8C774A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0443D285CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 13:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBC3146A86;
	Thu, 16 May 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EpVoNl/P"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B91465B7
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864970; cv=none; b=Sq0cgl8dUPkIWs/GpNXNi5tPCpIyuGnxLV+uiR0KOWePqb9fTWVjUuJXWC9xQpQ2XgFB6x3BdLbnXXguKpT2ilJlsFF9Ar/3xgT9dX9iaH3Ah6Qau1SHXKkpivMX9v+BEsz0GzdGI0Jr7hbww8gu60KcRQpVHi6CWcBTOUPxvy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864970; c=relaxed/simple;
	bh=4EsaPXJC+JvHpVJsiCeU8T2WD8dBBn24X0h0DEg9RBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y32HysUHYoVsqSeunVFDP0O7x2MMd6VTefrqbXTfCjZSbsbL/B04Du8G0XMwFQGCBESuMJRgNwXgZVUJBx7PaKNgi+Vqu+AxhU2lhbqyjf+VFnxXRZpMPWVkmPw61basMdZzT+fLdy9Jbl+vXIdJt2bIiGdWlWZUdNSA/DhyiNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EpVoNl/P; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F87C1C0006;
	Thu, 16 May 2024 13:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715864966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AToU5AIFALBM7r0eZ6ZWKjQjRupuMORQSk8DoQTPoaU=;
	b=EpVoNl/PLweZX1UQu/60zZH4S/fB+lYjJ3t9ifkXUwYUpiIrqZBpMkkrbw5yuS+/iMppXc
	qm7cwMM9Auzy+PmwB+8ZDe+XGm5uhxiqkqrMkBUo85g22Q1raZAjcyhDoguIUmZ8DUBRwj
	ZNI4IR8mdXKl/CWRb3rTk61ds9Rl507aZNOodUHxb0X2B19uCG0y6dtjnkKUueJ/kcDx87
	GstCyPaBaSkAUl68VHGcU1Qpkw4xZDATaE8aSfpm9cxoORLeNCgYqsu42dkJphZbTlEgNk
	7dF2ay9C+SeUifLaLoBMj+xvQCabk6BlgZ/XN/6Pfpq2fOdUZopb2c4VLLaunQ==
Date: Thu, 16 May 2024 15:09:25 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Weinberger <richard@nod.at>
Subject: Re: [PATCH] mtd: rawnand: onfi: read parameter pages in one go
Message-ID: <20240516150925.5c65319b@xps-13>
In-Reply-To: <ZkXylC2xrlqGW_xV@pengutronix.de>
References: <20240514134140.1050141-1-s.hauer@pengutronix.de>
	<20240516101350.78e5ee29@xps-13>
	<20240516115812.02908822@xps-13>
	<ZkXylC2xrlqGW_xV@pengutronix.de>
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

> > > > nand_read_data_op() is not supported by all NAND controllers.
> > > > nand_change_read_column_op() is not supported or at least is hard to
> > > > support by NAND controllers that use a different page layout than
> > > > expected by the NAND core.   =20
> > >=20
> > > I'm sorry but RNDOUT is not so hard to support, and I know no NAND
> > > controller without this feature (I think even the first mxc controller
> > > supports it?). However, the command does not exist on small page NANDs
> > > (512 bytes). =20
> >=20
> > Nevermind, the ONFI spec (in all versions) states that RNDOUT are
> > allowed during parameter page reads, regardless of the size of the chip
> > (at least, that is not mentioned). =20
>=20
> I could imagine that there are no ONFI compliant chips with small pages,
> I don't know how to verify this though.
>=20
> Anyway, this was a try to make reading the parameter pages a bit more
> straight forward. It seems the MXC NAND controller can't support reading
> three parameter pages in one go either. It works in software ECC mode
> because I reverse the syndome type layout the controller introduces, but
> it can't work with hardware ECC.

Hardware ECC should not be used at this step and should be disabled.
There should not be any ECC interference.

> So disregard this patch.

I now have a proposal, I'll send a v2 of my previous series.

Thanks,
Miqu=C3=A8l


Return-Path: <linux-kernel+bounces-353098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 683909928A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A231F241C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2260E1DDC20;
	Mon,  7 Oct 2024 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SKga1kwR"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1855A1DDC05
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294744; cv=none; b=MyV0aIFDWlAoDps1f77WICEsZd6n4bJaMbwsbeXRObSbKnWNAyAJq2+z3lZMl4HiueeK1dzwgI3aZRfzKPLo/prKptBXT4wN5Gkljro3jpqfAzfvst2s8vI8vRIYjpkPgx78qPMCUDRFzxLzoj2AsXqBNNyYvHxb7ouZHInTk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294744; c=relaxed/simple;
	bh=+EUqUpNUlUllSo0KYk9RtuBCtrCQcl4lEXXT/8nIyGw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGHCpHcFXzdH4hToJN9OFaHjk4UMYqBxtPrPI+mICEG+tcmKPz5pWrLE1PdSS2Etsrc4BIWoD2i0j1R+Bi08lxHKrmYYOg2Gor1RVhFNUv/TYA7Wx7n/51JqJRSbgBKwKYw8koDQ9jSyqy02A6i46KWurPRF2pcQG2gYIxSO0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SKga1kwR; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F378B40009;
	Mon,  7 Oct 2024 09:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728294733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDiPinINBvr6bJAxMdyt3dgUnwijd1daj//Q8bC6Vds=;
	b=SKga1kwR5GAKPcVI05WN/Vo904GPfbFLRsmuoMPVqB1AYvGwUlfDCXu7IVXRR2sLrkgTen
	/XPxAzviHAcavd65dJGk1QGf6DZ4H+hdHF4t6aSoJqe7IOqKAuRpdc6hn9wNj6/RlpJQEl
	ohl2xj/4fatcsrb+szOdNHPC3b9Hs22hyCHznRPoo/iE/v+vgLPDkRrszX2mbfCSlfNgwu
	fruIRjFZwxZR+QjftdpWXLOuIAs3effI3HmLDYDdPUgxE9PQl6CWoQ8iM3wkptSPBqstXm
	pLVkg8UPTr2+weIjd4PJ5tmNi667E1lRVFypKqXW7qiVuJxlXKrfH1MJmK+zwQ==
Date: Mon, 7 Oct 2024 11:52:11 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Han Xu <han.xu@nxp.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, imx@lists.linux.dev, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: nand: raw: gpmi: improve power management
 handling
Message-ID: <20241007115211.0ad33fda@xps-13>
In-Reply-To: <20241004092144.3e0d89b5@xps-13>
References: <20241002153944.69733-1-han.xu@nxp.com>
	<20241002153944.69733-2-han.xu@nxp.com>
	<20241003093840.2965be20@xps-13>
	<20241003150500.uz2efay7kadu47if@cozumel>
	<20241003172820.50324192@xps-13>
	<20241003200508.x7tbf2lpbg6ngm7q@cozumel>
	<20241004092144.3e0d89b5@xps-13>
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

Hi Miquel,

miquel.raynal@bootlin.com wrote on Fri, 4 Oct 2024 09:21:44 +0200:

> Hi Han,
>=20
> han.xu@nxp.com wrote on Thu, 3 Oct 2024 15:05:08 -0500:
>=20
> > On 24/10/03 05:28PM, Miquel Raynal wrote: =20
> > > Hi Han,
> > >=20
> > > han.xu@nxp.com wrote on Thu, 3 Oct 2024 10:05:16 -0500:
> > >    =20
> > > > On 24/10/03 09:38AM, Miquel Raynal wrote:   =20
> > > > > Hi Han,
> > > > >=20
> > > > > han.xu@nxp.com wrote on Wed,  2 Oct 2024 10:39:44 -0500:
> > > > >      =20
> > > > > > The commit refactors the power management handling in the gpmi =
nand
> > > > > > driver. It removes redundant pm_runtime calls in the probe func=
tion,
> > > > > > handles the pad control in suspend and resume, and moves the ca=
lls to
> > > > > > acquire and release DMA channels to the runtime suspend and res=
ume
> > > > > > functions.     =20
> > > > >=20
> > > > > May I know the motivation to acquire and release the DMA channels
> > > > > during suspend? In general it seems like a different change which=
 I'd
> > > > > prefer to see in its own commit with a justification. The rest lo=
oks
> > > > > ok otherwise.     =20
> > > >=20
> > > > Hi Miquel,
> > > >=20
> > > > Thanks for your comments. IMHO there is no much logic changes indee=
d, just move
> > > > the dma channel acquire and release from system pm to the runtime p=
m, releasing
> > > > the unused resources as early as possible. If you think it's necess=
ary I will
> > > > split the patch into two parts.   =20
> > >=20
> > > Actually I don't understand why these channels are released and
> > > acquired again. Does it make sense to do that in the (runtime)
> > > suspend/resume path? I'd be in favor of avoiding this extra
> > > configuration which as a first sight does not seem required here.   =
=20
> >=20
> > Our local mxs-dma driver (will upstream the changes later) implemented =
the runtime
> > resume/suspend in channel alloc/release functions, so I did this in the=
 gpmi
> > nand driver suspend/resume path. =20
>=20
> I think it no longer makes sense. RPM takes care of the
> suppliers, at least since fw_devlink=3Drpm.

Just to be clear, you can send v3 addressing Frank's comment and just
keep the DMA channels handling as it is, but please work on removing
this hack of dropping/allocating DMA channels in suspend/resume path, it
is really not worth the trouble and purely useless with any recent
kernel.

Thanks,
Miqu=C3=A8l


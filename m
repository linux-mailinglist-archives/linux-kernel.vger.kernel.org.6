Return-Path: <linux-kernel+bounces-195437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABED8D4CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3161C1F22F28
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3A1527B3;
	Thu, 30 May 2024 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SgfxEis1"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A43D68
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076740; cv=none; b=GuVAXSmL8CFx5Y0wqemB2BHYn0wZivdoZPkvF4G4rou5ItLd0TJ444ADAQ5HUMmAEG+6TfNvRtdhr331CpT9oZW/4TTjIRoRaW9S068LYr3cgYjCdcdDbRBbFLYV3XmkQkTKBnJz1I/G5RIo/x5k2IYgVb1vska30gTeAYlmXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076740; c=relaxed/simple;
	bh=Iyf593fiF264KxDvYfa2uUVWLRbVv1B2mOqmFHbtPJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zs8YxXFo+Z6EkUSudA2F3Nm/44JM5yJs+oHND15pVNZ9S1jDIgKz9sdq7sIqBSWv9D+r4Ywy5cIOEIyOr7ekKZgh30EfjOPLjpMQKao6ySYWF/T4fOPgZElYEDteEBCPf624oy53mX12BoP0rMWVygNBqjOW0OrriHeoAHA+4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SgfxEis1; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 334651C0009;
	Thu, 30 May 2024 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717076735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iyf593fiF264KxDvYfa2uUVWLRbVv1B2mOqmFHbtPJw=;
	b=SgfxEis1K/Yhj7kE3wKEjYarAcY1Pp9MxlNawPpgWayYNmrriLNzSGhXQTKFukmiR30zPs
	P4Ehg+NAbQMYLTk6TyYDjca/17pD3ZpAGxi77lXshHAVwL9zq5GaC9FRnWPQeWA4aCp9BJ
	uC5lyChhYNTTEzehRRr3LKDbCEDnJ1LnoOwwBD1bZTHmJHop3PgT6RgEJtb4G69OUYhTd2
	ZPws4tMkdwAlPFacMYykdBit3AuO0yJ3flg3fPsWcy5OJzPo3GSRRifJSUSkTXian1Z8Mi
	xyhsgDVFi/hMY40xVlnX8ClbuLeM60pP5tcKqNilI+TTNFvIVHLdzFgDNM+58w==
Date: Thu, 30 May 2024 15:45:26 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Richard Weinberger"
 <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "David
 Woodhouse" <David.Woodhouse@intel.com>, "Akinobu Mita"
 <akinobu.mita@gmail.com>, "Artem Bityutskiy"
 <artem.bityutskiy@linux.intel.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: make mtd_test.c a separate module
Message-ID: <20240530154526.25c3ae17@xps-13>
In-Reply-To: <48738af1-545e-4261-a8b7-fe224071910f@app.fastmail.com>
References: <20240529095049.1915393-1-arnd@kernel.org>
	<20240529141323.7015f3d9@xps-13>
	<48738af1-545e-4261-a8b7-fe224071910f@app.fastmail.com>
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

Hi Arnd,

arnd@arndb.de wrote on Wed, 29 May 2024 14:36:46 +0200:

> On Wed, May 29, 2024, at 14:13, Miquel Raynal wrote:
> > Hi Arnd,
> >
> > arnd@kernel.org wrote on Wed, 29 May 2024 11:50:39 +0200:
> > =20
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>=20
> >> This file gets linked into nine different modules, which causes a warn=
ing:
> >>=20
> >> scripts/Makefile.build:236: drivers/mtd/tests/Makefile: mtd_test.o is =
added to multiple modules: mtd_nandbiterrs mtd_oobtest mtd_pagetest mtd_rea=
dtest mtd_speedtest mtd_stresstest mtd_subpagetest mtd_torturetest =20
> >
> > I've never experienced this warning myself, how did you produce it? =20
>=20
> This warning is currently enabled when building with 'make W=3D1',

Ok. I didn't pay attention.

> but there are only a handful of drivers that run into it, so
> I have sent patches for each one, with the plan to enable it
> by default in the future.
>=20
> >> Make it a separate module instead. =20
> >
> > I'm not a total fan of this just because it now requires an additional
> > step to insert these test modules (they are likely used for
> > debugging/development purposes, so not properly installed in the
> > rootfs). Is there any chance we can find another way? =20
>=20
> This should only be a problem when using plain 'insmod' instead
> of 'modprobe' for loading the modules. Do you think this is
> commonly used here?

These test modules have been slowly deprecated in favor of the user
space tools but when I had to use them, I was often using an initramfs
with the modules just copy/pasted and inserted with insmod. There is no
real point I guess in embedding these modules in a final rootfs.

> Another option would be to turn all the helper functions into
> static inline versions and just include the header, but
> that does not avoid the duplication then.

Indeed.=20

Is there any chance to just silence the warning by flagging these
modules as "test" or "development" modules? Because TBH it feels like
the warning is just useless in this case. These modules should not be
enabled in a production environment anyway.

If not, then let's just keep your current patch. As I said, these
modules are kind of deprecated anyway.

Thanks,
Miqu=C3=A8l


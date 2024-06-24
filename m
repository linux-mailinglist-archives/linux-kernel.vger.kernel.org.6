Return-Path: <linux-kernel+bounces-226793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FBF9143DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA28D1C213A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DED4595B;
	Mon, 24 Jun 2024 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="MRE4vCze";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="KFrKXIjw"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7991945025
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215050; cv=none; b=Ae8WwAT3TUjUaQxNiHq6jicZqSPvqr5FU8FORPAcsCg917VCo30kpBO1ijG2oq7Aehvct2fG7eXaSuLRBRJW1I8R0PcZNct3OZGqu0Skva8bDc00J/SA14N/vfgaQsb4YOsqMhq7guhOcl71iwWomUBw7aRUe/4HiAHSnnlhflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215050; c=relaxed/simple;
	bh=C8jF8aYoWhfXOTgwgZp4YqlklIULbX3ohWUEV0pIJ6E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qvRVApj2Dt7Ru4VHD87/sG9BlWHlKc3TmeL9/mDOB+IONkA5pmxqaVetc9os+ZFHdEz/sfeYDLYPxO/wI/tzbw4GhUfPC4ppLlGCA7Pbb6oAd1XeK6U1nIM9+yIjaEpkiK05a/G8zpgxZ5+kTL6D4bKCmRRc+6X7lefcNSVs5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=MRE4vCze; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=KFrKXIjw reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719215046; x=1750751046;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=f0/4hczM3PgPRKRDj57itvBeTTs+iV8vaDqXvjPmF90=;
  b=MRE4vCzeCD7I3nlDFDhR8n30Mc6x0ZIEZBP/85/QkDiRI6GQRcF35mwK
   6XMfx8GEY8pzGMKujT7ggK9lFIhfMICMofaMu5eq123bybN8lnyqspMYK
   SokCDWP/nO0xpFR7D8/TMuIbiottGtUBsW9sX7pSS9d1Aj7PwRnymx+vF
   pcusAz0pwLqJxYTiwSP3dW4lGgIZKOJkt13MphWMoezRDW3v4ItT3s2yu
   xUkWFrpZuqTFfDKqkGUypMvxFSKQtia+ArbDSMexdRHcUck/TK7ngxTPg
   rZZVTMbT0GcXPQbYjeRxauRsrMXP6GS8zPjnk3EQFZ3T/ZKRf8a+0uUhp
   w==;
X-CSE-ConnectionGUID: hkbi1tQNTHqOQd7ONUZQAQ==
X-CSE-MsgGUID: MC01HsnOT3eez5cTfm/ICQ==
X-IronPort-AV: E=Sophos;i="6.08,261,1712613600"; 
   d="scan'208";a="37544150"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jun 2024 09:43:58 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D76AE16160A;
	Mon, 24 Jun 2024 09:43:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719215034;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=f0/4hczM3PgPRKRDj57itvBeTTs+iV8vaDqXvjPmF90=;
	b=KFrKXIjwzTjYyEyjjwfjSkav9LoRvWl6Uq/JaJwTqJqoknhHtqAoUazpz09gwt5ehtJX3a
	kFFOjFR27I5hMWHORRTJ/ScTxwH0fUSH530x89ljbeK7/+lVgVfjMKZDj/EgeMiOoAmQFg
	yg3SwkCJPyfLmUjTTQVwniYw/LUqUArhqfSzQ+wXGcI4MTzRbPiUjAsFZMhkpqvM1tCEto
	awg5tvMIYbGhZyS0uiNL4Q2C4mx38hhtLKjRCYDojEl1W6AMktCgL6mFijivBn+lAmNTze
	V+cJ/2gQCgI+dCQob0W4KXhGw1aQYsRIxzg4BX8uY7AfHcYVr5SU5jyQx/itUA==
Message-ID: <b46e06b64ceb14c205f7c48871687bd283fce53d.camel@ew.tq-group.com>
Subject: Re: [PATCH v2 4/5] mfd: tqmx86: make IRQ setup errors non-fatal
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Gregor Herburger
	 <gregor.herburger@tq-group.com>, linux@ew.tq-group.com
Date: Mon, 24 Jun 2024 09:43:53 +0200
In-Reply-To: <20240620163552.GQ3029315@google.com>
References: <cover.1718626665.git.matthias.schiffer@ew.tq-group.com>
	 <38a69a56697a80486067f7817d4d0ed3bdea4257.1718626665.git.matthias.schiffer@ew.tq-group.com>
	 <20240620163552.GQ3029315@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 2024-06-20 at 17:35 +0100, Lee Jones wrote:
>=20
> On Mon, 17 Jun 2024, Matthias Schiffer wrote:
>=20
> > GPIO IRQ setup can fail either because an invalid IRQ was passed as a
> > parameter, or because the GPIO controller does not support interrupts.
> > Neither is severe enough to stop the whole probe; simply disable IRQ
> > support in the GPIO resource when setup fails.
> >=20
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >=20
> > v2: no changes (was patch 3/4)
> >=20
> >  drivers/mfd/tqmx86.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> > index 5aa51ead00a28..7f9ccd83278dd 100644
> > --- a/drivers/mfd/tqmx86.c
> > +++ b/drivers/mfd/tqmx86.c
> > @@ -259,13 +259,14 @@ static int tqmx86_probe(struct platform_device *p=
dev)
> >  		err =3D tqmx86_setup_irq(dev, "GPIO", gpio_irq, io_base,
> >  				       TQMX86_REG_IO_EXT_INT_GPIO_SHIFT);
> >  		if (err)
> > -			return err;
> > +			gpio_irq =3D 0;
> > +	}
> > =20
> > +	if (gpio_irq)
>=20
> Stacking identical if()s one after another doesn't sound very efficient.
>=20
> Why not put the contents of this one inside the one above?

The intention was to have the "else" branch be executed both when gpio_irq =
was reset to 0 in the
above error path, and when gpio_irq was 0 in the first place (so the above =
section running
tqmx86_setup_irq() hasn't even been executed).

I got a better idea now however - by initializing flags to 0 and only setti=
ng it together with the
IRQ in the success path, no (!gpio_irq) branch is needed here at all. Will =
change in v3.

Best regards,
Matthias



>=20
> >  		/* Assumes the IRQ resource is first. */
> >  		tqmx_gpio_resources[0].start =3D gpio_irq;
> > -	} else {
> > +	else
> >  		tqmx_gpio_resources[0].flags =3D 0;
> > -	}
> > =20
> >  	ocores_platform_data.clock_khz =3D tqmx86_board_id_to_clk_rate(dev, b=
oard_id);
> > =20
> > --=20
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > https://www.tq-group.com/
> >=20
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/


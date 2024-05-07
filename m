Return-Path: <linux-kernel+bounces-171494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634EB8BE512
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F5C1F21ED8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE2315EFBB;
	Tue,  7 May 2024 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E4r1i8bY"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A115E7EE
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090584; cv=none; b=kHVVECd9/N98fQg9vwWOIBQjaRWrEJT8EozXhZ7bOKkMrFDA8qSLh/1V7r9fZn5GzunavhjJaHFzTnzC34SS/1l4Ah8cG25zgU0RBxfRCdaiK6Y8w57lrG8+dO1oYmTvKDa9StznEsIW6Ek9P/O+V+YitaQCd89ngNHOhoV0Br8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090584; c=relaxed/simple;
	bh=zMgf+YFtkL7wyKeWiQblCBbykN0pGyoBYairoO36Hxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZ4n59H4OZuWXRzMV61e+ZW4tj6LkCyEn59fW4gE+13PUKxgZ9W/bc2jpHZgADLq5AI9P0NihsAEctk76ohhmVXlf8zrzx1N19A+OzHBRbokbDt0EJnCRNYnyj1IinC9xxaHIfIuIZU/TrJOaCLndzywQaL+z1/hqjqQFMUH24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E4r1i8bY; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 978B42000A;
	Tue,  7 May 2024 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715090574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cKI7GlnVF7vzPp/kl1uAX4B6WlmM2PiXc58H6Tpvbjw=;
	b=E4r1i8bYOzJhf5Sasi5cIRU42VYipoxolzO9WnWIkyaJR83FxpDdM2jd+co9I8M1HD9rib
	6WjRiX2Nbv847FQZAM9zLdi8EyReUAptAaShBzdXFSFcjkiNyblF9xpnalOPTQWRzjgOST
	RbgbhtQdK/2VClqmulKWBzLKeMj0H513kmUWkobSHmN2kgrXJdpDY/siWWyjbB0kJseovh
	XmJaqGv3LlrL9UdDXl9sUvYJgzFtZVCabkggrmC8rJlTm4/IgGo5WqT6KwDuMMaXog8kJb
	81CrVn4HrgIEfz3Lz6Eko04UK2S8tINVRE5IoMRmqt9eNOuuJyVPp/0R0oBUVA==
Date: Tue, 7 May 2024 16:02:51 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mtd: nand: mxc_nand: support software ECC
Message-ID: <20240507160251.7f804eb7@xps-13>
In-Reply-To: <ZjoDYzVNOk06-Q3D@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
	<20240417-mtd-nand-mxc-nand-exec-op-v1-3-d12564fe54e9@pengutronix.de>
	<20240506160508.6c60d50f@xps-13>
	<20240506175106.2ab7c844@xps-13>
	<ZjnUXtWGR3cmtYB0@pengutronix.de>
	<20240507094538.745fb5a9@xps-13>
	<ZjoDYzVNOk06-Q3D@pengutronix.de>
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

> > No need, I believe the only reason for interleaving is that your
> > hardware ECC engine works like that (writes the ECC bytes slightly
> > after each chunk of data). So if you don't use on-host hardware ECC,
> > you don't need to deal with this data layout. =20
>=20
> Right, I could use a different layout for software ECC. Using the same
> layout for both hardware and software ECC is just quite convenient as
> the same mxc_nand_read_page_raw()/mxc_nand_write_page_raw() could be
> used for both software and hardware ECC.

I'm not sure I see why it would be more convenient, as you basically
don't need to provide anything if you use software ECC engines besides
a minimal exec_op() implementation. Anyway, that's clearly not the good
approach for software ECC: the engine decides where it wants to put the
data, there is just no reason to complexify the software layout (which
is free from any constraints).

> Another thing that might be worth considering is that if we use
> different functions for raw read/write page is that we would get
> different views on the same raw page data if we switch from software to
> hardware ECC or the other way round which might be confusing.

Don't worry about that: it's impossible to manage. Data layout might be
different of course, but most importantly once you've chosen an ECC
configuration, any access with another configuration will simply fail.
And I'm not just talking about the ECC/step size parameters, each
engine has it's own base polynomial on which it bases all its internal
calculations, and besides trying very hard to mimic your hardware
engine in software for some very good reason, you'll never want to do
that. Especially since the very first reason why you want software
support is usually to go beyond your hardware engine capabilities in
terms of strength.

Here is a blog post about such situation, if deemed useful:
https://bootlin.com/blog/supporting-a-misbehaving-nand-ecc-engine/

> > > This works fine currently, but means that NAND_CMD_RNDOUT can't be us=
ed.
> > > Using NAND_CMD_RNDOUT to position the cursor at offset 512b for examp=
le
> > > doesn't give you the second subpage, but instead oob0. Positioning the
> > > cursor at offset 2048 doesn't give you the start of OOB, but some
> > > position in the middle of data3.
> > >=20
> > > Ok, NAND_CMD_RNDOUT can't be used for hardware ECC and there's no way
> > > around it. For software ECC we could change the organisation in the c=
hip
> > > to be [2048b data][64b oob]. With that NAND_CMD_RNDOUT then could be
> > > used with software ECC.
> > >=20
> > > You say that NAND_CMD_RNDOUT is a basic command that is supported by =
all
> > > controllers, and yes, it is also supported with the mxc_nand controll=
er.
> > > You just can't control how many bytes are transferred between the NAND
> > > chip and the controller. When using NAND_CMD_RNDOUT to read a few byt=
es
> > > at a certain page offset we'll end up reading 512 bytes discarding mo=
st
> > > of it. For the next ECC block we would move the cursor forward using
> > > another NAND_CMD_RNDOUT command, again read 512 bytes and discard most
> > > it (altough the desired data would have been in the first read alread=
y). =20
> >=20
> > I'm not sure the controller limitations are so bad in this case. The
> > core helpers (using the same example) will ask for:
> > - 512b at offset 0
> > - 512b at offset 512...
> > - and finally 64b at offset 2048.
> > In practice it does not look like a huge drawback? I don't understand
> > in which case so much data would be read and then discarded? =20
>=20
> Yes, you're right. I misread the code and thought the core would read
> the ECC separately for each subpage. In fact it doesn't do so, the ECC
> is always read in one go even for multiple subpages.

"interleaved" layouts actually force us to perform so much
sub-readings, that's probably one reason why there is no reason to try
using an interleaved layout with software ECC engines.

> > > So I think NAND_CMD_RNDOUT should really be avoided for this controll=
er,
> > > eventhough we might be able to support it. =20
> >=20
> > I also mentioned the monolithic accessors which try to avoid these
> > random column changes. You probably want to check them out, they might
> > just avoid the need for NAND_CMD_RNDOUT by forcing full page accesses
> > directly. The reason why they were introduced is not exactly our
> > current use case, but it feels like they might be handy.
> >=20
> > 658beb663960 ("mtd: rawnand: Expose monolithic read/write_page_raw() he=
lpers")
> > 0e7f4b64ea46 ("mtd: rawnand: Allow controllers to overload soft ECC hoo=
ks") =20
>=20
> Yes, I already make use of 0e7f4b64ea46. My problem is only the ecc.read_=
subpage
> hook which can't be overwritten and AFAIK this is the only way
> NAND_CMD_RNDOUT might be used in my case.

It needs to be supported, we don't expect in the core that this command
will not be supported. There may be some constraints and limitations,
and this we can workaround them somehow, but we expect support for
NAND_CMD_RNDOUT.

Look at all users of nand_change_read_column_op(), NAND manufacturer
drivers use it, jedec/onfi drivers use it as well in case of
bitflip in the parameter page, and the core may want to use it (although
in your case I don't think it actually does if you don't try to support
over complex layouts, as software ECC engines will always request the
OOB data whereas subpages are not used in this situation).

> I think my favourite solution would be to:
>=20
> - store data/OOB interleaved for both hardware and software ECC
> - For software ECC use a similar OOB layout as used with hardware
>   ECC. This allows us to read a subpage including its ECC data in
>   a single step (just like with hardware ECC the controller just
>   reads 512b + 16b for each subpage)
> - Allow to disable subpage reads in the NAND core
>=20
> As a further optimisation we could make ecc.read_subpage overwritable
> for ecc->engine_type =3D=3D NAND_ECC_ENGINE_TYPE_SOFT && ecc->algo =3D=3D
> NAND_ECC_ALGO_BCH. With the OOB layout described above that would be
> easily implementable with the mxc_nand controller.
>=20
> What do you think?

I'm sorry but I feel like I need to answer "no" to all three items
above. It would be totally backwards.

> If you insist I would go the path of making NAND_CMD_RNDOUT work for
> software ECC, although I think it would cause me extra work with no
> clear gain for me.

Yes, please. I believe this command is not that complex to implement,
even with strong (and clearly advertised) limitations. I had a look at
your exec_op() implementation and to the datasheet of the imx27, the
controller clearly supports CMD/ADDR/CMD/DATAIN ops. It's true that you
can only request 16, 512 or 528 bytes, but, why not? It just needs
to be clearly identified that reading more data is not supported. Once
the data is in the local SRAM you just take what you need and done.
=46rom a performance perspective, I don't think this operation will be
used often, at least not in the fast path (see above why), but we need
it for the driver to work properly in all situations.

There is perhaps something that is missing in your current
implementation though: there is a check_only boolean in ->exec_op()
which might require additional handling so that the core does not try to
perform unsupported operations. You can do that either manually by
checking the ops entirely by hand if there are only a couple that
cannot be supported, or leverage the core parser otherwise.

In this case you can have a look at the use of the "struct
nand_op_parser" in the subsystem. Please also don't hesitate to take
inspiration from other drivers, as you might need to advertise
limitations such as a maximum number of command, address or
data cycles (in this case, 528 or 512 if it's easier).

Thanks,
Miqu=C3=A8l


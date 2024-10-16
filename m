Return-Path: <linux-kernel+bounces-368095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF4E9A0B21
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F5262838D7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BAF524B0;
	Wed, 16 Oct 2024 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="GV0QkZ8v";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="K4guGZKZ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C11534E9
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084513; cv=none; b=HyZliEEQrTKtBI73bp25uFTYRWbmCyBdZq0kfB/nIlF6ZV3HMx9rS5EHPa1UCUxfbqWZQjnnvbc8FKMymMbNjZAndoBtReyJ30k9QVzAuemjRoAEuZKO76d456HQm/CutamTQX8CgBteauE/lhHAz8HA5ouyHiIt/59zkQ3VnI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084513; c=relaxed/simple;
	bh=/YjbQv0xi8wt3m4MqV0H2h9hhzbCQ5eFbB9RcYdgb9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C5DoQ44Xl8+rbjgNVDAscvAahlnj2bAkBBZxSgbdV9e8Dzj3+U0idbf8otmparMYz48l3bBPG1hPGgDjXNUkZobf93a2FdXnr9w6nPkkoU5HrFUDVLiPR78/rLkoxnTx6HUCHebXX02I30zkRxpYi06qZnw8BZoLGT5iAMNcTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=GV0QkZ8v; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=K4guGZKZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729084509; x=1760620509;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=bnTavOEUNGQBF8Z5PNFSkC8+akVEFhp1o9XVwbxC+q4=;
  b=GV0QkZ8vkFWT1OQykeiaH9gZQAFsN3p/JcB3Kl4uGrV85ehvbesDX1g+
   zxM3SbCaRvpX/GAqQ3n3wNIBqpsR5CTjy6MqRJ/g+8jgGw2+d9BB4OUyr
   k1iI2C9t2yF6soJKRW2jxN+zZmZaOMM2zgAcUuX6tFq/a4vRPOqljaESk
   Z5UwmvvTV8jMrxEcZHbCOcuaWPPi+UmcMoIXGCR7caq927JIWASGghiTc
   LAFy+/N+RQhn3IMYLwu0ctqL2Okpvcq+AYUjVpO6iPUruBwx77ctBr+K7
   34EsXk+mbM5hTMrS51IXKREw+615OhvHgglPMTlbISb9WJTwVX3BK+4kM
   g==;
X-CSE-ConnectionGUID: dp2fysH4Tc+aI0TUFhsRFw==
X-CSE-MsgGUID: sZyAVIKMTpGF2k4kwY7Scg==
X-IronPort-AV: E=Sophos;i="6.11,208,1725314400"; 
   d="scan'208";a="39496462"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Oct 2024 15:15:07 +0200
X-CheckPoint: {670FBC5B-0-BD84CFBF-E7C15A70}
X-MAIL-CPID: DA531BA824FCDFD95CC9BF12A8CC9D9D_3
X-Control-Analysis: str=0001.0A682F1E.670FBC5B.0047,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D590169931;
	Wed, 16 Oct 2024 15:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729084502;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bnTavOEUNGQBF8Z5PNFSkC8+akVEFhp1o9XVwbxC+q4=;
	b=K4guGZKZk8yalXLMmytKJWw72qTFu2AAhq1RfYL0SQ6qoDQZHS3PCAXMdsIBfvV1vus5py
	BQ7csb8yKahKAfUr0V2dve3liL+mpKfiRd5SiNHr6Obv/NKKyJEtAS74ruJB4Ujo5D2BXa
	6rd2eSC4Rn1eUXm6dFuStMZ3w4YJhL2mEWZurhdXQ2Be8uZba+uy0dlXjeFAWhnSEYZMAY
	ZLRtzEVhNAJBzGHScog8PhSkOI7WonWI/CpHJNLXM74S0jXplnTmLyON/b9eeNWXsoOvTv
	f465t7KMhL+wZbx3kUPeXNkFk+Sd8YXPOqLw4+wie37jbywc0B+l5GNJvF/QgQ==
Message-ID: <e2842ba1ea0f5dfa818e4cbb9aefe343f48c1e53.camel@ew.tq-group.com>
Subject: Re: [PATCH v4 5/5] mfd: tqmx86: add I2C IRQ support
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org, Gregor Herburger
	 <gregor.herburger@tq-group.com>
Date: Wed, 16 Oct 2024 15:14:53 +0200
In-Reply-To: <20241016130715.GA1152434@google.com>
References: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
	 <e44098d2e496fda8220f9965f7a6021c1026eb18.1728286453.git.matthias.schiffer@ew.tq-group.com>
	 <20241015113841.GH8348@google.com>
	 <8fbae19e7e85a8fc8d6f9738155ec8fe44e63061.camel@ew.tq-group.com>
	 <20241016130715.GA1152434@google.com>
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

On Wed, 2024-10-16 at 14:07 +0100, Lee Jones wrote:
>=20
> On Wed, 16 Oct 2024, Matthias Schiffer wrote:
>=20
> > On Tue, 2024-10-15 at 12:38 +0100, Lee Jones wrote:
> > >=20
> > > On Mon, 07 Oct 2024, Matthias Schiffer wrote:
> > >=20
> > > > From: Gregor Herburger <gregor.herburger@tq-group.com>
> > > >=20
> > > > The i2c-ocores controller can run in interrupt mode on tqmx86 modul=
es.
> > > > Add module parameter to allow configuring the IRQ number, similar t=
o the
> > > > handling of the GPIO IRQ.
> > > >=20
> > > > Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
> > > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com=
>
> > > > ---
> > > >=20
> > > > v2: improve module parameter description (was patch 4/4)
> > > > v3: replace IRQ 0 resource with an empty placeholder to simplify er=
ror handling
> > > > v4: no changes
> > > >=20
> > > >  drivers/mfd/tqmx86.c | 20 +++++++++++++++++++-
> > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> > > > index e444fcd2a3e9d..057d035b71d33 100644
> > > > --- a/drivers/mfd/tqmx86.c
> > > > +++ b/drivers/mfd/tqmx86.c
> > > > @@ -50,6 +50,7 @@
> > > >  #define TQMX86_REG_IO_EXT_INT_9			2
> > > >  #define TQMX86_REG_IO_EXT_INT_12		3
> > > >  #define TQMX86_REG_IO_EXT_INT_MASK		0x3
> > > > +#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
> > > >  #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
> > > >  #define TQMX86_REG_SAUC		0x17
> > > > =20
> > > > @@ -60,7 +61,16 @@ static uint gpio_irq;
> > > >  module_param(gpio_irq, uint, 0);
> > > >  MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, =
9, 12)");
> > > > =20
> > > > -static const struct resource tqmx_i2c_soft_resources[] =3D {
> > > > +static uint i2c_irq;
> > > > +module_param(i2c_irq, uint, 0);
> > > > +MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (valid parameters: 7, 9,=
 12)");
> > > > +
> > > > +static struct resource tqmx_i2c_soft_resources[] =3D {
> > > > +	/*
> > > > +	 * Placeholder for IRQ resource - must come first to be filled in=
 by the
> > > > +	 * probe function.
> > > > +	 */
> > > > +	{},
> > >=20
> > > Having a NULLed entry in the first slot doesn't sit well with me at a=
ll.
> > >=20
> > > In order for us to avoid wasting memory, it would be better to place =
the
> > > entry at the end of the array with a blank entry:
> > >=20
> > >   DEFINE_RES_IRQ(0),
> > >=20
> > > Later comes the matching code which updates the 0 value to something =
sane.
> > >=20
> > > Before you call to the add the devices, check to see if the value has
> > > changed.  If it hasn't, deprecate num_resources, effectively masking =
the
> > > last entry in the array.  Then when platform_device_add_resources()
> > > comes to duplicate the array, it will only copy the relevant entries.
> >=20
> > I chose my current solution because it resulted in more simple and main=
tainable code:
> >=20
> > - No dynamic array access, the IRQ resource is always written to index =
0
>=20
> Which is fragile (even with the comment).  If you're going to directly
> index array elements, please do so with a unique identifier rather than
> relying on it happening to reside in the first.
>=20
> > - No surprises regarding num_resources, it is always equal to ARRAY_SIZ=
E(resources)
>=20
> No surprises, but sometimes it's incorrect.
>=20
> > It also allowed to make all mfd_cell const; to make num_resources modif=
yable, either the const would
> > need to be removed, or each mfd_cell would need to be copied to a stack=
 variable in the probe
> > function.
> >=20
> > In my opinion, these benefits outweigh the 2*64 bytes saved for the add=
itional resources allocated
> > by platform_device_add_resources() - and 128 bytes doesn't seem signifi=
cant at all, in particular
> > considering that this driver is used on x86_64 only.
>=20
> But doesn't outweigh my disliking for placing a NULL element at the
> start of the array.  If you _must_ do something like this, please place
> it at the end of the array.
>=20

Ok, will move the placeholder to the end, and access it using a defined ind=
ex instead of 0. I would
still prefer to keep num_resources constant instead of adjusting it. Does t=
his sound acceptable to
you?

Best,
Matthias



> > >=20
> > > >  	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
> > > >  };
> > > > =20
> > > > @@ -263,6 +273,14 @@ static int tqmx86_probe(struct platform_device=
 *pdev)
> > > >  	ocores_platform_data.clock_khz =3D tqmx86_board_id_to_clk_rate(de=
v, board_id);
> > > > =20
> > > >  	if (i2c_det =3D=3D TQMX86_REG_I2C_DETECT_SOFT) {
> > > > +		if (i2c_irq) {
> > > > +			err =3D tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
> > > > +					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
> > > > +			if (!err)
> > > > +				/* Assumes the IRQ resource placeholder is first */
> > > > +				tqmx_i2c_soft_resources[0] =3D DEFINE_RES_IRQ(i2c_irq);
> > > > +		}
> > > > +
> > > >  		err =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> > > >  					   tqmx86_i2c_soft_dev,
> > > >  					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
> > > > --=20
> > > > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefe=
ld, Germany
> > > > Amtsgericht M=C3=BCnchen, HRB 105018
> > > > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, St=
efan Schneider
> > > > https://www.tq-group.com/
> > > >=20
> > >=20
> >=20
> > --=20
> > TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, =
Germany
> > Amtsgericht M=C3=BCnchen, HRB 105018
> > Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan=
 Schneider
> > https://www.tq-group.com/
>=20

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/


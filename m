Return-Path: <linux-kernel+bounces-367995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920729A0940
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4DF287771
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B75208218;
	Wed, 16 Oct 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="i4IACJxg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TSP1QT+b"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C2C204F93
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729081378; cv=none; b=WtZiKfx55lQqH0BnbxBQo7qDTQhDK5YUn/tTH939hzU2V2369dvcSL7UQ4fqTHxbb0zyf9MP5RmRKTKQw6+CPY5SnZYbtlyd0u7cwH72ynRWUcDk3xPh73AXLJpBSvao0mhXgyJanE+mEMjnuOa7nrrEA0YX/ZaRvEAHZyLEPAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729081378; c=relaxed/simple;
	bh=XxIrrhGJnyUqdi34c3MlR5L6E6E2UQIxif5EyUJDw6g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cW5fB7GEd6K1a4Nk2IZF39nBv9Jf6VNBqRsELoH1qY+mwh8AmNbjkFfI0WzxtMWRYX1Lz66nbUu++tB2xPpsn1RYC0S2g6319GyKkMuWG7UzcwCMDKweWSBUT9izrxqmEEK9m81VpPABxLj3HB8QtgYkVrqXuViqc8Gc3lM86sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=i4IACJxg; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=TSP1QT+b reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729081374; x=1760617374;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=p0xcPELN3STlwPj9AAioMd4i3tKN5xU7mWevrcpRaEw=;
  b=i4IACJxgKDZ7DmHziHwwRCJr+asRgPCFCUbYUYKhI/lexBMRGcjS79LU
   R5qXiA6UZEpxZl8W6Hngal/ksAVKcyut6j5fdtrMsyGTApBfOokhCtJrE
   TCqsmZcjuV4hgq3vfM7+KWXXNSz6E96VFC0K+eitkA/qY+9rtvQygxqx5
   i576HqRDNK7lqHipz7WK8MREwiaO29j2S1kbRxU4s+uOXzkNlwziCUREP
   xd0ATQPXsOok3sqtqBpeigc580RPtfopyhRbHTtBjkT+suBoPi97R/asv
   M4EdoF1+yg0w4dWa1awZ53MdFRY9Fx2/7X+cRDFounJ20r1SLtd0C92Pl
   g==;
X-CSE-ConnectionGUID: mkm+CGD+ToSyCCcL4HM7Gw==
X-CSE-MsgGUID: 0UHrYNcbSyeP6KWAImr6ig==
X-IronPort-AV: E=Sophos;i="6.11,208,1725314400"; 
   d="scan'208";a="39494910"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Oct 2024 14:22:51 +0200
X-CheckPoint: {670FB01B-13-8E59014-E6F31237}
X-MAIL-CPID: 2F57A8D0FA4D34A6C61E05E93E531638_1
X-Control-Analysis: str=0001.0A682F2A.670FB01B.00A3,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A22E169A4E;
	Wed, 16 Oct 2024 14:22:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729081367;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=p0xcPELN3STlwPj9AAioMd4i3tKN5xU7mWevrcpRaEw=;
	b=TSP1QT+bMnydoLjLNATEI2UGKWAf1epxwN0DKyTYAl0NriszTUS5asGWyhj2dCJVPSFkYo
	k6qeBmxkhzWIzyUoJK5qihyDDmC97SZ4sm7wTwu5llFYISMgCmDZ4+fxkeuD8Gwuj24/28
	5ELVqqkGqzBtlocOn2fyqqVz3y5Mmrr5MZsPwogh4D1C87I5YrlDzvuAnqUrl90tZiwX+S
	MSpb2Ni/8L8hryejABrV7TxIvpB+KdInDl8PXey2Xt6cIExYnOiHX9wrIAxmNGorW4Eh6j
	5pfz2phAZc0zFz9AmplTjKEJR6sqIBh+tpEYYu8CNkXGXQP8Qxjh0/bZaB2AAw==
Message-ID: <8fbae19e7e85a8fc8d6f9738155ec8fe44e63061.camel@ew.tq-group.com>
Subject: Re: [PATCH v4 5/5] mfd: tqmx86: add I2C IRQ support
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Lee Jones <lee@kernel.org>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org, Gregor Herburger
	 <gregor.herburger@tq-group.com>
Date: Wed, 16 Oct 2024 14:22:45 +0200
In-Reply-To: <20241015113841.GH8348@google.com>
References: <cover.1728286453.git.matthias.schiffer@ew.tq-group.com>
	 <e44098d2e496fda8220f9965f7a6021c1026eb18.1728286453.git.matthias.schiffer@ew.tq-group.com>
	 <20241015113841.GH8348@google.com>
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

On Tue, 2024-10-15 at 12:38 +0100, Lee Jones wrote:
>=20
> On Mon, 07 Oct 2024, Matthias Schiffer wrote:
>=20
> > From: Gregor Herburger <gregor.herburger@tq-group.com>
> >=20
> > The i2c-ocores controller can run in interrupt mode on tqmx86 modules.
> > Add module parameter to allow configuring the IRQ number, similar to th=
e
> > handling of the GPIO IRQ.
> >=20
> > Signed-off-by: Gregor Herburger <gregor.herburger@tq-group.com>
> > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> > ---
> >=20
> > v2: improve module parameter description (was patch 4/4)
> > v3: replace IRQ 0 resource with an empty placeholder to simplify error =
handling
> > v4: no changes
> >=20
> >  drivers/mfd/tqmx86.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
> > index e444fcd2a3e9d..057d035b71d33 100644
> > --- a/drivers/mfd/tqmx86.c
> > +++ b/drivers/mfd/tqmx86.c
> > @@ -50,6 +50,7 @@
> >  #define TQMX86_REG_IO_EXT_INT_9			2
> >  #define TQMX86_REG_IO_EXT_INT_12		3
> >  #define TQMX86_REG_IO_EXT_INT_MASK		0x3
> > +#define TQMX86_REG_IO_EXT_INT_I2C_SHIFT		0
> >  #define TQMX86_REG_IO_EXT_INT_GPIO_SHIFT	4
> >  #define TQMX86_REG_SAUC		0x17
> > =20
> > @@ -60,7 +61,16 @@ static uint gpio_irq;
> >  module_param(gpio_irq, uint, 0);
> >  MODULE_PARM_DESC(gpio_irq, "GPIO IRQ number (valid parameters: 7, 9, 1=
2)");
> > =20
> > -static const struct resource tqmx_i2c_soft_resources[] =3D {
> > +static uint i2c_irq;
> > +module_param(i2c_irq, uint, 0);
> > +MODULE_PARM_DESC(i2c_irq, "I2C IRQ number (valid parameters: 7, 9, 12)=
");
> > +
> > +static struct resource tqmx_i2c_soft_resources[] =3D {
> > +	/*
> > +	 * Placeholder for IRQ resource - must come first to be filled in by =
the
> > +	 * probe function.
> > +	 */
> > +	{},
>=20
> Having a NULLed entry in the first slot doesn't sit well with me at all.
>=20
> In order for us to avoid wasting memory, it would be better to place the
> entry at the end of the array with a blank entry:
>=20
>   DEFINE_RES_IRQ(0),
>=20
> Later comes the matching code which updates the 0 value to something sane=
.
>=20
> Before you call to the add the devices, check to see if the value has
> changed.  If it hasn't, deprecate num_resources, effectively masking the
> last entry in the array.  Then when platform_device_add_resources()
> comes to duplicate the array, it will only copy the relevant entries.

I chose my current solution because it resulted in more simple and maintain=
able code:

- No dynamic array access, the IRQ resource is always written to index 0
- No surprises regarding num_resources, it is always equal to ARRAY_SIZE(re=
sources)

It also allowed to make all mfd_cell const; to make num_resources modifyabl=
e, either the const would
need to be removed, or each mfd_cell would need to be copied to a stack var=
iable in the probe
function.

In my opinion, these benefits outweigh the 2*64 bytes saved for the additio=
nal resources allocated
by platform_device_add_resources() - and 128 bytes doesn't seem significant=
 at all, in particular
considering that this driver is used on x86_64 only.

Best,
Matthias



>=20
> >  	DEFINE_RES_IO(TQMX86_IOBASE_I2C, TQMX86_IOSIZE_I2C),
> >  };
> > =20
> > @@ -263,6 +273,14 @@ static int tqmx86_probe(struct platform_device *pd=
ev)
> >  	ocores_platform_data.clock_khz =3D tqmx86_board_id_to_clk_rate(dev, b=
oard_id);
> > =20
> >  	if (i2c_det =3D=3D TQMX86_REG_I2C_DETECT_SOFT) {
> > +		if (i2c_irq) {
> > +			err =3D tqmx86_setup_irq(dev, "I2C", i2c_irq, io_base,
> > +					       TQMX86_REG_IO_EXT_INT_I2C_SHIFT);
> > +			if (!err)
> > +				/* Assumes the IRQ resource placeholder is first */
> > +				tqmx_i2c_soft_resources[0] =3D DEFINE_RES_IRQ(i2c_irq);
> > +		}
> > +
> >  		err =3D devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
> >  					   tqmx86_i2c_soft_dev,
> >  					   ARRAY_SIZE(tqmx86_i2c_soft_dev),
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


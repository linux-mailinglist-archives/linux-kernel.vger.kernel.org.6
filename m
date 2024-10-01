Return-Path: <linux-kernel+bounces-345633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA1898B866
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 835FCB21266
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B16D19CD07;
	Tue,  1 Oct 2024 09:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TWbp9r4f"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECE92B9B0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775081; cv=none; b=hjvlRxH8DXLrgXaYZj8aMTr9f9NRxT+zUB6IlQsRnwKIwnYbCEzbRuHmLJPpe+g9pTlshS/eKfpXeoRGI+2cToql5veO+VIl98F0ABk0Vgogyn5sqIQZd9y5gaNBlbe2FXwCm4gXe+Ypd9QUDk6+wYO3vygyBjgsOUeZZ55hxY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775081; c=relaxed/simple;
	bh=90whO5u1yrcp6vmdkfG+fVkdMYeOnPdIN+Kt0nefsZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LH8ou4Ftp5livBRNYI4LcZU3AmZkga479vBY3WG0And4+OT0jQGYJrf/GaQHUfNIHPqWewBuTllnaiwWTFgs8rEgWojZnpXOaqgG++AlTb9G2Cj5ExFbKfgN4Nti7X84/YyITGlpvyhbC5Wu8wv2kakZ1VM0pfaTuCxsjiTW3vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TWbp9r4f; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 04C624000A;
	Tue,  1 Oct 2024 09:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727775071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=blxCJn5l+Uj3mKb5XuBI9MwkYtyQvq/AqbPDgoKQ/vU=;
	b=TWbp9r4flefEUAtF/DENepFtFu8XvXe8TPSiZkJtTqopPPpVIsM48P8OQb34CRu/cA5V4q
	hPDjMorGBjOVDknwi+whkQyWYBcH6TSYRCkwxP1ME8TO2wn2OrkzfwC9GrnjJ1T//XGdm2
	MOchDvHB+5h8TH/MKQi0JSbEIw6ylpFGUZjbcFCuViX8v4SbUkMA4soOKpl9Qity2TDjgW
	v1+018+5uPbPC5lHQiHxW1KBQRyCfDXo9i2DvtxSyeM5HPI7tXra6B2F1vxL8gJgRgkXZR
	nExV9iZAPA3FeDtWCNrhOgRe7/vw7mQdAbGUKuS+0Aiv4cPqjChda7rAi4i0RQ==
Date: Tue, 1 Oct 2024 11:31:08 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Michael Walle <michael@walle.cc>, "Mark Brown" <broonie@kernel.org>,
 Chia-Lin Kao <acelan.kao@canonical.com>, "Md Sadre Alam"
 <quic_mdalam@quicinc.com>, Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
 Sridharan S N <quic_sridsn@quicinc.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Alexey Romanov
 <avromanov@salutedevices.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v2 4/5] mtd: spinand: micron: OTP access for
 MT29F2G01ABAGD
Message-ID: <20241001113108.4fdb6360@xps-13>
In-Reply-To: <20240827174920.316756-5-mmkurbanov@salutedevices.com>
References: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
	<20240827174920.316756-5-mmkurbanov@salutedevices.com>
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

Hi Martin,

mmkurbanov@salutedevices.com wrote on Tue, 27 Aug 2024 20:49:02 +0300:

> Support for OTP area access on Micron MT29F2G01ABAGD chip.
>=20
> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> ---
>  drivers/mtd/nand/spi/micron.c | 117 +++++++++++++++++++++++++++++++++-
>  1 file changed, 116 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index 8d741be6d5f3e..a538409db4ccd 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -9,6 +9,7 @@
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/mtd/spinand.h>
> +#include <linux/spi/spi-mem.h>
> =20
>  #define SPINAND_MFR_MICRON		0x2c
> =20
> @@ -28,6 +29,16 @@
> =20
>  #define MICRON_SELECT_DIE(x)	((x) << 6)
> =20
> +#define MICRON_MT29F2G01ABAGD_OTP_PAGES			12
> +#define MICRON_MT29F2G01ABAGD_OTP_PAGE_SIZE		2176

In the core we did add the data size and the OOB size to get the OTP
page size. I would prefer something dynamic here as well, otherwise the
implementation is very device specific for now reason?

> +#define MICRON_MT29F2G01ABAGD_OTP_SIZE_BYTES		\
> +	(MICRON_MT29F2G01ABAGD_OTP_PAGES *		\
> +	 MICRON_MT29F2G01ABAGD_OTP_PAGE_SIZE)

This is a function from the core as well once you've filled all the
information in the core structures, so why hardcoding it?

> +#define MICRON_MT29F2G01ABAGD_CFG_OTP_STATE		BIT(7)
> +#define MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK		\
> +	(CFG_OTP_ENABLE | MICRON_MT29F2G01ABAGD_CFG_OTP_STATE)
> +
>  static SPINAND_OP_VARIANTS(quadio_read_cache_variants,
>  		//SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> @@ -182,6 +193,108 @@ static int micron_8_ecc_get_status(struct spinand_d=
evice *spinand,
>  	return -EINVAL;
>  }
> =20
> +static int mt29f2g01abagd_otp_is_locked(struct spinand_device *spinand)
> +{
> +	size_t buf_size =3D MICRON_MT29F2G01ABAGD_OTP_PAGE_SIZE;
> +	size_t retlen;
> +	u8 *buf;
> +	int ret;
> +
> +	buf =3D kmalloc(buf_size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret =3D spinand_upd_cfg(spinand,
> +			      MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK,
> +			      MICRON_MT29F2G01ABAGD_CFG_OTP_STATE);
> +	if (ret)
> +		goto out;

can we name the label free_buf?

> +
> +	ret =3D spinand_otp_read(spinand, 0, buf_size, buf, &retlen);
> +
> +	if (spinand_upd_cfg(spinand, MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK,
> +			    0)) {
> +		WARN(1, "Can not disable OTP mode\n");

I prefer dev_warn as well here, so we know which device is concerned.

> +		ret =3D -EIO;
> +	}
> +
> +	if (!ret) {

if (ret)
	goto out;

> +		size_t i =3D 0;
> +
> +		/* If all zeros, then the OTP area is locked. */
> +		while (i < buf_size && *(uint32_t *)(&buf[i]) =3D=3D 0)
> +			i +=3D 4;

Shall we expect buf_size to always be a multiple of 4? (real question)

I am not a big fan of the casting game here. I see the optimization
you're attempting to do, but I'm a little bit skeptical. I must admit I
didn't find a helper for that, buf at least maybe you can use an
intermediate variable and loop over it.

> +
> +		if (i =3D=3D buf_size)
> +			ret =3D 1;

If buf_size is not a multiple of 4, this is not gonna work.

> +	}
> +
> +out:
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static int mt29f2g01abagd_otp_info(struct spinand_device *spinand, size_=
t len,
> +				   struct otp_info *buf, size_t *retlen)
> +{
> +	int locked;
> +
> +	if (len < sizeof(*buf))
> +		return -EINVAL;
> +
> +	locked =3D mt29f2g01abagd_otp_is_locked(spinand);
> +	if (locked < 0)
> +		return locked;
> +
> +	buf->locked =3D locked;
> +	buf->start =3D 0;
> +	buf->length =3D MICRON_MT29F2G01ABAGD_OTP_SIZE_BYTES;
> +
> +	*retlen =3D sizeof(*buf);
> +	return 0;
> +}
> +
> +static int mt29f2g01abagd_otp_lock(struct spinand_device *spinand, loff_=
t from,
> +				   size_t len)
> +{
> +	struct spi_mem_op write_op =3D SPINAND_WR_EN_DIS_OP(true);
> +	struct spi_mem_op exec_op =3D SPINAND_PROG_EXEC_OP(0);
> +	int ret;
> +
> +	ret =3D spinand_upd_cfg(spinand,
> +			      MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK,
> +			      MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK);
> +	if (!ret)
> +		return ret;
> +
> +	ret =3D spi_mem_exec_op(spinand->spimem, &write_op);
> +	if (!ret)
> +		goto out;
> +
> +	ret =3D spi_mem_exec_op(spinand->spimem, &exec_op);
> +	if (!ret)
> +		goto out;
> +
> +	ret =3D spinand_wait(spinand, 10, 5, NULL);

Usually I expect timeouts to be bigger.

> +	if (!ret)
> +		goto out;

This goto seems to have not impact :)

> +
> +out:
> +	if (spinand_upd_cfg(spinand, MICRON_MT29F2G01ABAGD_CFG_OTP_LOCK, 0)) {
> +		WARN(1, "Can not disable OTP mode\n");

dev_warn()

> +		ret =3D -EIO;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct spinand_otp_ops mt29f2g01abagd_otp_ops =3D {
> +	.info =3D mt29f2g01abagd_otp_info,
> +	.lock =3D mt29f2g01abagd_otp_lock,
> +	.read =3D spinand_otp_read,
> +	.write =3D spinand_otp_write,
> +};
> +
>  static const struct spinand_info micron_spinand_table[] =3D {
>  	/* M79A 2Gb 3.3V */
>  	SPINAND_INFO("MT29F2G01ABAGD",
> @@ -193,7 +306,9 @@ static const struct spinand_info micron_spinand_table=
[] =3D {
>  					      &x4_update_cache_variants),
>  		     0,
>  		     SPINAND_ECCINFO(&micron_8_ooblayout,
> -				     micron_8_ecc_get_status)),
> +				     micron_8_ecc_get_status),
> +		     SPINAND_OTP_INFO(MICRON_MT29F2G01ABAGD_OTP_PAGES,
> +				      &mt29f2g01abagd_otp_ops)),
>  	/* M79A 2Gb 1.8V */
>  	SPINAND_INFO("MT29F2G01ABBGD",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),


Thanks,
Miqu=C3=A8l


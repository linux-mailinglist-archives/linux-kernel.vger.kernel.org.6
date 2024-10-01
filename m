Return-Path: <linux-kernel+bounces-345643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2592D98B87D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BB01F22722
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A419E7EB;
	Tue,  1 Oct 2024 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ncr7AJWo"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A3D19DFAE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775652; cv=none; b=WtVPh9YdtKsgCQhoYR8Zu0+brkKOiZQ90Ay205t1wKTq6S5a5Lm53RMC05UbAqQDTwdceIS+TTO3ZxT7RKrMJGouhq+jVbX/psnrqOjy51dhjyxSmV8lhywZ6fJyY6gAtkLbWcTtl6qXZOfgJO6sWPnqkZ9V+u65Xy7bIXLJAjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775652; c=relaxed/simple;
	bh=sF9CVSO7wYL93ZeKhueec3+lUvvZNHA0sLOW7tiRXgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uz4JEpRxjcLN3/7O7Omesg/kF3fgTfHyd9tuueK7ejrtd72DkfUFkgRnT3kgZRSfJwjI61zUp6suVRnWly/AS+EeS1ergAPA3e4bd0bC9q2kkuAkPUd5MdqbdMWpZwZxOAkqlwkPIE93nCLe0UfU0/hC0KJ4Ahey9sWlwnA0erI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ncr7AJWo; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7E0BC000A;
	Tue,  1 Oct 2024 09:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727775641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZazbOnVpjyuZ0cs1o3YCCD2imMT96cqbEoNXbGVQQLI=;
	b=ncr7AJWoJiLeGvi2Ta1qMOI1oJx0H/7ixxgSOE6QnANelQBiTwdmimZAZ3+MZ3E2Z5LeDJ
	f+5pMUdxXTLfW0waoGcFCCHQlnLeGAzn3KP4rcyvM0ko1LeoIJvu8adCrpf4Xxm4/tD+Ub
	UVjURf0s6UftoInHeoc+EKH+ZZsjGStucXbvANLXvy0KyzEtJiS+QniiRis8VbRElJ8IfE
	RHlw+fBgKW65bOVtF41MWVhOmWQNnmX60Ce3xxCiAUZKy0Ofbzto3avy264qTR/GI1l84P
	2yzc8VlzipNRqs0UXm3Io4vm5u5XMhgNjWLvxZUE1bX/EXZnh3ruGesenyNoIA==
Date: Tue, 1 Oct 2024 11:40:39 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 1/2] mtd: spi-nand: Add fixups for read retry
Message-ID: <20241001114039.67bab21e@xps-13>
In-Reply-To: <20240905055333.2363358-2-linchengming884@gmail.com>
References: <20240905055333.2363358-1-linchengming884@gmail.com>
	<20240905055333.2363358-2-linchengming884@gmail.com>
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

Hi Cheng Ming,

linchengming884@gmail.com wrote on Thu,  5 Sep 2024 13:53:32 +0800:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> Add fixups for support read retry:
> - Initialize the NAND device maximum retry mode.
> - Set feature on Special Read for Data Recovery register.
>=20
> The Special Read for Data Recovery operation is enabled by Set Feature
> function.
>=20
> There are 5 modes for the user to recover the lost data.
>=20
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> ---
>  drivers/mtd/nand/spi/macronix.c | 79 ++++++++++++++++++++++++++-------
>  include/linux/mtd/spinand.h     | 17 +++++++
>  2 files changed, 81 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macro=
nix.c
> index 3f9e9c572854..baca67ff1cd6 100644
> --- a/drivers/mtd/nand/spi/macronix.c
> +++ b/drivers/mtd/nand/spi/macronix.c
> @@ -9,6 +9,8 @@
>  #include <linux/kernel.h>
>  #include <linux/mtd/spinand.h>
> =20
> +#define MACRONIX_NUM_READ_RETRY_MODES 6

You said 5 in the cover letter?

> +#define MACRONIX_FEATURE_ADDR_READ_RETRY 0x70

Both definitions should probably come...

>  #define SPINAND_MFR_MACRONIX		0xC2
>  #define MACRONIX_ECCSR_MASK		0x0F

...here

> =20
> @@ -100,6 +102,38 @@ static int mx35lf1ge4ab_ecc_get_status(struct spinan=
d_device *spinand,
>  	return -EINVAL;
>  }
> =20
> +/**
> + * macronix_spinand_init_read_retry - Initialize read_retries
> + * @spinand: SPI NAND device
> + *
> + * Return: the number of read retry modes
> + */
> +static int macronix_spinand_init_read_retry(struct spinand_device *spina=
nd)
> +{
> +	return MACRONIX_NUM_READ_RETRY_MODES;

Does not sound very useful as a function?

> +}
> +
> +/**
> + * macronix_spinand_setup_read_retry - Set the retry mode
> + * @spinand: SPI NAND device
> + * @retry_mode: Specify which retry mode to set
> + *
> + * Return: 0 on success, -error otherwise

			, a negative error code otherwise.

> + */
> +static int macronix_spinand_setup_read_retry(struct spinand_device *spin=
and, u8 retry_mode)
> +{
> +	struct spi_mem_op op =3D SPINAND_SET_FEATURE_OP(MACRONIX_FEATURE_ADDR_R=
EAD_RETRY,
> +						      spinand->scratchbuf);
> +
> +	*spinand->scratchbuf =3D retry_mode;
> +	return spi_mem_exec_op(spinand->spimem, &op);
> +}
> +
> +static const struct spi_nand_fixups read_retry_fixups =3D {
> +	.init_read_retry =3D macronix_spinand_init_read_retry,
> +	.setup_read_retry =3D macronix_spinand_setup_read_retry,
> +};
> +

...

> @@ -325,7 +373,8 @@ static const struct spinand_info macronix_spinand_tab=
le[] =3D {
>  					      &update_cache_variants),
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
> -				     mx35lf1ge4ab_ecc_get_status)),
> +				     mx35lf1ge4ab_ecc_get_status),
> +		     SPINAND_FIXUPS(&read_retry_fixups)),
>  	SPINAND_INFO("MX35UF1GE4AC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92, 0x01),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),

I expect a patch targeting the core first, and then the changes in the
Macronix driver.

> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 5c19ead60499..e567d00a2805 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -354,6 +354,7 @@ struct spinand_info {
>  	} op_variants;
>  	int (*select_target)(struct spinand_device *spinand,
>  			     unsigned int target);
> +	const struct spi_nand_fixups *fixups;
>  };
> =20
>  #define SPINAND_ID(__method, ...)					\
> @@ -379,6 +380,9 @@ struct spinand_info {
>  #define SPINAND_SELECT_TARGET(__func)					\
>  	.select_target =3D __func,
> =20
> +#define SPINAND_FIXUPS(__func)					\
> +	.fixups =3D __func,

I don't like the fixups naming. It feels like something is inherently
wrong.

> +
>  #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
>  		     __flags, ...)					\
>  	{								\
> @@ -398,6 +402,16 @@ struct spinand_dirmap {
>  	struct spi_mem_dirmap_desc *rdesc_ecc;
>  };
> =20
> +/**
> + * struct spi_nand_fixups - SPI NAND fixup hooks
> + * @init_read_retry: initialize spinand->read_retries
> + * @setup_read_retry: set the retry mode
> + */
> +struct spi_nand_fixups {
> +	int (*init_read_retry)(struct spinand_device *spinand);
> +	int (*setup_read_retry)(struct spinand_device *spinand, u8 retry_mode);
> +};
> +
>  /**
>   * struct spinand_device - SPI NAND device instance
>   * @base: NAND device instance
> @@ -423,6 +437,7 @@ struct spinand_dirmap {
>   *		the stack
>   * @manufacturer: SPI NAND manufacturer information
>   * @priv: manufacturer private data
> + * @read_retries: the number of read retry modes supported
>   */
>  struct spinand_device {
>  	struct nand_device base;
> @@ -449,8 +464,10 @@ struct spinand_device {
>  	u8 *databuf;
>  	u8 *oobbuf;
>  	u8 *scratchbuf;
> +	const struct spinand_info *info;

This looks like a leftover.

>  	const struct spinand_manufacturer *manufacturer;
>  	void *priv;
> +	int read_retries;

Any reason to keep this variable signed?

>  };
> =20
>  /**


Thanks,
Miqu=C3=A8l


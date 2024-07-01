Return-Path: <linux-kernel+bounces-235777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8491D986
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E791C21CB9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4871A78C8D;
	Mon,  1 Jul 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KdLX/lkw"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF7737142
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719820752; cv=none; b=ZvixL4dpUWnmcZITXdEs5W6s1Z3jAPoW44bBD6VJXeUmAu2G7OFR4rM1QJavPKAbFX95EIm0HZp4nJ7DKxKxwncGD7umghm1xVV+HDEX4Hk5K04zc6M/UXXMV6NomsblCxqX+B4IVSBhtTtaN+gfEQxF1bvFAVF9Ndnav+5JFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719820752; c=relaxed/simple;
	bh=VqEo5x8tReRP6eqJ0VEUTdHpftnZIN6k4UGcxgRM2gg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LxxifGz3wBaP6RuBztqaM4XUEGK4WQeK4GeDCgNV2S9iIr72/cHEdoICEp1Cps8kCVyLYXu7qgwouv4CYLFAJNKfxxLtQevzwUzm0DpXO0fJ2WJG5a1dpZ0cRxbL/WFUlGARd5IEWGqhGXgazyohkFwUt3LiUVit4OL3WWdx+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KdLX/lkw; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DF8DC0007;
	Mon,  1 Jul 2024 07:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719820748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VnYjkt4W+JtgawHTtPYvcvrC4PMbXA6KCWVQb/ZdYAM=;
	b=KdLX/lkwSs2WZA5gbBWSDU+jfClAT46F/z0f5JNLiau4OleWYlWpIywo2/f+T6uW2JFdld
	7Xtz0p7nHmWPYt1bOevGcQmc7ayRCMJq9zgemPwJ85wGiHybdjn7tDi2rzXpneQx14Hhaz
	iRqYcnP3XbrFhPnqNwXaOYLOehe8C20qIdLXdO2W5S79Fa/baFqZKjXx9xCEIWxxqgfmD7
	Cjsn/FVQyeaZBOc5ZYFFWgW3DfDrqYzLwxTq5II34PAs+Z6lAgGLJxzCaH5rHkBqaant9j
	YPkrtYcRh9oQV7KhUiGltqd57B4PwrBiexxW9hpNLK/HzCEaPQHHb5WbTYensQ==
Date: Mon, 1 Jul 2024 09:59:06 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maxim Anisimov <maxim.anisimov.ua@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Martin Kurbanov <mmkurbanov@salutedevices.com>, Michael
 Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>, "Chia-Lin Kao
 (AceLan)" <acelan.kao@canonical.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: spinand: Add support for HeYangTek HYF1GQ4UDACAE
Message-ID: <20240701095906.2bc4a0d2@xps-13>
In-Reply-To: <20240624061246.5292-1-maxim.anisimov.ua@gmail.com>
References: <20240624061246.5292-1-maxim.anisimov.ua@gmail.com>
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

Hi Maxim,

maxim.anisimov.ua@gmail.com wrote on Mon, 24 Jun 2024 09:12:17 +0300:

> Add Support HeYangTek HYF1GQ4UDACAE SPI NAND.
>=20
> Datasheet Link:
> - https://www.heyangtek.cn/previewfile.jsp?file=3DABUIABA9GAAgwsvRnwYo-eD=
psgc

Thanks for the patch! Few comments below.

> Signed-off-by: Maxim Anisimov <maxim.anisimov.ua@gmail.com>
> ---
>  drivers/mtd/nand/spi/Makefile    |   4 +-
>  drivers/mtd/nand/spi/core.c      |   1 +
>  drivers/mtd/nand/spi/heyangtek.c | 112 +++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h      |   1 +
>  4 files changed, 116 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/heyangtek.c
>=20
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 19cc77288ebb..69d95fbdd0ce 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs :=3D core.o alliancememory.o ato.o esmt.o foresee.o gigadev=
ice.o macronix.o
> -spinand-objs +=3D micron.o paragon.o toshiba.o winbond.o xtx.o
> +spinand-objs :=3D core.o alliancememory.o ato.o esmt.o foresee.o gigadev=
ice.o heyangtek.o
> +spinand-objs +=3D macronix.o micron.o paragon.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index e0b6715e5dfe..45795e5f1e49 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -942,6 +942,7 @@ static const struct spinand_manufacturer *spinand_man=
ufacturers[] =3D {
>  	&esmt_c8_spinand_manufacturer,
>  	&foresee_spinand_manufacturer,
>  	&gigadevice_spinand_manufacturer,
> +	&heyangtek_spinand_manufacturer,
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
>  	&paragon_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/heyangtek.c b/drivers/mtd/nand/spi/heya=
ngtek.c
> new file mode 100644
> index 000000000000..d4a5dbca40fb
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/heyangtek.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author:
> + *      Andrey Zolotarev <andrey.zolotarev@keenetic.com> - the main driv=
er logic
> + *      Maxim Anisimov <maxim.anisimov.ua@gmail.com> - adaptation to mai=
nline linux kernel
> + *
> + * Based on:
> + *      https://github.com/keenetic/kernel-49/commit/bacade569fb12bc0ad3=
1ba09bca9b890118fbca7
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_HEYANGTEK		0xC9
> +
> +#define STATUS_ECC_LIMIT_BITFLIPS	(3 << 4)
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +		SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> +		SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int hyfxgq4uda_ooblayout_ecc(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	region->offset =3D section * 16 + 8;
> +	region->length =3D 8;

This is: 8-15, 24-31, 40-47, 56-62

> +
> +	return 0;
> +}
> +
> +static int hyfxgq4uda_ooblayout_free(struct mtd_info *mtd, int section,
> +				   struct mtd_oob_region *region)
> +{
> +	if (section > 3)
> +		return -ERANGE;
> +
> +	/* ECC-protected user meta-data */
> +	region->offset =3D section * 16 + 4;
> +	region->length =3D 4;

This is: 4-7, 20-23, 32-35, 48-51

So what about 2-4, 16-19, 36-39, 52-55, 63-64 ?

> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops hyfxgq4uda_ooblayout =3D {
> +	.ecc =3D hyfxgq4uda_ooblayout_ecc,
> +	.free =3D hyfxgq4uda_ooblayout_free,
> +};
> +
> +static int hyfxgq4uda_ecc_get_status(struct spinand_device *spinand,
> +				     u8 status)
> +{
> +	struct nand_device *nand =3D spinand_to_nand(spinand);
> +
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case STATUS_ECC_UNCOR_ERROR:
> +		return -EBADMSG;
> +
> +	case STATUS_ECC_HAS_BITFLIPS:
> +		return nanddev_get_ecc_conf(nand)->strength >> 1;

Maybe an explanation of this line is needed. Is this just guessing or
is this defined in the datasheet?

Also please do not use shifts when you want to divide. Just use / 2
which is easier to understand. Compilers know how to optimize that.

> +
> +	case STATUS_ECC_LIMIT_BITFLIPS:
> +		return nanddev_get_ecc_conf(nand)->strength;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct spinand_info heyangtek_spinand_table[] =3D {
> +	SPINAND_INFO("HYF1GQ4UDACAE",
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x21),
> +		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +		     NAND_ECCREQ(4, 512),
> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					      &write_cache_variants,
> +					      &update_cache_variants),
> +		     SPINAND_HAS_QE_BIT,
> +		     SPINAND_ECCINFO(&hyfxgq4uda_ooblayout,
> +				     hyfxgq4uda_ecc_get_status)),
> +};
> +
> +static const struct spinand_manufacturer_ops heyangtek_spinand_manuf_ops=
 =3D {
> +};
> +
> +const struct spinand_manufacturer heyangtek_spinand_manufacturer =3D {
> +	.id =3D SPINAND_MFR_HEYANGTEK,
> +	.name =3D "HeYangTek",
> +	.chips =3D heyangtek_spinand_table,
> +	.nchips =3D ARRAY_SIZE(heyangtek_spinand_table),
> +	.ops =3D &heyangtek_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 5c19ead60499..06ee35a27e3b 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -265,6 +265,7 @@ extern const struct spinand_manufacturer ato_spinand_=
manufacturer;
>  extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
>  extern const struct spinand_manufacturer foresee_spinand_manufacturer;
>  extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
> +extern const struct spinand_manufacturer heyangtek_spinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
>  extern const struct spinand_manufacturer paragon_spinand_manufacturer;


Thanks,
Miqu=C3=A8l


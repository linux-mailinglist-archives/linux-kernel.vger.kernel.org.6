Return-Path: <linux-kernel+bounces-293495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F1958080
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B084B21CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDA9189BBD;
	Tue, 20 Aug 2024 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WrgUVyn0"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A46117C988
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141155; cv=none; b=iljblF/gC9hXdSXhjZihKsck74GuT7MiInPikmaUWPmC2td9P1c0yFBzHOYMuXP6bSVxqiNP/9cQJDJ1VLF3zwjVoDA3vlUKB3/QxWHymH3gdtXNUfqw9v923ulBYm0TsfoNSZGBfoVRcF1OW3DyXWYZbdq+htVRcsKE5m+sfms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141155; c=relaxed/simple;
	bh=1hA6vQxLeI6LXHkRQlqXTVZHmI8rKcAWXTEDpqDcbQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ahp0SiDVac/XmRar+rr8xxZKXCcgsQPLRFKkDooYSyqi1vQ9CEJ3z9SgG8U/HobvLnX/mIW4sWeiLxg0SBlPtvZCAcIuEBLh6UD3rQPqCcgXZaEqwUNEIQ3hERjvQsLOq7ofqz5tjtsXFsWqpWmnZfQpjijYCLL+IFcRdGswb+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WrgUVyn0; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 99CA640007;
	Tue, 20 Aug 2024 08:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724141144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSEoN+U6F77zcDOfBwap1b4cPlVZZGGjqoeECh7006g=;
	b=WrgUVyn0vTqosot4mELnfYpx3opzwojK1I4oFxl2GnwxnfsDhsxNLJOKrV8CweVcQx6or5
	oCfkXbbSKcGrzHVcLUt8Y/MpMciYANjGIvKesEeY0d+2D5K2n+kitLBs1Kh7B0GXyU6oXg
	FR0MjP3BjicQ8v13zN/bAoVjtnWP2fLRERFw55QOqNiivYlbIKjTjIJfjU+X5VF3HZxHP/
	DIzTnzCeMnPfqRAjKwRgW01a34fF+jPuhllXT4LLRFPLiekrZs0T7iWEY1XMLZLOkMAEjU
	UPY0/0PPiRjjD8b5Jqmxy7cjH/HGFJQuVr/E+K/zYYSJUtyLmlX8ipgSqjeKXw==
Date: Tue, 20 Aug 2024 10:05:42 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: KR Kim <kr.kim@skyhighmemory.com>
Cc: richard@nod.at, vigneshr@ti.com, mmkurbanov@salutedevices.com,
 broonie@kernel.org, tudor.ambarus@linaro.org,
 mika.westerberg@linux.intel.com, acelan.kao@canonical.com,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 zhi.feng@skyhighmemory.com, moh.sardi@skyhighmemory.com,
 Takahiro.Kuwano@infineon.com, changsub.shim@skyhighmemory.com
Subject: Re: [PATCH] mtd: spinand: add support for SkyHigh Memory ML-3 SPI
 NAND Flash family
Message-ID: <20240820100542.31e482b3@xps-13>
In-Reply-To: <20240820064547.5035-1-kr.kim@skyhighmemory.com>
References: <20240820064547.5035-1-kr.kim@skyhighmemory.com>
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

Hi,

kr.kim@skyhighmemory.com wrote on Tue, 20 Aug 2024 15:45:47 +0900:

> This patch has been added to operate properly on SkyHigh memory's SPI NAN=
D.
> This patch is derived from Takahiro's work who is author.
>=20
> Added:=09
> 	- Some patch code for the SkyHigh Memory ML-3 SPI NAND Flash family.
> Created:=20
> 	- skyhigh.c

This is not a correct commit log, please read the submitting process
doc.

> =09
> Signed-off-by: KR Kim <kr.kim@skyhighmemory.com>
> ---
>  drivers/mtd/nand/spi/Makefile  |   2 +-
>  drivers/mtd/nand/spi/core.c    |   7 +-
>  drivers/mtd/nand/spi/skyhigh.c | 146 +++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h    |   3 +
>  4 files changed, 156 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/skyhigh.c
>=20
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 19cc77288ebb..1e61ab21893a 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  spinand-objs :=3D core.o alliancememory.o ato.o esmt.o foresee.o gigadev=
ice.o macronix.o
> -spinand-objs +=3D micron.o paragon.o toshiba.o winbond.o xtx.o
> +spinand-objs +=3D micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index e0b6715e5dfe..4a25ed49a61f 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -34,7 +34,7 @@ static int spinand_read_reg_op(struct spinand_device *s=
pinand, u8 reg, u8 *val)
>  	return 0;
>  }
> =20
> -static int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, =
u8 val)
> +int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val)

This should be done in a preliminary patch.

>  {
>  	struct spi_mem_op op =3D SPINAND_SET_FEATURE_OP(reg,
>  						      spinand->scratchbuf);
> @@ -196,6 +196,10 @@ static int spinand_init_quad_enable(struct spinand_d=
evice *spinand)
>  static int spinand_ecc_enable(struct spinand_device *spinand,
>  			      bool enable)
>  {
> +	/* SHM : always ECC On */
> +	if (spinand->flags & SPINAND_ON_DIE_ECC_MANDATORY)
> +		return 0;

Do you have a datasheet? Can we really not disable the correction?

> +
>  	return spinand_upd_cfg(spinand, CFG_ECC_ENABLE,
>  			       enable ? CFG_ECC_ENABLE : 0);

How can this be useful if the engine cannot be disabled?

>  }
> @@ -945,6 +949,7 @@ static const struct spinand_manufacturer *spinand_man=
ufacturers[] =3D {
>  	&macronix_spinand_manufacturer,
>  	&micron_spinand_manufacturer,
>  	&paragon_spinand_manufacturer,
> +	&skyhigh_spinand_manufacturer,
>  	&toshiba_spinand_manufacturer,
>  	&winbond_spinand_manufacturer,
>  	&xtx_spinand_manufacturer,
> diff --git a/drivers/mtd/nand/spi/skyhigh.c b/drivers/mtd/nand/spi/skyhig=
h.c
> new file mode 100644
> index 000000000000..5829e8a9344b
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/skyhigh.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 SkyHigh Memory Limited
> + *
> + * Author: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> + * Co-Author: KR Kim <kr.kim@skyhighmemory.com>
> + * This patch is derived from Takahiro's work.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_SKYHIGH		0x01
> +
> +#define SKYHIGH_STATUS_ECC_1TO2_BITFLIPS	(1 << 4)
> +#define SKYHIGH_STATUS_ECC_3TO6_BITFLIPS	(2 << 4)
> +#define SKYHIGH_STATUS_ECC_UNCOR_ERROR		(3 << 4)
> +
> +#define SKYHIGH_CONFIG_PROTECT_EN	BIT(1)
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
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
> +static int skyhigh_spinand_ooblayout_ecc(struct mtd_info *mtd, int secti=
on,
> +					 struct mtd_oob_region *region)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	region->offset =3D mtd->oobsize;

That's not possible

> +	region->length =3D mtd->oobsize / 2;
> +
> +	return 0;
> +}
> +
> +static int skyhigh_spinand_ooblayout_free(struct mtd_info *mtd, int sect=
ion,
> +					  struct mtd_oob_region *region)
> +{
> +	if (section)
> +		return -ERANGE;
> +
> +	region->offset =3D 2;
> +	region->length =3D mtd->oobsize - 2;

Aren't the ECC bytes visible?
(if so, a comment is needed)

> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops skyhigh_spinand_ooblayout =3D {
> +	.ecc =3D skyhigh_spinand_ooblayout_ecc,
> +	.free =3D skyhigh_spinand_ooblayout_free,
> +};
> +
> +static int skyhigh_spinand_ecc_get_status(struct spinand_device *spinand=
, u8 status)
> +{
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case SKYHIGH_STATUS_ECC_1TO2_BITFLIPS:
> +		return 2;
> +
> +	case SKYHIGH_STATUS_ECC_3TO6_BITFLIPS:
> +		return 6;
> +
> +	case SKYHIGH_STATUS_ECC_UNCOR_ERROR:
> +		return -EBADMSG;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct spinand_info skyhigh_spinand_table[] =3D {
> +	SPINAND_INFO("S35ML01G301",
> +			SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x15),
> +			NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +			NAND_ECCREQ(6, 32),
> +			SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +						&write_cache_variants,
> +						&update_cache_variants),
> +			SPINAND_ON_DIE_ECC_MANDATORY,
> +			SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +			skyhigh_spinand_ecc_get_status)),

Indentation (same below)

> +	SPINAND_INFO("S35ML01G300",
> +			SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x14),
> +			NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +			NAND_ECCREQ(6, 32),
> +			SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					&write_cache_variants,
> +					&update_cache_variants),
> +			SPINAND_ON_DIE_ECC_MANDATORY,
> +			SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +			skyhigh_spinand_ecc_get_status)),
> +	SPINAND_INFO("S35ML02G300",
> +			SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x25),
> +			NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
> +			NAND_ECCREQ(6, 32),
> +			SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					&write_cache_variants,
> +					&update_cache_variants),
> +			SPINAND_ON_DIE_ECC_MANDATORY,
> +			SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +			skyhigh_spinand_ecc_get_status)),
> +	SPINAND_INFO("S35ML04G300",
> +			SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x35),
> +			NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 2, 1, 1),
> +			NAND_ECCREQ(6, 32),
> +			SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +					&write_cache_variants,
> +					&update_cache_variants),
> +			SPINAND_ON_DIE_ECC_MANDATORY,
> +			SPINAND_ECCINFO(&skyhigh_spinand_ooblayout,
> +			skyhigh_spinand_ecc_get_status)),
> +};
> +
> +static int skyhigh_spinand_init(struct spinand_device *spinand)
> +{
> +	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK,
> +				SKYHIGH_CONFIG_PROTECT_EN);
> +}
> +
> +static const struct spinand_manufacturer_ops skyhigh_spinand_manuf_ops =
=3D {
> +	.init =3D skyhigh_spinand_init,
> +};
> +
> +const struct spinand_manufacturer skyhigh_spinand_manufacturer =3D {
> +	.id =3D SPINAND_MFR_SKYHIGH,
> +	.name =3D "SkyHigh",
> +	.chips =3D skyhigh_spinand_table,
> +	.nchips =3D ARRAY_SIZE(skyhigh_spinand_table),
> +	.ops =3D &skyhigh_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 5c19ead60499..421c3ce704e7 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -268,6 +268,7 @@ extern const struct spinand_manufacturer gigadevice_s=
pinand_manufacturer;
>  extern const struct spinand_manufacturer macronix_spinand_manufacturer;
>  extern const struct spinand_manufacturer micron_spinand_manufacturer;
>  extern const struct spinand_manufacturer paragon_spinand_manufacturer;
> +extern const struct spinand_manufacturer skyhigh_spinand_manufacturer;
>  extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>  extern const struct spinand_manufacturer winbond_spinand_manufacturer;
>  extern const struct spinand_manufacturer xtx_spinand_manufacturer;
> @@ -312,6 +313,7 @@ struct spinand_ecc_info {
> =20
>  #define SPINAND_HAS_QE_BIT		BIT(0)
>  #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
> +#define SPINAND_ON_DIE_ECC_MANDATORY	BIT(2)
> =20
>  /**
>   * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine st=
ructure
> @@ -518,5 +520,6 @@ int spinand_match_and_init(struct spinand_device *spi=
nand,
> =20
>  int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
>  int spinand_select_target(struct spinand_device *spinand, unsigned int t=
arget);
> +int spinand_write_reg_op(struct spinand_device *spinand, u8 reg, u8 val);
> =20
>  #endif /* __LINUX_MTD_SPINAND_H */


Thanks,
Miqu=C3=A8l


Return-Path: <linux-kernel+bounces-254909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0763933927
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5416BB21B37
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC8538DD1;
	Wed, 17 Jul 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="igNCwyUn"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39DB3A29A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205390; cv=none; b=CETJdZf8uktwuUgwWvZGm+dRwyAI0eZnv9Evx1RIHHfurM7uBq4xC1rK3mOfNloJADpazu5VOExJ15tV3A8MgI6h28bAq5lt/DE6V9i5TWvZRSA+v5sXZtAbCr75KjDIvcUWGnSmflPTtSbWAOWOALJeak7nHmxHoncVGW+vNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205390; c=relaxed/simple;
	bh=Vt84Nx3fmxgWFWh7DtODAWjYhbXeJWjjA/s6+2UFVOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ilZSCau6VXAOxEYi3qotXWRPwCrgr2VnNFApvNSzaYj26yQLLEUVNOpFyXRFwaYACVza5FXQ2GQdxVGzTZSYxFLCDZYrJHb2mDDgHeaoc8HO8Ta69oWZqAp8+rfGQSI0tKa9br4d0nQ4PFOW2/5BUXHn9ekOY9MZvhsh9s1UbZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=igNCwyUn; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2089240004;
	Wed, 17 Jul 2024 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721205385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i6ol4Bte/dLJMoc78J1RFMZuqxdHcs0gCbCQIiakg7o=;
	b=igNCwyUn/7wJskLh2DTD+whtMcrLekNXwDt/yAmCT4SQ0yjIzzxblbIhAhguFtCFw5weMG
	fSQeNslhVc2/6x02zvuK/ynmBxqbhNULKPFa+eipJmA0M0e0g9u2MESsWibnUE5Vj31tQf
	46hnBU5MlDVea0X999DUKs+ZsUOQURgMBo1o3FURNdhNTLNfKqmUboElAbVnQypd97N+d2
	wulwVQjtma7GXaZ8k6ejAOM3wi8oBZA49f6Ot8t2OpHkdQLdFT1cYmuM9aV77nnw0xdtCY
	3aAGPt3n1VdBnQPynYQw6ouYjEBArOPOcWoTUwnqHSio2VfhOVw00fMvXSwwXA==
Date: Wed, 17 Jul 2024 10:36:23 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Michael Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>, Chia-Lin
 Kao <acelan.kao@canonical.com>, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>, Sridharan S N
 <quic_sridsn@quicinc.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <kernel@salutedevices.com>
Subject: Re: [PATCH v1 2/5] mtd: spinand: add OTP support
Message-ID: <20240717103623.6d6b63be@xps-13>
In-Reply-To: <20240617133504.179705-3-mmkurbanov@salutedevices.com>
References: <20240617133504.179705-1-mmkurbanov@salutedevices.com>
	<20240617133504.179705-3-mmkurbanov@salutedevices.com>
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

Hi Martin,

mmkurbanov@salutedevices.com wrote on Mon, 17 Jun 2024 16:34:54 +0300:

> The MTD subsystem already supports accessing two OTP areas: user and
> factory. User areas can be written by the user. This patch only adds
> support for the user areas.
>=20
> In this patch the OTP_INFO macro is provided to add parameters to
> spinand_info.
> To implement OTP operations, the client (flash driver) is provided with
> 5 callbacks: .read(), .write(), .info(), .lock(), .erase().

Good job! Please find minor comments below.

>=20
> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> ---
>  drivers/mtd/nand/spi/Makefile |   3 +-
>  drivers/mtd/nand/spi/core.c   |   3 +
>  drivers/mtd/nand/spi/otp.c    | 219 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |  56 +++++++++
>  4 files changed, 280 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/otp.c
>=20
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index 19cc77288ebbc..60d2e830ffc6b 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -spinand-objs :=3D core.o alliancememory.o ato.o esmt.o foresee.o gigadev=
ice.o macronix.o
> +spinand-objs :=3D core.o otp.o
> +spinand-objs +=3D alliancememory.o ato.o esmt.o foresee.o gigadevice.o m=
acronix.o
>  spinand-objs +=3D micron.o paragon.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 807c24b0c7c4f..2cb825edd49d0 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1111,6 +1111,7 @@ int spinand_match_and_init(struct spinand_device *s=
pinand,
>  		spinand->flags =3D table[i].flags;
>  		spinand->id.len =3D 1 + table[i].devid.len;
>  		spinand->select_target =3D table[i].select_target;
> +		spinand->otp =3D &table[i].otp;
> =20
>  		op =3D spinand_select_op_variant(spinand,
>  					       info->op_variants.read_cache);
> @@ -1292,6 +1293,8 @@ static int spinand_init(struct spinand_device *spin=
and)
>  	mtd->_max_bad_blocks =3D nanddev_mtd_max_bad_blocks;
>  	mtd->_resume =3D spinand_mtd_resume;
> =20
> +	spinand_set_mtd_otp_ops(spinand);
> +
>  	if (nand->ecc.engine) {
>  		ret =3D mtd_ooblayout_count_freebytes(mtd);
>  		if (ret < 0)
> diff --git a/drivers/mtd/nand/spi/otp.c b/drivers/mtd/nand/spi/otp.c
> new file mode 100644
> index 0000000000000..e1f96b1898dcb
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/otp.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
> + *
> + * Author: Martin Kurbanov <mmkurbanov@salutedevices.com>
> + */
> +
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/spinand.h>
> +
> +static size_t spinand_otp_size(struct spinand_device *spinand)
> +{
> +	struct nand_device *nand =3D spinand_to_nand(spinand);
> +	size_t otp_pagesize =3D nanddev_page_size(nand) +
> +			      nanddev_per_page_oobsize(nand);
> +
> +	return spinand->otp->layout.npages * otp_pagesize;
> +}
> +
> +static unsigned int spinand_otp_npages(const struct spinand_device *spin=
and)
> +{
> +	return spinand->otp->layout.npages;

Maybe you can move this helper up and use it in spinand_otp_size().

> +}
> +

...

> +static int spinand_mtd_otp_rw(struct mtd_info *mtd, loff_t ofs, size_t l=
en,
> +			      size_t *retlen, u8 *buf, bool is_write)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +	const struct spinand_otp_ops *ops =3D spinand->otp->ops;
> +	size_t total_len =3D len;
> +	int ret;
> +
> +	if (ofs < 0 || ofs + len > spinand_otp_size(spinand))
> +		return -EINVAL;
> +

Please just check if (!len) here

> +	total_len =3D min_t(size_t, total_len, spinand_otp_size(spinand) - ofs);

                                  len ^^^

Here you can just compute the minimum and don't check the output. It
will be simpler to understand.

> +	if (!total_len)
> +		return 0;
> +
> +	mutex_lock(&spinand->lock);
> +
> +	ret =3D spinand_upd_cfg(spinand, CFG_OTP_ENABLE, CFG_OTP_ENABLE);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (is_write)
> +		ret =3D ops->write(spinand, ofs, len, buf, retlen);
> +	else
> +		ret =3D ops->read(spinand, ofs, len, buf, retlen);
> +
> +	if (spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0)) {
> +		WARN(1, "Can not disable OTP mode\n");

Please avoid WARN() statements like that. A normal pr_warn is enough.

> +		ret =3D -EIO;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&spinand->lock);
> +	return ret;
> +}
> +
> +static int spinand_mtd_otp_read(struct mtd_info *mtd, loff_t from, size_=
t len,

Can you keep the naming consistent?                 ofs vs. from  ^

> +				size_t *retlen, u8 *buf)
> +{
> +	return spinand_mtd_otp_rw(mtd, from, len, retlen, buf, false);
> +}
> +
> +static int spinand_mtd_otp_write(struct mtd_info *mtd, loff_t to, size_t=
 len,
> +				 size_t *retlen, const u8 *buf)
> +{
> +	return spinand_mtd_otp_rw(mtd, to, len, retlen, (u8 *)buf, true);
> +}
> +
> +static int spinand_mtd_otp_erase(struct mtd_info *mtd, loff_t from, size=
_t len)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +	const struct spinand_otp_ops *ops =3D spinand->otp->ops;
> +	int ret;
> +
> +	if (!ops->erase)
> +		return -EOPNOTSUPP;
> +
> +	if (!len)
> +		return 0;

This check seems sensible but is absent in the other helpers. Any
reason? Please add it to _lock() and _rw()

> +
> +	if (from < 0 || (from + len) > spinand_otp_size(spinand))
> +		return -EINVAL;

And this is also repeated three times, it is probably worth factorizing
out.

> +
> +	mutex_lock(&spinand->lock);
> +	ret =3D ops->erase(spinand, from, len);
> +	mutex_unlock(&spinand->lock);
> +
> +	return ret;
> +}
> +
> +static int spinand_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_=
t len)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +	const struct spinand_otp_ops *ops =3D spinand->otp->ops;
> +	int ret;
> +
> +	if (!ops->lock)
> +		return -EOPNOTSUPP;
> +
> +	if (from < 0 || (from + len) > spinand_otp_size(spinand))
> +		return -EINVAL;
> +
> +	mutex_lock(&spinand->lock);
> +	ret =3D ops->lock(spinand, from, len);
> +	mutex_unlock(&spinand->lock);
> +
> +	return ret;
> +}
> +
> +/**
> + * spinand_set_mtd_otp_ops() - Set up OTP methods
> + * @spinand: the spinand device
> + *
> + * Set up OTP methods.
> + */
> +void spinand_set_mtd_otp_ops(struct spinand_device *spinand)
> +{
> +	struct mtd_info *mtd =3D spinand_to_mtd(spinand);
> +
> +	if (!spinand->otp->ops)
> +		return;
> +
> +	mtd->_get_user_prot_info =3D spinand_mtd_otp_info;
> +	mtd->_read_user_prot_reg =3D spinand_mtd_otp_read;
> +	mtd->_write_user_prot_reg =3D spinand_mtd_otp_write;
> +	mtd->_lock_user_prot_reg =3D spinand_mtd_otp_lock;
> +	mtd->_erase_user_prot_reg =3D spinand_mtd_otp_erase;
> +}
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 555846517faf6..a0d42a9be333f 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -322,6 +322,43 @@ struct spinand_ondie_ecc_conf {
>  	u8 status;
>  };
> =20
> +/**
> + * struct spinand_otp_layout - structure to describe the SPI NAND OTP ar=
ea
> + * @npages: number of pages in the OTP
> + */
> +struct spinand_otp_layout {
> +	unsigned int npages;
> +};
> +
> +/**
> + * struct spinand_otp_ops - SPI NAND OTP methods
> + * @info: Get the OTP area information
> + * @lock: lock an OTP region
> + * @erase: erase an OTP region
> + * @read: read from the SPI NAND OTP area
> + * @write: write to the SPI NAND OTP area
> + */
> +struct spinand_otp_ops {
> +	int (*info)(struct spinand_device *spinand, size_t len,
> +		    struct otp_info *buf, size_t *retlen);
> +	int (*lock)(struct spinand_device *spinand, loff_t from, size_t len);
> +	int (*erase)(struct spinand_device *spinand, loff_t from, size_t len);
> +	int (*read)(struct spinand_device *spinand, loff_t from, size_t len,
> +		    u8 *buf, size_t *retlen);
> +	int (*write)(struct spinand_device *spinand, loff_t from, size_t len,
> +		     const u8 *buf, size_t *retlen);
> +};
> +
> +/**
> + * struct spinand_otp - SPI NAND OTP grouping structure
> + * @layout: OTP region layout
> + * @ops: OTP access ops
> + */
> +struct spinand_otp {
> +	const struct spinand_otp_layout layout;
> +	const struct spinand_otp_ops *ops;
> +};
> +
>  /**
>   * struct spinand_info - Structure used to describe SPI NAND chips
>   * @model: model name
> @@ -354,6 +391,7 @@ struct spinand_info {
>  	} op_variants;
>  	int (*select_target)(struct spinand_device *spinand,
>  			     unsigned int target);
> +	struct spinand_otp otp;
>  };
> =20
>  #define SPINAND_ID(__method, ...)					\
> @@ -379,6 +417,14 @@ struct spinand_info {
>  #define SPINAND_SELECT_TARGET(__func)					\
>  	.select_target =3D __func,
> =20
> +#define SPINAND_OTP_INFO(__npages, __ops)				\
> +	.otp =3D {							\
> +		.layout =3D {						\
> +			.npages =3D __npages,				\
> +		},							\
> +		.ops =3D __ops,						\
> +	}
> +
>  #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
>  		     __flags, ...)					\
>  	{								\
> @@ -422,6 +468,7 @@ struct spinand_dirmap {
>   *		passed in spi_mem_op be DMA-able, so we can't based the bufs on
>   *		the stack
>   * @manufacturer: SPI NAND manufacturer information
> + * @otp: SPI NAND OTP info.
>   * @priv: manufacturer private data
>   */
>  struct spinand_device {
> @@ -450,6 +497,7 @@ struct spinand_device {
>  	u8 *oobbuf;
>  	u8 *scratchbuf;
>  	const struct spinand_manufacturer *manufacturer;
> +	const struct spinand_otp *otp;
>  	void *priv;
>  };
> =20
> @@ -525,4 +573,12 @@ int spinand_read_page(struct spinand_device *spinand,
>  int spinand_write_page(struct spinand_device *spinand,
>  		       const struct nand_page_io_req *req);
> =20
> +void spinand_set_mtd_otp_ops(struct spinand_device *spinand);
> +
> +int spinand_otp_read(struct spinand_device *spinand, loff_t from, size_t=
 len,
> +		     u8 *buf, size_t *retlen);
> +
> +int spinand_otp_write(struct spinand_device *spinand, loff_t from, size_=
t len,
> +		      const u8 *buf, size_t *retlen);
> +

Why exposing spinand_otp_read and spinand_otp_write ?

>  #endif /* __LINUX_MTD_SPINAND_H */


Thanks,
Miqu=C3=A8l


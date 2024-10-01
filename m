Return-Path: <linux-kernel+bounces-345610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7204198B80B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A00D1C21E60
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E219F19D09F;
	Tue,  1 Oct 2024 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="igZKjK1K"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7319D090
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773958; cv=none; b=rMTD6NNPr8Bq/uRFfNq4CVTclVVFAAbjOMZU/aN2QEiXrnxty9YEKAxypbZbNm+6FU0oo+Hlg0OXtchS3lr7Bbjkg9l35DvSFuBD/CrU8lMmY+CKMZjyWRYRjIID+iB27xffMLLPzIeRr0fOLKQOylb++fnqOwiXtUSl1kFvFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773958; c=relaxed/simple;
	bh=1B6wHs3i1LAve3450/x0qkEQTXwCiB4C7r3gEz/9hh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzdU3rFq28zI7XId6fBOQOKg6bEI3aYLkB74nhXSJvEFMZwAFox0wI3Vk4u2Ojrvg/l+Ebcv819O1EYkhCFthVM3bI7leWw1+Mg3FeH8HQhJD5zMXAEWnt14mG2gp2zWie7b8e4jHaTesCMQlro+Y0j1vxt9I5a6Ie6tqeH9FL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=igZKjK1K; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3ECFE6000D;
	Tue,  1 Oct 2024 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727773950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8e0/MF0EAHqslKXTtTfPt+/H8jOhZk2+bky0/VQZJg=;
	b=igZKjK1KY646cAPTO0FysAwddUJvKu3bVXfv9xU3id6yEp21t72YdRsB8QQYSLAuuQ549O
	DrAdgdhlcY5w1DY+zs0ia9MhSivk5sWnF1bBn43Ca8VhFpT/IKhhJ56puImFGo77KaYuJF
	3BzboTz6hQi8DxwuFxSvCbpUk8c8Tl7VdNQHaAn6Zy5f8GYJJYsGppDMiHm5TLOz0/t+Gr
	Ssz+GGlUu+2AP2phfOapXW0mDV1nxppT+8MvHjtpWf0bzNsxlQJvfL+EqMFrklWEnzkU2a
	OV4LHtFhm7WZ/zkE8BNWtOvd6mrFR23Ak+F58VaoCfcfEqLX9KMbG+DXAowWww==
Date: Tue, 1 Oct 2024 11:12:25 +0200
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
Subject: Re: [PATCH v2 2/5] mtd: spinand: add OTP support
Message-ID: <20241001111225.36cb9701@xps-13>
In-Reply-To: <20240827174920.316756-3-mmkurbanov@salutedevices.com>
References: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
	<20240827174920.316756-3-mmkurbanov@salutedevices.com>
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

mmkurbanov@salutedevices.com wrote on Tue, 27 Aug 2024 20:49:00 +0300:

> The MTD subsystem already supports accessing two OTP areas: user and
> factory. User areas can be written by the user. This patch only adds
> support for the user areas.
>=20
> In this patch the OTP_INFO macro is provided to add parameters to
> spinand_info.
> To implement OTP operations, the client (flash driver) is provided with
> 5 callbacks: .read(), .write(), .info(), .lock(), .erase().

Overall this looks good, I have minor changes to request. I'm not yet
done down to the last patch, but I think the implementation is neat.

> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> ---
>  drivers/mtd/nand/spi/Makefile |   3 +-
>  drivers/mtd/nand/spi/core.c   |   3 +
>  drivers/mtd/nand/spi/otp.c    | 232 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |  56 ++++++++
>  4 files changed, 293 insertions(+), 1 deletion(-)
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
> index 0000000000000..d459f811f9c04
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/otp.c
> @@ -0,0 +1,232 @@
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
> +static unsigned int spinand_otp_npages(const struct spinand_device *spin=
and)
> +{
> +	return spinand->otp->layout.npages;
> +}
> +
> +static size_t spinand_otp_size(struct spinand_device *spinand)
> +{
> +	struct nand_device *nand =3D spinand_to_nand(spinand);
> +	size_t otp_pagesize =3D nanddev_page_size(nand) +
> +			      nanddev_per_page_oobsize(nand);
> +
> +	return spinand_otp_npages(spinand) * otp_pagesize;
> +}
> +
> +static int spinand_otp_rw(struct spinand_device *spinand, loff_t ofs,
> +			  size_t len, u8 *buf, size_t *retlen, bool is_write)
> +{
> +	struct nand_device *nand =3D spinand_to_nand(spinand);
> +	struct nand_page_io_req req =3D { 0 };

					=3D {}; is enough

> +	unsigned long long page;
> +	size_t copied =3D 0;
> +	size_t otp_pagesize =3D nanddev_page_size(nand) +
> +			      nanddev_per_page_oobsize(nand);
> +	int ret =3D 0;
> +
> +	page =3D ofs;
> +	req.dataoffs =3D do_div(page, otp_pagesize);
> +	req.pos.page =3D page;
> +	req.type =3D is_write ? NAND_PAGE_WRITE : NAND_PAGE_READ;
> +	req.mode =3D MTD_OPS_RAW;
> +	req.databuf.in =3D buf;
> +
> +	while (copied < len && req.pos.page < spinand_otp_npages(spinand)) {
> +		req.datalen =3D min_t(unsigned int,
> +				    otp_pagesize - req.dataoffs,
> +				    len - copied);
> +
> +		if (is_write)
> +			ret =3D spinand_write_page(spinand, &req);
> +		else
> +			ret =3D spinand_read_page(spinand, &req);
> +
> +		if (ret < 0)
> +			break;
> +
> +		req.dataoffs =3D 0;
> +		copied +=3D req.datalen;
> +		req.pos.page++;
> +	}
> +
> +	*retlen =3D copied;
> +
> +	return ret;
> +}
> +
> +/**
> + * spinand_otp_read() - Read from OTP area
> + * @spinand: the spinand device
> + * @ofs: the offset to read
> + * @len: the number of data bytes to read
> + * @buf: the buffer to store the read data
> + * @retlen: the pointer to variable to store the number of read bytes
> + *
> + * Return: 0 on success, an error code otherwise.
> + */
> +int spinand_otp_read(struct spinand_device *spinand, loff_t ofs, size_t =
len,
> +		     u8 *buf, size_t *retlen)
> +{
> +	return spinand_otp_rw(spinand, ofs, len, buf, retlen, false);
> +}
> +
> +/**
> + * spinand_otp_write() - Write to OTP area
> + * @spinand:  the spinand device
> + * @ofs: the offset to write to
> + * @len: the number of bytes to write
> + * @buf: the buffer with data to write
> + * @retlen: the pointer to variable to store the number of written bytes
> + *
> + * Return: 0 on success, an error code otherwise.
> + */
> +int spinand_otp_write(struct spinand_device *spinand, loff_t ofs, size_t=
 len,
> +		      const u8 *buf, size_t *retlen)
> +{
> +	return spinand_otp_rw(spinand, ofs, len, (u8 *)buf, retlen, true);
> +}

These spinand_otp_xxx() helpers are not yet used, and thus should be
introduced later, when they are useful.

> +
> +static int spinand_otp_check_bounds(struct spinand_device *spinand, loff=
_t ofs,
> +				    size_t len)
> +{
> +	if (ofs < 0 || ofs + len > spinand_otp_size(spinand))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int spinand_mtd_otp_info(struct mtd_info *mtd, size_t len,
> +				size_t *retlen, struct otp_info *buf)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +	const struct spinand_otp_ops *ops =3D spinand->otp->ops;
> +	int ret;
> +
> +	mutex_lock(&spinand->lock);
> +	ret =3D ops->info(spinand, len, buf, retlen);
> +	mutex_unlock(&spinand->lock);
> +
> +	return ret;
> +}
> +
> +static int spinand_mtd_otp_rw(struct mtd_info *mtd, loff_t ofs, size_t l=
en,
> +			      size_t *retlen, u8 *buf, bool is_write)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +	const struct spinand_otp_ops *ops =3D spinand->otp->ops;
> +	int ret;
> +
> +	if (!len)
> +		return 0;
> +
> +	ret =3D spinand_otp_check_bounds(spinand, ofs, len);
> +	if (ret)
> +		return ret;
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
> +		pr_warn(1, "Can not disable OTP mode\n");

dev_warn?

> +		ret =3D -EIO;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&spinand->lock);
> +	return ret;
> +}
> +
> +static int spinand_mtd_otp_read(struct mtd_info *mtd, loff_t ofs, size_t=
 len,
> +				size_t *retlen, u8 *buf)
> +{
> +	return spinand_mtd_otp_rw(mtd, ofs, len, retlen, buf, false);
> +}
> +
> +static int spinand_mtd_otp_write(struct mtd_info *mtd, loff_t ofs, size_=
t len,
> +				 size_t *retlen, const u8 *buf)
> +{
> +	return spinand_mtd_otp_rw(mtd, ofs, len, retlen, (u8 *)buf, true);
> +}
> +
> +static int spinand_mtd_otp_erase(struct mtd_info *mtd, loff_t ofs, size_=
t len)
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
> +
> +	ret =3D spinand_otp_check_bounds(spinand, ofs, len);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&spinand->lock);
> +	ret =3D ops->erase(spinand, ofs, len);
> +	mutex_unlock(&spinand->lock);
> +
> +	return ret;
> +}
> +
> +static int spinand_mtd_otp_lock(struct mtd_info *mtd, loff_t ofs, size_t=
 len)
> +{
> +	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
> +	const struct spinand_otp_ops *ops =3D spinand->otp->ops;
> +	int ret;
> +
> +	if (!ops->lock)
> +		return -EOPNOTSUPP;
> +
> +	if (!len)
> +		return 0;
> +
> +	ret =3D spinand_otp_check_bounds(spinand, ofs, len);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&spinand->lock);
> +	ret =3D ops->lock(spinand, ofs, len);
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

Could we use something else as check? It feels odd to check for otp ops
and then just ignore the fact that they are here. Maybe check npages or
otp_size() ?

> +		return;
> +
> +	mtd->_get_user_prot_info =3D spinand_mtd_otp_info;
> +	mtd->_read_user_prot_reg =3D spinand_mtd_otp_read;
> +	mtd->_write_user_prot_reg =3D spinand_mtd_otp_write;
> +	mtd->_lock_user_prot_reg =3D spinand_mtd_otp_lock;
> +	mtd->_erase_user_prot_reg =3D spinand_mtd_otp_erase;
> +}
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 555846517faf6..8099f35f0e051 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -322,6 +322,43 @@ struct spinand_ondie_ecc_conf {
>  	u8 status;
>  };

Thanks,
Miqu=C3=A8l


Return-Path: <linux-kernel+bounces-346592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53E98C660
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D2BC283C44
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804D31CDFBB;
	Tue,  1 Oct 2024 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P4wZByQI"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCBB1DFCB;
	Tue,  1 Oct 2024 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727812690; cv=none; b=XXAoFajbp/RgoGsQEEiaDsD4Btnzd8TfmcjGq7K6O9+DXLhWtOyy2JhiWhiySLimFtQzb5vtY0LNGkRayU8EyKbuDB33aQwVa58pQfOcv8xTcVTdsQ/PHjTUq7jn9RdjIh2olqyt697AKj8SyIF/ubmNn4cvRn5NWkChyUAntH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727812690; c=relaxed/simple;
	bh=I8Nma6bap3hMsLCIfPnvv5a4ls3DSvmoRPs/9/vZDhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Klwtt89SVhBzmpLhFNqdFzCKLeooC0hDejIm+9smzL9g6PHeVtpkLyweD+aaeRWMnWCLZmjRXgTBnXXPZe/ok8sgHBfHhq2F2NmekvZo3gvMzbhMHb5IubcAbHFUOomGuuxHTo3yG8Z2iYZPrHtcrx5z3EmORd+v3Xz/e42fmTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P4wZByQI; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31B00240002;
	Tue,  1 Oct 2024 19:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727812679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeBS/mrBjYcDkcJinzL8WkJdzh8Scaxd5wN2OntLYjA=;
	b=P4wZByQIgmfwoLuMUW9CCe+CfHsqrBtlIflnx2K/UiWCyw7j6j0pO/wOkJnSbf3+l8cpJV
	bRhEQPjOxoQsjzmGEqj7iHj/e8uoLf63JHLsFApp2ROh2/AagrnHaURCuH+iuqvXHrzmya
	K8KEWfrgnLuqKP2Z8DFGOs5vAErunoyEcz1ENJIL4V5SJo2eKtcA0hfDVrDifFl3KO9JhA
	4fKawEVM2NzXd/MmIoSbWWYUJDC+IJ/OsWo5Xq9hqVbu76RoMdbYpoUr0yc8VO/ed+CFDY
	sEnn+ddyLd+j3Mgy9UKwbYqjnUfTC0PieITStzeqr1ZHaG63Nrza+gDqesYz0A==
Date: Tue, 1 Oct 2024 21:57:55 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
Message-ID: <20241001215755.5c2f8465@xps-13>
In-Reply-To: <20240927020749.46791-3-hpchen0nvt@gmail.com>
References: <20240927020749.46791-1-hpchen0nvt@gmail.com>
	<20240927020749.46791-3-hpchen0nvt@gmail.com>
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

Hi Hui-Ping,

hpchen0nvt@gmail.com wrote on Fri, 27 Sep 2024 02:07:49 +0000:

> Nuvoton MA35 SoCs NAND Flash Interface Controller
> supports 2kiB, 4kiB and 8kiB page size, and up to
> 8-bit, 12-bit, and 24-bit hardware ECC calculation
> circuit to protect data.
>=20
> Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
> ---
>  drivers/mtd/nand/raw/Kconfig               |   8 +
>  drivers/mtd/nand/raw/Makefile              |   1 +
>  drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c | 862 +++++++++++++++++++++
>  3 files changed, 871 insertions(+)
>  create mode 100644 drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c
>=20
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index d0aaccf72d78..e3677bcaf035 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -454,6 +454,14 @@ config MTD_NAND_TS72XX
>  	help
>  	  Enables support for NAND controller on ts72xx SBCs.
> =20
> +config MTD_NAND_NUVOTON_MA35
> +	tristate "Nuvoton MA35 SoC NAND controller"
> +	depends on ARCH_MA35 || COMPILE_TEST
> +	depends on OF
> +	help
> +	  Enables support for the NAND controller found on
> +	  the Nuvoton MA35 series SoCs.
> +
>  comment "Misc"
> =20
>  config MTD_SM_COMMON
> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
> index d0b0e6b83568..cc24955627f8 100644
> --- a/drivers/mtd/nand/raw/Makefile
> +++ b/drivers/mtd/nand/raw/Makefile
> @@ -58,6 +58,7 @@ obj-$(CONFIG_MTD_NAND_INTEL_LGM)	+=3D intel-nand-contro=
ller.o
>  obj-$(CONFIG_MTD_NAND_ROCKCHIP)		+=3D rockchip-nand-controller.o
>  obj-$(CONFIG_MTD_NAND_PL35X)		+=3D pl35x-nand-controller.o
>  obj-$(CONFIG_MTD_NAND_RENESAS)		+=3D renesas-nand-controller.o
> +obj-$(CONFIG_MTD_NAND_NUVOTON_MA35)	+=3D nuvoton_ma35d1_nand.o
> =20
>  nand-objs :=3D nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_=
ids.o
>  nand-objs +=3D nand_onfi.o
> diff --git a/drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c b/drivers/mtd/nan=
d/raw/nuvoton_ma35d1_nand.c
> new file mode 100644
> index 000000000000..efd60493f22a
> --- /dev/null
> +++ b/drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c
> @@ -0,0 +1,862 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024 Nuvoton Technology Corp.
> + */
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +#include <linux/mtd/rawnand.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +/* NFI Registers */
> +#define MA35_NFI_REG_DMACTL		0x400
> +#define   DMA_EN				BIT(0)
> +#define   DMA_RST				BIT(1)
> +#define   DMA_BUSY				BIT(9)
> +
> +#define MA35_NFI_REG_DMASA		0x408
> +#define MA35_NFI_REG_GCTL		0x800
> +#define   NAND_EN				BIT(3)
> +
> +#define MA35_NFI_REG_NANDCTL		0x8A0
> +#define   SWRST				BIT(0)
> +#define   DMA_R_EN				BIT(1)
> +#define   DMA_W_EN				BIT(2)
> +#define   ECC_CHK				BIT(7)
> +#define   PROT3BEN				BIT(8)
> +#define   PSIZE_2K				BIT(16)
> +#define   PSIZE_4K				BIT(17)
> +#define   PSIZE_8K				GENMASK(17, 16)
> +#define   PSIZE_MASK				GENMASK(17, 16)
> +#define   BCH_T24				BIT(18)
> +#define   BCH_T8				BIT(20)
> +#define   BCH_T12				BIT(21)
> +#define   BCH_NONE				(0x0)
> +#define   BCH_MASK				GENMASK(22, 18)
> +#define   ECC_EN				BIT(23)
> +#define   DISABLE_CS0				BIT(25)
> +
> +#define MA35_NFI_REG_NANDINTEN	0x8A8
> +#define MA35_NFI_REG_NANDINTSTS	0x8AC
> +#define   INT_DMA				BIT(0)
> +#define   INT_ECC				BIT(2)
> +#define   INT_RB0				BIT(10)
> +#define   INT_RB0_STS				BIT(18)
> +
> +#define MA35_NFI_REG_NANDCMD		0x8B0
> +#define MA35_NFI_REG_NANDADDR		0x8B4
> +#define   ENDADDR				BIT(31)
> +
> +#define MA35_NFI_REG_NANDDATA		0x8B8
> +#define MA35_NFI_REG_NANDRACTL	0x8BC
> +#define MA35_NFI_REG_NANDECTL		0x8C0
> +#define   ENABLE_WP				0x0
> +#define   DISABLE_WP				BIT(0)
> +
> +#define MA35_NFI_REG_NANDECCES0	0x8D0
> +#define   ECC_STATUS_MASK			GENMASK(1, 0)
> +#define   ECC_ERR_CNT_MASK			GENMASK(4, 0)
> +
> +#define MA35_NFI_REG_NANDECCEA0	0x900
> +#define MA35_NFI_REG_NANDECCED0	0x960
> +#define MA35_NFI_REG_NANDRA0		0xA00
> +
> +/* Define for the BCH hardware ECC engine */
> +/* define the total padding bytes for 512/1024 data segment */
> +#define MA35_BCH_PADDING_512	32
> +#define MA35_BCH_PADDING_1024	64
> +/* define the BCH parity code length for 512 bytes data pattern */
> +#define MA35_PARITY_BCH8	15
> +#define MA35_PARITY_BCH12	23
> +/* define the BCH parity code length for 1024 bytes data pattern */
> +#define MA35_PARITY_BCH24	45
> +
> +struct ma35_nand_info {
> +	struct nand_controller controller;
> +	struct nand_chip chip;
> +	struct device *dev;
> +	void __iomem *regs;
> +	int irq;
> +	struct clk *clk;
> +	struct completion complete;
> +	u32 bch;
> +	u32 bitflips;
> +	u8 *ecc_buf;
> +};
> +
> +static int ma35_ooblayout_ecc(struct mtd_info *mtd, int section,
> +			      struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->length =3D chip->ecc.total;
> +	oobregion->offset =3D mtd->oobsize - oobregion->length;
> +
> +	return 0;
> +}
> +
> +static int ma35_ooblayout_free(struct mtd_info *mtd, int section,
> +			       struct mtd_oob_region *oobregion)
> +{
> +	struct nand_chip *chip =3D mtd_to_nand(mtd);
> +
> +	if (section)
> +		return -ERANGE;
> +
> +	oobregion->length =3D mtd->oobsize - chip->ecc.total - 2;
> +	oobregion->offset =3D 2;
> +
> +	return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops ma35_ooblayout_ops =3D {
> +	.free =3D ma35_ooblayout_free,
> +	.ecc =3D ma35_ooblayout_ecc,
> +};
> +
> +static inline void ma35_clear_spare(struct nand_chip *chip, int size)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	int i;
> +
> +	for (i =3D 0; i < size/4; i++)

Spacing                    ^

> +		writel(0xff, nand->regs + MA35_NFI_REG_NANDRA0);
> +}
> +
> +static inline void read_remaining_bytes(struct ma35_nand_info *nand, u32=
 *buf,
> +					u32 offset, int size)
> +{
> +	u32 value =3D readl(nand->regs + MA35_NFI_REG_NANDRA0 + offset);
> +	u8 *ptr =3D (u8 *)buf;
> +	int i;
> +
> +	for (i =3D 0; i < size; i++)
> +		ptr[i] =3D (value >> (i * 8)) & 0xff;
> +}
> +
> +static inline void ma35_read_spare(struct nand_chip *chip, int size, u32=
 *buf, u32 offset)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	int i, j;
> +
> +	if ((offset % 4) =3D=3D 0) {
> +		for (i =3D 0, j =3D 0; i < size / 4; i++, j +=3D 4)
> +			*buf++ =3D readl(nand->regs + MA35_NFI_REG_NANDRA0 + offset + j);
> +
> +		read_remaining_bytes(nand, buf, offset + j, size % 4);
> +	} else {
> +		read_remaining_bytes(nand, buf, offset, 4 - (offset % 4));
> +		offset +=3D 4;
> +		size -=3D (4 - (offset % 4));
> +
> +		for (i =3D 0, j =3D 0; i < size / 4; i++, j +=3D 4)
> +			*buf++ =3D readl(nand->regs + MA35_NFI_REG_NANDRA0 + offset + j);
> +
> +		read_remaining_bytes(nand, buf, offset + j, size % 4);
> +	}
> +}
> +
> +static inline void ma35_write_spare(struct nand_chip *chip, int size, u3=
2 *buf)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	u32 value;
> +	int i, j;
> +	u8 *ptr;
> +
> +	for (i =3D 0, j =3D 0; i < size / 4; i++, j +=3D 4)
> +		writel(*buf++, nand->regs + MA35_NFI_REG_NANDRA0 + j);
> +
> +	ptr =3D (u8 *)buf;
> +	switch (size % 4) {
> +	case 1:
> +		writel(*ptr, nand->regs + MA35_NFI_REG_NANDRA0 + j);
> +		break;
> +	case 2:
> +		value =3D *ptr | (*(ptr+1) << 8);
> +		writel(value, nand->regs + MA35_NFI_REG_NANDRA0 + j);
> +		break;
> +	case 3:
> +		value =3D *ptr | (*(ptr+1) << 8) | (*(ptr+2) << 16);
> +		writel(value, nand->regs + MA35_NFI_REG_NANDRA0 + j);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static inline void ma35_nand_target_enable(struct ma35_nand_info *nand)
> +{
> +	writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~DISABLE_CS0),
> +		nand->regs+MA35_NFI_REG_NANDCTL);
> +}
> +
> +static inline void ma35_nand_target_disable(struct ma35_nand_info *nand)
> +{
> +	writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | DISABLE_CS0,
> +		nand->regs + MA35_NFI_REG_NANDCTL);
> +}
> +
> +static void ma35_nand_hwecc_init(struct ma35_nand_info *nand)
> +{
> +	struct mtd_info *mtd =3D nand_to_mtd(&nand->chip);
> +	u32 reg;
> +
> +	/* resets the internal state machine and counters

Please check the style in all you comments.

	/*
	 * Reset the

> +	 * This bit will be auto cleared after a few clock cycles.
> +	 */
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDCTL);
> +	reg |=3D SWRST;
> +	writel(reg, nand->regs + MA35_NFI_REG_NANDCTL);

This has a way wider impact than just configuring the hw ECC engine,
no? Are you sure you want to do this now? I believe it should be in its
own helper, and you want to do it earlier than that, like before the
discovery step (and also in the resume path).

> +	while (readl(nand->regs + MA35_NFI_REG_NANDCTL) & SWRST)
> +		;

cpu_relax()

> +
> +	/* Redundant area size */
> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
> +
> +	/* Protect redundant 3 bytes */
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDCTL);
> +	reg |=3D (PROT3BEN | ECC_CHK);
> +	writel(reg, nand->regs + MA35_NFI_REG_NANDCTL);
> +
> +	if (nand->bch =3D=3D BCH_NONE) {

Please use the definitions/constants from the core.

> +		/* Disable H/W ECC, ECC parity check enable bit during read page */
> +		writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~ECC_EN),
> +			nand->regs + MA35_NFI_REG_NANDCTL);

Move the readl before the if and save it in the reg variable.

In general please do not overload the lines like that when it's not
needed.

> +	} else {
> +		/* Set BCH algorithm */
> +		writel((readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~BCH_MASK)) |

Parenthesis are not needed                                         ^

> +			nand->bch, nand->regs + MA35_NFI_REG_NANDCTL);
> +
> +		/* Enable H/W ECC, ECC parity check enable bit during read page */
> +		writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | ECC_EN,
> +			nand->regs + MA35_NFI_REG_NANDCTL);
> +	}
> +}
> +
> +/* Correct data by BCH alrogithm */
> +static void ma35_nfi_correct(struct ma35_nand_info *nand, u8 index,
> +				 u8 err_cnt, u8 *addr)
> +{
> +	u32 temp_data[24], temp_addr[24];
> +	u32 padding_len, parity_len;
> +	u32 value, offset, remain;
> +	u32 err_data[6];
> +	u8  i, j;
> +
> +	/* configurations */
> +	switch (nand->bch) {
> +	case BCH_T24:
> +		parity_len =3D MA35_PARITY_BCH24;
> +		padding_len =3D MA35_BCH_PADDING_1024;
> +		break;
> +	case BCH_T12:
> +		parity_len =3D MA35_PARITY_BCH12;
> +		padding_len =3D MA35_BCH_PADDING_512;
> +		break;
> +	case BCH_T8:
> +		parity_len =3D MA35_PARITY_BCH8;
> +		padding_len =3D MA35_BCH_PADDING_512;
> +		break;
> +	default:
> +		dev_warn(nand->dev, "NAND ERROR: invalid SMCR_BCH_TSEL =3D 0x%08X\n",
> +			(u32)(readl(nand->regs + MA35_NFI_REG_NANDCTL) & BCH_MASK));
> +		return;
> +	}
> +
> +	/* got valid BCH_ECC_DATAx and parse them to temp_data[]
> +	 * got the valid register number of BCH_ECC_DATAx since
> +	 * one register include 4 error bytes
> +	 */
> +	j =3D (err_cnt + 3) / 4;
> +	j =3D (j > 6) ? 6 : j;
> +	for (i =3D 0; i < j; i++)
> +		err_data[i] =3D readl(nand->regs + MA35_NFI_REG_NANDECCED0 + i * 4);
> +
> +	for (i =3D 0; i < j; i++) {
> +		temp_data[i*4+0] =3D err_data[i] & 0xff;
> +		temp_data[i*4+1] =3D (err_data[i] >> 8) & 0xff;
> +		temp_data[i*4+2] =3D (err_data[i] >> 16) & 0xff;
> +		temp_data[i*4+3] =3D (err_data[i] >> 24) & 0xff;
> +	}
> +
> +	/* got valid REG_BCH_ECC_ADDRx and parse them to temp_addr[]
> +	 * got the valid register number of REG_BCH_ECC_ADDRx since
> +	 * one register include 2 error addresses
> +	 */
> +	j =3D (err_cnt + 1) / 2;
> +	j =3D (j > 12) ? 12 : j;
> +	for (i =3D 0; i < j; i++) {
> +		temp_addr[i*2+0] =3D readl(nand->regs + MA35_NFI_REG_NANDECCEA0 + i * =
4)
> +					& 0x07ff;
> +		temp_addr[i*2+1] =3D (readl(nand->regs + MA35_NFI_REG_NANDECCEA0 + i *=
 4)
> +					>> 16) & 0x07ff;
> +	}
> +
> +	/* pointer to begin address of field that with data error */
> +	addr +=3D index * nand->chip.ecc.steps;
> +
> +	/* correct each error bytes */
> +	for (i =3D 0; i < err_cnt; i++) {
> +		u32 corrected_index =3D temp_addr[i];
> +
> +		/* for wrong data in field */
> +		if (corrected_index < nand->chip.ecc.steps)
> +			*(addr + corrected_index) ^=3D temp_data[i];
> +
> +		/* for wrong first-3-bytes in redundancy area */
> +		else if (corrected_index < (nand->chip.ecc.steps + 3)) {
> +			corrected_index -=3D nand->chip.ecc.steps;
> +			temp_addr[i] +=3D (parity_len * index);	/* field offset */
> +
> +			value =3D readl(nand->regs + MA35_NFI_REG_NANDRA0);
> +			value ^=3D temp_data[i] << (8 * corrected_index);
> +			writel(value, nand->regs + MA35_NFI_REG_NANDRA0);
> +		}
> +		/* for wrong parity code in redundancy area
> +		 * BCH_ERR_ADDRx =3D [data in field] + [3 bytes] + [xx] + [parity code]
> +		 *                                   |<--     padding bytes      -->|
> +		 * The BCH_ERR_ADDRx for last parity code always =3D field size + padd=
ing size.
> +		 * So, the first parity code =3D field size + padding size - parity co=
de length.
> +		 * For example, for BCH T12, the first parity code =3D 512 + 32 - 23 =
=3D 521.
> +		 * That is, error byte address offset within field is
> +		 */
> +		else {
> +			corrected_index -=3D (nand->chip.ecc.steps + padding_len - parity_len=
);
> +
> +			/* final address =3D first parity code of first field +
> +			 *                 offset of fields +
> +			 *                 offset within field
> +			 */
> +			offset =3D (readl(nand->regs + MA35_NFI_REG_NANDRACTL) & 0x1ff) -
> +				(parity_len * nand->chip.ecc.steps) +
> +				(parity_len * index) + corrected_index;
> +
> +			remain =3D offset % 4;
> +			value =3D readl(nand->regs + MA35_NFI_REG_NANDRA0 + offset - remain);
> +			value ^=3D temp_data[i] << (8 * remain);
> +			writel(value, nand->regs + MA35_NFI_REG_NANDRA0 + offset - remain);
> +		}
> +	}
> +}
> +
> +static int ma35_nfi_ecc_check(struct nand_chip *chip, u8 *addr)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	int i, j, nchunks =3D 0;
> +	int report_err =3D 0;
> +	int err_cnt =3D 0;
> +	u32 status;
> +
> +	nchunks =3D mtd->writesize / chip->ecc.steps;
> +	if (nchunks < 4)
> +		nchunks =3D 1;
> +	else
> +		nchunks /=3D 4;
> +
> +	for (j =3D 0; j < nchunks; j++) {
> +		status =3D readl(nand->regs + MA35_NFI_REG_NANDECCES0 + j * 4);
> +		if (!status)
> +			continue;
> +
> +		for (i =3D 0; i < 4; i++) {
> +			if (!(status & ECC_STATUS_MASK)) {
> +				/* No error */
> +				status >>=3D 8;
> +				continue;

Remove this block, it will do the same and be more clear.

> +			} else if ((status & ECC_STATUS_MASK) =3D=3D 0x01) {
> +				/* Correctable error */
> +				err_cnt =3D (status >> 2) & ECC_ERR_CNT_MASK;
> +				ma35_nfi_correct(nand, j*4+i, err_cnt, addr);

Spacing                                               ^^^^^^

> +				report_err +=3D err_cnt;
> +			} else {
> +				/* uncorrectable error */
> +				dev_warn(nand->dev, "uncorrectable error! 0x%4x\n", status);
> +				return -1;

Not a valid error code

> +			}
> +			status >>=3D 8;
> +		}
> +	}
> +	return report_err;
> +}
> +
> +static void ma35_nand_dmac_init(struct ma35_nand_info *nand)
> +{
> +	/* DMAC reset and enable */
> +	writel(DMA_RST | DMA_EN, nand->regs + MA35_NFI_REG_DMACTL);
> +	writel(DMA_EN, nand->regs + MA35_NFI_REG_DMACTL);
> +
> +	/* Clear DMA finished flag */
> +	writel(INT_DMA | INT_ECC, nand->regs + MA35_NFI_REG_NANDINTSTS);
> +
> +	init_completion(&nand->complete);

You're gonna call init_completion more than once during suspend/resume
cycles, this is unsafe.

> +}
> +
> +static int ma35_nand_do_write(struct nand_chip *chip, const u8 *addr, u3=
2 len)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	dma_addr_t dma_addr;
> +	int ret =3D 0, i;
> +	u32 reg;
> +
> +	if (len !=3D mtd->writesize) {
> +		for (i =3D 0; i < len; i++)
> +			writel(addr[i], nand->regs + MA35_NFI_REG_NANDDATA);
> +		return 0;
> +	}
> +
> +	ma35_nand_dmac_init(nand);
> +
> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
> +
> +	writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTEN);
> +	/* To mark this page as dirty. */
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDRA0);
> +	if (reg & 0xffff0000)
> +		writel(reg & 0xffff, nand->regs + MA35_NFI_REG_NANDRA0);
> +
> +	dma_addr =3D dma_map_single(nand->dev, (void *)addr, len, DMA_TO_DEVICE=
);
> +	ret =3D dma_mapping_error(nand->dev, dma_addr);
> +	if (ret) {
> +		dev_err(nand->dev, "dma mapping error\n");
> +		return -EINVAL;
> +	}
> +	dma_sync_single_for_device(nand->dev, dma_addr, len, DMA_TO_DEVICE);
> +
> +	writel((unsigned long)dma_addr, nand->regs + MA35_NFI_REG_DMASA);
> +	writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | DMA_W_EN,
> +		nand->regs + MA35_NFI_REG_NANDCTL);
> +	ret =3D wait_for_completion_timeout(&nand->complete, msecs_to_jiffies(1=
000));
> +	if (!ret) {
> +		dev_err(nand->dev, "write timeout\n");
> +		ret =3D -ETIMEDOUT;
> +	}
> +
> +	dma_unmap_single(nand->dev, dma_addr, len, DMA_TO_DEVICE);
> +
> +	return ret;
> +}
> +
> +static int ma35_nand_do_read(struct nand_chip *chip, u8 *addr, u32 len)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	int ret =3D 0, cnt =3D 0, i;
> +	dma_addr_t dma_addr;
> +	u32 reg;
> +
> +	if (len !=3D mtd->writesize) {
> +		for (i =3D 0; i < len; i++)
> +			*(addr+i) =3D (u8)readl(nand->regs + MA35_NFI_REG_NANDDATA);

Mmh, that line is strange. Please don't do that.

			addr[i] =3D readb() ?

> +		return 0;
> +	}
> +
> +	ma35_nand_dmac_init(nand);
> +
> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
> +
> +	/* setup and start DMA using dma_addr */
> +	dma_addr =3D dma_map_single(nand->dev, (void *)addr, len, DMA_FROM_DEVI=
CE);
> +	ret =3D dma_mapping_error(nand->dev, dma_addr);
> +	if (ret) {
> +		dev_err(nand->dev, "dma mapping error\n");
> +		return -EINVAL;
> +	}
> +
> +	writel((unsigned long)dma_addr, nand->regs + MA35_NFI_REG_DMASA);

Please enforce a dma mask of 32 (even though it might be the fault).

> +	writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | DMA_R_EN,
> +		nand->regs + MA35_NFI_REG_NANDCTL);
> +	ret =3D wait_for_completion_timeout(&nand->complete, msecs_to_jiffies(1=
000));
> +	if (!ret) {
> +		dev_err(nand->dev, "read timeout\n");
> +		ret =3D -ETIMEDOUT;
> +	}
> +
> +	dma_unmap_single(nand->dev, dma_addr, len, DMA_FROM_DEVICE);
> +
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
> +	if (reg & INT_ECC) {
> +		cnt =3D ma35_nfi_ecc_check(&nand->chip, addr);
> +		if (cnt < 0) {
> +			mtd->ecc_stats.failed++;
> +			writel(DMA_RST | DMA_EN, nand->regs + MA35_NFI_REG_DMACTL);
> +			writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | SWRST,
> +				nand->regs + MA35_NFI_REG_NANDCTL);
> +		} else {
> +			mtd->ecc_stats.corrected +=3D cnt;
> +			nand->bitflips =3D cnt;
> +		}
> +		writel(INT_ECC, nand->regs + MA35_NFI_REG_NANDINTSTS);
> +	}
> +
> +	return ret;
> +}
> +
> +static int ma35_nand_write_page_hwecc(struct nand_chip *chip, const u8 *=
buf,
> +				      int oob_required, int page)
> +{
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	void *ecc_calc =3D chip->ecc.calc_buf;
> +
> +	ma35_clear_spare(chip, mtd->oobsize);
> +	ma35_write_spare(chip, mtd->oobsize - chip->ecc.total,
> +			(u32 *)chip->oob_poi);
> +
> +	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
> +	nand_prog_page_end_op(chip);
> +
> +	/* Copy parity code in NANDRA to calc */
> +	ma35_read_spare(chip, chip->ecc.total, (u32 *)ecc_calc,
> +			mtd->oobsize - chip->ecc.total);
> +
> +	/* Copy parity code in calc to oob_poi */
> +	memcpy(chip->oob_poi + (mtd->oobsize - chip->ecc.total),
> +		ecc_calc, chip->ecc.total);
> +
> +	return 0;
> +}
> +
> +static int ma35_nand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
> +					int oob_required, int page)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	u32 reg;
> +
> +	/* read the OOB area  */
> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
> +	nand->bitflips =3D 0;

Why storing this value in your structure?

> +
> +	/* copy OOB data to NANDRA for page read */
> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
> +
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDRA0);
> +	if (reg & 0xffff0000) {
> +		memset((void *)buf, 0xff, mtd->writesize);
> +	} else {
> +		/* read data from nand */
> +		nand_read_page_op(chip, page, 0, buf, mtd->writesize);

ret =3D=20
if (ret)
	...

> +
> +		/* restore OOB data from SMRA */
> +		ma35_read_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi, 0);


same

> +	}
> +
> +	return nand->bitflips;
> +}
> +
> +static int ma35_nand_read_oob_hwecc(struct nand_chip *chip, int page)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	u32 reg;
> +
> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
> +
> +	/* copy OOB data to NANDRA for page read */

What is NANDRA? does not mean anything to me.

> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
> +
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDRA0);
> +	if (reg & 0xffff0000)
> +		memset((void *)chip->oob_poi, 0xff, mtd->oobsize);

What does this mean?

> +
> +	return 0;
> +}
> +
> +static irqreturn_t ma35_nand_irq(int irq, void *id)
> +{
> +	struct ma35_nand_info *nand =3D (struct ma35_nand_info *)id;
> +	u32 isr;
> +
> +	isr =3D readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
> +	if (isr & INT_DMA) {
> +		writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTSTS);
> +		complete(&nand->complete);
> +	}

I guess a more future proof implementation would always writel(isr); to
silence the interrupt. Otherwise of course you must call complete()
only upon isr & INT_DMA.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ma35_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	unsigned int reg;
> +
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		dev_err(nand->dev, "16 bits bus width not supported");
> +		return -EINVAL;
> +	}
> +
> +	/* support only ecc hw mode */

Why ? Please don't.

> +	if (chip->ecc.engine_type !=3D NAND_ECC_ENGINE_TYPE_ON_HOST) {
> +		dev_err(nand->dev, "ecc.engine_type not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	nand->ecc_buf =3D devm_kzalloc(nand->dev, mtd->writesize + mtd->oobsize,
> +					GFP_KERNEL);
> +	if (!nand->ecc_buf)
> +		return  -ENOMEM;
> +	chip->ecc.calc_buf =3D nand->ecc_buf;

Are you sure you need this? I don't see the point.

> +
> +	/* Set PSize */
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~PSIZE_MASK);
> +	if (mtd->writesize =3D=3D 2048)
> +		writel(reg | PSIZE_2K, nand->regs + MA35_NFI_REG_NANDCTL);
> +	else if (mtd->writesize =3D=3D 4096)
> +		writel(reg | PSIZE_4K, nand->regs + MA35_NFI_REG_NANDCTL);
> +	else if (mtd->writesize =3D=3D 8192)
> +		writel(reg | PSIZE_8K, nand->regs + MA35_NFI_REG_NANDCTL);
> +
> +	chip->ecc.steps =3D mtd->writesize / chip->ecc.size;
> +	if (chip->ecc.strength =3D=3D 0) {
> +		nand->bch =3D BCH_NONE; /* No ECC */
> +		chip->ecc.total =3D 0;
> +	} else if (chip->ecc.strength <=3D 8) {
> +		nand->bch =3D BCH_T8; /* T8 */

bch is probably a bad name, and in general I don't see the point of
saving this value. Just check the ECC strength in the above switch
cases and don't use this intermediate variable.

> +		chip->ecc.total =3D chip->ecc.steps * MA35_PARITY_BCH8;
> +	} else if (chip->ecc.strength <=3D 12) {
> +		nand->bch =3D BCH_T12; /* T12 */
> +		chip->ecc.total =3D chip->ecc.steps * MA35_PARITY_BCH12;
> +	} else if (chip->ecc.strength <=3D 24) {
> +		nand->bch =3D BCH_T24; /* T24 */
> +		chip->ecc.total =3D chip->ecc.steps * MA35_PARITY_BCH24;
> +	} else {
> +		dev_warn(nand->dev, "NAND Controller is not support this flash. (%d, %=
d)\n",
> +			mtd->writesize, mtd->oobsize);

This must be a dev_err() and return an error immediately.

Also the string is not correct.

> +	}
> +
> +	chip->ecc.bytes =3D chip->ecc.total / chip->ecc.steps;
> +	mtd_set_ooblayout(mtd, &ma35_ooblayout_ops);
> +
> +	/* add mtd-id. The string should same as uboot definition */
> +	mtd->name =3D "nand0";

No! There are DT labels for that and mtd->name will automatically be
set when calling nand_set_flash_node().

> +
> +	ma35_nand_hwecc_init(nand);
> +
> +	writel(DISABLE_WP, nand->regs + MA35_NFI_REG_NANDECTL);
> +
> +	return 0;
> +}
> +
> +static int ma35_nfc_exec_instr(struct nand_chip *chip,
> +			      const struct nand_op_instr *instr)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	unsigned int i;
> +	u32 status;
> +
> +	switch (instr->type) {
> +	case NAND_OP_CMD_INSTR:
> +		writel(instr->ctx.cmd.opcode, nand->regs + MA35_NFI_REG_NANDCMD);
> +		return 0;
> +	case NAND_OP_ADDR_INSTR:
> +		for (i =3D 0; i < instr->ctx.addr.naddrs; i++) {
> +			if (i =3D=3D (instr->ctx.addr.naddrs - 1))
> +				writel(instr->ctx.addr.addrs[i] | ENDADDR,
> +					nand->regs + MA35_NFI_REG_NANDADDR);
> +			else
> +				writel(instr->ctx.addr.addrs[i],
> +					nand->regs + MA35_NFI_REG_NANDADDR);
> +		}
> +		return 0;
> +	case NAND_OP_DATA_IN_INSTR:
> +		ma35_nand_do_read(chip, instr->ctx.data.buf.in, instr->ctx.data.len);
> +		return 0;
> +	case NAND_OP_DATA_OUT_INSTR:
> +		ma35_nand_do_write(chip, instr->ctx.data.buf.out, instr->ctx.data.len);
> +		return 0;
> +	case NAND_OP_WAITRDY_INSTR:
> +		return readl_poll_timeout(nand->regs + MA35_NFI_REG_NANDINTSTS, status,
> +					  status & INT_RB0, 20,
> +					  instr->ctx.waitrdy.timeout_ms * 1000);

MSEC_PER_SEC

> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}

This is much better than the legacy hooks!

> +
> +static int ma35_nfc_exec_op(struct nand_chip *chip,
> +			  const struct nand_operation *op,
> +			  bool check_only)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	int ret =3D 0;
> +	u32 i, reg;
> +
> +	if (check_only)
> +		return 0;
> +
> +	ma35_nand_target_enable(nand);
> +
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
> +	reg |=3D INT_RB0;

This RB pin looks like something hardcoded, whereas it should not :-)

If you have several RB, it means you have several CS as well!

> +	writel(reg, nand->regs + MA35_NFI_REG_NANDINTSTS);
> +
> +	for (i =3D 0; i < op->ninstrs; i++) {
> +		ret =3D ma35_nfc_exec_instr(chip, &op->instrs[i]);
> +		if (ret)
> +			break;
> +	}
> +
> +	ma35_nand_target_disable(nand);
> +
> +	return ret;
> +}
> +
> +static const struct nand_controller_ops ma35_nfc_ops =3D {
> +	.attach_chip =3D ma35_nand_attach_chip,
> +	.exec_op =3D ma35_nfc_exec_op,
> +};
> +
> +static int ma35_nand_probe(struct platform_device *pdev)
> +{
> +	struct ma35_nand_info *nand;
> +	struct nand_chip *chip;
> +	struct mtd_info *mtd;
> +	int ret =3D 0;
> +
> +	nand =3D devm_kzalloc(&pdev->dev, sizeof(*nand), GFP_KERNEL);
> +	if (!nand)
> +		return -ENOMEM;
> +
> +	nand_controller_init(&nand->controller);
> +	nand->controller.ops =3D &ma35_nfc_ops;
> +
> +	nand->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(nand->regs))
> +		return PTR_ERR(nand->regs);
> +
> +	nand->dev =3D &pdev->dev;
> +	chip =3D &nand->chip;
> +	nand_set_controller_data(chip, nand);
> +	nand_set_flash_node(chip, pdev->dev.of_node);
> +
> +	nand->clk =3D devm_clk_get_enabled(&pdev->dev, "nand_gate");
> +	if (IS_ERR(nand->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(nand->clk),
> +				     "failed to find nand clock\n");

NAND

> +
> +	nand->irq =3D platform_get_irq(pdev, 0);
> +	if (nand->irq < 0)
> +		return dev_err_probe(&pdev->dev, nand->irq,
> +				     "failed to get platform irq\n");
> +
> +	ret =3D devm_request_irq(&pdev->dev, nand->irq, ma35_nand_irq,
> +				  IRQF_TRIGGER_HIGH, "ma35d1-nand", nand);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request NAND irq\n");
> +		return -ENXIO;
> +	}
> +
> +	nand->chip.controller =3D &nand->controller;
> +	platform_set_drvdata(pdev, nand);
> +
> +	chip->options |=3D NAND_NO_SUBPAGE_WRITE | NAND_USES_DMA;
> +
> +	chip->ecc.engine_type =3D NAND_ECC_ENGINE_TYPE_ON_HOST;
> +	chip->ecc.write_page =3D ma35_nand_write_page_hwecc;
> +	chip->ecc.read_page  =3D ma35_nand_read_page_hwecc;
> +	chip->ecc.read_oob   =3D ma35_nand_read_oob_hwecc;

You support to disable the ECC engine, so you must support software
corrections as well. Please don't force hw ECC use. Please look at
other implementations, there is usually a helper with a switch case
which supports various ECC configurations.

> +
> +	mtd =3D nand_to_mtd(chip);
> +	mtd->priv =3D chip;
> +	mtd->owner =3D THIS_MODULE;
> +	mtd->dev.parent =3D &pdev->dev;
> +
> +	writel(NAND_EN, nand->regs + MA35_NFI_REG_GCTL);

I would expect your reset bit to be set before this writel.

> +
> +	ret =3D nand_scan(chip, 1);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		nand_cleanup(chip);
> +		return ret;
> +	}
> +
> +	return ret;

return 0; then

> +}
> +
> +static void ma35_nand_remove(struct platform_device *pdev)
> +{
> +	struct ma35_nand_info *nand =3D platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret =3D mtd_device_unregister(nand_to_mtd(&nand->chip));
> +	WARN_ON(ret);
> +	nand_cleanup(&nand->chip);
> +}
> +
> +/* PM Support */
> +#ifdef CONFIG_PM
> +static int ma35_nand_suspend(struct platform_device *pdev, pm_message_t =
pm)
> +{
> +	struct ma35_nand_info *nand =3D platform_get_drvdata(pdev);
> +	int ret =3D 0;
> +	u32 val;
> +
> +	/* wait DMAC to ready */

			be

> +	ret =3D readl_poll_timeout(nand->regs + MA35_NFI_REG_DMACTL, val,
> +				 !(val & DMA_BUSY), 50, HZ/2);
> +	if (ret)
> +		dev_warn(&pdev->dev, "dma busy\n");

					DMA

And please make a sentence.

> +
> +	clk_disable(nand->clk);

If you decide to return ret !=3D 0, shall you really disable this clock ?

> +
> +	return ret;
> +}
> +
> +static int ma35_nand_resume(struct platform_device *pdev)
> +{
> +	struct ma35_nand_info *nand =3D platform_get_drvdata(pdev);
> +
> +	clk_enable(nand->clk);
> +	ma35_nand_hwecc_init(nand);

The naming is wrong. This init is not just the hw ECC controller.

> +	ma35_nand_dmac_init(nand);
> +
> +	return 0;
> +}
> +
> +#else
> +#define ma35_nand_suspend NULL
> +#define ma35_nand_resume NULL
> +#endif
> +
> +static const struct of_device_id ma35_nfi_of_match[] =3D {

ma35_nfi or ma35_nand, take one and please stick to it.

> +	{ .compatible =3D "nuvoton,ma35d1-nand" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ma35_nfi_of_match);
> +
> +static struct platform_driver ma35_nand_driver =3D {
> +	.driver =3D {
> +		.name =3D "ma35d1-nand",
> +		.of_match_table =3D ma35_nfi_of_match,
> +	},
> +	.probe =3D ma35_nand_probe,
> +	.remove =3D ma35_nand_remove,
> +	.suspend =3D ma35_nand_suspend,
> +	.resume =3D ma35_nand_resume,
> +};
> +
> +module_platform_driver(ma35_nand_driver);
> +
> +MODULE_DESCRIPTION("Nuvoton ma35 NAND driver");
> +MODULE_AUTHOR("Hui-Ping Chen <hpchen0nvt@gmail.com>");
> +MODULE_LICENSE("GPL");


Thanks,
Miqu=C3=A8l


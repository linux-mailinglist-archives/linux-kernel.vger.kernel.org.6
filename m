Return-Path: <linux-kernel+bounces-373922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7963E9A5F02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F5E1C22E73
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD421E32AC;
	Mon, 21 Oct 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P+nk6Uoq"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369011E25EC;
	Mon, 21 Oct 2024 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500304; cv=none; b=FQeI+fsU9fT/JUcTMtxn4Wk8IUTBqS+a/CqIFxxQjK9IxFRk2977I0wIju0Usk9KZ6N/EublKQtyoKnnbyVgfEeHVwPA/nqNLnZdLIIjnkeXGkGnFMxcM1MLDYbIj4C4wzKhd65HRdtk8DUoE/sr6oGvywnAI2YW0lpCQpPdENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500304; c=relaxed/simple;
	bh=DtdGVeL1+ii6OVw17j5Rrx8lrnm/xVn8iu/7A3lkOZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u90cRyNt8NEIv3+mQQSbMw9+UNMJ5K04MZjO8bXtIDDTxQontoTVpQe8iKmtXpiuLq95wPU7AWBdUcZfqbmCOBLcXamP5vDMH4Dfpy89P6lm8ecSGKpZrHt3gjzW+HKzWs4kcTQiCGyCpIc4xD0IuYa4vlmabJdmoh+05haLijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P+nk6Uoq; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D6572000E;
	Mon, 21 Oct 2024 08:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729500292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bo7GjofGAmj7pzKnQJVosHssaaYmnj51WR/It2wJmT8=;
	b=P+nk6Uoq7UoAOPa1atKgRM0ygE7F55LtQCZibNeNzPW1D9uRhUMoLAbUciEMoYN4jvY5NA
	fM66YnbPjbMaE1b1AkOJspoi9kOxARCX7ZlEqflNRhB1vLCxYMjHpaAIKyPmmGqz9Wm9EQ
	nKgQAGrkFNgV6Ame7Ky79h3NtKKsd313Xgec0qd3wYRdGbnYM423cFuqhKSjEQCDmM3iBP
	DtKpZAXndHADcL8dTA/73cLI9l0laufdTT12o0a2thJ0C1g/M9Xnbu2snMwuN8qZeGJe5K
	OHMym00IyuR2u4n/hqKmJiw5AxFpDB5HK8qFdXd60YwvQI7muxDdq0IDMmY1sQ==
Date: Mon, 21 Oct 2024 10:44:48 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
Message-ID: <20241021103254.1f31205b@xps-13>
In-Reply-To: <20241018022519.721914-3-hpchen0nvt@gmail.com>
References: <20241018022519.721914-1-hpchen0nvt@gmail.com>
	<20241018022519.721914-3-hpchen0nvt@gmail.com>
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

hpchen0nvt@gmail.com wrote on Fri, 18 Oct 2024 02:25:19 +0000:

> Nuvoton MA35 SoCs NAND Flash Interface Controller
> supports 2kiB, 4kiB and 8kiB page size, and up to
> 8-bit, 12-bit, and 24-bit hardware ECC calculation
> circuit to protect data.
>=20
> Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
> ---
>  drivers/mtd/nand/raw/Kconfig               |   8 +
>  drivers/mtd/nand/raw/Makefile              |   1 +
>  drivers/mtd/nand/raw/nuvoton_ma35d1_nand.c | 919 +++++++++++++++++++++
>  3 files changed, 928 insertions(+)
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

Can we name this file like the others? nuvoton-ma35d1-nand-controller.c?

[...]

> +static void ma35_nand_hwecc_init(struct nand_chip *chip, struct ma35_nan=
d_info *nand)
> +{
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	u32 reg;
> +
> +	/* Redundant area size */
> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
> +
> +	/* Protect redundant 3 bytes */
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDCTL);
> +	reg |=3D (PROT3BEN | ECC_CHK);
> +	writel(reg, nand->regs + MA35_NFI_REG_NANDCTL);
> +
> +	if (chip->ecc.strength =3D=3D 0) {
> +		/* Disable H/W ECC, ECC parity check enable bit during read page */
> +		reg =3D readl(nand->regs + MA35_NFI_REG_NANDCTL);
> +		writel(reg & ~ECC_EN, nand->regs + MA35_NFI_REG_NANDCTL);
> +	} else {
> +		/* Set BCH algorithm */
> +		reg =3D readl(nand->regs + MA35_NFI_REG_NANDCTL) & ~BCH_MASK;
> +		if (chip->ecc.strength <=3D 8)
> +			writel(reg | BCH_T8, nand->regs + MA35_NFI_REG_NANDCTL);
> +		else if (chip->ecc.strength <=3D 12)
> +			writel(reg | BCH_T12, nand->regs + MA35_NFI_REG_NANDCTL);
> +		else if (chip->ecc.strength <=3D 24)
> +			writel(reg | BCH_T24, nand->regs + MA35_NFI_REG_NANDCTL);

You should use a switch case here, and refuse strength you cannot
achieve.

> +
> +		/* Enable H/W ECC, ECC parity check enable bit during read page */
> +		writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | ECC_EN,
> +			nand->regs + MA35_NFI_REG_NANDCTL);
> +	}
> +}

[...]

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

This should be part of your initial configuration and be done once for
all.

> +
> +	for (j =3D 0; j < nchunks; j++) {
> +		status =3D readl(nand->regs + MA35_NFI_REG_NANDECCES0 + j * 4);
> +		if (!status)
> +			continue;
> +
> +		for (i =3D 0; i < 4; i++) {
> +			if ((status & ECC_STATUS_MASK) =3D=3D 0x01) {
> +				/* Correctable error */
> +				err_cnt =3D (status >> 2) & ECC_ERR_CNT_MASK;
> +				ma35_nfi_correct(chip, j * 4 + i, err_cnt, addr);
> +				report_err +=3D err_cnt;

Please look at other drivers implementation, you should report two
statistics: the total number of bf, also the maximum number of bf in a
single ECC chunk (which give indications to upper layers on whether
they should consider re-writing the data or not).

> +			} else {
> +				/* Uncorrectable error */
> +				dev_warn(nand->dev, "uncorrectable error! 0x%4x\n", status);
> +				return -EBADMSG;
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
> +	/* Clear DMA finished flag and enable */
> +	writel(INT_DMA | INT_ECC, nand->regs + MA35_NFI_REG_NANDINTSTS);
> +	writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTEN);
> +}

[...]

> +
> +static int ma35_nand_write_page_hwecc(struct nand_chip *chip, const u8 *=
buf,
> +				      int oob_required, int page)
> +{

The hardware ECC engine should always be disabled by default.

Then, in these helpers you should:
* enable the ECC engine
* do your things
* disable the ECC engine

> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +
> +	ma35_nand_target_enable(chip, chip->cur_cs);
> +
> +	ma35_clear_spare(chip, mtd->oobsize);
> +	ma35_write_spare(chip, mtd->oobsize - chip->ecc.total,
> +			(u32 *)chip->oob_poi);
> +
> +	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
> +	ma35_nand_do_write(chip, buf, mtd->writesize);
> +	nand_prog_page_end_op(chip);
> +
> +	ma35_read_spare(chip, chip->ecc.total,
> +			(u32 *)(chip->oob_poi + (mtd->oobsize - chip->ecc.total)),
> +			mtd->oobsize - chip->ecc.total);
> +
> +	return 0;
> +}
> +
> +static int ma35_nand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
> +					int oob_required, int page)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	int bitflips =3D 0;
> +	u32 reg;
> +
> +	ma35_nand_target_enable(chip, chip->cur_cs);
> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
> +
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDRA0);
> +	if (PREFIX_RA_IS_EMPTY(reg)) {
> +		memset((void *)buf, 0xff, mtd->writesize);
> +	} else {
> +		nand_read_page_op(chip, page, 0, NULL, 0);
> +		bitflips =3D ma35_nand_do_read(chip, buf, mtd->writesize);
> +		ma35_read_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi, 0);
> +	}
> +
> +	return bitflips;
> +}
> +
> +static int ma35_nand_read_oob_hwecc(struct nand_chip *chip, int page)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	u32 reg;
> +
> +	ma35_nand_target_enable(chip, chip->cur_cs);
> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
> +
> +	/* copy OOB data to controller redundant area for page read */
> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
> +
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDRA0);
> +	if (PREFIX_RA_IS_EMPTY(reg))
> +		memset((void *)chip->oob_poi, 0xff, mtd->oobsize);
> +
> +	return 0;
> +}
> +
> +static inline void ma35_hw_init(struct ma35_nand_info *nand)
> +{
> +	u32 reg;
> +
> +	/* Disable flash wp. */
> +	writel(DISABLE_WP, nand->regs + MA35_NFI_REG_NANDECTL);
> +
> +	/* resets the internal state machine and counters */
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDCTL);
> +	reg |=3D SWRST;
> +	writel(reg, nand->regs + MA35_NFI_REG_NANDCTL);

Make sure the ECC engine is disabled here.

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
> +
> +	return IRQ_HANDLED;

Should you return IRQ_NONE if (isr & INT_DMA) =3D=3D 0 ?

> +}
> +
> +static int ma35_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	struct device *dev =3D mtd->dev.parent;
> +	u32 reg;
> +
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		dev_err(dev, "16 bits bus width not supported");
> +		return -EINVAL;
> +	}
> +
> +	chip->options |=3D NAND_NO_SUBPAGE_WRITE | NAND_USES_DMA;

Why not supporting subpage writes? Your controller does not seem to not
support them. They are really useful to make your device last longer.

> +
> +	switch (chip->ecc.engine_type) {
> +	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> +		chip->ecc.write_page =3D ma35_nand_write_page_hwecc;
> +		chip->ecc.read_page  =3D ma35_nand_read_page_hwecc;
> +		chip->ecc.read_oob   =3D ma35_nand_read_oob_hwecc;
> +		break;
> +	case NAND_ECC_ENGINE_TYPE_NONE:
> +	case NAND_ECC_ENGINE_TYPE_SOFT:
> +	case NAND_ECC_ENGINE_TYPE_ON_DIE:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
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
> +		chip->ecc.total =3D 0;
> +	} else if (chip->ecc.strength <=3D 8) {
> +		chip->ecc.total =3D chip->ecc.steps * MA35_PARITY_BCH8;
> +	} else if (chip->ecc.strength <=3D 12) {
> +		chip->ecc.total =3D chip->ecc.steps * MA35_PARITY_BCH12;
> +	} else if (chip->ecc.strength <=3D 24) {
> +		chip->ecc.total =3D chip->ecc.steps * MA35_PARITY_BCH24;
> +	} else {
> +		dev_err(dev, "ECC strength unsupported\n");
> +		return -EINVAL;
> +	}
> +
> +	chip->ecc.bytes =3D chip->ecc.total / chip->ecc.steps;
> +
> +	ma35_nand_hwecc_init(chip, nand);

This should only be done in the ON_HOST case.

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
> +					  instr->ctx.waitrdy.timeout_ms * MSEC_PER_SEC);
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;

I would save the return value when there is one and just call

	return ret;

at the end.

> +}
> +
> +static int ma35_nfc_exec_op(struct nand_chip *chip,
> +			  const struct nand_operation *op,
> +			  bool check_only)
> +{
> +	int ret =3D 0;
> +	u32 i;
> +
> +	if (check_only)
> +		return 0;
> +
> +	ma35_nand_target_enable(chip, op->cs);
> +
> +	for (i =3D 0; i < op->ninstrs; i++) {
> +		ret =3D ma35_nfc_exec_instr(chip, &op->instrs[i]);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct nand_controller_ops ma35_nfc_ops =3D {
> +	.attach_chip =3D ma35_nand_attach_chip,
> +	.exec_op =3D ma35_nfc_exec_op,
> +};
> +
> +static int ma35_nand_chip_init(struct device *dev, struct ma35_nand_info=
 *nand,
> +				 struct device_node *np)
> +{
> +	struct ma35_nand_chip *nvtnand;
> +	struct nand_chip *chip;
> +	struct mtd_info *mtd;
> +	int nsels;
> +	u32 tmp;
> +	int ret;
> +	int i;
> +
> +	if (!of_get_property(np, "reg", &nsels))
> +		return -ENODEV;
> +
> +	nsels /=3D sizeof(u32);
> +	if (!nsels || nsels > MA35_MAX_NSELS) {
> +		dev_err(dev, "invalid reg property size %d\n", nsels);
> +		return -EINVAL;
> +	}
> +
> +	nvtnand =3D devm_kzalloc(dev, struct_size(nvtnand, sels, nsels),
> +			      GFP_KERNEL);
> +	if (!nvtnand)
> +		return -ENOMEM;
> +
> +	nvtnand->nsels =3D nsels;
> +	for (i =3D 0; i < nsels; i++) {
> +		ret =3D of_property_read_u32_index(np, "reg", i, &tmp);
> +		if (ret) {
> +			dev_err(dev, "reg property failure : %d\n", ret);
> +			return ret;
> +		}
> +
> +		if (tmp >=3D MA35_MAX_NSELS) {
> +			dev_err(dev, "invalid CS: %u\n", tmp);
> +			return -EINVAL;
> +		}
> +
> +		if (test_and_set_bit(tmp, &nand->assigned_cs)) {
> +			dev_err(dev, "CS %u already assigned\n", tmp);
> +			return -EINVAL;
> +		}
> +
> +		nvtnand->sels[i] =3D tmp;
> +	}
> +
> +	chip =3D &nvtnand->chip;
> +	chip->controller =3D &nand->controller;
> +
> +	nand_set_flash_node(chip, np);
> +	nand_set_controller_data(chip, nand);
> +
> +	mtd =3D nand_to_mtd(chip);
> +	mtd->owner =3D THIS_MODULE;
> +	mtd->dev.parent =3D dev;
> +
> +	mtd_set_ooblayout(mtd, &ma35_ooblayout_ops);
> +	ma35_hw_init(nand);

This is a chip called as many times as there are chips connected to the
host, so the controller initialization should not be here (see below).

> +	ret =3D nand_scan(chip, nsels);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_err(dev, "MTD parse partition error\n");
> +		nand_cleanup(chip);
> +		return ret;
> +	}
> +
> +	list_add_tail(&nvtnand->node, &nand->chips);
> +
> +	return 0;
> +}



> +static int ma35_nand_probe(struct platform_device *pdev)
> +{
> +	struct ma35_nand_info *nand;
> +	int ret =3D 0;
> +
> +	nand =3D devm_kzalloc(&pdev->dev, sizeof(*nand), GFP_KERNEL);
> +	if (!nand)
> +		return -ENOMEM;
> +
> +	nand_controller_init(&nand->controller);
> +	INIT_LIST_HEAD(&nand->chips);
> +	nand->controller.ops =3D &ma35_nfc_ops;
> +
> +	init_completion(&nand->complete);
> +
> +	nand->regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(nand->regs))
> +		return PTR_ERR(nand->regs);
> +
> +	nand->dev =3D &pdev->dev;
> +
> +	nand->clk =3D devm_clk_get_enabled(&pdev->dev, "nand_gate");
> +	if (IS_ERR(nand->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(nand->clk),
> +				     "failed to find NAND clock\n");
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
> +	platform_set_drvdata(pdev, nand);
> +
> +	writel(GRST | NAND_EN, nand->regs + MA35_NFI_REG_GCTL);

I'd call the hw_init() of the controller here, before going through the
chips init.

> +	ret =3D ma35_nand_chips_init(&pdev->dev, nand);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to init NAND chips\n");
> +		clk_disable(nand->clk);
> +		return ret;
> +	}
> +
> +	return ret;
> +}

Thanks,
Miqu=C3=A8l


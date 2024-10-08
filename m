Return-Path: <linux-kernel+bounces-354833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CE999431F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BEE1C243E4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5D21DED7D;
	Tue,  8 Oct 2024 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nq3yAv+8"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE021C230D;
	Tue,  8 Oct 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377563; cv=none; b=adq8QvJ5umR8auu81vxH5uFfxMiZZVX0BKnGPi1YpYqf5prsDc3C0JPiicNthoWaHabQ8YKIkX6kPL86xJj0RihiZmiJIjE7bT4kvaERKR1zzA7sD8v4xtOwvCQs2NwwXpPw920v527K71xDfawZEOJ/U5Ukk1qQGIc06Qa6Slo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377563; c=relaxed/simple;
	bh=FwOk7fUdusFNaQDxYROcnzukI+NFMgkBIKpLiD8+FpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTs8w7LLRISfzucR7WG2MJir18XSjWTsnH1P+PmoBkECJN2fIqG/0/GO4ZIjwOMhc5Cy+SfUZPl0PW36Cwft4g8+qbBOJNFRMCq43egYTng3t2kY+1b0S0EETRU8tBZjwUKofsLivg2Umb7KXVJTDdVcQ+NJdmFmKgnbEQBCjR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nq3yAv+8; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68321C0008;
	Tue,  8 Oct 2024 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728377552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BblGE6WTuC3EcDgLDgj8Gh9/9mU9eFyYH4IyM8CF5wY=;
	b=nq3yAv+8K3pMFYPI8bpJwFUc135b4BHyKOv1ozQhmzc5//Vzeq08/qk6WbO9dOxfOY/CSC
	U+707VPaHTBFuhB/MoWaRAFErBgavxDZ2CxRrCfkHEtzEstOfaZ5b2hBAeY6Z8UKgHysJV
	h1B3+0MMG3AGbFjK5LeyXFnJ13uWnCNsn+TRURB+gFzXoDfS4Uhlg1Ho3SqTgBK5juR1go
	5lrvOMUfveqw+ypUfXUA/TjlvyobvD5o6YA590hPcpKkF3RR4/sKAgNqwzaerOVEbr0rdg
	/ymHwzg3b7DE5IgRup60mjY8H0tGindlLmh/77uew+DfU3uHHTgjygaW7Pvq7A==
Date: Tue, 8 Oct 2024 10:52:30 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
Message-ID: <20241008105230.7fd25438@xps-13>
In-Reply-To: <8d5e7755-17fd-4860-bcb0-8c1de04bf0c5@gmail.com>
References: <20240927020749.46791-1-hpchen0nvt@gmail.com>
	<20240927020749.46791-3-hpchen0nvt@gmail.com>
	<20241001215755.5c2f8465@xps-13>
	<8d5e7755-17fd-4860-bcb0-8c1de04bf0c5@gmail.com>
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

> >> +		return 0;
> >> +	}
> >> +
> >> +	ma35_nand_dmac_init(nand);
> >> +
> >> +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
> >> +
> >> +	/* setup and start DMA using dma_addr */
> >> +	dma_addr =3D dma_map_single(nand->dev, (void *)addr, len, DMA_FROM_D=
EVICE);
> >> +	ret =3D dma_mapping_error(nand->dev, dma_addr);
> >> +	if (ret) {
> >> +		dev_err(nand->dev, "dma mapping error\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	writel((unsigned long)dma_addr, nand->regs + MA35_NFI_REG_DMASA); =20
> > Please enforce a dma mask of 32 (even though it might be the fault). =20
>=20
> I will change it to dma_addr & 0xffffffff.

That's not what I mean, I believe you should use the dma API to ask for
a mapping within the accessible 32-bit address range. The
dma_mapping_error() check should return an error if that's not the
case. Then you can safely write the value.

> >> +	writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | DMA_R_EN,
> >> +		nand->regs + MA35_NFI_REG_NANDCTL);
> >> +	ret =3D wait_for_completion_timeout(&nand->complete, msecs_to_jiffie=
s(1000));
> >> +	if (!ret) {
> >> +		dev_err(nand->dev, "read timeout\n");
> >> +		ret =3D -ETIMEDOUT;
> >> +	}
> >> +
> >> +	dma_unmap_single(nand->dev, dma_addr, len, DMA_FROM_DEVICE);
> >> +
> >> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
> >> +	if (reg & INT_ECC) {
> >> +		cnt =3D ma35_nfi_ecc_check(&nand->chip, addr);
> >> +		if (cnt < 0) {
> >> +			mtd->ecc_stats.failed++;
> >> +			writel(DMA_RST | DMA_EN, nand->regs + MA35_NFI_REG_DMACTL);
> >> +			writel(readl(nand->regs + MA35_NFI_REG_NANDCTL) | SWRST,
> >> +				nand->regs + MA35_NFI_REG_NANDCTL);
> >> +		} else {
> >> +			mtd->ecc_stats.corrected +=3D cnt;
> >> +			nand->bitflips =3D cnt;
> >> +		}
> >> +		writel(INT_ECC, nand->regs + MA35_NFI_REG_NANDINTSTS);
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int ma35_nand_write_page_hwecc(struct nand_chip *chip, const u=
8 *buf,
> >> +				      int oob_required, int page)
> >> +{
> >> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> >> +	void *ecc_calc =3D chip->ecc.calc_buf;
> >> +
> >> +	ma35_clear_spare(chip, mtd->oobsize);
> >> +	ma35_write_spare(chip, mtd->oobsize - chip->ecc.total,
> >> +			(u32 *)chip->oob_poi);
> >> +
> >> +	nand_prog_page_begin_op(chip, page, 0, buf, mtd->writesize);
> >> +	nand_prog_page_end_op(chip);
> >> +
> >> +	/* Copy parity code in NANDRA to calc */
> >> +	ma35_read_spare(chip, chip->ecc.total, (u32 *)ecc_calc,
> >> +			mtd->oobsize - chip->ecc.total);
> >> +
> >> +	/* Copy parity code in calc to oob_poi */
> >> +	memcpy(chip->oob_poi + (mtd->oobsize - chip->ecc.total),
> >> +		ecc_calc, chip->ecc.total);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int ma35_nand_read_page_hwecc(struct nand_chip *chip, u8 *buf,
> >> +					int oob_required, int page)
> >> +{
> >> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> >> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> >> +	u32 reg;
> >> +
> >> +	/* read the OOB area  */
> >> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
> >> +	nand->bitflips =3D 0; =20
> > Why storing this value in your structure? =20
>=20
> Because ecc.read_page needs to return bit flips, it is necessary to log t=
hem.

I believe you don't need bitflips to be part of the ma35_nand_info
structure.

> >> +
> >> +	/* copy OOB data to NANDRA for page read */
> >> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
> >> +
> >> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDRA0);
> >> +	if (reg & 0xffff0000) {
> >> +		memset((void *)buf, 0xff, mtd->writesize);
> >> +	} else {
> >> +		/* read data from nand */
> >> +		nand_read_page_op(chip, page, 0, buf, mtd->writesize); =20
> > ret =3D
> > if (ret)
> > 	... =20
>=20
> I will add a return value here.
>=20
>=20
> >> +
> >> +		/* restore OOB data from SMRA */
> >> +		ma35_read_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi, 0); =20
> >
> > same =20
>=20
> ma35_read_spare() is declared as void, with no return value.
>=20
> SMRA will be changed to NANDRA registers.
>=20
>=20
> >> +	}
> >> +
> >> +	return nand->bitflips;
> >> +}
> >> +
> >> +static int ma35_nand_read_oob_hwecc(struct nand_chip *chip, int page)
> >> +{
> >> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> >> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> >> +	u32 reg;
> >> +
> >> +	nand_read_oob_op(chip, page, 0, chip->oob_poi, mtd->oobsize);
> >> +
> >> +	/* copy OOB data to NANDRA for page read */ =20
> > What is NANDRA? does not mean anything to me. =20
>=20
> NANDRA is the Redundant Area Word of the MA35 NAND controller.

NANDRA is specific to your controller. "redundant area" is already more
understandable.

>=20
> The controller reads ECC parity from this area for calculations or uses t=
he information for check.

This is what we generically call the "ECC bytes/area" I guess?

>=20
> I will change NANDRA to NANDRA registers.
>=20
>=20
> >> +	ma35_write_spare(chip, mtd->oobsize, (u32 *)chip->oob_poi);
> >> +
> >> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDRA0);
> >> +	if (reg & 0xffff0000)
> >> +		memset((void *)chip->oob_poi, 0xff, mtd->oobsize); =20
> > What does this mean? =20
>=20
> MA35 NAND controller checks oob bytes 2 and 3.
>=20
> If this page has been written, oob bytes 2 and 3 will be set to 0.
>=20
> Therefore, if bytes 2 and 3 are not 0, it indicates an empty page, and it=
 will return 0xff.

Ok, please define a macro for that, something along:

#define PREFIX_RA_HAS_BEEN_WRITTEN(reg) FIELD_GET(GENMASK(..), (reg))

if (!PREFIX_RA_HAS_BEEN_WRITTEN(reg))
	memset();

>=20
>=20
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static irqreturn_t ma35_nand_irq(int irq, void *id)
> >> +{
> >> +	struct ma35_nand_info *nand =3D (struct ma35_nand_info *)id;
> >> +	u32 isr;
> >> +
> >> +	isr =3D readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
> >> +	if (isr & INT_DMA) {
> >> +		writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTSTS);
> >> +		complete(&nand->complete);
> >> +	} =20
> > I guess a more future proof implementation would always writel(isr); to
> > silence the interrupt. Otherwise of course you must call complete()
> > only upon isr & INT_DMA. =20
>=20
> This part can remove the if(), but writel(isr) is not feasible.
>=20
> The isr may contain the ECC flag, and clearing it could cause a miss in E=
CC handling.
>=20
> I will change it to:
>=20
>  =C2=A0=C2=A0=C2=A0 writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTSTS);
>  =C2=A0=C2=A0=C2=A0 complete(&nand->complete);

In this case keep the if() but be sure to handle the timeout correctly.
>=20
>=20
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int ma35_nand_attach_chip(struct nand_chip *chip)
> >> +{
> >> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> >> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> >> +	unsigned int reg;
> >> +
> >> +	if (chip->options & NAND_BUSWIDTH_16) {
> >> +		dev_err(nand->dev, "16 bits bus width not supported");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	/* support only ecc hw mode */ =20
> > Why ? Please don't. =20
>=20
> I will add handling for other cases.
>=20
>=20
> >> +	if (chip->ecc.engine_type !=3D NAND_ECC_ENGINE_TYPE_ON_HOST) {
> >> +		dev_err(nand->dev, "ecc.engine_type not supported\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	nand->ecc_buf =3D devm_kzalloc(nand->dev, mtd->writesize + mtd->oobs=
ize,
> >> +					GFP_KERNEL);
> >> +	if (!nand->ecc_buf)
> >> +		return  -ENOMEM;
> >> +	chip->ecc.calc_buf =3D nand->ecc_buf; =20
> > Are you sure you need this? I don't see the point. =20
>=20
> This is unnecessary; I will remove it.
>=20
>=20
> >> +
> >> +	/* Set PSize */
> >> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~PSIZE_MASK);
> >> +	if (mtd->writesize =3D=3D 2048)
> >> +		writel(reg | PSIZE_2K, nand->regs + MA35_NFI_REG_NANDCTL);
> >> +	else if (mtd->writesize =3D=3D 4096)
> >> +		writel(reg | PSIZE_4K, nand->regs + MA35_NFI_REG_NANDCTL);
> >> +	else if (mtd->writesize =3D=3D 8192)
> >> +		writel(reg | PSIZE_8K, nand->regs + MA35_NFI_REG_NANDCTL);
> >> +
> >> +	chip->ecc.steps =3D mtd->writesize / chip->ecc.size;
> >> +	if (chip->ecc.strength =3D=3D 0) {
> >> +		nand->bch =3D BCH_NONE; /* No ECC */
> >> +		chip->ecc.total =3D 0;
> >> +	} else if (chip->ecc.strength <=3D 8) {
> >> +		nand->bch =3D BCH_T8; /* T8 */ =20
> > bch is probably a bad name, and in general I don't see the point of
> > saving this value. Just check the ECC strength in the above switch
> > cases and don't use this intermediate variable. =20
>=20
> I will change it to directly use ecc.strength for the check.
>=20
>=20
> >> +		chip->ecc.total =3D chip->ecc.steps * MA35_PARITY_BCH8;
> >> +	} else if (chip->ecc.strength <=3D 12) {
> >> +		nand->bch =3D BCH_T12; /* T12 */
> >> +		chip->ecc.total =3D chip->ecc.steps * MA35_PARITY_BCH12;
> >> +	} else if (chip->ecc.strength <=3D 24) {
> >> +		nand->bch =3D BCH_T24; /* T24 */
> >> +		chip->ecc.total =3D chip->ecc.steps * MA35_PARITY_BCH24;
> >> +	} else {
> >> +		dev_warn(nand->dev, "NAND Controller is not support this flash. (%d=
, %d)\n",
> >> +			mtd->writesize, mtd->oobsize); =20
> > This must be a dev_err() and return an error immediately.
> >
> > Also the string is not correct. =20
>=20
> I will change it to:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(nand->dev, "ECC stren=
gth error\n");

					    unsupported

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>=20
>=20

...

>=20
> >> +
> >> +static int ma35_nfc_exec_op(struct nand_chip *chip,
> >> +			  const struct nand_operation *op,
> >> +			  bool check_only)
> >> +{
> >> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> >> +	int ret =3D 0;
> >> +	u32 i, reg;
> >> +
> >> +	if (check_only)
> >> +		return 0;
> >> +
> >> +	ma35_nand_target_enable(nand);
> >> +
> >> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDINTSTS);
> >> +	reg |=3D INT_RB0; =20
> > This RB pin looks like something hardcoded, whereas it should not :-)
> >
> > If you have several RB, it means you have several CS as well! =20
>=20
> The MA35 NAND controller is indeed expected to support two sets of CS and=
 RB.
>=20
> However, currently, the MA35 series only supports one set, so this name w=
ill be changed to RB.

No, please use the correct names for RB and CS, but please read the
value of the right RB and right CS from the DT (reg and nand-rb). These
properties are standard and can be used to use eg CS1 and RB1. In this
case the whole driver logic is the same, there is a single CS
supported, but it becomes correct because you don't silently assume CS0
and RB0 will always be used (you would be surprised by the number of
designs not using the first CS/RB). It's just a bit of additional
logic, nothing complex here.


...

> >> +
> >> +	mtd =3D nand_to_mtd(chip);
> >> +	mtd->priv =3D chip;
> >> +	mtd->owner =3D THIS_MODULE;
> >> +	mtd->dev.parent =3D &pdev->dev;
> >> +
> >> +	writel(NAND_EN, nand->regs + MA35_NFI_REG_GCTL); =20
> > I would expect your reset bit to be set before this writel. =20
>=20
> Are you referring to SWRST? I will call the reset engine before enabling =
it.

Yes, thanks.

Thanks,
Miqu=C3=A8l


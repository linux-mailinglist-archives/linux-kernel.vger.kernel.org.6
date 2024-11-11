Return-Path: <linux-kernel+bounces-404540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF769C44E4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213ED281643
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536501AAE3A;
	Mon, 11 Nov 2024 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P+dWOpS4"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E791A76CC;
	Mon, 11 Nov 2024 18:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349329; cv=none; b=dA1FBmbQet64bHeEkOgsQti0/P6lLMly9qdEfE6i4eNNEOVaaQx+3aHjfqfiiylfIvvAC+kMs9PrdlW4ObQ5zQ+iHwSpfaYtollZSTVucdpVxIHM2SplfQmmEBjcbwDFQZAkP8ESvbHw1ZuLlwEn2oMup6P5hIpHrXVjuV4qf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349329; c=relaxed/simple;
	bh=PutfDBf0Mx9OWmqvjfRpMgbqwDTWo42qlTELEX0R0Bk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=quPlH53d3W8dLUAl931rr5lyT//1FURdjAgngW6Mym0ckyiLHa+9dBl8DEPMnd+AQvgnGvHjdZEOz2w1fAL+JtJO9JSToEjJkVpRxA6F3ECBtYxuv6+cJprwYgRJXtnnqryNyqJcwwkz00wViUPG/osUJa8xxJpCuhoZzq0l5ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P+dWOpS4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49EFE1C0005;
	Mon, 11 Nov 2024 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731349324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5qBMJyupmVmP3WenwgqG6fxdPxLJkkXl5JQ5DHXwD0=;
	b=P+dWOpS4lvwV7ml2Qfzzvid2JahTF5umrRz6pPlZxfoDSVN7P7RBPC5/L1AoCYDmEGs0z6
	GdDwxm/e9vaPg8V5YM6NfeSx4yMOUgh42kO+kgWriWfrwiFd8aP0fwgcKoIOcEyJxICjcT
	cZdji2E5SwsT6f8SzmW7zJzfOPv0P2496z5WA7e+5h4ZOpCkf1LCJdaCVT24l8Wngjqc2Y
	mYK/iiOEOP4qlB4TdWuml/EGZm+obhm5ZNr5y9qhERlkvscEShimeq1nJc5xtuWmMyZEUI
	BoLHmgJDkaqq/JTSpjMR3HbpocvPW8UvZmSp4xJEkexDK7lIJ+dgKPl/tg/hnw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Hui-Ping Chen <hpchen0nvt@gmail.com>
Cc: richard@nod.at,  vigneshr@ti.com,  robh@kernel.org,  krzk+dt@kernel.org,
  conor+dt@kernel.org,  nikita.shubin@maquefel.me,  arnd@arndb.de,
  vkoul@kernel.org,  esben@geanix.com,
  linux-arm-kernel@lists.infradead.org,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] mtd: rawnand: nuvoton: add new driver for the
 Nuvoton MA35 SoC
In-Reply-To: <20241023092617.108021-3-hpchen0nvt@gmail.com> (Hui-Ping Chen's
	message of "Wed, 23 Oct 2024 09:26:17 +0000")
References: <20241023092617.108021-1-hpchen0nvt@gmail.com>
	<20241023092617.108021-3-hpchen0nvt@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 11 Nov 2024 19:22:02 +0100
Message-ID: <87y11p1vhx.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

> +static int ma35_nand_attach_chip(struct nand_chip *chip)
> +{
> +	struct ma35_nand_info *nand =3D nand_get_controller_data(chip);
> +	struct ma35_nand_chip *nvtnand =3D to_ma35_nand(chip);
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
> +	struct device *dev =3D mtd->dev.parent;
> +	u32 reg;
> +
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		dev_err(dev, "16 bits bus width not supported");
> +		return -EINVAL;
> +	}
> +
> +	nvtnand->nchunks =3D mtd->writesize / chip->ecc.steps;
> +	nvtnand->nchunks =3D (nvtnand->nchunks < 4) ? 1 : nvtnand->nchunks / 4;

This second division looks broken. Also, you probably don't want to do
that outside of the ON_HOST situation. Finally, you should probably
update chip->ecc.steps and chip->ecc.size to your final choice.

> +
> +	reg =3D readl(nand->regs + MA35_NFI_REG_NANDCTL) & (~PSIZE_MASK);
> +	if (mtd->writesize =3D=3D 2048)
> +		writel(reg | PSIZE_2K, nand->regs + MA35_NFI_REG_NANDCTL);
> +	else if (mtd->writesize =3D=3D 4096)
> +		writel(reg | PSIZE_4K, nand->regs + MA35_NFI_REG_NANDCTL);
> +	else if (mtd->writesize =3D=3D 8192)
> +		writel(reg | PSIZE_8K, nand->regs + MA35_NFI_REG_NANDCTL);
> +
> +	switch (chip->ecc.engine_type) {
> +	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> +		chip->options |=3D NAND_NO_SUBPAGE_WRITE | NAND_USES_DMA;

What is the reason for refusing subpage writes? This is not something
you can do later, so unless there is a good reason, please do not set
this flag.

> +		chip->ecc.write_page =3D ma35_nand_write_page_hwecc;
> +		chip->ecc.read_page  =3D ma35_nand_read_page_hwecc;
> +		chip->ecc.read_oob   =3D ma35_nand_read_oob_hwecc;
> +		return ma35_nand_hwecc_init(chip, nand);
> +	case NAND_ECC_ENGINE_TYPE_NONE:
> +	case NAND_ECC_ENGINE_TYPE_SOFT:
> +	case NAND_ECC_ENGINE_TYPE_ON_DIE:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +

...

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

Please convert to device_property_ helpers. And remove the of include
once you no longer need it.

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

...

> +
> +	ret =3D mtd_device_register(mtd, NULL, 0);
> +	if (ret) {
> +		dev_err(dev, "MTD parse partition error\n");

probably useless error message?

> +		nand_cleanup(chip);
> +		return ret;
> +	}
> +
> +	list_add_tail(&nvtnand->node, &nand->chips);
> +
> +	return 0;
> +}

I believe next iteration should be the one, I'm rather happy with the
overall look.

Thanks,
Miqu=C3=A8l


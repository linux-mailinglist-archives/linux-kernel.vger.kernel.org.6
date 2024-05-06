Return-Path: <linux-kernel+bounces-169930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 971408BCF7D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26DFB223E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F9380032;
	Mon,  6 May 2024 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oo8780Sl"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB587FBC3;
	Mon,  6 May 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715003616; cv=none; b=ncQ8lENaX7MF1ScYi20KmQa//gfXf880Q+2VtEFZp3I9Z0p7/slesIKse2Z0ZiXveXotVzqyWmaf/SECc1tJvR2KjV5CoH/dOJuPJo5FbYa+Q9JNssLLj2hwz7yTELuWH1y+zK+ACPMEnLikhFCd9dAFmiPPMo6qBDj6hQAYibY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715003616; c=relaxed/simple;
	bh=ZBw308vScpWpI6OOmAtYussqcW3H4nJ0DvHxVE73cic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsP11WrkoKYxTSZuklYd+dCNvlubj8jO1JjItW9n/hrEStWcale1nCarOzkUJPz9JSu8MQIBBhtINw8XfaUVBVLJN6CU+dBsX7fRdKfQe4YZ4HbdE14Ocx6GLuwhbWzE99/Xx/XgxiWlOqxKtsoGhbYXIWTmsBKXsXVh/qSXXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oo8780Sl; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CFD9C60002;
	Mon,  6 May 2024 13:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715003606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rl4J4sIVm+WsZbjOlT+E1mrylIFIWJ8bHbGao9o7iXw=;
	b=oo8780SlEJkCVOPPXFOPXAqPxufjs+dTIjDui17WFF/ls4iGGmMYvS8ZmJlz0Ph+EhTCmV
	9Dmitav+5z38uU64tHCsETTex1QgZnE2ipeEHFHy1cpMaMnQuqDDt//UKA6dS8B01odvtH
	shs2EgcW1RgDT71l3ESfZnostdVzXOtWK/uSZ1GOEt5wjWudIuWCy8Xe2wUIeZbWzz5q4x
	RTt5L43U1Bxoobv7ifVBN1iSOXKbgXAYMlLFjNWqhRrrZYKYrs8dHNukALuVTWi0/hwKHN
	QCg9mcVvrd8QYy8kGZkskUKV7wSveAf/nw85zKkyHHkZYrhf56GUTdDGxUzFJA==
Date: Mon, 6 May 2024 15:53:22 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <oxffffaa@gmail.com>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: support R/W mode for boot
 ROM
Message-ID: <20240506155322.002346d0@xps-13>
In-Reply-To: <20240416085101.740458-3-avkrasnov@salutedevices.com>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
	<20240416085101.740458-3-avkrasnov@salutedevices.com>
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

Hi Arseniy,

avkrasnov@salutedevices.com wrote on Tue, 16 Apr 2024 11:51:01 +0300:

> Boot ROM code on Meson requires that some pages on NAND must be written
> in special mode: "short" ECC mode where each block is 384 bytes and
> scrambling mode is on. Such pages located with the specified interval
> within specified offset. Both interval and offset are located in the
> device tree and used by driver if 'nand-is-boot-medium' is set for
> NAND chip.
>=20
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 88 +++++++++++++++++++++----------
>  1 file changed, 59 insertions(+), 29 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/mes=
on_nand.c
> index 00ce0e5bb970..9ee11243b257 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -35,6 +35,7 @@
>  #define NFC_CMD_RB		BIT(20)
>  #define NFC_CMD_SCRAMBLER_ENABLE	BIT(19)
>  #define NFC_CMD_SCRAMBLER_DISABLE	0
> +#define NFC_CMD_SHORTMODE_ENABLE	1
>  #define NFC_CMD_SHORTMODE_DISABLE	0
>  #define NFC_CMD_RB_INT		BIT(14)
>  #define NFC_CMD_RB_INT_NO_PIN	((0xb << 10) | BIT(18) | BIT(16))
> @@ -78,6 +79,8 @@
>  #define DMA_DIR(dir)		((dir) ? NFC_CMD_N2M : NFC_CMD_M2N)
>  #define DMA_ADDR_ALIGN		8
> =20
> +#define NFC_SHORT_MODE_ECC_SZ	384
> +
>  #define ECC_CHECK_RETURN_FF	(-1)
> =20
>  #define NAND_CE0		(0xe << 10)
> @@ -125,6 +128,8 @@ struct meson_nfc_nand_chip {
>  	u32 twb;
>  	u32 tadl;
>  	u32 tbers_max;
> +	u32 boot_pages;
> +	u32 boot_page_step;
> =20
>  	u32 bch_mode;
>  	u8 *data_buf;
> @@ -298,28 +303,49 @@ static void meson_nfc_cmd_seed(struct meson_nfc *nf=
c, u32 seed)
>  	       nfc->reg_base + NFC_REG_CMD);
>  }
> =20
> -static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool d=
ir,
> -				 int scrambler)
> +static int meson_nfc_page_is_boot(struct nand_chip *nand, int page)

meson_nfc_is_boot_page() is easier to read

> +{
> +	const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> +
> +	return (nand->options & NAND_IS_BOOT_MEDIUM) &&
> +	       !(page % meson_chip->boot_page_step) &&

I would dedicate all the space below ->boot_pages to the bootrom, no?
Using space in between sounds silly.

> +	       (page < meson_chip->boot_pages);
> +}
> +
> +static void meson_nfc_cmd_access(struct nand_chip *nand, bool raw, bool =
dir, int page)
>  {
> +	const struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
>  	struct mtd_info *mtd =3D nand_to_mtd(nand);
>  	struct meson_nfc *nfc =3D nand_get_controller_data(mtd_to_nand(mtd));
> -	struct meson_nfc_nand_chip *meson_chip =3D to_meson_nand(nand);
> -	u32 bch =3D meson_chip->bch_mode, cmd;
>  	int len =3D mtd->writesize, pagesize, pages;
> +	int scrambler;
> +	u32 cmd;
> =20
> -	pagesize =3D nand->ecc.size;
> +	if (nand->options & NAND_NEED_SCRAMBLING)
> +		scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
> +	else
> +		scrambler =3D NFC_CMD_SCRAMBLER_DISABLE;

That is a separate feature?

> =20
>  	if (raw) {
>  		len =3D mtd->writesize + mtd->oobsize;
>  		cmd =3D len | scrambler | DMA_DIR(dir);
> -		writel(cmd, nfc->reg_base + NFC_REG_CMD);
> -		return;
> -	}
> +	} else if (meson_nfc_page_is_boot(nand, page)) {
> +		pagesize =3D NFC_SHORT_MODE_ECC_SZ >> 3;
> +		pages =3D mtd->writesize / 512;
> +
> +		scrambler =3D NFC_CMD_SCRAMBLER_ENABLE;
> +		cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, NFC_ECC_BCH8_1K,
> +			       NFC_CMD_SHORTMODE_ENABLE, pagesize, pages);
> +	} else {
> +		pagesize =3D nand->ecc.size >> 3;
> +		pages =3D len / nand->ecc.size;
> =20
> -	pages =3D len / nand->ecc.size;
> +		cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, meson_chip->bch_mode,
> +			       NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
> +	}
> =20
> -	cmd =3D CMDRWGEN(DMA_DIR(dir), scrambler, bch,
> -		       NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
> +	if (scrambler =3D=3D NFC_CMD_SCRAMBLER_ENABLE)
> +		meson_nfc_cmd_seed(nfc, page);
> =20
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  }
> @@ -743,15 +769,7 @@ static int meson_nfc_write_page_sub(struct nand_chip=
 *nand,
>  	if (ret)
>  		return ret;
> =20
> -	if (nand->options & NAND_NEED_SCRAMBLING) {
> -		meson_nfc_cmd_seed(nfc, page);
> -		meson_nfc_cmd_access(nand, raw, DIRWRITE,
> -				     NFC_CMD_SCRAMBLER_ENABLE);
> -	} else {
> -		meson_nfc_cmd_access(nand, raw, DIRWRITE,
> -				     NFC_CMD_SCRAMBLER_DISABLE);
> -	}
> -

Ok I get it, the feature already exist but is handled differently.
Please split this patch:
- improve scrambler handling to facilitate boot page support
- add boot pages support

> +	meson_nfc_cmd_access(nand, raw, DIRWRITE, page);
>  	cmd =3D nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
>  	meson_nfc_queue_rb(nand, PSEC_TO_MSEC(sdr->tPROG_max), false);
> @@ -829,15 +847,7 @@ static int meson_nfc_read_page_sub(struct nand_chip =
*nand,
>  	if (ret)
>  		return ret;
> =20
> -	if (nand->options & NAND_NEED_SCRAMBLING) {
> -		meson_nfc_cmd_seed(nfc, page);
> -		meson_nfc_cmd_access(nand, raw, DIRREAD,
> -				     NFC_CMD_SCRAMBLER_ENABLE);
> -	} else {
> -		meson_nfc_cmd_access(nand, raw, DIRREAD,
> -				     NFC_CMD_SCRAMBLER_DISABLE);
> -	}
> -
> +	meson_nfc_cmd_access(nand, raw, DIRREAD, page);
>  	ret =3D meson_nfc_wait_dma_finish(nfc);
>  	meson_nfc_check_ecc_pages_valid(nfc, nand, raw);
> =20
> @@ -1436,6 +1446,26 @@ meson_nfc_nand_chip_init(struct device *dev,
>  	if (ret)
>  		return ret;
> =20
> +	if (nand->options & NAND_IS_BOOT_MEDIUM) {
> +		ret =3D of_property_read_u32(np, "amlogic,boot-pages",
> +					   &meson_chip->boot_pages);
> +		if (ret) {
> +			dev_err(dev, "could not retrieve 'amlogic,boot-pages' property: %d",
> +				ret);
> +			nand_cleanup(nand);
> +			return ret;
> +		}
> +
> +		ret =3D of_property_read_u32(np, "amlogic,boot-page-step",
> +					   &meson_chip->boot_page_step);
> +		if (ret) {
> +			dev_err(dev, "could not retrieve 'amlogic,boot-page-step' property: %=
d",
> +				ret);
> +			nand_cleanup(nand);
> +			return ret;
> +		}
> +	}
> +
>  	ret =3D mtd_device_register(mtd, NULL, 0);
>  	if (ret) {
>  		dev_err(dev, "failed to register MTD device: %d\n", ret);


Thanks,
Miqu=C3=A8l


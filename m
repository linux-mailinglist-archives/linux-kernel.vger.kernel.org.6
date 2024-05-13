Return-Path: <linux-kernel+bounces-177269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A298C3C30
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 09:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 073161C2109E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 07:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD828146A91;
	Mon, 13 May 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SN8EruZm"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82060168DA
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715586142; cv=none; b=twAGTpReptwgJXWnUPV0kqgOMnFes4yb8WklK3evRN23SKm/DKI/U6Ne+TobjNVgCEm+6qwGpzhfJiOcqY2m3o0KdDUR6eRi7dTu95GmDob35pB8lqp3Vx6rYupPcK6pZDEEu+kXPXb8ARw6RUJOVH9Sqg1hsWRtBEsZ09epsdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715586142; c=relaxed/simple;
	bh=WeoXoUQG4Spg2BNA3NuECdzYTo+AevDS5kWMpRMHe8c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bGF5gaGbXTD9SK5la4XMgrVTOuzCgjcHXjqEN8Ka24VUZ9E3faHFY9SEWtzj+eA2RJl23Pa3OL0zvgr02w6XGz3d2HBXKymkOlvs7NdFgUygJCYANBRYyeFGqF304/wZNQiQyFuV6C9qQ5iLPs6Ji66w+f6VEElM3Ocju/oZY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SN8EruZm; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B7F10E0070;
	Mon, 13 May 2024 07:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715586138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dDor7bdmkwOSRGCuBAJQQIoJD+BBzutL1t/QhzKUfc=;
	b=SN8EruZmgvDjmf7NTjlt1VZtsF2qArsga9lQiQ4GoheJnVL/opvgagI5SLWG5hctaITWTz
	6FhamsD0/im3RZkspGxRzDS2MN+86F8AdP95DJQ5PWBBjPeaOzpkP8sI5rUgD3mHWGG2C+
	N4My9jFvajhdy431RQuiZSzYlIAYHrng/SQi/vPWqBibyaqyVt48cbiApvotWsoha1ZuNh
	hBosGqHHHsFxZ4umOCRg6ulk92dvdmlSCz+v3ll6S8ny4ndx2XR9oK/zegiHfX5egksBDq
	JqprPEkEGoRY8Sh5pnPsMb3np28qLdAGnJek3wbSRT0T/dVgETTcRuDqYsVcxw==
Date: Mon, 13 May 2024 09:42:17 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] mtd: nand: mxc_nand: support software ECC
Message-ID: <20240513094217.4c1a0fc2@xps-13>
In-Reply-To: <20240508-mtd-nand-mxc-nand-exec-op-v2-3-6b7366b7831f@pengutronix.de>
References: <20240508-mtd-nand-mxc-nand-exec-op-v2-0-6b7366b7831f@pengutronix.de>
	<20240508-mtd-nand-mxc-nand-exec-op-v2-3-6b7366b7831f@pengutronix.de>
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

Hi Sascha,

s.hauer@pengutronix.de wrote on Wed, 08 May 2024 13:08:29 +0200:

> With these changes the driver can be used with software BCH ECC which
> is useful for NAND chips that require a stronger ECC than the i.MX
> hardware supports.
>=20
> The controller normally interleaves user data with OOB data when
> accessing the NAND chip. With Software BCH ECC we write the data
> to the NAND in a way that the raw data on the NAND chip matches the
> way the NAND layer sees it. This way commands like NAND_CMD_RNDOUT
> work as expected.
>=20
> This was tested on i.MX27 but should work on the other SoCs supported
> by this driver as well.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mtd/nand/raw/mxc_nand.c | 84 +++++++++++++++++++++++++++++++++++=
+-----
>  1 file changed, 75 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_n=
and.c
> index 1e8b4553e03ba..7004fd57c80f7 100644
> --- a/drivers/mtd/nand/raw/mxc_nand.c
> +++ b/drivers/mtd/nand/raw/mxc_nand.c
> @@ -178,6 +178,7 @@ struct mxc_nand_host {
>  	int			used_oobsize;
>  	int			active_cs;
>  	unsigned int		ecc_stats_v1;
> +	unsigned int		column;
> =20
>  	struct completion	op_completion;
> =20
> @@ -1397,10 +1398,10 @@ static int mxcnd_attach_chip(struct nand_chip *ch=
ip)
>  	chip->ecc.bytes =3D host->devtype_data->eccbytes;
>  	host->eccsize =3D host->devtype_data->eccsize;
>  	chip->ecc.size =3D 512;
> -	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
> =20
>  	switch (chip->ecc.engine_type) {
>  	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> +		mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
>  		chip->ecc.read_page =3D mxc_nand_read_page;
>  		chip->ecc.read_page_raw =3D mxc_nand_read_page_raw;
>  		chip->ecc.read_oob =3D mxc_nand_read_oob;
> @@ -1465,6 +1466,54 @@ static int mxcnd_setup_interface(struct nand_chip =
*chip, int chipnr,
>  	return host->devtype_data->setup_interface(chip, chipnr, conf);
>  }
> =20
> +static void copy_page_to_sram(struct mtd_info *mtd)
> +{
> +	struct nand_chip *this =3D mtd_to_nand(mtd);
> +	struct mxc_nand_host *host =3D nand_get_controller_data(this);
> +	void *buf =3D host->data_buf;
> +	unsigned int n_subpages =3D mtd->writesize / 512;
> +	int oob_per_subpage, i;
> +
> +	/* mtd->writesize is not set during ident scanning */
> +	if (!n_subpages)
> +		n_subpages =3D 1;
> +
> +	oob_per_subpage =3D (mtd->oobsize / n_subpages) & ~1;
> +
> +	for (i =3D 0; i < n_subpages; i++) {
> +		memcpy16_toio(host->main_area0 + i * 512, buf, 512);
> +		buf +=3D 512;
> +
> +		memcpy16_toio(host->spare0 + i * host->devtype_data->spare_len, buf,
> +			      oob_per_subpage);
> +		buf +=3D oob_per_subpage;
> +	}
> +}
> +
> +static void copy_page_from_sram(struct mtd_info *mtd)
> +{
> +	struct nand_chip *this =3D mtd_to_nand(mtd);
> +	struct mxc_nand_host *host =3D nand_get_controller_data(this);
> +	void *buf =3D host->data_buf;
> +	unsigned int n_subpages =3D mtd->writesize / 512;
> +	int oob_per_subpage, i;
> +
> +	/* mtd->writesize is not set during ident scanning */
> +	if (!n_subpages)
> +		n_subpages =3D 1;
> +
> +	oob_per_subpage =3D (mtd->oobsize / n_subpages) & ~1;
> +
> +	for (i =3D 0; i < n_subpages; i++) {
> +		memcpy16_fromio(buf, host->main_area0 + i * 512, 512);
> +		buf +=3D 512;
> +
> +		memcpy16_fromio(buf, host->spare0 + i * host->devtype_data->spare_len,
> +				oob_per_subpage);
> +		buf +=3D oob_per_subpage;
> +	}
> +}
> +
>  static int mxcnd_exec_op(struct nand_chip *chip,
>  			 const struct nand_operation *op,
>  			 bool check_only)
> @@ -1496,8 +1545,11 @@ static int mxcnd_exec_op(struct nand_chip *chip,
>  			 */
>  			break;
>  		case NAND_OP_CMD_INSTR:
> -			if (instr->ctx.cmd.opcode =3D=3D NAND_CMD_PAGEPROG)
> +			if (instr->ctx.cmd.opcode =3D=3D NAND_CMD_PAGEPROG) {
> +				if (chip->ecc.engine_type !=3D NAND_ECC_ENGINE_TYPE_ON_HOST)
> +					copy_page_to_sram(mtd);
>  				host->devtype_data->send_page(mtd, NFC_INPUT);
> +			}

Same as before: data moves should not happen here.

> =20
>  			host->devtype_data->send_cmd(host, instr->ctx.cmd.opcode, true);
> =20
> @@ -1506,6 +1558,8 @@ static int mxcnd_exec_op(struct nand_chip *chip,
>  			if (instr->ctx.cmd.opcode =3D=3D NAND_CMD_STATUS)
>  				statusreq =3D true;
> =20
> +			host->column =3D 0;
> +

This is risky but maybe this is the trick to get NAND_CMD_RNDOUT
working? If yes maybe it is worth separating from this patchset, if
possible, with a comment explaining what this is all about (the
controller's SRAM being some kind of 1:1 mapping with the NAND SRAM,
thus we need to write the data at the correct offset in the controller
SRAM, I guess?).

Please write the comment above when defining the column field, and
also, if my understanding is correct, can we rename it to sram_column
or something like that?

>  			break;
>  		case NAND_OP_ADDR_INSTR:
>  			for (j =3D 0; j < instr->ctx.addr.naddrs; j++) {
> @@ -1517,9 +1571,14 @@ static int mxcnd_exec_op(struct nand_chip *chip,
>  			buf_write =3D instr->ctx.data.buf.out;
>  			buf_len =3D instr->ctx.data.len;
> =20
> -			memcpy32_toio(host->main_area0, buf_write, buf_len);
> -			if (chip->oob_poi)
> -				copy_spare(mtd, false, chip->oob_poi);
> +			if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_HOST) {
> +				memcpy32_toio(host->main_area0, buf_write, buf_len);
> +				if (chip->oob_poi)
> +					copy_spare(mtd, false, chip->oob_poi);
> +			} else {
> +				memcpy(host->data_buf + host->column, buf_write, buf_len);
> +				host->column +=3D buf_len;
> +			}
> =20
>  			break;
>  		case NAND_OP_DATA_IN_INSTR:
> @@ -1552,11 +1611,18 @@ static int mxcnd_exec_op(struct nand_chip *chip,
> =20
>  			host->devtype_data->read_page(chip);
> =20
> -			if (IS_ALIGNED(buf_len, 4)) {
> -				memcpy32_fromio(buf_read, host->main_area0, buf_len);
> +			if (chip->ecc.engine_type =3D=3D NAND_ECC_ENGINE_TYPE_ON_HOST) {
> +				if (IS_ALIGNED(buf_len, 4)) {
> +					memcpy32_fromio(buf_read, host->main_area0, buf_len);
> +				} else {
> +					memcpy32_fromio(host->data_buf, host->main_area0, mtd->writesize);
> +					memcpy(buf_read, host->data_buf, buf_len);
> +				}
>  			} else {
> -				memcpy32_fromio(host->data_buf, host->main_area0, mtd->writesize);
> -				memcpy(buf_read, host->data_buf, buf_len);
> +				if (!host->column)
> +					copy_page_from_sram(mtd);
> +				memcpy(buf_read, host->data_buf + host->column, buf_len);
> +				host->column +=3D buf_len;
>  			}
> =20
>  			break;
>=20


Thanks,
Miqu=C3=A8l


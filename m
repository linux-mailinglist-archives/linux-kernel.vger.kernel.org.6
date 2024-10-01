Return-Path: <linux-kernel+bounces-345675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D0898B922
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA88FB23DE2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDAF19DF77;
	Tue,  1 Oct 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fi+shI2h"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7FF3209
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727777849; cv=none; b=qsW/EC6yb59j1t19ECqHjH+8AY7DUv5OfykJE44/j9iOn/jBYJA82Cz2QQ+S+EOBzYLsHJVCP6qIx4iW4i1iGX2mJ5ysC7xa/EMOonjp2m/6SByjJBkMhGjckQls6gQOeWsd3xudqDS8hCKbQdwMG47AdVWBgzR9nsV/AiZsbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727777849; c=relaxed/simple;
	bh=I5s3PMnJIYKJsBxGUM6/X8Bd1Iqzuh4phZNdtyU7IPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHcv9RR27yGWioPPOC+ixmde9jbMOUntuk/RSjkIeUOG+XmP+/56+OVyWGjWEBxbEH4IveQiXoT4IEHMGe1xGV0WIg2dBkgXbseeAc0mdz9yLOKuE3bFPwYLMkMSgukLzftrqq5YaNd9gpmyH7enC7drNJ6bf4suiT8tdN5R7yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fi+shI2h; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB755C0005;
	Tue,  1 Oct 2024 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727777845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzlKtMlNbWoB+9nbUO2l1PKIgrmDbUGSSNNWpNY2W8k=;
	b=fi+shI2hhDTsgzZeDttStg0qgsb/l+MA8w3CYU5gBmiYGdstiOKv7a4wIoLqomFeuudCd5
	D0eL73e4legzoXxdIs6EzvFzgoqrKj2/iVAQo3v76LlTeYdTJ+13eEjVJBDUrbe53T85k1
	1otd+yD98h4bhMlALyD5p4Rd6eD4385z82nPgdErv24JxR67dEgvSLdAv6fJRbyIUAmtwD
	/BB35l1Zoeq65XSt1oRVXMC5Dpb3XL6qz/Tq5JtXK0rIEseEBE7Ow7GMYg769NFZUQYWsl
	/Fb9dtwR+71/6mxU2Hdy0cr1UdG+M8IjIH/kzsUjOj+zvINYk2UAT6c5Bx0faw==
Date: Tue, 1 Oct 2024 12:17:24 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 2/2] mtd: spi-nand: Add read retry support
Message-ID: <20241001121724.5edbb64b@xps-13>
In-Reply-To: <20240905055333.2363358-3-linchengming884@gmail.com>
References: <20240905055333.2363358-1-linchengming884@gmail.com>
	<20240905055333.2363358-3-linchengming884@gmail.com>
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

Hi Cheng Ming,

linchengming884@gmail.com wrote on Thu,  5 Sep 2024 13:53:33 +0800:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> When the host ECC fails to correct the data error of NAND device,
> there's a special read for data recovery method which host setups
> for the next read retry mode and may recover the lost data by host
> ECC again.
>=20
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> ---
>  drivers/mtd/nand/spi/core.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index e0b6715e5dfe..2f21ea926132 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -640,6 +640,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, lof=
f_t from,
>  	struct nand_io_iter iter;
>  	bool disable_ecc =3D false;
>  	bool ecc_failed =3D false;
> +	u8 retry_mode =3D 0;
>  	int ret =3D 0;
> =20
>  	if (ops->mode =3D=3D MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
> @@ -657,20 +658,45 @@ static int spinand_mtd_read(struct mtd_info *mtd, l=
off_t from,

This will no longer apply with continuous support added in. However
please make this only in the non continuous path. I don't think it can
fly in the other.

>  		if (ret)
>  			break;
> =20
> +read_retry:
>  		ret =3D spinand_read_page(spinand, &iter.req);
>  		if (ret < 0 && ret !=3D -EBADMSG)
>  			break;
> =20
> -		if (ret =3D=3D -EBADMSG)
> +		if (ret =3D=3D -EBADMSG && spinand->info->fixups) {
> +			if (spinand->read_retries && ((retry_mode + 1) < spinand->read_retrie=
s)) {

							++retry_mode?
> +				retry_mode++;

So this can be dropped.

> +				ret =3D spinand->info->fixups->setup_read_retry(spinand, retry_mode);
> +				if (ret < 0)
> +					break;

No, you need to set ecc_failed here.

> +
> +				/* Reset ecc_stats; retry */
> +				mtd->ecc_stats =3D old_stats;
> +				goto read_retry;
> +			} else {
> +				/* No more retry modes; real failure */
> +				ecc_failed =3D true;
> +			}
> +		} else if (ret =3D=3D -EBADMSG) {
>  			ecc_failed =3D true;
> -		else
> +		} else {
>  			max_bitflips =3D max_t(unsigned int, max_bitflips, ret);
> +		}
> =20
>  		ret =3D 0;
>  		ops->retlen +=3D iter.req.datalen;
>  		ops->oobretlen +=3D iter.req.ooblen;
> +
> +		/* Reset to retry mode 0*/
> +		if (retry_mode) {

			retry_mode =3D 0;

> +			ret =3D spinand->info->fixups->setup_read_retry(spinand, 0);

									retry_mode);

> +			if (ret < 0)
> +				break;

this if clause is useless.

> +			retry_mode =3D 0;

And then this can be dropped from here.

> +		}
>  	}
> =20
> +

Spurious line

>  	if (ops->stats) {
>  		ops->stats->uncorrectable_errors +=3D
>  			mtd->ecc_stats.failed - old_stats.failed;
> @@ -1095,6 +1121,9 @@ int spinand_match_and_init(struct spinand_device *s=
pinand,
>  		spinand->flags =3D table[i].flags;
>  		spinand->id.len =3D 1 + table[i].devid.len;
>  		spinand->select_target =3D table[i].select_target;
> +		spinand->info =3D info;
> +		if (spinand->info->fixups && spinand->info->fixups->init_read_retry)
> +			spinand->read_retries =3D spinand->info->fixups->init_read_retry(spin=
and);

Now I get you init. Ok, fine.

> =20
>  		op =3D spinand_select_op_variant(spinand,
>  					       info->op_variants.read_cache);


Thanks,
Miqu=C3=A8l


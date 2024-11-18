Return-Path: <linux-kernel+bounces-412750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889AA9D0ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 11:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0137EB2FDF5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 10:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94D194A54;
	Mon, 18 Nov 2024 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QOEHaYre"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49649194141
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925916; cv=none; b=ay8CG4KrME1550bvVyXmnSHImPlmof7khw1HFBe7+efd8BIMF3jEP9nvsnpvUsUJlSE4leP8zarlLY494ZZ2sO3GGwS7Wk3hdDqP1ClJ5BZvVyE4K9b8UQhGXUJFL97WrWwRzzC/3Z+VQywXs3fCZ/6y2qXq0nR14PAj08o3DfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925916; c=relaxed/simple;
	bh=8cMgpZLTOAtEmlOq/SHwcVlhZIAmHmjelmaEJ9+Gf8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U+8Q3T3GPS8VLqGoRL6sCn4Hd9MGPM2PUAFfJLX+MsZJKPRffnTguRpPNrmxBJl/lUHtDifFTNla/3yRz9y/yhMd9W5mLFIViDaeIs5kCV/tWGQAPNzHju8uLubS3bWDnoI+x5fpiI0LvmqUgCwn/yc+v6nrVpdnYIxcD1mVcT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QOEHaYre; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2798F1BF20D;
	Mon, 18 Nov 2024 10:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731925912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcC3Xe5zohmo64rpnW3zHlxj6r5J3OjyHF6/WkG0CLQ=;
	b=QOEHaYretuz+WxWtygPy9SWFMvrzZ7jl3dwGOmEQQ6Hd9xkAC8V6ltrruhj5ZLOdELTMVi
	/riB4Cx1fG9KBrXhIHMV+SFCHomIHtiudG0c+18y50pbtEyOGlc/WCIM6XEVfmN1/LX6fa
	PRMeYa9crD2M7hXN6IM5GuNzFfiuxnOHRxes8fYqkFj2je1xPHBOmSjc8dlsgwazADGT5z
	yTfEPA9lOFkP69WVtFGxW+yQYSCUWmjHvoAcAXQuDAZs62F1QlZbwHeiSALPsk5UGVxCSz
	M1spmQPNhJsIR1QHwZtGt2+0tzkoyzrGO+17QkzGx82Jl/ALTXCB9rlddsnFqA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  richard@nod.at,  alvinzhou@mxic.com.tw,
  leoyu@mxic.com.tw,  Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v2 1/2] mtd: spi-nand: Add read retry support
In-Reply-To: <20241114023528.181583-2-linchengming884@gmail.com> (Cheng Ming
	Lin's message of "Thu, 14 Nov 2024 10:35:27 +0800")
References: <20241114023528.181583-1-linchengming884@gmail.com>
	<20241114023528.181583-2-linchengming884@gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 11:31:50 +0100
Message-ID: <87a5dw25pl.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com


Hi Cheng Ming,

On 14/11/2024 at 10:35:27 +08, Cheng Ming Lin <linchengming884@gmail.com> w=
rote:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>
> When the host ECC fails to correct the data error of NAND device,
> there's a special read for data recovery method which host setups

Here is a suggestion for rewording the second part of your commit log:

... which can be setup by the host for the next read. There are several
retry levels that can be attempted until the lost data is recovered or
definitely assumed lost.

> for the next read retry mode and may recover the lost data by host
> ECC again.
>
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> ---
>  drivers/mtd/nand/spi/core.c | 35 +++++++++++++++++++++++++++++++++--
>  include/linux/mtd/spinand.h | 14 ++++++++++++++
>  2 files changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 4d76f9f71a0e..bd5339a308aa 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -672,10 +672,14 @@ static int spinand_mtd_regular_page_read(struct mtd=
_info *mtd, loff_t from,
>  	struct spinand_device *spinand =3D mtd_to_spinand(mtd);
>  	struct nand_device *nand =3D mtd_to_nanddev(mtd);
>  	struct nand_io_iter iter;
> +	struct mtd_ecc_stats old_stats;

Reverse christmas tree is nicer :)

>  	bool disable_ecc =3D false;
>  	bool ecc_failed =3D false;
> +	unsigned int retry_mode =3D 0;
>  	int ret;
>=20=20
> +	old_stats =3D mtd->ecc_stats;
> +
>  	if (ops->mode =3D=3D MTD_OPS_RAW || !mtd->ooblayout)
>  		disable_ecc =3D true;
>=20=20
> @@ -687,18 +691,43 @@ static int spinand_mtd_regular_page_read(struct mtd=
_info *mtd, loff_t from,
>  		if (ret)
>  			break;
>=20=20
> +read_retry:
>  		ret =3D spinand_read_page(spinand, &iter.req);
>  		if (ret < 0 && ret !=3D -EBADMSG)
>  			break;
>=20=20
> -		if (ret =3D=3D -EBADMSG)
> +		if (ret =3D=3D -EBADMSG && spinand->set_read_retry) {
> +			if (spinand->read_retries && (++retry_mode < spinand->read_retries)) {
> +				ret =3D spinand->set_read_retry(spinand, retry_mode);
> +				if (ret < 0) {
> +					ecc_failed =3D true;
> +					break;

What is this break gonna do? You're not in a loop. I don't think breaks
have any effect on if blocks.

> +				}
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
>  			*max_bitflips =3D max_t(unsigned int, *max_bitflips, ret);
> +		}
>=20=20

Thanks,
Miqu=C3=A8l


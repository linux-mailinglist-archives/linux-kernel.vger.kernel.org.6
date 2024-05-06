Return-Path: <linux-kernel+bounces-169944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9558BCFA6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21961F22A57
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FDC8175E;
	Mon,  6 May 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LbxT8B8U"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E8915A5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004320; cv=none; b=mOaZTmIhu5vmbkQK/FH4tXgTr2hSeEg8yJWJVZ5YarCyd2btCqRARRZiqdMtKXhi1uPpBJCs/2/Brd0m/tgLszB5kF05n1xdA6ZRQOOmU71EGO7OHffT/ekgSPkXuoEeaUiFo1Glk5bcy+GlRTmWIwh7uCHx356tUgCjPRHVmWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004320; c=relaxed/simple;
	bh=BL1JeslB0DJYvxXfedhZTOKHbd0NWpnyK2Oyv4oIb+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lHa7pY/kxDWEoIOG/i2qLkDzQvkZbg7GsMgXqCxlZ2n++sw7GBGs3wtZZ7+Fq1q2g3PEJldBHOssrDu8tAR11bGp/tMDDyqZSahPq1MrW/Q58vPdn+4JZxxXbOAUSaeJFjtYaNPk5cxRUgkYTWVcC63Fqna/zQum7J1K6w8FD9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LbxT8B8U; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4419E1C000A;
	Mon,  6 May 2024 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715004310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jqe5Un0HeW18+qURGomHX4p3gETxbxF+O84t4VWCEXI=;
	b=LbxT8B8UGgimlG77fyOla4trAVaDHKpcAWVJDzLiM5voFwxfV9jLCO4FVI4ICH3DN1LhCc
	j7FbB///Y+11B9mXj8CCgsnvSfWK5pAFTqZ7dQIqoAAc1PGxYDZYx2mQ6YgrBNqQwMKLWe
	mY5OD1MTX7wgxbQGXUwChFZSIlyXYqr2oWeN0WyDm4W/WcVis6okqtXoJozt+WCMeb9ypC
	k14L0S06hZpzoK43SefFwUxdd5IcwAgjY+Cu1nObqAX0CcQXw4WRZ1bYZryh3+0rkYpsTY
	P4NJPvkWsuY+C3MaHNMgWDM1aLtoo/ARvS3RX/1YA/5bHG6pED73mfQpS4SblQ==
Date: Mon, 6 May 2024 16:05:08 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mtd: nand: mxc_nand: support software ECC
Message-ID: <20240506160508.6c60d50f@xps-13>
In-Reply-To: <20240417-mtd-nand-mxc-nand-exec-op-v1-3-d12564fe54e9@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
	<20240417-mtd-nand-mxc-nand-exec-op-v1-3-d12564fe54e9@pengutronix.de>
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

s.hauer@pengutronix.de wrote on Wed, 17 Apr 2024 09:13:30 +0200:

> To support software ECC we still need the driver provided read_oob,
> read_page_raw and write_page_raw ops, so set them unconditionally
> no matter which engine_type we use. The OOB layout on the other hand
> represents the layout the i.MX ECC hardware uses, so set this only
> when NAND_ECC_ENGINE_TYPE_ON_HOST is in use.
>=20
> With these changes the driver can be used with software BCH ECC which
> is useful for NAND chips that require a stronger ECC than the i.MX
> hardware supports.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mtd/nand/raw/mxc_nand.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_n=
and.c
> index fc70c65dea268..f44c130dca18d 100644
> --- a/drivers/mtd/nand/raw/mxc_nand.c
> +++ b/drivers/mtd/nand/raw/mxc_nand.c
> @@ -1394,15 +1394,16 @@ static int mxcnd_attach_chip(struct nand_chip *ch=
ip)
>  	chip->ecc.bytes =3D host->devtype_data->eccbytes;
>  	host->eccsize =3D host->devtype_data->eccsize;
>  	chip->ecc.size =3D 512;
> -	mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
> +
> +	chip->ecc.read_oob =3D mxc_nand_read_oob;
> +	chip->ecc.read_page_raw =3D mxc_nand_read_page_raw;
> +	chip->ecc.write_page_raw =3D mxc_nand_write_page_raw;
> =20
>  	switch (chip->ecc.engine_type) {
>  	case NAND_ECC_ENGINE_TYPE_ON_HOST:
> +		mtd_set_ooblayout(mtd, host->devtype_data->ooblayout);
>  		chip->ecc.read_page =3D mxc_nand_read_page;
> -		chip->ecc.read_page_raw =3D mxc_nand_read_page_raw;
> -		chip->ecc.read_oob =3D mxc_nand_read_oob;
>  		chip->ecc.write_page =3D mxc_nand_write_page_ecc;
> -		chip->ecc.write_page_raw =3D mxc_nand_write_page_raw;
>  		chip->ecc.write_oob =3D mxc_nand_write_oob;
>  		break;

You also need to disable the ECC engine by default (and then you're
free to use the raw page helpers).

I thought patch 4 was needed for this patch to work, do you confirm?
Otherwise with the little change requested I might also merge this one.

Thanks, Miqu=C3=A8l


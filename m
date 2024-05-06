Return-Path: <linux-kernel+bounces-169938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3368BCF9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E945B254E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC2481AD1;
	Mon,  6 May 2024 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hySbyhml"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951EF811E6
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004185; cv=none; b=bYP124azd2H+o049UA2Tp/K33xD9ladHQLrqja6wMZrPDuiKE+uWVeRnFvCtZh8DXi1S7tOmS6lEkvEm2oTEFrzFYZpcrW2/g3ewucpGKNtLcn6QmcHSu5xF5ZSTzgP9eU+cju+L9qgwZpzkeufaeXM+ms8xXkuh0aPEx2mKku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004185; c=relaxed/simple;
	bh=yTGxccudV9Wg1P03fm8HrS/J338PxC/EctnXLaE/gj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grzmHGazphPZp2nQ6hx25vUxoG1yg8gATgeQWIjKMOVS0jbSKqIqcVqLarwnc6952z0pMWtDL9+C9pDwyYoXOUjw4NzZFC31t8tBYvIJWftqUwMOZZOu67JP+8/mYkrCrNCUu1nAeFRgKCHGuXfs6PK6EeL+LVNbJpiZ6HYDcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hySbyhml; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0B66BE0009;
	Mon,  6 May 2024 14:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715004175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFrEFhO9TjFGR+Ywqd04S0jsdBATnoKGEa06T3fRaqA=;
	b=hySbyhml1EE7UT+stCg4Gbc8H/SHXW4yY9NO/FgdqCHsj3MbMkDTaeonzD2SVkNTBzXieV
	4qoFaa3C9sdI69aUuDhAZ/3+Tkyjb0DuK5JhCsejaLQRM0JJHx6ZymwflmsGACbvymhF92
	5npwMf8NKX/T3j2EJbGNfz8mUIaM2DRc6OZtQGtmWckkx4R3zLetjHFDCplTL4/Xl8h8oO
	XG5kUxvtfwsL4C/tEg21VFUetQsPuwG0oOI/2aMsJYhCJM4t4Q6d9Cx2tAiL38rxMjmnvx
	wAVJqn+EhnPJbTccJwuL+Ri/o2vEWNbdvPlHb/Haxiuyhe6NTwkv987/M7+ozQ==
Date: Mon, 6 May 2024 16:02:54 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mtd: nand: mxc_nand: implement exec_op
Message-ID: <20240506160254.19089e94@xps-13>
In-Reply-To: <20240417-mtd-nand-mxc-nand-exec-op-v1-2-d12564fe54e9@pengutronix.de>
References: <20240417-mtd-nand-mxc-nand-exec-op-v1-0-d12564fe54e9@pengutronix.de>
	<20240417-mtd-nand-mxc-nand-exec-op-v1-2-d12564fe54e9@pengutronix.de>
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

s.hauer@pengutronix.de wrote on Wed, 17 Apr 2024 09:13:29 +0200:

> This converts the driver to the more modern exec_op which gets us rid
> of a bunch of legacy code. Tested on i.MX27 and i.MX25.

Thanks a lot for this contribution!

>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

..

>  static int mxc_nand_read_page_raw(struct nand_chip *chip, uint8_t *buf,
>  				  int oob_required, int page)
>  {
> +	struct mtd_info *mtd =3D nand_to_mtd(chip);
>  	struct mxc_nand_host *host =3D nand_get_controller_data(chip);
> -	void *oob_buf;
> +	int ret;
> +
> +	host->devtype_data->enable_hwecc(chip, false);

In general the expected logic would be to keep the ECC engine disabled
and just enable/use it/disable in the page helpers.

> +
> +	ret =3D nand_read_page_op(chip, page, 0, buf, mtd->writesize);
> +	if (ret)
> +		return ret;
> =20
>  	if (oob_required)
> -		oob_buf =3D chip->oob_poi;
> -	else
> -		oob_buf =3D NULL;
> +		copy_spare(mtd, true, chip->oob_poi);
> =20
> -	return host->devtype_data->read_page(chip, buf, oob_buf, 0, page);
> +	return 0;
>  }
> =20

..

>  static int mxcnd_probe(struct platform_device *pdev)
> @@ -1752,13 +1594,6 @@ static int mxcnd_probe(struct platform_device *pde=
v)
> =20
>  	nand_set_controller_data(this, host);
>  	nand_set_flash_node(this, pdev->dev.of_node);
> -	this->legacy.dev_ready =3D mxc_nand_dev_ready;
> -	this->legacy.cmdfunc =3D mxc_nand_command;
> -	this->legacy.read_byte =3D mxc_nand_read_byte;
> -	this->legacy.write_buf =3D mxc_nand_write_buf;
> -	this->legacy.read_buf =3D mxc_nand_read_buf;
> -	this->legacy.set_features =3D mxc_nand_set_features;
> -	this->legacy.get_features =3D mxc_nand_get_features;

Very nice diff overall. I'm fine with the first two patches, do you
mind if I merge 1 and 2 for now? We need to discuss further the subpage
issue.

As mentioned above, I would welcome a patch setting the HW ECC engine to
false by default and only enabling it in the page helpers (when using
the on-host ECC engine of course). This would be a good minor step,
with or without software ECC support.

Thanks,
Miqu=C3=A8l


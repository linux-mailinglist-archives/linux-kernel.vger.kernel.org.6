Return-Path: <linux-kernel+bounces-345611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE1598B80D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954131F23273
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC06319D887;
	Tue,  1 Oct 2024 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BsKBmYJ3"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8919D096
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773981; cv=none; b=F6fQ9Z+Wqw4lH810+staRW2OpHznYXqAxVUEtpL7Rud8ZStnhi1q7BUQj6drc1aOFgmou2tr03kD5csazKmOE1efncoi3fIZquSAnNdE63e1Yhd9QkgUOt3EhdOTQj/aBk7yGA+jKZI5YQsQEs0pQZ9cJhVTSXTSsKfKXr4uzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773981; c=relaxed/simple;
	bh=lh7tuqnpE+5987m2jcyvLL2zRI/d/0fJ/Jge6e+YT6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeomrPQ7C8yNU8ESW1JfOI6f1eS+IGEzjyYr3/izxiKr/BOIKbEINZfmiTGshbyFsYqhMuQlAf6nm+KqY6qTX7JAkUOgiLUPcUkH6+w1hwDsQs2hH7W33hNBdxRWq1CM23VB41orG+qBRatThXjZZIAGfkKOiHRsh1E16jupnko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BsKBmYJ3; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DB4071BF205;
	Tue,  1 Oct 2024 09:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727773975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wn4FBOVtHOoxAtUICQyZujz1f15qkDm2lLUyaK/WqGk=;
	b=BsKBmYJ3IAN4SuRjTFNUfEwnvmTqwxiYMP2mlNx7HNBHVM80w/cCjWCFwRutyQEbvpwaIC
	D2hpIseVuxJsq7UPz6pTbA2aceak78mLDsOK2AucjiVEsWsBvvZKOoZCudf0npf7/btGpY
	ljEu1JyLLJ3mlTLCwSlXNeQSGVhz46RG57uNkROETI1iea7KNbRsdea4Qp+85BT8tHERvG
	0DRkTQhh7B2MG9v3ktXNd5v1zOMvBZ60Q+SyaoP6dSQgiT0DFn0BCcDUZrPOS3hubXQPAc
	JuPxPFkcLdL7zUzE58RUkscI+YF/pvXqNQc8UitQN15hJ83/GqsNRcI8FDEzWQ==
Date: Tue, 1 Oct 2024 11:12:49 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Martin Kurbanov <mmkurbanov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 Michael Walle <michael@walle.cc>, "Mark Brown" <broonie@kernel.org>,
 Chia-Lin Kao <acelan.kao@canonical.com>, "Md Sadre Alam"
 <quic_mdalam@quicinc.com>, Ezra Buehler <ezra.buehler@husqvarnagroup.com>,
 Sridharan S N <quic_sridsn@quicinc.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Alexey Romanov
 <avromanov@salutedevices.com>, <linux-kernel@vger.kernel.org>,
 <linux-mtd@lists.infradead.org>, <kernel@salutedevices.com>
Subject: Re: [PATCH v2 1/5] mtd: spinand: make spinand_{read,write}_page
 global
Message-ID: <20241001111249.43d20f5d@xps-13>
In-Reply-To: <20240827174920.316756-2-mmkurbanov@salutedevices.com>
References: <20240827174920.316756-1-mmkurbanov@salutedevices.com>
	<20240827174920.316756-2-mmkurbanov@salutedevices.com>
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

Hi Martin,

mmkurbanov@salutedevices.com wrote on Tue, 27 Aug 2024 20:48:59 +0300:

> Change these functions from static to global so that to use them later
> in OTP operations. Since reading OTP pages is no different from reading
> pages from the main area.
>=20
> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> ---
>  drivers/mtd/nand/spi/core.c | 24 ++++++++++++++++++++----
>  include/linux/mtd/spinand.h |  6 ++++++
>  2 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index e0b6715e5dfed..807c24b0c7c4f 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -566,8 +566,16 @@ static int spinand_lock_block(struct spinand_device =
*spinand, u8 lock)
>  	return spinand_write_reg_op(spinand, REG_BLOCK_LOCK, lock);
>  }
> =20
> -static int spinand_read_page(struct spinand_device *spinand,
> -			     const struct nand_page_io_req *req)
> +/**
> + * spinand_read_page() - Read the page

				 a page? (same below)

> + * @spinand: the spinand device
> + * @req: the I/O request
> + *
> + * Return: 0 or a positive number of bitflips corrected on success.
> + * A negative error code otherwise.
> + */
> +int spinand_read_page(struct spinand_device *spinand,
> +		      const struct nand_page_io_req *req)
>  {
>  	struct nand_device *nand =3D spinand_to_nand(spinand);
>  	u8 status;
> @@ -597,8 +605,16 @@ static int spinand_read_page(struct spinand_device *=
spinand,
>  	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
>  }
> =20
> -static int spinand_write_page(struct spinand_device *spinand,
> -			      const struct nand_page_io_req *req)
> +/**
> + * spinand_write_page() - Write the page
> + * @spinand: the spinand device
> + * @req: the I/O request
> + *
> + * Return: 0 or a positive number of bitflips corrected on success.
> + * A negative error code otherwise.
> + */
> +int spinand_write_page(struct spinand_device *spinand,
> +		       const struct nand_page_io_req *req)
>  {
>  	struct nand_device *nand =3D spinand_to_nand(spinand);
>  	u8 status;
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 5c19ead604996..555846517faf6 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -519,4 +519,10 @@ int spinand_match_and_init(struct spinand_device *sp=
inand,
>  int spinand_upd_cfg(struct spinand_device *spinand, u8 mask, u8 val);
>  int spinand_select_target(struct spinand_device *spinand, unsigned int t=
arget);
> =20
> +int spinand_read_page(struct spinand_device *spinand,
> +		      const struct nand_page_io_req *req);
> +
> +int spinand_write_page(struct spinand_device *spinand,
> +		       const struct nand_page_io_req *req);
> +
>  #endif /* __LINUX_MTD_SPINAND_H */


Thanks,
Miqu=C3=A8l


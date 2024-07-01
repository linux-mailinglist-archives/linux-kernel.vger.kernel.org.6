Return-Path: <linux-kernel+bounces-235950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E5D91DBA9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959AF1F232A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0742684DE9;
	Mon,  1 Jul 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NTYPMw4Y"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EC4A0F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719826994; cv=none; b=sZoZ8SWcPdEJEuGnmqNwOYvkPI/1ak69yVtFTtxOpsYLIqZUfM/OWhULPdSyei3umHhOmOwJLGAIXPoSu8q/fSaYSnmcIQ7NvuopK9QlJw78atBn5oNUqYpuihV1qXTcz6xKVuAuN2DS2/UWZhsTz23Ge5DBIqKGvb9I80EsHLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719826994; c=relaxed/simple;
	bh=3NzHyVFUjKyygfr/kqv/H3Lr1uZS//QAnnBQ8/1LmGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LFNsrfK0klMxzQf/uaB75+ZXxn5Ajula6jRQaBePknODtgX0qTknAq97GlQmDT2UBZFaS3nVO07k3b4FwfO4MS7NINgDvGya6oQaVgQhCNqs6dGyHTMxgwEkmbagFNpT1ICJM6r4pcDN0DfjFhDvo3LhKS0cDj1XuoZiF4W4yeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NTYPMw4Y; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 843ADE0009;
	Mon,  1 Jul 2024 09:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719826989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ed3IOlft/9T9yxBUdqc3PoZwEw29DrpPjWIbyKJhKD8=;
	b=NTYPMw4YGZc0IJp6iNpS/5KF1KO9IK9sy96WhScM1rCDYnMmahEQpxwgfHxYfO6OF/ncL+
	jSS6nfeZCofeAR9ep6K4fz0YH06ocrzn7VUsZz6G5ZkI5kaRE5VMKiuu2/Qnl4SufMUvEI
	E5wLZUxECNhAPXHE5fb57XpkzlNByJOLxeJfNP2BpKrxGUdfrtAhEvo2tkVYAVqKAoLhG/
	bqAHUk9kfH+8qEfbAMSrmIcAJyJxQRDGrf1B/dhZts1YpXmxtWewLT4h5L0WG/fZuEEyei
	svXQQ4aODcIb6e+DpMVFM/vvdLgPlSgDeScZDjH3y1gAvty9kEPZSMCKZBf2gw==
Date: Mon, 1 Jul 2024 11:43:07 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, richard@nod.at, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, alvinzhou@mxic.com.tw, leoyu@mxic.com.tw,
 Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 1/2] mtd: spinand: Support serial NAND for reading two
 bytes ID
Message-ID: <20240701114307.031005ce@xps-13>
In-Reply-To: <20240628085444.132714-2-linchengming884@gmail.com>
References: <20240628085444.132714-1-linchengming884@gmail.com>
	<20240628085444.132714-2-linchengming884@gmail.com>
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

Hi,

linchengming884@gmail.com wrote on Fri, 28 Jun 2024 16:54:43 +0800:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> Adding the Device ID 2 on Macronix Serial Flash.
>=20
> When the number of flashes increases, we need to utilize
> Device ID 2 to distinguish between different flashes.
>=20
> These flashes have been validated on Xilinx zynq-picozed
> board which included Macronix SPI Host.
>=20
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> ---

...

>  	SPINAND_INFO("MX35UF1GE4AD",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x96, 0x03),
>  		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -289,7 +288,7 @@ static const struct spinand_info macronix_spinand_tab=
le[] =3D {
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
>  				     mx35lf1ge4ab_ecc_get_status)),
>  	SPINAND_INFO("MX35UF1GE4AC",
> -		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92),
> +		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92, 0x01),
>  		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
>  		     NAND_ECCREQ(4, 512),
>  		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> @@ -298,7 +297,6 @@ static const struct spinand_info macronix_spinand_tab=
le[] =3D {
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
>  				     mx35lf1ge4ab_ecc_get_status)),
> -

This is style, and if you care should be in another patch.

>  	SPINAND_INFO("MX31LF2GE4BC",
>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x2e),
>  		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> @@ -309,7 +307,7 @@ static const struct spinand_info macronix_spinand_tab=
le[] =3D {
>  		     SPINAND_HAS_QE_BIT,
>  		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout,
>  				     mx35lf1ge4ab_ecc_get_status)),
> -	SPINAND_INFO("MX3UF2GE4BC",
> +	SPINAND_INFO("MX31UF2GE4BC",

This is a fix that should have the right tags (stable/fixes) and be in
another patch.

Also, maybe you want this patch content to be backported. If it's the
case, please add the necessary tags here as well.

>  		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xae),
>  		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
>  		     NAND_ECCREQ(8, 512),


Thanks,
Miqu=C3=A8l


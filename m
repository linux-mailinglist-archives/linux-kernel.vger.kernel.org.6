Return-Path: <linux-kernel+bounces-309101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D514F966634
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9088828380C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE041B81AC;
	Fri, 30 Aug 2024 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o2/ewgxa"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BB21A4ABC
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033320; cv=none; b=CwHB3rW1kYcaZPEYSB2LF0yJv8DfJQ4Xdpnztf7r2ADKu9DrxdNAjBpUmUnI2nED1dA60PVmodO17Eg3ETUIp+oyi4B9psS/OfmogmpLg0fn0HK5q7n5laVP6F2g1m3KHotooVyqbsKcpjUrL8LtbwxQp6Si+ST/jhw1P6TlIdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033320; c=relaxed/simple;
	bh=Oz4Mi6s2huvm71eOQhFUGm+Oh/pIrJe+Nn4yE2qOzIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jfHyJjZpNA8E/90z4r/25MER+kaGoFIcxaKhbVTLrleEbx+J+ZBI3l0EKVn9nKYaxaFjcsArjfYb/i0jm3r84mX6E26fnYgaSvF0orVI891MP/sE1mkOECqP9I5WazBu6r+pDy5QdZC6kp1Mvk4vsUmfe5QU74051dhy7bKOTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o2/ewgxa; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6EA3624000A;
	Fri, 30 Aug 2024 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725033310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TPA0rJ9OftpqjiI74jGLgXM3A95TCoAE5VsWnJzOCkA=;
	b=o2/ewgxaOezmTe7rnQANMV9VMz3u5epFA4/CpAiEictfcr2WPNl7+aUMpQbwN3cM6Aa4Lp
	fmB60ppV1ULOhACsLfrFWyS6mAdy8V1y+h2IVgu3jmWa2oZaFdFMeyXYfc7xfHOMjVBzo1
	xSeBPXw0iQUzUoJFAt5akxvkcdx3NOFdL2wKTXxqwpZIht2Os9okjf1CmulU+Vdi8zHUBE
	oOCJPp7xcddD5FkuuamGZmHDDF0RKblAOSgKGKNsZTLWQVKKI0SnbcJUXvyD7X+bdXidSw
	hZscBixg0+2d3ZQt3AbutTHZIkhLMPXaVzizcv4QcNidS7319XLxpis7NcIhLQ==
Date: Fri, 30 Aug 2024 17:55:04 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH v5 1/2] mtd: spinand: Add support for setting plane
 select bits
Message-ID: <20240830175504.746fb2ec@xps-13>
In-Reply-To: <20240830100310.1553675-2-linchengming884@gmail.com>
References: <20240830100310.1553675-1-linchengming884@gmail.com>
	<20240830100310.1553675-2-linchengming884@gmail.com>
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

Hi ChengMing,

linchengming884@gmail.com wrote on Fri, 30 Aug 2024 18:03:09 +0800:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> Add two flags for inserting the Plane Select bit into the column
> address during the write_to_cache and the read_from_cache operation.
>=20
> Add the SPINAND_HAS_PP_PLANE_SELECT_BIT flag for serial NAND flash

This flag has been renamed :)

> that require inserting the Plane Select bit into the column address
> during the write_to_cache operation.
>=20
> Add the SPINAND_HAS_READ_PLANE_SELECT_BIT flag for serial NAND flash
> that require inserting the Plane Select bit into the column address
> during the read_from_cache operation.
>=20
> Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
> ---
>  drivers/mtd/nand/spi/core.c | 6 ++++++
>  include/linux/mtd/spinand.h | 2 ++
>  2 files changed, 8 insertions(+)
>=20
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index e0b6715e5dfe..e7b592cdbb4c 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -386,6 +386,9 @@ static int spinand_read_from_cache_op(struct spinand_=
device *spinand,
>  	else
>  		rdesc =3D spinand->dirmaps[req->pos.plane].rdesc_ecc;
> =20
> +	if (spinand->flags & SPINAND_HAS_READ_PLANE_SELECT_BIT)
> +		column |=3D req->pos.plane << fls(nanddev_page_size(nand));

Isn't there any better way to know what the bit position is?

Thanks,
Miqu=C3=A8l


Return-Path: <linux-kernel+bounces-346597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7234F98C685
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3291283627
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101001CDFD9;
	Tue,  1 Oct 2024 20:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pJvNdWxl"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6ED1CBE98;
	Tue,  1 Oct 2024 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813439; cv=none; b=CSt28DFlI5gV0QdSHOP9Llcaoj6ragrMflfrPHz41ng8Vt1VMCqqF2DkaDaER3D0veE80oXXQHpykfzeY/+jKEamJ3kTM/t6DgJAzUO2hQTje8o1XqRPKLQ7FdH9X3czqlZ8RGvI3N3lsftvdFYW8yHYzd7EOsHSIJlpKXUNGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813439; c=relaxed/simple;
	bh=+f3L/ZvGox5IMgxhIOOFSRnBC9DEF6HvTk3GIKF9PFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqTKHXOZHq1hY1Q4MtXpnXqH4tIWFLpaVHlHaZYT9OQQzd32OlFiZeYhV6hvyJPLeJl0W3T2QJ55nZDnk0gO3DoWwqefb5iCT+VcPeRo5z17dv1b4yGuNLOBSM7jRTwhTPH0JZMGuNwV1t8qw+MMios/J1jI4iWJ0+134qeQnzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pJvNdWxl; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2BF6FFF802;
	Tue,  1 Oct 2024 20:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727813435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wciwjokDugAnsWeKdaqfhfP5WiHTbppV884jMM94Ra0=;
	b=pJvNdWxl4CIRZtaAqKyVjFpDtqhO7S5V282fRVAkWEPq1EjGEGWrkg5tqpQUN9ZjwKj/wZ
	5y10EzL2mBeKRmqBEfg62vQNJiV41laisO4NRr3oWSxg1li6qu1qqxG2FRTWCAMuYiTUs3
	Ul+aPkNA3E37TElAmTBPeGJvGtrlyjmHctkJe4ITohWh6QA8T6TIbRsY8WvXy7Yp2nDlWB
	JLgrJIX/fTmTcMG06pRjluk3udr1Q+nsk8VfBfnWbtlnlPDmhPK77h9Dyc+MHa1XunTbbp
	Sd/ZokFCPRudEV+ykPvritiOrRfJszeBjWxScYBT5E1vn07sVMUGgb3+arfz5w==
Date: Tue, 1 Oct 2024 22:10:32 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mtd: davinci: add support for on-die
 ECC engine type
Message-ID: <20241001221032.525be1e4@xps-13>
In-Reply-To: <20241001-ondie-v1-2-a3daae15c89d@gmail.com>
References: <20241001-ondie-v1-0-a3daae15c89d@gmail.com>
	<20241001-ondie-v1-2-a3daae15c89d@gmail.com>
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

Hi Marcus,

marcus.folkesson@gmail.com wrote on Tue, 01 Oct 2024 12:42:27 +0200:

> Some chips, e.g. Micron MT29F1G08ABBFAH4, has a mandatory on-die ECC.
> Add "on-die" as ECC engine type in order to be compatible with those.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  Documentation/devicetree/bindings/mtd/davinci-nand.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/davinci-nand.txt b/Doc=
umentation/devicetree/bindings/mtd/davinci-nand.txt
> index eb8e2ff4dbd2901b3c396f2e66c1f590a32dcf67..9afda5cd956494c6b3171bdba=
ecaeb289acd64ea 100644
> --- a/Documentation/devicetree/bindings/mtd/davinci-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
> @@ -44,6 +44,7 @@ Recommended properties :
>  				- "none"
>  				- "soft"
>  				- "hw"
> +				- "on-die"

This file is very legacy and this addition would be totally unneeded if
that file had been converted to yaml earlier. Just referencing
nand-controller.yaml will authorize nand-ecc-mode =3D "on-die" (while
still marking it legacy). Would you mind converting this file please?

Thanks,
Miqu=C3=A8l


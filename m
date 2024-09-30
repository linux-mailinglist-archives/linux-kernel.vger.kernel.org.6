Return-Path: <linux-kernel+bounces-343665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76241989DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66E01C21F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BBB187FE0;
	Mon, 30 Sep 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aryuuA52"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD37184539;
	Mon, 30 Sep 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687966; cv=none; b=fEYTWDKSltuAc1JDTDyzm5g9khG4kTuAnPMgU9PQHnhA5PJhagNbDmyCm1ZZZQq6znGa6Q2+eI8KMl14FXqrnA35BcpC54QcFgT1kOn1oAYX/7uiy3NvMb7rgIMbrAj3QWdw482Qd6+gB20PEdSpGaD5OPCmLE7Oz1dKlXtZ9wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687966; c=relaxed/simple;
	bh=lmWcA3krObUEcSgVI8XOtUqUtyX3hirROSDHuk05VoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mU0FpkIHRbcWvDnBmxvFJJ+2QHwAOd4+Y3l/bHspLkj+TU9ZH8DrgnFW2+txsQB/ZUSB+ivBIc1bftM2+Y4wBsUmJoA2c2ZDpW6wAYAB1ifzLoiA7IwrgeXc1OXWNOTdUfbNqfSDFIuUVKCcyoANBsyIKefke/oNkKtcT7oMbZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aryuuA52; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5E4A62000F;
	Mon, 30 Sep 2024 09:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727687957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08CqMCR40QeByk4ty6nskGAarldWWiP1HXvLuo/jmq8=;
	b=aryuuA522t22D8cTiaR7wOrrrGfDITc/83JLG7Jb/SzmS/GFsmyD7kPvEqzaqvtRZ8JhTh
	DqvJ9QEo9K3e69VI9MQzf5f7FArwYHbcNVyeVG+DR6qkPaV9N6OytyFv6MUqJu1Rk6a41Q
	pjJMF0s8zolKg0F6Nkfaudp+au93S7qmnwUEtp/yLsAXPUN1FE1V76z7Eqn8sqxJgeUc0r
	Uk8TAT0Y0oeEplXvLsoUieX6TaC95JvVNjj3QP/S9jE4akg/aMvrGhoIrhND4RdKknlP1s
	ImKyhYXYuGirdnUn6QiePxg5j62zCSjKN5QPRf117LZiWPzRkWg9Dzi5pGtqtA==
Date: Mon, 30 Sep 2024 11:19:14 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: support vcc-supply regulator
Message-ID: <20240930111914.4b412581@xps-13>
In-Reply-To: <20240930-spi-v2-2-ed7f6bcbe0df@nxp.com>
References: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
	<20240930-spi-v2-2-ed7f6bcbe0df@nxp.com>
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

Hi,

peng.fan@oss.nxp.com wrote on Mon, 30 Sep 2024 17:22:25 +0800:

> From: Peng Fan <peng.fan@nxp.com>
>=20
> SPI NOR flashes needs power supply to work properly. The power supply
> maybe software controllable per board design. So add the support
> for an vcc-supply regulator.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mtd/spi-nor/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 9d6e85bf227b..5249c8b13916 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -17,6 +17,7 @@
>  #include <linux/mtd/spi-nor.h>
>  #include <linux/mutex.h>
>  #include <linux/of_platform.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
> @@ -3462,6 +3463,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *=
name,
>  	if (!nor->bouncebuf)
>  		return -ENOMEM;
> =20
> +	ret =3D devm_regulator_get_enable(dev, "vcc");

					_optional ?

> +	if (ret)
> +		return ret;
> +
>  	ret =3D spi_nor_hw_reset(nor);
>  	if (ret)
>  		return ret;
>=20


Thanks,
Miqu=C3=A8l


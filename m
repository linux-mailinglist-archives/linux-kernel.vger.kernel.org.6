Return-Path: <linux-kernel+bounces-343664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FAB989DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A7742855E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D496718787B;
	Mon, 30 Sep 2024 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L5DQpkwJ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44913C9C4;
	Mon, 30 Sep 2024 09:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687944; cv=none; b=WeT6Y9UZKB3MDUiB6eUcXk5QX+BHkN76d73No9+WENHK0FQKpuW/kiSRDM7UcLZOsLkxsEuJ7gC1JI+4eJPAJGISxa5mAlmLWE168muVeaBApaCYkQT3staL1YsjRrxY6ZhqM4ge07lXpvqIlcOeTDncVM1xjA4EdCuNLkaOJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687944; c=relaxed/simple;
	bh=0tSHqkl+1GZcnS3RX2Berjr3BQ7ubsAP4voWFwADecw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4IKqbdFyO5dscgDhdCAZ+jzoHF7tjvR1A3aPj++Iepos6XYrFeblQRson4DMxu1ePOedvtWdzawWFc2VBNaqgjiYRHBM0ZWPqXFanQxmcjWVadCbgvAni8rPqF8tHxc/yd/QdpXD9/VE6ZABx1vYxaM7WQUPUffqV+5qpw8g4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L5DQpkwJ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 726A61C000B;
	Mon, 30 Sep 2024 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727687934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Blr8AqUM4hiswzZDj70roij+wAFRJvWfvmDyw7kgtr0=;
	b=L5DQpkwJjCF78igqUBzUHVZdrLloqSyCkM/5K2N7f7UmFEAGASXdUvyXxkeEhm8MoxNIC+
	q58SbZao1+8YxcL+ti1kEUZxutI5wwlAmOC/Q1/T8Uufk0Q9Xtl8xacT5MAmyLRh+iC+A9
	WW/FM/73en0OkXbZlIcSJQW+VrjudEk4x7Y78FvdL/E7UMKuGsOw+u7fU3Ygw0nyGEaj5e
	+RZGw93ENDsB/DoXvX64VS5IyEjEhq7RNGbHieXff5BA+c9mX/OT7qnsyFT9T1+BduJogq
	jF4zY5mkQX8s6K8Bwxm/90F9MvEVwDBL9l2LJYMvk2xC7H42I1YwVE0cJWLUig==
Date: Mon, 30 Sep 2024 11:18:52 +0200
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
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: jedec,spi-nor: add optional
 vcc-supply
Message-ID: <20240930111852.0fcb731f@xps-13>
In-Reply-To: <20240930-spi-v2-1-ed7f6bcbe0df@nxp.com>
References: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
	<20240930-spi-v2-1-ed7f6bcbe0df@nxp.com>
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

peng.fan@oss.nxp.com wrote on Mon, 30 Sep 2024 17:22:24 +0800:

> From: Peng Fan <peng.fan@nxp.com>
>=20
> Introduce optional vcc-supply property, SPI NOR flashes needs power supply
> to work properly. The power supply maybe software controlable per board
> design.
>=20
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/D=
ocumentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 6e3afb42926e..bab0617a51d5 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -96,6 +96,10 @@ properties:
>        If "broken-flash-reset" is present then having this property does =
not
>        make any difference.
> =20
> +  vcc-supply:
> +    description:
> +      Supply for the spi nor power.

			SPI NOR?

Thanks,
Miqu=C3=A8l


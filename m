Return-Path: <linux-kernel+bounces-200219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 501668FAD20
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADA4283E39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296541422A7;
	Tue,  4 Jun 2024 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XK+QEUpC"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2971420B0;
	Tue,  4 Jun 2024 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488593; cv=none; b=SEZOzk5KIyDOc5Jn0svpPOqaN1YqNJHQmPtuF/pm9Cf4LMD/EOEWeNpjlyajsOUc84lIUeRHShlo06QAMNnAojQkjD5m6kX0H2uf/Q+5Gl2ig2Te61YHhgDoO44BJU/mf/uFHeVscnVEVr/GAWBhWu6PMFdFH/H9waidx4kz4Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488593; c=relaxed/simple;
	bh=8tM5Zb6kQUVVQg/vsAjv/R/zJWorjd3aEehGuNdx6l4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqZt65OK/BMfz8ZTBkT8m5Hs3ymAiadGqQy+PHxuwB4U1YTDyvnW2yB8bn7pMPpfse5r0ZDyS7+B6mTX67VofcvOAJpMAvUfqS66Sv8yA68PZsxOGfHC1mfLa9DlsTyCLAFtk09Zhb82riQVO2M8S094P9uiI7NxPT2alv17xTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XK+QEUpC; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC7FA20008;
	Tue,  4 Jun 2024 08:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717488588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vmUIZ3RHApQ8liyK5HZsUjHttqDUp4gSBPYlUPRHpE=;
	b=XK+QEUpCNM4bUkE+3p8pLAotZEBwCZxnpuPMbgICJo7MVH6kkbG9TEk89TIn75OWFZhczz
	ppxSR5/WDhJ21ab1qyrUg7vGKMKtw7n2CzrCWsessyX7scaR2vaSptcgwYb6ncbljM2ack
	E6GZnsbHCKJbeo4zlWPsSWFcaGsBs34VMQr1w4t6teyB+kIthDibNGWB2SraHYNhyUcKRM
	r+WkjJuw0XCt8L2CykWUNg9gaz7SE73g1etahqOnXRvf3tm4qTPlejjWf/QQWVC3b49Ury
	mSrIofKPQa0/yno1IL1Mm4uM2i15Pwy+sohj/e3i+o8k2M49zpUk5MLxck0rxw==
Date: Tue, 4 Jun 2024 10:09:42 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, Thorsten Scherer
 <t.scherer@eckelmann.de>, Marek Vasut <marex@denx.de>, Imre Kaloz
 <kaloz@openwrt.org>, Andrew Lunn <andrew@lunn.ch>, Flavio Suligoi
 <f.suligoi@asem.it>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM
 devices
Message-ID: <20240604100942.3e663d60@xps-13>
In-Reply-To: <20240604074231.1874972-1-mwalle@kernel.org>
References: <20240604074231.1874972-1-mwalle@kernel.org>
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

Hi Michael,

mwalle@kernel.org wrote on Tue,  4 Jun 2024 09:42:31 +0200:

> These devices are more like an AT25 compatible EEPROM instead of
> flashes. Like an EEPROM the user doesn't need to explicitly erase the
> memory, nor are there sectors or pages. Thus, instead of the SPI-NOR
> (flash) driver, one should instead use the at25 EEPROM driver.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: Thorsten Scherer <t.scherer@eckelmann.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Flavio Suligoi <f.suligoi@asem.it>
> ---
> The referenced binding only supports the true AT25 compatible EEPROMs
> where you have to specify additional properties like size and page size
> or cypress FRAM devices where all the properties are discovered by the
> driver. I don't have the actual hardware, therefore I can't work on a
> proper driver and binding. But I really want to deprecate the use of
> these EEPROM like devices in SPI-NOR. So as a first step, mark the
> devices in the DT bindings as deprecated.
>=20
> There are three in-tree users of this. I hope I've CCed all the relevant
> people. With the switch to the at25 driver also comes a user-space
> facing change: there is no more MTD device. Instead there is an "eeprom"
> file in /sys now, just like for every other EEPROM.
>=20
> Marek already expressed, that the sps1 dts can likely be removed
> altogether. I'd like to hear from the other board DTS maintainers if
> they seem some problems moving to the EEPROM interface - or maybe that
> device isn't used at all anyway. So in the end, we can hopefully move
> all the users over to the at25 driver.
> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/D=
ocumentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 6e3afb42926e..2dccb6b049ea 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -21,7 +21,6 @@ properties:
>                (m25p(40|80|16|32|64|128)|\
>                n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
>                atmel,at25df(321a|641|081a)|\
> -              everspin,mr25h(10|40|128|256)|\
>                (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635=
e)|\
>                (mxicy|macronix),mx25u(4033|4035)|\
>                (spansion,)?s25fl(128s|256s1|512s|008k|064k|164k)|\
> @@ -42,6 +41,14 @@ properties:
>                - spansion,s25fs512s
>            - const: jedec,spi-nor
>        - const: jedec,spi-nor
> +
> +      # Deprecated bindings
> +      - items:
> +          - pattern: "^everspin,mr25h(10|40|128|256)$"
> +          - const: jedec,spi-nor
> +        description:
> +          Deprecated binding, use Documentation/devicetree/bindings/eepr=
om/at25.yaml.
> +        deprecated: true
>      description:
>        SPI NOR flashes compatible with the JEDEC SFDP standard or which m=
ay be
>        identified with the READ ID opcode (0x9F) do not deserve a specific

Makes sense.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l


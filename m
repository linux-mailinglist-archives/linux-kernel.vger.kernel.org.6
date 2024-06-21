Return-Path: <linux-kernel+bounces-224026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE269911C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53D9282526
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F61167D83;
	Fri, 21 Jun 2024 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="I5UNZqRJ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DS7PaVGf"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A91A364AB;
	Fri, 21 Jun 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952566; cv=none; b=K/xDUIqwdz046rG6kQP4Nc2SJg/echJMCQEUjI6nVVDLkMjPVPNVj3vUr29zFfRgRRhMGCrQr4ah+KQN9EoQec8awxh7Omzw43QdNq/rKRtXs/77cgAf4qcFNqZ3Qqyy3dLEbEO5VFIjCvzLuAVXjm+yu/oL42evlbT90vsMBAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952566; c=relaxed/simple;
	bh=26L2gQCJSuE67pfhGd6N9epBRIH0c7Y+Js7xEBNhk1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1FwxoEIIHI2Xzgz/1GT3Sd2fTbOpKoeFhu+S4Q9oputZJOyVIZ0WRhbLOOZbAR3DIrvjSn6B4TaSq9q1yAfKp6/tJYWZ2uPO+5WkkaK+Q2uDgqYsNke7dZ2w4tyJEvnKPlGgb8MpqYIJHo1rmv7nT7KpqfNngm+VOsWvzoVRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=I5UNZqRJ; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=DS7PaVGf reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718952563; x=1750488563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ofIaO25cvMoHiEwlbr15WgWS4pevjTp+4wBTNnE0AQ4=;
  b=I5UNZqRJJ2PM+4/ryvqS8tib9icCB7p9/iedgkL3p0FeD0K+mWNNIzRv
   gx+Dk3XMqVSVX1Xr+awntFENdL+Ys0q3EfTlKKLdKpC75jO0Wvg2Or8Oe
   xf2Os4Djc/PvBzdBRCgMnzuvJJQ4eDoWpE7zmTWb+1lS0zFrOKKhPQWz4
   Z/p7l6HVkDMVZMVPyp+DheoIL6hwJbGaJ26vRcmjlE8Re+JpF9wJik/nK
   e2eGa6GJebzrtTcc9IrSpTiR/5fDAGJ18GgKEk2xAiz+hERXCSiDHYHFZ
   MBDLScjop399onmKQAHrt8G9NiPQRghUGUDF4mNLdYbe6cyEIiKl9SoD1
   w==;
X-CSE-ConnectionGUID: QuE0I6vzSzGK02TNZixP0A==
X-CSE-MsgGUID: KW30Qy6mQ7qWIxEmSjiHsg==
X-IronPort-AV: E=Sophos;i="6.08,253,1712613600"; 
   d="scan'208";a="37513105"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Jun 2024 08:49:14 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17D46167716;
	Fri, 21 Jun 2024 08:49:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718952550;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ofIaO25cvMoHiEwlbr15WgWS4pevjTp+4wBTNnE0AQ4=;
	b=DS7PaVGfnx1mrywqJiDc+ZfAVB+TnBsIILY4g7ygauuN/DJ6jKjuAESovdhwVjM6FSDWVM
	SkkP6tb9yLnQgIONZmWIGQ2HS7OmbyaXrSVsOsaQqQ71DIyOMZD3zjBx4V/iTvB74ETgbV
	yu4e/xmWDk7Em2uwEleeFCIS1KCgrzTvqUZahOGOI6UrFCCmI9XSZEBt0strVnOP6N6CmV
	aYns+24tq5Z7OgEEGT0wztkZCIlBk2hnMXqF9QPJj+7r8LXBXPqwhbCFNAQnxItE33zmqk
	zl7sM6N+L0URTBmDAEEPT59oW2v4SxvZ3E8dt0KWNWnp0DTyIRRY+BDA2NZegg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Thorsten Scherer <t.scherer@eckelmann.de>, Marek Vasut <marex@denx.de>, Imre Kaloz <kaloz@openwrt.org>, Andrew Lunn <andrew@lunn.ch>, Flavio Suligoi <f.suligoi@asem.it>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM devices
Date: Fri, 21 Jun 2024 08:49:09 +0200
Message-ID: <23574950.6Emhk5qWAg@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240604074231.1874972-1-mwalle@kernel.org>
References: <20240604074231.1874972-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

sorry for being late to the party. I just noticed this discussion while
reading [1].

Am Dienstag, 4. Juni 2024, 09:42:31 CEST schrieb Michael Walle:
> These devices are more like an AT25 compatible EEPROM instead of
> flashes. Like an EEPROM the user doesn't need to explicitly erase the
> memory, nor are there sectors or pages. Thus, instead of the SPI-NOR
> (flash) driver, one should instead use the at25 EEPROM driver.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
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

So instead of spi-nor you want to use at25 for this MRAM devices?
AFAICS at25 is a spi only driver, but spi-nor is a spi-mem driver. So I am
wondering if at25 driver is capable of using QSPI hosts.
Everspin EMxxLXB devices are capable of running in xSPI modes.
Regarding QSPI (DSPI/OSPI as well) I assumed spi-nor is a given, but maybe
I am completely wrong here. Maybe someone could clarify this.

Best regards,
Alexander

[1] https://lore.kernel.org/linux-kernel/20240405100104.480779-1-f.suligoi@=
asem.it/

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
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/




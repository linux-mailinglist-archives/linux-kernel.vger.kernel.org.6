Return-Path: <linux-kernel+bounces-224104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9044A911D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5DE1C21057
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEF816C86D;
	Fri, 21 Jun 2024 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="DBlbpCdB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mgMFAjs5"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A8168C3A;
	Fri, 21 Jun 2024 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956147; cv=none; b=flDdB5tnbRIgY4GkhX9J8QMtVKQ9Bl90xw43IVKtjr2pI7wHPh00JWOiBjLYMWq6iRVwsEZVpAVRmfdx0SoNUeyGUOH/2OISZOTUJ1LWB+DWTzOkrTGZYDm79KW1qBMJ17ADe7DkbSgtMWBzBCCtsUxQWa/sit7U+RhVIKUWs3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956147; c=relaxed/simple;
	bh=wIlmEkajVgionahbTspK538zjM57VKi+YSPROMBtrCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5AwTCeo8jcKRq++lXckAeNBb0R3ollWizFBpWCNxhafWw4aFFpdHANTH/7S5Um+e+Rm1uvJurQSTQmM3San68dLmgDs8Fvopfj30nvb0UM7zfRf1U2uagBYP4Wm2+II4SpswsV1DiAiVikkiJp8uvhb69WZQCGZH6kkteEuk3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=DBlbpCdB; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=mgMFAjs5 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718956143; x=1750492143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wIlmEkajVgionahbTspK538zjM57VKi+YSPROMBtrCM=;
  b=DBlbpCdBlgvg89nMtcbkjg2pf3QGeUKROKke80Dv0mLdVSedaFVhuxUl
   Xqkp10yan6dKajxkbGlhm9/rupsF7Y4vt3m8F2/rwxkydR0ryIt9NAr+z
   WaRfCGgvFKw+jeWbGwC/oqd5lGO3zlTaEB4xa/ZIIB+QfYEszmaotfyM6
   rPAv72Aygro5Io7zJ4gsbrAQUvdc5EGvnT0Pj49R7Ecaq/lW45xVuGZEJ
   vFg2CErI4QLuXOB/JsJDDcP5+lyUK0OOTxEVQeBQhu0RO0fL5H3tlqKUg
   1qjHSm7zmAC4iP4rv0P404O33LJm4lr79tt2ygbA0EsBcGvP1uEZ+ZCEx
   A==;
X-CSE-ConnectionGUID: s8GHXRv/SRCOEcMmDwWgyg==
X-CSE-MsgGUID: SQUcTY4bRNqbIS5VTrS2oA==
X-IronPort-AV: E=Sophos;i="6.08,254,1712613600"; 
   d="scan'208";a="37515205"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Jun 2024 09:48:59 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9407160A30;
	Fri, 21 Jun 2024 09:48:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718956135;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wIlmEkajVgionahbTspK538zjM57VKi+YSPROMBtrCM=;
	b=mgMFAjs5PkqL7DA5WhALlYJLzMWua/S6uYkLRX1dtyDPUUkdkChkAN/ZLy6tAht+56Giwf
	IGikV/5Kopjj4czSVeOmOznPBmfGgwxS4nYkeHknIukwuWOedcpGgY9KQEa1ZbWFwWhTC5
	gFn+wfN5MCD6bSU5fKCYXGlXJ3dvQKPN9SubqLy/1xGp0nbxL6p/5KJAP+jzhzdoeWToks
	19nxDRcY/soKwOhotRxhwLVtNwKA25I0wEVoPTKsSH7tlezsVdYjidK76xZjl3wr6WHq79
	LrteIRg4wvOAyXyFaI9PJ9PWASzeGFVBHormvE2TWHDozerE1Ep5AWGNOdONKg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>, Thorsten Scherer <t.scherer@eckelmann.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>, Imre Kaloz <kaloz@openwrt.org>, Andrew Lunn <andrew@lunn.ch>, Flavio Suligoi <f.suligoi@asem.it>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM devices
Date: Fri, 21 Jun 2024 09:48:56 +0200
Message-ID: <114624730.nniJfEyVGO@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <D25I9KDHREE9.29RPCOHXUA70A@kernel.org>
References: <20240604074231.1874972-1-mwalle@kernel.org> <23574950.6Emhk5qWAg@steina-w> <D25I9KDHREE9.29RPCOHXUA70A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

removing Uwe from CC as this address bounces.

Am Freitag, 21. Juni 2024, 09:09:56 CEST schrieb Michael Walle:
> On Fri Jun 21, 2024 at 8:49 AM CEST, Alexander Stein wrote:
> > Hi everyone,
> >
> > sorry for being late to the party. I just noticed this discussion while
> > reading [1].
> >
> > Am Dienstag, 4. Juni 2024, 09:42:31 CEST schrieb Michael Walle:
> > > These devices are more like an AT25 compatible EEPROM instead of
> > > flashes. Like an EEPROM the user doesn't need to explicitly erase the
> > > memory, nor are there sectors or pages. Thus, instead of the SPI-NOR
> > > (flash) driver, one should instead use the at25 EEPROM driver.
> > >=20
> > > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > Cc: Thorsten Scherer <t.scherer@eckelmann.de>
> > > Cc: Marek Vasut <marex@denx.de>
> > > Cc: Imre Kaloz <kaloz@openwrt.org>
> > > Cc: Andrew Lunn <andrew@lunn.ch>
> > > Cc: Flavio Suligoi <f.suligoi@asem.it>
> > > ---
> > > The referenced binding only supports the true AT25 compatible EEPROMs
> > > where you have to specify additional properties like size and page si=
ze
> > > or cypress FRAM devices where all the properties are discovered by the
> > > driver. I don't have the actual hardware, therefore I can't work on a
> > > proper driver and binding. But I really want to deprecate the use of
> > > these EEPROM like devices in SPI-NOR. So as a first step, mark the
> > > devices in the DT bindings as deprecated.
> > >=20
> > > There are three in-tree users of this. I hope I've CCed all the relev=
ant
> > > people. With the switch to the at25 driver also comes a user-space
> > > facing change: there is no more MTD device. Instead there is an "eepr=
om"
> > > file in /sys now, just like for every other EEPROM.
> > >=20
> > > Marek already expressed, that the sps1 dts can likely be removed
> > > altogether. I'd like to hear from the other board DTS maintainers if
> > > they seem some problems moving to the EEPROM interface - or maybe that
> > > device isn't used at all anyway. So in the end, we can hopefully move
> > > all the users over to the at25 driver.
> >
> > So instead of spi-nor you want to use at25 for this MRAM devices?
>=20
> Yes.
>=20
> > AFAICS at25 is a spi only driver, but spi-nor is a spi-mem driver. So I=
 am
> > wondering if at25 driver is capable of using QSPI hosts.
>=20
> spi-mem support could be added to the at25 driver. But probably
> mainly because there are SPI controllers out there which only have
> an interface to attach memory (like the FlexSPI from NXP).

Yes, FlexSPI is my current area of interest.

> > Everspin EMxxLXB devices are capable of running in xSPI modes.
> > Regarding QSPI (DSPI/OSPI as well) I assumed spi-nor is a given, but ma=
ybe
> > I am completely wrong here. Maybe someone could clarify this.
>=20
> These newer devices should also support the erase command, right? So
> they can be a "real" flash. If they support SFDP, the would even be
> supported out of the box. The mentioned everspin devices are much
> older and behaves more like an EEPROM instead of a flash.

I see this is about older devices, I got misled by the subject.
The new devices EMxxLX devices do not support SFDP. There are erase command=
s,
but unless you want to set sectors/whole chip to a defined state, this seems
unneeded, so SPI_NOR_NO_ERASE would be sensible.
I'm wondering if the comment in [1] is still applicable unconditionally, as
there still is a use-case for spi-nor on flexspi.

Best regards,
Alexander

[1] https://lore.kernel.org/linux-kernel/D0C9NCOMI27O.2VW2U3FNFTSPK@kernel.=
org/
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/




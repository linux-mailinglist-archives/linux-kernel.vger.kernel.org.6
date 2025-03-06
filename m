Return-Path: <linux-kernel+bounces-548356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DADA543D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45228169BEF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154A1A2C3A;
	Thu,  6 Mar 2025 07:41:23 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A21C84A5;
	Thu,  6 Mar 2025 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741246883; cv=none; b=eXW0/FqzT3oSFuzjkwWYB9bZ/8ZYQW/tNqtO9xssFiBFMHc3j5HTqz5kpmim9BI6/ObZBg4+H6HiFleyTwXteKg/r1ApxVHLg6rQmIyY8al7yUY/Ra5Wp7bL41uFl+4GUgKAPeFmyoI5v321yh/NkBxiD1VqPfu8CJ27Q6NLSjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741246883; c=relaxed/simple;
	bh=tynbRCJNvJhi67ydy0W9gjWps9spqKy6/S2sdJUz3bA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=vB2Q4ibrCTlL+9vwjsYcyaILN4yPanGJai81zuGjKtQxRT2LOb5RkD8swOasD/Yjk9ysHjApdj2UvlZK+2E7I8FLmPjiD8HvXTl78539aYlDyRbFdEA+Co3ks8FRxs+EDXYYFnlijpDSxIH5M06xFqwwgkUBkYR+1R8Y5XbFKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id A0115287;
	Thu,  6 Mar 2025 08:41:17 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Mar 2025 08:41:17 +0100
Message-Id: <D890I4EPARNO.O0VS9VZUL6IR@kernel.org>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
 <pratyush@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <Varshini.Rajendran@microchip.com>
From: "Michael Walle" <mwalle@kernel.org>
To: <Manikandan.M@microchip.com>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address
X-Mailer: aerc 0.16.0
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
 <87ikonydym.fsf@bootlin.com>
 <84b1def7-fba7-4f29-a49b-d117efe26d26@microchip.com>
In-Reply-To: <84b1def7-fba7-4f29-a49b-d117efe26d26@microchip.com>

Hi,

> >> From: Varshini Rajendran <varshini.rajendran@microchip.com>
> >>
> >> EUI identifier and the MAC Address of the Ethernet Interface is stored
> >> after the SFDP table of contents starting at address 0x260 in the
> >> QSPI memory.
> >> Register the entire SFDP region read by the spi-nor (nor->sfdp) into t=
he
> >> NVMEM framework and read the MAC Address when requested using the nvme=
m
> >> properties in the DT by the net drivers.
> >>
> >> In kernel the Ethernet MAC address relied on U-Boot env variables or
> >> generated a random address, which posed challenges for boards without
> >> on-board EEPROMs or with multiple Ethernet ports.
> >> This change ensures consistent and reliable MAC address retrieval from=
 QSPI,
> >> benefiting boards like the sama5d29 curiosity and sam9x75 curiosity.
> >=20
> > Do you mean spi-nor have a programmable area in their SFDP table? Isn't
> > this supposed to be a read-only area written once in factory?
> >=20
> The SST26VF064BEUI serial quad flash memory is programmed at the factory=
=20
> with a globally unique address stored in the SFDP vendor
> parameter table and it is permanently write-protected.

Why didn't you mention that this is a vendor table in the commit
message?

Anyway, please write proper support in the core for parsing vendor
tables and exposing them as a nvmem device if needed (and asked to
do so by the driver of course).

-michael


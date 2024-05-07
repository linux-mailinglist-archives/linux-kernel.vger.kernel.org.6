Return-Path: <linux-kernel+bounces-170816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE77C8BDC65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544921F2240B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F383713BC29;
	Tue,  7 May 2024 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SGwQ/VNu"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7A513B59E;
	Tue,  7 May 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066860; cv=none; b=geKQSy5NE2lPnUQQ6i3jeaY/Rgc7ZEopzfQj9xrKdnYDhfux5Fls01FMnIEal9iZ0xJD25APnxlj9EUQCrX7WjTmA7IV+uEEGC55oeAt3LzsXzR2Qum9VdPWXu32JqxR1/YSI9PXD20LGla5SFSiLrI6EbjCh9PVbd/wWhVRYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066860; c=relaxed/simple;
	bh=24arK84G5OizO0Z/cQi1nW9OSkt8QOzYClHzvIuw32U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAaiLdYa2Oi8SfY0MfT2Vm2r+qtEwnwbVU4+WGwZuyG5zztskCYk8AdIda9HRPOBNAd5dyJVs0fiSXdHhoFuzyYOtoHdy5RRv5pwNYbd8RD3rU9dl4ENoQVHq4RHe6A4LE4xR+ycwpsBSCZrCzt5zxCngYOZiuGSO0xHL/DnihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SGwQ/VNu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A155D24000B;
	Tue,  7 May 2024 07:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715066849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hP/KCyJu/jC8qwnU4+ma1+qdgNY2kC0wtIaU2BlN2Ac=;
	b=SGwQ/VNurTMMep1bl+Igu0U09fhmyUGntaSDl5Xk6HXMXB2WENivRB0MTOb+fQs9KbV0Sj
	wT6SxUawqtYG5Tz4Ps3OZbuUZGUX4dbdyj3Dd2UU6v6mPFp055Qxo2B3inVBzS4yB+pf0l
	o1gqec4A4XshTe20snNzyRZ7e9QR4GVOWKZv4xqfQPyivhcmL4L4Y94QHfXPB6XhQIBAg1
	yGmLd30KzUXGl+Je7dGhhYieOy+A3dZBXVpYQh1ZSpnNHu3zkLFtqI82hqh9Y5KCTLIEjG
	0eVaM7OqT3Pva2HoXqYxnSDhh/CIFwGuPdNrjQIKneVaYFgeUZB7q3gnZcwCOA==
Date: Tue, 7 May 2024 09:27:26 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <oxffffaa@gmail.com>, <kernel@sberdevices.ru>
Subject: Re: [PATCH v5 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Message-ID: <20240507092726.4ab1afdb@xps-13>
In-Reply-To: <d90f9d3d-7823-503f-4cc6-73783a083d0e@salutedevices.com>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
	<20240416085101.740458-2-avkrasnov@salutedevices.com>
	<20240506154858.003bab54@xps-13>
	<d90f9d3d-7823-503f-4cc6-73783a083d0e@salutedevices.com>
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

Hi Arseniy,

avkrasnov@salutedevices.com wrote on Tue, 7 May 2024 09:53:06 +0300:

> On 06.05.2024 16:48, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > avkrasnov@salutedevices.com wrote on Tue, 16 Apr 2024 11:51:00 +0300:
> >  =20
> >> Boot ROM code on Meson requires that some pages on NAND must be written
> >> in special mode: "short" ECC mode where each block is 384 bytes and
> >> scrambling mode is on. =20
> >=20
> > Ok
> >  =20
> >> Such pages located with the specified interval within specified offset=
 =20
> >=20
> > I'm sorry I don't get that sentence. =20
>=20
> Sorry, I mean this (let me draw :) ) :
>=20
> [ page 0 ][ page 1 ][ page 2 ][ page 3 ][ page 4 ][ page 5 ][ page 6 ][ p=
age 7 ][ page 8 ][ page 9 ]
>=20
> For example, we have 10 pages starting from the beginning of the chip - t=
his is "within specified offset",
> e.g. offset is 10. BootROM on axg needs that (for example) every third pa=
ge must be written in "special"
> mode: scrambling is on and ECC is 384 bytes. Such pages are 0, 2, 4, 6, 8=
 E.g. "specified interval" will
> be 3.

Shall be 2, no?

>=20
> So:
>=20
> amlogic,boot-pages: 10
> amlogic,boot-page-step: 3

Ok I get it. Thanks for the explanation. I don't really understand the
logic behind it though. Do you know why the bootROM would access only
one page over 2 or 3? Is there a default value? Is this configurable?

Thanks,
Miqu=C3=A8l


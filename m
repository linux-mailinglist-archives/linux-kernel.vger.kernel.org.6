Return-Path: <linux-kernel+bounces-170850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE8A8BDCE8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C741F24FF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF0113C83E;
	Tue,  7 May 2024 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SpFGaQjH"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88896FE07;
	Tue,  7 May 2024 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069166; cv=none; b=BwHtDgbJEvYwEYmA73BB9rf6CyHG47Zs5EsN2KiFqfLVvFacDmEXqCNeHkfxTDrYtDQ6b5zuLYI05REDiSjXlrG7C7K/iivzvlsMfZaHFf8a2t5oiUcP+64uxCF5sR8n9gqq9xTa7lI6KpWGbJ96Dw/npYmLt0Kxg8DCPCFXfQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069166; c=relaxed/simple;
	bh=7BzDO5vHL5DN5HBAl+odWGDXNjBgB+USvYPToRZISgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HpBNnApkcRO1FqwXb3I+2dsrxpPmwDh8hcceccdKtZjPhiiw+sIgZiPs093XWsBWoZltd2w9bMBGh/HkWAUm11XcnNGd3PdbDboMuUjK4eaiZ9cEtKGiEAqFGuqfEaXDok+iw3wIkt5ay0oadflZdNbva3TVgqKspp+Tw6DI6BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SpFGaQjH; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E695BE0009;
	Tue,  7 May 2024 08:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715069155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9TepcGEoiKxLCbwlao4rlGSeQ9tpcI5kPyU38Gz2cI=;
	b=SpFGaQjHqBa1/EmaMM0V0Yv5VoQyM6W/gWWjS2btE9ZQTQxVehDqriIXAkPgnynxrxhRD+
	pV6OL/wqyJEdkYBN1GZVcgceosY9HP7sxbRWHej1+twLn+HQEuDNnEBBQVz5QPaFlUlyjT
	y1mude0egUS4aG38ywFou0RQgSq2Vh716RUZhuHieuAz5TwR0nTlU6VRCYjTqIOyPGZeoR
	aQxchupuRF8QxCgpd/JuICPP/BueU5pQ/QBMXstmsq7zugfzwcxKl+8RB1TtsI5J+DG/LP
	9l/Ar29/NkMYolWtO7s9fa7Aa8QrCxBz+vJb8LUMW+ORYVt7HkTTSza3ZJHJeQ==
Date: Tue, 7 May 2024 10:05:53 +0200
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
Message-ID: <20240507100553.31578d0d@xps-13>
In-Reply-To: <e3ea7238-c80d-dfe9-28bf-df95708872d6@salutedevices.com>
References: <20240416085101.740458-1-avkrasnov@salutedevices.com>
	<20240416085101.740458-2-avkrasnov@salutedevices.com>
	<20240506154858.003bab54@xps-13>
	<d90f9d3d-7823-503f-4cc6-73783a083d0e@salutedevices.com>
	<20240507092726.4ab1afdb@xps-13>
	<e3ea7238-c80d-dfe9-28bf-df95708872d6@salutedevices.com>
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

avkrasnov@salutedevices.com wrote on Tue, 7 May 2024 10:35:51 +0300:

> On 07.05.2024 10:27, Miquel Raynal wrote:
> > Hi Arseniy,
> >=20
> > avkrasnov@salutedevices.com wrote on Tue, 7 May 2024 09:53:06 +0300:
> >  =20
> >> On 06.05.2024 16:48, Miquel Raynal wrote: =20
> >>> Hi Arseniy,
> >>>
> >>> avkrasnov@salutedevices.com wrote on Tue, 16 Apr 2024 11:51:00 +0300:
> >>>    =20
> >>>> Boot ROM code on Meson requires that some pages on NAND must be writ=
ten
> >>>> in special mode: "short" ECC mode where each block is 384 bytes and
> >>>> scrambling mode is on.   =20
> >>>
> >>> Ok
> >>>    =20
> >>>> Such pages located with the specified interval within specified offs=
et.   =20
> >>>
> >>> I'm sorry I don't get that sentence.   =20
> >>
> >> Sorry, I mean this (let me draw :) ) :
> >>
> >> [ page 0 ][ page 1 ][ page 2 ][ page 3 ][ page 4 ][ page 5 ][ page 6 ]=
[ page 7 ][ page 8 ][ page 9 ]
> >>
> >> For example, we have 10 pages starting from the beginning of the chip =
- this is "within specified offset",
> >> e.g. offset is 10. BootROM on axg needs that (for example) every third=
 page must be written in "special"
> >> mode: scrambling is on and ECC is 384 bytes. Such pages are 0, 2, 4, 6=
, 8. E.g. "specified interval" will
> >> be 3. =20
> >=20
> > Shall be 2, no? =20
>=20
> yes, starting from 0 - then 2. e.g.
> if (!(page_num % 2))
>     boot ROM need this page
>=20
> >  =20
> >>
> >> So:
> >>
> >> amlogic,boot-pages: 10
> >> amlogic,boot-page-step: 3 =20
> >=20
> > Ok I get it. Thanks for the explanation. I don't really understand the
> > logic behind it though. Do you know why the bootROM would access only
> > one page over 2 or 3? Is there a default value? Is this configurable? =
=20
>=20
> No, boot rom source is closed, I don't have access to it. I get this logic
> from old version of vendor's uboot - in practice they use non 2 or 3, they
> use hardcoded 128 step value. And amlogic,boot-pages is 1024

Feels like they are trying to use only the first page of each block, no?

That's very weird but I understand better.

Thanks,
Miqu=C3=A8l


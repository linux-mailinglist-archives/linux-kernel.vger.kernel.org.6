Return-Path: <linux-kernel+bounces-233526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE691B8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282C91C2093A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 07:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06C3143C65;
	Fri, 28 Jun 2024 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JL+7kUq1"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62EC14388B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719560718; cv=none; b=XenVsrhJB/nEHlvGi00s7vAY1UkwUQ2CAf5j/b3kfOjteUykTQ1a3CV5m7fwAdkdbhXj9huRPQt1Etb1og7Vt9ZPgt7Q4CZbguP57gr9bbvLs5HLa08LFZid9cft2bh1NFofEy/iFyvCWJyYlSwR/FeWQsWTmATZhf3aMdTPmSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719560718; c=relaxed/simple;
	bh=yK668WcTZLOJw4BVcInFsi2DRk/KSYDVqA7Fig00L98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiweWzKANV5HepLqgI1YZSXO21uOx9+R8anUxiVDnrEJkWZThqxPuFO+p2ZcA/lyJFL2plUEeuJ8gvHRcsa3OfYq4Pesr6SNTvBxhusXcH1yTSosdYvSTr4Erj4vUVO8oFGwv9tdJDu90KqsNlHK12l3PkN5M/wmU43NuutvrKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JL+7kUq1; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CAD4FF806;
	Fri, 28 Jun 2024 07:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719560713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnuubegvOe+sUBWqClTh59X4+t4oNOFvsmld2Nx+GdI=;
	b=JL+7kUq13ClciI3OamkaMysFgmgNGEERBYxpXrO2adYuf/gUI3RIrOFzYRPtZwceRkde3m
	JHmKlgnnbe2cIq7Wcr/Q7mIGRpCvTOh87V74s+zQGTgHnEkqjU76kVAEsydKOV7mZ2mOgh
	TQJ4lMMJOZJKfOR1aRzqHSY1FfdN2OWuwaMCu2NV5xLO2xlAhpbgn+JqmHpt38v3F69kvW
	p5AyenYDHk7oEEiwkzeksDztOHaEZ6mq6ZT5L7fSQS7YVR9uJNvs18PFcupXBPauDjWhIo
	/3c8fw/OhM6b0Z4SXnpXhYR4q4WBb7LbkZW5AD08BKwG3xE4Elvz2yPmoribMg==
Date: Fri, 28 Jun 2024 09:45:11 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Stefan Agner
 <stefan@agner.ch>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arch: m68k: Add definitions for flash NFC
 support
Message-ID: <20240628094511.75cc9c78@xps-13>
In-Reply-To: <20240627-upstream-nfc-mcf5441x-v2-1-312929d09ee5@yoseli.org>
References: <20240627-upstream-nfc-mcf5441x-v2-0-312929d09ee5@yoseli.org>
	<20240627-upstream-nfc-mcf5441x-v2-1-312929d09ee5@yoseli.org>
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

Hi Jean-Michel & Geert,

jeanmichel.hautbois@yoseli.org wrote on Thu, 27 Jun 2024 18:05:28 +0200:

> Add a few definitions, as the base address for the NFC for the M5441x.
>=20
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  arch/m68k/include/asm/m5441xsim.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/m68k/include/asm/m5441xsim.h b/arch/m68k/include/asm/m5=
441xsim.h
> index f48cf63bd782..d4ee1eab7c4a 100644
> --- a/arch/m68k/include/asm/m5441xsim.h
> +++ b/arch/m68k/include/asm/m5441xsim.h
> @@ -99,6 +99,7 @@
>  #define MCFINT2_PIT1		14
>  #define MCFINT2_PIT2		15
>  #define MCFINT2_PIT3		16
> +#define MCFINT2_NFC		25
>  #define MCFINT2_RTC		26
> =20
>  /*
> @@ -333,4 +334,10 @@
>  #define MCF_IRQ_BOFF1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_BOFF)
>  #define MCF_IRQ_ERR1		(MCFINT1_VECBASE + MCFINT1_FLEXCAN1_ERR)
> =20
> +/*
> + * Flash module
> + */
> +#define MCF_NFC_BASE		0xfc0fc000
> +#define MCF_NFC_SIZE		(0xfc0fff3b - 0xfc0fc000)
> +#define MCF_NFC_ISR		(MCFINT2_VECBASE + MCFINT2_NFC)

I'm sorry but this feels really backwards. Platform data as C
structures are already legacy, but defining these information in
some arch headers and using them directly from drivers really seems
even "wronger" to me. What's the mid/long term plan for this? If the
platforms are still in use today and need to be maintained, why not
finally enabling device tree support? I know it's harder to do than to
say, but I'd like some really good explanation on why we should accept
to do this in 2024 because it feels rather inadequate.

Thanks,
Miqu=C3=A8l

